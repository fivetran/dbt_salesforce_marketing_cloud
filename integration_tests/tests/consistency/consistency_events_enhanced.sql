{{ config(
    tags="fivetran_validations",
    enabled=var('fivetran_validation_tests_enabled', false)
) }}

with prod as (
    select *
    from {{ target.schema }}_salesforce_marketing_cloud_prod.salesforce_marketing_cloud__events_enhanced
),

dev as (
    select *
    from {{ target.schema }}_salesforce_marketing_cloud_dev.salesforce_marketing_cloud__events_enhanced
),

final as (
    -- test will fail if any rows from prod are not found in dev
    (select * from prod
    except distinct
    select * from dev)

    union all -- union since we only care if rows are produced

    -- test will fail if any rows from dev are not found in prod
    (select * from dev
    except distinct
    select * from prod)
)

select *
from final