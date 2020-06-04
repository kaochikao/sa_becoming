

DynamoDB:
- Global table: 
    - multi-region
    - multi-master
    - you don't need to build your own replication solution.

Kinesis Video Streams + Rekognition Video:
- Use the Kinesis Video Streams `Producer SDK` to set up your producer.
- Rekognition stream processor API
- Rekognition Video write analysis output to a Kinesis Data Stream


DMS Database Migration Service:
- is able to migrate between different DB engines.
- selection rule, 
- transformation rule
    - remove columns
    - add prefix to table name
- s3也可以用做source or target endpoint in DMS!!
- `Data Pipeline` is suitable for `data backup` instead of migration.

- AWS Org: consolidated billing 只是其中一個feature. 開啟"All features", 就可以使用SCP.
- CloudFront: Origin Protocol Policy: Match Viewer:
    - HTTP only
    - HTTPS only
    - Match Viewer: HTTP or HTTPS, depending on the viewer.
- ALB支援SNI (Server Name Indicator) 後端servers可以host 不同applications並各自使用不同的ssl certificate.


- Route 53: 
    - complex routing (nested record sets)
    - 構成一個decision tree.
    - example: 先以latency-based routing, 再以weighted routing.
    - https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-complex-configs.html

- Redshift: 可以用reserved instance, 應該不能用spot instances.
- S3 Reduced Redundancy: The Reduced Redundancy Storage (RRS) storage class is designed for noncritical, reproducible data that can be stored with less redundancy than the S3 Standard storage class.
- DX public VIF, 可以從on-prem連到 S3. Low-latency, dedicated connection to an S3 public endpoint over DX.
    - 如果要連到VPC, 就用private VIF.
    - 一個VIF就是一個VLAN, 一個VIF需要一個VLAN ID, interface IP address, ASN, BGP key.
- EBS-Optimized EC2 instance
    - dedicated connection between EC2 instance & EBS volume.
    - 即使不斷增加EBS volumes to the RAID理論上會增加IOPS, 這個connection的throughput會成為bottleneck, 但可以用更大的instance type, bandwidth會更高．
- Managed Blockchain vs. QLDB:
    - QLDB is a ledger database purpose-built for customers who need to `maintain a complete and verifiable history of data changes` in an application that they own and manage in a `centralized` way. 
    - Amazon QLDB is not a blockchain technology. 
    - Instead, blockchain technologies focus enabling `multiple parties` to transact and share data securely in a decentralized way; without a trusted, central authority. 
    - Every member in a `network` has an independently verifiable `copy` of an immutable ledger, and members can create and endorse `transactions` in the network. 
    - Amazon Managed Blockchain is a fully managed blockchain service that enables multiple parties to transact and share data directly and securely `without the need for a central, trusted authority`.
    - `Managed Blockchain` can `replicate` an `immutable copy` of your `blockchain network activity` into `Amazon Quantum Ledger Database (QLDB)`, a fully managed ledger database. This allows you to easily analyze the network activity `outside the network` and gain insights into trends.
- WAF ACL: ALB, API Gateway, CloudFront
    - 當您在 Amazon CloudFront 上使用 AWS WAF 時，您的規則會`在靠近最終使用者的全球所有 AWS 節點中執行`。這表示不需要犧牲效能來提升安全性。封鎖的請求會在抵達您的 Web 伺服器前就被阻擋。
    - 當您在 Application Load Balancer 上使用 AWS WAF 時，您的規則會在區域中執行，並可用來保護與網際網路連接與內部的負載平衡器。
    - Rate-based rules:
        - `Rate-based Rules` are a new type of Rule that can be configured in AWS WAF. 
        - This feature allows you to specify `the number of web requests` that are allowed by a client IP in a trailing, continuously updated, 5 minute period. 
        - If an IP address breaches the configured limit, new requests will be blocked until the request rate falls below the configured threshold.
    - Shield是專門用於防DDoS, 如果要防SQL injection, 則要用WAF.
- S3 pre-signed URL:
    - All objects and buckets by default are private. The presigned URLs are useful if you want your user/customer to be able to upload a specific object to your bucket, but you `don't require them to have AWS security credentials or permissions`. 
    - if you receive a presigned URL to upload an object, you can upload the object only if `the creator of the presigned URL` has the necessary permissions to upload that object.
- ELB:
    - ELB = ALB, NLB, CLB
    - 無論哪種LB, 都要加1或多個listener.
    - A listener is `a process` that checks for connection requests.
    - It is configured with 
        1. a protocol and a port for front-end (client to load balancer) connections
        2. and a protocol and a port for back-end (load balancer to back-end instance) connections.
    - 3 components:
        1. Load Balancers (LB本身，single point of contact for clients. )
        2. Listeners
        3. Target Groups

## CLB
- supported protocols:
    1. HTTP
    2. HTTPS (secure HTTP)
    3. TCP
    4. SSL (secure TCP)
