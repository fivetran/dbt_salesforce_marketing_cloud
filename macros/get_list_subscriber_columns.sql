{% macro get_list_subscriber_columns() %}

{% set columns = [
    {"name": "_fivetran_active", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "_fivetran_start", "datatype": dbt.type_timestamp()},
    {"name": "_fivetran_end", "datatype": dbt.type_timestamp()},
    {"name": "created_date", "datatype": "datetime"},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "list_id", "datatype": dbt.type_int()},
    {"name": "modified_date", "datatype": "datetime"},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "subscriber_key", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
