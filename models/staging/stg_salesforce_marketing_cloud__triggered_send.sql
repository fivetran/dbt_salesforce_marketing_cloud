with base as (

    select
        {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__triggered_send_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__triggered_send_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__triggered_send_base')),
                staging_columns=get_triggered_send_columns()
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
        id as triggered_send_id,
        email_id,
        list_id,
        auto_add_subscribers,
        auto_update_subscribers,
        bcc_email,
        created_date,
        modified_date,
        description as triggered_send_description,
        dynamic_email_subject,
        email_subject,
        from_address,
        from_name,
        is_multipart,
        is_wrapped,
        name as triggered_send_name,
        priority,
        send_limit,
        send_window_close,
        send_window_open,
        triggered_send_status
    from fields
    where not coalesce(_fivetran_deleted, false)
)

select *
from final
