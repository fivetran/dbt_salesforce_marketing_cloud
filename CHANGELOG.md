# dbt_salesforce_marketing_cloud v0.2.0

[PR #4](https://github.com/fivetran/dbt_salesforce_marketing_cloud/pull/4) includes the following updates. Please be aware these changes only impact Databricks warehouse users:

## 🚨 Breaking Changes 🚨
> ⚠️ Since the following changes result in the table format changing for Databricks users, we recommend running a `--full-refresh` after upgrading to this version to avoid possible incremental failures.
- For Databricks All-Purpose clusters, the `salesforce_marketing_cloud__events_enhanced` model will now be materialized using the delta table format (previously parquet). 
  - Delta tables are generally more performant than parquet and are also more widely available for Databricks users. Previously, the parquet file format was causing compilation issues on customers' managed tables.

## Documentation
- Added details to the README to highlight the incremental strategies used within the `salesforce_marketing_cloud__events_enhanced` model.

## Under the Hood
- The `is_incremental_compatible` macro has been added to the package. This macro will return `true` if the Databricks runtime being used is an all-purpose cluster **or** if any other non-Databricks supported destination is being used.
  - This update was applied as there are other Databricks runtimes (ie. sql warehouse, endpoint, and external runtime) which do not support the `insert_overwrite` incremental strategy used in the `salesforce_marketing_cloud__events_enhanced` model. 
- In addition to the above, for Databricks users the `salesforce_marketing_cloud__events_enhanced` model will now leverage the incremental strategy only if the Databricks runtime is all-purpose. Otherwise, all other Databricks runtimes will not leverage an incremental strategy.
- Added validation tests to the `integration_tests/` folder to ensure the consistency and integrity of the `salesforce_marketing_cloud__events_enhanced` model for subsequent updates.

# dbt_salesforce_marketing_cloud v0.1.0
🎉 This is the initial release of this package! 🎉

# 📣 What does this dbt package do?

This package models Salesforce Marketing Cloud data from [Fivetran's connector](https://fivetran.com/docs/applications/salesforce_marketing_cloud). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/salesforce_marketing_cloud#schemainformation).

The main focus of the package is to transform the core object tables into analytics-ready models:
  - Materializes [Salesforce Marketing Cloud staging tables](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/overview/salesforce_marketing_cloud/models/?g_v=1) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/salesforce_marketing_cloud/#schemainformation). The staging tables clean, test, and prepare your Salesforce Marketing Cloud data from [Fivetran's connector](https://fivetran.com/docs/applications/salesforce_marketing_cloud) for analysis by doing the following:
  - Primary keys are renamed from `id` to `<table name>_id`. 
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
  - Provides insight into your Salesforce Marketing Cloud data across the following grains:
    - Email, send, event, link, list, and subscriber
  - Generates a comprehensive data dictionary of your Salesforce Marketing Cloud data through the [dbt docs site](https://fivetran.github.io/dbt_salesforce_marketing_cloud/).