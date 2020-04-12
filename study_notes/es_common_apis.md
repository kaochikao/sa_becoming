

## routing constraint

```
PUT index-tmp/_settings
{
    "index.routing.allocation.include._name": "xxx"
}
```



## create dummy index
```
PUT /index-tmp

PUT /index-tmp/_doc/1
{
  "name": "John Doe"
}

GET index-tmp/_settings
GET index-tmp/_search

```

## Toubleshooting
```
GET _cluster/allocation/explain?pretty

GET _cat/indices/index-tmp
GET _cat/shards/index-tmp
GET _cat/nodes
```

## Cognito / Access
enable Cognito 後，還要把Cognito Identity Pool Auth Role加到access policy.
"arn:aws:iam::123456789012:role/Cognito_identitypoolAuth_Role"

## switch off cluster read-only mode
PUT _cluster/settings
{
  "persistent": {
    "cluster.blocks.read_only": false
  }
}

# Restore .kibana index

## Step 1: Restore .kibana index from automated snapshot
```
GET /_cat/snapshots/cs-automated?v&s=id:desc

POST /_snapshot/cs-automated/<snapshot_id>/_restore
{
  "indices": ".kibana",
  "rename_pattern": "(kibana)",
  "rename_replacement": "restored_$1"
}

GET /_cat/indices?
```

## Step 2: Backup the current .kibana to a tmp index

```
PUT /tmp_kibana
{
    "settings" : {
        "index" : {
            "number_of_shards" : 1, 
            "number_of_replicas" : 0 
        }
    }
}

<!-- or use _clone -->
POST _reindex
{
  "source": {
    "index": ".kibana"
  },
  "dest": {
    "index": "tmp_kibana"
  }
}


DELETE /.kibana
```

## Step 3: Move the ".restored_kibana" to ".kibana"

```
PUT /.kibana
{
    "settings" : {
        "index" : {
            "number_of_shards" : 1, 
            "number_of_replicas" : 0 
        }
    }
}


POST _reindex
{
  "source": {
    "index": ".restored_kibana"
  },
  "dest": {
    "index": ".kibana"
  }
}
```

