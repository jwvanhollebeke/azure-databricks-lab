# Databricks Delta Lake

Delta lake is a transactional storage layer designed to work with Apache Spark and DBFS. It
maintains a transaction log that efficiently tracks changes to the table.

Just getting the data into the Data Lake is not enough. It is a challenge to extract meaningful
data from these data lakes:

- Schema enforcement
- Table repairs
- Frequent metadata refreshes
- Difficult to sort
- Failed production jobs
- No schema enforcement creates inconsistent data
- Consistency

Performance challenges of data lakes:

- Many small or big files means a lot of time burned on I/O
- Partitioning (poor man's indexing) breaks down when your data has high cardinality and many
  dimensions
- No caching

Delta lake helps you overcome these challenges. It integrates with Apache Spark and uses and open
format based on Parquet. It is supported by other data platforms such as Azure Synapse. It brings
ACID transactions to big data workloads. You can use Apache Spark SQL Batch and Streaming APIs.

## Batch and streaming

### Tables types

| Type   | Description                                         |
| ------ | --------------------------------------------------- |
| Bronze | Raw data from various sources (json, iot data etc.) |
| Silver | Enriched streaming records                          |
| Gold   | Business-level aggregates for BI                    |

## Structured streaming

You can use SQL queries to process streaming data in the same way that you would process static
data. You can stream millions of events per second from any source.

Near real-time.

### Stream processing vs batch processing

Stream

Continuous
Faster than batch
Appends to table

