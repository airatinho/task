SELECT val_sum ,uniq_users ,CAST(val_sum as  float)/CAST(uniq_users as  float) as ARPDAU
from (select COUNT(DISTINCT user_id)  as uniq_users FROM test
where event_name='launch') join (
select sum(event_value) as val_sum from test
where event_name='purchase')



