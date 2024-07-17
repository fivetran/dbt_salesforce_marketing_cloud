{{ config(
    tags="fivetran_validations",
    enabled=var('fivetran_validation_tests_enabled', false)
) }}

with source as (
    select 
        1 as join_key,
        count(*) as total_record_count
    from {{ ref('stg_salesforce_marketing_cloud__event') }}
    group by 1
),

end_model as (
    select 
        1 as join_key,
        count(*) as total_record_count
    from {{ ref('salesforce_marketing_cloud__events_enhanced') }}
    group by 1
),

final as (
    select
        end_model.join_key,
        end_model.total_record_count as end_model_count,
        source.total_record_count as source_count
    from end_model
    full outer join source
        on source.join_key = end_model.join_key
)

select *
from final
where end_model_count != source_count