{% macro get_subscriber_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_date", "datatype": "datetime"},
    {"name": "email_address", "datatype": dbt.type_string()},
    {"name": "email_type_preference", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "subscriber_key", "datatype": dbt.type_string()},
    {"name": "unsubscribed_date", "datatype": "datetime"}
] %}

{{ return(columns) }}

{% endmacro %}
