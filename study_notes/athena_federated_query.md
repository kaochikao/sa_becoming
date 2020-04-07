# Athena Federated Query

TODO:
- try to set up a mysql connector, and query it
- what's the relationship with Glue Catalog?

### Prebuilt Athena data source connectors
- CloudWatch Logs
- DynamoDB
- DocumentDB
- RDS & JDBC sources: MySQL, PostgreSQL
    - https://github.com/awslabs/aws-athena-query-federation/tree/master/athena-jdbc

### Key points:
- custom connector: Athena Query Federation SDK
- Connectors use Apache Arrow as the format for returning data requested in a query, which enables connectors to be implemented in languages such as C, C++, Java, Python, and Rust.
- only available in us-east-1

## Examples:

CloudWatch query
```
SELECT * FROM "MyCloudwatchCatalog"."/var/ecommerce-engine/order-processor".all_log_streams limit 100;
```


Required Parameter: SecretNamePrefix, DefaultConnectionString, LambdaFunctionName, SecurityGroupIds, SubnetIds


References:
- Blog: set up, walkthrough: https://aws.amazon.com/blogs/big-data/query-any-data-source-with-amazon-athenas-new-federated-query/