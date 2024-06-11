with base as(
select REGLA_VALIDACION from open.GE_ITEMS_TIPO_ATR where REGLA_VALIDACION is not null union all
select REGLA_INICIO from open.GE_ITEMS_TIPO_ATR where REGLA_INICIO is not null union all
select PACTREGL from open.LE_PARACATR where PACTREGL is not null union all
select RULE_ID from open.GE_ACT_PRODTYPE_STAT where RULE_ID is not null union all
select VALID_EXPRESSION_4_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_4_ID is not null union all
select VALID_EXPRESSION_3_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_3_ID is not null union all
select VALID_EXPRESSION_2_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_2_ID is not null union all
select VALID_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_1_ID is not null union all
select INIT_EXPRESSION_4_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_4_ID is not null union all
select INIT_EXPRESSION_3_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_3_ID is not null union all
select INIT_EXPRESSION_2_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_2_ID is not null union all
select INIT_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_1_ID is not null union all
select ACGCREGL from open.ACTIGECO where ACGCREGL is not null union all
select ACGCREVP from open.ACTIGECO where ACGCREVP is not null union all
select ACGCREFA from open.ACTIGECO where ACGCREFA is not null union all
select CONFIG_EXPRESSION_ID from open.PM_STAGE where CONFIG_EXPRESSION_ID is not null union all
select TIFRCEID from open.ED_TIPOFRAN where TIFRCEID is not null union all
select ITEMCEID from open.ED_ITEM where ITEMCEID is not null union all
select CONFIG_EXPRESSION_ID from open.GE_MESG_ALERT where CONFIG_EXPRESSION_ID is not null union all
select CAURCORE from open.LE_CAMPUNRO where CAURCORE is not null union all
select ERROR_EXPRESION_ID from open.GE_VARIABLE where ERROR_EXPRESION_ID is not null union all
select INIT_EXPRESSION_ID from open.GE_TEMPLATE_VAR where INIT_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GE_TEMPLATE_VAR where VALID_EXPRESSION_ID is not null union all
select ERROR_EXPRESSION_ID from open.GE_TEMPLATE_VAR where ERROR_EXPRESSION_ID is not null union all
select DETCRECA from open.GST_DETATACO where DETCRECA is not null union all
select INITIAL_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where INITIAL_EXPRESSION is not null union all
select VALID_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where VALID_EXPRESSION is not null union all
select CONFIG_EXPRESSION_ID from open.WF_RECOVERY_ACTION where CONFIG_EXPRESSION_ID is not null union all
select ONLINE_EXEC_ID from open.WF_INSTANCE where ONLINE_EXEC_ID is not null union all
select POS_EXPRESSION_ID from open.WF_INSTANCE where POS_EXPRESSION_ID is not null union all
select PRE_EXPRESSION_ID from open.WF_INSTANCE where PRE_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.GE_PROCESS where CONFIG_EXPRESSION_ID is not null union all
select TIEVCORE from open.LE_TIPOEVEN where TIEVCORE is not null union all
select CONFIG_EXPRESSION_ID from open.IF_WHEN_LINK where CONFIG_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GE_SUBS_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GE_SUBS_TYPE_ATTRIB where VALID_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.GE_WHEN_ENTITY_EVENT where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.IF_WHEN_ELEMENT where CONFIG_EXPRESSION_ID is not null union all
select CODVIDPV from open.RC_CONDDEVA where CODVIDPV is not null union all
select COGVIDPA from open.RC_CONDGEVA where COGVIDPA is not null union all
select COGVIDPP from open.RC_CONDGEVA where COGVIDPP is not null union all
select AFTER_EXPRE_ID from open.IF_STATUS_ACTION where AFTER_EXPRE_ID is not null union all
select BEFORE_EXPRE_ID from open.IF_STATUS_ACTION where BEFORE_EXPRE_ID is not null union all
select EXPRESSION from open.CC_ACTION_EVENT where EXPRESSION is not null union all
select CONFIG_EXPRESSION_ID from open.OR_OPUNI_TSKTYP_NOTI where CONFIG_EXPRESSION_ID is not null union all
select TIBLCEID from open.ED_TIPOBLOQ where TIBLCEID is not null union all
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_ELEM where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_DATA where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_TASK_MOD where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.GI_PROPERTIES_CONFIG where CONFIG_EXPRESSION_ID is not null union all
select BEFORE_EXPRESSION_ID from open.GI_FRAME where BEFORE_EXPRESSION_ID is not null union all
select AFTER_EXPRESSION_ID from open.GI_FRAME where AFTER_EXPRESSION_ID is not null union all
select ACCEPT_RULE_ID from open.GI_CONFIG where ACCEPT_RULE_ID is not null union all
select VALID_EXPRESSION_ID from open.GI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select PRCAREAS from open.PROGCART where PRCAREAS is not null union all
select RECAIDRE from open.REGLCALI where RECAIDRE is not null union all
select DECBREIN from open.TA_DEFICRBT where DECBREIN is not null union all
select DECBREVA from open.TA_DEFICRBT where DECBREVA is not null union all
select PRE_EXPRESSION_ID from open.OR_TRANSITION where PRE_EXPRESSION_ID is not null union all
select POST_EXPRESSION_ID from open.OR_TRANSITION where POST_EXPRESSION_ID is not null union all
select ASSIGN_RULE_ID from open.LD_QUOTA_ASSIGN_POLICY where ASSIGN_RULE_ID is not null union all
select EQTNREVA from open.LE_EQUITIEN where EQTNREVA is not null union all
select CONFIG_EXPRESSION_ID from open.OR_NOTIF_TIPO_TRABA where CONFIG_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where INIT_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where VALID_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select UPDATE_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where UPDATE_EXPRE_ID is not null union all
select INSERT_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where INSERT_EXPRE_ID is not null union all
select INITIALIZA_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where INITIALIZA_EXPRE_ID is not null union all
select UPDATE_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where UPDATE_EXPRE_ID is not null union all
select INSERT_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where INSERT_EXPRE_ID is not null union all
select INITIALIZA_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where INITIALIZA_EXPRE_ID is not null union all
select CONFIG_EXPRESSION_ID from open.IF_CAPACITY_TYPE where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.AB_DOMAIN_COMP where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.IN_MESSAGE_TYPE where CONFIG_EXPRESSION_ID is not null union all
select RVTAEXPR from open.LE_REGLVATA where RVTAEXPR is not null union all
select CONFIG_EXPRESSION_ID from open.CT_CONDITIONS where CONFIG_EXPRESSION_ID is not null union all
select REPDIDEX from open.RESTPLDI where REPDIDEX is not null union all
select INIT_AREA_EXPRESSION_ID from open.WF_UNIT_TYPE where INIT_AREA_EXPRESSION_ID is not null union all
select ONLINE_EXEC_ID from open.WF_UNIT where ONLINE_EXEC_ID is not null union all
select POS_EXPRESSION_ID from open.WF_UNIT where POS_EXPRESSION_ID is not null union all
select PRE_EXPRESSION_ID from open.WF_UNIT where PRE_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_PROD_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null union all
select REC_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where REC_CONFIG_EXPRES_ID is not null union all
select SEN_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where SEN_CONFIG_EXPRES_ID is not null union all
select POS_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where POS_EXP_EXEC_ID is not null union all
select PRE_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where PRE_EXP_EXEC_ID is not null union all
select EXP_EXEC_ID from open.PS_PACKAGE_ACTION where EXP_EXEC_ID is not null union all
select VALID_EXPRESSION from open.GE_ATTRIBUTES where VALID_EXPRESSION is not null union all
select CONFIG_EXPRESSION_ID from open.GE_ACTION_MODULE where CONFIG_EXPRESSION_ID is not null union all
select BANCIDRE from open.BANCO where BANCIDRE is not null union all
select VALI_DOC_SELE_EXP_ID from open.IN_INTERFACE_MESSAGE where VALI_DOC_SELE_EXP_ID is not null union all
select TARGET_MODULE_EXP_ID from open.IN_INTERFACE_MESSAGE where TARGET_MODULE_EXP_ID is not null union all
select POS_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where POS_CONFIG_EXPRES_ID is not null union all
select PRE_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where PRE_CONFIG_EXPRES_ID is not null union all
select CONFIG_EXPRESSION_ID from open.FM_MULTLVL_METHOD where CONFIG_EXPRESSION_ID is not null union all
select CAFPREGL from open.LE_CAFRPERF where CAFPREGL is not null union all
select BEFORE_EXPRE_ID from open.PS_MOTIVE_ACTION where BEFORE_EXPRE_ID is not null union all
select AFTER_EXPRE_ID from open.PS_MOTIVE_ACTION where AFTER_EXPRE_ID is not null union all
select CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTIVE where CONFIG_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where INIT_EXPRESSION_ID is not null union all
select ENCOIDRE from open.ENTICOBR where ENCOIDRE is not null union all
select PLSUREAP from open.PLANSUSC where PLSUREAP is not null union all
select CONFIG_EXPRESSION_ID from open.CC_PROM_DETAIL where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.PS_WHEN_PACKAGE where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTI_COMPON where CONFIG_EXPRESSION_ID is not null union all
select EXPRESSION_ID from open.GW_PROC_PARAMETER where EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where INIT_EXPRESSION_ID is not null union all
select BEFORE_EXPR_ID from open.GW_EVENT_ENTITY where BEFORE_EXPR_ID is not null 
)
, base2 as(
select distinct regla_validacion
from base)

