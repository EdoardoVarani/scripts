#!/bin/bash
MYSQLHOST="127.0.0.1"
MYSQLDB="testdb"
MYSQLUSER="testuser"
MYSQLPASS="pass"
 
#File name with date only
DATE=$(date)
 

MYSQLOPTS="--password=${MYSQLPASS}"
 
#testing purposes, give echo output
echo "Report Begin: $(date)"

mysql ${MYSQLOPTS} << EOFMYSQL
USE sys
EOFMYSQL
mysql -ppass sys -e "select table_schema.table_name, table_schema.io_read_requests, table_schema.io_write_requests from schema_table_statistics order by io_read_requests, io_write_requests" |sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' >  sample.csv  

#INTO OUTFILE '$FILE' FIELDS TERMINATED BY ',' 
#LINES TERMINATED BY '\n';
#EOFMYSQL
 
#add column title to the report
#sed -i '1i User_Name,User_ID' $FILE
