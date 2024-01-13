with base as (

    select
        {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__email_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__email_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__email_base')),
                staging_columns=get_email_columns()
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
        asset_id,
        asset_type_id,
        character_set,
        created_date,
        cast(id as {{ dbt.type_string() }}) as email_id,
        modified_date,
        name as email_name,
        pre_header,
        subject,
        text_body
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final
