--this code is using to answer the question 4
-- there was 72 new user in July2020 

SELECT      count(distinct user_id) as new_user_count
 FROM `inlaid-fx-441715-m8.SQL_Test.Transaction_detail` 
WHERE user_type = 'new'
  AND year_month = '202007'