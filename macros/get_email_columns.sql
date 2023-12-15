{% macro get_email_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "asset_id", "datatype": dbt.type_int()},
    {"name": "asset_type_id", "datatype": dbt.type_int()},
    {"name": "character_set", "datatype": dbt.type_string()},
    {"name": "created_date", "datatype": "datetime"},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "modified_date", "datatype": "datetime"},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "pre_header", "datatype": dbt.type_string()},
    {"name": "subject", "datatype": dbt.type_string()},
    {"name": "text_body", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
