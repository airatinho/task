
BEGIN


  Execute immediate ('truncate table T_CELL_DY_2G_NSN_SIP_NA reuse storage');
  INSERT INTO SERGEY_USTIMENKOV.T_CELL_DY_2G_NSN_SIP_NA
	select
		p.period_start_time,
		bsc_co_gid BSC_CO_GID,
		bcf_co_gid BCF_CO_GID,
		bts_co_gid BTS_CO_GID,
		bsc_id BSC_ID,
		bcf_id BCF_ID,
		BTS_ID BTS_ID,
		bsc_name BSC_NAME,
		bcf_name BCF_NAME,
		cell_name CELL_NAME,
		LAC LAC,
		cellid CELLID

	   --Cell Availability
	    ,SUM(NVL(BCCH_UPTIME,0)) AVAILABILITY_NOM
		,SUM(NVL(BCCH_UPTIME,0)+NVL(BCCH_DOWNTIME,0)) AVAILABILITY_DENOM

		--TBF_SSR_UL
		,SUM(NVL(NO_RADIO_RES_AVA_UL_TBF,0)) TBF_SSR_UL_NOM
		,SUM(NVL(UL_TBF_ESTABL_STARTED,0)) TBF_SSR_UL_DENOM

		--HO success ratio
		,SUM(NVL(MSC_O_SUCC_HO,0) + NVL(BSC_O_SUCC_HO,0) + NVL(CELL_SUCC_HO,0) + NVL(MSC_TO_WCDMA_RAN_SUCC_TCH_HO,0)) AS HOSR_NOM
		,SUM(NVL(MSC_O_HO_CMD,0) + NVL(BSC_O_HO_CMD_ASSGN,0) + NVL(BTS_HO_ASSGN,0) + NVL(MSC_GEN_SYS_WCDMA_RAN_HO_COM,0)) AS HOSR_DENOM

		--Voice Traffic
		,(sum((0.5*NVL(DTM_duration_sum_HR,0)+NVL(DTM_duration_sum_FR,0))/100)/sum(NVL(p.period_duration,0)*60))+(sum(NVL(p.ave_busy_tch,0))/sum(NVL(res_av_denom14,0))) AS  TRAFFIC_GSM_NOM
		,0 AS TRAFFIC_GSM_DENOM

		--Call Drop Rate
		,SUM(NVL(p3.DROP_AFTER_TCH_ASSIGN,0)) AS CDR_2G_NOM
		,SUM(NVL(TCH_NORM_RELEASE,0)+NVL(p3.DROP_AFTER_TCH_ASSIGN,0)+NVL(TCH_RE_EST_RELEASE,0)) AS CDR_2G_DENOM


		--CUNSSR
		,SUM(NVL(SDCCH_DROP_LU_EXCLUDED,0) + NVL(SDCCH_FAIL_PH_3,0) + NVL(SDCCH_LU_DROP,0)) AS CUNSSR_SDCDR_NOM
	    ,SUM(NVL(p3.SDCCH_ASSIGN,0)+NVL(SDCCH_HO_CALL_ASSIGN,0)-NVL(SDCCH_HO_RELEASE,0)-NVL(SDCCH_RE_EST_ASSIGN,0)) CUNSSR_SDCDR_DENOM
	    ,SUM(NVL(tch_new_call_assign,0)) AS CUNSSR_TAFR_NOM
	    ,SUM(NVL(tch_requests_call_attempt,0)+NVL(msc_i_sdcch_tch,0)) AS CUNSSR_TAFR_DENOM


	FROM  BSC_PS_RESAVAIL_BTS_DAY@na19 p

		LEFT JOIN BSC_PS_PCU_BTS_DAY@na19 p1
		ON p.period_start_time=p1.period_start_time and  p.bsc_gid = p1.bsc_gid and p.bcf_gid = p1.bcf_gid and p.bts_gid = p1.bts_gid

		LEFT JOIN BSC_PS_HO_BTS_DAY@na19 p2
		ON p.period_start_time=p2.period_start_time and  p.bsc_gid = p2.bsc_gid and p.bcf_gid = p2.bcf_gid and p.bts_gid = p2.bts_gid

		LEFT JOIN BSC_PS_TRAFFIC_BTS_DAY@na19 p3
		ON p.period_start_time=p3.period_start_time and  p.bsc_gid = p3.bsc_gid and p.bcf_gid = p3.bcf_gid and p.bts_gid = p3.bts_gid

		LEFT JOIN BSC_PS_SERVICE_BTS_DAY@na19 p4
		ON p.period_start_time=p4.period_start_time and  p.bsc_gid = p4.bsc_gid and p.bcf_gid = p4.bcf_gid and p.bts_gid = p4.bts_gid

		LEFT JOIN BSC_PS_PSDTM_BTS_DAY@na19 p5
		ON p.period_start_time=p5.period_start_time and  p.bsc_gid = p5.bsc_gid and p.bcf_gid = p5.bcf_gid and p.bts_gid = p5.bts_gid



		left JOIN (select
					cast(wr.co_gid as number(22)) bsc_co_gid
					,cast(wb.co_gid as number(22)) bcf_co_gid
					,cast(wc.co_gid as number(22)) bts_co_gid
					,wr.co_object_instance bsc_id
					,wb.co_object_instance bcf_id
					,wc.co_object_instance BTS_ID
					,wr.co_name bsc_name
					,wb.co_name bcf_name
					,wc.co_name cell_name
					,bts.BTS_SEGMENT_ID segmentId
					,bts.obj_gid
					,bts.BTS_FBNIU_1 frequencyBandInUse
					,bts.BTS_BICN_72 bsIdentityCodeNCC
					,bts.BTS_BICB_71 bsIdentityCodeBCC
					,bts.BTS_HSN1_150 hoppingSequenceNumber1
					,bts.BTS_HSN2_151 hoppingSequenceNumber2
					,bts.BTS_LOC_AREA_ID_LAC LAC
					,bts.bts_cell_id cellid
					,wc.CO_ADMIN_STATE bts_adminState
					,wb.CO_ADMIN_STATE bcf_adminState
					,wc.co_dn BTS_CO_DN
			from Ctp_common_objects@na19 wc
	            left join Ctp_common_objects@na19 wb
	            on wc.co_parent_gid=wb.co_gid
	            left join Ctp_common_objects@na19 wr
	            on wb.co_parent_gid=wr.co_gid
	            left join C_BSC_BTS@na19 bts
	  			 on wc.co_gid = bts.obj_gid)M
		on p.bsc_gid = M.bsc_co_gid and p.bcf_gid = M.bcf_co_gid and p.bts_gid = M.bts_co_gid


	where p.period_start_time=to_date('13.11.2021','dd.mm.yyyy')
	AND LAC IS NOT NULL AND cellid IS NOT null--and BRANCH_ID in (23,34,61)

	GROUP BY 	p.period_start_time,
		bsc_co_gid ,
		bcf_co_gid ,
		bts_co_gid ,
		bsc_id ,
		bcf_id ,
		BTS_ID ,
		bsc_name ,
		bcf_name ,
		cell_name ,
		LAC,
		cellid

		UNION ALL


	select
		p.period_start_time,
		bsc_co_gid BSC_CO_GID,
		bcf_co_gid BCF_CO_GID,
		bts_co_gid BTS_CO_GID,
		bsc_id BSC_ID,
		bcf_id BCF_ID,
		BTS_ID BTS_ID,
		bsc_name BSC_NAME,
		bcf_name BCF_NAME,
		cell_name CELL_NAME,
		LAC LAC,
		cellid CELLID

	   --Cell Availability
	    ,SUM(NVL(BCCH_UPTIME,0)) AVAILABILITY_NOM
		,SUM(NVL(BCCH_UPTIME,0)+NVL(BCCH_DOWNTIME,0)) AVAILABILITY_DENOM

		--TBF_SSR_UL
		,SUM(NVL(NO_RADIO_RES_AVA_UL_TBF,0)) TBF_SSR_UL_NOM
		,SUM(NVL(UL_TBF_ESTABL_STARTED,0)) TBF_SSR_UL_DENOM

		--HO success ratio
		,SUM(NVL(MSC_O_SUCC_HO,0) + NVL(BSC_O_SUCC_HO,0) + NVL(CELL_SUCC_HO,0) + NVL(MSC_TO_WCDMA_RAN_SUCC_TCH_HO,0)) AS HOSR_NOM
		,SUM(NVL(MSC_O_HO_CMD,0) + NVL(BSC_O_HO_CMD_ASSGN,0) + NVL(BTS_HO_ASSGN,0) + NVL(MSC_GEN_SYS_WCDMA_RAN_HO_COM,0)) AS HOSR_DENOM

		--Voice Traffic
		,(sum((0.5*NVL(DTM_duration_sum_HR,0)+NVL(DTM_duration_sum_FR,0))/100)/sum(NVL(p.period_duration,0)*60))+(sum(NVL(p.ave_busy_tch,0))/sum(NVL(res_av_denom14,0))) AS  TRAFFIC_GSM_NOM
		,0 AS TRAFFIC_GSM_DENOM

		--Call Drop Rate
		,SUM(NVL(p3.DROP_AFTER_TCH_ASSIGN,0)) AS CDR_2G_NOM
		,SUM(NVL(TCH_NORM_RELEASE,0)+NVL(p3.DROP_AFTER_TCH_ASSIGN,0)+NVL(TCH_RE_EST_RELEASE,0)) AS CDR_2G_DENOM


		--CUNSSR
		,SUM(NVL(SDCCH_DROP_LU_EXCLUDED,0) + NVL(SDCCH_FAIL_PH_3,0) + NVL(SDCCH_LU_DROP,0)) AS CUNSSR_SDCDR_NOM
	    ,SUM(NVL(p3.SDCCH_ASSIGN,0)+NVL(SDCCH_HO_CALL_ASSIGN,0)-NVL(SDCCH_HO_RELEASE,0)-NVL(SDCCH_RE_EST_ASSIGN,0)) CUNSSR_SDCDR_DENOM
	    ,SUM(NVL(tch_new_call_assign,0)) AS CUNSSR_TAFR_NOM
	    ,SUM(NVL(tch_requests_call_attempt,0)+NVL(msc_i_sdcch_tch,0)) AS CUNSSR_TAFR_DENOM


	FROM  BSC_PS_RESAVAIL_BTS_DAY@na18 p

		LEFT JOIN BSC_PS_PCU_BTS_DAY@na18 p1
		ON p.period_start_time=p1.period_start_time and  p.bsc_gid = p1.bsc_gid and p.bcf_gid = p1.bcf_gid and p.bts_gid = p1.bts_gid

		LEFT JOIN BSC_PS_HO_BTS_DAY@na18 p2
		ON p.period_start_time=p2.period_start_time and  p.bsc_gid = p2.bsc_gid and p.bcf_gid = p2.bcf_gid and p.bts_gid = p2.bts_gid

		LEFT JOIN BSC_PS_TRAFFIC_BTS_DAY@na18 p3
		ON p.period_start_time=p3.period_start_time and  p.bsc_gid = p3.bsc_gid and p.bcf_gid = p3.bcf_gid and p.bts_gid = p3.bts_gid

		LEFT JOIN BSC_PS_SERVICE_BTS_DAY@na18 p4
		ON p.period_start_time=p4.period_start_time and  p.bsc_gid = p4.bsc_gid and p.bcf_gid = p4.bcf_gid and p.bts_gid = p4.bts_gid

		LEFT JOIN BSC_PS_PSDTM_BTS_DAY@na19 p5
		ON p.period_start_time=p5.period_start_time and  p.bsc_gid = p5.bsc_gid and p.bcf_gid = p5.bcf_gid and p.bts_gid = p5.bts_gid


		left JOIN (select
					cast(wr.co_gid as number(22)) bsc_co_gid
					,cast(wb.co_gid as number(22)) bcf_co_gid
					,cast(wc.co_gid as number(22)) bts_co_gid
					,wr.co_object_instance bsc_id
					,wb.co_object_instance bcf_id
					,wc.co_object_instance BTS_ID
					,wr.co_name bsc_name
					,wb.co_name bcf_name
					,wc.co_name cell_name
					,bts.BTS_SEGMENT_ID segmentId
					,bts.obj_gid
					,bts.BTS_FBNIU_1 frequencyBandInUse
					,bts.BTS_BICN_72 bsIdentityCodeNCC
					,bts.BTS_BICB_71 bsIdentityCodeBCC
					,bts.BTS_HSN1_150 hoppingSequenceNumber1
					,bts.BTS_HSN2_151 hoppingSequenceNumber2
					,bts.BTS_LOC_AREA_ID_LAC LAC
					,bts.bts_cell_id cellid
					,wc.CO_ADMIN_STATE bts_adminState
					,wb.CO_ADMIN_STATE bcf_adminState
					,wc.co_dn BTS_CO_DN
			from Ctp_common_objects@na18 wc
	            left join Ctp_common_objects@na18 wb
	            on wc.co_parent_gid=wb.co_gid
	            left join Ctp_common_objects@na18 wr
	            on wb.co_parent_gid=wr.co_gid
	            left join C_BSC_BTS@na18 bts
	  			 on wc.co_gid = bts.obj_gid)M
		on p.bsc_gid = M.bsc_co_gid and p.bcf_gid = M.bcf_co_gid and p.bts_gid = M.bts_co_gid


	where p.period_start_time=to_date('13.11.2021','dd.mm.yyyy')
	AND LAC IS NOT NULL AND cellid IS NOT null
	GROUP BY 	p.period_start_time,
		bsc_co_gid ,
		bcf_co_gid ,
		bts_co_gid ,
		bsc_id ,
		bcf_id ,
		BTS_ID ,
		bsc_name ,
		bcf_name ,
		cell_name ,
		LAC,
		cellid ;
	COMMIT;


	INSERT INTO MIP.T_CELL_DY_2G_NSN_NA@mip
	SELECT * FROM SERGEY_USTIMENKOV.T_CELL_DY_2G_NSN_SIP_NA;

	COMMIT;
END;