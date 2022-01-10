BEGIN
--   Execute immediate ('truncate table T_CELL_DY_4G_NSN_SIP_NA reuse storage');
  INSERT INTO SERGEY_USTIMENKOV.T_CELL_DY_4G_NSN_SIP_NA

SELECT
	--,to_char(LISHO.PERIOD_START_TIME,'dd.mm.yyyy HH24:mi:ss')
	to_char(LCELAV.PERIOD_START_TIME,'dd.mm.yyyy') PERIOD_START_TIME
	/*,case when LNCEL.LNCEL_EARFCN_DL is Null then 7
	      when LNCEL.LNCEL_EARFCN_DL >3000 then 7
	      when LNCEL.LNCEL_EARFCN_DL <3000 then 3 end "Band"*/
	, substr(LNCEL.LNCEL_TAC, length(LNCEL.LNCEL_TAC)-1) "Region"
	,ctp_lnbts.co_object_instance LNBTS_ID
	,ctp.co_dn LNCEL_DN
	--,LNCEL.LNCEL_TAC
	--,substr(LNCEL.LNCEL_TAC, LENGTH(LNCEL.LNCEL_TAC)-1)
	,ctp.co_object_instance LNCELID
    ,LNCEL.LNCEL_CELL_NAME
    ,LNCEL.LNCEL_EUTRA_Cel_id

	/*,case when ctp.co_object_instance in (4,5,6) then 'L2600'
	      when ctp.co_object_instance in (7,8,9) then 'L1800'
	      when t.lncel_id in (201,202,203,24,25,26,231,232,233) then '2600TDD'
	      when t.lncel_id in (101,102,103) then 'L2100' else 'UNKNOWN' end BAND*/


	,SUM(NVL(LCELLT.IP_TPUT_VOL_DL_QCI_1,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_2,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_3,0)+
	NVL(LCELLT.IP_TPUT_VOL_DL_QCI_4,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_5,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_6,0)+
	NVL(LCELLT.IP_TPUT_VOL_DL_QCI_7,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_8,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_9,0)) AS DL_AVG_THR_NOM
	,SUM(NVL(LCELLT.IP_TPUT_TIME_DL_QCI_1,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_2,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_3,0)+
	NVL(LCELLT.IP_TPUT_TIME_DL_QCI_4,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_5,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_6,0)+
	NVL(LCELLT.IP_TPUT_TIME_DL_QCI_7,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_8,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_9,0)) AS DL_AVG_THR_DENOM

	,0 AS CQI_0_9_NOM
	,0 AS CQI_0_9_DENOM

	,SUM(1*(NVL(LPQDL.ue_rep_cqi_level_01,0)) + 2*(NVL(LPQDL.ue_rep_cqi_level_02,0)) + 3*(NVL(LPQDL.ue_rep_cqi_level_03,0)) +
	4*(NVL(LPQDL.ue_rep_cqi_level_04,0)) + 5*(NVL(LPQDL.ue_rep_cqi_level_05,0)) + 6*(NVL(LPQDL.ue_rep_cqi_level_06,0)) +
	7*(NVL(LPQDL.ue_rep_cqi_level_07,0)) + 8*(NVL(LPQDL.ue_rep_cqi_level_08,0)) + 9*(NVL(LPQDL.ue_rep_cqi_level_09,0)) +
	10*(NVL(LPQDL.ue_rep_cqi_level_10,0)) + 11*(NVL(LPQDL.ue_rep_cqi_level_11,0)) + 12*(NVL(LPQDL.ue_rep_cqi_level_12,0)) +
	13*(NVL(LPQDL.ue_rep_cqi_level_13,0)) + 14*(NVL(LPQDL.ue_rep_cqi_level_14,0)) + 15*(NVL(LPQDL.ue_rep_cqi_level_15,0))) AS CQI_AVG_NOM
	,SUM(NVL(LPQDL.ue_rep_cqi_level_00,0) + NVL(LPQDL.ue_rep_cqi_level_01,0) + NVL(LPQDL.ue_rep_cqi_level_02,0) + NVL(LPQDL.ue_rep_cqi_level_03,0) +
	NVL(LPQDL.ue_rep_cqi_level_04,0) + NVL(LPQDL.ue_rep_cqi_level_05,0) + NVL(LPQDL.ue_rep_cqi_level_06,0) + NVL(LPQDL.ue_rep_cqi_level_07,0) +
	NVL(LPQDL.ue_rep_cqi_level_08,0) + NVL(LPQDL.ue_rep_cqi_level_09,0) + NVL(LPQDL.ue_rep_cqi_level_10,0) + NVL(LPQDL.ue_rep_cqi_level_11,0) +
	NVL(LPQDL.ue_rep_cqi_level_12,0) + NVL(LPQDL.ue_rep_cqi_level_13,0) + NVL(LPQDL.ue_rep_cqi_level_14,0) + NVL(LPQDL.ue_rep_cqi_level_15,0)) AS CQI_AVG_DENOM


	,SUM(NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_256QAM,0)) AS QAM256_NOM
	,SUM(NVL(LCELLT.TB_VOL_PDSCH_MCS0,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS1,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS2,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS3,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS4,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS5,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS6,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS7,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS8,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS9,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS10,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS11,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS12,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS13,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS14,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS15,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS16,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS17,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS18,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS19,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS20,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS21,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS22,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS23,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS24,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS25,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS26,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS27,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS28,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS29,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS30,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS31,0)+
	NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_16QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_64QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_256QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_QPSK,0)) AS QAM256_DENOM


	,SUM(NVL(LPQDL.UE_REPORTED_RI_2 ,0)+NVL(LPQDL.UE_REPORTED_RI_3 ,0)+NVL(LPQDL.UE_REPORTED_RI_4 ,0)) AS RI2_4_NOM
	,SUM(NVL(LPQDL.UE_REPORTED_RI_1 ,0)+NVL(LPQDL.UE_REPORTED_RI_2 ,0)+NVL(LPQDL.UE_REPORTED_RI_3 ,0)+NVL(LPQDL.UE_REPORTED_RI_4 ,0)) AS RI2_4_DENOM


	,SUM(NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_QPSK,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS0,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS1,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS2,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS3,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS4,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS5,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS6,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS7,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS8,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS9,0)) AS QPSK_NOM
	,SUM(NVL(LCELLT.TB_VOL_PDSCH_MCS0,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS1,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS2,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS3,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS4,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS5,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS6,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS7,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS8,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS9,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS10,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS11,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS12,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS13,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS14,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS15,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS16,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS17,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS18,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS19,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS20,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS21,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS22,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS23,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS24,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS25,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS26,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS27,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS28,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS29,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS30,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS31,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_16QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_64QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_256QAM,0)+
	NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_QPSK,0)) AS QPSK_DENOM


	,SUM(NVL(LCELAV.samples_cell_avail,0)) AS AVAILABILITY_NOM
	,SUM(NVL(LCELAV.denom_cell_avail,0)) AS AVAILABILITY_DENOM



	,SUM(NVL(LUEST.SIGN_CONN_ESTAB_COMP,0)) AS CUNSSR_SIGN_CONN_ESTAB_COMP_NOM
	,SUM(NVL(LUEST.SIGN_CONN_ESTAB_ATT_MO_D ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_MO_S ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_MT,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_EMG ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_HIPRIO ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_DEL_TOL,0 )) AS CUNSSR_SIGN_CONN_ESTAB_COMP_DENOM
	,SUM(NVL(LUEST.S1_SIGN_CONN_ESTAB_SUCC_UE,0)) AS CUNSSR_S1_SIGN_CONN_ESTAB_NOM
	,SUM(NVL(LUEST.S1_SIGN_CONN_ESTAB_ATT_UE,0)) AS CUNSSR_S1_SIGN_CONN_ESTAB_DENOM
	,SUM(NVL(LEPSB.ERAB_INI_SETUP_SUCC_QCI1,0) +NVL(LEPSB.ERAB_ADD_SETUP_SUCC_QCI1,0) -NVL(LEPSB.ERAB_REL_TEMP_QCI1,0)) AS CUNSSR_ERAB_INI_SETUP_QCI1_NOM
	,SUM(NVL(LEPSB.ERAB_INI_SETUP_ATT_QCI1 ,0) + NVL(LEPSB.ERAB_ADD_SETUP_ATT_QCI1_EX_RTR ,0) - NVL(LEPSB.ERAB_ADD_SETUP_ATT_QCI1_HO,0)) AS CUNSSR_ERAB_INI_SETUP_QCI1_DENOM
	,SUM(NVL(LEPSB.EPS_BEARER_SETUP_COMPLETIONS,0)) AS CUNSSR_EPS_BEARER_SETUP_NOM
	,SUM(NVL(LEPSB.EPS_BEARER_SETUP_ATTEMPTS ,0)) AS CUNSSR_EPS_BEARER_SETUP_DENOM


    --CDR_VOLTE
	,SUM(NVL(LEPSB.ERAB_REL_HO_PART_QCI1,0) + NVL(LEPSB.ERAB_REL_ENB_QCI1,0) - NVL(LEPSB.ERAB_REL_ENB_RNL_INA_QCI1,0) - NVL(LEPSB.ERAB_REL_ENB_RNL_RED_QCI1,0) - NVL(LEPSB.ERAB_REL_ENB_RNL_PREEM_QCI1,0) - NVL(LEPSB.erab_rel_temp_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_g_r_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_p_r_qci1 ,0) + NVL(LEPSB.erab_rel_s1_outage_qci1,0)) AS CDR_VOLTE_NOM
    ,SUM(NVL(LEPSB.ERAB_REL_ENB_QCI1,0) + NVL(LEPSB.ERAB_REL_HO_PART_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_N_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_D_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_R_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_O_QCI1,0) + NVL(LEPSB.erab_rel_epc_path_switch_qci1 ,0) - NVL(LEPSB.erab_rel_temp_qci1 ,0) + NVL(LEPSB.erab_rel_succ_ho_utran_qci1 ,0) + NVL(LEPSB.erab_rel_succ_ho_geran_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_g_r_qci1 ,0) + NVL(LEPSB.erab_rel_mme_ini_s1_g_r_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_p_r_qci1 ,0) + NVL(LEPSB.erab_rel_mme_ini_s1_p_r_qci1 ,0) + NVL(erab_rel_s1_outage_qci1,0)) AS CDR_VOLTE_DENOM


	--E_RAB_DR
    ,SUM(NVL(LEPSB.ERAB_REL_ENB_ACT_QCI1,0)+NVL(LEPSB.ERAB_REL_ENB_ACT_QCI2,0)+NVL(LEPSB.ERAB_REL_ENB_ACT_QCI3,0)+
         NVL(LEPSB.ERAB_REL_ENB_ACT_QCI4,0)+NVL(LEPSB.ERAB_REL_ENB_ACT_NON_GBR,0)+
         NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_RNL,0)+NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_OTH,0)) E_RAB_DR_NOM
    ,SUM(NVL(LEPSB.ERAB_REL_ENB,0)+NVL(LEPSB.ERAB_REL_HO_PART,0)+NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_NORM,0)+
         NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_DETACH,0)+NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_RNL,0)+
         NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_OTH,0)+NVL(LEPSB.ERAB_REL_EPC_PATH_SWITCH,0)-NVL(LEPSB.ERAB_REL_TEMP_QCI1,0)) E_RAB_DR_DENOM

	--UL_AVG_THR
    ,SUM(NVL(LCELLT.IP_TPUT_VOL_UL_QCI_1,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_2,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_3,0)+
       NVL(LCELLT.IP_TPUT_VOL_UL_QCI_4,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_5,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_6,0)+
       NVL(LCELLT.IP_TPUT_VOL_UL_QCI_7,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_8,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_9,0)) UL_AVG_THR_NOM
    ,SUM(NVL(LCELLT.IP_TPUT_TIME_UL_QCI_1,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_2,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_3,0)+
       NVL(LCELLT.IP_TPUT_TIME_UL_QCI_4,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_5,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_6,0)+
       NVL(LCELLT.IP_TPUT_TIME_UL_QCI_7,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_8,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_9,0)) UL_AVG_THR_DENOM

    --EUTRAN_IRAT_HO_UTRAN_SRVCC_ATT
    ,SUM(NVL(LISHO.ISYS_HO_UTRAN_SRVCC_ATT,0)) AS EUTRAN_IRAT_HO_UTRAN_SRVCC_ATT

    --EUTRAN_IRAT_HO_GERAN_SRVCC_ATT
    ,SUM(NVL(LISHO.ISYS_HO_GERAN_SRVCC_ATT,0)) AS EUTRAN_IRAT_HO_GERAN_SRVCC_ATT

	--IFHO_SR
	,SUM(NVL(LHO.HO_INTFREQ_SUCC,0)) AS IFHO_SR_NOM
    ,SUM(NVL(LHO.HO_INTFREQ_ATT ,0)) AS IFHO_SR_DENOM

    --IRATHO_SR
	,SUM(NVL(LISHO.isys_ho_succ,0) + NVL(LISHO.isys_ho_utran_srvcc_succ,0) + NVL(LISHO.isys_ho_geran_srvcc_succ,0)) AS IRATHO_SR_NOM
	,SUM(NVL(LISHO.isys_ho_prep, 0)) AS IRATHO_SR_DENOM

	-- TOTAL_HOSR
	,SUM(NVL(LIANBHO.INTRA_ENB_HO_PREP ,0) -NVL(LIANBHO.FAIL_ENB_HO_PREP_OTH ,0)+NVL(LIENBHO.INTER_ENB_HO_PREP ,0) -NVL(LIENBHO.FAIL_ENB_HO_PREP_OTHER ,0) -NVL(LIENBHO.FAIL_ENB_HO_PREP_TIME ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_PREP ,0) -NVL(LIENBHO.INTER_S1_HO_PREP_FAIL_TIME ,0) -NVL(LIENBHO.INTER_S1_HO_PREP_FAIL_NORR ,0) -NVL(LIENBHO.INTER_S1_HO_PREP_FAIL_OTHER,0)) AS TOTAL_HOSR_PREP_NOM
	,SUM(NVL(LIANBHO.INTRA_ENB_HO_PREP ,0)+NVL(LIENBHO.INTER_ENB_HO_PREP ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_PREP,0)) AS TOTAL_HOSR_PREP_DENOM
	,SUM(NVL(LIANBHO.SUCC_INTRA_ENB_HO ,0)+NVL(LIENBHO.SUCC_INTER_ENB_HO ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_SUCC,0)) AS TOTAL_HOSR_EXEC_NOM
	,SUM(NVL(LIANBHO.ATT_INTRA_ENB_HO ,0)+NVL(LIENBHO.ATT_INTER_ENB_HO ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_ATT,0)) AS TOTAL_HOSR_EXEC_DENOM

	--PS_DATA_VOL_MB_4G
	,SUM((NVL(LCELLT.PDCP_SDU_VOL_DL,0)+NVL(LCELLT.PDCP_SDU_VOL_UL,0))/1000000) AS PS_DATA_VOL_MB_4G

	--RSRP_115
	,SUM(NVL(RHIST.NUM_RSRP_MEAS_BIN1,0) +NVL(RHIST.NUM_RSRP_MEAS_BIN2,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN3,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN4,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN5,0)) AS RSRP_115_NOM
	,SUM(NVL(RHIST.NUM_RSRP_MEAS_BIN1,0) +NVL(RHIST.NUM_RSRP_MEAS_BIN2,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN3,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN4,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN5,0)+
	NVL(RHIST.NUM_RSRP_MEAS_BIN6,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN7,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN8,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN9,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN10,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN11,0)+
	NVL(RHIST.NUM_RSRP_MEAS_BIN12,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN13,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN14,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN15,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN16,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN17,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN18,0)) AS RSRP_115_DENOM


	--NUMBER_OF_RRC_CONNECTED_USERS
	,DIV(SUM(NVL(LUEQ.SUM_RRC_CONNECTED_UE,0) + NVL(LCELLD.SUM_RRC_CONN_UE,0)), SUM(NVL(LUEQ.DENOM_RRC_CONNECTED_UE,0) + NVL(LCELLD.DENOM_RRC_CONN_UE,0))) AS NUMBER_OF_RRC_CONNECTED_USERS

	--VOLTE ERLANG
	,SUM(NVL(erab_in_session_time_qci1,0)/(60*60)) AS VOLTE_ERLANG


