{{ config(enabled=var('salesforce_marketing_cloud__link_enabled', true)) }}

with base as (

    {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__link_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__link_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__link_base')),
                staging_columns=get_link_columns()
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
        id as link_id,
        alias as link_alias,
        last_clicked as link_last_clicked,
        created_date,
        modified_date,
        total_clicks as link_total_clicks,
        unique_clicks as link_unique_clicks,
        url as link_url,
        _fivetran_synced,
        _fivetran_deleted
    from fields
)

select *
from final