- 關於SSL:
    - If you use `HTTPS` or `SSL` for your front-end connections, you must deploy an `X.509 certificate` (SSL server certificate) on your load balancer. The load balancer decrypts requests from clients before sending them to the back-end instances (known as `SSL termination`).
    - If you `don't` want the load balancer to handle the SSL termination (known as SSL offloading), you can use `TCP` for `both the front-end and back-end connections`, and deploy certificates on the registered `instances` handling requests.

## ALB:
- Listener: HTTP & HTTPS
- The `rules` that you define for a listener determine `how` the load balancer routes requests to its registered targets.
- Listener Rule Action Types:
    - authenticate-cognito
    - authenticate-oidc
    - fixed-response
    - forward
    - redirect
- After you disable an Availability Zone, the targets in that Availability Zone `remain registered` with the load balancer, but the load balancer `will not route requests to them`.
- You can create `different target groups` for `different types of requests`. For example, create one target group for `general requests` and other target groups for `requests to the microservices for your application`.


## NLB:
- Listeners: 
    - TLS
    - TCP 
    - UDP 
    - TCP_UDP

- AWS `Global Accelerator` — Improves the availability and performance of your application. Use an accelerator to distribute traffic across `multiple load balancers` in `one or more AWS Regions`.

## LB比較：
- https://aws.amazon.com/elasticloadbalancing/features/#compare
- 都support
    - sticky session
    - cross-zone load balancing & zonal fail-over
    - SSL offload (因為都有TLS or HTTPS)
- 新型的only (ALB & NLB):
    - SNI
    - load balancing to multiple ports on the same instance
    - WebSockets
- ALB only:
    - User Authentication
    - Lambda functions as targets
    - Redirects
    - Fixed Response
    - routing based on:
        - HTTP header
        - HTTP method
        - HTTP query string
        - Host
        - Path
- NLB only:
    - EIP
    - Static IP
    - PrivateLink

Using `CLB` instead of `ALB` has the following benefits:
- Support for EC2-Classic
- Support for TCP and SSL listeners
- Support for `sticky sessions using application-generated cookies`

LB & HTTP headers:
- There are also non-standard HTTP headers available that are widely used by the applications. 
- Some of the non-standard HTTP headers have an `X-Forwarded prefix`. 
- Classic Load Balancers support the following X-Forwarded headers.
    1. X-Forwarded-For
        - ELB stores the client IP address in the X-Forwarded-For request header and passes the header to your server.
        - format: `X-Forwarded-For: client1, proxy1, proxy2`
    2. X-Forwarded-Proto
        - client 用的protocol (HTTP or HTTPS), 不然只看得到LB & server之間用的protocol.
    3. X-Forwarded-Port

AutoScaling:
- Use the `standby feature` instead of the suspend-resume feature if you need to `troubleshoot` or `reboot` an instance. 
    - You can put an instance that is in the `InService` state into the `Standby` state, update or troubleshoot the instance, and then return the instance to service. 
    - Instances that are on standby `are still part of the Auto Scaling group`, but they do not actively handle application traffic.
- Use the instance `scale-in protection` feature to `prevent specific instances from being terminated` during automatic `scale in`. 
    - You can enable the instance scale-in protection setting on an `Auto Scaling group` or on an `individual Auto Scaling instance`.

SAM Resource types:
- AWS::Serverless::Function
- AWS::Serverless::Api (HTTPS)
- AWS::Serverless::HttpApi
- AWS::Serverless::Application
- AWS::Serverless::SimpleTable
- AWS::Serverless::LayerVersion (Lambda Layer)

Migration:
- Server Migration Service:
    - Each server volume replicated is saved as a new `AMI`, which can be launched as an EC2 instance (virtual machine) in the AWS cloud. 
    - If you are using application groupings, Server Migration Service will launch the servers in a CloudFormation stack using an auto-generated CloudFormation template.
- Migration Hub: 
    - plan, track progress, monitor
    - no additional cost, you only pay for individual migration tools 

AWS Blockchain Templates:
- deploys the blockchain framework you choose as containers on an Amazon Elastic Container Service (ECS) cluster, or directly on an EC2 instance running Docker. 
- Your blockchain network is created in your own Amazon VPC, allowing you to use your VPC subnets and network Access Control Lists. 
- You can assign granular permissions using AWS IAM to restrict which resources an Amazon ECS cluster or Amazon EC2 instance can access.
- no additional charge for AWS Blockchain Templates. You pay only for the resources required to run your blockchain network.

- EC2 hibernation：等於是把EC2 instance的RAM裡的state存到EBS volume

