use testdb;
create external table if not exists top20viewed_by_adult (
  movieid INT, 
  name STRING, 
  number_of_rates INT
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/top20viewed_by_adult';
INSERT OVERWRITE DIRECTORY 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/top20viewed_by_adult'
row format delimited
fields terminated by ','
lines terminated by '\n'
SELECT  m.movieid, m.name, count(m.movieid) number_of_rates
FROM    movies m JOIN ratings r
ON      (m.movieid=r.movieid)
JOIN    users u
ON      (r.userid=u.userid)
WHERE u.number1 >= 18
GROUP BY m.movieid, m.name
ORDER BY number_of_rates DESC
LIMIT 20;
