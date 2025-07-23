BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100030_',
'CREATE OR REPLACE PACKAGE RQTY_100030_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyPS_PACKAGE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACKAGE_TYPERowId tyPS_PACKAGE_TYPERowId;type tyPS_PACKAGE_ACTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACKAGE_ACTIONRowId tyPS_PACKAGE_ACTIONRowId;type tyPS_PACKAGE_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACKAGE_ATTRIBSRowId tyPS_PACKAGE_ATTRIBSRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyPS_PACK_TYPE_PARAMRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACK_TYPE_PARAMRowId tyPS_PACK_TYPE_PARAMRowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyPS_PACKAGE_UNITTYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACKAGE_UNITTYPERowId tyPS_PACKAGE_UNITTYPERowId;type tySERVICIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSERVICIORowId tySERVICIORowId;type tyPS_PRODUCT_MOTIVERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PRODUCT_MOTIVERowId tyPS_PRODUCT_MOTIVERowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyPS_PACK_TYPE_VALIDRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACK_TYPE_VALIDRowId tyPS_PACK_TYPE_VALIDRowId;type tyPS_PACKAGE_EVENTSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACKAGE_EVENTSRowId tyPS_PACKAGE_EVENTSRowId;type tyPS_WHEN_PACKAGERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_WHEN_PACKAGERowId tyPS_WHEN_PACKAGERowId;type tyPS_PRD_MOTIV_PACKAGERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PRD_MOTIV_PACKAGERowId tyPS_PRD_MOTIV_PACKAGERowId;type tyPS_MOTIVE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_MOTIVE_TYPERowId tyPS_MOTIVE_TYPERowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type tyGE_SERVICE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_SERVICE_CLASSRowId tyGE_SERVICE_CLASSRowId;type tyTIPOSERVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbTIPOSERVRowId tyTIPOSERVRowId;type tyGE_SERVICE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_SERVICE_TYPERowId tyGE_SERVICE_TYPERowId;type tyGE_STATEMENT_COLUMNSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENT_COLUMNSRowId tyGE_STATEMENT_COLUMNSRowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGE_NOTIFICATIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_NOTIFICATIONRowId tyGE_NOTIFICATIONRowId;type ty0_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIGURA_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty5_0 is table of PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of PS_PACKAGE_TYPE.ACTION_REGIS_EXEC%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_4 is table of PS_PACKAGE_TYPE.TAG_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb5_4 ty5_4; ' || chr(10) ||
'tb5_4 ty5_4;type ty6_0 is table of PS_PACKAGE_ATTRIBS.PACKAGE_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of PS_PACKAGE_ATTRIBS.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of PS_PACKAGE_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty6_3 is table of PS_PACKAGE_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_3 ty6_3; ' || chr(10) ||
'tb6_3 ty6_3;type ty6_4 is table of PS_PACKAGE_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb6_4 ty6_4; ' || chr(10) ||
'tb6_4 ty6_4;type ty6_5 is table of PS_PACKAGE_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_5 ty6_5; ' || chr(10) ||
'tb6_5 ty6_5;type ty6_6 is table of PS_PACKAGE_ATTRIBS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_6 ty6_6; ' || chr(10) ||
'tb6_6 ty6_6;type ty6_7 is table of PS_PACKAGE_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_7 ty6_7; ' || chr(10) ||
'tb6_7 ty6_7;type ty6_8 is table of PS_PACKAGE_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_8 ty6_8; ' || chr(10) ||
'tb6_8 ty6_8;type ty6_9 is table of PS_PACKAGE_ATTRIBS.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_9 ty6_9; ' || chr(10) ||
'tb6_9 ty6_9;type ty7_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty9_0 is table of PS_PACK_TYPE_PARAM.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of PS_PACK_TYPE_PARAM.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty10_0 is table of PS_PACKAGE_UNITTYPE.PACKAGE_UNITTYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of PS_PACKAGE_UNITTYPE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of PS_PACKAGE_UNITTYPE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty10_3 is table of PS_PACKAGE_UNITTYPE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_3 ty10_3; ' || chr(10) ||
'tb10_3 ty10_3;type ty11_0 is table of WF_ATTRIBUTES_EQUIV.ATTRIBUTES_EQUIV_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of WF_ATTRIBUTES_EQUIV.VALUE_1%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty12_0 is table of PS_PACKAGE_EVENTS.PACKAGE_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of PS_PACKAGE_EVENTS.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty13_0 is table of PS_WHEN_PACKAGE.WHEN_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty13_1 is table of PS_WHEN_PACKAGE.PACKAGE_EVENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_1 ty13_1; ' || chr(10) ||
'tb13_1 ty13_1;type ty13_2 is table of PS_WHEN_PACKAGE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_2 ty13_2; ' || chr(10) ||
'tb13_2 ty13_2;type ty14_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty15_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_0 ty15_0; ' || chr(10) ||
'tb15_0 ty15_0;type ty16_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb16_0 ty16_0; ' || chr(10) ||
'tb16_0 ty16_0;type ty16_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb16_1 ty16_1; ' || chr(10) ||
'tb16_1 ty16_1;type ty16_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb16_2 ty16_2; ' || chr(10) ||
'tb16_2 ty16_2;type ty16_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb16_3 ty16_3; ' || chr(10) ||
'tb16_3 ty16_3;type ty17_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_0 ty17_0; ' || chr(10) ||
'tb17_0 ty17_0;type ty18_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_0 ty18_0; ' || chr(10) ||
'tb18_0 ty18_0;type ty18_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_1 ty18_1; ' || chr(10) ||
'tb18_1 ty18_1;type ty18_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_2 ty18_2; ' || chr(10) ||
'tb18_2 ty18_2;type ty18_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_3 ty18_3; ' || chr(10) ||
'tb18_3 ty18_3;type ty19_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_0 ty19_0; ' || chr(10) ||
'tb19_0 ty19_0;type ty19_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_1 ty19_1; ' || chr(10) ||
'tb19_1 ty19_1;type ty19_3 is table of PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_3 ty19_3; ' || chr(10) ||
'tb19_3 ty19_3;--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM ' || chr(10) ||
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100030 ' || chr(10) ||
'AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id ' || chr(10) ||
'AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression; ' || chr(10) ||
'nuIndex     number; ' || chr(10) ||
'tbExpressionsId      dagr_config_expression.tytbConfig_Expression_Id; ' || chr(10) ||
' ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
'clColumn_0 clob; ' || chr(10) ||
'clColumn_1 clob;clColumn_2 clob; ' || chr(10) ||
'END RQTY_100030_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100030_******************************'); END;
/

BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
UPDATE gi_comp_attribs
SET    init_expression_id = null,
valid_expression_id = null,
select_statement_id = null
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id =
(
SELECT  config_id
FROM    gi_config
WHERE   config_type_id = 4
AND     entity_root_id = 2012
AND     external_root_id = 100030
)
);

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100030_.cuExpressions;
fetch RQTY_100030_.cuExpressions bulk collect INTO RQTY_100030_.tbExpressionsId;
close RQTY_100030_.cuExpressions;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100030_.tbEntityName(-1) := 'NULL';
   RQTY_100030_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(2374) := 'MO_PACKAGES@ATTENTION_DATE';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(2666) := 'MO_PACKAGES@DISTRIBUT_ADMIN_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(419) := 'MO_PROCESS@PRODUCT_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(1040) := 'MO_PROCESS@GEOGRAP_LOCATION_ID';
   RQTY_100030_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100030_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100030_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQTY_100030_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(175491) := 'MO_PACKAGES@ORDER_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(260) := 'MO_PACKAGES@USER_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(702) := 'MO_PROCESS@ADDRESS';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(41406) := 'MO_PACKAGES@ZONE_ADMIN_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(261) := 'MO_PACKAGES@TERMINAL_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(2508) := 'MO_PROCESS@DUMMY';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(40909) := 'MO_PACKAGES@ORGANIZAT_AREA_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(42655) := 'MO_PROCESS@NEIGHBORTHOOD_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(1137) := 'MO_PROCESS@NACIONALITY';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(182398) := 'MO_PACKAGES@MANAGEMENT_AREA_ID';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(1081) := 'MO_PROCESS@SUBSCRIBER_ID';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQTY_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100030_.tbEntityAttributeName(42279) := 'MO_PROCESS@REQUEST_ID_EXTERN';
   RQTY_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100030_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100030
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100030
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100030
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100030
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100030_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACKAGE_ATTRIBS',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACKAGE_ATTRIBS WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100030_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100030_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACK_TYPE_PARAM',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACK_TYPE_PARAM WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100030_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100030_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACKAGE_UNITTYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACKAGE_UNITTYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100030_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100030_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACK_TYPE_VALID',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACK_TYPE_VALID WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_ATTRIBUTES_EQUIV',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_ATTRIBUTES_EQUIV WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_PACKAGE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_WHEN_PACKAGE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACKAGE_EVENTS',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACKAGE_EVENTS WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030))));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030))));

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PRD_MOTIV_PACKAGE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PRD_MOTIV_PACKAGE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100030_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100030_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100030_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100030_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100030_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100030_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100030_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100030_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030)));

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030));
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100030_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030);
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACKAGE_ACTION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACKAGE_ACTION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100030_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100030_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100030_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100030_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100030;
nuIndex binary_integer;
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PACKAGE_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PACKAGE_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100030_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100030_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100030_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100030_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100030_.tb0_0(0),
DESCRIPTION='GENERAL'
,
MNEMONIC='GE'
,
LAST_MESSAGE=614,
PATH_MODULE='GENERAL'
,
ICON_NAME='mod_admcnf'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = RQTY_100030_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100030_.tb0_0(0),
'GENERAL'
,
'GE'
,
614,
'GENERAL'
,
'mod_admcnf'
,
'IN'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb1_0(0):=1;
RQTY_100030_.tb1_1(0):=RQTY_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100030_.tb1_0(0),
MODULE_ID=RQTY_100030_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100030_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100030_.tb1_0(0),
RQTY_100030_.tb1_1(0),
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(0):=121407559;
RQTY_100030_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(0):=RQTY_100030_.tb2_0(0);
RQTY_100030_.old_tb2_1(0):='GE_EXEACTION_CT1E121407559'
;
RQTY_100030_.tb2_1(0):=RQTY_100030_.tb2_0(0);
RQTY_100030_.tb2_2(0):=RQTY_100030_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(0),
RQTY_100030_.tb2_1(0),
RQTY_100030_.tb2_2(0),
'MO_BOATTENTION.ACTCREATEPLANWF();nuIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", nuIdSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.FNUCHARTONUMBER(nuIdSolicitud),cnuTipoFechaPQR,dtFechaSolicitud)'
,
'CARLPARR'
,
to_date('18-04-2013 14:17:09','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla de Creaci¿n Plan en Workflow y Registro Adicional de Fecha'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb3_0(0):=8177;
RQTY_100030_.tb3_1(0):=RQTY_100030_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100030_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100030_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Creaci¿n Plan en Workflow y Registro Adicional de Fecha'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100030_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100030_.tb3_0(0),
RQTY_100030_.tb3_1(0),
5,
'Creaci¿n Plan en Workflow y Registro Adicional de Fecha'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb4_0(0):=RQTY_100030_.tb3_0(0);
RQTY_100030_.tb4_1(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100030_.tb4_0(0),
VALID_MODULE_ID=RQTY_100030_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100030_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100030_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100030_.tb4_0(0),
RQTY_100030_.tb4_1(0));
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb4_0(1):=RQTY_100030_.tb3_0(0);
RQTY_100030_.tb4_1(1):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100030_.tb4_0(1),
VALID_MODULE_ID=RQTY_100030_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100030_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100030_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100030_.tb4_0(1),
RQTY_100030_.tb4_1(1));
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb5_0(0):=100030;
RQTY_100030_.tb5_1(0):=RQTY_100030_.tb3_0(0);
RQTY_100030_.tb5_4(0):='P_GENER_REGISTROQUEJAS'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100030_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100030_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100030_.tb5_4(0),
DESCRIPTION='Registro de Quejas'
,
PROCESS_WITH_XML='Y'
,
INDICATOR_REGIS_EXEC='P'
,
STAT_INI_REGIS_EXEC=1,
PROCESS_WITH_WEB='N'
,
ACTIVE='Y'
,
STATISTICS_INCLUDED='N'
,
GESTIONABLE_REQUEST='Y'
,
IS_ANNULABLE='Y'
,
IS_DEMAND_REQUEST='Y'
,
ANSWER_REQUIRED='Y'
,
LIQUIDATION_METHOD=2
 WHERE PACKAGE_TYPE_ID = RQTY_100030_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100030_.tb5_0(0),
