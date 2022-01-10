
BEGIN


  Execute immediate ('truncate table T_CELL_DY_3G_NSN_SIP_NA reuse storage');
	  INSERT INTO SERGEY_USTIMENKOV.T_CELL_DY_3G_NSN_SIP_NA
	select
		to_char(trunc(c1.period_start_time, 'dd'), 'dd/mm/yyyy') period_start_time
		,c1.rnc_id
		,c1.wbts_id
		,c1.wcel_id

	    --Average HS-DSCH User Throughput (HSDPA)
	    ,SUM(NVL(HSDPA_ORIG_DATA,0)*8*500) HSDPA_AVG_THR_NOM
	    ,SUM(NVL(HSDPA_BUFF_WITH_DATA_PER_TTI,0)) HSDPA_AVG_THR_DENOM

	    --Cell Availability
	    ,SUM(NVL(AVAIL_WCELL_IN_WO_STATE,0)) AS AVAILABILITY_NOM
		,SUM(NVL(AVAIL_WCELL_EXISTS_IN_RNW_DB,0)) AS AVAILABILITY_DENOM

	    --RAB Drop Rate, NRT services
		,SUM(NVL(PS_REL_RL_FAIL_hs_e_int,0)+NVL(PS_REL_RL_FAIL_hs_e_bgr,0)+NVL(PS_REL_RL_FAIL_hs_d_int,0)+NVL(PS_REL_RL_FAIL_hs_d_bgr,0)+
	         NVL(PS_REL_RL_FAIL_d_d_int,0)+NVL(PS_REL_RL_FAIL_d_d_bgr,0)+NVL(PS_REL_OTH_FAIL_hs_e_int,0)+NVL(PS_REL_OTH_FAIL_hs_e_bgr,0)+
	         NVL(PS_REL_OTH_FAIL_hs_d_int,0)+NVL(PS_REL_OTH_FAIL_hs_d_bgr,0)+NVL(PS_REL_OTH_FAIL_d_d_int,0)+NVL(PS_REL_OTH_FAIL_d_d_bgr,0)+
	         NVL(PS_REL_RL_FAIL_hs_e_stre,0)+NVL(PS_REL_RL_FAIL_hs_d_stre,0)+NVL(PS_REL_RL_FAIL_d_d_stre,0)+NVL(PS_REL_OTH_FAIL_hs_e_stre,0)+
	         NVL(PS_REL_OTH_FAIL_hs_d_stre,0)+NVL(PS_REL_OTH_FAIL_d_d_stre,0)) RAB_DR_PS_NOM
	    ,SUM(NVL(PS_REL_RL_FAIL_hs_e_int,0)+NVL(PS_REL_RL_FAIL_hs_e_bgr,0)+NVL(PS_REL_RL_FAIL_hs_d_int,0)+NVL(PS_REL_RL_FAIL_hs_d_bgr,0)+
	         NVL(PS_REL_RL_FAIL_d_d_int,0)+NVL(PS_REL_RL_FAIL_d_d_bgr,0)+NVL(PS_REL_OTH_FAIL_hs_e_int,0)+NVL(PS_REL_OTH_FAIL_hs_e_bgr,0)+
	         NVL(PS_REL_OTH_FAIL_hs_d_int,0)+NVL(PS_REL_OTH_FAIL_hs_d_bgr,0)+NVL(PS_REL_OTH_FAIL_d_d_int,0)+NVL(PS_REL_OTH_FAIL_d_d_bgr,0)+
	         NVL(ps_rel_norm_hs_e_int,0)+NVL(ps_rel_norm_hs_e_bgr,0)+NVL(ps_rel_norm_hs_d_int,0)+NVL(ps_rel_norm_hs_d_bgr,0)+
	         NVL(ps_rel_norm_d_d_int,0)+NVL(ps_rel_norm_d_d_bgr,0)+NVL(PS_REL_RL_FAIL_hs_e_stre,0)+NVL(PS_REL_RL_FAIL_hs_d_stre,0)+
	         NVL(PS_REL_RL_FAIL_d_d_stre,0)+NVL(PS_REL_OTH_FAIL_hs_e_stre,0)+NVL(PS_REL_OTH_FAIL_hs_d_stre,0)+NVL(PS_REL_OTH_FAIL_d_d_stre,0)+
	         NVL(ps_rel_norm_hs_e_stre,0)+NVL(ps_rel_norm_hs_d_stre,0)+NVL(ps_rel_norm_d_d_stre,0)+NVL(denom_st_trans_time_fach_pch,0)) RAB_DR_PS_DENOM

		-- U_CUNSSR_PS
	    ,SUM(NVL(moc_inter_call_atts,0)-NVL(moc_inter_call_fails,0)+NVL(moc_backg_call_atts,0)-NVL(moc_backg_call_fails,0)+NVL(moc_strea_call_atts,0)-NVL(moc_strea_call_fails,0)+NVL(mtc_inter_call_atts,0)-NVL(mtc_inter_call_fails,0)+NVL(mtc_backg_call_atts,0)-NVL(mtc_backg_call_fails,0)+NVL(mtc_strea_call_atts,0)-NVL(mtc_strea_call_fails,0)+NVL(moc_subsc_traf_call_atts,0)-NVL(moc_subsc_traf_call_fails,0)-NVL(RRC_ACC_REL_MO_STREAMING,0)-NVL(RRC_ACC_REL_MO_INTERACTIVE,0)-NVL(RRC_ACC_REL_MO_BACKGROUND,0)-NVL(RRC_ACC_REL_MO_SUBSCRIBED,0)-NVL(RRC_ACC_REL_MT_STREAMING,0)-NVL(RRC_ACC_REL_INTERACTIVE,0)-NVL(RRC_ACC_REL_MT_BACKGROUND,0)) AS U_CUNSSR_PS_RRC_NOM
		,SUM(NVL(moc_inter_call_atts,0)+NVL(moc_backg_call_atts,0)+NVL(moc_strea_call_atts,0)+NVL(moc_subsc_traf_call_atts,0)+NVL(mtc_inter_call_atts,0)+NVL(mtc_backg_call_atts,0)+NVL(mtc_strea_call_atts,0)-NVL(RRC_ATT_REP_MO_INTERACTIVE,0)-NVL(RRC_ATT_REP_MO_BACKGROUND,0)-NVL(RRC_ATT_REP_MO_STREAMING,0)-NVL(RRC_ATT_REP_MO_SUBSCRIBED,0)-NVL(RRC_ATT_REP_INTERACTIVE,0)-NVL(RRC_ATT_REP_MT_BACKGROUND,0)-NVL(RRC_ATT_REP_MT_STREAMING,0)-NVL(RRC_ACC_REL_MO_INTERACTIVE,0)-NVL(RRC_ACC_REL_MO_BACKGROUND,0)-NVL(RRC_ACC_REL_MO_STREAMING,0)-NVL(RRC_ACC_REL_MO_SUBSCRIBED,0)-NVL(RRC_ACC_REL_INTERACTIVE,0)-NVL(RRC_ACC_REL_MT_BACKGROUND,0)-NVL(RRC_ACC_REL_MT_STREAMING,0)) AS U_CUNSSR_PS_RRC_DENOM
		,SUM(NVL(rab_acc_comp_ps_inter,0)+NVL(rab_acc_comp_ps_backg,0)+NVL(rab_acc_comp_ps_strea,0)+NVL(HS_E_REQ_HS_E_ALLO_INT,0)+NVL(HS_E_REQ_HS_E_ALLO_BGR,0)+NVL(HS_E_REQ_HS_E_ALLO_STRE,0)+NVL(HS_E_REQ_HS_D_ALLO_INT,0)+NVL(HS_E_REQ_HS_D_ALLO_BGR,0)+NVL(HS_E_REQ_HS_D_ALLO_STRE,0)+NVL(HS_E_REQ_D_D_ALLO_INT,0)+NVL(HS_E_REQ_D_D_ALLO_BGR,0)+NVL(HS_E_REQ_D_D_ALLO_STRE,0)+NVL(HS_D_REQ_HS_D_ALLO_INT,0)+NVL(HS_D_REQ_HS_D_ALLO_BGR,0)+NVL(HS_D_REQ_HS_D_ALLO_STRE,0)+NVL(HS_D_REQ_D_D_ALLO_INT,0)+NVL(HS_D_REQ_D_D_ALLO_BGR,0)+NVL(HS_D_REQ_D_D_ALLO_STRE,0)+NVL(D_D_REQ_D_D_ALLO_INT,0)+NVL(D_D_REQ_D_D_ALLO_BGR,0)+NVL(D_D_REQ_D_D_ALLO_STRE,0)+NVL(DENOM_ST_TRANS_TIME_PCH_FACH,0)) AS U_CUNSSR_PS_RAB_NOM
		,SUM(NVL(rab_stp_att_ps_inter,0)+NVL(RAB_STP_ATT_PS_BACKG,0)+NVL(RAB_STP_ATT_PS_STREA,0)+NVL(PS_ATT_HSDSCH_EDCH_INT,0)+NVL(PS_ATT_HSDSCH_EDCH_BGR,0)+NVL(PS_ATT_HSDSCH_EDCH_STRE,0)+NVL(PS_ATT_HSDSCH_DCH_INT,0)+NVL(PS_ATT_HSDSCH_DCH_BGR,0)+NVL(PS_ATT_HSDSCH_DCH_STRE,0)+NVL(PS_ATT_DCH_DCH_INT,0)+NVL(PS_ATT_DCH_DCH_BGR,0)+NVL(PS_ATT_DCH_DCH_STRE,0)+NVL(ATT_PCH_TO_FACH,0)) AS U_CUNSSR_PS_RAB_DENOM

		-- Average HSUPA User Throughput
	    ,SUM(NVL(EDCH_DATA_SCELL_UL,0)*8) AS HSUPA_AVG_THR_NOM
		,SUM(NVL(MACE_PDUS_2MS_TTI,0)*0.002 + NVL(MACE_PDUS_10MS_TTI,0)*0.01) AS HSUPA_AVG_THR_DENOM

		-- Inter frequency HO Success Rate RT - IFHO_CS_SR
		,SUM(NVL(succ_if_hho_cpich_ecno_rt,0) +NVL(succ_if_hho_cpich_rscp_rt,0) +NVL(succ_is_hho_dl_dpch_pwr_rt,0) +NVL(succ_is_hho_ue_trx_pwr_rt,0) +NVL(succ_is_hho_ul_dch_q_rt,0))  AS IFHO_CS_SR_NOM
		,SUM(NVL(if_hho_att_cpich_ecno_rt,0) +NVL(if_hho_att_cpich_rscp_rt,0) +NVL(is_hho_att_dpch_pwr_rt,0) +NVL(is_hho_att_ue_trx_pwr_rt,0) +NVL(is_hho_att_ul_dch_q_rt,0))  AS IFHO_CS_SR_DENOM

		-- Inter System Hard Handover Success Ratio RT - IRATHO_CS_SR
		,SUM(NVL(succ_is_hho_ul_dch_q_rt ,0) + NVL(succ_is_hho_ue_trx_pwr_rt ,0) + NVL(succ_is_hho_dl_dpch_pwr_rt ,0) + NVL(succ_is_hho_cpich_rscp_rt ,0) + NVL(succ_is_hho_cpich_ecno_rt ,0) + NVL(succ_is_hho_im_ims_rt ,0) + NVL(succ_isho_cell_shutdown_rt ,0) + NVL(succ_isho_cell_block_rt ,0) + NVL(succ_is_hho_dr_amr_rt ,0) + NVL(succ_is_hho_emerg_call,0)) AS IRATHO_CS_SR_NOM
		,SUM(NVL(is_hho_att_ul_dch_q_rt ,0) + NVL(is_hho_att_ue_trx_pwr_rt ,0) + NVL(is_hho_att_dpch_pwr_rt ,0) + NVL(is_hho_att_cpich_rscp_rt ,0) + NVL(is_hho_att_cpich_ecno_rt ,0) + NVL(is_hho_att_im_ims_rt ,0) + NVL(att_isho_cell_shutdown_rt ,0) + NVL(att_isho_cell_block_rt ,0) + NVL(is_hho_att_dr_amr_rt,0)) AS IRATHO_CS_SR_DENOM

		-- IRATHO_PS_SR
		,SUM(NVL(INTER_RAT_HO_UTRAN,0) - NVL(INTER_RAT_HO_UTRAN_FAIL, 0)) AS IRATHO_PS_SR_NOM
		,SUM(NVL(INTER_RAT_HO_UTRAN,0)) AS IRATHO_PS_SR_DENOM

		-- IFHO_PS_SR
		,SUM(NVL(succ_if_hho_cpich_ecno_nrt,0) +NVL(succ_if_hho_cpich_rscp_nrt,0) +NVL(succ_is_hho_dl_dpch_pwr_nrt,0) +NVL(succ_is_hho_ue_trx_pwr_nrt,0) +NVL(succ_is_hho_ul_dch_q_nrt, 0)) AS IFHO_PS_SR_NOM
		,SUM(NVL(if_hho_att_cpich_ecno_nrt,0) +NVL(if_hho_att_cpich_rscp_nrt,0) +NVL(is_hho_att_dl_dpch_pwr_nrt,0) +NVL(is_hho_att_ue_trx_pwr_nrt,0) +NVL(is_hho_att_ul_dch_q_nrt, 0)) AS IFHO_PS_SR_DENOM


		-- % of RSCP < -105 dBm
		,SUM(NVL(RRC_CPICH_RSCP_CLASS_0 ,0) + NVL(RRC_CPICH_RSCP_CLASS_1 ,0) + NVL(RRC_CPICH_RSCP_CLASS_2 ,0) + NVL(RRC_CPICH_RSCP_CLASS_3,0) )  AS RSCP_BELOW_105_NOM
		,SUM(NVL(RRC_CPICH_RSCP_CLASS_0 ,0) + NVL(RRC_CPICH_RSCP_CLASS_1 ,0) + NVL(RRC_CPICH_RSCP_CLASS_2 ,0) + NVL(RRC_CPICH_RSCP_CLASS_3 ,0) + NVL(RRC_CPICH_RSCP_CLASS_4 ,0) +
		NVL(RRC_CPICH_RSCP_CLASS_5 ,0) + NVL(RRC_CPICH_RSCP_CLASS_6 ,0) + NVL(RRC_CPICH_RSCP_CLASS_7 ,0) + NVL(RRC_CPICH_RSCP_CLASS_8 ,0) + NVL(RRC_CPICH_RSCP_CLASS_9 ,0) +
		NVL(RRC_CPICH_RSCP_CLASS_10 ,0) + NVL(RRC_CPICH_RSCP_CLASS_11 ,0) + NVL(RRC_CPICH_RSCP_CLASS_12 ,0) + NVL(RRC_CPICH_RSCP_CLASS_13 ,0) + NVL(RRC_CPICH_RSCP_CLASS_14 ,0) +
		NVL(RRC_CPICH_RSCP_CLASS_15 ,0) + NVL(RRC_CPICH_RSCP_CLASS_16,0)) AS RSCP_BELOW_105_DENOM


		-- Avg CQI 3G
		,SUM(1*NVL(cqi_dist_cl_1 ,0) + 2*NVL(cqi_dist_cl_2 ,0) + 3*NVL(cqi_dist_cl_3 ,0) + 4*NVL(cqi_dist_cl_4 ,0) + 5*NVL(cqi_dist_cl_5 ,0) + 6*NVL(cqi_dist_cl_6 ,0) + 7*NVL(cqi_dist_cl_7 ,0) + 8*NVL(cqi_dist_cl_8 ,0) + 9*NVL(cqi_dist_cl_9 ,0) + 10*NVL(cqi_dist_cl_10 ,0) + 11*NVL(cqi_dist_cl_11 ,0) + 12*NVL(cqi_dist_cl_12 ,0) + 13*NVL(cqi_dist_cl_13 ,0) + 14*NVL(cqi_dist_cl_14 ,0) + 15*NVL(cqi_dist_cl_15 ,0) + 16*NVL(cqi_dist_cl_16 ,0) + 17*NVL(cqi_dist_cl_17 ,0) + 18*NVL(cqi_dist_cl_18 ,0) + 19*NVL(cqi_dist_cl_19 ,0) + 20*NVL(cqi_dist_cl_20 ,0) + 21*NVL(cqi_dist_cl_21 ,0) + 22*NVL(cqi_dist_cl_22 ,0) + 23*NVL(cqi_dist_cl_23 ,0) + 24*NVL(cqi_dist_cl_24 ,0) + 25*NVL(cqi_dist_cl_25 ,0) + 26*NVL(cqi_dist_cl_26 ,0) + 27*NVL(cqi_dist_cl_27 ,0) + 28*NVL(cqi_dist_cl_28 ,0) + 29*NVL(cqi_dist_cl_29 ,0) + 30*NVL(cqi_dist_cl_30,0)) AS AVG_CQI_NOM
		,SUM(NVL(cqi_dist_cl_0 ,0) + NVL(cqi_dist_cl_1 ,0) + NVL(cqi_dist_cl_2 ,0) + NVL(cqi_dist_cl_3 ,0) + NVL(cqi_dist_cl_4 ,0) + NVL(cqi_dist_cl_5 ,0) + NVL(cqi_dist_cl_6 ,0) + NVL(cqi_dist_cl_7 ,0) + NVL(cqi_dist_cl_8 ,0) + NVL(cqi_dist_cl_9 ,0) + NVL(cqi_dist_cl_10 ,0) + NVL(cqi_dist_cl_11 ,0) + NVL(cqi_dist_cl_12 ,0) + NVL(cqi_dist_cl_13 ,0) + NVL(cqi_dist_cl_14 ,0) + NVL(cqi_dist_cl_15 ,0) + NVL(cqi_dist_cl_16 ,0) + NVL(cqi_dist_cl_17 ,0) + NVL(cqi_dist_cl_18 ,0) + NVL(cqi_dist_cl_19 ,0) + NVL(cqi_dist_cl_20 ,0) + NVL(cqi_dist_cl_21 ,0) + NVL(cqi_dist_cl_22 ,0) + NVL(cqi_dist_cl_23 ,0) + NVL(cqi_dist_cl_24 ,0) + NVL(cqi_dist_cl_25 ,0) + NVL(cqi_dist_cl_26 ,0) + NVL(cqi_dist_cl_27 ,0) + NVL(cqi_dist_cl_28 ,0) + NVL(cqi_dist_cl_29 ,0) + NVL(cqi_dist_cl_30,0)) AS AVG_CQI_DENOM

		--Number of RRC connected users
		,SUM(NVL(NUM_UE_MEAS_CELL_DCH,0) + NVL(NUM_UE_MEAS_CELL_FACH,0) + NVL(NUM_UE_MEAS_CELL_PCH,0)) AS NUMBER_OF_RRC_CONNECTED_USERS

		-- CDR CS
		,SUM(NVL(RAB_ACT_REL_CS_VOICE_P_EMP,0)+NVL(RAB_ACT_FAIL_CS_VOICE_IU,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RADIO,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_BTS,0)+NVL(RAB_ACT_FAIL_CS_VOICE_IUR,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RNC,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_UE,0)+NVL(RAB_ACT_FAIL_CS_VOICE_TRANS,0)+ NVL(RAB_ACT_REL_CS_CONV_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IU,0)+NVL(RAB_ACT_FAIL_CS_CONV_RADIO,0)+NVL(RAB_ACT_FAIL_CS_CONV_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IUR,0)+NVL(RAB_ACT_FAIL_CS_CONV_RNC,0)+NVL(RAB_ACT_FAIL_CS_CONV_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_TRANS,0)+NVL(RAB_ACT_REL_CS_STREA_P_EMP,0)+NVL(RAB_ACT_FAIL_CS_STREA_IU,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_RADIO,0)+NVL(RAB_ACT_FAIL_CS_STREA_BTS,0)+NVL(RAB_ACT_FAIL_CS_STREA_IUR,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_RNC,0)+NVL(RAB_ACT_FAIL_CS_STREA_UE,0)+NVL(RAB_ACT_FAIL_CS_STREA_TRANS,0)) AS  CDR_CS_NOM
	    ,SUM(NVL(RAB_ACT_COMP_CS_VOICE,0)+NVL(RAB_ACT_REL_CS_VOICE_SRNC,0)+NVL(RAB_ACT_REL_CS_VOICE_HHO,0)+
	         NVL(RAB_ACT_REL_CS_VOICE_ISHO,0)+NVL(RAB_ACT_REL_CS_VOICE_GANHO,0)+NVL(RAB_ACT_REL_CS_VOICE_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_IU,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RADIO,0)+NVL(RAB_ACT_FAIL_CS_VOICE_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_IUR,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RNC,0)+NVL(RAB_ACT_FAIL_CS_VOICE_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_TRANS,0)+NVL(RAB_ACT_COMP_CS_CONV,0)+NVL(RAB_ACT_REL_CS_CONV_SRNC,0)+
	         NVL(RAB_ACT_REL_CS_CONV_HHO,0)+NVL(RAB_ACT_REL_CS_CONV_ISHO,0)+NVL(RAB_ACT_REL_CS_CONV_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IU,0)+NVL(RAB_ACT_FAIL_CS_CONV_RADIO,0)+NVL(RAB_ACT_FAIL_CS_CONV_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IUR,0)+NVL(RAB_ACT_FAIL_CS_CONV_RNC,0)+NVL(RAB_ACT_FAIL_CS_CONV_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_TRANS,0)+NVL(RAB_ACT_COMP_CS_STREA,0)+NVL(RAB_ACT_REL_CS_STREA_SRNC,0)+
	         NVL(RAB_ACT_REL_CS_STREA_HHO,0)+NVL(RAB_ACT_REL_CS_STREA_ISHO,0)+NVL(RAB_ACT_REL_CS_STREA_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_IU,0)+NVL(RAB_ACT_FAIL_CS_STREA_RADIO,0)+NVL(RAB_ACT_FAIL_CS_STREA_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_IUR,0)+NVL(RAB_ACT_FAIL_CS_STREA_RNC,0)+NVL(RAB_ACT_FAIL_CS_STREA_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_TRANS,0)) AS CDR_CS_DENOM

	    -- U_CUNSSR_CS
		,SUM(NVL(moc_conv_call_atts,0)-NVL(moc_conv_call_fails,0)+NVL(mtc_conv_call_atts,0)-NVL(mtc_conv_call_fails,0)+NVL(emergency_call_atts,0)-NVL(emergency_call_fails,0)-NVL(RRC_ACC_REL_EMERGENCY,0)-NVL(RRC_ACC_REL_MO_CONV,0)-NVL(RRC_ACC_REL_MT_CONV,0)) AS CUNSSR_CS_RRC_NOM
		,SUM(NVL(moc_conv_call_atts,0)+NVL(mtc_conv_call_atts,0)+NVL(emergency_call_atts,0)-NVL(RRC_ATT_REP_MO_CONV,0)-NVL(RRC_ATT_REP_MT_CONV,0)-NVL(RRC_ATT_REP_EMERGENCY,0)-NVL(RRC_ACC_REL_EMERGENCY,0)-NVL(RRC_ACC_REL_MO_CONV,0)-NVL(RRC_ACC_REL_MT_CONV,0)-NVL(RRC_CONN_STP_REJ_EMERG_CALL,0)) AS CUNSSR_CS_RRC_DENOM
		,SUM(NVL(rab_acc_comp_cs_voice,0)+NVL(rab_acc_comp_cs_conv,0)+NVL(rab_acc_comp_cs_strea,0)) AS CUNSSR_CS_RAB_NOM
		,SUM(NVL(rab_stp_att_cs_voice,0)+NVL(rab_stp_att_cs_conv,0)+NVL(rab_stp_att_cs_strea,0)) AS CUNSSR_CS_RAB_DENOM

		--PS_DATA_VOL_MB_3G
		,SUM(NVL(RT_PS_DCH_DL_DATA_VOL,0)+NVL(NRT_DCH_DL_DATA_VOL,0)+NVL(RT_PS_DCH_UL_DATA_VOL,0)+NVL(NRT_DCH_UL_DATA_VOL,0)+
	         NVL(NRT_DCH_HSDPA_UL_DATA_VOL,0)+NVL(HS_DSCH_DATA_VOL,0)+NVL(NRT_EDCH_UL_DATA_VOL,0))/1000000 AS PS_DATA_VOL_MB_3G

	    -- Voice Traffic
	    ,SUM((NVL(AVG_RAB_HLD_TM_CS_VOICE,0)*10)/1000)/3600 AS TRAFFIC_AMR

	FROM  NOKRWW_PS_CELLRES_WCEL_DAY@na19 c1

	LEFT JOIN NOKRWW_PS_SERVLEV_WCEL_DAY@na19 c2 ON c1.period_start_time=c2.period_start_time and c1.rnc_id=c2.rnc_id and c1.wcel_id=c2.wcel_id
	LEFT JOIN NOKRWW_PS_HSDPAW_WCEL_DAY@na19 c3 ON c1.period_start_time=c3.period_start_time and c1.rnc_id=c3.rnc_id and c1.wcel_id=c3.wcel_id
	LEFT JOIN NOKRWW_PS_RRC_WCEL_DAY@na19 c4 ON c1.period_start_time=c4.period_start_time and c1.rnc_id=c4.rnc_id and c1.wcel_id=c4.wcel_id
	LEFT JOIN NOKRWW_PS_CELTPW_WCEL_DAY@na19 c5 ON c1.period_start_time=c5.period_start_time and c1.rnc_id=c5.rnc_id and c1.wcel_id=c5.wcel_id
	LEFT JOIN NOKRWW_PS_INTERSHO_WCEL_DAY@na19 c6 ON c1.period_start_time=c6.period_start_time and c1.rnc_id=c6.rnc_id and c1.wcel_id=c6.wcel_id
	LEFT JOIN NOKRWW_PS_PKTCALL_WCEL_DAY@na19 c7 ON c1.period_start_time=c7.period_start_time and c1.rnc_id=c7.rnc_id and c1.wcel_id=c7.wcel_id
	LEFT JOIN NOKRWW_PS_CELLTP_WCEL_DAY@na19 c8 ON c1.period_start_time=c8.period_start_time and c1.rnc_id=c8.rnc_id and c1.wcel_id=c8.wcel_id
	LEFT JOIN NOKRWW_PS_SOFTHO_WCEL_DAY@na19 c9 ON c1.period_start_time=c9.period_start_time and c1.rnc_id=c9.rnc_id and c1.wcel_id=c9.wcel_id
	LEFT JOIN NOKRWW_PS_CPICHQ_WCEL_DAY@na19 c10 ON c1.period_start_time=c10.period_start_time and c1.rnc_id=c10.rnc_id and c1.wcel_id=c10.wcel_id
	LEFT JOIN NOKRWW_PS_INTSYSHO_WCEL_DAY@na19 c11 ON c1.period_start_time=c11.period_start_time and c1.rnc_id=c11.rnc_id and c1.wcel_id=c11.wcel_id
	WHERE c1.period_start_time =to_date('13.11.2021','dd.mm.yyyy')
