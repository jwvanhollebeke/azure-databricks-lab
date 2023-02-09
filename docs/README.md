# README

## Do we really need ETL?

Yes, business users don't want to work with the messy and complex raw data. Data science success
relies on solid data engineering to furnish reliable data.

## Why not use traditional ETL tools?

Challenges with traditional ETL:

- Exponential data growth.
- Semi-structured and unstructured data need to be transformed.
- Increasing need to process streaming data.

Traditional tools can only scale so large. And they have difficulty keeping up with transforming
business needs. Enter **Apache Spark**.

## Why Databricks

Databricks is a managed and optimized platform for running Apache Spark. It provides a bunch of
tools out of the box. It provides an integrated workspace for collaboration. You can configure the
infrastructure easily, and it manages scalability, failure recovery, patching, upgrades etc.

- https://www.databricks.com/blog/2021/11/02/databricks-sets-official-data-warehousing-performance-record.html

## Terms

- Worker Node: Does work
- Driver Node: Coordinates worker nodes

- Interactive cluster: humans collaborate on data analysis
- Job cluster: Automated jobs

- Workspace: Organize assets in folders (notebooks, libraries, dashboards, ML experiments)
- Version control options available for workspaces

- Notebooks: You write your code here

- Table: Collection of structured data (equivalent to a DataFrame). It's really just a
  representation of the underlying file where you know the schema.

## What is **Azure** Databricks

It is a managed first-party service on Azure. It's fully backed by Microsoft. It natively integrates
with Azure Active Directory and provides RBAC. You get unified billing with Azure subscription.

## Components that are not open source

| Component                      | Description                                |
| ------------------------------ | ------------------------------------------ |
| Databricks Workspace           | Interactive data science and collaboration |
| Databricks Workflows           | Workflow automation and production jobs    |
| Databricks Runtime             |
| Databricks I/O                 | Optimized data access layer                |
| Databricks Serverless          | Fully managed auto-tuning platform         |
| Databricks Enterprise Security | e2e security and compliance                |
