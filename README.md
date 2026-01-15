<!--section="salesforce-marketing-cloud_transformation_model"-->
# Salesforce Marketing Cloud dbt Package

<p align="left">
    <a alt="License"
        href="https://github.com/fivetran/dbt_salesforce_marketing_cloud/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0,_<3.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
    <a alt="Fivetran Quickstart Compatible"
        href="https://fivetran.com/docs/transformations/data-models/quickstart-management#quickstartmanagement">
        <img src="https://img.shields.io/badge/Fivetran_Quickstart_Compatible%3F-yes-green.svg" /></a>
</p>

This dbt package transforms data from Fivetran's Salesforce Marketing Cloud connector into analytics-ready tables.

## Resources

- Number of materialized models¹: 24
- Connector documentation
  - [Salesforce Marketing Cloud connector documentation](https://fivetran.com/docs/connectors/applications/salesforce-marketing-cloud)
  - [Salesforce Marketing Cloud ERD](https://fivetran.com/docs/connectors/applications/salesforce-marketing-cloud#schemainformation)
- dbt package documentation
  - [GitHub repository](https://github.com/fivetran/dbt_salesforce_marketing_cloud)
  - [dbt Docs](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/overview)
  - [DAG](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/overview?g_v=1)
  - [Changelog](https://github.com/fivetran/dbt_salesforce_marketing_cloud/blob/main/CHANGELOG.md)

## What does this dbt package do?
This package enables you to transform core object tables into analytics-ready models and generate comprehensive data dictionaries. It creates enriched models with metrics focused on email, send, event, link, list, and subscriber data.

### Output schema
Final output tables are generated in the following target schema:

```
<your_database>.<connector/schema_name>_salesforce_marketing_cloud
```

### Final output tables

By default, this package materializes the following final tables:

| Table | Description |
| :---- | :---- |
| [salesforce_marketing_cloud__email_overview](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/model/model.salesforce_marketing_cloud.salesforce_marketing_cloud__email_overview) | Summarizes email performance with aggregate metrics including total sends, opens, clicks, bounces, and engagement rates to evaluate email effectiveness at the email level. <br></br>**Example Analytics Questions:**<ul><li>Which emails have the highest open rates, click-through rates, and conversion rates?</li><li>How do bounce rates and delivery success vary across different email campaigns?</li><li>What is the average engagement rate by email type or subject line pattern?</li></ul>|
| [salesforce_marketing_cloud__events_enhanced](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/model/model.salesforce_marketing_cloud.salesforce_marketing_cloud__events_enhanced) | Tracks individual email events with event types pivoted into boolean fields and enriched with send and email details to analyze granular user interactions and event patterns. <br></br>**Example Analytics Questions:**<ul><li>What event sequences (opened, clicked, converted) are most common among engaged subscribers?</li><li>How do different event types correlate with send timing or email content?</li><li>Which subscribers trigger the most high-value events across campaigns?</li></ul>|
| [salesforce_marketing_cloud__sends_links](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/model/model.salesforce_marketing_cloud.salesforce_marketing_cloud__sends_links) | Connects email links to their corresponding sends to analyze link click activity, measure call-to-action effectiveness, and understand which URLs drive the most engagement. <br></br>**Example Analytics Questions:**<ul><li>Which links and calls-to-action generate the highest click rates across sends?</li><li>How do link placements (header, body, footer) affect click-through performance?</li><li>What landing page URLs receive the most clicks from email campaigns?</li></ul>|
| [salesforce_marketing_cloud__sends_overview](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/model/model.salesforce_marketing_cloud.salesforce_marketing_cloud__sends_overview) | Provides send-level performance metrics including total opens, clicks, bounces, and engagement rates to measure the effectiveness of individual email sends and identify optimization opportunities. <br></br>**Example Analytics Questions:**<ul><li>Which sends have the highest engagement rates and delivery success?</li><li>How do send performance metrics vary by send time, day of week, or audience segment?</li><li>What is the relationship between send volume and engagement rate?</li></ul>|
| [salesforce_marketing_cloud__subscriber_lists](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/model/model.salesforce_marketing_cloud.salesforce_marketing_cloud__subscriber_lists) | Connects subscriber lists to individual subscribers to manage list memberships, analyze list growth, and understand subscriber distribution across segmentation lists. <br></br>**Example Analytics Questions:**<ul><li>Which lists have the most subscribers and highest engagement rates?</li><li>How is subscriber membership distributed across different lists?</li><li>What is the overlap between lists and do multi-list subscribers show higher engagement?</li></ul>|
| [salesforce_marketing_cloud__subscriber_overview](https://fivetran.github.io/dbt_salesforce_marketing_cloud/#!/model/model.salesforce_marketing_cloud.salesforce_marketing_cloud__subscriber_overview) | Consolidates subscriber-level engagement metrics including total sends received, open rates, click rates, and bounce history to understand individual subscriber behavior and preferences. <br></br>**Example Analytics Questions:**<ul><li>Which subscribers are most engaged based on total opens, clicks, and emails received?</li><li>What percentage of subscribers have never opened an email or have hard bounced?</li><li>How do subscriber engagement levels vary by subscription source or list membership?</li></ul>|

¹ Each Quickstart transformation job run materializes these models if all components of this data model are enabled. This count includes all staging, intermediate, and final models materialized as `view`, `table`, or `incremental`.

---

## Prerequisites
To use this dbt package, you must have the following:

- At least one Fivetran Salesforce Marketing Cloud connection syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **Databricks**, or **PostgreSQL** destination.

#### Database Incremental Strategies
The `salesforce_marketing_cloud__events_enhanced` model in this package is materialized incrementally and is configured to work with the different strategies available to each supported warehouse.

For **BigQuery** and **Databricks All-Purpose Cluster runtime** destinations, we have chosen `insert_overwrite` as the default strategy, which benefits from the partitioning capability.
> For all other Databricks runtimes, models are materialized as tables without support for incremental runs.

For **Snowflake**, **Redshift**, and **Postgres** databases, we have chosen `delete+insert` as the default strategy.

> Regardless of strategy, we recommend that users periodically run a `--full-refresh` to ensure a high level of data quality.

## How do I use the dbt package?
You can either add this dbt package in the Fivetran dashboard or import it into your dbt project:

- To add the package in the Fivetran dashboard, follow our [Quickstart guide](https://fivetran.com/docs/transformations/data-models/quickstart-management).
- To add the package to your dbt project, follow the setup instructions in the dbt package's [README file](https://github.com/fivetran/dbt_salesforce_marketing_cloud/blob/main/README.md#how-do-i-use-the-dbt-package) to use this package.

<!--section-end-->

### Install the package
Include the following Salesforce Marketing Cloud package version in your `packages.yml` file:
> [!TIP]
> Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yml
packages:
  - package: fivetran/salesforce_marketing_cloud
    version: [">=0.5.0", "<0.6.0"] # we recommend using ranges to capture non-breaking changes automatically
```

#### Databricks dispatch configuration
If you are using a Databricks destination with this package, you must add the following (or a variation of the following) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

### Define database and schema variables
#### Single connection
By default, this package runs using your destination and the `salesforce_marketing_cloud` schema. If this is not where your Salesforce Marketing Cloud data is (for example, if your Salesforce Marketing Cloud schema is named `salesforce_marketing_cloud_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    salesforce_marketing_cloud_database: your_database_name
    salesforce_marketing_cloud_schema: your_schema_name
```
#### Union multiple connections
If you have multiple Salesforce Marketing Cloud connections in Fivetran and would like to use this package on all of them simultaneously, we have provided functionality to do so. The package will union all of the data together and pass the unioned table into the transformations. You will be able to see which source it came from in the `source_relation` column of each model. To use this functionality, you will need to set either the `salesforce_marketing_cloud_union_schemas` OR `salesforce_marketing_cloud_union_databases` variables (cannot do both) in your root `dbt_project.yml` file:

```yml
vars:
    salesforce_marketing_cloud_union_schemas: ['sfmc_usa','sfmc_canada'] # use this if the data is in different schemas/datasets of the same database/project
    salesforce_marketing_cloud_union_databases: ['sfmc_usa','sfmc_canada'] # use this if the data is in different databases/projects but uses the same schema name
```

> NOTE: The native `source.yml` connection set up in the package will not function when the union schema/database feature is utilized. Although the data will be correctly combined, you will not observe the sources linked to the package models in the Directed Acyclic Graph (DAG). This happens because the package includes only one defined `source.yml`.

To connect your multiple schema/database sources to the package models, follow the steps outlined in the [Union Data Defined Sources Configuration](https://github.com/fivetran/dbt_fivetran_utils/tree/releases/v0.4.latest#union_data-source) section of the Fivetran Utils documentation for the union_data macro. This will ensure a proper configuration and correct visualization of connections in the DAG.

### Enable/Disable Variables
By default, this package brings in data from the Salesforce Marketing Cloud `link` and `list` source tables. However, if you have disabled syncing these sources, you will need to add the following configuration to your `dbt_project.yml`:

```yml
vars:
    salesforce_marketing_cloud__link_enabled: false # default = true
    salesforce_marketing_cloud__list_enabled: false # default = true
```

### (Optional) Additional configurations

#### Changing the Build Schema
By default this package will build the Salesforce Marketing Cloud staging models within a schema titled (<target_schema> + `_stg_sfmc`) and the Salesforce Marketing Cloud final models within a schema titled (<target_schema> + `_sfmc`) in your target database. If this is not where you would like your modeled Salesforce Marketing Cloud data to be written, add the following configuration to your `dbt_project.yml` file:

```yml
models:
  salesforce_marketing_cloud:
    +schema: my_new_schema_name # leave blank for just the target_schema
    staging:
        +schema: my_new_schema_name # leave blank for just the target_schema
```

#### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:

> [!IMPORTANT]
> See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_salesforce_marketing_cloud/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
vars:
    salesforce_marketing_cloud_<default_source_table_name>_identifier: your_table_name 
```

### (Optional) Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand for details</summary>
<br>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt#transformationsfordbtcore). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core setup guides](https://fivetran.com/docs/transformations/dbt/setup-guide#transformationsfordbtcoresetupguide).
</details>

## Does this package have dependencies?
This dbt package is dependent on the following dbt packages. These dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> [!IMPORTANT]
> If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.

```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]
```
<!--section="salesforce-marketing-cloud_maintenance"-->
## How is this package maintained and can I contribute?

### Package Maintenance
The Fivetran team maintaining this package only maintains the [latest version](https://hub.getdbt.com/fivetran/salesforce_marketing_cloud/latest/) of the package. We highly recommend you stay consistent with the latest version of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_salesforce_marketing_cloud/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

### Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions.

We highly encourage and welcome contributions to this package. Learn how to contribute to a package in dbt's [Contributing to an external dbt package article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657).

<!--section-end-->

## Are there any resources available?
- If you have questions or want to reach out for help, see the [GitHub Issue](https://github.com/fivetran/dbt_salesforce_marketing_cloud/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).