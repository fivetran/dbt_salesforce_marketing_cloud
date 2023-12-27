{{ config(enabled=var('salesforce_marketing_cloud__list_enabled', true)) }}

-- this is meant to be stand alone since subscribers could belong to multiple lists, and I did not want to do a list agg to include this in the subscriber overview, but open for discussion
with subscribers as ( 
  select *
  from {{ ref('salesforce_marketing_cloud__subscribers_enhanced') }}

), lists_subscribers as (
  select *
  from {{ ref('stg_salesforce_marketing_cloud__list_subscriber') }}
  where _fivetran_active

), lists as ( --make lists optional
  select *
  from {{ ref('stg_salesforce_marketing_cloud__list') }}
  where _fivetran_active

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
    lists.list_id, 
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
