{% macro get_link_send_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "link_id", "datatype": dbt.type_int()},
    {"name": "send_id", "datatype": dbt.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
