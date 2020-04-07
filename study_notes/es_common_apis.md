

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