select c.config_expression_id, description, object_name
from open.gr_config_expression c
where not exists(select null from base2 where base2.regla_validacion=c.config_expression_id)
;



with base as(
select REGLA_VALIDACION from open.GE_ITEMS_TIPO_ATR where REGLA_VALIDACION is not null union all
select REGLA_INICIO from open.GE_ITEMS_TIPO_ATR where REGLA_INICIO is not null union all
select PACTREGL from open.LE_PARACATR where PACTREGL is not null union all
select RULE_ID from open.GE_ACT_PRODTYPE_STAT where RULE_ID is not null union all
select VALID_EXPRESSION_4_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_4_ID is not null union all
select VALID_EXPRESSION_3_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_3_ID is not null union all
select VALID_EXPRESSION_2_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_2_ID is not null union all
select VALID_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_1_ID is not null union all
select INIT_EXPRESSION_4_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_4_ID is not null union all
select INIT_EXPRESSION_3_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_3_ID is not null union all
select INIT_EXPRESSION_2_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_2_ID is not null union all
select INIT_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_1_ID is not null union all
select ACGCREGL from open.ACTIGECO where ACGCREGL is not null union all
select ACGCREVP from open.ACTIGECO where ACGCREVP is not null union all
select ACGCREFA from open.ACTIGECO where ACGCREFA is not null union all
select CONFIG_EXPRESSION_ID from open.PM_STAGE where CONFIG_EXPRESSION_ID is not null union all
select TIFRCEID from open.ED_TIPOFRAN where TIFRCEID is not null union all
select ITEMCEID from open.ED_ITEM where ITEMCEID is not null union all
select CONFIG_EXPRESSION_ID from open.GE_MESG_ALERT where CONFIG_EXPRESSION_ID is not null union all
select CAURCORE from open.LE_CAMPUNRO where CAURCORE is not null union all
select ERROR_EXPRESION_ID from open.GE_VARIABLE where ERROR_EXPRESION_ID is not null union all
select INIT_EXPRESSION_ID from open.GE_TEMPLATE_VAR where INIT_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GE_TEMPLATE_VAR where VALID_EXPRESSION_ID is not null union all
select ERROR_EXPRESSION_ID from open.GE_TEMPLATE_VAR where ERROR_EXPRESSION_ID is not null union all
select DETCRECA from open.GST_DETATACO where DETCRECA is not null union all
select INITIAL_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where INITIAL_EXPRESSION is not null union all
select VALID_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where VALID_EXPRESSION is not null union all
select CONFIG_EXPRESSION_ID from open.WF_RECOVERY_ACTION where CONFIG_EXPRESSION_ID is not null union all
select ONLINE_EXEC_ID from open.WF_INSTANCE where ONLINE_EXEC_ID is not null union all
select POS_EXPRESSION_ID from open.WF_INSTANCE where POS_EXPRESSION_ID is not null union all
select PRE_EXPRESSION_ID from open.WF_INSTANCE where PRE_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.GE_PROCESS where CONFIG_EXPRESSION_ID is not null union all
select TIEVCORE from open.LE_TIPOEVEN where TIEVCORE is not null union all
select CONFIG_EXPRESSION_ID from open.IF_WHEN_LINK where CONFIG_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GE_SUBS_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GE_SUBS_TYPE_ATTRIB where VALID_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.GE_WHEN_ENTITY_EVENT where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.IF_WHEN_ELEMENT where CONFIG_EXPRESSION_ID is not null union all
select CODVIDPV from open.RC_CONDDEVA where CODVIDPV is not null union all
select COGVIDPA from open.RC_CONDGEVA where COGVIDPA is not null union all
select COGVIDPP from open.RC_CONDGEVA where COGVIDPP is not null union all
select AFTER_EXPRE_ID from open.IF_STATUS_ACTION where AFTER_EXPRE_ID is not null union all
select BEFORE_EXPRE_ID from open.IF_STATUS_ACTION where BEFORE_EXPRE_ID is not null union all
select EXPRESSION from open.CC_ACTION_EVENT where EXPRESSION is not null union all
select CONFIG_EXPRESSION_ID from open.OR_OPUNI_TSKTYP_NOTI where CONFIG_EXPRESSION_ID is not null union all
select TIBLCEID from open.ED_TIPOBLOQ where TIBLCEID is not null union all
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_ELEM where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_DATA where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_TASK_MOD where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.GI_PROPERTIES_CONFIG where CONFIG_EXPRESSION_ID is not null union all
select BEFORE_EXPRESSION_ID from open.GI_FRAME where BEFORE_EXPRESSION_ID is not null union all
select AFTER_EXPRESSION_ID from open.GI_FRAME where AFTER_EXPRESSION_ID is not null union all
select ACCEPT_RULE_ID from open.GI_CONFIG where ACCEPT_RULE_ID is not null union all
select VALID_EXPRESSION_ID from open.GI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select PRCAREAS from open.PROGCART where PRCAREAS is not null union all
select RECAIDRE from open.REGLCALI where RECAIDRE is not null union all
select DECBREIN from open.TA_DEFICRBT where DECBREIN is not null union all
select DECBREVA from open.TA_DEFICRBT where DECBREVA is not null union all
select PRE_EXPRESSION_ID from open.OR_TRANSITION where PRE_EXPRESSION_ID is not null union all
select POST_EXPRESSION_ID from open.OR_TRANSITION where POST_EXPRESSION_ID is not null union all
select ASSIGN_RULE_ID from open.LD_QUOTA_ASSIGN_POLICY where ASSIGN_RULE_ID is not null union all
select EQTNREVA from open.LE_EQUITIEN where EQTNREVA is not null union all
select CONFIG_EXPRESSION_ID from open.OR_NOTIF_TIPO_TRABA where CONFIG_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where INIT_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where VALID_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where INIT_EXPRESSION_ID is not null union all
select UPDATE_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where UPDATE_EXPRE_ID is not null union all
select INSERT_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where INSERT_EXPRE_ID is not null union all
select INITIALIZA_EXPRE_ID from open.IF_ELEMENT_ATTRIBUTE where INITIALIZA_EXPRE_ID is not null union all
select UPDATE_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where UPDATE_EXPRE_ID is not null union all
select INSERT_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where INSERT_EXPRE_ID is not null union all
select INITIALIZA_EXPRE_ID from open.IF_CAPA_ELEM_ATTR where INITIALIZA_EXPRE_ID is not null union all
select CONFIG_EXPRESSION_ID from open.IF_CAPACITY_TYPE where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.AB_DOMAIN_COMP where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.IN_MESSAGE_TYPE where CONFIG_EXPRESSION_ID is not null union all
select RVTAEXPR from open.LE_REGLVATA where RVTAEXPR is not null union all
select CONFIG_EXPRESSION_ID from open.CT_CONDITIONS where CONFIG_EXPRESSION_ID is not null union all
select REPDIDEX from open.RESTPLDI where REPDIDEX is not null union all
select INIT_AREA_EXPRESSION_ID from open.WF_UNIT_TYPE where INIT_AREA_EXPRESSION_ID is not null union all
select ONLINE_EXEC_ID from open.WF_UNIT where ONLINE_EXEC_ID is not null union all
select POS_EXPRESSION_ID from open.WF_UNIT where POS_EXPRESSION_ID is not null union all
select PRE_EXPRESSION_ID from open.WF_UNIT where PRE_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.PS_PROD_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null union all
select REC_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where REC_CONFIG_EXPRES_ID is not null union all
select SEN_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where SEN_CONFIG_EXPRES_ID is not null union all
select POS_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where POS_EXP_EXEC_ID is not null union all
select PRE_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where PRE_EXP_EXEC_ID is not null union all
select EXP_EXEC_ID from open.PS_PACKAGE_ACTION where EXP_EXEC_ID is not null union all
select VALID_EXPRESSION from open.GE_ATTRIBUTES where VALID_EXPRESSION is not null union all
select CONFIG_EXPRESSION_ID from open.GE_ACTION_MODULE where CONFIG_EXPRESSION_ID is not null union all
select BANCIDRE from open.BANCO where BANCIDRE is not null union all
select VALI_DOC_SELE_EXP_ID from open.IN_INTERFACE_MESSAGE where VALI_DOC_SELE_EXP_ID is not null union all
select TARGET_MODULE_EXP_ID from open.IN_INTERFACE_MESSAGE where TARGET_MODULE_EXP_ID is not null union all
select POS_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where POS_CONFIG_EXPRES_ID is not null union all
select PRE_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where PRE_CONFIG_EXPRES_ID is not null union all
select CONFIG_EXPRESSION_ID from open.FM_MULTLVL_METHOD where CONFIG_EXPRESSION_ID is not null union all
select CAFPREGL from open.LE_CAFRPERF where CAFPREGL is not null union all
select BEFORE_EXPRE_ID from open.PS_MOTIVE_ACTION where BEFORE_EXPRE_ID is not null union all
select AFTER_EXPRE_ID from open.PS_MOTIVE_ACTION where AFTER_EXPRE_ID is not null union all
select CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTIVE where CONFIG_EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where INIT_EXPRESSION_ID is not null union all
select ENCOIDRE from open.ENTICOBR where ENCOIDRE is not null union all
select PLSUREAP from open.PLANSUSC where PLSUREAP is not null union all
select CONFIG_EXPRESSION_ID from open.CC_PROM_DETAIL where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.PS_WHEN_PACKAGE where CONFIG_EXPRESSION_ID is not null union all
select CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTI_COMPON where CONFIG_EXPRESSION_ID is not null union all
select EXPRESSION_ID from open.GW_PROC_PARAMETER where EXPRESSION_ID is not null union all
select VALID_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where VALID_EXPRESSION_ID is not null union all
select INIT_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where INIT_EXPRESSION_ID is not null union all
select BEFORE_EXPR_ID from open.GW_EVENT_ENTITY where BEFORE_EXPR_ID is not null 
)
, base2 as(
select distinct regla_validacion
from base)

