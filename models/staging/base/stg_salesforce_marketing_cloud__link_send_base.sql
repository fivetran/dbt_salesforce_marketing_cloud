{{ config(enabled=var('salesforce_marketing_cloud__link_enabled', true)) }}

{% if var('salesforce_marketing_cloud_union_schemas', []) | length > 0 or var('salesforce_marketing_cloud_union_databases', []) | length > 0 %}

{{
    fivetran_utils.union_data(
        table_identifier='link_send',
        database_variable='salesforce_marketing_cloud_database',
        schema_variable='salesforce_marketing_cloud_schema',
        default_database=target.database,
        default_schema='salesforce_marketing_cloud',
        default_variable='link_send',
        union_schema_variable='salesforce_marketing_cloud_union_schemas',
        union_database_variable='salesforce_marketing_cloud_union_databases'
    )
}}

{% else %}

{{
    fivetran_utils.union_connections(
        connection_dictionary='salesforce_marketing_cloud_sources',
        single_source_name='salesforce_marketing_cloud',
        single_table_name='link_send'
    )
}}

{% endif %}