--	c1.period_start_time >=to_date('06.10.2021','dd.mm.yyyy')
--	AND c1.period_start_time <to_date('10.10.2021','dd.mm.yyyy')
	group by
	    to_char(trunc(c1.period_start_time, 'dd'), 'dd/mm/yyyy')
	    ,c1.rnc_id
	    ,c1.wbts_id
		,c1.wcel_id
	UNION ALL
	select
		to_char(trunc(c1.period_start_time, 'dd'), 'dd/mm/yyyy') period_start_time
		,c1.rnc_id
		,c1.wbts_id
		,c1.wcel_id

	    --Average HS-DSCH User Throughput (HSDPA)
	    ,SUM(NVL(HSDPA_ORIG_DATA,0)*8*500) HSDPA_AVG_THR_NOM
	    ,SUM(NVL(HSDPA_BUFF_WITH_DATA_PER_TTI,0)) HSDPA_AVG_THR_DENOM

	    --Cell Availability
	    ,SUM(NVL(AVAIL_WCELL_IN_WO_STATE,0)) AS AVAILABILITY_NOM
		,SUM(NVL(AVAIL_WCELL_EXISTS_IN_RNW_DB,0)) AS AVAILABILITY_DENOM

	    --RAB Drop Rate, NRT services
		,SUM(NVL(PS_REL_RL_FAIL_hs_e_int,0)+NVL(PS_REL_RL_FAIL_hs_e_bgr,0)+NVL(PS_REL_RL_FAIL_hs_d_int,0)+NVL(PS_REL_RL_FAIL_hs_d_bgr,0)+
	         NVL(PS_REL_RL_FAIL_d_d_int,0)+NVL(PS_REL_RL_FAIL_d_d_bgr,0)+NVL(PS_REL_OTH_FAIL_hs_e_int,0)+NVL(PS_REL_OTH_FAIL_hs_e_bgr,0)+
	         NVL(PS_REL_OTH_FAIL_hs_d_int,0)+NVL(PS_REL_OTH_FAIL_hs_d_bgr,0)+NVL(PS_REL_OTH_FAIL_d_d_int,0)+NVL(PS_REL_OTH_FAIL_d_d_bgr,0)+
	         NVL(PS_REL_RL_FAIL_hs_e_stre,0)+NVL(PS_REL_RL_FAIL_hs_d_stre,0)+NVL(PS_REL_RL_FAIL_d_d_stre,0)+NVL(PS_REL_OTH_FAIL_hs_e_stre,0)+
	         NVL(PS_REL_OTH_FAIL_hs_d_stre,0)+NVL(PS_REL_OTH_FAIL_d_d_stre,0)) RAB_DR_PS_NOM
	    ,SUM(NVL(PS_REL_RL_FAIL_hs_e_int,0)+NVL(PS_REL_RL_FAIL_hs_e_bgr,0)+NVL(PS_REL_RL_FAIL_hs_d_int,0)+NVL(PS_REL_RL_FAIL_hs_d_bgr,0)+
	         NVL(PS_REL_RL_FAIL_d_d_int,0)+NVL(PS_REL_RL_FAIL_d_d_bgr,0)+NVL(PS_REL_OTH_FAIL_hs_e_int,0)+NVL(PS_REL_OTH_FAIL_hs_e_bgr,0)+
	         NVL(PS_REL_OTH_FAIL_hs_d_int,0)+NVL(PS_REL_OTH_FAIL_hs_d_bgr,0)+NVL(PS_REL_OTH_FAIL_d_d_int,0)+NVL(PS_REL_OTH_FAIL_d_d_bgr,0)+
	         NVL(ps_rel_norm_hs_e_int,0)+NVL(ps_rel_norm_hs_e_bgr,0)+NVL(ps_rel_norm_hs_d_int,0)+NVL(ps_rel_norm_hs_d_bgr,0)+
	         NVL(ps_rel_norm_d_d_int,0)+NVL(ps_rel_norm_d_d_bgr,0)+NVL(PS_REL_RL_FAIL_hs_e_stre,0)+NVL(PS_REL_RL_FAIL_hs_d_stre,0)+
	         NVL(PS_REL_RL_FAIL_d_d_stre,0)+NVL(PS_REL_OTH_FAIL_hs_e_stre,0)+NVL(PS_REL_OTH_FAIL_hs_d_stre,0)+NVL(PS_REL_OTH_FAIL_d_d_stre,0)+
	         NVL(ps_rel_norm_hs_e_stre,0)+NVL(ps_rel_norm_hs_d_stre,0)+NVL(ps_rel_norm_d_d_stre,0)+NVL(denom_st_trans_time_fach_pch,0)) RAB_DR_PS_DENOM

		-- U_CUNSSR_PS
	    ,SUM(NVL(moc_inter_call_atts,0)-NVL(moc_inter_call_fails,0)+NVL(moc_backg_call_atts,0)-NVL(moc_backg_call_fails,0)+NVL(moc_strea_call_atts,0)-NVL(moc_strea_call_fails,0)+NVL(mtc_inter_call_atts,0)-NVL(mtc_inter_call_fails,0)+NVL(mtc_backg_call_atts,0)-NVL(mtc_backg_call_fails,0)+NVL(mtc_strea_call_atts,0)-NVL(mtc_strea_call_fails,0)+NVL(moc_subsc_traf_call_atts,0)-NVL(moc_subsc_traf_call_fails,0)-NVL(RRC_ACC_REL_MO_STREAMING,0)-NVL(RRC_ACC_REL_MO_INTERACTIVE,0)-NVL(RRC_ACC_REL_MO_BACKGROUND,0)-NVL(RRC_ACC_REL_MO_SUBSCRIBED,0)-NVL(RRC_ACC_REL_MT_STREAMING,0)-NVL(RRC_ACC_REL_INTERACTIVE,0)-NVL(RRC_ACC_REL_MT_BACKGROUND,0)) AS U_CUNSSR_PS_RRC_NOM
		,SUM(NVL(moc_inter_call_atts,0)+NVL(moc_backg_call_atts,0)+NVL(moc_strea_call_atts,0)+NVL(moc_subsc_traf_call_atts,0)+NVL(mtc_inter_call_atts,0)+NVL(mtc_backg_call_atts,0)+NVL(mtc_strea_call_atts,0)-NVL(RRC_ATT_REP_MO_INTERACTIVE,0)-NVL(RRC_ATT_REP_MO_BACKGROUND,0)-NVL(RRC_ATT_REP_MO_STREAMING,0)-NVL(RRC_ATT_REP_MO_SUBSCRIBED,0)-NVL(RRC_ATT_REP_INTERACTIVE,0)-NVL(RRC_ATT_REP_MT_BACKGROUND,0)-NVL(RRC_ATT_REP_MT_STREAMING,0)-NVL(RRC_ACC_REL_MO_INTERACTIVE,0)-NVL(RRC_ACC_REL_MO_BACKGROUND,0)-NVL(RRC_ACC_REL_MO_STREAMING,0)-NVL(RRC_ACC_REL_MO_SUBSCRIBED,0)-NVL(RRC_ACC_REL_INTERACTIVE,0)-NVL(RRC_ACC_REL_MT_BACKGROUND,0)-NVL(RRC_ACC_REL_MT_STREAMING,0)) AS U_CUNSSR_PS_RRC_DENOM
		,SUM(NVL(rab_acc_comp_ps_inter,0)+NVL(rab_acc_comp_ps_backg,0)+NVL(rab_acc_comp_ps_strea,0)+NVL(HS_E_REQ_HS_E_ALLO_INT,0)+NVL(HS_E_REQ_HS_E_ALLO_BGR,0)+NVL(HS_E_REQ_HS_E_ALLO_STRE,0)+NVL(HS_E_REQ_HS_D_ALLO_INT,0)+NVL(HS_E_REQ_HS_D_ALLO_BGR,0)+NVL(HS_E_REQ_HS_D_ALLO_STRE,0)+NVL(HS_E_REQ_D_D_ALLO_INT,0)+NVL(HS_E_REQ_D_D_ALLO_BGR,0)+NVL(HS_E_REQ_D_D_ALLO_STRE,0)+NVL(HS_D_REQ_HS_D_ALLO_INT,0)+NVL(HS_D_REQ_HS_D_ALLO_BGR,0)+NVL(HS_D_REQ_HS_D_ALLO_STRE,0)+NVL(HS_D_REQ_D_D_ALLO_INT,0)+NVL(HS_D_REQ_D_D_ALLO_BGR,0)+NVL(HS_D_REQ_D_D_ALLO_STRE,0)+NVL(D_D_REQ_D_D_ALLO_INT,0)+NVL(D_D_REQ_D_D_ALLO_BGR,0)+NVL(D_D_REQ_D_D_ALLO_STRE,0)+NVL(DENOM_ST_TRANS_TIME_PCH_FACH,0)) AS U_CUNSSR_PS_RAB_NOM
		,SUM(NVL(rab_stp_att_ps_inter,0)+NVL(RAB_STP_ATT_PS_BACKG,0)+NVL(RAB_STP_ATT_PS_STREA,0)+NVL(PS_ATT_HSDSCH_EDCH_INT,0)+NVL(PS_ATT_HSDSCH_EDCH_BGR,0)+NVL(PS_ATT_HSDSCH_EDCH_STRE,0)+NVL(PS_ATT_HSDSCH_DCH_INT,0)+NVL(PS_ATT_HSDSCH_DCH_BGR,0)+NVL(PS_ATT_HSDSCH_DCH_STRE,0)+NVL(PS_ATT_DCH_DCH_INT,0)+NVL(PS_ATT_DCH_DCH_BGR,0)+NVL(PS_ATT_DCH_DCH_STRE,0)+NVL(ATT_PCH_TO_FACH,0)) AS U_CUNSSR_PS_RAB_DENOM

		-- Average HSUPA User Throughput
	    ,SUM(NVL(EDCH_DATA_SCELL_UL,0)*8) AS HSUPA_AVG_THR_NOM
		,SUM(NVL(MACE_PDUS_2MS_TTI,0)*0.002 + NVL(MACE_PDUS_10MS_TTI,0)*0.01) AS HSUPA_AVG_THR_DENOM

		-- Inter frequency HO Success Rate RT - IFHO_CS_SR
		,SUM(NVL(succ_if_hho_cpich_ecno_rt,0) +NVL(succ_if_hho_cpich_rscp_rt,0) +NVL(succ_is_hho_dl_dpch_pwr_rt,0) +NVL(succ_is_hho_ue_trx_pwr_rt,0) +NVL(succ_is_hho_ul_dch_q_rt,0))  AS IFHO_CS_SR_NOM
		,SUM(NVL(if_hho_att_cpich_ecno_rt,0) +NVL(if_hho_att_cpich_rscp_rt,0) +NVL(is_hho_att_dpch_pwr_rt,0) +NVL(is_hho_att_ue_trx_pwr_rt,0) +NVL(is_hho_att_ul_dch_q_rt,0))  AS IFHO_CS_SR_DENOM

		-- Inter System Hard Handover Success Ratio RT - IRATHO_CS_SR
		,SUM(NVL(succ_is_hho_ul_dch_q_rt ,0) + NVL(succ_is_hho_ue_trx_pwr_rt ,0) + NVL(succ_is_hho_dl_dpch_pwr_rt ,0) + NVL(succ_is_hho_cpich_rscp_rt ,0) + NVL(succ_is_hho_cpich_ecno_rt ,0) + NVL(succ_is_hho_im_ims_rt ,0) + NVL(succ_isho_cell_shutdown_rt ,0) + NVL(succ_isho_cell_block_rt ,0) + NVL(succ_is_hho_dr_amr_rt ,0) + NVL(succ_is_hho_emerg_call,0)) AS IRATHO_CS_SR_NOM
		,SUM(NVL(is_hho_att_ul_dch_q_rt ,0) + NVL(is_hho_att_ue_trx_pwr_rt ,0) + NVL(is_hho_att_dpch_pwr_rt ,0) + NVL(is_hho_att_cpich_rscp_rt ,0) + NVL(is_hho_att_cpich_ecno_rt ,0) + NVL(is_hho_att_im_ims_rt ,0) + NVL(att_isho_cell_shutdown_rt ,0) + NVL(att_isho_cell_block_rt ,0) + NVL(is_hho_att_dr_amr_rt,0)) AS IRATHO_CS_SR_DENOM

		-- IRATHO_PS_SR
		,SUM(NVL(INTER_RAT_HO_UTRAN,0) - NVL(INTER_RAT_HO_UTRAN_FAIL, 0)) AS IRATHO_PS_SR_NOM
		,SUM(NVL(INTER_RAT_HO_UTRAN,0)) AS IRATHO_PS_SR_DENOM

		-- IFHO_PS_SR
		,SUM(NVL(succ_if_hho_cpich_ecno_nrt,0) +NVL(succ_if_hho_cpich_rscp_nrt,0) +NVL(succ_is_hho_dl_dpch_pwr_nrt,0) +NVL(succ_is_hho_ue_trx_pwr_nrt,0) +NVL(succ_is_hho_ul_dch_q_nrt, 0)) AS IFHO_PS_SR_NOM
		,SUM(NVL(if_hho_att_cpich_ecno_nrt,0) +NVL(if_hho_att_cpich_rscp_nrt,0) +NVL(is_hho_att_dl_dpch_pwr_nrt,0) +NVL(is_hho_att_ue_trx_pwr_nrt,0) +NVL(is_hho_att_ul_dch_q_nrt, 0)) AS IFHO_PS_SR_DENOM

		-- % of RSCP < -105 dBm
		,SUM(NVL(RRC_CPICH_RSCP_CLASS_0 ,0) + NVL(RRC_CPICH_RSCP_CLASS_1 ,0) + NVL(RRC_CPICH_RSCP_CLASS_2 ,0) + NVL(RRC_CPICH_RSCP_CLASS_3,0) )  AS RSCP_BELOW_105_NOM
		,SUM(NVL(RRC_CPICH_RSCP_CLASS_0 ,0) + NVL(RRC_CPICH_RSCP_CLASS_1 ,0) + NVL(RRC_CPICH_RSCP_CLASS_2 ,0) + NVL(RRC_CPICH_RSCP_CLASS_3 ,0) + NVL(RRC_CPICH_RSCP_CLASS_4 ,0) +
		NVL(RRC_CPICH_RSCP_CLASS_5 ,0) + NVL(RRC_CPICH_RSCP_CLASS_6 ,0) + NVL(RRC_CPICH_RSCP_CLASS_7 ,0) + NVL(RRC_CPICH_RSCP_CLASS_8 ,0) + NVL(RRC_CPICH_RSCP_CLASS_9 ,0) +
		NVL(RRC_CPICH_RSCP_CLASS_10 ,0) + NVL(RRC_CPICH_RSCP_CLASS_11 ,0) + NVL(RRC_CPICH_RSCP_CLASS_12 ,0) + NVL(RRC_CPICH_RSCP_CLASS_13 ,0) + NVL(RRC_CPICH_RSCP_CLASS_14 ,0) +
		NVL(RRC_CPICH_RSCP_CLASS_15 ,0) + NVL(RRC_CPICH_RSCP_CLASS_16,0)) AS RSCP_BELOW_105_DENOM


		-- Avg CQI 3G
		,SUM(1*NVL(cqi_dist_cl_1 ,0) + 2*NVL(cqi_dist_cl_2 ,0) + 3*NVL(cqi_dist_cl_3 ,0) + 4*NVL(cqi_dist_cl_4 ,0) + 5*NVL(cqi_dist_cl_5 ,0) + 6*NVL(cqi_dist_cl_6 ,0) + 7*NVL(cqi_dist_cl_7 ,0) + 8*NVL(cqi_dist_cl_8 ,0) + 9*NVL(cqi_dist_cl_9 ,0) + 10*NVL(cqi_dist_cl_10 ,0) + 11*NVL(cqi_dist_cl_11 ,0) + 12*NVL(cqi_dist_cl_12 ,0) + 13*NVL(cqi_dist_cl_13 ,0) + 14*NVL(cqi_dist_cl_14 ,0) + 15*NVL(cqi_dist_cl_15 ,0) + 16*NVL(cqi_dist_cl_16 ,0) + 17*NVL(cqi_dist_cl_17 ,0) + 18*NVL(cqi_dist_cl_18 ,0) + 19*NVL(cqi_dist_cl_19 ,0) + 20*NVL(cqi_dist_cl_20 ,0) + 21*NVL(cqi_dist_cl_21 ,0) + 22*NVL(cqi_dist_cl_22 ,0) + 23*NVL(cqi_dist_cl_23 ,0) + 24*NVL(cqi_dist_cl_24 ,0) + 25*NVL(cqi_dist_cl_25 ,0) + 26*NVL(cqi_dist_cl_26 ,0) + 27*NVL(cqi_dist_cl_27 ,0) + 28*NVL(cqi_dist_cl_28 ,0) + 29*NVL(cqi_dist_cl_29 ,0) + 30*NVL(cqi_dist_cl_30,0)) AS AVG_CQI_NOM
		,SUM(NVL(cqi_dist_cl_0 ,0) + NVL(cqi_dist_cl_1 ,0) + NVL(cqi_dist_cl_2 ,0) + NVL(cqi_dist_cl_3 ,0) + NVL(cqi_dist_cl_4 ,0) + NVL(cqi_dist_cl_5 ,0) + NVL(cqi_dist_cl_6 ,0) + NVL(cqi_dist_cl_7 ,0) + NVL(cqi_dist_cl_8 ,0) + NVL(cqi_dist_cl_9 ,0) + NVL(cqi_dist_cl_10 ,0) + NVL(cqi_dist_cl_11 ,0) + NVL(cqi_dist_cl_12 ,0) + NVL(cqi_dist_cl_13 ,0) + NVL(cqi_dist_cl_14 ,0) + NVL(cqi_dist_cl_15 ,0) + NVL(cqi_dist_cl_16 ,0) + NVL(cqi_dist_cl_17 ,0) + NVL(cqi_dist_cl_18 ,0) + NVL(cqi_dist_cl_19 ,0) + NVL(cqi_dist_cl_20 ,0) + NVL(cqi_dist_cl_21 ,0) + NVL(cqi_dist_cl_22 ,0) + NVL(cqi_dist_cl_23 ,0) + NVL(cqi_dist_cl_24 ,0) + NVL(cqi_dist_cl_25 ,0) + NVL(cqi_dist_cl_26 ,0) + NVL(cqi_dist_cl_27 ,0) + NVL(cqi_dist_cl_28 ,0) + NVL(cqi_dist_cl_29 ,0) + NVL(cqi_dist_cl_30,0)) AS AVG_CQI_DENOM

		--Number of RRC connected users
		,SUM(NVL(NUM_UE_MEAS_CELL_DCH,0) + NVL(NUM_UE_MEAS_CELL_FACH,0) + NVL(NUM_UE_MEAS_CELL_PCH,0)) AS NUMBER_OF_RRC_CONNECTED_USERS

		-- CDR CS
		,SUM(NVL(RAB_ACT_REL_CS_VOICE_P_EMP,0)+NVL(RAB_ACT_FAIL_CS_VOICE_IU,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RADIO,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_BTS,0)+NVL(RAB_ACT_FAIL_CS_VOICE_IUR,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RNC,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_UE,0)+NVL(RAB_ACT_FAIL_CS_VOICE_TRANS,0)+ NVL(RAB_ACT_REL_CS_CONV_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IU,0)+NVL(RAB_ACT_FAIL_CS_CONV_RADIO,0)+NVL(RAB_ACT_FAIL_CS_CONV_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IUR,0)+NVL(RAB_ACT_FAIL_CS_CONV_RNC,0)+NVL(RAB_ACT_FAIL_CS_CONV_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_TRANS,0)+NVL(RAB_ACT_REL_CS_STREA_P_EMP,0)+NVL(RAB_ACT_FAIL_CS_STREA_IU,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_RADIO,0)+NVL(RAB_ACT_FAIL_CS_STREA_BTS,0)+NVL(RAB_ACT_FAIL_CS_STREA_IUR,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_RNC,0)+NVL(RAB_ACT_FAIL_CS_STREA_UE,0)+NVL(RAB_ACT_FAIL_CS_STREA_TRANS,0)) AS  CDR_CS_NOM
	    ,SUM(NVL(RAB_ACT_COMP_CS_VOICE,0)+NVL(RAB_ACT_REL_CS_VOICE_SRNC,0)+NVL(RAB_ACT_REL_CS_VOICE_HHO,0)+
	         NVL(RAB_ACT_REL_CS_VOICE_ISHO,0)+NVL(RAB_ACT_REL_CS_VOICE_GANHO,0)+NVL(RAB_ACT_REL_CS_VOICE_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_IU,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RADIO,0)+NVL(RAB_ACT_FAIL_CS_VOICE_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_IUR,0)+NVL(RAB_ACT_FAIL_CS_VOICE_RNC,0)+NVL(RAB_ACT_FAIL_CS_VOICE_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_VOICE_TRANS,0)+NVL(RAB_ACT_COMP_CS_CONV,0)+NVL(RAB_ACT_REL_CS_CONV_SRNC,0)+
	         NVL(RAB_ACT_REL_CS_CONV_HHO,0)+NVL(RAB_ACT_REL_CS_CONV_ISHO,0)+NVL(RAB_ACT_REL_CS_CONV_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IU,0)+NVL(RAB_ACT_FAIL_CS_CONV_RADIO,0)+NVL(RAB_ACT_FAIL_CS_CONV_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_IUR,0)+NVL(RAB_ACT_FAIL_CS_CONV_RNC,0)+NVL(RAB_ACT_FAIL_CS_CONV_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_CONV_TRANS,0)+NVL(RAB_ACT_COMP_CS_STREA,0)+NVL(RAB_ACT_REL_CS_STREA_SRNC,0)+
	         NVL(RAB_ACT_REL_CS_STREA_HHO,0)+NVL(RAB_ACT_REL_CS_STREA_ISHO,0)+NVL(RAB_ACT_REL_CS_STREA_P_EMP,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_IU,0)+NVL(RAB_ACT_FAIL_CS_STREA_RADIO,0)+NVL(RAB_ACT_FAIL_CS_STREA_BTS,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_IUR,0)+NVL(RAB_ACT_FAIL_CS_STREA_RNC,0)+NVL(RAB_ACT_FAIL_CS_STREA_UE,0)+
	         NVL(RAB_ACT_FAIL_CS_STREA_TRANS,0)) AS CDR_CS_DENOM

	    -- U_CUNSSR_CS
		,SUM(NVL(moc_conv_call_atts,0)-NVL(moc_conv_call_fails,0)+NVL(mtc_conv_call_atts,0)-NVL(mtc_conv_call_fails,0)+NVL(emergency_call_atts,0)-NVL(emergency_call_fails,0)-NVL(RRC_ACC_REL_EMERGENCY,0)-NVL(RRC_ACC_REL_MO_CONV,0)-NVL(RRC_ACC_REL_MT_CONV,0)) AS CUNSSR_CS_RRC_NOM
		,SUM(NVL(moc_conv_call_atts,0)+NVL(mtc_conv_call_atts,0)+NVL(emergency_call_atts,0)-NVL(RRC_ATT_REP_MO_CONV,0)-NVL(RRC_ATT_REP_MT_CONV,0)-NVL(RRC_ATT_REP_EMERGENCY,0)-NVL(RRC_ACC_REL_EMERGENCY,0)-NVL(RRC_ACC_REL_MO_CONV,0)-NVL(RRC_ACC_REL_MT_CONV,0)-NVL(RRC_CONN_STP_REJ_EMERG_CALL,0)) AS CUNSSR_CS_RRC_DENOM
		,SUM(NVL(rab_acc_comp_cs_voice,0)+NVL(rab_acc_comp_cs_conv,0)+NVL(rab_acc_comp_cs_strea,0)) AS CUNSSR_CS_RAB_NOM
		,SUM(NVL(rab_stp_att_cs_voice,0)+NVL(rab_stp_att_cs_conv,0)+NVL(rab_stp_att_cs_strea,0)) AS CUNSSR_CS_RAB_DENOM

		--PS_DATA_VOL_MB_3G
		,SUM(NVL(RT_PS_DCH_DL_DATA_VOL,0)+NVL(NRT_DCH_DL_DATA_VOL,0)+NVL(RT_PS_DCH_UL_DATA_VOL,0)+NVL(NRT_DCH_UL_DATA_VOL,0)+
	         NVL(NRT_DCH_HSDPA_UL_DATA_VOL,0)+NVL(HS_DSCH_DATA_VOL,0)+NVL(NRT_EDCH_UL_DATA_VOL,0))/1000000 AS PS_DATA_VOL_MB_3G

	    -- Voice Traffic
	    ,SUM((NVL(AVG_RAB_HLD_TM_CS_VOICE,0)*10)/1000)/3600 AS TRAFFIC_AMR

	FROM  NOKRWW_PS_CELLRES_WCEL_DAY@na18 c1

	LEFT JOIN NOKRWW_PS_SERVLEV_WCEL_DAY@na18 c2 ON c1.period_start_time=c2.period_start_time and c1.rnc_id=c2.rnc_id and c1.wcel_id=c2.wcel_id
	LEFT JOIN NOKRWW_PS_HSDPAW_WCEL_DAY@na18 c3 ON c1.period_start_time=c3.period_start_time and c1.rnc_id=c3.rnc_id and c1.wcel_id=c3.wcel_id
	LEFT JOIN NOKRWW_PS_RRC_WCEL_DAY@na18 c4 ON c1.period_start_time=c4.period_start_time and c1.rnc_id=c4.rnc_id and c1.wcel_id=c4.wcel_id
	LEFT JOIN NOKRWW_PS_CELTPW_WCEL_DAY@na18 c5 ON c1.period_start_time=c5.period_start_time and c1.rnc_id=c5.rnc_id and c1.wcel_id=c5.wcel_id
	LEFT JOIN NOKRWW_PS_INTERSHO_WCEL_DAY@na18 c6 ON c1.period_start_time=c6.period_start_time and c1.rnc_id=c6.rnc_id and c1.wcel_id=c6.wcel_id
	LEFT JOIN NOKRWW_PS_PKTCALL_WCEL_DAY@na18 c7 ON c1.period_start_time=c7.period_start_time and c1.rnc_id=c7.rnc_id and c1.wcel_id=c7.wcel_id
	LEFT JOIN NOKRWW_PS_CELLTP_WCEL_DAY@na18 c8 ON c1.period_start_time=c8.period_start_time and c1.rnc_id=c8.rnc_id and c1.wcel_id=c8.wcel_id
	LEFT JOIN NOKRWW_PS_SOFTHO_WCEL_DAY@na18 c9 ON c1.period_start_time=c9.period_start_time and c1.rnc_id=c9.rnc_id and c1.wcel_id=c9.wcel_id
	LEFT JOIN NOKRWW_PS_CPICHQ_WCEL_DAY@na18 c10 ON c1.period_start_time=c10.period_start_time and c1.rnc_id=c10.rnc_id and c1.wcel_id=c10.wcel_id
	LEFT JOIN NOKRWW_PS_INTSYSHO_WCEL_DAY@na18 c11 ON c1.period_start_time=c11.period_start_time and c1.rnc_id=c11.rnc_id and c1.wcel_id=c11.wcel_id
	WHERE c1.period_start_time =to_date('13.11.2021','dd.mm.yyyy')
