with base as (

    select
        {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__subscriber_base')) }}
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
        cast(created_date as {{ dbt.type_timestamp() }}) as created_date,
        email_address,
        email_type_preference,
        cast(id as {{ dbt.type_string() }}) as subscriber_id,
        status as subscriber_status,
        subscriber_key,
        cast(unsubscribed_date as {{ dbt.type_timestamp() }}) as unsubscribed_date
    from fields
    where not coalesce(_fivetran_deleted, false)
)

select *
from final
