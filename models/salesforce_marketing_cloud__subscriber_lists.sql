{{ config(enabled=var('salesforce_marketing_cloud__list_enabled', true)) }}

-- subscribers joined with lists.
with subscribers as ( 
  select *
  from {{ ref('salesforce_marketing_cloud__subscribers_enhanced') }}

), lists_subscribers as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__list_subscriber') }}

), lists as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__list') }}

), joined as (
  select
    subscribers.source_relation,
    subscribers.subscriber_id, 
    subscribers.email_address, 
    subscribers.email_type_preference, 
    subscribers.subscriber_key, 
    subscribers.subscriber_status, 
    subscribers.created_date, 
    subscribers.unsubscribed_date,
    lists_subscribers.list_id, 
    lists.list_description, 
    lists.list_name, 
    lists.list_type, 
    lists.created_date as list_created_date, 
    lists.modified_date as list_modified_date
  from subscribers
  left join lists_subscribers
    on lists_subscribers.subscriber_key = subscribers.subscriber_key
    and lists_subscribers.source_relation = subscribers.source_relation
  left join lists
    on lists.list_id = lists_subscribers.list_id
    and lists.source_relation = lists_subscribers.source_relation
)

select *
from joined
