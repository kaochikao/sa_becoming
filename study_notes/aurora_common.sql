
-- LOAD file from S3
create table programs(
    sn int,
    program varchar(20),
    test_id varchar(20),
    test_value varchar(20)
);

LOAD DATA FROM S3 's3://<path>'
    INTO TABLE programs
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (sn, program, test_id, test_value);


-- query general log
Select distinct (user_host) from mysql.general_log;

select * from mysql.general_log
where user_host like '%spark-user%'
and not argument like '/* ApplicationName=DataGrip 2019.3.1 */ SET%'
and not argument like '/* ApplicationName=DataGrip 2019.3.1 */ select database()'
and not argument = 'SHOW WARNINGS'
and not argument like 'SELECT @@session%'
;


-- create new user
CREATE USER 'spark-user' IDENTIFIED BY '<password>';
GRANT ALL PRIVILEGES ON test.* TO 'spark-user';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'spark-user';

