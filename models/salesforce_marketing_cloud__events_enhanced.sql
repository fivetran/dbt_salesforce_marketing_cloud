{{ config(
    materialized='incremental' if is_incremental_compatible(target) else 'table',
    unique_key=['source_relation', 'event_id', 'event_type'],
    incremental_strategy='insert_overwrite' if target.type in ('bigquery','spark','databricks') else 'delete+insert',
    partition_by={'field': 'event_date', 'data_type': 'date'} if target.type not in ('spark', 'databricks', 'duckdb') else ['event_date'],
    cluster_by = ['event_date'],
    file_format='delta'
) }}

-- events grain with sends and email information added.
with events as(
  select
    stg_events.*
  from {{ ref('stg_salesforce_marketing_cloud__event') }} as stg_events

  {% if is_incremental() %}
    {% if target.type == 'bigquery' %}
      where date(stg_events.event_date) >= date(_dbt_max_partition)
    {% else %}
      -- Reprocess each connection from its own latest event_date. Using >= picks up late-arriving events on that date,
      -- and the delete+insert unique_key replaces the overlapping rows without creating duplicates.
      left join (
        select
          source_relation,
          max(event_date) as max_event_date
        from {{ this }}
        group by source_relation
      ) as max_event_dates
        on stg_events.source_relation = max_event_dates.source_relation
      where max_event_dates.max_event_date is null
        or stg_events.event_date >= max_event_dates.max_event_date
    {% endif %}
  {% endif %}

), events_enhanced as (
  select
    source_relation,
    batch_id,
    bounce_category,
    bounce_type,
    created_date,
    event_date,
    event_type,
    event_id,
    modified_date,
    opt_in_subscriber_key,
    question,
    send_id,
    smtp_code,
    smtp_reason,
    subscriber_key,
    triggered_send_id,
    unsubscribed_list_id,
    event_url,
    -- the below definitions are found here: https://developer.salesforce.com/docs/marketing/marketing-cloud/guide/eventtype.html
    lower(event_type) = 'click' as is_click,
    lower(event_type) = 'deliveredevent' as is_delivered_event,
    lower(event_type) = 'forwardedemail' as is_forward,
    lower(event_type) = 'forwardedemailoptin' as is_opt_in,
    lower(event_type) in ('hardbounce', 'otherbounce', 'softbounce') as is_bounce,
    lower(event_type) = 'open' as is_open,
    lower(event_type) = 'notsent' as is_not_sent, 
    lower(event_type) = 'sent' as is_sent,
    lower(event_type) = 'survey' as is_survey_response,
    lower(event_type) = 'unsubscribe' as is_unsubscribe
  from events

), sends as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__send') }}

), emails as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__email') }}

), joined as (
  select
    events_enhanced.*,
    sends.created_date as send_created_date,
    sends.bcc_email,
    sends.from_address,
    sends.from_name,
    sends.preview_url,
    sends.subject as sends_subject,
    sends.email_id,
    emails.email_name,
    emails.subject as email_subject,
    emails.created_date as email_created_date
  from events_enhanced
  left join sends
    on sends.send_id = events_enhanced.send_id
    and sends.source_relation = events_enhanced.source_relation
  left join emails
    on emails.email_id = sends.email_id
    and emails.source_relation = sends.source_relation
)

select *
from joined