Route Table:
- Your VPC has an implicit router, and you use route tables to control where network traffic is directed.
- Each subnet in your VPC must be associated with a route table, which controls the routing for the subnet (subnet route table). 
- You can explicitly associate a subnet with a particular route table. `Otherwise, the subnet is implicitly associated with the main route table`. 
- A subnet can only be associated with `one route table` at a time, but you can associate `multiple subnets with the same subnet route table`.
- When you create a VPC, it automatically has a `main route table`. The main route table controls the routing for all `subnets that are not explicitly associated with any other route table`. 
- By default, when you create a `non-default VPC`, the `main route table` contains only a `local route`.

RDS Multi-AZ Deployment:
- In case of an infrastructure failure, Amazon RDS performs an `automatic failover` to the `standby` (or to a `read replica` in the case of Amazon `Aurora`), so that you can resume database operations as soon as the failover is complete.
- `Read replicas` can be associated with `Multi-AZ deployments` to gain `read scaling benefits` in addition to the `enhanced database write availability` and `data durability` provided by `Multi-AZ deployments`.
- Enable `automatic backups` on your source DB Instance `before adding read replicas`, by setting the backup retention period to a value other than 0. `Backups must remain enabled for read replicas to work`.
- TL;DR: Use `Multi-AZ deployments` for `High Availability/Failover` and `Read Replicas` for `read scalability`.
- Read Replica:
    - You can create Read Replicas `within AZ`, `Cross-AZ` or `Cross-Region`.
    - Read Replica can be manually promoted as a standalone database instance.
    - Read Replicas support `Multi-AZ deployments`.
- Multi-AZ deployments are not a read scaling solution, `you cannot use a standby replica to serve read traffic. The standby is only there for failover`.
- AWS Lambda@Edge 
    - now supports `Node 12.x` and `Python 3.8`.
    - a compute service that lets you execute functions that `customize the content that CloudFront delivers`.
- CloudFront 502: 
    - loudFront wasn't able to serve the requested object because it `couldn't connect to the origin server`.

AWS X-Ray:
- helps developers analyze and debug production, distributed applications, such as those built using a microservices architecture. 
- With X-Ray, you can understand how your application and its underlying services are performing to identify and troubleshoot the root cause of performance issues and errors. 
- X-Ray provides an end-to-end view of `requests` as they `travel through your application`, and shows a map of your application’s underlying components. 


Cron Expression:
- Asterisks indicate that the cron expression matches for all values of the field. For example, "*" in the minute field means every minute. 
- Question marks are used to specify `no specific value` and is allowed for the `day-of-month` and `day-of-week` fields.
- 一般cron
    - `0 0 */3 ? * *` = every 3 hours
    - `0 * * ? * *` = every minute
- 似乎year有時會被省略，所以是7位or6位．
- CW Event不支援second. 但也是6位，支援year.

RDS:
- parameter group: basic general config?
- option group: for additional options?


KMS Key Policy:
- CMK = customer master key
- You can `view` the key policy for an `AWS managed CMK` or a `customer managed CMK`, but you can only change the key policy for a `customer managed CMK`. 
- The policies of AWS managed CMKs are created and managed by `the AWS service that created the CMK` in your account.
- You can add or remove IAM users, IAM roles, and `AWS accounts (root users)` in the key policy, and change the actions that are allowed or denied for those principals. 

```
"Action": [
    "kms:CreateGrant",
    "kms:ListGrants",
    "kms:RevokeGrant"
],
"Resource": "*",
"Condition": {
    "Bool": {
        "kms:GrantIsForAWSResource": "true"
    }
}
```
- grant 是用來給AWS services使用

Cognito:
- https://serverless-stack.com/chapters/cognito-user-pool-vs-identity-pool.html
- Notice how we could use the `User Pool`, `social networks`, or even our own `custom authentication system` as the `identity provider` for the `Cognito Identity Pool`. 
- The Cognito `Identity Pool` simply takes `all your identity providers` and `puts them together (federates them)`. And with all of this it can now give your users secure access to your AWS services, `regardless of where they come from`.
- So in summary; the Cognito User Pool stores all your users which then plugs into your Cognito Identity Pool which can give your users access to your AWS services.

EBS snapshot:
- Snapshots are constrained to the Region in which they were created. To share a snapshot with another Region, `copy the snapshot to that Region`.
- AWS prevents you from sharing snapshots that were encrypted with your `default CMK`. Snapshots that you intend to share must instead be encrypted with a `customer managed CMK`.


Lambda + RDS:
- https://aws.amazon.com/blogs/compute/using-amazon-rds-proxy-with-aws-lambda/
- Often developers must access data stored in relational databases from Lambda functions. But it can be challenging to ensure that your Lambda invocations do not `overload your database with too many connections`. The number of maximum concurrent connections for a relational database depends on how it is sized.
- This is because each connection consumes memory and CPU resources on the database server. Lambda functions can scale to tens of thousands of `concurrent connections`, meaning your database needs more resources to maintain connections instead of executing queries.
- `RDS Proxy` acts as an intermediary between your application and an RDS database. RDS Proxy establishes and manages the necessary `connection pools` to your database so that your application creates fewer database connections.