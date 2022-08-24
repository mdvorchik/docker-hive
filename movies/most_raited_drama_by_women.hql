use testdb;
create external table if not exists top20_drama_by_women (
  movieid INT, 
  name STRING, 
  genre STRING,
  rating INT,
  number_of_rates INT
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/top20_drama_by_women';
INSERT OVERWRITE DIRECTORY 'hdfs://namenode:8020/user/hive/warehouse/testdb.db/top20_drama_by_women'
row format delimited
fields terminated by ','
lines terminated by '\n'
SELECT  m.movieid, m.name, m.genre, r.rating, count(m.movieid) number_of_rates
FROM    movies m JOIN ratings r
ON      (m.movieid=r.movieid)
JOIN    users u
ON      (r.userid=u.userid)
WHERE r.rating = 5 AND u.gender = 'F' AND m.genre LIKE '%Drama%'
GROUP BY m.movieid, m.name, m.genre, r.rating
ORDER BY number_of_rates DESC
LIMIT 20;