RQTY_100030_.tb5_1(0),
null,
null,
RQTY_100030_.tb5_4(0),
'Registro de Quejas'
,
'Y'
,
'P'
,
1,
'N'
,
'Y'
,
'N'
,
'Y'
,
'Y'
,
'Y'
,
'Y'
,
2);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100030_.tb0_0(1),
DESCRIPTION='GESTI¿N DE MOTIVOS'
,
MNEMONIC='MO'
,
LAST_MESSAGE=136,
PATH_MODULE='Motives_Management'
,
ICON_NAME='mod_motivos'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = RQTY_100030_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100030_.tb0_0(1),
'GESTI¿N DE MOTIVOS'
,
'MO'
,
136,
'Motives_Management'
,
'mod_motivos'
,
'IN'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb1_0(1):=23;
RQTY_100030_.tb1_1(1):=RQTY_100030_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100030_.tb1_0(1),
MODULE_ID=RQTY_100030_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100030_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100030_.tb1_0(1),
RQTY_100030_.tb1_1(1),
'Inicializacion de atributos'
,
'PL'
,
'FD'
,
'DS'
,
'_INITATRIB_'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(1):=121407560;
RQTY_100030_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(1):=RQTY_100030_.tb2_0(1);
RQTY_100030_.old_tb2_1(1):='MO_INITATRIB_CT23E121407560'
;
RQTY_100030_.tb2_1(1):=RQTY_100030_.tb2_0(1);
RQTY_100030_.tb2_2(1):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(1),
RQTY_100030_.tb2_1(1),
RQTY_100030_.tb2_2(1),
'PKG_REGLAS_REGISTROQUEJAS.PRCREGLAASIGDIRECCIONRESPUESTA()'
,
'LBTEST'
,
to_date('26-03-2012 11:56:29','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:54:04','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:54:04','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - ADDESS_ID - inicializaci¿n de la direcci¿n de respuesta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(0):=750;
RQTY_100030_.tb6_1(0):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(0):=17;
RQTY_100030_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(0),-1)));
RQTY_100030_.old_tb6_3(0):=146756;
RQTY_100030_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(0),-1)));
RQTY_100030_.old_tb6_4(0):=null;
RQTY_100030_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(0),-1)));
RQTY_100030_.old_tb6_5(0):=null;
RQTY_100030_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(0),-1)));
RQTY_100030_.tb6_7(0):=RQTY_100030_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(0),
ENTITY_ID=RQTY_100030_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(0),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Direcci¿n de Respuesta'
,
DISPLAY_ORDER=8,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='ADDRESS_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(0),
RQTY_100030_.tb6_1(0),
RQTY_100030_.tb6_2(0),
RQTY_100030_.tb6_3(0),
RQTY_100030_.tb6_4(0),
RQTY_100030_.tb6_5(0),
null,
RQTY_100030_.tb6_7(0),
null,
null,
8,
'Direcci¿n de Respuesta'
,
8,
'Y'
,
'N'
,
'Y'
,
'ADDRESS_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'ADDRESS_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(1):=751;
RQTY_100030_.tb6_1(1):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(1):=17;
RQTY_100030_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(1),-1)));
RQTY_100030_.old_tb6_3(1):=146754;
RQTY_100030_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(1),-1)));
RQTY_100030_.old_tb6_4(1):=null;
RQTY_100030_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(1),-1)));
RQTY_100030_.old_tb6_5(1):=null;
RQTY_100030_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(1),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(1),
ENTITY_ID=RQTY_100030_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Observaci¿n'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='COMMENT_'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='COMMENT_'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(1),
RQTY_100030_.tb6_1(1),
RQTY_100030_.tb6_2(1),
RQTY_100030_.tb6_3(1),
RQTY_100030_.tb6_4(1),
RQTY_100030_.tb6_5(1),
null,
null,
null,
null,
12,
'Observaci¿n'
,
12,
'Y'
,
'N'
,
'Y'
,
'COMMENT_'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'COMMENT_'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(2):=121407561;
RQTY_100030_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(2):=RQTY_100030_.tb2_0(2);
RQTY_100030_.old_tb2_1(2):='MO_INITATRIB_CT23E121407561'
;
RQTY_100030_.tb2_1(2):=RQTY_100030_.tb2_0(2);
RQTY_100030_.tb2_2(2):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(2),
RQTY_100030_.tb2_1(2),
RQTY_100030_.tb2_2(2),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PACKAGES","CONTACT_ID",nuIdContacto);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSUBSCRIBER.FSBGETNAME(nuIdContacto))'
,
'LBTEST'
,
to_date('12-07-2012 14:53:48','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - NOMBRE - Inicializaci¿n del Nombre del Solicitante'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(2):=1166;
RQTY_100030_.tb6_1(2):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(2):=68;
RQTY_100030_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(2),-1)));
RQTY_100030_.old_tb6_3(2):=6733;
RQTY_100030_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(2),-1)));
RQTY_100030_.old_tb6_4(2):=null;
RQTY_100030_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(2),-1)));
RQTY_100030_.old_tb6_5(2):=146755;
RQTY_100030_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(2),-1)));
RQTY_100030_.tb6_7(2):=RQTY_100030_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(2),
ENTITY_ID=RQTY_100030_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(2),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Nombre '
,
DISPLAY_ORDER=5,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='NOMBRE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='VARCHAR_2'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(2),
RQTY_100030_.tb6_1(2),
RQTY_100030_.tb6_2(2),
RQTY_100030_.tb6_3(2),
RQTY_100030_.tb6_4(2),
RQTY_100030_.tb6_5(2),
null,
RQTY_100030_.tb6_7(2),
null,
null,
5,
'Nombre '
,
5,
'Y'
,
'N'
,
'N'
,
'NOMBRE'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'VARCHAR_2'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(3):=1169;
RQTY_100030_.tb6_1(3):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(3):=5872;
RQTY_100030_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(3),-1)));
RQTY_100030_.old_tb6_3(3):=138161;
RQTY_100030_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(3),-1)));
RQTY_100030_.old_tb6_4(3):=null;
RQTY_100030_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(3),-1)));
RQTY_100030_.old_tb6_5(3):=null;
RQTY_100030_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(3),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(3),
ENTITY_ID=RQTY_100030_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Datos de la Queja'
,
DISPLAY_ORDER=20,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DATOS_DE_LA_QUEJA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='GI_ATTRIBS'
,
ATTRI_TECHNICAL_NAME='ATTRIB01'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(3),
RQTY_100030_.tb6_1(3),
RQTY_100030_.tb6_2(3),
RQTY_100030_.tb6_3(3),
RQTY_100030_.tb6_4(3),
RQTY_100030_.tb6_5(3),
null,
null,
null,
null,
20,
'Datos de la Queja'
,
20,
'Y'
,
'N'
,
'N'
,
'DATOS_DE_LA_QUEJA'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'GI_ATTRIBS'
,
'ATTRIB01'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(3):=121407562;
RQTY_100030_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(3):=RQTY_100030_.tb2_0(3);
RQTY_100030_.old_tb2_1(3):='MO_INITATRIB_CT23E121407562'
;
RQTY_100030_.tb2_1(3):=RQTY_100030_.tb2_0(3);
RQTY_100030_.tb2_2(3):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(3),
RQTY_100030_.tb2_1(3),
RQTY_100030_.tb2_2(3),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSuscriptionId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSuscriptionId);,)'
,
'LBTEST'
,
to_date('07-06-2012 08:10:59','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - Inicia la Suscripcion'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(4):=138;
RQTY_100030_.tb6_1(4):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(4):=68;
RQTY_100030_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(4),-1)));
RQTY_100030_.old_tb6_3(4):=6732;
RQTY_100030_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(4),-1)));
RQTY_100030_.old_tb6_4(4):=null;
RQTY_100030_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(4),-1)));
RQTY_100030_.old_tb6_5(4):=null;
RQTY_100030_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(4),-1)));
RQTY_100030_.tb6_7(4):=RQTY_100030_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(4),
ENTITY_ID=RQTY_100030_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Suscripci¿n'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SUSCRIPCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='VARCHAR_1'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(4),
RQTY_100030_.tb6_1(4),
RQTY_100030_.tb6_2(4),
RQTY_100030_.tb6_3(4),
RQTY_100030_.tb6_4(4),
RQTY_100030_.tb6_5(4),
null,
RQTY_100030_.tb6_7(4),
null,
null,
21,
'Suscripci¿n'
,
21,
'Y'
,
'N'
,
'N'
,
'SUSCRIPCI_N'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'VARCHAR_1'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(4):=121407563;
RQTY_100030_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(4):=RQTY_100030_.tb2_0(4);
RQTY_100030_.old_tb2_1(4):='MO_INITATRIB_CT23E121407563'
;
RQTY_100030_.tb2_1(4):=RQTY_100030_.tb2_0(4);
RQTY_100030_.tb2_2(4):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(4),
RQTY_100030_.tb2_1(4),
RQTY_100030_.tb2_2(4),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);sbSubscription = "SUBSCRIPTION_ID";sbProduct = "PRODUCT_ID";sbNull = "null";if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbSubscriptionId);sbSubscription = UT_STRING.FSBCONCAT(sbSubscription, sbSubscriptionId, "=");if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",sbProductId);sbProduct = UT_STRING.FSBCONCAT(sbProduct, sbProductId, "=");sbCadena = UT_STRING.FSBCONCAT(sbSubscription, sbProduct, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbCadena);,sbProduct = UT_STRING.FSBCONCAT(sbProduct, sbNull, "=");sbCadena = UT_STRING.FSBCONCAT(sbSubscription, sbProduct, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(s' ||
'bCadena););,)'
,
'LBTEST'
,
to_date('15-08-2012 12:05:03','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PROCESS - COMMENTARY - Inicializacion Componente Actualizacion de Datos'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(5):=1707;
RQTY_100030_.tb6_1(5):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(5):=68;
RQTY_100030_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(5),-1)));
RQTY_100030_.old_tb6_3(5):=20371;
RQTY_100030_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(5),-1)));
RQTY_100030_.old_tb6_4(5):=null;
RQTY_100030_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(5),-1)));
RQTY_100030_.old_tb6_5(5):=null;
RQTY_100030_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(5),-1)));
RQTY_100030_.tb6_7(5):=RQTY_100030_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(5),
ENTITY_ID=RQTY_100030_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Actualizar Datos'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ACTUALIZAR_DATOS'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='COMMENTARY'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(5),
RQTY_100030_.tb6_1(5),
RQTY_100030_.tb6_2(5),
RQTY_100030_.tb6_3(5),
RQTY_100030_.tb6_4(5),
RQTY_100030_.tb6_5(5),
null,
RQTY_100030_.tb6_7(5),
null,
null,
14,
'Actualizar Datos'
,
14,
'Y'
,
'N'
,
'N'
,
'ACTUALIZAR_DATOS'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'COMMENTARY'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(5):=121407564;
RQTY_100030_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(5):=RQTY_100030_.tb2_0(5);
RQTY_100030_.old_tb2_1(5):='MO_INITATRIB_CT23E121407564'
;
RQTY_100030_.tb2_1(5):=RQTY_100030_.tb2_0(5);
RQTY_100030_.tb2_2(5):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(5),
RQTY_100030_.tb2_1(5),
RQTY_100030_.tb2_2(5),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('22-06-2011 15:53:36','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGE.PERSON_ID - Incializa el Vendedor'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb1_0(2):=26;
RQTY_100030_.tb1_1(2):=RQTY_100030_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100030_.tb1_0(2),
MODULE_ID=RQTY_100030_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100030_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100030_.tb1_0(2),
RQTY_100030_.tb1_1(2),
'Validaci¿n de atributos'
,
'PL'
,
'FD'
,
'DS'
,
'_VALIDATTR_'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(6):=121407565;
RQTY_100030_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(6):=RQTY_100030_.tb2_0(6);
RQTY_100030_.old_tb2_1(6):='MO_VALIDATTR_CT26E121407565'
;
RQTY_100030_.tb2_1(6):=RQTY_100030_.tb2_0(6);
RQTY_100030_.tb2_2(6):=RQTY_100030_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(6),
RQTY_100030_.tb2_1(6),
RQTY_100030_.tb2_2(6),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPersonId);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,Null,"MO_PACKAGES","POS_OPER_UNIT_ID",nuSaleChannel,True)'
,
'LBTEST'
,
to_date('22-06-2011 15:53:37','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MO_PACKAGES.PERSON_ID - Valida Vendedor'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(0):=120198205;
RQTY_100030_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(0):=RQTY_100030_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(0),
16,
'Listado de Vendedores '
,
'SELECT   a.person_id ID, a.name_ DESCRIPTION FROM   GE_PERSON a'
,
'Listado de Vendedores '
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(6):=100976;
RQTY_100030_.tb6_1(6):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(6):=17;
RQTY_100030_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(6),-1)));
RQTY_100030_.old_tb6_3(6):=50001162;
RQTY_100030_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(6),-1)));
RQTY_100030_.old_tb6_4(6):=null;
RQTY_100030_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(6),-1)));
RQTY_100030_.old_tb6_5(6):=null;
RQTY_100030_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(6),-1)));
RQTY_100030_.tb6_6(6):=RQTY_100030_.tb7_0(0);
RQTY_100030_.tb6_7(6):=RQTY_100030_.tb2_0(5);
RQTY_100030_.tb6_8(6):=RQTY_100030_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(6),
ENTITY_ID=RQTY_100030_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(6),
STATEMENT_ID=RQTY_100030_.tb6_6(6),
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(6),
VALID_EXPRESSION_ID=RQTY_100030_.tb6_8(6),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Funcionario'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='PERSON_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(6),
RQTY_100030_.tb6_1(6),
RQTY_100030_.tb6_2(6),
RQTY_100030_.tb6_3(6),
RQTY_100030_.tb6_4(6),
RQTY_100030_.tb6_5(6),
RQTY_100030_.tb6_6(6),
RQTY_100030_.tb6_7(6),
RQTY_100030_.tb6_8(6),
null,
3,
'Funcionario'
,
3,
'Y'
,
'N'
,
'Y'
,
'ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'PERSON_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(7):=121407566;
RQTY_100030_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(7):=RQTY_100030_.tb2_0(7);
RQTY_100030_.old_tb2_1(7):='MO_INITATRIB_CT23E121407566'
;
RQTY_100030_.tb2_1(7):=RQTY_100030_.tb2_0(7);
RQTY_100030_.tb2_2(7):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(7),
RQTY_100030_.tb2_1(7),
RQTY_100030_.tb2_2(7),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'TESTOSS'
,
to_date('27-04-2006 09:01:26','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGES - MESSAG_DELIVERY_DATE - Inicializa la fecha de envio'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(7):=100977;
RQTY_100030_.tb6_1(7):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(7):=17;
RQTY_100030_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(7),-1)));
RQTY_100030_.old_tb6_3(7):=259;
RQTY_100030_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(7),-1)));
RQTY_100030_.old_tb6_4(7):=null;
RQTY_100030_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(7),-1)));
RQTY_100030_.old_tb6_5(7):=null;
RQTY_100030_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(7),-1)));
RQTY_100030_.tb6_7(7):=RQTY_100030_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(7),
ENTITY_ID=RQTY_100030_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Fecha de Env¿o'
,
DISPLAY_ORDER=23,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_DE_ENV_O'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='MESSAG_DELIVERY_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(7),
RQTY_100030_.tb6_1(7),
RQTY_100030_.tb6_2(7),
RQTY_100030_.tb6_3(7),
RQTY_100030_.tb6_4(7),
RQTY_100030_.tb6_5(7),
null,
RQTY_100030_.tb6_7(7),
null,
null,
23,
'Fecha de Env¿o'
,
23,
'N'
,
'N'
,
'Y'
,
'FECHA_DE_ENV_O'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'MESSAG_DELIVERY_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(8):=121407567;
RQTY_100030_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(8):=RQTY_100030_.tb2_0(8);
RQTY_100030_.old_tb2_1(8):='MO_INITATRIB_CT23E121407567'
;
RQTY_100030_.tb2_1(8):=RQTY_100030_.tb2_0(8);
RQTY_100030_.tb2_2(8):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(8),
RQTY_100030_.tb2_1(8),
RQTY_100030_.tb2_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('26-03-2012 11:50:30','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - CUST_CARE_REQUES_NUM - Inicializaci¿n de la petici¿n'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(8):=100978;
RQTY_100030_.tb6_1(8):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(8):=17;
RQTY_100030_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(8),-1)));
RQTY_100030_.old_tb6_3(8):=257;
RQTY_100030_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(8),-1)));
RQTY_100030_.old_tb6_4(8):=null;
RQTY_100030_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(8),-1)));
RQTY_100030_.old_tb6_5(8):=null;
RQTY_100030_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(8),-1)));
RQTY_100030_.tb6_7(8):=RQTY_100030_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(8),
ENTITY_ID=RQTY_100030_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Interacci¿n'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='INTERACCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='CUST_CARE_REQUES_NUM'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(8),
RQTY_100030_.tb6_1(8),
RQTY_100030_.tb6_2(8),
RQTY_100030_.tb6_3(8),
RQTY_100030_.tb6_4(8),
RQTY_100030_.tb6_5(8),
null,
RQTY_100030_.tb6_7(8),
null,
null,
0,
'Interacci¿n'
,
0,
'Y'
,
'N'
,
'Y'
,
'INTERACCI_N'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'CUST_CARE_REQUES_NUM'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(9):=1988;
RQTY_100030_.tb6_1(9):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(9):=68;
RQTY_100030_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(9),-1)));
RQTY_100030_.old_tb6_3(9):=419;
RQTY_100030_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(9),-1)));
RQTY_100030_.old_tb6_4(9):=null;
RQTY_100030_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(9),-1)));
RQTY_100030_.old_tb6_5(9):=null;
RQTY_100030_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(9),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(9),
ENTITY_ID=RQTY_100030_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Identificador del Producto'
,
DISPLAY_ORDER=19,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PRODUCT'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='PRODUCT_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(9),
RQTY_100030_.tb6_1(9),
RQTY_100030_.tb6_2(9),
RQTY_100030_.tb6_3(9),
RQTY_100030_.tb6_4(9),
RQTY_100030_.tb6_5(9),
null,
null,
null,
null,
19,
'Identificador del Producto'
,
19,
'N'
,
'N'
,
'N'
,
'PRODUCT'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'PRODUCT_ID'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(9):=121407568;
RQTY_100030_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(9):=RQTY_100030_.tb2_0(9);
RQTY_100030_.old_tb2_1(9):='MO_INITATRIB_CT23E121407568'
;
RQTY_100030_.tb2_1(9):=RQTY_100030_.tb2_0(9);
RQTY_100030_.tb2_2(9):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(9),
RQTY_100030_.tb2_1(9),
RQTY_100030_.tb2_2(9),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('26-03-2012 11:56:28','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - RECEPTION_TYPE_ID - Inicializaci¿n del medio de recepci¿n'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(1):=120198206;
RQTY_100030_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(1):=RQTY_100030_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(1),
16,
'Tipos de Recepci¿n de Queja'
,
'SELECT r.RECEPTION_TYPE_ID id, r.description
FROM ge_reception_type r, or_ope_uni_rece_type o, or_operating_unit u
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'r.RECEPTION_TYPE_ID <> GE_BOPARAMETER.fnuGet('|| chr(39) ||'EXTERN_RECEPTION'|| chr(39) ||') '||chr(64)||'
'||chr(64)||'r.RECEPTION_TYPE_ID = :RECEPTION_ID '||chr(64)||'
'||chr(64)||'r.description like :DESCRIPTION '||chr(64)||'
'||chr(64)||'r.reception_type_id = o.reception_type_id '||chr(64)||'
'||chr(64)||'o.operating_unit_id = u.operating_unit_id '||chr(64)||'
'||chr(64)||'u.operating_unit_id = ge_boinstancecontrol.fsbgetfieldvalue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'POS_OPER_UNIT_ID'|| chr(39) ||') '||chr(64)||''
,
'Tipos de Recepci¿n de Queja'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(10):=100979;
RQTY_100030_.tb6_1(10):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(10):=17;
RQTY_100030_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(10),-1)));
RQTY_100030_.old_tb6_3(10):=2683;
RQTY_100030_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(10),-1)));
RQTY_100030_.old_tb6_4(10):=null;
RQTY_100030_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(10),-1)));
RQTY_100030_.old_tb6_5(10):=null;
RQTY_100030_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(10),-1)));
RQTY_100030_.tb6_6(10):=RQTY_100030_.tb7_0(1);
RQTY_100030_.tb6_7(10):=RQTY_100030_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(10),
ENTITY_ID=RQTY_100030_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(10),
STATEMENT_ID=RQTY_100030_.tb6_6(10),
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Medio de Recepci¿n'
,
DISPLAY_ORDER=7,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='RECEPTION_TYPE_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='RECEPTION_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(10),
RQTY_100030_.tb6_1(10),
RQTY_100030_.tb6_2(10),
RQTY_100030_.tb6_3(10),
RQTY_100030_.tb6_4(10),
RQTY_100030_.tb6_5(10),
RQTY_100030_.tb6_6(10),
RQTY_100030_.tb6_7(10),
null,
null,
7,
'Medio de Recepci¿n'
,
7,
'Y'
,
'N'
,
'Y'
,
'RECEPTION_TYPE_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'RECEPTION_TYPE_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(10):=121407569;
RQTY_100030_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(10):=RQTY_100030_.tb2_0(10);
RQTY_100030_.old_tb2_1(10):='MO_INITATRIB_CT23E121407569'
;
RQTY_100030_.tb2_1(10):=RQTY_100030_.tb2_0(10);
RQTY_100030_.tb2_2(10):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(10),
RQTY_100030_.tb2_1(10),
RQTY_100030_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbSubscriberId);,);if (MO_BOREGISTERWITHXML.FBLISREGISTERXML() = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","CONTRACT_INFORMATION",sbIdContrato);if (UT_CONVERT.FNUCHARTONUMBER(sbIdContrato) <> null,nuIdCliente = PKBODATA.FSBGETVALUE("SUSCRIPC", "SUSCCLIE", UT_CONVERT.FNUCHARTONUMBER(sbIdContrato));GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuIdCliente);,);,)'
,
'LBTEST'
,
to_date('12-12-2011 14:13:50','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGES - SUBSCRIBER_ID - Inicializa el identificador del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(11):=100984;
RQTY_100030_.tb6_1(11):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(11):=17;
RQTY_100030_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(11),-1)));
RQTY_100030_.old_tb6_3(11):=4015;
RQTY_100030_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(11),-1)));
RQTY_100030_.old_tb6_4(11):=null;
RQTY_100030_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(11),-1)));
RQTY_100030_.old_tb6_5(11):=null;
RQTY_100030_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(11),-1)));
RQTY_100030_.tb6_7(11):=RQTY_100030_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(11),
ENTITY_ID=RQTY_100030_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Identificador del Cliente'
,
DISPLAY_ORDER=24,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DEL_CLIENTE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='SUBSCRIBER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(11),
RQTY_100030_.tb6_1(11),
RQTY_100030_.tb6_2(11),
RQTY_100030_.tb6_3(11),
RQTY_100030_.tb6_4(11),
RQTY_100030_.tb6_5(11),
null,
RQTY_100030_.tb6_7(11),
null,
null,
24,
'Identificador del Cliente'
,
24,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DEL_CLIENTE'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'SUBSCRIBER_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(12):=100995;
RQTY_100030_.tb6_1(12):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(12):=21;
RQTY_100030_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(12),-1)));
RQTY_100030_.old_tb6_3(12):=39322;
RQTY_100030_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(12),-1)));
RQTY_100030_.old_tb6_4(12):=255;
RQTY_100030_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(12),-1)));
RQTY_100030_.old_tb6_5(12):=null;
RQTY_100030_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(12),
ENTITY_ID=RQTY_100030_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=25,
DISPLAY_NAME='PACKAGE_ID'
,
DISPLAY_ORDER=25,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME=null,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='N'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(12),
RQTY_100030_.tb6_1(12),
RQTY_100030_.tb6_2(12),
RQTY_100030_.tb6_3(12),
RQTY_100030_.tb6_4(12),
RQTY_100030_.tb6_5(12),
null,
null,
null,
null,
25,
'PACKAGE_ID'
,
25,
'N'
,
'N'
,
'Y'
,
null,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'MO_ADDRESS'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(13):=100996;
RQTY_100030_.tb6_1(13):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(13):=17;
RQTY_100030_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(13),-1)));
RQTY_100030_.old_tb6_3(13):=260;
RQTY_100030_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(13),-1)));
RQTY_100030_.old_tb6_4(13):=null;
RQTY_100030_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(13),-1)));
RQTY_100030_.old_tb6_5(13):=null;
RQTY_100030_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(13),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(13),
ENTITY_ID=RQTY_100030_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=26,
DISPLAY_NAME='Usuario'
,
DISPLAY_ORDER=26,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='USUARIO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='USER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(13),
RQTY_100030_.tb6_1(13),
RQTY_100030_.tb6_2(13),
RQTY_100030_.tb6_3(13),
RQTY_100030_.tb6_4(13),
RQTY_100030_.tb6_5(13),
null,
null,
null,
null,
26,
'Usuario'
,
26,
'N'
,
'N'
,
'Y'
,
'USUARIO'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'USER_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(14):=100999;
RQTY_100030_.tb6_1(14):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(14):=17;
RQTY_100030_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(14),-1)));
RQTY_100030_.old_tb6_3(14):=2374;
RQTY_100030_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(14),-1)));
RQTY_100030_.old_tb6_4(14):=null;
RQTY_100030_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(14),-1)));
RQTY_100030_.old_tb6_5(14):=null;
RQTY_100030_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(14),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(14),
ENTITY_ID=RQTY_100030_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=29,
DISPLAY_NAME='Fecha de Atenci¿n'
,
DISPLAY_ORDER=29,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='FECHA_DE_ATENCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='ATTENTION_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(14),
RQTY_100030_.tb6_1(14),
RQTY_100030_.tb6_2(14),
RQTY_100030_.tb6_3(14),
RQTY_100030_.tb6_4(14),
RQTY_100030_.tb6_5(14),
null,
null,
null,
null,
29,
'Fecha de Atenci¿n'
,
29,
'N'
,
'N'
,
'N'
,
'FECHA_DE_ATENCI_N'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'ATTENTION_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(2):=120198207;
RQTY_100030_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(2):=RQTY_100030_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(2),
8,
'Selecci¿n distribuci¿n administrativa'
,
'SELECT distribut_admin_id id, display_description description
FROM ge_distribut_admin
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'ASSIGN_LEVEL = ge_boconstants.GetYes '||chr(64)||''
,
'Selecci¿n distribuci¿n administrativa'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(15):=101013;
RQTY_100030_.tb6_1(15):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(15):=17;
RQTY_100030_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(15),-1)));
RQTY_100030_.old_tb6_3(15):=41406;
RQTY_100030_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(15),-1)));
RQTY_100030_.old_tb6_4(15):=null;
RQTY_100030_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(15),-1)));
RQTY_100030_.old_tb6_5(15):=null;
RQTY_100030_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(15),-1)));
RQTY_100030_.tb6_6(15):=RQTY_100030_.tb7_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(15),
ENTITY_ID=RQTY_100030_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(15),
STATEMENT_ID=RQTY_100030_.tb6_6(15),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=30,
DISPLAY_NAME='Zona'
,
DISPLAY_ORDER=30,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ZONE_ADMIN_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='ZONE_ADMIN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(15),
RQTY_100030_.tb6_1(15),
RQTY_100030_.tb6_2(15),
RQTY_100030_.tb6_3(15),
RQTY_100030_.tb6_4(15),
RQTY_100030_.tb6_5(15),
RQTY_100030_.tb6_6(15),
null,
null,
null,
30,
'Zona'
,
30,
'N'
,
'N'
,
'N'
,
'ZONE_ADMIN_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'ZONE_ADMIN_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(11):=121407570;
RQTY_100030_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(11):=RQTY_100030_.tb2_0(11);
RQTY_100030_.old_tb2_1(11):='MO_INITATRIB_CT23E121407570'
;
RQTY_100030_.tb2_1(11):=RQTY_100030_.tb2_0(11);
RQTY_100030_.tb2_2(11):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(11),
RQTY_100030_.tb2_1(11),
RQTY_100030_.tb2_2(11),
'GI_BOCNFADDRESS.INITDATAADDRESS("Y","N",4,"M","Y","D");GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",null,"GI_PROCESS","ADDRESS_MAIN_MOTIVE_NEW",null,TRUE);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProducto);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","ADDRESS_ID",nuIdDirecc);if (nuIdDirecc <> null,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuIdDirecc);,);GI_BOCNFADDRESS.LOADADDRESS(nuIdProducto);,)'
,
'LBTEST'
,
to_date('05-08-2010 10:53:25','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - Direcci¿n'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(16):=101014;
RQTY_100030_.tb6_1(16):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(16):=68;
RQTY_100030_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(16),-1)));
RQTY_100030_.old_tb6_3(16):=1035;
RQTY_100030_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(16),-1)));
RQTY_100030_.old_tb6_4(16):=null;
RQTY_100030_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(16),-1)));
RQTY_100030_.old_tb6_5(16):=null;
RQTY_100030_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(16),-1)));
RQTY_100030_.tb6_7(16):=RQTY_100030_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(16),
ENTITY_ID=RQTY_100030_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(16),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=31,
DISPLAY_NAME='Direcci¿n '
,
DISPLAY_ORDER=31,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='DIRECCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS_MAIN_MOTIVE'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(16),
RQTY_100030_.tb6_1(16),
RQTY_100030_.tb6_2(16),
RQTY_100030_.tb6_3(16),
RQTY_100030_.tb6_4(16),
RQTY_100030_.tb6_5(16),
null,
RQTY_100030_.tb6_7(16),
null,
null,
31,
'Direcci¿n '
,
31,
'N'
,
'N'
,
'Y'
,
'DIRECCI_N'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'ADDRESS_MAIN_MOTIVE'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(3):=120198208;
RQTY_100030_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(3):=RQTY_100030_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(3),
16,
'Centros de Atenci¿n Quejas'
,
'SELECT distribut_admin_id ID, display_description description FROM ge_distribut_admin
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'distri_admi_type_id = 3 '||chr(64)||'
'||chr(64)||'distribut_admin_id = :distribut_admin_id '||chr(64)||'
'||chr(64)||'display_description like :description '||chr(64)||''
,
'Centros de Atenci¿n Quejas'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(17):=101017;
RQTY_100030_.tb6_1(17):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(17):=17;
RQTY_100030_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(17),-1)));
RQTY_100030_.old_tb6_3(17):=2666;
RQTY_100030_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(17),-1)));
RQTY_100030_.old_tb6_4(17):=null;
RQTY_100030_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(17),-1)));
RQTY_100030_.old_tb6_5(17):=null;
RQTY_100030_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(17),-1)));
RQTY_100030_.tb6_6(17):=RQTY_100030_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(17),
ENTITY_ID=RQTY_100030_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(17),
STATEMENT_ID=RQTY_100030_.tb6_6(17),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=32,
DISPLAY_NAME='Centro de Atenci¿n'
,
DISPLAY_ORDER=32,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DISTRIBUT_ADMIN_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='DISTRIBUT_ADMIN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(17),
RQTY_100030_.tb6_1(17),
RQTY_100030_.tb6_2(17),
RQTY_100030_.tb6_3(17),
RQTY_100030_.tb6_4(17),
RQTY_100030_.tb6_5(17),
RQTY_100030_.tb6_6(17),
null,
null,
null,
32,
'Centro de Atenci¿n'
,
32,
'N'
,
'N'
,
'N'
,
'DISTRIBUT_ADMIN_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'DISTRIBUT_ADMIN_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(12):=121407571;
RQTY_100030_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(12):=RQTY_100030_.tb2_0(12);
RQTY_100030_.old_tb2_1(12):='MO_VALIDATTR_CT26E121407571'
;
RQTY_100030_.tb2_1(12):=RQTY_100030_.tb2_0(12);
RQTY_100030_.tb2_2(12):=RQTY_100030_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(12),
RQTY_100030_.tb2_1(12),
RQTY_100030_.tb2_2(12),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",null,"MO_PACKAGES","PACKAGE_NEW_ID",sbValue,TRUE)'
,
'TESTOSS'
,
to_date('08-05-2008 15:49:11','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - Instancia Identificador del Paquete (Requerido para generar la notificaci¿n)'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(18):=100973;
RQTY_100030_.tb6_1(18):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(18):=17;
RQTY_100030_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(18),-1)));
RQTY_100030_.old_tb6_3(18):=255;
RQTY_100030_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(18),-1)));
RQTY_100030_.old_tb6_4(18):=null;
RQTY_100030_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(18),-1)));
RQTY_100030_.old_tb6_5(18):=null;
RQTY_100030_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(18),-1)));
RQTY_100030_.tb6_8(18):=RQTY_100030_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(18),
ENTITY_ID=RQTY_100030_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100030_.tb6_8(18),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='N¿mero de Solicitud'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='N_MERO_DE_SOLICITUD'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(18),
RQTY_100030_.tb6_1(18),
RQTY_100030_.tb6_2(18),
RQTY_100030_.tb6_3(18),
RQTY_100030_.tb6_4(18),
RQTY_100030_.tb6_5(18),
null,
null,
RQTY_100030_.tb6_8(18),
null,
2,
'N¿mero de Solicitud'
,
2,
'Y'
,
'N'
,
'Y'
,
'N_MERO_DE_SOLICITUD'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(19):=100972;
RQTY_100030_.tb6_1(19):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(19):=17;
RQTY_100030_.tb6_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(19),-1)));
RQTY_100030_.old_tb6_3(19):=269;
RQTY_100030_.tb6_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(19),-1)));
RQTY_100030_.old_tb6_4(19):=null;
RQTY_100030_.tb6_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(19),-1)));
RQTY_100030_.old_tb6_5(19):=null;
RQTY_100030_.tb6_5(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(19),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (19)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(19),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(19),
ENTITY_ID=RQTY_100030_.tb6_2(19),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(19),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(19),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='C¿digo del Tipo de Paquete'
,
DISPLAY_ORDER=15,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='Y'
,
REQUIRED='Y'
,
TAG_NAME='ID_TIPOPAQUETE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='PACKAGE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(19);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(19),
RQTY_100030_.tb6_1(19),
RQTY_100030_.tb6_2(19),
RQTY_100030_.tb6_3(19),
RQTY_100030_.tb6_4(19),
RQTY_100030_.tb6_5(19),
null,
null,
null,
null,
15,
'C¿digo del Tipo de Paquete'
,
15,
'N'
,
'Y'
,
'Y'
,
'ID_TIPOPAQUETE'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'PACKAGE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(13):=121407572;
RQTY_100030_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(13):=RQTY_100030_.tb2_0(13);
RQTY_100030_.old_tb2_1(13):='MO_INITATRIB_CT23E121407572'
;
RQTY_100030_.tb2_1(13):=RQTY_100030_.tb2_0(13);
RQTY_100030_.tb2_2(13):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(13),
RQTY_100030_.tb2_1(13),
RQTY_100030_.tb2_2(13),
'CF_BOINITRULES.INIREQUESTDATE()'
,
'TESTOSS'
,
to_date('27-04-2006 08:50:02','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGES - REQUEST_DATE- Inicializa la fecha de solicitud'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(14):=121407573;
RQTY_100030_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(14):=RQTY_100030_.tb2_0(14);
RQTY_100030_.old_tb2_1(14):='MO_VALIDATTR_CT26E121407573'
;
RQTY_100030_.tb2_1(14):=RQTY_100030_.tb2_0(14);
RQTY_100030_.tb2_2(14):=RQTY_100030_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(14),
RQTY_100030_.tb2_1(14),
RQTY_100030_.tb2_2(14),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PROCESS","PACKAGE_TYPE_ID",nuPackageTypeId);nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPackageTypeId, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No est¿ permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,););)'
,
'JUANPAMP'
,
to_date('09-04-2013 17:59:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PACKAGES - REQUEST_DATE - Valida que la fecha de registro hacia atr¿s no sea mayor al num¿ro de d¿as definido en el par¿metro MAX_DAYS'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(20):=100974;
RQTY_100030_.tb6_1(20):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(20):=17;
RQTY_100030_.tb6_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(20),-1)));
RQTY_100030_.old_tb6_3(20):=258;
RQTY_100030_.tb6_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(20),-1)));
RQTY_100030_.old_tb6_4(20):=null;
RQTY_100030_.tb6_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(20),-1)));
RQTY_100030_.old_tb6_5(20):=null;
RQTY_100030_.tb6_5(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(20),-1)));
RQTY_100030_.tb6_7(20):=RQTY_100030_.tb2_0(13);
RQTY_100030_.tb6_8(20):=RQTY_100030_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (20)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(20),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(20),
ENTITY_ID=RQTY_100030_.tb6_2(20),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(20),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(20),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(20),
VALID_EXPRESSION_ID=RQTY_100030_.tb6_8(20),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Fecha de Solicitud'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_DE_SOLICITUD'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='REQUEST_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(20);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(20),
RQTY_100030_.tb6_1(20),
RQTY_100030_.tb6_2(20),
RQTY_100030_.tb6_3(20),
RQTY_100030_.tb6_4(20),
RQTY_100030_.tb6_5(20),
null,
RQTY_100030_.tb6_7(20),
RQTY_100030_.tb6_8(20),
null,
1,
'Fecha de Solicitud'
,
1,
'Y'
,
'N'
,
'Y'
,
'FECHA_DE_SOLICITUD'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'REQUEST_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(21):=465;
RQTY_100030_.tb6_1(21):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(21):=17;
RQTY_100030_.tb6_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(21),-1)));
RQTY_100030_.old_tb6_3(21):=109478;
RQTY_100030_.tb6_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(21),-1)));
RQTY_100030_.old_tb6_4(21):=null;
RQTY_100030_.tb6_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(21),-1)));
RQTY_100030_.old_tb6_5(21):=null;
RQTY_100030_.tb6_5(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(21),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (21)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(21),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(21),
ENTITY_ID=RQTY_100030_.tb6_2(21),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(21),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(21),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=39,
DISPLAY_NAME='Unidad Operativa Del Vendedor'
,
DISPLAY_ORDER=39,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='OPERATING_UNIT_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='OPERATING_UNIT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(21);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(21),
RQTY_100030_.tb6_1(21),
RQTY_100030_.tb6_2(21),
RQTY_100030_.tb6_3(21),
RQTY_100030_.tb6_4(21),
RQTY_100030_.tb6_5(21),
null,
null,
null,
null,
39,
'Unidad Operativa Del Vendedor'
,
39,
'N'
,
'N'
,
'N'
,
'OPERATING_UNIT_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'OPERATING_UNIT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(22):=466;
RQTY_100030_.tb6_1(22):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(22):=17;
RQTY_100030_.tb6_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(22),-1)));
RQTY_100030_.old_tb6_3(22):=42118;
RQTY_100030_.tb6_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(22),-1)));
RQTY_100030_.old_tb6_4(22):=109479;
RQTY_100030_.tb6_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(22),-1)));
RQTY_100030_.old_tb6_5(22):=null;
RQTY_100030_.tb6_5(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(22),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (22)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(22),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(22),
ENTITY_ID=RQTY_100030_.tb6_2(22),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(22),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(22),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=40,
DISPLAY_NAME='C¿digo Canal De Ventas'
,
DISPLAY_ORDER=40,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SALE_CHANNEL_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='SALE_CHANNEL_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(22);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(22),
RQTY_100030_.tb6_1(22),
RQTY_100030_.tb6_2(22),
RQTY_100030_.tb6_3(22),
RQTY_100030_.tb6_4(22),
RQTY_100030_.tb6_5(22),
null,
null,
null,
null,
40,
'C¿digo Canal De Ventas'
,
40,
'N'
,
'N'
,
'N'
,
'SALE_CHANNEL_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'SALE_CHANNEL_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(15):=121407574;
RQTY_100030_.tb2_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(15):=RQTY_100030_.tb2_0(15);
RQTY_100030_.old_tb2_1(15):='MO_INITATRIB_CT23E121407574'
;
RQTY_100030_.tb2_1(15):=RQTY_100030_.tb2_0(15);
RQTY_100030_.tb2_2(15):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(15),
RQTY_100030_.tb2_1(15),
RQTY_100030_.tb2_2(15),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('26-03-2012 11:53:01','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - POS_OPER_UNIT_ID - inicializaci¿n del punto de atenci¿n'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(4):=120198209;
RQTY_100030_.tb7_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(4):=RQTY_100030_.tb7_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(4),
5,
'Lista Punto de Atenci¿n'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')'
,
'Lista Punto de Atenci¿n'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(23):=1010;
RQTY_100030_.tb6_1(23):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(23):=17;
RQTY_100030_.tb6_2(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(23),-1)));
RQTY_100030_.old_tb6_3(23):=109479;
RQTY_100030_.tb6_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(23),-1)));
RQTY_100030_.old_tb6_4(23):=null;
RQTY_100030_.tb6_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(23),-1)));
RQTY_100030_.old_tb6_5(23):=null;
RQTY_100030_.tb6_5(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(23),-1)));
RQTY_100030_.tb6_6(23):=RQTY_100030_.tb7_0(4);
RQTY_100030_.tb6_7(23):=RQTY_100030_.tb2_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (23)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(23),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(23),
ENTITY_ID=RQTY_100030_.tb6_2(23),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(23),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(23),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(23),
STATEMENT_ID=RQTY_100030_.tb6_6(23),
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(23),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Punto de Atenci¿n'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='POS_OPER_UNIT_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='POS_OPER_UNIT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(23);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(23),
RQTY_100030_.tb6_1(23),
RQTY_100030_.tb6_2(23),
RQTY_100030_.tb6_3(23),
RQTY_100030_.tb6_4(23),
RQTY_100030_.tb6_5(23),
RQTY_100030_.tb6_6(23),
RQTY_100030_.tb6_7(23),
null,
null,
6,
'Punto de Atenci¿n'
,
6,
'Y'
,
'N'
,
'Y'
,
'POS_OPER_UNIT_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'POS_OPER_UNIT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(5):=120198210;
RQTY_100030_.tb7_0(5):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(5):=RQTY_100030_.tb7_0(5);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (5)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(5),
5,
'Sentencia Obtiene las posibles areas causantes segun tipo de paquete y causa'
,
'PS_BOListOfValues.GetCausingAreas(ID, DESCRIPTION, OUTPUT)'
,
'Sentencia Obtiene las posibles areas causantes segun tipo de paquete y causa'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(24):=1124;
RQTY_100030_.tb6_1(24):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(24):=17;
RQTY_100030_.tb6_2(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(24),-1)));
RQTY_100030_.old_tb6_3(24):=40909;
RQTY_100030_.tb6_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(24),-1)));
RQTY_100030_.old_tb6_4(24):=null;
RQTY_100030_.tb6_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(24),-1)));
RQTY_100030_.old_tb6_5(24):=189644;
RQTY_100030_.tb6_5(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(24),-1)));
RQTY_100030_.tb6_6(24):=RQTY_100030_.tb7_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (24)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(24),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(24),
ENTITY_ID=RQTY_100030_.tb6_2(24),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(24),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(24),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(24),
STATEMENT_ID=RQTY_100030_.tb6_6(24),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='¿rea Organizacional Causante'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='ORGANIZAT_AREA_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='ORGANIZAT_AREA_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(24);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(24),
RQTY_100030_.tb6_1(24),
RQTY_100030_.tb6_2(24),
RQTY_100030_.tb6_3(24),
RQTY_100030_.tb6_4(24),
RQTY_100030_.tb6_5(24),
RQTY_100030_.tb6_6(24),
null,
null,
null,
10,
'¿rea Organizacional Causante'
,
10,
'Y'
,
'N'
,
'Y'
,
'ORGANIZAT_AREA_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'ORGANIZAT_AREA_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(25):=1985;
RQTY_100030_.tb6_1(25):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(25):=68;
RQTY_100030_.tb6_2(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(25),-1)));
RQTY_100030_.old_tb6_3(25):=42279;
RQTY_100030_.tb6_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(25),-1)));
RQTY_100030_.old_tb6_4(25):=null;
RQTY_100030_.tb6_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(25),-1)));
RQTY_100030_.old_tb6_5(25):=null;
RQTY_100030_.tb6_5(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(25),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (25)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(25),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(25),
ENTITY_ID=RQTY_100030_.tb6_2(25),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(25),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(25),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Identificador de la solicitud del sistema externo'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='REQUEST_ID_EXTERN'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='REQUEST_ID_EXTERN'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(25);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(25),
RQTY_100030_.tb6_1(25),
RQTY_100030_.tb6_2(25),
RQTY_100030_.tb6_3(25),
RQTY_100030_.tb6_4(25),
RQTY_100030_.tb6_5(25),
null,
null,
null,
null,
16,
'Identificador de la solicitud del sistema externo'
,
16,
'N'
,
'N'
,
'N'
,
'REQUEST_ID_EXTERN'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'REQUEST_ID_EXTERN'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(26):=1986;
RQTY_100030_.tb6_1(26):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(26):=68;
RQTY_100030_.tb6_2(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(26),-1)));
RQTY_100030_.old_tb6_3(26):=1081;
RQTY_100030_.tb6_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(26),-1)));
RQTY_100030_.old_tb6_4(26):=null;
RQTY_100030_.tb6_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(26),-1)));
RQTY_100030_.old_tb6_5(26):=null;
RQTY_100030_.tb6_5(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(26),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (26)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(26),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(26),
ENTITY_ID=RQTY_100030_.tb6_2(26),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(26),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(26),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(26),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Suscriptor'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='CUSTOMER'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='SUBSCRIBER_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(26);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(26),
RQTY_100030_.tb6_1(26),
RQTY_100030_.tb6_2(26),
RQTY_100030_.tb6_3(26),
RQTY_100030_.tb6_4(26),
RQTY_100030_.tb6_5(26),
null,
null,
null,
null,
17,
'Suscriptor'
,
17,
'N'
,
'N'
,
'N'
,
'CUSTOMER'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'SUBSCRIBER_ID'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(27):=1987;
RQTY_100030_.tb6_1(27):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(27):=68;
RQTY_100030_.tb6_2(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(27),-1)));
RQTY_100030_.old_tb6_3(27):=2826;
RQTY_100030_.tb6_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(27),-1)));
RQTY_100030_.old_tb6_4(27):=null;
RQTY_100030_.tb6_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(27),-1)));
RQTY_100030_.old_tb6_5(27):=null;
RQTY_100030_.tb6_5(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(27),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (27)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(27),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(27),
ENTITY_ID=RQTY_100030_.tb6_2(27),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(27),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(27),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(27),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Informaci¿n de contrato'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='INFORMACI_N_DE_CONTRATO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='CONTRACT_INFORMATION'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(27);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(27),
RQTY_100030_.tb6_1(27),
RQTY_100030_.tb6_2(27),
RQTY_100030_.tb6_3(27),
RQTY_100030_.tb6_4(27),
RQTY_100030_.tb6_5(27),
null,
null,
null,
null,
18,
'Informaci¿n de contrato'
,
18,
'N'
,
'N'
,
'N'
,
'INFORMACI_N_DE_CONTRATO'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'CONTRACT_INFORMATION'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(28):=1989;
RQTY_100030_.tb6_1(28):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(28):=68;
RQTY_100030_.tb6_2(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(28),-1)));
RQTY_100030_.old_tb6_3(28):=1040;
RQTY_100030_.tb6_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(28),-1)));
RQTY_100030_.old_tb6_4(28):=null;
RQTY_100030_.tb6_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(28),-1)));
RQTY_100030_.old_tb6_5(28):=null;
RQTY_100030_.tb6_5(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(28),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (28)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(28),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(28),
ENTITY_ID=RQTY_100030_.tb6_2(28),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(28),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(28),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(28),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=33,
DISPLAY_NAME='C¿digo de la Ubicaci¿n Geogr¿fica'
,
DISPLAY_ORDER=33,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='C_DIGO_DE_LA_UBICACI_N_GEOGR_FICA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='GEOGRAP_LOCATION_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(28);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(28),
RQTY_100030_.tb6_1(28),
RQTY_100030_.tb6_2(28),
RQTY_100030_.tb6_3(28),
RQTY_100030_.tb6_4(28),
RQTY_100030_.tb6_5(28),
null,
null,
null,
null,
33,
'C¿digo de la Ubicaci¿n Geogr¿fica'
,
33,
'N'
,
'N'
,
'N'
,
'C_DIGO_DE_LA_UBICACI_N_GEOGR_FICA'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'GEOGRAP_LOCATION_ID'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(29):=1990;
RQTY_100030_.tb6_1(29):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(29):=68;
RQTY_100030_.tb6_2(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(29),-1)));
RQTY_100030_.old_tb6_3(29):=42655;
RQTY_100030_.tb6_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(29),-1)));
RQTY_100030_.old_tb6_4(29):=null;
RQTY_100030_.tb6_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(29),-1)));
RQTY_100030_.old_tb6_5(29):=null;
RQTY_100030_.tb6_5(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(29),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (29)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(29),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(29),
ENTITY_ID=RQTY_100030_.tb6_2(29),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(29),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(29),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(29),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=34,
DISPLAY_NAME='C¿digo del Barrio'
,
DISPLAY_ORDER=34,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='C_DIGO_DEL_BARRIO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='NEIGHBORTHOOD_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(29);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(29),
RQTY_100030_.tb6_1(29),
RQTY_100030_.tb6_2(29),
RQTY_100030_.tb6_3(29),
RQTY_100030_.tb6_4(29),
RQTY_100030_.tb6_5(29),
null,
null,
null,
null,
34,
'C¿digo del Barrio'
,
34,
'N'
,
'N'
,
'N'
,
'C_DIGO_DEL_BARRIO'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'NEIGHBORTHOOD_ID'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(30):=100997;
RQTY_100030_.tb6_1(30):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(30):=17;
RQTY_100030_.tb6_2(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(30),-1)));
RQTY_100030_.old_tb6_3(30):=261;
RQTY_100030_.tb6_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(30),-1)));
RQTY_100030_.old_tb6_4(30):=null;
RQTY_100030_.tb6_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(30),-1)));
RQTY_100030_.old_tb6_5(30):=null;
RQTY_100030_.tb6_5(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(30),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (30)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(30),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(30),
ENTITY_ID=RQTY_100030_.tb6_2(30),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(30),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(30),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(30),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=27,
DISPLAY_NAME='Terminal'
,
DISPLAY_ORDER=27,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='TERMINAL'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='TERMINAL_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(30);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(30),
RQTY_100030_.tb6_1(30),
RQTY_100030_.tb6_2(30),
RQTY_100030_.tb6_3(30),
RQTY_100030_.tb6_4(30),
RQTY_100030_.tb6_5(30),
null,
null,
null,
null,
27,
'Terminal'
,
27,
'N'
,
'N'
,
'Y'
,
'TERMINAL'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'TERMINAL_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb7_0(6):=120198211;
RQTY_100030_.tb7_0(6):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100030_.tb7_0(6):=RQTY_100030_.tb7_0(6);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (6)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100030_.tb7_0(6),
5,
'Sentencia Obtiene las posibles areas que gestionan - segun tipo de paquete y causa'
,
'select distinct p.management_area_id id, t.name_ description
from open.ps_package_areas p, open.GE_ORGANIZAT_AREA t
where p.management_area_id = t.organizat_area_id
and p.causing_area_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'ORGANIZAT_AREA_ID'|| chr(39) ||')'
,
'Sentencia Obtiene las posibles areas que gestionan - segun tipo de paquete y causa'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(31):=1371;
RQTY_100030_.tb6_1(31):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(31):=17;
RQTY_100030_.tb6_2(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(31),-1)));
RQTY_100030_.old_tb6_3(31):=182398;
RQTY_100030_.tb6_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(31),-1)));
RQTY_100030_.old_tb6_4(31):=null;
RQTY_100030_.tb6_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(31),-1)));
RQTY_100030_.old_tb6_5(31):=189644;
RQTY_100030_.tb6_5(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(31),-1)));
RQTY_100030_.tb6_6(31):=RQTY_100030_.tb7_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (31)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(31),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(31),
ENTITY_ID=RQTY_100030_.tb6_2(31),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(31),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(31),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(31),
STATEMENT_ID=RQTY_100030_.tb6_6(31),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='¿rea Que Gestiona La Solicitud'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='MANAGEMENT_AREA_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='MANAGEMENT_AREA_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(31);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(31),
RQTY_100030_.tb6_1(31),
RQTY_100030_.tb6_2(31),
RQTY_100030_.tb6_3(31),
RQTY_100030_.tb6_4(31),
RQTY_100030_.tb6_5(31),
RQTY_100030_.tb6_6(31),
null,
null,
null,
11,
'¿rea Que Gestiona La Solicitud'
,
11,
'Y'
,
'N'
,
'Y'
,
'MANAGEMENT_AREA_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'MANAGEMENT_AREA_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(16):=121407575;
RQTY_100030_.tb2_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(16):=RQTY_100030_.tb2_0(16);
RQTY_100030_.old_tb2_1(16):='MO_INITATRIB_CT23E121407575'
;
RQTY_100030_.tb2_1(16):=RQTY_100030_.tb2_0(16);
RQTY_100030_.tb2_2(16):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(16),
RQTY_100030_.tb2_1(16),
RQTY_100030_.tb2_2(16),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "OR_ORDER", "ORDER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"OR_ORDER","ORDER_ID",sbIdOrden);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbIdOrden);,)'
,
'LBTEST'
,
to_date('12-07-2012 15:31:27','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - ORDER_ID - Inicia el identificador de la orden'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(32):=1372;
RQTY_100030_.tb6_1(32):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(32):=17;
RQTY_100030_.tb6_2(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(32),-1)));
RQTY_100030_.old_tb6_3(32):=175491;
RQTY_100030_.tb6_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(32),-1)));
RQTY_100030_.old_tb6_4(32):=null;
RQTY_100030_.tb6_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(32),-1)));
RQTY_100030_.old_tb6_5(32):=null;
RQTY_100030_.tb6_5(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(32),-1)));
RQTY_100030_.tb6_7(32):=RQTY_100030_.tb2_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (32)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(32),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(32),
ENTITY_ID=RQTY_100030_.tb6_2(32),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(32),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(32),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(32),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(32),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Identificador De La Orden'
,
DISPLAY_ORDER=22,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ORDER_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='ORDER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(32);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(32),
RQTY_100030_.tb6_1(32),
RQTY_100030_.tb6_2(32),
RQTY_100030_.tb6_3(32),
RQTY_100030_.tb6_4(32),
RQTY_100030_.tb6_5(32),
null,
RQTY_100030_.tb6_7(32),
null,
null,
22,
'Identificador De La Orden'
,
22,
'Y'
,
'N'
,
'N'
,
'ORDER_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'ORDER_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(17):=121407576;
RQTY_100030_.tb2_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(17):=RQTY_100030_.tb2_0(17);
RQTY_100030_.old_tb2_1(17):='MO_INITATRIB_CT23E121407576'
;
RQTY_100030_.tb2_1(17):=RQTY_100030_.tb2_0(17);
RQTY_100030_.tb2_2(17):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(17),
RQTY_100030_.tb2_1(17),
RQTY_100030_.tb2_2(17),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('26-03-2012 11:56:29','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - CONTACT_ID - Inicializaci¿n del solicitante'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(33):=749;
RQTY_100030_.tb6_1(33):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(33):=17;
RQTY_100030_.tb6_2(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(33),-1)));
RQTY_100030_.old_tb6_3(33):=146755;
RQTY_100030_.tb6_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(33),-1)));
RQTY_100030_.old_tb6_4(33):=null;
RQTY_100030_.tb6_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(33),-1)));
RQTY_100030_.old_tb6_5(33):=null;
RQTY_100030_.tb6_5(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(33),-1)));
RQTY_100030_.tb6_7(33):=RQTY_100030_.tb2_0(17);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (33)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(33),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(33),
ENTITY_ID=RQTY_100030_.tb6_2(33),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(33),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(33),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(33),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(33),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Informaci¿n del Solicitante'
,
DISPLAY_ORDER=4,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='CONTACT_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='CONTACT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(33);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(33),
RQTY_100030_.tb6_1(33),
RQTY_100030_.tb6_2(33),
RQTY_100030_.tb6_3(33),
RQTY_100030_.tb6_4(33),
RQTY_100030_.tb6_5(33),
null,
RQTY_100030_.tb6_7(33),
null,
null,
4,
'Informaci¿n del Solicitante'
,
4,
'Y'
,
'N'
,
'Y'
,
'CONTACT_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'CONTACT_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(34):=100998;
RQTY_100030_.tb6_1(34):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(34):=17;
RQTY_100030_.tb6_2(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(34),-1)));
RQTY_100030_.old_tb6_3(34):=11621;
RQTY_100030_.tb6_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(34),-1)));
RQTY_100030_.old_tb6_4(34):=null;
RQTY_100030_.tb6_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(34),-1)));
RQTY_100030_.old_tb6_5(34):=null;
RQTY_100030_.tb6_5(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(34),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (34)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(34),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(34),
ENTITY_ID=RQTY_100030_.tb6_2(34),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(34),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(34),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(34),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=28,
DISPLAY_NAME='Identificador de la Suscripci¿n'
,
DISPLAY_ORDER=28,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DE_LA_SUSCRIPCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PACKAGES'
,
ATTRI_TECHNICAL_NAME='SUBSCRIPTION_PEND_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(34);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(34),
RQTY_100030_.tb6_1(34),
RQTY_100030_.tb6_2(34),
RQTY_100030_.tb6_3(34),
RQTY_100030_.tb6_4(34),
RQTY_100030_.tb6_5(34),
null,
null,
null,
null,
28,
'Identificador de la Suscripci¿n'
,
28,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DE_LA_SUSCRIPCI_N'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PACKAGES'
,
'SUBSCRIPTION_PEND_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(18):=121407577;
RQTY_100030_.tb2_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(18):=RQTY_100030_.tb2_0(18);
RQTY_100030_.old_tb2_1(18):='MO_VALIDATTR_CT26E121407577'
;
RQTY_100030_.tb2_1(18):=RQTY_100030_.tb2_0(18);
RQTY_100030_.tb2_2(18):=RQTY_100030_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(18),
RQTY_100030_.tb2_1(18),
RQTY_100030_.tb2_2(18),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_PROCESS", "ADDRESS", 1) = GE_BOCONSTANTS.GETTRUE() '||chr(38)||''||chr(38)||' MO_BOREGISTERWITHXML.FBLISREGISTERXML() = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","ADDRESS",sbAddress);if (UT_CONVERT.FBLISSTRINGNULL(sbAddress) = GE_BOCONSTANTS.GETFALSE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","GEOGRAP_LOCATION_ID",sbGeoLoca);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","NEIGHBORTHOOD_ID",sbNeighborthood);AB_BSADDRESSPARSER.INSERTADDRESSONNOTFOUND(sbGeoLoca,sbAddress,nuIdPrin,sbAddressParsed,sbMessage,nuError,sbErrorMessage,sbNeighborthood,"Y");if (nuError = 0,GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_PROCESS","ADDRESS_MAIN_MOTIVE",nuIdPrin,GE_BOCONSTANTS.GETTRUE());,GI_BOERRORS.SETERRORCODEARGUMENT(2741,sbErrorMessage););,);,)'
,
'LBTEST'
,
to_date('12-12-2011 14:24:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - Direccion registro en Registro de Quejas'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(35):=1991;
RQTY_100030_.tb6_1(35):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(35):=68;
RQTY_100030_.tb6_2(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(35),-1)));
RQTY_100030_.old_tb6_3(35):=702;
RQTY_100030_.tb6_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(35),-1)));
RQTY_100030_.old_tb6_4(35):=null;
RQTY_100030_.tb6_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(35),-1)));
RQTY_100030_.old_tb6_5(35):=null;
RQTY_100030_.tb6_5(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(35),-1)));
RQTY_100030_.tb6_8(35):=RQTY_100030_.tb2_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (35)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(35),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(35),
ENTITY_ID=RQTY_100030_.tb6_2(35),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(35),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(35),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(35),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100030_.tb6_8(35),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=35,
DISPLAY_NAME='Direcciones'
,
DISPLAY_ORDER=35,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DIRECCIONES'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(35);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(35),
RQTY_100030_.tb6_1(35),
RQTY_100030_.tb6_2(35),
RQTY_100030_.tb6_3(35),
RQTY_100030_.tb6_4(35),
RQTY_100030_.tb6_5(35),
null,
null,
RQTY_100030_.tb6_8(35),
null,
35,
'Direcciones'
,
35,
'N'
,
'N'
,
'N'
,
'DIRECCIONES'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'ADDRESS'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(36):=1992;
RQTY_100030_.tb6_1(36):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(36):=68;
RQTY_100030_.tb6_2(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(36),-1)));
RQTY_100030_.old_tb6_3(36):=2559;
RQTY_100030_.tb6_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(36),-1)));
RQTY_100030_.old_tb6_4(36):=null;
RQTY_100030_.tb6_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(36),-1)));
RQTY_100030_.old_tb6_5(36):=null;
RQTY_100030_.tb6_5(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(36),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (36)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(36),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(36),
ENTITY_ID=RQTY_100030_.tb6_2(36),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(36),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(36),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(36),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=36,
DISPLAY_NAME='Ubicaci¿n Respuesta'
,
DISPLAY_ORDER=36,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='UBICACI_N_RESPUESTA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='VALUE_2'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(36);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(36),
RQTY_100030_.tb6_1(36),
RQTY_100030_.tb6_2(36),
RQTY_100030_.tb6_3(36),
RQTY_100030_.tb6_4(36),
RQTY_100030_.tb6_5(36),
null,
null,
null,
null,
36,
'Ubicaci¿n Respuesta'
,
36,
'N'
,
'N'
,
'N'
,
'UBICACI_N_RESPUESTA'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'VALUE_2'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(37):=1713;
RQTY_100030_.tb6_1(37):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(37):=68;
RQTY_100030_.tb6_2(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(37),-1)));
RQTY_100030_.old_tb6_3(37):=189644;
RQTY_100030_.tb6_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(37),-1)));
RQTY_100030_.old_tb6_4(37):=null;
RQTY_100030_.tb6_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(37),-1)));
RQTY_100030_.old_tb6_5(37):=null;
RQTY_100030_.tb6_5(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(37),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (37)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(37),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(37),
ENTITY_ID=RQTY_100030_.tb6_2(37),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(37),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(37),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(37),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Causal'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='CAUSAL_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='CAUSAL_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(37);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(37),
RQTY_100030_.tb6_1(37),
RQTY_100030_.tb6_2(37),
RQTY_100030_.tb6_3(37),
RQTY_100030_.tb6_4(37),
RQTY_100030_.tb6_5(37),
null,
null,
null,
null,
9,
'Causal'
,
9,
'Y'
,
'N'
,
'Y'
,
'CAUSAL_ID'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'CAUSAL_ID'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(38):=1993;
RQTY_100030_.tb6_1(38):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(38):=68;
RQTY_100030_.tb6_2(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(38),-1)));
RQTY_100030_.old_tb6_3(38):=2558;
RQTY_100030_.tb6_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(38),-1)));
RQTY_100030_.old_tb6_4(38):=null;
RQTY_100030_.tb6_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(38),-1)));
RQTY_100030_.old_tb6_5(38):=null;
RQTY_100030_.tb6_5(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(38),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (38)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(38),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(38),
ENTITY_ID=RQTY_100030_.tb6_2(38),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(38),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(38),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(38),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=37,
DISPLAY_NAME='Barrio Respuesta'
,
DISPLAY_ORDER=37,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='BARRIO_RESPUESTA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='VALUE_1'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(38);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(38),
RQTY_100030_.tb6_1(38),
RQTY_100030_.tb6_2(38),
RQTY_100030_.tb6_3(38),
RQTY_100030_.tb6_4(38),
RQTY_100030_.tb6_5(38),
null,
null,
null,
null,
37,
'Barrio Respuesta'
,
37,
'N'
,
'N'
,
'N'
,
'BARRIO_RESPUESTA'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'VALUE_1'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(19):=121407578;
RQTY_100030_.tb2_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(19):=RQTY_100030_.tb2_0(19);
RQTY_100030_.old_tb2_1(19):='MO_VALIDATTR_CT26E121407578'
;
RQTY_100030_.tb2_1(19):=RQTY_100030_.tb2_0(19);
RQTY_100030_.tb2_2(19):=RQTY_100030_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(19),
RQTY_100030_.tb2_1(19),
RQTY_100030_.tb2_2(19),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_PROCESS", "NACIONALITY", 1) = GE_BOCONSTANTS.GETTRUE() '||chr(38)||''||chr(38)||' MO_BOREGISTERWITHXML.FBLISREGISTERXML() = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","NACIONALITY",sbAddress);if (UT_CONVERT.FBLISSTRINGNULL(sbAddress) = GE_BOCONSTANTS.GETFALSE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","GEOGRAP_LOCATION_ID",sbGeoLoca);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","NEIGHBORTHOOD_ID",sbNeighborthood);AB_BSADDRESSPARSER.INSERTADDRESSONNOTFOUND(sbGeoLoca,sbAddress,nuIdPrin,sbAddressParsed,sbMessage,nuError,sbErrorMessage,sbNeighborthood,"Y");if (nuError = 0,GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_PROCESS","ADDRESS_MAIN_COMP",nuIdPrin,GE_BOCONSTANTS.GETTRUE());,GI_BOERRORS.SETERRORCODEARGUMENT(2741,sbErrorMessage););,);,)'
,
'LBTEST'
,
to_date('12-12-2011 14:28:47','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - Direccion Respuesta en Registro de Quejas'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(39):=1994;
RQTY_100030_.tb6_1(39):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(39):=68;
RQTY_100030_.tb6_2(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(39),-1)));
RQTY_100030_.old_tb6_3(39):=1137;
RQTY_100030_.tb6_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(39),-1)));
RQTY_100030_.old_tb6_4(39):=null;
RQTY_100030_.tb6_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(39),-1)));
RQTY_100030_.old_tb6_5(39):=null;
RQTY_100030_.tb6_5(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(39),-1)));
RQTY_100030_.tb6_8(39):=RQTY_100030_.tb2_0(19);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (39)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(39),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(39),
ENTITY_ID=RQTY_100030_.tb6_2(39),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(39),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(39),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(39),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100030_.tb6_8(39),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=38,
DISPLAY_NAME='Direcci¿n Respuesta'
,
DISPLAY_ORDER=38,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DIRECCI_N_RESPUESTA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='NACIONALITY'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(39);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(39),
RQTY_100030_.tb6_1(39),
RQTY_100030_.tb6_2(39),
RQTY_100030_.tb6_3(39),
RQTY_100030_.tb6_4(39),
RQTY_100030_.tb6_5(39),
null,
null,
RQTY_100030_.tb6_8(39),
null,
38,
'Direcci¿n Respuesta'
,
38,
'N'
,
'N'
,
'N'
,
'DIRECCI_N_RESPUESTA'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'NACIONALITY'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(20):=121407579;
RQTY_100030_.tb2_0(20):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(20):=RQTY_100030_.tb2_0(20);
RQTY_100030_.old_tb2_1(20):='MO_INITATRIB_CT23E121407579'
;
RQTY_100030_.tb2_1(20):=RQTY_100030_.tb2_0(20);
RQTY_100030_.tb2_2(20):=RQTY_100030_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (20)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(20),
RQTY_100030_.tb2_1(20),
RQTY_100030_.tb2_2(20),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PACKAGES","PACKAGE_ID",sbPackageId);sbParam1 = "OBJECT_LEVEL=REQUEST";sbParam2 = UT_STRING.FSBCONCAT("OBJECT_ID=", sbPackageId, "");sbParam = UT_STRING.FSBCONCAT(sbParam1, sbParam2, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbParam)'
,
'LBTEST'
,
to_date('28-07-2012 14:29:52','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa los valores para el componente de archivos adjuntos (Nivel REQUEST)'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb6_0(40):=1548;
RQTY_100030_.tb6_1(40):=RQTY_100030_.tb5_0(0);
RQTY_100030_.old_tb6_2(40):=68;
RQTY_100030_.tb6_2(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100030_.TBENTITYNAME(NVL(RQTY_100030_.old_tb6_2(40),-1)));
RQTY_100030_.old_tb6_3(40):=2508;
RQTY_100030_.tb6_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_3(40),-1)));
RQTY_100030_.old_tb6_4(40):=null;
RQTY_100030_.tb6_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_4(40),-1)));
RQTY_100030_.old_tb6_5(40):=null;
RQTY_100030_.tb6_5(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100030_.TBENTITYATTRIBUTENAME(NVL(RQTY_100030_.old_tb6_5(40),-1)));
RQTY_100030_.tb6_7(40):=RQTY_100030_.tb2_0(20);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (40)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100030_.tb6_0(40),
PACKAGE_TYPE_ID=RQTY_100030_.tb6_1(40),
ENTITY_ID=RQTY_100030_.tb6_2(40),
ENTITY_ATTRIBUTE_ID=RQTY_100030_.tb6_3(40),
MIRROR_ENTI_ATTRIB=RQTY_100030_.tb6_4(40),
PARENT_ATTRIBUTE_ID=RQTY_100030_.tb6_5(40),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100030_.tb6_7(40),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Adjuntar Archivo'
,
DISPLAY_ORDER=13,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ADJUNTAR_ARCHIVO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='DUMMY'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100030_.tb6_0(40);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100030_.tb6_0(40),
RQTY_100030_.tb6_1(40),
RQTY_100030_.tb6_2(40),
RQTY_100030_.tb6_3(40),
RQTY_100030_.tb6_4(40),
RQTY_100030_.tb6_5(40),
null,
RQTY_100030_.tb6_7(40),
null,
null,
13,
'Adjuntar Archivo'
,
13,
'Y'
,
'N'
,
'N'
,
'ADJUNTAR_ARCHIVO'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'MO_PROCESS'
,
'DUMMY'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb8_0(0):=43;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100030_.tb8_0(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=8,
NAME_ATTRIBUTE='FAIL_PACK_ANSWER'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Respuesta de Fallo por Defecto para Solicitudes'
,
DISPLAY_NAME='Respuesta de Fallo por Defecto para Solicitudes'

 WHERE ATTRIBUTE_ID = RQTY_100030_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100030_.tb8_0(0),
null,
null,
1,
5,
8,
'FAIL_PACK_ANSWER'
,
null,
null,
null,
null,
null,
'Respuesta de Fallo por Defecto para Solicitudes'
,
'Respuesta de Fallo por Defecto para Solicitudes'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb9_0(0):=RQTY_100030_.tb5_0(0);
RQTY_100030_.tb9_1(0):=RQTY_100030_.tb8_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100030_.tb9_0(0),
RQTY_100030_.tb9_1(0),
'Respuesta de Fallo por Defecto para Solicitudes'
,
'1120'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb8_0(1):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100030_.tb8_0(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=1,
ATTRIBUTE_CLASS_ID=8,
NAME_ATTRIBUTE='MAX_DAYS'
,
LENGTH=10,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='N¿mero m¿ximo de d¿as'
,
DISPLAY_NAME='N¿mero m¿ximo de d¿as'

 WHERE ATTRIBUTE_ID = RQTY_100030_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100030_.tb8_0(1),
null,
null,
1,
1,
8,
'MAX_DAYS'
,
10,
null,
null,
null,
null,
'N¿mero m¿ximo de d¿as'
,
'N¿mero m¿ximo de d¿as'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb9_0(1):=RQTY_100030_.tb5_0(0);
RQTY_100030_.tb9_1(1):=RQTY_100030_.tb8_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100030_.tb9_0(1),
RQTY_100030_.tb9_1(1),
'N¿mero m¿ximo de d¿as'
,
'30'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb1_0(3):=64;
RQTY_100030_.tb1_1(3):=RQTY_100030_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100030_.tb1_0(3),
MODULE_ID=RQTY_100030_.tb1_1(3),
DESCRIPTION='Validaci¿n Tramites'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDTRAM_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100030_.tb1_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100030_.tb1_0(3),
RQTY_100030_.tb1_1(3),
'Validaci¿n Tramites'
,
'PL'
,
'FD'
,
'DS'
,
'_VALIDTRAM_'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(21):=121407580;
RQTY_100030_.tb2_0(21):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(21):=RQTY_100030_.tb2_0(21);
RQTY_100030_.old_tb2_1(21):='MO_VALIDTRAM_CT64E121407580'
;
RQTY_100030_.tb2_1(21):=RQTY_100030_.tb2_0(21);
RQTY_100030_.tb2_2(21):=RQTY_100030_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (21)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(21),
RQTY_100030_.tb2_1(21),
RQTY_100030_.tb2_2(21),
'IF ( Ge_BOInstanceControl.fblAcckeyAttributeStack("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = Ge_BOConstants.GetTrue(),Ge_BOInstanceControl.GetAttributeNewValue("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", sbProductId);nuProductId = UT_CONVERT.FNUCHARTONUMBER(sbProductId);IF ( PR_BOProduct.GetProductType(nuProductId) = 6300,Ge_BOErrors.setErrorCode(953);,);,)'
,
'CONFBOSS'
,
to_date('23-05-2005 17:19:39','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR - Valida si un producto es operador-carrier'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb8_0(2):=65;
RQTY_100030_.tb8_1(2):=RQTY_100030_.tb2_0(21);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100030_.tb8_0(2),
VALID_EXPRESSION=RQTY_100030_.tb8_1(2),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VALIDA_OPERADOR_CARRIER'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida si un producto es operador-carrier'
,
DISPLAY_NAME='Valida si un producto es operador-carrier'

 WHERE ATTRIBUTE_ID = RQTY_100030_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100030_.tb8_0(2),
RQTY_100030_.tb8_1(2),
null,
1,
5,
22,
'VALIDA_OPERADOR_CARRIER'
,
4,
0,
0,
null,
null,
'Valida si un producto es operador-carrier'
,
'Valida si un producto es operador-carrier'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb9_0(2):=RQTY_100030_.tb5_0(0);
RQTY_100030_.tb9_1(2):=RQTY_100030_.tb8_0(2);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (2)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100030_.tb9_0(2),
RQTY_100030_.tb9_1(2),
'Valida si un producto es operador-carrier'
,
'Y'
,
0,
'E'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(22):=121407581;
RQTY_100030_.tb2_0(22):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(22):=RQTY_100030_.tb2_0(22);
RQTY_100030_.old_tb2_1(22):='MO_VALIDTRAM_CT64E121407581'
;
RQTY_100030_.tb2_1(22):=RQTY_100030_.tb2_0(22);
RQTY_100030_.tb2_2(22):=RQTY_100030_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (22)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(22),
RQTY_100030_.tb2_1(22),
RQTY_100030_.tb2_2(22),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_SUBSCRIPTION", "SUBSCRIPTION_ID", "1") = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_SUBSCRIPTION","SUBSCRIPTION_ID",IdSubscripc);if (PKTBLSUSCRIPC.FNUGETTYPESUSCRIPTION(IdSubscripc,0) = 110,GE_BOERRORS.SETERRORCODE(5183);,);,)'
,
'CONFBOSS'
,
to_date('02-12-2005 18:14:57','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - CON - Valida que el contrato no sea tipo clientes ocasionales'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb8_0(3):=686;
RQTY_100030_.tb8_1(3):=RQTY_100030_.tb2_0(22);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (3)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100030_.tb8_0(3),
VALID_EXPRESSION=RQTY_100030_.tb8_1(3),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=21,
NAME_ATTRIBUTE='VAL_CONTRATO_NO_TIPO_CLIEN_OCASION'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='VALIDA QUE EL CONTRATO NO SEA TIPO CLIENTES OCASIONALES'
,
DISPLAY_NAME='VALIDA QUE EL CONTRATO NO SEA TIPO CLIENTES OCASIONALES'

 WHERE ATTRIBUTE_ID = RQTY_100030_.tb8_0(3);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100030_.tb8_0(3),
RQTY_100030_.tb8_1(3),
null,
1,
5,
21,
'VAL_CONTRATO_NO_TIPO_CLIEN_OCASION'
,
4,
0,
0,
null,
null,
'VALIDA QUE EL CONTRATO NO SEA TIPO CLIENTES OCASIONALES'
,
'VALIDA QUE EL CONTRATO NO SEA TIPO CLIENTES OCASIONALES'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb9_0(3):=RQTY_100030_.tb5_0(0);
RQTY_100030_.tb9_1(3):=RQTY_100030_.tb8_0(3);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (3)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100030_.tb9_0(3),
RQTY_100030_.tb9_1(3),
'VALIDA QUE EL CONTRATO NO SEA TIPO CLIENTES OCASIONALES'
,
'Y'
,
0,
'E'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(23):=121407582;
RQTY_100030_.tb2_0(23):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(23):=RQTY_100030_.tb2_0(23);
RQTY_100030_.old_tb2_1(23):='MO_VALIDTRAM_CT64E121407582'
;
RQTY_100030_.tb2_1(23):=RQTY_100030_.tb2_0(23);
RQTY_100030_.tb2_2(23):=RQTY_100030_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (23)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(23),
RQTY_100030_.tb2_1(23),
RQTY_100030_.tb2_2(23),
'IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_SUBSCRIPTION", "SUBSCRIPTION_ID", 1) = Ge_BOConstants.GetTrue(),Ge_BOInstanceControl.GetAttributeNewValue("WORK_INSTANCE", null, "PR_SUBSCRIPTION", "SUBSCRIPTION_ID", sbSubscriptionId);nuSubscriptionId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriptionId);IF(PKTBLSUSCRIPC.FNUGETTYPESUSCRIPTION(nuSubscriptionId)=13,GE_BOERRORS.SETERRORCODEARGUMENT(898, nuSubscriptionId);,);,)'
,
'CONFBOSS'
,
to_date('23-05-2005 17:28:58','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - CON - Valida que el contrato no sea tipo carrier'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb8_0(4):=57;
RQTY_100030_.tb8_1(4):=RQTY_100030_.tb2_0(23);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (4)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100030_.tb8_0(4),
VALID_EXPRESSION=RQTY_100030_.tb8_1(4),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=21,
NAME_ATTRIBUTE='VAL_CONT_NO_CARRIER'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='VALIDA QUE UN CONTRATO NO SEA TIPO CARRIER'
,
DISPLAY_NAME='VALIDA QUE UN CONTRATO NO SEA TIPO CARRIER'

 WHERE ATTRIBUTE_ID = RQTY_100030_.tb8_0(4);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100030_.tb8_0(4),
RQTY_100030_.tb8_1(4),
null,
1,
5,
21,
'VAL_CONT_NO_CARRIER'
,
4,
0,
0,
null,
null,
'VALIDA QUE UN CONTRATO NO SEA TIPO CARRIER'
,
'VALIDA QUE UN CONTRATO NO SEA TIPO CARRIER'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb9_0(4):=RQTY_100030_.tb5_0(0);
RQTY_100030_.tb9_1(4):=RQTY_100030_.tb8_0(4);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (4)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100030_.tb9_0(4),
RQTY_100030_.tb9_1(4),
'VALIDA QUE UN CONTRATO NO SEA TIPO CARRIER'
,
'Y'
,
0,
'E'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb1_0(4):=69;
RQTY_100030_.tb1_1(4):=RQTY_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (4)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100030_.tb1_0(4),
MODULE_ID=RQTY_100030_.tb1_1(4),
DESCRIPTION='Reglas validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULVAL_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100030_.tb1_0(4);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100030_.tb1_0(4),
RQTY_100030_.tb1_1(4),
'Reglas validaci¿n de atributos'
,
'PL'
,
'FD'
,
'DS'
,
'GE_EXERULVAL_'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(24):=121407583;
RQTY_100030_.tb2_0(24):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(24):=RQTY_100030_.tb2_0(24);
RQTY_100030_.old_tb2_1(24):='GEGE_EXERULVAL_CT69E121407583'
;
RQTY_100030_.tb2_1(24):=RQTY_100030_.tb2_0(24);
RQTY_100030_.tb2_2(24):=RQTY_100030_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (24)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(24),
RQTY_100030_.tb2_1(24),
RQTY_100030_.tb2_2(24),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuContrato);GC_BOINSOLVENCY.VALIDATESUSCRIPTIONTYPE(nuContrato,sbInsolvente);if (sbInsolvente = GE_BOCONSTANTS.GETYES(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El tr¿mite no puede ser ejecutado ya que el contrato se encuentra en proceso de Insolvencia Econ¿mica");,)'
,
'LBTEST'
,
to_date('27-07-2012 07:52:14','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:47','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida que el contrato no se encuentre en proceso de insolvencia econ¿mica (Nivel Contrato)'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb8_0(5):=163;
RQTY_100030_.tb8_1(5):=RQTY_100030_.tb2_0(24);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (5)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100030_.tb8_0(5),
VALID_EXPRESSION=RQTY_100030_.tb8_1(5),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=21,
NAME_ATTRIBUTE='VAL_CONTRA_NO_TENGA_INSOL_ECONO_NIV_CONT'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que el contrato no se encuentre en insolvencia econ¿mica (NIVEL CONTRATO)'
,
DISPLAY_NAME='Valida que el contrato no se encuentre en insolvencia econ¿mica (NIVEL CONTRATO)'

 WHERE ATTRIBUTE_ID = RQTY_100030_.tb8_0(5);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100030_.tb8_0(5),
RQTY_100030_.tb8_1(5),
null,
1,
5,
21,
'VAL_CONTRA_NO_TENGA_INSOL_ECONO_NIV_CONT'
,
null,
null,
null,
null,
null,
'Valida que el contrato no se encuentre en insolvencia econ¿mica (NIVEL CONTRATO)'
,
'Valida que el contrato no se encuentre en insolvencia econ¿mica (NIVEL CONTRATO)'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb9_0(5):=RQTY_100030_.tb5_0(0);
RQTY_100030_.tb9_1(5):=RQTY_100030_.tb8_0(5);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (5)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100030_.tb9_0(5),
RQTY_100030_.tb9_1(5),
'Valida que el contrato no se encuentre en insolvencia econ¿mica (NIVEL CONTRATO)'
,
'Y'
,
0,
'E'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb10_0(0):=78;
RQTY_100030_.tb10_1(0):=RQTY_100030_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100030_.tb10_0(0),
PACKAGE_TYPE_ID=RQTY_100030_.tb10_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=165,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100030_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100030_.tb10_0(0),
RQTY_100030_.tb10_1(0),
null,
null,
165,
21);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb11_0(0):=31;
RQTY_100030_.tb11_1(0):=RQTY_100030_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100030_.tb11_0(0),
VALUE_1=RQTY_100030_.tb11_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=165,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Registro de Quejas'
,
VALUE_3=null,
VALUE_4=null,
VALUE_5=null,
VALUE_6=null,
VALUE_7=null,
VALUE_8=null,
VALUE_9=null,
VALUE_10=null,
VALUE_11=null,
VALUE_12=null,
VALUE_13=null,
VALUE_14=null,
VALUE_15=null,
VALUE_16=null,
VALUE_17=null,
VALUE_18=null,
VALUE_19=null,
VALUE_20=null
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100030_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100030_.tb11_0(0),
RQTY_100030_.tb11_1(0),
null,
21,
165,
0,
31536000,
0,
'Registro de Quejas'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb12_0(0):=20;
RQTY_100030_.tb12_1(0):=RQTY_100030_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_EVENTS fila (0)',1);
UPDATE PS_PACKAGE_EVENTS SET PACKAGE_EVENTS_ID=RQTY_100030_.tb12_0(0),
PACKAGE_TYPE_ID=RQTY_100030_.tb12_1(0),
EVENT_ID=1
 WHERE PACKAGE_EVENTS_ID = RQTY_100030_.tb12_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_EVENTS(PACKAGE_EVENTS_ID,PACKAGE_TYPE_ID,EVENT_ID) 
VALUES (RQTY_100030_.tb12_0(0),
RQTY_100030_.tb12_1(0),
1);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb1_0(5):=65;
RQTY_100030_.tb1_1(5):=RQTY_100030_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (5)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100030_.tb1_0(5),
MODULE_ID=RQTY_100030_.tb1_1(5),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100030_.tb1_0(5);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100030_.tb1_0(5),
RQTY_100030_.tb1_1(5),
'Configuraci¿n eventos de componentes'
,
'PL'
,
'FD'
,
'DS'
,
'_EVE_COMP_'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(25):=121407584;
RQTY_100030_.tb2_0(25):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(25):=RQTY_100030_.tb2_0(25);
RQTY_100030_.old_tb2_1(25):='MO_EVE_COMP_CT65E121407584'
;
RQTY_100030_.tb2_1(25):=RQTY_100030_.tb2_0(25);
RQTY_100030_.tb2_2(25):=RQTY_100030_.tb1_0(5);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (25)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(25),
RQTY_100030_.tb2_1(25),
RQTY_100030_.tb2_2(25),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("GLOBAL_INSTANCE", null, "GLOBAL_ENTITY", "GLOBAL_LEVEL_NAME", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE("GLOBAL_LEVEL_NAME",sbNivel);if (sbNivel = "PR_SUBSCRIPTION" '||chr(38)||''||chr(38)||' GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbContrato);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PACKAGES","TAG_NAME",sbTagName);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","CAUSAL_ID",sbCausal);MO_BOINSISTENTLY.VALPACKFORSUBSANDCAUS(sbTagName,sbContrato,sbCausal,GE_BOCONSTANTS.GETTRUE());,if (sbNivel = "OR_FW_OR_ORDER" '||chr(38)||''||chr(38)||' GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "OR_ORDER", "ORDER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE' ||
'("WORK_INSTANCE",null,"OR_ORDER","ORDER_ID",sbIdOrden);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PACKAGES","TAG_NAME",sbTagName);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","CAUSAL_ID",sbCausal);MO_BOINSISTENTLY.VALPACKFORORDANDCAUS(sbTagName,sbIdOrden,sbCausal,GE_BOCONSTANTS.GETTRUE());,););,)'
,
'LBTEST'
,
to_date('23-08-2012 11:35:09','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:47','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'POST - PACK - Regla valiciones del tramite Registro de Quejas'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb13_0(0):=28;
RQTY_100030_.tb13_1(0):=RQTY_100030_.tb12_0(0);
RQTY_100030_.tb13_2(0):=RQTY_100030_.tb2_0(25);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_PACKAGE fila (0)',1);
UPDATE PS_WHEN_PACKAGE SET WHEN_PACKAGE_ID=RQTY_100030_.tb13_0(0),
PACKAGE_EVENT_ID=RQTY_100030_.tb13_1(0),
CONFIG_EXPRESSION_ID=RQTY_100030_.tb13_2(0),
EXECUTING_TIME='AF'
,
ACTIVE='Y'

 WHERE WHEN_PACKAGE_ID = RQTY_100030_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_PACKAGE(WHEN_PACKAGE_ID,PACKAGE_EVENT_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQTY_100030_.tb13_0(0),
RQTY_100030_.tb13_1(0),
RQTY_100030_.tb13_2(0),
'AF'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.old_tb2_0(26):=121407585;
RQTY_100030_.tb2_0(26):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100030_.tb2_0(26):=RQTY_100030_.tb2_0(26);
RQTY_100030_.old_tb2_1(26):='MO_EVE_COMP_CT65E121407585'
;
RQTY_100030_.tb2_1(26):=RQTY_100030_.tb2_0(26);
RQTY_100030_.tb2_2(26):=RQTY_100030_.tb1_0(5);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (26)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100030_.tb2_0(26),
RQTY_100030_.tb2_1(26),
RQTY_100030_.tb2_2(26),
'if (MO_BOREGISTERWITHXML.FBLISREGISTERXML() = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","CONTRACT_INFORMATION",sbContrato);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PACKAGES","ORDER_ID",sbOrder);if (sbContrato <> null '||chr(38)||''||chr(38)||' sbOrder <> null,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Debe ingresar s¿lo uno de estos campos: el contrato ¿ la orden de trabajo");,);,);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETFALSE(),GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrentInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,null,"MO_PACKAGES","CONTACT_ID",nuContactId);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbCurrentInstance,null,"MO_PACKAGES","SUBSCRIBER_ID",nuContactId,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,null,"MO_PACKAGES","TAG_NAM' ||
'E",sbTagName);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,null,"MO_PROCESS","CAUSAL_ID",sbCausal);MO_BOINSISTENTLY.VALPACKFORCLIEANDCAU(sbTagName,nuContactId,sbCausal,GE_BOCONSTANTS.GETTRUE());,)'
,
'LBTEST'
,
to_date('17-08-2012 15:25:26','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:47','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:26:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'PRE - PACK - Regla valiciones del tramite Registro de Quejas'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb13_0(1):=27;
RQTY_100030_.tb13_1(1):=RQTY_100030_.tb12_0(0);
RQTY_100030_.tb13_2(1):=RQTY_100030_.tb2_0(26);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_PACKAGE fila (1)',1);
UPDATE PS_WHEN_PACKAGE SET WHEN_PACKAGE_ID=RQTY_100030_.tb13_0(1),
PACKAGE_EVENT_ID=RQTY_100030_.tb13_1(1),
CONFIG_EXPRESSION_ID=RQTY_100030_.tb13_2(1),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_PACKAGE_ID = RQTY_100030_.tb13_0(1);
if not (sql%found) then
INSERT INTO PS_WHEN_PACKAGE(WHEN_PACKAGE_ID,PACKAGE_EVENT_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQTY_100030_.tb13_0(1),
RQTY_100030_.tb13_1(1),
RQTY_100030_.tb13_2(1),
'B'
,
'Y'
);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb14_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100030_.tb14_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb15_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100030_.tb15_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb16_0(0):=6121;
RQTY_100030_.tb16_2(0):=RQTY_100030_.tb14_0(0);
RQTY_100030_.tb16_3(0):=RQTY_100030_.tb15_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100030_.tb16_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100030_.tb16_2(0),
SERVSETI=RQTY_100030_.tb16_3(0),
SERVDESC='Gen¿rico'
,
SERVCOEX='N'
,
SERVFLST='N'
,
SERVFLBA='N'
,
SERVFLAC='S'
,
SERVFLIM='N'
,
SERVPRRE=-1,
SERVFLFR=null,
SERVFLRE=null,
SERVAPFR=null,
SERVVAAF=null,
SERVFLPC='N'
,
SERVTECO=null,
SERVFLFI=null,
SERVNVEC=1,
SERVLIQU='S'
,
SERVNPRC=null,
SERVORLE=1,
SERVREUB='Y'
,
SERVCEDI='Y'
,
SERVTXML='PR_GENERICO'
,
SERVASAU='Y'
,
SERVPRFI='N'
,
SERVCOLC='N'
,
SERVTICO='V'
,
SERVDIMI=0
 WHERE SERVCODI = RQTY_100030_.tb16_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100030_.tb16_0(0),
null,
RQTY_100030_.tb16_2(0),
RQTY_100030_.tb16_3(0),
'Gen¿rico'
,
'N'
,
'N'
,
'N'
,
'S'
,
'N'
,
-1,
null,
null,
null,
null,
'N'
,
null,
null,
1,
'S'
,
null,
1,
'Y'
,
'Y'
,
'PR_GENERICO'
,
'Y'
,
'N'
,
'N'
,
'V'
,
0);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb17_0(0):=33;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100030_.tb17_0(0),
CLASS_REGISTER_ID=6,
DESCRIPTION='RECLAMACIONES'
,
ASSIGNABLE='Y'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_RECLAMACIONES'
,
ACTIVITY_TYPE=null
 WHERE MOTIVE_TYPE_ID = RQTY_100030_.tb17_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100030_.tb17_0(0),
6,
'RECLAMACIONES'
,
'Y'
,
'Y'
,
'MOTY_RECLAMACIONES'
,
null);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb18_0(0):=100020;
RQTY_100030_.tb18_1(0):=RQTY_100030_.tb16_0(0);
RQTY_100030_.tb18_2(0):=RQTY_100030_.tb17_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100030_.tb18_0(0),
RQTY_100030_.tb18_1(0),
RQTY_100030_.tb18_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_REGISTRO_DE_QUEJAS_100020'
,
'Registro de Quejas'
,
'Y'
,
'N'
,
'N'
,
'Y'
,
'N'
,
'Y'
,
'N'
,
null,
null,
null,
'N'
,
'N'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;

RQTY_100030_.tb19_0(0):=100047;
RQTY_100030_.tb19_1(0):=RQTY_100030_.tb18_0(0);
RQTY_100030_.tb19_3(0):=RQTY_100030_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100030_.tb19_0(0),
PRODUCT_MOTIVE_ID=RQTY_100030_.tb19_1(0),
PRODUCT_TYPE_ID=6121,
PACKAGE_TYPE_ID=RQTY_100030_.tb19_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100030_.tb19_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100030_.tb19_0(0),
RQTY_100030_.tb19_1(0),
6121,
RQTY_100030_.tb19_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
nuIndex         binary_integer;
blObjectDeleted boolean;
BEGIN
ut_trace.trace('Inicia borrado de objetos de reglas',1);
nuIndex := RQTY_100030_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100030_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100030_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100030_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100030_.tbExpressionsId.next(nuIndex);
END loop;
ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
when ex.controlled_error then
ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm,1);
when others then
ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm,1);
END;
/

COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not RQTY_100030_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100030_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100030_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100030_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100030_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100030_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := RQTY_100030_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100030_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100030_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100030_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100030_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100030_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100030_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100030_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('RQTY_100030_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100030_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100030_',
'CREATE OR REPLACE PACKAGE RQPMT_100030_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyPS_PRODUCT_MOTIVERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PRODUCT_MOTIVERowId tyPS_PRODUCT_MOTIVERowId;type tyPS_PROD_MOTI_ACTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_MOTI_ACTIONRowId tyPS_PROD_MOTI_ACTIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type tyPS_PROD_MOTI_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_MOTI_ATTRIBRowId tyPS_PROD_MOTI_ATTRIBRowId;type tyPS_PRD_MOTIV_PACKAGERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PRD_MOTIV_PACKAGERowId tyPS_PRD_MOTIV_PACKAGERowId;type tyPS_PROD_MOTI_PARAMRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_MOTI_PARAMRowId tyPS_PROD_MOTI_PARAMRowId;type tyPS_PROD_MOTI_EVENTSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_MOTI_EVENTSRowId tyPS_PROD_MOTI_EVENTSRowId;type tyPS_PROD_MOTIVE_COMPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_MOTIVE_COMPRowId tyPS_PROD_MOTIVE_COMPRowId;type tyPS_WHEN_MOTIVERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_WHEN_MOTIVERowId tyPS_WHEN_MOTIVERowId;type tyPS_MOTI_COMPON_EVENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_MOTI_COMPON_EVENTRowId tyPS_MOTI_COMPON_EVENTRowId;type tyPS_MOTI_COMP_PARAMRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_MOTI_COMP_PARAMRowId tyPS_MOTI_COMP_PARAMRowId;type tyPS_SERVCOMP_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_SERVCOMP_CLASSRowId tyPS_SERVCOMP_CLASSRowId;type tyPS_MOTI_COMP_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_MOTI_COMP_ATTRIBSRowId tyPS_MOTI_COMP_ATTRIBSRowId;type tyPS_WHEN_MOTI_COMPONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_WHEN_MOTI_COMPONRowId tyPS_WHEN_MOTI_COMPONRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyPS_CLASS_SERVICERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_CLASS_SERVICERowId tyPS_CLASS_SERVICERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_SERVICE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_SERVICE_TYPERowId tyGE_SERVICE_TYPERowId;type tyPS_COMPONENT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_COMPONENT_TYPERowId tyPS_COMPONENT_TYPERowId;type tyGE_STATEMENT_COLUMNSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENT_COLUMNSRowId tyGE_STATEMENT_COLUMNSRowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyIM_COMPONENT_ROUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbIM_COMPONENT_ROUTERowId tyIM_COMPONENT_ROUTERowId;type tyPS_OBJECT_COMP_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_OBJECT_COMP_TYPERowId tyPS_OBJECT_COMP_TYPERowId;type ty0_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of PS_PROD_MOTI_ATTRIB.PROD_MOTI_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of PS_PROD_MOTI_ATTRIB.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of PS_PROD_MOTI_ATTRIB.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty1_3 is table of PS_PROD_MOTI_ATTRIB.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb1_3 ty1_3; ' || chr(10) ||
'tb1_3 ty1_3;type ty1_4 is table of PS_PROD_MOTI_ATTRIB.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_4 ty1_4; ' || chr(10) ||
'tb1_4 ty1_4;type ty1_5 is table of PS_PROD_MOTI_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_5 ty1_5; ' || chr(10) ||
'tb1_5 ty1_5;type ty1_6 is table of PS_PROD_MOTI_ATTRIB.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_6 ty1_6; ' || chr(10) ||
'tb1_6 ty1_6;type ty1_7 is table of PS_PROD_MOTI_ATTRIB.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_7 ty1_7; ' || chr(10) ||
'tb1_7 ty1_7;type ty1_8 is table of PS_PROD_MOTI_ATTRIB.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_8 ty1_8; ' || chr(10) ||
'tb1_8 ty1_8;type ty1_9 is table of PS_PROD_MOTI_ATTRIB.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_9 ty1_9; ' || chr(10) ||
'tb1_9 ty1_9;type ty2_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GR_CONFIGURA_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty5_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 100030; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100030 ' || chr(10) ||
')  ' || chr(10) ||
'AND     GE_ATTRIBUTES.attribute_id = PS_PROD_MOTI_PARAM.attribute_id ' || chr(10) ||
'AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression ' || chr(10) ||
'UNION  ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_MOTI_COMP_PARAM, PS_PROD_MOTIVE_COMP ' || chr(10) ||
'WHERE   PS_PROD_MOTIVE_COMP.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100030 ' || chr(10) ||
')  ' || chr(10) ||
'AND     PS_MOTI_COMP_PARAM.prod_motive_comp_id = PS_PROD_MOTIVE_COMP.prod_motive_comp_id ' || chr(10) ||
'AND     GE_ATTRIBUTES.attribute_id = PS_MOTI_COMP_PARAM.attribute_id ' || chr(10) ||
'AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression; ' || chr(10) ||
'nuIndex number; ' || chr(10) ||
'tbExpressionsId      dagr_config_expression.tytbConfig_Expression_Id; ' || chr(10) ||
' ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
'clColumn_0 clob; ' || chr(10) ||
'clColumn_1 clob;clColumn_2 clob; ' || chr(10) ||
'END RQPMT_100030_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100030_******************************'); END;
/

BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100030_.cuExpressions;
fetch RQPMT_100030_.cuExpressions bulk collect INTO RQPMT_100030_.tbExpressionsId;
close RQPMT_100030_.cuExpressions;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100030_.tbEntityName(-1) := 'NULL';
   RQPMT_100030_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_100030_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQPMT_100030_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100030_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQPMT_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100030_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQPMT_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100030_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos asociados a PS_WHEN_MOTIVE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_MOTIVE, PS_PROD_MOTI_EVENTS, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)
AND     ps_prod_moti_events.product_motive_id = PS_PRODUCT_MOTIVE.product_motive_id
AND     ps_when_motive.prod_moti_events_id = ps_prod_moti_events.prod_moti_events_id
AND     ps_when_motive.config_expression_id = gr_config_expression.config_expression_id
union all
--Obtiene Objetos asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)
AND     PS_PROD_MOTI_PARAM.product_motive_id = PS_PRODUCT_MOTIVE.product_motive_id
AND     PS_PROD_MOTI_PARAM.attribute_id = GE_ATTRIBUTES.attribute_id
AND     gr_config_expression.config_expression_id = ge_Attributes.valid_expression
union all
--Obtiene Objetos asociados a PS_PROD_MOTI_ATTRIB
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PROD_MOTI_ATTRIB, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)
AND     PS_PRODUCT_MOTIVE.product_motive_id = PS_PROD_MOTI_ATTRIB.product_motive_id
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ATTRIB.init_expression_id
OR       GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ATTRIB.valid_expression_id)
union all
--Obtiene Objetos asociados a PS_MOTI_COMP_ATTRIBS
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_MOTI_COMP_ATTRIBS,
        PS_PROD_MOTIVE_COMP, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)
