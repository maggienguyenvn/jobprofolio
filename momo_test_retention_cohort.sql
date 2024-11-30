-- This code is using to calculate the monthly_retention_cohort

WITH 
 active_months AS 
 (
  SELECT t1.user_id,
         DATE_TRUNC(MIN(date_mofidied) OVER(PARTITION BY t1.user_id ORDER BY date_mofidied),MONTH) AS first_purchase_month,
         CONCAT("month_",DATE_DIFF( DATE_TRUNC(date_mofidied,MONTH),DATE_TRUNC(MIN(date_mofidied) OVER(PARTITION BY t1.user_id ORDER BY date_mofidied),MONTH),MONTH)) AS cohort_month
         
    FROM `inlaid-fx-441715-m8.SQL_Test.Transaction_detail` t1
 )

SELECT *
  FROM active_months
  PIVOT(COUNT(DISTINCT user_id) users FOR cohort_month IN ("month_0","month_1","month_2","month_3","month_4","month_5","month_6","month_7","month_8","month_9","month_10","month_11") )
  ORDER BY first_purchase_month
