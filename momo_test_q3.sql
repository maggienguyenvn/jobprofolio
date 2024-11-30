-- This query is used to answer the question 3
-- The most money weekday is in Wednesday; The least money weekday is in Sunday


with detail_revenue as 
(SELECT      tr.date_mofidied,
            case when Extract(dayofweek from tr.date_mofidied)  = 1 then "Sunday"
            when Extract(dayofweek from tr.date_mofidied)  = 2 then "Monday"
            when Extract(dayofweek from tr.date_mofidied)  = 3 then "Tuesday"
            when Extract(dayofweek from tr.date_mofidied)  = 4 then "Wednesday"
            when Extract(dayofweek from tr.date_mofidied)  = 5 then "Thursday"
            when Extract(dayofweek from tr.date_mofidied)  = 6 then "Friday"
            when Extract(dayofweek from tr.date_mofidied)  = 7 then "Satuday"
end as weekday,
            sum(sc.Rate_pct * tr.amount/100) as daily_revenue

 FROM `inlaid-fx-441715-m8.SQL_Test.Transaction` tr
 LEFT JOIN `inlaid-fx-441715-m8.SQL_Test.Commission_scheme` sc
   ON tr.Merchant_id = sc.Merchant_id
 GROUP BY 1,2
 ORDER BY 3 DESC
)

select weekday,
       round(avg(daily_revenue),2) as avg_daily_revenue
  from detail_revenue
 group by 1
 order by 2 desc 
