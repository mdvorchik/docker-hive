create database if not exists testdb;
use testdb;
create external table if not exists movies (
  movieid INT,
  name STRING,
  genre STRING
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/movies';