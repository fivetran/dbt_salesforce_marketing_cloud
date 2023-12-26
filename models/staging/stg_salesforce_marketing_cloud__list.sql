{{ config(enabled=var('salesforce_marketing_cloud__list_enabled', true)) }}

with base as (

    {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__list_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__list_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__list_base')),
                staging_columns=get_list_columns()
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
        _fivetran_start,
        _fivetran_end,
        _fivetran_active,
        _fivetran_synced,
        created_date,
        description,
        id as list_id,
        modified_date,
        name as list_name,
        type
    from fields
)

select *
from final
