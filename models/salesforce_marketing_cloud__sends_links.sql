{{ config(enabled=var('salesforce_marketing_cloud__link_enabled', true)) }}

-- sends joined with links. Similar to the subscriber_lists, I wanted to include this for users but not sure the best placement.
with sends as (
  select *
  from ref('stg_salesforce_marketing_cloud__send')
  where not _fivetran_deleted

), link_sends as (
  select
    link_id,
    send_id
  from ref('stg_salesforce_marketing_cloud__link_send')

), links as (
  select *
  from ref('stg_salesforce_marketing_cloud__link')

), joined as (
  select 
    sends.*,
    links.*
  from sends
  left join link_sends
    on link_sends.send_id = sends.id
  left join links
    on links.link_id = link_sends.link_id
)

select *
from joined