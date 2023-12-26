{% macro get_link_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "alias", "datatype": dbt.type_string()},
    {"name": "last_clicked", "datatype": dbt.type_timestamp()},
    {"name": "created_date", "datatype": dbt.type_timestamp()},
    {"name": "modified_date", "datatype": dbt.type_timestamp()},
    {"name": "total_clicks", "datatype": dbt.type_int()},
    {"name": "unique_clicks", "datatype": dbt.type_int()},
    {"name": "url ", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