AND     PS_PRODUCT_MOTIVE.product_motive_id = PS_PROD_MOTIVE_COMP.product_motive_id
AND     PS_PROD_MOTIVE_COMP.prod_motive_comp_id = PS_MOTI_COMP_ATTRIBS.prod_motive_comp_id
AND     (PS_MOTI_COMP_ATTRIBS.init_expression_id = GR_CONFIG_EXPRESSION.config_expression_id
OR       PS_MOTI_COMP_ATTRIBS.valid_expression_id = GR_CONFIG_EXPRESSION.config_expression_id)
union all
--Obtiene Objetos asociados a PS_WHEN_MOTI_COMPON
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_MOTI_COMPON, PS_MOTI_COMPON_EVENT,
        PS_PROD_MOTIVE_COMP, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)
AND     PS_PRODUCT_MOTIVE.product_motive_id = PS_PROD_MOTIVE_COMP.product_motive_id
AND     PS_PROD_MOTIVE_COMP.prod_motive_comp_id = PS_MOTI_COMPON_EVENT.prod_motive_comp_id
AND     PS_MOTI_COMPON_EVENT.moti_compon_event_id = PS_WHEN_MOTI_COMPON.moti_compon_event_id
AND     PS_WHEN_MOTI_COMPON.config_expression_id = GR_CONFIG_EXPRESSION.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PROD_MOTI_ACTION 
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PROD_MOTI_ACTION
WHERE   PS_PROD_MOTI_ACTION.product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100030_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_MOTI_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_MOTI_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100030_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100030_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PROD_MOTI_PARAM WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PROD_MOTI_PARAM WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_MOTI_PARAM WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_MOTI_PARAM',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_MOTI_PARAM WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100030_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100030_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_MOTI_COMPON_EVENT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_MOTI_COMPON_EVENT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_MOTI_COMP_PARAM WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_MOTI_COMP_PARAM WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_MOTI_COMP_PARAM WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_MOTI_COMP_PARAM',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_MOTI_COMP_PARAM WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100030_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100030_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)))));

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_MOTI_COMP_ATTRIBS',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_MOTI_COMP_ATTRIBS WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100030_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100030_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_CLASS_SERVICE WHERE (CLASS_SERVICE_ID) in (SELECT CLASS_SERVICE_ID FROM PS_SERVCOMP_CLASS WHERE (SERVICE_COMPONENT) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_SERVCOMP_CLASS WHERE (SERVICE_COMPONENT) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_SERVCOMP_CLASS',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_SERVCOMP_CLASS WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100030_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100030_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_MOTIVE_COMP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_MOTIVE_COMP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100030_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100030_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PRD_MOTIV_PACKAGE WHERE (PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID) in (SELECT PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PRD_MOTIV_PACKAGE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PRD_MOTIV_PACKAGE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_MOTIVE WHERE (PROD_MOTI_EVENTS_ID) in (SELECT PROD_MOTI_EVENTS_ID FROM PS_PROD_MOTI_EVENTS WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_WHEN_MOTIVE WHERE (PROD_MOTI_EVENTS_ID) in (SELECT PROD_MOTI_EVENTS_ID FROM PS_PROD_MOTI_EVENTS WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTIVE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_WHEN_MOTIVE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_MOTI_EVENTS WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_MOTI_EVENTS',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_MOTI_EVENTS WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXP_EXEC_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXP_EXEC_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
))));

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
)));
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100030_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_MOTI_ACTION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_MOTI_ACTION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100030_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100030_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100030_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100030_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100030_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100030_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100030
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PRODUCT_MOTIVE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PRODUCT_MOTIVE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb0_0(0):=100020;
RQPMT_100030_.tb0_1(0):=6121;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100030_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100030_.tb0_1(0),
MOTIVE_TYPE_ID=33,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_REGISTRO_DE_QUEJAS_100020'
,
DESCRIPTION='Registro de Quejas'
,
USE_UNCOMPOSITION='Y'
,
LOAD_PRODUCT_INFO='N'
,
LOAD_HIERARCHY='N'
,
PROCESS_WITH_XML='Y'
,
IS_MULTI_PRODUCT='N'
,
ACTIVE='Y'
,
IS_NULLABLE='N'
,
PROD_MOTI_TO_COPY_ID=null,
LOAD_ALLCOMP_IN_COPY=null,
LOAD_MOT_DATA_FOR_CP=null,
REUSABLE_IN_BUNDLE='N'
,
USED_IN_INCLUDED='N'

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100030_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100030_.tb0_0(0),
RQPMT_100030_.tb0_1(0),
33,
null,
'N'
,
'N'
,
'N'
,
'M_REGISTRO_DE_QUEJAS_100020'
,
'Registro de Quejas'
,
'Y'
,
'N'
,
'N'
,
'Y'
,
'N'
,
'Y'
,
'N'
,
null,
null,
null,
'N'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(0):=101847;
RQPMT_100030_.old_tb1_1(0):=8;
RQPMT_100030_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(0),-1)));
RQPMT_100030_.old_tb1_2(0):=524;
RQPMT_100030_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(0),-1)));
RQPMT_100030_.old_tb1_3(0):=null;
RQPMT_100030_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(0),-1)));
RQPMT_100030_.old_tb1_4(0):=null;
RQPMT_100030_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(0),-1)));
RQPMT_100030_.tb1_9(0):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(0),
ENTITY_ID=RQPMT_100030_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(0),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Estado del Motivo'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='ESTADO_DEL_MOTIVO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='MOTIVE_STATUS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(0),
RQPMT_100030_.tb1_1(0),
RQPMT_100030_.tb1_2(0),
RQPMT_100030_.tb1_3(0),
RQPMT_100030_.tb1_4(0),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(0),
9,
'Estado del Motivo'
,
9,
'N'
,
'N'
,
'N'
,
'Y'
,
'ESTADO_DEL_MOTIVO'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'MOTIVE_STATUS_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(1):=101848;
RQPMT_100030_.old_tb1_1(1):=8;
RQPMT_100030_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(1),-1)));
RQPMT_100030_.old_tb1_2(1):=191;
RQPMT_100030_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(1),-1)));
RQPMT_100030_.old_tb1_3(1):=null;
RQPMT_100030_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(1),-1)));
RQPMT_100030_.old_tb1_4(1):=null;
RQPMT_100030_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(1),-1)));
RQPMT_100030_.tb1_9(1):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(1),
ENTITY_ID=RQPMT_100030_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(1),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Identificador del Tipo de Motivo'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DEL_TIPO_DE_MOTIVO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='MOTIVE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(1),
RQPMT_100030_.tb1_1(1),
RQPMT_100030_.tb1_2(1),
RQPMT_100030_.tb1_3(1),
RQPMT_100030_.tb1_4(1),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(1),
11,
'Identificador del Tipo de Motivo'
,
11,
'N'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DEL_TIPO_DE_MOTIVO'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'MOTIVE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(2):=101849;
RQPMT_100030_.old_tb1_1(2):=8;
RQPMT_100030_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(2),-1)));
RQPMT_100030_.old_tb1_2(2):=192;
RQPMT_100030_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(2),-1)));
RQPMT_100030_.old_tb1_3(2):=null;
RQPMT_100030_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(2),-1)));
RQPMT_100030_.old_tb1_4(2):=null;
RQPMT_100030_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(2),-1)));
RQPMT_100030_.tb1_9(2):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(2),
ENTITY_ID=RQPMT_100030_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(2),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Identificador del Tipo de Producto'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DEL_TIPO_DE_PRODUCTO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='PRODUCT_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(2),
RQPMT_100030_.tb1_1(2),
RQPMT_100030_.tb1_2(2),
RQPMT_100030_.tb1_3(2),
RQPMT_100030_.tb1_4(2),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(2),
10,
'Identificador del Tipo de Producto'
,
10,
'N'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DEL_TIPO_DE_PRODUCTO'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'PRODUCT_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100030_.tb2_0(0),
DESCRIPTION='GESTI¿N DE MOTIVOS'
,
MNEMONIC='MO'
,
LAST_MESSAGE=136,
PATH_MODULE='Motives_Management'
,
ICON_NAME='mod_motivos'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = RQPMT_100030_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100030_.tb2_0(0),
'GESTI¿N DE MOTIVOS'
,
'MO'
,
136,
'Motives_Management'
,
'mod_motivos'
,
'IN'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb3_0(0):=23;
RQPMT_100030_.tb3_1(0):=RQPMT_100030_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100030_.tb3_0(0),
MODULE_ID=RQPMT_100030_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100030_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100030_.tb3_0(0),
RQPMT_100030_.tb3_1(0),
'Inicializacion de atributos'
,
'PL'
,
'FD'
,
'DS'
,
'_INITATRIB_'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.old_tb4_0(0):=121407586;
RQPMT_100030_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100030_.tb4_0(0):=RQPMT_100030_.tb4_0(0);
RQPMT_100030_.old_tb4_1(0):='MO_INITATRIB_CT23E121407586'
;
RQPMT_100030_.tb4_1(0):=RQPMT_100030_.tb4_0(0);
RQPMT_100030_.tb4_2(0):=RQPMT_100030_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100030_.tb4_0(0),
RQPMT_100030_.tb4_1(0),
RQPMT_100030_.tb4_2(0),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSuscriptionId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSuscriptionId);,);if (MO_BOREGISTERWITHXML.FBLISREGISTERXML() = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETFATHERCURRENTINSTANCE(sbInstanciaPadre);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstanciaPadre,null,"MO_PROCESS","CONTRACT_INFORMATION",sbIdContrato);if (UT_CONVERT.FNUCHARTONUMBER(sbIdContrato) <> null,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbIdContrato);,);,)'
,
'LBTEST'
,
to_date('17-07-2012 10:58:43','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:27:18','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:27:18','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - SUBSCRIPTION_ID - Inicia la Suscripcion'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(3):=101850;
RQPMT_100030_.old_tb1_1(3):=8;
RQPMT_100030_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(3),-1)));
RQPMT_100030_.old_tb1_2(3):=11403;
RQPMT_100030_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(3),-1)));
RQPMT_100030_.old_tb1_3(3):=null;
RQPMT_100030_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(3),-1)));
RQPMT_100030_.old_tb1_4(3):=null;
RQPMT_100030_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(3),-1)));
RQPMT_100030_.tb1_6(3):=RQPMT_100030_.tb4_0(0);
RQPMT_100030_.tb1_9(3):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(3),
ENTITY_ID=RQPMT_100030_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100030_.tb1_6(3),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(3),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador de la Suscripci¿n'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DE_LA_SUSCRIPCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='SUBSCRIPTION_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(3),
RQPMT_100030_.tb1_1(3),
RQPMT_100030_.tb1_2(3),
RQPMT_100030_.tb1_3(3),
RQPMT_100030_.tb1_4(3),
null,
RQPMT_100030_.tb1_6(3),
null,
null,
RQPMT_100030_.tb1_9(3),
12,
'Identificador de la Suscripci¿n'
,
12,
'N'
,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DE_LA_SUSCRIPCI_N'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'SUBSCRIPTION_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(4):=1821;
RQPMT_100030_.old_tb1_1(4):=5872;
RQPMT_100030_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(4),-1)));
RQPMT_100030_.old_tb1_2(4):=138161;
RQPMT_100030_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(4),-1)));
RQPMT_100030_.old_tb1_3(4):=null;
RQPMT_100030_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(4),-1)));
RQPMT_100030_.old_tb1_4(4):=null;
RQPMT_100030_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(4),-1)));
RQPMT_100030_.tb1_9(4):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(4),
ENTITY_ID=RQPMT_100030_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(4),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Atenci¿n Inmediata'
,
DISPLAY_ORDER=13,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='ATENCI_N_INMEDIATA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='GI_ATTRIBS'
,
ATTRI_TECHNICAL_NAME='ATTRIB01'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(4),
RQPMT_100030_.tb1_1(4),
RQPMT_100030_.tb1_2(4),
RQPMT_100030_.tb1_3(4),
RQPMT_100030_.tb1_4(4),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(4),
13,
'Atenci¿n Inmediata'
,
13,
'Y'
,
'N'
,
'N'
,
'N'
,
'ATENCI_N_INMEDIATA'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'GI_ATTRIBS'
,
'ATTRIB01'
,
'N'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(5):=1316;
RQPMT_100030_.old_tb1_1(5):=8;
RQPMT_100030_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(5),-1)));
RQPMT_100030_.old_tb1_2(5):=144514;
RQPMT_100030_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(5),-1)));
RQPMT_100030_.old_tb1_3(5):=189644;
RQPMT_100030_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(5),-1)));
RQPMT_100030_.old_tb1_4(5):=null;
RQPMT_100030_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(5),-1)));
RQPMT_100030_.tb1_9(5):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(5),
ENTITY_ID=RQPMT_100030_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(5),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Causal'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='CAUSAL_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='CAUSAL_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(5),
RQPMT_100030_.tb1_1(5),
RQPMT_100030_.tb1_2(5),
RQPMT_100030_.tb1_3(5),
RQPMT_100030_.tb1_4(5),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(5),
14,
'Causal'
,
14,
'N'
,
'N'
,
'N'
,
'N'
,
'CAUSAL_ID'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'CAUSAL_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.old_tb5_0(0):=120198212;
RQPMT_100030_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100030_.tb5_0(0):=RQPMT_100030_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100030_.tb5_0(0),
5,
'Respuesta para las Quejas'
,
'ldcproListaCausal(ID, DESCRIPTION, OUTPUT )'
,
'Respuesta para las Quejas'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(6):=1317;
RQPMT_100030_.old_tb1_1(6):=8;
RQPMT_100030_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(6),-1)));
RQPMT_100030_.old_tb1_2(6):=144591;
RQPMT_100030_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(6),-1)));
RQPMT_100030_.old_tb1_3(6):=null;
RQPMT_100030_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(6),-1)));
RQPMT_100030_.old_tb1_4(6):=null;
RQPMT_100030_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(6),-1)));
RQPMT_100030_.tb1_5(6):=RQPMT_100030_.tb5_0(0);
RQPMT_100030_.tb1_9(6):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(6),
ENTITY_ID=RQPMT_100030_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(6),
STATEMENT_ID=RQPMT_100030_.tb1_5(6),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(6),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Respuesta'
,
DISPLAY_ORDER=15,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='ANSWER_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='ANSWER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(6),
RQPMT_100030_.tb1_1(6),
RQPMT_100030_.tb1_2(6),
RQPMT_100030_.tb1_3(6),
RQPMT_100030_.tb1_4(6),
RQPMT_100030_.tb1_5(6),
null,
null,
null,
RQPMT_100030_.tb1_9(6),
15,
'Respuesta'
,
15,
'Y'
,
'N'
,
'N'
,
'N'
,
'ANSWER_ID'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'ANSWER_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.old_tb4_0(1):=121407587;
RQPMT_100030_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100030_.tb4_0(1):=RQPMT_100030_.tb4_0(1);
RQPMT_100030_.old_tb4_1(1):='MO_INITATRIB_CT23E121407587'
;
RQPMT_100030_.tb4_1(1):=RQPMT_100030_.tb4_0(1);
RQPMT_100030_.tb4_2(1):=RQPMT_100030_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100030_.tb4_0(1),
RQPMT_100030_.tb4_1(1),
RQPMT_100030_.tb4_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'LBTEST'
,
to_date('01-02-2011 08:55:27','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:27:18','DD-MM-YYYY HH24:MI:SS'),
to_date('03-02-2025 16:27:18','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - MOTIVE_ID - Inicializa el identificador del motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(7):=101832;
RQPMT_100030_.old_tb1_1(7):=8;
RQPMT_100030_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(7),-1)));
RQPMT_100030_.old_tb1_2(7):=187;
RQPMT_100030_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(7),-1)));
RQPMT_100030_.old_tb1_3(7):=null;
RQPMT_100030_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(7),-1)));
RQPMT_100030_.old_tb1_4(7):=null;
RQPMT_100030_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(7),-1)));
RQPMT_100030_.tb1_6(7):=RQPMT_100030_.tb4_0(1);
RQPMT_100030_.tb1_9(7):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(7),
ENTITY_ID=RQPMT_100030_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100030_.tb1_6(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(7),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Identificador de Motivo'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DE_MOTIVO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(7),
RQPMT_100030_.tb1_1(7),
RQPMT_100030_.tb1_2(7),
RQPMT_100030_.tb1_3(7),
RQPMT_100030_.tb1_4(7),
null,
RQPMT_100030_.tb1_6(7),
null,
null,
RQPMT_100030_.tb1_9(7),
0,
'Identificador de Motivo'
,
0,
'N'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DE_MOTIVO'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(8):=101834;
RQPMT_100030_.old_tb1_1(8):=8;
RQPMT_100030_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(8),-1)));
RQPMT_100030_.old_tb1_2(8):=213;
RQPMT_100030_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(8),-1)));
RQPMT_100030_.old_tb1_3(8):=255;
RQPMT_100030_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(8),-1)));
RQPMT_100030_.old_tb1_4(8):=null;
RQPMT_100030_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(8),-1)));
RQPMT_100030_.tb1_9(8):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(8),
ENTITY_ID=RQPMT_100030_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(8),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Identificador del Paquete'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DEL_PAQUETE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(8),
RQPMT_100030_.tb1_1(8),
RQPMT_100030_.tb1_2(8),
RQPMT_100030_.tb1_3(8),
RQPMT_100030_.tb1_4(8),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(8),
1,
'Identificador del Paquete'
,
1,
'N'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DEL_PAQUETE'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(9):=101836;
RQPMT_100030_.old_tb1_1(9):=8;
RQPMT_100030_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(9),-1)));
RQPMT_100030_.old_tb1_2(9):=2641;
RQPMT_100030_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(9),-1)));
RQPMT_100030_.old_tb1_3(9):=null;
RQPMT_100030_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(9),-1)));
RQPMT_100030_.old_tb1_4(9):=null;
RQPMT_100030_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(9),-1)));
RQPMT_100030_.tb1_9(9):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(9),
ENTITY_ID=RQPMT_100030_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(9),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='L¿mite de Cr¿dito'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='L_MITE_DE_CR_DITO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='CREDIT_LIMIT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(9),
RQPMT_100030_.tb1_1(9),
RQPMT_100030_.tb1_2(9),
RQPMT_100030_.tb1_3(9),
RQPMT_100030_.tb1_4(9),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(9),
2,
'L¿mite de Cr¿dito'
,
2,
'N'
,
'N'
,
'N'
,
'N'
,
'L_MITE_DE_CR_DITO'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'CREDIT_LIMIT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(10):=101837;
RQPMT_100030_.old_tb1_1(10):=8;
RQPMT_100030_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(10),-1)));
RQPMT_100030_.old_tb1_2(10):=189;
RQPMT_100030_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(10),-1)));
RQPMT_100030_.old_tb1_3(10):=257;
RQPMT_100030_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(10),-1)));
RQPMT_100030_.old_tb1_4(10):=null;
RQPMT_100030_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(10),-1)));
RQPMT_100030_.tb1_9(10):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(10),
ENTITY_ID=RQPMT_100030_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(10),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='N¿mero Petici¿n Atenci¿n al cliente'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='N_MERO_PETICI_N_ATENCI_N_AL_CLIENTE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='CUST_CARE_REQUES_NUM'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(10),
RQPMT_100030_.tb1_1(10),
RQPMT_100030_.tb1_2(10),
RQPMT_100030_.tb1_3(10),
RQPMT_100030_.tb1_4(10),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(10),
3,
'N¿mero Petici¿n Atenci¿n al cliente'
,
3,
'N'
,
'N'
,
'N'
,
'Y'
,
'N_MERO_PETICI_N_ATENCI_N_AL_CLIENTE'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'CUST_CARE_REQUES_NUM'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(11):=101842;
RQPMT_100030_.old_tb1_1(11):=8;
RQPMT_100030_.tb1_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(11),-1)));
RQPMT_100030_.old_tb1_2(11):=50001324;
RQPMT_100030_.tb1_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(11),-1)));
RQPMT_100030_.old_tb1_3(11):=null;
RQPMT_100030_.tb1_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(11),-1)));
RQPMT_100030_.old_tb1_4(11):=null;
RQPMT_100030_.tb1_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(11),-1)));
RQPMT_100030_.tb1_9(11):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(11),
ENTITY_ID=RQPMT_100030_.tb1_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(11),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Ubicaci¿n Geogr¿fica'
,
DISPLAY_ORDER=4,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='GEOGRAP_LOCATION_ID'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='GEOGRAP_LOCATION_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(11),
RQPMT_100030_.tb1_1(11),
RQPMT_100030_.tb1_2(11),
RQPMT_100030_.tb1_3(11),
RQPMT_100030_.tb1_4(11),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(11),
4,
'Ubicaci¿n Geogr¿fica'
,
4,
'N'
,
'N'
,
'N'
,
'N'
,
'GEOGRAP_LOCATION_ID'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'GEOGRAP_LOCATION_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(12):=101843;
RQPMT_100030_.old_tb1_1(12):=8;
RQPMT_100030_.tb1_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(12),-1)));
RQPMT_100030_.old_tb1_2(12):=201;
RQPMT_100030_.tb1_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(12),-1)));
RQPMT_100030_.old_tb1_3(12):=null;
RQPMT_100030_.tb1_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(12),-1)));
RQPMT_100030_.old_tb1_4(12):=null;
RQPMT_100030_.tb1_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(12),-1)));
RQPMT_100030_.tb1_9(12):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(12),
ENTITY_ID=RQPMT_100030_.tb1_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(12),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Inicio de Provisionalidad'
,
DISPLAY_ORDER=5,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='INICIO_DE_PROVISIONALIDAD'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='PROV_INITIAL_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(12),
RQPMT_100030_.tb1_1(12),
RQPMT_100030_.tb1_2(12),
RQPMT_100030_.tb1_3(12),
RQPMT_100030_.tb1_4(12),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(12),
5,
'Inicio de Provisionalidad'
,
5,
'N'
,
'N'
,
'N'
,
'Y'
,
'INICIO_DE_PROVISIONALIDAD'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'PROV_INITIAL_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(13):=101844;
RQPMT_100030_.old_tb1_1(13):=8;
RQPMT_100030_.tb1_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(13),-1)));
RQPMT_100030_.old_tb1_2(13):=202;
RQPMT_100030_.tb1_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(13),-1)));
RQPMT_100030_.old_tb1_3(13):=null;
RQPMT_100030_.tb1_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(13),-1)));
RQPMT_100030_.old_tb1_4(13):=null;
RQPMT_100030_.tb1_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(13),-1)));
RQPMT_100030_.tb1_9(13):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(13),
ENTITY_ID=RQPMT_100030_.tb1_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(13),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Fin de Provisionalidad'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='FIN_DE_PROVISIONALIDAD'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='PROV_FINAL_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(13),
RQPMT_100030_.tb1_1(13),
RQPMT_100030_.tb1_2(13),
RQPMT_100030_.tb1_3(13),
RQPMT_100030_.tb1_4(13),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(13),
6,
'Fin de Provisionalidad'
,
6,
'N'
,
'N'
,
'N'
,
'Y'
,
'FIN_DE_PROVISIONALIDAD'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'PROV_FINAL_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(14):=101845;
RQPMT_100030_.old_tb1_1(14):=8;
RQPMT_100030_.tb1_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(14),-1)));
RQPMT_100030_.old_tb1_2(14):=498;
RQPMT_100030_.tb1_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(14),-1)));
RQPMT_100030_.old_tb1_3(14):=null;
RQPMT_100030_.tb1_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(14),-1)));
RQPMT_100030_.old_tb1_4(14):=null;
RQPMT_100030_.tb1_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(14),-1)));
RQPMT_100030_.tb1_9(14):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(14),
ENTITY_ID=RQPMT_100030_.tb1_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(14),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Fecha de Atenci¿n'
,
DISPLAY_ORDER=7,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_DE_ATENCI_N'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='ATTENTION_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(14),
RQPMT_100030_.tb1_1(14),
RQPMT_100030_.tb1_2(14),
RQPMT_100030_.tb1_3(14),
RQPMT_100030_.tb1_4(14),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(14),
7,
'Fecha de Atenci¿n'
,
7,
'N'
,
'N'
,
'N'
,
'Y'
,
'FECHA_DE_ATENCI_N'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'ATTENTION_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;

