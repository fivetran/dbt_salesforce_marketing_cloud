with subscribers as ( 
  select 
    *,
    lower(subscriber_status) = 'active' as is_active
  from {{ ref('stg_salesforce_marketing_cloud__subscriber') }}
)

select *
from subscribers
