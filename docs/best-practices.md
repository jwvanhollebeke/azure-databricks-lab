# Best Practices

## Administration

1. Separate development, staging, and production workspace environments. View the workspace as a
   fundamental isolation unit.
2. Deploy using infrastructure-as-code (Terraform/ARM).
3. Remember, Azure Active Directory is the identity provider. Anyone with the owner or contributor
   role for the AD tenant can log in. You can create users or groups in an Databricks workspace.
   These users don't have any access to Azure AD unless you use SCIM (System for Cross-domain
   Identity Management).

### How to plan a deployment

Map workspaces to business divisions. This is the _Business Unit Subscription_ design pattern.
Deploy workspaces in multiple subscriptions to avoid Azure limits as listed below.

This means that dev, staging and production should be in separate subscriptions. Deploy to two
paired Azure regions for HA/DR. Use Azure Traffic Manager to distribute API requests across two
deployments when using ADB in non-interactive mode.

Define workspace-level tags.

#### API call limits

- 1000 jobs per hour
- 150 concurrent jobs
- 150 notebooks or execution contexts attached to a cluster
- 15000 Azure Databricks API calls per hour

#### Azure limits

- 250 Storage accounts/region
- 50 Gbps maximum egress
- 25,000 VMs per subscription per region
- 980 resource groups per subscription

Current as of the date of recording. Some are soft limits.

## Security

- Isolate each workspace in its own VNet. Follow the hub-and-spoke model and use VNet peering if you
  want to share networking resources across workspaces.
- Do not store production data in the default `/dbfs` folders. The lifecycle of these folders is
  tied to the workspace, so if you delete the workspace this production data will be removed. You
  cannot add ACLs to the files in these folders. Exception, blob or data lake storage mounted to
  dbfs is OK.
- Use a vault to access any secret data. Either Databricks vault or Azure Key Vault. For AKV, create
  separate secret scopes and secret data for each secret set.
- Azure Data Lake storage passthrough.
- Enable encryption-at-rest.
- Use ADLS credential passthrough over table ACLS.
- Configure access control for Databricks-native resources including clusters, jobs, notebooks etc.

## Monitoring

Use monitoring to right-size your VMs. To get utilization metrics stream VM metrics to an Azure Log
Analytics Workspace. You need to install an agent on each node. You can use Grafana to visualize
your data.

Send logs to blob storage using Cluster Log Delivery. Logs include user code, driver log, executors
log. Blob storage doesn't get purged and can be forwarded to an analytics platform.

## Integrations

- Favor cluster-scoped init scripts over global scripts. Init scripts allow you to customize your
  nodes. Available modes:

  | Name           | Where                                                          |
  | -------------- | -------------------------------------------------------------- |
  | Global         | In `/databricks/init`                                          |
  | Cluster-named  | Deprecated. In `/databricks/init/<cluster-_name>`              |
  | Cluster-scoped | Stored in dbfs under `/databricks` not under the `init` folder |

  Be careful with init scripts! They can cause clusters to fail on startup.

- Use Azure Data Factory (or Airflow) for orchestration.
- Sync notebooks using Azure DevOps.
- Use the Databricks CLI for CI and CD.
- Use library utilities to install python libraries at the notebook/cluster level.

## Runtime

### Shuffle

Tune shuffle for optimal performance. These determine the partition size, which should be several
megabytes to a gigabyte.. Settings:
 
- Number of partitions `spark.conf.set("spark.sql.shuffle.partitions", {integer})
- Number of partitions that you can compute in parallel (== number of cores in a cluster)

### Partition

Store data in partitions. This allows for partition pruning and data skipping to avoid unnecessary
reads. Choose your partition field based on the predicates most often used in your queries.

Aim for:

- Even data distribution. Date is common.
- 10-50 GB per partition.
- Don't partition small datasets.
- Avoid over-partitioning.

### Additional considerations

- Use Delta lake whenever you can to get the best performance and multi-step data pipelines.
- Use machine learning runtime to use the latest ML/DL libraries.
- Use Delta Cache to accelerate reads from blob storage or ADLS.
- Use the ADS-AQS connector for structured streaming with a consistent rate of incoming data on blob
  storage.
- Use Databricks Advisor for tips.

### Job types

- **Machine Learning** - All data for the model must be cached in memory. Consider _memory
  optimized_ VMs. For large datasets, possible consider _storage optimized VMS. To right-size, (1)
  take a percentage fo the data set (2) cache it (3) see how much memory it used (3) extrapolate to
  the rest of the data.
- **Streaming** - Make sure the processing rate is just above the input rate a peak times. Consider
  _compute optimized_ VMs.
- **Extract, Transform and Load (ETL)** - Consider using a general purpose for these VMs to start.
  Analyze the characteristics of these jobs by starting with a basic ETL and check if the job is
  limited by CPU, network, local I/O or other.
- **Interactive / Development** - Make sure these can autoscale to reduce cost.