RQPMT_100030_.tb1_0(15):=101846;
RQPMT_100030_.old_tb1_1(15):=8;
RQPMT_100030_.tb1_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100030_.TBENTITYNAME(NVL(RQPMT_100030_.old_tb1_1(15),-1)));
RQPMT_100030_.old_tb1_2(15):=220;
RQPMT_100030_.tb1_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_2(15),-1)));
RQPMT_100030_.old_tb1_3(15):=null;
RQPMT_100030_.tb1_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_3(15),-1)));
RQPMT_100030_.old_tb1_4(15):=null;
RQPMT_100030_.tb1_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100030_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100030_.old_tb1_4(15),-1)));
RQPMT_100030_.tb1_9(15):=RQPMT_100030_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100030_.tb1_0(15),
ENTITY_ID=RQPMT_100030_.tb1_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100030_.tb1_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100030_.tb1_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100030_.tb1_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100030_.tb1_9(15),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Identificador de Distribuci¿n Administrativa'
,
DISPLAY_ORDER=8,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DE_DISTRIBUCI_N_ADMINISTRATIVA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='DISTRIBUT_ADMIN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100030_.tb1_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100030_.tb1_0(15),
RQPMT_100030_.tb1_1(15),
RQPMT_100030_.tb1_2(15),
RQPMT_100030_.tb1_3(15),
RQPMT_100030_.tb1_4(15),
null,
null,
null,
null,
RQPMT_100030_.tb1_9(15),
8,
'Identificador de Distribuci¿n Administrativa'
,
8,
'N'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DE_DISTRIBUCI_N_ADMINISTRATIVA'
,
'N'
,
1,
'M'
,
'N'
,
'Y'
,
'Y'
,
'MO_MOTIVE'
,
'DISTRIBUT_ADMIN_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
declare
sbSuccess   varchar2(1);
nuErrCode   ge_error_log.error_log_id%type;
sbErrMssg   ge_error_log.description%type;
begin

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100030, sbSuccess);
FOR rc in RQPMT_100030_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
nuIndex         binary_integer;
blObjectDeleted boolean;
BEGIN
ut_trace.trace('Inicia borrado de objetos de reglas',1);
nuIndex := RQPMT_100030_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100030_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100030_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100030_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100030_.tbExpressionsId.next(nuIndex);
END loop;
ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
when ex.controlled_error then
ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm,1);
when others then
ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm,1);
END;
/

COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not RQPMT_100030_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100030_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100030_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100030_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100030_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100030_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := RQPMT_100030_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100030_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100030_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100030_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100030_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100030_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100030_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100030_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('RQPMT_100030_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100030_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100030_',
'CREATE OR REPLACE PACKAGE RQCFG_100030_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_CONFIGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIGRowId tyGI_CONFIGRowId;type tyGI_CONFIG_COMPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIG_COMPRowId tyGI_CONFIG_COMPRowId;type tyGI_COMPOSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITIONRowId tyGI_COMPOSITIONRowId;type tyGI_FRAMERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_FRAMERowId tyGI_FRAMERowId;type tyGI_COMP_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_ATTRIBSRowId tyGI_COMP_ATTRIBSRowId;type tyGI_COMP_FRAME_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_FRAME_ATTRIBRowId tyGI_COMP_FRAME_ATTRIBRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type ty0_0 is table of GI_CONFIG.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_2 is table of GI_CONFIG.ENTITY_ROOT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2;type ty1_0 is table of GI_COMPOSITION.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GI_COMPOSITION.EXTERNAL_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GI_COMPOSITION.ENTITY_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty1_3 is table of GI_COMPOSITION.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_3 ty1_3; ' || chr(10) ||
'tb1_3 ty1_3;type ty1_4 is table of GI_COMPOSITION.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_4 ty1_4; ' || chr(10) ||
'tb1_4 ty1_4;type ty2_0 is table of GI_CONFIG_COMP.CONFIG_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GI_CONFIG_COMP.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of GI_CONFIG_COMP.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_3 is table of GI_CONFIG_COMP.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_3 ty2_3; ' || chr(10) ||
'tb2_3 ty2_3;type ty3_0 is table of GI_COMP_ATTRIBS.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty3_4 is table of GI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_4 ty3_4; ' || chr(10) ||
'tb3_4 ty3_4;type ty3_5 is table of GI_COMP_ATTRIBS.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_5 ty3_5; ' || chr(10) ||
'tb3_5 ty3_5;type ty3_6 is table of GI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_6 ty3_6; ' || chr(10) ||
'tb3_6 ty3_6;type ty3_7 is table of GI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_7 ty3_7; ' || chr(10) ||
'tb3_7 ty3_7;type ty3_8 is table of GI_COMP_ATTRIBS.SELECT_STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_8 ty3_8; ' || chr(10) ||
'tb3_8 ty3_8;type ty3_9 is table of GI_COMP_ATTRIBS.PARENT_GROUP_ATTR_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_9 ty3_9; ' || chr(10) ||
'tb3_9 ty3_9;type ty4_0 is table of GI_FRAME.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GI_FRAME.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of GI_FRAME.AFTER_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of GI_FRAME.BEFORE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty5_0 is table of GI_COMP_FRAME_ATTRIB.COMP_FRAME_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of GI_COMP_FRAME_ATTRIB.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of GI_COMP_FRAME_ATTRIB.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty5_3 is table of GI_COMP_FRAME_ATTRIB.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_3 ty5_3; ' || chr(10) ||
'tb5_3 ty5_3;type ty5_4 is table of GI_COMP_FRAME_ATTRIB.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_4 ty5_4; ' || chr(10) ||
'tb5_4 ty5_4;CURSOR  cuCompositions IS ' || chr(10) ||
'SELECT  rowid ' || chr(10) ||
'FROM    gi_composition ' || chr(10) ||
'WHERE   composition_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT  composition_id ' || chr(10) ||
'FROM    gi_config_comp ' || chr(10) ||
'WHERE   config_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT  config_id ' || chr(10) ||
'FROM    gi_config ' || chr(10) ||
'WHERE   config_type_id = 4 ' || chr(10) ||
'AND     entity_root_id = 2012 ' || chr(10) ||
'AND     external_root_id = 100030 ' || chr(10) ||
') ' || chr(10) ||
'); ' || chr(10) ||
'nuIndex     number; ' || chr(10) ||
'type tyCompositions IS table of rowid; ' || chr(10) ||
'tbCompositions      tyCompositions; ' || chr(10) ||
' ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END RQCFG_100030_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100030_******************************'); END;
/

BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100030_.cuCompositions;
fetch RQCFG_100030_.cuCompositions bulk collect INTO RQCFG_100030_.tbCompositions;
close RQCFG_100030_.cuCompositions;

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100030_.tbEntityName(-1) := 'NULL';
   RQCFG_100030_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100030_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100030_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100030_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100030_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(260) := 'MO_PACKAGES@USER_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(261) := 'MO_PACKAGES@TERMINAL_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(419) := 'MO_PROCESS@PRODUCT_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(702) := 'MO_PROCESS@ADDRESS';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1040) := 'MO_PROCESS@GEOGRAP_LOCATION_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1081) := 'MO_PROCESS@SUBSCRIBER_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1137) := 'MO_PROCESS@NACIONALITY';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(2374) := 'MO_PACKAGES@ATTENTION_DATE';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2508) := 'MO_PROCESS@DUMMY';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(2666) := 'MO_PACKAGES@DISTRIBUT_ADMIN_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100030_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100030_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(40909) := 'MO_PACKAGES@ORGANIZAT_AREA_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(41406) := 'MO_PACKAGES@ZONE_ADMIN_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(42279) := 'MO_PROCESS@REQUEST_ID_EXTERN';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(42655) := 'MO_PROCESS@NEIGHBORTHOOD_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100030_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100030_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(175491) := 'MO_PACKAGES@ORDER_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(182398) := 'MO_PACKAGES@MANAGEMENT_AREA_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(2666) := 'MO_PACKAGES@DISTRIBUT_ADMIN_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(2374) := 'MO_PACKAGES@ATTENTION_DATE';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(419) := 'MO_PROCESS@PRODUCT_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1040) := 'MO_PROCESS@GEOGRAP_LOCATION_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(175491) := 'MO_PACKAGES@ORDER_ID';
   RQCFG_100030_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100030_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100030_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100030_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(260) := 'MO_PACKAGES@USER_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(702) := 'MO_PROCESS@ADDRESS';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(41406) := 'MO_PACKAGES@ZONE_ADMIN_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(40909) := 'MO_PACKAGES@ORGANIZAT_AREA_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(42655) := 'MO_PROCESS@NEIGHBORTHOOD_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(261) := 'MO_PACKAGES@TERMINAL_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2508) := 'MO_PROCESS@DUMMY';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1137) := 'MO_PROCESS@NACIONALITY';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(182398) := 'MO_PACKAGES@MANAGEMENT_AREA_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(42279) := 'MO_PROCESS@REQUEST_ID_EXTERN';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(1081) := 'MO_PROCESS@SUBSCRIBER_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100030_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100030_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100030_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100030_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100030_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100030_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  object_name
