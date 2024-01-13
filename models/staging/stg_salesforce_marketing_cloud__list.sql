{{ config(enabled=var('salesforce_marketing_cloud__list_enabled', true)) }}

with base as (

    select
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
        created_date,
        description as list_description,
        cast(id as {{ dbt.type_string() }}) as list_id,
        modified_date,
        name as list_name,
        type as list_type
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
