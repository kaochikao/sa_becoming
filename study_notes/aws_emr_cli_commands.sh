aws emr create-cluster \
--use-default-roles \
--release-label emr-5.30.0 \
--instance-type m5.xlarge \
--instance-count 2 \
--applications Name=Hive \
--name <cluster_name> \
--region <your_region> \
--tags "<your_key>=<your_val>"