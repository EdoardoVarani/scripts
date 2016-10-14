#!/bin/bash
MYSQLHOST="127.0.0.1"
MYSQLDB="testdb"
MYSQLUSER="testuser"
MYSQLPASS="pass"
 
#File name with date only
DATE=$(date)
 
#File location
FILE="/tmp/Usage_Report_$DATE.csv"
 
MYSQLOPTS="--password=${MYSQLPASS}"
 
#testing purposes, give echo output
echo "Report Begin: $(date)"

 
mysql ${MYSQLOPTS} << EOFMYSQL
USE sys
select table_name, io_read, io_write from schema_table_statistics where table_schema="employees" order by io_read, io_write;
INTO OUTFILE '$FILE' FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
EOFMYSQL
 
#add column title to the report
sed -i '1i User_Name,User_ID' $FILE