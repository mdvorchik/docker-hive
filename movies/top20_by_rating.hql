use testdb;
create external table if not exists top20by_rating (
  movieid INT, 
  name STRING, 
  rating INT, 
  number_of_rates INT
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/top20by_rating';
INSERT OVERWRITE DIRECTORY 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/top20by_rating'
row format delimited
fields terminated by ','
lines terminated by '\n'
SELECT  m.movieid, m.name, r.rating, count(r.rating) number_of_rates
FROM    movies m JOIN ratings r
ON      (m.movieid=r.movieid)
WHERE   r.rating=5
GROUP BY m.movieid, m.name, r.rating
ORDER BY number_of_rates DESC
LIMIT 20;