FROM    gr_config_expression, gi_frame
WHERE   (gr_config_expression.config_expression_id = gi_frame.after_expression_id
OR      gr_config_expression.config_expression_id = gi_frame.before_expression_id)
AND     composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id =
(
SELECT  config_id
FROM    gi_config
WHERE   config_type_id = 4
AND     entity_root_id = 2012
AND     external_root_id = 100030
)
);
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100030_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100030, 4);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100030_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100030_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100030_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100030_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100030_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030))));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030)));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100030, 4);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100030_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030))));
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030))));
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030))));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030)));

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100030_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100030_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100030_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100030_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100030_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GI_CONFIG_COMP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100030;

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb0_0(0):=8946;
RQCFG_100030_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100030_.tb0_0(0):=RQCFG_100030_.tb0_0(0);
RQCFG_100030_.old_tb0_2(0):=2012;
RQCFG_100030_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100030_.tb0_0(0),
100030,
RQCFG_100030_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb1_0(0):=1066098;
RQCFG_100030_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100030_.tb1_0(0):=RQCFG_100030_.tb1_0(0);
RQCFG_100030_.old_tb1_1(0):=100030;
RQCFG_100030_.tb1_1(0):=RQCFG_100030_.old_tb1_1(0);
RQCFG_100030_.old_tb1_2(0):=2012;
RQCFG_100030_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb1_2(0),-1)));
RQCFG_100030_.old_tb1_3(0):=8946;
RQCFG_100030_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb1_2(0),-1))), RQCFG_100030_.old_tb1_1(0), 4);
RQCFG_100030_.tb1_3(0):=RQCFG_100030_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100030_.tb1_0(0),
RQCFG_100030_.tb1_1(0),
RQCFG_100030_.tb1_2(0),
RQCFG_100030_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb2_0(0):=100026271;
RQCFG_100030_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100030_.tb2_0(0):=RQCFG_100030_.tb2_0(0);
RQCFG_100030_.tb2_1(0):=RQCFG_100030_.tb0_0(0);
RQCFG_100030_.tb2_2(0):=RQCFG_100030_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100030_.tb2_0(0),
RQCFG_100030_.tb2_1(0),
RQCFG_100030_.tb2_2(0),
null,
6121,
1,
1,
1);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb1_0(1):=1066099;
RQCFG_100030_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100030_.tb1_0(1):=RQCFG_100030_.tb1_0(1);
RQCFG_100030_.old_tb1_1(1):=100020;
RQCFG_100030_.tb1_1(1):=RQCFG_100030_.old_tb1_1(1);
RQCFG_100030_.old_tb1_2(1):=2013;
RQCFG_100030_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb1_2(1),-1)));
RQCFG_100030_.old_tb1_3(1):=null;
RQCFG_100030_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb1_2(1),-1))), RQCFG_100030_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100030_.tb1_0(1),
RQCFG_100030_.tb1_1(1),
RQCFG_100030_.tb1_2(1),
RQCFG_100030_.tb1_3(1),
null,
'M_REGISTRO_DE_QUEJAS_100020'
,
1,
1,
4);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb2_0(1):=100026272;
RQCFG_100030_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100030_.tb2_0(1):=RQCFG_100030_.tb2_0(1);
RQCFG_100030_.tb2_1(1):=RQCFG_100030_.tb0_0(0);
RQCFG_100030_.tb2_2(1):=RQCFG_100030_.tb1_0(1);
RQCFG_100030_.tb2_3(1):=RQCFG_100030_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100030_.tb2_0(1),
RQCFG_100030_.tb2_1(1),
RQCFG_100030_.tb2_2(1),
RQCFG_100030_.tb2_3(1),
6121,
2,
1,
1);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(0):=1152013;
RQCFG_100030_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(0):=RQCFG_100030_.tb3_0(0);
RQCFG_100030_.old_tb3_1(0):=3334;
RQCFG_100030_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(0),-1)));
RQCFG_100030_.old_tb3_2(0):=144514;
RQCFG_100030_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(0),-1)));
RQCFG_100030_.old_tb3_3(0):=189644;
RQCFG_100030_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(0),-1)));
RQCFG_100030_.old_tb3_4(0):=null;
RQCFG_100030_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(0),-1)));
RQCFG_100030_.tb3_5(0):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(0):=null;
RQCFG_100030_.tb3_6(0):=NULL;
RQCFG_100030_.old_tb3_7(0):=null;
RQCFG_100030_.tb3_7(0):=NULL;
RQCFG_100030_.old_tb3_8(0):=null;
RQCFG_100030_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(0),
RQCFG_100030_.tb3_1(0),
RQCFG_100030_.tb3_2(0),
RQCFG_100030_.tb3_3(0),
RQCFG_100030_.tb3_4(0),
RQCFG_100030_.tb3_5(0),
RQCFG_100030_.tb3_6(0),
RQCFG_100030_.tb3_7(0),
RQCFG_100030_.tb3_8(0),
null,
1316,
14,
'Causal'
,
'N'
,
'C'
,
'N'
,
14,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb4_0(0):=2587;
RQCFG_100030_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100030_.tb4_0(0):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb4_1(0):=RQCFG_100030_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100030_.tb4_0(0),
RQCFG_100030_.tb4_1(0),
null,
null,
'FRAME-M_REGISTRO_DE_QUEJAS_100020-1066099'
,
2);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(0):=1604671;
RQCFG_100030_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(0):=RQCFG_100030_.tb5_0(0);
RQCFG_100030_.old_tb5_1(0):=144514;
RQCFG_100030_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(0),-1)));
RQCFG_100030_.old_tb5_2(0):=null;
RQCFG_100030_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(0),-1)));
RQCFG_100030_.tb5_3(0):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(0):=RQCFG_100030_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(0),
RQCFG_100030_.tb5_1(0),
RQCFG_100030_.tb5_2(0),
RQCFG_100030_.tb5_3(0),
RQCFG_100030_.tb5_4(0),
'C'
,
'Y'
,
14,
'N'
,
'Causal'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(1):=1152014;
RQCFG_100030_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(1):=RQCFG_100030_.tb3_0(1);
RQCFG_100030_.old_tb3_1(1):=3334;
RQCFG_100030_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(1),-1)));
RQCFG_100030_.old_tb3_2(1):=144591;
RQCFG_100030_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(1),-1)));
RQCFG_100030_.old_tb3_3(1):=null;
RQCFG_100030_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(1),-1)));
RQCFG_100030_.old_tb3_4(1):=null;
RQCFG_100030_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(1),-1)));
RQCFG_100030_.tb3_5(1):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(1):=null;
RQCFG_100030_.tb3_6(1):=NULL;
RQCFG_100030_.old_tb3_7(1):=null;
RQCFG_100030_.tb3_7(1):=NULL;
RQCFG_100030_.old_tb3_8(1):=120198212;
RQCFG_100030_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(1),
RQCFG_100030_.tb3_1(1),
RQCFG_100030_.tb3_2(1),
RQCFG_100030_.tb3_3(1),
RQCFG_100030_.tb3_4(1),
RQCFG_100030_.tb3_5(1),
RQCFG_100030_.tb3_6(1),
RQCFG_100030_.tb3_7(1),
RQCFG_100030_.tb3_8(1),
null,
1317,
15,
'Respuesta'
,
'N'
,
'Y'
,
'N'
,
15,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(1):=1604672;
RQCFG_100030_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(1):=RQCFG_100030_.tb5_0(1);
RQCFG_100030_.old_tb5_1(1):=144591;
RQCFG_100030_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(1),-1)));
RQCFG_100030_.old_tb5_2(1):=null;
RQCFG_100030_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(1),-1)));
RQCFG_100030_.tb5_3(1):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(1):=RQCFG_100030_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(1),
RQCFG_100030_.tb5_1(1),
RQCFG_100030_.tb5_2(1),
RQCFG_100030_.tb5_3(1),
RQCFG_100030_.tb5_4(1),
'Y'
,
'Y'
,
15,
'N'
,
'Respuesta'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(2):=1152015;
RQCFG_100030_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(2):=RQCFG_100030_.tb3_0(2);
RQCFG_100030_.old_tb3_1(2):=3334;
RQCFG_100030_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(2),-1)));
RQCFG_100030_.old_tb3_2(2):=138161;
RQCFG_100030_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(2),-1)));
RQCFG_100030_.old_tb3_3(2):=null;
RQCFG_100030_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(2),-1)));
RQCFG_100030_.old_tb3_4(2):=null;
RQCFG_100030_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(2),-1)));
RQCFG_100030_.tb3_5(2):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(2):=null;
RQCFG_100030_.tb3_6(2):=NULL;
RQCFG_100030_.old_tb3_7(2):=null;
RQCFG_100030_.tb3_7(2):=NULL;
RQCFG_100030_.old_tb3_8(2):=null;
RQCFG_100030_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(2),
RQCFG_100030_.tb3_1(2),
RQCFG_100030_.tb3_2(2),
RQCFG_100030_.tb3_3(2),
RQCFG_100030_.tb3_4(2),
RQCFG_100030_.tb3_5(2),
RQCFG_100030_.tb3_6(2),
RQCFG_100030_.tb3_7(2),
RQCFG_100030_.tb3_8(2),
null,
1821,
13,
'Atenci¿n Inmediata'
,
'N'
,
'Y'
,
'N'
,
13,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(2):=1604673;
RQCFG_100030_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(2):=RQCFG_100030_.tb5_0(2);
RQCFG_100030_.old_tb5_1(2):=138161;
RQCFG_100030_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(2),-1)));
RQCFG_100030_.old_tb5_2(2):=null;
RQCFG_100030_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(2),-1)));
RQCFG_100030_.tb5_3(2):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(2):=RQCFG_100030_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(2),
RQCFG_100030_.tb5_1(2),
RQCFG_100030_.tb5_2(2),
RQCFG_100030_.tb5_3(2),
RQCFG_100030_.tb5_4(2),
'Y'
,
'Y'
,
13,
'N'
,
'Atenci¿n Inmediata'
,
'N'
,
'N'
,
'U'
,
null,
10,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(3):=1152016;
RQCFG_100030_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(3):=RQCFG_100030_.tb3_0(3);
RQCFG_100030_.old_tb3_1(3):=3334;
RQCFG_100030_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(3),-1)));
RQCFG_100030_.old_tb3_2(3):=187;
RQCFG_100030_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(3),-1)));
RQCFG_100030_.old_tb3_3(3):=null;
RQCFG_100030_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(3),-1)));
RQCFG_100030_.old_tb3_4(3):=null;
RQCFG_100030_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(3),-1)));
RQCFG_100030_.tb3_5(3):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(3):=121407587;
RQCFG_100030_.tb3_6(3):=NULL;
RQCFG_100030_.old_tb3_7(3):=null;
RQCFG_100030_.tb3_7(3):=NULL;
RQCFG_100030_.old_tb3_8(3):=null;
RQCFG_100030_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(3),
RQCFG_100030_.tb3_1(3),
RQCFG_100030_.tb3_2(3),
RQCFG_100030_.tb3_3(3),
RQCFG_100030_.tb3_4(3),
RQCFG_100030_.tb3_5(3),
RQCFG_100030_.tb3_6(3),
RQCFG_100030_.tb3_7(3),
RQCFG_100030_.tb3_8(3),
null,
101832,
0,
'Identificador de Motivo'
,
'N'
,
'C'
,
'Y'
,
0,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(3):=1604674;
RQCFG_100030_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(3):=RQCFG_100030_.tb5_0(3);
RQCFG_100030_.old_tb5_1(3):=187;
RQCFG_100030_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(3),-1)));
RQCFG_100030_.old_tb5_2(3):=null;
RQCFG_100030_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(3),-1)));
RQCFG_100030_.tb5_3(3):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(3):=RQCFG_100030_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(3),
RQCFG_100030_.tb5_1(3),
RQCFG_100030_.tb5_2(3),
RQCFG_100030_.tb5_3(3),
RQCFG_100030_.tb5_4(3),
'C'
,
'Y'
,
0,
'Y'
,
'Identificador de Motivo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(4):=1152017;
RQCFG_100030_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(4):=RQCFG_100030_.tb3_0(4);
RQCFG_100030_.old_tb3_1(4):=3334;
RQCFG_100030_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(4),-1)));
RQCFG_100030_.old_tb3_2(4):=213;
RQCFG_100030_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(4),-1)));
RQCFG_100030_.old_tb3_3(4):=255;
RQCFG_100030_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(4),-1)));
RQCFG_100030_.old_tb3_4(4):=null;
RQCFG_100030_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(4),-1)));
RQCFG_100030_.tb3_5(4):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(4):=null;
RQCFG_100030_.tb3_6(4):=NULL;
RQCFG_100030_.old_tb3_7(4):=null;
RQCFG_100030_.tb3_7(4):=NULL;
RQCFG_100030_.old_tb3_8(4):=null;
RQCFG_100030_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(4),
RQCFG_100030_.tb3_1(4),
RQCFG_100030_.tb3_2(4),
RQCFG_100030_.tb3_3(4),
RQCFG_100030_.tb3_4(4),
RQCFG_100030_.tb3_5(4),
RQCFG_100030_.tb3_6(4),
RQCFG_100030_.tb3_7(4),
RQCFG_100030_.tb3_8(4),
null,
101834,
1,
'Identificador del Paquete'
,
'N'
,
'C'
,
'Y'
,
1,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(4):=1604675;
RQCFG_100030_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(4):=RQCFG_100030_.tb5_0(4);
RQCFG_100030_.old_tb5_1(4):=213;
RQCFG_100030_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(4),-1)));
RQCFG_100030_.old_tb5_2(4):=null;
RQCFG_100030_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(4),-1)));
RQCFG_100030_.tb5_3(4):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(4):=RQCFG_100030_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(4),
RQCFG_100030_.tb5_1(4),
RQCFG_100030_.tb5_2(4),
RQCFG_100030_.tb5_3(4),
RQCFG_100030_.tb5_4(4),
'C'
,
'Y'
,
1,
'Y'
,
'Identificador del Paquete'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(5):=1152018;
RQCFG_100030_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(5):=RQCFG_100030_.tb3_0(5);
RQCFG_100030_.old_tb3_1(5):=3334;
RQCFG_100030_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(5),-1)));
RQCFG_100030_.old_tb3_2(5):=2641;
RQCFG_100030_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(5),-1)));
RQCFG_100030_.old_tb3_3(5):=null;
RQCFG_100030_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(5),-1)));
RQCFG_100030_.old_tb3_4(5):=null;
RQCFG_100030_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(5),-1)));
RQCFG_100030_.tb3_5(5):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(5):=null;
RQCFG_100030_.tb3_6(5):=NULL;
RQCFG_100030_.old_tb3_7(5):=null;
RQCFG_100030_.tb3_7(5):=NULL;
RQCFG_100030_.old_tb3_8(5):=null;
RQCFG_100030_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(5),
RQCFG_100030_.tb3_1(5),
RQCFG_100030_.tb3_2(5),
RQCFG_100030_.tb3_3(5),
RQCFG_100030_.tb3_4(5),
RQCFG_100030_.tb3_5(5),
RQCFG_100030_.tb3_6(5),
RQCFG_100030_.tb3_7(5),
RQCFG_100030_.tb3_8(5),
null,
101836,
2,
'L¿mite de Cr¿dito'
,
'N'
,
'C'
,
'N'
,
2,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(5):=1604676;
RQCFG_100030_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(5):=RQCFG_100030_.tb5_0(5);
RQCFG_100030_.old_tb5_1(5):=2641;
RQCFG_100030_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(5),-1)));
RQCFG_100030_.old_tb5_2(5):=null;
RQCFG_100030_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(5),-1)));
RQCFG_100030_.tb5_3(5):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(5):=RQCFG_100030_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(5),
RQCFG_100030_.tb5_1(5),
RQCFG_100030_.tb5_2(5),
RQCFG_100030_.tb5_3(5),
RQCFG_100030_.tb5_4(5),
'C'
,
'Y'
,
2,
'N'
,
'L¿mite de Cr¿dito'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(6):=1152019;
RQCFG_100030_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(6):=RQCFG_100030_.tb3_0(6);
RQCFG_100030_.old_tb3_1(6):=3334;
RQCFG_100030_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(6),-1)));
RQCFG_100030_.old_tb3_2(6):=189;
RQCFG_100030_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(6),-1)));
RQCFG_100030_.old_tb3_3(6):=257;
RQCFG_100030_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(6),-1)));
RQCFG_100030_.old_tb3_4(6):=null;
RQCFG_100030_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(6),-1)));
RQCFG_100030_.tb3_5(6):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(6):=null;
RQCFG_100030_.tb3_6(6):=NULL;
RQCFG_100030_.old_tb3_7(6):=null;
RQCFG_100030_.tb3_7(6):=NULL;
RQCFG_100030_.old_tb3_8(6):=null;
RQCFG_100030_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(6),
RQCFG_100030_.tb3_1(6),
RQCFG_100030_.tb3_2(6),
RQCFG_100030_.tb3_3(6),
RQCFG_100030_.tb3_4(6),
RQCFG_100030_.tb3_5(6),
RQCFG_100030_.tb3_6(6),
RQCFG_100030_.tb3_7(6),
RQCFG_100030_.tb3_8(6),
null,
101837,
3,
'N¿mero Petici¿n Atenci¿n al cliente'
,
'N'
,
'C'
,
'Y'
,
3,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(6):=1604677;
RQCFG_100030_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(6):=RQCFG_100030_.tb5_0(6);
RQCFG_100030_.old_tb5_1(6):=189;
RQCFG_100030_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(6),-1)));
RQCFG_100030_.old_tb5_2(6):=null;
RQCFG_100030_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(6),-1)));
RQCFG_100030_.tb5_3(6):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(6):=RQCFG_100030_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(6),
RQCFG_100030_.tb5_1(6),
RQCFG_100030_.tb5_2(6),
RQCFG_100030_.tb5_3(6),
RQCFG_100030_.tb5_4(6),
'C'
,
'Y'
,
3,
'Y'
,
'N¿mero Petici¿n Atenci¿n al cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(7):=1152020;
RQCFG_100030_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(7):=RQCFG_100030_.tb3_0(7);
RQCFG_100030_.old_tb3_1(7):=3334;
RQCFG_100030_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(7),-1)));
RQCFG_100030_.old_tb3_2(7):=50001324;
RQCFG_100030_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(7),-1)));
RQCFG_100030_.old_tb3_3(7):=null;
RQCFG_100030_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(7),-1)));
RQCFG_100030_.old_tb3_4(7):=null;
RQCFG_100030_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(7),-1)));
RQCFG_100030_.tb3_5(7):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(7):=null;
RQCFG_100030_.tb3_6(7):=NULL;
RQCFG_100030_.old_tb3_7(7):=null;
RQCFG_100030_.tb3_7(7):=NULL;
RQCFG_100030_.old_tb3_8(7):=null;
RQCFG_100030_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(7),
RQCFG_100030_.tb3_1(7),
RQCFG_100030_.tb3_2(7),
RQCFG_100030_.tb3_3(7),
RQCFG_100030_.tb3_4(7),
RQCFG_100030_.tb3_5(7),
RQCFG_100030_.tb3_6(7),
RQCFG_100030_.tb3_7(7),
RQCFG_100030_.tb3_8(7),
null,
101842,
4,
'Ubicaci¿n Geogr¿fica'
,
'N'
,
'C'
,
'N'
,
4,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(7):=1604678;
RQCFG_100030_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(7):=RQCFG_100030_.tb5_0(7);
RQCFG_100030_.old_tb5_1(7):=50001324;
RQCFG_100030_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(7),-1)));
RQCFG_100030_.old_tb5_2(7):=null;
RQCFG_100030_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(7),-1)));
RQCFG_100030_.tb5_3(7):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(7):=RQCFG_100030_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(7),
RQCFG_100030_.tb5_1(7),
RQCFG_100030_.tb5_2(7),
RQCFG_100030_.tb5_3(7),
RQCFG_100030_.tb5_4(7),
'C'
,
'Y'
,
4,
'N'
,
'Ubicaci¿n Geogr¿fica'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(8):=1152021;
RQCFG_100030_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(8):=RQCFG_100030_.tb3_0(8);
RQCFG_100030_.old_tb3_1(8):=3334;
RQCFG_100030_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(8),-1)));
RQCFG_100030_.old_tb3_2(8):=201;
RQCFG_100030_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(8),-1)));
RQCFG_100030_.old_tb3_3(8):=null;
RQCFG_100030_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(8),-1)));
RQCFG_100030_.old_tb3_4(8):=null;
RQCFG_100030_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(8),-1)));
RQCFG_100030_.tb3_5(8):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(8):=null;
RQCFG_100030_.tb3_6(8):=NULL;
RQCFG_100030_.old_tb3_7(8):=null;
RQCFG_100030_.tb3_7(8):=NULL;
RQCFG_100030_.old_tb3_8(8):=null;
RQCFG_100030_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(8),
RQCFG_100030_.tb3_1(8),
RQCFG_100030_.tb3_2(8),
RQCFG_100030_.tb3_3(8),
RQCFG_100030_.tb3_4(8),
RQCFG_100030_.tb3_5(8),
RQCFG_100030_.tb3_6(8),
RQCFG_100030_.tb3_7(8),
RQCFG_100030_.tb3_8(8),
null,
101843,
5,
'Inicio de Provisionalidad'
,
'N'
,
'C'
,
'Y'
,
5,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(8):=1604679;
RQCFG_100030_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(8):=RQCFG_100030_.tb5_0(8);
RQCFG_100030_.old_tb5_1(8):=201;
RQCFG_100030_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(8),-1)));
RQCFG_100030_.old_tb5_2(8):=null;
RQCFG_100030_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(8),-1)));
RQCFG_100030_.tb5_3(8):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(8):=RQCFG_100030_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(8),
RQCFG_100030_.tb5_1(8),
RQCFG_100030_.tb5_2(8),
RQCFG_100030_.tb5_3(8),
RQCFG_100030_.tb5_4(8),
'C'
,
'Y'
,
5,
'Y'
,
'Inicio de Provisionalidad'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(9):=1152022;
RQCFG_100030_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(9):=RQCFG_100030_.tb3_0(9);
RQCFG_100030_.old_tb3_1(9):=3334;
RQCFG_100030_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(9),-1)));
RQCFG_100030_.old_tb3_2(9):=202;
RQCFG_100030_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(9),-1)));
RQCFG_100030_.old_tb3_3(9):=null;
RQCFG_100030_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(9),-1)));
RQCFG_100030_.old_tb3_4(9):=null;
RQCFG_100030_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(9),-1)));
RQCFG_100030_.tb3_5(9):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(9):=null;
RQCFG_100030_.tb3_6(9):=NULL;
RQCFG_100030_.old_tb3_7(9):=null;
RQCFG_100030_.tb3_7(9):=NULL;
RQCFG_100030_.old_tb3_8(9):=null;
RQCFG_100030_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(9),
RQCFG_100030_.tb3_1(9),
RQCFG_100030_.tb3_2(9),
RQCFG_100030_.tb3_3(9),
RQCFG_100030_.tb3_4(9),
RQCFG_100030_.tb3_5(9),
RQCFG_100030_.tb3_6(9),
RQCFG_100030_.tb3_7(9),
RQCFG_100030_.tb3_8(9),
null,
101844,
6,
'Fin de Provisionalidad'
,
'N'
,
'C'
,
'Y'
,
6,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(9):=1604680;
RQCFG_100030_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(9):=RQCFG_100030_.tb5_0(9);
RQCFG_100030_.old_tb5_1(9):=202;
RQCFG_100030_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(9),-1)));
RQCFG_100030_.old_tb5_2(9):=null;
RQCFG_100030_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(9),-1)));
RQCFG_100030_.tb5_3(9):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(9):=RQCFG_100030_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(9),
RQCFG_100030_.tb5_1(9),
RQCFG_100030_.tb5_2(9),
RQCFG_100030_.tb5_3(9),
RQCFG_100030_.tb5_4(9),
'C'
,
'Y'
,
6,
'Y'
,
'Fin de Provisionalidad'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(10):=1152023;
RQCFG_100030_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(10):=RQCFG_100030_.tb3_0(10);
RQCFG_100030_.old_tb3_1(10):=3334;
RQCFG_100030_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(10),-1)));
RQCFG_100030_.old_tb3_2(10):=498;
RQCFG_100030_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(10),-1)));
RQCFG_100030_.old_tb3_3(10):=null;
RQCFG_100030_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(10),-1)));
RQCFG_100030_.old_tb3_4(10):=null;
RQCFG_100030_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(10),-1)));
RQCFG_100030_.tb3_5(10):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(10):=null;
RQCFG_100030_.tb3_6(10):=NULL;
RQCFG_100030_.old_tb3_7(10):=null;
RQCFG_100030_.tb3_7(10):=NULL;
RQCFG_100030_.old_tb3_8(10):=null;
RQCFG_100030_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(10),
RQCFG_100030_.tb3_1(10),
RQCFG_100030_.tb3_2(10),
RQCFG_100030_.tb3_3(10),
RQCFG_100030_.tb3_4(10),
RQCFG_100030_.tb3_5(10),
RQCFG_100030_.tb3_6(10),
RQCFG_100030_.tb3_7(10),
RQCFG_100030_.tb3_8(10),
null,
101845,
7,
'Fecha de Atenci¿n'
,
'N'
,
'C'
,
'Y'
,
7,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(10):=1604681;
RQCFG_100030_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(10):=RQCFG_100030_.tb5_0(10);
RQCFG_100030_.old_tb5_1(10):=498;
RQCFG_100030_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(10),-1)));
RQCFG_100030_.old_tb5_2(10):=null;
RQCFG_100030_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(10),-1)));
RQCFG_100030_.tb5_3(10):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(10):=RQCFG_100030_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(10),
RQCFG_100030_.tb5_1(10),
RQCFG_100030_.tb5_2(10),
RQCFG_100030_.tb5_3(10),
RQCFG_100030_.tb5_4(10),
'C'
,
'Y'
,
7,
'Y'
,
'Fecha de Atenci¿n'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(11):=1152024;
RQCFG_100030_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(11):=RQCFG_100030_.tb3_0(11);
RQCFG_100030_.old_tb3_1(11):=3334;
RQCFG_100030_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(11),-1)));
RQCFG_100030_.old_tb3_2(11):=220;
RQCFG_100030_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(11),-1)));
RQCFG_100030_.old_tb3_3(11):=null;
RQCFG_100030_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(11),-1)));
RQCFG_100030_.old_tb3_4(11):=null;
RQCFG_100030_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(11),-1)));
RQCFG_100030_.tb3_5(11):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(11):=null;
RQCFG_100030_.tb3_6(11):=NULL;
RQCFG_100030_.old_tb3_7(11):=null;
RQCFG_100030_.tb3_7(11):=NULL;
RQCFG_100030_.old_tb3_8(11):=null;
RQCFG_100030_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(11),
RQCFG_100030_.tb3_1(11),
RQCFG_100030_.tb3_2(11),
RQCFG_100030_.tb3_3(11),
RQCFG_100030_.tb3_4(11),
RQCFG_100030_.tb3_5(11),
RQCFG_100030_.tb3_6(11),
RQCFG_100030_.tb3_7(11),
RQCFG_100030_.tb3_8(11),
null,
101846,
8,
'Identificador de Distribuci¿n Administrativa'
,
'N'
,
'C'
,
'Y'
,
8,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(11):=1604682;
RQCFG_100030_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(11):=RQCFG_100030_.tb5_0(11);
RQCFG_100030_.old_tb5_1(11):=220;
RQCFG_100030_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(11),-1)));
RQCFG_100030_.old_tb5_2(11):=null;
RQCFG_100030_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(11),-1)));
RQCFG_100030_.tb5_3(11):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(11):=RQCFG_100030_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(11),
RQCFG_100030_.tb5_1(11),
RQCFG_100030_.tb5_2(11),
RQCFG_100030_.tb5_3(11),
RQCFG_100030_.tb5_4(11),
'C'
,
'Y'
,
8,
'Y'
,
'Identificador de Distribuci¿n Administrativa'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(12):=1152025;
RQCFG_100030_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(12):=RQCFG_100030_.tb3_0(12);
RQCFG_100030_.old_tb3_1(12):=3334;
RQCFG_100030_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(12),-1)));
RQCFG_100030_.old_tb3_2(12):=524;
RQCFG_100030_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(12),-1)));
RQCFG_100030_.old_tb3_3(12):=null;
RQCFG_100030_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(12),-1)));
RQCFG_100030_.old_tb3_4(12):=null;
RQCFG_100030_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(12),-1)));
RQCFG_100030_.tb3_5(12):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(12):=null;
RQCFG_100030_.tb3_6(12):=NULL;
RQCFG_100030_.old_tb3_7(12):=null;
RQCFG_100030_.tb3_7(12):=NULL;
RQCFG_100030_.old_tb3_8(12):=null;
RQCFG_100030_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(12),
RQCFG_100030_.tb3_1(12),
RQCFG_100030_.tb3_2(12),
RQCFG_100030_.tb3_3(12),
RQCFG_100030_.tb3_4(12),
RQCFG_100030_.tb3_5(12),
RQCFG_100030_.tb3_6(12),
RQCFG_100030_.tb3_7(12),
RQCFG_100030_.tb3_8(12),
null,
101847,
9,
'Estado del Motivo'
,
'N'
,
'C'
,
'Y'
,
9,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(12):=1604683;
RQCFG_100030_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(12):=RQCFG_100030_.tb5_0(12);
RQCFG_100030_.old_tb5_1(12):=524;
RQCFG_100030_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(12),-1)));
RQCFG_100030_.old_tb5_2(12):=null;
RQCFG_100030_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(12),-1)));
RQCFG_100030_.tb5_3(12):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(12):=RQCFG_100030_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(12),
RQCFG_100030_.tb5_1(12),
RQCFG_100030_.tb5_2(12),
RQCFG_100030_.tb5_3(12),
RQCFG_100030_.tb5_4(12),
'C'
,
'Y'
,
9,
'Y'
,
'Estado del Motivo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(13):=1152026;
RQCFG_100030_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(13):=RQCFG_100030_.tb3_0(13);
RQCFG_100030_.old_tb3_1(13):=3334;
RQCFG_100030_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(13),-1)));
RQCFG_100030_.old_tb3_2(13):=191;
RQCFG_100030_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(13),-1)));
RQCFG_100030_.old_tb3_3(13):=null;
RQCFG_100030_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(13),-1)));
RQCFG_100030_.old_tb3_4(13):=null;
RQCFG_100030_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(13),-1)));
RQCFG_100030_.tb3_5(13):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(13):=null;
RQCFG_100030_.tb3_6(13):=NULL;
RQCFG_100030_.old_tb3_7(13):=null;
RQCFG_100030_.tb3_7(13):=NULL;
RQCFG_100030_.old_tb3_8(13):=null;
RQCFG_100030_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(13),
RQCFG_100030_.tb3_1(13),
RQCFG_100030_.tb3_2(13),
RQCFG_100030_.tb3_3(13),
RQCFG_100030_.tb3_4(13),
RQCFG_100030_.tb3_5(13),
RQCFG_100030_.tb3_6(13),
RQCFG_100030_.tb3_7(13),
RQCFG_100030_.tb3_8(13),
null,
101848,
11,
'Identificador del Tipo de Motivo'
,
'N'
,
'C'
,
'Y'
,
11,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(13):=1604684;
RQCFG_100030_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(13):=RQCFG_100030_.tb5_0(13);
RQCFG_100030_.old_tb5_1(13):=191;
RQCFG_100030_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(13),-1)));
RQCFG_100030_.old_tb5_2(13):=null;
RQCFG_100030_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(13),-1)));
RQCFG_100030_.tb5_3(13):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(13):=RQCFG_100030_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(13),
RQCFG_100030_.tb5_1(13),
RQCFG_100030_.tb5_2(13),
RQCFG_100030_.tb5_3(13),
RQCFG_100030_.tb5_4(13),
'C'
,
'Y'
,
11,
'Y'
,
'Identificador del Tipo de Motivo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(14):=1152027;
RQCFG_100030_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(14):=RQCFG_100030_.tb3_0(14);
RQCFG_100030_.old_tb3_1(14):=3334;
RQCFG_100030_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(14),-1)));
RQCFG_100030_.old_tb3_2(14):=192;
RQCFG_100030_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(14),-1)));
RQCFG_100030_.old_tb3_3(14):=null;
RQCFG_100030_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(14),-1)));
RQCFG_100030_.old_tb3_4(14):=null;
RQCFG_100030_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(14),-1)));
RQCFG_100030_.tb3_5(14):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(14):=null;
RQCFG_100030_.tb3_6(14):=NULL;
RQCFG_100030_.old_tb3_7(14):=null;
RQCFG_100030_.tb3_7(14):=NULL;
RQCFG_100030_.old_tb3_8(14):=null;
RQCFG_100030_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(14),
RQCFG_100030_.tb3_1(14),
RQCFG_100030_.tb3_2(14),
RQCFG_100030_.tb3_3(14),
RQCFG_100030_.tb3_4(14),
RQCFG_100030_.tb3_5(14),
RQCFG_100030_.tb3_6(14),
RQCFG_100030_.tb3_7(14),
RQCFG_100030_.tb3_8(14),
null,
101849,
10,
'Identificador del Tipo de Producto'
,
'N'
,
'C'
,
'Y'
,
10,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(14):=1604685;
RQCFG_100030_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(14):=RQCFG_100030_.tb5_0(14);
RQCFG_100030_.old_tb5_1(14):=192;
RQCFG_100030_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(14),-1)));
RQCFG_100030_.old_tb5_2(14):=null;
RQCFG_100030_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(14),-1)));
RQCFG_100030_.tb5_3(14):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(14):=RQCFG_100030_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(14),
RQCFG_100030_.tb5_1(14),
RQCFG_100030_.tb5_2(14),
RQCFG_100030_.tb5_3(14),
RQCFG_100030_.tb5_4(14),
'C'
,
'Y'
,
10,
'Y'
,
'Identificador del Tipo de Producto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(15):=1152028;
RQCFG_100030_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(15):=RQCFG_100030_.tb3_0(15);
RQCFG_100030_.old_tb3_1(15):=3334;
RQCFG_100030_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(15),-1)));
RQCFG_100030_.old_tb3_2(15):=11403;
RQCFG_100030_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(15),-1)));
RQCFG_100030_.old_tb3_3(15):=null;
RQCFG_100030_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(15),-1)));
RQCFG_100030_.old_tb3_4(15):=null;
RQCFG_100030_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(15),-1)));
RQCFG_100030_.tb3_5(15):=RQCFG_100030_.tb2_2(1);
RQCFG_100030_.old_tb3_6(15):=121407586;
RQCFG_100030_.tb3_6(15):=NULL;
RQCFG_100030_.old_tb3_7(15):=null;
RQCFG_100030_.tb3_7(15):=NULL;
RQCFG_100030_.old_tb3_8(15):=null;
RQCFG_100030_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(15),
RQCFG_100030_.tb3_1(15),
RQCFG_100030_.tb3_2(15),
RQCFG_100030_.tb3_3(15),
RQCFG_100030_.tb3_4(15),
RQCFG_100030_.tb3_5(15),
RQCFG_100030_.tb3_6(15),
RQCFG_100030_.tb3_7(15),
RQCFG_100030_.tb3_8(15),
null,
101850,
12,
'Identificador de la Suscripci¿n'
,
'N'
,
'C'
,
'N'
,
12,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(15):=1604686;
RQCFG_100030_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(15):=RQCFG_100030_.tb5_0(15);
RQCFG_100030_.old_tb5_1(15):=11403;
RQCFG_100030_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(15),-1)));
RQCFG_100030_.old_tb5_2(15):=null;
RQCFG_100030_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(15),-1)));
RQCFG_100030_.tb5_3(15):=RQCFG_100030_.tb4_0(0);
RQCFG_100030_.tb5_4(15):=RQCFG_100030_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(15),
RQCFG_100030_.tb5_1(15),
RQCFG_100030_.tb5_2(15),
RQCFG_100030_.tb5_3(15),
RQCFG_100030_.tb5_4(15),
'C'
,
'Y'
,
12,
'N'
,
'Identificador de la Suscripci¿n'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(16):=1152029;
RQCFG_100030_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(16):=RQCFG_100030_.tb3_0(16);
RQCFG_100030_.old_tb3_1(16):=2036;
RQCFG_100030_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(16),-1)));
RQCFG_100030_.old_tb3_2(16):=6732;
RQCFG_100030_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(16),-1)));
RQCFG_100030_.old_tb3_3(16):=null;
RQCFG_100030_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(16),-1)));
RQCFG_100030_.old_tb3_4(16):=null;
RQCFG_100030_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(16),-1)));
RQCFG_100030_.tb3_5(16):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(16):=121407562;
RQCFG_100030_.tb3_6(16):=NULL;
RQCFG_100030_.old_tb3_7(16):=null;
RQCFG_100030_.tb3_7(16):=NULL;
RQCFG_100030_.old_tb3_8(16):=null;
RQCFG_100030_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(16),
RQCFG_100030_.tb3_1(16),
RQCFG_100030_.tb3_2(16),
RQCFG_100030_.tb3_3(16),
RQCFG_100030_.tb3_4(16),
RQCFG_100030_.tb3_5(16),
RQCFG_100030_.tb3_6(16),
RQCFG_100030_.tb3_7(16),
RQCFG_100030_.tb3_8(16),
null,
138,
21,
'Suscripci¿n'
,
'N'
,
'Y'
,
'N'
,
21,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb4_0(1):=2588;
RQCFG_100030_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100030_.tb4_0(1):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb4_1(1):=RQCFG_100030_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100030_.tb4_0(1),
RQCFG_100030_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1066098'
,
1);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(16):=1604687;
RQCFG_100030_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(16):=RQCFG_100030_.tb5_0(16);
RQCFG_100030_.old_tb5_1(16):=6732;
RQCFG_100030_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(16),-1)));
RQCFG_100030_.old_tb5_2(16):=null;
RQCFG_100030_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(16),-1)));
RQCFG_100030_.tb5_3(16):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(16):=RQCFG_100030_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(16),
RQCFG_100030_.tb5_1(16),
RQCFG_100030_.tb5_2(16),
RQCFG_100030_.tb5_3(16),
RQCFG_100030_.tb5_4(16),
'Y'
,
'N'
,
21,
'N'
,
'Suscripci¿n'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(17):=1152030;
RQCFG_100030_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(17):=RQCFG_100030_.tb3_0(17);
RQCFG_100030_.old_tb3_1(17):=2036;
RQCFG_100030_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(17),-1)));
RQCFG_100030_.old_tb3_2(17):=2666;
RQCFG_100030_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(17),-1)));
RQCFG_100030_.old_tb3_3(17):=null;
RQCFG_100030_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(17),-1)));
RQCFG_100030_.old_tb3_4(17):=null;
RQCFG_100030_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(17),-1)));
RQCFG_100030_.tb3_5(17):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(17):=null;
RQCFG_100030_.tb3_6(17):=NULL;
RQCFG_100030_.old_tb3_7(17):=null;
RQCFG_100030_.tb3_7(17):=NULL;
RQCFG_100030_.old_tb3_8(17):=120198208;
RQCFG_100030_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(17),
RQCFG_100030_.tb3_1(17),
RQCFG_100030_.tb3_2(17),
RQCFG_100030_.tb3_3(17),
RQCFG_100030_.tb3_4(17),
RQCFG_100030_.tb3_5(17),
RQCFG_100030_.tb3_6(17),
RQCFG_100030_.tb3_7(17),
RQCFG_100030_.tb3_8(17),
null,
101017,
32,
'Centro de Atenci¿n'
,
'N'
,
'C'
,
'N'
,
32,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(17):=1604688;
RQCFG_100030_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(17):=RQCFG_100030_.tb5_0(17);
RQCFG_100030_.old_tb5_1(17):=2666;
RQCFG_100030_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(17),-1)));
RQCFG_100030_.old_tb5_2(17):=null;
RQCFG_100030_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(17),-1)));
RQCFG_100030_.tb5_3(17):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(17):=RQCFG_100030_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(17),
RQCFG_100030_.tb5_1(17),
RQCFG_100030_.tb5_2(17),
RQCFG_100030_.tb5_3(17),
RQCFG_100030_.tb5_4(17),
'C'
,
'Y'
,
32,
'N'
,
'Centro de Atenci¿n'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(18):=1152031;
RQCFG_100030_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(18):=RQCFG_100030_.tb3_0(18);
RQCFG_100030_.old_tb3_1(18):=2036;
RQCFG_100030_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(18),-1)));
RQCFG_100030_.old_tb3_2(18):=40909;
RQCFG_100030_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(18),-1)));
RQCFG_100030_.old_tb3_3(18):=null;
RQCFG_100030_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(18),-1)));
RQCFG_100030_.old_tb3_4(18):=189644;
RQCFG_100030_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(18),-1)));
RQCFG_100030_.tb3_5(18):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(18):=null;
RQCFG_100030_.tb3_6(18):=NULL;
RQCFG_100030_.old_tb3_7(18):=null;
RQCFG_100030_.tb3_7(18):=NULL;
RQCFG_100030_.old_tb3_8(18):=120198210;
RQCFG_100030_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(18),
RQCFG_100030_.tb3_1(18),
RQCFG_100030_.tb3_2(18),
RQCFG_100030_.tb3_3(18),
RQCFG_100030_.tb3_4(18),
RQCFG_100030_.tb3_5(18),
RQCFG_100030_.tb3_6(18),
RQCFG_100030_.tb3_7(18),
RQCFG_100030_.tb3_8(18),
null,
1124,
10,
'¿rea Organizacional Causante'
,
'N'
,
'Y'
,
'Y'
,
10,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(18):=1604689;
RQCFG_100030_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(18):=RQCFG_100030_.tb5_0(18);
RQCFG_100030_.old_tb5_1(18):=40909;
RQCFG_100030_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(18),-1)));
RQCFG_100030_.old_tb5_2(18):=189644;
RQCFG_100030_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(18),-1)));
RQCFG_100030_.tb5_3(18):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(18):=RQCFG_100030_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(18),
RQCFG_100030_.tb5_1(18),
RQCFG_100030_.tb5_2(18),
RQCFG_100030_.tb5_3(18),
RQCFG_100030_.tb5_4(18),
'Y'
,
'Y'
,
10,
'Y'
,
'¿rea Organizacional Causante'
,
'N'
,
'N'
,
'U'
,
null,
18,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(19):=1152032;
RQCFG_100030_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(19):=RQCFG_100030_.tb3_0(19);
RQCFG_100030_.old_tb3_1(19):=2036;
RQCFG_100030_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(19),-1)));
RQCFG_100030_.old_tb3_2(19):=42279;
RQCFG_100030_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(19),-1)));
RQCFG_100030_.old_tb3_3(19):=null;
RQCFG_100030_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(19),-1)));
RQCFG_100030_.old_tb3_4(19):=null;
RQCFG_100030_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(19),-1)));
RQCFG_100030_.tb3_5(19):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(19):=null;
RQCFG_100030_.tb3_6(19):=NULL;
RQCFG_100030_.old_tb3_7(19):=null;
RQCFG_100030_.tb3_7(19):=NULL;
RQCFG_100030_.old_tb3_8(19):=null;
RQCFG_100030_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(19),
RQCFG_100030_.tb3_1(19),
RQCFG_100030_.tb3_2(19),
RQCFG_100030_.tb3_3(19),
RQCFG_100030_.tb3_4(19),
RQCFG_100030_.tb3_5(19),
RQCFG_100030_.tb3_6(19),
RQCFG_100030_.tb3_7(19),
RQCFG_100030_.tb3_8(19),
null,
1985,
16,
'Identificador de la solicitud del sistema externo'
,
'N'
,
'C'
,
'N'
,
16,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(19):=1604690;
RQCFG_100030_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(19):=RQCFG_100030_.tb5_0(19);
RQCFG_100030_.old_tb5_1(19):=42279;
RQCFG_100030_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(19),-1)));
RQCFG_100030_.old_tb5_2(19):=null;
RQCFG_100030_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(19),-1)));
RQCFG_100030_.tb5_3(19):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(19):=RQCFG_100030_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(19),
RQCFG_100030_.tb5_1(19),
RQCFG_100030_.tb5_2(19),
RQCFG_100030_.tb5_3(19),
RQCFG_100030_.tb5_4(19),
'C'
,
'Y'
,
16,
'N'
,
'Identificador de la solicitud del sistema externo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(20):=1152033;
RQCFG_100030_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(20):=RQCFG_100030_.tb3_0(20);
RQCFG_100030_.old_tb3_1(20):=2036;
RQCFG_100030_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(20),-1)));
RQCFG_100030_.old_tb3_2(20):=1081;
RQCFG_100030_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(20),-1)));
RQCFG_100030_.old_tb3_3(20):=null;
RQCFG_100030_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(20),-1)));
RQCFG_100030_.old_tb3_4(20):=null;
RQCFG_100030_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(20),-1)));
RQCFG_100030_.tb3_5(20):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(20):=null;
RQCFG_100030_.tb3_6(20):=NULL;
RQCFG_100030_.old_tb3_7(20):=null;
RQCFG_100030_.tb3_7(20):=NULL;
RQCFG_100030_.old_tb3_8(20):=null;
RQCFG_100030_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(20),
RQCFG_100030_.tb3_1(20),
RQCFG_100030_.tb3_2(20),
RQCFG_100030_.tb3_3(20),
RQCFG_100030_.tb3_4(20),
RQCFG_100030_.tb3_5(20),
RQCFG_100030_.tb3_6(20),
RQCFG_100030_.tb3_7(20),
RQCFG_100030_.tb3_8(20),
null,
1986,
17,
'Suscriptor'
,
'N'
,
'C'
,
'N'
,
17,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(20):=1604691;
RQCFG_100030_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(20):=RQCFG_100030_.tb5_0(20);
RQCFG_100030_.old_tb5_1(20):=1081;
RQCFG_100030_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(20),-1)));
RQCFG_100030_.old_tb5_2(20):=null;
RQCFG_100030_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(20),-1)));
RQCFG_100030_.tb5_3(20):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(20):=RQCFG_100030_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(20),
RQCFG_100030_.tb5_1(20),
RQCFG_100030_.tb5_2(20),
RQCFG_100030_.tb5_3(20),
RQCFG_100030_.tb5_4(20),
'C'
,
'Y'
,
17,
'N'
,
'Suscriptor'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(21):=1152034;
RQCFG_100030_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(21):=RQCFG_100030_.tb3_0(21);
RQCFG_100030_.old_tb3_1(21):=2036;
RQCFG_100030_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(21),-1)));
RQCFG_100030_.old_tb3_2(21):=2826;
RQCFG_100030_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(21),-1)));
RQCFG_100030_.old_tb3_3(21):=null;
RQCFG_100030_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(21),-1)));
RQCFG_100030_.old_tb3_4(21):=null;
RQCFG_100030_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(21),-1)));
RQCFG_100030_.tb3_5(21):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(21):=null;
RQCFG_100030_.tb3_6(21):=NULL;
RQCFG_100030_.old_tb3_7(21):=null;
RQCFG_100030_.tb3_7(21):=NULL;
RQCFG_100030_.old_tb3_8(21):=null;
RQCFG_100030_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(21),
RQCFG_100030_.tb3_1(21),
RQCFG_100030_.tb3_2(21),
RQCFG_100030_.tb3_3(21),
RQCFG_100030_.tb3_4(21),
RQCFG_100030_.tb3_5(21),
RQCFG_100030_.tb3_6(21),
RQCFG_100030_.tb3_7(21),
RQCFG_100030_.tb3_8(21),
null,
1987,
18,
'Informaci¿n de contrato'
,
'N'
,
'C'
,
'N'
,
18,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(21):=1604692;
RQCFG_100030_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(21):=RQCFG_100030_.tb5_0(21);
RQCFG_100030_.old_tb5_1(21):=2826;
RQCFG_100030_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(21),-1)));
RQCFG_100030_.old_tb5_2(21):=null;
RQCFG_100030_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(21),-1)));
RQCFG_100030_.tb5_3(21):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(21):=RQCFG_100030_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(21),
RQCFG_100030_.tb5_1(21),
RQCFG_100030_.tb5_2(21),
RQCFG_100030_.tb5_3(21),
RQCFG_100030_.tb5_4(21),
'C'
,
'Y'
,
18,
'N'
,
'Informaci¿n de contrato'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(22):=1152035;
RQCFG_100030_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(22):=RQCFG_100030_.tb3_0(22);
RQCFG_100030_.old_tb3_1(22):=2036;
RQCFG_100030_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(22),-1)));
RQCFG_100030_.old_tb3_2(22):=419;
RQCFG_100030_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(22),-1)));
RQCFG_100030_.old_tb3_3(22):=null;
RQCFG_100030_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(22),-1)));
RQCFG_100030_.old_tb3_4(22):=null;
RQCFG_100030_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(22),-1)));
RQCFG_100030_.tb3_5(22):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(22):=null;
RQCFG_100030_.tb3_6(22):=NULL;
RQCFG_100030_.old_tb3_7(22):=null;
RQCFG_100030_.tb3_7(22):=NULL;
RQCFG_100030_.old_tb3_8(22):=null;
RQCFG_100030_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(22),
RQCFG_100030_.tb3_1(22),
RQCFG_100030_.tb3_2(22),
RQCFG_100030_.tb3_3(22),
RQCFG_100030_.tb3_4(22),
RQCFG_100030_.tb3_5(22),
RQCFG_100030_.tb3_6(22),
RQCFG_100030_.tb3_7(22),
RQCFG_100030_.tb3_8(22),
null,
1988,
19,
'Identificador del Producto'
,
'N'
,
'C'
,
'N'
,
19,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(22):=1604693;
RQCFG_100030_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(22):=RQCFG_100030_.tb5_0(22);
RQCFG_100030_.old_tb5_1(22):=419;
RQCFG_100030_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(22),-1)));
RQCFG_100030_.old_tb5_2(22):=null;
RQCFG_100030_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(22),-1)));
RQCFG_100030_.tb5_3(22):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(22):=RQCFG_100030_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(22),
RQCFG_100030_.tb5_1(22),
RQCFG_100030_.tb5_2(22),
RQCFG_100030_.tb5_3(22),
RQCFG_100030_.tb5_4(22),
'C'
,
'Y'
,
19,
'N'
,
'Identificador del Producto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(23):=1152036;
RQCFG_100030_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(23):=RQCFG_100030_.tb3_0(23);
RQCFG_100030_.old_tb3_1(23):=2036;
RQCFG_100030_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(23),-1)));
RQCFG_100030_.old_tb3_2(23):=1040;
RQCFG_100030_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(23),-1)));
RQCFG_100030_.old_tb3_3(23):=null;
RQCFG_100030_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(23),-1)));
RQCFG_100030_.old_tb3_4(23):=null;
RQCFG_100030_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(23),-1)));
RQCFG_100030_.tb3_5(23):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(23):=null;
RQCFG_100030_.tb3_6(23):=NULL;
RQCFG_100030_.old_tb3_7(23):=null;
RQCFG_100030_.tb3_7(23):=NULL;
RQCFG_100030_.old_tb3_8(23):=null;
RQCFG_100030_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(23),
RQCFG_100030_.tb3_1(23),
RQCFG_100030_.tb3_2(23),
RQCFG_100030_.tb3_3(23),
RQCFG_100030_.tb3_4(23),
RQCFG_100030_.tb3_5(23),
RQCFG_100030_.tb3_6(23),
RQCFG_100030_.tb3_7(23),
RQCFG_100030_.tb3_8(23),
null,
1989,
33,
'C¿digo de la Ubicaci¿n Geogr¿fica'
,
'N'
,
'C'
,
'N'
,
33,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(23):=1604694;
RQCFG_100030_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(23):=RQCFG_100030_.tb5_0(23);
RQCFG_100030_.old_tb5_1(23):=1040;
RQCFG_100030_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(23),-1)));
RQCFG_100030_.old_tb5_2(23):=null;
RQCFG_100030_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(23),-1)));
RQCFG_100030_.tb5_3(23):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(23):=RQCFG_100030_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(23),
RQCFG_100030_.tb5_1(23),
RQCFG_100030_.tb5_2(23),
RQCFG_100030_.tb5_3(23),
RQCFG_100030_.tb5_4(23),
'C'
,
'Y'
,
33,
'N'
,
'C¿digo de la Ubicaci¿n Geogr¿fica'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(24):=1152037;
RQCFG_100030_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(24):=RQCFG_100030_.tb3_0(24);
RQCFG_100030_.old_tb3_1(24):=2036;
RQCFG_100030_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(24),-1)));
RQCFG_100030_.old_tb3_2(24):=42655;
RQCFG_100030_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(24),-1)));
RQCFG_100030_.old_tb3_3(24):=null;
RQCFG_100030_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(24),-1)));
RQCFG_100030_.old_tb3_4(24):=null;
RQCFG_100030_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(24),-1)));
RQCFG_100030_.tb3_5(24):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(24):=null;
RQCFG_100030_.tb3_6(24):=NULL;
RQCFG_100030_.old_tb3_7(24):=null;
RQCFG_100030_.tb3_7(24):=NULL;
RQCFG_100030_.old_tb3_8(24):=null;
RQCFG_100030_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(24),
RQCFG_100030_.tb3_1(24),
RQCFG_100030_.tb3_2(24),
RQCFG_100030_.tb3_3(24),
RQCFG_100030_.tb3_4(24),
RQCFG_100030_.tb3_5(24),
RQCFG_100030_.tb3_6(24),
RQCFG_100030_.tb3_7(24),
RQCFG_100030_.tb3_8(24),
null,
1990,
34,
'C¿digo del Barrio'
,
'N'
,
'C'
,
'N'
,
34,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(24):=1604695;
RQCFG_100030_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(24):=RQCFG_100030_.tb5_0(24);
RQCFG_100030_.old_tb5_1(24):=42655;
RQCFG_100030_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(24),-1)));
RQCFG_100030_.old_tb5_2(24):=null;
RQCFG_100030_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(24),-1)));
RQCFG_100030_.tb5_3(24):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(24):=RQCFG_100030_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(24),
RQCFG_100030_.tb5_1(24),
RQCFG_100030_.tb5_2(24),
RQCFG_100030_.tb5_3(24),
RQCFG_100030_.tb5_4(24),
'C'
,
'Y'
,
34,
'N'
,
'C¿digo del Barrio'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(25):=1152038;
RQCFG_100030_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(25):=RQCFG_100030_.tb3_0(25);
RQCFG_100030_.old_tb3_1(25):=2036;
RQCFG_100030_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(25),-1)));
RQCFG_100030_.old_tb3_2(25):=702;
RQCFG_100030_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(25),-1)));
RQCFG_100030_.old_tb3_3(25):=null;
RQCFG_100030_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(25),-1)));
RQCFG_100030_.old_tb3_4(25):=null;
RQCFG_100030_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(25),-1)));
RQCFG_100030_.tb3_5(25):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(25):=null;
RQCFG_100030_.tb3_6(25):=NULL;
RQCFG_100030_.old_tb3_7(25):=121407577;
RQCFG_100030_.tb3_7(25):=NULL;
RQCFG_100030_.old_tb3_8(25):=null;
RQCFG_100030_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(25),
RQCFG_100030_.tb3_1(25),
RQCFG_100030_.tb3_2(25),
RQCFG_100030_.tb3_3(25),
RQCFG_100030_.tb3_4(25),
RQCFG_100030_.tb3_5(25),
RQCFG_100030_.tb3_6(25),
RQCFG_100030_.tb3_7(25),
RQCFG_100030_.tb3_8(25),
null,
1991,
35,
'Direcciones'
,
'N'
,
'C'
,
'N'
,
35,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(25):=1604696;
RQCFG_100030_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(25):=RQCFG_100030_.tb5_0(25);
RQCFG_100030_.old_tb5_1(25):=702;
RQCFG_100030_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(25),-1)));
RQCFG_100030_.old_tb5_2(25):=null;
RQCFG_100030_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(25),-1)));
RQCFG_100030_.tb5_3(25):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(25):=RQCFG_100030_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(25),
RQCFG_100030_.tb5_1(25),
RQCFG_100030_.tb5_2(25),
RQCFG_100030_.tb5_3(25),
RQCFG_100030_.tb5_4(25),
'C'
,
'Y'
,
35,
'N'
,
'Direcciones'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(26):=1152039;
RQCFG_100030_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(26):=RQCFG_100030_.tb3_0(26);
RQCFG_100030_.old_tb3_1(26):=2036;
RQCFG_100030_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(26),-1)));
RQCFG_100030_.old_tb3_2(26):=2559;
RQCFG_100030_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(26),-1)));
RQCFG_100030_.old_tb3_3(26):=null;
RQCFG_100030_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(26),-1)));
RQCFG_100030_.old_tb3_4(26):=null;
RQCFG_100030_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(26),-1)));
RQCFG_100030_.tb3_5(26):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(26):=null;
RQCFG_100030_.tb3_6(26):=NULL;
RQCFG_100030_.old_tb3_7(26):=null;
RQCFG_100030_.tb3_7(26):=NULL;
RQCFG_100030_.old_tb3_8(26):=null;
RQCFG_100030_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(26),
RQCFG_100030_.tb3_1(26),
RQCFG_100030_.tb3_2(26),
RQCFG_100030_.tb3_3(26),
RQCFG_100030_.tb3_4(26),
RQCFG_100030_.tb3_5(26),
RQCFG_100030_.tb3_6(26),
RQCFG_100030_.tb3_7(26),
RQCFG_100030_.tb3_8(26),
null,
1992,
36,
'Ubicaci¿n Respuesta'
,
'N'
,
'C'
,
'N'
,
36,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(26):=1604697;
RQCFG_100030_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(26):=RQCFG_100030_.tb5_0(26);
RQCFG_100030_.old_tb5_1(26):=2559;
RQCFG_100030_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(26),-1)));
RQCFG_100030_.old_tb5_2(26):=null;
RQCFG_100030_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(26),-1)));
RQCFG_100030_.tb5_3(26):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(26):=RQCFG_100030_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(26),
RQCFG_100030_.tb5_1(26),
RQCFG_100030_.tb5_2(26),
RQCFG_100030_.tb5_3(26),
RQCFG_100030_.tb5_4(26),
'C'
,
'Y'
,
36,
'N'
,
'Ubicaci¿n Respuesta'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(27):=1152040;
RQCFG_100030_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(27):=RQCFG_100030_.tb3_0(27);
RQCFG_100030_.old_tb3_1(27):=2036;
RQCFG_100030_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(27),-1)));
RQCFG_100030_.old_tb3_2(27):=2558;
RQCFG_100030_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(27),-1)));
RQCFG_100030_.old_tb3_3(27):=null;
RQCFG_100030_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(27),-1)));
RQCFG_100030_.old_tb3_4(27):=null;
RQCFG_100030_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(27),-1)));
RQCFG_100030_.tb3_5(27):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(27):=null;
RQCFG_100030_.tb3_6(27):=NULL;
RQCFG_100030_.old_tb3_7(27):=null;
RQCFG_100030_.tb3_7(27):=NULL;
RQCFG_100030_.old_tb3_8(27):=null;
RQCFG_100030_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(27),
RQCFG_100030_.tb3_1(27),
RQCFG_100030_.tb3_2(27),
RQCFG_100030_.tb3_3(27),
RQCFG_100030_.tb3_4(27),
RQCFG_100030_.tb3_5(27),
RQCFG_100030_.tb3_6(27),
RQCFG_100030_.tb3_7(27),
RQCFG_100030_.tb3_8(27),
null,
1993,
37,
'Barrio Respuesta'
,
'N'
,
'C'
,
'N'
,
37,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(27):=1604698;
RQCFG_100030_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(27):=RQCFG_100030_.tb5_0(27);
RQCFG_100030_.old_tb5_1(27):=2558;
RQCFG_100030_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(27),-1)));
RQCFG_100030_.old_tb5_2(27):=null;
RQCFG_100030_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(27),-1)));
RQCFG_100030_.tb5_3(27):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(27):=RQCFG_100030_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(27),
RQCFG_100030_.tb5_1(27),
RQCFG_100030_.tb5_2(27),
RQCFG_100030_.tb5_3(27),
RQCFG_100030_.tb5_4(27),
'C'
,
'Y'
,
37,
'N'
,
'Barrio Respuesta'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(28):=1152041;
RQCFG_100030_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(28):=RQCFG_100030_.tb3_0(28);
RQCFG_100030_.old_tb3_1(28):=2036;
RQCFG_100030_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(28),-1)));
RQCFG_100030_.old_tb3_2(28):=1137;
RQCFG_100030_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(28),-1)));
RQCFG_100030_.old_tb3_3(28):=null;
RQCFG_100030_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(28),-1)));
RQCFG_100030_.old_tb3_4(28):=null;
RQCFG_100030_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(28),-1)));
RQCFG_100030_.tb3_5(28):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(28):=null;
RQCFG_100030_.tb3_6(28):=NULL;
RQCFG_100030_.old_tb3_7(28):=121407578;
RQCFG_100030_.tb3_7(28):=NULL;
RQCFG_100030_.old_tb3_8(28):=null;
RQCFG_100030_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(28),
RQCFG_100030_.tb3_1(28),
RQCFG_100030_.tb3_2(28),
RQCFG_100030_.tb3_3(28),
RQCFG_100030_.tb3_4(28),
RQCFG_100030_.tb3_5(28),
RQCFG_100030_.tb3_6(28),
RQCFG_100030_.tb3_7(28),
RQCFG_100030_.tb3_8(28),
null,
1994,
38,
'Direcci¿n Respuesta'
,
'N'
,
'C'
,
'N'
,
38,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(28):=1604699;
RQCFG_100030_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(28):=RQCFG_100030_.tb5_0(28);
RQCFG_100030_.old_tb5_1(28):=1137;
RQCFG_100030_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(28),-1)));
RQCFG_100030_.old_tb5_2(28):=null;
RQCFG_100030_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(28),-1)));
RQCFG_100030_.tb5_3(28):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(28):=RQCFG_100030_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(28),
RQCFG_100030_.tb5_1(28),
RQCFG_100030_.tb5_2(28),
RQCFG_100030_.tb5_3(28),
RQCFG_100030_.tb5_4(28),
'C'
,
'Y'
,
38,
'N'
,
'Direcci¿n Respuesta'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(29):=1152042;
RQCFG_100030_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(29):=RQCFG_100030_.tb3_0(29);
RQCFG_100030_.old_tb3_1(29):=2036;
RQCFG_100030_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(29),-1)));
RQCFG_100030_.old_tb3_2(29):=109479;
RQCFG_100030_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(29),-1)));
RQCFG_100030_.old_tb3_3(29):=null;
RQCFG_100030_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(29),-1)));
RQCFG_100030_.old_tb3_4(29):=null;
RQCFG_100030_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(29),-1)));
RQCFG_100030_.tb3_5(29):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(29):=121407574;
RQCFG_100030_.tb3_6(29):=NULL;
RQCFG_100030_.old_tb3_7(29):=null;
RQCFG_100030_.tb3_7(29):=NULL;
RQCFG_100030_.old_tb3_8(29):=120198209;
RQCFG_100030_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(29),
RQCFG_100030_.tb3_1(29),
RQCFG_100030_.tb3_2(29),
RQCFG_100030_.tb3_3(29),
RQCFG_100030_.tb3_4(29),
RQCFG_100030_.tb3_5(29),
RQCFG_100030_.tb3_6(29),
RQCFG_100030_.tb3_7(29),
RQCFG_100030_.tb3_8(29),
null,
1010,
6,
'Punto de Atenci¿n'
,
'N'
,
'Y'
,
'Y'
,
6,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(29):=1604700;
RQCFG_100030_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(29):=RQCFG_100030_.tb5_0(29);
RQCFG_100030_.old_tb5_1(29):=109479;
RQCFG_100030_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(29),-1)));
RQCFG_100030_.old_tb5_2(29):=null;
RQCFG_100030_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(29),-1)));
RQCFG_100030_.tb5_3(29):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(29):=RQCFG_100030_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(29),
RQCFG_100030_.tb5_1(29),
RQCFG_100030_.tb5_2(29),
RQCFG_100030_.tb5_3(29),
RQCFG_100030_.tb5_4(29),
'Y'
,
'N'
,
6,
'Y'
,
'Punto de Atenci¿n'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(30):=1152043;
RQCFG_100030_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(30):=RQCFG_100030_.tb3_0(30);
RQCFG_100030_.old_tb3_1(30):=2036;
RQCFG_100030_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(30),-1)));
RQCFG_100030_.old_tb3_2(30):=109478;
RQCFG_100030_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(30),-1)));
RQCFG_100030_.old_tb3_3(30):=null;
RQCFG_100030_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(30),-1)));
RQCFG_100030_.old_tb3_4(30):=null;
RQCFG_100030_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(30),-1)));
RQCFG_100030_.tb3_5(30):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(30):=null;
RQCFG_100030_.tb3_6(30):=NULL;
RQCFG_100030_.old_tb3_7(30):=null;
RQCFG_100030_.tb3_7(30):=NULL;
RQCFG_100030_.old_tb3_8(30):=null;
RQCFG_100030_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(30),
RQCFG_100030_.tb3_1(30),
RQCFG_100030_.tb3_2(30),
RQCFG_100030_.tb3_3(30),
RQCFG_100030_.tb3_4(30),
RQCFG_100030_.tb3_5(30),
RQCFG_100030_.tb3_6(30),
RQCFG_100030_.tb3_7(30),
RQCFG_100030_.tb3_8(30),
null,
465,
39,
'Unidad Operativa Del Vendedor'
,
'N'
,
'C'
,
'N'
,
39,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(30):=1604701;
RQCFG_100030_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(30):=RQCFG_100030_.tb5_0(30);
RQCFG_100030_.old_tb5_1(30):=109478;
RQCFG_100030_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(30),-1)));
RQCFG_100030_.old_tb5_2(30):=null;
RQCFG_100030_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(30),-1)));
RQCFG_100030_.tb5_3(30):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(30):=RQCFG_100030_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(30),
RQCFG_100030_.tb5_1(30),
RQCFG_100030_.tb5_2(30),
RQCFG_100030_.tb5_3(30),
RQCFG_100030_.tb5_4(30),
'C'
,
'Y'
,
39,
'N'
,
'Unidad Operativa Del Vendedor'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(31):=1152044;
RQCFG_100030_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(31):=RQCFG_100030_.tb3_0(31);
RQCFG_100030_.old_tb3_1(31):=2036;
RQCFG_100030_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(31),-1)));
RQCFG_100030_.old_tb3_2(31):=42118;
RQCFG_100030_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(31),-1)));
RQCFG_100030_.old_tb3_3(31):=109479;
RQCFG_100030_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(31),-1)));
RQCFG_100030_.old_tb3_4(31):=null;
RQCFG_100030_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(31),-1)));
RQCFG_100030_.tb3_5(31):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(31):=null;
RQCFG_100030_.tb3_6(31):=NULL;
RQCFG_100030_.old_tb3_7(31):=null;
RQCFG_100030_.tb3_7(31):=NULL;
RQCFG_100030_.old_tb3_8(31):=null;
RQCFG_100030_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(31),
RQCFG_100030_.tb3_1(31),
RQCFG_100030_.tb3_2(31),
RQCFG_100030_.tb3_3(31),
RQCFG_100030_.tb3_4(31),
RQCFG_100030_.tb3_5(31),
RQCFG_100030_.tb3_6(31),
RQCFG_100030_.tb3_7(31),
RQCFG_100030_.tb3_8(31),
null,
466,
40,
'C¿digo Canal De Ventas'
,
'N'
,
'C'
,
'N'
,
40,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(31):=1604702;
RQCFG_100030_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(31):=RQCFG_100030_.tb5_0(31);
RQCFG_100030_.old_tb5_1(31):=42118;
RQCFG_100030_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(31),-1)));
RQCFG_100030_.old_tb5_2(31):=null;
RQCFG_100030_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(31),-1)));
RQCFG_100030_.tb5_3(31):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(31):=RQCFG_100030_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(31),
RQCFG_100030_.tb5_1(31),
RQCFG_100030_.tb5_2(31),
RQCFG_100030_.tb5_3(31),
RQCFG_100030_.tb5_4(31),
'C'
,
'Y'
,
40,
'N'
,
'C¿digo Canal De Ventas'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(32):=1152045;
RQCFG_100030_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(32):=RQCFG_100030_.tb3_0(32);
RQCFG_100030_.old_tb3_1(32):=2036;
RQCFG_100030_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(32),-1)));
RQCFG_100030_.old_tb3_2(32):=269;
RQCFG_100030_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(32),-1)));
RQCFG_100030_.old_tb3_3(32):=null;
RQCFG_100030_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(32),-1)));
RQCFG_100030_.old_tb3_4(32):=null;
RQCFG_100030_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(32),-1)));
RQCFG_100030_.tb3_5(32):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(32):=null;
RQCFG_100030_.tb3_6(32):=NULL;
RQCFG_100030_.old_tb3_7(32):=null;
RQCFG_100030_.tb3_7(32):=NULL;
RQCFG_100030_.old_tb3_8(32):=null;
RQCFG_100030_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(32),
RQCFG_100030_.tb3_1(32),
RQCFG_100030_.tb3_2(32),
RQCFG_100030_.tb3_3(32),
RQCFG_100030_.tb3_4(32),
RQCFG_100030_.tb3_5(32),
RQCFG_100030_.tb3_6(32),
RQCFG_100030_.tb3_7(32),
RQCFG_100030_.tb3_8(32),
null,
100972,
15,
'C¿digo del Tipo de Paquete'
,
'N'
,
'C'
,
'Y'
,
15,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(32):=1604703;
RQCFG_100030_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(32):=RQCFG_100030_.tb5_0(32);
RQCFG_100030_.old_tb5_1(32):=269;
RQCFG_100030_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(32),-1)));
RQCFG_100030_.old_tb5_2(32):=null;
RQCFG_100030_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(32),-1)));
RQCFG_100030_.tb5_3(32):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(32):=RQCFG_100030_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(32),
RQCFG_100030_.tb5_1(32),
RQCFG_100030_.tb5_2(32),
RQCFG_100030_.tb5_3(32),
RQCFG_100030_.tb5_4(32),
'C'
,
'Y'
,
15,
'Y'
,
'C¿digo del Tipo de Paquete'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(33):=1152046;
RQCFG_100030_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(33):=RQCFG_100030_.tb3_0(33);
RQCFG_100030_.old_tb3_1(33):=2036;
RQCFG_100030_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(33),-1)));
RQCFG_100030_.old_tb3_2(33):=255;
RQCFG_100030_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(33),-1)));
RQCFG_100030_.old_tb3_3(33):=null;
RQCFG_100030_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(33),-1)));
RQCFG_100030_.old_tb3_4(33):=null;
RQCFG_100030_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(33),-1)));
RQCFG_100030_.tb3_5(33):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(33):=null;
RQCFG_100030_.tb3_6(33):=NULL;
RQCFG_100030_.old_tb3_7(33):=121407571;
RQCFG_100030_.tb3_7(33):=NULL;
RQCFG_100030_.old_tb3_8(33):=null;
RQCFG_100030_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(33),
RQCFG_100030_.tb3_1(33),
RQCFG_100030_.tb3_2(33),
RQCFG_100030_.tb3_3(33),
RQCFG_100030_.tb3_4(33),
RQCFG_100030_.tb3_5(33),
RQCFG_100030_.tb3_6(33),
RQCFG_100030_.tb3_7(33),
RQCFG_100030_.tb3_8(33),
null,
100973,
2,
'N¿mero de Solicitud'
,
'N'
,
'Y'
,
'Y'
,
2,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(33):=1604704;
RQCFG_100030_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(33):=RQCFG_100030_.tb5_0(33);
RQCFG_100030_.old_tb5_1(33):=255;
RQCFG_100030_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(33),-1)));
RQCFG_100030_.old_tb5_2(33):=null;
RQCFG_100030_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(33),-1)));
RQCFG_100030_.tb5_3(33):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(33):=RQCFG_100030_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(33),
RQCFG_100030_.tb5_1(33),
RQCFG_100030_.tb5_2(33),
RQCFG_100030_.tb5_3(33),
RQCFG_100030_.tb5_4(33),
'Y'
,
'E'
,
2,
'Y'
,
'N¿mero de Solicitud'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(34):=1152047;
RQCFG_100030_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(34):=RQCFG_100030_.tb3_0(34);
RQCFG_100030_.old_tb3_1(34):=2036;
RQCFG_100030_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(34),-1)));
RQCFG_100030_.old_tb3_2(34):=175491;
RQCFG_100030_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(34),-1)));
RQCFG_100030_.old_tb3_3(34):=null;
RQCFG_100030_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(34),-1)));
RQCFG_100030_.old_tb3_4(34):=null;
RQCFG_100030_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(34),-1)));
RQCFG_100030_.tb3_5(34):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(34):=121407575;
RQCFG_100030_.tb3_6(34):=NULL;
RQCFG_100030_.old_tb3_7(34):=null;
RQCFG_100030_.tb3_7(34):=NULL;
RQCFG_100030_.old_tb3_8(34):=null;
RQCFG_100030_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(34),
RQCFG_100030_.tb3_1(34),
RQCFG_100030_.tb3_2(34),
RQCFG_100030_.tb3_3(34),
RQCFG_100030_.tb3_4(34),
RQCFG_100030_.tb3_5(34),
RQCFG_100030_.tb3_6(34),
RQCFG_100030_.tb3_7(34),
RQCFG_100030_.tb3_8(34),
null,
1372,
22,
'Identificador De La Orden'
,
'N'
,
'Y'
,
'N'
,
22,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(34):=1604705;
RQCFG_100030_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(34):=RQCFG_100030_.tb5_0(34);
RQCFG_100030_.old_tb5_1(34):=175491;
RQCFG_100030_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(34),-1)));
RQCFG_100030_.old_tb5_2(34):=null;
RQCFG_100030_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(34),-1)));
RQCFG_100030_.tb5_3(34):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(34):=RQCFG_100030_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(34),
RQCFG_100030_.tb5_1(34),
RQCFG_100030_.tb5_2(34),
RQCFG_100030_.tb5_3(34),
RQCFG_100030_.tb5_4(34),
'Y'
,
'N'
,
22,
'N'
,
'Identificador De La Orden'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(35):=1152048;
RQCFG_100030_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(35):=RQCFG_100030_.tb3_0(35);
RQCFG_100030_.old_tb3_1(35):=2036;
RQCFG_100030_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(35),-1)));
RQCFG_100030_.old_tb3_2(35):=258;
RQCFG_100030_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(35),-1)));
RQCFG_100030_.old_tb3_3(35):=null;
RQCFG_100030_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(35),-1)));
RQCFG_100030_.old_tb3_4(35):=null;
RQCFG_100030_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(35),-1)));
RQCFG_100030_.tb3_5(35):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(35):=121407572;
RQCFG_100030_.tb3_6(35):=NULL;
RQCFG_100030_.old_tb3_7(35):=121407573;
RQCFG_100030_.tb3_7(35):=NULL;
RQCFG_100030_.old_tb3_8(35):=null;
RQCFG_100030_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(35),
RQCFG_100030_.tb3_1(35),
RQCFG_100030_.tb3_2(35),
RQCFG_100030_.tb3_3(35),
RQCFG_100030_.tb3_4(35),
RQCFG_100030_.tb3_5(35),
RQCFG_100030_.tb3_6(35),
RQCFG_100030_.tb3_7(35),
RQCFG_100030_.tb3_8(35),
null,
100974,
1,
'Fecha de Solicitud'
,
'N'
,
'Y'
,
'Y'
,
1,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(35):=1604706;
RQCFG_100030_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(35):=RQCFG_100030_.tb5_0(35);
RQCFG_100030_.old_tb5_1(35):=258;
RQCFG_100030_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(35),-1)));
RQCFG_100030_.old_tb5_2(35):=null;
RQCFG_100030_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(35),-1)));
RQCFG_100030_.tb5_3(35):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(35):=RQCFG_100030_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(35),
RQCFG_100030_.tb5_1(35),
RQCFG_100030_.tb5_2(35),
RQCFG_100030_.tb5_3(35),
RQCFG_100030_.tb5_4(35),
'Y'
,
'Y'
,
1,
'Y'
,
'Fecha de Solicitud'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(36):=1152049;
RQCFG_100030_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(36):=RQCFG_100030_.tb3_0(36);
RQCFG_100030_.old_tb3_1(36):=2036;
RQCFG_100030_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(36),-1)));
RQCFG_100030_.old_tb3_2(36):=50001162;
RQCFG_100030_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(36),-1)));
RQCFG_100030_.old_tb3_3(36):=null;
RQCFG_100030_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(36),-1)));
RQCFG_100030_.old_tb3_4(36):=null;
RQCFG_100030_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(36),-1)));
RQCFG_100030_.tb3_5(36):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(36):=121407564;
RQCFG_100030_.tb3_6(36):=NULL;
RQCFG_100030_.old_tb3_7(36):=121407565;
RQCFG_100030_.tb3_7(36):=NULL;
RQCFG_100030_.old_tb3_8(36):=120198205;
RQCFG_100030_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(36),
RQCFG_100030_.tb3_1(36),
RQCFG_100030_.tb3_2(36),
RQCFG_100030_.tb3_3(36),
RQCFG_100030_.tb3_4(36),
RQCFG_100030_.tb3_5(36),
RQCFG_100030_.tb3_6(36),
RQCFG_100030_.tb3_7(36),
RQCFG_100030_.tb3_8(36),
null,
100976,
3,
'Funcionario'
,
'N'
,
'Y'
,
'Y'
,
3,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(36):=1604707;
RQCFG_100030_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(36):=RQCFG_100030_.tb5_0(36);
RQCFG_100030_.old_tb5_1(36):=50001162;
RQCFG_100030_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(36),-1)));
RQCFG_100030_.old_tb5_2(36):=null;
RQCFG_100030_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(36),-1)));
RQCFG_100030_.tb5_3(36):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(36):=RQCFG_100030_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(36),
RQCFG_100030_.tb5_1(36),
RQCFG_100030_.tb5_2(36),
RQCFG_100030_.tb5_3(36),
RQCFG_100030_.tb5_4(36),
'Y'
,
'E'
,
3,
'Y'
,
'Funcionario'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(37):=1152050;
RQCFG_100030_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(37):=RQCFG_100030_.tb3_0(37);
RQCFG_100030_.old_tb3_1(37):=2036;
RQCFG_100030_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(37),-1)));
RQCFG_100030_.old_tb3_2(37):=259;
RQCFG_100030_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(37),-1)));
RQCFG_100030_.old_tb3_3(37):=null;
RQCFG_100030_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(37),-1)));
RQCFG_100030_.old_tb3_4(37):=null;
RQCFG_100030_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(37),-1)));
RQCFG_100030_.tb3_5(37):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(37):=121407566;
RQCFG_100030_.tb3_6(37):=NULL;
RQCFG_100030_.old_tb3_7(37):=null;
RQCFG_100030_.tb3_7(37):=NULL;
RQCFG_100030_.old_tb3_8(37):=null;
RQCFG_100030_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(37),
RQCFG_100030_.tb3_1(37),
RQCFG_100030_.tb3_2(37),
RQCFG_100030_.tb3_3(37),
RQCFG_100030_.tb3_4(37),
RQCFG_100030_.tb3_5(37),
RQCFG_100030_.tb3_6(37),
RQCFG_100030_.tb3_7(37),
RQCFG_100030_.tb3_8(37),
null,
100977,
23,
'Fecha de Env¿o'
,
'N'
,
'C'
,
'Y'
,
23,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(37):=1604708;
RQCFG_100030_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(37):=RQCFG_100030_.tb5_0(37);
RQCFG_100030_.old_tb5_1(37):=259;
RQCFG_100030_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(37),-1)));
RQCFG_100030_.old_tb5_2(37):=null;
RQCFG_100030_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(37),-1)));
RQCFG_100030_.tb5_3(37):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(37):=RQCFG_100030_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(37),
RQCFG_100030_.tb5_1(37),
RQCFG_100030_.tb5_2(37),
RQCFG_100030_.tb5_3(37),
RQCFG_100030_.tb5_4(37),
'C'
,
'Y'
,
23,
'Y'
,
'Fecha de Env¿o'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(38):=1152051;
RQCFG_100030_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(38):=RQCFG_100030_.tb3_0(38);
RQCFG_100030_.old_tb3_1(38):=2036;
RQCFG_100030_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(38),-1)));
RQCFG_100030_.old_tb3_2(38):=257;
RQCFG_100030_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(38),-1)));
RQCFG_100030_.old_tb3_3(38):=null;
RQCFG_100030_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(38),-1)));
RQCFG_100030_.old_tb3_4(38):=null;
RQCFG_100030_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(38),-1)));
RQCFG_100030_.tb3_5(38):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(38):=121407567;
RQCFG_100030_.tb3_6(38):=NULL;
RQCFG_100030_.old_tb3_7(38):=null;
RQCFG_100030_.tb3_7(38):=NULL;
RQCFG_100030_.old_tb3_8(38):=null;
RQCFG_100030_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(38),
RQCFG_100030_.tb3_1(38),
RQCFG_100030_.tb3_2(38),
RQCFG_100030_.tb3_3(38),
RQCFG_100030_.tb3_4(38),
RQCFG_100030_.tb3_5(38),
RQCFG_100030_.tb3_6(38),
RQCFG_100030_.tb3_7(38),
RQCFG_100030_.tb3_8(38),
null,
100978,
0,
'Interacci¿n'
,
'N'
,
'Y'
,
'Y'
,
0,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(38):=1604709;
RQCFG_100030_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(38):=RQCFG_100030_.tb5_0(38);
RQCFG_100030_.old_tb5_1(38):=257;
RQCFG_100030_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(38),-1)));
RQCFG_100030_.old_tb5_2(38):=null;
RQCFG_100030_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(38),-1)));
RQCFG_100030_.tb5_3(38):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(38):=RQCFG_100030_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(38),
RQCFG_100030_.tb5_1(38),
RQCFG_100030_.tb5_2(38),
RQCFG_100030_.tb5_3(38),
RQCFG_100030_.tb5_4(38),
'Y'
,
'E'
,
0,
'Y'
,
'Interacci¿n'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(39):=1152052;
RQCFG_100030_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(39):=RQCFG_100030_.tb3_0(39);
RQCFG_100030_.old_tb3_1(39):=2036;
RQCFG_100030_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(39),-1)));
RQCFG_100030_.old_tb3_2(39):=2683;
RQCFG_100030_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(39),-1)));
RQCFG_100030_.old_tb3_3(39):=null;
RQCFG_100030_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(39),-1)));
RQCFG_100030_.old_tb3_4(39):=null;
RQCFG_100030_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(39),-1)));
RQCFG_100030_.tb3_5(39):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(39):=121407568;
RQCFG_100030_.tb3_6(39):=NULL;
RQCFG_100030_.old_tb3_7(39):=null;
RQCFG_100030_.tb3_7(39):=NULL;
RQCFG_100030_.old_tb3_8(39):=120198206;
RQCFG_100030_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(39),
RQCFG_100030_.tb3_1(39),
RQCFG_100030_.tb3_2(39),
RQCFG_100030_.tb3_3(39),
RQCFG_100030_.tb3_4(39),
RQCFG_100030_.tb3_5(39),
RQCFG_100030_.tb3_6(39),
RQCFG_100030_.tb3_7(39),
RQCFG_100030_.tb3_8(39),
null,
100979,
7,
'Medio de Recepci¿n'
,
'N'
,
'Y'
,
'Y'
,
7,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(39):=1604710;
RQCFG_100030_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(39):=RQCFG_100030_.tb5_0(39);
RQCFG_100030_.old_tb5_1(39):=2683;
RQCFG_100030_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(39),-1)));
RQCFG_100030_.old_tb5_2(39):=null;
RQCFG_100030_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(39),-1)));
RQCFG_100030_.tb5_3(39):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(39):=RQCFG_100030_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(39),
RQCFG_100030_.tb5_1(39),
RQCFG_100030_.tb5_2(39),
RQCFG_100030_.tb5_3(39),
RQCFG_100030_.tb5_4(39),
'Y'
,
'Y'
,
7,
'Y'
,
'Medio de Recepci¿n'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(40):=1152053;
RQCFG_100030_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(40):=RQCFG_100030_.tb3_0(40);
RQCFG_100030_.old_tb3_1(40):=2036;
RQCFG_100030_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(40),-1)));
RQCFG_100030_.old_tb3_2(40):=4015;
RQCFG_100030_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(40),-1)));
RQCFG_100030_.old_tb3_3(40):=null;
RQCFG_100030_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(40),-1)));
RQCFG_100030_.old_tb3_4(40):=null;
RQCFG_100030_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(40),-1)));
RQCFG_100030_.tb3_5(40):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(40):=121407569;
RQCFG_100030_.tb3_6(40):=NULL;
RQCFG_100030_.old_tb3_7(40):=null;
RQCFG_100030_.tb3_7(40):=NULL;
RQCFG_100030_.old_tb3_8(40):=null;
RQCFG_100030_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(40),
RQCFG_100030_.tb3_1(40),
RQCFG_100030_.tb3_2(40),
RQCFG_100030_.tb3_3(40),
RQCFG_100030_.tb3_4(40),
RQCFG_100030_.tb3_5(40),
RQCFG_100030_.tb3_6(40),
RQCFG_100030_.tb3_7(40),
RQCFG_100030_.tb3_8(40),
null,
100984,
24,
'Identificador del Cliente'
,
'N'
,
'C'
,
'N'
,
24,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(40):=1604711;
RQCFG_100030_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(40):=RQCFG_100030_.tb5_0(40);
RQCFG_100030_.old_tb5_1(40):=4015;
RQCFG_100030_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(40),-1)));
RQCFG_100030_.old_tb5_2(40):=null;
RQCFG_100030_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(40),-1)));
RQCFG_100030_.tb5_3(40):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(40):=RQCFG_100030_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(40),
RQCFG_100030_.tb5_1(40),
RQCFG_100030_.tb5_2(40),
RQCFG_100030_.tb5_3(40),
RQCFG_100030_.tb5_4(40),
'C'
,
'Y'
,
24,
'N'
,
'Identificador del Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(41):=1152054;
RQCFG_100030_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(41):=RQCFG_100030_.tb3_0(41);
RQCFG_100030_.old_tb3_1(41):=2036;
RQCFG_100030_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(41),-1)));
RQCFG_100030_.old_tb3_2(41):=39322;
RQCFG_100030_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(41),-1)));
RQCFG_100030_.old_tb3_3(41):=255;
RQCFG_100030_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(41),-1)));
RQCFG_100030_.old_tb3_4(41):=null;
RQCFG_100030_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(41),-1)));
RQCFG_100030_.tb3_5(41):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(41):=null;
RQCFG_100030_.tb3_6(41):=NULL;
RQCFG_100030_.old_tb3_7(41):=null;
RQCFG_100030_.tb3_7(41):=NULL;
RQCFG_100030_.old_tb3_8(41):=null;
RQCFG_100030_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(41),
RQCFG_100030_.tb3_1(41),
RQCFG_100030_.tb3_2(41),
RQCFG_100030_.tb3_3(41),
RQCFG_100030_.tb3_4(41),
RQCFG_100030_.tb3_5(41),
RQCFG_100030_.tb3_6(41),
RQCFG_100030_.tb3_7(41),
RQCFG_100030_.tb3_8(41),
null,
100995,
25,
'PACKAGE_ID'
,
'N'
,
'N'
,
'Y'
,
25,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(41):=1604712;
RQCFG_100030_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(41):=RQCFG_100030_.tb5_0(41);
RQCFG_100030_.old_tb5_1(41):=39322;
RQCFG_100030_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(41),-1)));
RQCFG_100030_.old_tb5_2(41):=null;
RQCFG_100030_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(41),-1)));
RQCFG_100030_.tb5_3(41):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(41):=RQCFG_100030_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(41),
RQCFG_100030_.tb5_1(41),
RQCFG_100030_.tb5_2(41),
RQCFG_100030_.tb5_3(41),
RQCFG_100030_.tb5_4(41),
'N'
,
'N'
,
25,
'Y'
,
'PACKAGE_ID'
,
'N'
,
'N'
,
'M'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(42):=1152055;
RQCFG_100030_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(42):=RQCFG_100030_.tb3_0(42);
RQCFG_100030_.old_tb3_1(42):=2036;
RQCFG_100030_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(42),-1)));
RQCFG_100030_.old_tb3_2(42):=260;
RQCFG_100030_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(42),-1)));
RQCFG_100030_.old_tb3_3(42):=null;
RQCFG_100030_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(42),-1)));
RQCFG_100030_.old_tb3_4(42):=null;
RQCFG_100030_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(42),-1)));
RQCFG_100030_.tb3_5(42):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(42):=null;
RQCFG_100030_.tb3_6(42):=NULL;
RQCFG_100030_.old_tb3_7(42):=null;
RQCFG_100030_.tb3_7(42):=NULL;
RQCFG_100030_.old_tb3_8(42):=null;
RQCFG_100030_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(42),
RQCFG_100030_.tb3_1(42),
RQCFG_100030_.tb3_2(42),
RQCFG_100030_.tb3_3(42),
RQCFG_100030_.tb3_4(42),
RQCFG_100030_.tb3_5(42),
RQCFG_100030_.tb3_6(42),
RQCFG_100030_.tb3_7(42),
RQCFG_100030_.tb3_8(42),
null,
100996,
26,
'Usuario'
,
'N'
,
'C'
,
'Y'
,
26,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(42):=1604713;
RQCFG_100030_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(42):=RQCFG_100030_.tb5_0(42);
RQCFG_100030_.old_tb5_1(42):=260;
RQCFG_100030_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(42),-1)));
RQCFG_100030_.old_tb5_2(42):=null;
RQCFG_100030_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(42),-1)));
RQCFG_100030_.tb5_3(42):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(42):=RQCFG_100030_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(42),
RQCFG_100030_.tb5_1(42),
RQCFG_100030_.tb5_2(42),
RQCFG_100030_.tb5_3(42),
RQCFG_100030_.tb5_4(42),
'C'
,
'Y'
,
26,
'Y'
,
'Usuario'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(43):=1152056;
RQCFG_100030_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(43):=RQCFG_100030_.tb3_0(43);
RQCFG_100030_.old_tb3_1(43):=2036;
RQCFG_100030_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(43),-1)));
RQCFG_100030_.old_tb3_2(43):=261;
RQCFG_100030_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(43),-1)));
RQCFG_100030_.old_tb3_3(43):=null;
RQCFG_100030_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(43),-1)));
RQCFG_100030_.old_tb3_4(43):=null;
RQCFG_100030_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(43),-1)));
RQCFG_100030_.tb3_5(43):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(43):=null;
RQCFG_100030_.tb3_6(43):=NULL;
RQCFG_100030_.old_tb3_7(43):=null;
RQCFG_100030_.tb3_7(43):=NULL;
RQCFG_100030_.old_tb3_8(43):=null;
RQCFG_100030_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(43),
RQCFG_100030_.tb3_1(43),
RQCFG_100030_.tb3_2(43),
RQCFG_100030_.tb3_3(43),
RQCFG_100030_.tb3_4(43),
RQCFG_100030_.tb3_5(43),
RQCFG_100030_.tb3_6(43),
RQCFG_100030_.tb3_7(43),
RQCFG_100030_.tb3_8(43),
null,
100997,
27,
'Terminal'
,
'N'
,
'C'
,
'Y'
,
27,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(43):=1604714;
RQCFG_100030_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(43):=RQCFG_100030_.tb5_0(43);
RQCFG_100030_.old_tb5_1(43):=261;
RQCFG_100030_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(43),-1)));
RQCFG_100030_.old_tb5_2(43):=null;
RQCFG_100030_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(43),-1)));
RQCFG_100030_.tb5_3(43):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(43):=RQCFG_100030_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(43),
RQCFG_100030_.tb5_1(43),
RQCFG_100030_.tb5_2(43),
RQCFG_100030_.tb5_3(43),
RQCFG_100030_.tb5_4(43),
'C'
,
'Y'
,
27,
'Y'
,
'Terminal'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(44):=1152057;
RQCFG_100030_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(44):=RQCFG_100030_.tb3_0(44);
RQCFG_100030_.old_tb3_1(44):=2036;
RQCFG_100030_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(44),-1)));
RQCFG_100030_.old_tb3_2(44):=11621;
RQCFG_100030_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(44),-1)));
RQCFG_100030_.old_tb3_3(44):=null;
RQCFG_100030_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(44),-1)));
RQCFG_100030_.old_tb3_4(44):=null;
RQCFG_100030_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(44),-1)));
RQCFG_100030_.tb3_5(44):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(44):=null;
RQCFG_100030_.tb3_6(44):=NULL;
RQCFG_100030_.old_tb3_7(44):=null;
RQCFG_100030_.tb3_7(44):=NULL;
RQCFG_100030_.old_tb3_8(44):=null;
RQCFG_100030_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(44),
RQCFG_100030_.tb3_1(44),
RQCFG_100030_.tb3_2(44),
RQCFG_100030_.tb3_3(44),
RQCFG_100030_.tb3_4(44),
RQCFG_100030_.tb3_5(44),
RQCFG_100030_.tb3_6(44),
RQCFG_100030_.tb3_7(44),
RQCFG_100030_.tb3_8(44),
null,
100998,
28,
'Identificador de la Suscripci¿n'
,
'N'
,
'C'
,
'N'
,
28,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(44):=1604715;
RQCFG_100030_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(44):=RQCFG_100030_.tb5_0(44);
RQCFG_100030_.old_tb5_1(44):=11621;
RQCFG_100030_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(44),-1)));
RQCFG_100030_.old_tb5_2(44):=null;
RQCFG_100030_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(44),-1)));
RQCFG_100030_.tb5_3(44):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(44):=RQCFG_100030_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(44),
RQCFG_100030_.tb5_1(44),
RQCFG_100030_.tb5_2(44),
RQCFG_100030_.tb5_3(44),
RQCFG_100030_.tb5_4(44),
'C'
,
'Y'
,
28,
'N'
,
'Identificador de la Suscripci¿n'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(45):=1152058;
RQCFG_100030_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(45):=RQCFG_100030_.tb3_0(45);
RQCFG_100030_.old_tb3_1(45):=2036;
RQCFG_100030_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(45),-1)));
RQCFG_100030_.old_tb3_2(45):=2374;
RQCFG_100030_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(45),-1)));
RQCFG_100030_.old_tb3_3(45):=null;
RQCFG_100030_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(45),-1)));
RQCFG_100030_.old_tb3_4(45):=null;
RQCFG_100030_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(45),-1)));
RQCFG_100030_.tb3_5(45):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(45):=null;
RQCFG_100030_.tb3_6(45):=NULL;
RQCFG_100030_.old_tb3_7(45):=null;
RQCFG_100030_.tb3_7(45):=NULL;
RQCFG_100030_.old_tb3_8(45):=null;
RQCFG_100030_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(45),
RQCFG_100030_.tb3_1(45),
RQCFG_100030_.tb3_2(45),
RQCFG_100030_.tb3_3(45),
RQCFG_100030_.tb3_4(45),
RQCFG_100030_.tb3_5(45),
RQCFG_100030_.tb3_6(45),
RQCFG_100030_.tb3_7(45),
RQCFG_100030_.tb3_8(45),
null,
100999,
29,
'Fecha de Atenci¿n'
,
'N'
,
'C'
,
'N'
,
29,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(45):=1604716;
RQCFG_100030_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(45):=RQCFG_100030_.tb5_0(45);
RQCFG_100030_.old_tb5_1(45):=2374;
RQCFG_100030_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(45),-1)));
RQCFG_100030_.old_tb5_2(45):=null;
RQCFG_100030_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(45),-1)));
RQCFG_100030_.tb5_3(45):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(45):=RQCFG_100030_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(45),
RQCFG_100030_.tb5_1(45),
RQCFG_100030_.tb5_2(45),
RQCFG_100030_.tb5_3(45),
RQCFG_100030_.tb5_4(45),
'C'
,
'Y'
,
29,
'N'
,
'Fecha de Atenci¿n'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(46):=1152059;
RQCFG_100030_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(46):=RQCFG_100030_.tb3_0(46);
RQCFG_100030_.old_tb3_1(46):=2036;
RQCFG_100030_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(46),-1)));
RQCFG_100030_.old_tb3_2(46):=41406;
RQCFG_100030_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(46),-1)));
RQCFG_100030_.old_tb3_3(46):=null;
RQCFG_100030_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(46),-1)));
RQCFG_100030_.old_tb3_4(46):=null;
RQCFG_100030_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(46),-1)));
RQCFG_100030_.tb3_5(46):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(46):=null;
RQCFG_100030_.tb3_6(46):=NULL;
RQCFG_100030_.old_tb3_7(46):=null;
RQCFG_100030_.tb3_7(46):=NULL;
RQCFG_100030_.old_tb3_8(46):=120198207;
RQCFG_100030_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(46),
RQCFG_100030_.tb3_1(46),
RQCFG_100030_.tb3_2(46),
RQCFG_100030_.tb3_3(46),
RQCFG_100030_.tb3_4(46),
RQCFG_100030_.tb3_5(46),
RQCFG_100030_.tb3_6(46),
RQCFG_100030_.tb3_7(46),
RQCFG_100030_.tb3_8(46),
null,
101013,
30,
'Zona'
,
'N'
,
'C'
,
'N'
,
30,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(46):=1604717;
RQCFG_100030_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(46):=RQCFG_100030_.tb5_0(46);
RQCFG_100030_.old_tb5_1(46):=41406;
RQCFG_100030_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(46),-1)));
RQCFG_100030_.old_tb5_2(46):=null;
RQCFG_100030_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(46),-1)));
RQCFG_100030_.tb5_3(46):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(46):=RQCFG_100030_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(46),
RQCFG_100030_.tb5_1(46),
RQCFG_100030_.tb5_2(46),
RQCFG_100030_.tb5_3(46),
RQCFG_100030_.tb5_4(46),
'C'
,
'Y'
,
30,
'N'
,
'Zona'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(47):=1152060;
RQCFG_100030_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(47):=RQCFG_100030_.tb3_0(47);
RQCFG_100030_.old_tb3_1(47):=2036;
RQCFG_100030_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(47),-1)));
RQCFG_100030_.old_tb3_2(47):=1035;
RQCFG_100030_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(47),-1)));
RQCFG_100030_.old_tb3_3(47):=null;
RQCFG_100030_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(47),-1)));
RQCFG_100030_.old_tb3_4(47):=null;
RQCFG_100030_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(47),-1)));
RQCFG_100030_.tb3_5(47):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(47):=121407570;
RQCFG_100030_.tb3_6(47):=NULL;
RQCFG_100030_.old_tb3_7(47):=null;
RQCFG_100030_.tb3_7(47):=NULL;
RQCFG_100030_.old_tb3_8(47):=null;
RQCFG_100030_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(47),
RQCFG_100030_.tb3_1(47),
RQCFG_100030_.tb3_2(47),
RQCFG_100030_.tb3_3(47),
RQCFG_100030_.tb3_4(47),
RQCFG_100030_.tb3_5(47),
RQCFG_100030_.tb3_6(47),
RQCFG_100030_.tb3_7(47),
RQCFG_100030_.tb3_8(47),
null,
101014,
31,
'Direcci¿n '
,
'N'
,
'C'
,
'Y'
,
31,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(47):=1604718;
RQCFG_100030_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(47):=RQCFG_100030_.tb5_0(47);
RQCFG_100030_.old_tb5_1(47):=1035;
RQCFG_100030_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(47),-1)));
RQCFG_100030_.old_tb5_2(47):=null;
RQCFG_100030_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(47),-1)));
RQCFG_100030_.tb5_3(47):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(47):=RQCFG_100030_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(47),
RQCFG_100030_.tb5_1(47),
RQCFG_100030_.tb5_2(47),
RQCFG_100030_.tb5_3(47),
RQCFG_100030_.tb5_4(47),
'C'
,
'Y'
,
31,
'Y'
,
'Direcci¿n '
,
'N'
,
'N'
,
'U'
,
null,
2,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(48):=1152061;
RQCFG_100030_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(48):=RQCFG_100030_.tb3_0(48);
RQCFG_100030_.old_tb3_1(48):=2036;
RQCFG_100030_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(48),-1)));
RQCFG_100030_.old_tb3_2(48):=20371;
RQCFG_100030_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(48),-1)));
RQCFG_100030_.old_tb3_3(48):=null;
RQCFG_100030_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(48),-1)));
RQCFG_100030_.old_tb3_4(48):=null;
RQCFG_100030_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(48),-1)));
RQCFG_100030_.tb3_5(48):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(48):=121407563;
RQCFG_100030_.tb3_6(48):=NULL;
RQCFG_100030_.old_tb3_7(48):=null;
RQCFG_100030_.tb3_7(48):=NULL;
RQCFG_100030_.old_tb3_8(48):=null;
RQCFG_100030_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(48),
RQCFG_100030_.tb3_1(48),
RQCFG_100030_.tb3_2(48),
RQCFG_100030_.tb3_3(48),
RQCFG_100030_.tb3_4(48),
RQCFG_100030_.tb3_5(48),
RQCFG_100030_.tb3_6(48),
RQCFG_100030_.tb3_7(48),
RQCFG_100030_.tb3_8(48),
null,
1707,
14,
'Actualizar Datos'
,
'N'
,
'Y'
,
'N'
,
14,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(48):=1604719;
RQCFG_100030_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(48):=RQCFG_100030_.tb5_0(48);
RQCFG_100030_.old_tb5_1(48):=20371;
RQCFG_100030_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(48),-1)));
RQCFG_100030_.old_tb5_2(48):=null;
RQCFG_100030_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(48),-1)));
RQCFG_100030_.tb5_3(48):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(48):=RQCFG_100030_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(48),
RQCFG_100030_.tb5_1(48),
RQCFG_100030_.tb5_2(48),
RQCFG_100030_.tb5_3(48),
RQCFG_100030_.tb5_4(48),
'Y'
,
'Y'
,
14,
'N'
,
'Actualizar Datos'
,
'N'
,
'N'
,
'U'
,
null,
128,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(49):=1152062;
RQCFG_100030_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(49):=RQCFG_100030_.tb3_0(49);
RQCFG_100030_.old_tb3_1(49):=2036;
RQCFG_100030_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(49),-1)));
RQCFG_100030_.old_tb3_2(49):=2508;
RQCFG_100030_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(49),-1)));
RQCFG_100030_.old_tb3_3(49):=null;
RQCFG_100030_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(49),-1)));
RQCFG_100030_.old_tb3_4(49):=null;
RQCFG_100030_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(49),-1)));
RQCFG_100030_.tb3_5(49):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(49):=121407579;
RQCFG_100030_.tb3_6(49):=NULL;
RQCFG_100030_.old_tb3_7(49):=null;
RQCFG_100030_.tb3_7(49):=NULL;
RQCFG_100030_.old_tb3_8(49):=null;
RQCFG_100030_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(49),
RQCFG_100030_.tb3_1(49),
RQCFG_100030_.tb3_2(49),
RQCFG_100030_.tb3_3(49),
RQCFG_100030_.tb3_4(49),
RQCFG_100030_.tb3_5(49),
RQCFG_100030_.tb3_6(49),
RQCFG_100030_.tb3_7(49),
RQCFG_100030_.tb3_8(49),
null,
1548,
13,
'Adjuntar Archivo'
,
'N'
,
'Y'
,
'N'
,
13,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(49):=1604720;
RQCFG_100030_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(49):=RQCFG_100030_.tb5_0(49);
RQCFG_100030_.old_tb5_1(49):=2508;
RQCFG_100030_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(49),-1)));
RQCFG_100030_.old_tb5_2(49):=null;
RQCFG_100030_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(49),-1)));
RQCFG_100030_.tb5_3(49):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(49):=RQCFG_100030_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(49),
RQCFG_100030_.tb5_1(49),
RQCFG_100030_.tb5_2(49),
RQCFG_100030_.tb5_3(49),
RQCFG_100030_.tb5_4(49),
'Y'
,
'Y'
,
13,
'N'
,
'Adjuntar Archivo'
,
'N'
,
'N'
,
'U'
,
null,
30,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(50):=1152063;
RQCFG_100030_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(50):=RQCFG_100030_.tb3_0(50);
RQCFG_100030_.old_tb3_1(50):=2036;
RQCFG_100030_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(50),-1)));
RQCFG_100030_.old_tb3_2(50):=146755;
RQCFG_100030_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(50),-1)));
RQCFG_100030_.old_tb3_3(50):=null;
RQCFG_100030_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(50),-1)));
RQCFG_100030_.old_tb3_4(50):=null;
RQCFG_100030_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(50),-1)));
RQCFG_100030_.tb3_5(50):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(50):=121407576;
RQCFG_100030_.tb3_6(50):=NULL;
RQCFG_100030_.old_tb3_7(50):=null;
RQCFG_100030_.tb3_7(50):=NULL;
RQCFG_100030_.old_tb3_8(50):=null;
RQCFG_100030_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(50),
RQCFG_100030_.tb3_1(50),
RQCFG_100030_.tb3_2(50),
RQCFG_100030_.tb3_3(50),
RQCFG_100030_.tb3_4(50),
RQCFG_100030_.tb3_5(50),
RQCFG_100030_.tb3_6(50),
RQCFG_100030_.tb3_7(50),
RQCFG_100030_.tb3_8(50),
null,
749,
4,
'Informaci¿n del Solicitante'
,
'N'
,
'Y'
,
'Y'
,
4,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(50):=1604721;
RQCFG_100030_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(50):=RQCFG_100030_.tb5_0(50);
RQCFG_100030_.old_tb5_1(50):=146755;
RQCFG_100030_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(50),-1)));
RQCFG_100030_.old_tb5_2(50):=null;
RQCFG_100030_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(50),-1)));
RQCFG_100030_.tb5_3(50):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(50):=RQCFG_100030_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(50),
RQCFG_100030_.tb5_1(50),
RQCFG_100030_.tb5_2(50),
RQCFG_100030_.tb5_3(50),
RQCFG_100030_.tb5_4(50),
'Y'
,
'E'
,
4,
'Y'
,
'Informaci¿n del Solicitante'
,
'N'
,
'N'
,
'U'
,
null,
122,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(51):=1152064;
RQCFG_100030_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(51):=RQCFG_100030_.tb3_0(51);
RQCFG_100030_.old_tb3_1(51):=2036;
RQCFG_100030_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(51),-1)));
RQCFG_100030_.old_tb3_2(51):=146756;
RQCFG_100030_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(51),-1)));
RQCFG_100030_.old_tb3_3(51):=null;
RQCFG_100030_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(51),-1)));
RQCFG_100030_.old_tb3_4(51):=null;
RQCFG_100030_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(51),-1)));
RQCFG_100030_.tb3_5(51):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(51):=121407560;
RQCFG_100030_.tb3_6(51):=NULL;
RQCFG_100030_.old_tb3_7(51):=null;
RQCFG_100030_.tb3_7(51):=NULL;
RQCFG_100030_.old_tb3_8(51):=null;
RQCFG_100030_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(51),
RQCFG_100030_.tb3_1(51),
RQCFG_100030_.tb3_2(51),
RQCFG_100030_.tb3_3(51),
RQCFG_100030_.tb3_4(51),
RQCFG_100030_.tb3_5(51),
RQCFG_100030_.tb3_6(51),
RQCFG_100030_.tb3_7(51),
RQCFG_100030_.tb3_8(51),
null,
750,
8,
'Direcci¿n de Respuesta'
,
'N'
,
'Y'
,
'Y'
,
8,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(51):=1604722;
RQCFG_100030_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(51):=RQCFG_100030_.tb5_0(51);
RQCFG_100030_.old_tb5_1(51):=146756;
RQCFG_100030_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(51),-1)));
RQCFG_100030_.old_tb5_2(51):=null;
RQCFG_100030_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(51),-1)));
RQCFG_100030_.tb5_3(51):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(51):=RQCFG_100030_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(51),
RQCFG_100030_.tb5_1(51),
RQCFG_100030_.tb5_2(51),
RQCFG_100030_.tb5_3(51),
RQCFG_100030_.tb5_4(51),
'Y'
,
'Y'
,
8,
'Y'
,
'Direcci¿n de Respuesta'
,
'N'
,
'N'
,
'U'
,
null,
2,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(52):=1152065;
RQCFG_100030_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(52):=RQCFG_100030_.tb3_0(52);
RQCFG_100030_.old_tb3_1(52):=2036;
RQCFG_100030_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(52),-1)));
RQCFG_100030_.old_tb3_2(52):=146754;
RQCFG_100030_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(52),-1)));
RQCFG_100030_.old_tb3_3(52):=null;
RQCFG_100030_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(52),-1)));
RQCFG_100030_.old_tb3_4(52):=null;
RQCFG_100030_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(52),-1)));
RQCFG_100030_.tb3_5(52):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(52):=null;
RQCFG_100030_.tb3_6(52):=NULL;
RQCFG_100030_.old_tb3_7(52):=null;
RQCFG_100030_.tb3_7(52):=NULL;
RQCFG_100030_.old_tb3_8(52):=null;
RQCFG_100030_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(52),
RQCFG_100030_.tb3_1(52),
RQCFG_100030_.tb3_2(52),
RQCFG_100030_.tb3_3(52),
RQCFG_100030_.tb3_4(52),
RQCFG_100030_.tb3_5(52),
RQCFG_100030_.tb3_6(52),
RQCFG_100030_.tb3_7(52),
RQCFG_100030_.tb3_8(52),
null,
751,
12,
'Observaci¿n'
,
'N'
,
'Y'
,
'Y'
,
12,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(52):=1604723;
RQCFG_100030_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(52):=RQCFG_100030_.tb5_0(52);
RQCFG_100030_.old_tb5_1(52):=146754;
RQCFG_100030_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(52),-1)));
RQCFG_100030_.old_tb5_2(52):=null;
RQCFG_100030_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(52),-1)));
RQCFG_100030_.tb5_3(52):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(52):=RQCFG_100030_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(52),
RQCFG_100030_.tb5_1(52),
RQCFG_100030_.tb5_2(52),
RQCFG_100030_.tb5_3(52),
RQCFG_100030_.tb5_4(52),
'Y'
,
'Y'
,
12,
'Y'
,
'Observaci¿n'
,
'N'
,
'N'
,
'U'
,
null,
110,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(53):=1152066;
RQCFG_100030_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(53):=RQCFG_100030_.tb3_0(53);
RQCFG_100030_.old_tb3_1(53):=2036;
RQCFG_100030_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(53),-1)));
RQCFG_100030_.old_tb3_2(53):=6733;
RQCFG_100030_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(53),-1)));
RQCFG_100030_.old_tb3_3(53):=null;
RQCFG_100030_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(53),-1)));
RQCFG_100030_.old_tb3_4(53):=146755;
RQCFG_100030_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(53),-1)));
RQCFG_100030_.tb3_5(53):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(53):=121407561;
RQCFG_100030_.tb3_6(53):=NULL;
RQCFG_100030_.old_tb3_7(53):=null;
RQCFG_100030_.tb3_7(53):=NULL;
RQCFG_100030_.old_tb3_8(53):=null;
RQCFG_100030_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(53),
RQCFG_100030_.tb3_1(53),
RQCFG_100030_.tb3_2(53),
RQCFG_100030_.tb3_3(53),
RQCFG_100030_.tb3_4(53),
RQCFG_100030_.tb3_5(53),
RQCFG_100030_.tb3_6(53),
RQCFG_100030_.tb3_7(53),
RQCFG_100030_.tb3_8(53),
null,
1166,
5,
'Nombre '
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(53):=1604724;
RQCFG_100030_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(53):=RQCFG_100030_.tb5_0(53);
RQCFG_100030_.old_tb5_1(53):=6733;
RQCFG_100030_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(53),-1)));
RQCFG_100030_.old_tb5_2(53):=146755;
RQCFG_100030_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(53),-1)));
RQCFG_100030_.tb5_3(53):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(53):=RQCFG_100030_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(53),
RQCFG_100030_.tb5_1(53),
RQCFG_100030_.tb5_2(53),
RQCFG_100030_.tb5_3(53),
RQCFG_100030_.tb5_4(53),
'Y'
,
'N'
,
5,
'N'
,
'Nombre '
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(54):=1152067;
RQCFG_100030_.tb3_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(54):=RQCFG_100030_.tb3_0(54);
RQCFG_100030_.old_tb3_1(54):=2036;
RQCFG_100030_.tb3_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(54),-1)));
RQCFG_100030_.old_tb3_2(54):=138161;
RQCFG_100030_.tb3_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(54),-1)));
RQCFG_100030_.old_tb3_3(54):=null;
RQCFG_100030_.tb3_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(54),-1)));
RQCFG_100030_.old_tb3_4(54):=null;
RQCFG_100030_.tb3_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(54),-1)));
RQCFG_100030_.tb3_5(54):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(54):=null;
RQCFG_100030_.tb3_6(54):=NULL;
RQCFG_100030_.old_tb3_7(54):=null;
RQCFG_100030_.tb3_7(54):=NULL;
RQCFG_100030_.old_tb3_8(54):=null;
RQCFG_100030_.tb3_8(54):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(54),
RQCFG_100030_.tb3_1(54),
RQCFG_100030_.tb3_2(54),
RQCFG_100030_.tb3_3(54),
RQCFG_100030_.tb3_4(54),
RQCFG_100030_.tb3_5(54),
RQCFG_100030_.tb3_6(54),
RQCFG_100030_.tb3_7(54),
RQCFG_100030_.tb3_8(54),
null,
1169,
20,
'Datos de la Queja'
,
'N'
,
'Y'
,
'N'
,
20,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(54):=1604725;
RQCFG_100030_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(54):=RQCFG_100030_.tb5_0(54);
RQCFG_100030_.old_tb5_1(54):=138161;
RQCFG_100030_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(54),-1)));
RQCFG_100030_.old_tb5_2(54):=null;
RQCFG_100030_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(54),-1)));
RQCFG_100030_.tb5_3(54):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(54):=RQCFG_100030_.tb3_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(54),
RQCFG_100030_.tb5_1(54),
RQCFG_100030_.tb5_2(54),
RQCFG_100030_.tb5_3(54),
RQCFG_100030_.tb5_4(54),
'Y'
,
'Y'
,
20,
'N'
,
'Datos de la Queja'
,
'N'
,
'N'
,
'U'
,
null,
10,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(55):=1152068;
RQCFG_100030_.tb3_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(55):=RQCFG_100030_.tb3_0(55);
RQCFG_100030_.old_tb3_1(55):=2036;
RQCFG_100030_.tb3_1(55):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(55),-1)));
RQCFG_100030_.old_tb3_2(55):=189644;
RQCFG_100030_.tb3_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(55),-1)));
RQCFG_100030_.old_tb3_3(55):=null;
RQCFG_100030_.tb3_3(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(55),-1)));
RQCFG_100030_.old_tb3_4(55):=null;
RQCFG_100030_.tb3_4(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(55),-1)));
RQCFG_100030_.tb3_5(55):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(55):=null;
RQCFG_100030_.tb3_6(55):=NULL;
RQCFG_100030_.old_tb3_7(55):=null;
RQCFG_100030_.tb3_7(55):=NULL;
RQCFG_100030_.old_tb3_8(55):=null;
RQCFG_100030_.tb3_8(55):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (55)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(55),
RQCFG_100030_.tb3_1(55),
RQCFG_100030_.tb3_2(55),
RQCFG_100030_.tb3_3(55),
RQCFG_100030_.tb3_4(55),
RQCFG_100030_.tb3_5(55),
RQCFG_100030_.tb3_6(55),
RQCFG_100030_.tb3_7(55),
RQCFG_100030_.tb3_8(55),
null,
1713,
9,
'Causal'
,
'N'
,
'Y'
,
'Y'
,
9,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(55):=1604726;
RQCFG_100030_.tb5_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(55):=RQCFG_100030_.tb5_0(55);
RQCFG_100030_.old_tb5_1(55):=189644;
RQCFG_100030_.tb5_1(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(55),-1)));
RQCFG_100030_.old_tb5_2(55):=null;
RQCFG_100030_.tb5_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(55),-1)));
RQCFG_100030_.tb5_3(55):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(55):=RQCFG_100030_.tb3_0(55);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(55),
RQCFG_100030_.tb5_1(55),
RQCFG_100030_.tb5_2(55),
RQCFG_100030_.tb5_3(55),
RQCFG_100030_.tb5_4(55),
'Y'
,
'Y'
,
9,
'Y'
,
'Causal'
,
'N'
,
'N'
,
'U'
,
null,
130,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb3_0(56):=1152069;
RQCFG_100030_.tb3_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100030_.tb3_0(56):=RQCFG_100030_.tb3_0(56);
RQCFG_100030_.old_tb3_1(56):=2036;
RQCFG_100030_.tb3_1(56):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100030_.TBENTITYNAME(NVL(RQCFG_100030_.old_tb3_1(56),-1)));
RQCFG_100030_.old_tb3_2(56):=182398;
RQCFG_100030_.tb3_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_2(56),-1)));
RQCFG_100030_.old_tb3_3(56):=null;
RQCFG_100030_.tb3_3(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_3(56),-1)));
RQCFG_100030_.old_tb3_4(56):=189644;
RQCFG_100030_.tb3_4(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb3_4(56),-1)));
RQCFG_100030_.tb3_5(56):=RQCFG_100030_.tb2_2(0);
RQCFG_100030_.old_tb3_6(56):=null;
RQCFG_100030_.tb3_6(56):=NULL;
RQCFG_100030_.old_tb3_7(56):=null;
RQCFG_100030_.tb3_7(56):=NULL;
RQCFG_100030_.old_tb3_8(56):=120198211;
RQCFG_100030_.tb3_8(56):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (56)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100030_.tb3_0(56),
RQCFG_100030_.tb3_1(56),
RQCFG_100030_.tb3_2(56),
RQCFG_100030_.tb3_3(56),
RQCFG_100030_.tb3_4(56),
RQCFG_100030_.tb3_5(56),
RQCFG_100030_.tb3_6(56),
RQCFG_100030_.tb3_7(56),
RQCFG_100030_.tb3_8(56),
null,
1371,
11,
'¿rea Que Gestiona La Solicitud'
,
'N'
,
'Y'
,
'Y'
,
11,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;

