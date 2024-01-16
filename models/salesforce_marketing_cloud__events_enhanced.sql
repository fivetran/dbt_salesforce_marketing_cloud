{{
  config(
    materialized='incremental',
    unique_key='event_id',
    partition_by={
      'field': 'event_date', 
      'data_type': 'date',
      'granularity': 'day'
      } if target.type not in ('spark','databricks') else ['event_date'],
    cluster_by=['event_date'],
    incremental_strategy='insert_overwrite' if target.type in ('bigquery', 'spark', 'databricks') else 'delete+insert',
    file_format='parquet'
    )
}}

-- events grain with sends and email information added.
with events as( 
  select
    *
  from {{ ref('stg_salesforce_marketing_cloud__event') }}

  {% if is_incremental() %}
    {% if target.type == 'bigquery' %}
      cast(event_date as date) >= cast(_dbt_max_partition as date)
    {% else %}
      where event_date > (select max(event_date) from {{ this }})
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