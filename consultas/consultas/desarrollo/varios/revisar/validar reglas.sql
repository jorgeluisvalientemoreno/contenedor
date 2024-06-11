select count(1), count(distinct expression)
from open.gr_config_expression;

with base as(
select 'TA_DEFICRBT' as tabla,DECBREVA from open.TA_DEFICRBT where DECBREVA is not null union all
select 'TA_DEFICRBT' as tabla,DECBREIN from open.TA_DEFICRBT where DECBREIN is not null union all
select 'AB_DOMAIN_COMP' as tabla,CONFIG_EXPRESSION_ID from open.AB_DOMAIN_COMP where CONFIG_EXPRESSION_ID is not null union all
select 'FM_MULTLVL_METHOD' as tabla,CONFIG_EXPRESSION_ID from open.FM_MULTLVL_METHOD where CONFIG_EXPRESSION_ID is not null union all
select 'CC_PROM_DETAIL' as tabla,CONFIG_EXPRESSION_ID from open.CC_PROM_DETAIL where CONFIG_EXPRESSION_ID is not null union all
select 'PM_STAGE' as tabla,CONFIG_EXPRESSION_ID from open.PM_STAGE where CONFIG_EXPRESSION_ID is not null union all
select 'RC_CONDDEVA' as tabla,CODVIDPV from open.RC_CONDDEVA where CODVIDPV is not null union all
select 'ED_TIPOBLOQ' as tabla,TIBLCEID from open.ED_TIPOBLOQ where TIBLCEID is not null union all
select 'RC_CONDGEVA' as tabla,COGVIDPP from open.RC_CONDGEVA where COGVIDPP is not null union all
select 'RC_CONDGEVA' as tabla,COGVIDPA from open.RC_CONDGEVA where COGVIDPA is not null union all
select 'GE_WHEN_ENTITY_EVENT' as tabla,CONFIG_EXPRESSION_ID from open.GE_WHEN_ENTITY_EVENT where CONFIG_EXPRESSION_ID is not null union all
select 'ACTIGECO' as tabla,ACGCREFA from open.ACTIGECO where ACGCREFA is not null union all
select 'ACTIGECO' as tabla,ACGCREVP from open.ACTIGECO where ACGCREVP is not null union all
select 'ACTIGECO' as tabla,ACGCREGL from open.ACTIGECO where ACGCREGL is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,INIT_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_1_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,INIT_EXPRESSION_2_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_2_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,INIT_EXPRESSION_3_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_3_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,INIT_EXPRESSION_4_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_4_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,VALID_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_1_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,VALID_EXPRESSION_2_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_2_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,VALID_EXPRESSION_3_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_3_ID is not null union all
select 'GE_ITEMS_ATTRIBUTES' as tabla,VALID_EXPRESSION_4_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_4_ID is not null union all
select 'GE_ACT_PRODTYPE_STAT' as tabla,RULE_ID from open.GE_ACT_PRODTYPE_STAT where RULE_ID is not null union all
select 'LE_PARACATR' as tabla,PACTREGL from open.LE_PARACATR where PACTREGL is not null union all
select 'IN_STATUS_TRANSITION' as tabla,PRE_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where PRE_CONFIG_EXPRES_ID is not null union all
select 'IN_STATUS_TRANSITION' as tabla,POS_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where POS_CONFIG_EXPRES_ID is not null union all
select 'IN_INTERFACE_MESSAGE' as tabla,TARGET_MODULE_EXP_ID from open.IN_INTERFACE_MESSAGE where TARGET_MODULE_EXP_ID is not null union all
select 'IN_INTERFACE_MESSAGE' as tabla,VALI_DOC_SELE_EXP_ID from open.IN_INTERFACE_MESSAGE where VALI_DOC_SELE_EXP_ID is not null union all
select 'IN_INTERF_TYPE_BATCH' as tabla,SEN_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where SEN_CONFIG_EXPRES_ID is not null union all
select 'IN_INTERF_TYPE_BATCH' as tabla,REC_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where REC_CONFIG_EXPRES_ID is not null union all
select 'IN_MESSAGE_TYPE' as tabla,CONFIG_EXPRESSION_ID from open.IN_MESSAGE_TYPE where CONFIG_EXPRESSION_ID is not null union all
select 'PS_MOTIVE_ACTION' as tabla,AFTER_EXPRE_ID from open.PS_MOTIVE_ACTION where AFTER_EXPRE_ID is not null union all
select 'PS_MOTIVE_ACTION' as tabla,BEFORE_EXPRE_ID from open.PS_MOTIVE_ACTION where BEFORE_EXPRE_ID is not null union all
select 'LE_CAFRPERF' as tabla,CAFPREGL from open.LE_CAFRPERF where CAFPREGL is not null union all
select 'GE_MESG_ALERT' as tabla,CONFIG_EXPRESSION_ID from open.GE_MESG_ALERT where CONFIG_EXPRESSION_ID is not null union all
select 'ED_ITEM' as tabla,ITEMCEID from open.ED_ITEM where ITEMCEID is not null union all
select 'ED_TIPOFRAN' as tabla,TIFRCEID from open.ED_TIPOFRAN where TIFRCEID is not null union all
select 'CT_CONDITIONS' as tabla,CONFIG_EXPRESSION_ID from open.CT_CONDITIONS where CONFIG_EXPRESSION_ID is not null union all
select 'OR_TRANSITION' as tabla,POST_EXPRESSION_ID from open.OR_TRANSITION where POST_EXPRESSION_ID is not null union all
select 'OR_TRANSITION' as tabla,PRE_EXPRESSION_ID from open.OR_TRANSITION where PRE_EXPRESSION_ID is not null union all
select 'OR_OPUNI_TSKTYP_NOTI' as tabla,CONFIG_EXPRESSION_ID from open.OR_OPUNI_TSKTYP_NOTI where CONFIG_EXPRESSION_ID is not null union all
select 'REGLCALI' as tabla,RECAIDRE from open.REGLCALI where RECAIDRE is not null union all
select 'PROGCART' as tabla,PRCAREAS from open.PROGCART where PRCAREAS is not null union all
select 'PLANSUSC' as tabla,PLSUREAP from open.PLANSUSC where PLSUREAP is not null union all
select 'ENTICOBR' as tabla,ENCOIDRE from open.ENTICOBR where ENCOIDRE is not null union all
select 'GE_ENTITY_ATTRIBUTES' as tabla,INIT_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where INIT_EXPRESSION_ID is not null union all
select 'GE_ENTITY_ATTRIBUTES' as tabla,VALID_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where VALID_EXPRESSION_ID is not null union all
select 'BANCO' as tabla,BANCIDRE from open.BANCO where BANCIDRE is not null union all
select 'GE_ACTION_MODULE' as tabla,CONFIG_EXPRESSION_ID from open.GE_ACTION_MODULE where CONFIG_EXPRESSION_ID is not null union all
select 'GE_ATTRIBUTES' as tabla,VALID_EXPRESSION from open.GE_ATTRIBUTES where VALID_EXPRESSION is not null union all
select 'IF_CAPACITY_TYPE' as tabla,CONFIG_EXPRESSION_ID from open.IF_CAPACITY_TYPE where CONFIG_EXPRESSION_ID is not null union all
select 'IF_CAPA_ELEM_ATTR' as tabla,INITIALIZA_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where INITIALIZA_EXPRE_ID is not null union all
select 'IF_CAPA_ELEM_ATTR' as tabla,INSERT_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where INSERT_EXPRE_ID is not null union all
select 'IF_CAPA_ELEM_ATTR' as tabla,UPDATE_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where UPDATE_EXPRE_ID is not null union all
select 'GST_DETATACO' as tabla,DETCRECA from open.GST_DETATACO where DETCRECA is not null union all
select 'GE_TEMPLATE_VAR' as tabla,ERROR_EXPRESSION_ID from open.GE_TEMPLATE_VAR where ERROR_EXPRESSION_ID is not null union all
select 'GE_TEMPLATE_VAR' as tabla,VALID_EXPRESSION_ID from open.GE_TEMPLATE_VAR where VALID_EXPRESSION_ID is not null union all
select 'GE_TEMPLATE_VAR' as tabla,INIT_EXPRESSION_ID from open.GE_TEMPLATE_VAR where INIT_EXPRESSION_ID is not null union all
select 'GE_VARIABLE' as tabla,ERROR_EXPRESION_ID from open.GE_VARIABLE where ERROR_EXPRESION_ID is not null union all
select 'GW_EVENT_ENTITY' as tabla,BEFORE_EXPR_ID from open.GW_EVENT_ENTITY where BEFORE_EXPR_ID is not null union all
select 'GW_EVENT_ENTITY_ATR' as tabla,INIT_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where INIT_EXPRESSION_ID is not null union all
select 'GW_EVENT_ENTITY_ATR' as tabla,VALID_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where VALID_EXPRESSION_ID is not null union all
select 'GW_PROC_PARAMETER' as tabla,EXPRESSION_ID from open.GW_PROC_PARAMETER where EXPRESSION_ID is not null union all
select 'PS_WHEN_MOTI_COMPON' as tabla,CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTI_COMPON where CONFIG_EXPRESSION_ID is not null union all
select 'PS_WHEN_PACKAGE' as tabla,CONFIG_EXPRESSION_ID from open.PS_WHEN_PACKAGE where CONFIG_EXPRESSION_ID is not null union all
select 'PS_PACKAGE_ACTION' as tabla,EXP_EXEC_ID from open.PS_PACKAGE_ACTION where EXP_EXEC_ID is not null union all
select 'PS_PROD_MOTI_ACTION' as tabla,PRE_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where PRE_EXP_EXEC_ID is not null union all
select 'PS_PROD_MOTI_ACTION' as tabla,POS_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where POS_EXP_EXEC_ID is not null union all
select 'PS_WHEN_MOTIVE' as tabla,CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTIVE where CONFIG_EXPRESSION_ID is not null union all
select 'GE_PROCESS' as tabla,CONFIG_EXPRESSION_ID from open.GE_PROCESS where CONFIG_EXPRESSION_ID is not null union all
select 'GE_ATTRIB_SET_ATTRIB' as tabla,VALID_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where VALID_EXPRESSION is not null union all
select 'GE_ATTRIB_SET_ATTRIB' as tabla,INITIAL_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where INITIAL_EXPRESSION is not null union all
select 'GE_SUBS_TYPE_ATTRIB' as tabla,VALID_EXPRESSION_ID from open.GE_SUBS_TYPE_ATTRIB where VALID_EXPRESSION_ID is not null union all
select 'GE_SUBS_TYPE_ATTRIB' as tabla,INIT_EXPRESSION_ID from open.GE_SUBS_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null union all
select 'LE_TIPOEVEN' as tabla,TIEVCORE from open.LE_TIPOEVEN where TIEVCORE is not null union all
select 'WF_INSTANCE' as tabla,PRE_EXPRESSION_ID from open.WF_INSTANCE where PRE_EXPRESSION_ID is not null union all
select 'WF_INSTANCE' as tabla,POS_EXPRESSION_ID from open.WF_INSTANCE where POS_EXPRESSION_ID is not null union all
select 'WF_INSTANCE' as tabla,ONLINE_EXEC_ID from open.WF_INSTANCE where ONLINE_EXEC_ID is not null union all
select 'WF_RECOVERY_ACTION' as tabla,CONFIG_EXPRESSION_ID from open.WF_RECOVERY_ACTION where CONFIG_EXPRESSION_ID is not null union all
select 'LD_QUOTA_ASSIGN_POLICY' as tabla,ASSIGN_RULE_ID from open.LD_QUOTA_ASSIGN_POLICY where ASSIGN_RULE_ID is not null union all
select 'IF_WHEN_LINK' as tabla,CONFIG_EXPRESSION_ID from open.IF_WHEN_LINK where CONFIG_EXPRESSION_ID is not null union all
select 'CC_ACTION_EVENT' as tabla,EXPRESSION from open.CC_ACTION_EVENT where EXPRESSION is not null union all
select 'IF_STATUS_ACTION' as tabla,BEFORE_EXPRE_ID from open.IF_STATUS_ACTION where BEFORE_EXPRE_ID is not null union all
select 'IF_STATUS_ACTION' as tabla,AFTER_EXPRE_ID from open.IF_STATUS_ACTION where AFTER_EXPRE_ID is not null union all
select 'IF_WHEN_ELEMENT' as tabla,CONFIG_EXPRESSION_ID from open.IF_WHEN_ELEMENT where CONFIG_EXPRESSION_ID is not null union all
select 'GE_ITEMS_TIPO_ATR' as tabla,REGLA_INICIO from open.GE_ITEMS_TIPO_ATR where REGLA_INICIO is not null union all
select 'GE_ITEMS_TIPO_ATR' as tabla,REGLA_VALIDACION from open.GE_ITEMS_TIPO_ATR where REGLA_VALIDACION is not null union all
select 'RESTPLDI' as tabla,REPDIDEX from open.RESTPLDI where REPDIDEX is not null union all
select 'IF_ELEMENT_ATTRIBUTE' as tabla,INITIALIZA_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where INITIALIZA_EXPRE_ID is not null union all
select 'IF_ELEMENT_ATTRIBUTE' as tabla,INSERT_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where INSERT_EXPRE_ID is not null union all
select 'IF_ELEMENT_ATTRIBUTE' as tabla,UPDATE_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where UPDATE_EXPRE_ID is not null union all
select 'PS_PACKAGE_ATTRIBS' as tabla,INIT_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select 'PS_PACKAGE_ATTRIBS' as tabla,VALID_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select 'PS_PROD_MOTI_ATTRIB' as tabla,VALID_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where VALID_EXPRESSION_ID is not null union all
select 'PS_PROD_MOTI_ATTRIB' as tabla,INIT_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where INIT_EXPRESSION_ID is not null union all
select 'PS_MOTI_COMP_ATTRIBS' as tabla,INIT_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select 'PS_MOTI_COMP_ATTRIBS' as tabla,VALID_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select 'PS_PROD_TYPE_ATTRIB' as tabla,INIT_EXPRESSION_ID from open.PS_PROD_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null union all
select 'WF_UNIT' as tabla,PRE_EXPRESSION_ID from open.WF_UNIT where PRE_EXPRESSION_ID is not null union all
select 'WF_UNIT' as tabla,POS_EXPRESSION_ID from open.WF_UNIT where POS_EXPRESSION_ID is not null union all
select 'WF_UNIT' as tabla,ONLINE_EXEC_ID from open.WF_UNIT where ONLINE_EXEC_ID is not null union all
select 'WF_UNIT_TYPE' as tabla,INIT_AREA_EXPRESSION_ID from open.WF_UNIT_TYPE where INIT_AREA_EXPRESSION_ID is not null union all
select 'GI_COMP_ATTRIBS' as tabla,INIT_EXPRESSION_ID from open.GI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select 'GI_COMP_ATTRIBS' as tabla,VALID_EXPRESSION_ID from open.GI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select 'GI_CONFIG' as tabla,ACCEPT_RULE_ID from open.GI_CONFIG where ACCEPT_RULE_ID is not null union all
select 'GI_FRAME' as tabla,AFTER_EXPRESSION_ID from open.GI_FRAME where AFTER_EXPRESSION_ID is not null union all
select 'GI_FRAME' as tabla,BEFORE_EXPRESSION_ID from open.GI_FRAME where BEFORE_EXPRESSION_ID is not null union all
select 'GI_PROPERTIES_CONFIG' as tabla,CONFIG_EXPRESSION_ID from open.GI_PROPERTIES_CONFIG where CONFIG_EXPRESSION_ID is not null union all
select 'OR_ACT_BY_TASK_MOD' as tabla,CONFIG_EXPRESSION_ID from open.OR_ACT_BY_TASK_MOD where CONFIG_EXPRESSION_ID is not null union all
select 'OR_ACT_BY_REQ_DATA' as tabla,CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_DATA where CONFIG_EXPRESSION_ID is not null union all
select 'OR_ACT_BY_REQ_ELEM' as tabla,CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_ELEM where CONFIG_EXPRESSION_ID is not null union all
select 'OR_NOTIF_TIPO_TRABA' as tabla,CONFIG_EXPRESSION_ID from open.OR_NOTIF_TIPO_TRABA where CONFIG_EXPRESSION_ID is not null union all
select 'LE_REGLVATA' as tabla,RVTAEXPR from open.LE_REGLVATA where RVTAEXPR is not null union all
select 'LE_CAMPUNRO' as tabla,CAURCORE from open.LE_CAMPUNRO where CAURCORE is not null union all
select 'LE_EQUITIEN' as tabla,EQTNREVA from open.LE_EQUITIEN where EQTNREVA is not null union all
select 'CONCCICL' as tabla,COCIREGL from open.CONCCICL where COCIREGL is not null union all
select 'CONCFESS' as tabla,CFSSREGL from open.CONCFESS where CFSSREGL is not null union all
select 'CONCFESU' as tabla,COFSREGL from open.CONCFESU where COFSREGL is not null union all
select 'CONCPLSU' as tabla,COPSREGL from open.CONCPLSU where COPSREGL is not null union all
select 'CONCSERV' as tabla,COSEREGL from open.CONCSERV where COSEREGL is not null union all
select 'CONCSESU' as tabla,COSSREGL from open.CONCSESU where COSSREGL is not null union all
select 'CONCSOPL' as tabla,COSOREGL from open.CONCSOPL where COSOREGL is not null union all
select 'CONCSUSC' as tabla,COSUREGL from open.CONCSUSC where COSUREGL is not null union all
select 'CONFESCO' as tabla,COECREGL from open.CONFESCO where COECREGL is not null union all
select 'GE_ITEMS_TIPO_ATR_LM' as tabla,REGLA_INICIO from open.GE_ITEMS_TIPO_ATR_LM where REGLA_INICIO is not null union all
select 'GE_ITEMS_TIPO_ATR_LM' as tabla,REGLA_VALIDACION from open.GE_ITEMS_TIPO_ATR_LM where REGLA_VALIDACION is not null union all
select 'LDC_BI_PROC_CRITICA_CONSUMO' as tabla,IDREGLACRITICA from open.LDC_BI_PROC_CRITICA_CONSUMO where IDREGLACRITICA is not null union all
select 'LDC_CONSALTO' as tabla,COALREGL from open.LDC_CONSALTO where COALREGL is not null union all
select 'LDC_CONSUALTO' as tabla,COALREGL from open.LDC_CONSUALTO where COALREGL is not null union all
select 'LDC_LECTMENO' as tabla,LEMEREGL from open.LDC_LECTMENO where LEMEREGL is not null union all
select 'LDC_REGFACPROD' as tabla,REGLA_INICIAL from open.LDC_REGFACPROD where REGLA_INICIAL is not null union all
select 'LDC_REGFACPROD' as tabla,REGLA_FINAL from open.LDC_REGFACPROD where REGLA_FINAL is not null 

)
select base.tabla, count(1), count(distinct c.config_expression_id), count(distinct c.expression)
from base
inner join open.gr_config_expression c on c.config_expression_id=base.DECBREVA
group by base.tabla
;


select *
from dba_tab_columns TC
where owner='OPEN'
 AND COLUMN_NAME LIKE '%REGL%'
 AND DATA_TYPE='NUMBER'
 AND NOT EXISTS(
 select NULL
from dba_cons_columns u 
inner join dba_constraints hija on u.CONSTRAINT_NAME = hija.constraint_name and hija.constraint_type='R' 
inner join dba_constraints padre on hija.r_constraint_name = padre.constraint_name and hija.r_owner = padre.owner 
WHERE u.column_name=TC.COLUMN_NAME
  AND hija.table_name=TC.TABLE_NAME
 )
 
