from requests_aws4auth import AWS4Auth
import boto3
import requests

service = 'es'
region = '<your_region>'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

url = '<your_elasticsearch_endpoint>'
r = requests.get(url, auth=awsauth)
print(r.text)

# if not signed: {"Message":"User: anonymous is not authorized to perform: es:ESHttpGet"}