from C_LTE_LNCEL@na19 LNCEL
join ctp_common_objects@na19 CTP                   on (LNCEL.OBJ_GID = CTP.CO_GID and CTP.co_oc_id in (6614))
join ctp_common_objects@na19 CTP_LNBTS             on (CTP_LNBTS.CO_GID = CTP.CO_PARENT_GID and CTP_LNBTS.co_oc_id in (7284))
join C_LTE_LNBTS@na19 LNBTS                        on (LNBTS.OBJ_GID = CTP_LNBTS.CO_GID and CTP_LNBTS.co_oc_id in (7284) and LNBTS.CONF_ID = 1)

left join NOKLTE_PS_LCELAV_LNCEL_day@na19 LCELAV       on (LCELAV.LNCEL_ID = LNCEL.OBJ_GID)
left join NOKLTE_PS_LISHO_lncel_day@na19 LISHO         on (LISHO.LNCEL_ID = LNCEL.OBJ_GID and LISHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
--left join NOKLTE_PS_LRRC_LNCEL_day@na19 LRRC           on (LRRC.LNCEL_ID = LNCEL.OBJ_GID and LRRC.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LCELLD_LNCEL_day@na19 LCELLD       on (LCELLD.LNCEL_ID = LNCEL.OBJ_GID and LCELLD.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
--left join NOKLTE_PS_LCELAV_LNCEL_day@na19 LCELAV       on (LCELAV.LNCEL_ID = LNCEL.OBJ_GID and LCELAV.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LUEST_LNCEL_day@na19 LUEST         on (LUEST.LNCEL_ID = LNCEL.OBJ_GID and LUEST.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LEPSB_LNCEL_day@na19  LEPSB        on (LEPSB.LNCEL_ID = LNCEL.OBJ_GID and LEPSB.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LCELLT_LNCEL_day@na19 LCELLT       on (LCELLT.LNCEL_ID = LNCEL.OBJ_GID and LCELLT.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LIANBHO_LNCEL_day@na19 LIANBHO     on (LIANBHO.LNCEL_ID = LNCEL.OBJ_GID and LIANBHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LIENBHO_LNCEL_day@na19 LIENBHO     on (LIENBHO.LNCEL_ID = LNCEL.OBJ_GID and LIENBHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
--left join NOKLTE_PS_LCELLR_LNCEL_day@na19 LCELLR       on (LCELLR.LNCEL_ID = LNCEL.OBJ_GID and LCELLR.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LHO_LNCEL_day@na19 LHO             on (LHO.LNCEL_ID = LNCEL.OBJ_GID and LHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LUEQ_LNCEL_day@na19 LUEQ           on (LUEQ.LNCEL_ID = LNCEL.OBJ_GID and LUEQ.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LPQDL_LNCEL_day@na19 LPQDL         on (LPQDL.LNCEL_ID = LNCEL.OBJ_GID and LPQDL.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
--left join NOKLTE_PS_LPQUL_LNCEL_day@na19 LPQUL         on (LPQUL.LNCEL_ID = LNCEL.OBJ_GID and LPQUL.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
--left join NOKLTE_PS_LMAC_LNCEL_day@na19 LMAC           on (LMAC.LNCEL_ID = LNCEL.OBJ_GID and LMAC.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
--left join NOKLTE_PS_LHORLF_LNCEL_day@na19 LHORLF      on (LHORLF.LNCEL_ID = LNCEL.OBJ_GID and LHORLF.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_RHIST_LNCEL_day@na19 RHIST      on (RHIST.LNCEL_ID = LNCEL.OBJ_GID and RHIST.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)


where LNCEL.conf_id = 1 and LNBTS.conf_id = 1
and substr(LNCEL.LNCEL_TAC, LENGTH(LNCEL.LNCEL_TAC)-1) = '23'
and LCELAV.period_start_time =to_date('23.10.2021','dd.mm.yyyy')

and ctp.co_dn not like ('%LNCEL-14') and ctp.co_dn not like ('%LNCEL-15') and ctp.co_dn not like ('%LNCEL-16')
and ctp.co_dn not like ('%LNCEL-17') and ctp.co_dn not like ('%LNCEL-18') and ctp.co_dn not like ('%LNCEL-19')
and ctp.co_dn not like ('%LNCEL-247') and ctp.co_dn not like ('%LNCEL-248') and ctp.co_dn not like ('%LNCEL-249')


group by
to_char(LCELAV.PERIOD_START_TIME,'dd.mm.yyyy')
, substr(LNCEL.LNCEL_TAC, length(LNCEL.LNCEL_TAC)-1)
,ctp_lnbts.co_object_instance
,ctp.co_dn
,ctp.co_object_instance
   ,LNCEL.LNCEL_CELL_NAME
    ,LNCEL.LNCEL_EUTRA_Cel_id

UNION ALL


select
	--,to_char(LISHO.PERIOD_START_TIME,'dd.mm.yyyy HH24:mi:ss')
	to_char(LCELAV.PERIOD_START_TIME,'dd.mm.yyyy') PERIOD_START_TIME
	/*,case when LNCEL.LNCEL_EARFCN_DL is Null then 7
	      when LNCEL.LNCEL_EARFCN_DL >3000 then 7
	      when LNCEL.LNCEL_EARFCN_DL <3000 then 3 end "Band"*/
	, substr(LNCEL.LNCEL_TAC, length(LNCEL.LNCEL_TAC)-1) "Region"
	,ctp_lnbts.co_object_instance LNBTS_ID
	,ctp.co_dn LNCEL_DN
	--,LNCEL.LNCEL_TAC
	--,substr(LNCEL.LNCEL_TAC, LENGTH(LNCEL.LNCEL_TAC)-1)
	,ctp.co_object_instance LNCELID
	/*,case when ctp.co_object_instance in (4,5,6) then 'L2600'
	      when ctp.co_object_instance in (7,8,9) then 'L1800'
	      when t.lncel_id in (201,202,203,24,25,26,231,232,233) then '2600TDD'
	      when t.lncel_id in (101,102,103) then 'L2100' else 'UNKNOWN' end BAND*/
	,LNCEL.LNCEL_CELL_NAME
    ,LNCEL.LNCEL_EUTRA_Cel_id


	,SUM(NVL(LCELLT.IP_TPUT_VOL_DL_QCI_1,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_2,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_3,0)+
	NVL(LCELLT.IP_TPUT_VOL_DL_QCI_4,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_5,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_6,0)+
	NVL(LCELLT.IP_TPUT_VOL_DL_QCI_7,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_8,0)+NVL(LCELLT.IP_TPUT_VOL_DL_QCI_9,0)) AS DL_AVG_THR_NOM
	,SUM(NVL(LCELLT.IP_TPUT_TIME_DL_QCI_1,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_2,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_3,0)+
	NVL(LCELLT.IP_TPUT_TIME_DL_QCI_4,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_5,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_6,0)+
	NVL(LCELLT.IP_TPUT_TIME_DL_QCI_7,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_8,0)+NVL(LCELLT.IP_TPUT_TIME_DL_QCI_9,0)) AS DL_AVG_THR_DENOM

	,0 AS CQI_0_9_NOM
	,0 AS CQI_0_9_DENOM

	,SUM(1*(NVL(LPQDL.ue_rep_cqi_level_01,0)) + 2*(NVL(LPQDL.ue_rep_cqi_level_02,0)) + 3*(NVL(LPQDL.ue_rep_cqi_level_03,0)) +
	4*(NVL(LPQDL.ue_rep_cqi_level_04,0)) + 5*(NVL(LPQDL.ue_rep_cqi_level_05,0)) + 6*(NVL(LPQDL.ue_rep_cqi_level_06,0)) +
	7*(NVL(LPQDL.ue_rep_cqi_level_07,0)) + 8*(NVL(LPQDL.ue_rep_cqi_level_08,0)) + 9*(NVL(LPQDL.ue_rep_cqi_level_09,0)) +
	10*(NVL(LPQDL.ue_rep_cqi_level_10,0)) + 11*(NVL(LPQDL.ue_rep_cqi_level_11,0)) + 12*(NVL(LPQDL.ue_rep_cqi_level_12,0)) +
	13*(NVL(LPQDL.ue_rep_cqi_level_13,0)) + 14*(NVL(LPQDL.ue_rep_cqi_level_14,0)) + 15*(NVL(LPQDL.ue_rep_cqi_level_15,0))) AS CQI_AVG_NOM
	,SUM(NVL(LPQDL.ue_rep_cqi_level_00,0) + NVL(LPQDL.ue_rep_cqi_level_01,0) + NVL(LPQDL.ue_rep_cqi_level_02,0) + NVL(LPQDL.ue_rep_cqi_level_03,0) +
	NVL(LPQDL.ue_rep_cqi_level_04,0) + NVL(LPQDL.ue_rep_cqi_level_05,0) + NVL(LPQDL.ue_rep_cqi_level_06,0) + NVL(LPQDL.ue_rep_cqi_level_07,0) +
	NVL(LPQDL.ue_rep_cqi_level_08,0) + NVL(LPQDL.ue_rep_cqi_level_09,0) + NVL(LPQDL.ue_rep_cqi_level_10,0) + NVL(LPQDL.ue_rep_cqi_level_11,0) +
	NVL(LPQDL.ue_rep_cqi_level_12,0) + NVL(LPQDL.ue_rep_cqi_level_13,0) + NVL(LPQDL.ue_rep_cqi_level_14,0) + NVL(LPQDL.ue_rep_cqi_level_15,0)) AS CQI_AVG_DENOM


	,SUM(NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_256QAM,0)) AS QAM256_NOM
	,SUM(NVL(LCELLT.TB_VOL_PDSCH_MCS0,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS1,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS2,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS3,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS4,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS5,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS6,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS7,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS8,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS9,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS10,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS11,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS12,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS13,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS14,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS15,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS16,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS17,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS18,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS19,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS20,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS21,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS22,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS23,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS24,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS25,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS26,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS27,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS28,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS29,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS30,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS31,0)+
	NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_16QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_64QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_256QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_QPSK,0)) AS QAM256_DENOM


	,SUM(NVL(LPQDL.UE_REPORTED_RI_2 ,0)+NVL(LPQDL.UE_REPORTED_RI_3 ,0)+NVL(LPQDL.UE_REPORTED_RI_4 ,0)) AS RI2_4_NOM
	,SUM(NVL(LPQDL.UE_REPORTED_RI_1 ,0)+NVL(LPQDL.UE_REPORTED_RI_2 ,0)+NVL(LPQDL.UE_REPORTED_RI_3 ,0)+NVL(LPQDL.UE_REPORTED_RI_4 ,0)) AS RI2_4_DENOM


	,SUM(NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_QPSK,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS0,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS1,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS2,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS3,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS4,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS5,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS6,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS7,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS8,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS9,0)) AS QPSK_NOM
	,SUM(NVL(LCELLT.TB_VOL_PDSCH_MCS0,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS1,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS2,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS3,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS4,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS5,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS6,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS7,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS8,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS9,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS10,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS11,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS12,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS13,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS14,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS15,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS16,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS17,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS18,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS19,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS20,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS21,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS22,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS23,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS24,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS25,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS26,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS27,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS28,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS29,0)+
	NVL(LCELLT.TB_VOL_PDSCH_MCS30,0)+NVL(LCELLT.TB_VOL_PDSCH_MCS31,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_16QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_64QAM,0)+NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_256QAM,0)+
	NVL(LCELLT.SCHDL_256QAM_VOL_PDSCH_QPSK,0)) AS QPSK_DENOM


	,SUM(NVL(LCELAV.samples_cell_avail,0)) AS AVAILABILITY_NOM
	,SUM(NVL(LCELAV.denom_cell_avail,0)) AS AVAILABILITY_DENOM


	,SUM(NVL(LUEST.SIGN_CONN_ESTAB_COMP,0)) AS CUNSSR_SIGN_CONN_ESTAB_COMP_NOM
	,SUM(NVL(LUEST.SIGN_CONN_ESTAB_ATT_MO_D ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_MO_S ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_MT,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_EMG ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_HIPRIO ,0) +NVL(LUEST.SIGN_CONN_ESTAB_ATT_DEL_TOL,0 )) AS CUNSSR_SIGN_CONN_ESTAB_COMP_DENOM
	,SUM(NVL(LUEST.S1_SIGN_CONN_ESTAB_SUCC_UE,0)) AS CUNSSR_S1_SIGN_CONN_ESTAB_NOM
	,SUM(NVL(LUEST.S1_SIGN_CONN_ESTAB_ATT_UE,0)) AS CUNSSR_S1_SIGN_CONN_ESTAB_DENOM
	,SUM(NVL(LEPSB.ERAB_INI_SETUP_SUCC_QCI1,0) +NVL(LEPSB.ERAB_ADD_SETUP_SUCC_QCI1,0) -NVL(LEPSB.ERAB_REL_TEMP_QCI1,0)) AS CUNSSR_ERAB_INI_SETUP_QCI1_NOM
	,SUM(NVL(LEPSB.ERAB_INI_SETUP_ATT_QCI1 ,0) + NVL(LEPSB.ERAB_ADD_SETUP_ATT_QCI1_EX_RTR ,0) - NVL(LEPSB.ERAB_ADD_SETUP_ATT_QCI1_HO,0)) AS CUNSSR_ERAB_INI_SETUP_QCI1_DENOM
	,SUM(NVL(LEPSB.EPS_BEARER_SETUP_COMPLETIONS,0)) AS CUNSSR_EPS_BEARER_SETUP_NOM
	,SUM(NVL(LEPSB.EPS_BEARER_SETUP_ATTEMPTS ,0)) AS CUNSSR_EPS_BEARER_SETUP_DENOM


    --CDR_VOLTE
	,SUM(NVL(LEPSB.ERAB_REL_HO_PART_QCI1,0) + NVL(LEPSB.ERAB_REL_ENB_QCI1,0) - NVL(LEPSB.ERAB_REL_ENB_RNL_INA_QCI1,0) - NVL(LEPSB.ERAB_REL_ENB_RNL_RED_QCI1,0) - NVL(LEPSB.ERAB_REL_ENB_RNL_PREEM_QCI1,0) - NVL(LEPSB.erab_rel_temp_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_g_r_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_p_r_qci1 ,0) + NVL(LEPSB.erab_rel_s1_outage_qci1,0)) AS CDR_VOLTE_NOM
    ,SUM(NVL(LEPSB.ERAB_REL_ENB_QCI1,0) + NVL(LEPSB.ERAB_REL_HO_PART_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_N_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_D_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_R_QCI1,0) + NVL(LEPSB.EPC_EPS_BEAR_REL_REQ_O_QCI1,0) + NVL(LEPSB.erab_rel_epc_path_switch_qci1 ,0) - NVL(LEPSB.erab_rel_temp_qci1 ,0) + NVL(LEPSB.erab_rel_succ_ho_utran_qci1 ,0) + NVL(LEPSB.erab_rel_succ_ho_geran_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_g_r_qci1 ,0) + NVL(LEPSB.erab_rel_mme_ini_s1_g_r_qci1 ,0) + NVL(LEPSB.erab_rel_enb_ini_s1_p_r_qci1 ,0) + NVL(LEPSB.erab_rel_mme_ini_s1_p_r_qci1 ,0) + NVL(erab_rel_s1_outage_qci1,0)) AS CDR_VOLTE_DENOM


	--E_RAB_DR
    ,SUM(NVL(LEPSB.ERAB_REL_ENB_ACT_QCI1,0)+NVL(LEPSB.ERAB_REL_ENB_ACT_QCI2,0)+NVL(LEPSB.ERAB_REL_ENB_ACT_QCI3,0)+
         NVL(LEPSB.ERAB_REL_ENB_ACT_QCI4,0)+NVL(LEPSB.ERAB_REL_ENB_ACT_NON_GBR,0)+
         NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_RNL,0)+NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_OTH,0)) E_RAB_DR_NOM
    ,SUM(NVL(LEPSB.ERAB_REL_ENB,0)+NVL(LEPSB.ERAB_REL_HO_PART,0)+NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_NORM,0)+
         NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_DETACH,0)+NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_RNL,0)+
         NVL(LEPSB.EPC_EPS_BEARER_REL_REQ_OTH,0)+NVL(LEPSB.ERAB_REL_EPC_PATH_SWITCH,0)-NVL(LEPSB.ERAB_REL_TEMP_QCI1,0)) E_RAB_DR_DENOM

	--UL_AVG_THR
    ,SUM(NVL(LCELLT.IP_TPUT_VOL_UL_QCI_1,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_2,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_3,0)+
       NVL(LCELLT.IP_TPUT_VOL_UL_QCI_4,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_5,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_6,0)+
       NVL(LCELLT.IP_TPUT_VOL_UL_QCI_7,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_8,0)+NVL(LCELLT.IP_TPUT_VOL_UL_QCI_9,0)) UL_AVG_THR_NOM
    ,SUM(NVL(LCELLT.IP_TPUT_TIME_UL_QCI_1,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_2,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_3,0)+
       NVL(LCELLT.IP_TPUT_TIME_UL_QCI_4,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_5,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_6,0)+
       NVL(LCELLT.IP_TPUT_TIME_UL_QCI_7,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_8,0)+NVL(LCELLT.IP_TPUT_TIME_UL_QCI_9,0)) UL_AVG_THR_DENOM

    --EUTRAN_IRAT_HO_UTRAN_SRVCC_ATT
    ,SUM(NVL(LISHO.ISYS_HO_UTRAN_SRVCC_ATT,0)) AS EUTRAN_IRAT_HO_UTRAN_SRVCC_ATT

    --EUTRAN_IRAT_HO_GERAN_SRVCC_ATT
    ,SUM(NVL(LISHO.ISYS_HO_GERAN_SRVCC_ATT,0)) AS EUTRAN_IRAT_HO_GERAN_SRVCC_ATT

	--IFHO_SR
	,SUM(NVL(LHO.HO_INTFREQ_SUCC,0)) AS IFHO_SR_NOM
    ,SUM(NVL(LHO.HO_INTFREQ_ATT ,0)) AS IFHO_SR_DENOM

    --IRATHO_SR
	,SUM(NVL(LISHO.isys_ho_succ,0) + NVL(LISHO.isys_ho_utran_srvcc_succ,0) + NVL(LISHO.isys_ho_geran_srvcc_succ,0)) AS IRATHO_SR_NOM
	,SUM(NVL(LISHO.isys_ho_prep, 0)) AS IRATHO_SR_DENOM

	-- TOTAL_HOSR
	,SUM(NVL(LIANBHO.INTRA_ENB_HO_PREP ,0) -NVL(LIANBHO.FAIL_ENB_HO_PREP_OTH ,0)+NVL(LIENBHO.INTER_ENB_HO_PREP ,0) -NVL(LIENBHO.FAIL_ENB_HO_PREP_OTHER ,0) -NVL(LIENBHO.FAIL_ENB_HO_PREP_TIME ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_PREP ,0) -NVL(LIENBHO.INTER_S1_HO_PREP_FAIL_TIME ,0) -NVL(LIENBHO.INTER_S1_HO_PREP_FAIL_NORR ,0) -NVL(LIENBHO.INTER_S1_HO_PREP_FAIL_OTHER,0)) AS TOTAL_HOSR_PREP_NOM
	,SUM(NVL(LIANBHO.INTRA_ENB_HO_PREP ,0)+NVL(LIENBHO.INTER_ENB_HO_PREP ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_PREP,0)) AS TOTAL_HOSR_PREP_DENOM
	,SUM(NVL(LIANBHO.SUCC_INTRA_ENB_HO ,0)+NVL(LIENBHO.SUCC_INTER_ENB_HO ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_SUCC,0)) AS TOTAL_HOSR_EXEC_NOM
	,SUM(NVL(LIANBHO.ATT_INTRA_ENB_HO ,0)+NVL(LIENBHO.ATT_INTER_ENB_HO ,0)+NVL(LIENBHO.INTER_ENB_S1_HO_ATT,0)) AS TOTAL_HOSR_EXEC_DENOM

	--PS_DATA_VOL_MB_4G
	,SUM((NVL(LCELLT.PDCP_SDU_VOL_DL,0)+NVL(LCELLT.PDCP_SDU_VOL_UL,0))/1000000) AS PS_DATA_VOL_MB_4G

	--RSRP_115
	,SUM(NVL(RHIST.NUM_RSRP_MEAS_BIN1,0) +NVL(RHIST.NUM_RSRP_MEAS_BIN2,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN3,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN4,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN5,0)) AS RSRP_115_NOM
	,SUM(NVL(RHIST.NUM_RSRP_MEAS_BIN1,0) +NVL(RHIST.NUM_RSRP_MEAS_BIN2,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN3,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN4,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN5,0)+
	NVL(RHIST.NUM_RSRP_MEAS_BIN6,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN7,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN8,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN9,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN10,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN11,0)+
	NVL(RHIST.NUM_RSRP_MEAS_BIN12,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN13,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN14,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN15,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN16,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN17,0)+NVL(RHIST.NUM_RSRP_MEAS_BIN18,0)) AS RSRP_115_DENOM


	--NUMBER_OF_RRC_CONNECTED_USERS
	,DIV(SUM(NVL(LUEQ.SUM_RRC_CONNECTED_UE,0) + NVL(LCELLD.SUM_RRC_CONN_UE,0)), SUM(NVL(LUEQ.DENOM_RRC_CONNECTED_UE,0) + NVL(LCELLD.DENOM_RRC_CONN_UE,0))) AS NUMBER_OF_RRC_CONNECTED_USERS

	--VOLTE ERLANG
	,SUM(NVL(erab_in_session_time_qci1,0)/(60*60)) AS VOLTE_ERLANG


from C_LTE_LNCEL@na18 LNCEL
left join ctp_common_objects@na18 CTP                   on (LNCEL.OBJ_GID = CTP.CO_GID and CTP.co_oc_id in (8240))
left join ctp_common_objects@na18 CTP_LNBTS             on (CTP_LNBTS.CO_GID = CTP.CO_PARENT_GID and CTP_LNBTS.co_oc_id in (8076))
left join C_LTE_LNBTS@na18 LNBTS                        on (LNBTS.OBJ_GID = CTP_LNBTS.CO_GID and CTP_LNBTS.co_oc_id in (8076) and LNBTS.CONF_ID = 1)

left join NOKLTE_PS_LCELAV_LNCEL_day@na18 LCELAV       on (LCELAV.LNCEL_ID = LNCEL.OBJ_GID)
left join NOKLTE_PS_LISHO_lncel_day@na18 LISHO         on (LISHO.LNCEL_ID = LNCEL.OBJ_GID and LISHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LCELLD_LNCEL_day@na18 LCELLD       on (LCELLD.LNCEL_ID = LNCEL.OBJ_GID and LCELLD.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LUEST_LNCEL_day@na18 LUEST         on (LUEST.LNCEL_ID = LNCEL.OBJ_GID and LUEST.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LEPSB_LNCEL_day@na18 LEPSB        on (LEPSB.LNCEL_ID = LNCEL.OBJ_GID and LEPSB.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LCELLT_LNCEL_day@na18 LCELLT       on (LCELLT.LNCEL_ID = LNCEL.OBJ_GID and LCELLT.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LIANBHO_LNCEL_day@na18 LIANBHO     on (LIANBHO.LNCEL_ID = LNCEL.OBJ_GID and LIANBHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LIENBHO_LNCEL_day@na18 LIENBHO     on (LIENBHO.LNCEL_ID = LNCEL.OBJ_GID and LIENBHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LHO_LNCEL_day@na18 LHO             on (LHO.LNCEL_ID = LNCEL.OBJ_GID and LHO.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LUEQ_LNCEL_day@na18 LUEQ           on (LUEQ.LNCEL_ID = LNCEL.OBJ_GID and LUEQ.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_LPQDL_LNCEL_day@na18 LPQDL         on (LPQDL.LNCEL_ID = LNCEL.OBJ_GID and LPQDL.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)
left join NOKLTE_PS_RHIST_LNCEL_day@na18 RHIST      on (RHIST.LNCEL_ID = LNCEL.OBJ_GID and RHIST.PERIOD_START_TIME = LCELAV.PERIOD_START_TIME)

where LNCEL.conf_id = 1 and LNBTS.conf_id = 1
AND substr(LNCEL.LNCEL_TAC, LENGTH(LNCEL.LNCEL_TAC)-1) in ('61','34')
and LCELAV.period_start_time =to_date('23.10.2021','dd.mm.yyyy')
--AND LCELAV.period_start_time >= to_date('07.07.2021','dd.mm.yyyy')
--AND LCELAV.period_start_time < to_date('07.07.2021','dd.mm.yyyy')

and ctp.co_dn not like ('%LNCEL-14') and ctp.co_dn not like ('%LNCEL-15') and ctp.co_dn not like ('%LNCEL-16')
and ctp.co_dn not like ('%LNCEL-17') and ctp.co_dn not like ('%LNCEL-18') and ctp.co_dn not like ('%LNCEL-19')
and ctp.co_dn not like ('%LNCEL-247') and ctp.co_dn not like ('%LNCEL-248') and ctp.co_dn not like ('%LNCEL-249')


group by
to_char(LCELAV.PERIOD_START_TIME,'dd.mm.yyyy')
, substr(LNCEL.LNCEL_TAC, length(LNCEL.LNCEL_TAC)-1)
,ctp_lnbts.co_object_instance
,ctp.co_dn
,ctp.co_object_instance
    ,LNCEL.LNCEL_CELL_NAME
    ,LNCEL.LNCEL_EUTRA_Cel_id
order by 1,2;
COMMIT;

 	Execute immediate ('INSERT INTO MIP.T_CELL_DY_4G_NSN_NA@mip (PERIOD_START_TIME,"Region",LNBTS_ID,LNCEL_DN,LNCELID,DL_AVG_THR_NOM,DL_AVG_THR_DENOM,CQI_0_9_NOM,CQI_0_9_DENOM,CQI_AVG_NOM,CQI_AVG_DENOM,QAM256_NOM,QAM256_DENOM,RI2_4_NOM,RI2_4_DENOM,QPSK_NOM,QPSK_DENOM,AVAILABILITY_NOM,AVAILABILITY_DENOM,CUNSSR_SIGN_C_E_COMP_NOM,CUNSSR_SIGN_C_E_COMP_DENOM,CUNSSR_S1_S_C_E_NOM,CUNSSR_S1_S_C_E_DENOM,CUNSSR_ERAB_I_S_QCI1_NOM,CUNSSR_ERAB_I_S_QCI1_DENOM,CUNSSR_EPS_BEARER_SETUP_NOM,CUNSSR_EPS_BEARER_SETUP_DENOM,CDR_VOLTE_NOM,CDR_VOLTE_DENOM,E_RAB_DR_NOM,E_RAB_DR_DENOM,UL_AVG_THR_NOM,UL_AVG_THR_DENOM,EUTRAN_IRAT_HO_U_SRVCC_ATT,EUTRAN_IRAT_HO_G_SRVCC_ATT,IFHO_SR_NOM,IFHO_SR_DENOM,IRATHO_SR_NOM,IRATHO_SR_DENOM,TOTAL_HOSR_PREP_NOM,TOTAL_HOSR_PREP_DENOM,TOTAL_HOSR_EXEC_NOM,TOTAL_HOSR_EXEC_DENOM,PS_DATA_VOL_MB_4G,RSRP_115_NOM,RSRP_115_DENOM,NUMBER_OF_RRC_CONNECTED_USERS,VOLTE_ERLANG,LNCEL_CELL_NAME,LNCEL_EUTRA_CEL_ID)SELECT PERIOD_START_TIME,"Region",LNBTS_ID,LNCEL_DN,LNCELID,DL_AVG_THR_NOM,DL_AVG_THR_DENOM,CQI_0_9_NOM,CQI_0_9_DENOM,CQI_AVG_NOM,CQI_AVG_DENOM,QAM256_NOM,QAM256_DENOM,RI2_4_NOM,RI2_4_DENOM,QPSK_NOM,QPSK_DENOM,AVAILABILITY_NOM,AVAILABILITY_DENOM,CUNSSR_SIGN_C_E_COMP_NOM,CUNSSR_SIGN_C_E_COMP_DENOM,CUNSSR_S1_S_C_E_NOM,CUNSSR_S1_S_C_E_DENOM,CUNSSR_ERAB_I_S_QCI1_NOM,CUNSSR_ERAB_I_S_QCI1_DENOM,CUNSSR_EPS_BEARER_SETUP_NOM,CUNSSR_EPS_BEARER_SETUP_DENOM,CDR_VOLTE_NOM,CDR_VOLTE_DENOM,E_RAB_DR_NOM,E_RAB_DR_DENOM,UL_AVG_THR_NOM,UL_AVG_THR_DENOM,EUTRAN_IRAT_HO_U_SRVCC_ATT,EUTRAN_IRAT_HO_G_SRVCC_ATT,IFHO_SR_NOM,IFHO_SR_DENOM,IRATHO_SR_NOM,IRATHO_SR_DENOM,TOTAL_HOSR_PREP_NOM,TOTAL_HOSR_PREP_DENOM,TOTAL_HOSR_EXEC_NOM,TOTAL_HOSR_EXEC_DENOM,PS_DATA_VOL_MB_4G,RSRP_115_NOM,RSRP_115_DENOM,NUMBER_OF_RRC_CONNECTED_USERS,VOLTE_ERLANG,LNCEL_CELL_NAME,LNCEL_EUTRA_CEL_ID
    FROM SERGEY_USTIMENKOV.T_CELL_DY_4G_NSN_SIP_NA');

	COMMIT;
END;