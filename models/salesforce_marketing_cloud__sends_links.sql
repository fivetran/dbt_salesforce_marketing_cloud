{{ config(enabled=var('salesforce_marketing_cloud__link_enabled', true)) }}

-- sends joined with links. Similar to the subscriber_lists, I wanted to include this for users but not sure the best placement.
with sends as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__send') }}

), link_sends as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__link_send') }}

), links as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__link') }}

), joined as (
  select 
    sends.source_relation,
    sends.send_id, 
    sends.bcc_email, 
    sends.duplicates, 
    sends.email_name, 
    sends.existing_undeliverables, 
    sends.existing_unsubscribes, 
    sends.forwarded_emails, 
    sends.from_address, 
    sends.from_name, 
    sends.hard_bounces, 
    sends.invalid_addresses, 
    sends.is_always_on, 
    sends.is_multipart, 
    sends.missing_addresses,
    sends.number_delivered,
    sends.number_errored,
    sends.number_excluded,
    sends.number_sent,
    sends.number_targeted,
    sends.other_bounces,
    sends.preview_url,
    sends.soft_bounces,
    sends.send_status,
    sends.subject,
    sends.unique_clicks,
    sends.unique_opens,
    sends.unsubscribes,
    sends.email_id,
    sends.created_date as send_created_date,
    sends.modified_date as send_modified_date,
    sends.send_date,
    link_sends.link_id,
    links.link_alias,
    links.link_total_clicks,
    links.link_unique_clicks,
    links.link_url,
    links.link_last_clicked
  from sends
  left join link_sends
    on link_sends.send_id = sends.send_id
    and link_sends.source_relation = sends.source_relation
  left join links
    on links.link_id = link_sends.link_id
    and links.source_relation = link_sends.source_relation
)

select *
from joined