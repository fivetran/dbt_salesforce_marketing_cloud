#!/bin/bash

set -euo pipefail

apt-get update
apt-get install libsasl2-dev

python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip setuptools
pip install -r integration_tests/requirements.txt
mkdir -p ~/.dbt
cp integration_tests/ci/sample.profiles.yml ~/.dbt/profiles.yml

db=$1
echo `pwd`
cd integration_tests
dbt deps
if [ "$db" = "databricks-sql" ]; then
dbt seed --vars '{fivetran_platform_schema: sqlw_tests}' --target "$db" --full-refresh
dbt run --vars '{fivetran_platform_schema: sqlw_tests}' --target "$db" --full-refresh
dbt test --vars '{fivetran_platform_schema: sqlw_tests}' --target "$db"
dbt run --vars '{fivetran_platform_schema: sqlw_tests}' --target "$db"
dbt test --vars '{fivetran_platform_schema: sqlw_tests}' --target "$db"
dbt run --vars '{fivetran_platform_schema: sqlw_tests, salesforce_marketing_cloud__link_enabled: false, salesforce_marketing_cloud__list_enabled: false}' --full-refresh --target "$db"
dbt test --vars '{fivetran_platform_schema: sqlw_tests}' --target "$db"
else
dbt seed --target "$db" --full-refresh
dbt run --target "$db" --full-refresh
dbt test --target "$db"
dbt run --target "$db"
dbt test --target "$db"
dbt run --vars '{salesforce_marketing_cloud__link_enabled: false, salesforce_marketing_cloud__list_enabled: false}' --full-refresh --target "$db"
dbt test --target "$db"
fi
dbt run-operation fivetran_utils.drop_schemas_automation --target "$db"