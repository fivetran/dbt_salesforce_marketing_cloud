{{ config(enabled=var('salesforce_marketing_cloud__list_enabled', true)) }}

{{
    fivetran_utils.union_data(
        table_identifier='list_subscriber', 
        database_variable='salesforce_marketing_cloud_database', 
        schema_variable='salesforce_marketing_cloud_schema', 
        default_database=target.database,
        default_schema='salesforce_marketing_cloud',
        default_variable='list_subscriber',
        union_schema_variable='salesforce_marketing_cloud_union_schemas',
        union_database_variable='salesforce_marketing_cloud_union_databases'
    )
}}
