# Performance Features

Why optimize for performance? As your data grows, so does the time required to gain valuable
insights from your data. Databricks includes many performance optimization features.

## Eager and lazy execution

Transformations are **lazy**. Actions are **eager**. Laziness makes it easier to parallelize
operations.

## Catalyst optimizer

When performing different transformation, Spark will store them in a Directed Acyclic Graph (DAG).
Then the catalyst optimizer will perform a set of rule-based and cost-based optimizations to
determine a logical and then physical plan of execution.

[databricks blog post](https://www.databricks.com/blog/2015/04/13/deep-dive-into-spark-sqls-catalyst-optimizer.html)

### Stages

1. Analyze the logical plan - SQL AST, datasets, and dataframes are combined into an unresolved
   logical plan and then resolved to a logical plan
2. Logical optimization - logical plan is optimized
3. Physical plan - logical plan is converted to a physical plan and analyzed for optimization
4. Code generation

## Narrow and wide transformations

A wide transformation requires sharing data across workers. A narrow transformation can be applied
per partition/worker with no need to share or shuffle data to other workers.

- Examples of narrow transformations: `filter`, `drop`, `coalesce`
- Examples of wide transformations: `distinct`, `groupBy`, `repartition`

Wide transformations cause data to shuffle between executors. We can use **pipelining** to optimize
these operations. That is executing as many operations as possible on a single partition of data. A
single partition is read into RAM and then as many narrow operations are performed as possible. Then
wide operations are performed.

- See also: Apache Spark RDD programming guide

### Tungsten binary format

Avoids serialization and deserialization. Aka UnsafeRow. This is the in-memory format of DataFrames.
Faster encoding and decoding. Spark can operate directly on Tungsten without deserialization.


