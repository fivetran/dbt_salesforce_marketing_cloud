{% macro get_event_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "batch_id", "datatype": dbt.type_int()},
    {"name": "bounce_category", "datatype": dbt.type_string()},
    {"name": "bounce_type", "datatype": dbt.type_string()},
    {"name": "created_date", "datatype": "datetime"},
    {"name": "event_date", "datatype": "datetime"},
    {"name": "event_type", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "modified_date", "datatype": "datetime"},
    {"name": "opt_in_subscriber_key", "datatype": dbt.type_string()},
    {"name": "question", "datatype": dbt.type_string()},
    {"name": "send_id", "datatype": dbt.type_int()},
    {"name": "smtp_code", "datatype": dbt.type_int()},
    {"name": "smtp_reason", "datatype": dbt.type_string()},
    {"name": "subscriber_key", "datatype": dbt.type_string()},
    {"name": "triggered_send_id", "datatype": dbt.type_string()},
    {"name": "unsubscribed_list_id", "datatype": dbt.type_int()},
    {"name": "url", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
