# Databricks Platform Architecture

Azure Databricks collaborative workspace:

- User management
- Git repositories
- Workspace folders

## ETL

Use Azure Data Factory Pipelines. Power BI can be integrated using the JDBC connector. Azure Active
Directory can control access to sources, results, and jobs. Azure Data Lakes and Azure Blob Storage
are exposed over DBFS (Databricks File System).

## Standard deployment architecture

Control plane is in the Microsoft/Databricks subscription. The data plane is in the Client
Subscription.

## Key points

1. Only use the default storage for temporary files. If you delete the Databricks workspace then
   this will be deleted.
2. Long-term storage should be in storage in _your_ storage accounts.
3. If you need custom connectivity then you can deploy databricks resources within your own VNet.
