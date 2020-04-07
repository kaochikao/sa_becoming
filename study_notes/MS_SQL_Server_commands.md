
[Official Doc](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15) 

## Install client:
```
sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo
sudo yum remove unixODBC-utf16 unixODBC-utf16-devel

sudo yum check-update
sudo yum update mssql-tools
sudo yum install -y mssql-tools unixODBC-devel

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```

## Connect
```
sqlcmd -S xxx.xxx.eu-west-1.rds.amazonaws.com -U admin -P 'xxx'

SELECT Name from sys.Databases;
GO
USE test;
CREATE DATABASE test;
CREATE TABLE Inventory (id INT, naMe NVARCHAR(50), quantity INT);
INSERT INTO Inventory VALUES (1, 'banana', 150); 
INSERT INTO Inventory VALUES (2, 'orange', 154);

SELECT * FROM Inventory;
```

Glue connection include path, use "test/dbo/%" or "test/%"
