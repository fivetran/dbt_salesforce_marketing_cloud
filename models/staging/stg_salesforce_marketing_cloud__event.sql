
with base as (

    select 
        {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__event_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__event_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__event_base')),
                staging_columns=get_event_columns()
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
        batch_id,
        bounce_category,
        bounce_type,
        created_date,
        cast(event_date as date) as event_date,
        event_type,
        cast(id as {{ dbt.type_string() }}) as event_id,
        modified_date,
        opt_in_subscriber_key,
        question,
        cast(send_id as {{ dbt.type_string() }}) as send_id,
        smtp_code,
        smtp_reason,
        subscriber_key,
        triggered_send_id,
        unsubscribed_list_id,
        url as event_url
    from fields
)

select *
from final
