
with base as (

    {{ dbt_utils.star(ref('stg_salesforce_marketing_cloud__send_base')) }}
    from {{ ref('stg_salesforce_marketing_cloud__send_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_salesforce_marketing_cloud__send_base')),
                staging_columns=get_send_columns()
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
        bcc_email,
        created_date,
        duplicates,
        email_id,
        email_name,
        existing_undeliverables,
        existing_unsubscribes,
        forwarded_emails,
        from_address,
        from_name,
        hard_bounces,
        id as send_id,
        invalid_addresses,
        is_always_on,
        is_multipart,
        missing_addresses,
        modified_date,
        number_delivered,
        number_errored,
        number_excluded,
        number_sent,
        number_targeted,
        other_bounces,
        preview_url,
        send_date,
        soft_bounces,
        status,
        subject,
        unique_clicks,
        unique_opens,
        unsubscribes
    from fields
)

select *
from final