RQCFG_100030_.old_tb5_0(56):=1604727;
RQCFG_100030_.tb5_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100030_.tb5_0(56):=RQCFG_100030_.tb5_0(56);
RQCFG_100030_.old_tb5_1(56):=182398;
RQCFG_100030_.tb5_1(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_1(56),-1)));
RQCFG_100030_.old_tb5_2(56):=189644;
RQCFG_100030_.tb5_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100030_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100030_.old_tb5_2(56),-1)));
RQCFG_100030_.tb5_3(56):=RQCFG_100030_.tb4_0(1);
RQCFG_100030_.tb5_4(56):=RQCFG_100030_.tb3_0(56);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100030_.tb5_0(56),
RQCFG_100030_.tb5_1(56),
RQCFG_100030_.tb5_2(56),
RQCFG_100030_.tb5_3(56),
RQCFG_100030_.tb5_4(56),
'Y'
,
'Y'
,
11,
'Y'
,
'¿rea Que Gestiona La Solicitud'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100030);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100030)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100030_.blProcessStatus) then
 return;
end if;
UPDATE  gi_comp_attribs
SET     init_expression_id  = (SELECT init_expression_id  FROM ps_package_attribs WHERE PACKAGE_attribs_id = gi_comp_attribs.external_id),
valid_expression_id = (SELECT valid_expression_id FROM ps_package_attribs WHERE PACKAGE_attribs_id = gi_comp_attribs.external_id),
select_statement_id = (SELECT    statement_id     FROM ps_package_attribs WHERE PACKAGE_attribs_id = gi_comp_attribs.external_id)
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id =
(
SELECT  config_id
FROM    gi_config
WHERE   config_type_id = 4
AND     entity_root_id = 2012
AND     external_root_id = 100030
)
)
AND     entity_id = 2036;
UPDATE  gi_comp_attribs
SET     init_expression_id  = (SELECT init_expression_id  FROM ps_moti_comp_attribs WHERE moti_comp_attribs_id = gi_comp_attribs.external_id),
valid_expression_id = (SELECT valid_expression_id FROM ps_moti_comp_attribs WHERE moti_comp_attribs_id = gi_comp_attribs.external_id),
select_statement_id = (SELECT    statement_id     FROM ps_moti_comp_attribs WHERE moti_comp_attribs_id = gi_comp_attribs.external_id)
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id =
(
SELECT  config_id
FROM    gi_config
WHERE   config_type_id = 4
AND     entity_root_id = 2012
AND     external_root_id = 100030
)
)
AND     entity_id = 2042;
UPDATE  gi_comp_attribs
SET     init_expression_id  = (SELECT init_expression_id  FROM ps_prod_moti_attrib WHERE prod_moti_attrib_id = gi_comp_attribs.external_id),
valid_expression_id = (SELECT valid_expression_id FROM ps_prod_moti_attrib WHERE prod_moti_attrib_id = gi_comp_attribs.external_id),
select_statement_id = (SELECT    statement_id     FROM ps_prod_moti_attrib WHERE prod_moti_attrib_id = gi_comp_attribs.external_id)
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id =
(
SELECT  config_id
FROM    gi_config
WHERE   config_type_id = 4
AND     entity_root_id = 2012
AND     external_root_id = 100030
)
)
AND     entity_id = 3334;
ut_trace.trace('Se actualizan las composiciones de las solicitudes asociadas', 7);
ut_trace.trace('Se actualizan los config_comp_id de las solicitudes asociadas', 7);
open c1;
fetch c1 bulk collect INTO tbMotivos;
close c1;
-- Se obtiene primer registro
indice := tbMotivos.FIRST;
-- Se actualizan los registros a partir del motivo
while indice IS not null loop
    UPDATE  gi_config_comp
    SET     composition_id =
    (
        SELECT  composition_id
        FROM    gi_composition
        WHERE   entity_type_id = 2013
        AND     external_type_id = tbMotivos(indice)
        AND     composition_id in
        (
            SELECT  composition_id
            FROM    gi_config_comp
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100030, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100030)
        )
    )
    WHERE   composition_id in
    (
        SELECT  composition_id
        FROM    gi_composition
        WHERE   entity_type_id = 2013
        AND     external_type_id = tbMotivos(indice)
        AND     composition_id not in
        (
            SELECT  composition_id
            FROM    gi_config_comp
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100030, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100030)
        )
    );
    indice := tbMotivos.NEXT(indice);
