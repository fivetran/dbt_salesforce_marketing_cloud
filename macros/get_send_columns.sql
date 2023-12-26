{% macro get_send_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "bcc_email", "datatype": dbt.type_string()},
    {"name": "created_date", "datatype": dbt.type_timestamp()},
    {"name": "duplicates", "datatype": dbt.type_int()},
    {"name": "email_id", "datatype": dbt.type_int()},
    {"name": "email_name", "datatype": dbt.type_string()},
    {"name": "existing_undeliverables", "datatype": dbt.type_int()},
    {"name": "existing_unsubscribes", "datatype": dbt.type_int()},
    {"name": "forwarded_emails", "datatype": dbt.type_int()},
    {"name": "from_address", "datatype": dbt.type_string()},
    {"name": "from_name", "datatype": dbt.type_string()},
    {"name": "hard_bounces", "datatype": dbt.type_int()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "invalid_addresses", "datatype": dbt.type_int()},
    {"name": "is_always_on", "datatype": dbt.type_boolean()},
    {"name": "is_multipart", "datatype": dbt.type_boolean()},
    {"name": "missing_addresses", "datatype": dbt.type_int()},
    {"name": "modified_date", "datatype": dbt.type_timestamp()},
    {"name": "number_delivered", "datatype": dbt.type_int()},
    {"name": "number_errored", "datatype": dbt.type_int()},
    {"name": "number_excluded", "datatype": dbt.type_int()},
    {"name": "number_sent", "datatype": dbt.type_int()},
    {"name": "number_targeted", "datatype": dbt.type_int()},
    {"name": "other_bounces", "datatype": dbt.type_int()},
    {"name": "preview_url", "datatype": dbt.type_string()},
    {"name": "send_date", "datatype": dbt.type_timestamp()},
    {"name": "soft_bounces", "datatype": dbt.type_int()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "subject", "datatype": dbt.type_string()},
    {"name": "unique_clicks", "datatype": dbt.type_int()},
    {"name": "unique_opens", "datatype": dbt.type_int()},
    {"name": "unsubscribes", "datatype": dbt.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
