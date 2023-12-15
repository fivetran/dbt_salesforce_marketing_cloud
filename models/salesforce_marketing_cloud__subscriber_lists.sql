-- this is meant to be stand alone since subscribers could belong to multiple lists, and I did not want to do a list agg to include this in the subscriber overview, but open for discussion
with subscribers as ( 
  select 
    *,
    lower(status) = 'active' as is_active
  from ref('stg_salesforce_marketing_cloud__subscriber')
  where not _fivetran_deleted

), lists_subscribers as (
  select
    subscriber_key,
    list_id
  from ref('stg_salesforce_marketing_cloud__list_subscriber')
  where _fivetran_active

), lists as ( --make lists optional
  select
    id as list_id,
    description as list_description,
    name as list_name,
    type as list_type
  from pc_fivetran_db.salesforce_marketing_cloud.list
  where _fivetran_active

), joined as (
  select
    subscribers.*,
    lists.* --customer data is 1:1, but docs indicate a subsciber could belong to multiple lists
  from subscribers
  left join lists_subscribers
    on lists_subscribers.subscriber_key = subscribers.subscriber_key
  left join lists
    on lists.list_id = lists_subscribers.list_id
)

select *
from joined