END loop;
-- Se abre CURSOR de componentes de motivo
open c2;
fetch c2 bulk collect INTO tbMoticom;
close c2;
-- Se obtiene el índice
indice := tbMoticom.FIRST;
-- Se actualizan los registros a partir del componente de motivo
while indice IS not null loop
    UPDATE  gi_config_comp
    SET     composition_id =
    (
        SELECT  composition_id
        FROM    gi_composition
        WHERE   entity_type_id = 2014
        AND     external_type_id = tbMoticom(indice)
        AND     composition_id in
        (
            SELECT  composition_id
            FROM    gi_config_comp
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100030, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100030)
        )
    )
    WHERE   composition_id in
    (
        SELECT  composition_id
        FROM    gi_composition
        WHERE   entity_type_id = 2014
        AND     external_type_id = tbMoticom(indice)
        AND     composition_id not in
        (
            SELECT  composition_id
            FROM    gi_config_comp
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100030, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100030)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100030_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100030_.tbCompositions.FIRST..RQCFG_100030_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100030_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100030_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := RQCFG_100030_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100030_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100030_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100030_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100030_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100030_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100030_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100030_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQCFG_100030_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100030_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100030_',
'CREATE OR REPLACE PACKAGE I18N_R_100030_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100030_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100030_******************************'); END;
/


declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM I18N_STRING WHERE ID in
(
SELECT  tag_name
FROM    gi_composition
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id =
(
SELECT    config_id
FROM      gi_config
WHERE     EXTERNAL_ROOT_ID= 100030
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla I18N_STRING',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM I18N_STRING WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(0):='M_REGISTRO_DE_QUEJAS_100020'
;
I18N_R_100030_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(0),
I18N_R_100030_.tb0_1(0),
'WE8ISO8859P1'
,
'Registro de Quejas'
,
'Registro de Quejas'
,
null,
'Registro de Quejas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(1):='M_REGISTRO_DE_QUEJAS_100020'
;
I18N_R_100030_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(1),
I18N_R_100030_.tb0_1(1),
'WE8ISO8859P1'
,
'Registro de Quejas'
,
'Registro de Quejas'
,
null,
'Registro de Quejas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(2):='M_REGISTRO_DE_QUEJAS_100020'
;
I18N_R_100030_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(2),
I18N_R_100030_.tb0_1(2),
'WE8ISO8859P1'
,
'Registro de Quejas'
,
'Registro de Quejas'
,
null,
'Registro de Quejas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(3):='PAQUETE'
;
I18N_R_100030_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(3),
I18N_R_100030_.tb0_1(3),
'WE8ISO8859P1'
,
'Datos B¿sicos Solicitud'
,
'Datos B¿sicos Solicitud'
,
null,
'Datos B¿sicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(4):='PAQUETE'
;
I18N_R_100030_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(4),
I18N_R_100030_.tb0_1(4),
'WE8ISO8859P1'
,
'Datos B¿sicos Solicitud'
,
'Datos B¿sicos Solicitud'
,
null,
'Datos B¿sicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(5):='PAQUETE'
;
I18N_R_100030_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(5),
I18N_R_100030_.tb0_1(5),
'WE8ISO8859P1'
,
'Datos B¿sicos Solicitud'
,
'Datos B¿sicos Solicitud'
,
null,
'Datos B¿sicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100030_.blProcessStatus) then
 return;
end if;

I18N_R_100030_.tb0_0(6):='PAQUETE'
;
I18N_R_100030_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100030_.tb0_0(6),
I18N_R_100030_.tb0_1(6),
'WE8ISO8859P1'
,
'Datos B¿sicos Solicitud'
,
'Datos B¿sicos Solicitud'
,
null,
'Datos B¿sicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100030_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100030_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100030_',
'CREATE OR REPLACE PACKAGE RQEXEC_100030_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type ty0_0 is table of SA_EXECUTABLE.NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of SA_EXECUTABLE.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1; ' || chr(10) ||
'END RQEXEC_100030_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100030_******************************'); END;
/


BEGIN

if (not RQEXEC_100030_.blProcessStatus) then
 return;
end if;

RQEXEC_100030_.old_tb0_0(0):='P_GENER_REGISTROQUEJAS'
;
RQEXEC_100030_.tb0_0(0):=UPPER(RQEXEC_100030_.old_tb0_0(0));
RQEXEC_100030_.old_tb0_1(0):=7721;
RQEXEC_100030_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100030_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100030_.tb0_1(0):=RQEXEC_100030_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100030_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100030_.tb0_1(0),
DESCRIPTION='Registro de Quejas'
,
PATH=null,
VERSION='467'
,
EXECUTABLE_TYPE_ID=3,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=16,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP='ges_comercial_aten_clie_quejas_reg_quejas.htm'
,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='N'
,
TIMES_EXECUTED=55602,
EXEC_OWNER='O'
,
LAST_DATE_EXECUTED=to_date('04-02-2025 14:57:21','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100030_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100030_.tb0_0(0),
RQEXEC_100030_.tb0_1(0),
'Registro de Quejas'
,
null,
'467'
,
3,
2,
16,
1,
null,
'N'
,
'ges_comercial_aten_clie_quejas_reg_quejas.htm'
,
'N'
,
'N'
,
55602,
'O'
,
to_date('04-02-2025 14:57:21','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100030_.blProcessStatus) then
 return;
end if;

RQEXEC_100030_.tb1_0(0):=1;
RQEXEC_100030_.tb1_1(0):=RQEXEC_100030_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100030_.tb1_0(0),
RQEXEC_100030_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100030_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100030_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100030_******************************'); end;
/

