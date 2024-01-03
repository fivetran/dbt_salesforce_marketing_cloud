-- this is meant to be stand alone since subscribers could belong to multiple lists, and I did not want to do a list agg to include this in the subscriber overview, but open for discussion 
with subscribers as ( 
  select 
    *,
    lower(subscriber_status) = 'active' as is_active
  from {{ ref('stg_salesforce_marketing_cloud__subscriber') }}
  where not _fivetran_deleted
)

select *
from subscribers
