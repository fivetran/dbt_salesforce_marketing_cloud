{% macro get_triggered_send_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "auto_add_subscribers", "datatype": dbt.type_boolean()},
    {"name": "auto_update_subscribers", "datatype": dbt.type_boolean()},
    {"name": "bcc_email", "datatype": dbt.type_string()},
    {"name": "created_date", "datatype": dbt.type_timestamp()},
    {"name": "description", "datatype": dbt.type_string()},
    {"name": "dynamic_email_subject", "datatype": dbt.type_string()},
    {"name": "email_id", "datatype": dbt.type_int()},
    {"name": "email_subject", "datatype": dbt.type_string()},
    {"name": "from_address", "datatype": dbt.type_string()},
    {"name": "from_name", "datatype": dbt.type_string()},
    {"name": "is_multipart", "datatype": dbt.type_boolean()},
    {"name": "is_wrapped", "datatype": dbt.type_boolean()},
    {"name": "list_id", "datatype": dbt.type_int()},
    {"name": "modified_date", "datatype": dbt.type_timestamp()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "priority", "datatype": dbt.type_string()},
    {"name": "send_limit", "datatype": dbt.type_string()},
    {"name": "send_window_close", "datatype": dbt.type_string()},
    {"name": "send_window_open", "datatype": dbt.type_string()},
    {"name": "triggered_send_status", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
