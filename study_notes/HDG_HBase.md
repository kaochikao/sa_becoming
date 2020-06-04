

## HBase meta table

```
hbase shell
hbase(main):001:0> scan 'hbase:meta'
```

```
table_name, start_row, timestamp, MD5_hash
TestTable,xyz,1279729913622.1b6e176fb8d8aa88fd4ab6bc80247ece.
```

### meta table：
- As regions transition—are split, disabled, enabled, deleted, or redeployed by the region load balancer, or redeployed due to a regionserver `crash—the catalog table is updated so the state of all regions on the cluster is kept current`.
- 1 row = 1 region


### 與client的互動：

#### Simple Lookup Path
- Fresh clients connect to the ZooKeeper cluster first to learn the location of hbase:meta. 
- The client then does a lookup against the appropriate hbase:meta region to figure out the hosting user-space region and its location. 
- Thereafter, the client interacts directly with the hosting regionserver.
- As noted previously, row keys are sorted, so finding `the region that hosts a particular row` is a matter of a lookup to find the largest entry whose key is less than or equal to that of the requested row key.

#### In practice, caching: 
- To `save on` having to make `three round-trips` per `row` operation, clients cache all they learn while doing lookups for hbase:meta. 
- They cache `locations` as well as `user-space region` start and stop rows, so they can figure out hosting regions themselves without having to go back to the hbase:meta table. 
- Clients continue to use the cached entries as they work, until there is a fault. When this happens—i.e., `when the region has moved`—the client consults the hbase:meta table again to learn the new location. If the consulted `hbase:meta region` has moved, then `ZooKeeper` is reconsulted.
    - ZooKeeper是最終source of truth


### Write process
- WAL -> memstore -> flush to FS

### RS crash, reassignment
- The commit log is hosted on `HDFS`, so it remains available through a regionserver crash. 
- When the master notices that a regionserver is no longer reachable, usually because `the server’s znode has expired in ZooKeeper`, it splits the dead regionserver’s commit log `by region`. 
- On reassignment and before they reopen for business, regions that were on the dead regionserver will pick up their `just-split files` of `not-yet-persisted edits` and `replay` them to bring themselves up to date with the state they had just before the failure.


### HFile Compaction
- A `background process` compacts flush files once their number has exceeded a threshold, rewriting many files as one, because the fewer files a read consults, the more performant it will be. 
- On compaction, the process cleans out versions beyond the schema-configured maximum and removes deleted and expired cells. 
- A separate process running in the regionserver `monitors flush file sizes`, `splitting the region` when they grow in excess of the configured maximum.
    - Region Split 是由HFile size觸發！


### Data Model
- 其實一個data cell還是由一個column和一個row去定位，column family只是多一層的grouping, 也可視為column name中的prefix.
- cells are versioned.
- Physically, all column family members are stored together on the filesystem
- In synopsis, HBase tables are like those in an RDBMS, only cells are versioned, rows are sorted, and columns can be added on the fly by the client as long as the column family they belong to preexists.