{{ 
    config(
        materialized='incremental',
        unique_key='event_id',
        partition_by={'field': 'event_date', 'data_type': 'date'} if target.type not in ('spark','databricks') else ['event_date'],
        cluster_by=['event_date'],
        incremental_strategy = 'merge' if target.type not in ('postgres', 'redshift') else 'delete+insert', 
        file_format = 'delta' 
    )
}}

-- events grain with sends and email information added.
with events as( 
  select
    *,
    -- the below list comes from: https://developer.salesforce.com/docs/marketing/marketing-cloud/guide/eventtype.html
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
  from {{ ref('stg_salesforce_marketing_cloud__event') }}
  where not _fivetran_deleted

  {% if is_incremental() %}
  and event_date >= coalesce((select max(event_date) from {{ this }}), '1900-01-01')
  {% endif %}

), sends as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__send') }}

), emails as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__email') }}

), joined as (
  select
    events.*,
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
  from events
  left join sends
    on sends.send_id = events.send_id
    and sends.source_relation = events.source_relation
  left join emails
    on emails.email_id = sends.email_id
    and emails.source_relation = sends.source_relation
)

select *
from joined