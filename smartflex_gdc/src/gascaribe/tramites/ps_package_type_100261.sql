BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100261_',
'CREATE OR REPLACE PACKAGE RQTY_100261_ IS ' || chr(10) ||
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
'tb7_0 ty7_0;type ty8_0 is table of GE_STATEMENT_COLUMNS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty10_0 is table of PS_PACK_TYPE_PARAM.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of PS_PACK_TYPE_PARAM.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty11_0 is table of PS_PACKAGE_UNITTYPE.PACKAGE_UNITTYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of PS_PACKAGE_UNITTYPE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty11_2 is table of PS_PACKAGE_UNITTYPE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_2 ty11_2; ' || chr(10) ||
'tb11_2 ty11_2;type ty11_3 is table of PS_PACKAGE_UNITTYPE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_3 ty11_3; ' || chr(10) ||
'tb11_3 ty11_3;type ty12_0 is table of WF_ATTRIBUTES_EQUIV.ATTRIBUTES_EQUIV_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of WF_ATTRIBUTES_EQUIV.VALUE_1%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty13_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty14_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty15_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb15_0 ty15_0; ' || chr(10) ||
'tb15_0 ty15_0;type ty15_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb15_1 ty15_1; ' || chr(10) ||
'tb15_1 ty15_1;type ty15_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb15_2 ty15_2; ' || chr(10) ||
'tb15_2 ty15_2;type ty15_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb15_3 ty15_3; ' || chr(10) ||
'tb15_3 ty15_3;type ty16_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb16_0 ty16_0; ' || chr(10) ||
'tb16_0 ty16_0;type ty17_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_0 ty17_0; ' || chr(10) ||
'tb17_0 ty17_0;type ty17_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_1 ty17_1; ' || chr(10) ||
'tb17_1 ty17_1;type ty17_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_2 ty17_2; ' || chr(10) ||
'tb17_2 ty17_2;type ty17_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_3 ty17_3; ' || chr(10) ||
'tb17_3 ty17_3;type ty18_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_0 ty18_0; ' || chr(10) ||
'tb18_0 ty18_0;type ty18_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_1 ty18_1; ' || chr(10) ||
'tb18_1 ty18_1;type ty18_3 is table of PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_3 ty18_3; ' || chr(10) ||
'tb18_3 ty18_3;--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM ' || chr(10) ||
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100261 ' || chr(10) ||
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
'END RQTY_100261_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100261_******************************'); END;
/

BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
AND     external_root_id = 100261
)
);

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100261_.cuExpressions;
fetch RQTY_100261_.cuExpressions bulk collect INTO RQTY_100261_.tbExpressionsId;
close RQTY_100261_.cuExpressions;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100261_.tbEntityName(-1) := 'NULL';
   RQTY_100261_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100261_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68342) := 'CC_SALES_FINANC_COND@PACKAGE_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68345) := 'CC_SALES_FINANC_COND@INTEREST_RATE_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68351) := 'CC_SALES_FINANC_COND@TAX_FINANCING_ONE';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68353) := 'CC_SALES_FINANC_COND@DOCUMENT_SUPPORT';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100261_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68347) := 'CC_SALES_FINANC_COND@PERCENT_TO_FINANCE';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68348) := 'CC_SALES_FINANC_COND@INTEREST_PERCENT';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQTY_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100261_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68349) := 'CC_SALES_FINANC_COND@SPREAD';
   RQTY_100261_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   RQTY_100261_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(282) := 'MO_ADDRESS@ADDRESS';
   RQTY_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100261_.tbEntityAttributeName(475) := 'MO_ADDRESS@GEOGRAP_LOCATION_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68343) := 'CC_SALES_FINANC_COND@FINANCING_PLAN_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68346) := 'CC_SALES_FINANC_COND@FIRST_PAY_DATE';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(50001351) := 'MO_PACKAGES@COMM_EXCEPTION';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68350) := 'CC_SALES_FINANC_COND@QUOTAS_NUMBER';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68577) := 'CC_SALES_FINANC_COND@INITIAL_PAYMENT';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68344) := 'CC_SALES_FINANC_COND@COMPUTE_METHOD_ID';
   RQTY_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQTY_100261_.tbEntityAttributeName(68352) := 'CC_SALES_FINANC_COND@VALUE_TO_FINANCE';
   RQTY_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100261_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100261
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100261
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100261
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100261
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100261_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100261_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100261_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100261_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100261_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100261_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100261_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261))));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261))));

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100261_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100261_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100261_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100261_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100261_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100261_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100261_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100261_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261)));

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261));
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100261_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261);
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100261_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100261_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100261_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100261_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100261;
nuIndex binary_integer;
BEGIN

if (not RQTY_100261_.blProcessStatus) then
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100261_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100261_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100261_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100261_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100261_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100261_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100261_.tb0_0(0),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb1_0(0):=1;
RQTY_100261_.tb1_1(0):=RQTY_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100261_.tb1_0(0),
MODULE_ID=RQTY_100261_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100261_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100261_.tb1_0(0),
RQTY_100261_.tb1_1(0),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(0):=121128771;
RQTY_100261_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(0):=RQTY_100261_.tb2_0(0);
RQTY_100261_.old_tb2_1(0):='GE_EXEACTION_CT1E121128771'
;
RQTY_100261_.tb2_1(0):=RQTY_100261_.tb2_0(0);
RQTY_100261_.tb2_2(0):=RQTY_100261_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(0),
RQTY_100261_.tb2_1(0),
RQTY_100261_.tb2_2(0),
'inuPackage = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();LD_BOSECUREMANAGEMENT.PROCSALECREATE(inuPackage);LD_BOFLOWFNBPACK.GETLDPARAMATER("COD_CAU_CUMP","Y",sbcauscump);LD_BCSECUREMANAGEMENT.GETCAUSSECURE(inuPackage,sbcauscump,onuvalue);if (onuvalue <> 0,MO_BOATTENTION.ACTCREATEPLANWF();,CF_BOACTIONS.ATTENDREQUEST(inuPackage);)'
,
'LBTEST'
,
to_date('26-09-2012 11:51:05','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla Ingreso tramite venta de seguro'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb3_0(0):=8151;
RQTY_100261_.tb3_1(0):=RQTY_100261_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100261_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100261_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='LD- Venta de Seguros'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100261_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100261_.tb3_0(0),
RQTY_100261_.tb3_1(0),
5,
'LD- Venta de Seguros'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb4_0(0):=RQTY_100261_.tb3_0(0);
RQTY_100261_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100261_.tb4_0(0),
VALID_MODULE_ID=RQTY_100261_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100261_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100261_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100261_.tb4_0(0),
RQTY_100261_.tb4_1(0));
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb4_0(1):=RQTY_100261_.tb3_0(0);
RQTY_100261_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100261_.tb4_0(1),
VALID_MODULE_ID=RQTY_100261_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100261_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100261_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100261_.tb4_0(1),
RQTY_100261_.tb4_1(1));
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb4_0(2):=RQTY_100261_.tb3_0(0);
RQTY_100261_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100261_.tb4_0(2),
VALID_MODULE_ID=RQTY_100261_.tb4_1(2)
 WHERE ACTION_ID = RQTY_100261_.tb4_0(2) AND VALID_MODULE_ID = RQTY_100261_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100261_.tb4_0(2),
RQTY_100261_.tb4_1(2));
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb5_0(0):=100261;
RQTY_100261_.tb5_1(0):=RQTY_100261_.tb3_0(0);
RQTY_100261_.tb5_4(0):='P_TRAMITE_VENTA_SEGUROS_XML_100261'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100261_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100261_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100261_.tb5_4(0),
DESCRIPTION='Venta Seguros XML'
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
IS_ANNULABLE='N'
,
IS_DEMAND_REQUEST='N'
,
ANSWER_REQUIRED='Y'
,
LIQUIDATION_METHOD=2
 WHERE PACKAGE_TYPE_ID = RQTY_100261_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100261_.tb5_0(0),
RQTY_100261_.tb5_1(0),
null,
null,
RQTY_100261_.tb5_4(0),
'Venta Seguros XML'
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
'N'
,
'N'
,
'Y'
,
2);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(0):=106256;
RQTY_100261_.tb6_1(0):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(0):=2640;
RQTY_100261_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(0),-1)));
RQTY_100261_.old_tb6_3(0):=68346;
RQTY_100261_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(0),-1)));
RQTY_100261_.old_tb6_4(0):=null;
RQTY_100261_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(0),-1)));
RQTY_100261_.old_tb6_5(0):=null;
RQTY_100261_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(0),
ENTITY_ID=RQTY_100261_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=29,
DISPLAY_NAME='Fecha De Cobro Primera Cuota'
,
DISPLAY_ORDER=29,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='FIRST_PAY_DATE'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='FIRST_PAY_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(0),
RQTY_100261_.tb6_1(0),
RQTY_100261_.tb6_2(0),
RQTY_100261_.tb6_3(0),
RQTY_100261_.tb6_4(0),
RQTY_100261_.tb6_5(0),
null,
null,
null,
null,
29,
'Fecha De Cobro Primera Cuota'
,
29,
'N'
,
'N'
,
'N'
,
'FIRST_PAY_DATE'
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
'CC_SALES_FINANC_COND'
,
'FIRST_PAY_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(1):=106257;
RQTY_100261_.tb6_1(1):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(1):=2640;
RQTY_100261_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(1),-1)));
RQTY_100261_.old_tb6_3(1):=68347;
RQTY_100261_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(1),-1)));
RQTY_100261_.old_tb6_4(1):=null;
RQTY_100261_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(1),-1)));
RQTY_100261_.old_tb6_5(1):=null;
RQTY_100261_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(1),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(1),
ENTITY_ID=RQTY_100261_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=30,
DISPLAY_NAME='Porcentaje A Financiar'
,
DISPLAY_ORDER=30,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PERCENT_TO_FINANCE'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='PERCENT_TO_FINANCE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(1),
RQTY_100261_.tb6_1(1),
RQTY_100261_.tb6_2(1),
RQTY_100261_.tb6_3(1),
RQTY_100261_.tb6_4(1),
RQTY_100261_.tb6_5(1),
null,
null,
null,
null,
30,
'Porcentaje A Financiar'
,
30,
'N'
,
'N'
,
'N'
,
'PERCENT_TO_FINANCE'
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
'CC_SALES_FINANC_COND'
,
'PERCENT_TO_FINANCE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(2):=106258;
RQTY_100261_.tb6_1(2):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(2):=2640;
RQTY_100261_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(2),-1)));
RQTY_100261_.old_tb6_3(2):=68348;
RQTY_100261_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(2),-1)));
RQTY_100261_.old_tb6_4(2):=null;
RQTY_100261_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(2),-1)));
RQTY_100261_.old_tb6_5(2):=null;
RQTY_100261_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(2),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(2),
ENTITY_ID=RQTY_100261_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=31,
DISPLAY_NAME='Porcentaje De Interés'
,
DISPLAY_ORDER=31,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='INTEREST_PERCENT'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='INTEREST_PERCENT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(2),
RQTY_100261_.tb6_1(2),
RQTY_100261_.tb6_2(2),
RQTY_100261_.tb6_3(2),
RQTY_100261_.tb6_4(2),
RQTY_100261_.tb6_5(2),
null,
null,
null,
null,
31,
'Porcentaje De Interés'
,
31,
'N'
,
'N'
,
'N'
,
'INTEREST_PERCENT'
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
'CC_SALES_FINANC_COND'
,
'INTEREST_PERCENT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(3):=106221;
RQTY_100261_.tb6_1(3):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(3):=17;
RQTY_100261_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(3),-1)));
RQTY_100261_.old_tb6_3(3):=50001351;
RQTY_100261_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(3),-1)));
RQTY_100261_.old_tb6_4(3):=null;
RQTY_100261_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(3),-1)));
RQTY_100261_.old_tb6_5(3):=null;
RQTY_100261_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(3),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(3),
ENTITY_ID=RQTY_100261_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=38,
DISPLAY_NAME='Excepción comercial'
,
DISPLAY_ORDER=38,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='COMM_EXCEPTION'
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
ATTRI_TECHNICAL_NAME='COMM_EXCEPTION'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(3),
RQTY_100261_.tb6_1(3),
RQTY_100261_.tb6_2(3),
RQTY_100261_.tb6_3(3),
RQTY_100261_.tb6_4(3),
RQTY_100261_.tb6_5(3),
null,
null,
null,
null,
38,
'Excepción comercial'
,
38,
'Y'
,
'N'
,
'N'
,
'COMM_EXCEPTION'
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
'COMM_EXCEPTION'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(4):=106259;
RQTY_100261_.tb6_1(4):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(4):=2640;
RQTY_100261_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(4),-1)));
RQTY_100261_.old_tb6_3(4):=68349;
RQTY_100261_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(4),-1)));
RQTY_100261_.old_tb6_4(4):=null;
RQTY_100261_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(4),-1)));
RQTY_100261_.old_tb6_5(4):=null;
RQTY_100261_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(4),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(4),
ENTITY_ID=RQTY_100261_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=32,
DISPLAY_NAME='Puntos Adicionales'
,
DISPLAY_ORDER=32,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SPREAD'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='SPREAD'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(4),
RQTY_100261_.tb6_1(4),
RQTY_100261_.tb6_2(4),
RQTY_100261_.tb6_3(4),
RQTY_100261_.tb6_4(4),
RQTY_100261_.tb6_5(4),
null,
null,
null,
null,
32,
'Puntos Adicionales'
,
32,
'N'
,
'N'
,
'N'
,
'SPREAD'
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
'CC_SALES_FINANC_COND'
,
'SPREAD'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100261_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100261_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100261_.tb0_0(1),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb1_0(1):=23;
RQTY_100261_.tb1_1(1):=RQTY_100261_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100261_.tb1_0(1),
MODULE_ID=RQTY_100261_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100261_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100261_.tb1_0(1),
RQTY_100261_.tb1_1(1),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(1):=121128779;
RQTY_100261_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(1):=RQTY_100261_.tb2_0(1);
RQTY_100261_.old_tb2_1(1):='MO_INITATRIB_CT23E121128779'
;
RQTY_100261_.tb2_1(1):=RQTY_100261_.tb2_0(1);
RQTY_100261_.tb2_2(1):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(1),
RQTY_100261_.tb2_1(1),
RQTY_100261_.tb2_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("N")'
,
'LBTEST'
,
to_date('23-10-2012 21:00:05','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializaci¿n de la financiaci¿n iva a una couta de venta de seguros'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(5):=106260;
RQTY_100261_.tb6_1(5):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(5):=2640;
RQTY_100261_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(5),-1)));
RQTY_100261_.old_tb6_3(5):=68351;
RQTY_100261_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(5),-1)));
RQTY_100261_.old_tb6_4(5):=null;
RQTY_100261_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(5),-1)));
RQTY_100261_.old_tb6_5(5):=null;
RQTY_100261_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(5),-1)));
RQTY_100261_.tb6_7(5):=RQTY_100261_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(5),
ENTITY_ID=RQTY_100261_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=33,
DISPLAY_NAME='Financiar Iva A Una Cuota'
,
DISPLAY_ORDER=33,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='TAX_FINANCING_ONE'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='TAX_FINANCING_ONE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(5),
RQTY_100261_.tb6_1(5),
RQTY_100261_.tb6_2(5),
RQTY_100261_.tb6_3(5),
RQTY_100261_.tb6_4(5),
RQTY_100261_.tb6_5(5),
null,
RQTY_100261_.tb6_7(5),
null,
null,
33,
'Financiar Iva A Una Cuota'
,
33,
'N'
,
'N'
,
'N'
,
'TAX_FINANCING_ONE'
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
'CC_SALES_FINANC_COND'
,
'TAX_FINANCING_ONE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(6):=106261;
RQTY_100261_.tb6_1(6):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(6):=2640;
RQTY_100261_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(6),-1)));
RQTY_100261_.old_tb6_3(6):=68353;
RQTY_100261_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(6),-1)));
RQTY_100261_.old_tb6_4(6):=null;
RQTY_100261_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(6),-1)));
RQTY_100261_.old_tb6_5(6):=null;
RQTY_100261_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(6),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(6),
ENTITY_ID=RQTY_100261_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=34,
DISPLAY_NAME='Documento De Soporte'
,
DISPLAY_ORDER=34,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DOCUMENT_SUPPORT'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='DOCUMENT_SUPPORT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(6),
RQTY_100261_.tb6_1(6),
RQTY_100261_.tb6_2(6),
RQTY_100261_.tb6_3(6),
RQTY_100261_.tb6_4(6),
RQTY_100261_.tb6_5(6),
null,
null,
null,
null,
34,
'Documento De Soporte'
,
34,
'N'
,
'N'
,
'N'
,
'DOCUMENT_SUPPORT'
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
'CC_SALES_FINANC_COND'
,
'DOCUMENT_SUPPORT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(2):=121128782;
RQTY_100261_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(2):=RQTY_100261_.tb2_0(2);
RQTY_100261_.old_tb2_1(2):='MO_INITATRIB_CT23E121128782'
;
RQTY_100261_.tb2_1(2):=RQTY_100261_.tb2_0(2);
RQTY_100261_.tb2_2(2):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(2),
RQTY_100261_.tb2_1(2),
RQTY_100261_.tb2_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("0")'
,
'LBTEST'
,
to_date('23-10-2012 21:00:06','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Ini valor a financiar venta de seguros'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(7):=106262;
RQTY_100261_.tb6_1(7):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(7):=2640;
RQTY_100261_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(7),-1)));
RQTY_100261_.old_tb6_3(7):=68577;
RQTY_100261_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(7),-1)));
RQTY_100261_.old_tb6_4(7):=null;
RQTY_100261_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(7),-1)));
RQTY_100261_.old_tb6_5(7):=null;
RQTY_100261_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(7),-1)));
RQTY_100261_.tb6_7(7):=RQTY_100261_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(7),
ENTITY_ID=RQTY_100261_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=35,
DISPLAY_NAME='Valor A Pagar'
,
DISPLAY_ORDER=35,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='INITIAL_PAYMENT'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='INITIAL_PAYMENT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(7),
RQTY_100261_.tb6_1(7),
RQTY_100261_.tb6_2(7),
RQTY_100261_.tb6_3(7),
RQTY_100261_.tb6_4(7),
RQTY_100261_.tb6_5(7),
null,
RQTY_100261_.tb6_7(7),
null,
null,
35,
'Valor A Pagar'
,
35,
'N'
,
'N'
,
'N'
,
'INITIAL_PAYMENT'
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
'CC_SALES_FINANC_COND'
,
'INITIAL_PAYMENT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(3):=121128783;
RQTY_100261_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(3):=RQTY_100261_.tb2_0(3);
RQTY_100261_.old_tb2_1(3):='MO_INITATRIB_CT23E121128783'
;
RQTY_100261_.tb2_1(3):=RQTY_100261_.tb2_0(3);
RQTY_100261_.tb2_2(3):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(3),
RQTY_100261_.tb2_1(3),
RQTY_100261_.tb2_2(3),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSusc);nuSuscr = UT_CONVERT.FNUCHARTONUMBER(nuSusc);LD_BOSECUREMANAGEMENT.GETCATSUBBYSUSCRIPC(nuSuscr,nuCategory,nuSubcate);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_PROCESS","USE",nuCategory,GE_BOCONSTANTS.GETTRUE())'
,
'LBTEST'
,
to_date('24-10-2012 09:40:52','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializacion de la categoria del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb7_0(0):=120071852;
RQTY_100261_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100261_.tb7_0(0):=RQTY_100261_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100261_.tb7_0(0),
16,
'Usos'
,
'SELECT catecodi id,catedesc description FROM categori'
,
'Usos'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb8_0(0):=RQTY_100261_.tb7_0(0);
RQTY_100261_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ID</Name>
    <Description>ID</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPTION</Name>
    <Description>Descripci¿n</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
    <Entity>GE_SOCIOECO_STRATUM</Entity>
    <Column>DESCRIPTION</Column>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (0)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100261_.tb8_0(0),
null,
RQTY_100261_.clColumn_1,
null);

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(8):=106263;
RQTY_100261_.tb6_1(8):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(8):=68;
RQTY_100261_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(8),-1)));
RQTY_100261_.old_tb6_3(8):=440;
RQTY_100261_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(8),-1)));
RQTY_100261_.old_tb6_4(8):=null;
RQTY_100261_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(8),-1)));
RQTY_100261_.old_tb6_5(8):=null;
RQTY_100261_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(8),-1)));
RQTY_100261_.tb6_6(8):=RQTY_100261_.tb7_0(0);
RQTY_100261_.tb6_7(8):=RQTY_100261_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(8),
ENTITY_ID=RQTY_100261_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(8),
STATEMENT_ID=RQTY_100261_.tb6_6(8),
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=36,
DISPLAY_NAME='Categoria'
,
DISPLAY_ORDER=36,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='CATEGORIA'
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
ATTRI_TECHNICAL_NAME='USE'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(8),
RQTY_100261_.tb6_1(8),
RQTY_100261_.tb6_2(8),
RQTY_100261_.tb6_3(8),
RQTY_100261_.tb6_4(8),
RQTY_100261_.tb6_5(8),
RQTY_100261_.tb6_6(8),
RQTY_100261_.tb6_7(8),
null,
null,
36,
'Categoria'
,
36,
'N'
,
'N'
,
'Y'
,
'CATEGORIA'
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
'USE'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(4):=121128784;
RQTY_100261_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(4):=RQTY_100261_.tb2_0(4);
RQTY_100261_.old_tb2_1(4):='MO_INITATRIB_CT23E121128784'
;
RQTY_100261_.tb2_1(4):=RQTY_100261_.tb2_0(4);
RQTY_100261_.tb2_2(4):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(4),
RQTY_100261_.tb2_1(4),
RQTY_100261_.tb2_2(4),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSusc);nuSuscr = UT_CONVERT.FNUCHARTONUMBER(nuSusc);LD_BOSECUREMANAGEMENT.GETCATSUBBYSUSCRIPC(nuSuscr,nuCateg,nuSubca);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbinstace);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbinstace,null,"MO_PROCESS","STRATUM",nuSubca,GE_BOCONSTANTS.GETTRUE())'
,
'LBTEST'
,
to_date('24-10-2012 09:40:52','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializacion de la subcategoria del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb7_0(1):=120071853;
RQTY_100261_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100261_.tb7_0(1):=RQTY_100261_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100261_.tb7_0(1),
16,
'Estratos'
,
'SELECT sucacodi id,sucadesc description FROM subcateg WHERE sucacate = to_number(ge_boInstanceControl.fsbGetFieldValue('|| chr(39) ||'MO_PROCESS'|| chr(39) ||','|| chr(39) ||'USE'|| chr(39) ||'))'
,
'Estratos'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(9):=106264;
RQTY_100261_.tb6_1(9):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(9):=68;
RQTY_100261_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(9),-1)));
RQTY_100261_.old_tb6_3(9):=441;
RQTY_100261_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(9),-1)));
RQTY_100261_.old_tb6_4(9):=null;
RQTY_100261_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(9),-1)));
RQTY_100261_.old_tb6_5(9):=null;
RQTY_100261_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(9),-1)));
RQTY_100261_.tb6_6(9):=RQTY_100261_.tb7_0(1);
RQTY_100261_.tb6_7(9):=RQTY_100261_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(9),
ENTITY_ID=RQTY_100261_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(9),
STATEMENT_ID=RQTY_100261_.tb6_6(9),
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=37,
DISPLAY_NAME='Subcategoria'
,
DISPLAY_ORDER=37,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='SUBCATEGORIA'
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
ATTRI_TECHNICAL_NAME='STRATUM'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(9),
RQTY_100261_.tb6_1(9),
RQTY_100261_.tb6_2(9),
RQTY_100261_.tb6_3(9),
RQTY_100261_.tb6_4(9),
RQTY_100261_.tb6_5(9),
RQTY_100261_.tb6_6(9),
RQTY_100261_.tb6_7(9),
null,
null,
37,
'Subcategoria'
,
37,
'N'
,
'N'
,
'Y'
,
'SUBCATEGORIA'
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
'STRATUM'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(10):=106265;
RQTY_100261_.tb6_1(10):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(10):=68;
RQTY_100261_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(10),-1)));
RQTY_100261_.old_tb6_3(10):=1111;
RQTY_100261_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(10),-1)));
RQTY_100261_.old_tb6_4(10):=null;
RQTY_100261_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(10),-1)));
RQTY_100261_.old_tb6_5(10):=null;
RQTY_100261_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(10),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(10),
ENTITY_ID=RQTY_100261_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Id Contrato del producto'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='CONTRACT'
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
ATTRI_TECHNICAL_NAME='SUBSCRIPTION_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(10),
RQTY_100261_.tb6_1(10),
RQTY_100261_.tb6_2(10),
RQTY_100261_.tb6_3(10),
RQTY_100261_.tb6_4(10),
RQTY_100261_.tb6_5(10),
null,
null,
null,
null,
0,
'Id Contrato del producto'
,
0,
'N'
,
'N'
,
'N'
,
'CONTRACT'
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
'SUBSCRIPTION_ID'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(5):=121128785;
RQTY_100261_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(5):=RQTY_100261_.tb2_0(5);
RQTY_100261_.old_tb2_1(5):='MO_INITATRIB_CT23E121128785'
;
RQTY_100261_.tb2_1(5):=RQTY_100261_.tb2_0(5);
RQTY_100261_.tb2_2(5):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(5),
RQTY_100261_.tb2_1(5),
RQTY_100261_.tb2_2(5),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('23-10-2012 20:59:56','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(11):=106228;
RQTY_100261_.tb6_1(11):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(11):=17;
RQTY_100261_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(11),-1)));
RQTY_100261_.old_tb6_3(11):=257;
RQTY_100261_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(11),-1)));
RQTY_100261_.old_tb6_4(11):=null;
RQTY_100261_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(11),-1)));
RQTY_100261_.old_tb6_5(11):=null;
RQTY_100261_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(11),-1)));
RQTY_100261_.tb6_7(11):=RQTY_100261_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(11),
ENTITY_ID=RQTY_100261_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Interacción'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='INTERACCION'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(11),
RQTY_100261_.tb6_1(11),
RQTY_100261_.tb6_2(11),
RQTY_100261_.tb6_3(11),
RQTY_100261_.tb6_4(11),
RQTY_100261_.tb6_5(11),
null,
RQTY_100261_.tb6_7(11),
null,
null,
1,
'Interacción'
,
1,
'N'
,
'N'
,
'Y'
,
'INTERACCION'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(6):=121128786;
RQTY_100261_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(6):=RQTY_100261_.tb2_0(6);
RQTY_100261_.old_tb2_1(6):='MO_INITATRIB_CT23E121128786'
;
RQTY_100261_.tb2_1(6):=RQTY_100261_.tb2_0(6);
RQTY_100261_.tb2_2(6):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(6),
RQTY_100261_.tb2_1(6),
RQTY_100261_.tb2_2(6),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('23-10-2012 20:59:57','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb7_0(2):=120071854;
RQTY_100261_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100261_.tb7_0(2):=RQTY_100261_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100261_.tb7_0(2),
16,
'Lista Puntos de Atención SCL'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b, OR_operating_unit c
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')
AND a.organizat_area_id = c.orga_area_id
AND a.organizat_area_id = c.operating_unit_id
'
,
'Lista Puntos de Atención SCL'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(12):=106229;
RQTY_100261_.tb6_1(12):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(12):=17;
RQTY_100261_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(12),-1)));
RQTY_100261_.old_tb6_3(12):=109479;
RQTY_100261_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(12),-1)));
RQTY_100261_.old_tb6_4(12):=null;
RQTY_100261_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(12),-1)));
RQTY_100261_.old_tb6_5(12):=null;
RQTY_100261_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(12),-1)));
RQTY_100261_.tb6_6(12):=RQTY_100261_.tb7_0(2);
RQTY_100261_.tb6_7(12):=RQTY_100261_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(12),
ENTITY_ID=RQTY_100261_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(12),
STATEMENT_ID=RQTY_100261_.tb6_6(12),
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(12),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Punto de Atención'
,
DISPLAY_ORDER=4,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(12),
RQTY_100261_.tb6_1(12),
RQTY_100261_.tb6_2(12),
RQTY_100261_.tb6_3(12),
RQTY_100261_.tb6_4(12),
RQTY_100261_.tb6_5(12),
RQTY_100261_.tb6_6(12),
RQTY_100261_.tb6_7(12),
null,
null,
4,
'Punto de Atención'
,
4,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb1_0(2):=26;
RQTY_100261_.tb1_1(2):=RQTY_100261_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100261_.tb1_0(2),
MODULE_ID=RQTY_100261_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100261_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100261_.tb1_0(2),
RQTY_100261_.tb1_1(2),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(7):=121128787;
RQTY_100261_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(7):=RQTY_100261_.tb2_0(7);
RQTY_100261_.old_tb2_1(7):='MO_VALIDATTR_CT26E121128787'
;
RQTY_100261_.tb2_1(7):=RQTY_100261_.tb2_0(7);
RQTY_100261_.tb2_2(7):=RQTY_100261_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(7),
RQTY_100261_.tb2_1(7),
RQTY_100261_.tb2_2(7),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",null,"MO_PACKAGES","PACKAGE_NEW_ID",sbValue,TRUE)'
,
'LBTEST'
,
to_date('23-10-2012 20:59:58','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:23','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(13):=106230;
RQTY_100261_.tb6_1(13):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(13):=17;
RQTY_100261_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(13),-1)));
RQTY_100261_.old_tb6_3(13):=255;
RQTY_100261_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(13),-1)));
RQTY_100261_.old_tb6_4(13):=null;
RQTY_100261_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(13),-1)));
RQTY_100261_.old_tb6_5(13):=null;
RQTY_100261_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(13),-1)));
RQTY_100261_.tb6_8(13):=RQTY_100261_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(13),
ENTITY_ID=RQTY_100261_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100261_.tb6_8(13),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='N¿mero de Solicitud'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(13),
RQTY_100261_.tb6_1(13),
RQTY_100261_.tb6_2(13),
RQTY_100261_.tb6_3(13),
RQTY_100261_.tb6_4(13),
RQTY_100261_.tb6_5(13),
null,
null,
RQTY_100261_.tb6_8(13),
null,
2,
'N¿mero de Solicitud'
,
2,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(8):=121128788;
RQTY_100261_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(8):=RQTY_100261_.tb2_0(8);
RQTY_100261_.old_tb2_1(8):='MO_INITATRIB_CT23E121128788'
;
RQTY_100261_.tb2_1(8):=RQTY_100261_.tb2_0(8);
RQTY_100261_.tb2_2(8):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(8),
RQTY_100261_.tb2_1(8),
RQTY_100261_.tb2_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('23-10-2012 20:59:58','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb7_0(3):=120071855;
RQTY_100261_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100261_.tb7_0(3):=RQTY_100261_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100261_.tb7_0(3),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(14):=106231;
RQTY_100261_.tb6_1(14):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(14):=17;
RQTY_100261_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(14),-1)));
RQTY_100261_.old_tb6_3(14):=2683;
RQTY_100261_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(14),-1)));
RQTY_100261_.old_tb6_4(14):=null;
RQTY_100261_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(14),-1)));
RQTY_100261_.old_tb6_5(14):=null;
RQTY_100261_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(14),-1)));
RQTY_100261_.tb6_6(14):=RQTY_100261_.tb7_0(3);
RQTY_100261_.tb6_7(14):=RQTY_100261_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(14),
ENTITY_ID=RQTY_100261_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(14),
STATEMENT_ID=RQTY_100261_.tb6_6(14),
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Medio de recepción'
,
DISPLAY_ORDER=5,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(14),
RQTY_100261_.tb6_1(14),
RQTY_100261_.tb6_2(14),
RQTY_100261_.tb6_3(14),
RQTY_100261_.tb6_4(14),
RQTY_100261_.tb6_5(14),
RQTY_100261_.tb6_6(14),
RQTY_100261_.tb6_7(14),
null,
null,
5,
'Medio de recepción'
,
5,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(9):=121128789;
RQTY_100261_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(9):=RQTY_100261_.tb2_0(9);
RQTY_100261_.old_tb2_1(9):='MO_INITATRIB_CT23E121128789'
;
RQTY_100261_.tb2_1(9):=RQTY_100261_.tb2_0(9);
RQTY_100261_.tb2_2(9):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(9),
RQTY_100261_.tb2_1(9),
RQTY_100261_.tb2_2(9),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('23-10-2012 20:59:58','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(10):=121128790;
RQTY_100261_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(10):=RQTY_100261_.tb2_0(10);
RQTY_100261_.old_tb2_1(10):='MO_VALIDATTR_CT26E121128790'
;
RQTY_100261_.tb2_1(10):=RQTY_100261_.tb2_0(10);
RQTY_100261_.tb2_2(10):=RQTY_100261_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(10),
RQTY_100261_.tb2_1(10),
RQTY_100261_.tb2_2(10),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPersonId);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,Null,"MO_PACKAGES","POS_OPER_UNIT_ID",nuSaleChannel,True)'
,
'LBTEST'
,
to_date('23-10-2012 20:59:58','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb7_0(4):=120071856;
RQTY_100261_.tb7_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100261_.tb7_0(4):=RQTY_100261_.tb7_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100261_.tb7_0(4),
16,
'Listado de Vendedores SCL'
,
'SELECT   a.person_id ID, a.name_ DESCRIPTION FROM   GE_PERSON a'
,
'Listado de Vendedores SCL'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(15):=106232;
RQTY_100261_.tb6_1(15):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(15):=17;
RQTY_100261_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(15),-1)));
RQTY_100261_.old_tb6_3(15):=50001162;
RQTY_100261_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(15),-1)));
RQTY_100261_.old_tb6_4(15):=null;
RQTY_100261_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(15),-1)));
RQTY_100261_.old_tb6_5(15):=null;
RQTY_100261_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(15),-1)));
RQTY_100261_.tb6_6(15):=RQTY_100261_.tb7_0(4);
RQTY_100261_.tb6_7(15):=RQTY_100261_.tb2_0(9);
RQTY_100261_.tb6_8(15):=RQTY_100261_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(15),
ENTITY_ID=RQTY_100261_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(15),
STATEMENT_ID=RQTY_100261_.tb6_6(15),
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(15),
VALID_EXPRESSION_ID=RQTY_100261_.tb6_8(15),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Funcionario'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(15),
RQTY_100261_.tb6_1(15),
RQTY_100261_.tb6_2(15),
RQTY_100261_.tb6_3(15),
RQTY_100261_.tb6_4(15),
RQTY_100261_.tb6_5(15),
RQTY_100261_.tb6_6(15),
RQTY_100261_.tb6_7(15),
RQTY_100261_.tb6_8(15),
null,
3,
'Funcionario'
,
3,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(16):=106233;
RQTY_100261_.tb6_1(16):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(16):=17;
RQTY_100261_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(16),-1)));
RQTY_100261_.old_tb6_3(16):=146754;
RQTY_100261_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(16),-1)));
RQTY_100261_.old_tb6_4(16):=null;
RQTY_100261_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(16),-1)));
RQTY_100261_.old_tb6_5(16):=null;
RQTY_100261_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(16),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(16),
ENTITY_ID=RQTY_100261_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Observación'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(16),
RQTY_100261_.tb6_1(16),
RQTY_100261_.tb6_2(16),
RQTY_100261_.tb6_3(16),
RQTY_100261_.tb6_4(16),
RQTY_100261_.tb6_5(16),
null,
null,
null,
null,
6,
'Observación'
,
6,
'N'
,
'N'
,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(11):=121128791;
RQTY_100261_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(11):=RQTY_100261_.tb2_0(11);
RQTY_100261_.old_tb2_1(11):='MO_INITATRIB_CT23E121128791'
;
RQTY_100261_.tb2_1(11):=RQTY_100261_.tb2_0(11);
RQTY_100261_.tb2_2(11):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(11),
RQTY_100261_.tb2_1(11),
RQTY_100261_.tb2_2(11),
'CF_BOINITRULES.INIREQUESTDATE()'
,
'LBTEST'
,
to_date('23-10-2012 20:59:59','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(12):=121128792;
RQTY_100261_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(12):=RQTY_100261_.tb2_0(12);
RQTY_100261_.old_tb2_1(12):='MO_VALIDATTR_CT26E121128792'
;
RQTY_100261_.tb2_1(12):=RQTY_100261_.tb2_0(12);
RQTY_100261_.tb2_2(12):=RQTY_100261_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(12),
RQTY_100261_.tb2_1(12),
RQTY_100261_.tb2_2(12),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100261;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);nuMaxDaysParam = GE_BOPARAMETER.FNUGET("LD_MAX_DAYS_REGISTER", "N");if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No está permitido registrar una solicitud a futuro");,if (nuMaxDays <= nuMaxDaysParam,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > nuMaxDaysParam,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,););)'
,
'SAMUPACH'
,
to_date('05-04-2013 10:19:42','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Val - Fecha de Solicitud - Venta seguros XML'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(17):=106234;
RQTY_100261_.tb6_1(17):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(17):=17;
RQTY_100261_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(17),-1)));
RQTY_100261_.old_tb6_3(17):=258;
RQTY_100261_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(17),-1)));
RQTY_100261_.old_tb6_4(17):=null;
RQTY_100261_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(17),-1)));
RQTY_100261_.old_tb6_5(17):=null;
RQTY_100261_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(17),-1)));
RQTY_100261_.tb6_7(17):=RQTY_100261_.tb2_0(11);
RQTY_100261_.tb6_8(17):=RQTY_100261_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(17),
ENTITY_ID=RQTY_100261_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(17),
VALID_EXPRESSION_ID=RQTY_100261_.tb6_8(17),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Fecha de Solicitud'
,
DISPLAY_ORDER=7,
INCLUDED_VAL_DOC='N'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(17),
RQTY_100261_.tb6_1(17),
RQTY_100261_.tb6_2(17),
RQTY_100261_.tb6_3(17),
RQTY_100261_.tb6_4(17),
RQTY_100261_.tb6_5(17),
null,
RQTY_100261_.tb6_7(17),
RQTY_100261_.tb6_8(17),
null,
7,
'Fecha de Solicitud'
,
7,
'N'
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
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(13):=121128793;
RQTY_100261_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(13):=RQTY_100261_.tb2_0(13);
RQTY_100261_.old_tb2_1(13):='MO_INITATRIB_CT23E121128793'
;
RQTY_100261_.tb2_1(13):=RQTY_100261_.tb2_0(13);
RQTY_100261_.tb2_2(13):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(13),
RQTY_100261_.tb2_1(13),
RQTY_100261_.tb2_2(13),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'LBTEST'
,
to_date('23-10-2012 21:00:00','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - ADDRESS_ID - inicializaci¿n de la direcci¿n de respuesta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(18):=106235;
RQTY_100261_.tb6_1(18):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(18):=17;
RQTY_100261_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(18),-1)));
RQTY_100261_.old_tb6_3(18):=146756;
RQTY_100261_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(18),-1)));
RQTY_100261_.old_tb6_4(18):=null;
RQTY_100261_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(18),-1)));
RQTY_100261_.old_tb6_5(18):=null;
RQTY_100261_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(18),-1)));
RQTY_100261_.tb6_7(18):=RQTY_100261_.tb2_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(18),
ENTITY_ID=RQTY_100261_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(18),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Direcci¿n de Respuesta'
,
DISPLAY_ORDER=8,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(18),
RQTY_100261_.tb6_1(18),
RQTY_100261_.tb6_2(18),
RQTY_100261_.tb6_3(18),
RQTY_100261_.tb6_4(18),
RQTY_100261_.tb6_5(18),
null,
RQTY_100261_.tb6_7(18),
null,
null,
8,
'Direcci¿n de Respuesta'
,
8,
'N'
,
'N'
,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(14):=121128794;
RQTY_100261_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(14):=RQTY_100261_.tb2_0(14);
RQTY_100261_.old_tb2_1(14):='MO_INITATRIB_CT23E121128794'
;
RQTY_100261_.tb2_1(14):=RQTY_100261_.tb2_0(14);
RQTY_100261_.tb2_2(14):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(14),
RQTY_100261_.tb2_1(14),
RQTY_100261_.tb2_2(14),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('23-10-2012 21:00:00','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(19):=106236;
RQTY_100261_.tb6_1(19):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(19):=17;
RQTY_100261_.tb6_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(19),-1)));
RQTY_100261_.old_tb6_3(19):=146755;
RQTY_100261_.tb6_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(19),-1)));
RQTY_100261_.old_tb6_4(19):=null;
RQTY_100261_.tb6_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(19),-1)));
RQTY_100261_.old_tb6_5(19):=null;
RQTY_100261_.tb6_5(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(19),-1)));
RQTY_100261_.tb6_7(19):=RQTY_100261_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (19)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(19),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(19),
ENTITY_ID=RQTY_100261_.tb6_2(19),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(19),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(19),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(19),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Información del Solicitante'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(19);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(19),
RQTY_100261_.tb6_1(19),
RQTY_100261_.tb6_2(19),
RQTY_100261_.tb6_3(19),
RQTY_100261_.tb6_4(19),
RQTY_100261_.tb6_5(19),
null,
RQTY_100261_.tb6_7(19),
null,
null,
9,
'Información del Solicitante'
,
9,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(20):=106237;
RQTY_100261_.tb6_1(20):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(20):=17;
RQTY_100261_.tb6_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(20),-1)));
RQTY_100261_.old_tb6_3(20):=269;
RQTY_100261_.tb6_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(20),-1)));
RQTY_100261_.old_tb6_4(20):=null;
RQTY_100261_.tb6_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(20),-1)));
RQTY_100261_.old_tb6_5(20):=null;
RQTY_100261_.tb6_5(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(20),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (20)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(20),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(20),
ENTITY_ID=RQTY_100261_.tb6_2(20),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(20),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(20),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='C¿digo del Tipo de Paquete'
,
DISPLAY_ORDER=10,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(20);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(20),
RQTY_100261_.tb6_1(20),
RQTY_100261_.tb6_2(20),
RQTY_100261_.tb6_3(20),
RQTY_100261_.tb6_4(20),
RQTY_100261_.tb6_5(20),
null,
null,
null,
null,
10,
'C¿digo del Tipo de Paquete'
,
10,
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(21):=106238;
RQTY_100261_.tb6_1(21):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(21):=17;
RQTY_100261_.tb6_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(21),-1)));
RQTY_100261_.old_tb6_3(21):=109478;
RQTY_100261_.tb6_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(21),-1)));
RQTY_100261_.old_tb6_4(21):=null;
RQTY_100261_.tb6_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(21),-1)));
RQTY_100261_.old_tb6_5(21):=null;
RQTY_100261_.tb6_5(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(21),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (21)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(21),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(21),
ENTITY_ID=RQTY_100261_.tb6_2(21),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(21),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(21),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Unidad Operativa Del Vendedor'
,
DISPLAY_ORDER=11,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(21);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(21),
RQTY_100261_.tb6_1(21),
RQTY_100261_.tb6_2(21),
RQTY_100261_.tb6_3(21),
RQTY_100261_.tb6_4(21),
RQTY_100261_.tb6_5(21),
null,
null,
null,
null,
11,
'Unidad Operativa Del Vendedor'
,
11,
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(22):=106239;
RQTY_100261_.tb6_1(22):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(22):=17;
RQTY_100261_.tb6_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(22),-1)));
RQTY_100261_.old_tb6_3(22):=42118;
RQTY_100261_.tb6_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(22),-1)));
RQTY_100261_.old_tb6_4(22):=109479;
RQTY_100261_.tb6_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(22),-1)));
RQTY_100261_.old_tb6_5(22):=null;
RQTY_100261_.tb6_5(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(22),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (22)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(22),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(22),
ENTITY_ID=RQTY_100261_.tb6_2(22),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(22),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(22),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='C¿digo Canal De Ventas'
,
DISPLAY_ORDER=12,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(22);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(22),
RQTY_100261_.tb6_1(22),
RQTY_100261_.tb6_2(22),
RQTY_100261_.tb6_3(22),
RQTY_100261_.tb6_4(22),
RQTY_100261_.tb6_5(22),
null,
null,
null,
null,
12,
'C¿digo Canal De Ventas'
,
12,
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(15):=121128797;
RQTY_100261_.tb2_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(15):=RQTY_100261_.tb2_0(15);
RQTY_100261_.old_tb2_1(15):='MO_INITATRIB_CT23E121128797'
;
RQTY_100261_.tb2_1(15):=RQTY_100261_.tb2_0(15);
RQTY_100261_.tb2_2(15):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(15),
RQTY_100261_.tb2_1(15),
RQTY_100261_.tb2_2(15),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'LBTEST'
,
to_date('23-10-2012 21:00:01','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(23):=106240;
RQTY_100261_.tb6_1(23):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(23):=17;
RQTY_100261_.tb6_2(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(23),-1)));
RQTY_100261_.old_tb6_3(23):=259;
RQTY_100261_.tb6_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(23),-1)));
RQTY_100261_.old_tb6_4(23):=null;
RQTY_100261_.tb6_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(23),-1)));
RQTY_100261_.old_tb6_5(23):=null;
RQTY_100261_.tb6_5(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(23),-1)));
RQTY_100261_.tb6_7(23):=RQTY_100261_.tb2_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (23)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(23),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(23),
ENTITY_ID=RQTY_100261_.tb6_2(23),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(23),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(23),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(23),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Fecha de Env¿o'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(23);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(23),
RQTY_100261_.tb6_1(23),
RQTY_100261_.tb6_2(23),
RQTY_100261_.tb6_3(23),
RQTY_100261_.tb6_4(23),
RQTY_100261_.tb6_5(23),
null,
RQTY_100261_.tb6_7(23),
null,
null,
13,
'Fecha de Env¿o'
,
13,
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(24):=106241;
RQTY_100261_.tb6_1(24):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(24):=17;
RQTY_100261_.tb6_2(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(24),-1)));
RQTY_100261_.old_tb6_3(24):=11619;
RQTY_100261_.tb6_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(24),-1)));
RQTY_100261_.old_tb6_4(24):=null;
RQTY_100261_.tb6_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(24),-1)));
RQTY_100261_.old_tb6_5(24):=null;
RQTY_100261_.tb6_5(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(24),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (24)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(24),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(24),
ENTITY_ID=RQTY_100261_.tb6_2(24),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(24),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(24),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Privacidad Suscriptor'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PRIVACIDAD_SUSCRIPTOR'
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
ATTRI_TECHNICAL_NAME='CLIENT_PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(24);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(24),
RQTY_100261_.tb6_1(24),
RQTY_100261_.tb6_2(24),
RQTY_100261_.tb6_3(24),
RQTY_100261_.tb6_4(24),
RQTY_100261_.tb6_5(24),
null,
null,
null,
null,
14,
'Privacidad Suscriptor'
,
14,
'N'
,
'N'
,
'N'
,
'PRIVACIDAD_SUSCRIPTOR'
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
'CLIENT_PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(25):=106242;
RQTY_100261_.tb6_1(25):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(25):=17;
RQTY_100261_.tb6_2(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(25),-1)));
RQTY_100261_.old_tb6_3(25):=4015;
RQTY_100261_.tb6_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(25),-1)));
RQTY_100261_.old_tb6_4(25):=793;
RQTY_100261_.tb6_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(25),-1)));
RQTY_100261_.old_tb6_5(25):=null;
RQTY_100261_.tb6_5(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(25),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (25)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(25),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(25),
ENTITY_ID=RQTY_100261_.tb6_2(25),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(25),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(25),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Identificador del Cliente'
,
DISPLAY_ORDER=15,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(25);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(25),
RQTY_100261_.tb6_1(25),
RQTY_100261_.tb6_2(25),
RQTY_100261_.tb6_3(25),
RQTY_100261_.tb6_4(25),
RQTY_100261_.tb6_5(25),
null,
null,
null,
null,
15,
'Identificador del Cliente'
,
15,
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(16):=121128799;
RQTY_100261_.tb2_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(16):=RQTY_100261_.tb2_0(16);
RQTY_100261_.old_tb2_1(16):='MO_INITATRIB_CT23E121128799'
;
RQTY_100261_.tb2_1(16):=RQTY_100261_.tb2_0(16);
RQTY_100261_.tb2_2(16):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(16),
RQTY_100261_.tb2_1(16),
RQTY_100261_.tb2_2(16),
'nuSeq = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_ADDRESS", "SEQ_MO_ADDRESS");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSeq)'
,
'LBTEST'
,
to_date('23-10-2012 21:00:01','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Secuencia de mo_address'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(26):=106243;
RQTY_100261_.tb6_1(26):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(26):=21;
RQTY_100261_.tb6_2(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(26),-1)));
RQTY_100261_.old_tb6_3(26):=474;
RQTY_100261_.tb6_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(26),-1)));
RQTY_100261_.old_tb6_4(26):=null;
RQTY_100261_.tb6_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(26),-1)));
RQTY_100261_.old_tb6_5(26):=null;
RQTY_100261_.tb6_5(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(26),-1)));
RQTY_100261_.tb6_7(26):=RQTY_100261_.tb2_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (26)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(26),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(26),
ENTITY_ID=RQTY_100261_.tb6_2(26),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(26),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(26),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(26),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(26),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Código de la Dirección'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(26);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(26),
RQTY_100261_.tb6_1(26),
RQTY_100261_.tb6_2(26),
RQTY_100261_.tb6_3(26),
RQTY_100261_.tb6_4(26),
RQTY_100261_.tb6_5(26),
null,
RQTY_100261_.tb6_7(26),
null,
null,
16,
'Código de la Dirección'
,
16,
'N'
,
'N'
,
'N'
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
'MO_ADDRESS'
,
'ADDRESS_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(17):=121128800;
RQTY_100261_.tb2_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(17):=RQTY_100261_.tb2_0(17);
RQTY_100261_.old_tb2_1(17):='MO_INITATRIB_CT23E121128800'
;
RQTY_100261_.tb2_1(17):=RQTY_100261_.tb2_0(17);
RQTY_100261_.tb2_2(17):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(17),
RQTY_100261_.tb2_1(17),
RQTY_100261_.tb2_2(17),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSuscripc);nuSusc = UT_CONVERT.FNUCHARTONUMBER(nuSuscripc);LD_BOSECUREMANAGEMENT.GETADDRESSBYSUSC(nuSusc,onuAdd,onuGeo);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuAdd)'
,
'LBTEST'
,
to_date('24-10-2012 10:00:17','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializaci¿n de la ubicaci¿n geografica del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(27):=106244;
RQTY_100261_.tb6_1(27):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(27):=21;
RQTY_100261_.tb6_2(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(27),-1)));
RQTY_100261_.old_tb6_3(27):=11376;
RQTY_100261_.tb6_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(27),-1)));
RQTY_100261_.old_tb6_4(27):=null;
RQTY_100261_.tb6_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(27),-1)));
RQTY_100261_.old_tb6_5(27):=null;
RQTY_100261_.tb6_5(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(27),-1)));
RQTY_100261_.tb6_7(27):=RQTY_100261_.tb2_0(17);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (27)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(27),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(27),
ENTITY_ID=RQTY_100261_.tb6_2(27),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(27),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(27),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(27),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(27),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Direccion de instalación'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PARSER_ADDRESS_ID'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='PARSER_ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(27);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(27),
RQTY_100261_.tb6_1(27),
RQTY_100261_.tb6_2(27),
RQTY_100261_.tb6_3(27),
RQTY_100261_.tb6_4(27),
RQTY_100261_.tb6_5(27),
null,
RQTY_100261_.tb6_7(27),
null,
null,
17,
'Direccion de instalación'
,
17,
'N'
,
'N'
,
'N'
,
'PARSER_ADDRESS_ID'
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
'MO_ADDRESS'
,
'PARSER_ADDRESS_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(18):=121128801;
RQTY_100261_.tb2_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(18):=RQTY_100261_.tb2_0(18);
RQTY_100261_.old_tb2_1(18):='MO_INITATRIB_CT23E121128801'
;
RQTY_100261_.tb2_1(18):=RQTY_100261_.tb2_0(18);
RQTY_100261_.tb2_2(18):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(18),
RQTY_100261_.tb2_1(18),
RQTY_100261_.tb2_2(18),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSusc);LD_BOSECUREMANAGEMENT.GETADDRESS(nuSusc,onuValue);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuValue)'
,
'LBTEST'
,
to_date('24-10-2012 10:00:18','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializacion de la direcci¿n parseada del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(28):=106245;
RQTY_100261_.tb6_1(28):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(28):=21;
RQTY_100261_.tb6_2(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(28),-1)));
RQTY_100261_.old_tb6_3(28):=282;
RQTY_100261_.tb6_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(28),-1)));
RQTY_100261_.old_tb6_4(28):=null;
RQTY_100261_.tb6_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(28),-1)));
RQTY_100261_.old_tb6_5(28):=null;
RQTY_100261_.tb6_5(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(28),-1)));
RQTY_100261_.tb6_7(28):=RQTY_100261_.tb2_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (28)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(28),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(28),
ENTITY_ID=RQTY_100261_.tb6_2(28),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(28),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(28),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(28),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(28),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Dirección'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ADDRESS'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(28);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(28),
RQTY_100261_.tb6_1(28),
RQTY_100261_.tb6_2(28),
RQTY_100261_.tb6_3(28),
RQTY_100261_.tb6_4(28),
RQTY_100261_.tb6_5(28),
null,
RQTY_100261_.tb6_7(28),
null,
null,
18,
'Dirección'
,
18,
'N'
,
'N'
,
'N'
,
'ADDRESS'
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
'MO_ADDRESS'
,
'ADDRESS'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(19):=121128802;
RQTY_100261_.tb2_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(19):=RQTY_100261_.tb2_0(19);
RQTY_100261_.old_tb2_1(19):='MO_INITATRIB_CT23E121128802'
;
RQTY_100261_.tb2_1(19):=RQTY_100261_.tb2_0(19);
RQTY_100261_.tb2_2(19):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(19),
RQTY_100261_.tb2_1(19),
RQTY_100261_.tb2_2(19),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSuscripc);nuSusc = UT_CONVERT.FNUCHARTONUMBER(nuSuscripc);LD_BOSECUREMANAGEMENT.GETADDRESSBYSUSC(nuSusc,onuAdd,onuGeo);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuGeo)'
,
'LBTEST'
,
to_date('24-10-2012 09:40:48','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializacion de la ubicaci¿n geografica'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(29):=106246;
RQTY_100261_.tb6_1(29):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(29):=21;
RQTY_100261_.tb6_2(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(29),-1)));
RQTY_100261_.old_tb6_3(29):=475;
RQTY_100261_.tb6_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(29),-1)));
RQTY_100261_.old_tb6_4(29):=null;
RQTY_100261_.tb6_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(29),-1)));
RQTY_100261_.old_tb6_5(29):=null;
RQTY_100261_.tb6_5(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(29),-1)));
RQTY_100261_.tb6_7(29):=RQTY_100261_.tb2_0(19);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (29)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(29),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(29),
ENTITY_ID=RQTY_100261_.tb6_2(29),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(29),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(29),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(29),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(29),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=19,
DISPLAY_NAME='C´´odigo de la Ubicación Geográfica'
,
DISPLAY_ORDER=19,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
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
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='GEOGRAP_LOCATION_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(29);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(29),
RQTY_100261_.tb6_1(29),
RQTY_100261_.tb6_2(29),
RQTY_100261_.tb6_3(29),
RQTY_100261_.tb6_4(29),
RQTY_100261_.tb6_5(29),
null,
RQTY_100261_.tb6_7(29),
null,
null,
19,
'C´´odigo de la Ubicación Geográfica'
,
19,
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
'Y'
,
'Y'
,
'MO_ADDRESS'
,
'GEOGRAP_LOCATION_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(20):=121128803;
RQTY_100261_.tb2_0(20):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(20):=RQTY_100261_.tb2_0(20);
RQTY_100261_.old_tb2_1(20):='MO_INITATRIB_CT23E121128803'
;
RQTY_100261_.tb2_1(20):=RQTY_100261_.tb2_0(20);
RQTY_100261_.tb2_2(20):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (20)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(20),
RQTY_100261_.tb2_1(20),
RQTY_100261_.tb2_2(20),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'LBTEST'
,
to_date('23-10-2012 21:00:03','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:25','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicialización de is_address_main'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(30):=106247;
RQTY_100261_.tb6_1(30):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(30):=21;
RQTY_100261_.tb6_2(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(30),-1)));
RQTY_100261_.old_tb6_3(30):=2;
RQTY_100261_.tb6_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(30),-1)));
RQTY_100261_.old_tb6_4(30):=null;
RQTY_100261_.tb6_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(30),-1)));
RQTY_100261_.old_tb6_5(30):=null;
RQTY_100261_.tb6_5(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(30),-1)));
RQTY_100261_.tb6_7(30):=RQTY_100261_.tb2_0(20);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (30)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(30),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(30),
ENTITY_ID=RQTY_100261_.tb6_2(30),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(30),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(30),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(30),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(30),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=20,
DISPLAY_NAME='IS_ADDRESS_MAIN'
,
DISPLAY_ORDER=20,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IS_ADDRESS_MAIN'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='IS_ADDRESS_MAIN'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(30);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(30),
RQTY_100261_.tb6_1(30),
RQTY_100261_.tb6_2(30),
RQTY_100261_.tb6_3(30),
RQTY_100261_.tb6_4(30),
RQTY_100261_.tb6_5(30),
null,
RQTY_100261_.tb6_7(30),
null,
null,
20,
'IS_ADDRESS_MAIN'
,
20,
'N'
,
'N'
,
'N'
,
'IS_ADDRESS_MAIN'
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
'MO_ADDRESS'
,
'IS_ADDRESS_MAIN'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(31):=106248;
RQTY_100261_.tb6_1(31):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(31):=21;
RQTY_100261_.tb6_2(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(31),-1)));
RQTY_100261_.old_tb6_3(31):=39322;
RQTY_100261_.tb6_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(31),-1)));
RQTY_100261_.old_tb6_4(31):=255;
RQTY_100261_.tb6_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(31),-1)));
RQTY_100261_.old_tb6_5(31):=null;
RQTY_100261_.tb6_5(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(31),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (31)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(31),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(31),
ENTITY_ID=RQTY_100261_.tb6_2(31),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(31),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(31),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(31),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PACKAGE_ID'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(31);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(31),
RQTY_100261_.tb6_1(31),
RQTY_100261_.tb6_2(31),
RQTY_100261_.tb6_3(31),
RQTY_100261_.tb6_4(31),
RQTY_100261_.tb6_5(31),
null,
null,
null,
null,
21,
'Identificador De Solicitud'
,
21,
'N'
,
'N'
,
'N'
,
'PACKAGE_ID'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(21):=121128805;
RQTY_100261_.tb2_0(21):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(21):=RQTY_100261_.tb2_0(21);
RQTY_100261_.old_tb2_1(21):='MO_INITATRIB_CT23E121128805'
;
RQTY_100261_.tb2_1(21):=RQTY_100261_.tb2_0(21);
RQTY_100261_.tb2_2(21):=RQTY_100261_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (21)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(21),
RQTY_100261_.tb2_1(21),
RQTY_100261_.tb2_2(21),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("1")'
,
'LBTEST'
,
to_date('23-10-2012 21:00:03','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:25','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializaci¿n del tipo direcci¿m mo_address'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(32):=106249;
RQTY_100261_.tb6_1(32):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(32):=21;
RQTY_100261_.tb6_2(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(32),-1)));
RQTY_100261_.old_tb6_3(32):=476;
RQTY_100261_.tb6_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(32),-1)));
RQTY_100261_.old_tb6_4(32):=null;
RQTY_100261_.tb6_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(32),-1)));
RQTY_100261_.old_tb6_5(32):=null;
RQTY_100261_.tb6_5(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(32),-1)));
RQTY_100261_.tb6_7(32):=RQTY_100261_.tb2_0(21);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (32)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(32),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(32),
ENTITY_ID=RQTY_100261_.tb6_2(32),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(32),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(32),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(32),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100261_.tb6_7(32),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=22,
DISPLAY_NAME='C¿digo del Tipo Direcci¿n'
,
DISPLAY_ORDER=22,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ADDRESS_TYPE_ID'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(32);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(32),
RQTY_100261_.tb6_1(32),
RQTY_100261_.tb6_2(32),
RQTY_100261_.tb6_3(32),
RQTY_100261_.tb6_4(32),
RQTY_100261_.tb6_5(32),
null,
RQTY_100261_.tb6_7(32),
null,
null,
22,
'C¿digo del Tipo Direcci¿n'
,
22,
'N'
,
'N'
,
'N'
,
'ADDRESS_TYPE_ID'
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
'MO_ADDRESS'
,
'ADDRESS_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(33):=106250;
RQTY_100261_.tb6_1(33):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(33):=2640;
RQTY_100261_.tb6_2(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(33),-1)));
RQTY_100261_.old_tb6_3(33):=68342;
RQTY_100261_.tb6_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(33),-1)));
RQTY_100261_.old_tb6_4(33):=255;
RQTY_100261_.tb6_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(33),-1)));
RQTY_100261_.old_tb6_5(33):=null;
RQTY_100261_.tb6_5(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(33),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (33)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(33),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(33),
ENTITY_ID=RQTY_100261_.tb6_2(33),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(33),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(33),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(33),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Solicitud De Venta'
,
DISPLAY_ORDER=23,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PACKAGE_ID'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(33);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(33),
RQTY_100261_.tb6_1(33),
RQTY_100261_.tb6_2(33),
RQTY_100261_.tb6_3(33),
RQTY_100261_.tb6_4(33),
RQTY_100261_.tb6_5(33),
null,
null,
null,
null,
23,
'Solicitud De Venta'
,
23,
'N'
,
'N'
,
'N'
,
'PACKAGE_ID'
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
'CC_SALES_FINANC_COND'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb2_0(22):=121128807;
RQTY_100261_.tb2_0(22):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100261_.tb2_0(22):=RQTY_100261_.tb2_0(22);
RQTY_100261_.old_tb2_1(22):='MO_VALIDATTR_CT26E121128807'
;
RQTY_100261_.tb2_1(22):=RQTY_100261_.tb2_0(22);
RQTY_100261_.tb2_2(22):=RQTY_100261_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (22)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100261_.tb2_0(22),
RQTY_100261_.tb2_1(22),
RQTY_100261_.tb2_2(22),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPlanFin);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstace);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstace,null,"MO_PACKAGES","REQUEST_DATE",dtRequest);LD_BOSECUREMANAGEMENT.GETPLANDIFSALE(nuPlanFin,dtRequest,onuComputeMethod,onuInteresPercent,onuInterestRate,onuSpread,onuPercentFin,osbDocumentSuppport,odtFitsPay);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","COMPUTE_METHOD_ID",onuComputeMethod,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","INTEREST_PERCENT",onuInteresPercent,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","INTEREST_RATE_ID",onuInterestRate,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","SPREAD",onuSpread,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","PERCENT_TO_FINANCE",onuPercentFin,GE_BOCONST' ||
'ANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","DOCUMENT_SUPPORT",osbDocumentSuppport,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstace,null,"CC_SALES_FINANC_COND","FIRST_PAY_DATE",odtFitsPay,GE_BOCONSTANTS.GETTRUE())'
,
'LBTEST'
,
to_date('23-10-2012 21:00:04','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:25','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene los datos del plan de financiaci¿n'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.old_tb7_0(5):=120071860;
RQTY_100261_.tb7_0(5):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100261_.tb7_0(5):=RQTY_100261_.tb7_0(5);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (5)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100261_.tb7_0(5),
16,
'Plan de Financiación SCL'
,
'SELECT pldicodi ID, pldidesc DESCRIPTION
FROM plandife
WHERE ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||' , '|| chr(39) ||'REQUEST_DATE'|| chr(39) ||') between PLDIFEIN AND PLDIFEFI'
,
'Plan de Financiación SCL'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(34):=106251;
RQTY_100261_.tb6_1(34):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(34):=2640;
RQTY_100261_.tb6_2(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(34),-1)));
RQTY_100261_.old_tb6_3(34):=68343;
RQTY_100261_.tb6_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(34),-1)));
RQTY_100261_.old_tb6_4(34):=null;
RQTY_100261_.tb6_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(34),-1)));
RQTY_100261_.old_tb6_5(34):=null;
RQTY_100261_.tb6_5(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(34),-1)));
RQTY_100261_.tb6_6(34):=RQTY_100261_.tb7_0(5);
RQTY_100261_.tb6_8(34):=RQTY_100261_.tb2_0(22);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (34)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(34),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(34),
ENTITY_ID=RQTY_100261_.tb6_2(34),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(34),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(34),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(34),
STATEMENT_ID=RQTY_100261_.tb6_6(34),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100261_.tb6_8(34),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Plan De Financiación'
,
DISPLAY_ORDER=24,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FINANCING_PLAN_ID'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='FINANCING_PLAN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(34);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(34),
RQTY_100261_.tb6_1(34),
RQTY_100261_.tb6_2(34),
RQTY_100261_.tb6_3(34),
RQTY_100261_.tb6_4(34),
RQTY_100261_.tb6_5(34),
RQTY_100261_.tb6_6(34),
null,
RQTY_100261_.tb6_8(34),
null,
24,
'Plan De Financiación'
,
24,
'N'
,
'N'
,
'Y'
,
'FINANCING_PLAN_ID'
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
'CC_SALES_FINANC_COND'
,
'FINANCING_PLAN_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(35):=106252;
RQTY_100261_.tb6_1(35):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(35):=2640;
RQTY_100261_.tb6_2(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(35),-1)));
RQTY_100261_.old_tb6_3(35):=68350;
RQTY_100261_.tb6_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(35),-1)));
RQTY_100261_.old_tb6_4(35):=null;
RQTY_100261_.tb6_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(35),-1)));
RQTY_100261_.old_tb6_5(35):=null;
RQTY_100261_.tb6_5(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(35),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (35)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(35),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(35),
ENTITY_ID=RQTY_100261_.tb6_2(35),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(35),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(35),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(35),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=25,
DISPLAY_NAME='Número De Cuotas'
,
DISPLAY_ORDER=25,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='QUOTAS_NUMBER'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='QUOTAS_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(35);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(35),
RQTY_100261_.tb6_1(35),
RQTY_100261_.tb6_2(35),
RQTY_100261_.tb6_3(35),
RQTY_100261_.tb6_4(35),
RQTY_100261_.tb6_5(35),
null,
null,
null,
null,
25,
'Número De Cuotas'
,
25,
'N'
,
'N'
,
'N'
,
'QUOTAS_NUMBER'
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
'CC_SALES_FINANC_COND'
,
'QUOTAS_NUMBER'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(36):=106253;
RQTY_100261_.tb6_1(36):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(36):=2640;
RQTY_100261_.tb6_2(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(36),-1)));
RQTY_100261_.old_tb6_3(36):=68352;
RQTY_100261_.tb6_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(36),-1)));
RQTY_100261_.old_tb6_4(36):=null;
RQTY_100261_.tb6_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(36),-1)));
RQTY_100261_.old_tb6_5(36):=null;
RQTY_100261_.tb6_5(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(36),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (36)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(36),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(36),
ENTITY_ID=RQTY_100261_.tb6_2(36),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(36),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(36),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(36),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=26,
DISPLAY_NAME='Valor A Financiar'
,
DISPLAY_ORDER=26,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='VALUE_TO_FINANCE'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='VALUE_TO_FINANCE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(36);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(36),
RQTY_100261_.tb6_1(36),
RQTY_100261_.tb6_2(36),
RQTY_100261_.tb6_3(36),
RQTY_100261_.tb6_4(36),
RQTY_100261_.tb6_5(36),
null,
null,
null,
null,
26,
'Valor A Financiar'
,
26,
'N'
,
'N'
,
'N'
,
'VALUE_TO_FINANCE'
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
'CC_SALES_FINANC_COND'
,
'VALUE_TO_FINANCE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(37):=106254;
RQTY_100261_.tb6_1(37):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(37):=2640;
RQTY_100261_.tb6_2(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(37),-1)));
RQTY_100261_.old_tb6_3(37):=68344;
RQTY_100261_.tb6_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(37),-1)));
RQTY_100261_.old_tb6_4(37):=null;
RQTY_100261_.tb6_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(37),-1)));
RQTY_100261_.old_tb6_5(37):=null;
RQTY_100261_.tb6_5(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(37),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (37)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(37),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(37),
ENTITY_ID=RQTY_100261_.tb6_2(37),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(37),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(37),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(37),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=27,
DISPLAY_NAME='Método De Cálculo'
,
DISPLAY_ORDER=27,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='COMPUTE_METHOD_ID'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='COMPUTE_METHOD_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(37);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(37),
RQTY_100261_.tb6_1(37),
RQTY_100261_.tb6_2(37),
RQTY_100261_.tb6_3(37),
RQTY_100261_.tb6_4(37),
RQTY_100261_.tb6_5(37),
null,
null,
null,
null,
27,
'Método De Cálculo'
,
27,
'N'
,
'N'
,
'N'
,
'COMPUTE_METHOD_ID'
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
'CC_SALES_FINANC_COND'
,
'COMPUTE_METHOD_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb6_0(38):=106255;
RQTY_100261_.tb6_1(38):=RQTY_100261_.tb5_0(0);
RQTY_100261_.old_tb6_2(38):=2640;
RQTY_100261_.tb6_2(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100261_.TBENTITYNAME(NVL(RQTY_100261_.old_tb6_2(38),-1)));
RQTY_100261_.old_tb6_3(38):=68345;
RQTY_100261_.tb6_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_3(38),-1)));
RQTY_100261_.old_tb6_4(38):=null;
RQTY_100261_.tb6_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_4(38),-1)));
RQTY_100261_.old_tb6_5(38):=null;
RQTY_100261_.tb6_5(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100261_.TBENTITYATTRIBUTENAME(NVL(RQTY_100261_.old_tb6_5(38),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (38)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100261_.tb6_0(38),
PACKAGE_TYPE_ID=RQTY_100261_.tb6_1(38),
ENTITY_ID=RQTY_100261_.tb6_2(38),
ENTITY_ATTRIBUTE_ID=RQTY_100261_.tb6_3(38),
MIRROR_ENTI_ATTRIB=RQTY_100261_.tb6_4(38),
PARENT_ATTRIBUTE_ID=RQTY_100261_.tb6_5(38),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=28,
DISPLAY_NAME='C¿digo De La Tasa De Inter¿s'
,
DISPLAY_ORDER=28,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='INTEREST_RATE_ID'
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
ENTITY_NAME='CC_SALES_FINANC_COND'
,
ATTRI_TECHNICAL_NAME='INTEREST_RATE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100261_.tb6_0(38);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100261_.tb6_0(38),
RQTY_100261_.tb6_1(38),
RQTY_100261_.tb6_2(38),
RQTY_100261_.tb6_3(38),
RQTY_100261_.tb6_4(38),
RQTY_100261_.tb6_5(38),
null,
null,
null,
null,
28,
'C¿digo De La Tasa De Inter¿s'
,
28,
'N'
,
'N'
,
'N'
,
'INTEREST_RATE_ID'
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
'CC_SALES_FINANC_COND'
,
'INTEREST_RATE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb9_0(0):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100261_.tb9_0(0),
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
COMMENT_='Número máximo de días'
,
DISPLAY_NAME='Número máximo de días'

 WHERE ATTRIBUTE_ID = RQTY_100261_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100261_.tb9_0(0),
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
'Número máximo de días'
,
'Número máximo de días'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb10_0(0):=RQTY_100261_.tb5_0(0);
RQTY_100261_.tb10_1(0):=RQTY_100261_.tb9_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100261_.tb10_0(0),
RQTY_100261_.tb10_1(0),
'Número máximo de días'
,
'60'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb11_0(0):=10000000207;
RQTY_100261_.tb11_1(0):=RQTY_100261_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100261_.tb11_0(0),
PACKAGE_TYPE_ID=RQTY_100261_.tb11_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=150040,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100261_.tb11_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100261_.tb11_0(0),
RQTY_100261_.tb11_1(0),
null,
null,
150040,
21);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb12_0(0):=150004;
RQTY_100261_.tb12_1(0):=RQTY_100261_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100261_.tb12_0(0),
VALUE_1=RQTY_100261_.tb12_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=150040,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Venta Seguros XML'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100261_.tb12_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100261_.tb12_0(0),
RQTY_100261_.tb12_1(0),
null,
21,
150040,
0,
31536000,
0,
'Venta Seguros XML'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb13_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100261_.tb13_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb14_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100261_.tb14_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb15_0(0):=7053;
RQTY_100261_.tb15_2(0):=RQTY_100261_.tb13_0(0);
RQTY_100261_.tb15_3(0):=RQTY_100261_.tb14_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100261_.tb15_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100261_.tb15_2(0),
SERVSETI=RQTY_100261_.tb15_3(0),
SERVDESC='Brilla Seguros'
,
SERVCOEX='7053'
,
SERVFLST='N'
,
SERVFLBA='N'
,
SERVFLAC='S'
,
SERVFLIM='N'
,
SERVPRRE=3,
SERVFLFR=null,
SERVFLRE=null,
SERVAPFR=null,
SERVVAAF=null,
SERVFLPC='N'
,
SERVTECO=null,
SERVFLFI=null,
SERVNVEC=null,
SERVLIQU='S'
,
SERVNPRC=null,
SERVORLE=0,
SERVREUB='N'
,
SERVCEDI='N'
,
SERVTXML='PR_BRILLA_SEGURO_7053'
,
SERVASAU='N'
,
SERVPRFI='N'
,
SERVCOLC='N'
,
SERVTICO='V'
,
SERVDIMI=0
 WHERE SERVCODI = RQTY_100261_.tb15_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100261_.tb15_0(0),
null,
RQTY_100261_.tb15_2(0),
RQTY_100261_.tb15_3(0),
'Brilla Seguros'
,
'7053'
,
'N'
,
'N'
,
'S'
,
'N'
,
3,
null,
null,
null,
null,
'N'
,
null,
null,
null,
'S'
,
null,
0,
'N'
,
'N'
,
'PR_BRILLA_SEGURO_7053'
,
'N'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb16_0(0):=8;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100261_.tb16_0(0),
CLASS_REGISTER_ID=4,
DESCRIPTION='INSTALACIÓN'
,
ASSIGNABLE='Y'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_INSTALACION'
,
ACTIVITY_TYPE='I'

 WHERE MOTIVE_TYPE_ID = RQTY_100261_.tb16_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100261_.tb16_0(0),
4,
'INSTALACIÓN'
,
'Y'
,
'Y'
,
'MOTY_INSTALACION'
,
'I'
);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb17_0(0):=100268;
RQTY_100261_.tb17_1(0):=RQTY_100261_.tb15_0(0);
RQTY_100261_.tb17_2(0):=RQTY_100261_.tb16_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100261_.tb17_0(0),
RQTY_100261_.tb17_1(0),
RQTY_100261_.tb17_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DEBRILLA_SEGUROS_100268'
,
'Venta de Brilla Seguros'
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
RQTY_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;

RQTY_100261_.tb18_0(0):=100268;
RQTY_100261_.tb18_1(0):=RQTY_100261_.tb17_0(0);
RQTY_100261_.tb18_3(0):=RQTY_100261_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100261_.tb18_0(0),
PRODUCT_MOTIVE_ID=RQTY_100261_.tb18_1(0),
PRODUCT_TYPE_ID=7053,
PACKAGE_TYPE_ID=RQTY_100261_.tb18_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100261_.tb18_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100261_.tb18_0(0),
RQTY_100261_.tb18_1(0),
7053,
RQTY_100261_.tb18_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100261_.blProcessStatus := false;
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
nuIndex := RQTY_100261_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100261_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100261_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100261_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100261_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100261_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100261_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100261_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100261_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100261_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100261_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100261_.blProcessStatus := false;
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
 nuIndex := RQTY_100261_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100261_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100261_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100261_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100261_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100261_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100261_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100261_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100261_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100261_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100261_',
'CREATE OR REPLACE PACKAGE RQPMT_100261_ IS ' || chr(10) ||
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
'tb5_0 ty5_0;type ty6_0 is table of GE_STATEMENT_COLUMNS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of PS_COMPONENT_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty9_0 is table of PS_PROD_MOTIVE_COMP.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of PS_PROD_MOTIVE_COMP.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty9_2 is table of PS_PROD_MOTIVE_COMP.PARENT_COMP%type index by binary_integer; ' || chr(10) ||
'old_tb9_2 ty9_2; ' || chr(10) ||
'tb9_2 ty9_2;type ty9_4 is table of PS_PROD_MOTIVE_COMP.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_4 ty9_4; ' || chr(10) ||
'tb9_4 ty9_4;type ty10_0 is table of PS_MOTI_COMP_ATTRIBS.MOTI_COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty10_3 is table of PS_MOTI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb10_3 ty10_3; ' || chr(10) ||
'tb10_3 ty10_3;type ty10_4 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_4 ty10_4; ' || chr(10) ||
'tb10_4 ty10_4;type ty10_5 is table of PS_MOTI_COMP_ATTRIBS.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_5 ty10_5; ' || chr(10) ||
'tb10_5 ty10_5;type ty10_6 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_6 ty10_6; ' || chr(10) ||
'tb10_6 ty10_6;type ty10_7 is table of PS_MOTI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_7 ty10_7; ' || chr(10) ||
'tb10_7 ty10_7;type ty10_8 is table of PS_MOTI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_8 ty10_8; ' || chr(10) ||
'tb10_8 ty10_8;type ty10_9 is table of PS_MOTI_COMP_ATTRIBS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_9 ty10_9; ' || chr(10) ||
'tb10_9 ty10_9;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 100261; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100261 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100261 ' || chr(10) ||
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
'END RQPMT_100261_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100261_******************************'); END;
/

BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100261_.cuExpressions;
fetch RQPMT_100261_.cuExpressions bulk collect INTO RQPMT_100261_.tbExpressionsId;
close RQPMT_100261_.cuExpressions;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100261_.tbEntityName(-1) := 'NULL';
   RQPMT_100261_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90013152) := 'LD_SECURE_SALE@CAUSAL_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQPMT_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100261_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009661) := 'LD_SECURE_SALE@BORN_DATE';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100261_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009663) := 'LD_SECURE_SALE@POLICY_NUMBER';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009662) := 'LD_SECURE_SALE@POLICY_TYPE_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009660) := 'LD_SECURE_SALE@PRODUCT_LINE_ID';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009664) := 'LD_SECURE_SALE@POLICY_VALUE';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009659) := 'LD_SECURE_SALE@ID_CONTRATISTA';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009658) := 'LD_SECURE_SALE@SECURE_SALE_ID';
   RQPMT_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQPMT_100261_.tbEntityAttributeName(90009665) := 'LD_SECURE_SALE@IDENTIFICATION_ID';
   RQPMT_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100261_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQPMT_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100261_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100261_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100261_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100261
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
WHERE PACKAGE_type_id = 100261
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
WHERE PACKAGE_type_id = 100261
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
WHERE PACKAGE_type_id = 100261
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
WHERE PACKAGE_type_id = 100261
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
WHERE PACKAGE_type_id = 100261
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100261_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100261
))));

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100261_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100261_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100261_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100261_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100261
))));

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100261
))));

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100261_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100261_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100261
)))));

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100261_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100261_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100261_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100261_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100261_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100261_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100261
))));

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
))));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100261
))));

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
)));
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100261_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100261_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100261_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100261_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100261_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100261_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100261_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100261
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb0_0(0):=100268;
RQPMT_100261_.tb0_1(0):=7053;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100261_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100261_.tb0_1(0),
MOTIVE_TYPE_ID=8,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_INSTALACION_DEBRILLA_SEGUROS_100268'
,
DESCRIPTION='Venta de Brilla Seguros'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100261_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100261_.tb0_0(0),
RQPMT_100261_.tb0_1(0),
8,
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DEBRILLA_SEGUROS_100268'
,
'Venta de Brilla Seguros'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(0):=103759;
RQPMT_100261_.old_tb1_1(0):=8;
RQPMT_100261_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(0),-1)));
RQPMT_100261_.old_tb1_2(0):=147336;
RQPMT_100261_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(0),-1)));
RQPMT_100261_.old_tb1_3(0):=440;
RQPMT_100261_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(0),-1)));
RQPMT_100261_.old_tb1_4(0):=null;
RQPMT_100261_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(0),-1)));
RQPMT_100261_.tb1_9(0):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(0),
ENTITY_ID=RQPMT_100261_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(0),
PROCESS_SEQUENCE=30,
DISPLAY_NAME='Categoría'
,
DISPLAY_ORDER=30,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='CATEGORY_ID'
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
ATTRI_TECHNICAL_NAME='CATEGORY_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(0),
RQPMT_100261_.tb1_1(0),
RQPMT_100261_.tb1_2(0),
RQPMT_100261_.tb1_3(0),
RQPMT_100261_.tb1_4(0),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(0),
30,
'Categoría'
,
30,
'N'
,
'N'
,
'N'
,
'N'
,
'CATEGORY_ID'
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
'CATEGORY_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(1):=103760;
RQPMT_100261_.old_tb1_1(1):=8;
RQPMT_100261_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(1),-1)));
RQPMT_100261_.old_tb1_2(1):=147337;
RQPMT_100261_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(1),-1)));
RQPMT_100261_.old_tb1_3(1):=441;
RQPMT_100261_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(1),-1)));
RQPMT_100261_.old_tb1_4(1):=null;
RQPMT_100261_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(1),-1)));
RQPMT_100261_.tb1_9(1):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(1),
ENTITY_ID=RQPMT_100261_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(1),
PROCESS_SEQUENCE=31,
DISPLAY_NAME='Subcategoría'
,
DISPLAY_ORDER=31,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='SUBCATEGORY_ID'
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
ATTRI_TECHNICAL_NAME='SUBCATEGORY_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(1),
RQPMT_100261_.tb1_1(1),
RQPMT_100261_.tb1_2(1),
RQPMT_100261_.tb1_3(1),
RQPMT_100261_.tb1_4(1),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(1),
31,
'Subcategoría'
,
31,
'N'
,
'N'
,
'N'
,
'N'
,
'SUBCATEGORY_ID'
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
'SUBCATEGORY_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(2):=103802;
RQPMT_100261_.old_tb1_1(2):=8;
RQPMT_100261_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(2),-1)));
RQPMT_100261_.old_tb1_2(2):=220;
RQPMT_100261_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(2),-1)));
RQPMT_100261_.old_tb1_3(2):=null;
RQPMT_100261_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(2),-1)));
RQPMT_100261_.old_tb1_4(2):=null;
RQPMT_100261_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(2),-1)));
RQPMT_100261_.tb1_9(2):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(2),
ENTITY_ID=RQPMT_100261_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(2),
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Identificador de Distribución Administrativa'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME=null,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(2),
RQPMT_100261_.tb1_1(2),
RQPMT_100261_.tb1_2(2),
RQPMT_100261_.tb1_3(2),
RQPMT_100261_.tb1_4(2),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(2),
21,
'Identificador de Distribución Administrativa'
,
21,
'N'
,
'N'
,
'N'
,
'N'
,
null,
'N'
,
1,
'M'
,
'N'
,
'N'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(3):=103803;
RQPMT_100261_.old_tb1_1(3):=8;
RQPMT_100261_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(3),-1)));
RQPMT_100261_.old_tb1_2(3):=524;
RQPMT_100261_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(3),-1)));
RQPMT_100261_.old_tb1_3(3):=null;
RQPMT_100261_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(3),-1)));
RQPMT_100261_.old_tb1_4(3):=null;
RQPMT_100261_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(3),-1)));
RQPMT_100261_.tb1_9(3):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(3),
ENTITY_ID=RQPMT_100261_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(3),
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Estado del Motivo'
,
DISPLAY_ORDER=22,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(3),
RQPMT_100261_.tb1_1(3),
RQPMT_100261_.tb1_2(3),
RQPMT_100261_.tb1_3(3),
RQPMT_100261_.tb1_4(3),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(3),
22,
'Estado del Motivo'
,
22,
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(4):=103804;
RQPMT_100261_.old_tb1_1(4):=8;
RQPMT_100261_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(4),-1)));
RQPMT_100261_.old_tb1_2(4):=191;
RQPMT_100261_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(4),-1)));
RQPMT_100261_.old_tb1_3(4):=null;
RQPMT_100261_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(4),-1)));
RQPMT_100261_.old_tb1_4(4):=null;
RQPMT_100261_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(4),-1)));
RQPMT_100261_.tb1_9(4):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(4),
ENTITY_ID=RQPMT_100261_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(4),
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Identificador del Tipo de Motivo'
,
DISPLAY_ORDER=23,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(4),
RQPMT_100261_.tb1_1(4),
RQPMT_100261_.tb1_2(4),
RQPMT_100261_.tb1_3(4),
RQPMT_100261_.tb1_4(4),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(4),
23,
'Identificador del Tipo de Motivo'
,
23,
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(5):=103805;
RQPMT_100261_.old_tb1_1(5):=8;
RQPMT_100261_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(5),-1)));
RQPMT_100261_.old_tb1_2(5):=192;
RQPMT_100261_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(5),-1)));
RQPMT_100261_.old_tb1_3(5):=null;
RQPMT_100261_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(5),-1)));
RQPMT_100261_.old_tb1_4(5):=null;
RQPMT_100261_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(5),-1)));
RQPMT_100261_.tb1_9(5):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(5),
ENTITY_ID=RQPMT_100261_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(5),
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Identificador del Tipo de Producto'
,
DISPLAY_ORDER=24,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(5),
RQPMT_100261_.tb1_1(5),
RQPMT_100261_.tb1_2(5),
RQPMT_100261_.tb1_3(5),
RQPMT_100261_.tb1_4(5),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(5),
24,
'Identificador del Tipo de Producto'
,
24,
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(6):=103806;
RQPMT_100261_.old_tb1_1(6):=8;
RQPMT_100261_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(6),-1)));
RQPMT_100261_.old_tb1_2(6):=4011;
RQPMT_100261_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(6),-1)));
RQPMT_100261_.old_tb1_3(6):=null;
RQPMT_100261_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(6),-1)));
RQPMT_100261_.old_tb1_4(6):=null;
RQPMT_100261_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(6),-1)));
RQPMT_100261_.tb1_9(6):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(6),
ENTITY_ID=RQPMT_100261_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(6),
PROCESS_SEQUENCE=25,
DISPLAY_NAME='Número del Servicio'
,
DISPLAY_ORDER=25,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='NUMERO_DEL_SERVICIO'
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
ATTRI_TECHNICAL_NAME='SERVICE_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(6),
RQPMT_100261_.tb1_1(6),
RQPMT_100261_.tb1_2(6),
RQPMT_100261_.tb1_3(6),
RQPMT_100261_.tb1_4(6),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(6),
25,
'Número del Servicio'
,
25,
'N'
,
'N'
,
'N'
,
'Y'
,
'NUMERO_DEL_SERVICIO'
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
'SERVICE_NUMBER'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100261_.tb2_0(0),
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

 WHERE MODULE_ID = RQPMT_100261_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100261_.tb2_0(0),
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb3_0(0):=23;
RQPMT_100261_.tb3_1(0):=RQPMT_100261_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100261_.tb3_0(0),
MODULE_ID=RQPMT_100261_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100261_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100261_.tb3_0(0),
RQPMT_100261_.tb3_1(0),
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(0):=121128840;
RQPMT_100261_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(0):=RQPMT_100261_.tb4_0(0);
RQPMT_100261_.old_tb4_1(0):='MO_INITATRIB_CT23E121128840'
;
RQPMT_100261_.tb4_1(0):=RQPMT_100261_.tb4_0(0);
RQPMT_100261_.tb4_2(0):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(0),
RQPMT_100261_.tb4_1(0),
RQPMT_100261_.tb4_2(0),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbSubscription);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbSubscription)'
,
'LBTEST'
,
to_date('05-10-2012 11:19:08','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - SUBSCRIPTION_ID - Inicializa el identificador del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(7):=103807;
RQPMT_100261_.old_tb1_1(7):=8;
RQPMT_100261_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(7),-1)));
RQPMT_100261_.old_tb1_2(7):=11403;
RQPMT_100261_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(7),-1)));
RQPMT_100261_.old_tb1_3(7):=null;
RQPMT_100261_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(7),-1)));
RQPMT_100261_.old_tb1_4(7):=null;
RQPMT_100261_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(7),-1)));
RQPMT_100261_.tb1_6(7):=RQPMT_100261_.tb4_0(0);
RQPMT_100261_.tb1_9(7):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(7),
ENTITY_ID=RQPMT_100261_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(7),
PROCESS_SEQUENCE=26,
DISPLAY_NAME='Identificador de la Suscripción'
,
DISPLAY_ORDER=26,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DE_LA_SUSCRIPCION'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(7),
RQPMT_100261_.tb1_1(7),
RQPMT_100261_.tb1_2(7),
RQPMT_100261_.tb1_3(7),
RQPMT_100261_.tb1_4(7),
null,
RQPMT_100261_.tb1_6(7),
null,
null,
RQPMT_100261_.tb1_9(7),
26,
'Identificador de la Suscripción'
,
26,
'N'
,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DE_LA_SUSCRIPCION'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(8):=103808;
RQPMT_100261_.old_tb1_1(8):=8;
RQPMT_100261_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(8),-1)));
RQPMT_100261_.old_tb1_2(8):=6683;
RQPMT_100261_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(8),-1)));
RQPMT_100261_.old_tb1_3(8):=null;
RQPMT_100261_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(8),-1)));
RQPMT_100261_.old_tb1_4(8):=null;
RQPMT_100261_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(8),-1)));
RQPMT_100261_.tb1_9(8):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(8),
ENTITY_ID=RQPMT_100261_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(8),
PROCESS_SEQUENCE=27,
DISPLAY_NAME='CLIENT_PRIVACY_FLAG'
,
DISPLAY_ORDER=27,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME=null,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='CLIENT_PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(8),
RQPMT_100261_.tb1_1(8),
RQPMT_100261_.tb1_2(8),
RQPMT_100261_.tb1_3(8),
RQPMT_100261_.tb1_4(8),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(8),
27,
'CLIENT_PRIVACY_FLAG'
,
27,
'N'
,
'N'
,
'N'
,
'N'
,
null,
'N'
,
1,
'M'
,
'N'
,
'N'
,
'Y'
,
'MO_MOTIVE'
,
'CLIENT_PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(1):=121128841;
RQPMT_100261_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(1):=RQPMT_100261_.tb4_0(1);
RQPMT_100261_.old_tb4_1(1):='MO_INITATRIB_CT23E121128841'
;
RQPMT_100261_.tb4_1(1):=RQPMT_100261_.tb4_0(1);
RQPMT_100261_.tb4_2(1):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(1),
RQPMT_100261_.tb4_1(1),
RQPMT_100261_.tb4_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(0)'
,
'LBTEST'
,
to_date('05-10-2012 11:19:09','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - Valor a Cobrar - Vta Serv ingenieria'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(9):=103809;
RQPMT_100261_.old_tb1_1(9):=8;
RQPMT_100261_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(9),-1)));
RQPMT_100261_.old_tb1_2(9):=20362;
RQPMT_100261_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(9),-1)));
RQPMT_100261_.old_tb1_3(9):=null;
RQPMT_100261_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(9),-1)));
RQPMT_100261_.old_tb1_4(9):=null;
RQPMT_100261_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(9),-1)));
RQPMT_100261_.tb1_6(9):=RQPMT_100261_.tb4_0(1);
RQPMT_100261_.tb1_9(9):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(9),
ENTITY_ID=RQPMT_100261_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(9),
PROCESS_SEQUENCE=28,
DISPLAY_NAME='Valor a cobrar'
,
DISPLAY_ORDER=28,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='VALUE_TO_DEBIT'
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
ATTRI_TECHNICAL_NAME='VALUE_TO_DEBIT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(9),
RQPMT_100261_.tb1_1(9),
RQPMT_100261_.tb1_2(9),
RQPMT_100261_.tb1_3(9),
RQPMT_100261_.tb1_4(9),
null,
RQPMT_100261_.tb1_6(9),
null,
null,
RQPMT_100261_.tb1_9(9),
28,
'Valor a cobrar'
,
28,
'N'
,
'N'
,
'N'
,
'N'
,
'VALUE_TO_DEBIT'
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
'VALUE_TO_DEBIT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(2):=121128842;
RQPMT_100261_.tb4_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(2):=RQPMT_100261_.tb4_0(2);
RQPMT_100261_.old_tb4_1(2):='MO_INITATRIB_CT23E121128842'
;
RQPMT_100261_.tb4_1(2):=RQPMT_100261_.tb4_0(2);
RQPMT_100261_.tb4_2(2):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(2),
RQPMT_100261_.tb4_1(2),
RQPMT_100261_.tb4_2(2),
'LD_BOFLOWFNBPACK.GETLDPARAMATER("COD_COMERCIAL_PLAN","N",sbCommercialPlanId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbCommercialPlanId)'
,
'OPEN'
,
to_date('17-12-2013 20:10:44','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - COMMERCIAL_PLAN_ID - Inicializa el plan comercial'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(10):=103810;
RQPMT_100261_.old_tb1_1(10):=8;
RQPMT_100261_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(10),-1)));
RQPMT_100261_.old_tb1_2(10):=45189;
RQPMT_100261_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(10),-1)));
RQPMT_100261_.old_tb1_3(10):=null;
RQPMT_100261_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(10),-1)));
RQPMT_100261_.old_tb1_4(10):=null;
RQPMT_100261_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(10),-1)));
RQPMT_100261_.tb1_6(10):=RQPMT_100261_.tb4_0(2);
RQPMT_100261_.tb1_9(10):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(10),
ENTITY_ID=RQPMT_100261_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(10),
PROCESS_SEQUENCE=29,
DISPLAY_NAME='Identificador Plan Comercial'
,
DISPLAY_ORDER=29,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='COMMERCIAL_PLAN_ID'
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
ATTRI_TECHNICAL_NAME='COMMERCIAL_PLAN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(10),
RQPMT_100261_.tb1_1(10),
RQPMT_100261_.tb1_2(10),
RQPMT_100261_.tb1_3(10),
RQPMT_100261_.tb1_4(10),
null,
RQPMT_100261_.tb1_6(10),
null,
null,
RQPMT_100261_.tb1_9(10),
29,
'Identificador Plan Comercial'
,
29,
'N'
,
'N'
,
'N'
,
'N'
,
'COMMERCIAL_PLAN_ID'
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
'COMMERCIAL_PLAN_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(11):=103198;
RQPMT_100261_.old_tb1_1(11):=8006;
RQPMT_100261_.tb1_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(11),-1)));
RQPMT_100261_.old_tb1_2(11):=90013152;
RQPMT_100261_.tb1_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(11),-1)));
RQPMT_100261_.old_tb1_3(11):=null;
RQPMT_100261_.tb1_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(11),-1)));
RQPMT_100261_.old_tb1_4(11):=null;
RQPMT_100261_.tb1_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(11),-1)));
RQPMT_100261_.tb1_9(11):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(11),
ENTITY_ID=RQPMT_100261_.tb1_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(11),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Causal de cumplimiento o incumplimiento'
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
TAG_NAME='CAUSAL_DE_CUMPLIMIENTO_O_INCUMPLIMIENTO'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='CAUSAL_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(11),
RQPMT_100261_.tb1_1(11),
RQPMT_100261_.tb1_2(11),
RQPMT_100261_.tb1_3(11),
RQPMT_100261_.tb1_4(11),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(11),
4,
'Causal de cumplimiento o incumplimiento'
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
'CAUSAL_DE_CUMPLIMIENTO_O_INCUMPLIMIENTO'
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
'LD_SECURE_SALE'
,
'CAUSAL_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(12):=103782;
RQPMT_100261_.old_tb1_1(12):=8006;
RQPMT_100261_.tb1_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(12),-1)));
RQPMT_100261_.old_tb1_2(12):=90009658;
RQPMT_100261_.tb1_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(12),-1)));
RQPMT_100261_.old_tb1_3(12):=255;
RQPMT_100261_.tb1_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(12),-1)));
RQPMT_100261_.old_tb1_4(12):=null;
RQPMT_100261_.tb1_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(12),-1)));
RQPMT_100261_.tb1_9(12):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(12),
ENTITY_ID=RQPMT_100261_.tb1_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(12),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='C¿digo de la solicitud'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='C_DIGO_DE_LA_SOLICITUD'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='SECURE_SALE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(12),
RQPMT_100261_.tb1_1(12),
RQPMT_100261_.tb1_2(12),
RQPMT_100261_.tb1_3(12),
RQPMT_100261_.tb1_4(12),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(12),
0,
'C¿digo de la solicitud'
,
0,
'N'
,
'N'
,
'N'
,
'N'
,
'C_DIGO_DE_LA_SOLICITUD'
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
'LD_SECURE_SALE'
,
'SECURE_SALE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb5_0(0):=120071873;
RQPMT_100261_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100261_.tb5_0(0):=RQPMT_100261_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100261_.tb5_0(0),
16,
'Sentencia de contratista'
,
'select /*+ index (ge_contratista PK_GE_CONTRATISTA)*/ id_contratista id,nombre_contratista description from ge_contratista order by id_contratista
'
,
'Sentencia de contratista Tramite Venta de Seguros'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb6_0(0):=RQPMT_100261_.tb5_0(0);
RQPMT_100261_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ID</Name>
    <Description>ID</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPTION</Name>
    <Description>DESCRIPTION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT_COLUMNS fila (0)',1);
UPDATE GE_STATEMENT_COLUMNS SET STATEMENT_ID=RQPMT_100261_.tb6_0(0),
WIZARD_COLUMNS=null,
SELECT_COLUMNS=RQPMT_100261_.clColumn_1,
LIST_VALUES=null
 WHERE STATEMENT_ID = RQPMT_100261_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQPMT_100261_.tb6_0(0),
null,
RQPMT_100261_.clColumn_1,
null);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(13):=103783;
RQPMT_100261_.old_tb1_1(13):=8006;
RQPMT_100261_.tb1_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(13),-1)));
RQPMT_100261_.old_tb1_2(13):=90009659;
RQPMT_100261_.tb1_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(13),-1)));
RQPMT_100261_.old_tb1_3(13):=null;
RQPMT_100261_.tb1_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(13),-1)));
RQPMT_100261_.old_tb1_4(13):=null;
RQPMT_100261_.tb1_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(13),-1)));
RQPMT_100261_.tb1_5(13):=RQPMT_100261_.tb5_0(0);
RQPMT_100261_.tb1_9(13):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(13),
ENTITY_ID=RQPMT_100261_.tb1_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(13),
STATEMENT_ID=RQPMT_100261_.tb1_5(13),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(13),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Aseguradora'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='ASEGURADORA'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='ID_CONTRATISTA'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(13),
RQPMT_100261_.tb1_1(13),
RQPMT_100261_.tb1_2(13),
RQPMT_100261_.tb1_3(13),
RQPMT_100261_.tb1_4(13),
RQPMT_100261_.tb1_5(13),
null,
null,
null,
RQPMT_100261_.tb1_9(13),
2,
'Aseguradora'
,
2,
'N'
,
'N'
,
'N'
,
'Y'
,
'ASEGURADORA'
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
'LD_SECURE_SALE'
,
'ID_CONTRATISTA'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(14):=103784;
RQPMT_100261_.old_tb1_1(14):=8006;
RQPMT_100261_.tb1_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(14),-1)));
RQPMT_100261_.old_tb1_2(14):=90009665;
RQPMT_100261_.tb1_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(14),-1)));
RQPMT_100261_.old_tb1_3(14):=null;
RQPMT_100261_.tb1_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(14),-1)));
RQPMT_100261_.old_tb1_4(14):=null;
RQPMT_100261_.tb1_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(14),-1)));
RQPMT_100261_.tb1_9(14):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(14),
ENTITY_ID=RQPMT_100261_.tb1_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(14),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Informacion del asegurado'
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
TAG_NAME='INFORMACION_DEL_ASEGURADO'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='IDENTIFICATION_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(14),
RQPMT_100261_.tb1_1(14),
RQPMT_100261_.tb1_2(14),
RQPMT_100261_.tb1_3(14),
RQPMT_100261_.tb1_4(14),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(14),
3,
'Informacion del asegurado'
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
'INFORMACION_DEL_ASEGURADO'
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
'LD_SECURE_SALE'
,
'IDENTIFICATION_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb5_0(1):=120071874;
RQPMT_100261_.tb5_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100261_.tb5_0(1):=RQPMT_100261_.tb5_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100261_.tb5_0(1),
16,
'Consulta  de linea de producto para No Renovación'
,
'select  /*+ index(l PK_LD_PRODUCT_LINE)*/
p.product_line_id id, p.description  description
from  ld_product_line p
'
,
'Consulta  de linea de producto para No Renovaci¿n'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(15):=103785;
RQPMT_100261_.old_tb1_1(15):=8006;
RQPMT_100261_.tb1_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(15),-1)));
RQPMT_100261_.old_tb1_2(15):=90009660;
RQPMT_100261_.tb1_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(15),-1)));
RQPMT_100261_.old_tb1_3(15):=null;
RQPMT_100261_.tb1_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(15),-1)));
RQPMT_100261_.old_tb1_4(15):=null;
RQPMT_100261_.tb1_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(15),-1)));
RQPMT_100261_.tb1_5(15):=RQPMT_100261_.tb5_0(1);
RQPMT_100261_.tb1_9(15):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(15),
ENTITY_ID=RQPMT_100261_.tb1_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(15),
STATEMENT_ID=RQPMT_100261_.tb1_5(15),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(15),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Linea del producto'
,
DISPLAY_ORDER=5,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='LINEA_DEL_PRODUCTO'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='PRODUCT_LINE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(15),
RQPMT_100261_.tb1_1(15),
RQPMT_100261_.tb1_2(15),
RQPMT_100261_.tb1_3(15),
RQPMT_100261_.tb1_4(15),
RQPMT_100261_.tb1_5(15),
null,
null,
null,
RQPMT_100261_.tb1_9(15),
5,
'Linea del producto'
,
5,
'N'
,
'N'
,
'N'
,
'N'
,
'LINEA_DEL_PRODUCTO'
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
'LD_SECURE_SALE'
,
'PRODUCT_LINE_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb3_0(1):=26;
RQPMT_100261_.tb3_1(1):=RQPMT_100261_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100261_.tb3_0(1),
MODULE_ID=RQPMT_100261_.tb3_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100261_.tb3_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100261_.tb3_0(1),
RQPMT_100261_.tb3_1(1),
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(3):=121128843;
RQPMT_100261_.tb4_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(3):=RQPMT_100261_.tb4_0(3);
RQPMT_100261_.old_tb4_1(3):='MO_VALIDATTR_CT26E121128843'
;
RQPMT_100261_.tb4_1(3):=RQPMT_100261_.tb4_0(3);
RQPMT_100261_.tb4_2(3):=RQPMT_100261_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(3),
RQPMT_100261_.tb4_1(3),
RQPMT_100261_.tb4_2(3),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"LD_SECURE_SALE","BORN_DATE",idtDateBorn);LD_BOSECUREMANAGEMENT.PROCVALBORNDATE(idtDateBorn)'
,
'OPEN'
,
to_date('04-09-2013 13:41:31','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida Fecha del Asegurado'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(16):=103786;
RQPMT_100261_.old_tb1_1(16):=8006;
RQPMT_100261_.tb1_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(16),-1)));
RQPMT_100261_.old_tb1_2(16):=90009661;
RQPMT_100261_.tb1_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(16),-1)));
RQPMT_100261_.old_tb1_3(16):=null;
RQPMT_100261_.tb1_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(16),-1)));
RQPMT_100261_.old_tb1_4(16):=null;
RQPMT_100261_.tb1_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(16),-1)));
RQPMT_100261_.tb1_7(16):=RQPMT_100261_.tb4_0(3);
RQPMT_100261_.tb1_9(16):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(16),
ENTITY_ID=RQPMT_100261_.tb1_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100261_.tb1_7(16),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(16),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Fecha de nacimiento'
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
TAG_NAME='FECHA_DE_NACIMIENTO'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='BORN_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(16),
RQPMT_100261_.tb1_1(16),
RQPMT_100261_.tb1_2(16),
RQPMT_100261_.tb1_3(16),
RQPMT_100261_.tb1_4(16),
null,
null,
RQPMT_100261_.tb1_7(16),
null,
RQPMT_100261_.tb1_9(16),
6,
'Fecha de nacimiento'
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
'FECHA_DE_NACIMIENTO'
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
'LD_SECURE_SALE'
,
'BORN_DATE'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(4):=121128844;
RQPMT_100261_.tb4_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(4):=RQPMT_100261_.tb4_0(4);
RQPMT_100261_.old_tb4_1(4):='MO_VALIDATTR_CT26E121128844'
;
RQPMT_100261_.tb4_1(4):=RQPMT_100261_.tb4_0(4);
RQPMT_100261_.tb4_2(4):=RQPMT_100261_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(4),
RQPMT_100261_.tb4_1(4),
RQPMT_100261_.tb4_2(4),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(inuPolicyTypeId);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETFATHERINSTANCE(sbInstance,osbInstanse);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(osbInstanse,null,"MO_PACKAGES","REQUEST_DATE",sbRequestDate);dtRequestDate = UT_CONVERT.FNUCHARTODATE(sbRequestDate);LD_BOSECUREMANAGEMENT.GETVALUEPOLICYTYPE(inuPolicyTypeId,dtRequestDate,nuValue,nuCoverageM);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"LD_SECURE_SALE","POLICY_VALUE",nuValue,GE_BOCONSTANTS.GETTRUE());if (nuValue = null,nuValue = 0;nuCoverageM = 0;,);GE_BOINSTANCECONTROL.ADDATTRIBUTE(osbInstanse,null,"CC_SALES_FINANC_COND","VALUE_TO_FINANCE",nuValue,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(osbInstanse,null,"CC_SALES_FINANC_COND","QUOTAS_NUMBER",nuCoverageM,GE_BOCONSTANTS.GETTRUE())'
,
'LBTEST'
,
to_date('24-10-2012 10:03:07','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Validación del tipo de póliza por XML'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb5_0(2):=120071875;
RQPMT_100261_.tb5_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100261_.tb5_0(2):=RQPMT_100261_.tb5_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100261_.tb5_0(2),
16,
'Sentencia del tipo de póliza por xml'
,
'SELECT lp.policy_type_id id,lp.description description
FROM ld_policy_type lp,ld_prod_line_ge_cont ld, ld_validity_policy_type lvpt
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'lp.contratista_id = ge_boinstancecontrol.fsbgetfieldvalue('|| chr(39) ||'LD_SECURE_SALE'|| chr(39) ||','|| chr(39) ||'ID_CONTRATISTA'|| chr(39) ||')'||chr(64)||'
'||chr(64)||'lp.product_line_id = ge_boinstancecontrol.fsbgetfieldvalue('|| chr(39) ||'LD_SECURE_SALE'|| chr(39) ||','|| chr(39) ||'PRODUCT_LINE_ID'|| chr(39) ||')'||chr(64)||'
'||chr(64)||'lvpt.policy_type_id = lp.policy_type_id'||chr(64)||'
'||chr(64)||'sysdate between lvpt.initial_date AND lvpt.final_date'||chr(64)||'
'||chr(64)||'lp.contratista_id = ld.contratistas_id'||chr(64)||'
'||chr(64)||'lp.product_line_id = ld.product_line_id'||chr(64)||''
,
'Sentencia del tipo de póliza por xml'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(17):=103787;
RQPMT_100261_.old_tb1_1(17):=8006;
RQPMT_100261_.tb1_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(17),-1)));
RQPMT_100261_.old_tb1_2(17):=90009662;
RQPMT_100261_.tb1_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(17),-1)));
RQPMT_100261_.old_tb1_3(17):=null;
RQPMT_100261_.tb1_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(17),-1)));
RQPMT_100261_.old_tb1_4(17):=null;
RQPMT_100261_.tb1_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(17),-1)));
RQPMT_100261_.tb1_5(17):=RQPMT_100261_.tb5_0(2);
RQPMT_100261_.tb1_7(17):=RQPMT_100261_.tb4_0(4);
RQPMT_100261_.tb1_9(17):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(17),
ENTITY_ID=RQPMT_100261_.tb1_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(17),
STATEMENT_ID=RQPMT_100261_.tb1_5(17),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100261_.tb1_7(17),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(17),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Tipo de poliza'
,
DISPLAY_ORDER=7,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='TIPO_DE_POLIZA'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='POLICY_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(17),
RQPMT_100261_.tb1_1(17),
RQPMT_100261_.tb1_2(17),
RQPMT_100261_.tb1_3(17),
RQPMT_100261_.tb1_4(17),
RQPMT_100261_.tb1_5(17),
null,
RQPMT_100261_.tb1_7(17),
null,
RQPMT_100261_.tb1_9(17),
7,
'Tipo de poliza'
,
7,
'N'
,
'N'
,
'N'
,
'N'
,
'TIPO_DE_POLIZA'
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
'LD_SECURE_SALE'
,
'POLICY_TYPE_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(5):=121128845;
RQPMT_100261_.tb4_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(5):=RQPMT_100261_.tb4_0(5);
RQPMT_100261_.old_tb4_1(5):='MO_VALIDATTR_CT26E121128845'
;
RQPMT_100261_.tb4_1(5):=RQPMT_100261_.tb4_0(5);
RQPMT_100261_.tb4_2(5):=RQPMT_100261_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(5),
RQPMT_100261_.tb4_1(5),
RQPMT_100261_.tb4_2(5),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPolicy);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"LD_SECURE_SALE","POLICY_TYPE_ID",nuPolicyType);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"LD_SECURE_SALE","PRODUCT_LINE_ID",nuProductLine);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"LD_SECURE_SALE","IDENTIFICATION_ID",nuSuscriberId);LD_BOSECUREMANAGEMENT.VALPOLICYAMOUNT(nuProductLine,nuSuscriberId,nuPolicyType,nuPolicy)'
,
'OPEN'
,
to_date('04-11-2014 16:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Validación de número de póliza'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(18):=103788;
RQPMT_100261_.old_tb1_1(18):=8006;
RQPMT_100261_.tb1_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(18),-1)));
RQPMT_100261_.old_tb1_2(18):=90009663;
RQPMT_100261_.tb1_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(18),-1)));
RQPMT_100261_.old_tb1_3(18):=null;
RQPMT_100261_.tb1_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(18),-1)));
RQPMT_100261_.old_tb1_4(18):=null;
RQPMT_100261_.tb1_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(18),-1)));
RQPMT_100261_.tb1_7(18):=RQPMT_100261_.tb4_0(5);
RQPMT_100261_.tb1_9(18):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(18),
ENTITY_ID=RQPMT_100261_.tb1_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100261_.tb1_7(18),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(18),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Número de poliza'
,
DISPLAY_ORDER=8,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='NUMERO_DE_POLIZA'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='POLICY_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(18),
RQPMT_100261_.tb1_1(18),
RQPMT_100261_.tb1_2(18),
RQPMT_100261_.tb1_3(18),
RQPMT_100261_.tb1_4(18),
null,
null,
RQPMT_100261_.tb1_7(18),
null,
RQPMT_100261_.tb1_9(18),
8,
'Número de poliza'
,
8,
'N'
,
'N'
,
'N'
,
'N'
,
'NUMERO_DE_POLIZA'
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
'LD_SECURE_SALE'
,
'POLICY_NUMBER'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(19):=103789;
RQPMT_100261_.old_tb1_1(19):=8006;
RQPMT_100261_.tb1_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(19),-1)));
RQPMT_100261_.old_tb1_2(19):=90009664;
RQPMT_100261_.tb1_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(19),-1)));
RQPMT_100261_.old_tb1_3(19):=null;
RQPMT_100261_.tb1_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(19),-1)));
RQPMT_100261_.old_tb1_4(19):=null;
RQPMT_100261_.tb1_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(19),-1)));
RQPMT_100261_.tb1_9(19):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (19)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(19),
ENTITY_ID=RQPMT_100261_.tb1_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(19),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Valor de la poliza'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='VALOR_DE_LA_POLIZA'
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
ENTITY_NAME='LD_SECURE_SALE'
,
ATTRI_TECHNICAL_NAME='POLICY_VALUE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(19);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(19),
RQPMT_100261_.tb1_1(19),
RQPMT_100261_.tb1_2(19),
RQPMT_100261_.tb1_3(19),
RQPMT_100261_.tb1_4(19),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(19),
9,
'Valor de la poliza'
,
9,
'N'
,
'N'
,
'N'
,
'N'
,
'VALOR_DE_LA_POLIZA'
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
'LD_SECURE_SALE'
,
'POLICY_VALUE'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb5_0(3):=120071876;
RQPMT_100261_.tb5_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100261_.tb5_0(3):=RQPMT_100261_.tb5_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100261_.tb5_0(3),
5,
'Respuestas de Atención Venta de Seguros'
,
'select cc_answer.answer_id ID, cc_answer.description DESCRIPTION
from cc_answer
where REQUEST_TYPE_ID = 100261
order by id'
,
'Respuestas de Atención Venta de Seguros'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(20):=103790;
RQPMT_100261_.old_tb1_1(20):=8;
RQPMT_100261_.tb1_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(20),-1)));
RQPMT_100261_.old_tb1_2(20):=144591;
RQPMT_100261_.tb1_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(20),-1)));
RQPMT_100261_.old_tb1_3(20):=null;
RQPMT_100261_.tb1_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(20),-1)));
RQPMT_100261_.old_tb1_4(20):=null;
RQPMT_100261_.tb1_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(20),-1)));
RQPMT_100261_.tb1_5(20):=RQPMT_100261_.tb5_0(3);
RQPMT_100261_.tb1_9(20):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (20)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(20),
ENTITY_ID=RQPMT_100261_.tb1_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(20),
STATEMENT_ID=RQPMT_100261_.tb1_5(20),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(20),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Respuesta '
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(20);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(20),
RQPMT_100261_.tb1_1(20),
RQPMT_100261_.tb1_2(20),
RQPMT_100261_.tb1_3(20),
RQPMT_100261_.tb1_4(20),
RQPMT_100261_.tb1_5(20),
null,
null,
null,
RQPMT_100261_.tb1_9(20),
10,
'Respuesta '
,
10,
'N'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(6):=121128846;
RQPMT_100261_.tb4_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(6):=RQPMT_100261_.tb4_0(6);
RQPMT_100261_.old_tb4_1(6):='MO_INITATRIB_CT23E121128846'
;
RQPMT_100261_.tb4_1(6):=RQPMT_100261_.tb4_0(6);
RQPMT_100261_.tb4_2(6):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(6),
RQPMT_100261_.tb4_1(6),
RQPMT_100261_.tb4_2(6),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'LBTEST'
,
to_date('05-10-2012 11:19:02','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(21):=103791;
RQPMT_100261_.old_tb1_1(21):=8;
RQPMT_100261_.tb1_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(21),-1)));
RQPMT_100261_.old_tb1_2(21):=187;
RQPMT_100261_.tb1_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(21),-1)));
RQPMT_100261_.old_tb1_3(21):=null;
RQPMT_100261_.tb1_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(21),-1)));
RQPMT_100261_.old_tb1_4(21):=null;
RQPMT_100261_.tb1_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(21),-1)));
RQPMT_100261_.tb1_6(21):=RQPMT_100261_.tb4_0(6);
RQPMT_100261_.tb1_9(21):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (21)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(21),
ENTITY_ID=RQPMT_100261_.tb1_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(21),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(21),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Identificador de Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(21);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(21),
RQPMT_100261_.tb1_1(21),
RQPMT_100261_.tb1_2(21),
RQPMT_100261_.tb1_3(21),
RQPMT_100261_.tb1_4(21),
null,
RQPMT_100261_.tb1_6(21),
null,
null,
RQPMT_100261_.tb1_9(21),
1,
'Identificador de Motivo'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(22):=103792;
RQPMT_100261_.old_tb1_1(22):=8;
RQPMT_100261_.tb1_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(22),-1)));
RQPMT_100261_.old_tb1_2(22):=213;
RQPMT_100261_.tb1_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(22),-1)));
RQPMT_100261_.old_tb1_3(22):=255;
RQPMT_100261_.tb1_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(22),-1)));
RQPMT_100261_.old_tb1_4(22):=null;
RQPMT_100261_.tb1_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(22),-1)));
RQPMT_100261_.tb1_9(22):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (22)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(22),
ENTITY_ID=RQPMT_100261_.tb1_1(22),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(22),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(22),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(22),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Identificador del Paquete'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(22);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(22),
RQPMT_100261_.tb1_1(22),
RQPMT_100261_.tb1_2(22),
RQPMT_100261_.tb1_3(22),
RQPMT_100261_.tb1_4(22),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(22),
11,
'Identificador del Paquete'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(7):=121128847;
RQPMT_100261_.tb4_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(7):=RQPMT_100261_.tb4_0(7);
RQPMT_100261_.old_tb4_1(7):='MO_INITATRIB_CT23E121128847'
;
RQPMT_100261_.tb4_1(7):=RQPMT_100261_.tb4_0(7);
RQPMT_100261_.tb4_2(7):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(7),
RQPMT_100261_.tb4_1(7),
RQPMT_100261_.tb4_2(7),
'CF_BOINITRULES.INIPRIORITY()'
,
'LBTEST'
,
to_date('05-10-2012 11:19:03','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - PRIORITY - Inicializa prioridad'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(23):=103793;
RQPMT_100261_.old_tb1_1(23):=8;
RQPMT_100261_.tb1_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(23),-1)));
RQPMT_100261_.old_tb1_2(23):=203;
RQPMT_100261_.tb1_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(23),-1)));
RQPMT_100261_.old_tb1_3(23):=null;
RQPMT_100261_.tb1_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(23),-1)));
RQPMT_100261_.old_tb1_4(23):=null;
RQPMT_100261_.tb1_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(23),-1)));
RQPMT_100261_.tb1_6(23):=RQPMT_100261_.tb4_0(7);
RQPMT_100261_.tb1_9(23):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (23)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(23),
ENTITY_ID=RQPMT_100261_.tb1_1(23),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(23),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(23),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(23),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(23),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Prioridad'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='PRIORIDAD'
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
ATTRI_TECHNICAL_NAME='PRIORITY'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(23);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(23),
RQPMT_100261_.tb1_1(23),
RQPMT_100261_.tb1_2(23),
RQPMT_100261_.tb1_3(23),
RQPMT_100261_.tb1_4(23),
null,
RQPMT_100261_.tb1_6(23),
null,
null,
RQPMT_100261_.tb1_9(23),
12,
'Prioridad'
,
12,
'N'
,
'N'
,
'N'
,
'Y'
,
'PRIORIDAD'
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
'PRIORITY'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(8):=121128848;
RQPMT_100261_.tb4_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(8):=RQPMT_100261_.tb4_0(8);
RQPMT_100261_.old_tb4_1(8):='MO_INITATRIB_CT23E121128848'
;
RQPMT_100261_.tb4_1(8):=RQPMT_100261_.tb4_0(8);
RQPMT_100261_.tb4_2(8):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(8),
RQPMT_100261_.tb4_1(8),
RQPMT_100261_.tb4_2(8),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'LBTEST'
,
to_date('05-10-2012 11:19:03','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:51','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - PARTIAL_FLAG - Inicializa flag de parcialidad'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(24):=103794;
RQPMT_100261_.old_tb1_1(24):=8;
RQPMT_100261_.tb1_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(24),-1)));
RQPMT_100261_.old_tb1_2(24):=322;
RQPMT_100261_.tb1_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(24),-1)));
RQPMT_100261_.old_tb1_3(24):=null;
RQPMT_100261_.tb1_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(24),-1)));
RQPMT_100261_.old_tb1_4(24):=null;
RQPMT_100261_.tb1_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(24),-1)));
RQPMT_100261_.tb1_6(24):=RQPMT_100261_.tb4_0(8);
RQPMT_100261_.tb1_9(24):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (24)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(24),
ENTITY_ID=RQPMT_100261_.tb1_1(24),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(24),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(24),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(24),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(24),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Entregas Parciales'
,
DISPLAY_ORDER=13,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='ENTREGAS_PARCIALES'
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
ATTRI_TECHNICAL_NAME='PARTIAL_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(24);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(24),
RQPMT_100261_.tb1_1(24),
RQPMT_100261_.tb1_2(24),
RQPMT_100261_.tb1_3(24),
RQPMT_100261_.tb1_4(24),
null,
RQPMT_100261_.tb1_6(24),
null,
null,
RQPMT_100261_.tb1_9(24),
13,
'Entregas Parciales'
,
13,
'N'
,
'N'
,
'N'
,
'N'
,
'ENTREGAS_PARCIALES'
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
'PARTIAL_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(25):=103795;
RQPMT_100261_.old_tb1_1(25):=8;
RQPMT_100261_.tb1_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(25),-1)));
RQPMT_100261_.old_tb1_2(25):=2641;
RQPMT_100261_.tb1_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(25),-1)));
RQPMT_100261_.old_tb1_3(25):=null;
RQPMT_100261_.tb1_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(25),-1)));
RQPMT_100261_.old_tb1_4(25):=null;
RQPMT_100261_.tb1_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(25),-1)));
RQPMT_100261_.tb1_9(25):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (25)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(25),
ENTITY_ID=RQPMT_100261_.tb1_1(25),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(25),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(25),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(25),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Límite de Crédito'
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
TAG_NAME=null,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(25);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(25),
RQPMT_100261_.tb1_1(25),
RQPMT_100261_.tb1_2(25),
RQPMT_100261_.tb1_3(25),
RQPMT_100261_.tb1_4(25),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(25),
14,
'Límite de Crédito'
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
null,
'N'
,
1,
'M'
,
'N'
,
'N'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(26):=103796;
RQPMT_100261_.old_tb1_1(26):=8;
RQPMT_100261_.tb1_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(26),-1)));
RQPMT_100261_.old_tb1_2(26):=197;
RQPMT_100261_.tb1_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(26),-1)));
RQPMT_100261_.old_tb1_3(26):=null;
RQPMT_100261_.tb1_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(26),-1)));
RQPMT_100261_.old_tb1_4(26):=null;
RQPMT_100261_.tb1_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(26),-1)));
RQPMT_100261_.tb1_9(26):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (26)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(26),
ENTITY_ID=RQPMT_100261_.tb1_1(26),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(26),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(26),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(26),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(26),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='PRIVACY_FLAG'
,
DISPLAY_ORDER=15,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME=null,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
,
ACTIVE='Y'
,
ENTITY_NAME='MO_MOTIVE'
,
ATTRI_TECHNICAL_NAME='PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(26);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(26),
RQPMT_100261_.tb1_1(26),
RQPMT_100261_.tb1_2(26),
RQPMT_100261_.tb1_3(26),
RQPMT_100261_.tb1_4(26),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(26),
15,
'PRIVACY_FLAG'
,
15,
'N'
,
'N'
,
'N'
,
'N'
,
null,
'N'
,
1,
'M'
,
'N'
,
'N'
,
'Y'
,
'MO_MOTIVE'
,
'PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(27):=103797;
RQPMT_100261_.old_tb1_1(27):=8;
RQPMT_100261_.tb1_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(27),-1)));
RQPMT_100261_.old_tb1_2(27):=189;
RQPMT_100261_.tb1_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(27),-1)));
RQPMT_100261_.old_tb1_3(27):=null;
RQPMT_100261_.tb1_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(27),-1)));
RQPMT_100261_.old_tb1_4(27):=null;
RQPMT_100261_.tb1_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(27),-1)));
RQPMT_100261_.tb1_9(27):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (27)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(27),
ENTITY_ID=RQPMT_100261_.tb1_1(27),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(27),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(27),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(27),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(27),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Número Petición Atención al cliente'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='NUMERO_PETICION_ATENCION_AL_CLIENTE'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(27);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(27),
RQPMT_100261_.tb1_1(27),
RQPMT_100261_.tb1_2(27),
RQPMT_100261_.tb1_3(27),
RQPMT_100261_.tb1_4(27),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(27),
16,
'Número Petición Atención al cliente'
,
16,
'N'
,
'N'
,
'N'
,
'Y'
,
'NUMERO_PETICION_ATENCION_AL_CLIENTE'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(28):=103798;
RQPMT_100261_.old_tb1_1(28):=8;
RQPMT_100261_.tb1_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(28),-1)));
RQPMT_100261_.old_tb1_2(28):=413;
RQPMT_100261_.tb1_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(28),-1)));
RQPMT_100261_.old_tb1_3(28):=null;
RQPMT_100261_.tb1_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(28),-1)));
RQPMT_100261_.old_tb1_4(28):=null;
RQPMT_100261_.tb1_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(28),-1)));
RQPMT_100261_.tb1_9(28):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (28)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(28),
ENTITY_ID=RQPMT_100261_.tb1_1(28),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(28),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(28),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(28),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(28),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='PRODUCT_ID'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='PRODUCT_ID'
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
ATTRI_TECHNICAL_NAME='PRODUCT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(28);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(28),
RQPMT_100261_.tb1_1(28),
RQPMT_100261_.tb1_2(28),
RQPMT_100261_.tb1_3(28),
RQPMT_100261_.tb1_4(28),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(28),
17,
'PRODUCT_ID'
,
17,
'N'
,
'N'
,
'N'
,
'N'
,
'PRODUCT_ID'
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
'PRODUCT_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(29):=103799;
RQPMT_100261_.old_tb1_1(29):=8;
RQPMT_100261_.tb1_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(29),-1)));
RQPMT_100261_.old_tb1_2(29):=50001324;
RQPMT_100261_.tb1_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(29),-1)));
RQPMT_100261_.old_tb1_3(29):=null;
RQPMT_100261_.tb1_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(29),-1)));
RQPMT_100261_.old_tb1_4(29):=null;
RQPMT_100261_.tb1_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(29),-1)));
RQPMT_100261_.tb1_9(29):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (29)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(29),
ENTITY_ID=RQPMT_100261_.tb1_1(29),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(29),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(29),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(29),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(29),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Ubicaci¿n Geogr¿fica'
,
DISPLAY_ORDER=18,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(29);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(29),
RQPMT_100261_.tb1_1(29),
RQPMT_100261_.tb1_2(29),
RQPMT_100261_.tb1_3(29),
RQPMT_100261_.tb1_4(29),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(29),
18,
'Ubicaci¿n Geogr¿fica'
,
18,
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(9):=121128849;
RQPMT_100261_.tb4_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(9):=RQPMT_100261_.tb4_0(9);
RQPMT_100261_.old_tb4_1(9):='MO_INITATRIB_CT23E121128849'
;
RQPMT_100261_.tb4_1(9):=RQPMT_100261_.tb4_0(9);
RQPMT_100261_.tb4_2(9):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(9),
RQPMT_100261_.tb4_1(9),
RQPMT_100261_.tb4_2(9),
'CF_BOINITRULES.INIPROVISIONALFLAG()'
,
'LBTEST'
,
to_date('05-10-2012 11:19:05','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:51','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - PROVISIONAL_FLAG - Inicia flag de provisionalidad'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(30):=103800;
RQPMT_100261_.old_tb1_1(30):=8;
RQPMT_100261_.tb1_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(30),-1)));
RQPMT_100261_.old_tb1_2(30):=198;
RQPMT_100261_.tb1_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(30),-1)));
RQPMT_100261_.old_tb1_3(30):=null;
RQPMT_100261_.tb1_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(30),-1)));
RQPMT_100261_.old_tb1_4(30):=null;
RQPMT_100261_.tb1_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(30),-1)));
RQPMT_100261_.tb1_6(30):=RQPMT_100261_.tb4_0(9);
RQPMT_100261_.tb1_9(30):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (30)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(30),
ENTITY_ID=RQPMT_100261_.tb1_1(30),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(30),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(30),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(30),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb1_6(30),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(30),
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Provisional'
,
DISPLAY_ORDER=19,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='PROVISIONAL'
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
ATTRI_TECHNICAL_NAME='PROVISIONAL_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(30);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(30),
RQPMT_100261_.tb1_1(30),
RQPMT_100261_.tb1_2(30),
RQPMT_100261_.tb1_3(30),
RQPMT_100261_.tb1_4(30),
null,
RQPMT_100261_.tb1_6(30),
null,
null,
RQPMT_100261_.tb1_9(30),
19,
'Provisional'
,
19,
'N'
,
'N'
,
'N'
,
'N'
,
'PROVISIONAL'
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
'PROVISIONAL_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb1_0(31):=103801;
RQPMT_100261_.old_tb1_1(31):=8;
RQPMT_100261_.tb1_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb1_1(31),-1)));
RQPMT_100261_.old_tb1_2(31):=498;
RQPMT_100261_.tb1_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_2(31),-1)));
RQPMT_100261_.old_tb1_3(31):=null;
RQPMT_100261_.tb1_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_3(31),-1)));
RQPMT_100261_.old_tb1_4(31):=null;
RQPMT_100261_.tb1_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb1_4(31),-1)));
RQPMT_100261_.tb1_9(31):=RQPMT_100261_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (31)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100261_.tb1_0(31),
ENTITY_ID=RQPMT_100261_.tb1_1(31),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb1_2(31),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb1_3(31),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb1_4(31),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb1_9(31),
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Fecha de Atenci¿n'
,
DISPLAY_ORDER=20,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME=null,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100261_.tb1_0(31);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb1_0(31),
RQPMT_100261_.tb1_1(31),
RQPMT_100261_.tb1_2(31),
RQPMT_100261_.tb1_3(31),
RQPMT_100261_.tb1_4(31),
null,
null,
null,
null,
RQPMT_100261_.tb1_9(31),
20,
'Fecha de Atenci¿n'
,
20,
'N'
,
'N'
,
'N'
,
'N'
,
null,
'N'
,
1,
'M'
,
'N'
,
'N'
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
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb7_0(0):=99;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQPMT_100261_.tb7_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb8_0(0):=7109;
RQPMT_100261_.tb8_1(0):=RQPMT_100261_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (0)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=RQPMT_100261_.tb8_0(0),
SERVICE_TYPE_ID=RQPMT_100261_.tb8_1(0),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Brilla Seguros'
,
ACCEPT_IF_PROJECTED='N'
,
ASSIGNABLE='N'
,
TAG_NAME='CP_BRILLA_SEGUROS_7109'
,
ELEMENT_DAYS_WAIT=null,
IS_AUTOMATIC_ASSIGN='N'
,
SUSPEND_ALLOWED='N'
,
IS_DEPENDENT='N'
,
VALIDATE_RETIRE='Y'
,
IS_MEASURABLE='N'
,
IS_MOVEABLE='Y'
,
ELEMENT_TYPE_ID=null,
COMPONEN_BY_QUANTITY='N'
,
PRODUCT_REFERENCE='N'
,
AUTOMATIC_ACTIVATION='N'
,
CONCEPT_ID=null,
SALE_CONCEPT_ID=null,
ALLOW_CLASS_CHANGE='N'

 WHERE COMPONENT_TYPE_ID = RQPMT_100261_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (RQPMT_100261_.tb8_0(0),
RQPMT_100261_.tb8_1(0),
null,
'Brilla Seguros'
,
'N'
,
'N'
,
'CP_BRILLA_SEGUROS_7109'
,
null,
'N'
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
null,
'N'
,
'N'
,
'N'
,
null,
null,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb9_0(0):=10333;
RQPMT_100261_.tb9_1(0):=RQPMT_100261_.tb0_0(0);
RQPMT_100261_.tb9_4(0):=RQPMT_100261_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTIVE_COMP fila (0)',1);
UPDATE PS_PROD_MOTIVE_COMP SET PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb9_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100261_.tb9_1(0),
PARENT_COMP=null,
SERVICE_COMPONENT=10320,
COMPONENT_TYPE_ID=RQPMT_100261_.tb9_4(0),
MOTIVE_TYPE_ID=8,
TAG_NAME='C_BRILLA_SEGUROS_10333'
,
ASSIGN_ORDER=3,
MIN_COMPONENTS=1,
MAX_COMPONENTS=1,
IS_OPTIONAL='N'
,
DESCRIPTION='Brilla Seguros'
,
PROCESS_SEQUENCE=3,
CONTAIN_MAIN_NUMBER='N'
,
LOAD_COMPONENT_INFO='N'
,
COPY_NETWORK_ASSO='N'
,
ELEMENT_CATEGORY_ID=null,
ATTEND_WITH_PARENT='N'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
IS_NULLABLE='N'
,
FACTI_TECNICA='N'
,
DISPLAY_CLASS_SERVICE='Y'
,
DISPLAY_CONTROL=null,
REQUIRES_CHILDREN='N'

 WHERE PROD_MOTIVE_COMP_ID = RQPMT_100261_.tb9_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTIVE_COMP(PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,SERVICE_COMPONENT,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN) 
VALUES (RQPMT_100261_.tb9_0(0),
RQPMT_100261_.tb9_1(0),
null,
10320,
RQPMT_100261_.tb9_4(0),
8,
'C_BRILLA_SEGUROS_10333'
,
3,
1,
1,
'N'
,
'Brilla Seguros'
,
3,
'N'
,
'N'
,
'N'
,
null,
'N'
,
'Y'
,
'Y'
,
'N'
,
'N'
,
'Y'
,
null,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(0):=105176;
RQPMT_100261_.old_tb10_1(0):=43;
RQPMT_100261_.tb10_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(0),-1)));
RQPMT_100261_.old_tb10_2(0):=456;
RQPMT_100261_.tb10_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(0),-1)));
RQPMT_100261_.old_tb10_3(0):=187;
RQPMT_100261_.tb10_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(0),-1)));
RQPMT_100261_.old_tb10_4(0):=null;
RQPMT_100261_.tb10_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(0),-1)));
RQPMT_100261_.tb10_5(0):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (0)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(0),
ENTITY_ID=RQPMT_100261_.tb10_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(0),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(0),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Identificador del Motivo Registro Componente'
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
TAG_NAME='IDENTIFICADOR_DEL_MOTIVO_REGISTRO_COMPONENTE'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(0),
RQPMT_100261_.tb10_1(0),
RQPMT_100261_.tb10_2(0),
RQPMT_100261_.tb10_3(0),
RQPMT_100261_.tb10_4(0),
RQPMT_100261_.tb10_5(0),
null,
null,
null,
null,
1,
'Identificador del Motivo Registro Componente'
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
'IDENTIFICADOR_DEL_MOTIVO_REGISTRO_COMPONENTE'
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
'MO_COMPONENT'
,
'MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(1):=105177;
RQPMT_100261_.old_tb10_1(1):=43;
RQPMT_100261_.tb10_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(1),-1)));
RQPMT_100261_.old_tb10_2(1):=696;
RQPMT_100261_.tb10_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(1),-1)));
RQPMT_100261_.old_tb10_3(1):=697;
RQPMT_100261_.tb10_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(1),-1)));
RQPMT_100261_.old_tb10_4(1):=null;
RQPMT_100261_.tb10_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(1),-1)));
RQPMT_100261_.tb10_5(1):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (1)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(1),
ENTITY_ID=RQPMT_100261_.tb10_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(1),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(1),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Identificador del Producto Motivo'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DEL_PRODUCTO_MOTIVO'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='PRODUCT_MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(1);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(1),
RQPMT_100261_.tb10_1(1),
RQPMT_100261_.tb10_2(1),
RQPMT_100261_.tb10_3(1),
RQPMT_100261_.tb10_4(1),
RQPMT_100261_.tb10_5(1),
null,
null,
null,
null,
2,
'Identificador del Producto Motivo'
,
2,
'N'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DEL_PRODUCTO_MOTIVO'
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
'MO_COMPONENT'
,
'PRODUCT_MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(2):=105178;
RQPMT_100261_.old_tb10_1(2):=43;
RQPMT_100261_.tb10_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(2),-1)));
RQPMT_100261_.old_tb10_2(2):=1026;
RQPMT_100261_.tb10_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(2),-1)));
RQPMT_100261_.old_tb10_3(2):=null;
RQPMT_100261_.tb10_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(2),-1)));
RQPMT_100261_.old_tb10_4(2):=null;
RQPMT_100261_.tb10_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(2),-1)));
RQPMT_100261_.tb10_5(2):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (2)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(2),
ENTITY_ID=RQPMT_100261_.tb10_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(2),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(2),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Fecha de inicio del servicio'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='FECHA_DE_INICIO_DEL_SERVICIO'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='SERVICE_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(2);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(2),
RQPMT_100261_.tb10_1(2),
RQPMT_100261_.tb10_2(2),
RQPMT_100261_.tb10_3(2),
RQPMT_100261_.tb10_4(2),
RQPMT_100261_.tb10_5(2),
null,
null,
null,
null,
3,
'Fecha de inicio del servicio'
,
3,
'N'
,
'N'
,
'N'
,
'N'
,
'FECHA_DE_INICIO_DEL_SERVICIO'
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
'MO_COMPONENT'
,
'SERVICE_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(3):=105179;
RQPMT_100261_.old_tb10_1(3):=43;
RQPMT_100261_.tb10_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(3),-1)));
RQPMT_100261_.old_tb10_2(3):=50000937;
RQPMT_100261_.tb10_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(3),-1)));
RQPMT_100261_.old_tb10_3(3):=255;
RQPMT_100261_.tb10_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(3),-1)));
RQPMT_100261_.old_tb10_4(3):=null;
RQPMT_100261_.tb10_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(3),-1)));
RQPMT_100261_.tb10_5(3):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (3)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(3),
ENTITY_ID=RQPMT_100261_.tb10_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(3),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(3),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='PACKAGE_ID'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(3);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(3),
RQPMT_100261_.tb10_1(3),
RQPMT_100261_.tb10_2(3),
RQPMT_100261_.tb10_3(3),
RQPMT_100261_.tb10_4(3),
RQPMT_100261_.tb10_5(3),
null,
null,
null,
null,
4,
'PACKAGE_ID'
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
'MO_COMPONENT'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(4):=105180;
RQPMT_100261_.old_tb10_1(4):=43;
RQPMT_100261_.tb10_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(4),-1)));
RQPMT_100261_.old_tb10_2(4):=50000936;
RQPMT_100261_.tb10_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(4),-1)));
RQPMT_100261_.old_tb10_3(4):=null;
RQPMT_100261_.tb10_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(4),-1)));
RQPMT_100261_.old_tb10_4(4):=null;
RQPMT_100261_.tb10_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(4),-1)));
RQPMT_100261_.tb10_5(4):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (4)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(4),
ENTITY_ID=RQPMT_100261_.tb10_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(4),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(4),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='PRODUCT_ID'
,
DISPLAY_ORDER=5,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='PRODUCT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(4);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(4),
RQPMT_100261_.tb10_1(4),
RQPMT_100261_.tb10_2(4),
RQPMT_100261_.tb10_3(4),
RQPMT_100261_.tb10_4(4),
RQPMT_100261_.tb10_5(4),
null,
null,
null,
null,
5,
'PRODUCT_ID'
,
5,
'N'
,
'N'
,
'N'
,
'N'
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
'MO_COMPONENT'
,
'PRODUCT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(5):=105181;
RQPMT_100261_.old_tb10_1(5):=43;
RQPMT_100261_.tb10_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(5),-1)));
RQPMT_100261_.old_tb10_2(5):=4013;
RQPMT_100261_.tb10_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(5),-1)));
RQPMT_100261_.old_tb10_3(5):=null;
RQPMT_100261_.tb10_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(5),-1)));
RQPMT_100261_.old_tb10_4(5):=null;
RQPMT_100261_.tb10_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(5),-1)));
RQPMT_100261_.tb10_5(5):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (5)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(5),
ENTITY_ID=RQPMT_100261_.tb10_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(5),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(5),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='SERVICE_NUMBER'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='SERVICE_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(5);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(5),
RQPMT_100261_.tb10_1(5),
RQPMT_100261_.tb10_2(5),
RQPMT_100261_.tb10_3(5),
RQPMT_100261_.tb10_4(5),
RQPMT_100261_.tb10_5(5),
null,
null,
null,
null,
6,
'SERVICE_NUMBER'
,
6,
'N'
,
'N'
,
'N'
,
'N'
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
'MO_COMPONENT'
,
'SERVICE_NUMBER'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(6):=105182;
RQPMT_100261_.old_tb10_1(6):=43;
RQPMT_100261_.tb10_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(6),-1)));
RQPMT_100261_.old_tb10_2(6):=362;
RQPMT_100261_.tb10_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(6),-1)));
RQPMT_100261_.old_tb10_3(6):=null;
RQPMT_100261_.tb10_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(6),-1)));
RQPMT_100261_.old_tb10_4(6):=null;
RQPMT_100261_.tb10_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(6),-1)));
RQPMT_100261_.tb10_5(6):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (6)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(6),
ENTITY_ID=RQPMT_100261_.tb10_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(6),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(6),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='MOTIVE_TYPE_ID'
,
DISPLAY_ORDER=7,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='MOTIVE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(6);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(6),
RQPMT_100261_.tb10_1(6),
RQPMT_100261_.tb10_2(6),
RQPMT_100261_.tb10_3(6),
RQPMT_100261_.tb10_4(6),
RQPMT_100261_.tb10_5(6),
null,
null,
null,
null,
7,
'MOTIVE_TYPE_ID'
,
7,
'N'
,
'N'
,
'N'
,
'N'
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
'MO_COMPONENT'
,
'MOTIVE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(7):=105183;
RQPMT_100261_.old_tb10_1(7):=43;
RQPMT_100261_.tb10_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(7),-1)));
RQPMT_100261_.old_tb10_2(7):=361;
RQPMT_100261_.tb10_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(7),-1)));
RQPMT_100261_.old_tb10_3(7):=null;
RQPMT_100261_.tb10_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(7),-1)));
RQPMT_100261_.old_tb10_4(7):=null;
RQPMT_100261_.tb10_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(7),-1)));
RQPMT_100261_.tb10_5(7):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (7)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(7),
ENTITY_ID=RQPMT_100261_.tb10_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(7),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(7),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='COMPONENT_TYPE_ID'
,
DISPLAY_ORDER=8,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='COMPONENT_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(7);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(7),
RQPMT_100261_.tb10_1(7),
RQPMT_100261_.tb10_2(7),
RQPMT_100261_.tb10_3(7),
RQPMT_100261_.tb10_4(7),
RQPMT_100261_.tb10_5(7),
null,
null,
null,
null,
8,
'COMPONENT_TYPE_ID'
,
8,
'N'
,
'N'
,
'N'
,
'N'
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
'MO_COMPONENT'
,
'COMPONENT_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(8):=105184;
RQPMT_100261_.old_tb10_1(8):=43;
RQPMT_100261_.tb10_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(8),-1)));
RQPMT_100261_.old_tb10_2(8):=355;
RQPMT_100261_.tb10_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(8),-1)));
RQPMT_100261_.old_tb10_3(8):=null;
RQPMT_100261_.tb10_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(8),-1)));
RQPMT_100261_.old_tb10_4(8):=null;
RQPMT_100261_.tb10_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(8),-1)));
RQPMT_100261_.tb10_5(8):=RQPMT_100261_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (8)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(8),
ENTITY_ID=RQPMT_100261_.tb10_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(8),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(8),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='DISTRICT_ID'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='DISTRICT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(8);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(8),
RQPMT_100261_.tb10_1(8),
RQPMT_100261_.tb10_2(8),
RQPMT_100261_.tb10_3(8),
RQPMT_100261_.tb10_4(8),
RQPMT_100261_.tb10_5(8),
null,
null,
null,
null,
9,
'DISTRICT_ID'
,
9,
'N'
,
'N'
,
'N'
,
'N'
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
'MO_COMPONENT'
,
'DISTRICT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb5_0(4):=120071877;
RQPMT_100261_.tb5_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100261_.tb5_0(4):=RQPMT_100261_.tb5_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100261_.tb5_0(4),
16,
'Alternativas para el Componente del Servicio'
,
'SELECT distinct a.class_service_id id, a.description description
FROM ps_prod_motive_comp b, ps_servcomp_class c, ps_class_service a
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||' b.service_component = c.service_component '||chr(64)||'
'||chr(64)||' c.class_service_id = a.class_service_id '||chr(64)||'
'||chr(64)||' a.class_service_id = :id '||chr(64)||'
'
,
'Alternativas para el Componente del Servicio'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(9):=105185;
RQPMT_100261_.old_tb10_1(9):=43;
RQPMT_100261_.tb10_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(9),-1)));
RQPMT_100261_.old_tb10_2(9):=1801;
RQPMT_100261_.tb10_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(9),-1)));
RQPMT_100261_.old_tb10_3(9):=null;
RQPMT_100261_.tb10_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(9),-1)));
RQPMT_100261_.old_tb10_4(9):=null;
RQPMT_100261_.tb10_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(9),-1)));
RQPMT_100261_.tb10_5(9):=RQPMT_100261_.tb9_0(0);
RQPMT_100261_.tb10_9(9):=RQPMT_100261_.tb5_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (9)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(9),
ENTITY_ID=RQPMT_100261_.tb10_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(9),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(9),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=RQPMT_100261_.tb10_9(9),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Alternativa'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='CLASS_SERVICE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(9);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(9),
RQPMT_100261_.tb10_1(9),
RQPMT_100261_.tb10_2(9),
RQPMT_100261_.tb10_3(9),
RQPMT_100261_.tb10_4(9),
RQPMT_100261_.tb10_5(9),
null,
null,
null,
RQPMT_100261_.tb10_9(9),
10,
'Alternativa'
,
10,
'N'
,
'N'
,
'N'
,
'N'
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
'MO_COMPONENT'
,
'CLASS_SERVICE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.old_tb4_0(10):=121128850;
RQPMT_100261_.tb4_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100261_.tb4_0(10):=RQPMT_100261_.tb4_0(10);
RQPMT_100261_.old_tb4_1(10):='MO_INITATRIB_CT23E121128850'
;
RQPMT_100261_.tb4_1(10):=RQPMT_100261_.tb4_0(10);
RQPMT_100261_.tb4_2(10):=RQPMT_100261_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100261_.tb4_0(10),
RQPMT_100261_.tb4_1(10),
RQPMT_100261_.tb4_2(10),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETCOMPONENTID())'
,
'LBTEST'
,
to_date('05-10-2012 11:22:02','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:51','DD-MM-YYYY HH24:MI:SS'),
to_date('05-12-2014 12:34:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_COMPONENT - COMPONENT_ID - Inicializa identificador de componente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;

RQPMT_100261_.tb10_0(10):=105175;
RQPMT_100261_.old_tb10_1(10):=43;
RQPMT_100261_.tb10_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100261_.TBENTITYNAME(NVL(RQPMT_100261_.old_tb10_1(10),-1)));
RQPMT_100261_.old_tb10_2(10):=338;
RQPMT_100261_.tb10_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_2(10),-1)));
RQPMT_100261_.old_tb10_3(10):=null;
RQPMT_100261_.tb10_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_3(10),-1)));
RQPMT_100261_.old_tb10_4(10):=null;
RQPMT_100261_.tb10_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100261_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100261_.old_tb10_4(10),-1)));
RQPMT_100261_.tb10_5(10):=RQPMT_100261_.tb9_0(0);
RQPMT_100261_.tb10_8(10):=RQPMT_100261_.tb4_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (10)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100261_.tb10_0(10),
ENTITY_ID=RQPMT_100261_.tb10_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100261_.tb10_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100261_.tb10_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100261_.tb10_4(10),
PROD_MOTIVE_COMP_ID=RQPMT_100261_.tb10_5(10),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100261_.tb10_8(10),
STATEMENT_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Identificador del Componente Registro Componente'
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
TAG_NAME='IDENTIFICADOR_DEL_COMPONENTE_REGISTRO_COMPONENTE'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='COMPONENT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100261_.tb10_0(10);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100261_.tb10_0(10),
RQPMT_100261_.tb10_1(10),
RQPMT_100261_.tb10_2(10),
RQPMT_100261_.tb10_3(10),
RQPMT_100261_.tb10_4(10),
RQPMT_100261_.tb10_5(10),
null,
null,
RQPMT_100261_.tb10_8(10),
null,
0,
'Identificador del Componente Registro Componente'
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
'IDENTIFICADOR_DEL_COMPONENTE_REGISTRO_COMPONENTE'
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
'MO_COMPONENT'
,
'COMPONENT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
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

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100261, sbSuccess);
FOR rc in RQPMT_100261_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
nuIndex := RQPMT_100261_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100261_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100261_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100261_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100261_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100261_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100261_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100261_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100261_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100261_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100261_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100261_.blProcessStatus := false;
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
 nuIndex := RQPMT_100261_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100261_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100261_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100261_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100261_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100261_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100261_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100261_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100261_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100261_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100261_',
'CREATE OR REPLACE PACKAGE RQCFG_100261_ IS ' || chr(10) ||
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
'AND     external_root_id = 100261 ' || chr(10) ||
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
'END RQCFG_100261_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100261_******************************'); END;
/

BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100261_.cuCompositions;
fetch RQCFG_100261_.cuCompositions bulk collect INTO RQCFG_100261_.tbCompositions;
close RQCFG_100261_.cuCompositions;

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100261_.tbEntityName(-1) := 'NULL';
   RQCFG_100261_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100261_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100261_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100261_.tbEntityName(2014) := 'PS_PROD_MOTIVE_COMP';
   RQCFG_100261_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100261_.tbEntityName(2042) := 'PS_MOTI_COMP_ATTRIBS';
   RQCFG_100261_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(282) := 'MO_ADDRESS@ADDRESS';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(475) := 'MO_ADDRESS@GEOGRAP_LOCATION_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68342) := 'CC_SALES_FINANC_COND@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68343) := 'CC_SALES_FINANC_COND@FINANCING_PLAN_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68344) := 'CC_SALES_FINANC_COND@COMPUTE_METHOD_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68345) := 'CC_SALES_FINANC_COND@INTEREST_RATE_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68346) := 'CC_SALES_FINANC_COND@FIRST_PAY_DATE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68347) := 'CC_SALES_FINANC_COND@PERCENT_TO_FINANCE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68348) := 'CC_SALES_FINANC_COND@INTEREST_PERCENT';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68349) := 'CC_SALES_FINANC_COND@SPREAD';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68350) := 'CC_SALES_FINANC_COND@QUOTAS_NUMBER';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68351) := 'CC_SALES_FINANC_COND@TAX_FINANCING_ONE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68352) := 'CC_SALES_FINANC_COND@VALUE_TO_FINANCE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68353) := 'CC_SALES_FINANC_COND@DOCUMENT_SUPPORT';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68577) := 'CC_SALES_FINANC_COND@INITIAL_PAYMENT';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(50001351) := 'MO_PACKAGES@COMM_EXCEPTION';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009658) := 'LD_SECURE_SALE@SECURE_SALE_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009659) := 'LD_SECURE_SALE@ID_CONTRATISTA';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009660) := 'LD_SECURE_SALE@PRODUCT_LINE_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009661) := 'LD_SECURE_SALE@BORN_DATE';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009662) := 'LD_SECURE_SALE@POLICY_TYPE_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009663) := 'LD_SECURE_SALE@POLICY_NUMBER';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009664) := 'LD_SECURE_SALE@POLICY_VALUE';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009665) := 'LD_SECURE_SALE@IDENTIFICATION_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90013152) := 'LD_SECURE_SALE@CAUSAL_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_100261_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   RQCFG_100261_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90013152) := 'LD_SECURE_SALE@CAUSAL_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68351) := 'CC_SALES_FINANC_COND@TAX_FINANCING_ONE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68353) := 'CC_SALES_FINANC_COND@DOCUMENT_SUPPORT';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68342) := 'CC_SALES_FINANC_COND@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68345) := 'CC_SALES_FINANC_COND@INTEREST_RATE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009661) := 'LD_SECURE_SALE@BORN_DATE';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68348) := 'CC_SALES_FINANC_COND@INTEREST_PERCENT';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68347) := 'CC_SALES_FINANC_COND@PERCENT_TO_FINANCE';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68349) := 'CC_SALES_FINANC_COND@SPREAD';
   RQCFG_100261_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100261_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009663) := 'LD_SECURE_SALE@POLICY_NUMBER';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(50001351) := 'MO_PACKAGES@COMM_EXCEPTION';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(282) := 'MO_ADDRESS@ADDRESS';
   RQCFG_100261_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100261_.tbEntityAttributeName(475) := 'MO_ADDRESS@GEOGRAP_LOCATION_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68343) := 'CC_SALES_FINANC_COND@FINANCING_PLAN_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68346) := 'CC_SALES_FINANC_COND@FIRST_PAY_DATE';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009662) := 'LD_SECURE_SALE@POLICY_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009660) := 'LD_SECURE_SALE@PRODUCT_LINE_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009664) := 'LD_SECURE_SALE@POLICY_VALUE';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68577) := 'CC_SALES_FINANC_COND@INITIAL_PAYMENT';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68350) := 'CC_SALES_FINANC_COND@QUOTAS_NUMBER';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009659) := 'LD_SECURE_SALE@ID_CONTRATISTA';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_100261_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100261_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100261_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100261_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68352) := 'CC_SALES_FINANC_COND@VALUE_TO_FINANCE';
   RQCFG_100261_.tbEntityName(2640) := 'CC_SALES_FINANC_COND';
   RQCFG_100261_.tbEntityAttributeName(68344) := 'CC_SALES_FINANC_COND@COMPUTE_METHOD_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009658) := 'LD_SECURE_SALE@SECURE_SALE_ID';
   RQCFG_100261_.tbEntityName(8006) := 'LD_SECURE_SALE';
   RQCFG_100261_.tbEntityAttributeName(90009665) := 'LD_SECURE_SALE@IDENTIFICATION_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100261_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100261_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
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
AND     external_root_id = 100261
)
);
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100261_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100261, 4);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100261_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100261_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100261_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100261_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100261_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261))));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261)));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100261, 4);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100261_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261))));
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261))));
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261))));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261)));

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100261_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100261_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100261_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100261_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100261_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100261_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100261;

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb0_0(0):=7924;
RQCFG_100261_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100261_.tb0_0(0):=RQCFG_100261_.tb0_0(0);
RQCFG_100261_.old_tb0_2(0):=2012;
RQCFG_100261_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100261_.tb0_0(0),
100261,
RQCFG_100261_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb1_0(0):=1046560;
RQCFG_100261_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100261_.tb1_0(0):=RQCFG_100261_.tb1_0(0);
RQCFG_100261_.old_tb1_1(0):=100261;
RQCFG_100261_.tb1_1(0):=RQCFG_100261_.old_tb1_1(0);
RQCFG_100261_.old_tb1_2(0):=2012;
RQCFG_100261_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb1_2(0),-1)));
RQCFG_100261_.old_tb1_3(0):=7924;
RQCFG_100261_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb1_2(0),-1))), RQCFG_100261_.old_tb1_1(0), 4);
RQCFG_100261_.tb1_3(0):=RQCFG_100261_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100261_.tb1_0(0),
RQCFG_100261_.tb1_1(0),
RQCFG_100261_.tb1_2(0),
RQCFG_100261_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb2_0(0):=100023365;
RQCFG_100261_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100261_.tb2_0(0):=RQCFG_100261_.tb2_0(0);
RQCFG_100261_.tb2_1(0):=RQCFG_100261_.tb0_0(0);
RQCFG_100261_.tb2_2(0):=RQCFG_100261_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100261_.tb2_0(0),
RQCFG_100261_.tb2_1(0),
RQCFG_100261_.tb2_2(0),
null,
7053,
1,
1,
1);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb1_0(1):=1046561;
RQCFG_100261_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100261_.tb1_0(1):=RQCFG_100261_.tb1_0(1);
RQCFG_100261_.old_tb1_1(1):=100268;
RQCFG_100261_.tb1_1(1):=RQCFG_100261_.old_tb1_1(1);
RQCFG_100261_.old_tb1_2(1):=2013;
RQCFG_100261_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb1_2(1),-1)));
RQCFG_100261_.old_tb1_3(1):=null;
RQCFG_100261_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb1_2(1),-1))), RQCFG_100261_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100261_.tb1_0(1),
RQCFG_100261_.tb1_1(1),
RQCFG_100261_.tb1_2(1),
RQCFG_100261_.tb1_3(1),
null,
'M_INSTALACION_DEBRILLA_SEGUROS_100268'
,
1,
1,
4);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb2_0(1):=100023366;
RQCFG_100261_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100261_.tb2_0(1):=RQCFG_100261_.tb2_0(1);
RQCFG_100261_.tb2_1(1):=RQCFG_100261_.tb0_0(0);
RQCFG_100261_.tb2_2(1):=RQCFG_100261_.tb1_0(1);
RQCFG_100261_.tb2_3(1):=RQCFG_100261_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100261_.tb2_0(1),
RQCFG_100261_.tb2_1(1),
RQCFG_100261_.tb2_2(1),
RQCFG_100261_.tb2_3(1),
7053,
2,
1,
1);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb1_0(2):=1046562;
RQCFG_100261_.tb1_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100261_.tb1_0(2):=RQCFG_100261_.tb1_0(2);
RQCFG_100261_.old_tb1_1(2):=10333;
RQCFG_100261_.tb1_1(2):=RQCFG_100261_.old_tb1_1(2);
RQCFG_100261_.old_tb1_2(2):=2014;
RQCFG_100261_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb1_2(2),-1)));
RQCFG_100261_.old_tb1_3(2):=null;
RQCFG_100261_.tb1_3(2):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb1_2(2),-1))), RQCFG_100261_.old_tb1_1(2), 4);
RQCFG_100261_.tb1_4(2):=RQCFG_100261_.tb1_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100261_.tb1_0(2),
RQCFG_100261_.tb1_1(2),
RQCFG_100261_.tb1_2(2),
RQCFG_100261_.tb1_3(2),
RQCFG_100261_.tb1_4(2),
'C_BRILLA_SEGUROS_10333'
,
1,
1,
4);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb2_0(2):=100023367;
RQCFG_100261_.tb2_0(2):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100261_.tb2_0(2):=RQCFG_100261_.tb2_0(2);
RQCFG_100261_.tb2_1(2):=RQCFG_100261_.tb0_0(0);
RQCFG_100261_.tb2_2(2):=RQCFG_100261_.tb1_0(2);
RQCFG_100261_.tb2_3(2):=RQCFG_100261_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (2)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100261_.tb2_0(2),
RQCFG_100261_.tb2_1(2),
RQCFG_100261_.tb2_2(2),
RQCFG_100261_.tb2_3(2),
7053,
3,
1,
1);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(0):=1097246;
RQCFG_100261_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(0):=RQCFG_100261_.tb3_0(0);
RQCFG_100261_.old_tb3_1(0):=2042;
RQCFG_100261_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(0),-1)));
RQCFG_100261_.old_tb3_2(0):=338;
RQCFG_100261_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(0),-1)));
RQCFG_100261_.old_tb3_3(0):=null;
RQCFG_100261_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(0),-1)));
RQCFG_100261_.old_tb3_4(0):=null;
RQCFG_100261_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(0),-1)));
RQCFG_100261_.tb3_5(0):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(0):=121128850;
RQCFG_100261_.tb3_6(0):=NULL;
RQCFG_100261_.old_tb3_7(0):=null;
RQCFG_100261_.tb3_7(0):=NULL;
RQCFG_100261_.old_tb3_8(0):=null;
RQCFG_100261_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(0),
RQCFG_100261_.tb3_1(0),
RQCFG_100261_.tb3_2(0),
RQCFG_100261_.tb3_3(0),
RQCFG_100261_.tb3_4(0),
RQCFG_100261_.tb3_5(0),
RQCFG_100261_.tb3_6(0),
RQCFG_100261_.tb3_7(0),
RQCFG_100261_.tb3_8(0),
null,
105175,
0,
'Identificador del Componente Registro Componente'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb4_0(0):=95067;
RQCFG_100261_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100261_.tb4_0(0):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb4_1(0):=RQCFG_100261_.tb2_2(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100261_.tb4_0(0),
RQCFG_100261_.tb4_1(0),
null,
null,
'FRAME-C_BRILLA_SEGUROS_10333-1048956'
,
3);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(0):=1367483;
RQCFG_100261_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(0):=RQCFG_100261_.tb5_0(0);
RQCFG_100261_.old_tb5_1(0):=338;
RQCFG_100261_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(0),-1)));
RQCFG_100261_.old_tb5_2(0):=null;
RQCFG_100261_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(0),-1)));
RQCFG_100261_.tb5_3(0):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(0):=RQCFG_100261_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(0),
RQCFG_100261_.tb5_1(0),
RQCFG_100261_.tb5_2(0),
RQCFG_100261_.tb5_3(0),
RQCFG_100261_.tb5_4(0),
'C'
,
'Y'
,
0,
'Y'
,
'Identificador del Componente Registro Componente'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(1):=1097247;
RQCFG_100261_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(1):=RQCFG_100261_.tb3_0(1);
RQCFG_100261_.old_tb3_1(1):=2042;
RQCFG_100261_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(1),-1)));
RQCFG_100261_.old_tb3_2(1):=456;
RQCFG_100261_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(1),-1)));
RQCFG_100261_.old_tb3_3(1):=187;
RQCFG_100261_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(1),-1)));
RQCFG_100261_.old_tb3_4(1):=null;
RQCFG_100261_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(1),-1)));
RQCFG_100261_.tb3_5(1):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(1):=null;
RQCFG_100261_.tb3_6(1):=NULL;
RQCFG_100261_.old_tb3_7(1):=null;
RQCFG_100261_.tb3_7(1):=NULL;
RQCFG_100261_.old_tb3_8(1):=null;
RQCFG_100261_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(1),
RQCFG_100261_.tb3_1(1),
RQCFG_100261_.tb3_2(1),
RQCFG_100261_.tb3_3(1),
RQCFG_100261_.tb3_4(1),
RQCFG_100261_.tb3_5(1),
RQCFG_100261_.tb3_6(1),
RQCFG_100261_.tb3_7(1),
RQCFG_100261_.tb3_8(1),
null,
105176,
1,
'Identificador del Motivo Registro Componente'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(1):=1367484;
RQCFG_100261_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(1):=RQCFG_100261_.tb5_0(1);
RQCFG_100261_.old_tb5_1(1):=456;
RQCFG_100261_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(1),-1)));
RQCFG_100261_.old_tb5_2(1):=null;
RQCFG_100261_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(1),-1)));
RQCFG_100261_.tb5_3(1):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(1):=RQCFG_100261_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(1),
RQCFG_100261_.tb5_1(1),
RQCFG_100261_.tb5_2(1),
RQCFG_100261_.tb5_3(1),
RQCFG_100261_.tb5_4(1),
'C'
,
'Y'
,
1,
'Y'
,
'Identificador del Motivo Registro Componente'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(2):=1097248;
RQCFG_100261_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(2):=RQCFG_100261_.tb3_0(2);
RQCFG_100261_.old_tb3_1(2):=2042;
RQCFG_100261_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(2),-1)));
RQCFG_100261_.old_tb3_2(2):=696;
RQCFG_100261_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(2),-1)));
RQCFG_100261_.old_tb3_3(2):=697;
RQCFG_100261_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(2),-1)));
RQCFG_100261_.old_tb3_4(2):=null;
RQCFG_100261_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(2),-1)));
RQCFG_100261_.tb3_5(2):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(2):=null;
RQCFG_100261_.tb3_6(2):=NULL;
RQCFG_100261_.old_tb3_7(2):=null;
RQCFG_100261_.tb3_7(2):=NULL;
RQCFG_100261_.old_tb3_8(2):=null;
RQCFG_100261_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(2),
RQCFG_100261_.tb3_1(2),
RQCFG_100261_.tb3_2(2),
RQCFG_100261_.tb3_3(2),
RQCFG_100261_.tb3_4(2),
RQCFG_100261_.tb3_5(2),
RQCFG_100261_.tb3_6(2),
RQCFG_100261_.tb3_7(2),
RQCFG_100261_.tb3_8(2),
null,
105177,
2,
'Identificador del Producto Motivo'
,
'N'
,
'C'
,
'Y'
,
2,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(2):=1367485;
RQCFG_100261_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(2):=RQCFG_100261_.tb5_0(2);
RQCFG_100261_.old_tb5_1(2):=696;
RQCFG_100261_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(2),-1)));
RQCFG_100261_.old_tb5_2(2):=null;
RQCFG_100261_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(2),-1)));
RQCFG_100261_.tb5_3(2):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(2):=RQCFG_100261_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(2),
RQCFG_100261_.tb5_1(2),
RQCFG_100261_.tb5_2(2),
RQCFG_100261_.tb5_3(2),
RQCFG_100261_.tb5_4(2),
'C'
,
'Y'
,
2,
'Y'
,
'Identificador del Producto Motivo'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(3):=1097249;
RQCFG_100261_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(3):=RQCFG_100261_.tb3_0(3);
RQCFG_100261_.old_tb3_1(3):=2042;
RQCFG_100261_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(3),-1)));
RQCFG_100261_.old_tb3_2(3):=1026;
RQCFG_100261_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(3),-1)));
RQCFG_100261_.old_tb3_3(3):=null;
RQCFG_100261_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(3),-1)));
RQCFG_100261_.old_tb3_4(3):=null;
RQCFG_100261_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(3),-1)));
RQCFG_100261_.tb3_5(3):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(3):=null;
RQCFG_100261_.tb3_6(3):=NULL;
RQCFG_100261_.old_tb3_7(3):=null;
RQCFG_100261_.tb3_7(3):=NULL;
RQCFG_100261_.old_tb3_8(3):=null;
RQCFG_100261_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(3),
RQCFG_100261_.tb3_1(3),
RQCFG_100261_.tb3_2(3),
RQCFG_100261_.tb3_3(3),
RQCFG_100261_.tb3_4(3),
RQCFG_100261_.tb3_5(3),
RQCFG_100261_.tb3_6(3),
RQCFG_100261_.tb3_7(3),
RQCFG_100261_.tb3_8(3),
null,
105178,
3,
'Fecha de inicio del servicio'
,
'N'
,
'C'
,
'N'
,
3,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(3):=1367486;
RQCFG_100261_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(3):=RQCFG_100261_.tb5_0(3);
RQCFG_100261_.old_tb5_1(3):=1026;
RQCFG_100261_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(3),-1)));
RQCFG_100261_.old_tb5_2(3):=null;
RQCFG_100261_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(3),-1)));
RQCFG_100261_.tb5_3(3):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(3):=RQCFG_100261_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(3),
RQCFG_100261_.tb5_1(3),
RQCFG_100261_.tb5_2(3),
RQCFG_100261_.tb5_3(3),
RQCFG_100261_.tb5_4(3),
'C'
,
'Y'
,
3,
'N'
,
'Fecha de inicio del servicio'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(4):=1097250;
RQCFG_100261_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(4):=RQCFG_100261_.tb3_0(4);
RQCFG_100261_.old_tb3_1(4):=2042;
RQCFG_100261_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(4),-1)));
RQCFG_100261_.old_tb3_2(4):=50000937;
RQCFG_100261_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(4),-1)));
RQCFG_100261_.old_tb3_3(4):=255;
RQCFG_100261_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(4),-1)));
RQCFG_100261_.old_tb3_4(4):=null;
RQCFG_100261_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(4),-1)));
RQCFG_100261_.tb3_5(4):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(4):=null;
RQCFG_100261_.tb3_6(4):=NULL;
RQCFG_100261_.old_tb3_7(4):=null;
RQCFG_100261_.tb3_7(4):=NULL;
RQCFG_100261_.old_tb3_8(4):=null;
RQCFG_100261_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(4),
RQCFG_100261_.tb3_1(4),
RQCFG_100261_.tb3_2(4),
RQCFG_100261_.tb3_3(4),
RQCFG_100261_.tb3_4(4),
RQCFG_100261_.tb3_5(4),
RQCFG_100261_.tb3_6(4),
RQCFG_100261_.tb3_7(4),
RQCFG_100261_.tb3_8(4),
null,
105179,
4,
'PACKAGE_ID'
,
'N'
,
'N'
,
'N'
,
4,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(4):=1367487;
RQCFG_100261_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(4):=RQCFG_100261_.tb5_0(4);
RQCFG_100261_.old_tb5_1(4):=50000937;
RQCFG_100261_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(4),-1)));
RQCFG_100261_.old_tb5_2(4):=null;
RQCFG_100261_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(4),-1)));
RQCFG_100261_.tb5_3(4):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(4):=RQCFG_100261_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(4),
RQCFG_100261_.tb5_1(4),
RQCFG_100261_.tb5_2(4),
RQCFG_100261_.tb5_3(4),
RQCFG_100261_.tb5_4(4),
'N'
,
'N'
,
4,
'N'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(5):=1097251;
RQCFG_100261_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(5):=RQCFG_100261_.tb3_0(5);
RQCFG_100261_.old_tb3_1(5):=2042;
RQCFG_100261_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(5),-1)));
RQCFG_100261_.old_tb3_2(5):=50000936;
RQCFG_100261_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(5),-1)));
RQCFG_100261_.old_tb3_3(5):=null;
RQCFG_100261_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(5),-1)));
RQCFG_100261_.old_tb3_4(5):=null;
RQCFG_100261_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(5),-1)));
RQCFG_100261_.tb3_5(5):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(5):=null;
RQCFG_100261_.tb3_6(5):=NULL;
RQCFG_100261_.old_tb3_7(5):=null;
RQCFG_100261_.tb3_7(5):=NULL;
RQCFG_100261_.old_tb3_8(5):=null;
RQCFG_100261_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(5),
RQCFG_100261_.tb3_1(5),
RQCFG_100261_.tb3_2(5),
RQCFG_100261_.tb3_3(5),
RQCFG_100261_.tb3_4(5),
RQCFG_100261_.tb3_5(5),
RQCFG_100261_.tb3_6(5),
RQCFG_100261_.tb3_7(5),
RQCFG_100261_.tb3_8(5),
null,
105180,
5,
'PRODUCT_ID'
,
'N'
,
'N'
,
'N'
,
5,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(5):=1367488;
RQCFG_100261_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(5):=RQCFG_100261_.tb5_0(5);
RQCFG_100261_.old_tb5_1(5):=50000936;
RQCFG_100261_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(5),-1)));
RQCFG_100261_.old_tb5_2(5):=null;
RQCFG_100261_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(5),-1)));
RQCFG_100261_.tb5_3(5):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(5):=RQCFG_100261_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(5),
RQCFG_100261_.tb5_1(5),
RQCFG_100261_.tb5_2(5),
RQCFG_100261_.tb5_3(5),
RQCFG_100261_.tb5_4(5),
'N'
,
'N'
,
5,
'N'
,
'PRODUCT_ID'
,
'N'
,
'N'
,
'M'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(6):=1097252;
RQCFG_100261_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(6):=RQCFG_100261_.tb3_0(6);
RQCFG_100261_.old_tb3_1(6):=2042;
RQCFG_100261_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(6),-1)));
RQCFG_100261_.old_tb3_2(6):=4013;
RQCFG_100261_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(6),-1)));
RQCFG_100261_.old_tb3_3(6):=null;
RQCFG_100261_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(6),-1)));
RQCFG_100261_.old_tb3_4(6):=null;
RQCFG_100261_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(6),-1)));
RQCFG_100261_.tb3_5(6):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(6):=null;
RQCFG_100261_.tb3_6(6):=NULL;
RQCFG_100261_.old_tb3_7(6):=null;
RQCFG_100261_.tb3_7(6):=NULL;
RQCFG_100261_.old_tb3_8(6):=null;
RQCFG_100261_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(6),
RQCFG_100261_.tb3_1(6),
RQCFG_100261_.tb3_2(6),
RQCFG_100261_.tb3_3(6),
RQCFG_100261_.tb3_4(6),
RQCFG_100261_.tb3_5(6),
RQCFG_100261_.tb3_6(6),
RQCFG_100261_.tb3_7(6),
RQCFG_100261_.tb3_8(6),
null,
105181,
6,
'SERVICE_NUMBER'
,
'N'
,
'N'
,
'N'
,
6,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(6):=1367489;
RQCFG_100261_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(6):=RQCFG_100261_.tb5_0(6);
RQCFG_100261_.old_tb5_1(6):=4013;
RQCFG_100261_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(6),-1)));
RQCFG_100261_.old_tb5_2(6):=null;
RQCFG_100261_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(6),-1)));
RQCFG_100261_.tb5_3(6):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(6):=RQCFG_100261_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(6),
RQCFG_100261_.tb5_1(6),
RQCFG_100261_.tb5_2(6),
RQCFG_100261_.tb5_3(6),
RQCFG_100261_.tb5_4(6),
'N'
,
'N'
,
6,
'N'
,
'SERVICE_NUMBER'
,
'N'
,
'N'
,
'M'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(7):=1097253;
RQCFG_100261_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(7):=RQCFG_100261_.tb3_0(7);
RQCFG_100261_.old_tb3_1(7):=2042;
RQCFG_100261_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(7),-1)));
RQCFG_100261_.old_tb3_2(7):=362;
RQCFG_100261_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(7),-1)));
RQCFG_100261_.old_tb3_3(7):=null;
RQCFG_100261_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(7),-1)));
RQCFG_100261_.old_tb3_4(7):=null;
RQCFG_100261_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(7),-1)));
RQCFG_100261_.tb3_5(7):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(7):=null;
RQCFG_100261_.tb3_6(7):=NULL;
RQCFG_100261_.old_tb3_7(7):=null;
RQCFG_100261_.tb3_7(7):=NULL;
RQCFG_100261_.old_tb3_8(7):=null;
RQCFG_100261_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(7),
RQCFG_100261_.tb3_1(7),
RQCFG_100261_.tb3_2(7),
RQCFG_100261_.tb3_3(7),
RQCFG_100261_.tb3_4(7),
RQCFG_100261_.tb3_5(7),
RQCFG_100261_.tb3_6(7),
RQCFG_100261_.tb3_7(7),
RQCFG_100261_.tb3_8(7),
null,
105182,
7,
'MOTIVE_TYPE_ID'
,
'N'
,
'N'
,
'N'
,
7,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(7):=1367490;
RQCFG_100261_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(7):=RQCFG_100261_.tb5_0(7);
RQCFG_100261_.old_tb5_1(7):=362;
RQCFG_100261_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(7),-1)));
RQCFG_100261_.old_tb5_2(7):=null;
RQCFG_100261_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(7),-1)));
RQCFG_100261_.tb5_3(7):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(7):=RQCFG_100261_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(7),
RQCFG_100261_.tb5_1(7),
RQCFG_100261_.tb5_2(7),
RQCFG_100261_.tb5_3(7),
RQCFG_100261_.tb5_4(7),
'N'
,
'N'
,
7,
'N'
,
'MOTIVE_TYPE_ID'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(8):=1097254;
RQCFG_100261_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(8):=RQCFG_100261_.tb3_0(8);
RQCFG_100261_.old_tb3_1(8):=2042;
RQCFG_100261_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(8),-1)));
RQCFG_100261_.old_tb3_2(8):=361;
RQCFG_100261_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(8),-1)));
RQCFG_100261_.old_tb3_3(8):=null;
RQCFG_100261_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(8),-1)));
RQCFG_100261_.old_tb3_4(8):=null;
RQCFG_100261_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(8),-1)));
RQCFG_100261_.tb3_5(8):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(8):=null;
RQCFG_100261_.tb3_6(8):=NULL;
RQCFG_100261_.old_tb3_7(8):=null;
RQCFG_100261_.tb3_7(8):=NULL;
RQCFG_100261_.old_tb3_8(8):=null;
RQCFG_100261_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(8),
RQCFG_100261_.tb3_1(8),
RQCFG_100261_.tb3_2(8),
RQCFG_100261_.tb3_3(8),
RQCFG_100261_.tb3_4(8),
RQCFG_100261_.tb3_5(8),
RQCFG_100261_.tb3_6(8),
RQCFG_100261_.tb3_7(8),
RQCFG_100261_.tb3_8(8),
null,
105183,
8,
'COMPONENT_TYPE_ID'
,
'N'
,
'N'
,
'N'
,
8,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(8):=1367491;
RQCFG_100261_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(8):=RQCFG_100261_.tb5_0(8);
RQCFG_100261_.old_tb5_1(8):=361;
RQCFG_100261_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(8),-1)));
RQCFG_100261_.old_tb5_2(8):=null;
RQCFG_100261_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(8),-1)));
RQCFG_100261_.tb5_3(8):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(8):=RQCFG_100261_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(8),
RQCFG_100261_.tb5_1(8),
RQCFG_100261_.tb5_2(8),
RQCFG_100261_.tb5_3(8),
RQCFG_100261_.tb5_4(8),
'N'
,
'N'
,
8,
'N'
,
'COMPONENT_TYPE_ID'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(9):=1097255;
RQCFG_100261_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(9):=RQCFG_100261_.tb3_0(9);
RQCFG_100261_.old_tb3_1(9):=2042;
RQCFG_100261_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(9),-1)));
RQCFG_100261_.old_tb3_2(9):=355;
RQCFG_100261_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(9),-1)));
RQCFG_100261_.old_tb3_3(9):=null;
RQCFG_100261_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(9),-1)));
RQCFG_100261_.old_tb3_4(9):=null;
RQCFG_100261_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(9),-1)));
RQCFG_100261_.tb3_5(9):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(9):=null;
RQCFG_100261_.tb3_6(9):=NULL;
RQCFG_100261_.old_tb3_7(9):=null;
RQCFG_100261_.tb3_7(9):=NULL;
RQCFG_100261_.old_tb3_8(9):=null;
RQCFG_100261_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(9),
RQCFG_100261_.tb3_1(9),
RQCFG_100261_.tb3_2(9),
RQCFG_100261_.tb3_3(9),
RQCFG_100261_.tb3_4(9),
RQCFG_100261_.tb3_5(9),
RQCFG_100261_.tb3_6(9),
RQCFG_100261_.tb3_7(9),
RQCFG_100261_.tb3_8(9),
null,
105184,
9,
'DISTRICT_ID'
,
'N'
,
'N'
,
'N'
,
9,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(9):=1367492;
RQCFG_100261_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(9):=RQCFG_100261_.tb5_0(9);
RQCFG_100261_.old_tb5_1(9):=355;
RQCFG_100261_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(9),-1)));
RQCFG_100261_.old_tb5_2(9):=null;
RQCFG_100261_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(9),-1)));
RQCFG_100261_.tb5_3(9):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(9):=RQCFG_100261_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(9),
RQCFG_100261_.tb5_1(9),
RQCFG_100261_.tb5_2(9),
RQCFG_100261_.tb5_3(9),
RQCFG_100261_.tb5_4(9),
'N'
,
'N'
,
9,
'N'
,
'DISTRICT_ID'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(10):=1097256;
RQCFG_100261_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(10):=RQCFG_100261_.tb3_0(10);
RQCFG_100261_.old_tb3_1(10):=2042;
RQCFG_100261_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(10),-1)));
RQCFG_100261_.old_tb3_2(10):=1801;
RQCFG_100261_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(10),-1)));
RQCFG_100261_.old_tb3_3(10):=null;
RQCFG_100261_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(10),-1)));
RQCFG_100261_.old_tb3_4(10):=null;
RQCFG_100261_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(10),-1)));
RQCFG_100261_.tb3_5(10):=RQCFG_100261_.tb2_2(2);
RQCFG_100261_.old_tb3_6(10):=null;
RQCFG_100261_.tb3_6(10):=NULL;
RQCFG_100261_.old_tb3_7(10):=null;
RQCFG_100261_.tb3_7(10):=NULL;
RQCFG_100261_.old_tb3_8(10):=120071877;
RQCFG_100261_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(10),
RQCFG_100261_.tb3_1(10),
RQCFG_100261_.tb3_2(10),
RQCFG_100261_.tb3_3(10),
RQCFG_100261_.tb3_4(10),
RQCFG_100261_.tb3_5(10),
RQCFG_100261_.tb3_6(10),
RQCFG_100261_.tb3_7(10),
RQCFG_100261_.tb3_8(10),
null,
105185,
10,
'Alternativa'
,
'N'
,
'N'
,
'N'
,
10,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(10):=1367493;
RQCFG_100261_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(10):=RQCFG_100261_.tb5_0(10);
RQCFG_100261_.old_tb5_1(10):=1801;
RQCFG_100261_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(10),-1)));
RQCFG_100261_.old_tb5_2(10):=null;
RQCFG_100261_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(10),-1)));
RQCFG_100261_.tb5_3(10):=RQCFG_100261_.tb4_0(0);
RQCFG_100261_.tb5_4(10):=RQCFG_100261_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(10),
RQCFG_100261_.tb5_1(10),
RQCFG_100261_.tb5_2(10),
RQCFG_100261_.tb5_3(10),
RQCFG_100261_.tb5_4(10),
'N'
,
'Y'
,
10,
'N'
,
'Alternativa'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(11):=1097257;
RQCFG_100261_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(11):=RQCFG_100261_.tb3_0(11);
RQCFG_100261_.old_tb3_1(11):=3334;
RQCFG_100261_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(11),-1)));
RQCFG_100261_.old_tb3_2(11):=147336;
RQCFG_100261_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(11),-1)));
RQCFG_100261_.old_tb3_3(11):=440;
RQCFG_100261_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(11),-1)));
RQCFG_100261_.old_tb3_4(11):=null;
RQCFG_100261_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(11),-1)));
RQCFG_100261_.tb3_5(11):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(11):=null;
RQCFG_100261_.tb3_6(11):=NULL;
RQCFG_100261_.old_tb3_7(11):=null;
RQCFG_100261_.tb3_7(11):=NULL;
RQCFG_100261_.old_tb3_8(11):=null;
RQCFG_100261_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(11),
RQCFG_100261_.tb3_1(11),
RQCFG_100261_.tb3_2(11),
RQCFG_100261_.tb3_3(11),
RQCFG_100261_.tb3_4(11),
RQCFG_100261_.tb3_5(11),
RQCFG_100261_.tb3_6(11),
RQCFG_100261_.tb3_7(11),
RQCFG_100261_.tb3_8(11),
null,
103759,
30,
'Categoría'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb4_0(1):=95068;
RQCFG_100261_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100261_.tb4_0(1):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb4_1(1):=RQCFG_100261_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100261_.tb4_0(1),
RQCFG_100261_.tb4_1(1),
null,
null,
'FRAME-M_INSTALACION_DEBRILLA_SEGUROS_100268-1048955'
,
2);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(11):=1367494;
RQCFG_100261_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(11):=RQCFG_100261_.tb5_0(11);
RQCFG_100261_.old_tb5_1(11):=147336;
RQCFG_100261_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(11),-1)));
RQCFG_100261_.old_tb5_2(11):=null;
RQCFG_100261_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(11),-1)));
RQCFG_100261_.tb5_3(11):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(11):=RQCFG_100261_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(11),
RQCFG_100261_.tb5_1(11),
RQCFG_100261_.tb5_2(11),
RQCFG_100261_.tb5_3(11),
RQCFG_100261_.tb5_4(11),
'C'
,
'Y'
,
30,
'N'
,
'Categoría'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(12):=1097258;
RQCFG_100261_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(12):=RQCFG_100261_.tb3_0(12);
RQCFG_100261_.old_tb3_1(12):=3334;
RQCFG_100261_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(12),-1)));
RQCFG_100261_.old_tb3_2(12):=147337;
RQCFG_100261_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(12),-1)));
RQCFG_100261_.old_tb3_3(12):=441;
RQCFG_100261_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(12),-1)));
RQCFG_100261_.old_tb3_4(12):=null;
RQCFG_100261_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(12),-1)));
RQCFG_100261_.tb3_5(12):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(12):=null;
RQCFG_100261_.tb3_6(12):=NULL;
RQCFG_100261_.old_tb3_7(12):=null;
RQCFG_100261_.tb3_7(12):=NULL;
RQCFG_100261_.old_tb3_8(12):=null;
RQCFG_100261_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(12),
RQCFG_100261_.tb3_1(12),
RQCFG_100261_.tb3_2(12),
RQCFG_100261_.tb3_3(12),
RQCFG_100261_.tb3_4(12),
RQCFG_100261_.tb3_5(12),
RQCFG_100261_.tb3_6(12),
RQCFG_100261_.tb3_7(12),
RQCFG_100261_.tb3_8(12),
null,
103760,
31,
'Subcategoría'
,
'N'
,
'C'
,
'N'
,
31,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(12):=1367495;
RQCFG_100261_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(12):=RQCFG_100261_.tb5_0(12);
RQCFG_100261_.old_tb5_1(12):=147337;
RQCFG_100261_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(12),-1)));
RQCFG_100261_.old_tb5_2(12):=null;
RQCFG_100261_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(12),-1)));
RQCFG_100261_.tb5_3(12):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(12):=RQCFG_100261_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(12),
RQCFG_100261_.tb5_1(12),
RQCFG_100261_.tb5_2(12),
RQCFG_100261_.tb5_3(12),
RQCFG_100261_.tb5_4(12),
'C'
,
'Y'
,
31,
'N'
,
'Subcategoría'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(13):=1097259;
RQCFG_100261_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(13):=RQCFG_100261_.tb3_0(13);
RQCFG_100261_.old_tb3_1(13):=3334;
RQCFG_100261_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(13),-1)));
RQCFG_100261_.old_tb3_2(13):=90013152;
RQCFG_100261_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(13),-1)));
RQCFG_100261_.old_tb3_3(13):=null;
RQCFG_100261_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(13),-1)));
RQCFG_100261_.old_tb3_4(13):=null;
RQCFG_100261_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(13),-1)));
RQCFG_100261_.tb3_5(13):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(13):=null;
RQCFG_100261_.tb3_6(13):=NULL;
RQCFG_100261_.old_tb3_7(13):=null;
RQCFG_100261_.tb3_7(13):=NULL;
RQCFG_100261_.old_tb3_8(13):=null;
RQCFG_100261_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(13),
RQCFG_100261_.tb3_1(13),
RQCFG_100261_.tb3_2(13),
RQCFG_100261_.tb3_3(13),
RQCFG_100261_.tb3_4(13),
RQCFG_100261_.tb3_5(13),
RQCFG_100261_.tb3_6(13),
RQCFG_100261_.tb3_7(13),
RQCFG_100261_.tb3_8(13),
null,
103198,
4,
'Causal de cumplimiento o incumplimiento'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(13):=1367496;
RQCFG_100261_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(13):=RQCFG_100261_.tb5_0(13);
RQCFG_100261_.old_tb5_1(13):=90013152;
RQCFG_100261_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(13),-1)));
RQCFG_100261_.old_tb5_2(13):=null;
RQCFG_100261_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(13),-1)));
RQCFG_100261_.tb5_3(13):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(13):=RQCFG_100261_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(13),
RQCFG_100261_.tb5_1(13),
RQCFG_100261_.tb5_2(13),
RQCFG_100261_.tb5_3(13),
RQCFG_100261_.tb5_4(13),
'C'
,
'Y'
,
4,
'N'
,
'Causal de cumplimiento o incumplimiento'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(14):=1097260;
RQCFG_100261_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(14):=RQCFG_100261_.tb3_0(14);
RQCFG_100261_.old_tb3_1(14):=3334;
RQCFG_100261_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(14),-1)));
RQCFG_100261_.old_tb3_2(14):=90009658;
RQCFG_100261_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(14),-1)));
RQCFG_100261_.old_tb3_3(14):=255;
RQCFG_100261_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(14),-1)));
RQCFG_100261_.old_tb3_4(14):=null;
RQCFG_100261_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(14),-1)));
RQCFG_100261_.tb3_5(14):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(14):=null;
RQCFG_100261_.tb3_6(14):=NULL;
RQCFG_100261_.old_tb3_7(14):=null;
RQCFG_100261_.tb3_7(14):=NULL;
RQCFG_100261_.old_tb3_8(14):=null;
RQCFG_100261_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(14),
RQCFG_100261_.tb3_1(14),
RQCFG_100261_.tb3_2(14),
RQCFG_100261_.tb3_3(14),
RQCFG_100261_.tb3_4(14),
RQCFG_100261_.tb3_5(14),
RQCFG_100261_.tb3_6(14),
RQCFG_100261_.tb3_7(14),
RQCFG_100261_.tb3_8(14),
null,
103782,
0,
'C¿digo de la solicitud'
,
'N'
,
'C'
,
'N'
,
0,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(14):=1367497;
RQCFG_100261_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(14):=RQCFG_100261_.tb5_0(14);
RQCFG_100261_.old_tb5_1(14):=90009658;
RQCFG_100261_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(14),-1)));
RQCFG_100261_.old_tb5_2(14):=null;
RQCFG_100261_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(14),-1)));
RQCFG_100261_.tb5_3(14):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(14):=RQCFG_100261_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(14),
RQCFG_100261_.tb5_1(14),
RQCFG_100261_.tb5_2(14),
RQCFG_100261_.tb5_3(14),
RQCFG_100261_.tb5_4(14),
'C'
,
'Y'
,
0,
'N'
,
'C¿digo de la solicitud'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(15):=1097261;
RQCFG_100261_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(15):=RQCFG_100261_.tb3_0(15);
RQCFG_100261_.old_tb3_1(15):=3334;
RQCFG_100261_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(15),-1)));
RQCFG_100261_.old_tb3_2(15):=90009659;
RQCFG_100261_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(15),-1)));
RQCFG_100261_.old_tb3_3(15):=null;
RQCFG_100261_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(15),-1)));
RQCFG_100261_.old_tb3_4(15):=null;
RQCFG_100261_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(15),-1)));
RQCFG_100261_.tb3_5(15):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(15):=null;
RQCFG_100261_.tb3_6(15):=NULL;
RQCFG_100261_.old_tb3_7(15):=null;
RQCFG_100261_.tb3_7(15):=NULL;
RQCFG_100261_.old_tb3_8(15):=120071873;
RQCFG_100261_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(15),
RQCFG_100261_.tb3_1(15),
RQCFG_100261_.tb3_2(15),
RQCFG_100261_.tb3_3(15),
RQCFG_100261_.tb3_4(15),
RQCFG_100261_.tb3_5(15),
RQCFG_100261_.tb3_6(15),
RQCFG_100261_.tb3_7(15),
RQCFG_100261_.tb3_8(15),
null,
103783,
2,
'Aseguradora'
,
'N'
,
'C'
,
'Y'
,
2,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(15):=1367498;
RQCFG_100261_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(15):=RQCFG_100261_.tb5_0(15);
RQCFG_100261_.old_tb5_1(15):=90009659;
RQCFG_100261_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(15),-1)));
RQCFG_100261_.old_tb5_2(15):=null;
RQCFG_100261_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(15),-1)));
RQCFG_100261_.tb5_3(15):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(15):=RQCFG_100261_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(15),
RQCFG_100261_.tb5_1(15),
RQCFG_100261_.tb5_2(15),
RQCFG_100261_.tb5_3(15),
RQCFG_100261_.tb5_4(15),
'C'
,
'Y'
,
2,
'Y'
,
'Aseguradora'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(16):=1097262;
RQCFG_100261_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(16):=RQCFG_100261_.tb3_0(16);
RQCFG_100261_.old_tb3_1(16):=3334;
RQCFG_100261_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(16),-1)));
RQCFG_100261_.old_tb3_2(16):=90009665;
RQCFG_100261_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(16),-1)));
RQCFG_100261_.old_tb3_3(16):=null;
RQCFG_100261_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(16),-1)));
RQCFG_100261_.old_tb3_4(16):=null;
RQCFG_100261_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(16),-1)));
RQCFG_100261_.tb3_5(16):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(16):=null;
RQCFG_100261_.tb3_6(16):=NULL;
RQCFG_100261_.old_tb3_7(16):=null;
RQCFG_100261_.tb3_7(16):=NULL;
RQCFG_100261_.old_tb3_8(16):=null;
RQCFG_100261_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(16),
RQCFG_100261_.tb3_1(16),
RQCFG_100261_.tb3_2(16),
RQCFG_100261_.tb3_3(16),
RQCFG_100261_.tb3_4(16),
RQCFG_100261_.tb3_5(16),
RQCFG_100261_.tb3_6(16),
RQCFG_100261_.tb3_7(16),
RQCFG_100261_.tb3_8(16),
null,
103784,
3,
'Informacion del asegurado'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(16):=1367499;
RQCFG_100261_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(16):=RQCFG_100261_.tb5_0(16);
RQCFG_100261_.old_tb5_1(16):=90009665;
RQCFG_100261_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(16),-1)));
RQCFG_100261_.old_tb5_2(16):=null;
RQCFG_100261_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(16),-1)));
RQCFG_100261_.tb5_3(16):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(16):=RQCFG_100261_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(16),
RQCFG_100261_.tb5_1(16),
RQCFG_100261_.tb5_2(16),
RQCFG_100261_.tb5_3(16),
RQCFG_100261_.tb5_4(16),
'C'
,
'Y'
,
3,
'Y'
,
'Informacion del asegurado'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(17):=1097263;
RQCFG_100261_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(17):=RQCFG_100261_.tb3_0(17);
RQCFG_100261_.old_tb3_1(17):=3334;
RQCFG_100261_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(17),-1)));
RQCFG_100261_.old_tb3_2(17):=90009660;
RQCFG_100261_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(17),-1)));
RQCFG_100261_.old_tb3_3(17):=null;
RQCFG_100261_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(17),-1)));
RQCFG_100261_.old_tb3_4(17):=null;
RQCFG_100261_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(17),-1)));
RQCFG_100261_.tb3_5(17):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(17):=null;
RQCFG_100261_.tb3_6(17):=NULL;
RQCFG_100261_.old_tb3_7(17):=null;
RQCFG_100261_.tb3_7(17):=NULL;
RQCFG_100261_.old_tb3_8(17):=120071874;
RQCFG_100261_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(17),
RQCFG_100261_.tb3_1(17),
RQCFG_100261_.tb3_2(17),
RQCFG_100261_.tb3_3(17),
RQCFG_100261_.tb3_4(17),
RQCFG_100261_.tb3_5(17),
RQCFG_100261_.tb3_6(17),
RQCFG_100261_.tb3_7(17),
RQCFG_100261_.tb3_8(17),
null,
103785,
5,
'Linea del producto'
,
'N'
,
'C'
,
'N'
,
5,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(17):=1367500;
RQCFG_100261_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(17):=RQCFG_100261_.tb5_0(17);
RQCFG_100261_.old_tb5_1(17):=90009660;
RQCFG_100261_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(17),-1)));
RQCFG_100261_.old_tb5_2(17):=null;
RQCFG_100261_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(17),-1)));
RQCFG_100261_.tb5_3(17):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(17):=RQCFG_100261_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(17),
RQCFG_100261_.tb5_1(17),
RQCFG_100261_.tb5_2(17),
RQCFG_100261_.tb5_3(17),
RQCFG_100261_.tb5_4(17),
'C'
,
'N'
,
5,
'N'
,
'Linea del producto'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(18):=1097264;
RQCFG_100261_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(18):=RQCFG_100261_.tb3_0(18);
RQCFG_100261_.old_tb3_1(18):=3334;
RQCFG_100261_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(18),-1)));
RQCFG_100261_.old_tb3_2(18):=90009661;
RQCFG_100261_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(18),-1)));
RQCFG_100261_.old_tb3_3(18):=null;
RQCFG_100261_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(18),-1)));
RQCFG_100261_.old_tb3_4(18):=null;
RQCFG_100261_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(18),-1)));
RQCFG_100261_.tb3_5(18):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(18):=null;
RQCFG_100261_.tb3_6(18):=NULL;
RQCFG_100261_.old_tb3_7(18):=121128843;
RQCFG_100261_.tb3_7(18):=NULL;
RQCFG_100261_.old_tb3_8(18):=null;
RQCFG_100261_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(18),
RQCFG_100261_.tb3_1(18),
RQCFG_100261_.tb3_2(18),
RQCFG_100261_.tb3_3(18),
RQCFG_100261_.tb3_4(18),
RQCFG_100261_.tb3_5(18),
RQCFG_100261_.tb3_6(18),
RQCFG_100261_.tb3_7(18),
RQCFG_100261_.tb3_8(18),
null,
103786,
6,
'Fecha de nacimiento'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(18):=1367501;
RQCFG_100261_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(18):=RQCFG_100261_.tb5_0(18);
RQCFG_100261_.old_tb5_1(18):=90009661;
RQCFG_100261_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(18),-1)));
RQCFG_100261_.old_tb5_2(18):=null;
RQCFG_100261_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(18),-1)));
RQCFG_100261_.tb5_3(18):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(18):=RQCFG_100261_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(18),
RQCFG_100261_.tb5_1(18),
RQCFG_100261_.tb5_2(18),
RQCFG_100261_.tb5_3(18),
RQCFG_100261_.tb5_4(18),
'C'
,
'Y'
,
6,
'Y'
,
'Fecha de nacimiento'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(19):=1097265;
RQCFG_100261_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(19):=RQCFG_100261_.tb3_0(19);
RQCFG_100261_.old_tb3_1(19):=3334;
RQCFG_100261_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(19),-1)));
RQCFG_100261_.old_tb3_2(19):=90009662;
RQCFG_100261_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(19),-1)));
RQCFG_100261_.old_tb3_3(19):=null;
RQCFG_100261_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(19),-1)));
RQCFG_100261_.old_tb3_4(19):=null;
RQCFG_100261_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(19),-1)));
RQCFG_100261_.tb3_5(19):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(19):=null;
RQCFG_100261_.tb3_6(19):=NULL;
RQCFG_100261_.old_tb3_7(19):=121128844;
RQCFG_100261_.tb3_7(19):=NULL;
RQCFG_100261_.old_tb3_8(19):=120071875;
RQCFG_100261_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(19),
RQCFG_100261_.tb3_1(19),
RQCFG_100261_.tb3_2(19),
RQCFG_100261_.tb3_3(19),
RQCFG_100261_.tb3_4(19),
RQCFG_100261_.tb3_5(19),
RQCFG_100261_.tb3_6(19),
RQCFG_100261_.tb3_7(19),
RQCFG_100261_.tb3_8(19),
null,
103787,
7,
'Tipo de poliza'
,
'N'
,
'C'
,
'N'
,
7,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(19):=1367502;
RQCFG_100261_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(19):=RQCFG_100261_.tb5_0(19);
RQCFG_100261_.old_tb5_1(19):=90009662;
RQCFG_100261_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(19),-1)));
RQCFG_100261_.old_tb5_2(19):=null;
RQCFG_100261_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(19),-1)));
RQCFG_100261_.tb5_3(19):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(19):=RQCFG_100261_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(19),
RQCFG_100261_.tb5_1(19),
RQCFG_100261_.tb5_2(19),
RQCFG_100261_.tb5_3(19),
RQCFG_100261_.tb5_4(19),
'C'
,
'Y'
,
7,
'N'
,
'Tipo de poliza'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(20):=1097266;
RQCFG_100261_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(20):=RQCFG_100261_.tb3_0(20);
RQCFG_100261_.old_tb3_1(20):=3334;
RQCFG_100261_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(20),-1)));
RQCFG_100261_.old_tb3_2(20):=90009663;
RQCFG_100261_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(20),-1)));
RQCFG_100261_.old_tb3_3(20):=null;
RQCFG_100261_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(20),-1)));
RQCFG_100261_.old_tb3_4(20):=null;
RQCFG_100261_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(20),-1)));
RQCFG_100261_.tb3_5(20):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(20):=null;
RQCFG_100261_.tb3_6(20):=NULL;
RQCFG_100261_.old_tb3_7(20):=121128845;
RQCFG_100261_.tb3_7(20):=NULL;
RQCFG_100261_.old_tb3_8(20):=null;
RQCFG_100261_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(20),
RQCFG_100261_.tb3_1(20),
RQCFG_100261_.tb3_2(20),
RQCFG_100261_.tb3_3(20),
RQCFG_100261_.tb3_4(20),
RQCFG_100261_.tb3_5(20),
RQCFG_100261_.tb3_6(20),
RQCFG_100261_.tb3_7(20),
RQCFG_100261_.tb3_8(20),
null,
103788,
8,
'Número de poliza'
,
'N'
,
'C'
,
'N'
,
8,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(20):=1367503;
RQCFG_100261_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(20):=RQCFG_100261_.tb5_0(20);
RQCFG_100261_.old_tb5_1(20):=90009663;
RQCFG_100261_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(20),-1)));
RQCFG_100261_.old_tb5_2(20):=null;
RQCFG_100261_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(20),-1)));
RQCFG_100261_.tb5_3(20):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(20):=RQCFG_100261_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(20),
RQCFG_100261_.tb5_1(20),
RQCFG_100261_.tb5_2(20),
RQCFG_100261_.tb5_3(20),
RQCFG_100261_.tb5_4(20),
'C'
,
'N'
,
8,
'N'
,
'Número de poliza'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(21):=1097267;
RQCFG_100261_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(21):=RQCFG_100261_.tb3_0(21);
RQCFG_100261_.old_tb3_1(21):=3334;
RQCFG_100261_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(21),-1)));
RQCFG_100261_.old_tb3_2(21):=90009664;
RQCFG_100261_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(21),-1)));
RQCFG_100261_.old_tb3_3(21):=null;
RQCFG_100261_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(21),-1)));
RQCFG_100261_.old_tb3_4(21):=null;
RQCFG_100261_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(21),-1)));
RQCFG_100261_.tb3_5(21):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(21):=null;
RQCFG_100261_.tb3_6(21):=NULL;
RQCFG_100261_.old_tb3_7(21):=null;
RQCFG_100261_.tb3_7(21):=NULL;
RQCFG_100261_.old_tb3_8(21):=null;
RQCFG_100261_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(21),
RQCFG_100261_.tb3_1(21),
RQCFG_100261_.tb3_2(21),
RQCFG_100261_.tb3_3(21),
RQCFG_100261_.tb3_4(21),
RQCFG_100261_.tb3_5(21),
RQCFG_100261_.tb3_6(21),
RQCFG_100261_.tb3_7(21),
RQCFG_100261_.tb3_8(21),
null,
103789,
9,
'Valor de la poliza'
,
'N'
,
'C'
,
'N'
,
9,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(21):=1367504;
RQCFG_100261_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(21):=RQCFG_100261_.tb5_0(21);
RQCFG_100261_.old_tb5_1(21):=90009664;
RQCFG_100261_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(21),-1)));
RQCFG_100261_.old_tb5_2(21):=null;
RQCFG_100261_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(21),-1)));
RQCFG_100261_.tb5_3(21):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(21):=RQCFG_100261_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(21),
RQCFG_100261_.tb5_1(21),
RQCFG_100261_.tb5_2(21),
RQCFG_100261_.tb5_3(21),
RQCFG_100261_.tb5_4(21),
'C'
,
'N'
,
9,
'N'
,
'Valor de la poliza'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(22):=1097268;
RQCFG_100261_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(22):=RQCFG_100261_.tb3_0(22);
RQCFG_100261_.old_tb3_1(22):=3334;
RQCFG_100261_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(22),-1)));
RQCFG_100261_.old_tb3_2(22):=144591;
RQCFG_100261_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(22),-1)));
RQCFG_100261_.old_tb3_3(22):=null;
RQCFG_100261_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(22),-1)));
RQCFG_100261_.old_tb3_4(22):=null;
RQCFG_100261_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(22),-1)));
RQCFG_100261_.tb3_5(22):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(22):=null;
RQCFG_100261_.tb3_6(22):=NULL;
RQCFG_100261_.old_tb3_7(22):=null;
RQCFG_100261_.tb3_7(22):=NULL;
RQCFG_100261_.old_tb3_8(22):=120071876;
RQCFG_100261_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(22),
RQCFG_100261_.tb3_1(22),
RQCFG_100261_.tb3_2(22),
RQCFG_100261_.tb3_3(22),
RQCFG_100261_.tb3_4(22),
RQCFG_100261_.tb3_5(22),
RQCFG_100261_.tb3_6(22),
RQCFG_100261_.tb3_7(22),
RQCFG_100261_.tb3_8(22),
null,
103790,
10,
'Respuesta '
,
'N'
,
'C'
,
'N'
,
10,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(22):=1367505;
RQCFG_100261_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(22):=RQCFG_100261_.tb5_0(22);
RQCFG_100261_.old_tb5_1(22):=144591;
RQCFG_100261_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(22),-1)));
RQCFG_100261_.old_tb5_2(22):=null;
RQCFG_100261_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(22),-1)));
RQCFG_100261_.tb5_3(22):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(22):=RQCFG_100261_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(22),
RQCFG_100261_.tb5_1(22),
RQCFG_100261_.tb5_2(22),
RQCFG_100261_.tb5_3(22),
RQCFG_100261_.tb5_4(22),
'C'
,
'Y'
,
10,
'N'
,
'Respuesta '
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(23):=1097269;
RQCFG_100261_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(23):=RQCFG_100261_.tb3_0(23);
RQCFG_100261_.old_tb3_1(23):=3334;
RQCFG_100261_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(23),-1)));
RQCFG_100261_.old_tb3_2(23):=187;
RQCFG_100261_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(23),-1)));
RQCFG_100261_.old_tb3_3(23):=null;
RQCFG_100261_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(23),-1)));
RQCFG_100261_.old_tb3_4(23):=null;
RQCFG_100261_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(23),-1)));
RQCFG_100261_.tb3_5(23):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(23):=121128846;
RQCFG_100261_.tb3_6(23):=NULL;
RQCFG_100261_.old_tb3_7(23):=null;
RQCFG_100261_.tb3_7(23):=NULL;
RQCFG_100261_.old_tb3_8(23):=null;
RQCFG_100261_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(23),
RQCFG_100261_.tb3_1(23),
RQCFG_100261_.tb3_2(23),
RQCFG_100261_.tb3_3(23),
RQCFG_100261_.tb3_4(23),
RQCFG_100261_.tb3_5(23),
RQCFG_100261_.tb3_6(23),
RQCFG_100261_.tb3_7(23),
RQCFG_100261_.tb3_8(23),
null,
103791,
1,
'Identificador de Motivo'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(23):=1367506;
RQCFG_100261_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(23):=RQCFG_100261_.tb5_0(23);
RQCFG_100261_.old_tb5_1(23):=187;
RQCFG_100261_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(23),-1)));
RQCFG_100261_.old_tb5_2(23):=null;
RQCFG_100261_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(23),-1)));
RQCFG_100261_.tb5_3(23):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(23):=RQCFG_100261_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(23),
RQCFG_100261_.tb5_1(23),
RQCFG_100261_.tb5_2(23),
RQCFG_100261_.tb5_3(23),
RQCFG_100261_.tb5_4(23),
'C'
,
'Y'
,
1,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(24):=1097270;
RQCFG_100261_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(24):=RQCFG_100261_.tb3_0(24);
RQCFG_100261_.old_tb3_1(24):=3334;
RQCFG_100261_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(24),-1)));
RQCFG_100261_.old_tb3_2(24):=213;
RQCFG_100261_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(24),-1)));
RQCFG_100261_.old_tb3_3(24):=255;
RQCFG_100261_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(24),-1)));
RQCFG_100261_.old_tb3_4(24):=null;
RQCFG_100261_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(24),-1)));
RQCFG_100261_.tb3_5(24):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(24):=null;
RQCFG_100261_.tb3_6(24):=NULL;
RQCFG_100261_.old_tb3_7(24):=null;
RQCFG_100261_.tb3_7(24):=NULL;
RQCFG_100261_.old_tb3_8(24):=null;
RQCFG_100261_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(24),
RQCFG_100261_.tb3_1(24),
RQCFG_100261_.tb3_2(24),
RQCFG_100261_.tb3_3(24),
RQCFG_100261_.tb3_4(24),
RQCFG_100261_.tb3_5(24),
RQCFG_100261_.tb3_6(24),
RQCFG_100261_.tb3_7(24),
RQCFG_100261_.tb3_8(24),
null,
103792,
11,
'Identificador del Paquete'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(24):=1367507;
RQCFG_100261_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(24):=RQCFG_100261_.tb5_0(24);
RQCFG_100261_.old_tb5_1(24):=213;
RQCFG_100261_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(24),-1)));
RQCFG_100261_.old_tb5_2(24):=null;
RQCFG_100261_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(24),-1)));
RQCFG_100261_.tb5_3(24):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(24):=RQCFG_100261_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(24),
RQCFG_100261_.tb5_1(24),
RQCFG_100261_.tb5_2(24),
RQCFG_100261_.tb5_3(24),
RQCFG_100261_.tb5_4(24),
'C'
,
'Y'
,
11,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(25):=1097271;
RQCFG_100261_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(25):=RQCFG_100261_.tb3_0(25);
RQCFG_100261_.old_tb3_1(25):=3334;
RQCFG_100261_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(25),-1)));
RQCFG_100261_.old_tb3_2(25):=203;
RQCFG_100261_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(25),-1)));
RQCFG_100261_.old_tb3_3(25):=null;
RQCFG_100261_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(25),-1)));
RQCFG_100261_.old_tb3_4(25):=null;
RQCFG_100261_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(25),-1)));
RQCFG_100261_.tb3_5(25):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(25):=121128847;
RQCFG_100261_.tb3_6(25):=NULL;
RQCFG_100261_.old_tb3_7(25):=null;
RQCFG_100261_.tb3_7(25):=NULL;
RQCFG_100261_.old_tb3_8(25):=null;
RQCFG_100261_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(25),
RQCFG_100261_.tb3_1(25),
RQCFG_100261_.tb3_2(25),
RQCFG_100261_.tb3_3(25),
RQCFG_100261_.tb3_4(25),
RQCFG_100261_.tb3_5(25),
RQCFG_100261_.tb3_6(25),
RQCFG_100261_.tb3_7(25),
RQCFG_100261_.tb3_8(25),
null,
103793,
12,
'Prioridad'
,
'N'
,
'C'
,
'Y'
,
12,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(25):=1367508;
RQCFG_100261_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(25):=RQCFG_100261_.tb5_0(25);
RQCFG_100261_.old_tb5_1(25):=203;
RQCFG_100261_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(25),-1)));
RQCFG_100261_.old_tb5_2(25):=null;
RQCFG_100261_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(25),-1)));
RQCFG_100261_.tb5_3(25):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(25):=RQCFG_100261_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(25),
RQCFG_100261_.tb5_1(25),
RQCFG_100261_.tb5_2(25),
RQCFG_100261_.tb5_3(25),
RQCFG_100261_.tb5_4(25),
'C'
,
'Y'
,
12,
'Y'
,
'Prioridad'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(26):=1097272;
RQCFG_100261_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(26):=RQCFG_100261_.tb3_0(26);
RQCFG_100261_.old_tb3_1(26):=3334;
RQCFG_100261_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(26),-1)));
RQCFG_100261_.old_tb3_2(26):=322;
RQCFG_100261_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(26),-1)));
RQCFG_100261_.old_tb3_3(26):=null;
RQCFG_100261_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(26),-1)));
RQCFG_100261_.old_tb3_4(26):=null;
RQCFG_100261_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(26),-1)));
RQCFG_100261_.tb3_5(26):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(26):=121128848;
RQCFG_100261_.tb3_6(26):=NULL;
RQCFG_100261_.old_tb3_7(26):=null;
RQCFG_100261_.tb3_7(26):=NULL;
RQCFG_100261_.old_tb3_8(26):=null;
RQCFG_100261_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(26),
RQCFG_100261_.tb3_1(26),
RQCFG_100261_.tb3_2(26),
RQCFG_100261_.tb3_3(26),
RQCFG_100261_.tb3_4(26),
RQCFG_100261_.tb3_5(26),
RQCFG_100261_.tb3_6(26),
RQCFG_100261_.tb3_7(26),
RQCFG_100261_.tb3_8(26),
null,
103794,
13,
'Entregas Parciales'
,
'N'
,
'C'
,
'N'
,
13,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(26):=1367509;
RQCFG_100261_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(26):=RQCFG_100261_.tb5_0(26);
RQCFG_100261_.old_tb5_1(26):=322;
RQCFG_100261_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(26),-1)));
RQCFG_100261_.old_tb5_2(26):=null;
RQCFG_100261_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(26),-1)));
RQCFG_100261_.tb5_3(26):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(26):=RQCFG_100261_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(26),
RQCFG_100261_.tb5_1(26),
RQCFG_100261_.tb5_2(26),
RQCFG_100261_.tb5_3(26),
RQCFG_100261_.tb5_4(26),
'C'
,
'Y'
,
13,
'N'
,
'Entregas Parciales'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(27):=1097273;
RQCFG_100261_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(27):=RQCFG_100261_.tb3_0(27);
RQCFG_100261_.old_tb3_1(27):=3334;
RQCFG_100261_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(27),-1)));
RQCFG_100261_.old_tb3_2(27):=2641;
RQCFG_100261_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(27),-1)));
RQCFG_100261_.old_tb3_3(27):=null;
RQCFG_100261_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(27),-1)));
RQCFG_100261_.old_tb3_4(27):=null;
RQCFG_100261_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(27),-1)));
RQCFG_100261_.tb3_5(27):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(27):=null;
RQCFG_100261_.tb3_6(27):=NULL;
RQCFG_100261_.old_tb3_7(27):=null;
RQCFG_100261_.tb3_7(27):=NULL;
RQCFG_100261_.old_tb3_8(27):=null;
RQCFG_100261_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(27),
RQCFG_100261_.tb3_1(27),
RQCFG_100261_.tb3_2(27),
RQCFG_100261_.tb3_3(27),
RQCFG_100261_.tb3_4(27),
RQCFG_100261_.tb3_5(27),
RQCFG_100261_.tb3_6(27),
RQCFG_100261_.tb3_7(27),
RQCFG_100261_.tb3_8(27),
null,
103795,
14,
'Límite de Crédito'
,
'N'
,
'N'
,
'N'
,
14,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(27):=1367510;
RQCFG_100261_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(27):=RQCFG_100261_.tb5_0(27);
RQCFG_100261_.old_tb5_1(27):=2641;
RQCFG_100261_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(27),-1)));
RQCFG_100261_.old_tb5_2(27):=null;
RQCFG_100261_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(27),-1)));
RQCFG_100261_.tb5_3(27):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(27):=RQCFG_100261_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(27),
RQCFG_100261_.tb5_1(27),
RQCFG_100261_.tb5_2(27),
RQCFG_100261_.tb5_3(27),
RQCFG_100261_.tb5_4(27),
'N'
,
'Y'
,
14,
'N'
,
'Límite de Crédito'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(28):=1097274;
RQCFG_100261_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(28):=RQCFG_100261_.tb3_0(28);
RQCFG_100261_.old_tb3_1(28):=3334;
RQCFG_100261_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(28),-1)));
RQCFG_100261_.old_tb3_2(28):=197;
RQCFG_100261_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(28),-1)));
RQCFG_100261_.old_tb3_3(28):=null;
RQCFG_100261_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(28),-1)));
RQCFG_100261_.old_tb3_4(28):=null;
RQCFG_100261_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(28),-1)));
RQCFG_100261_.tb3_5(28):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(28):=null;
RQCFG_100261_.tb3_6(28):=NULL;
RQCFG_100261_.old_tb3_7(28):=null;
RQCFG_100261_.tb3_7(28):=NULL;
RQCFG_100261_.old_tb3_8(28):=null;
RQCFG_100261_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(28),
RQCFG_100261_.tb3_1(28),
RQCFG_100261_.tb3_2(28),
RQCFG_100261_.tb3_3(28),
RQCFG_100261_.tb3_4(28),
RQCFG_100261_.tb3_5(28),
RQCFG_100261_.tb3_6(28),
RQCFG_100261_.tb3_7(28),
RQCFG_100261_.tb3_8(28),
null,
103796,
15,
'PRIVACY_FLAG'
,
'N'
,
'N'
,
'N'
,
15,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(28):=1367511;
RQCFG_100261_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(28):=RQCFG_100261_.tb5_0(28);
RQCFG_100261_.old_tb5_1(28):=197;
RQCFG_100261_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(28),-1)));
RQCFG_100261_.old_tb5_2(28):=null;
RQCFG_100261_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(28),-1)));
RQCFG_100261_.tb5_3(28):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(28):=RQCFG_100261_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(28),
RQCFG_100261_.tb5_1(28),
RQCFG_100261_.tb5_2(28),
RQCFG_100261_.tb5_3(28),
RQCFG_100261_.tb5_4(28),
'N'
,
'N'
,
15,
'N'
,
'PRIVACY_FLAG'
,
'N'
,
'N'
,
'M'
,
null,
1,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(29):=1097275;
RQCFG_100261_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(29):=RQCFG_100261_.tb3_0(29);
RQCFG_100261_.old_tb3_1(29):=3334;
RQCFG_100261_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(29),-1)));
RQCFG_100261_.old_tb3_2(29):=189;
RQCFG_100261_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(29),-1)));
RQCFG_100261_.old_tb3_3(29):=null;
RQCFG_100261_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(29),-1)));
RQCFG_100261_.old_tb3_4(29):=null;
RQCFG_100261_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(29),-1)));
RQCFG_100261_.tb3_5(29):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(29):=null;
RQCFG_100261_.tb3_6(29):=NULL;
RQCFG_100261_.old_tb3_7(29):=null;
RQCFG_100261_.tb3_7(29):=NULL;
RQCFG_100261_.old_tb3_8(29):=null;
RQCFG_100261_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(29),
RQCFG_100261_.tb3_1(29),
RQCFG_100261_.tb3_2(29),
RQCFG_100261_.tb3_3(29),
RQCFG_100261_.tb3_4(29),
RQCFG_100261_.tb3_5(29),
RQCFG_100261_.tb3_6(29),
RQCFG_100261_.tb3_7(29),
RQCFG_100261_.tb3_8(29),
null,
103797,
16,
'Número Petición Atención al cliente'
,
'N'
,
'C'
,
'Y'
,
16,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(29):=1367512;
RQCFG_100261_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(29):=RQCFG_100261_.tb5_0(29);
RQCFG_100261_.old_tb5_1(29):=189;
RQCFG_100261_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(29),-1)));
RQCFG_100261_.old_tb5_2(29):=null;
RQCFG_100261_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(29),-1)));
RQCFG_100261_.tb5_3(29):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(29):=RQCFG_100261_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(29),
RQCFG_100261_.tb5_1(29),
RQCFG_100261_.tb5_2(29),
RQCFG_100261_.tb5_3(29),
RQCFG_100261_.tb5_4(29),
'C'
,
'Y'
,
16,
'Y'
,
'Número Petición Atención al cliente'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(30):=1097276;
RQCFG_100261_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(30):=RQCFG_100261_.tb3_0(30);
RQCFG_100261_.old_tb3_1(30):=3334;
RQCFG_100261_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(30),-1)));
RQCFG_100261_.old_tb3_2(30):=413;
RQCFG_100261_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(30),-1)));
RQCFG_100261_.old_tb3_3(30):=null;
RQCFG_100261_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(30),-1)));
RQCFG_100261_.old_tb3_4(30):=null;
RQCFG_100261_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(30),-1)));
RQCFG_100261_.tb3_5(30):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(30):=null;
RQCFG_100261_.tb3_6(30):=NULL;
RQCFG_100261_.old_tb3_7(30):=null;
RQCFG_100261_.tb3_7(30):=NULL;
RQCFG_100261_.old_tb3_8(30):=null;
RQCFG_100261_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(30),
RQCFG_100261_.tb3_1(30),
RQCFG_100261_.tb3_2(30),
RQCFG_100261_.tb3_3(30),
RQCFG_100261_.tb3_4(30),
RQCFG_100261_.tb3_5(30),
RQCFG_100261_.tb3_6(30),
RQCFG_100261_.tb3_7(30),
RQCFG_100261_.tb3_8(30),
null,
103798,
17,
'PRODUCT_ID'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(30):=1367513;
RQCFG_100261_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(30):=RQCFG_100261_.tb5_0(30);
RQCFG_100261_.old_tb5_1(30):=413;
RQCFG_100261_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(30),-1)));
RQCFG_100261_.old_tb5_2(30):=null;
RQCFG_100261_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(30),-1)));
RQCFG_100261_.tb5_3(30):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(30):=RQCFG_100261_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(30),
RQCFG_100261_.tb5_1(30),
RQCFG_100261_.tb5_2(30),
RQCFG_100261_.tb5_3(30),
RQCFG_100261_.tb5_4(30),
'C'
,
'N'
,
17,
'N'
,
'PRODUCT_ID'
,
'N'
,
'N'
,
'M'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(31):=1097277;
RQCFG_100261_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(31):=RQCFG_100261_.tb3_0(31);
RQCFG_100261_.old_tb3_1(31):=3334;
RQCFG_100261_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(31),-1)));
RQCFG_100261_.old_tb3_2(31):=50001324;
RQCFG_100261_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(31),-1)));
RQCFG_100261_.old_tb3_3(31):=null;
RQCFG_100261_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(31),-1)));
RQCFG_100261_.old_tb3_4(31):=null;
RQCFG_100261_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(31),-1)));
RQCFG_100261_.tb3_5(31):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(31):=null;
RQCFG_100261_.tb3_6(31):=NULL;
RQCFG_100261_.old_tb3_7(31):=null;
RQCFG_100261_.tb3_7(31):=NULL;
RQCFG_100261_.old_tb3_8(31):=null;
RQCFG_100261_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(31),
RQCFG_100261_.tb3_1(31),
RQCFG_100261_.tb3_2(31),
RQCFG_100261_.tb3_3(31),
RQCFG_100261_.tb3_4(31),
RQCFG_100261_.tb3_5(31),
RQCFG_100261_.tb3_6(31),
RQCFG_100261_.tb3_7(31),
RQCFG_100261_.tb3_8(31),
null,
103799,
18,
'Ubicaci¿n Geogr¿fica'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(31):=1367514;
RQCFG_100261_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(31):=RQCFG_100261_.tb5_0(31);
RQCFG_100261_.old_tb5_1(31):=50001324;
RQCFG_100261_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(31),-1)));
RQCFG_100261_.old_tb5_2(31):=null;
RQCFG_100261_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(31),-1)));
RQCFG_100261_.tb5_3(31):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(31):=RQCFG_100261_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(31),
RQCFG_100261_.tb5_1(31),
RQCFG_100261_.tb5_2(31),
RQCFG_100261_.tb5_3(31),
RQCFG_100261_.tb5_4(31),
'C'
,
'Y'
,
18,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(32):=1097278;
RQCFG_100261_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(32):=RQCFG_100261_.tb3_0(32);
RQCFG_100261_.old_tb3_1(32):=3334;
RQCFG_100261_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(32),-1)));
RQCFG_100261_.old_tb3_2(32):=198;
RQCFG_100261_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(32),-1)));
RQCFG_100261_.old_tb3_3(32):=null;
RQCFG_100261_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(32),-1)));
RQCFG_100261_.old_tb3_4(32):=null;
RQCFG_100261_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(32),-1)));
RQCFG_100261_.tb3_5(32):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(32):=121128849;
RQCFG_100261_.tb3_6(32):=NULL;
RQCFG_100261_.old_tb3_7(32):=null;
RQCFG_100261_.tb3_7(32):=NULL;
RQCFG_100261_.old_tb3_8(32):=null;
RQCFG_100261_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(32),
RQCFG_100261_.tb3_1(32),
RQCFG_100261_.tb3_2(32),
RQCFG_100261_.tb3_3(32),
RQCFG_100261_.tb3_4(32),
RQCFG_100261_.tb3_5(32),
RQCFG_100261_.tb3_6(32),
RQCFG_100261_.tb3_7(32),
RQCFG_100261_.tb3_8(32),
null,
103800,
19,
'Provisional'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(32):=1367515;
RQCFG_100261_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(32):=RQCFG_100261_.tb5_0(32);
RQCFG_100261_.old_tb5_1(32):=198;
RQCFG_100261_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(32),-1)));
RQCFG_100261_.old_tb5_2(32):=null;
RQCFG_100261_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(32),-1)));
RQCFG_100261_.tb5_3(32):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(32):=RQCFG_100261_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(32),
RQCFG_100261_.tb5_1(32),
RQCFG_100261_.tb5_2(32),
RQCFG_100261_.tb5_3(32),
RQCFG_100261_.tb5_4(32),
'C'
,
'N'
,
19,
'N'
,
'Provisional'
,
'N'
,
'N'
,
'M'
,
null,
1,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(33):=1097279;
RQCFG_100261_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(33):=RQCFG_100261_.tb3_0(33);
RQCFG_100261_.old_tb3_1(33):=3334;
RQCFG_100261_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(33),-1)));
RQCFG_100261_.old_tb3_2(33):=498;
RQCFG_100261_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(33),-1)));
RQCFG_100261_.old_tb3_3(33):=null;
RQCFG_100261_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(33),-1)));
RQCFG_100261_.old_tb3_4(33):=null;
RQCFG_100261_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(33),-1)));
RQCFG_100261_.tb3_5(33):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(33):=null;
RQCFG_100261_.tb3_6(33):=NULL;
RQCFG_100261_.old_tb3_7(33):=null;
RQCFG_100261_.tb3_7(33):=NULL;
RQCFG_100261_.old_tb3_8(33):=null;
RQCFG_100261_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(33),
RQCFG_100261_.tb3_1(33),
RQCFG_100261_.tb3_2(33),
RQCFG_100261_.tb3_3(33),
RQCFG_100261_.tb3_4(33),
RQCFG_100261_.tb3_5(33),
RQCFG_100261_.tb3_6(33),
RQCFG_100261_.tb3_7(33),
RQCFG_100261_.tb3_8(33),
null,
103801,
20,
'Fecha de Atenci¿n'
,
'N'
,
'N'
,
'N'
,
20,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(33):=1367516;
RQCFG_100261_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(33):=RQCFG_100261_.tb5_0(33);
RQCFG_100261_.old_tb5_1(33):=498;
RQCFG_100261_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(33),-1)));
RQCFG_100261_.old_tb5_2(33):=null;
RQCFG_100261_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(33),-1)));
RQCFG_100261_.tb5_3(33):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(33):=RQCFG_100261_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(33),
RQCFG_100261_.tb5_1(33),
RQCFG_100261_.tb5_2(33),
RQCFG_100261_.tb5_3(33),
RQCFG_100261_.tb5_4(33),
'N'
,
'Y'
,
20,
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
7,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(34):=1097280;
RQCFG_100261_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(34):=RQCFG_100261_.tb3_0(34);
RQCFG_100261_.old_tb3_1(34):=3334;
RQCFG_100261_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(34),-1)));
RQCFG_100261_.old_tb3_2(34):=220;
RQCFG_100261_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(34),-1)));
RQCFG_100261_.old_tb3_3(34):=null;
RQCFG_100261_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(34),-1)));
RQCFG_100261_.old_tb3_4(34):=null;
RQCFG_100261_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(34),-1)));
RQCFG_100261_.tb3_5(34):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(34):=null;
RQCFG_100261_.tb3_6(34):=NULL;
RQCFG_100261_.old_tb3_7(34):=null;
RQCFG_100261_.tb3_7(34):=NULL;
RQCFG_100261_.old_tb3_8(34):=null;
RQCFG_100261_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(34),
RQCFG_100261_.tb3_1(34),
RQCFG_100261_.tb3_2(34),
RQCFG_100261_.tb3_3(34),
RQCFG_100261_.tb3_4(34),
RQCFG_100261_.tb3_5(34),
RQCFG_100261_.tb3_6(34),
RQCFG_100261_.tb3_7(34),
RQCFG_100261_.tb3_8(34),
null,
103802,
21,
'Identificador de Distribución Administrativa'
,
'N'
,
'N'
,
'N'
,
21,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(34):=1367517;
RQCFG_100261_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(34):=RQCFG_100261_.tb5_0(34);
RQCFG_100261_.old_tb5_1(34):=220;
RQCFG_100261_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(34),-1)));
RQCFG_100261_.old_tb5_2(34):=null;
RQCFG_100261_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(34),-1)));
RQCFG_100261_.tb5_3(34):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(34):=RQCFG_100261_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(34),
RQCFG_100261_.tb5_1(34),
RQCFG_100261_.tb5_2(34),
RQCFG_100261_.tb5_3(34),
RQCFG_100261_.tb5_4(34),
'N'
,
'Y'
,
21,
'N'
,
'Identificador de Distribución Administrativa'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(35):=1097281;
RQCFG_100261_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(35):=RQCFG_100261_.tb3_0(35);
RQCFG_100261_.old_tb3_1(35):=3334;
RQCFG_100261_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(35),-1)));
RQCFG_100261_.old_tb3_2(35):=524;
RQCFG_100261_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(35),-1)));
RQCFG_100261_.old_tb3_3(35):=null;
RQCFG_100261_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(35),-1)));
RQCFG_100261_.old_tb3_4(35):=null;
RQCFG_100261_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(35),-1)));
RQCFG_100261_.tb3_5(35):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(35):=null;
RQCFG_100261_.tb3_6(35):=NULL;
RQCFG_100261_.old_tb3_7(35):=null;
RQCFG_100261_.tb3_7(35):=NULL;
RQCFG_100261_.old_tb3_8(35):=null;
RQCFG_100261_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(35),
RQCFG_100261_.tb3_1(35),
RQCFG_100261_.tb3_2(35),
RQCFG_100261_.tb3_3(35),
RQCFG_100261_.tb3_4(35),
RQCFG_100261_.tb3_5(35),
RQCFG_100261_.tb3_6(35),
RQCFG_100261_.tb3_7(35),
RQCFG_100261_.tb3_8(35),
null,
103803,
22,
'Estado del Motivo'
,
'N'
,
'C'
,
'Y'
,
22,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(35):=1367518;
RQCFG_100261_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(35):=RQCFG_100261_.tb5_0(35);
RQCFG_100261_.old_tb5_1(35):=524;
RQCFG_100261_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(35),-1)));
RQCFG_100261_.old_tb5_2(35):=null;
RQCFG_100261_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(35),-1)));
RQCFG_100261_.tb5_3(35):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(35):=RQCFG_100261_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(35),
RQCFG_100261_.tb5_1(35),
RQCFG_100261_.tb5_2(35),
RQCFG_100261_.tb5_3(35),
RQCFG_100261_.tb5_4(35),
'C'
,
'Y'
,
22,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(36):=1097282;
RQCFG_100261_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(36):=RQCFG_100261_.tb3_0(36);
RQCFG_100261_.old_tb3_1(36):=3334;
RQCFG_100261_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(36),-1)));
RQCFG_100261_.old_tb3_2(36):=191;
RQCFG_100261_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(36),-1)));
RQCFG_100261_.old_tb3_3(36):=null;
RQCFG_100261_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(36),-1)));
RQCFG_100261_.old_tb3_4(36):=null;
RQCFG_100261_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(36),-1)));
RQCFG_100261_.tb3_5(36):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(36):=null;
RQCFG_100261_.tb3_6(36):=NULL;
RQCFG_100261_.old_tb3_7(36):=null;
RQCFG_100261_.tb3_7(36):=NULL;
RQCFG_100261_.old_tb3_8(36):=null;
RQCFG_100261_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(36),
RQCFG_100261_.tb3_1(36),
RQCFG_100261_.tb3_2(36),
RQCFG_100261_.tb3_3(36),
RQCFG_100261_.tb3_4(36),
RQCFG_100261_.tb3_5(36),
RQCFG_100261_.tb3_6(36),
RQCFG_100261_.tb3_7(36),
RQCFG_100261_.tb3_8(36),
null,
103804,
23,
'Identificador del Tipo de Motivo'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(36):=1367519;
RQCFG_100261_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(36):=RQCFG_100261_.tb5_0(36);
RQCFG_100261_.old_tb5_1(36):=191;
RQCFG_100261_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(36),-1)));
RQCFG_100261_.old_tb5_2(36):=null;
RQCFG_100261_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(36),-1)));
RQCFG_100261_.tb5_3(36):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(36):=RQCFG_100261_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(36),
RQCFG_100261_.tb5_1(36),
RQCFG_100261_.tb5_2(36),
RQCFG_100261_.tb5_3(36),
RQCFG_100261_.tb5_4(36),
'C'
,
'Y'
,
23,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(37):=1097283;
RQCFG_100261_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(37):=RQCFG_100261_.tb3_0(37);
RQCFG_100261_.old_tb3_1(37):=3334;
RQCFG_100261_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(37),-1)));
RQCFG_100261_.old_tb3_2(37):=192;
RQCFG_100261_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(37),-1)));
RQCFG_100261_.old_tb3_3(37):=null;
RQCFG_100261_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(37),-1)));
RQCFG_100261_.old_tb3_4(37):=null;
RQCFG_100261_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(37),-1)));
RQCFG_100261_.tb3_5(37):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(37):=null;
RQCFG_100261_.tb3_6(37):=NULL;
RQCFG_100261_.old_tb3_7(37):=null;
RQCFG_100261_.tb3_7(37):=NULL;
RQCFG_100261_.old_tb3_8(37):=null;
RQCFG_100261_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(37),
RQCFG_100261_.tb3_1(37),
RQCFG_100261_.tb3_2(37),
RQCFG_100261_.tb3_3(37),
RQCFG_100261_.tb3_4(37),
RQCFG_100261_.tb3_5(37),
RQCFG_100261_.tb3_6(37),
RQCFG_100261_.tb3_7(37),
RQCFG_100261_.tb3_8(37),
null,
103805,
24,
'Identificador del Tipo de Producto'
,
'N'
,
'C'
,
'Y'
,
24,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(37):=1367520;
RQCFG_100261_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(37):=RQCFG_100261_.tb5_0(37);
RQCFG_100261_.old_tb5_1(37):=192;
RQCFG_100261_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(37),-1)));
RQCFG_100261_.old_tb5_2(37):=null;
RQCFG_100261_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(37),-1)));
RQCFG_100261_.tb5_3(37):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(37):=RQCFG_100261_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(37),
RQCFG_100261_.tb5_1(37),
RQCFG_100261_.tb5_2(37),
RQCFG_100261_.tb5_3(37),
RQCFG_100261_.tb5_4(37),
'C'
,
'Y'
,
24,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(38):=1097284;
RQCFG_100261_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(38):=RQCFG_100261_.tb3_0(38);
RQCFG_100261_.old_tb3_1(38):=3334;
RQCFG_100261_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(38),-1)));
RQCFG_100261_.old_tb3_2(38):=4011;
RQCFG_100261_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(38),-1)));
RQCFG_100261_.old_tb3_3(38):=null;
RQCFG_100261_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(38),-1)));
RQCFG_100261_.old_tb3_4(38):=null;
RQCFG_100261_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(38),-1)));
RQCFG_100261_.tb3_5(38):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(38):=null;
RQCFG_100261_.tb3_6(38):=NULL;
RQCFG_100261_.old_tb3_7(38):=null;
RQCFG_100261_.tb3_7(38):=NULL;
RQCFG_100261_.old_tb3_8(38):=null;
RQCFG_100261_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(38),
RQCFG_100261_.tb3_1(38),
RQCFG_100261_.tb3_2(38),
RQCFG_100261_.tb3_3(38),
RQCFG_100261_.tb3_4(38),
RQCFG_100261_.tb3_5(38),
RQCFG_100261_.tb3_6(38),
RQCFG_100261_.tb3_7(38),
RQCFG_100261_.tb3_8(38),
null,
103806,
25,
'Número del Servicio'
,
'N'
,
'C'
,
'Y'
,
25,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(38):=1367521;
RQCFG_100261_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(38):=RQCFG_100261_.tb5_0(38);
RQCFG_100261_.old_tb5_1(38):=4011;
RQCFG_100261_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(38),-1)));
RQCFG_100261_.old_tb5_2(38):=null;
RQCFG_100261_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(38),-1)));
RQCFG_100261_.tb5_3(38):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(38):=RQCFG_100261_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(38),
RQCFG_100261_.tb5_1(38),
RQCFG_100261_.tb5_2(38),
RQCFG_100261_.tb5_3(38),
RQCFG_100261_.tb5_4(38),
'C'
,
'Y'
,
25,
'Y'
,
'Número del Servicio'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(39):=1097285;
RQCFG_100261_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(39):=RQCFG_100261_.tb3_0(39);
RQCFG_100261_.old_tb3_1(39):=3334;
RQCFG_100261_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(39),-1)));
RQCFG_100261_.old_tb3_2(39):=11403;
RQCFG_100261_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(39),-1)));
RQCFG_100261_.old_tb3_3(39):=null;
RQCFG_100261_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(39),-1)));
RQCFG_100261_.old_tb3_4(39):=null;
RQCFG_100261_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(39),-1)));
RQCFG_100261_.tb3_5(39):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(39):=121128840;
RQCFG_100261_.tb3_6(39):=NULL;
RQCFG_100261_.old_tb3_7(39):=null;
RQCFG_100261_.tb3_7(39):=NULL;
RQCFG_100261_.old_tb3_8(39):=null;
RQCFG_100261_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(39),
RQCFG_100261_.tb3_1(39),
RQCFG_100261_.tb3_2(39),
RQCFG_100261_.tb3_3(39),
RQCFG_100261_.tb3_4(39),
RQCFG_100261_.tb3_5(39),
RQCFG_100261_.tb3_6(39),
RQCFG_100261_.tb3_7(39),
RQCFG_100261_.tb3_8(39),
null,
103807,
26,
'Identificador de la Suscripción'
,
'N'
,
'C'
,
'N'
,
26,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(39):=1367522;
RQCFG_100261_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(39):=RQCFG_100261_.tb5_0(39);
RQCFG_100261_.old_tb5_1(39):=11403;
RQCFG_100261_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(39),-1)));
RQCFG_100261_.old_tb5_2(39):=null;
RQCFG_100261_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(39),-1)));
RQCFG_100261_.tb5_3(39):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(39):=RQCFG_100261_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(39),
RQCFG_100261_.tb5_1(39),
RQCFG_100261_.tb5_2(39),
RQCFG_100261_.tb5_3(39),
RQCFG_100261_.tb5_4(39),
'C'
,
'N'
,
26,
'N'
,
'Identificador de la Suscripción'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(40):=1097286;
RQCFG_100261_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(40):=RQCFG_100261_.tb3_0(40);
RQCFG_100261_.old_tb3_1(40):=3334;
RQCFG_100261_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(40),-1)));
RQCFG_100261_.old_tb3_2(40):=6683;
RQCFG_100261_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(40),-1)));
RQCFG_100261_.old_tb3_3(40):=null;
RQCFG_100261_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(40),-1)));
RQCFG_100261_.old_tb3_4(40):=null;
RQCFG_100261_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(40),-1)));
RQCFG_100261_.tb3_5(40):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(40):=null;
RQCFG_100261_.tb3_6(40):=NULL;
RQCFG_100261_.old_tb3_7(40):=null;
RQCFG_100261_.tb3_7(40):=NULL;
RQCFG_100261_.old_tb3_8(40):=null;
RQCFG_100261_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(40),
RQCFG_100261_.tb3_1(40),
RQCFG_100261_.tb3_2(40),
RQCFG_100261_.tb3_3(40),
RQCFG_100261_.tb3_4(40),
RQCFG_100261_.tb3_5(40),
RQCFG_100261_.tb3_6(40),
RQCFG_100261_.tb3_7(40),
RQCFG_100261_.tb3_8(40),
null,
103808,
27,
'CLIENT_PRIVACY_FLAG'
,
'N'
,
'N'
,
'N'
,
27,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(40):=1367523;
RQCFG_100261_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(40):=RQCFG_100261_.tb5_0(40);
RQCFG_100261_.old_tb5_1(40):=6683;
RQCFG_100261_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(40),-1)));
RQCFG_100261_.old_tb5_2(40):=null;
RQCFG_100261_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(40),-1)));
RQCFG_100261_.tb5_3(40):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(40):=RQCFG_100261_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(40),
RQCFG_100261_.tb5_1(40),
RQCFG_100261_.tb5_2(40),
RQCFG_100261_.tb5_3(40),
RQCFG_100261_.tb5_4(40),
'N'
,
'N'
,
27,
'N'
,
'CLIENT_PRIVACY_FLAG'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(41):=1097287;
RQCFG_100261_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(41):=RQCFG_100261_.tb3_0(41);
RQCFG_100261_.old_tb3_1(41):=3334;
RQCFG_100261_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(41),-1)));
RQCFG_100261_.old_tb3_2(41):=20362;
RQCFG_100261_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(41),-1)));
RQCFG_100261_.old_tb3_3(41):=null;
RQCFG_100261_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(41),-1)));
RQCFG_100261_.old_tb3_4(41):=null;
RQCFG_100261_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(41),-1)));
RQCFG_100261_.tb3_5(41):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(41):=121128841;
RQCFG_100261_.tb3_6(41):=NULL;
RQCFG_100261_.old_tb3_7(41):=null;
RQCFG_100261_.tb3_7(41):=NULL;
RQCFG_100261_.old_tb3_8(41):=null;
RQCFG_100261_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(41),
RQCFG_100261_.tb3_1(41),
RQCFG_100261_.tb3_2(41),
RQCFG_100261_.tb3_3(41),
RQCFG_100261_.tb3_4(41),
RQCFG_100261_.tb3_5(41),
RQCFG_100261_.tb3_6(41),
RQCFG_100261_.tb3_7(41),
RQCFG_100261_.tb3_8(41),
null,
103809,
28,
'Valor a cobrar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(41):=1367524;
RQCFG_100261_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(41):=RQCFG_100261_.tb5_0(41);
RQCFG_100261_.old_tb5_1(41):=20362;
RQCFG_100261_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(41),-1)));
RQCFG_100261_.old_tb5_2(41):=null;
RQCFG_100261_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(41),-1)));
RQCFG_100261_.tb5_3(41):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(41):=RQCFG_100261_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(41),
RQCFG_100261_.tb5_1(41),
RQCFG_100261_.tb5_2(41),
RQCFG_100261_.tb5_3(41),
RQCFG_100261_.tb5_4(41),
'C'
,
'Y'
,
28,
'N'
,
'Valor a cobrar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(42):=1097288;
RQCFG_100261_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(42):=RQCFG_100261_.tb3_0(42);
RQCFG_100261_.old_tb3_1(42):=3334;
RQCFG_100261_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(42),-1)));
RQCFG_100261_.old_tb3_2(42):=45189;
RQCFG_100261_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(42),-1)));
RQCFG_100261_.old_tb3_3(42):=null;
RQCFG_100261_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(42),-1)));
RQCFG_100261_.old_tb3_4(42):=null;
RQCFG_100261_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(42),-1)));
RQCFG_100261_.tb3_5(42):=RQCFG_100261_.tb2_2(1);
RQCFG_100261_.old_tb3_6(42):=121128842;
RQCFG_100261_.tb3_6(42):=NULL;
RQCFG_100261_.old_tb3_7(42):=null;
RQCFG_100261_.tb3_7(42):=NULL;
RQCFG_100261_.old_tb3_8(42):=null;
RQCFG_100261_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(42),
RQCFG_100261_.tb3_1(42),
RQCFG_100261_.tb3_2(42),
RQCFG_100261_.tb3_3(42),
RQCFG_100261_.tb3_4(42),
RQCFG_100261_.tb3_5(42),
RQCFG_100261_.tb3_6(42),
RQCFG_100261_.tb3_7(42),
RQCFG_100261_.tb3_8(42),
null,
103810,
29,
'Identificador Plan Comercial'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(42):=1367525;
RQCFG_100261_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(42):=RQCFG_100261_.tb5_0(42);
RQCFG_100261_.old_tb5_1(42):=45189;
RQCFG_100261_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(42),-1)));
RQCFG_100261_.old_tb5_2(42):=null;
RQCFG_100261_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(42),-1)));
RQCFG_100261_.tb5_3(42):=RQCFG_100261_.tb4_0(1);
RQCFG_100261_.tb5_4(42):=RQCFG_100261_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(42),
RQCFG_100261_.tb5_1(42),
RQCFG_100261_.tb5_2(42),
RQCFG_100261_.tb5_3(42),
RQCFG_100261_.tb5_4(42),
'C'
,
'Y'
,
29,
'N'
,
'Identificador Plan Comercial'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(43):=1097289;
RQCFG_100261_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(43):=RQCFG_100261_.tb3_0(43);
RQCFG_100261_.old_tb3_1(43):=2036;
RQCFG_100261_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(43),-1)));
RQCFG_100261_.old_tb3_2(43):=68348;
RQCFG_100261_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(43),-1)));
RQCFG_100261_.old_tb3_3(43):=null;
RQCFG_100261_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(43),-1)));
RQCFG_100261_.old_tb3_4(43):=null;
RQCFG_100261_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(43),-1)));
RQCFG_100261_.tb3_5(43):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(43):=null;
RQCFG_100261_.tb3_6(43):=NULL;
RQCFG_100261_.old_tb3_7(43):=null;
RQCFG_100261_.tb3_7(43):=NULL;
RQCFG_100261_.old_tb3_8(43):=null;
RQCFG_100261_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(43),
RQCFG_100261_.tb3_1(43),
RQCFG_100261_.tb3_2(43),
RQCFG_100261_.tb3_3(43),
RQCFG_100261_.tb3_4(43),
RQCFG_100261_.tb3_5(43),
RQCFG_100261_.tb3_6(43),
RQCFG_100261_.tb3_7(43),
RQCFG_100261_.tb3_8(43),
null,
106258,
31,
'Porcentaje De Interés'
,
'N'
,
'C'
,
'N'
,
31,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb4_0(2):=95069;
RQCFG_100261_.tb4_0(2):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100261_.tb4_0(2):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb4_1(2):=RQCFG_100261_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (2)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100261_.tb4_0(2),
RQCFG_100261_.tb4_1(2),
null,
null,
'FRAME-PAQUETE-1048954'
,
1);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(43):=1367526;
RQCFG_100261_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(43):=RQCFG_100261_.tb5_0(43);
RQCFG_100261_.old_tb5_1(43):=68348;
RQCFG_100261_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(43),-1)));
RQCFG_100261_.old_tb5_2(43):=null;
RQCFG_100261_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(43),-1)));
RQCFG_100261_.tb5_3(43):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(43):=RQCFG_100261_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(43),
RQCFG_100261_.tb5_1(43),
RQCFG_100261_.tb5_2(43),
RQCFG_100261_.tb5_3(43),
RQCFG_100261_.tb5_4(43),
'C'
,
'Y'
,
31,
'N'
,
'Porcentaje De Interés'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(44):=1097290;
RQCFG_100261_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(44):=RQCFG_100261_.tb3_0(44);
RQCFG_100261_.old_tb3_1(44):=2036;
RQCFG_100261_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(44),-1)));
RQCFG_100261_.old_tb3_2(44):=68349;
RQCFG_100261_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(44),-1)));
RQCFG_100261_.old_tb3_3(44):=null;
RQCFG_100261_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(44),-1)));
RQCFG_100261_.old_tb3_4(44):=null;
RQCFG_100261_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(44),-1)));
RQCFG_100261_.tb3_5(44):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(44):=null;
RQCFG_100261_.tb3_6(44):=NULL;
RQCFG_100261_.old_tb3_7(44):=null;
RQCFG_100261_.tb3_7(44):=NULL;
RQCFG_100261_.old_tb3_8(44):=null;
RQCFG_100261_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(44),
RQCFG_100261_.tb3_1(44),
RQCFG_100261_.tb3_2(44),
RQCFG_100261_.tb3_3(44),
RQCFG_100261_.tb3_4(44),
RQCFG_100261_.tb3_5(44),
RQCFG_100261_.tb3_6(44),
RQCFG_100261_.tb3_7(44),
RQCFG_100261_.tb3_8(44),
null,
106259,
32,
'Puntos Adicionales'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(44):=1367527;
RQCFG_100261_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(44):=RQCFG_100261_.tb5_0(44);
RQCFG_100261_.old_tb5_1(44):=68349;
RQCFG_100261_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(44),-1)));
RQCFG_100261_.old_tb5_2(44):=null;
RQCFG_100261_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(44),-1)));
RQCFG_100261_.tb5_3(44):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(44):=RQCFG_100261_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(44),
RQCFG_100261_.tb5_1(44),
RQCFG_100261_.tb5_2(44),
RQCFG_100261_.tb5_3(44),
RQCFG_100261_.tb5_4(44),
'C'
,
'Y'
,
32,
'N'
,
'Puntos Adicionales'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(45):=1097291;
RQCFG_100261_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(45):=RQCFG_100261_.tb3_0(45);
RQCFG_100261_.old_tb3_1(45):=2036;
RQCFG_100261_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(45),-1)));
RQCFG_100261_.old_tb3_2(45):=68351;
RQCFG_100261_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(45),-1)));
RQCFG_100261_.old_tb3_3(45):=null;
RQCFG_100261_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(45),-1)));
RQCFG_100261_.old_tb3_4(45):=null;
RQCFG_100261_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(45),-1)));
RQCFG_100261_.tb3_5(45):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(45):=121128779;
RQCFG_100261_.tb3_6(45):=NULL;
RQCFG_100261_.old_tb3_7(45):=null;
RQCFG_100261_.tb3_7(45):=NULL;
RQCFG_100261_.old_tb3_8(45):=null;
RQCFG_100261_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(45),
RQCFG_100261_.tb3_1(45),
RQCFG_100261_.tb3_2(45),
RQCFG_100261_.tb3_3(45),
RQCFG_100261_.tb3_4(45),
RQCFG_100261_.tb3_5(45),
RQCFG_100261_.tb3_6(45),
RQCFG_100261_.tb3_7(45),
RQCFG_100261_.tb3_8(45),
null,
106260,
33,
'Financiar Iva A Una Cuota'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(45):=1367528;
RQCFG_100261_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(45):=RQCFG_100261_.tb5_0(45);
RQCFG_100261_.old_tb5_1(45):=68351;
RQCFG_100261_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(45),-1)));
RQCFG_100261_.old_tb5_2(45):=null;
RQCFG_100261_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(45),-1)));
RQCFG_100261_.tb5_3(45):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(45):=RQCFG_100261_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(45),
RQCFG_100261_.tb5_1(45),
RQCFG_100261_.tb5_2(45),
RQCFG_100261_.tb5_3(45),
RQCFG_100261_.tb5_4(45),
'C'
,
'Y'
,
33,
'N'
,
'Financiar Iva A Una Cuota'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(46):=1097292;
RQCFG_100261_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(46):=RQCFG_100261_.tb3_0(46);
RQCFG_100261_.old_tb3_1(46):=2036;
RQCFG_100261_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(46),-1)));
RQCFG_100261_.old_tb3_2(46):=68353;
RQCFG_100261_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(46),-1)));
RQCFG_100261_.old_tb3_3(46):=null;
RQCFG_100261_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(46),-1)));
RQCFG_100261_.old_tb3_4(46):=null;
RQCFG_100261_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(46),-1)));
RQCFG_100261_.tb3_5(46):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(46):=null;
RQCFG_100261_.tb3_6(46):=NULL;
RQCFG_100261_.old_tb3_7(46):=null;
RQCFG_100261_.tb3_7(46):=NULL;
RQCFG_100261_.old_tb3_8(46):=null;
RQCFG_100261_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(46),
RQCFG_100261_.tb3_1(46),
RQCFG_100261_.tb3_2(46),
RQCFG_100261_.tb3_3(46),
RQCFG_100261_.tb3_4(46),
RQCFG_100261_.tb3_5(46),
RQCFG_100261_.tb3_6(46),
RQCFG_100261_.tb3_7(46),
RQCFG_100261_.tb3_8(46),
null,
106261,
34,
'Documento De Soporte'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(46):=1367529;
RQCFG_100261_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(46):=RQCFG_100261_.tb5_0(46);
RQCFG_100261_.old_tb5_1(46):=68353;
RQCFG_100261_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(46),-1)));
RQCFG_100261_.old_tb5_2(46):=null;
RQCFG_100261_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(46),-1)));
RQCFG_100261_.tb5_3(46):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(46):=RQCFG_100261_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(46),
RQCFG_100261_.tb5_1(46),
RQCFG_100261_.tb5_2(46),
RQCFG_100261_.tb5_3(46),
RQCFG_100261_.tb5_4(46),
'C'
,
'Y'
,
34,
'N'
,
'Documento De Soporte'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(47):=1097293;
RQCFG_100261_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(47):=RQCFG_100261_.tb3_0(47);
RQCFG_100261_.old_tb3_1(47):=2036;
RQCFG_100261_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(47),-1)));
RQCFG_100261_.old_tb3_2(47):=68577;
RQCFG_100261_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(47),-1)));
RQCFG_100261_.old_tb3_3(47):=null;
RQCFG_100261_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(47),-1)));
RQCFG_100261_.old_tb3_4(47):=null;
RQCFG_100261_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(47),-1)));
RQCFG_100261_.tb3_5(47):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(47):=121128782;
RQCFG_100261_.tb3_6(47):=NULL;
RQCFG_100261_.old_tb3_7(47):=null;
RQCFG_100261_.tb3_7(47):=NULL;
RQCFG_100261_.old_tb3_8(47):=null;
RQCFG_100261_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(47),
RQCFG_100261_.tb3_1(47),
RQCFG_100261_.tb3_2(47),
RQCFG_100261_.tb3_3(47),
RQCFG_100261_.tb3_4(47),
RQCFG_100261_.tb3_5(47),
RQCFG_100261_.tb3_6(47),
RQCFG_100261_.tb3_7(47),
RQCFG_100261_.tb3_8(47),
null,
106262,
35,
'Valor A Pagar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(47):=1367530;
RQCFG_100261_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(47):=RQCFG_100261_.tb5_0(47);
RQCFG_100261_.old_tb5_1(47):=68577;
RQCFG_100261_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(47),-1)));
RQCFG_100261_.old_tb5_2(47):=null;
RQCFG_100261_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(47),-1)));
RQCFG_100261_.tb5_3(47):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(47):=RQCFG_100261_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(47),
RQCFG_100261_.tb5_1(47),
RQCFG_100261_.tb5_2(47),
RQCFG_100261_.tb5_3(47),
RQCFG_100261_.tb5_4(47),
'C'
,
'Y'
,
35,
'N'
,
'Valor A Pagar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(48):=1097294;
RQCFG_100261_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(48):=RQCFG_100261_.tb3_0(48);
RQCFG_100261_.old_tb3_1(48):=2036;
RQCFG_100261_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(48),-1)));
RQCFG_100261_.old_tb3_2(48):=440;
RQCFG_100261_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(48),-1)));
RQCFG_100261_.old_tb3_3(48):=null;
RQCFG_100261_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(48),-1)));
RQCFG_100261_.old_tb3_4(48):=null;
RQCFG_100261_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(48),-1)));
RQCFG_100261_.tb3_5(48):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(48):=121128783;
RQCFG_100261_.tb3_6(48):=NULL;
RQCFG_100261_.old_tb3_7(48):=null;
RQCFG_100261_.tb3_7(48):=NULL;
RQCFG_100261_.old_tb3_8(48):=120071852;
RQCFG_100261_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(48),
RQCFG_100261_.tb3_1(48),
RQCFG_100261_.tb3_2(48),
RQCFG_100261_.tb3_3(48),
RQCFG_100261_.tb3_4(48),
RQCFG_100261_.tb3_5(48),
RQCFG_100261_.tb3_6(48),
RQCFG_100261_.tb3_7(48),
RQCFG_100261_.tb3_8(48),
null,
106263,
36,
'Categoria'
,
'N'
,
'C'
,
'Y'
,
36,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(48):=1367531;
RQCFG_100261_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(48):=RQCFG_100261_.tb5_0(48);
RQCFG_100261_.old_tb5_1(48):=440;
RQCFG_100261_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(48),-1)));
RQCFG_100261_.old_tb5_2(48):=null;
RQCFG_100261_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(48),-1)));
RQCFG_100261_.tb5_3(48):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(48):=RQCFG_100261_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(48),
RQCFG_100261_.tb5_1(48),
RQCFG_100261_.tb5_2(48),
RQCFG_100261_.tb5_3(48),
RQCFG_100261_.tb5_4(48),
'C'
,
'Y'
,
36,
'Y'
,
'Categoria'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(49):=1097295;
RQCFG_100261_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(49):=RQCFG_100261_.tb3_0(49);
RQCFG_100261_.old_tb3_1(49):=2036;
RQCFG_100261_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(49),-1)));
RQCFG_100261_.old_tb3_2(49):=441;
RQCFG_100261_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(49),-1)));
RQCFG_100261_.old_tb3_3(49):=null;
RQCFG_100261_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(49),-1)));
RQCFG_100261_.old_tb3_4(49):=null;
RQCFG_100261_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(49),-1)));
RQCFG_100261_.tb3_5(49):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(49):=121128784;
RQCFG_100261_.tb3_6(49):=NULL;
RQCFG_100261_.old_tb3_7(49):=null;
RQCFG_100261_.tb3_7(49):=NULL;
RQCFG_100261_.old_tb3_8(49):=120071853;
RQCFG_100261_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(49),
RQCFG_100261_.tb3_1(49),
RQCFG_100261_.tb3_2(49),
RQCFG_100261_.tb3_3(49),
RQCFG_100261_.tb3_4(49),
RQCFG_100261_.tb3_5(49),
RQCFG_100261_.tb3_6(49),
RQCFG_100261_.tb3_7(49),
RQCFG_100261_.tb3_8(49),
null,
106264,
37,
'Subcategoria'
,
'N'
,
'C'
,
'Y'
,
37,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(49):=1367532;
RQCFG_100261_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(49):=RQCFG_100261_.tb5_0(49);
RQCFG_100261_.old_tb5_1(49):=441;
RQCFG_100261_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(49),-1)));
RQCFG_100261_.old_tb5_2(49):=null;
RQCFG_100261_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(49),-1)));
RQCFG_100261_.tb5_3(49):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(49):=RQCFG_100261_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(49),
RQCFG_100261_.tb5_1(49),
RQCFG_100261_.tb5_2(49),
RQCFG_100261_.tb5_3(49),
RQCFG_100261_.tb5_4(49),
'C'
,
'Y'
,
37,
'Y'
,
'Subcategoria'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(50):=1097296;
RQCFG_100261_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(50):=RQCFG_100261_.tb3_0(50);
RQCFG_100261_.old_tb3_1(50):=2036;
RQCFG_100261_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(50),-1)));
RQCFG_100261_.old_tb3_2(50):=50001351;
RQCFG_100261_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(50),-1)));
RQCFG_100261_.old_tb3_3(50):=null;
RQCFG_100261_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(50),-1)));
RQCFG_100261_.old_tb3_4(50):=null;
RQCFG_100261_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(50),-1)));
RQCFG_100261_.tb3_5(50):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(50):=null;
RQCFG_100261_.tb3_6(50):=NULL;
RQCFG_100261_.old_tb3_7(50):=null;
RQCFG_100261_.tb3_7(50):=NULL;
RQCFG_100261_.old_tb3_8(50):=null;
RQCFG_100261_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(50),
RQCFG_100261_.tb3_1(50),
RQCFG_100261_.tb3_2(50),
RQCFG_100261_.tb3_3(50),
RQCFG_100261_.tb3_4(50),
RQCFG_100261_.tb3_5(50),
RQCFG_100261_.tb3_6(50),
RQCFG_100261_.tb3_7(50),
RQCFG_100261_.tb3_8(50),
null,
106221,
38,
'Excepción comercial'
,
'N'
,
'Y'
,
'N'
,
38,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(50):=1367533;
RQCFG_100261_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(50):=RQCFG_100261_.tb5_0(50);
RQCFG_100261_.old_tb5_1(50):=50001351;
RQCFG_100261_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(50),-1)));
RQCFG_100261_.old_tb5_2(50):=null;
RQCFG_100261_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(50),-1)));
RQCFG_100261_.tb5_3(50):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(50):=RQCFG_100261_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(50),
RQCFG_100261_.tb5_1(50),
RQCFG_100261_.tb5_2(50),
RQCFG_100261_.tb5_3(50),
RQCFG_100261_.tb5_4(50),
'Y'
,
'Y'
,
38,
'N'
,
'Excepción comercial'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(51):=1097297;
RQCFG_100261_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(51):=RQCFG_100261_.tb3_0(51);
RQCFG_100261_.old_tb3_1(51):=2036;
RQCFG_100261_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(51),-1)));
RQCFG_100261_.old_tb3_2(51):=1111;
RQCFG_100261_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(51),-1)));
RQCFG_100261_.old_tb3_3(51):=null;
RQCFG_100261_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(51),-1)));
RQCFG_100261_.old_tb3_4(51):=null;
RQCFG_100261_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(51),-1)));
RQCFG_100261_.tb3_5(51):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(51):=null;
RQCFG_100261_.tb3_6(51):=NULL;
RQCFG_100261_.old_tb3_7(51):=null;
RQCFG_100261_.tb3_7(51):=NULL;
RQCFG_100261_.old_tb3_8(51):=null;
RQCFG_100261_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(51),
RQCFG_100261_.tb3_1(51),
RQCFG_100261_.tb3_2(51),
RQCFG_100261_.tb3_3(51),
RQCFG_100261_.tb3_4(51),
RQCFG_100261_.tb3_5(51),
RQCFG_100261_.tb3_6(51),
RQCFG_100261_.tb3_7(51),
RQCFG_100261_.tb3_8(51),
null,
106265,
0,
'Id Contrato del producto'
,
'N'
,
'C'
,
'N'
,
0,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(51):=1367534;
RQCFG_100261_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(51):=RQCFG_100261_.tb5_0(51);
RQCFG_100261_.old_tb5_1(51):=1111;
RQCFG_100261_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(51),-1)));
RQCFG_100261_.old_tb5_2(51):=null;
RQCFG_100261_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(51),-1)));
RQCFG_100261_.tb5_3(51):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(51):=RQCFG_100261_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(51),
RQCFG_100261_.tb5_1(51),
RQCFG_100261_.tb5_2(51),
RQCFG_100261_.tb5_3(51),
RQCFG_100261_.tb5_4(51),
'C'
,
'Y'
,
0,
'N'
,
'Id Contrato del producto'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(52):=1097298;
RQCFG_100261_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(52):=RQCFG_100261_.tb3_0(52);
RQCFG_100261_.old_tb3_1(52):=2036;
RQCFG_100261_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(52),-1)));
RQCFG_100261_.old_tb3_2(52):=257;
RQCFG_100261_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(52),-1)));
RQCFG_100261_.old_tb3_3(52):=null;
RQCFG_100261_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(52),-1)));
RQCFG_100261_.old_tb3_4(52):=null;
RQCFG_100261_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(52),-1)));
RQCFG_100261_.tb3_5(52):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(52):=121128785;
RQCFG_100261_.tb3_6(52):=NULL;
RQCFG_100261_.old_tb3_7(52):=null;
RQCFG_100261_.tb3_7(52):=NULL;
RQCFG_100261_.old_tb3_8(52):=null;
RQCFG_100261_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(52),
RQCFG_100261_.tb3_1(52),
RQCFG_100261_.tb3_2(52),
RQCFG_100261_.tb3_3(52),
RQCFG_100261_.tb3_4(52),
RQCFG_100261_.tb3_5(52),
RQCFG_100261_.tb3_6(52),
RQCFG_100261_.tb3_7(52),
RQCFG_100261_.tb3_8(52),
null,
106228,
1,
'Interacción'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(52):=1367535;
RQCFG_100261_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(52):=RQCFG_100261_.tb5_0(52);
RQCFG_100261_.old_tb5_1(52):=257;
RQCFG_100261_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(52),-1)));
RQCFG_100261_.old_tb5_2(52):=null;
RQCFG_100261_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(52),-1)));
RQCFG_100261_.tb5_3(52):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(52):=RQCFG_100261_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(52),
RQCFG_100261_.tb5_1(52),
RQCFG_100261_.tb5_2(52),
RQCFG_100261_.tb5_3(52),
RQCFG_100261_.tb5_4(52),
'C'
,
'E'
,
1,
'Y'
,
'Interacción'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(53):=1097299;
RQCFG_100261_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(53):=RQCFG_100261_.tb3_0(53);
RQCFG_100261_.old_tb3_1(53):=2036;
RQCFG_100261_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(53),-1)));
RQCFG_100261_.old_tb3_2(53):=109479;
RQCFG_100261_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(53),-1)));
RQCFG_100261_.old_tb3_3(53):=null;
RQCFG_100261_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(53),-1)));
RQCFG_100261_.old_tb3_4(53):=null;
RQCFG_100261_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(53),-1)));
RQCFG_100261_.tb3_5(53):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(53):=121128786;
RQCFG_100261_.tb3_6(53):=NULL;
RQCFG_100261_.old_tb3_7(53):=null;
RQCFG_100261_.tb3_7(53):=NULL;
RQCFG_100261_.old_tb3_8(53):=120071854;
RQCFG_100261_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(53),
RQCFG_100261_.tb3_1(53),
RQCFG_100261_.tb3_2(53),
RQCFG_100261_.tb3_3(53),
RQCFG_100261_.tb3_4(53),
RQCFG_100261_.tb3_5(53),
RQCFG_100261_.tb3_6(53),
RQCFG_100261_.tb3_7(53),
RQCFG_100261_.tb3_8(53),
null,
106229,
4,
'Punto de Atención'
,
'N'
,
'C'
,
'Y'
,
4,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(53):=1367536;
RQCFG_100261_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(53):=RQCFG_100261_.tb5_0(53);
RQCFG_100261_.old_tb5_1(53):=109479;
RQCFG_100261_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(53),-1)));
RQCFG_100261_.old_tb5_2(53):=null;
RQCFG_100261_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(53),-1)));
RQCFG_100261_.tb5_3(53):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(53):=RQCFG_100261_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(53),
RQCFG_100261_.tb5_1(53),
RQCFG_100261_.tb5_2(53),
RQCFG_100261_.tb5_3(53),
RQCFG_100261_.tb5_4(53),
'C'
,
'N'
,
4,
'Y'
,
'Punto de Atención'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(54):=1097300;
RQCFG_100261_.tb3_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(54):=RQCFG_100261_.tb3_0(54);
RQCFG_100261_.old_tb3_1(54):=2036;
RQCFG_100261_.tb3_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(54),-1)));
RQCFG_100261_.old_tb3_2(54):=255;
RQCFG_100261_.tb3_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(54),-1)));
RQCFG_100261_.old_tb3_3(54):=null;
RQCFG_100261_.tb3_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(54),-1)));
RQCFG_100261_.old_tb3_4(54):=null;
RQCFG_100261_.tb3_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(54),-1)));
RQCFG_100261_.tb3_5(54):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(54):=null;
RQCFG_100261_.tb3_6(54):=NULL;
RQCFG_100261_.old_tb3_7(54):=121128787;
RQCFG_100261_.tb3_7(54):=NULL;
RQCFG_100261_.old_tb3_8(54):=null;
RQCFG_100261_.tb3_8(54):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(54),
RQCFG_100261_.tb3_1(54),
RQCFG_100261_.tb3_2(54),
RQCFG_100261_.tb3_3(54),
RQCFG_100261_.tb3_4(54),
RQCFG_100261_.tb3_5(54),
RQCFG_100261_.tb3_6(54),
RQCFG_100261_.tb3_7(54),
RQCFG_100261_.tb3_8(54),
null,
106230,
2,
'N¿mero de Solicitud'
,
'N'
,
'C'
,
'Y'
,
2,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(54):=1367537;
RQCFG_100261_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(54):=RQCFG_100261_.tb5_0(54);
RQCFG_100261_.old_tb5_1(54):=255;
RQCFG_100261_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(54),-1)));
RQCFG_100261_.old_tb5_2(54):=null;
RQCFG_100261_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(54),-1)));
RQCFG_100261_.tb5_3(54):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(54):=RQCFG_100261_.tb3_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(54),
RQCFG_100261_.tb5_1(54),
RQCFG_100261_.tb5_2(54),
RQCFG_100261_.tb5_3(54),
RQCFG_100261_.tb5_4(54),
'C'
,
'N'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(55):=1097301;
RQCFG_100261_.tb3_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(55):=RQCFG_100261_.tb3_0(55);
RQCFG_100261_.old_tb3_1(55):=2036;
RQCFG_100261_.tb3_1(55):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(55),-1)));
RQCFG_100261_.old_tb3_2(55):=2683;
RQCFG_100261_.tb3_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(55),-1)));
RQCFG_100261_.old_tb3_3(55):=null;
RQCFG_100261_.tb3_3(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(55),-1)));
RQCFG_100261_.old_tb3_4(55):=null;
RQCFG_100261_.tb3_4(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(55),-1)));
RQCFG_100261_.tb3_5(55):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(55):=121128788;
RQCFG_100261_.tb3_6(55):=NULL;
RQCFG_100261_.old_tb3_7(55):=null;
RQCFG_100261_.tb3_7(55):=NULL;
RQCFG_100261_.old_tb3_8(55):=120071855;
RQCFG_100261_.tb3_8(55):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (55)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(55),
RQCFG_100261_.tb3_1(55),
RQCFG_100261_.tb3_2(55),
RQCFG_100261_.tb3_3(55),
RQCFG_100261_.tb3_4(55),
RQCFG_100261_.tb3_5(55),
RQCFG_100261_.tb3_6(55),
RQCFG_100261_.tb3_7(55),
RQCFG_100261_.tb3_8(55),
null,
106231,
5,
'Medio de recepción'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(55):=1367538;
RQCFG_100261_.tb5_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(55):=RQCFG_100261_.tb5_0(55);
RQCFG_100261_.old_tb5_1(55):=2683;
RQCFG_100261_.tb5_1(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(55),-1)));
RQCFG_100261_.old_tb5_2(55):=null;
RQCFG_100261_.tb5_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(55),-1)));
RQCFG_100261_.tb5_3(55):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(55):=RQCFG_100261_.tb3_0(55);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(55),
RQCFG_100261_.tb5_1(55),
RQCFG_100261_.tb5_2(55),
RQCFG_100261_.tb5_3(55),
RQCFG_100261_.tb5_4(55),
'C'
,
'Y'
,
5,
'Y'
,
'Medio de recepción'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(56):=1097302;
RQCFG_100261_.tb3_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(56):=RQCFG_100261_.tb3_0(56);
RQCFG_100261_.old_tb3_1(56):=2036;
RQCFG_100261_.tb3_1(56):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(56),-1)));
RQCFG_100261_.old_tb3_2(56):=50001162;
RQCFG_100261_.tb3_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(56),-1)));
RQCFG_100261_.old_tb3_3(56):=null;
RQCFG_100261_.tb3_3(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(56),-1)));
RQCFG_100261_.old_tb3_4(56):=null;
RQCFG_100261_.tb3_4(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(56),-1)));
RQCFG_100261_.tb3_5(56):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(56):=121128789;
RQCFG_100261_.tb3_6(56):=NULL;
RQCFG_100261_.old_tb3_7(56):=121128790;
RQCFG_100261_.tb3_7(56):=NULL;
RQCFG_100261_.old_tb3_8(56):=120071856;
RQCFG_100261_.tb3_8(56):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (56)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(56),
RQCFG_100261_.tb3_1(56),
RQCFG_100261_.tb3_2(56),
RQCFG_100261_.tb3_3(56),
RQCFG_100261_.tb3_4(56),
RQCFG_100261_.tb3_5(56),
RQCFG_100261_.tb3_6(56),
RQCFG_100261_.tb3_7(56),
RQCFG_100261_.tb3_8(56),
null,
106232,
3,
'Funcionario'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(56):=1367539;
RQCFG_100261_.tb5_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(56):=RQCFG_100261_.tb5_0(56);
RQCFG_100261_.old_tb5_1(56):=50001162;
RQCFG_100261_.tb5_1(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(56),-1)));
RQCFG_100261_.old_tb5_2(56):=null;
RQCFG_100261_.tb5_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(56),-1)));
RQCFG_100261_.tb5_3(56):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(56):=RQCFG_100261_.tb3_0(56);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(56),
RQCFG_100261_.tb5_1(56),
RQCFG_100261_.tb5_2(56),
RQCFG_100261_.tb5_3(56),
RQCFG_100261_.tb5_4(56),
'C'
,
'N'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(57):=1097303;
RQCFG_100261_.tb3_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(57):=RQCFG_100261_.tb3_0(57);
RQCFG_100261_.old_tb3_1(57):=2036;
RQCFG_100261_.tb3_1(57):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(57),-1)));
RQCFG_100261_.old_tb3_2(57):=146754;
RQCFG_100261_.tb3_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(57),-1)));
RQCFG_100261_.old_tb3_3(57):=null;
RQCFG_100261_.tb3_3(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(57),-1)));
RQCFG_100261_.old_tb3_4(57):=null;
RQCFG_100261_.tb3_4(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(57),-1)));
RQCFG_100261_.tb3_5(57):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(57):=null;
RQCFG_100261_.tb3_6(57):=NULL;
RQCFG_100261_.old_tb3_7(57):=null;
RQCFG_100261_.tb3_7(57):=NULL;
RQCFG_100261_.old_tb3_8(57):=null;
RQCFG_100261_.tb3_8(57):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (57)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(57),
RQCFG_100261_.tb3_1(57),
RQCFG_100261_.tb3_2(57),
RQCFG_100261_.tb3_3(57),
RQCFG_100261_.tb3_4(57),
RQCFG_100261_.tb3_5(57),
RQCFG_100261_.tb3_6(57),
RQCFG_100261_.tb3_7(57),
RQCFG_100261_.tb3_8(57),
null,
106233,
6,
'Observación'
,
'N'
,
'C'
,
'N'
,
6,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(57):=1367540;
RQCFG_100261_.tb5_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(57):=RQCFG_100261_.tb5_0(57);
RQCFG_100261_.old_tb5_1(57):=146754;
RQCFG_100261_.tb5_1(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(57),-1)));
RQCFG_100261_.old_tb5_2(57):=null;
RQCFG_100261_.tb5_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(57),-1)));
RQCFG_100261_.tb5_3(57):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(57):=RQCFG_100261_.tb3_0(57);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(57),
RQCFG_100261_.tb5_1(57),
RQCFG_100261_.tb5_2(57),
RQCFG_100261_.tb5_3(57),
RQCFG_100261_.tb5_4(57),
'C'
,
'Y'
,
6,
'N'
,
'Observación'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(58):=1097304;
RQCFG_100261_.tb3_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(58):=RQCFG_100261_.tb3_0(58);
RQCFG_100261_.old_tb3_1(58):=2036;
RQCFG_100261_.tb3_1(58):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(58),-1)));
RQCFG_100261_.old_tb3_2(58):=258;
RQCFG_100261_.tb3_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(58),-1)));
RQCFG_100261_.old_tb3_3(58):=null;
RQCFG_100261_.tb3_3(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(58),-1)));
RQCFG_100261_.old_tb3_4(58):=null;
RQCFG_100261_.tb3_4(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(58),-1)));
RQCFG_100261_.tb3_5(58):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(58):=121128791;
RQCFG_100261_.tb3_6(58):=NULL;
RQCFG_100261_.old_tb3_7(58):=121128792;
RQCFG_100261_.tb3_7(58):=NULL;
RQCFG_100261_.old_tb3_8(58):=null;
RQCFG_100261_.tb3_8(58):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (58)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(58),
RQCFG_100261_.tb3_1(58),
RQCFG_100261_.tb3_2(58),
RQCFG_100261_.tb3_3(58),
RQCFG_100261_.tb3_4(58),
RQCFG_100261_.tb3_5(58),
RQCFG_100261_.tb3_6(58),
RQCFG_100261_.tb3_7(58),
RQCFG_100261_.tb3_8(58),
null,
106234,
7,
'Fecha de Solicitud'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(58):=1367541;
RQCFG_100261_.tb5_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(58):=RQCFG_100261_.tb5_0(58);
RQCFG_100261_.old_tb5_1(58):=258;
RQCFG_100261_.tb5_1(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(58),-1)));
RQCFG_100261_.old_tb5_2(58):=null;
RQCFG_100261_.tb5_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(58),-1)));
RQCFG_100261_.tb5_3(58):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(58):=RQCFG_100261_.tb3_0(58);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (58)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(58),
RQCFG_100261_.tb5_1(58),
RQCFG_100261_.tb5_2(58),
RQCFG_100261_.tb5_3(58),
RQCFG_100261_.tb5_4(58),
'C'
,
'Y'
,
7,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(59):=1097305;
RQCFG_100261_.tb3_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(59):=RQCFG_100261_.tb3_0(59);
RQCFG_100261_.old_tb3_1(59):=2036;
RQCFG_100261_.tb3_1(59):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(59),-1)));
RQCFG_100261_.old_tb3_2(59):=146756;
RQCFG_100261_.tb3_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(59),-1)));
RQCFG_100261_.old_tb3_3(59):=null;
RQCFG_100261_.tb3_3(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(59),-1)));
RQCFG_100261_.old_tb3_4(59):=null;
RQCFG_100261_.tb3_4(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(59),-1)));
RQCFG_100261_.tb3_5(59):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(59):=121128793;
RQCFG_100261_.tb3_6(59):=NULL;
RQCFG_100261_.old_tb3_7(59):=null;
RQCFG_100261_.tb3_7(59):=NULL;
RQCFG_100261_.old_tb3_8(59):=null;
RQCFG_100261_.tb3_8(59):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (59)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(59),
RQCFG_100261_.tb3_1(59),
RQCFG_100261_.tb3_2(59),
RQCFG_100261_.tb3_3(59),
RQCFG_100261_.tb3_4(59),
RQCFG_100261_.tb3_5(59),
RQCFG_100261_.tb3_6(59),
RQCFG_100261_.tb3_7(59),
RQCFG_100261_.tb3_8(59),
null,
106235,
8,
'Direcci¿n de Respuesta'
,
'N'
,
'C'
,
'N'
,
8,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(59):=1367542;
RQCFG_100261_.tb5_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(59):=RQCFG_100261_.tb5_0(59);
RQCFG_100261_.old_tb5_1(59):=146756;
RQCFG_100261_.tb5_1(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(59),-1)));
RQCFG_100261_.old_tb5_2(59):=null;
RQCFG_100261_.tb5_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(59),-1)));
RQCFG_100261_.tb5_3(59):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(59):=RQCFG_100261_.tb3_0(59);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (59)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(59),
RQCFG_100261_.tb5_1(59),
RQCFG_100261_.tb5_2(59),
RQCFG_100261_.tb5_3(59),
RQCFG_100261_.tb5_4(59),
'C'
,
'E'
,
8,
'N'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(60):=1097306;
RQCFG_100261_.tb3_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(60):=RQCFG_100261_.tb3_0(60);
RQCFG_100261_.old_tb3_1(60):=2036;
RQCFG_100261_.tb3_1(60):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(60),-1)));
RQCFG_100261_.old_tb3_2(60):=146755;
RQCFG_100261_.tb3_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(60),-1)));
RQCFG_100261_.old_tb3_3(60):=null;
RQCFG_100261_.tb3_3(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(60),-1)));
RQCFG_100261_.old_tb3_4(60):=null;
RQCFG_100261_.tb3_4(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(60),-1)));
RQCFG_100261_.tb3_5(60):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(60):=121128794;
RQCFG_100261_.tb3_6(60):=NULL;
RQCFG_100261_.old_tb3_7(60):=null;
RQCFG_100261_.tb3_7(60):=NULL;
RQCFG_100261_.old_tb3_8(60):=null;
RQCFG_100261_.tb3_8(60):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (60)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(60),
RQCFG_100261_.tb3_1(60),
RQCFG_100261_.tb3_2(60),
RQCFG_100261_.tb3_3(60),
RQCFG_100261_.tb3_4(60),
RQCFG_100261_.tb3_5(60),
RQCFG_100261_.tb3_6(60),
RQCFG_100261_.tb3_7(60),
RQCFG_100261_.tb3_8(60),
null,
106236,
9,
'Información del Solicitante'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(60):=1367543;
RQCFG_100261_.tb5_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(60):=RQCFG_100261_.tb5_0(60);
RQCFG_100261_.old_tb5_1(60):=146755;
RQCFG_100261_.tb5_1(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(60),-1)));
RQCFG_100261_.old_tb5_2(60):=null;
RQCFG_100261_.tb5_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(60),-1)));
RQCFG_100261_.tb5_3(60):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(60):=RQCFG_100261_.tb3_0(60);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (60)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(60),
RQCFG_100261_.tb5_1(60),
RQCFG_100261_.tb5_2(60),
RQCFG_100261_.tb5_3(60),
RQCFG_100261_.tb5_4(60),
'C'
,
'Y'
,
9,
'Y'
,
'Información del Solicitante'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(61):=1097307;
RQCFG_100261_.tb3_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(61):=RQCFG_100261_.tb3_0(61);
RQCFG_100261_.old_tb3_1(61):=2036;
RQCFG_100261_.tb3_1(61):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(61),-1)));
RQCFG_100261_.old_tb3_2(61):=269;
RQCFG_100261_.tb3_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(61),-1)));
RQCFG_100261_.old_tb3_3(61):=null;
RQCFG_100261_.tb3_3(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(61),-1)));
RQCFG_100261_.old_tb3_4(61):=null;
RQCFG_100261_.tb3_4(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(61),-1)));
RQCFG_100261_.tb3_5(61):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(61):=null;
RQCFG_100261_.tb3_6(61):=NULL;
RQCFG_100261_.old_tb3_7(61):=null;
RQCFG_100261_.tb3_7(61):=NULL;
RQCFG_100261_.old_tb3_8(61):=null;
RQCFG_100261_.tb3_8(61):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (61)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(61),
RQCFG_100261_.tb3_1(61),
RQCFG_100261_.tb3_2(61),
RQCFG_100261_.tb3_3(61),
RQCFG_100261_.tb3_4(61),
RQCFG_100261_.tb3_5(61),
RQCFG_100261_.tb3_6(61),
RQCFG_100261_.tb3_7(61),
RQCFG_100261_.tb3_8(61),
null,
106237,
10,
'C¿digo del Tipo de Paquete'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(61):=1367544;
RQCFG_100261_.tb5_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(61):=RQCFG_100261_.tb5_0(61);
RQCFG_100261_.old_tb5_1(61):=269;
RQCFG_100261_.tb5_1(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(61),-1)));
RQCFG_100261_.old_tb5_2(61):=null;
RQCFG_100261_.tb5_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(61),-1)));
RQCFG_100261_.tb5_3(61):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(61):=RQCFG_100261_.tb3_0(61);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (61)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(61),
RQCFG_100261_.tb5_1(61),
RQCFG_100261_.tb5_2(61),
RQCFG_100261_.tb5_3(61),
RQCFG_100261_.tb5_4(61),
'C'
,
'Y'
,
10,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(62):=1097308;
RQCFG_100261_.tb3_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(62):=RQCFG_100261_.tb3_0(62);
RQCFG_100261_.old_tb3_1(62):=2036;
RQCFG_100261_.tb3_1(62):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(62),-1)));
RQCFG_100261_.old_tb3_2(62):=109478;
RQCFG_100261_.tb3_2(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(62),-1)));
RQCFG_100261_.old_tb3_3(62):=null;
RQCFG_100261_.tb3_3(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(62),-1)));
RQCFG_100261_.old_tb3_4(62):=null;
RQCFG_100261_.tb3_4(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(62),-1)));
RQCFG_100261_.tb3_5(62):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(62):=null;
RQCFG_100261_.tb3_6(62):=NULL;
RQCFG_100261_.old_tb3_7(62):=null;
RQCFG_100261_.tb3_7(62):=NULL;
RQCFG_100261_.old_tb3_8(62):=null;
RQCFG_100261_.tb3_8(62):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (62)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(62),
RQCFG_100261_.tb3_1(62),
RQCFG_100261_.tb3_2(62),
RQCFG_100261_.tb3_3(62),
RQCFG_100261_.tb3_4(62),
RQCFG_100261_.tb3_5(62),
RQCFG_100261_.tb3_6(62),
RQCFG_100261_.tb3_7(62),
RQCFG_100261_.tb3_8(62),
null,
106238,
11,
'Unidad Operativa Del Vendedor'
,
'N'
,
'C'
,
'N'
,
11,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(62):=1367545;
RQCFG_100261_.tb5_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(62):=RQCFG_100261_.tb5_0(62);
RQCFG_100261_.old_tb5_1(62):=109478;
RQCFG_100261_.tb5_1(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(62),-1)));
RQCFG_100261_.old_tb5_2(62):=null;
RQCFG_100261_.tb5_2(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(62),-1)));
RQCFG_100261_.tb5_3(62):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(62):=RQCFG_100261_.tb3_0(62);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (62)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(62),
RQCFG_100261_.tb5_1(62),
RQCFG_100261_.tb5_2(62),
RQCFG_100261_.tb5_3(62),
RQCFG_100261_.tb5_4(62),
'C'
,
'Y'
,
11,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(63):=1097309;
RQCFG_100261_.tb3_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(63):=RQCFG_100261_.tb3_0(63);
RQCFG_100261_.old_tb3_1(63):=2036;
RQCFG_100261_.tb3_1(63):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(63),-1)));
RQCFG_100261_.old_tb3_2(63):=42118;
RQCFG_100261_.tb3_2(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(63),-1)));
RQCFG_100261_.old_tb3_3(63):=109479;
RQCFG_100261_.tb3_3(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(63),-1)));
RQCFG_100261_.old_tb3_4(63):=null;
RQCFG_100261_.tb3_4(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(63),-1)));
RQCFG_100261_.tb3_5(63):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(63):=null;
RQCFG_100261_.tb3_6(63):=NULL;
RQCFG_100261_.old_tb3_7(63):=null;
RQCFG_100261_.tb3_7(63):=NULL;
RQCFG_100261_.old_tb3_8(63):=null;
RQCFG_100261_.tb3_8(63):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (63)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(63),
RQCFG_100261_.tb3_1(63),
RQCFG_100261_.tb3_2(63),
RQCFG_100261_.tb3_3(63),
RQCFG_100261_.tb3_4(63),
RQCFG_100261_.tb3_5(63),
RQCFG_100261_.tb3_6(63),
RQCFG_100261_.tb3_7(63),
RQCFG_100261_.tb3_8(63),
null,
106239,
12,
'C¿digo Canal De Ventas'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(63):=1367546;
RQCFG_100261_.tb5_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(63):=RQCFG_100261_.tb5_0(63);
RQCFG_100261_.old_tb5_1(63):=42118;
RQCFG_100261_.tb5_1(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(63),-1)));
RQCFG_100261_.old_tb5_2(63):=null;
RQCFG_100261_.tb5_2(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(63),-1)));
RQCFG_100261_.tb5_3(63):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(63):=RQCFG_100261_.tb3_0(63);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (63)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(63),
RQCFG_100261_.tb5_1(63),
RQCFG_100261_.tb5_2(63),
RQCFG_100261_.tb5_3(63),
RQCFG_100261_.tb5_4(63),
'C'
,
'Y'
,
12,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(64):=1097310;
RQCFG_100261_.tb3_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(64):=RQCFG_100261_.tb3_0(64);
RQCFG_100261_.old_tb3_1(64):=2036;
RQCFG_100261_.tb3_1(64):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(64),-1)));
RQCFG_100261_.old_tb3_2(64):=259;
RQCFG_100261_.tb3_2(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(64),-1)));
RQCFG_100261_.old_tb3_3(64):=null;
RQCFG_100261_.tb3_3(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(64),-1)));
RQCFG_100261_.old_tb3_4(64):=null;
RQCFG_100261_.tb3_4(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(64),-1)));
RQCFG_100261_.tb3_5(64):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(64):=121128797;
RQCFG_100261_.tb3_6(64):=NULL;
RQCFG_100261_.old_tb3_7(64):=null;
RQCFG_100261_.tb3_7(64):=NULL;
RQCFG_100261_.old_tb3_8(64):=null;
RQCFG_100261_.tb3_8(64):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (64)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(64),
RQCFG_100261_.tb3_1(64),
RQCFG_100261_.tb3_2(64),
RQCFG_100261_.tb3_3(64),
RQCFG_100261_.tb3_4(64),
RQCFG_100261_.tb3_5(64),
RQCFG_100261_.tb3_6(64),
RQCFG_100261_.tb3_7(64),
RQCFG_100261_.tb3_8(64),
null,
106240,
13,
'Fecha de Env¿o'
,
'N'
,
'C'
,
'Y'
,
13,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(64):=1367547;
RQCFG_100261_.tb5_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(64):=RQCFG_100261_.tb5_0(64);
RQCFG_100261_.old_tb5_1(64):=259;
RQCFG_100261_.tb5_1(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(64),-1)));
RQCFG_100261_.old_tb5_2(64):=null;
RQCFG_100261_.tb5_2(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(64),-1)));
RQCFG_100261_.tb5_3(64):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(64):=RQCFG_100261_.tb3_0(64);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (64)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(64),
RQCFG_100261_.tb5_1(64),
RQCFG_100261_.tb5_2(64),
RQCFG_100261_.tb5_3(64),
RQCFG_100261_.tb5_4(64),
'C'
,
'Y'
,
13,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(65):=1097311;
RQCFG_100261_.tb3_0(65):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(65):=RQCFG_100261_.tb3_0(65);
RQCFG_100261_.old_tb3_1(65):=2036;
RQCFG_100261_.tb3_1(65):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(65),-1)));
RQCFG_100261_.old_tb3_2(65):=11619;
RQCFG_100261_.tb3_2(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(65),-1)));
RQCFG_100261_.old_tb3_3(65):=null;
RQCFG_100261_.tb3_3(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(65),-1)));
RQCFG_100261_.old_tb3_4(65):=null;
RQCFG_100261_.tb3_4(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(65),-1)));
RQCFG_100261_.tb3_5(65):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(65):=null;
RQCFG_100261_.tb3_6(65):=NULL;
RQCFG_100261_.old_tb3_7(65):=null;
RQCFG_100261_.tb3_7(65):=NULL;
RQCFG_100261_.old_tb3_8(65):=null;
RQCFG_100261_.tb3_8(65):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (65)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(65),
RQCFG_100261_.tb3_1(65),
RQCFG_100261_.tb3_2(65),
RQCFG_100261_.tb3_3(65),
RQCFG_100261_.tb3_4(65),
RQCFG_100261_.tb3_5(65),
RQCFG_100261_.tb3_6(65),
RQCFG_100261_.tb3_7(65),
RQCFG_100261_.tb3_8(65),
null,
106241,
14,
'Privacidad Suscriptor'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(65):=1367548;
RQCFG_100261_.tb5_0(65):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(65):=RQCFG_100261_.tb5_0(65);
RQCFG_100261_.old_tb5_1(65):=11619;
RQCFG_100261_.tb5_1(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(65),-1)));
RQCFG_100261_.old_tb5_2(65):=null;
RQCFG_100261_.tb5_2(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(65),-1)));
RQCFG_100261_.tb5_3(65):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(65):=RQCFG_100261_.tb3_0(65);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (65)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(65),
RQCFG_100261_.tb5_1(65),
RQCFG_100261_.tb5_2(65),
RQCFG_100261_.tb5_3(65),
RQCFG_100261_.tb5_4(65),
'C'
,
'Y'
,
14,
'N'
,
'Privacidad Suscriptor'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(66):=1097312;
RQCFG_100261_.tb3_0(66):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(66):=RQCFG_100261_.tb3_0(66);
RQCFG_100261_.old_tb3_1(66):=2036;
RQCFG_100261_.tb3_1(66):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(66),-1)));
RQCFG_100261_.old_tb3_2(66):=4015;
RQCFG_100261_.tb3_2(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(66),-1)));
RQCFG_100261_.old_tb3_3(66):=793;
RQCFG_100261_.tb3_3(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(66),-1)));
RQCFG_100261_.old_tb3_4(66):=null;
RQCFG_100261_.tb3_4(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(66),-1)));
RQCFG_100261_.tb3_5(66):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(66):=null;
RQCFG_100261_.tb3_6(66):=NULL;
RQCFG_100261_.old_tb3_7(66):=null;
RQCFG_100261_.tb3_7(66):=NULL;
RQCFG_100261_.old_tb3_8(66):=null;
RQCFG_100261_.tb3_8(66):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (66)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(66),
RQCFG_100261_.tb3_1(66),
RQCFG_100261_.tb3_2(66),
RQCFG_100261_.tb3_3(66),
RQCFG_100261_.tb3_4(66),
RQCFG_100261_.tb3_5(66),
RQCFG_100261_.tb3_6(66),
RQCFG_100261_.tb3_7(66),
RQCFG_100261_.tb3_8(66),
null,
106242,
15,
'Identificador del Cliente'
,
'N'
,
'C'
,
'N'
,
15,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(66):=1367549;
RQCFG_100261_.tb5_0(66):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(66):=RQCFG_100261_.tb5_0(66);
RQCFG_100261_.old_tb5_1(66):=4015;
RQCFG_100261_.tb5_1(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(66),-1)));
RQCFG_100261_.old_tb5_2(66):=null;
RQCFG_100261_.tb5_2(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(66),-1)));
RQCFG_100261_.tb5_3(66):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(66):=RQCFG_100261_.tb3_0(66);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (66)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(66),
RQCFG_100261_.tb5_1(66),
RQCFG_100261_.tb5_2(66),
RQCFG_100261_.tb5_3(66),
RQCFG_100261_.tb5_4(66),
'C'
,
'Y'
,
15,
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(67):=1097313;
RQCFG_100261_.tb3_0(67):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(67):=RQCFG_100261_.tb3_0(67);
RQCFG_100261_.old_tb3_1(67):=2036;
RQCFG_100261_.tb3_1(67):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(67),-1)));
RQCFG_100261_.old_tb3_2(67):=474;
RQCFG_100261_.tb3_2(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(67),-1)));
RQCFG_100261_.old_tb3_3(67):=null;
RQCFG_100261_.tb3_3(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(67),-1)));
RQCFG_100261_.old_tb3_4(67):=null;
RQCFG_100261_.tb3_4(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(67),-1)));
RQCFG_100261_.tb3_5(67):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(67):=121128799;
RQCFG_100261_.tb3_6(67):=NULL;
RQCFG_100261_.old_tb3_7(67):=null;
RQCFG_100261_.tb3_7(67):=NULL;
RQCFG_100261_.old_tb3_8(67):=null;
RQCFG_100261_.tb3_8(67):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (67)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(67),
RQCFG_100261_.tb3_1(67),
RQCFG_100261_.tb3_2(67),
RQCFG_100261_.tb3_3(67),
RQCFG_100261_.tb3_4(67),
RQCFG_100261_.tb3_5(67),
RQCFG_100261_.tb3_6(67),
RQCFG_100261_.tb3_7(67),
RQCFG_100261_.tb3_8(67),
null,
106243,
16,
'Código de la Dirección'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(67):=1367550;
RQCFG_100261_.tb5_0(67):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(67):=RQCFG_100261_.tb5_0(67);
RQCFG_100261_.old_tb5_1(67):=474;
RQCFG_100261_.tb5_1(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(67),-1)));
RQCFG_100261_.old_tb5_2(67):=null;
RQCFG_100261_.tb5_2(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(67),-1)));
RQCFG_100261_.tb5_3(67):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(67):=RQCFG_100261_.tb3_0(67);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (67)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(67),
RQCFG_100261_.tb5_1(67),
RQCFG_100261_.tb5_2(67),
RQCFG_100261_.tb5_3(67),
RQCFG_100261_.tb5_4(67),
'C'
,
'E'
,
16,
'N'
,
'Código de la Dirección'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(68):=1097314;
RQCFG_100261_.tb3_0(68):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(68):=RQCFG_100261_.tb3_0(68);
RQCFG_100261_.old_tb3_1(68):=2036;
RQCFG_100261_.tb3_1(68):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(68),-1)));
RQCFG_100261_.old_tb3_2(68):=11376;
RQCFG_100261_.tb3_2(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(68),-1)));
RQCFG_100261_.old_tb3_3(68):=null;
RQCFG_100261_.tb3_3(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(68),-1)));
RQCFG_100261_.old_tb3_4(68):=null;
RQCFG_100261_.tb3_4(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(68),-1)));
RQCFG_100261_.tb3_5(68):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(68):=121128800;
RQCFG_100261_.tb3_6(68):=NULL;
RQCFG_100261_.old_tb3_7(68):=null;
RQCFG_100261_.tb3_7(68):=NULL;
RQCFG_100261_.old_tb3_8(68):=null;
RQCFG_100261_.tb3_8(68):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (68)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(68),
RQCFG_100261_.tb3_1(68),
RQCFG_100261_.tb3_2(68),
RQCFG_100261_.tb3_3(68),
RQCFG_100261_.tb3_4(68),
RQCFG_100261_.tb3_5(68),
RQCFG_100261_.tb3_6(68),
RQCFG_100261_.tb3_7(68),
RQCFG_100261_.tb3_8(68),
null,
106244,
17,
'Direccion de instalación'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(68):=1367551;
RQCFG_100261_.tb5_0(68):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(68):=RQCFG_100261_.tb5_0(68);
RQCFG_100261_.old_tb5_1(68):=11376;
RQCFG_100261_.tb5_1(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(68),-1)));
RQCFG_100261_.old_tb5_2(68):=null;
RQCFG_100261_.tb5_2(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(68),-1)));
RQCFG_100261_.tb5_3(68):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(68):=RQCFG_100261_.tb3_0(68);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (68)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(68),
RQCFG_100261_.tb5_1(68),
RQCFG_100261_.tb5_2(68),
RQCFG_100261_.tb5_3(68),
RQCFG_100261_.tb5_4(68),
'C'
,
'Y'
,
17,
'N'
,
'Direccion de instalación'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(69):=1097315;
RQCFG_100261_.tb3_0(69):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(69):=RQCFG_100261_.tb3_0(69);
RQCFG_100261_.old_tb3_1(69):=2036;
RQCFG_100261_.tb3_1(69):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(69),-1)));
RQCFG_100261_.old_tb3_2(69):=282;
RQCFG_100261_.tb3_2(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(69),-1)));
RQCFG_100261_.old_tb3_3(69):=null;
RQCFG_100261_.tb3_3(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(69),-1)));
RQCFG_100261_.old_tb3_4(69):=null;
RQCFG_100261_.tb3_4(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(69),-1)));
RQCFG_100261_.tb3_5(69):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(69):=121128801;
RQCFG_100261_.tb3_6(69):=NULL;
RQCFG_100261_.old_tb3_7(69):=null;
RQCFG_100261_.tb3_7(69):=NULL;
RQCFG_100261_.old_tb3_8(69):=null;
RQCFG_100261_.tb3_8(69):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (69)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(69),
RQCFG_100261_.tb3_1(69),
RQCFG_100261_.tb3_2(69),
RQCFG_100261_.tb3_3(69),
RQCFG_100261_.tb3_4(69),
RQCFG_100261_.tb3_5(69),
RQCFG_100261_.tb3_6(69),
RQCFG_100261_.tb3_7(69),
RQCFG_100261_.tb3_8(69),
null,
106245,
18,
'Dirección'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(69):=1367552;
RQCFG_100261_.tb5_0(69):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(69):=RQCFG_100261_.tb5_0(69);
RQCFG_100261_.old_tb5_1(69):=282;
RQCFG_100261_.tb5_1(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(69),-1)));
RQCFG_100261_.old_tb5_2(69):=null;
RQCFG_100261_.tb5_2(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(69),-1)));
RQCFG_100261_.tb5_3(69):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(69):=RQCFG_100261_.tb3_0(69);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (69)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(69),
RQCFG_100261_.tb5_1(69),
RQCFG_100261_.tb5_2(69),
RQCFG_100261_.tb5_3(69),
RQCFG_100261_.tb5_4(69),
'C'
,
'Y'
,
18,
'N'
,
'Dirección'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(70):=1097316;
RQCFG_100261_.tb3_0(70):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(70):=RQCFG_100261_.tb3_0(70);
RQCFG_100261_.old_tb3_1(70):=2036;
RQCFG_100261_.tb3_1(70):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(70),-1)));
RQCFG_100261_.old_tb3_2(70):=475;
RQCFG_100261_.tb3_2(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(70),-1)));
RQCFG_100261_.old_tb3_3(70):=null;
RQCFG_100261_.tb3_3(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(70),-1)));
RQCFG_100261_.old_tb3_4(70):=null;
RQCFG_100261_.tb3_4(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(70),-1)));
RQCFG_100261_.tb3_5(70):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(70):=121128802;
RQCFG_100261_.tb3_6(70):=NULL;
RQCFG_100261_.old_tb3_7(70):=null;
RQCFG_100261_.tb3_7(70):=NULL;
RQCFG_100261_.old_tb3_8(70):=null;
RQCFG_100261_.tb3_8(70):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (70)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(70),
RQCFG_100261_.tb3_1(70),
RQCFG_100261_.tb3_2(70),
RQCFG_100261_.tb3_3(70),
RQCFG_100261_.tb3_4(70),
RQCFG_100261_.tb3_5(70),
RQCFG_100261_.tb3_6(70),
RQCFG_100261_.tb3_7(70),
RQCFG_100261_.tb3_8(70),
null,
106246,
19,
'C´´odigo de la Ubicación Geográfica'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(70):=1367553;
RQCFG_100261_.tb5_0(70):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(70):=RQCFG_100261_.tb5_0(70);
RQCFG_100261_.old_tb5_1(70):=475;
RQCFG_100261_.tb5_1(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(70),-1)));
RQCFG_100261_.old_tb5_2(70):=null;
RQCFG_100261_.tb5_2(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(70),-1)));
RQCFG_100261_.tb5_3(70):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(70):=RQCFG_100261_.tb3_0(70);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (70)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(70),
RQCFG_100261_.tb5_1(70),
RQCFG_100261_.tb5_2(70),
RQCFG_100261_.tb5_3(70),
RQCFG_100261_.tb5_4(70),
'C'
,
'Y'
,
19,
'N'
,
'C´´odigo de la Ubicación Geográfica'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(71):=1097317;
RQCFG_100261_.tb3_0(71):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(71):=RQCFG_100261_.tb3_0(71);
RQCFG_100261_.old_tb3_1(71):=2036;
RQCFG_100261_.tb3_1(71):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(71),-1)));
RQCFG_100261_.old_tb3_2(71):=2;
RQCFG_100261_.tb3_2(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(71),-1)));
RQCFG_100261_.old_tb3_3(71):=null;
RQCFG_100261_.tb3_3(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(71),-1)));
RQCFG_100261_.old_tb3_4(71):=null;
RQCFG_100261_.tb3_4(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(71),-1)));
RQCFG_100261_.tb3_5(71):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(71):=121128803;
RQCFG_100261_.tb3_6(71):=NULL;
RQCFG_100261_.old_tb3_7(71):=null;
RQCFG_100261_.tb3_7(71):=NULL;
RQCFG_100261_.old_tb3_8(71):=null;
RQCFG_100261_.tb3_8(71):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (71)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(71),
RQCFG_100261_.tb3_1(71),
RQCFG_100261_.tb3_2(71),
RQCFG_100261_.tb3_3(71),
RQCFG_100261_.tb3_4(71),
RQCFG_100261_.tb3_5(71),
RQCFG_100261_.tb3_6(71),
RQCFG_100261_.tb3_7(71),
RQCFG_100261_.tb3_8(71),
null,
106247,
20,
'IS_ADDRESS_MAIN'
,
'N'
,
'C'
,
'N'
,
20,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(71):=1367554;
RQCFG_100261_.tb5_0(71):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(71):=RQCFG_100261_.tb5_0(71);
RQCFG_100261_.old_tb5_1(71):=2;
RQCFG_100261_.tb5_1(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(71),-1)));
RQCFG_100261_.old_tb5_2(71):=null;
RQCFG_100261_.tb5_2(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(71),-1)));
RQCFG_100261_.tb5_3(71):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(71):=RQCFG_100261_.tb3_0(71);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (71)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(71),
RQCFG_100261_.tb5_1(71),
RQCFG_100261_.tb5_2(71),
RQCFG_100261_.tb5_3(71),
RQCFG_100261_.tb5_4(71),
'C'
,
'Y'
,
20,
'N'
,
'IS_ADDRESS_MAIN'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(72):=1097318;
RQCFG_100261_.tb3_0(72):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(72):=RQCFG_100261_.tb3_0(72);
RQCFG_100261_.old_tb3_1(72):=2036;
RQCFG_100261_.tb3_1(72):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(72),-1)));
RQCFG_100261_.old_tb3_2(72):=39322;
RQCFG_100261_.tb3_2(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(72),-1)));
RQCFG_100261_.old_tb3_3(72):=255;
RQCFG_100261_.tb3_3(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(72),-1)));
RQCFG_100261_.old_tb3_4(72):=null;
RQCFG_100261_.tb3_4(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(72),-1)));
RQCFG_100261_.tb3_5(72):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(72):=null;
RQCFG_100261_.tb3_6(72):=NULL;
RQCFG_100261_.old_tb3_7(72):=null;
RQCFG_100261_.tb3_7(72):=NULL;
RQCFG_100261_.old_tb3_8(72):=null;
RQCFG_100261_.tb3_8(72):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (72)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(72),
RQCFG_100261_.tb3_1(72),
RQCFG_100261_.tb3_2(72),
RQCFG_100261_.tb3_3(72),
RQCFG_100261_.tb3_4(72),
RQCFG_100261_.tb3_5(72),
RQCFG_100261_.tb3_6(72),
RQCFG_100261_.tb3_7(72),
RQCFG_100261_.tb3_8(72),
null,
106248,
21,
'Identificador De Solicitud'
,
'N'
,
'C'
,
'N'
,
21,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(72):=1367555;
RQCFG_100261_.tb5_0(72):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(72):=RQCFG_100261_.tb5_0(72);
RQCFG_100261_.old_tb5_1(72):=39322;
RQCFG_100261_.tb5_1(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(72),-1)));
RQCFG_100261_.old_tb5_2(72):=null;
RQCFG_100261_.tb5_2(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(72),-1)));
RQCFG_100261_.tb5_3(72):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(72):=RQCFG_100261_.tb3_0(72);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (72)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(72),
RQCFG_100261_.tb5_1(72),
RQCFG_100261_.tb5_2(72),
RQCFG_100261_.tb5_3(72),
RQCFG_100261_.tb5_4(72),
'C'
,
'Y'
,
21,
'N'
,
'Identificador De Solicitud'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(73):=1097319;
RQCFG_100261_.tb3_0(73):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(73):=RQCFG_100261_.tb3_0(73);
RQCFG_100261_.old_tb3_1(73):=2036;
RQCFG_100261_.tb3_1(73):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(73),-1)));
RQCFG_100261_.old_tb3_2(73):=476;
RQCFG_100261_.tb3_2(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(73),-1)));
RQCFG_100261_.old_tb3_3(73):=null;
RQCFG_100261_.tb3_3(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(73),-1)));
RQCFG_100261_.old_tb3_4(73):=null;
RQCFG_100261_.tb3_4(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(73),-1)));
RQCFG_100261_.tb3_5(73):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(73):=121128805;
RQCFG_100261_.tb3_6(73):=NULL;
RQCFG_100261_.old_tb3_7(73):=null;
RQCFG_100261_.tb3_7(73):=NULL;
RQCFG_100261_.old_tb3_8(73):=null;
RQCFG_100261_.tb3_8(73):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (73)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(73),
RQCFG_100261_.tb3_1(73),
RQCFG_100261_.tb3_2(73),
RQCFG_100261_.tb3_3(73),
RQCFG_100261_.tb3_4(73),
RQCFG_100261_.tb3_5(73),
RQCFG_100261_.tb3_6(73),
RQCFG_100261_.tb3_7(73),
RQCFG_100261_.tb3_8(73),
null,
106249,
22,
'C¿digo del Tipo Direcci¿n'
,
'N'
,
'C'
,
'N'
,
22,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(73):=1367556;
RQCFG_100261_.tb5_0(73):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(73):=RQCFG_100261_.tb5_0(73);
RQCFG_100261_.old_tb5_1(73):=476;
RQCFG_100261_.tb5_1(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(73),-1)));
RQCFG_100261_.old_tb5_2(73):=null;
RQCFG_100261_.tb5_2(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(73),-1)));
RQCFG_100261_.tb5_3(73):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(73):=RQCFG_100261_.tb3_0(73);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (73)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(73),
RQCFG_100261_.tb5_1(73),
RQCFG_100261_.tb5_2(73),
RQCFG_100261_.tb5_3(73),
RQCFG_100261_.tb5_4(73),
'C'
,
'Y'
,
22,
'N'
,
'C¿digo del Tipo Direcci¿n'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(74):=1097320;
RQCFG_100261_.tb3_0(74):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(74):=RQCFG_100261_.tb3_0(74);
RQCFG_100261_.old_tb3_1(74):=2036;
RQCFG_100261_.tb3_1(74):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(74),-1)));
RQCFG_100261_.old_tb3_2(74):=68342;
RQCFG_100261_.tb3_2(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(74),-1)));
RQCFG_100261_.old_tb3_3(74):=255;
RQCFG_100261_.tb3_3(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(74),-1)));
RQCFG_100261_.old_tb3_4(74):=null;
RQCFG_100261_.tb3_4(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(74),-1)));
RQCFG_100261_.tb3_5(74):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(74):=null;
RQCFG_100261_.tb3_6(74):=NULL;
RQCFG_100261_.old_tb3_7(74):=null;
RQCFG_100261_.tb3_7(74):=NULL;
RQCFG_100261_.old_tb3_8(74):=null;
RQCFG_100261_.tb3_8(74):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (74)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(74),
RQCFG_100261_.tb3_1(74),
RQCFG_100261_.tb3_2(74),
RQCFG_100261_.tb3_3(74),
RQCFG_100261_.tb3_4(74),
RQCFG_100261_.tb3_5(74),
RQCFG_100261_.tb3_6(74),
RQCFG_100261_.tb3_7(74),
RQCFG_100261_.tb3_8(74),
null,
106250,
23,
'Solicitud De Venta'
,
'N'
,
'C'
,
'N'
,
23,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(74):=1367557;
RQCFG_100261_.tb5_0(74):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(74):=RQCFG_100261_.tb5_0(74);
RQCFG_100261_.old_tb5_1(74):=68342;
RQCFG_100261_.tb5_1(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(74),-1)));
RQCFG_100261_.old_tb5_2(74):=null;
RQCFG_100261_.tb5_2(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(74),-1)));
RQCFG_100261_.tb5_3(74):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(74):=RQCFG_100261_.tb3_0(74);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (74)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(74),
RQCFG_100261_.tb5_1(74),
RQCFG_100261_.tb5_2(74),
RQCFG_100261_.tb5_3(74),
RQCFG_100261_.tb5_4(74),
'C'
,
'Y'
,
23,
'N'
,
'Solicitud De Venta'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(75):=1097321;
RQCFG_100261_.tb3_0(75):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(75):=RQCFG_100261_.tb3_0(75);
RQCFG_100261_.old_tb3_1(75):=2036;
RQCFG_100261_.tb3_1(75):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(75),-1)));
RQCFG_100261_.old_tb3_2(75):=68343;
RQCFG_100261_.tb3_2(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(75),-1)));
RQCFG_100261_.old_tb3_3(75):=null;
RQCFG_100261_.tb3_3(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(75),-1)));
RQCFG_100261_.old_tb3_4(75):=null;
RQCFG_100261_.tb3_4(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(75),-1)));
RQCFG_100261_.tb3_5(75):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(75):=null;
RQCFG_100261_.tb3_6(75):=NULL;
RQCFG_100261_.old_tb3_7(75):=121128807;
RQCFG_100261_.tb3_7(75):=NULL;
RQCFG_100261_.old_tb3_8(75):=120071860;
RQCFG_100261_.tb3_8(75):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (75)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(75),
RQCFG_100261_.tb3_1(75),
RQCFG_100261_.tb3_2(75),
RQCFG_100261_.tb3_3(75),
RQCFG_100261_.tb3_4(75),
RQCFG_100261_.tb3_5(75),
RQCFG_100261_.tb3_6(75),
RQCFG_100261_.tb3_7(75),
RQCFG_100261_.tb3_8(75),
null,
106251,
24,
'Plan De Financiación'
,
'N'
,
'C'
,
'Y'
,
24,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(75):=1367558;
RQCFG_100261_.tb5_0(75):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(75):=RQCFG_100261_.tb5_0(75);
RQCFG_100261_.old_tb5_1(75):=68343;
RQCFG_100261_.tb5_1(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(75),-1)));
RQCFG_100261_.old_tb5_2(75):=null;
RQCFG_100261_.tb5_2(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(75),-1)));
RQCFG_100261_.tb5_3(75):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(75):=RQCFG_100261_.tb3_0(75);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (75)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(75),
RQCFG_100261_.tb5_1(75),
RQCFG_100261_.tb5_2(75),
RQCFG_100261_.tb5_3(75),
RQCFG_100261_.tb5_4(75),
'C'
,
'Y'
,
24,
'Y'
,
'Plan De Financiación'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(76):=1097322;
RQCFG_100261_.tb3_0(76):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(76):=RQCFG_100261_.tb3_0(76);
RQCFG_100261_.old_tb3_1(76):=2036;
RQCFG_100261_.tb3_1(76):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(76),-1)));
RQCFG_100261_.old_tb3_2(76):=68350;
RQCFG_100261_.tb3_2(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(76),-1)));
RQCFG_100261_.old_tb3_3(76):=null;
RQCFG_100261_.tb3_3(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(76),-1)));
RQCFG_100261_.old_tb3_4(76):=null;
RQCFG_100261_.tb3_4(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(76),-1)));
RQCFG_100261_.tb3_5(76):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(76):=null;
RQCFG_100261_.tb3_6(76):=NULL;
RQCFG_100261_.old_tb3_7(76):=null;
RQCFG_100261_.tb3_7(76):=NULL;
RQCFG_100261_.old_tb3_8(76):=null;
RQCFG_100261_.tb3_8(76):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (76)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(76),
RQCFG_100261_.tb3_1(76),
RQCFG_100261_.tb3_2(76),
RQCFG_100261_.tb3_3(76),
RQCFG_100261_.tb3_4(76),
RQCFG_100261_.tb3_5(76),
RQCFG_100261_.tb3_6(76),
RQCFG_100261_.tb3_7(76),
RQCFG_100261_.tb3_8(76),
null,
106252,
25,
'Número De Cuotas'
,
'N'
,
'C'
,
'N'
,
25,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(76):=1367559;
RQCFG_100261_.tb5_0(76):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(76):=RQCFG_100261_.tb5_0(76);
RQCFG_100261_.old_tb5_1(76):=68350;
RQCFG_100261_.tb5_1(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(76),-1)));
RQCFG_100261_.old_tb5_2(76):=null;
RQCFG_100261_.tb5_2(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(76),-1)));
RQCFG_100261_.tb5_3(76):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(76):=RQCFG_100261_.tb3_0(76);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (76)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(76),
RQCFG_100261_.tb5_1(76),
RQCFG_100261_.tb5_2(76),
RQCFG_100261_.tb5_3(76),
RQCFG_100261_.tb5_4(76),
'C'
,
'Y'
,
25,
'N'
,
'Número De Cuotas'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(77):=1097323;
RQCFG_100261_.tb3_0(77):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(77):=RQCFG_100261_.tb3_0(77);
RQCFG_100261_.old_tb3_1(77):=2036;
RQCFG_100261_.tb3_1(77):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(77),-1)));
RQCFG_100261_.old_tb3_2(77):=68352;
RQCFG_100261_.tb3_2(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(77),-1)));
RQCFG_100261_.old_tb3_3(77):=null;
RQCFG_100261_.tb3_3(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(77),-1)));
RQCFG_100261_.old_tb3_4(77):=null;
RQCFG_100261_.tb3_4(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(77),-1)));
RQCFG_100261_.tb3_5(77):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(77):=null;
RQCFG_100261_.tb3_6(77):=NULL;
RQCFG_100261_.old_tb3_7(77):=null;
RQCFG_100261_.tb3_7(77):=NULL;
RQCFG_100261_.old_tb3_8(77):=null;
RQCFG_100261_.tb3_8(77):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (77)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(77),
RQCFG_100261_.tb3_1(77),
RQCFG_100261_.tb3_2(77),
RQCFG_100261_.tb3_3(77),
RQCFG_100261_.tb3_4(77),
RQCFG_100261_.tb3_5(77),
RQCFG_100261_.tb3_6(77),
RQCFG_100261_.tb3_7(77),
RQCFG_100261_.tb3_8(77),
null,
106253,
26,
'Valor A Financiar'
,
'N'
,
'C'
,
'N'
,
26,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(77):=1367560;
RQCFG_100261_.tb5_0(77):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(77):=RQCFG_100261_.tb5_0(77);
RQCFG_100261_.old_tb5_1(77):=68352;
RQCFG_100261_.tb5_1(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(77),-1)));
RQCFG_100261_.old_tb5_2(77):=null;
RQCFG_100261_.tb5_2(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(77),-1)));
RQCFG_100261_.tb5_3(77):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(77):=RQCFG_100261_.tb3_0(77);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (77)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(77),
RQCFG_100261_.tb5_1(77),
RQCFG_100261_.tb5_2(77),
RQCFG_100261_.tb5_3(77),
RQCFG_100261_.tb5_4(77),
'C'
,
'Y'
,
26,
'N'
,
'Valor A Financiar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(78):=1097324;
RQCFG_100261_.tb3_0(78):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(78):=RQCFG_100261_.tb3_0(78);
RQCFG_100261_.old_tb3_1(78):=2036;
RQCFG_100261_.tb3_1(78):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(78),-1)));
RQCFG_100261_.old_tb3_2(78):=68344;
RQCFG_100261_.tb3_2(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(78),-1)));
RQCFG_100261_.old_tb3_3(78):=null;
RQCFG_100261_.tb3_3(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(78),-1)));
RQCFG_100261_.old_tb3_4(78):=null;
RQCFG_100261_.tb3_4(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(78),-1)));
RQCFG_100261_.tb3_5(78):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(78):=null;
RQCFG_100261_.tb3_6(78):=NULL;
RQCFG_100261_.old_tb3_7(78):=null;
RQCFG_100261_.tb3_7(78):=NULL;
RQCFG_100261_.old_tb3_8(78):=null;
RQCFG_100261_.tb3_8(78):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (78)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(78),
RQCFG_100261_.tb3_1(78),
RQCFG_100261_.tb3_2(78),
RQCFG_100261_.tb3_3(78),
RQCFG_100261_.tb3_4(78),
RQCFG_100261_.tb3_5(78),
RQCFG_100261_.tb3_6(78),
RQCFG_100261_.tb3_7(78),
RQCFG_100261_.tb3_8(78),
null,
106254,
27,
'Método De Cálculo'
,
'N'
,
'C'
,
'N'
,
27,
null,
null);

exception when others then
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(78):=1367561;
RQCFG_100261_.tb5_0(78):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(78):=RQCFG_100261_.tb5_0(78);
RQCFG_100261_.old_tb5_1(78):=68344;
RQCFG_100261_.tb5_1(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(78),-1)));
RQCFG_100261_.old_tb5_2(78):=null;
RQCFG_100261_.tb5_2(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(78),-1)));
RQCFG_100261_.tb5_3(78):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(78):=RQCFG_100261_.tb3_0(78);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (78)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(78),
RQCFG_100261_.tb5_1(78),
RQCFG_100261_.tb5_2(78),
RQCFG_100261_.tb5_3(78),
RQCFG_100261_.tb5_4(78),
'C'
,
'Y'
,
27,
'N'
,
'Método De Cálculo'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(79):=1097325;
RQCFG_100261_.tb3_0(79):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(79):=RQCFG_100261_.tb3_0(79);
RQCFG_100261_.old_tb3_1(79):=2036;
RQCFG_100261_.tb3_1(79):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(79),-1)));
RQCFG_100261_.old_tb3_2(79):=68345;
RQCFG_100261_.tb3_2(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(79),-1)));
RQCFG_100261_.old_tb3_3(79):=null;
RQCFG_100261_.tb3_3(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(79),-1)));
RQCFG_100261_.old_tb3_4(79):=null;
RQCFG_100261_.tb3_4(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(79),-1)));
RQCFG_100261_.tb3_5(79):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(79):=null;
RQCFG_100261_.tb3_6(79):=NULL;
RQCFG_100261_.old_tb3_7(79):=null;
RQCFG_100261_.tb3_7(79):=NULL;
RQCFG_100261_.old_tb3_8(79):=null;
RQCFG_100261_.tb3_8(79):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (79)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(79),
RQCFG_100261_.tb3_1(79),
RQCFG_100261_.tb3_2(79),
RQCFG_100261_.tb3_3(79),
RQCFG_100261_.tb3_4(79),
RQCFG_100261_.tb3_5(79),
RQCFG_100261_.tb3_6(79),
RQCFG_100261_.tb3_7(79),
RQCFG_100261_.tb3_8(79),
null,
106255,
28,
'C¿digo De La Tasa De Inter¿s'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(79):=1367562;
RQCFG_100261_.tb5_0(79):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(79):=RQCFG_100261_.tb5_0(79);
RQCFG_100261_.old_tb5_1(79):=68345;
RQCFG_100261_.tb5_1(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(79),-1)));
RQCFG_100261_.old_tb5_2(79):=null;
RQCFG_100261_.tb5_2(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(79),-1)));
RQCFG_100261_.tb5_3(79):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(79):=RQCFG_100261_.tb3_0(79);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (79)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(79),
RQCFG_100261_.tb5_1(79),
RQCFG_100261_.tb5_2(79),
RQCFG_100261_.tb5_3(79),
RQCFG_100261_.tb5_4(79),
'C'
,
'Y'
,
28,
'N'
,
'C¿digo De La Tasa De Inter¿s'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(80):=1097326;
RQCFG_100261_.tb3_0(80):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(80):=RQCFG_100261_.tb3_0(80);
RQCFG_100261_.old_tb3_1(80):=2036;
RQCFG_100261_.tb3_1(80):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(80),-1)));
RQCFG_100261_.old_tb3_2(80):=68346;
RQCFG_100261_.tb3_2(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(80),-1)));
RQCFG_100261_.old_tb3_3(80):=null;
RQCFG_100261_.tb3_3(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(80),-1)));
RQCFG_100261_.old_tb3_4(80):=null;
RQCFG_100261_.tb3_4(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(80),-1)));
RQCFG_100261_.tb3_5(80):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(80):=null;
RQCFG_100261_.tb3_6(80):=NULL;
RQCFG_100261_.old_tb3_7(80):=null;
RQCFG_100261_.tb3_7(80):=NULL;
RQCFG_100261_.old_tb3_8(80):=null;
RQCFG_100261_.tb3_8(80):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (80)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(80),
RQCFG_100261_.tb3_1(80),
RQCFG_100261_.tb3_2(80),
RQCFG_100261_.tb3_3(80),
RQCFG_100261_.tb3_4(80),
RQCFG_100261_.tb3_5(80),
RQCFG_100261_.tb3_6(80),
RQCFG_100261_.tb3_7(80),
RQCFG_100261_.tb3_8(80),
null,
106256,
29,
'Fecha De Cobro Primera Cuota'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(80):=1367563;
RQCFG_100261_.tb5_0(80):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(80):=RQCFG_100261_.tb5_0(80);
RQCFG_100261_.old_tb5_1(80):=68346;
RQCFG_100261_.tb5_1(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(80),-1)));
RQCFG_100261_.old_tb5_2(80):=null;
RQCFG_100261_.tb5_2(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(80),-1)));
RQCFG_100261_.tb5_3(80):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(80):=RQCFG_100261_.tb3_0(80);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (80)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(80),
RQCFG_100261_.tb5_1(80),
RQCFG_100261_.tb5_2(80),
RQCFG_100261_.tb5_3(80),
RQCFG_100261_.tb5_4(80),
'C'
,
'Y'
,
29,
'N'
,
'Fecha De Cobro Primera Cuota'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb3_0(81):=1097327;
RQCFG_100261_.tb3_0(81):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100261_.tb3_0(81):=RQCFG_100261_.tb3_0(81);
RQCFG_100261_.old_tb3_1(81):=2036;
RQCFG_100261_.tb3_1(81):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100261_.TBENTITYNAME(NVL(RQCFG_100261_.old_tb3_1(81),-1)));
RQCFG_100261_.old_tb3_2(81):=68347;
RQCFG_100261_.tb3_2(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_2(81),-1)));
RQCFG_100261_.old_tb3_3(81):=null;
RQCFG_100261_.tb3_3(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_3(81),-1)));
RQCFG_100261_.old_tb3_4(81):=null;
RQCFG_100261_.tb3_4(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb3_4(81),-1)));
RQCFG_100261_.tb3_5(81):=RQCFG_100261_.tb2_2(0);
RQCFG_100261_.old_tb3_6(81):=null;
RQCFG_100261_.tb3_6(81):=NULL;
RQCFG_100261_.old_tb3_7(81):=null;
RQCFG_100261_.tb3_7(81):=NULL;
RQCFG_100261_.old_tb3_8(81):=null;
RQCFG_100261_.tb3_8(81):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (81)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100261_.tb3_0(81),
RQCFG_100261_.tb3_1(81),
RQCFG_100261_.tb3_2(81),
RQCFG_100261_.tb3_3(81),
RQCFG_100261_.tb3_4(81),
RQCFG_100261_.tb3_5(81),
RQCFG_100261_.tb3_6(81),
RQCFG_100261_.tb3_7(81),
RQCFG_100261_.tb3_8(81),
null,
106257,
30,
'Porcentaje A Financiar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100261_.blProcessStatus) then
 return;
end if;

RQCFG_100261_.old_tb5_0(81):=1367564;
RQCFG_100261_.tb5_0(81):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100261_.tb5_0(81):=RQCFG_100261_.tb5_0(81);
RQCFG_100261_.old_tb5_1(81):=68347;
RQCFG_100261_.tb5_1(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_1(81),-1)));
RQCFG_100261_.old_tb5_2(81):=null;
RQCFG_100261_.tb5_2(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100261_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100261_.old_tb5_2(81),-1)));
RQCFG_100261_.tb5_3(81):=RQCFG_100261_.tb4_0(2);
RQCFG_100261_.tb5_4(81):=RQCFG_100261_.tb3_0(81);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (81)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100261_.tb5_0(81),
RQCFG_100261_.tb5_1(81),
RQCFG_100261_.tb5_2(81),
RQCFG_100261_.tb5_3(81),
RQCFG_100261_.tb5_4(81),
'C'
,
'Y'
,
30,
'N'
,
'Porcentaje A Financiar'
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
RQCFG_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100261);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100261)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100261_.blProcessStatus) then
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
AND     external_root_id = 100261
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
AND     external_root_id = 100261
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
AND     external_root_id = 100261
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100261, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100261)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100261, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100261)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100261, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100261)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100261, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100261)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100261_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100261_.tbCompositions.FIRST..RQCFG_100261_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100261_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100261_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100261_.blProcessStatus := false;
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
 nuIndex := RQCFG_100261_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100261_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100261_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100261_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100261_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100261_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100261_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100261_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100261_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100261_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100261_',
'CREATE OR REPLACE PACKAGE I18N_R_100261_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100261_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100261_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100261
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
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
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(3):='C_BRILLA_SEGUROS_10333'
;
I18N_R_100261_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(3),
I18N_R_100261_.tb0_1(3),
'WE8ISO8859P1'
,
'Brilla Seguros'
,
'Brilla Seguros'
,
null,
'Brilla Seguros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(4):='C_BRILLA_SEGUROS_10333'
;
I18N_R_100261_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(4),
I18N_R_100261_.tb0_1(4),
'WE8ISO8859P1'
,
'Brilla Seguros'
,
'Brilla Seguros'
,
null,
'Brilla Seguros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(5):='C_BRILLA_SEGUROS_10333'
;
I18N_R_100261_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(5),
I18N_R_100261_.tb0_1(5),
'WE8ISO8859P1'
,
'Brilla Seguros'
,
'Brilla Seguros'
,
null,
'Brilla Seguros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(0):='M_INSTALACION_DEBRILLA_SEGUROS_100268'
;
I18N_R_100261_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(0),
I18N_R_100261_.tb0_1(0),
'WE8ISO8859P1'
,
'Venta de Brilla Seguros'
,
'Venta de Brilla Seguros'
,
null,
'Venta de Brilla Seguros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(1):='M_INSTALACION_DEBRILLA_SEGUROS_100268'
;
I18N_R_100261_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(1),
I18N_R_100261_.tb0_1(1),
'WE8ISO8859P1'
,
'Venta de Brilla Seguros'
,
'Venta de Brilla Seguros'
,
null,
'Venta de Brilla Seguros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(2):='M_INSTALACION_DEBRILLA_SEGUROS_100268'
;
I18N_R_100261_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(2),
I18N_R_100261_.tb0_1(2),
'WE8ISO8859P1'
,
'Venta de Brilla Seguros'
,
'Venta de Brilla Seguros'
,
null,
'Venta de Brilla Seguros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(6):='PAQUETE'
;
I18N_R_100261_.tb0_1(6):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(6),
I18N_R_100261_.tb0_1(6),
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
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(7):='PAQUETE'
;
I18N_R_100261_.tb0_1(7):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (7)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(7),
I18N_R_100261_.tb0_1(7),
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
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(8):='PAQUETE'
;
I18N_R_100261_.tb0_1(8):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (8)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(8),
I18N_R_100261_.tb0_1(8),
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
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100261_.blProcessStatus) then
 return;
end if;

I18N_R_100261_.tb0_0(9):='PAQUETE'
;
I18N_R_100261_.tb0_1(9):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (9)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100261_.tb0_0(9),
I18N_R_100261_.tb0_1(9),
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
I18N_R_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100261_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100261_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100261_',
'CREATE OR REPLACE PACKAGE RQEXEC_100261_ IS ' || chr(10) ||
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
'END RQEXEC_100261_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100261_******************************'); END;
/


BEGIN

if (not RQEXEC_100261_.blProcessStatus) then
 return;
end if;

RQEXEC_100261_.old_tb0_0(0):='P_TRAMITE_VENTA_SEGUROS_XML_100261'
;
RQEXEC_100261_.tb0_0(0):=UPPER(RQEXEC_100261_.old_tb0_0(0));
RQEXEC_100261_.old_tb0_1(0):=200372;
RQEXEC_100261_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100261_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100261_.tb0_1(0):=RQEXEC_100261_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100261_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100261_.tb0_1(0),
DESCRIPTION='Tramite Venta Seguros XML'
,
PATH=null,
VERSION='114'
,
EXECUTABLE_TYPE_ID=3,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=16,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP=null,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='N'
,
TIMES_EXECUTED=null,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=null,
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100261_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100261_.tb0_0(0),
RQEXEC_100261_.tb0_1(0),
'Tramite Venta Seguros XML'
,
null,
'114'
,
3,
2,
16,
1,
null,
'N'
,
null,
'N'
,
'N'
,
null,
'O',
null,
null);
end if;

exception when others then
RQEXEC_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100261_.blProcessStatus) then
 return;
end if;

RQEXEC_100261_.tb1_0(0):=1;
RQEXEC_100261_.tb1_1(0):=RQEXEC_100261_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100261_.tb1_0(0),
RQEXEC_100261_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100261_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100261_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100261_******************************'); end;
/

