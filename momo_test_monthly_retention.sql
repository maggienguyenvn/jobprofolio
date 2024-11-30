--People purchase last month did not return/return in this month (Month over month retention)
create or replace table `inlaid-fx-441715-m8.SQL_Test.Monthly_transaction` as
with monthly_user as (
SELECT DISTINCT user_id,
       DATE_TRUNC(date_mofidied,MONTH) as month
  FROM `inlaid-fx-441715-m8.SQL_Test.Transaction_detail` ),

  consolidate1 as (
 
 SELECT DISTINCT user_id,
        month as current_month,
        LEAD(month) OVER (PARTITION BY user_id ORDER BY month) AS next_month,
        LAG(month) OVER (PARTITION BY user_id ORDER BY month) AS previous_month
  FROM monthly_user)

  select current_month,
         user_id,
         CASE WHEN DATE_DIFF(current_month,previous_month,month) = 1 THEN "return"
              WHEN next_month is null then "churned_user"
              else null
         END as status_month
         
  from consolidate1
