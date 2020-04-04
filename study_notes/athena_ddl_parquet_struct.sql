CREATE EXTERNAL TABLE test_pq_evol(
    a STRING,
    b STRING,
    c struct<c1:string,c2:string,c3:string>
) 
STORED AS PARQUET
LOCATION 's3://xxx/dummy/parquet_struct/';

-- {"a": "val_a1", "b": "val_b1", "c": {"c1": "val_c11", "c2": "val_c12", "c3": "val_c13"}}
-- {"a": "val_a2", "b": "val_b2", "c": {"c1": "val_c21", "c2": "val_c22", "c3": "val_c23"}}
-- {"a": "val_a3", "b": "val_b3", "c": {"c1": "val_c31", "c2": "val_c32", "c3": "val_c33"}}
-- {"a": "val_a4", "b": "val_b4", "c": {"c1": "val_c41", "c2": "val_c42"}}
-- {"a": "val_a5", "b": "val_b5", "c": {"c1": "val_c51", "c2": "val_c52"}}
-- {"a": "val_a6", "b": "val_b6", "c": {"c1": "val_c61", "c2": "val_c62"}}

-- 用pyarrow可以生成一般的parquet file, 但pyarrow還不支援nested field (struct), 用spark convert format更簡單



/*
Athena error: HIVE_CANNOT_OPEN_SPLIT
- "corrupted" Parquet files
- Parquet file inspection tool: https://github.com/apache/parquet-mr/tree/master/parquet-tools


Split
- splits are sections of a large data set
- “Lowest level stages retrieve data via splits from connectors”
- “Intermediate stages (at a higher level of a distributed query plan) retrieve data from other stages”
*/