select c.config_expression_id, description, object_name
from open.gr_config_expression c
where exists(select null from base2 where base2.regla_validacion=c.config_expression_id);



select RULE_ID from open.GE_ACT_PRODTYPE_STAT where RULE_ID is not null ;
select VALID_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where VALID_EXPRESSION_1_ID is not null ;
select INIT_EXPRESSION_1_ID from open.GE_ITEMS_ATTRIBUTES where INIT_EXPRESSION_1_ID is not null ;
select ITEMCEID from open.ED_ITEM where ITEMCEID is not null ;
select CONFIG_EXPRESSION_ID from open.GE_MESG_ALERT where CONFIG_EXPRESSION_ID is not null ;
select ERROR_EXPRESSION_ID from open.GE_TEMPLATE_VAR where ERROR_EXPRESSION_ID is not null ;
select INITIAL_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where INITIAL_EXPRESSION is not null ;
select VALID_EXPRESSION from open.GE_ATTRIB_SET_ATTRIB where VALID_EXPRESSION is not null ;
select POS_EXPRESSION_ID from open.WF_INSTANCE where POS_EXPRESSION_ID is not null ;
select PRE_EXPRESSION_ID from open.WF_INSTANCE where PRE_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.GE_PROCESS where CONFIG_EXPRESSION_ID is not null ;
select CODVIDPV from open.RC_CONDDEVA where CODVIDPV is not null ;
select EXPRESSION from open.CC_ACTION_EVENT where EXPRESSION is not null ;
select CONFIG_EXPRESSION_ID from open.OR_OPUNI_TSKTYP_NOTI where CONFIG_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_REQ_DATA where CONFIG_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.OR_ACT_BY_TASK_MOD where CONFIG_EXPRESSION_ID is not null ;
select BEFORE_EXPRESSION_ID from open.GI_FRAME where BEFORE_EXPRESSION_ID is not null ;
select AFTER_EXPRESSION_ID from open.GI_FRAME where AFTER_EXPRESSION_ID is not null ;
select ACCEPT_RULE_ID from open.GI_CONFIG where ACCEPT_RULE_ID is not null ;
select VALID_EXPRESSION_ID from open.GI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.GI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null ;
select PRCAREAS from open.PROGCART where PRCAREAS is not null ;
select DECBREIN from open.TA_DEFICRBT where DECBREIN is not null ;
select DECBREVA from open.TA_DEFICRBT where DECBREVA is not null ;
select POST_EXPRESSION_ID from open.OR_TRANSITION where POST_EXPRESSION_ID is not null ;
select ASSIGN_RULE_ID from open.LD_QUOTA_ASSIGN_POLICY where ASSIGN_RULE_ID is not null ;
select VALID_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where VALID_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.PS_MOTI_COMP_ATTRIBS where INIT_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where INIT_EXPRESSION_ID is not null ;
select VALID_EXPRESSION_ID from open.PS_PROD_MOTI_ATTRIB where VALID_EXPRESSION_ID is not null ;
select VALID_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where VALID_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.PS_PACKAGE_ATTRIBS where INIT_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.IN_MESSAGE_TYPE where CONFIG_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.CT_CONDITIONS where CONFIG_EXPRESSION_ID is not null ;


