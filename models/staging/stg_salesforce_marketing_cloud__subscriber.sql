
with base as (

    {{ dbt.star(ref('stg_salesforce_marketing_cloud__subscriber_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__subscriber_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__subscriber_base')),
                staging_columns=get_subscriber_columns()
            )
        }}
        {{ fivetran_utils.source_relation(
            union_schema_variable='salesforce_marketing_cloud_union_schemas', 
            union_database_variable='salesforce_marketing_cloud_union_databases') 
        }}
    from base
),

final as (
    
    select 
        source_relation, 
        _fivetran_deleted,
        _fivetran_synced,
        created_date,
        email_address,
        email_type_preference,
        id as subscriber_id,
        status as subscriber_status,
        subscriber_key,
        unsubscribed_date
    from fields
)

select *
from final
