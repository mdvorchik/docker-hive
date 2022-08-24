create database if not exists testdb;
use testdb;
create external table if not exists users (
  userid INT,
  gender STRING,
  number1 INT,
  number2 INT,
  str1 STRING
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/users';