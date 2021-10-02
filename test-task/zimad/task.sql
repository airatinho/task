select * from (SELECT
                      date(event_time),
                      user_id,
                      avg(event_value) ARPDAU
                      from test
where event_name='purchase' or event_name='launch'
group by date(event_time),user_id
)
where ARPDAU is not null
