# Spark architecture fundamentals

Feature-rich Spark workload for analytics, data processing, and machine learning.

### Do you work with Big Data?

- Volume: scaling compute horizontally is required to keep up with the volume
- High velocity: real-time streaming and quick batch (microbatch)
- Variety: structured data _and_ unstructured data

The three V's of big data.

## Architecture

Azure Databricks Service - launches and manages Apache Spark clusters. Azure handles autoscaling and
auto termination.

Apache Spark Cluster - master/worker to parallelize compute horizontally handling commands issued
from notebooks. The spark driver is the "master", in Databricks the notebook is the driver program.
The driver nodes delegates work to the worker nodes. Driver programs access Apache Spark using a
spark session object.

### Databricks appliance

Deployed as a managed resource group in your subscription. The appliance includes:

- Virtual machines (driver and worker)
- Storage account
- Virtual network and security group

### Integration

Control plane integrates with Azure Resource Manager. Users can work with the Databricks web
application, which sits in the control plane in the Azure resource group, and provides access to the
databricks workspace, virtual network, blog storage.

## Spark jobs

- Distributed computing environment
- Unit of distribution is the Spark cluster

Every cluster has a driver and one or more workers (aka executors, JVMs). Work is split into jobs
across multiple nodes. Jobs are subdivided into tasks. Jobs are partitioned into units of work for
each slot. Each executor has several slots that the executor can assign for work. Number of slots
corresponds to cores and CPUs of each node. The JVM is multithreaded but has limits. The driver
scales horizontally using slots.

Driver has the responsibility to partition the data so that each task knows which piece of data to
process.

### Jobs

You focus on:

- Number of partitions
- Number of available slots
- Number of jobs triggered
- The stages these jobs are divided into

## Storage