select REPDIDEX from open.RESTPLDI where REPDIDEX is not null ;
select INIT_AREA_EXPRESSION_ID from open.WF_UNIT_TYPE where INIT_AREA_EXPRESSION_ID is not null ;
select ONLINE_EXEC_ID from open.WF_UNIT where ONLINE_EXEC_ID is not null ;
select POS_EXPRESSION_ID from open.WF_UNIT where POS_EXPRESSION_ID is not null ;
select PRE_EXPRESSION_ID from open.WF_UNIT where PRE_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.PS_PROD_TYPE_ATTRIB where INIT_EXPRESSION_ID is not null ;
select REC_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where REC_CONFIG_EXPRES_ID is not null ;
select SEN_CONFIG_EXPRES_ID from open.IN_INTERF_TYPE_BATCH where SEN_CONFIG_EXPRES_ID is not null ;
select POS_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where POS_EXP_EXEC_ID is not null ;
select PRE_EXP_EXEC_ID from open.PS_PROD_MOTI_ACTION where PRE_EXP_EXEC_ID is not null ;
select EXP_EXEC_ID from open.PS_PACKAGE_ACTION where EXP_EXEC_ID is not null ;
select VALID_EXPRESSION from open.GE_ATTRIBUTES where VALID_EXPRESSION is not null ;
select CONFIG_EXPRESSION_ID from open.GE_ACTION_MODULE where CONFIG_EXPRESSION_ID is not null ;
select BANCIDRE from open.BANCO where BANCIDRE is not null ;
select VALI_DOC_SELE_EXP_ID from open.IN_INTERFACE_MESSAGE where VALI_DOC_SELE_EXP_ID is not null ;
select TARGET_MODULE_EXP_ID from open.IN_INTERFACE_MESSAGE where TARGET_MODULE_EXP_ID is not null ;
select POS_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where POS_CONFIG_EXPRES_ID is not null ;
select PRE_CONFIG_EXPRES_ID from open.IN_STATUS_TRANSITION where PRE_CONFIG_EXPRES_ID is not null ;
select CONFIG_EXPRESSION_ID from open.FM_MULTLVL_METHOD where CONFIG_EXPRESSION_ID is not null ;
select CAFPREGL from open.LE_CAFRPERF where CAFPREGL is not null ;
select BEFORE_EXPRE_ID from open.PS_MOTIVE_ACTION where BEFORE_EXPRE_ID is not null ;
select AFTER_EXPRE_ID from open.PS_MOTIVE_ACTION where AFTER_EXPRE_ID is not null ;
select CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTIVE where CONFIG_EXPRESSION_ID is not null ;
select VALID_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where VALID_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.GE_ENTITY_ATTRIBUTES where INIT_EXPRESSION_ID is not null ;
select ENCOIDRE from open.ENTICOBR where ENCOIDRE is not null ;
select PLSUREAP from open.PLANSUSC where PLSUREAP is not null ;
select CONFIG_EXPRESSION_ID from open.CC_PROM_DETAIL where CONFIG_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.PS_WHEN_PACKAGE where CONFIG_EXPRESSION_ID is not null ;
select CONFIG_EXPRESSION_ID from open.PS_WHEN_MOTI_COMPON where CONFIG_EXPRESSION_ID is not null ;
select EXPRESSION_ID from open.GW_PROC_PARAMETER where EXPRESSION_ID is not null ;
select VALID_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where VALID_EXPRESSION_ID is not null ;
select INIT_EXPRESSION_ID from open.GW_EVENT_ENTITY_ATR where INIT_EXPRESSION_ID is not null ;
select BEFORE_EXPR_ID from open.GW_EVENT_ENTITY where BEFORE_EXPR_ID is not null
