
# show account & project
gcloud config list

# show GCS buckets
gsutil ls
gsutil ls gs://some-bucket

# -a, show archival information (eg. version)
gsutil ls -a gs://some-bucket

gsutil mb -l asia gs://some-bucket
gsutil mb -c regional -l us-east1 gs://some-bucket

# change bucket label
gsutil label ch -l "jklabel:jkval" gs://some-bucket

# see if versioning is enabled.
gsutil versioning get gs://some-bucket

gsutil versioning set on gs://some-bucket

gsutil cp localfile.txt gs://some-bucket/

gsutil cp gs://bucket1/** gs://bucket2/

# change ACL to give all users Read access to the csv file
gsutil acl ch -u AllUsers:R gs://bucket2/somefile.csv


References:
- install & init gcloud: https://cloud.google.com/storage/docs/gsutil_install?hl=zh-tw
