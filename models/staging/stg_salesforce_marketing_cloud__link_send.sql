{{ config(enabled=var('salesforce_marketing_cloud__link_enabled', true)) }}

with base as (

    select
        {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__link_send_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__link_send_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__link_send_base')),
                staging_columns=get_link_send_columns()
            )
        }}
        {{ fivetran_utils.apply_source_relation(package_name='salesforce_marketing_cloud') }}
    from base
),

final as (
    
    select 
        source_relation,
        cast(link_id as {{ dbt.type_string() }}) as link_id,
        cast(send_id as {{ dbt.type_string() }}) as send_id
    from fields
    where not coalesce(_fivetran_deleted, false)
)

select *
from final