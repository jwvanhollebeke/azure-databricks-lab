# Storage Options

## Apache Parquet

- Columnar storage
- Supports complex nested structures
- Schema is stored in the file
- Supports efficient compression and encoding
- Binary
  - Writing to parquet can be slower
  - Reading from parquet is _much_ faster

## Tables

|                  | Managed                       | Unmanaged                               |
| :--------------- | :---------------------------- | :-------------------------------------- |
| Spark manages    | Schema and data               | Only schema                             |
| Storage location | DBFS                          | External location                       |
| Storage format   | Parquet                       | Stored in the underlying dataset format |
| Drop operation   | Deletes the schema and _data_ | Deletes the schema, preserves the data  |
| Use case         | staging, non-production       | production                              |
