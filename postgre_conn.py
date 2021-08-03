
import psycopg2
import pandas as pd
import numpy as np

con=psycopg2.connect(
    host="hostname",
    port=15432,
    database="database",
    user="username",
    password="password",
)

querry_comm="""select * from communications"""
communications=pd.read_sql(querry_comm,con)

querry_session="""select * from sessions"""
sessions=pd.read_sql(querry_session,con)

session_date_time_list=[]
row_n_list=[]
for i in range(len(communications['visitor_id'])):
    try:
        session_date_time_list.append(sessions[sessions['visitor_id']==communications['visitor_id'][i]]['date_time'][sessions['date_time']<=
        communications['date_time'][communications['visitor_id']==communications['visitor_id'][i]].iloc[0]].sort_values(ascending=False).iloc[1])
        row_n_list.append(len(sessions[sessions['visitor_id']==communications['visitor_id'][i]]['date_time'][sessions['date_time']<=
        communications['date_time'][communications['visitor_id']==communications['visitor_id'][i]].iloc[0]].sort_values(ascending=False).iloc[1:]))
    except IndexError:
        session_date_time_list.append(np.NaN)
        row_n_list.append(0)


joined=communications.merge(sessions,how='left',on='visitor_id').drop_duplicates(subset=['communication_id']).reset_index(drop=True)

joined['row_n']=row_n_list
joined['sessions_date_time']=session_date_time_list



"""выгрзука в таблицу"""
from sqlalchemy import create_engine

#выгрузка
engine = create_engine('postgresql://postgres:1@localhost/data', echo=False)

joined.to_sql('joined', con=engine)

sql_script="""

create table from_py_sql as
(
    SELECT FRT.visitor_id,communication_id,site_id,row_n,campaign_id,FRT.sessions_date_time,date_time as communication_date_time from (
                    SELECT * from communications com
                    left join LATERAL
                    (
                        select LEAD(date_time) over () as sessions_date_time, visitor_session_id,campaign_id
                        from sessions
                        where (visitor_id = com.visitor_id)
                        and (site_id = com.site_id)
                        and (date_time<=com.date_time)
                        limit 1
                    ) re on com.visitor_id = visitor_id
                  ) FRT
    left join LATERAL (
                        select Count(date_time)-1 as row_n, visitor_id
                        from LATERAL (
                                        select date_time
                                        from sessions
                                        where (visitor_id = FRT.visitor_id)
                                        and (date_time <=frt.date_time)
                                     ) a where visitor_id = FRT.visitor_id and site_id = frt.site_id
                      ) sss
    on FRT.visitor_id = sss.visitor_id

)
"""
