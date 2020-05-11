import boto3

client = boto3.client('athena')

qstring = """
select
    release_year,
    rating,
    mcast
from (
    select release_year, rating, mcast, row_number() over (partition by release_year, rating order by mcast desc) rn from (select * from movies where regexp_like(show_id,'[0-9]{7}[0-5]{1}'))
    )
where rn = 1
order by 1,2,3
"""

response = client.start_query_execution(
    QueryString=qstring,
    QueryExecutionContext={
        'Database': 'default'
    },
    ResultConfiguration={
        'OutputLocation': 's3://xxx/athena_query_out/'
    },
    WorkGroup='primary'
)

print(response)