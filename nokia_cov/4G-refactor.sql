BEGIN

  Execute immediate ('truncate table T_CELL_DY_4G_TA_NSN_SIPPROJECT reuse storage');
  INSERT INTO T_CELL_DY_4G_TA_NSN_SIPPROJECT
	select
	         trunc(t.datetime) AS datetime
	         ,s.id_rg
	        ,mo_ref
	        ,CNAME
	        ,s.ci
	        ,ID_RAW

	         ,SUM(NVL(IP_TPUT_TIME_DL_QCI_1,0)+NVL(IP_TPUT_TIME_DL_QCI_2,0)+NVL(IP_TPUT_TIME_DL_QCI_3,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_4,0)+NVL(IP_TPUT_TIME_DL_QCI_5,0)+NVL(IP_TPUT_TIME_DL_QCI_6,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_7,0)+NVL(IP_TPUT_TIME_DL_QCI_8,0)+NVL(IP_TPUT_TIME_DL_QCI_9,0)) DL_AVG_THR_DENOM

		     ,round(DIV(SUM(NVL(IP_TPUT_VOL_DL_QCI_1,0)+NVL(IP_TPUT_VOL_DL_QCI_2,0)+NVL(IP_TPUT_VOL_DL_QCI_3,0)+
		      NVL(IP_TPUT_VOL_DL_QCI_4,0)+NVL(IP_TPUT_VOL_DL_QCI_5,0)+NVL(IP_TPUT_VOL_DL_QCI_6,0)+
		      NVL(IP_TPUT_VOL_DL_QCI_7,0)+NVL(IP_TPUT_VOL_DL_QCI_8,0)+NVL(IP_TPUT_VOL_DL_QCI_9,0))
		    ,SUM(NVL(IP_TPUT_TIME_DL_QCI_1,0)+NVL(IP_TPUT_TIME_DL_QCI_2,0)+NVL(IP_TPUT_TIME_DL_QCI_3,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_4,0)+NVL(IP_TPUT_TIME_DL_QCI_5,0)+NVL(IP_TPUT_TIME_DL_QCI_6,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_7,0)+NVL(IP_TPUT_TIME_DL_QCI_8,0)+NVL(IP_TPUT_TIME_DL_QCI_9,0))),2) DL_AVG_THR


		    ,round(DIV(SUM(1*NVL(t3.ue_rep_cqi_level_01, 0) + 2*NVL(t3.ue_rep_cqi_level_02, 0) + 3*NVL(t3.ue_rep_cqi_level_03, 0) + 4*NVL(t3.ue_rep_cqi_level_04, 0) + 5*NVL(t3.ue_rep_cqi_level_05, 0) + 6*NVL(t3.ue_rep_cqi_level_06, 0) + 7*NVL(t3.ue_rep_cqi_level_07, 0) + 8*NVL(t3.ue_rep_cqi_level_08, 0) + 9*NVL(t3.ue_rep_cqi_level_09, 0) + 10*NVL(t3.ue_rep_cqi_level_10, 0) + 11*NVL(t3.ue_rep_cqi_level_11, 0) + 12*NVL(t3.ue_rep_cqi_level_12, 0) + 13*NVL(t3.ue_rep_cqi_level_13, 0) + 14*NVL(t3.ue_rep_cqi_level_14, 0) + 15*NVL(t3.ue_rep_cqi_level_15, 0))
	    	,SUM(NVL(t3.ue_rep_cqi_level_00 ,0) + NVL(t3.ue_rep_cqi_level_01 ,0) + NVL(t3.ue_rep_cqi_level_02 ,0) + NVL(t3.ue_rep_cqi_level_03 ,0) + NVL(t3.ue_rep_cqi_level_04 ,0) + NVL(t3.ue_rep_cqi_level_05 ,0) + NVL(t3.ue_rep_cqi_level_06 ,0) + NVL(t3.ue_rep_cqi_level_07 ,0) + NVL(t3.ue_rep_cqi_level_08 ,0) + NVL(t3.ue_rep_cqi_level_09 ,0) + NVL(t3.ue_rep_cqi_level_10 ,0) + NVL(t3.ue_rep_cqi_level_11 ,0) + NVL(t3.ue_rep_cqi_level_12 ,0) + NVL(t3.ue_rep_cqi_level_13 ,0) + NVL(t3.ue_rep_cqi_level_14 ,0) + NVL(t3.ue_rep_cqi_level_15, 0))),2) AS CQI_AVG


	    	,round(DIV(SUM(NVL(SUM_RRC_CONNECTED_UE,0) + NVL(SUM_RRC_CONN_UE,0)), SUM(NVL(DENOM_RRC_CONNECTED_UE,0) + NVL(DENOM_RRC_CONN_UE,0))),2) AS NUMBER_OF_RRC_CONNECTED_USERS


	    	,round(avg(DL_PRB_UTIL_TTI_MEAN)/10,1) Avg_USG_per_TTI_PRB_DL

	        ,100*DIV(SUM(NVL(timing_adv_bin_1,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "0-0.5km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_2,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "0.5-1.0km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "1.0-1.5km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_5,0)+NVL(timing_adv_bin_6,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "1.5-2.0km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "2.0-2.7km"

	         ,100*DIV(SUM(NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "2.7-3.4km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_11,0)+NVL(timing_adv_bin_12,0)+NVL(timing_adv_bin_13,0)+NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "3.4-4.1km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+NVL(timing_adv_bin_18,0)+NVL(timing_adv_bin_19,0)+NVL(timing_adv_bin_20,0)+NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "4.1-4.8km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)+NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "4.8-5.6km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_30,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "+5.6km"

	         ,NULL AS "0-1.5km",NULL AS "1.5-3.0km",NULL AS "3.0-4.5km",NULL AS "4.5-6.0km",NULL AS "6.0-8.0km",NULL AS "8.0-10.4km",NULL AS "10.4-12.9km",NULL AS "12.9-14.6km",NULL AS "14.6-16.6km",NULL AS "+16.6km"

	      FROM i_nsn_lte.mnc1stats_hr t
		  LEFT JOIN i_nsn_lte.mnc1stats2_hr t2
		  ON t.datetime = t2.datetime
		    and t.mrbts_id = t2.mrbts_id
		    and t.lnbts_id = t2.lnbts_id
		    and t.lncel_id = t2.lncel_id
		  LEFT JOIN i_nsn_lte.mnc1stats3_hr t3
		  ON t.datetime = t3.datetime
		    and t.mrbts_id = t3.mrbts_id
		    and t.lnbts_id = t3.lnbts_id
		    and t.lncel_id = t3.lncel_id
		  JOIN SERGEY_USTIMENKOV.DS8_CELL s
		  	ON regexp_substr(regexp_substr(s.MO_REF,'[^/]+',1,2),'[^-]+',1,2) = t.mrbts_id
		    and regexp_substr(regexp_substr(s.MO_REF,'[^/]+',1,3),'[^-]+',1,2) = t.lnbts_id
		    and regexp_substr(regexp_substr(s.MO_REF,'[^/]+',1,4),'[^-]+',1,2) = t.lncel_id
		  WHERE t.datetime >to_date('12.11.2021','dd.mm.yyyy')
	    and t.datetime <to_date('13.11.2021','dd.mm.yyyy')
		    and s.id_vendtech in (56,66)
		    and s.dt_to is null
		    and id_rg in (23,34,61)
		    and s.cell_cgi not like '250-01-%'
		    and timing_adv_set_index = 2
	      group BY trunc(t.datetime)
	         ,s.id_rg
	        ,s.ci
	        ,CNAME
	        ,MO_REF
	        ,ID_RAW
	       UNION all
	       select
	         trunc(t.datetime) AS datetime
	         ,s.id_rg
	        ,mo_ref
	        ,CNAME
	        ,s.ci
	        ,ID_RAW


	        ,SUM(NVL(IP_TPUT_TIME_DL_QCI_1,0)+NVL(IP_TPUT_TIME_DL_QCI_2,0)+NVL(IP_TPUT_TIME_DL_QCI_3,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_4,0)+NVL(IP_TPUT_TIME_DL_QCI_5,0)+NVL(IP_TPUT_TIME_DL_QCI_6,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_7,0)+NVL(IP_TPUT_TIME_DL_QCI_8,0)+NVL(IP_TPUT_TIME_DL_QCI_9,0)) DL_AVG_THR_DENOM

		     ,round(DIV(SUM(NVL(IP_TPUT_VOL_DL_QCI_1,0)+NVL(IP_TPUT_VOL_DL_QCI_2,0)+NVL(IP_TPUT_VOL_DL_QCI_3,0)+
		      NVL(IP_TPUT_VOL_DL_QCI_4,0)+NVL(IP_TPUT_VOL_DL_QCI_5,0)+NVL(IP_TPUT_VOL_DL_QCI_6,0)+
		      NVL(IP_TPUT_VOL_DL_QCI_7,0)+NVL(IP_TPUT_VOL_DL_QCI_8,0)+NVL(IP_TPUT_VOL_DL_QCI_9,0))
		    ,SUM(NVL(IP_TPUT_TIME_DL_QCI_1,0)+NVL(IP_TPUT_TIME_DL_QCI_2,0)+NVL(IP_TPUT_TIME_DL_QCI_3,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_4,0)+NVL(IP_TPUT_TIME_DL_QCI_5,0)+NVL(IP_TPUT_TIME_DL_QCI_6,0)+
		       NVL(IP_TPUT_TIME_DL_QCI_7,0)+NVL(IP_TPUT_TIME_DL_QCI_8,0)+NVL(IP_TPUT_TIME_DL_QCI_9,0))),2) DL_AVG_THR


		    ,round(DIV(SUM(1*NVL(t3.ue_rep_cqi_level_01, 0) + 2*NVL(t3.ue_rep_cqi_level_02, 0) + 3*NVL(t3.ue_rep_cqi_level_03, 0) + 4*NVL(t3.ue_rep_cqi_level_04, 0) + 5*NVL(t3.ue_rep_cqi_level_05, 0) + 6*NVL(t3.ue_rep_cqi_level_06, 0) + 7*NVL(t3.ue_rep_cqi_level_07, 0) + 8*NVL(t3.ue_rep_cqi_level_08, 0) + 9*NVL(t3.ue_rep_cqi_level_09, 0) + 10*NVL(t3.ue_rep_cqi_level_10, 0) + 11*NVL(t3.ue_rep_cqi_level_11, 0) + 12*NVL(t3.ue_rep_cqi_level_12, 0) + 13*NVL(t3.ue_rep_cqi_level_13, 0) + 14*NVL(t3.ue_rep_cqi_level_14, 0) + 15*NVL(t3.ue_rep_cqi_level_15, 0))
	    	,SUM(NVL(t3.ue_rep_cqi_level_00 ,0) + NVL(t3.ue_rep_cqi_level_01 ,0) + NVL(t3.ue_rep_cqi_level_02 ,0) + NVL(t3.ue_rep_cqi_level_03 ,0) + NVL(t3.ue_rep_cqi_level_04 ,0) + NVL(t3.ue_rep_cqi_level_05 ,0) + NVL(t3.ue_rep_cqi_level_06 ,0) + NVL(t3.ue_rep_cqi_level_07 ,0) + NVL(t3.ue_rep_cqi_level_08 ,0) + NVL(t3.ue_rep_cqi_level_09 ,0) + NVL(t3.ue_rep_cqi_level_10 ,0) + NVL(t3.ue_rep_cqi_level_11 ,0) + NVL(t3.ue_rep_cqi_level_12 ,0) + NVL(t3.ue_rep_cqi_level_13 ,0) + NVL(t3.ue_rep_cqi_level_14 ,0) + NVL(t3.ue_rep_cqi_level_15, 0))),2) AS CQI_AVG


	    	,round(DIV(SUM(NVL(SUM_RRC_CONNECTED_UE,0) + NVL(SUM_RRC_CONN_UE,0)), SUM(NVL(DENOM_RRC_CONNECTED_UE,0) + NVL(DENOM_RRC_CONN_UE,0))),2) AS NUMBER_OF_RRC_CONNECTED_USERS


	    	,round(avg(DL_PRB_UTIL_TTI_MEAN)/10,1) Avg_USG_per_TTI_PRB_DL

	    	,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL

	         ,100*DIV(SUM(NVL(timing_adv_bin_1,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "0-1.5km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_2,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "1.5-3.0km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "3.0-4.5km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_5,0)+NVL(timing_adv_bin_6,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "4.5-6.0km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "6.0-8.0km"

	         ,100*DIV(SUM(NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "8.0-10.4km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_11,0)+NVL(timing_adv_bin_12,0)+NVL(timing_adv_bin_13,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "10.4-12.9km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)+NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+NVL(timing_adv_bin_18,0)+NVL(timing_adv_bin_19,0)+NVL(timing_adv_bin_20,0)+NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "12.9-14.6km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_25,0)+NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "14.6-16.6km"

	        ,100*DIV(SUM(NVL(timing_adv_bin_30,0)),
	         SUM(NVL(timing_adv_bin_1,0)+NVL(timing_adv_bin_2,0)+NVL(timing_adv_bin_3,0)+NVL(timing_adv_bin_4,0)+NVL(timing_adv_bin_5,0)
	         +NVL(timing_adv_bin_6,0)+NVL(timing_adv_bin_7,0)+NVL(timing_adv_bin_8,0)+NVL(timing_adv_bin_9,0)+NVL(timing_adv_bin_10,0)
	         +NVL(timing_adv_bin_11,0)+ NVL(timing_adv_bin_12,0)+ NVL(timing_adv_bin_13,0)+ NVL(timing_adv_bin_14,0)+NVL(timing_adv_bin_15,0)
	         +NVL(timing_adv_bin_16,0)+NVL(timing_adv_bin_17,0)+ NVL(timing_adv_bin_18,0)+ NVL(timing_adv_bin_19,0)+ NVL(timing_adv_bin_20,0)
	         +NVL(timing_adv_bin_21,0)+NVL(timing_adv_bin_22,0)+NVL(timing_adv_bin_23,0)+NVL(timing_adv_bin_24,0)+NVL(timing_adv_bin_25,0)
	         +NVL(timing_adv_bin_26,0)+NVL(timing_adv_bin_27,0)+NVL(timing_adv_bin_28,0)+NVL(timing_adv_bin_29,0)+NVL(timing_adv_bin_30,0))) "+16.6km"

	      FROM i_nsn_lte.mnc1stats_hr t
		  LEFT JOIN i_nsn_lte.mnc1stats2_hr t2
		  ON t.datetime = t2.datetime
		    and t.mrbts_id = t2.mrbts_id
		    and t.lnbts_id = t2.lnbts_id
		    and t.lncel_id = t2.lncel_id
		  LEFT JOIN i_nsn_lte.mnc1stats3_hr t3
		  ON t.datetime = t3.datetime
		    and t.mrbts_id = t3.mrbts_id
		    and t.lnbts_id = t3.lnbts_id
		    and t.lncel_id = t3.lncel_id
		  JOIN SERGEY_USTIMENKOV.DS8_CELL s
		  	ON regexp_substr(regexp_substr(s.MO_REF,'[^/]+',1,2),'[^-]+',1,2) = t.mrbts_id
		    and regexp_substr(regexp_substr(s.MO_REF,'[^/]+',1,3),'[^-]+',1,2) = t.lnbts_id
		    and regexp_substr(regexp_substr(s.MO_REF,'[^/]+',1,4),'[^-]+',1,2) = t.lncel_id
		  WHERE t.datetime >to_date('12.11.2021','dd.mm.yyyy')
	            and t.datetime <to_date('13.11.2021','dd.mm.yyyy')
		    and s.id_vendtech in (56,66)
		    and s.dt_to is null
		    and id_rg in (23,34,61)
		    and s.cell_cgi not like '250-01-%'
		    and timing_adv_set_index = 4
	      group BY trunc(t.datetime)
	         ,s.id_rg
	        ,s.ci
	        ,CNAME
	        ,MO_REF
	        ,ID_RAW;
	COMMIT;


  INSERT INTO MIP.T_CELL_DY_4G_TA_NSN@MIP
  SELECT * FROM SERGEY_USTIMENKOV.T_CELL_DY_4G_TA_NSN_SIPPROJECT;



	COMMIT;
END;
