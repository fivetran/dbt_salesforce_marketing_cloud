{{ config(enabled=var('salesforce_marketing_cloud__list_enabled', true)) }}

with base as (

    select
        {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__list_subscriber_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__list_subscriber_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__list_subscriber_base')),
                staging_columns=get_list_subscriber_columns()
            )
        }}
        {{ fivetran_utils.apply_source_relation(package_name='salesforce_marketing_cloud') }}
    from base
),

final as (
    
    select 
        source_relation,
        created_date,
        cast(id as {{ dbt.type_string() }}) as list_subscriber_id,
        cast(list_id as {{ dbt.type_string() }}) as list_id,
        modified_date,
        status,
        subscriber_key
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final