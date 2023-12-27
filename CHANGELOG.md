# dbt_salesforce_marketing_cloud v0.1.0
🎉 This is the initial release of this package! 🎉

# 📣 What does this dbt package do?

This package models Salesforce Marketing Cloud data from [Fivetran's connector](https://fivetran.com/docs/applications/salesforce_marketing_cloud). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/salesforce_marketing_cloud#schemainformation).

The main focus of the package is to transform the core object tables into analytics-ready models:
<!--section="salesforce_marketing_cloud_model"-->
  - Materializes [Salesforce Marketing Cloud staging tables](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/overview/salesforce_marketing_cloud_source/models/?g_v=1) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/salesforce_marketing_cloud/#schemainformation). The staging tables clean, test, and prepare your Salesforce Marketing Cloud data from [Fivetran's connector](https://fivetran.com/docs/applications/salesforce_marketing_cloud_source) for analysis by doing the following:
  - Primary keys are renamed from `id` to `<table name>_id`. 
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
  - Provides insight into your Salesforce Marketing Cloud data across the following grains:
    - Email, send, event, link, list, and subscriber
  - Generates a comprehensive data dictionary of your Salesforce Marketing Cloud data through the [dbt docs site](https://fivetran.github.io/dbt_salesforce_marketing_cloud/).