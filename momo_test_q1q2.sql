-- This query to answer the question 1 & 2:
-- 1. Total revenue in Jan2020 is 1409827.02
-- 2. The most profitable month is in September2020 with 1702200.0

SELECT concat(extract(year from tr.date_mofidied),extract(month from tr.date_mofidied)) as month,
       sum(sc.Rate_pct * tr.amount/100) as revenue

 FROM `inlaid-fx-441715-m8.SQL_Test.Transaction` tr
 LEFT JOIN `inlaid-fx-441715-m8.SQL_Test.Commission_scheme` sc
   ON tr.Merchant_id = sc.Merchant_id
 GROUP BY 1
 ORDER BY 2 DESC;


