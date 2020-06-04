
Edge

sudo mkdir -p /var/aws/emr/
sudo mkdir -p /etc/hadoop/conf
sudo mkdir -p /etc/spark/conf
sudo mkdir -p /var/log/spark/user/
sudo chmod 777 -R /var/log/spark/

------------------------------------------------------------------

Master

aws s3 cp /etc/yum.repos.d/emr-apps.repo s3://xxxxxxx/emr_edge_setup/emr-apps.repo
aws s3 cp /var/aws/emr/repoPublicKey.txt s3://xxxxxxx/emr_edge_setup/repoPublicKey.txt

Edge

aws s3 cp s3://xxxxxxx/emr_edge_setup/emr-apps.repo /etc/yum.repos.d/emr-apps.repo
aws s3 cp s3://xxxxxxx/emr_edge_setup/repoPublicKey.txt /var/aws/emr/repoPublicKey.txt 

------------------------------------------------------------------
Edge

sudo yum install -y hadoop-client
sudo yum install -y hadoop-hdfs
sudo yum install -y spark-core
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y libgssglue

------------------------------------------------------------------
Master

aws s3 sync /etc/spark/conf/ s3://xxxxxxx/emr_edge_setup/emrhadoop-conf/sparkconf/ 
aws s3 sync /etc/hadoop/conf/ s3://xxxxxxx/emr_edge_setup/emrhadoop-conf/hadoopconf/ 

Edge

sudo aws s3 sync s3://xxxxxxx/emr_edge_setup/emrhadoop-conf/sparkconf/ /etc/spark/conf/ 
sudo aws s3 sync s3://xxxxxxx/emr_edge_setup/emrhadoop-conf/hadoopconf/ /etc/hadoop/conf/ 

------------------------------------------------------------------
Master

hdfs dfs -mkdir -p /user/ec2-user
hdfs dfs -chown ec2-user:ec2-user /user/ec2-user

------------------------------------------------------------------


