--this code is using to create consolidated table for data visualization


CREATE OR REPLACE TABLE `inlaid-fx-441715-m8.SQL_Test.Transaction_detail` as

SELECT      tr.*,
            sc.Merchant_name ,
            format_timestamp('%Y-%m',tr.date_mofidied) as year_month,
            DATE_TRUNC(date_mofidied,MONTH) as month,
            Extract(dayofweek from tr.date_mofidied) as day_of_week,
            case when Extract(dayofweek from tr.date_mofidied)  = 1 then "Sunday"
            when Extract(dayofweek from tr.date_mofidied)  = 2 then "Monday"
            when Extract(dayofweek from tr.date_mofidied)  = 3 then "Tuesday"
            when Extract(dayofweek from tr.date_mofidied)  = 4 then "Wednesday"
            when Extract(dayofweek from tr.date_mofidied)  = 5 then "Thursday"
            when Extract(dayofweek from tr.date_mofidied)  = 6 then "Friday"
            when Extract(dayofweek from tr.date_mofidied)  = 7 then "Satuday"
end as weekday,
            sc.Rate_pct * tr.amount/100 as revenue,
            ui.Gender_modified as gender,
            ui.Location_modified as location,
            ui.age,
            case when format_timestamp('%Y%m',tr.date_mofidied) = format_timestamp('%Y%m',ui.First_tran_date) then 'new'
            else 'return'
            end as user_type,
            format_timestamp('%Y-%m',First_tran_date) as first_year_month
 FROM `inlaid-fx-441715-m8.SQL_Test.Transaction` tr
 LEFT JOIN `inlaid-fx-441715-m8.SQL_Test.Commission_scheme` sc
   ON tr.Merchant_id = sc.Merchant_id
 JOIN `inlaid-fx-441715-m8.SQL_Test.User_info` ui
   ON tr.user_id = ui.User_id