--	c1.period_start_time >=to_date('06.10.2021','dd.mm.yyyy')
--	AND c1.period_start_time <to_date('10.10.2021','dd.mm.yyyy')
	group by
	    to_char(trunc(c1.period_start_time, 'dd'), 'dd/mm/yyyy')
	    ,c1.rnc_id
	    ,c1.wbts_id
		,c1.wcel_id;
	COMMIT;

 	INSERT INTO MIP.T_CELL_DY_3G_NSN_NA@mip
	SELECT  PERIOD_START_TIME,RNC_ID,WBTS_ID,WCEL_ID,co.co_dn, co.co_name, co.co_object_instance,HSDPA_AVG_THR_NOM,HSDPA_AVG_THR_DENOM,AVAILABILITY_NOM,AVAILABILITY_DENOM,RAB_DR_PS_NOM,RAB_DR_PS_DENOM,U_CUNSSR_PS_RRC_NOM,U_CUNSSR_PS_RRC_DENOM,U_CUNSSR_PS_RAB_NOM,U_CUNSSR_PS_RAB_DENOM,HSUPA_AVG_THR_NOM,HSUPA_AVG_THR_DENOM,IFHO_CS_SR_NOM,IFHO_CS_SR_DENOM,IRATHO_CS_SR_NOM,IRATHO_CS_SR_DENOM,IRATHO_PS_SR_NOM,IRATHO_PS_SR_DENOM,IFHO_PS_SR_NOM,IFHO_PS_SR_DENOM,RSCP_BELOW_105_NOM,RSCP_BELOW_105_DENOM,AVG_CQI_NOM,AVG_CQI_DENOM,NUMBER_OF_RRC_CONNECTED_USERS,CDR_CS_NOM,CDR_CS_DENOM,CUNSSR_CS_RRC_NOM,CUNSSR_CS_RRC_DENOM,CUNSSR_CS_RAB_NOM,CUNSSR_CS_RAB_DENOM,PS_DATA_VOL_MB_3G,TRAFFIC_AMR FROM SERGEY_USTIMENKOV.T_CELL_DY_3G_NSN_SIP_NA c1
	LEFT JOIN ctp_common_objects@na19 co
	ON wcel_id = co_gid
	WHERE co_oc_id = 675
    UNION ALL
    SELECT  PERIOD_START_TIME,RNC_ID,WBTS_ID,WCEL_ID,co.co_dn, co.co_name, co.co_object_instance,HSDPA_AVG_THR_NOM,HSDPA_AVG_THR_DENOM,AVAILABILITY_NOM,AVAILABILITY_DENOM,RAB_DR_PS_NOM,RAB_DR_PS_DENOM,U_CUNSSR_PS_RRC_NOM,U_CUNSSR_PS_RRC_DENOM,U_CUNSSR_PS_RAB_NOM,U_CUNSSR_PS_RAB_DENOM,HSUPA_AVG_THR_NOM,HSUPA_AVG_THR_DENOM,IFHO_CS_SR_NOM,IFHO_CS_SR_DENOM,IRATHO_CS_SR_NOM,IRATHO_CS_SR_DENOM,IRATHO_PS_SR_NOM,IRATHO_PS_SR_DENOM,IFHO_PS_SR_NOM,IFHO_PS_SR_DENOM,RSCP_BELOW_105_NOM,RSCP_BELOW_105_DENOM,AVG_CQI_NOM,AVG_CQI_DENOM,NUMBER_OF_RRC_CONNECTED_USERS,CDR_CS_NOM,CDR_CS_DENOM,CUNSSR_CS_RRC_NOM,CUNSSR_CS_RRC_DENOM,CUNSSR_CS_RAB_NOM,CUNSSR_CS_RAB_DENOM,PS_DATA_VOL_MB_3G,TRAFFIC_AMR FROM SERGEY_USTIMENKOV.T_CELL_DY_3G_NSN_SIP_NA c1
	LEFT JOIN ctp_common_objects@na18 co
	ON wcel_id = co_gid  ;

	COMMIT;
END;
