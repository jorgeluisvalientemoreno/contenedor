BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_323_',
'CREATE OR REPLACE PACKAGE RQTY_323_ IS ' || chr(10) ||
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
'tb12_1 ty12_1;type ty13_0 is table of PS_PACKAGE_EVENTS.PACKAGE_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty13_1 is table of PS_PACKAGE_EVENTS.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_1 ty13_1; ' || chr(10) ||
'tb13_1 ty13_1;type ty14_0 is table of PS_WHEN_PACKAGE.WHEN_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty14_1 is table of PS_WHEN_PACKAGE.PACKAGE_EVENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_1 ty14_1; ' || chr(10) ||
'tb14_1 ty14_1;type ty14_2 is table of PS_WHEN_PACKAGE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_2 ty14_2; ' || chr(10) ||
'tb14_2 ty14_2;type ty15_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb15_0 ty15_0; ' || chr(10) ||
'tb15_0 ty15_0;type ty16_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb16_0 ty16_0; ' || chr(10) ||
'tb16_0 ty16_0;type ty17_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb17_0 ty17_0; ' || chr(10) ||
'tb17_0 ty17_0;type ty17_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb17_1 ty17_1; ' || chr(10) ||
'tb17_1 ty17_1;type ty17_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb17_2 ty17_2; ' || chr(10) ||
'tb17_2 ty17_2;type ty17_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb17_3 ty17_3; ' || chr(10) ||
'tb17_3 ty17_3;type ty18_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb18_0 ty18_0; ' || chr(10) ||
'tb18_0 ty18_0;type ty19_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_0 ty19_0; ' || chr(10) ||
'tb19_0 ty19_0;type ty19_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_1 ty19_1; ' || chr(10) ||
'tb19_1 ty19_1;type ty19_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_2 ty19_2; ' || chr(10) ||
'tb19_2 ty19_2;type ty19_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb19_3 ty19_3; ' || chr(10) ||
'tb19_3 ty19_3;type ty20_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb20_0 ty20_0; ' || chr(10) ||
'tb20_0 ty20_0;type ty20_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb20_1 ty20_1; ' || chr(10) ||
'tb20_1 ty20_1;type ty20_3 is table of PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb20_3 ty20_3; ' || chr(10) ||
'tb20_3 ty20_3;--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM ' || chr(10) ||
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 323 ' || chr(10) ||
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
'END RQTY_323_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_323_******************************'); END;
/

BEGIN

if (not RQTY_323_.blProcessStatus) then
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
AND     external_root_id = 323
)
);

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_323_.cuExpressions;
fetch RQTY_323_.cuExpressions bulk collect INTO RQTY_323_.tbExpressionsId;
close RQTY_323_.cuExpressions;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_323_.tbEntityName(-1) := 'NULL';
   RQTY_323_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQTY_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQTY_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQTY_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQTY_323_.tbEntityAttributeName(90168711) := 'LDC_PACKAGE_CODE_DESIGN@COD_DESIGN';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQTY_323_.tbEntityAttributeName(90167565) := 'LD_PACKAGE_PERSON@OPER_UNIT_INST';
   RQTY_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQTY_323_.tbEntityAttributeName(90167568) := 'LD_PACKAGE_PERSON@PACKAGE_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQTY_323_.tbEntityAttributeName(90168710) := 'LDC_PACKAGE_CODE_DESIGN@PACKAGE_ID';
   RQTY_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQTY_323_.tbEntityAttributeName(90188539) := 'LDC_PORTAL_VENTA@PACKAGE_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(191044) := 'MO_PACKAGES@RECURRENT_BILLING';
   RQTY_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQTY_323_.tbEntityAttributeName(90167564) := 'LD_PACKAGE_PERSON@PACKAGE_PERSON_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQTY_323_.tbEntityAttributeName(90167567) := 'LD_PACKAGE_PERSON@PERSON_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQTY_323_.tbEntityAttributeName(90167566) := 'LD_PACKAGE_PERSON@OPER_UNIT_CERT';
   RQTY_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQTY_323_.tbEntityAttributeName(90188540) := 'LDC_PORTAL_VENTA@FLAG_PORTALVENTA';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_323_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_323_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQTY_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_323_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 323
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 323
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 323
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 323
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_323_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_323_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_323_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_323_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_323_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_323_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_323_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323))));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323))));

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_323_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_323_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_323_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_323_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_323_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_323_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_323_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_323_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323)));

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323));
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_323_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323);
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_323_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_323_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_323_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_323_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=323;
nuIndex binary_integer;
BEGIN

if (not RQTY_323_.blProcessStatus) then
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_323_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_323_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_323_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_323_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_323_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_323_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_323_.tb0_0(0),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb1_0(0):=1;
RQTY_323_.tb1_1(0):=RQTY_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_323_.tb1_0(0),
MODULE_ID=RQTY_323_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_323_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_323_.tb1_0(0),
RQTY_323_.tb1_1(0),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(0):=121371419;
RQTY_323_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(0):=RQTY_323_.tb2_0(0);
RQTY_323_.old_tb2_1(0):='GE_EXEACTION_CT1E121371419'
;
RQTY_323_.tb2_1(0):=RQTY_323_.tb2_0(0);
RQTY_323_.tb2_2(0):=RQTY_323_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(0),
RQTY_323_.tb2_1(0),
RQTY_323_.tb2_2(0),
'cf_boactions.RegVentaServIng();sbIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", sbIdSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.FNUCHARTONUMBER(sbIdSolicitud),cnuTipoFechaPQR,dtFechaSolicitud)'
,
'LBTEST'
,
to_date('08-09-2012 16:35:41','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:39','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:39','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Registro Venta a Constructoras'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb3_0(0):=293;
RQTY_323_.tb3_1(0):=RQTY_323_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_323_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_323_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Registro Venta a Constructoras'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_323_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_323_.tb3_0(0),
RQTY_323_.tb3_1(0),
5,
'Registro Venta a Constructoras'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb4_0(0):=RQTY_323_.tb3_0(0);
RQTY_323_.tb4_1(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_323_.tb4_0(0),
VALID_MODULE_ID=RQTY_323_.tb4_1(0)
 WHERE ACTION_ID = RQTY_323_.tb4_0(0) AND VALID_MODULE_ID = RQTY_323_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_323_.tb4_0(0),
RQTY_323_.tb4_1(0));
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb4_0(1):=RQTY_323_.tb3_0(0);
RQTY_323_.tb4_1(1):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_323_.tb4_0(1),
VALID_MODULE_ID=RQTY_323_.tb4_1(1)
 WHERE ACTION_ID = RQTY_323_.tb4_0(1) AND VALID_MODULE_ID = RQTY_323_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_323_.tb4_0(1),
RQTY_323_.tb4_1(1));
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb5_0(0):=323;
RQTY_323_.tb5_1(0):=RQTY_323_.tb3_0(0);
RQTY_323_.tb5_4(0):='P_VENTA_A_CONSTRUCTORAS_323'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_323_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_323_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_323_.tb5_4(0),
DESCRIPTION='Venta a Constructoras'
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
 WHERE PACKAGE_TYPE_ID = RQTY_323_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_323_.tb5_0(0),
RQTY_323_.tb5_1(0),
null,
null,
RQTY_323_.tb5_4(0),
'Venta a Constructoras'
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(0):=108725;
RQTY_323_.tb6_1(0):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(0):=5032;
RQTY_323_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(0),-1)));
RQTY_323_.old_tb6_3(0):=90168710;
RQTY_323_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(0),-1)));
RQTY_323_.old_tb6_4(0):=255;
RQTY_323_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(0),-1)));
RQTY_323_.old_tb6_5(0):=null;
RQTY_323_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(0),
ENTITY_ID=RQTY_323_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Identificador de la solicitud'
,
DISPLAY_ORDER=22,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DE_LA_SOLICITUD'
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
ENTITY_NAME='LDC_PACKAGE_CODE_DESIGN'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(0),
RQTY_323_.tb6_1(0),
RQTY_323_.tb6_2(0),
RQTY_323_.tb6_3(0),
RQTY_323_.tb6_4(0),
RQTY_323_.tb6_5(0),
null,
null,
null,
null,
22,
'Identificador de la solicitud'
,
22,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DE_LA_SOLICITUD'
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
'LDC_PACKAGE_CODE_DESIGN'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_323_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_323_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_323_.tb0_0(1),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb1_0(1):=26;
RQTY_323_.tb1_1(1):=RQTY_323_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_323_.tb1_0(1),
MODULE_ID=RQTY_323_.tb1_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_323_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_323_.tb1_0(1),
RQTY_323_.tb1_1(1),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(1):=121371420;
RQTY_323_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(1):=RQTY_323_.tb2_0(1);
RQTY_323_.old_tb2_1(1):='MO_VALIDATTR_CT26E121371420'
;
RQTY_323_.tb2_1(1):=RQTY_323_.tb2_0(1);
RQTY_323_.tb2_2(1):=RQTY_323_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(1),
RQTY_323_.tb2_1(1),
RQTY_323_.tb2_2(1),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);sbCodigo = null;GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbCodigo);nuValido = null;LDC_BO_PACKAGE_CODE_DESIGN.VALIDATE_COD_DESIGN_ORDER(sbCodigo,nuValido);if (nuValido = 0,SETERRORDESC("El c¿digo de dise¿o no es v¿lido");,)'
,
'OPEN'
,
to_date('26-07-2018 23:50:30','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:41','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida si el c¿digo de dise¿o es v¿lido'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(1):=108726;
RQTY_323_.tb6_1(1):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(1):=5032;
RQTY_323_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(1),-1)));
RQTY_323_.old_tb6_3(1):=90168711;
RQTY_323_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(1),-1)));
RQTY_323_.old_tb6_4(1):=null;
RQTY_323_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(1),-1)));
RQTY_323_.old_tb6_5(1):=null;
RQTY_323_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(1),-1)));
RQTY_323_.tb6_8(1):=RQTY_323_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(1),
ENTITY_ID=RQTY_323_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_323_.tb6_8(1),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=23,
DISPLAY_NAME='C¿digo de dise¿o'
,
DISPLAY_ORDER=23,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='C_DIGO_DE_DISE_O'
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
ENTITY_NAME='LDC_PACKAGE_CODE_DESIGN'
,
ATTRI_TECHNICAL_NAME='COD_DESIGN'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(1),
RQTY_323_.tb6_1(1),
RQTY_323_.tb6_2(1),
RQTY_323_.tb6_3(1),
RQTY_323_.tb6_4(1),
RQTY_323_.tb6_5(1),
null,
null,
RQTY_323_.tb6_8(1),
null,
23,
'C¿digo de dise¿o'
,
23,
'Y'
,
'N'
,
'N'
,
'C_DIGO_DE_DISE_O'
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
'LDC_PACKAGE_CODE_DESIGN'
,
'COD_DESIGN'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb1_0(2):=23;
RQTY_323_.tb1_1(2):=RQTY_323_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_323_.tb1_0(2),
MODULE_ID=RQTY_323_.tb1_1(2),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_323_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_323_.tb1_0(2),
RQTY_323_.tb1_1(2),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(2):=121371421;
RQTY_323_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(2):=RQTY_323_.tb2_0(2);
RQTY_323_.old_tb2_1(2):='MO_INITATRIB_CT23E121371421'
;
RQTY_323_.tb2_1(2):=RQTY_323_.tb2_0(2);
RQTY_323_.tb2_2(2):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(2),
RQTY_323_.tb2_1(2),
RQTY_323_.tb2_2(2),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSubscriberId);,)'
,
'LBTEST'
,
to_date('08-09-2012 17:09:13','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - SUBSCRIBER_ID - Inicializaci¿n del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(3):=121371422;
RQTY_323_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(3):=RQTY_323_.tb2_0(3);
RQTY_323_.old_tb2_1(3):='MO_VALIDATTR_CT26E121371422'
;
RQTY_323_.tb2_1(3):=RQTY_323_.tb2_0(3);
RQTY_323_.tb2_2(3):=RQTY_323_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(3),
RQTY_323_.tb2_1(3),
RQTY_323_.tb2_2(3),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuCliente);GE_BOINSTANCECONTROL.LOADENTITYOLDVALUESID("WORK_INSTANCE",NULL,"GE_SUBSCRIBER",nuCliente,GE_BOCONSTANTS.GETFALSE(),GE_BOCONSTANTS.GETFALSE(),GE_BOCONSTANTS.GETFALSE())'
,
'LBTEST'
,
to_date('08-09-2012 17:09:13','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MO_PACKAGES - SUBSCRIBER_ID - VSI'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(2):=2029;
RQTY_323_.tb6_1(2):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(2):=17;
RQTY_323_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(2),-1)));
RQTY_323_.old_tb6_3(2):=4015;
RQTY_323_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(2),-1)));
RQTY_323_.old_tb6_4(2):=null;
RQTY_323_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(2),-1)));
RQTY_323_.old_tb6_5(2):=null;
RQTY_323_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(2),-1)));
RQTY_323_.tb6_7(2):=RQTY_323_.tb2_0(2);
RQTY_323_.tb6_8(2):=RQTY_323_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(2),
ENTITY_ID=RQTY_323_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(2),
VALID_EXPRESSION_ID=RQTY_323_.tb6_8(2),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Identificador del Cliente'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(2),
RQTY_323_.tb6_1(2),
RQTY_323_.tb6_2(2),
RQTY_323_.tb6_3(2),
RQTY_323_.tb6_4(2),
RQTY_323_.tb6_5(2),
null,
RQTY_323_.tb6_7(2),
RQTY_323_.tb6_8(2),
null,
6,
'Identificador del Cliente'
,
6,
'Y'
,
'N'
,
'Y'
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
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(4):=121371423;
RQTY_323_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(4):=RQTY_323_.tb2_0(4);
RQTY_323_.old_tb2_1(4):='MO_INITATRIB_CT23E121371423'
;
RQTY_323_.tb2_1(4):=RQTY_323_.tb2_0(4);
RQTY_323_.tb2_2(4):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(4),
RQTY_323_.tb2_1(4),
RQTY_323_.tb2_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:04','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(3):=1838;
RQTY_323_.tb6_1(3):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(3):=17;
RQTY_323_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(3),-1)));
RQTY_323_.old_tb6_3(3):=257;
RQTY_323_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(3),-1)));
RQTY_323_.old_tb6_4(3):=null;
RQTY_323_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(3),-1)));
RQTY_323_.old_tb6_5(3):=null;
RQTY_323_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(3),-1)));
RQTY_323_.tb6_7(3):=RQTY_323_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(3),
ENTITY_ID=RQTY_323_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(3),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(3),
RQTY_323_.tb6_1(3),
RQTY_323_.tb6_2(3),
RQTY_323_.tb6_3(3),
RQTY_323_.tb6_4(3),
RQTY_323_.tb6_5(3),
null,
RQTY_323_.tb6_7(3),
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
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(5):=121371424;
RQTY_323_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(5):=RQTY_323_.tb2_0(5);
RQTY_323_.old_tb2_1(5):='MO_INITATRIB_CT23E121371424'
;
RQTY_323_.tb2_1(5):=RQTY_323_.tb2_0(5);
RQTY_323_.tb2_2(5):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(5),
RQTY_323_.tb2_1(5),
RQTY_323_.tb2_2(5),
'CF_BOINITRULES.INIREQUESTDATE()'
,
'LBTEST'
,
to_date('01-09-2012 08:50:05','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(6):=121371425;
RQTY_323_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(6):=RQTY_323_.tb2_0(6);
RQTY_323_.old_tb2_1(6):='MO_VALIDATTR_CT26E121371425'
;
RQTY_323_.tb2_1(6):=RQTY_323_.tb2_0(6);
RQTY_323_.tb2_2(6):=RQTY_323_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(6),
RQTY_323_.tb2_1(6),
RQTY_323_.tb2_2(6),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 323;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No est¿ permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,););)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:05','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:43','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:43','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Val - Fecha de Solicitud de Venta de Serv Ing'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(4):=1839;
RQTY_323_.tb6_1(4):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(4):=17;
RQTY_323_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(4),-1)));
RQTY_323_.old_tb6_3(4):=258;
RQTY_323_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(4),-1)));
RQTY_323_.old_tb6_4(4):=null;
RQTY_323_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(4),-1)));
RQTY_323_.old_tb6_5(4):=null;
RQTY_323_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(4),-1)));
RQTY_323_.tb6_7(4):=RQTY_323_.tb2_0(5);
RQTY_323_.tb6_8(4):=RQTY_323_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(4),
ENTITY_ID=RQTY_323_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(4),
VALID_EXPRESSION_ID=RQTY_323_.tb6_8(4),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(4),
RQTY_323_.tb6_1(4),
RQTY_323_.tb6_2(4),
RQTY_323_.tb6_3(4),
RQTY_323_.tb6_4(4),
RQTY_323_.tb6_5(4),
null,
RQTY_323_.tb6_7(4),
RQTY_323_.tb6_8(4),
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
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(7):=121371426;
RQTY_323_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(7):=RQTY_323_.tb2_0(7);
RQTY_323_.old_tb2_1(7):='MO_VALIDATTR_CT26E121371426'
;
RQTY_323_.tb2_1(7):=RQTY_323_.tb2_0(7);
RQTY_323_.tb2_2(7):=RQTY_323_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(7),
RQTY_323_.tb2_1(7),
RQTY_323_.tb2_2(7),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",null,"MO_PACKAGES","PACKAGE_NEW_ID",sbValue,TRUE)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:06','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:43','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:43','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(5):=1840;
RQTY_323_.tb6_1(5):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(5):=17;
RQTY_323_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(5),-1)));
RQTY_323_.old_tb6_3(5):=255;
RQTY_323_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(5),-1)));
RQTY_323_.old_tb6_4(5):=null;
RQTY_323_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(5),-1)));
RQTY_323_.old_tb6_5(5):=null;
RQTY_323_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(5),-1)));
RQTY_323_.tb6_8(5):=RQTY_323_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(5),
ENTITY_ID=RQTY_323_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_323_.tb6_8(5),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(5),
RQTY_323_.tb6_1(5),
RQTY_323_.tb6_2(5),
RQTY_323_.tb6_3(5),
RQTY_323_.tb6_4(5),
RQTY_323_.tb6_5(5),
null,
null,
RQTY_323_.tb6_8(5),
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
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(8):=121371427;
RQTY_323_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(8):=RQTY_323_.tb2_0(8);
RQTY_323_.old_tb2_1(8):='MO_INITATRIB_CT23E121371427'
;
RQTY_323_.tb2_1(8):=RQTY_323_.tb2_0(8);
RQTY_323_.tb2_2(8):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(8),
RQTY_323_.tb2_1(8),
RQTY_323_.tb2_2(8),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('01-09-2012 08:50:06','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:43','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:43','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(9):=121371428;
RQTY_323_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(9):=RQTY_323_.tb2_0(9);
RQTY_323_.old_tb2_1(9):='MO_VALIDATTR_CT26E121371428'
;
RQTY_323_.tb2_1(9):=RQTY_323_.tb2_0(9);
RQTY_323_.tb2_2(9):=RQTY_323_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(9),
RQTY_323_.tb2_1(9),
RQTY_323_.tb2_2(9),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPersonId);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,Null,"MO_PACKAGES","POS_OPER_UNIT_ID",nuSaleChannel,True)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:06','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb7_0(0):=120188088;
RQTY_323_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_323_.tb7_0(0):=RQTY_323_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_323_.tb7_0(0),
16,
'Listado de Vendedores'
,
'SELECT   a.person_id ID, a.name_ DESCRIPTION FROM   GE_PERSON a'
,
'Listado de Vendedores'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(6):=1841;
RQTY_323_.tb6_1(6):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(6):=17;
RQTY_323_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(6),-1)));
RQTY_323_.old_tb6_3(6):=50001162;
RQTY_323_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(6),-1)));
RQTY_323_.old_tb6_4(6):=null;
RQTY_323_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(6),-1)));
RQTY_323_.old_tb6_5(6):=null;
RQTY_323_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(6),-1)));
RQTY_323_.tb6_6(6):=RQTY_323_.tb7_0(0);
RQTY_323_.tb6_7(6):=RQTY_323_.tb2_0(8);
RQTY_323_.tb6_8(6):=RQTY_323_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(6),
ENTITY_ID=RQTY_323_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(6),
STATEMENT_ID=RQTY_323_.tb6_6(6),
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(6),
VALID_EXPRESSION_ID=RQTY_323_.tb6_8(6),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(6),
RQTY_323_.tb6_1(6),
RQTY_323_.tb6_2(6),
RQTY_323_.tb6_3(6),
RQTY_323_.tb6_4(6),
RQTY_323_.tb6_5(6),
RQTY_323_.tb6_6(6),
RQTY_323_.tb6_7(6),
RQTY_323_.tb6_8(6),
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
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(7):=1847;
RQTY_323_.tb6_1(7):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(7):=17;
RQTY_323_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(7),-1)));
RQTY_323_.old_tb6_3(7):=269;
RQTY_323_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(7),-1)));
RQTY_323_.old_tb6_4(7):=null;
RQTY_323_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(7),-1)));
RQTY_323_.old_tb6_5(7):=null;
RQTY_323_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(7),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(7),
ENTITY_ID=RQTY_323_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(7),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(7),
RQTY_323_.tb6_1(7),
RQTY_323_.tb6_2(7),
RQTY_323_.tb6_3(7),
RQTY_323_.tb6_4(7),
RQTY_323_.tb6_5(7),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(10):=121371429;
RQTY_323_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(10):=RQTY_323_.tb2_0(10);
RQTY_323_.old_tb2_1(10):='MO_INITATRIB_CT23E121371429'
;
RQTY_323_.tb2_1(10):=RQTY_323_.tb2_0(10);
RQTY_323_.tb2_2(10):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(10),
RQTY_323_.tb2_1(10),
RQTY_323_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:06','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb7_0(1):=120188089;
RQTY_323_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_323_.tb7_0(1):=RQTY_323_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_323_.tb7_0(1),
5,
'Puntos de Atencion por Usuario'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')
'
,
'Puntos de Atencion por Usuario'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(8):=1842;
RQTY_323_.tb6_1(8):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(8):=17;
RQTY_323_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(8),-1)));
RQTY_323_.old_tb6_3(8):=109479;
RQTY_323_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(8),-1)));
RQTY_323_.old_tb6_4(8):=null;
RQTY_323_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(8),-1)));
RQTY_323_.old_tb6_5(8):=null;
RQTY_323_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(8),-1)));
RQTY_323_.tb6_6(8):=RQTY_323_.tb7_0(1);
RQTY_323_.tb6_7(8):=RQTY_323_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(8),
ENTITY_ID=RQTY_323_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(8),
STATEMENT_ID=RQTY_323_.tb6_6(8),
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Punto de Atenci¿n'
,
DISPLAY_ORDER=4,
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(8),
RQTY_323_.tb6_1(8),
RQTY_323_.tb6_2(8),
RQTY_323_.tb6_3(8),
RQTY_323_.tb6_4(8),
RQTY_323_.tb6_5(8),
RQTY_323_.tb6_6(8),
RQTY_323_.tb6_7(8),
null,
null,
4,
'Punto de Atenci¿n'
,
4,
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
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(11):=121371430;
RQTY_323_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(11):=RQTY_323_.tb2_0(11);
RQTY_323_.old_tb2_1(11):='MO_INITATRIB_CT23E121371430'
;
RQTY_323_.tb2_1(11):=RQTY_323_.tb2_0(11);
RQTY_323_.tb2_2(11):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(11),
RQTY_323_.tb2_1(11),
RQTY_323_.tb2_2(11),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb7_0(2):=120188090;
RQTY_323_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_323_.tb7_0(2):=RQTY_323_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_323_.tb7_0(2),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(9):=1843;
RQTY_323_.tb6_1(9):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(9):=17;
RQTY_323_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(9),-1)));
RQTY_323_.old_tb6_3(9):=2683;
RQTY_323_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(9),-1)));
RQTY_323_.old_tb6_4(9):=null;
RQTY_323_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(9),-1)));
RQTY_323_.old_tb6_5(9):=null;
RQTY_323_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(9),-1)));
RQTY_323_.tb6_6(9):=RQTY_323_.tb7_0(2);
RQTY_323_.tb6_7(9):=RQTY_323_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(9),
ENTITY_ID=RQTY_323_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(9),
STATEMENT_ID=RQTY_323_.tb6_6(9),
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Medio de Recepci¿n'
,
DISPLAY_ORDER=5,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(9),
RQTY_323_.tb6_1(9),
RQTY_323_.tb6_2(9),
RQTY_323_.tb6_3(9),
RQTY_323_.tb6_4(9),
RQTY_323_.tb6_5(9),
RQTY_323_.tb6_6(9),
RQTY_323_.tb6_7(9),
null,
null,
5,
'Medio de Recepci¿n'
,
5,
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(12):=121371431;
RQTY_323_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(12):=RQTY_323_.tb2_0(12);
RQTY_323_.old_tb2_1(12):='MO_INITATRIB_CT23E121371431'
;
RQTY_323_.tb2_1(12):=RQTY_323_.tb2_0(12);
RQTY_323_.tb2_2(12):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(12),
RQTY_323_.tb2_1(12),
RQTY_323_.tb2_2(12),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:44','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(10):=1844;
RQTY_323_.tb6_1(10):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(10):=17;
RQTY_323_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(10),-1)));
RQTY_323_.old_tb6_3(10):=146755;
RQTY_323_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(10),-1)));
RQTY_323_.old_tb6_4(10):=null;
RQTY_323_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(10),-1)));
RQTY_323_.old_tb6_5(10):=null;
RQTY_323_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(10),-1)));
RQTY_323_.tb6_7(10):=RQTY_323_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(10),
ENTITY_ID=RQTY_323_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Informaci¿n del Solicitante'
,
DISPLAY_ORDER=7,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(10),
RQTY_323_.tb6_1(10),
RQTY_323_.tb6_2(10),
RQTY_323_.tb6_3(10),
RQTY_323_.tb6_4(10),
RQTY_323_.tb6_5(10),
null,
RQTY_323_.tb6_7(10),
null,
null,
7,
'Informaci¿n del Solicitante'
,
7,
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(13):=121371432;
RQTY_323_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(13):=RQTY_323_.tb2_0(13);
RQTY_323_.old_tb2_1(13):='MO_INITATRIB_CT23E121371432'
;
RQTY_323_.tb2_1(13):=RQTY_323_.tb2_0(13);
RQTY_323_.tb2_2(13):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(13),
RQTY_323_.tb2_1(13),
RQTY_323_.tb2_2(13),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:45','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:45','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(11):=1845;
RQTY_323_.tb6_1(11):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(11):=17;
RQTY_323_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(11),-1)));
RQTY_323_.old_tb6_3(11):=146756;
RQTY_323_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(11),-1)));
RQTY_323_.old_tb6_4(11):=null;
RQTY_323_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(11),-1)));
RQTY_323_.old_tb6_5(11):=null;
RQTY_323_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(11),-1)));
RQTY_323_.tb6_7(11):=RQTY_323_.tb2_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(11),
ENTITY_ID=RQTY_323_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(11),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(11),
RQTY_323_.tb6_1(11),
RQTY_323_.tb6_2(11),
RQTY_323_.tb6_3(11),
RQTY_323_.tb6_4(11),
RQTY_323_.tb6_5(11),
null,
RQTY_323_.tb6_7(11),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(12):=108571;
RQTY_323_.tb6_1(12):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(12):=4957;
RQTY_323_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(12),-1)));
RQTY_323_.old_tb6_3(12):=90167568;
RQTY_323_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(12),-1)));
RQTY_323_.old_tb6_4(12):=255;
RQTY_323_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(12),-1)));
RQTY_323_.old_tb6_5(12):=null;
RQTY_323_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(12),
ENTITY_ID=RQTY_323_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Identificador de la solicitud'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DE_LA_SOLICITUD'
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
ENTITY_NAME='LD_PACKAGE_PERSON'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(12),
RQTY_323_.tb6_1(12),
RQTY_323_.tb6_2(12),
RQTY_323_.tb6_3(12),
RQTY_323_.tb6_4(12),
RQTY_323_.tb6_5(12),
null,
null,
null,
null,
18,
'Identificador de la solicitud'
,
18,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DE_LA_SOLICITUD'
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
'LD_PACKAGE_PERSON'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(14):=121371433;
RQTY_323_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(14):=RQTY_323_.tb2_0(14);
RQTY_323_.old_tb2_1(14):='MO_INITATRIB_CT23E121371433'
;
RQTY_323_.tb2_1(14):=RQTY_323_.tb2_0(14);
RQTY_323_.tb2_2(14):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(14),
RQTY_323_.tb2_1(14),
RQTY_323_.tb2_2(14),
'nuValor = -1;GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuValor)'
,
'OPEN'
,
to_date('18-04-2018 22:57:16','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:45','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa t¿cnico'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(13):=108572;
RQTY_323_.tb6_1(13):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(13):=4957;
RQTY_323_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(13),-1)));
RQTY_323_.old_tb6_3(13):=90167567;
RQTY_323_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(13),-1)));
RQTY_323_.old_tb6_4(13):=null;
RQTY_323_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(13),-1)));
RQTY_323_.old_tb6_5(13):=null;
RQTY_323_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(13),-1)));
RQTY_323_.tb6_7(13):=RQTY_323_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(13),
ENTITY_ID=RQTY_323_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(13),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Identificador del t¿cnico'
,
DISPLAY_ORDER=19,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DEL_T_CNICO'
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
ENTITY_NAME='LD_PACKAGE_PERSON'
,
ATTRI_TECHNICAL_NAME='PERSON_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(13),
RQTY_323_.tb6_1(13),
RQTY_323_.tb6_2(13),
RQTY_323_.tb6_3(13),
RQTY_323_.tb6_4(13),
RQTY_323_.tb6_5(13),
null,
RQTY_323_.tb6_7(13),
null,
null,
19,
'Identificador del t¿cnico'
,
19,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DEL_T_CNICO'
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
'LD_PACKAGE_PERSON'
,
'PERSON_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb7_0(3):=120188091;
RQTY_323_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_323_.tb7_0(3):=RQTY_323_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_323_.tb7_0(3),
16,
'Unidad de trabajo instaladora'
,
'select  or_operating_unit.operating_unit_id ID,
        or_operating_unit.name DESCRIPTION
from    or_operating_unit
where   or_operating_unit.unit_type_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                      FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(dald_parameter.fsbGetValue_Chain('|| chr(39) ||'LD_OPER_UNIT_INST'|| chr(39) ||'),'|| chr(39) ||','|| chr(39) ||')))'
,
'Unidad de trabajo instaladora'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb8_0(0):=RQTY_323_.tb7_0(3);
RQTY_323_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ID</Name>
    <Description>ID</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
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
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (0)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_323_.tb8_0(0),
null,
RQTY_323_.clColumn_1,
null);

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(14):=108573;
RQTY_323_.tb6_1(14):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(14):=4957;
RQTY_323_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(14),-1)));
RQTY_323_.old_tb6_3(14):=90167565;
RQTY_323_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(14),-1)));
RQTY_323_.old_tb6_4(14):=null;
RQTY_323_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(14),-1)));
RQTY_323_.old_tb6_5(14):=null;
RQTY_323_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(14),-1)));
RQTY_323_.tb6_6(14):=RQTY_323_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(14),
ENTITY_ID=RQTY_323_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(14),
STATEMENT_ID=RQTY_323_.tb6_6(14),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Unidad de trabajo instaladora'
,
DISPLAY_ORDER=20,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='UNIDAD_DE_TRABAJO_INSTALADORA'
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
ENTITY_NAME='LD_PACKAGE_PERSON'
,
ATTRI_TECHNICAL_NAME='OPER_UNIT_INST'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(14),
RQTY_323_.tb6_1(14),
RQTY_323_.tb6_2(14),
RQTY_323_.tb6_3(14),
RQTY_323_.tb6_4(14),
RQTY_323_.tb6_5(14),
RQTY_323_.tb6_6(14),
null,
null,
null,
20,
'Unidad de trabajo instaladora'
,
20,
'Y'
,
'N'
,
'N'
,
'UNIDAD_DE_TRABAJO_INSTALADORA'
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
'LD_PACKAGE_PERSON'
,
'OPER_UNIT_INST'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb7_0(4):=120188092;
RQTY_323_.tb7_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_323_.tb7_0(4):=RQTY_323_.tb7_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_323_.tb7_0(4),
16,
'Unidad de trabajo certificadora'
,
'select  or_operating_unit.operating_unit_id ID,
        or_operating_unit.name DESCRIPTION
from    or_operating_unit
where   or_operating_unit.unit_type_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                      FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(dald_parameter.fsbGetValue_Chain('|| chr(39) ||'LD_OPER_UNIT_CERT'|| chr(39) ||'),'|| chr(39) ||','|| chr(39) ||')))'
,
'Unidad de trabajo certificadora'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb8_0(1):=RQTY_323_.tb7_0(4);
RQTY_323_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ID</Name>
    <Description>ID</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
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
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (1)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_323_.tb8_0(1),
null,
RQTY_323_.clColumn_1,
null);

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(15):=108574;
RQTY_323_.tb6_1(15):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(15):=4957;
RQTY_323_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(15),-1)));
RQTY_323_.old_tb6_3(15):=90167566;
RQTY_323_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(15),-1)));
RQTY_323_.old_tb6_4(15):=null;
RQTY_323_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(15),-1)));
RQTY_323_.old_tb6_5(15):=null;
RQTY_323_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(15),-1)));
RQTY_323_.tb6_6(15):=RQTY_323_.tb7_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(15),
ENTITY_ID=RQTY_323_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(15),
STATEMENT_ID=RQTY_323_.tb6_6(15),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Unidad de trabajo certificadora'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='UNIDAD_DE_TRABAJO_CERTIFICADORA'
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
ENTITY_NAME='LD_PACKAGE_PERSON'
,
ATTRI_TECHNICAL_NAME='OPER_UNIT_CERT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(15),
RQTY_323_.tb6_1(15),
RQTY_323_.tb6_2(15),
RQTY_323_.tb6_3(15),
RQTY_323_.tb6_4(15),
RQTY_323_.tb6_5(15),
RQTY_323_.tb6_6(15),
null,
null,
null,
21,
'Unidad de trabajo certificadora'
,
21,
'Y'
,
'N'
,
'N'
,
'UNIDAD_DE_TRABAJO_CERTIFICADORA'
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
'LD_PACKAGE_PERSON'
,
'OPER_UNIT_CERT'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(16):=1848;
RQTY_323_.tb6_1(16):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(16):=17;
RQTY_323_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(16),-1)));
RQTY_323_.old_tb6_3(16):=109478;
RQTY_323_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(16),-1)));
RQTY_323_.old_tb6_4(16):=null;
RQTY_323_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(16),-1)));
RQTY_323_.old_tb6_5(16):=null;
RQTY_323_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(16),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(16),
ENTITY_ID=RQTY_323_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(16),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(16),
RQTY_323_.tb6_1(16),
RQTY_323_.tb6_2(16),
RQTY_323_.tb6_3(16),
RQTY_323_.tb6_4(16),
RQTY_323_.tb6_5(16),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(17):=1849;
RQTY_323_.tb6_1(17):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(17):=17;
RQTY_323_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(17),-1)));
RQTY_323_.old_tb6_3(17):=42118;
RQTY_323_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(17),-1)));
RQTY_323_.old_tb6_4(17):=109479;
RQTY_323_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(17),-1)));
RQTY_323_.old_tb6_5(17):=null;
RQTY_323_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(17),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(17),
ENTITY_ID=RQTY_323_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(17),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(17),
RQTY_323_.tb6_1(17),
RQTY_323_.tb6_2(17),
RQTY_323_.tb6_3(17),
RQTY_323_.tb6_4(17),
RQTY_323_.tb6_5(17),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(15):=121371434;
RQTY_323_.tb2_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(15):=RQTY_323_.tb2_0(15);
RQTY_323_.old_tb2_1(15):='MO_INITATRIB_CT23E121371434'
;
RQTY_323_.tb2_1(15):=RQTY_323_.tb2_0(15);
RQTY_323_.tb2_2(15):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(15),
RQTY_323_.tb2_1(15),
RQTY_323_.tb2_2(15),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'LBTEST'
,
to_date('01-09-2012 08:50:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:45','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:45','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(18):=1850;
RQTY_323_.tb6_1(18):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(18):=17;
RQTY_323_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(18),-1)));
RQTY_323_.old_tb6_3(18):=259;
RQTY_323_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(18),-1)));
RQTY_323_.old_tb6_4(18):=null;
RQTY_323_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(18),-1)));
RQTY_323_.old_tb6_5(18):=null;
RQTY_323_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(18),-1)));
RQTY_323_.tb6_7(18):=RQTY_323_.tb2_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(18),
ENTITY_ID=RQTY_323_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(18),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(18),
RQTY_323_.tb6_1(18),
RQTY_323_.tb6_2(18),
RQTY_323_.tb6_3(18),
RQTY_323_.tb6_4(18),
RQTY_323_.tb6_5(18),
null,
RQTY_323_.tb6_7(18),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(19):=1852;
RQTY_323_.tb6_1(19):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(19):=17;
RQTY_323_.tb6_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(19),-1)));
RQTY_323_.old_tb6_3(19):=11619;
RQTY_323_.tb6_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(19),-1)));
RQTY_323_.old_tb6_4(19):=null;
RQTY_323_.tb6_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(19),-1)));
RQTY_323_.old_tb6_5(19):=null;
RQTY_323_.tb6_5(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(19),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (19)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(19),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(19),
ENTITY_ID=RQTY_323_.tb6_2(19),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(19),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(19),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(19),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(19);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(19),
RQTY_323_.tb6_1(19),
RQTY_323_.tb6_2(19),
RQTY_323_.tb6_3(19),
RQTY_323_.tb6_4(19),
RQTY_323_.tb6_5(19),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(16):=121371435;
RQTY_323_.tb2_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(16):=RQTY_323_.tb2_0(16);
RQTY_323_.old_tb2_1(16):='MO_INITATRIB_CT23E121371435'
;
RQTY_323_.tb2_1(16):=RQTY_323_.tb2_0(16);
RQTY_323_.tb2_2(16):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(16),
RQTY_323_.tb2_1(16),
RQTY_323_.tb2_2(16),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,"GE_SUBSCRIBER","SUBSCRIBER_ID",nuSubscriberId);sbSubscriber = "SUBSCRIBER_ID";sbSubscriber = UT_STRING.FSBCONCAT(sbSubscriber, nuSubscriberId, "=");,);blExistContract = GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", Null, "PR_SUBSCRIPTION", "SUBSCRIPTION_ID", 1);if (blExistContract = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",Null,"PR_SUBSCRIPTION","SUBSCRIPTION_ID",sbSubscriptionId);sbSubscription = "SUBSCRIPTION_ID";sbSubscription = UT_STRING.FSBCONCAT(sbSubscription, sbSubscriptionId, "=");cadena = UT_STRING.FSBCONCAT(sbSubscriber, sbSubscription, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(cadena);,cadena = sbSubscriber;GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(cadena);)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PACKAGES - MO_PROCESS - CONTRACT_INFORMATION - Inicializa Atributo de Modificaci¿n de Cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(20):=1853;
RQTY_323_.tb6_1(20):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(20):=68;
RQTY_323_.tb6_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(20),-1)));
RQTY_323_.old_tb6_3(20):=2826;
RQTY_323_.tb6_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(20),-1)));
RQTY_323_.old_tb6_4(20):=null;
RQTY_323_.tb6_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(20),-1)));
RQTY_323_.old_tb6_5(20):=null;
RQTY_323_.tb6_5(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(20),-1)));
RQTY_323_.tb6_7(20):=RQTY_323_.tb2_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (20)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(20),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(20),
ENTITY_ID=RQTY_323_.tb6_2(20),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(20),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(20),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(20),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Informacion de Contrato'
,
DISPLAY_ORDER=15,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='INFORMACION_DE_CONTRATO'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(20);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(20),
RQTY_323_.tb6_1(20),
RQTY_323_.tb6_2(20),
RQTY_323_.tb6_3(20),
RQTY_323_.tb6_4(20),
RQTY_323_.tb6_5(20),
null,
RQTY_323_.tb6_7(20),
null,
null,
15,
'Informacion de Contrato'
,
15,
'Y'
,
'N'
,
'Y'
,
'INFORMACION_DE_CONTRATO'
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(17):=121371436;
RQTY_323_.tb2_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(17):=RQTY_323_.tb2_0(17);
RQTY_323_.old_tb2_1(17):='MO_INITATRIB_CT23E121371436'
;
RQTY_323_.tb2_1(17):=RQTY_323_.tb2_0(17);
RQTY_323_.tb2_2(17):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(17),
RQTY_323_.tb2_1(17),
RQTY_323_.tb2_2(17),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'LBTEST'
,
to_date('01-09-2012 08:50:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGES - RECURRENT_BILLING - VSI'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(21):=1854;
RQTY_323_.tb6_1(21):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(21):=17;
RQTY_323_.tb6_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(21),-1)));
RQTY_323_.old_tb6_3(21):=191044;
RQTY_323_.tb6_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(21),-1)));
RQTY_323_.old_tb6_4(21):=null;
RQTY_323_.tb6_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(21),-1)));
RQTY_323_.old_tb6_5(21):=null;
RQTY_323_.tb6_5(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(21),-1)));
RQTY_323_.tb6_7(21):=RQTY_323_.tb2_0(17);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (21)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(21),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(21),
ENTITY_ID=RQTY_323_.tb6_2(21),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(21),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(21),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(21),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Facturaci¿n Es En La Recurrente'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='RECURRENT_BILLING'
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
ATTRI_TECHNICAL_NAME='RECURRENT_BILLING'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(21);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(21),
RQTY_323_.tb6_1(21),
RQTY_323_.tb6_2(21),
RQTY_323_.tb6_3(21),
RQTY_323_.tb6_4(21),
RQTY_323_.tb6_5(21),
null,
RQTY_323_.tb6_7(21),
null,
null,
16,
'Facturaci¿n Es En La Recurrente'
,
16,
'N'
,
'N'
,
'N'
,
'RECURRENT_BILLING'
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
'RECURRENT_BILLING'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(22):=1846;
RQTY_323_.tb6_1(22):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(22):=17;
RQTY_323_.tb6_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(22),-1)));
RQTY_323_.old_tb6_3(22):=146754;
RQTY_323_.tb6_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(22),-1)));
RQTY_323_.old_tb6_4(22):=null;
RQTY_323_.tb6_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(22),-1)));
RQTY_323_.old_tb6_5(22):=null;
RQTY_323_.tb6_5(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(22),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (22)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(22),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(22),
ENTITY_ID=RQTY_323_.tb6_2(22),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(22),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(22),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Observaci¿n'
,
DISPLAY_ORDER=9,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(22);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(22),
RQTY_323_.tb6_1(22),
RQTY_323_.tb6_2(22),
RQTY_323_.tb6_3(22),
RQTY_323_.tb6_4(22),
RQTY_323_.tb6_5(22),
null,
null,
null,
null,
9,
'Observaci¿n'
,
9,
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(18):=121371437;
RQTY_323_.tb2_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(18):=RQTY_323_.tb2_0(18);
RQTY_323_.old_tb2_1(18):='MO_INITATRIB_CT23E121371437'
;
RQTY_323_.tb2_1(18):=RQTY_323_.tb2_0(18);
RQTY_323_.tb2_2(18):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(18),
RQTY_323_.tb2_1(18),
RQTY_323_.tb2_2(18),
'valorSecuencia = PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_LD_PACKAGE_PERSON");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(valorSecuencia)'
,
'OPEN'
,
to_date('18-04-2018 22:57:15','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa el identificador del registro'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(23):=108570;
RQTY_323_.tb6_1(23):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(23):=4957;
RQTY_323_.tb6_2(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(23),-1)));
RQTY_323_.old_tb6_3(23):=90167564;
RQTY_323_.tb6_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(23),-1)));
RQTY_323_.old_tb6_4(23):=null;
RQTY_323_.tb6_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(23),-1)));
RQTY_323_.old_tb6_5(23):=null;
RQTY_323_.tb6_5(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(23),-1)));
RQTY_323_.tb6_7(23):=RQTY_323_.tb2_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (23)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(23),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(23),
ENTITY_ID=RQTY_323_.tb6_2(23),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(23),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(23),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(23),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Identificador del registro'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='IDENTIFICADOR_DEL_REGISTRO'
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
ENTITY_NAME='LD_PACKAGE_PERSON'
,
ATTRI_TECHNICAL_NAME='PACKAGE_PERSON_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(23);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(23),
RQTY_323_.tb6_1(23),
RQTY_323_.tb6_2(23),
RQTY_323_.tb6_3(23),
RQTY_323_.tb6_4(23),
RQTY_323_.tb6_5(23),
null,
RQTY_323_.tb6_7(23),
null,
null,
17,
'Identificador del registro'
,
17,
'N'
,
'N'
,
'N'
,
'IDENTIFICADOR_DEL_REGISTRO'
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
'LD_PACKAGE_PERSON'
,
'PACKAGE_PERSON_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(19):=121371495;
RQTY_323_.tb2_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(19):=RQTY_323_.tb2_0(19);
RQTY_323_.old_tb2_1(19):='MO_INITATRIB_CT23E121371495'
;
RQTY_323_.tb2_1(19):=RQTY_323_.tb2_0(19);
RQTY_323_.tb2_2(19):=RQTY_323_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(19),
RQTY_323_.tb2_1(19),
RQTY_323_.tb2_2(19),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("N")'
,
'OPEN'
,
to_date('10-03-2021 15:10:22','DD-MM-YYYY HH24:MI:SS'),
to_date('10-03-2021 15:10:22','DD-MM-YYYY HH24:MI:SS'),
to_date('10-03-2021 15:10:22','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - LDC_PORTAL_VENTA - FLAG_PORTALVENTA'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(24):=107479;
RQTY_323_.tb6_1(24):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(24):=5766;
RQTY_323_.tb6_2(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(24),-1)));
RQTY_323_.old_tb6_3(24):=90188540;
RQTY_323_.tb6_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(24),-1)));
RQTY_323_.old_tb6_4(24):=null;
RQTY_323_.tb6_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(24),-1)));
RQTY_323_.old_tb6_5(24):=null;
RQTY_323_.tb6_5(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(24),-1)));
RQTY_323_.tb6_7(24):=RQTY_323_.tb2_0(19);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (24)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(24),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(24),
ENTITY_ID=RQTY_323_.tb6_2(24),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(24),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(24),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_323_.tb6_7(24),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=25,
DISPLAY_NAME='PORTAL VENTA Y - N'
,
DISPLAY_ORDER=25,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PORTAL_VENTA_Y_N'
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
ENTITY_NAME='LDC_PORTAL_VENTA'
,
ATTRI_TECHNICAL_NAME='FLAG_PORTALVENTA'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(24);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(24),
RQTY_323_.tb6_1(24),
RQTY_323_.tb6_2(24),
RQTY_323_.tb6_3(24),
RQTY_323_.tb6_4(24),
RQTY_323_.tb6_5(24),
null,
RQTY_323_.tb6_7(24),
null,
null,
25,
'PORTAL VENTA Y - N'
,
25,
'N'
,
'N'
,
'N'
,
'PORTAL_VENTA_Y_N'
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
'LDC_PORTAL_VENTA'
,
'FLAG_PORTALVENTA'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb6_0(25):=107478;
RQTY_323_.tb6_1(25):=RQTY_323_.tb5_0(0);
RQTY_323_.old_tb6_2(25):=5766;
RQTY_323_.tb6_2(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_323_.TBENTITYNAME(NVL(RQTY_323_.old_tb6_2(25),-1)));
RQTY_323_.old_tb6_3(25):=90188539;
RQTY_323_.tb6_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_3(25),-1)));
RQTY_323_.old_tb6_4(25):=255;
RQTY_323_.tb6_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_4(25),-1)));
RQTY_323_.old_tb6_5(25):=null;
RQTY_323_.tb6_5(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_323_.TBENTITYATTRIBUTENAME(NVL(RQTY_323_.old_tb6_5(25),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (25)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_323_.tb6_0(25),
PACKAGE_TYPE_ID=RQTY_323_.tb6_1(25),
ENTITY_ID=RQTY_323_.tb6_2(25),
ENTITY_ATTRIBUTE_ID=RQTY_323_.tb6_3(25),
MIRROR_ENTI_ATTRIB=RQTY_323_.tb6_4(25),
PARENT_ATTRIBUTE_ID=RQTY_323_.tb6_5(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Solicitud Venta a Constructora'
,
DISPLAY_ORDER=24,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SOLICITUD_VENTA_A_CONSTRUCTORA'
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
ENTITY_NAME='LDC_PORTAL_VENTA'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_323_.tb6_0(25);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_323_.tb6_0(25),
RQTY_323_.tb6_1(25),
RQTY_323_.tb6_2(25),
RQTY_323_.tb6_3(25),
RQTY_323_.tb6_4(25),
RQTY_323_.tb6_5(25),
null,
null,
null,
null,
24,
'Solicitud Venta a Constructora'
,
24,
'N'
,
'N'
,
'N'
,
'SOLICITUD_VENTA_A_CONSTRUCTORA'
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
'LDC_PORTAL_VENTA'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb1_0(3):=69;
RQTY_323_.tb1_1(3):=RQTY_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_323_.tb1_0(3),
MODULE_ID=RQTY_323_.tb1_1(3),
DESCRIPTION='Reglas validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULVAL_'

 WHERE CONFIGURA_TYPE_ID = RQTY_323_.tb1_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_323_.tb1_0(3),
RQTY_323_.tb1_1(3),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(20):=121371438;
RQTY_323_.tb2_0(20):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(20):=RQTY_323_.tb2_0(20);
RQTY_323_.old_tb2_1(20):='GEGE_EXERULVAL_CT69E121371438'
;
RQTY_323_.tb2_1(20):=RQTY_323_.tb2_0(20);
RQTY_323_.tb2_2(20):=RQTY_323_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (20)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(20),
RQTY_323_.tb2_1(20),
RQTY_323_.tb2_2(20),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);nuSuspenPendientes = MO_BOSUSPENSION.FNUCOUNTPENDPRODSUSPS(nuIdProd, nuIl);if (nuSuspenPendientes <> 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El producto tiene suspensiones pendientes");,)'
,
'LBTEST'
,
to_date('19-07-2012 16:27:54','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Suspensiones Pendientes'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(0):=126;
RQTY_323_.tb9_1(0):=RQTY_323_.tb2_0(20);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(0),
VALID_EXPRESSION=RQTY_323_.tb9_1(0),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PROD_SUSPEN'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que el producto no tenga suspensiones pendientes'
,
DISPLAY_NAME='Valida que el producto no tenga suspensiones pendientes'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(0),
RQTY_323_.tb9_1(0),
null,
1,
5,
22,
'VAL_PROD_SUSPEN'
,
null,
null,
null,
null,
null,
'Valida que el producto no tenga suspensiones pendientes'
,
'Valida que el producto no tenga suspensiones pendientes'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(0):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(0):=RQTY_323_.tb9_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(0),
RQTY_323_.tb10_1(0),
'Valida que el producto no tenga suspensiones pendientes'
,
'N'
,
0,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(1):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(1),
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

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(1),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(1):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(1):=RQTY_323_.tb9_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(1),
RQTY_323_.tb10_1(1),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb1_0(4):=64;
RQTY_323_.tb1_1(4):=RQTY_323_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (4)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_323_.tb1_0(4),
MODULE_ID=RQTY_323_.tb1_1(4),
DESCRIPTION='Validaci¿n Tramites'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDTRAM_'

 WHERE CONFIGURA_TYPE_ID = RQTY_323_.tb1_0(4);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_323_.tb1_0(4),
RQTY_323_.tb1_1(4),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(21):=121371439;
RQTY_323_.tb2_0(21):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(21):=RQTY_323_.tb2_0(21);
RQTY_323_.old_tb2_1(21):='MO_VALIDTRAM_CT64E121371439'
;
RQTY_323_.tb2_1(21):=RQTY_323_.tb2_0(21);
RQTY_323_.tb2_2(21):=RQTY_323_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (21)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(21),
RQTY_323_.tb2_1(21),
RQTY_323_.tb2_2(21),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);pkServNumber.ValIsSubsServSuspended(nuIdProd,nuErrorCode,sbMessage);GW_BOERRORS.CHECKERROR(nuErrorCode,sbMessage)'
,
'CONFBOSS'
,
to_date('24-05-2005 12:31:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:47','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR - Validar si un producto esta suspendido por no pago BSS'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(2):=70;
RQTY_323_.tb9_1(2):=RQTY_323_.tb2_0(21);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(2),
VALID_EXPRESSION=RQTY_323_.tb9_1(2),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VALIDA_SUSPENDIDO_BSS'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Validar si un producto esta suspendido por no pago BSS'
,
DISPLAY_NAME='Validar si un producto esta suspendido por no pago BSS'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(2),
RQTY_323_.tb9_1(2),
null,
1,
5,
22,
'VALIDA_SUSPENDIDO_BSS'
,
4,
0,
0,
null,
null,
'Validar si un producto esta suspendido por no pago BSS'
,
'Validar si un producto esta suspendido por no pago BSS'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(2):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(2):=RQTY_323_.tb9_0(2);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (2)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(2),
RQTY_323_.tb10_1(2),
'Validar si un producto esta suspendido por no pago BSS'
,
'N'
,
0,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(3):=108;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (3)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(3),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=16,
ATTRIBUTE_CLASS_ID=25,
NAME_ATTRIBUTE='PLAN_ID'
,
LENGTH=15,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Plan comercial por defecto'
,
DISPLAY_NAME='Plan comercial por defecto'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(3);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(3),
null,
null,
1,
16,
25,
'PLAN_ID'
,
15,
null,
null,
null,
'T'
,
'Plan comercial por defecto'
,
'Plan comercial por defecto'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(3):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(3):=RQTY_323_.tb9_0(3);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (3)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(3),
RQTY_323_.tb10_1(3),
'Plan comercial por defecto'
,
'12'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(4):=118;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (4)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(4),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=9,
ATTRIBUTE_CLASS_ID=25,
NAME_ATTRIBUTE='CANT_DIAS_EJEC_TRABAJOS'
,
LENGTH=150,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Cantidad de d¿as m¿ximos para la ejecuci¿n de trabajos'
,
DISPLAY_NAME='Cantidad de d¿as m¿ximos para la ejecuci¿n de trabajos'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(4);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(4),
null,
null,
1,
9,
25,
'CANT_DIAS_EJEC_TRABAJOS'
,
150,
null,
null,
null,
null,
'Cantidad de d¿as m¿ximos para la ejecuci¿n de trabajos'
,
'Cantidad de d¿as m¿ximos para la ejecuci¿n de trabajos'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(4):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(4):=RQTY_323_.tb9_0(4);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (4)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(4),
RQTY_323_.tb10_1(4),
'Cantidad de d¿as m¿ximos para la ejecuci¿n de trabajos'
,
'89'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(22):=121371440;
RQTY_323_.tb2_0(22):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(22):=RQTY_323_.tb2_0(22);
RQTY_323_.old_tb2_1(22):='GEGE_EXERULVAL_CT69E121371440'
;
RQTY_323_.tb2_1(22):=RQTY_323_.tb2_0(22);
RQTY_323_.tb2_2(22):=RQTY_323_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (22)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(22),
RQTY_323_.tb2_1(22),
RQTY_323_.tb2_2(22),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_ PRODUCT","PRODUCT_ID",nuIdProd);MO_BOGENERICVALID.VALPRDHASRETNOPAYORD(nuIdProd,sbProcesosPend);if (sbProcesosPend = "Y",GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El producto tiene procesos de retiro pendientes");,)'
,
'LBTEST'
,
to_date('19-07-2012 17:06:33','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:47','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Val producto retirado en proceso'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(5):=132;
RQTY_323_.tb9_1(5):=RQTY_323_.tb2_0(22);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (5)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(5),
VALID_EXPRESSION=RQTY_323_.tb9_1(5),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PROD_RETIRADO_NOPAGO'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida producto retirado por no pago o se encuentra en proceso'
,
DISPLAY_NAME='Valida producto retirado por no pago o se encuentra en proceso '

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(5);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(5),
RQTY_323_.tb9_1(5),
null,
1,
5,
22,
'VAL_PROD_RETIRADO_NOPAGO'
,
null,
null,
null,
null,
null,
'Valida producto retirado por no pago o se encuentra en proceso'
,
'Valida producto retirado por no pago o se encuentra en proceso '
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(5):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(5):=RQTY_323_.tb9_0(5);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (5)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(5),
RQTY_323_.tb10_1(5),
'Valida producto retirado por no pago o se encuentra en proceso'
,
'N'
,
0,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(23):=121371441;
RQTY_323_.tb2_0(23):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(23):=RQTY_323_.tb2_0(23);
RQTY_323_.old_tb2_1(23):='GEGE_EXERULVAL_CT69E121371441'
;
RQTY_323_.tb2_1(23):=RQTY_323_.tb2_0(23);
RQTY_323_.tb2_2(23):=RQTY_323_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (23)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(23),
RQTY_323_.tb2_1(23),
RQTY_323_.tb2_2(23),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);nuCartCastiga = GC_BCCASTIGOCARTERA.FNUOBTCARCASTPORSERVS(nuIdProd);if (nuCartCastiga > 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El producto cuenta con cartera castigada");,)'
,
'LBTEST'
,
to_date('24-07-2012 17:40:31','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:48','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida si el producto tiene saldo en cartera castigada'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(6):=147;
RQTY_323_.tb9_1(6):=RQTY_323_.tb2_0(23);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (6)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(6),
VALID_EXPRESSION=RQTY_323_.tb9_1(6),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PROD_CARTERA_CAST'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida si el producto tiene saldo en cartera castigada'
,
DISPLAY_NAME='Valida si el producto tiene saldo en cartera castigada'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(6);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(6),
RQTY_323_.tb9_1(6),
null,
1,
5,
22,
'VAL_PROD_CARTERA_CAST'
,
null,
null,
null,
null,
null,
'Valida si el producto tiene saldo en cartera castigada'
,
'Valida si el producto tiene saldo en cartera castigada'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(6):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(6):=RQTY_323_.tb9_0(6);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (6)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(6),
RQTY_323_.tb10_1(6),
'Valida si el producto tiene saldo en cartera castigada'
,
'N'
,
0,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(24):=121371442;
RQTY_323_.tb2_0(24):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(24):=RQTY_323_.tb2_0(24);
RQTY_323_.old_tb2_1(24):='GEGE_EXERULVAL_CT69E121371442'
;
RQTY_323_.tb2_1(24):=RQTY_323_.tb2_0(24);
RQTY_323_.tb2_2(24):=RQTY_323_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (24)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(24),
RQTY_323_.tb2_1(24),
RQTY_323_.tb2_2(24),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",nuCustomer);sbPNOPend = FM_BO_NTL_PROCESS.FSBGETCOSTHASPENDNTLPKG(nuCustomer);if (sbPNOPend <> "N",GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Este cliente se encuentra un proceso de PNO");,)'
,
'LBTEST'
,
to_date('25-07-2012 15:31:52','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:48','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida que el cliente que solicita el servicio no se encuentre asociado a un proceso de PNO'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(7):=158;
RQTY_323_.tb9_1(7):=RQTY_323_.tb2_0(24);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (7)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(7),
VALID_EXPRESSION=RQTY_323_.tb9_1(7),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_CUST_NO_PNO'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que el cliente que solicita el servicio no se encuentre asociado a un proceso de PNO'
,
DISPLAY_NAME='Valida que el cliente que solicita el servicio no se encuentre asociado a un proceso de PNO'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(7);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(7),
RQTY_323_.tb9_1(7),
null,
1,
5,
22,
'VAL_CUST_NO_PNO'
,
null,
null,
null,
null,
null,
'Valida que el cliente que solicita el servicio no se encuentre asociado a un proceso de PNO'
,
'Valida que el cliente que solicita el servicio no se encuentre asociado a un proceso de PNO'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(7):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(7):=RQTY_323_.tb9_0(7);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (7)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(7),
RQTY_323_.tb10_1(7),
'Valida que el cliente que solicita el servicio no se encuentre asociado a un proceso de PNO'
,
'N'
,
0,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(8):=199;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (8)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(8),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=1,
ATTRIBUTE_CLASS_ID=8,
NAME_ATTRIBUTE='DEFAULT_MEASURING_MET'
,
LENGTH=10,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='M¿todo de medici¿n por defecto'
,
DISPLAY_NAME='M¿todo de medici¿n por defecto'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(8);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(8),
null,
null,
1,
1,
8,
'DEFAULT_MEASURING_MET'
,
10,
null,
null,
null,
null,
'M¿todo de medici¿n por defecto'
,
'M¿todo de medici¿n por defecto'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(8):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(8):=RQTY_323_.tb9_0(8);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (8)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(8),
RQTY_323_.tb10_1(8),
'M¿todo de medici¿n por defecto'
,
'3102'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb9_0(9):=204;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (9)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_323_.tb9_0(9),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=2,
MODULE_ID=16,
ATTRIBUTE_CLASS_ID=7,
NAME_ATTRIBUTE='PLANEA_ACT_PARA_COTIZACION'
,
LENGTH=1,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Se planean actividades para ser usadas en la cotizacion?'
,
DISPLAY_NAME='Se planean actividades para ser usadas en la cotizacion?'

 WHERE ATTRIBUTE_ID = RQTY_323_.tb9_0(9);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_323_.tb9_0(9),
null,
null,
2,
16,
7,
'PLANEA_ACT_PARA_COTIZACION'
,
1,
null,
null,
null,
null,
'Se planean actividades para ser usadas en la cotizacion?'
,
'Se planean actividades para ser usadas en la cotizacion?'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb10_0(9):=RQTY_323_.tb5_0(0);
RQTY_323_.tb10_1(9):=RQTY_323_.tb9_0(9);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (9)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_323_.tb10_0(9),
RQTY_323_.tb10_1(9),
'Se planean actividades para ser usadas en la cotizacion?'
,
'Y'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb11_0(0):=117;
RQTY_323_.tb11_1(0):=RQTY_323_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_323_.tb11_0(0),
PACKAGE_TYPE_ID=RQTY_323_.tb11_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=349,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_323_.tb11_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_323_.tb11_0(0),
RQTY_323_.tb11_1(0),
null,
null,
349,
21);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb12_0(0):=66;
RQTY_323_.tb12_1(0):=RQTY_323_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_323_.tb12_0(0),
VALUE_1=RQTY_323_.tb12_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=349,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Venta a Constructoras'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_323_.tb12_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_323_.tb12_0(0),
RQTY_323_.tb12_1(0),
null,
21,
349,
0,
31536000,
0,
'Venta a Constructoras'
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb13_0(0):=22;
RQTY_323_.tb13_1(0):=RQTY_323_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_EVENTS fila (0)',1);
UPDATE PS_PACKAGE_EVENTS SET PACKAGE_EVENTS_ID=RQTY_323_.tb13_0(0),
PACKAGE_TYPE_ID=RQTY_323_.tb13_1(0),
EVENT_ID=1
 WHERE PACKAGE_EVENTS_ID = RQTY_323_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_EVENTS(PACKAGE_EVENTS_ID,PACKAGE_TYPE_ID,EVENT_ID) 
VALUES (RQTY_323_.tb13_0(0),
RQTY_323_.tb13_1(0),
1);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb1_0(5):=65;
RQTY_323_.tb1_1(5):=RQTY_323_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (5)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_323_.tb1_0(5),
MODULE_ID=RQTY_323_.tb1_1(5),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQTY_323_.tb1_0(5);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_323_.tb1_0(5),
RQTY_323_.tb1_1(5),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.old_tb2_0(25):=121371443;
RQTY_323_.tb2_0(25):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_323_.tb2_0(25):=RQTY_323_.tb2_0(25);
RQTY_323_.old_tb2_1(25):='MO_EVE_COMP_CT65E121371443'
;
RQTY_323_.tb2_1(25):=RQTY_323_.tb2_0(25);
RQTY_323_.tb2_2(25):=RQTY_323_.tb1_0(5);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (25)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_323_.tb2_0(25),
RQTY_323_.tb2_1(25),
RQTY_323_.tb2_2(25),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);if (GE_BOINSTANCECONTROL.FBLACCKEYENTITYSTACK(sbInstancia, null, "MO_BILLING_ADDRESS", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.DESTROYENTITY(sbInstancia,null,"MO_BILLING_ADDRESS");GE_BOINSTANCECONTROL.DESTROYENTITY(sbInstancia,null,"MO_SUBSCRIPTION");,)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:00','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:48','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:00:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'EVE - PRE - PACK- Instancia Contrato - Venta Constructoras'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb14_0(0):=30;
RQTY_323_.tb14_1(0):=RQTY_323_.tb13_0(0);
RQTY_323_.tb14_2(0):=RQTY_323_.tb2_0(25);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_PACKAGE fila (0)',1);
UPDATE PS_WHEN_PACKAGE SET WHEN_PACKAGE_ID=RQTY_323_.tb14_0(0),
PACKAGE_EVENT_ID=RQTY_323_.tb14_1(0),
CONFIG_EXPRESSION_ID=RQTY_323_.tb14_2(0),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_PACKAGE_ID = RQTY_323_.tb14_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_PACKAGE(WHEN_PACKAGE_ID,PACKAGE_EVENT_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQTY_323_.tb14_0(0),
RQTY_323_.tb14_1(0),
RQTY_323_.tb14_2(0),
'B'
,
'Y'
);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb15_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_323_.tb15_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb16_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_323_.tb16_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb17_0(0):=6121;
RQTY_323_.tb17_2(0):=RQTY_323_.tb15_0(0);
RQTY_323_.tb17_3(0):=RQTY_323_.tb16_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_323_.tb17_0(0),
SERVCLAS=null,
SERVTISE=RQTY_323_.tb17_2(0),
SERVSETI=RQTY_323_.tb17_3(0),
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
 WHERE SERVCODI = RQTY_323_.tb17_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_323_.tb17_0(0),
null,
RQTY_323_.tb17_2(0),
RQTY_323_.tb17_3(0),
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb18_0(0):=108;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_323_.tb18_0(0),
CLASS_REGISTER_ID=6,
DESCRIPTION='Venta de Servicios de Ingenier¿a'
,
ASSIGNABLE='N'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_VENTA_SERV_INGENIERIA'
,
ACTIVITY_TYPE=null
 WHERE MOTIVE_TYPE_ID = RQTY_323_.tb18_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_323_.tb18_0(0),
6,
'Venta de Servicios de Ingenier¿a'
,
'N'
,
'Y'
,
'MOTY_VENTA_SERV_INGENIERIA'
,
null);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb19_0(0):=114;
RQTY_323_.tb19_1(0):=RQTY_323_.tb17_0(0);
RQTY_323_.tb19_2(0):=RQTY_323_.tb18_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_323_.tb19_0(0),
RQTY_323_.tb19_1(0),
RQTY_323_.tb19_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
,
'Solicitud de Trabajos para una Constructora'
,
'N'
,
'N'
,
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
RQTY_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_323_.blProcessStatus) then
 return;
end if;

RQTY_323_.tb20_0(0):=122;
RQTY_323_.tb20_1(0):=RQTY_323_.tb19_0(0);
RQTY_323_.tb20_3(0):=RQTY_323_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_323_.tb20_0(0),
PRODUCT_MOTIVE_ID=RQTY_323_.tb20_1(0),
PRODUCT_TYPE_ID=6121,
PACKAGE_TYPE_ID=RQTY_323_.tb20_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_323_.tb20_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_323_.tb20_0(0),
RQTY_323_.tb20_1(0),
6121,
RQTY_323_.tb20_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_323_.blProcessStatus := false;
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
nuIndex := RQTY_323_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_323_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_323_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_323_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_323_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_323_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_323_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_323_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_323_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_323_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_323_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_323_.blProcessStatus := false;
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
 nuIndex := RQTY_323_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_323_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_323_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_323_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_323_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_323_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_323_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_323_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_323_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_323_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_323_',
'CREATE OR REPLACE PACKAGE RQPMT_323_ IS ' || chr(10) ||
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
'tb5_0 ty5_0;type ty6_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty7_0 is table of PS_PROD_MOTI_PARAM.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_PROD_MOTI_PARAM.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty8_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of PS_COMPONENT_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty10_0 is table of PS_PROD_MOTIVE_COMP.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of PS_PROD_MOTIVE_COMP.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of PS_PROD_MOTIVE_COMP.PARENT_COMP%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty10_4 is table of PS_PROD_MOTIVE_COMP.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_4 ty10_4; ' || chr(10) ||
'tb10_4 ty10_4;type ty11_0 is table of PS_MOTI_COMPON_EVENT.MOTI_COMPON_EVENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of PS_MOTI_COMPON_EVENT.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty12_0 is table of PS_WHEN_MOTI_COMPON.WHEN_MOTI_COMPON_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of PS_WHEN_MOTI_COMPON.MOTI_COMPON_EVENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty12_2 is table of PS_WHEN_MOTI_COMPON.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_2 ty12_2; ' || chr(10) ||
'tb12_2 ty12_2;type ty13_0 is table of PS_MOTI_COMP_ATTRIBS.MOTI_COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty13_1 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_1 ty13_1; ' || chr(10) ||
'tb13_1 ty13_1;type ty13_2 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_2 ty13_2; ' || chr(10) ||
'tb13_2 ty13_2;type ty13_3 is table of PS_MOTI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb13_3 ty13_3; ' || chr(10) ||
'tb13_3 ty13_3;type ty13_4 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_4 ty13_4; ' || chr(10) ||
'tb13_4 ty13_4;type ty13_5 is table of PS_MOTI_COMP_ATTRIBS.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_5 ty13_5; ' || chr(10) ||
'tb13_5 ty13_5;type ty13_6 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_6 ty13_6; ' || chr(10) ||
'tb13_6 ty13_6;type ty13_7 is table of PS_MOTI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_7 ty13_7; ' || chr(10) ||
'tb13_7 ty13_7;type ty13_8 is table of PS_MOTI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_8 ty13_8; ' || chr(10) ||
'tb13_8 ty13_8;type ty13_9 is table of PS_MOTI_COMP_ATTRIBS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_9 ty13_9; ' || chr(10) ||
'tb13_9 ty13_9;type ty14_0 is table of PS_PROD_MOTI_EVENTS.PROD_MOTI_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty14_1 is table of PS_PROD_MOTI_EVENTS.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_1 ty14_1; ' || chr(10) ||
'tb14_1 ty14_1;type ty15_0 is table of PS_WHEN_MOTIVE.WHEN_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_0 ty15_0; ' || chr(10) ||
'tb15_0 ty15_0;type ty15_1 is table of PS_WHEN_MOTIVE.PROD_MOTI_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_1 ty15_1; ' || chr(10) ||
'tb15_1 ty15_1;type ty15_2 is table of PS_WHEN_MOTIVE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_2 ty15_2; ' || chr(10) ||
'tb15_2 ty15_2;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 323; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 323 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 323 ' || chr(10) ||
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
'END RQPMT_323_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_323_******************************'); END;
/

BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_323_.cuExpressions;
fetch RQPMT_323_.cuExpressions bulk collect INTO RQPMT_323_.tbExpressionsId;
close RQPMT_323_.cuExpressions;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_323_.tbEntityName(-1) := 'NULL';
   RQPMT_323_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_323_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQPMT_323_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_323_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQPMT_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQPMT_323_.tbEntityAttributeName(90151603) := 'LDC_TIPO_VIVIENDA_CONT@SOLICITUD';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_323_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQPMT_323_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_323_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQPMT_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_323_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQPMT_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQPMT_323_.tbEntityAttributeName(90151602) := 'LDC_TIPO_VIVIENDA_CONT@FECHA_REGISTRO';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQPMT_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQPMT_323_.tbEntityAttributeName(90151601) := 'LDC_TIPO_VIVIENDA_CONT@TIPO_VIVIENDA';
   RQPMT_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_323_.tbEntityAttributeName(44501) := 'MO_DATA_FOR_ORDER@ITEM_ID';
   RQPMT_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_323_.tbEntityAttributeName(2877) := 'MO_DATA_FOR_ORDER@MOTIVE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQPMT_323_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_323_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQPMT_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_323_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQPMT_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_323_.tbEntityAttributeName(2875) := 'MO_DATA_FOR_ORDER@DATA_FOR_ORDER_ID';
   RQPMT_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQPMT_323_.tbEntityAttributeName(90151600) := 'LDC_TIPO_VIVIENDA_CONT@CONTRATO';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_323_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQPMT_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_323_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQPMT_323_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_323_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQPMT_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_323_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_323_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
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
WHERE PACKAGE_type_id = 323
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
WHERE PACKAGE_type_id = 323
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
WHERE PACKAGE_type_id = 323
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
WHERE PACKAGE_type_id = 323
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
WHERE PACKAGE_type_id = 323
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
WHERE PACKAGE_type_id = 323
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_323_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 323
))));

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_323_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_323_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_323_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_323_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 323
))));

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 323
))));

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_323_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_323_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 323
)))));

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_323_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_323_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_323_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_323_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_323_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_323_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 323
))));

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
))));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 323
))));

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
)));
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_323_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_323_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_323_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_323_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_323_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_323_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_323_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_323_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 323
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_323_.blProcessStatus) then
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb0_0(0):=114;
RQPMT_323_.tb0_1(0):=6121;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_323_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_323_.tb0_1(0),
MOTIVE_TYPE_ID=108,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
,
DESCRIPTION='Solicitud de Trabajos para una Constructora'
,
USE_UNCOMPOSITION='N'
,
LOAD_PRODUCT_INFO='N'
,
LOAD_HIERARCHY='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_323_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_323_.tb0_0(0),
RQPMT_323_.tb0_1(0),
108,
null,
'N'
,
'N'
,
'N'
,
'M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
,
'Solicitud de Trabajos para una Constructora'
,
'N'
,
'N'
,
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
null,
null,
null,
'N'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(0):=1910;
RQPMT_323_.old_tb1_1(0):=118;
RQPMT_323_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(0),-1)));
RQPMT_323_.old_tb1_2(0):=2877;
RQPMT_323_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(0),-1)));
RQPMT_323_.old_tb1_3(0):=187;
RQPMT_323_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(0),-1)));
RQPMT_323_.old_tb1_4(0):=null;
RQPMT_323_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(0),-1)));
RQPMT_323_.tb1_9(0):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(0),
ENTITY_ID=RQPMT_323_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(0),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Id Del Motivo'
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
TAG_NAME='MOTIVE_ID'
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
ENTITY_NAME='MO_DATA_FOR_ORDER'
,
ATTRI_TECHNICAL_NAME='MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(0),
RQPMT_323_.tb1_1(0),
RQPMT_323_.tb1_2(0),
RQPMT_323_.tb1_3(0),
RQPMT_323_.tb1_4(0),
null,
null,
null,
null,
RQPMT_323_.tb1_9(0),
3,
'Id Del Motivo'
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
'MOTIVE_ID'
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
'MO_DATA_FOR_ORDER'
,
'MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_323_.tb2_0(0),
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

 WHERE MODULE_ID = RQPMT_323_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_323_.tb2_0(0),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb3_0(0):=23;
RQPMT_323_.tb3_1(0):=RQPMT_323_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_323_.tb3_0(0),
MODULE_ID=RQPMT_323_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_323_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_323_.tb3_0(0),
RQPMT_323_.tb3_1(0),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(0):=121371445;
RQPMT_323_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(0):=RQPMT_323_.tb4_0(0);
RQPMT_323_.old_tb4_1(0):='MO_INITATRIB_CT23E121371445'
;
RQPMT_323_.tb4_1(0):=RQPMT_323_.tb4_0(0);
RQPMT_323_.tb4_2(0):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(0),
RQPMT_323_.tb4_1(0),
RQPMT_323_.tb4_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETADDRESSID())'
,
'LBTEST'
,
to_date('01-09-2012 08:50:12','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:06','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:06','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_ADDRESS - ADDRESS_ID - Inicializa la secuencia de la direcci¿n de motivo.'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(1):=1923;
RQPMT_323_.old_tb1_1(1):=21;
RQPMT_323_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(1),-1)));
RQPMT_323_.old_tb1_2(1):=474;
RQPMT_323_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(1),-1)));
RQPMT_323_.old_tb1_3(1):=null;
RQPMT_323_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(1),-1)));
RQPMT_323_.old_tb1_4(1):=null;
RQPMT_323_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(1),-1)));
RQPMT_323_.tb1_6(1):=RQPMT_323_.tb4_0(0);
RQPMT_323_.tb1_9(1):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(1),
ENTITY_ID=RQPMT_323_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(1),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(1),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='C¿digo de la Direcci¿n'
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
TAG_NAME='ADDRESS_ID'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(1),
RQPMT_323_.tb1_1(1),
RQPMT_323_.tb1_2(1),
RQPMT_323_.tb1_3(1),
RQPMT_323_.tb1_4(1),
null,
RQPMT_323_.tb1_6(1),
null,
null,
RQPMT_323_.tb1_9(1),
16,
'C¿digo de la Direcci¿n'
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
'ADDRESS_ID'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb3_0(1):=26;
RQPMT_323_.tb3_1(1):=RQPMT_323_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_323_.tb3_0(1),
MODULE_ID=RQPMT_323_.tb3_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_323_.tb3_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_323_.tb3_0(1),
RQPMT_323_.tb3_1(1),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(1):=121371446;
RQPMT_323_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(1):=RQPMT_323_.tb4_0(1);
RQPMT_323_.old_tb4_1(1):='MO_VALIDATTR_CT26E121371446'
;
RQPMT_323_.tb4_1(1):=RQPMT_323_.tb4_0(1);
RQPMT_323_.tb4_2(1):=RQPMT_323_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(1),
RQPMT_323_.tb4_1(1),
RQPMT_323_.tb4_2(1),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(inuAddressID);LDC_BOINFOADDRESS.VALINFOPREMISE(inuAddressID)'
,
'OPEN'
,
to_date('26-05-2014 15:58:22','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PROCESS - ADDRESS_MAIN_MOTIVE - Validaci¿n de la Direcci¿n  - Venta a Constructoras'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(2):=1924;
RQPMT_323_.old_tb1_1(2):=68;
RQPMT_323_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(2),-1)));
RQPMT_323_.old_tb1_2(2):=1035;
RQPMT_323_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(2),-1)));
RQPMT_323_.old_tb1_3(2):=null;
RQPMT_323_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(2),-1)));
RQPMT_323_.old_tb1_4(2):=null;
RQPMT_323_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(2),-1)));
RQPMT_323_.tb1_7(2):=RQPMT_323_.tb4_0(1);
RQPMT_323_.tb1_9(2):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(2),
ENTITY_ID=RQPMT_323_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_323_.tb1_7(2),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(2),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Direccion de Ejecucion de Trabajos'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='DIRECCION_DE_EJECUCION_DE_TRABAJOS'
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
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS_MAIN_MOTIVE'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(2),
RQPMT_323_.tb1_1(2),
RQPMT_323_.tb1_2(2),
RQPMT_323_.tb1_3(2),
RQPMT_323_.tb1_4(2),
null,
null,
RQPMT_323_.tb1_7(2),
null,
RQPMT_323_.tb1_9(2),
17,
'Direccion de Ejecucion de Trabajos'
,
17,
'Y'
,
'N'
,
'N'
,
'Y'
,
'DIRECCION_DE_EJECUCION_DE_TRABAJOS'
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
'MO_PROCESS'
,
'ADDRESS_MAIN_MOTIVE'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(2):=121371444;
RQPMT_323_.tb4_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(2):=RQPMT_323_.tb4_0(2);
RQPMT_323_.old_tb4_1(2):='MO_INITATRIB_CT23E121371444'
;
RQPMT_323_.tb4_1(2):=RQPMT_323_.tb4_0(2);
RQPMT_323_.tb4_2(2):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(2),
RQPMT_323_.tb4_1(2),
RQPMT_323_.tb4_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETSEQ_MO_DATA_FOR_ORDER())'
,
'LBTEST'
,
to_date('01-09-2012 08:50:10','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:06','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:06','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtener nuevo identificador de MO_DATA_FOR_ORDER'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(3):=1909;
RQPMT_323_.old_tb1_1(3):=118;
RQPMT_323_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(3),-1)));
RQPMT_323_.old_tb1_2(3):=2875;
RQPMT_323_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(3),-1)));
RQPMT_323_.old_tb1_3(3):=null;
RQPMT_323_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(3),-1)));
RQPMT_323_.old_tb1_4(3):=null;
RQPMT_323_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(3),-1)));
RQPMT_323_.tb1_6(3):=RQPMT_323_.tb4_0(2);
RQPMT_323_.tb1_9(3):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(3),
ENTITY_ID=RQPMT_323_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(3),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(3),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Id De Data For Order'
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
TAG_NAME='DATA_FOR_ORDER_ID'
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
ENTITY_NAME='MO_DATA_FOR_ORDER'
,
ATTRI_TECHNICAL_NAME='DATA_FOR_ORDER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(3),
RQPMT_323_.tb1_1(3),
RQPMT_323_.tb1_2(3),
RQPMT_323_.tb1_3(3),
RQPMT_323_.tb1_4(3),
null,
RQPMT_323_.tb1_6(3),
null,
null,
RQPMT_323_.tb1_9(3),
2,
'Id De Data For Order'
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
'DATA_FOR_ORDER_ID'
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
'MO_DATA_FOR_ORDER'
,
'DATA_FOR_ORDER_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(4):=104128;
RQPMT_323_.old_tb1_1(4):=4396;
RQPMT_323_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(4),-1)));
RQPMT_323_.old_tb1_2(4):=90151600;
RQPMT_323_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(4),-1)));
RQPMT_323_.old_tb1_3(4):=null;
RQPMT_323_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(4),-1)));
RQPMT_323_.old_tb1_4(4):=null;
RQPMT_323_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(4),-1)));
RQPMT_323_.tb1_9(4):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(4),
ENTITY_ID=RQPMT_323_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(4),
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Contrato'
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
TAG_NAME='CONTRATO'
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
ENTITY_NAME='LDC_TIPO_VIVIENDA_CONT'
,
ATTRI_TECHNICAL_NAME='CONTRATO'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(4),
RQPMT_323_.tb1_1(4),
RQPMT_323_.tb1_2(4),
RQPMT_323_.tb1_3(4),
RQPMT_323_.tb1_4(4),
null,
null,
null,
null,
RQPMT_323_.tb1_9(4),
20,
'Contrato'
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
'CONTRATO'
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
'LDC_TIPO_VIVIENDA_CONT'
,
'CONTRATO'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb5_0(0):=120188093;
RQPMT_323_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_323_.tb5_0(0):=RQPMT_323_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_323_.tb5_0(0),
16,
'Programas de Vivienda para constructoras'
,
'SELECT prog_viv_id ID, descripcion DESCRIPTION
  FROM ldc_programas_vivienda
ORDER BY ID'
,
'LDC - SEL- Programas de Vivienda'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(5):=104129;
RQPMT_323_.old_tb1_1(5):=4396;
RQPMT_323_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(5),-1)));
RQPMT_323_.old_tb1_2(5):=90151601;
RQPMT_323_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(5),-1)));
RQPMT_323_.old_tb1_3(5):=null;
RQPMT_323_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(5),-1)));
RQPMT_323_.old_tb1_4(5):=null;
RQPMT_323_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(5),-1)));
RQPMT_323_.tb1_5(5):=RQPMT_323_.tb5_0(0);
RQPMT_323_.tb1_9(5):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(5),
ENTITY_ID=RQPMT_323_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(5),
STATEMENT_ID=RQPMT_323_.tb1_5(5),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(5),
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Tipo de Vivienda'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='TIPO_DE_VIVIENDA'
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
ENTITY_NAME='LDC_TIPO_VIVIENDA_CONT'
,
ATTRI_TECHNICAL_NAME='TIPO_VIVIENDA'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(5),
RQPMT_323_.tb1_1(5),
RQPMT_323_.tb1_2(5),
RQPMT_323_.tb1_3(5),
RQPMT_323_.tb1_4(5),
RQPMT_323_.tb1_5(5),
null,
null,
null,
RQPMT_323_.tb1_9(5),
21,
'Tipo de Vivienda'
,
21,
'Y'
,
'N'
,
'N'
,
'Y'
,
'TIPO_DE_VIVIENDA'
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
'LDC_TIPO_VIVIENDA_CONT'
,
'TIPO_VIVIENDA'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(6):=104130;
RQPMT_323_.old_tb1_1(6):=4396;
RQPMT_323_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(6),-1)));
RQPMT_323_.old_tb1_2(6):=90151602;
RQPMT_323_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(6),-1)));
RQPMT_323_.old_tb1_3(6):=258;
RQPMT_323_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(6),-1)));
RQPMT_323_.old_tb1_4(6):=null;
RQPMT_323_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(6),-1)));
RQPMT_323_.tb1_9(6):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(6),
ENTITY_ID=RQPMT_323_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(6),
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Fecha de Registro'
,
DISPLAY_ORDER=22,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='FECHA_DE_REGISTRO'
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
ENTITY_NAME='LDC_TIPO_VIVIENDA_CONT'
,
ATTRI_TECHNICAL_NAME='FECHA_REGISTRO'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(6),
RQPMT_323_.tb1_1(6),
RQPMT_323_.tb1_2(6),
RQPMT_323_.tb1_3(6),
RQPMT_323_.tb1_4(6),
null,
null,
null,
null,
RQPMT_323_.tb1_9(6),
22,
'Fecha de Registro'
,
22,
'N'
,
'N'
,
'N'
,
'N'
,
'FECHA_DE_REGISTRO'
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
'LDC_TIPO_VIVIENDA_CONT'
,
'FECHA_REGISTRO'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(7):=104131;
RQPMT_323_.old_tb1_1(7):=4396;
RQPMT_323_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(7),-1)));
RQPMT_323_.old_tb1_2(7):=90151603;
RQPMT_323_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(7),-1)));
RQPMT_323_.old_tb1_3(7):=255;
RQPMT_323_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(7),-1)));
RQPMT_323_.old_tb1_4(7):=null;
RQPMT_323_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(7),-1)));
RQPMT_323_.tb1_9(7):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(7),
ENTITY_ID=RQPMT_323_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(7),
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Solicitud Asociada'
,
DISPLAY_ORDER=23,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='SOLICITUD_ASOCIADA'
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
ENTITY_NAME='LDC_TIPO_VIVIENDA_CONT'
,
ATTRI_TECHNICAL_NAME='SOLICITUD'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(7),
RQPMT_323_.tb1_1(7),
RQPMT_323_.tb1_2(7),
RQPMT_323_.tb1_3(7),
RQPMT_323_.tb1_4(7),
null,
null,
null,
null,
RQPMT_323_.tb1_9(7),
23,
'Solicitud Asociada'
,
23,
'N'
,
'N'
,
'N'
,
'N'
,
'SOLICITUD_ASOCIADA'
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
'LDC_TIPO_VIVIENDA_CONT'
,
'SOLICITUD'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(3):=121371447;
RQPMT_323_.tb4_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(3):=RQPMT_323_.tb4_0(3);
RQPMT_323_.old_tb4_1(3):='MO_INITATRIB_CT23E121371447'
;
RQPMT_323_.tb4_1(3):=RQPMT_323_.tb4_0(3);
RQPMT_323_.tb4_2(3):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(3),
RQPMT_323_.tb4_1(3),
RQPMT_323_.tb4_2(3),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'LBTEST'
,
to_date('01-09-2012 08:50:09','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(8):=1907;
RQPMT_323_.old_tb1_1(8):=8;
RQPMT_323_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(8),-1)));
RQPMT_323_.old_tb1_2(8):=187;
RQPMT_323_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(8),-1)));
RQPMT_323_.old_tb1_3(8):=null;
RQPMT_323_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(8),-1)));
RQPMT_323_.old_tb1_4(8):=null;
RQPMT_323_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(8),-1)));
RQPMT_323_.tb1_6(8):=RQPMT_323_.tb4_0(3);
RQPMT_323_.tb1_9(8):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(8),
ENTITY_ID=RQPMT_323_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(8),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='C¿digo'
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
TAG_NAME='C_DIGO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(8),
RQPMT_323_.tb1_1(8),
RQPMT_323_.tb1_2(8),
RQPMT_323_.tb1_3(8),
RQPMT_323_.tb1_4(8),
null,
RQPMT_323_.tb1_6(8),
null,
null,
RQPMT_323_.tb1_9(8),
0,
'C¿digo'
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
'C_DIGO'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(9):=1908;
RQPMT_323_.old_tb1_1(9):=8;
RQPMT_323_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(9),-1)));
RQPMT_323_.old_tb1_2(9):=213;
RQPMT_323_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(9),-1)));
RQPMT_323_.old_tb1_3(9):=255;
RQPMT_323_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(9),-1)));
RQPMT_323_.old_tb1_4(9):=null;
RQPMT_323_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(9),-1)));
RQPMT_323_.tb1_9(9):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(9),
ENTITY_ID=RQPMT_323_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(9),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Solicitud'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='SOLICITUD'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(9),
RQPMT_323_.tb1_1(9),
RQPMT_323_.tb1_2(9),
RQPMT_323_.tb1_3(9),
RQPMT_323_.tb1_4(9),
null,
null,
null,
null,
RQPMT_323_.tb1_9(9),
1,
'Solicitud'
,
1,
'N'
,
'N'
,
'N'
,
'N'
,
'SOLICITUD'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(4):=121371448;
RQPMT_323_.tb4_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(4):=RQPMT_323_.tb4_0(4);
RQPMT_323_.old_tb4_1(4):='MO_INITATRIB_CT23E121371448'
;
RQPMT_323_.tb4_1(4):=RQPMT_323_.tb4_0(4);
RQPMT_323_.tb4_2(4):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(4),
RQPMT_323_.tb4_1(4),
RQPMT_323_.tb4_2(4),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","ADDRESS_MAIN_MOTIVE",onuDireccion);nuCategoria = AB_BOADDRESS.FNUGETCATEGORY(onuDireccion);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuCategoria)'
,
'OPEN'
,
to_date('30-10-2015 14:48:43','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI-MOT-MO_MOTIVE-CATEGORY_ID-Inicializa la categoria'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(10):=104459;
RQPMT_323_.old_tb1_1(10):=8;
RQPMT_323_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(10),-1)));
RQPMT_323_.old_tb1_2(10):=147336;
RQPMT_323_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(10),-1)));
RQPMT_323_.old_tb1_3(10):=null;
RQPMT_323_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(10),-1)));
RQPMT_323_.old_tb1_4(10):=1035;
RQPMT_323_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(10),-1)));
RQPMT_323_.tb1_6(10):=RQPMT_323_.tb4_0(4);
RQPMT_323_.tb1_9(10):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(10),
ENTITY_ID=RQPMT_323_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(10),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Categor¿a'
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
ATTRI_TECHNICAL_NAME='CATEGORY_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(10),
RQPMT_323_.tb1_1(10),
RQPMT_323_.tb1_2(10),
RQPMT_323_.tb1_3(10),
RQPMT_323_.tb1_4(10),
null,
RQPMT_323_.tb1_6(10),
null,
null,
RQPMT_323_.tb1_9(10),
18,
'Categor¿a'
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
'CATEGORY_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(5):=121371449;
RQPMT_323_.tb4_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(5):=RQPMT_323_.tb4_0(5);
RQPMT_323_.old_tb4_1(5):='MO_INITATRIB_CT23E121371449'
;
RQPMT_323_.tb4_1(5):=RQPMT_323_.tb4_0(5);
RQPMT_323_.tb4_2(5):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(5),
RQPMT_323_.tb4_1(5),
RQPMT_323_.tb4_2(5),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","ADDRESS_MAIN_MOTIVE",onuDireccion);nuSubcategoria = AB_BOADDRESS.FNUGETSUBCATEGORY(onuDireccion);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSubcategoria)'
,
'OPEN'
,
to_date('30-10-2015 14:48:45','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI-MOT-MO_MOTIVE-SUBCATEGORY_ID-Inicializa el Subcategoria'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(11):=104460;
RQPMT_323_.old_tb1_1(11):=8;
RQPMT_323_.tb1_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(11),-1)));
RQPMT_323_.old_tb1_2(11):=147337;
RQPMT_323_.tb1_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(11),-1)));
RQPMT_323_.old_tb1_3(11):=null;
RQPMT_323_.tb1_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(11),-1)));
RQPMT_323_.old_tb1_4(11):=147336;
RQPMT_323_.tb1_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(11),-1)));
RQPMT_323_.tb1_6(11):=RQPMT_323_.tb4_0(5);
RQPMT_323_.tb1_9(11):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(11),
ENTITY_ID=RQPMT_323_.tb1_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(11),
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Subcategor¿a'
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
ATTRI_TECHNICAL_NAME='SUBCATEGORY_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(11),
RQPMT_323_.tb1_1(11),
RQPMT_323_.tb1_2(11),
RQPMT_323_.tb1_3(11),
RQPMT_323_.tb1_4(11),
null,
RQPMT_323_.tb1_6(11),
null,
null,
RQPMT_323_.tb1_9(11),
19,
'Subcategor¿a'
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
'SUBCATEGORY_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb5_0(1):=120188094;
RQPMT_323_.tb5_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_323_.tb5_0(1):=RQPMT_323_.tb5_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_323_.tb5_0(1),
16,
'Obtiene actividades para Constructoras'
,
'SELECT  a.items_id ID,
        b.description
        ||'|| chr(39) ||'     MODALIDAD['|| chr(39) ||'
        ||DECODE(a.pay_modality,
                1, '|| chr(39) ||'1-Antes de Hacer los Trabajos'|| chr(39) ||',
                2, '|| chr(39) ||'2-Al Finalizar los Trabajos'|| chr(39) ||',
                3, '|| chr(39) ||'3-Seg¿n Avance de Obra'|| chr(39) ||',
                4, '|| chr(39) ||'4-Sin Cotizaci¿n'|| chr(39) ||')
        ||'|| chr(39) ||']    PRODUCTO['|| chr(39) ||'
        ||DECODE(a.product_type_id,
                 null, '|| chr(39) ||'N/A'|| chr(39) ||',
                 pktblServicio.fsbGetDescription(a.product_type_id))
        ||'|| chr(39) ||']'|| chr(39) ||' DESCRIPTION
FROM    ps_engineering_activ a, ge_items b
WHERE   a.items_id = b.items_id'
,
'Obtiene actividades para Constructoras'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(12):=1911;
RQPMT_323_.old_tb1_1(12):=118;
RQPMT_323_.tb1_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(12),-1)));
RQPMT_323_.old_tb1_2(12):=44501;
RQPMT_323_.tb1_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(12),-1)));
RQPMT_323_.old_tb1_3(12):=null;
RQPMT_323_.tb1_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(12),-1)));
RQPMT_323_.old_tb1_4(12):=2558;
RQPMT_323_.tb1_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(12),-1)));
RQPMT_323_.tb1_5(12):=RQPMT_323_.tb5_0(1);
RQPMT_323_.tb1_9(12):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(12),
ENTITY_ID=RQPMT_323_.tb1_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(12),
STATEMENT_ID=RQPMT_323_.tb1_5(12),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(12),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Actividad'
,
DISPLAY_ORDER=4,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='ITEM_ID'
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
ENTITY_NAME='MO_DATA_FOR_ORDER'
,
ATTRI_TECHNICAL_NAME='ITEM_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(12),
RQPMT_323_.tb1_1(12),
RQPMT_323_.tb1_2(12),
RQPMT_323_.tb1_3(12),
RQPMT_323_.tb1_4(12),
RQPMT_323_.tb1_5(12),
null,
null,
null,
RQPMT_323_.tb1_9(12),
4,
'Actividad'
,
4,
'Y'
,
'N'
,
'N'
,
'Y'
,
'ITEM_ID'
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
'MO_DATA_FOR_ORDER'
,
'ITEM_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(13):=1912;
RQPMT_323_.old_tb1_1(13):=8;
RQPMT_323_.tb1_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(13),-1)));
RQPMT_323_.old_tb1_2(13):=197;
RQPMT_323_.tb1_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(13),-1)));
RQPMT_323_.old_tb1_3(13):=null;
RQPMT_323_.tb1_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(13),-1)));
RQPMT_323_.old_tb1_4(13):=null;
RQPMT_323_.tb1_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(13),-1)));
RQPMT_323_.tb1_9(13):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(13),
ENTITY_ID=RQPMT_323_.tb1_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(13),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Privado'
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
TAG_NAME='PRIVADO'
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
ATTRI_TECHNICAL_NAME='PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(13),
RQPMT_323_.tb1_1(13),
RQPMT_323_.tb1_2(13),
RQPMT_323_.tb1_3(13),
RQPMT_323_.tb1_4(13),
null,
null,
null,
null,
RQPMT_323_.tb1_9(13),
5,
'Privado'
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
'PRIVADO'
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
'PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(6):=121371450;
RQPMT_323_.tb4_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(6):=RQPMT_323_.tb4_0(6);
RQPMT_323_.old_tb4_1(6):='MO_INITATRIB_CT23E121371450'
;
RQPMT_323_.tb4_1(6):=RQPMT_323_.tb4_0(6);
RQPMT_323_.tb4_2(6):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(6),
RQPMT_323_.tb4_1(6),
RQPMT_323_.tb4_2(6),
'GI_BOINSTANCE.REPLACEVALUE("S|s|Y|y|N|n|","Y|Y|Y|Y|N|N|","|")'
,
'LBTEST'
,
to_date('01-09-2012 08:50:10','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:07','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida y actualiza cadena de caracteres'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(14):=1913;
RQPMT_323_.old_tb1_1(14):=8;
RQPMT_323_.tb1_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(14),-1)));
RQPMT_323_.old_tb1_2(14):=322;
RQPMT_323_.tb1_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(14),-1)));
RQPMT_323_.old_tb1_3(14):=null;
RQPMT_323_.tb1_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(14),-1)));
RQPMT_323_.old_tb1_4(14):=null;
RQPMT_323_.tb1_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(14),-1)));
RQPMT_323_.tb1_6(14):=RQPMT_323_.tb4_0(6);
RQPMT_323_.tb1_9(14):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(14),
ENTITY_ID=RQPMT_323_.tb1_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(14),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Parcial'
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
TAG_NAME='PARCIAL'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(14),
RQPMT_323_.tb1_1(14),
RQPMT_323_.tb1_2(14),
RQPMT_323_.tb1_3(14),
RQPMT_323_.tb1_4(14),
null,
RQPMT_323_.tb1_6(14),
null,
null,
RQPMT_323_.tb1_9(14),
6,
'Parcial'
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
'PARCIAL'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb2_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_323_.tb2_0(1),
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

 WHERE MODULE_ID = RQPMT_323_.tb2_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_323_.tb2_0(1),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb3_0(2):=1;
RQPMT_323_.tb3_1(2):=RQPMT_323_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_323_.tb3_0(2),
MODULE_ID=RQPMT_323_.tb3_1(2),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_323_.tb3_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_323_.tb3_0(2),
RQPMT_323_.tb3_1(2),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(7):=121371451;
RQPMT_323_.tb4_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(7):=RQPMT_323_.tb4_0(7);
RQPMT_323_.old_tb4_1(7):='GE_EXEACTION_CT1E121371451'
;
RQPMT_323_.tb4_1(7):=RQPMT_323_.tb4_0(7);
RQPMT_323_.tb4_2(7):=RQPMT_323_.tb3_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(7),
RQPMT_323_.tb4_1(7),
RQPMT_323_.tb4_2(7),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbPriority);nuPriority = UT_CONVERT.FNUCHARTONUMBER(sbPriority);if (nuPriority <= 0,GE_BOERRORS.SETERRORCODE(3305);,nuMaximPriority = UT_CONVERT.FNUCHARTONUMBER(DAGE_PARAMETER.FSBGETVALUE("MAX_PRIORITY"));if (nuPriority > nuMaximPriority,GE_BOERRORS.SETERRORCODE(9510);,);)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:11','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - GEST MOT - MO_MOTIVE - PRIORITY - Valida prioridad'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(8):=121371452;
RQPMT_323_.tb4_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(8):=RQPMT_323_.tb4_0(8);
RQPMT_323_.old_tb4_1(8):='MO_INITATRIB_CT23E121371452'
;
RQPMT_323_.tb4_1(8):=RQPMT_323_.tb4_0(8);
RQPMT_323_.tb4_2(8):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(8),
RQPMT_323_.tb4_1(8),
RQPMT_323_.tb4_2(8),
'nuPriority = UT_CONVERT.FNUCHARTONUMBER(DAGE_PARAMETER.FSBGETVALUE("DEFAULT_PRIORITY"));GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuPriority)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:11','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - GEST MOT - MO_MOTIVE - PRIORITY - Inicializa prioridad'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(15):=1914;
RQPMT_323_.old_tb1_1(15):=8;
RQPMT_323_.tb1_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(15),-1)));
RQPMT_323_.old_tb1_2(15):=203;
RQPMT_323_.tb1_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(15),-1)));
RQPMT_323_.old_tb1_3(15):=null;
RQPMT_323_.tb1_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(15),-1)));
RQPMT_323_.old_tb1_4(15):=null;
RQPMT_323_.tb1_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(15),-1)));
RQPMT_323_.tb1_6(15):=RQPMT_323_.tb4_0(8);
RQPMT_323_.tb1_7(15):=RQPMT_323_.tb4_0(7);
RQPMT_323_.tb1_9(15):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(15),
ENTITY_ID=RQPMT_323_.tb1_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(15),
VALID_EXPRESSION_ID=RQPMT_323_.tb1_7(15),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(15),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Prioridad'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(15),
RQPMT_323_.tb1_1(15),
RQPMT_323_.tb1_2(15),
RQPMT_323_.tb1_3(15),
RQPMT_323_.tb1_4(15),
null,
RQPMT_323_.tb1_6(15),
RQPMT_323_.tb1_7(15),
null,
RQPMT_323_.tb1_9(15),
7,
'Prioridad'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(16):=1915;
RQPMT_323_.old_tb1_1(16):=8;
RQPMT_323_.tb1_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(16),-1)));
RQPMT_323_.old_tb1_2(16):=189;
RQPMT_323_.tb1_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(16),-1)));
RQPMT_323_.old_tb1_3(16):=null;
RQPMT_323_.tb1_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(16),-1)));
RQPMT_323_.old_tb1_4(16):=null;
RQPMT_323_.tb1_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(16),-1)));
RQPMT_323_.tb1_9(16):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(16),
ENTITY_ID=RQPMT_323_.tb1_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(16),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Solicitud atenci¿n al cliente'
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
TAG_NAME='SOLICITUD_ATENCI_N_AL_CLIENTE'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(16),
RQPMT_323_.tb1_1(16),
RQPMT_323_.tb1_2(16),
RQPMT_323_.tb1_3(16),
RQPMT_323_.tb1_4(16),
null,
null,
null,
null,
RQPMT_323_.tb1_9(16),
8,
'Solicitud atenci¿n al cliente'
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
'SOLICITUD_ATENCI_N_AL_CLIENTE'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(9):=121371453;
RQPMT_323_.tb4_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(9):=RQPMT_323_.tb4_0(9);
RQPMT_323_.old_tb4_1(9):='MO_INITATRIB_CT23E121371453'
;
RQPMT_323_.tb4_1(9):=RQPMT_323_.tb4_0(9);
RQPMT_323_.tb4_2(9):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(9),
RQPMT_323_.tb4_1(9),
RQPMT_323_.tb4_2(9),
'CF_BOINITRULES.INIFIELDFROMWI("PR_PRODUCT","PRODUCT_ID")'
,
'LBTEST'
,
to_date('01-09-2012 08:50:11','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa el campo con el valor instanciado en WI'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(17):=1916;
RQPMT_323_.old_tb1_1(17):=8;
RQPMT_323_.tb1_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(17),-1)));
RQPMT_323_.old_tb1_2(17):=413;
RQPMT_323_.tb1_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(17),-1)));
RQPMT_323_.old_tb1_3(17):=null;
RQPMT_323_.tb1_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(17),-1)));
RQPMT_323_.old_tb1_4(17):=null;
RQPMT_323_.tb1_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(17),-1)));
RQPMT_323_.tb1_6(17):=RQPMT_323_.tb4_0(9);
RQPMT_323_.tb1_9(17):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(17),
ENTITY_ID=RQPMT_323_.tb1_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(17),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(17),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Producto'
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
TAG_NAME='PRODUCTO'
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
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(17),
RQPMT_323_.tb1_1(17),
RQPMT_323_.tb1_2(17),
RQPMT_323_.tb1_3(17),
RQPMT_323_.tb1_4(17),
null,
RQPMT_323_.tb1_6(17),
null,
null,
RQPMT_323_.tb1_9(17),
9,
'Producto'
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
'PRODUCTO'
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
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(10):=121371454;
RQPMT_323_.tb4_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(10):=RQPMT_323_.tb4_0(10);
RQPMT_323_.old_tb4_1(10):='MO_INITATRIB_CT23E121371454'
;
RQPMT_323_.tb4_1(10):=RQPMT_323_.tb4_0(10);
RQPMT_323_.tb4_2(10):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(10),
RQPMT_323_.tb4_1(10),
RQPMT_323_.tb4_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),CF_BOINITRULES.INIFIELDFROMWI("SUSCRIPC","SUSCCODI");,)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:11','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI -MO_MOTIVE - SUBSCRIPTION_ID - Inicializa identificador del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(18):=1917;
RQPMT_323_.old_tb1_1(18):=8;
RQPMT_323_.tb1_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(18),-1)));
RQPMT_323_.old_tb1_2(18):=11403;
RQPMT_323_.tb1_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(18),-1)));
RQPMT_323_.old_tb1_3(18):=null;
RQPMT_323_.tb1_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(18),-1)));
RQPMT_323_.old_tb1_4(18):=null;
RQPMT_323_.tb1_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(18),-1)));
RQPMT_323_.tb1_6(18):=RQPMT_323_.tb4_0(10);
RQPMT_323_.tb1_9(18):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(18),
ENTITY_ID=RQPMT_323_.tb1_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(18),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(18),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Contrato'
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
TAG_NAME='CONTRATO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(18),
RQPMT_323_.tb1_1(18),
RQPMT_323_.tb1_2(18),
RQPMT_323_.tb1_3(18),
RQPMT_323_.tb1_4(18),
null,
RQPMT_323_.tb1_6(18),
null,
null,
RQPMT_323_.tb1_9(18),
10,
'Contrato'
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
'CONTRATO'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(11):=121371455;
RQPMT_323_.tb4_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(11):=RQPMT_323_.tb4_0(11);
RQPMT_323_.old_tb4_1(11):='MO_INITATRIB_CT23E121371455'
;
RQPMT_323_.tb4_1(11):=RQPMT_323_.tb4_0(11);
RQPMT_323_.tb4_2(11):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(11),
RQPMT_323_.tb4_1(11),
RQPMT_323_.tb4_2(11),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_TYPE_ID", "1") = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_TYPE_ID",nuProductType);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductType);,)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:12','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa el tipo de producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(19):=1918;
RQPMT_323_.old_tb1_1(19):=8;
RQPMT_323_.tb1_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(19),-1)));
RQPMT_323_.old_tb1_2(19):=192;
RQPMT_323_.tb1_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(19),-1)));
RQPMT_323_.old_tb1_3(19):=null;
RQPMT_323_.tb1_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(19),-1)));
RQPMT_323_.old_tb1_4(19):=null;
RQPMT_323_.tb1_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(19),-1)));
RQPMT_323_.tb1_6(19):=RQPMT_323_.tb4_0(11);
RQPMT_323_.tb1_9(19):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (19)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(19),
ENTITY_ID=RQPMT_323_.tb1_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(19),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(19),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Tipo de producto'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='TIPO_DE_PRODUCTO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(19);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(19),
RQPMT_323_.tb1_1(19),
RQPMT_323_.tb1_2(19),
RQPMT_323_.tb1_3(19),
RQPMT_323_.tb1_4(19),
null,
RQPMT_323_.tb1_6(19),
null,
null,
RQPMT_323_.tb1_9(19),
11,
'Tipo de producto'
,
11,
'N'
,
'N'
,
'N'
,
'N'
,
'TIPO_DE_PRODUCTO'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(12):=121371456;
RQPMT_323_.tb4_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(12):=RQPMT_323_.tb4_0(12);
RQPMT_323_.old_tb4_1(12):='MO_INITATRIB_CT23E121371456'
;
RQPMT_323_.tb4_1(12):=RQPMT_323_.tb4_0(12);
RQPMT_323_.tb4_2(12):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(12),
RQPMT_323_.tb4_1(12),
RQPMT_323_.tb4_2(12),
'nuCommPlan = PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(323, 108, GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuCommPlan)'
,
'LBTEST'
,
to_date('01-09-2012 08:50:12','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - Plan Comercial - VtaServIng'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(20):=1919;
RQPMT_323_.old_tb1_1(20):=8;
RQPMT_323_.tb1_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(20),-1)));
RQPMT_323_.old_tb1_2(20):=45189;
RQPMT_323_.tb1_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(20),-1)));
RQPMT_323_.old_tb1_3(20):=null;
RQPMT_323_.tb1_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(20),-1)));
RQPMT_323_.old_tb1_4(20):=null;
RQPMT_323_.tb1_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(20),-1)));
RQPMT_323_.tb1_6(20):=RQPMT_323_.tb4_0(12);
RQPMT_323_.tb1_9(20):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (20)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(20),
ENTITY_ID=RQPMT_323_.tb1_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb1_6(20),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(20),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador Plan Comercial'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(20);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(20),
RQPMT_323_.tb1_1(20),
RQPMT_323_.tb1_2(20),
RQPMT_323_.tb1_3(20),
RQPMT_323_.tb1_4(20),
null,
RQPMT_323_.tb1_6(20),
null,
null,
RQPMT_323_.tb1_9(20),
12,
'Identificador Plan Comercial'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(21):=1920;
RQPMT_323_.old_tb1_1(21):=68;
RQPMT_323_.tb1_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(21),-1)));
RQPMT_323_.old_tb1_2(21):=2559;
RQPMT_323_.tb1_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(21),-1)));
RQPMT_323_.old_tb1_3(21):=2826;
RQPMT_323_.tb1_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(21),-1)));
RQPMT_323_.old_tb1_4(21):=null;
RQPMT_323_.tb1_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(21),-1)));
RQPMT_323_.tb1_9(21):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (21)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(21),
ENTITY_ID=RQPMT_323_.tb1_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(21),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Valor Numerico Contrato'
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
TAG_NAME='VALOR_NUMERICO_CONTRATO'
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
ENTITY_NAME='MO_PROCESS'
,
ATTRI_TECHNICAL_NAME='VALUE_2'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(21);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(21),
RQPMT_323_.tb1_1(21),
RQPMT_323_.tb1_2(21),
RQPMT_323_.tb1_3(21),
RQPMT_323_.tb1_4(21),
null,
null,
null,
null,
RQPMT_323_.tb1_9(21),
13,
'Valor Numerico Contrato'
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
'VALOR_NUMERICO_CONTRATO'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(22):=1921;
RQPMT_323_.old_tb1_1(22):=21;
RQPMT_323_.tb1_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(22),-1)));
RQPMT_323_.old_tb1_2(22):=281;
RQPMT_323_.tb1_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(22),-1)));
RQPMT_323_.old_tb1_3(22):=187;
RQPMT_323_.tb1_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(22),-1)));
RQPMT_323_.old_tb1_4(22):=null;
RQPMT_323_.tb1_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(22),-1)));
RQPMT_323_.tb1_9(22):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (22)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(22),
ENTITY_ID=RQPMT_323_.tb1_1(22),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(22),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(22),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(22),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Consecutivo Interno Motivos'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='MOTIVE_ID'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(22);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(22),
RQPMT_323_.tb1_1(22),
RQPMT_323_.tb1_2(22),
RQPMT_323_.tb1_3(22),
RQPMT_323_.tb1_4(22),
null,
null,
null,
null,
RQPMT_323_.tb1_9(22),
14,
'Consecutivo Interno Motivos'
,
14,
'N'
,
'N'
,
'N'
,
'Y'
,
'MOTIVE_ID'
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
'MO_ADDRESS'
,
'MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb1_0(23):=1922;
RQPMT_323_.old_tb1_1(23):=21;
RQPMT_323_.tb1_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb1_1(23),-1)));
RQPMT_323_.old_tb1_2(23):=39322;
RQPMT_323_.tb1_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_2(23),-1)));
RQPMT_323_.old_tb1_3(23):=255;
RQPMT_323_.tb1_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_3(23),-1)));
RQPMT_323_.old_tb1_4(23):=null;
RQPMT_323_.tb1_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb1_4(23),-1)));
RQPMT_323_.tb1_9(23):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (23)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_323_.tb1_0(23),
ENTITY_ID=RQPMT_323_.tb1_1(23),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb1_2(23),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb1_3(23),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb1_4(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_323_.tb1_9(23),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=15,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='PACKAGE_ID'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_323_.tb1_0(23);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb1_0(23),
RQPMT_323_.tb1_1(23),
RQPMT_323_.tb1_2(23),
RQPMT_323_.tb1_3(23),
RQPMT_323_.tb1_4(23),
null,
null,
null,
null,
RQPMT_323_.tb1_9(23),
15,
'Identificador De Solicitud'
,
15,
'N'
,
'N'
,
'N'
,
'Y'
,
'PACKAGE_ID'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb6_0(0):=235;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQPMT_323_.tb6_0(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=25,
NAME_ATTRIBUTE='REQ_GENERAR_CUENTA'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Requiere generar cuenta para la liquidaci¿n de cargos pos-instalaci¿n'
,
DISPLAY_NAME='Requiere generar cuenta para la liquidaci¿n de cargos pos-instalaci¿n'

 WHERE ATTRIBUTE_ID = RQPMT_323_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQPMT_323_.tb6_0(0),
null,
null,
1,
5,
25,
'REQ_GENERAR_CUENTA'
,
null,
null,
null,
null,
null,
'Requiere generar cuenta para la liquidaci¿n de cargos pos-instalaci¿n'
,
'Requiere generar cuenta para la liquidaci¿n de cargos pos-instalaci¿n'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb7_0(0):=RQPMT_323_.tb0_0(0);
RQPMT_323_.tb7_1(0):=RQPMT_323_.tb6_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PROD_MOTI_PARAM fila (0)',1);
INSERT INTO PS_PROD_MOTI_PARAM(PRODUCT_MOTIVE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE) 
VALUES (RQPMT_323_.tb7_0(0),
RQPMT_323_.tb7_1(0),
'Requiere generar cuenta para la liquidaci¿n de cargos pos-instalaci¿n'
,
'N'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb6_0(1):=75000;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQPMT_323_.tb6_0(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=2,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=25,
NAME_ATTRIBUTE='TASK_CLASS_SERVING'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Clases de Trabajo - Servicios de Ingenier¿a'
,
DISPLAY_NAME='Clases de Trabajo - Servicios de Ingenier¿a'

 WHERE ATTRIBUTE_ID = RQPMT_323_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQPMT_323_.tb6_0(1),
null,
null,
2,
5,
25,
'TASK_CLASS_SERVING'
,
null,
null,
null,
null,
null,
'Clases de Trabajo - Servicios de Ingenier¿a'
,
'Clases de Trabajo - Servicios de Ingenier¿a'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb7_0(1):=RQPMT_323_.tb0_0(0);
RQPMT_323_.tb7_1(1):=RQPMT_323_.tb6_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PROD_MOTI_PARAM fila (1)',1);
INSERT INTO PS_PROD_MOTI_PARAM(PRODUCT_MOTIVE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE) 
VALUES (RQPMT_323_.tb7_0(1),
RQPMT_323_.tb7_1(1),
'Clases de Trabajo - Servicios de Ingenier¿a'
,
'150,151,155'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb8_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQPMT_323_.tb8_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb9_0(0):=6260;
RQPMT_323_.tb9_1(0):=RQPMT_323_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (0)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=RQPMT_323_.tb9_0(0),
SERVICE_TYPE_ID=RQPMT_323_.tb9_1(0),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Gen¿rico'
,
ACCEPT_IF_PROJECTED='Y'
,
ASSIGNABLE='Y'
,
TAG_NAME='GENERICO'
,
ELEMENT_DAYS_WAIT=0,
IS_AUTOMATIC_ASSIGN='Y'
,
SUSPEND_ALLOWED='Y'
,
IS_DEPENDENT='N'
,
VALIDATE_RETIRE='Y'
,
IS_MEASURABLE=null,
IS_MOVEABLE='Y'
,
ELEMENT_TYPE_ID=null,
COMPONEN_BY_QUANTITY='N'
,
PRODUCT_REFERENCE=null,
AUTOMATIC_ACTIVATION='N'
,
CONCEPT_ID=null,
SALE_CONCEPT_ID=null,
ALLOW_CLASS_CHANGE='N'

 WHERE COMPONENT_TYPE_ID = RQPMT_323_.tb9_0(0);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (RQPMT_323_.tb9_0(0),
RQPMT_323_.tb9_1(0),
null,
'Gen¿rico'
,
'Y'
,
'Y'
,
'GENERICO'
,
0,
'Y'
,
'Y'
,
'N'
,
'Y'
,
null,
'Y'
,
null,
'N'
,
null,
'N'
,
null,
null,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb10_0(0):=90;
RQPMT_323_.tb10_1(0):=RQPMT_323_.tb0_0(0);
RQPMT_323_.tb10_4(0):=RQPMT_323_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTIVE_COMP fila (0)',1);
UPDATE PS_PROD_MOTIVE_COMP SET PROD_MOTIVE_COMP_ID=RQPMT_323_.tb10_0(0),
PRODUCT_MOTIVE_ID=RQPMT_323_.tb10_1(0),
PARENT_COMP=null,
SERVICE_COMPONENT=959,
COMPONENT_TYPE_ID=RQPMT_323_.tb10_4(0),
MOTIVE_TYPE_ID=108,
TAG_NAME='C_GENERICO_90'
,
ASSIGN_ORDER=3,
MIN_COMPONENTS=1,
MAX_COMPONENTS=1,
IS_OPTIONAL='N'
,
DESCRIPTION='Gen¿rico'
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

 WHERE PROD_MOTIVE_COMP_ID = RQPMT_323_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTIVE_COMP(PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,SERVICE_COMPONENT,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN) 
VALUES (RQPMT_323_.tb10_0(0),
RQPMT_323_.tb10_1(0),
null,
959,
RQPMT_323_.tb10_4(0),
108,
'C_GENERICO_90'
,
3,
1,
1,
'N'
,
'Gen¿rico'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb11_0(0):=38;
RQPMT_323_.tb11_1(0):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMPON_EVENT fila (0)',1);
UPDATE PS_MOTI_COMPON_EVENT SET MOTI_COMPON_EVENT_ID=RQPMT_323_.tb11_0(0),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb11_1(0),
EVENT_ID=1
 WHERE MOTI_COMPON_EVENT_ID = RQPMT_323_.tb11_0(0);
if not (sql%found) then
INSERT INTO PS_MOTI_COMPON_EVENT(MOTI_COMPON_EVENT_ID,PROD_MOTIVE_COMP_ID,EVENT_ID) 
VALUES (RQPMT_323_.tb11_0(0),
RQPMT_323_.tb11_1(0),
1);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb3_0(3):=65;
RQPMT_323_.tb3_1(3):=RQPMT_323_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_323_.tb3_0(3),
MODULE_ID=RQPMT_323_.tb3_1(3),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_323_.tb3_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_323_.tb3_0(3),
RQPMT_323_.tb3_1(3),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(13):=121371457;
RQPMT_323_.tb4_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(13):=RQPMT_323_.tb4_0(13);
RQPMT_323_.old_tb4_1(13):='MO_EVE_COMP_CT65E121371457'
;
RQPMT_323_.tb4_1(13):=RQPMT_323_.tb4_0(13);
RQPMT_323_.tb4_2(13):=RQPMT_323_.tb3_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(13),
RQPMT_323_.tb4_1(13),
RQPMT_323_.tb4_2(13),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"MO_COMPONENT","COMPONENT_ID_PROD",sbComponentId);if (UT_CONVERT.FBLISSTRINGNULL(sbComponentId) = GE_BOCONSTANTS.GETFALSE(),MO_BOCNFLOADPRODUCTDATA.LOADONECOMPONENT(GE_BOCONSTANTS.GETFALSE());,)'
,
'LBTEST'
,
to_date('01-09-2012 09:06:13','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Carga datos del componente en la instancia'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb12_0(0):=58;
RQPMT_323_.tb12_1(0):=RQPMT_323_.tb11_0(0);
RQPMT_323_.tb12_2(0):=RQPMT_323_.tb4_0(13);
ut_trace.trace('insertando tabla: PS_WHEN_MOTI_COMPON fila (0)',1);
INSERT INTO PS_WHEN_MOTI_COMPON(WHEN_MOTI_COMPON_ID,MOTI_COMPON_EVENT_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_323_.tb12_0(0),
RQPMT_323_.tb12_1(0),
RQPMT_323_.tb12_2(0),
'AF'
,
'Y'
);

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(14):=121371458;
RQPMT_323_.tb4_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(14):=RQPMT_323_.tb4_0(14);
RQPMT_323_.old_tb4_1(14):='MO_VALIDATTR_CT26E121371458'
;
RQPMT_323_.tb4_1(14):=RQPMT_323_.tb4_0(14);
RQPMT_323_.tb4_2(14):=RQPMT_323_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(14),
RQPMT_323_.tb4_1(14),
RQPMT_323_.tb4_2(14),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuAlternativa);if (nuAlternativa <> null,DAPS_CLASS_SERVICE.ACCKEY(nuAlternativa);,)'
,
'LBTEST'
,
to_date('01-09-2012 08:57:50','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MO_COMPONENT - CLASS_SERVICE_ID - Valida la existencia de la alternativa'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb5_0(2):=120188095;
RQPMT_323_.tb5_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_323_.tb5_0(2):=RQPMT_323_.tb5_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_323_.tb5_0(2),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(0):=972;
RQPMT_323_.old_tb13_1(0):=43;
RQPMT_323_.tb13_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(0),-1)));
RQPMT_323_.old_tb13_2(0):=1801;
RQPMT_323_.tb13_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(0),-1)));
RQPMT_323_.old_tb13_3(0):=null;
RQPMT_323_.tb13_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(0),-1)));
RQPMT_323_.old_tb13_4(0):=null;
RQPMT_323_.tb13_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(0),-1)));
RQPMT_323_.tb13_5(0):=RQPMT_323_.tb10_0(0);
RQPMT_323_.tb13_7(0):=RQPMT_323_.tb4_0(14);
RQPMT_323_.tb13_9(0):=RQPMT_323_.tb5_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (0)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(0),
ENTITY_ID=RQPMT_323_.tb13_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(0),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(0),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=RQPMT_323_.tb13_7(0),
INIT_EXPRESSION_ID=null,
STATEMENT_ID=RQPMT_323_.tb13_9(0),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Alternativa'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(0),
RQPMT_323_.tb13_1(0),
RQPMT_323_.tb13_2(0),
RQPMT_323_.tb13_3(0),
RQPMT_323_.tb13_4(0),
RQPMT_323_.tb13_5(0),
null,
RQPMT_323_.tb13_7(0),
null,
RQPMT_323_.tb13_9(0),
0,
'Alternativa'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(15):=121371459;
RQPMT_323_.tb4_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(15):=RQPMT_323_.tb4_0(15);
RQPMT_323_.old_tb4_1(15):='MO_INITATRIB_CT23E121371459'
;
RQPMT_323_.tb4_1(15):=RQPMT_323_.tb4_0(15);
RQPMT_323_.tb4_2(15):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(15),
RQPMT_323_.tb4_1(15),
RQPMT_323_.tb4_2(15),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETCOMPONENTID())'
,
'LBTEST'
,
to_date('01-09-2012 08:57:51','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(1):=973;
RQPMT_323_.old_tb13_1(1):=43;
RQPMT_323_.tb13_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(1),-1)));
RQPMT_323_.old_tb13_2(1):=338;
RQPMT_323_.tb13_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(1),-1)));
RQPMT_323_.old_tb13_3(1):=null;
RQPMT_323_.tb13_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(1),-1)));
RQPMT_323_.old_tb13_4(1):=null;
RQPMT_323_.tb13_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(1),-1)));
RQPMT_323_.tb13_5(1):=RQPMT_323_.tb10_0(0);
RQPMT_323_.tb13_8(1):=RQPMT_323_.tb4_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (1)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(1),
ENTITY_ID=RQPMT_323_.tb13_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(1),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(1),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb13_8(1),
STATEMENT_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Identificador del Componente Registro Componente'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(1);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(1),
RQPMT_323_.tb13_1(1),
RQPMT_323_.tb13_2(1),
RQPMT_323_.tb13_3(1),
RQPMT_323_.tb13_4(1),
RQPMT_323_.tb13_5(1),
null,
null,
RQPMT_323_.tb13_8(1),
null,
1,
'Identificador del Componente Registro Componente'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(2):=974;
RQPMT_323_.old_tb13_1(2):=43;
RQPMT_323_.tb13_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(2),-1)));
RQPMT_323_.old_tb13_2(2):=456;
RQPMT_323_.tb13_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(2),-1)));
RQPMT_323_.old_tb13_3(2):=187;
RQPMT_323_.tb13_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(2),-1)));
RQPMT_323_.old_tb13_4(2):=null;
RQPMT_323_.tb13_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(2),-1)));
RQPMT_323_.tb13_5(2):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (2)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(2),
ENTITY_ID=RQPMT_323_.tb13_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(2),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(2),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Identificador del Motivo Registro Componente'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(2);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(2),
RQPMT_323_.tb13_1(2),
RQPMT_323_.tb13_2(2),
RQPMT_323_.tb13_3(2),
RQPMT_323_.tb13_4(2),
RQPMT_323_.tb13_5(2),
null,
null,
null,
null,
2,
'Identificador del Motivo Registro Componente'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(3):=975;
RQPMT_323_.old_tb13_1(3):=43;
RQPMT_323_.tb13_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(3),-1)));
RQPMT_323_.old_tb13_2(3):=696;
RQPMT_323_.tb13_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(3),-1)));
RQPMT_323_.old_tb13_3(3):=697;
RQPMT_323_.tb13_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(3),-1)));
RQPMT_323_.old_tb13_4(3):=null;
RQPMT_323_.tb13_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(3),-1)));
RQPMT_323_.tb13_5(3):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (3)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(3),
ENTITY_ID=RQPMT_323_.tb13_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(3),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(3),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Identificador del Producto Motivo'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(3);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(3),
RQPMT_323_.tb13_1(3),
RQPMT_323_.tb13_2(3),
RQPMT_323_.tb13_3(3),
RQPMT_323_.tb13_4(3),
RQPMT_323_.tb13_5(3),
null,
null,
null,
null,
3,
'Identificador del Producto Motivo'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(4):=976;
RQPMT_323_.old_tb13_1(4):=43;
RQPMT_323_.tb13_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(4),-1)));
RQPMT_323_.old_tb13_2(4):=1026;
RQPMT_323_.tb13_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(4),-1)));
RQPMT_323_.old_tb13_3(4):=null;
RQPMT_323_.tb13_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(4),-1)));
RQPMT_323_.old_tb13_4(4):=null;
RQPMT_323_.tb13_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(4),-1)));
RQPMT_323_.tb13_5(4):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (4)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(4),
ENTITY_ID=RQPMT_323_.tb13_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(4),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(4),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Fecha de inicio del servicio'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(4);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(4),
RQPMT_323_.tb13_1(4),
RQPMT_323_.tb13_2(4),
RQPMT_323_.tb13_3(4),
RQPMT_323_.tb13_4(4),
RQPMT_323_.tb13_5(4),
null,
null,
null,
null,
4,
'Fecha de inicio del servicio'
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(5):=977;
RQPMT_323_.old_tb13_1(5):=43;
RQPMT_323_.tb13_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(5),-1)));
RQPMT_323_.old_tb13_2(5):=50000937;
RQPMT_323_.tb13_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(5),-1)));
RQPMT_323_.old_tb13_3(5):=213;
RQPMT_323_.tb13_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(5),-1)));
RQPMT_323_.old_tb13_4(5):=null;
RQPMT_323_.tb13_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(5),-1)));
RQPMT_323_.tb13_5(5):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (5)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(5),
ENTITY_ID=RQPMT_323_.tb13_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(5),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(5),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='PACKAGE_ID'
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
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(5);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(5),
RQPMT_323_.tb13_1(5),
RQPMT_323_.tb13_2(5),
RQPMT_323_.tb13_3(5),
RQPMT_323_.tb13_4(5),
RQPMT_323_.tb13_5(5),
null,
null,
null,
null,
5,
'PACKAGE_ID'
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
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(16):=121371460;
RQPMT_323_.tb4_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(16):=RQPMT_323_.tb4_0(16);
RQPMT_323_.old_tb4_1(16):='MO_INITATRIB_CT23E121371460'
;
RQPMT_323_.tb4_1(16):=RQPMT_323_.tb4_0(16);
RQPMT_323_.tb4_2(16):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(16),
RQPMT_323_.tb4_1(16),
RQPMT_323_.tb4_2(16),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", "1") = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);nuComponentId = PR_BCPRODUCT.FNUGETMAINCOMPONENTID(nuProductId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuComponentId);nuComponentType = PR_BOCOMPONENT.GETCOMPONENTTYPE(nuComponentId);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,NULL,"MO_COMPONENT","COMPONENT_TYPE_ID",nuComponentType);,)'
,
'LBTEST'
,
to_date('01-09-2012 08:57:51','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - Idnetificador del Componente de producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(6):=978;
RQPMT_323_.old_tb13_1(6):=43;
RQPMT_323_.tb13_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(6),-1)));
RQPMT_323_.old_tb13_2(6):=8064;
RQPMT_323_.tb13_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(6),-1)));
RQPMT_323_.old_tb13_3(6):=null;
RQPMT_323_.tb13_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(6),-1)));
RQPMT_323_.old_tb13_4(6):=null;
RQPMT_323_.tb13_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(6),-1)));
RQPMT_323_.tb13_5(6):=RQPMT_323_.tb10_0(0);
RQPMT_323_.tb13_8(6):=RQPMT_323_.tb4_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (6)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(6),
ENTITY_ID=RQPMT_323_.tb13_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(6),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(6),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb13_8(6),
STATEMENT_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Id Del Componente Del Producto'
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
TAG_NAME='ID_DEL_COMPONENTE_DEL_PRODUCTO'
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
ATTRI_TECHNICAL_NAME='COMPONENT_ID_PROD'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(6);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(6),
RQPMT_323_.tb13_1(6),
RQPMT_323_.tb13_2(6),
RQPMT_323_.tb13_3(6),
RQPMT_323_.tb13_4(6),
RQPMT_323_.tb13_5(6),
null,
null,
RQPMT_323_.tb13_8(6),
null,
6,
'Id Del Componente Del Producto'
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
'ID_DEL_COMPONENTE_DEL_PRODUCTO'
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
'COMPONENT_ID_PROD'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(17):=121371461;
RQPMT_323_.tb4_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(17):=RQPMT_323_.tb4_0(17);
RQPMT_323_.old_tb4_1(17):='MO_INITATRIB_CT23E121371461'
;
RQPMT_323_.tb4_1(17):=RQPMT_323_.tb4_0(17);
RQPMT_323_.tb4_2(17):=RQPMT_323_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(17),
RQPMT_323_.tb4_1(17),
RQPMT_323_.tb4_2(17),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", "1") = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductId);,)'
,
'LBTEST'
,
to_date('01-09-2012 08:57:52','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:09','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa el identificador del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(7):=979;
RQPMT_323_.old_tb13_1(7):=43;
RQPMT_323_.tb13_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(7),-1)));
RQPMT_323_.old_tb13_2(7):=50000936;
RQPMT_323_.tb13_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(7),-1)));
RQPMT_323_.old_tb13_3(7):=413;
RQPMT_323_.tb13_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(7),-1)));
RQPMT_323_.old_tb13_4(7):=null;
RQPMT_323_.tb13_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(7),-1)));
RQPMT_323_.tb13_5(7):=RQPMT_323_.tb10_0(0);
RQPMT_323_.tb13_8(7):=RQPMT_323_.tb4_0(17);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (7)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(7),
ENTITY_ID=RQPMT_323_.tb13_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(7),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(7),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_323_.tb13_8(7),
STATEMENT_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='PRODUCT_ID'
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
TAG_NAME='PRODUCT_ID'
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
ATTRI_TECHNICAL_NAME='PRODUCT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(7);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(7),
RQPMT_323_.tb13_1(7),
RQPMT_323_.tb13_2(7),
RQPMT_323_.tb13_3(7),
RQPMT_323_.tb13_4(7),
RQPMT_323_.tb13_5(7),
null,
null,
RQPMT_323_.tb13_8(7),
null,
7,
'PRODUCT_ID'
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
'PRODUCT_ID'
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
'PRODUCT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(8):=980;
RQPMT_323_.old_tb13_1(8):=43;
RQPMT_323_.tb13_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(8),-1)));
RQPMT_323_.old_tb13_2(8):=4013;
RQPMT_323_.tb13_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(8),-1)));
RQPMT_323_.old_tb13_3(8):=null;
RQPMT_323_.tb13_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(8),-1)));
RQPMT_323_.old_tb13_4(8):=null;
RQPMT_323_.tb13_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(8),-1)));
RQPMT_323_.tb13_5(8):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (8)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(8),
ENTITY_ID=RQPMT_323_.tb13_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(8),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(8),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='SERVICE_NUMBER'
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
ATTRI_TECHNICAL_NAME='SERVICE_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(8);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(8),
RQPMT_323_.tb13_1(8),
RQPMT_323_.tb13_2(8),
RQPMT_323_.tb13_3(8),
RQPMT_323_.tb13_4(8),
RQPMT_323_.tb13_5(8),
null,
null,
null,
null,
8,
'SERVICE_NUMBER'
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
'SERVICE_NUMBER'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(9):=981;
RQPMT_323_.old_tb13_1(9):=43;
RQPMT_323_.tb13_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(9),-1)));
RQPMT_323_.old_tb13_2(9):=362;
RQPMT_323_.tb13_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(9),-1)));
RQPMT_323_.old_tb13_3(9):=null;
RQPMT_323_.tb13_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(9),-1)));
RQPMT_323_.old_tb13_4(9):=null;
RQPMT_323_.tb13_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(9),-1)));
RQPMT_323_.tb13_5(9):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (9)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(9),
ENTITY_ID=RQPMT_323_.tb13_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(9),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(9),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='MOTIVE_TYPE_ID'
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
ATTRI_TECHNICAL_NAME='MOTIVE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(9);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(9),
RQPMT_323_.tb13_1(9),
RQPMT_323_.tb13_2(9),
RQPMT_323_.tb13_3(9),
RQPMT_323_.tb13_4(9),
RQPMT_323_.tb13_5(9),
null,
null,
null,
null,
9,
'MOTIVE_TYPE_ID'
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
'MOTIVE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(10):=982;
RQPMT_323_.old_tb13_1(10):=43;
RQPMT_323_.tb13_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(10),-1)));
RQPMT_323_.old_tb13_2(10):=361;
RQPMT_323_.tb13_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(10),-1)));
RQPMT_323_.old_tb13_3(10):=null;
RQPMT_323_.tb13_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(10),-1)));
RQPMT_323_.old_tb13_4(10):=null;
RQPMT_323_.tb13_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(10),-1)));
RQPMT_323_.tb13_5(10):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (10)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(10),
ENTITY_ID=RQPMT_323_.tb13_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(10),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(10),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='COMPONENT_TYPE_ID'
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
ATTRI_TECHNICAL_NAME='COMPONENT_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(10);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(10),
RQPMT_323_.tb13_1(10),
RQPMT_323_.tb13_2(10),
RQPMT_323_.tb13_3(10),
RQPMT_323_.tb13_4(10),
RQPMT_323_.tb13_5(10),
null,
null,
null,
null,
10,
'COMPONENT_TYPE_ID'
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
'COMPONENT_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb13_0(11):=983;
RQPMT_323_.old_tb13_1(11):=43;
RQPMT_323_.tb13_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_323_.TBENTITYNAME(NVL(RQPMT_323_.old_tb13_1(11),-1)));
RQPMT_323_.old_tb13_2(11):=355;
RQPMT_323_.tb13_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_2(11),-1)));
RQPMT_323_.old_tb13_3(11):=null;
RQPMT_323_.tb13_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_3(11),-1)));
RQPMT_323_.old_tb13_4(11):=null;
RQPMT_323_.tb13_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_323_.TBENTITYATTRIBUTENAME(NVL(RQPMT_323_.old_tb13_4(11),-1)));
RQPMT_323_.tb13_5(11):=RQPMT_323_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (11)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_323_.tb13_0(11),
ENTITY_ID=RQPMT_323_.tb13_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_323_.tb13_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_323_.tb13_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_323_.tb13_4(11),
PROD_MOTIVE_COMP_ID=RQPMT_323_.tb13_5(11),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='DISTRICT_ID'
,
DISPLAY_ORDER=11,
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_323_.tb13_0(11);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_323_.tb13_0(11),
RQPMT_323_.tb13_1(11),
RQPMT_323_.tb13_2(11),
RQPMT_323_.tb13_3(11),
RQPMT_323_.tb13_4(11),
RQPMT_323_.tb13_5(11),
null,
null,
null,
null,
11,
'DISTRICT_ID'
,
11,
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
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb14_0(0):=27;
RQPMT_323_.tb14_1(0):=RQPMT_323_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_EVENTS fila (0)',1);
UPDATE PS_PROD_MOTI_EVENTS SET PROD_MOTI_EVENTS_ID=RQPMT_323_.tb14_0(0),
PRODUCT_MOTIVE_ID=RQPMT_323_.tb14_1(0),
EVENT_ID=1
 WHERE PROD_MOTI_EVENTS_ID = RQPMT_323_.tb14_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_EVENTS(PROD_MOTI_EVENTS_ID,PRODUCT_MOTIVE_ID,EVENT_ID) 
VALUES (RQPMT_323_.tb14_0(0),
RQPMT_323_.tb14_1(0),
1);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(18):=121371462;
RQPMT_323_.tb4_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(18):=RQPMT_323_.tb4_0(18);
RQPMT_323_.old_tb4_1(18):='MO_EVE_COMP_CT65E121371462'
;
RQPMT_323_.tb4_1(18):=RQPMT_323_.tb4_0(18);
RQPMT_323_.tb4_2(18):=RQPMT_323_.tb3_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(18),
RQPMT_323_.tb4_1(18),
RQPMT_323_.tb4_2(18),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETFATHERINSTANCE(sbInstancia,sbInstanciaPaquete);nuModalidadFinTrabajos = 2;nuModalidadSinContizacion = 4;GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_DATA_FOR_ORDER","ITEM_ID",sbIdActividad);nuModalidadPago = PS_BOENGINEERINGACTIV.FSBGETMODALITYBYITEM(sbIdActividad);if (nuModalidadPago = nuModalidadFinTrabajos || nuModalidadPago = nuModalidadSinContizacion,GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstanciaPaquete,null,"MO_PACKAGES","RECURRENT_BILLING","N");,);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","VALUE_2",sbContrato);UT_STRING.FINDPARAMETERVALUE(sbContrato,"SUBSCRIPTION_ID","|","=",nuIdContrato);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia,null,"MO_MOTIVE","SUBSCRIPTION_ID",nuIdContrato,true);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia,null,"LDC_TIPO_VIVIENDA_CONT","CONTRATO",nuIdContrato,true)'
,
'LBTEST'
,
to_date('01-09-2012 09:00:19','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:10','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:10','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'EVE-POST-MOT- Venta Constructoras'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb15_0(0):=38;
RQPMT_323_.tb15_1(0):=RQPMT_323_.tb14_0(0);
RQPMT_323_.tb15_2(0):=RQPMT_323_.tb4_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (0)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_323_.tb15_0(0),
PROD_MOTI_EVENTS_ID=RQPMT_323_.tb15_1(0),
CONFIG_EXPRESSION_ID=RQPMT_323_.tb15_2(0),
EXECUTING_TIME='AF'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_323_.tb15_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_323_.tb15_0(0),
RQPMT_323_.tb15_1(0),
RQPMT_323_.tb15_2(0),
'AF'
,
'Y'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.old_tb4_0(19):=121371463;
RQPMT_323_.tb4_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_323_.tb4_0(19):=RQPMT_323_.tb4_0(19);
RQPMT_323_.old_tb4_1(19):='MO_EVE_COMP_CT65E121371463'
;
RQPMT_323_.tb4_1(19):=RQPMT_323_.tb4_0(19);
RQPMT_323_.tb4_2(19):=RQPMT_323_.tb3_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_323_.tb4_0(19),
RQPMT_323_.tb4_1(19),
RQPMT_323_.tb4_2(19),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETFATHERINSTANCE(sbInstance,sbFatherInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", "1") = TRUE,GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_DATA_FOR_ORDER","ITEM_ID",nuItem);boSolicitud = MO_BODATA_FOR_ORDER.FBOEXISTACTIVITYBYPROD(nuIdProd, "P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101", nuItem);if (boSolicitud = TRUE,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El producto ya cuenta con una solicitud de venta de servicios de ingenier¿a con ese tipo de actividad");,);,);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"MO_PROCESS","ADDRESS_MAIN_MOTIVE",sbAddressId);nuAddressId = UT_CONVERT.FNUCHARTONUMBER(sbAddressId);CF_BOREGISTERRULESCRM.LOADADDRESS(sbInstance,sbAddressId)'
,
'LBTEST'
,
to_date('01-09-2012 11:45:38','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:10','DD-MM-YYYY HH24:MI:SS'),
to_date('09-03-2021 20:02:10','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'PRE - Valida solicitudes con la misma actividad'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;

RQPMT_323_.tb15_0(1):=39;
RQPMT_323_.tb15_1(1):=RQPMT_323_.tb14_0(0);
RQPMT_323_.tb15_2(1):=RQPMT_323_.tb4_0(19);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (1)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_323_.tb15_0(1),
PROD_MOTI_EVENTS_ID=RQPMT_323_.tb15_1(1),
CONFIG_EXPRESSION_ID=RQPMT_323_.tb15_2(1),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_323_.tb15_0(1);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_323_.tb15_0(1),
RQPMT_323_.tb15_1(1),
RQPMT_323_.tb15_2(1),
'B'
,
'Y'
);
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
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

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(323, sbSuccess);
FOR rc in RQPMT_323_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_323_.blProcessStatus := false;
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
nuIndex := RQPMT_323_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_323_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_323_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_323_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_323_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_323_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_323_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_323_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_323_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_323_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_323_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_323_.blProcessStatus := false;
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
 nuIndex := RQPMT_323_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_323_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_323_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_323_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_323_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_323_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_323_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_323_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_323_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_323_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_323_',
'CREATE OR REPLACE PACKAGE RQCFG_323_ IS ' || chr(10) ||
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
'AND     external_root_id = 323 ' || chr(10) ||
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
'END RQCFG_323_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_323_******************************'); END;
/

BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_323_.cuCompositions;
fetch RQCFG_323_.cuCompositions bulk collect INTO RQCFG_323_.tbCompositions;
close RQCFG_323_.cuCompositions;

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_323_.tbEntityName(-1) := 'NULL';
   RQCFG_323_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_323_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_323_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_323_.tbEntityName(2014) := 'PS_PROD_MOTIVE_COMP';
   RQCFG_323_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_323_.tbEntityName(2042) := 'PS_MOTI_COMP_ATTRIBS';
   RQCFG_323_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_323_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_323_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_323_.tbEntityAttributeName(2875) := 'MO_DATA_FOR_ORDER@DATA_FOR_ORDER_ID';
   RQCFG_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_323_.tbEntityAttributeName(2877) := 'MO_DATA_FOR_ORDER@MOTIVE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_323_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_323_.tbEntityAttributeName(44501) := 'MO_DATA_FOR_ORDER@ITEM_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(191044) := 'MO_PACKAGES@RECURRENT_BILLING';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151600) := 'LDC_TIPO_VIVIENDA_CONT@CONTRATO';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151601) := 'LDC_TIPO_VIVIENDA_CONT@TIPO_VIVIENDA';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151602) := 'LDC_TIPO_VIVIENDA_CONT@FECHA_REGISTRO';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151603) := 'LDC_TIPO_VIVIENDA_CONT@SOLICITUD';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167564) := 'LD_PACKAGE_PERSON@PACKAGE_PERSON_ID';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167565) := 'LD_PACKAGE_PERSON@OPER_UNIT_INST';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167566) := 'LD_PACKAGE_PERSON@OPER_UNIT_CERT';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167567) := 'LD_PACKAGE_PERSON@PERSON_ID';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167568) := 'LD_PACKAGE_PERSON@PACKAGE_ID';
   RQCFG_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQCFG_323_.tbEntityAttributeName(90168710) := 'LDC_PACKAGE_CODE_DESIGN@PACKAGE_ID';
   RQCFG_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQCFG_323_.tbEntityAttributeName(90168711) := 'LDC_PACKAGE_CODE_DESIGN@COD_DESIGN';
   RQCFG_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQCFG_323_.tbEntityAttributeName(90188539) := 'LDC_PORTAL_VENTA@PACKAGE_ID';
   RQCFG_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQCFG_323_.tbEntityAttributeName(90188540) := 'LDC_PORTAL_VENTA@FLAG_PORTALVENTA';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQCFG_323_.tbEntityAttributeName(90168711) := 'LDC_PACKAGE_CODE_DESIGN@COD_DESIGN';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167568) := 'LD_PACKAGE_PERSON@PACKAGE_ID';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167565) := 'LD_PACKAGE_PERSON@OPER_UNIT_INST';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151603) := 'LDC_TIPO_VIVIENDA_CONT@SOLICITUD';
   RQCFG_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_323_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQCFG_323_.tbEntityAttributeName(90188539) := 'LDC_PORTAL_VENTA@PACKAGE_ID';
   RQCFG_323_.tbEntityName(5032) := 'LDC_PACKAGE_CODE_DESIGN';
   RQCFG_323_.tbEntityAttributeName(90168710) := 'LDC_PACKAGE_CODE_DESIGN@PACKAGE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151602) := 'LDC_TIPO_VIVIENDA_CONT@FECHA_REGISTRO';
   RQCFG_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_323_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167564) := 'LD_PACKAGE_PERSON@PACKAGE_PERSON_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(191044) := 'MO_PACKAGES@RECURRENT_BILLING';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151601) := 'LDC_TIPO_VIVIENDA_CONT@TIPO_VIVIENDA';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167567) := 'LD_PACKAGE_PERSON@PERSON_ID';
   RQCFG_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_323_.tbEntityAttributeName(44501) := 'MO_DATA_FOR_ORDER@ITEM_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQCFG_323_.tbEntityName(5766) := 'LDC_PORTAL_VENTA';
   RQCFG_323_.tbEntityAttributeName(90188540) := 'LDC_PORTAL_VENTA@FLAG_PORTALVENTA';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_323_.tbEntityName(4957) := 'LD_PACKAGE_PERSON';
   RQCFG_323_.tbEntityAttributeName(90167566) := 'LD_PACKAGE_PERSON@OPER_UNIT_CERT';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_323_.tbEntityAttributeName(2877) := 'MO_DATA_FOR_ORDER@MOTIVE_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_323_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_323_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_323_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_323_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_323_.tbEntityName(4396) := 'LDC_TIPO_VIVIENDA_CONT';
   RQCFG_323_.tbEntityAttributeName(90151600) := 'LDC_TIPO_VIVIENDA_CONT@CONTRATO';
   RQCFG_323_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_323_.tbEntityAttributeName(2875) := 'MO_DATA_FOR_ORDER@DATA_FOR_ORDER_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_323_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_323_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_323_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_323_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_323_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_323_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
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
AND     external_root_id = 323
)
);
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_323_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 323, 4);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_323_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_323_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_323_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_323_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_323_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323))));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323)));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 323, 4);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_323_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323))));
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323))));
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323))));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323)));

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_323_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_323_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_323_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_323_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_323_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_323_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323));
nuIndex binary_integer;
BEGIN

if (not RQCFG_323_.blProcessStatus) then
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 323;

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb0_0(0):=9073;
RQCFG_323_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_323_.tb0_0(0):=RQCFG_323_.tb0_0(0);
RQCFG_323_.old_tb0_2(0):=2012;
RQCFG_323_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_323_.tb0_0(0),
323,
RQCFG_323_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb1_0(0):=1069802;
RQCFG_323_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_323_.tb1_0(0):=RQCFG_323_.tb1_0(0);
RQCFG_323_.old_tb1_1(0):=323;
RQCFG_323_.tb1_1(0):=RQCFG_323_.old_tb1_1(0);
RQCFG_323_.old_tb1_2(0):=2012;
RQCFG_323_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb1_2(0),-1)));
RQCFG_323_.old_tb1_3(0):=9073;
RQCFG_323_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb1_2(0),-1))), RQCFG_323_.old_tb1_1(0), 4);
RQCFG_323_.tb1_3(0):=RQCFG_323_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_323_.tb1_0(0),
RQCFG_323_.tb1_1(0),
RQCFG_323_.tb1_2(0),
RQCFG_323_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb2_0(0):=100026834;
RQCFG_323_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_323_.tb2_0(0):=RQCFG_323_.tb2_0(0);
RQCFG_323_.tb2_1(0):=RQCFG_323_.tb0_0(0);
RQCFG_323_.tb2_2(0):=RQCFG_323_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_323_.tb2_0(0),
RQCFG_323_.tb2_1(0),
RQCFG_323_.tb2_2(0),
null,
6121,
1,
1,
1);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb1_0(1):=1069803;
RQCFG_323_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_323_.tb1_0(1):=RQCFG_323_.tb1_0(1);
RQCFG_323_.old_tb1_1(1):=114;
RQCFG_323_.tb1_1(1):=RQCFG_323_.old_tb1_1(1);
RQCFG_323_.old_tb1_2(1):=2013;
RQCFG_323_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb1_2(1),-1)));
RQCFG_323_.old_tb1_3(1):=null;
RQCFG_323_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb1_2(1),-1))), RQCFG_323_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_323_.tb1_0(1),
RQCFG_323_.tb1_1(1),
RQCFG_323_.tb1_2(1),
RQCFG_323_.tb1_3(1),
null,
'M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
,
1,
1,
4);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb2_0(1):=100026835;
RQCFG_323_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_323_.tb2_0(1):=RQCFG_323_.tb2_0(1);
RQCFG_323_.tb2_1(1):=RQCFG_323_.tb0_0(0);
RQCFG_323_.tb2_2(1):=RQCFG_323_.tb1_0(1);
RQCFG_323_.tb2_3(1):=RQCFG_323_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_323_.tb2_0(1),
RQCFG_323_.tb2_1(1),
RQCFG_323_.tb2_2(1),
RQCFG_323_.tb2_3(1),
6121,
2,
1,
1);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb1_0(2):=1069804;
RQCFG_323_.tb1_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_323_.tb1_0(2):=RQCFG_323_.tb1_0(2);
RQCFG_323_.old_tb1_1(2):=90;
RQCFG_323_.tb1_1(2):=RQCFG_323_.old_tb1_1(2);
RQCFG_323_.old_tb1_2(2):=2014;
RQCFG_323_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb1_2(2),-1)));
RQCFG_323_.old_tb1_3(2):=null;
RQCFG_323_.tb1_3(2):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb1_2(2),-1))), RQCFG_323_.old_tb1_1(2), 4);
RQCFG_323_.tb1_4(2):=RQCFG_323_.tb1_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_323_.tb1_0(2),
RQCFG_323_.tb1_1(2),
RQCFG_323_.tb1_2(2),
RQCFG_323_.tb1_3(2),
RQCFG_323_.tb1_4(2),
'C_GENERICO_90'
,
1,
1,
4);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb2_0(2):=100026836;
RQCFG_323_.tb2_0(2):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_323_.tb2_0(2):=RQCFG_323_.tb2_0(2);
RQCFG_323_.tb2_1(2):=RQCFG_323_.tb0_0(0);
RQCFG_323_.tb2_2(2):=RQCFG_323_.tb1_0(2);
RQCFG_323_.tb2_3(2):=RQCFG_323_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (2)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_323_.tb2_0(2),
RQCFG_323_.tb2_1(2),
RQCFG_323_.tb2_2(2),
RQCFG_323_.tb2_3(2),
6121,
3,
1,
1);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(0):=1159046;
RQCFG_323_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(0):=RQCFG_323_.tb3_0(0);
RQCFG_323_.old_tb3_1(0):=2042;
RQCFG_323_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(0),-1)));
RQCFG_323_.old_tb3_2(0):=1801;
RQCFG_323_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(0),-1)));
RQCFG_323_.old_tb3_3(0):=null;
RQCFG_323_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(0),-1)));
RQCFG_323_.old_tb3_4(0):=null;
RQCFG_323_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(0),-1)));
RQCFG_323_.tb3_5(0):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(0):=null;
RQCFG_323_.tb3_6(0):=NULL;
RQCFG_323_.old_tb3_7(0):=121371458;
RQCFG_323_.tb3_7(0):=NULL;
RQCFG_323_.old_tb3_8(0):=120188095;
RQCFG_323_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(0),
RQCFG_323_.tb3_1(0),
RQCFG_323_.tb3_2(0),
RQCFG_323_.tb3_3(0),
RQCFG_323_.tb3_4(0),
RQCFG_323_.tb3_5(0),
RQCFG_323_.tb3_6(0),
RQCFG_323_.tb3_7(0),
RQCFG_323_.tb3_8(0),
null,
972,
0,
'Alternativa'
,
'N'
,
'N'
,
'Y'
,
0,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb4_0(0):=5441;
RQCFG_323_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_323_.tb4_0(0):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb4_1(0):=RQCFG_323_.tb2_2(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_323_.tb4_0(0),
RQCFG_323_.tb4_1(0),
null,
null,
'FRAME-C_GENERICO_90-1069804'
,
3);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(0):=1646223;
RQCFG_323_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(0):=RQCFG_323_.tb5_0(0);
RQCFG_323_.old_tb5_1(0):=1801;
RQCFG_323_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(0),-1)));
RQCFG_323_.old_tb5_2(0):=null;
RQCFG_323_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(0),-1)));
RQCFG_323_.tb5_3(0):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(0):=RQCFG_323_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(0),
RQCFG_323_.tb5_1(0),
RQCFG_323_.tb5_2(0),
RQCFG_323_.tb5_3(0),
RQCFG_323_.tb5_4(0),
'N'
,
'Y'
,
0,
'Y'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(1):=1159047;
RQCFG_323_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(1):=RQCFG_323_.tb3_0(1);
RQCFG_323_.old_tb3_1(1):=2042;
RQCFG_323_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(1),-1)));
RQCFG_323_.old_tb3_2(1):=338;
RQCFG_323_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(1),-1)));
RQCFG_323_.old_tb3_3(1):=null;
RQCFG_323_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(1),-1)));
RQCFG_323_.old_tb3_4(1):=null;
RQCFG_323_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(1),-1)));
RQCFG_323_.tb3_5(1):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(1):=121371459;
RQCFG_323_.tb3_6(1):=NULL;
RQCFG_323_.old_tb3_7(1):=null;
RQCFG_323_.tb3_7(1):=NULL;
RQCFG_323_.old_tb3_8(1):=null;
RQCFG_323_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(1),
RQCFG_323_.tb3_1(1),
RQCFG_323_.tb3_2(1),
RQCFG_323_.tb3_3(1),
RQCFG_323_.tb3_4(1),
RQCFG_323_.tb3_5(1),
RQCFG_323_.tb3_6(1),
RQCFG_323_.tb3_7(1),
RQCFG_323_.tb3_8(1),
null,
973,
1,
'Identificador del Componente Registro Componente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(1):=1646224;
RQCFG_323_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(1):=RQCFG_323_.tb5_0(1);
RQCFG_323_.old_tb5_1(1):=338;
RQCFG_323_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(1),-1)));
RQCFG_323_.old_tb5_2(1):=null;
RQCFG_323_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(1),-1)));
RQCFG_323_.tb5_3(1):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(1):=RQCFG_323_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(1),
RQCFG_323_.tb5_1(1),
RQCFG_323_.tb5_2(1),
RQCFG_323_.tb5_3(1),
RQCFG_323_.tb5_4(1),
'C'
,
'Y'
,
1,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(2):=1159048;
RQCFG_323_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(2):=RQCFG_323_.tb3_0(2);
RQCFG_323_.old_tb3_1(2):=2042;
RQCFG_323_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(2),-1)));
RQCFG_323_.old_tb3_2(2):=456;
RQCFG_323_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(2),-1)));
RQCFG_323_.old_tb3_3(2):=187;
RQCFG_323_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(2),-1)));
RQCFG_323_.old_tb3_4(2):=null;
RQCFG_323_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(2),-1)));
RQCFG_323_.tb3_5(2):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(2):=null;
RQCFG_323_.tb3_6(2):=NULL;
RQCFG_323_.old_tb3_7(2):=null;
RQCFG_323_.tb3_7(2):=NULL;
RQCFG_323_.old_tb3_8(2):=null;
RQCFG_323_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(2),
RQCFG_323_.tb3_1(2),
RQCFG_323_.tb3_2(2),
RQCFG_323_.tb3_3(2),
RQCFG_323_.tb3_4(2),
RQCFG_323_.tb3_5(2),
RQCFG_323_.tb3_6(2),
RQCFG_323_.tb3_7(2),
RQCFG_323_.tb3_8(2),
null,
974,
2,
'Identificador del Motivo Registro Componente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(2):=1646225;
RQCFG_323_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(2):=RQCFG_323_.tb5_0(2);
RQCFG_323_.old_tb5_1(2):=456;
RQCFG_323_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(2),-1)));
RQCFG_323_.old_tb5_2(2):=null;
RQCFG_323_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(2),-1)));
RQCFG_323_.tb5_3(2):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(2):=RQCFG_323_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(2),
RQCFG_323_.tb5_1(2),
RQCFG_323_.tb5_2(2),
RQCFG_323_.tb5_3(2),
RQCFG_323_.tb5_4(2),
'C'
,
'Y'
,
2,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(3):=1159049;
RQCFG_323_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(3):=RQCFG_323_.tb3_0(3);
RQCFG_323_.old_tb3_1(3):=2042;
RQCFG_323_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(3),-1)));
RQCFG_323_.old_tb3_2(3):=696;
RQCFG_323_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(3),-1)));
RQCFG_323_.old_tb3_3(3):=697;
RQCFG_323_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(3),-1)));
RQCFG_323_.old_tb3_4(3):=null;
RQCFG_323_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(3),-1)));
RQCFG_323_.tb3_5(3):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(3):=null;
RQCFG_323_.tb3_6(3):=NULL;
RQCFG_323_.old_tb3_7(3):=null;
RQCFG_323_.tb3_7(3):=NULL;
RQCFG_323_.old_tb3_8(3):=null;
RQCFG_323_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(3),
RQCFG_323_.tb3_1(3),
RQCFG_323_.tb3_2(3),
RQCFG_323_.tb3_3(3),
RQCFG_323_.tb3_4(3),
RQCFG_323_.tb3_5(3),
RQCFG_323_.tb3_6(3),
RQCFG_323_.tb3_7(3),
RQCFG_323_.tb3_8(3),
null,
975,
3,
'Identificador del Producto Motivo'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(3):=1646226;
RQCFG_323_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(3):=RQCFG_323_.tb5_0(3);
RQCFG_323_.old_tb5_1(3):=696;
RQCFG_323_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(3),-1)));
RQCFG_323_.old_tb5_2(3):=null;
RQCFG_323_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(3),-1)));
RQCFG_323_.tb5_3(3):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(3):=RQCFG_323_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(3),
RQCFG_323_.tb5_1(3),
RQCFG_323_.tb5_2(3),
RQCFG_323_.tb5_3(3),
RQCFG_323_.tb5_4(3),
'C'
,
'Y'
,
3,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(4):=1159050;
RQCFG_323_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(4):=RQCFG_323_.tb3_0(4);
RQCFG_323_.old_tb3_1(4):=2042;
RQCFG_323_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(4),-1)));
RQCFG_323_.old_tb3_2(4):=1026;
RQCFG_323_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(4),-1)));
RQCFG_323_.old_tb3_3(4):=null;
RQCFG_323_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(4),-1)));
RQCFG_323_.old_tb3_4(4):=null;
RQCFG_323_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(4),-1)));
RQCFG_323_.tb3_5(4):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(4):=null;
RQCFG_323_.tb3_6(4):=NULL;
RQCFG_323_.old_tb3_7(4):=null;
RQCFG_323_.tb3_7(4):=NULL;
RQCFG_323_.old_tb3_8(4):=null;
RQCFG_323_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(4),
RQCFG_323_.tb3_1(4),
RQCFG_323_.tb3_2(4),
RQCFG_323_.tb3_3(4),
RQCFG_323_.tb3_4(4),
RQCFG_323_.tb3_5(4),
RQCFG_323_.tb3_6(4),
RQCFG_323_.tb3_7(4),
RQCFG_323_.tb3_8(4),
null,
976,
4,
'Fecha de inicio del servicio'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(4):=1646227;
RQCFG_323_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(4):=RQCFG_323_.tb5_0(4);
RQCFG_323_.old_tb5_1(4):=1026;
RQCFG_323_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(4),-1)));
RQCFG_323_.old_tb5_2(4):=null;
RQCFG_323_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(4),-1)));
RQCFG_323_.tb5_3(4):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(4):=RQCFG_323_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(4),
RQCFG_323_.tb5_1(4),
RQCFG_323_.tb5_2(4),
RQCFG_323_.tb5_3(4),
RQCFG_323_.tb5_4(4),
'C'
,
'Y'
,
4,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(5):=1159051;
RQCFG_323_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(5):=RQCFG_323_.tb3_0(5);
RQCFG_323_.old_tb3_1(5):=2042;
RQCFG_323_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(5),-1)));
RQCFG_323_.old_tb3_2(5):=50000937;
RQCFG_323_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(5),-1)));
RQCFG_323_.old_tb3_3(5):=213;
RQCFG_323_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(5),-1)));
RQCFG_323_.old_tb3_4(5):=null;
RQCFG_323_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(5),-1)));
RQCFG_323_.tb3_5(5):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(5):=null;
RQCFG_323_.tb3_6(5):=NULL;
RQCFG_323_.old_tb3_7(5):=null;
RQCFG_323_.tb3_7(5):=NULL;
RQCFG_323_.old_tb3_8(5):=null;
RQCFG_323_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(5),
RQCFG_323_.tb3_1(5),
RQCFG_323_.tb3_2(5),
RQCFG_323_.tb3_3(5),
RQCFG_323_.tb3_4(5),
RQCFG_323_.tb3_5(5),
RQCFG_323_.tb3_6(5),
RQCFG_323_.tb3_7(5),
RQCFG_323_.tb3_8(5),
null,
977,
5,
'PACKAGE_ID'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(5):=1646228;
RQCFG_323_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(5):=RQCFG_323_.tb5_0(5);
RQCFG_323_.old_tb5_1(5):=50000937;
RQCFG_323_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(5),-1)));
RQCFG_323_.old_tb5_2(5):=null;
RQCFG_323_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(5),-1)));
RQCFG_323_.tb5_3(5):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(5):=RQCFG_323_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(5),
RQCFG_323_.tb5_1(5),
RQCFG_323_.tb5_2(5),
RQCFG_323_.tb5_3(5),
RQCFG_323_.tb5_4(5),
'N'
,
'N'
,
5,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(6):=1159052;
RQCFG_323_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(6):=RQCFG_323_.tb3_0(6);
RQCFG_323_.old_tb3_1(6):=2042;
RQCFG_323_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(6),-1)));
RQCFG_323_.old_tb3_2(6):=8064;
RQCFG_323_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(6),-1)));
RQCFG_323_.old_tb3_3(6):=null;
RQCFG_323_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(6),-1)));
RQCFG_323_.old_tb3_4(6):=null;
RQCFG_323_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(6),-1)));
RQCFG_323_.tb3_5(6):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(6):=121371460;
RQCFG_323_.tb3_6(6):=NULL;
RQCFG_323_.old_tb3_7(6):=null;
RQCFG_323_.tb3_7(6):=NULL;
RQCFG_323_.old_tb3_8(6):=null;
RQCFG_323_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(6),
RQCFG_323_.tb3_1(6),
RQCFG_323_.tb3_2(6),
RQCFG_323_.tb3_3(6),
RQCFG_323_.tb3_4(6),
RQCFG_323_.tb3_5(6),
RQCFG_323_.tb3_6(6),
RQCFG_323_.tb3_7(6),
RQCFG_323_.tb3_8(6),
null,
978,
6,
'Id Del Componente Del Producto'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(6):=1646229;
RQCFG_323_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(6):=RQCFG_323_.tb5_0(6);
RQCFG_323_.old_tb5_1(6):=8064;
RQCFG_323_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(6),-1)));
RQCFG_323_.old_tb5_2(6):=null;
RQCFG_323_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(6),-1)));
RQCFG_323_.tb5_3(6):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(6):=RQCFG_323_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(6),
RQCFG_323_.tb5_1(6),
RQCFG_323_.tb5_2(6),
RQCFG_323_.tb5_3(6),
RQCFG_323_.tb5_4(6),
'C'
,
'Y'
,
6,
'N'
,
'Id Del Componente Del Producto'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(7):=1159053;
RQCFG_323_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(7):=RQCFG_323_.tb3_0(7);
RQCFG_323_.old_tb3_1(7):=2042;
RQCFG_323_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(7),-1)));
RQCFG_323_.old_tb3_2(7):=50000936;
RQCFG_323_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(7),-1)));
RQCFG_323_.old_tb3_3(7):=413;
RQCFG_323_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(7),-1)));
RQCFG_323_.old_tb3_4(7):=null;
RQCFG_323_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(7),-1)));
RQCFG_323_.tb3_5(7):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(7):=121371461;
RQCFG_323_.tb3_6(7):=NULL;
RQCFG_323_.old_tb3_7(7):=null;
RQCFG_323_.tb3_7(7):=NULL;
RQCFG_323_.old_tb3_8(7):=null;
RQCFG_323_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(7),
RQCFG_323_.tb3_1(7),
RQCFG_323_.tb3_2(7),
RQCFG_323_.tb3_3(7),
RQCFG_323_.tb3_4(7),
RQCFG_323_.tb3_5(7),
RQCFG_323_.tb3_6(7),
RQCFG_323_.tb3_7(7),
RQCFG_323_.tb3_8(7),
null,
979,
7,
'PRODUCT_ID'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(7):=1646230;
RQCFG_323_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(7):=RQCFG_323_.tb5_0(7);
RQCFG_323_.old_tb5_1(7):=50000936;
RQCFG_323_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(7),-1)));
RQCFG_323_.old_tb5_2(7):=null;
RQCFG_323_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(7),-1)));
RQCFG_323_.tb5_3(7):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(7):=RQCFG_323_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(7),
RQCFG_323_.tb5_1(7),
RQCFG_323_.tb5_2(7),
RQCFG_323_.tb5_3(7),
RQCFG_323_.tb5_4(7),
'C'
,
'N'
,
7,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(8):=1159054;
RQCFG_323_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(8):=RQCFG_323_.tb3_0(8);
RQCFG_323_.old_tb3_1(8):=2042;
RQCFG_323_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(8),-1)));
RQCFG_323_.old_tb3_2(8):=4013;
RQCFG_323_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(8),-1)));
RQCFG_323_.old_tb3_3(8):=null;
RQCFG_323_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(8),-1)));
RQCFG_323_.old_tb3_4(8):=null;
RQCFG_323_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(8),-1)));
RQCFG_323_.tb3_5(8):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(8):=null;
RQCFG_323_.tb3_6(8):=NULL;
RQCFG_323_.old_tb3_7(8):=null;
RQCFG_323_.tb3_7(8):=NULL;
RQCFG_323_.old_tb3_8(8):=null;
RQCFG_323_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(8),
RQCFG_323_.tb3_1(8),
RQCFG_323_.tb3_2(8),
RQCFG_323_.tb3_3(8),
RQCFG_323_.tb3_4(8),
RQCFG_323_.tb3_5(8),
RQCFG_323_.tb3_6(8),
RQCFG_323_.tb3_7(8),
RQCFG_323_.tb3_8(8),
null,
980,
8,
'SERVICE_NUMBER'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(8):=1646231;
RQCFG_323_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(8):=RQCFG_323_.tb5_0(8);
RQCFG_323_.old_tb5_1(8):=4013;
RQCFG_323_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(8),-1)));
RQCFG_323_.old_tb5_2(8):=null;
RQCFG_323_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(8),-1)));
RQCFG_323_.tb5_3(8):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(8):=RQCFG_323_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(8),
RQCFG_323_.tb5_1(8),
RQCFG_323_.tb5_2(8),
RQCFG_323_.tb5_3(8),
RQCFG_323_.tb5_4(8),
'N'
,
'N'
,
8,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(9):=1159055;
RQCFG_323_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(9):=RQCFG_323_.tb3_0(9);
RQCFG_323_.old_tb3_1(9):=2042;
RQCFG_323_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(9),-1)));
RQCFG_323_.old_tb3_2(9):=362;
RQCFG_323_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(9),-1)));
RQCFG_323_.old_tb3_3(9):=null;
RQCFG_323_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(9),-1)));
RQCFG_323_.old_tb3_4(9):=null;
RQCFG_323_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(9),-1)));
RQCFG_323_.tb3_5(9):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(9):=null;
RQCFG_323_.tb3_6(9):=NULL;
RQCFG_323_.old_tb3_7(9):=null;
RQCFG_323_.tb3_7(9):=NULL;
RQCFG_323_.old_tb3_8(9):=null;
RQCFG_323_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(9),
RQCFG_323_.tb3_1(9),
RQCFG_323_.tb3_2(9),
RQCFG_323_.tb3_3(9),
RQCFG_323_.tb3_4(9),
RQCFG_323_.tb3_5(9),
RQCFG_323_.tb3_6(9),
RQCFG_323_.tb3_7(9),
RQCFG_323_.tb3_8(9),
null,
981,
9,
'MOTIVE_TYPE_ID'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(9):=1646232;
RQCFG_323_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(9):=RQCFG_323_.tb5_0(9);
RQCFG_323_.old_tb5_1(9):=362;
RQCFG_323_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(9),-1)));
RQCFG_323_.old_tb5_2(9):=null;
RQCFG_323_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(9),-1)));
RQCFG_323_.tb5_3(9):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(9):=RQCFG_323_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(9),
RQCFG_323_.tb5_1(9),
RQCFG_323_.tb5_2(9),
RQCFG_323_.tb5_3(9),
RQCFG_323_.tb5_4(9),
'N'
,
'N'
,
9,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(10):=1159056;
RQCFG_323_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(10):=RQCFG_323_.tb3_0(10);
RQCFG_323_.old_tb3_1(10):=2042;
RQCFG_323_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(10),-1)));
RQCFG_323_.old_tb3_2(10):=361;
RQCFG_323_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(10),-1)));
RQCFG_323_.old_tb3_3(10):=null;
RQCFG_323_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(10),-1)));
RQCFG_323_.old_tb3_4(10):=null;
RQCFG_323_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(10),-1)));
RQCFG_323_.tb3_5(10):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(10):=null;
RQCFG_323_.tb3_6(10):=NULL;
RQCFG_323_.old_tb3_7(10):=null;
RQCFG_323_.tb3_7(10):=NULL;
RQCFG_323_.old_tb3_8(10):=null;
RQCFG_323_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(10),
RQCFG_323_.tb3_1(10),
RQCFG_323_.tb3_2(10),
RQCFG_323_.tb3_3(10),
RQCFG_323_.tb3_4(10),
RQCFG_323_.tb3_5(10),
RQCFG_323_.tb3_6(10),
RQCFG_323_.tb3_7(10),
RQCFG_323_.tb3_8(10),
null,
982,
10,
'COMPONENT_TYPE_ID'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(10):=1646233;
RQCFG_323_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(10):=RQCFG_323_.tb5_0(10);
RQCFG_323_.old_tb5_1(10):=361;
RQCFG_323_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(10),-1)));
RQCFG_323_.old_tb5_2(10):=null;
RQCFG_323_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(10),-1)));
RQCFG_323_.tb5_3(10):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(10):=RQCFG_323_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(10),
RQCFG_323_.tb5_1(10),
RQCFG_323_.tb5_2(10),
RQCFG_323_.tb5_3(10),
RQCFG_323_.tb5_4(10),
'N'
,
'N'
,
10,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(11):=1159057;
RQCFG_323_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(11):=RQCFG_323_.tb3_0(11);
RQCFG_323_.old_tb3_1(11):=2042;
RQCFG_323_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(11),-1)));
RQCFG_323_.old_tb3_2(11):=355;
RQCFG_323_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(11),-1)));
RQCFG_323_.old_tb3_3(11):=null;
RQCFG_323_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(11),-1)));
RQCFG_323_.old_tb3_4(11):=null;
RQCFG_323_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(11),-1)));
RQCFG_323_.tb3_5(11):=RQCFG_323_.tb2_2(2);
RQCFG_323_.old_tb3_6(11):=null;
RQCFG_323_.tb3_6(11):=NULL;
RQCFG_323_.old_tb3_7(11):=null;
RQCFG_323_.tb3_7(11):=NULL;
RQCFG_323_.old_tb3_8(11):=null;
RQCFG_323_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(11),
RQCFG_323_.tb3_1(11),
RQCFG_323_.tb3_2(11),
RQCFG_323_.tb3_3(11),
RQCFG_323_.tb3_4(11),
RQCFG_323_.tb3_5(11),
RQCFG_323_.tb3_6(11),
RQCFG_323_.tb3_7(11),
RQCFG_323_.tb3_8(11),
null,
983,
11,
'DISTRICT_ID'
,
'N'
,
'N'
,
'N'
,
11,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(11):=1646234;
RQCFG_323_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(11):=RQCFG_323_.tb5_0(11);
RQCFG_323_.old_tb5_1(11):=355;
RQCFG_323_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(11),-1)));
RQCFG_323_.old_tb5_2(11):=null;
RQCFG_323_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(11),-1)));
RQCFG_323_.tb5_3(11):=RQCFG_323_.tb4_0(0);
RQCFG_323_.tb5_4(11):=RQCFG_323_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(11),
RQCFG_323_.tb5_1(11),
RQCFG_323_.tb5_2(11),
RQCFG_323_.tb5_3(11),
RQCFG_323_.tb5_4(11),
'N'
,
'N'
,
11,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(12):=1159070;
RQCFG_323_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(12):=RQCFG_323_.tb3_0(12);
RQCFG_323_.old_tb3_1(12):=3334;
RQCFG_323_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(12),-1)));
RQCFG_323_.old_tb3_2(12):=44501;
RQCFG_323_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(12),-1)));
RQCFG_323_.old_tb3_3(12):=null;
RQCFG_323_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(12),-1)));
RQCFG_323_.old_tb3_4(12):=2558;
RQCFG_323_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(12),-1)));
RQCFG_323_.tb3_5(12):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(12):=null;
RQCFG_323_.tb3_6(12):=NULL;
RQCFG_323_.old_tb3_7(12):=null;
RQCFG_323_.tb3_7(12):=NULL;
RQCFG_323_.old_tb3_8(12):=120188094;
RQCFG_323_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(12),
RQCFG_323_.tb3_1(12),
RQCFG_323_.tb3_2(12),
RQCFG_323_.tb3_3(12),
RQCFG_323_.tb3_4(12),
RQCFG_323_.tb3_5(12),
RQCFG_323_.tb3_6(12),
RQCFG_323_.tb3_7(12),
RQCFG_323_.tb3_8(12),
null,
1911,
4,
'Actividad'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb4_0(1):=5442;
RQCFG_323_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_323_.tb4_0(1):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb4_1(1):=RQCFG_323_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_323_.tb4_0(1),
RQCFG_323_.tb4_1(1),
null,
null,
'FRAME-M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114-1069803'
,
2);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(12):=1646247;
RQCFG_323_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(12):=RQCFG_323_.tb5_0(12);
RQCFG_323_.old_tb5_1(12):=44501;
RQCFG_323_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(12),-1)));
RQCFG_323_.old_tb5_2(12):=2558;
RQCFG_323_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(12),-1)));
RQCFG_323_.tb5_3(12):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(12):=RQCFG_323_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(12),
RQCFG_323_.tb5_1(12),
RQCFG_323_.tb5_2(12),
RQCFG_323_.tb5_3(12),
RQCFG_323_.tb5_4(12),
'Y'
,
'Y'
,
4,
'Y'
,
'Actividad'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(13):=1159071;
RQCFG_323_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(13):=RQCFG_323_.tb3_0(13);
RQCFG_323_.old_tb3_1(13):=3334;
RQCFG_323_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(13),-1)));
RQCFG_323_.old_tb3_2(13):=197;
RQCFG_323_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(13),-1)));
RQCFG_323_.old_tb3_3(13):=null;
RQCFG_323_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(13),-1)));
RQCFG_323_.old_tb3_4(13):=null;
RQCFG_323_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(13),-1)));
RQCFG_323_.tb3_5(13):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(13):=null;
RQCFG_323_.tb3_6(13):=NULL;
RQCFG_323_.old_tb3_7(13):=null;
RQCFG_323_.tb3_7(13):=NULL;
RQCFG_323_.old_tb3_8(13):=null;
RQCFG_323_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(13),
RQCFG_323_.tb3_1(13),
RQCFG_323_.tb3_2(13),
RQCFG_323_.tb3_3(13),
RQCFG_323_.tb3_4(13),
RQCFG_323_.tb3_5(13),
RQCFG_323_.tb3_6(13),
RQCFG_323_.tb3_7(13),
RQCFG_323_.tb3_8(13),
null,
1912,
5,
'Privado'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(13):=1646248;
RQCFG_323_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(13):=RQCFG_323_.tb5_0(13);
RQCFG_323_.old_tb5_1(13):=197;
RQCFG_323_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(13),-1)));
RQCFG_323_.old_tb5_2(13):=null;
RQCFG_323_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(13),-1)));
RQCFG_323_.tb5_3(13):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(13):=RQCFG_323_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(13),
RQCFG_323_.tb5_1(13),
RQCFG_323_.tb5_2(13),
RQCFG_323_.tb5_3(13),
RQCFG_323_.tb5_4(13),
'C'
,
'Y'
,
5,
'N'
,
'Privado'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(14):=1159072;
RQCFG_323_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(14):=RQCFG_323_.tb3_0(14);
RQCFG_323_.old_tb3_1(14):=3334;
RQCFG_323_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(14),-1)));
RQCFG_323_.old_tb3_2(14):=322;
RQCFG_323_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(14),-1)));
RQCFG_323_.old_tb3_3(14):=null;
RQCFG_323_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(14),-1)));
RQCFG_323_.old_tb3_4(14):=null;
RQCFG_323_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(14),-1)));
RQCFG_323_.tb3_5(14):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(14):=121371450;
RQCFG_323_.tb3_6(14):=NULL;
RQCFG_323_.old_tb3_7(14):=null;
RQCFG_323_.tb3_7(14):=NULL;
RQCFG_323_.old_tb3_8(14):=null;
RQCFG_323_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(14),
RQCFG_323_.tb3_1(14),
RQCFG_323_.tb3_2(14),
RQCFG_323_.tb3_3(14),
RQCFG_323_.tb3_4(14),
RQCFG_323_.tb3_5(14),
RQCFG_323_.tb3_6(14),
RQCFG_323_.tb3_7(14),
RQCFG_323_.tb3_8(14),
null,
1913,
6,
'Parcial'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(14):=1646249;
RQCFG_323_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(14):=RQCFG_323_.tb5_0(14);
RQCFG_323_.old_tb5_1(14):=322;
RQCFG_323_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(14),-1)));
RQCFG_323_.old_tb5_2(14):=null;
RQCFG_323_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(14),-1)));
RQCFG_323_.tb5_3(14):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(14):=RQCFG_323_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(14),
RQCFG_323_.tb5_1(14),
RQCFG_323_.tb5_2(14),
RQCFG_323_.tb5_3(14),
RQCFG_323_.tb5_4(14),
'C'
,
'Y'
,
6,
'N'
,
'Parcial'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(15):=1159073;
RQCFG_323_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(15):=RQCFG_323_.tb3_0(15);
RQCFG_323_.old_tb3_1(15):=3334;
RQCFG_323_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(15),-1)));
RQCFG_323_.old_tb3_2(15):=203;
RQCFG_323_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(15),-1)));
RQCFG_323_.old_tb3_3(15):=null;
RQCFG_323_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(15),-1)));
RQCFG_323_.old_tb3_4(15):=null;
RQCFG_323_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(15),-1)));
RQCFG_323_.tb3_5(15):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(15):=121371452;
RQCFG_323_.tb3_6(15):=NULL;
RQCFG_323_.old_tb3_7(15):=121371451;
RQCFG_323_.tb3_7(15):=NULL;
RQCFG_323_.old_tb3_8(15):=null;
RQCFG_323_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(15),
RQCFG_323_.tb3_1(15),
RQCFG_323_.tb3_2(15),
RQCFG_323_.tb3_3(15),
RQCFG_323_.tb3_4(15),
RQCFG_323_.tb3_5(15),
RQCFG_323_.tb3_6(15),
RQCFG_323_.tb3_7(15),
RQCFG_323_.tb3_8(15),
null,
1914,
7,
'Prioridad'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(15):=1646250;
RQCFG_323_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(15):=RQCFG_323_.tb5_0(15);
RQCFG_323_.old_tb5_1(15):=203;
RQCFG_323_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(15),-1)));
RQCFG_323_.old_tb5_2(15):=null;
RQCFG_323_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(15),-1)));
RQCFG_323_.tb5_3(15):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(15):=RQCFG_323_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(15),
RQCFG_323_.tb5_1(15),
RQCFG_323_.tb5_2(15),
RQCFG_323_.tb5_3(15),
RQCFG_323_.tb5_4(15),
'C'
,
'Y'
,
7,
'N'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(16):=1159074;
RQCFG_323_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(16):=RQCFG_323_.tb3_0(16);
RQCFG_323_.old_tb3_1(16):=3334;
RQCFG_323_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(16),-1)));
RQCFG_323_.old_tb3_2(16):=189;
RQCFG_323_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(16),-1)));
RQCFG_323_.old_tb3_3(16):=null;
RQCFG_323_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(16),-1)));
RQCFG_323_.old_tb3_4(16):=null;
RQCFG_323_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(16),-1)));
RQCFG_323_.tb3_5(16):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(16):=null;
RQCFG_323_.tb3_6(16):=NULL;
RQCFG_323_.old_tb3_7(16):=null;
RQCFG_323_.tb3_7(16):=NULL;
RQCFG_323_.old_tb3_8(16):=null;
RQCFG_323_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(16),
RQCFG_323_.tb3_1(16),
RQCFG_323_.tb3_2(16),
RQCFG_323_.tb3_3(16),
RQCFG_323_.tb3_4(16),
RQCFG_323_.tb3_5(16),
RQCFG_323_.tb3_6(16),
RQCFG_323_.tb3_7(16),
RQCFG_323_.tb3_8(16),
null,
1915,
8,
'Solicitud atenci¿n al cliente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(16):=1646251;
RQCFG_323_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(16):=RQCFG_323_.tb5_0(16);
RQCFG_323_.old_tb5_1(16):=189;
RQCFG_323_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(16),-1)));
RQCFG_323_.old_tb5_2(16):=null;
RQCFG_323_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(16),-1)));
RQCFG_323_.tb5_3(16):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(16):=RQCFG_323_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(16),
RQCFG_323_.tb5_1(16),
RQCFG_323_.tb5_2(16),
RQCFG_323_.tb5_3(16),
RQCFG_323_.tb5_4(16),
'C'
,
'Y'
,
8,
'N'
,
'Solicitud atenci¿n al cliente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(17):=1159075;
RQCFG_323_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(17):=RQCFG_323_.tb3_0(17);
RQCFG_323_.old_tb3_1(17):=3334;
RQCFG_323_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(17),-1)));
RQCFG_323_.old_tb3_2(17):=413;
RQCFG_323_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(17),-1)));
RQCFG_323_.old_tb3_3(17):=null;
RQCFG_323_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(17),-1)));
RQCFG_323_.old_tb3_4(17):=null;
RQCFG_323_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(17),-1)));
RQCFG_323_.tb3_5(17):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(17):=121371453;
RQCFG_323_.tb3_6(17):=NULL;
RQCFG_323_.old_tb3_7(17):=null;
RQCFG_323_.tb3_7(17):=NULL;
RQCFG_323_.old_tb3_8(17):=null;
RQCFG_323_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(17),
RQCFG_323_.tb3_1(17),
RQCFG_323_.tb3_2(17),
RQCFG_323_.tb3_3(17),
RQCFG_323_.tb3_4(17),
RQCFG_323_.tb3_5(17),
RQCFG_323_.tb3_6(17),
RQCFG_323_.tb3_7(17),
RQCFG_323_.tb3_8(17),
null,
1916,
9,
'Producto'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(17):=1646252;
RQCFG_323_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(17):=RQCFG_323_.tb5_0(17);
RQCFG_323_.old_tb5_1(17):=413;
RQCFG_323_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(17),-1)));
RQCFG_323_.old_tb5_2(17):=null;
RQCFG_323_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(17),-1)));
RQCFG_323_.tb5_3(17):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(17):=RQCFG_323_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(17),
RQCFG_323_.tb5_1(17),
RQCFG_323_.tb5_2(17),
RQCFG_323_.tb5_3(17),
RQCFG_323_.tb5_4(17),
'C'
,
'Y'
,
9,
'N'
,
'Producto'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(18):=1159076;
RQCFG_323_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(18):=RQCFG_323_.tb3_0(18);
RQCFG_323_.old_tb3_1(18):=3334;
RQCFG_323_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(18),-1)));
RQCFG_323_.old_tb3_2(18):=11403;
RQCFG_323_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(18),-1)));
RQCFG_323_.old_tb3_3(18):=null;
RQCFG_323_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(18),-1)));
RQCFG_323_.old_tb3_4(18):=null;
RQCFG_323_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(18),-1)));
RQCFG_323_.tb3_5(18):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(18):=121371454;
RQCFG_323_.tb3_6(18):=NULL;
RQCFG_323_.old_tb3_7(18):=null;
RQCFG_323_.tb3_7(18):=NULL;
RQCFG_323_.old_tb3_8(18):=null;
RQCFG_323_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(18),
RQCFG_323_.tb3_1(18),
RQCFG_323_.tb3_2(18),
RQCFG_323_.tb3_3(18),
RQCFG_323_.tb3_4(18),
RQCFG_323_.tb3_5(18),
RQCFG_323_.tb3_6(18),
RQCFG_323_.tb3_7(18),
RQCFG_323_.tb3_8(18),
null,
1917,
10,
'Contrato'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(18):=1646253;
RQCFG_323_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(18):=RQCFG_323_.tb5_0(18);
RQCFG_323_.old_tb5_1(18):=11403;
RQCFG_323_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(18),-1)));
RQCFG_323_.old_tb5_2(18):=null;
RQCFG_323_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(18),-1)));
RQCFG_323_.tb5_3(18):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(18):=RQCFG_323_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(18),
RQCFG_323_.tb5_1(18),
RQCFG_323_.tb5_2(18),
RQCFG_323_.tb5_3(18),
RQCFG_323_.tb5_4(18),
'C'
,
'Y'
,
10,
'N'
,
'Contrato'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(19):=1159077;
RQCFG_323_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(19):=RQCFG_323_.tb3_0(19);
RQCFG_323_.old_tb3_1(19):=3334;
RQCFG_323_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(19),-1)));
RQCFG_323_.old_tb3_2(19):=192;
RQCFG_323_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(19),-1)));
RQCFG_323_.old_tb3_3(19):=null;
RQCFG_323_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(19),-1)));
RQCFG_323_.old_tb3_4(19):=null;
RQCFG_323_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(19),-1)));
RQCFG_323_.tb3_5(19):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(19):=121371455;
RQCFG_323_.tb3_6(19):=NULL;
RQCFG_323_.old_tb3_7(19):=null;
RQCFG_323_.tb3_7(19):=NULL;
RQCFG_323_.old_tb3_8(19):=null;
RQCFG_323_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(19),
RQCFG_323_.tb3_1(19),
RQCFG_323_.tb3_2(19),
RQCFG_323_.tb3_3(19),
RQCFG_323_.tb3_4(19),
RQCFG_323_.tb3_5(19),
RQCFG_323_.tb3_6(19),
RQCFG_323_.tb3_7(19),
RQCFG_323_.tb3_8(19),
null,
1918,
11,
'Tipo de producto'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(19):=1646254;
RQCFG_323_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(19):=RQCFG_323_.tb5_0(19);
RQCFG_323_.old_tb5_1(19):=192;
RQCFG_323_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(19),-1)));
RQCFG_323_.old_tb5_2(19):=null;
RQCFG_323_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(19),-1)));
RQCFG_323_.tb5_3(19):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(19):=RQCFG_323_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(19),
RQCFG_323_.tb5_1(19),
RQCFG_323_.tb5_2(19),
RQCFG_323_.tb5_3(19),
RQCFG_323_.tb5_4(19),
'C'
,
'Y'
,
11,
'N'
,
'Tipo de producto'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(20):=1159078;
RQCFG_323_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(20):=RQCFG_323_.tb3_0(20);
RQCFG_323_.old_tb3_1(20):=3334;
RQCFG_323_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(20),-1)));
RQCFG_323_.old_tb3_2(20):=45189;
RQCFG_323_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(20),-1)));
RQCFG_323_.old_tb3_3(20):=null;
RQCFG_323_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(20),-1)));
RQCFG_323_.old_tb3_4(20):=null;
RQCFG_323_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(20),-1)));
RQCFG_323_.tb3_5(20):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(20):=121371456;
RQCFG_323_.tb3_6(20):=NULL;
RQCFG_323_.old_tb3_7(20):=null;
RQCFG_323_.tb3_7(20):=NULL;
RQCFG_323_.old_tb3_8(20):=null;
RQCFG_323_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(20),
RQCFG_323_.tb3_1(20),
RQCFG_323_.tb3_2(20),
RQCFG_323_.tb3_3(20),
RQCFG_323_.tb3_4(20),
RQCFG_323_.tb3_5(20),
RQCFG_323_.tb3_6(20),
RQCFG_323_.tb3_7(20),
RQCFG_323_.tb3_8(20),
null,
1919,
12,
'Identificador Plan Comercial'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(20):=1646255;
RQCFG_323_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(20):=RQCFG_323_.tb5_0(20);
RQCFG_323_.old_tb5_1(20):=45189;
RQCFG_323_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(20),-1)));
RQCFG_323_.old_tb5_2(20):=null;
RQCFG_323_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(20),-1)));
RQCFG_323_.tb5_3(20):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(20):=RQCFG_323_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(20),
RQCFG_323_.tb5_1(20),
RQCFG_323_.tb5_2(20),
RQCFG_323_.tb5_3(20),
RQCFG_323_.tb5_4(20),
'C'
,
'Y'
,
12,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(21):=1159079;
RQCFG_323_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(21):=RQCFG_323_.tb3_0(21);
RQCFG_323_.old_tb3_1(21):=3334;
RQCFG_323_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(21),-1)));
RQCFG_323_.old_tb3_2(21):=147336;
RQCFG_323_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(21),-1)));
RQCFG_323_.old_tb3_3(21):=null;
RQCFG_323_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(21),-1)));
RQCFG_323_.old_tb3_4(21):=1035;
RQCFG_323_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(21),-1)));
RQCFG_323_.tb3_5(21):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(21):=121371448;
RQCFG_323_.tb3_6(21):=NULL;
RQCFG_323_.old_tb3_7(21):=null;
RQCFG_323_.tb3_7(21):=NULL;
RQCFG_323_.old_tb3_8(21):=null;
RQCFG_323_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(21),
RQCFG_323_.tb3_1(21),
RQCFG_323_.tb3_2(21),
RQCFG_323_.tb3_3(21),
RQCFG_323_.tb3_4(21),
RQCFG_323_.tb3_5(21),
RQCFG_323_.tb3_6(21),
RQCFG_323_.tb3_7(21),
RQCFG_323_.tb3_8(21),
null,
104459,
18,
'Categor¿a'
,
'N'
,
'N'
,
'N'
,
18,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(21):=1646256;
RQCFG_323_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(21):=RQCFG_323_.tb5_0(21);
RQCFG_323_.old_tb5_1(21):=147336;
RQCFG_323_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(21),-1)));
RQCFG_323_.old_tb5_2(21):=1035;
RQCFG_323_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(21),-1)));
RQCFG_323_.tb5_3(21):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(21):=RQCFG_323_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(21),
RQCFG_323_.tb5_1(21),
RQCFG_323_.tb5_2(21),
RQCFG_323_.tb5_3(21),
RQCFG_323_.tb5_4(21),
'N'
,
'Y'
,
18,
'N'
,
'Categor¿a'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(22):=1159080;
RQCFG_323_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(22):=RQCFG_323_.tb3_0(22);
RQCFG_323_.old_tb3_1(22):=3334;
RQCFG_323_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(22),-1)));
RQCFG_323_.old_tb3_2(22):=147337;
RQCFG_323_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(22),-1)));
RQCFG_323_.old_tb3_3(22):=null;
RQCFG_323_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(22),-1)));
RQCFG_323_.old_tb3_4(22):=147336;
RQCFG_323_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(22),-1)));
RQCFG_323_.tb3_5(22):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(22):=121371449;
RQCFG_323_.tb3_6(22):=NULL;
RQCFG_323_.old_tb3_7(22):=null;
RQCFG_323_.tb3_7(22):=NULL;
RQCFG_323_.old_tb3_8(22):=null;
RQCFG_323_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(22),
RQCFG_323_.tb3_1(22),
RQCFG_323_.tb3_2(22),
RQCFG_323_.tb3_3(22),
RQCFG_323_.tb3_4(22),
RQCFG_323_.tb3_5(22),
RQCFG_323_.tb3_6(22),
RQCFG_323_.tb3_7(22),
RQCFG_323_.tb3_8(22),
null,
104460,
19,
'Subcategor¿a'
,
'N'
,
'N'
,
'N'
,
19,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(22):=1646257;
RQCFG_323_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(22):=RQCFG_323_.tb5_0(22);
RQCFG_323_.old_tb5_1(22):=147337;
RQCFG_323_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(22),-1)));
RQCFG_323_.old_tb5_2(22):=147336;
RQCFG_323_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(22),-1)));
RQCFG_323_.tb5_3(22):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(22):=RQCFG_323_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(22),
RQCFG_323_.tb5_1(22),
RQCFG_323_.tb5_2(22),
RQCFG_323_.tb5_3(22),
RQCFG_323_.tb5_4(22),
'N'
,
'Y'
,
19,
'N'
,
'Subcategor¿a'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(23):=1159081;
RQCFG_323_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(23):=RQCFG_323_.tb3_0(23);
RQCFG_323_.old_tb3_1(23):=3334;
RQCFG_323_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(23),-1)));
RQCFG_323_.old_tb3_2(23):=2559;
RQCFG_323_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(23),-1)));
RQCFG_323_.old_tb3_3(23):=2826;
RQCFG_323_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(23),-1)));
RQCFG_323_.old_tb3_4(23):=null;
RQCFG_323_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(23),-1)));
RQCFG_323_.tb3_5(23):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(23):=null;
RQCFG_323_.tb3_6(23):=NULL;
RQCFG_323_.old_tb3_7(23):=null;
RQCFG_323_.tb3_7(23):=NULL;
RQCFG_323_.old_tb3_8(23):=null;
RQCFG_323_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(23),
RQCFG_323_.tb3_1(23),
RQCFG_323_.tb3_2(23),
RQCFG_323_.tb3_3(23),
RQCFG_323_.tb3_4(23),
RQCFG_323_.tb3_5(23),
RQCFG_323_.tb3_6(23),
RQCFG_323_.tb3_7(23),
RQCFG_323_.tb3_8(23),
null,
1920,
13,
'Valor Numerico Contrato'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(23):=1646258;
RQCFG_323_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(23):=RQCFG_323_.tb5_0(23);
RQCFG_323_.old_tb5_1(23):=2559;
RQCFG_323_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(23),-1)));
RQCFG_323_.old_tb5_2(23):=null;
RQCFG_323_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(23),-1)));
RQCFG_323_.tb5_3(23):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(23):=RQCFG_323_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(23),
RQCFG_323_.tb5_1(23),
RQCFG_323_.tb5_2(23),
RQCFG_323_.tb5_3(23),
RQCFG_323_.tb5_4(23),
'C'
,
'Y'
,
13,
'N'
,
'Valor Numerico Contrato'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(24):=1159058;
RQCFG_323_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(24):=RQCFG_323_.tb3_0(24);
RQCFG_323_.old_tb3_1(24):=3334;
RQCFG_323_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(24),-1)));
RQCFG_323_.old_tb3_2(24):=281;
RQCFG_323_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(24),-1)));
RQCFG_323_.old_tb3_3(24):=187;
RQCFG_323_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(24),-1)));
RQCFG_323_.old_tb3_4(24):=null;
RQCFG_323_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(24),-1)));
RQCFG_323_.tb3_5(24):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(24):=null;
RQCFG_323_.tb3_6(24):=NULL;
RQCFG_323_.old_tb3_7(24):=null;
RQCFG_323_.tb3_7(24):=NULL;
RQCFG_323_.old_tb3_8(24):=null;
RQCFG_323_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(24),
RQCFG_323_.tb3_1(24),
RQCFG_323_.tb3_2(24),
RQCFG_323_.tb3_3(24),
RQCFG_323_.tb3_4(24),
RQCFG_323_.tb3_5(24),
RQCFG_323_.tb3_6(24),
RQCFG_323_.tb3_7(24),
RQCFG_323_.tb3_8(24),
null,
1921,
14,
'Consecutivo Interno Motivos'
,
'N'
,
'C'
,
'Y'
,
14,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(24):=1646235;
RQCFG_323_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(24):=RQCFG_323_.tb5_0(24);
RQCFG_323_.old_tb5_1(24):=281;
RQCFG_323_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(24),-1)));
RQCFG_323_.old_tb5_2(24):=null;
RQCFG_323_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(24),-1)));
RQCFG_323_.tb5_3(24):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(24):=RQCFG_323_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(24),
RQCFG_323_.tb5_1(24),
RQCFG_323_.tb5_2(24),
RQCFG_323_.tb5_3(24),
RQCFG_323_.tb5_4(24),
'C'
,
'Y'
,
14,
'Y'
,
'Consecutivo Interno Motivos'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(25):=1159059;
RQCFG_323_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(25):=RQCFG_323_.tb3_0(25);
RQCFG_323_.old_tb3_1(25):=3334;
RQCFG_323_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(25),-1)));
RQCFG_323_.old_tb3_2(25):=90151600;
RQCFG_323_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(25),-1)));
RQCFG_323_.old_tb3_3(25):=null;
RQCFG_323_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(25),-1)));
RQCFG_323_.old_tb3_4(25):=null;
RQCFG_323_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(25),-1)));
RQCFG_323_.tb3_5(25):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(25):=null;
RQCFG_323_.tb3_6(25):=NULL;
RQCFG_323_.old_tb3_7(25):=null;
RQCFG_323_.tb3_7(25):=NULL;
RQCFG_323_.old_tb3_8(25):=null;
RQCFG_323_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(25),
RQCFG_323_.tb3_1(25),
RQCFG_323_.tb3_2(25),
RQCFG_323_.tb3_3(25),
RQCFG_323_.tb3_4(25),
RQCFG_323_.tb3_5(25),
RQCFG_323_.tb3_6(25),
RQCFG_323_.tb3_7(25),
RQCFG_323_.tb3_8(25),
null,
104128,
20,
'Contrato'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(25):=1646236;
RQCFG_323_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(25):=RQCFG_323_.tb5_0(25);
RQCFG_323_.old_tb5_1(25):=90151600;
RQCFG_323_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(25),-1)));
RQCFG_323_.old_tb5_2(25):=null;
RQCFG_323_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(25),-1)));
RQCFG_323_.tb5_3(25):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(25):=RQCFG_323_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(25),
RQCFG_323_.tb5_1(25),
RQCFG_323_.tb5_2(25),
RQCFG_323_.tb5_3(25),
RQCFG_323_.tb5_4(25),
'C'
,
'Y'
,
20,
'N'
,
'Contrato'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(26):=1159060;
RQCFG_323_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(26):=RQCFG_323_.tb3_0(26);
RQCFG_323_.old_tb3_1(26):=3334;
RQCFG_323_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(26),-1)));
RQCFG_323_.old_tb3_2(26):=90151601;
RQCFG_323_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(26),-1)));
RQCFG_323_.old_tb3_3(26):=null;
RQCFG_323_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(26),-1)));
RQCFG_323_.old_tb3_4(26):=null;
RQCFG_323_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(26),-1)));
RQCFG_323_.tb3_5(26):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(26):=null;
RQCFG_323_.tb3_6(26):=NULL;
RQCFG_323_.old_tb3_7(26):=null;
RQCFG_323_.tb3_7(26):=NULL;
RQCFG_323_.old_tb3_8(26):=120188093;
RQCFG_323_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(26),
RQCFG_323_.tb3_1(26),
RQCFG_323_.tb3_2(26),
RQCFG_323_.tb3_3(26),
RQCFG_323_.tb3_4(26),
RQCFG_323_.tb3_5(26),
RQCFG_323_.tb3_6(26),
RQCFG_323_.tb3_7(26),
RQCFG_323_.tb3_8(26),
null,
104129,
21,
'Tipo de Vivienda'
,
'N'
,
'Y'
,
'Y'
,
21,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(26):=1646237;
RQCFG_323_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(26):=RQCFG_323_.tb5_0(26);
RQCFG_323_.old_tb5_1(26):=90151601;
RQCFG_323_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(26),-1)));
RQCFG_323_.old_tb5_2(26):=null;
RQCFG_323_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(26),-1)));
RQCFG_323_.tb5_3(26):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(26):=RQCFG_323_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(26),
RQCFG_323_.tb5_1(26),
RQCFG_323_.tb5_2(26),
RQCFG_323_.tb5_3(26),
RQCFG_323_.tb5_4(26),
'Y'
,
'Y'
,
21,
'Y'
,
'Tipo de Vivienda'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(27):=1159061;
RQCFG_323_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(27):=RQCFG_323_.tb3_0(27);
RQCFG_323_.old_tb3_1(27):=3334;
RQCFG_323_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(27),-1)));
RQCFG_323_.old_tb3_2(27):=90151602;
RQCFG_323_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(27),-1)));
RQCFG_323_.old_tb3_3(27):=258;
RQCFG_323_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(27),-1)));
RQCFG_323_.old_tb3_4(27):=null;
RQCFG_323_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(27),-1)));
RQCFG_323_.tb3_5(27):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(27):=null;
RQCFG_323_.tb3_6(27):=NULL;
RQCFG_323_.old_tb3_7(27):=null;
RQCFG_323_.tb3_7(27):=NULL;
RQCFG_323_.old_tb3_8(27):=null;
RQCFG_323_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(27),
RQCFG_323_.tb3_1(27),
RQCFG_323_.tb3_2(27),
RQCFG_323_.tb3_3(27),
RQCFG_323_.tb3_4(27),
RQCFG_323_.tb3_5(27),
RQCFG_323_.tb3_6(27),
RQCFG_323_.tb3_7(27),
RQCFG_323_.tb3_8(27),
null,
104130,
22,
'Fecha de Registro'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(27):=1646238;
RQCFG_323_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(27):=RQCFG_323_.tb5_0(27);
RQCFG_323_.old_tb5_1(27):=90151602;
RQCFG_323_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(27),-1)));
RQCFG_323_.old_tb5_2(27):=null;
RQCFG_323_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(27),-1)));
RQCFG_323_.tb5_3(27):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(27):=RQCFG_323_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(27),
RQCFG_323_.tb5_1(27),
RQCFG_323_.tb5_2(27),
RQCFG_323_.tb5_3(27),
RQCFG_323_.tb5_4(27),
'C'
,
'Y'
,
22,
'N'
,
'Fecha de Registro'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(28):=1159062;
RQCFG_323_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(28):=RQCFG_323_.tb3_0(28);
RQCFG_323_.old_tb3_1(28):=3334;
RQCFG_323_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(28),-1)));
RQCFG_323_.old_tb3_2(28):=90151603;
RQCFG_323_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(28),-1)));
RQCFG_323_.old_tb3_3(28):=255;
RQCFG_323_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(28),-1)));
RQCFG_323_.old_tb3_4(28):=null;
RQCFG_323_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(28),-1)));
RQCFG_323_.tb3_5(28):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(28):=null;
RQCFG_323_.tb3_6(28):=NULL;
RQCFG_323_.old_tb3_7(28):=null;
RQCFG_323_.tb3_7(28):=NULL;
RQCFG_323_.old_tb3_8(28):=null;
RQCFG_323_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(28),
RQCFG_323_.tb3_1(28),
RQCFG_323_.tb3_2(28),
RQCFG_323_.tb3_3(28),
RQCFG_323_.tb3_4(28),
RQCFG_323_.tb3_5(28),
RQCFG_323_.tb3_6(28),
RQCFG_323_.tb3_7(28),
RQCFG_323_.tb3_8(28),
null,
104131,
23,
'Solicitud Asociada'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(28):=1646239;
RQCFG_323_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(28):=RQCFG_323_.tb5_0(28);
RQCFG_323_.old_tb5_1(28):=90151603;
RQCFG_323_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(28),-1)));
RQCFG_323_.old_tb5_2(28):=null;
RQCFG_323_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(28),-1)));
RQCFG_323_.tb5_3(28):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(28):=RQCFG_323_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(28),
RQCFG_323_.tb5_1(28),
RQCFG_323_.tb5_2(28),
RQCFG_323_.tb5_3(28),
RQCFG_323_.tb5_4(28),
'C'
,
'Y'
,
23,
'N'
,
'Solicitud Asociada'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(29):=1159063;
RQCFG_323_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(29):=RQCFG_323_.tb3_0(29);
RQCFG_323_.old_tb3_1(29):=3334;
RQCFG_323_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(29),-1)));
RQCFG_323_.old_tb3_2(29):=39322;
RQCFG_323_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(29),-1)));
RQCFG_323_.old_tb3_3(29):=255;
RQCFG_323_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(29),-1)));
RQCFG_323_.old_tb3_4(29):=null;
RQCFG_323_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(29),-1)));
RQCFG_323_.tb3_5(29):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(29):=null;
RQCFG_323_.tb3_6(29):=NULL;
RQCFG_323_.old_tb3_7(29):=null;
RQCFG_323_.tb3_7(29):=NULL;
RQCFG_323_.old_tb3_8(29):=null;
RQCFG_323_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(29),
RQCFG_323_.tb3_1(29),
RQCFG_323_.tb3_2(29),
RQCFG_323_.tb3_3(29),
RQCFG_323_.tb3_4(29),
RQCFG_323_.tb3_5(29),
RQCFG_323_.tb3_6(29),
RQCFG_323_.tb3_7(29),
RQCFG_323_.tb3_8(29),
null,
1922,
15,
'Identificador De Solicitud'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(29):=1646240;
RQCFG_323_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(29):=RQCFG_323_.tb5_0(29);
RQCFG_323_.old_tb5_1(29):=39322;
RQCFG_323_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(29),-1)));
RQCFG_323_.old_tb5_2(29):=null;
RQCFG_323_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(29),-1)));
RQCFG_323_.tb5_3(29):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(29):=RQCFG_323_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(29),
RQCFG_323_.tb5_1(29),
RQCFG_323_.tb5_2(29),
RQCFG_323_.tb5_3(29),
RQCFG_323_.tb5_4(29),
'C'
,
'Y'
,
15,
'Y'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(30):=1159064;
RQCFG_323_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(30):=RQCFG_323_.tb3_0(30);
RQCFG_323_.old_tb3_1(30):=3334;
RQCFG_323_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(30),-1)));
RQCFG_323_.old_tb3_2(30):=474;
RQCFG_323_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(30),-1)));
RQCFG_323_.old_tb3_3(30):=null;
RQCFG_323_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(30),-1)));
RQCFG_323_.old_tb3_4(30):=null;
RQCFG_323_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(30),-1)));
RQCFG_323_.tb3_5(30):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(30):=121371445;
RQCFG_323_.tb3_6(30):=NULL;
RQCFG_323_.old_tb3_7(30):=null;
RQCFG_323_.tb3_7(30):=NULL;
RQCFG_323_.old_tb3_8(30):=null;
RQCFG_323_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(30),
RQCFG_323_.tb3_1(30),
RQCFG_323_.tb3_2(30),
RQCFG_323_.tb3_3(30),
RQCFG_323_.tb3_4(30),
RQCFG_323_.tb3_5(30),
RQCFG_323_.tb3_6(30),
RQCFG_323_.tb3_7(30),
RQCFG_323_.tb3_8(30),
null,
1923,
16,
'C¿digo de la Direcci¿n'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(30):=1646241;
RQCFG_323_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(30):=RQCFG_323_.tb5_0(30);
RQCFG_323_.old_tb5_1(30):=474;
RQCFG_323_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(30),-1)));
RQCFG_323_.old_tb5_2(30):=null;
RQCFG_323_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(30),-1)));
RQCFG_323_.tb5_3(30):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(30):=RQCFG_323_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(30),
RQCFG_323_.tb5_1(30),
RQCFG_323_.tb5_2(30),
RQCFG_323_.tb5_3(30),
RQCFG_323_.tb5_4(30),
'C'
,
'Y'
,
16,
'Y'
,
'C¿digo de la Direcci¿n'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(31):=1159065;
RQCFG_323_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(31):=RQCFG_323_.tb3_0(31);
RQCFG_323_.old_tb3_1(31):=3334;
RQCFG_323_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(31),-1)));
RQCFG_323_.old_tb3_2(31):=1035;
RQCFG_323_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(31),-1)));
RQCFG_323_.old_tb3_3(31):=null;
RQCFG_323_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(31),-1)));
RQCFG_323_.old_tb3_4(31):=null;
RQCFG_323_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(31),-1)));
RQCFG_323_.tb3_5(31):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(31):=null;
RQCFG_323_.tb3_6(31):=NULL;
RQCFG_323_.old_tb3_7(31):=121371446;
RQCFG_323_.tb3_7(31):=NULL;
RQCFG_323_.old_tb3_8(31):=null;
RQCFG_323_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(31),
RQCFG_323_.tb3_1(31),
RQCFG_323_.tb3_2(31),
RQCFG_323_.tb3_3(31),
RQCFG_323_.tb3_4(31),
RQCFG_323_.tb3_5(31),
RQCFG_323_.tb3_6(31),
RQCFG_323_.tb3_7(31),
RQCFG_323_.tb3_8(31),
null,
1924,
17,
'Direccion de Ejecucion de Trabajos'
,
'N'
,
'Y'
,
'Y'
,
17,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(31):=1646242;
RQCFG_323_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(31):=RQCFG_323_.tb5_0(31);
RQCFG_323_.old_tb5_1(31):=1035;
RQCFG_323_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(31),-1)));
RQCFG_323_.old_tb5_2(31):=null;
RQCFG_323_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(31),-1)));
RQCFG_323_.tb5_3(31):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(31):=RQCFG_323_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(31),
RQCFG_323_.tb5_1(31),
RQCFG_323_.tb5_2(31),
RQCFG_323_.tb5_3(31),
RQCFG_323_.tb5_4(31),
'Y'
,
'Y'
,
17,
'Y'
,
'Direccion de Ejecucion de Trabajos'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(32):=1159066;
RQCFG_323_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(32):=RQCFG_323_.tb3_0(32);
RQCFG_323_.old_tb3_1(32):=3334;
RQCFG_323_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(32),-1)));
RQCFG_323_.old_tb3_2(32):=187;
RQCFG_323_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(32),-1)));
RQCFG_323_.old_tb3_3(32):=null;
RQCFG_323_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(32),-1)));
RQCFG_323_.old_tb3_4(32):=null;
RQCFG_323_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(32),-1)));
RQCFG_323_.tb3_5(32):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(32):=121371447;
RQCFG_323_.tb3_6(32):=NULL;
RQCFG_323_.old_tb3_7(32):=null;
RQCFG_323_.tb3_7(32):=NULL;
RQCFG_323_.old_tb3_8(32):=null;
RQCFG_323_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(32),
RQCFG_323_.tb3_1(32),
RQCFG_323_.tb3_2(32),
RQCFG_323_.tb3_3(32),
RQCFG_323_.tb3_4(32),
RQCFG_323_.tb3_5(32),
RQCFG_323_.tb3_6(32),
RQCFG_323_.tb3_7(32),
RQCFG_323_.tb3_8(32),
null,
1907,
0,
'C¿digo'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(32):=1646243;
RQCFG_323_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(32):=RQCFG_323_.tb5_0(32);
RQCFG_323_.old_tb5_1(32):=187;
RQCFG_323_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(32),-1)));
RQCFG_323_.old_tb5_2(32):=null;
RQCFG_323_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(32),-1)));
RQCFG_323_.tb5_3(32):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(32):=RQCFG_323_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(32),
RQCFG_323_.tb5_1(32),
RQCFG_323_.tb5_2(32),
RQCFG_323_.tb5_3(32),
RQCFG_323_.tb5_4(32),
'C'
,
'Y'
,
0,
'N'
,
'C¿digo'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(33):=1159067;
RQCFG_323_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(33):=RQCFG_323_.tb3_0(33);
RQCFG_323_.old_tb3_1(33):=3334;
RQCFG_323_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(33),-1)));
RQCFG_323_.old_tb3_2(33):=213;
RQCFG_323_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(33),-1)));
RQCFG_323_.old_tb3_3(33):=255;
RQCFG_323_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(33),-1)));
RQCFG_323_.old_tb3_4(33):=null;
RQCFG_323_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(33),-1)));
RQCFG_323_.tb3_5(33):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(33):=null;
RQCFG_323_.tb3_6(33):=NULL;
RQCFG_323_.old_tb3_7(33):=null;
RQCFG_323_.tb3_7(33):=NULL;
RQCFG_323_.old_tb3_8(33):=null;
RQCFG_323_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(33),
RQCFG_323_.tb3_1(33),
RQCFG_323_.tb3_2(33),
RQCFG_323_.tb3_3(33),
RQCFG_323_.tb3_4(33),
RQCFG_323_.tb3_5(33),
RQCFG_323_.tb3_6(33),
RQCFG_323_.tb3_7(33),
RQCFG_323_.tb3_8(33),
null,
1908,
1,
'Solicitud'
,
'N'
,
'C'
,
'N'
,
1,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(33):=1646244;
RQCFG_323_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(33):=RQCFG_323_.tb5_0(33);
RQCFG_323_.old_tb5_1(33):=213;
RQCFG_323_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(33),-1)));
RQCFG_323_.old_tb5_2(33):=null;
RQCFG_323_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(33),-1)));
RQCFG_323_.tb5_3(33):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(33):=RQCFG_323_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(33),
RQCFG_323_.tb5_1(33),
RQCFG_323_.tb5_2(33),
RQCFG_323_.tb5_3(33),
RQCFG_323_.tb5_4(33),
'C'
,
'Y'
,
1,
'N'
,
'Solicitud'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(34):=1159068;
RQCFG_323_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(34):=RQCFG_323_.tb3_0(34);
RQCFG_323_.old_tb3_1(34):=3334;
RQCFG_323_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(34),-1)));
RQCFG_323_.old_tb3_2(34):=2875;
RQCFG_323_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(34),-1)));
RQCFG_323_.old_tb3_3(34):=null;
RQCFG_323_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(34),-1)));
RQCFG_323_.old_tb3_4(34):=null;
RQCFG_323_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(34),-1)));
RQCFG_323_.tb3_5(34):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(34):=121371444;
RQCFG_323_.tb3_6(34):=NULL;
RQCFG_323_.old_tb3_7(34):=null;
RQCFG_323_.tb3_7(34):=NULL;
RQCFG_323_.old_tb3_8(34):=null;
RQCFG_323_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(34),
RQCFG_323_.tb3_1(34),
RQCFG_323_.tb3_2(34),
RQCFG_323_.tb3_3(34),
RQCFG_323_.tb3_4(34),
RQCFG_323_.tb3_5(34),
RQCFG_323_.tb3_6(34),
RQCFG_323_.tb3_7(34),
RQCFG_323_.tb3_8(34),
null,
1909,
2,
'Id De Data For Order'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(34):=1646245;
RQCFG_323_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(34):=RQCFG_323_.tb5_0(34);
RQCFG_323_.old_tb5_1(34):=2875;
RQCFG_323_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(34),-1)));
RQCFG_323_.old_tb5_2(34):=null;
RQCFG_323_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(34),-1)));
RQCFG_323_.tb5_3(34):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(34):=RQCFG_323_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(34),
RQCFG_323_.tb5_1(34),
RQCFG_323_.tb5_2(34),
RQCFG_323_.tb5_3(34),
RQCFG_323_.tb5_4(34),
'C'
,
'Y'
,
2,
'N'
,
'Id De Data For Order'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(35):=1159069;
RQCFG_323_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(35):=RQCFG_323_.tb3_0(35);
RQCFG_323_.old_tb3_1(35):=3334;
RQCFG_323_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(35),-1)));
RQCFG_323_.old_tb3_2(35):=2877;
RQCFG_323_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(35),-1)));
RQCFG_323_.old_tb3_3(35):=187;
RQCFG_323_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(35),-1)));
RQCFG_323_.old_tb3_4(35):=null;
RQCFG_323_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(35),-1)));
RQCFG_323_.tb3_5(35):=RQCFG_323_.tb2_2(1);
RQCFG_323_.old_tb3_6(35):=null;
RQCFG_323_.tb3_6(35):=NULL;
RQCFG_323_.old_tb3_7(35):=null;
RQCFG_323_.tb3_7(35):=NULL;
RQCFG_323_.old_tb3_8(35):=null;
RQCFG_323_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(35),
RQCFG_323_.tb3_1(35),
RQCFG_323_.tb3_2(35),
RQCFG_323_.tb3_3(35),
RQCFG_323_.tb3_4(35),
RQCFG_323_.tb3_5(35),
RQCFG_323_.tb3_6(35),
RQCFG_323_.tb3_7(35),
RQCFG_323_.tb3_8(35),
null,
1910,
3,
'Id Del Motivo'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(35):=1646246;
RQCFG_323_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(35):=RQCFG_323_.tb5_0(35);
RQCFG_323_.old_tb5_1(35):=2877;
RQCFG_323_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(35),-1)));
RQCFG_323_.old_tb5_2(35):=null;
RQCFG_323_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(35),-1)));
RQCFG_323_.tb5_3(35):=RQCFG_323_.tb4_0(1);
RQCFG_323_.tb5_4(35):=RQCFG_323_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(35),
RQCFG_323_.tb5_1(35),
RQCFG_323_.tb5_2(35),
RQCFG_323_.tb5_3(35),
RQCFG_323_.tb5_4(35),
'C'
,
'Y'
,
3,
'N'
,
'Id Del Motivo'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(36):=1159082;
RQCFG_323_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(36):=RQCFG_323_.tb3_0(36);
RQCFG_323_.old_tb3_1(36):=2036;
RQCFG_323_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(36),-1)));
RQCFG_323_.old_tb3_2(36):=2683;
RQCFG_323_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(36),-1)));
RQCFG_323_.old_tb3_3(36):=null;
RQCFG_323_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(36),-1)));
RQCFG_323_.old_tb3_4(36):=null;
RQCFG_323_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(36),-1)));
RQCFG_323_.tb3_5(36):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(36):=121371430;
RQCFG_323_.tb3_6(36):=NULL;
RQCFG_323_.old_tb3_7(36):=null;
RQCFG_323_.tb3_7(36):=NULL;
RQCFG_323_.old_tb3_8(36):=120188090;
RQCFG_323_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(36),
RQCFG_323_.tb3_1(36),
RQCFG_323_.tb3_2(36),
RQCFG_323_.tb3_3(36),
RQCFG_323_.tb3_4(36),
RQCFG_323_.tb3_5(36),
RQCFG_323_.tb3_6(36),
RQCFG_323_.tb3_7(36),
RQCFG_323_.tb3_8(36),
null,
1843,
5,
'Medio de Recepci¿n'
,
'N'
,
'Y'
,
'Y'
,
5,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb4_0(2):=5443;
RQCFG_323_.tb4_0(2):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_323_.tb4_0(2):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb4_1(2):=RQCFG_323_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (2)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_323_.tb4_0(2),
RQCFG_323_.tb4_1(2),
null,
null,
'FRAME-PAQUETE-1069802'
,
1);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(36):=1646259;
RQCFG_323_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(36):=RQCFG_323_.tb5_0(36);
RQCFG_323_.old_tb5_1(36):=2683;
RQCFG_323_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(36),-1)));
RQCFG_323_.old_tb5_2(36):=null;
RQCFG_323_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(36),-1)));
RQCFG_323_.tb5_3(36):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(36):=RQCFG_323_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(36),
RQCFG_323_.tb5_1(36),
RQCFG_323_.tb5_2(36),
RQCFG_323_.tb5_3(36),
RQCFG_323_.tb5_4(36),
'Y'
,
'Y'
,
5,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(37):=1159096;
RQCFG_323_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(37):=RQCFG_323_.tb3_0(37);
RQCFG_323_.old_tb3_1(37):=2036;
RQCFG_323_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(37),-1)));
RQCFG_323_.old_tb3_2(37):=90167565;
RQCFG_323_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(37),-1)));
RQCFG_323_.old_tb3_3(37):=null;
RQCFG_323_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(37),-1)));
RQCFG_323_.old_tb3_4(37):=null;
RQCFG_323_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(37),-1)));
RQCFG_323_.tb3_5(37):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(37):=null;
RQCFG_323_.tb3_6(37):=NULL;
RQCFG_323_.old_tb3_7(37):=null;
RQCFG_323_.tb3_7(37):=NULL;
RQCFG_323_.old_tb3_8(37):=120188091;
RQCFG_323_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(37),
RQCFG_323_.tb3_1(37),
RQCFG_323_.tb3_2(37),
RQCFG_323_.tb3_3(37),
RQCFG_323_.tb3_4(37),
RQCFG_323_.tb3_5(37),
RQCFG_323_.tb3_6(37),
RQCFG_323_.tb3_7(37),
RQCFG_323_.tb3_8(37),
null,
108573,
20,
'Unidad de trabajo instaladora'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(37):=1646273;
RQCFG_323_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(37):=RQCFG_323_.tb5_0(37);
RQCFG_323_.old_tb5_1(37):=90167565;
RQCFG_323_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(37),-1)));
RQCFG_323_.old_tb5_2(37):=null;
RQCFG_323_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(37),-1)));
RQCFG_323_.tb5_3(37):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(37):=RQCFG_323_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(37),
RQCFG_323_.tb5_1(37),
RQCFG_323_.tb5_2(37),
RQCFG_323_.tb5_3(37),
RQCFG_323_.tb5_4(37),
'Y'
,
'Y'
,
20,
'N'
,
'Unidad de trabajo instaladora'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(38):=1159097;
RQCFG_323_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(38):=RQCFG_323_.tb3_0(38);
RQCFG_323_.old_tb3_1(38):=2036;
RQCFG_323_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(38),-1)));
RQCFG_323_.old_tb3_2(38):=90167566;
RQCFG_323_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(38),-1)));
RQCFG_323_.old_tb3_3(38):=null;
RQCFG_323_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(38),-1)));
RQCFG_323_.old_tb3_4(38):=null;
RQCFG_323_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(38),-1)));
RQCFG_323_.tb3_5(38):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(38):=null;
RQCFG_323_.tb3_6(38):=NULL;
RQCFG_323_.old_tb3_7(38):=null;
RQCFG_323_.tb3_7(38):=NULL;
RQCFG_323_.old_tb3_8(38):=120188092;
RQCFG_323_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(38),
RQCFG_323_.tb3_1(38),
RQCFG_323_.tb3_2(38),
RQCFG_323_.tb3_3(38),
RQCFG_323_.tb3_4(38),
RQCFG_323_.tb3_5(38),
RQCFG_323_.tb3_6(38),
RQCFG_323_.tb3_7(38),
RQCFG_323_.tb3_8(38),
null,
108574,
21,
'Unidad de trabajo certificadora'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(38):=1646274;
RQCFG_323_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(38):=RQCFG_323_.tb5_0(38);
RQCFG_323_.old_tb5_1(38):=90167566;
RQCFG_323_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(38),-1)));
RQCFG_323_.old_tb5_2(38):=null;
RQCFG_323_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(38),-1)));
RQCFG_323_.tb5_3(38):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(38):=RQCFG_323_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(38),
RQCFG_323_.tb5_1(38),
RQCFG_323_.tb5_2(38),
RQCFG_323_.tb5_3(38),
RQCFG_323_.tb5_4(38),
'Y'
,
'Y'
,
21,
'N'
,
'Unidad de trabajo certificadora'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(39):=1159098;
RQCFG_323_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(39):=RQCFG_323_.tb3_0(39);
RQCFG_323_.old_tb3_1(39):=2036;
RQCFG_323_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(39),-1)));
RQCFG_323_.old_tb3_2(39):=259;
RQCFG_323_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(39),-1)));
RQCFG_323_.old_tb3_3(39):=null;
RQCFG_323_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(39),-1)));
RQCFG_323_.old_tb3_4(39):=null;
RQCFG_323_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(39),-1)));
RQCFG_323_.tb3_5(39):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(39):=121371434;
RQCFG_323_.tb3_6(39):=NULL;
RQCFG_323_.old_tb3_7(39):=null;
RQCFG_323_.tb3_7(39):=NULL;
RQCFG_323_.old_tb3_8(39):=null;
RQCFG_323_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(39),
RQCFG_323_.tb3_1(39),
RQCFG_323_.tb3_2(39),
RQCFG_323_.tb3_3(39),
RQCFG_323_.tb3_4(39),
RQCFG_323_.tb3_5(39),
RQCFG_323_.tb3_6(39),
RQCFG_323_.tb3_7(39),
RQCFG_323_.tb3_8(39),
null,
1850,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(39):=1646275;
RQCFG_323_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(39):=RQCFG_323_.tb5_0(39);
RQCFG_323_.old_tb5_1(39):=259;
RQCFG_323_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(39),-1)));
RQCFG_323_.old_tb5_2(39):=null;
RQCFG_323_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(39),-1)));
RQCFG_323_.tb5_3(39):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(39):=RQCFG_323_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(39),
RQCFG_323_.tb5_1(39),
RQCFG_323_.tb5_2(39),
RQCFG_323_.tb5_3(39),
RQCFG_323_.tb5_4(39),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(40):=1159099;
RQCFG_323_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(40):=RQCFG_323_.tb3_0(40);
RQCFG_323_.old_tb3_1(40):=2036;
RQCFG_323_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(40),-1)));
RQCFG_323_.old_tb3_2(40):=11619;
RQCFG_323_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(40),-1)));
RQCFG_323_.old_tb3_3(40):=null;
RQCFG_323_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(40),-1)));
RQCFG_323_.old_tb3_4(40):=null;
RQCFG_323_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(40),-1)));
RQCFG_323_.tb3_5(40):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(40):=null;
RQCFG_323_.tb3_6(40):=NULL;
RQCFG_323_.old_tb3_7(40):=null;
RQCFG_323_.tb3_7(40):=NULL;
RQCFG_323_.old_tb3_8(40):=null;
RQCFG_323_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(40),
RQCFG_323_.tb3_1(40),
RQCFG_323_.tb3_2(40),
RQCFG_323_.tb3_3(40),
RQCFG_323_.tb3_4(40),
RQCFG_323_.tb3_5(40),
RQCFG_323_.tb3_6(40),
RQCFG_323_.tb3_7(40),
RQCFG_323_.tb3_8(40),
null,
1852,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(40):=1646276;
RQCFG_323_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(40):=RQCFG_323_.tb5_0(40);
RQCFG_323_.old_tb5_1(40):=11619;
RQCFG_323_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(40),-1)));
RQCFG_323_.old_tb5_2(40):=null;
RQCFG_323_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(40),-1)));
RQCFG_323_.tb5_3(40):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(40):=RQCFG_323_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(40),
RQCFG_323_.tb5_1(40),
RQCFG_323_.tb5_2(40),
RQCFG_323_.tb5_3(40),
RQCFG_323_.tb5_4(40),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(41):=1159100;
RQCFG_323_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(41):=RQCFG_323_.tb3_0(41);
RQCFG_323_.old_tb3_1(41):=2036;
RQCFG_323_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(41),-1)));
RQCFG_323_.old_tb3_2(41):=2826;
RQCFG_323_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(41),-1)));
RQCFG_323_.old_tb3_3(41):=null;
RQCFG_323_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(41),-1)));
RQCFG_323_.old_tb3_4(41):=null;
RQCFG_323_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(41),-1)));
RQCFG_323_.tb3_5(41):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(41):=121371435;
RQCFG_323_.tb3_6(41):=NULL;
RQCFG_323_.old_tb3_7(41):=null;
RQCFG_323_.tb3_7(41):=NULL;
RQCFG_323_.old_tb3_8(41):=null;
RQCFG_323_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(41),
RQCFG_323_.tb3_1(41),
RQCFG_323_.tb3_2(41),
RQCFG_323_.tb3_3(41),
RQCFG_323_.tb3_4(41),
RQCFG_323_.tb3_5(41),
RQCFG_323_.tb3_6(41),
RQCFG_323_.tb3_7(41),
RQCFG_323_.tb3_8(41),
null,
1853,
15,
'Informacion de Contrato'
,
'N'
,
'Y'
,
'Y'
,
15,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(41):=1646277;
RQCFG_323_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(41):=RQCFG_323_.tb5_0(41);
RQCFG_323_.old_tb5_1(41):=2826;
RQCFG_323_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(41),-1)));
RQCFG_323_.old_tb5_2(41):=null;
RQCFG_323_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(41),-1)));
RQCFG_323_.tb5_3(41):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(41):=RQCFG_323_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(41),
RQCFG_323_.tb5_1(41),
RQCFG_323_.tb5_2(41),
RQCFG_323_.tb5_3(41),
RQCFG_323_.tb5_4(41),
'Y'
,
'E'
,
15,
'Y'
,
'Informacion de Contrato'
,
'N'
,
'N'
,
'U'
,
null,
82,
null,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(42):=1159101;
RQCFG_323_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(42):=RQCFG_323_.tb3_0(42);
RQCFG_323_.old_tb3_1(42):=2036;
RQCFG_323_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(42),-1)));
RQCFG_323_.old_tb3_2(42):=191044;
RQCFG_323_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(42),-1)));
RQCFG_323_.old_tb3_3(42):=null;
RQCFG_323_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(42),-1)));
RQCFG_323_.old_tb3_4(42):=null;
RQCFG_323_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(42),-1)));
RQCFG_323_.tb3_5(42):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(42):=121371436;
RQCFG_323_.tb3_6(42):=NULL;
RQCFG_323_.old_tb3_7(42):=null;
RQCFG_323_.tb3_7(42):=NULL;
RQCFG_323_.old_tb3_8(42):=null;
RQCFG_323_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(42),
RQCFG_323_.tb3_1(42),
RQCFG_323_.tb3_2(42),
RQCFG_323_.tb3_3(42),
RQCFG_323_.tb3_4(42),
RQCFG_323_.tb3_5(42),
RQCFG_323_.tb3_6(42),
RQCFG_323_.tb3_7(42),
RQCFG_323_.tb3_8(42),
null,
1854,
16,
'Facturaci¿n Es En La Recurrente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(42):=1646278;
RQCFG_323_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(42):=RQCFG_323_.tb5_0(42);
RQCFG_323_.old_tb5_1(42):=191044;
RQCFG_323_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(42),-1)));
RQCFG_323_.old_tb5_2(42):=null;
RQCFG_323_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(42),-1)));
RQCFG_323_.tb5_3(42):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(42):=RQCFG_323_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(42),
RQCFG_323_.tb5_1(42),
RQCFG_323_.tb5_2(42),
RQCFG_323_.tb5_3(42),
RQCFG_323_.tb5_4(42),
'C'
,
'Y'
,
16,
'N'
,
'Facturaci¿n Es En La Recurrente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(43):=1159102;
RQCFG_323_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(43):=RQCFG_323_.tb3_0(43);
RQCFG_323_.old_tb3_1(43):=2036;
RQCFG_323_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(43),-1)));
RQCFG_323_.old_tb3_2(43):=4015;
RQCFG_323_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(43),-1)));
RQCFG_323_.old_tb3_3(43):=null;
RQCFG_323_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(43),-1)));
RQCFG_323_.old_tb3_4(43):=null;
RQCFG_323_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(43),-1)));
RQCFG_323_.tb3_5(43):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(43):=121371421;
RQCFG_323_.tb3_6(43):=NULL;
RQCFG_323_.old_tb3_7(43):=121371422;
RQCFG_323_.tb3_7(43):=NULL;
RQCFG_323_.old_tb3_8(43):=null;
RQCFG_323_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(43),
RQCFG_323_.tb3_1(43),
RQCFG_323_.tb3_2(43),
RQCFG_323_.tb3_3(43),
RQCFG_323_.tb3_4(43),
RQCFG_323_.tb3_5(43),
RQCFG_323_.tb3_6(43),
RQCFG_323_.tb3_7(43),
RQCFG_323_.tb3_8(43),
null,
2029,
6,
'Identificador del Cliente'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(43):=1646279;
RQCFG_323_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(43):=RQCFG_323_.tb5_0(43);
RQCFG_323_.old_tb5_1(43):=4015;
RQCFG_323_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(43),-1)));
RQCFG_323_.old_tb5_2(43):=null;
RQCFG_323_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(43),-1)));
RQCFG_323_.tb5_3(43):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(43):=RQCFG_323_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(43),
RQCFG_323_.tb5_1(43),
RQCFG_323_.tb5_2(43),
RQCFG_323_.tb5_3(43),
RQCFG_323_.tb5_4(43),
'Y'
,
'Y'
,
6,
'Y'
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
122,
null,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(44):=1159103;
RQCFG_323_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(44):=RQCFG_323_.tb3_0(44);
RQCFG_323_.old_tb3_1(44):=2036;
RQCFG_323_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(44),-1)));
RQCFG_323_.old_tb3_2(44):=257;
RQCFG_323_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(44),-1)));
RQCFG_323_.old_tb3_3(44):=null;
RQCFG_323_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(44),-1)));
RQCFG_323_.old_tb3_4(44):=null;
RQCFG_323_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(44),-1)));
RQCFG_323_.tb3_5(44):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(44):=121371423;
RQCFG_323_.tb3_6(44):=NULL;
RQCFG_323_.old_tb3_7(44):=null;
RQCFG_323_.tb3_7(44):=NULL;
RQCFG_323_.old_tb3_8(44):=null;
RQCFG_323_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(44),
RQCFG_323_.tb3_1(44),
RQCFG_323_.tb3_2(44),
RQCFG_323_.tb3_3(44),
RQCFG_323_.tb3_4(44),
RQCFG_323_.tb3_5(44),
RQCFG_323_.tb3_6(44),
RQCFG_323_.tb3_7(44),
RQCFG_323_.tb3_8(44),
null,
1838,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(44):=1646280;
RQCFG_323_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(44):=RQCFG_323_.tb5_0(44);
RQCFG_323_.old_tb5_1(44):=257;
RQCFG_323_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(44),-1)));
RQCFG_323_.old_tb5_2(44):=null;
RQCFG_323_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(44),-1)));
RQCFG_323_.tb5_3(44):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(44):=RQCFG_323_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(44),
RQCFG_323_.tb5_1(44),
RQCFG_323_.tb5_2(44),
RQCFG_323_.tb5_3(44),
RQCFG_323_.tb5_4(44),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(45):=1159104;
RQCFG_323_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(45):=RQCFG_323_.tb3_0(45);
RQCFG_323_.old_tb3_1(45):=2036;
RQCFG_323_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(45),-1)));
RQCFG_323_.old_tb3_2(45):=258;
RQCFG_323_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(45),-1)));
RQCFG_323_.old_tb3_3(45):=null;
RQCFG_323_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(45),-1)));
RQCFG_323_.old_tb3_4(45):=null;
RQCFG_323_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(45),-1)));
RQCFG_323_.tb3_5(45):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(45):=121371424;
RQCFG_323_.tb3_6(45):=NULL;
RQCFG_323_.old_tb3_7(45):=121371425;
RQCFG_323_.tb3_7(45):=NULL;
RQCFG_323_.old_tb3_8(45):=null;
RQCFG_323_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(45),
RQCFG_323_.tb3_1(45),
RQCFG_323_.tb3_2(45),
RQCFG_323_.tb3_3(45),
RQCFG_323_.tb3_4(45),
RQCFG_323_.tb3_5(45),
RQCFG_323_.tb3_6(45),
RQCFG_323_.tb3_7(45),
RQCFG_323_.tb3_8(45),
null,
1839,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(45):=1646281;
RQCFG_323_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(45):=RQCFG_323_.tb5_0(45);
RQCFG_323_.old_tb5_1(45):=258;
RQCFG_323_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(45),-1)));
RQCFG_323_.old_tb5_2(45):=null;
RQCFG_323_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(45),-1)));
RQCFG_323_.tb5_3(45):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(45):=RQCFG_323_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(45),
RQCFG_323_.tb5_1(45),
RQCFG_323_.tb5_2(45),
RQCFG_323_.tb5_3(45),
RQCFG_323_.tb5_4(45),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(46):=1159105;
RQCFG_323_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(46):=RQCFG_323_.tb3_0(46);
RQCFG_323_.old_tb3_1(46):=2036;
RQCFG_323_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(46),-1)));
RQCFG_323_.old_tb3_2(46):=255;
RQCFG_323_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(46),-1)));
RQCFG_323_.old_tb3_3(46):=null;
RQCFG_323_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(46),-1)));
RQCFG_323_.old_tb3_4(46):=null;
RQCFG_323_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(46),-1)));
RQCFG_323_.tb3_5(46):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(46):=null;
RQCFG_323_.tb3_6(46):=NULL;
RQCFG_323_.old_tb3_7(46):=121371426;
RQCFG_323_.tb3_7(46):=NULL;
RQCFG_323_.old_tb3_8(46):=null;
RQCFG_323_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(46),
RQCFG_323_.tb3_1(46),
RQCFG_323_.tb3_2(46),
RQCFG_323_.tb3_3(46),
RQCFG_323_.tb3_4(46),
RQCFG_323_.tb3_5(46),
RQCFG_323_.tb3_6(46),
RQCFG_323_.tb3_7(46),
RQCFG_323_.tb3_8(46),
null,
1840,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(46):=1646282;
RQCFG_323_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(46):=RQCFG_323_.tb5_0(46);
RQCFG_323_.old_tb5_1(46):=255;
RQCFG_323_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(46),-1)));
RQCFG_323_.old_tb5_2(46):=null;
RQCFG_323_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(46),-1)));
RQCFG_323_.tb5_3(46):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(46):=RQCFG_323_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(46),
RQCFG_323_.tb5_1(46),
RQCFG_323_.tb5_2(46),
RQCFG_323_.tb5_3(46),
RQCFG_323_.tb5_4(46),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(47):=1159083;
RQCFG_323_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(47):=RQCFG_323_.tb3_0(47);
RQCFG_323_.old_tb3_1(47):=2036;
RQCFG_323_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(47),-1)));
RQCFG_323_.old_tb3_2(47):=50001162;
RQCFG_323_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(47),-1)));
RQCFG_323_.old_tb3_3(47):=null;
RQCFG_323_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(47),-1)));
RQCFG_323_.old_tb3_4(47):=null;
RQCFG_323_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(47),-1)));
RQCFG_323_.tb3_5(47):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(47):=121371427;
RQCFG_323_.tb3_6(47):=NULL;
RQCFG_323_.old_tb3_7(47):=121371428;
RQCFG_323_.tb3_7(47):=NULL;
RQCFG_323_.old_tb3_8(47):=120188088;
RQCFG_323_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(47),
RQCFG_323_.tb3_1(47),
RQCFG_323_.tb3_2(47),
RQCFG_323_.tb3_3(47),
RQCFG_323_.tb3_4(47),
RQCFG_323_.tb3_5(47),
RQCFG_323_.tb3_6(47),
RQCFG_323_.tb3_7(47),
RQCFG_323_.tb3_8(47),
null,
1841,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(47):=1646260;
RQCFG_323_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(47):=RQCFG_323_.tb5_0(47);
RQCFG_323_.old_tb5_1(47):=50001162;
RQCFG_323_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(47),-1)));
RQCFG_323_.old_tb5_2(47):=null;
RQCFG_323_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(47),-1)));
RQCFG_323_.tb5_3(47):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(47):=RQCFG_323_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(47),
RQCFG_323_.tb5_1(47),
RQCFG_323_.tb5_2(47),
RQCFG_323_.tb5_3(47),
RQCFG_323_.tb5_4(47),
'Y'
,
'Y'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(48):=1159084;
RQCFG_323_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(48):=RQCFG_323_.tb3_0(48);
RQCFG_323_.old_tb3_1(48):=2036;
RQCFG_323_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(48),-1)));
RQCFG_323_.old_tb3_2(48):=109479;
RQCFG_323_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(48),-1)));
RQCFG_323_.old_tb3_3(48):=null;
RQCFG_323_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(48),-1)));
RQCFG_323_.old_tb3_4(48):=null;
RQCFG_323_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(48),-1)));
RQCFG_323_.tb3_5(48):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(48):=121371429;
RQCFG_323_.tb3_6(48):=NULL;
RQCFG_323_.old_tb3_7(48):=null;
RQCFG_323_.tb3_7(48):=NULL;
RQCFG_323_.old_tb3_8(48):=120188089;
RQCFG_323_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(48),
RQCFG_323_.tb3_1(48),
RQCFG_323_.tb3_2(48),
RQCFG_323_.tb3_3(48),
RQCFG_323_.tb3_4(48),
RQCFG_323_.tb3_5(48),
RQCFG_323_.tb3_6(48),
RQCFG_323_.tb3_7(48),
RQCFG_323_.tb3_8(48),
null,
1842,
4,
'Punto de Atenci¿n'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(48):=1646261;
RQCFG_323_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(48):=RQCFG_323_.tb5_0(48);
RQCFG_323_.old_tb5_1(48):=109479;
RQCFG_323_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(48),-1)));
RQCFG_323_.old_tb5_2(48):=null;
RQCFG_323_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(48),-1)));
RQCFG_323_.tb5_3(48):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(48):=RQCFG_323_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(48),
RQCFG_323_.tb5_1(48),
RQCFG_323_.tb5_2(48),
RQCFG_323_.tb5_3(48),
RQCFG_323_.tb5_4(48),
'Y'
,
'N'
,
4,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(49):=1159085;
RQCFG_323_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(49):=RQCFG_323_.tb3_0(49);
RQCFG_323_.old_tb3_1(49):=2036;
RQCFG_323_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(49),-1)));
RQCFG_323_.old_tb3_2(49):=146755;
RQCFG_323_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(49),-1)));
RQCFG_323_.old_tb3_3(49):=null;
RQCFG_323_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(49),-1)));
RQCFG_323_.old_tb3_4(49):=null;
RQCFG_323_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(49),-1)));
RQCFG_323_.tb3_5(49):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(49):=121371431;
RQCFG_323_.tb3_6(49):=NULL;
RQCFG_323_.old_tb3_7(49):=null;
RQCFG_323_.tb3_7(49):=NULL;
RQCFG_323_.old_tb3_8(49):=null;
RQCFG_323_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(49),
RQCFG_323_.tb3_1(49),
RQCFG_323_.tb3_2(49),
RQCFG_323_.tb3_3(49),
RQCFG_323_.tb3_4(49),
RQCFG_323_.tb3_5(49),
RQCFG_323_.tb3_6(49),
RQCFG_323_.tb3_7(49),
RQCFG_323_.tb3_8(49),
null,
1844,
7,
'Informaci¿n del Solicitante'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(49):=1646262;
RQCFG_323_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(49):=RQCFG_323_.tb5_0(49);
RQCFG_323_.old_tb5_1(49):=146755;
RQCFG_323_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(49),-1)));
RQCFG_323_.old_tb5_2(49):=null;
RQCFG_323_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(49),-1)));
RQCFG_323_.tb5_3(49):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(49):=RQCFG_323_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(49),
RQCFG_323_.tb5_1(49),
RQCFG_323_.tb5_2(49),
RQCFG_323_.tb5_3(49),
RQCFG_323_.tb5_4(49),
'Y'
,
'E'
,
7,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(50):=1159086;
RQCFG_323_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(50):=RQCFG_323_.tb3_0(50);
RQCFG_323_.old_tb3_1(50):=2036;
RQCFG_323_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(50),-1)));
RQCFG_323_.old_tb3_2(50):=146756;
RQCFG_323_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(50),-1)));
RQCFG_323_.old_tb3_3(50):=null;
RQCFG_323_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(50),-1)));
RQCFG_323_.old_tb3_4(50):=null;
RQCFG_323_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(50),-1)));
RQCFG_323_.tb3_5(50):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(50):=121371432;
RQCFG_323_.tb3_6(50):=NULL;
RQCFG_323_.old_tb3_7(50):=null;
RQCFG_323_.tb3_7(50):=NULL;
RQCFG_323_.old_tb3_8(50):=null;
RQCFG_323_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(50),
RQCFG_323_.tb3_1(50),
RQCFG_323_.tb3_2(50),
RQCFG_323_.tb3_3(50),
RQCFG_323_.tb3_4(50),
RQCFG_323_.tb3_5(50),
RQCFG_323_.tb3_6(50),
RQCFG_323_.tb3_7(50),
RQCFG_323_.tb3_8(50),
null,
1845,
8,
'Direcci¿n de Respuesta'
,
'N'
,
'Y'
,
'N'
,
8,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(50):=1646263;
RQCFG_323_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(50):=RQCFG_323_.tb5_0(50);
RQCFG_323_.old_tb5_1(50):=146756;
RQCFG_323_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(50),-1)));
RQCFG_323_.old_tb5_2(50):=null;
RQCFG_323_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(50),-1)));
RQCFG_323_.tb5_3(50):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(50):=RQCFG_323_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(50),
RQCFG_323_.tb5_1(50),
RQCFG_323_.tb5_2(50),
RQCFG_323_.tb5_3(50),
RQCFG_323_.tb5_4(50),
'Y'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(51):=1159087;
RQCFG_323_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(51):=RQCFG_323_.tb3_0(51);
RQCFG_323_.old_tb3_1(51):=2036;
RQCFG_323_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(51),-1)));
RQCFG_323_.old_tb3_2(51):=146754;
RQCFG_323_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(51),-1)));
RQCFG_323_.old_tb3_3(51):=null;
RQCFG_323_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(51),-1)));
RQCFG_323_.old_tb3_4(51):=null;
RQCFG_323_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(51),-1)));
RQCFG_323_.tb3_5(51):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(51):=null;
RQCFG_323_.tb3_6(51):=NULL;
RQCFG_323_.old_tb3_7(51):=null;
RQCFG_323_.tb3_7(51):=NULL;
RQCFG_323_.old_tb3_8(51):=null;
RQCFG_323_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(51),
RQCFG_323_.tb3_1(51),
RQCFG_323_.tb3_2(51),
RQCFG_323_.tb3_3(51),
RQCFG_323_.tb3_4(51),
RQCFG_323_.tb3_5(51),
RQCFG_323_.tb3_6(51),
RQCFG_323_.tb3_7(51),
RQCFG_323_.tb3_8(51),
null,
1846,
9,
'Observaci¿n'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(51):=1646264;
RQCFG_323_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(51):=RQCFG_323_.tb5_0(51);
RQCFG_323_.old_tb5_1(51):=146754;
RQCFG_323_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(51),-1)));
RQCFG_323_.old_tb5_2(51):=null;
RQCFG_323_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(51),-1)));
RQCFG_323_.tb5_3(51):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(51):=RQCFG_323_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(51),
RQCFG_323_.tb5_1(51),
RQCFG_323_.tb5_2(51),
RQCFG_323_.tb5_3(51),
RQCFG_323_.tb5_4(51),
'Y'
,
'Y'
,
9,
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
null,
null,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(52):=1159088;
RQCFG_323_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(52):=RQCFG_323_.tb3_0(52);
RQCFG_323_.old_tb3_1(52):=2036;
RQCFG_323_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(52),-1)));
RQCFG_323_.old_tb3_2(52):=269;
RQCFG_323_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(52),-1)));
RQCFG_323_.old_tb3_3(52):=null;
RQCFG_323_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(52),-1)));
RQCFG_323_.old_tb3_4(52):=null;
RQCFG_323_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(52),-1)));
RQCFG_323_.tb3_5(52):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(52):=null;
RQCFG_323_.tb3_6(52):=NULL;
RQCFG_323_.old_tb3_7(52):=null;
RQCFG_323_.tb3_7(52):=NULL;
RQCFG_323_.old_tb3_8(52):=null;
RQCFG_323_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(52),
RQCFG_323_.tb3_1(52),
RQCFG_323_.tb3_2(52),
RQCFG_323_.tb3_3(52),
RQCFG_323_.tb3_4(52),
RQCFG_323_.tb3_5(52),
RQCFG_323_.tb3_6(52),
RQCFG_323_.tb3_7(52),
RQCFG_323_.tb3_8(52),
null,
1847,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(52):=1646265;
RQCFG_323_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(52):=RQCFG_323_.tb5_0(52);
RQCFG_323_.old_tb5_1(52):=269;
RQCFG_323_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(52),-1)));
RQCFG_323_.old_tb5_2(52):=null;
RQCFG_323_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(52),-1)));
RQCFG_323_.tb5_3(52):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(52):=RQCFG_323_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(52),
RQCFG_323_.tb5_1(52),
RQCFG_323_.tb5_2(52),
RQCFG_323_.tb5_3(52),
RQCFG_323_.tb5_4(52),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(53):=1159089;
RQCFG_323_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(53):=RQCFG_323_.tb3_0(53);
RQCFG_323_.old_tb3_1(53):=2036;
RQCFG_323_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(53),-1)));
RQCFG_323_.old_tb3_2(53):=109478;
RQCFG_323_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(53),-1)));
RQCFG_323_.old_tb3_3(53):=null;
RQCFG_323_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(53),-1)));
RQCFG_323_.old_tb3_4(53):=null;
RQCFG_323_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(53),-1)));
RQCFG_323_.tb3_5(53):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(53):=null;
RQCFG_323_.tb3_6(53):=NULL;
RQCFG_323_.old_tb3_7(53):=null;
RQCFG_323_.tb3_7(53):=NULL;
RQCFG_323_.old_tb3_8(53):=null;
RQCFG_323_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(53),
RQCFG_323_.tb3_1(53),
RQCFG_323_.tb3_2(53),
RQCFG_323_.tb3_3(53),
RQCFG_323_.tb3_4(53),
RQCFG_323_.tb3_5(53),
RQCFG_323_.tb3_6(53),
RQCFG_323_.tb3_7(53),
RQCFG_323_.tb3_8(53),
null,
1848,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(53):=1646266;
RQCFG_323_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(53):=RQCFG_323_.tb5_0(53);
RQCFG_323_.old_tb5_1(53):=109478;
RQCFG_323_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(53),-1)));
RQCFG_323_.old_tb5_2(53):=null;
RQCFG_323_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(53),-1)));
RQCFG_323_.tb5_3(53):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(53):=RQCFG_323_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(53),
RQCFG_323_.tb5_1(53),
RQCFG_323_.tb5_2(53),
RQCFG_323_.tb5_3(53),
RQCFG_323_.tb5_4(53),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(54):=1159090;
RQCFG_323_.tb3_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(54):=RQCFG_323_.tb3_0(54);
RQCFG_323_.old_tb3_1(54):=2036;
RQCFG_323_.tb3_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(54),-1)));
RQCFG_323_.old_tb3_2(54):=42118;
RQCFG_323_.tb3_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(54),-1)));
RQCFG_323_.old_tb3_3(54):=109479;
RQCFG_323_.tb3_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(54),-1)));
RQCFG_323_.old_tb3_4(54):=null;
RQCFG_323_.tb3_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(54),-1)));
RQCFG_323_.tb3_5(54):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(54):=null;
RQCFG_323_.tb3_6(54):=NULL;
RQCFG_323_.old_tb3_7(54):=null;
RQCFG_323_.tb3_7(54):=NULL;
RQCFG_323_.old_tb3_8(54):=null;
RQCFG_323_.tb3_8(54):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(54),
RQCFG_323_.tb3_1(54),
RQCFG_323_.tb3_2(54),
RQCFG_323_.tb3_3(54),
RQCFG_323_.tb3_4(54),
RQCFG_323_.tb3_5(54),
RQCFG_323_.tb3_6(54),
RQCFG_323_.tb3_7(54),
RQCFG_323_.tb3_8(54),
null,
1849,
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(54):=1646267;
RQCFG_323_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(54):=RQCFG_323_.tb5_0(54);
RQCFG_323_.old_tb5_1(54):=42118;
RQCFG_323_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(54),-1)));
RQCFG_323_.old_tb5_2(54):=null;
RQCFG_323_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(54),-1)));
RQCFG_323_.tb5_3(54):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(54):=RQCFG_323_.tb3_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(54),
RQCFG_323_.tb5_1(54),
RQCFG_323_.tb5_2(54),
RQCFG_323_.tb5_3(54),
RQCFG_323_.tb5_4(54),
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(55):=1159091;
RQCFG_323_.tb3_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(55):=RQCFG_323_.tb3_0(55);
RQCFG_323_.old_tb3_1(55):=2036;
RQCFG_323_.tb3_1(55):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(55),-1)));
RQCFG_323_.old_tb3_2(55):=90168710;
RQCFG_323_.tb3_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(55),-1)));
RQCFG_323_.old_tb3_3(55):=255;
RQCFG_323_.tb3_3(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(55),-1)));
RQCFG_323_.old_tb3_4(55):=null;
RQCFG_323_.tb3_4(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(55),-1)));
RQCFG_323_.tb3_5(55):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(55):=null;
RQCFG_323_.tb3_6(55):=NULL;
RQCFG_323_.old_tb3_7(55):=null;
RQCFG_323_.tb3_7(55):=NULL;
RQCFG_323_.old_tb3_8(55):=null;
RQCFG_323_.tb3_8(55):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (55)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(55),
RQCFG_323_.tb3_1(55),
RQCFG_323_.tb3_2(55),
RQCFG_323_.tb3_3(55),
RQCFG_323_.tb3_4(55),
RQCFG_323_.tb3_5(55),
RQCFG_323_.tb3_6(55),
RQCFG_323_.tb3_7(55),
RQCFG_323_.tb3_8(55),
null,
108725,
22,
'Identificador de la solicitud'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(55):=1646268;
RQCFG_323_.tb5_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(55):=RQCFG_323_.tb5_0(55);
RQCFG_323_.old_tb5_1(55):=90168710;
RQCFG_323_.tb5_1(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(55),-1)));
RQCFG_323_.old_tb5_2(55):=null;
RQCFG_323_.tb5_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(55),-1)));
RQCFG_323_.tb5_3(55):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(55):=RQCFG_323_.tb3_0(55);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(55),
RQCFG_323_.tb5_1(55),
RQCFG_323_.tb5_2(55),
RQCFG_323_.tb5_3(55),
RQCFG_323_.tb5_4(55),
'C'
,
'Y'
,
22,
'N'
,
'Identificador de la solicitud'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(56):=1159092;
RQCFG_323_.tb3_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(56):=RQCFG_323_.tb3_0(56);
RQCFG_323_.old_tb3_1(56):=2036;
RQCFG_323_.tb3_1(56):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(56),-1)));
RQCFG_323_.old_tb3_2(56):=90168711;
RQCFG_323_.tb3_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(56),-1)));
RQCFG_323_.old_tb3_3(56):=null;
RQCFG_323_.tb3_3(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(56),-1)));
RQCFG_323_.old_tb3_4(56):=null;
RQCFG_323_.tb3_4(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(56),-1)));
RQCFG_323_.tb3_5(56):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(56):=null;
RQCFG_323_.tb3_6(56):=NULL;
RQCFG_323_.old_tb3_7(56):=121371420;
RQCFG_323_.tb3_7(56):=NULL;
RQCFG_323_.old_tb3_8(56):=null;
RQCFG_323_.tb3_8(56):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (56)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(56),
RQCFG_323_.tb3_1(56),
RQCFG_323_.tb3_2(56),
RQCFG_323_.tb3_3(56),
RQCFG_323_.tb3_4(56),
RQCFG_323_.tb3_5(56),
RQCFG_323_.tb3_6(56),
RQCFG_323_.tb3_7(56),
RQCFG_323_.tb3_8(56),
null,
108726,
23,
'C¿digo de dise¿o'
,
'N'
,
'Y'
,
'N'
,
23,
null,
null);

exception when others then
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(56):=1646269;
RQCFG_323_.tb5_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(56):=RQCFG_323_.tb5_0(56);
RQCFG_323_.old_tb5_1(56):=90168711;
RQCFG_323_.tb5_1(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(56),-1)));
RQCFG_323_.old_tb5_2(56):=null;
RQCFG_323_.tb5_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(56),-1)));
RQCFG_323_.tb5_3(56):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(56):=RQCFG_323_.tb3_0(56);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(56),
RQCFG_323_.tb5_1(56),
RQCFG_323_.tb5_2(56),
RQCFG_323_.tb5_3(56),
RQCFG_323_.tb5_4(56),
'Y'
,
'Y'
,
23,
'N'
,
'C¿digo de dise¿o'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(57):=1159093;
RQCFG_323_.tb3_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(57):=RQCFG_323_.tb3_0(57);
RQCFG_323_.old_tb3_1(57):=2036;
RQCFG_323_.tb3_1(57):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(57),-1)));
RQCFG_323_.old_tb3_2(57):=90167564;
RQCFG_323_.tb3_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(57),-1)));
RQCFG_323_.old_tb3_3(57):=null;
RQCFG_323_.tb3_3(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(57),-1)));
RQCFG_323_.old_tb3_4(57):=null;
RQCFG_323_.tb3_4(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(57),-1)));
RQCFG_323_.tb3_5(57):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(57):=121371437;
RQCFG_323_.tb3_6(57):=NULL;
RQCFG_323_.old_tb3_7(57):=null;
RQCFG_323_.tb3_7(57):=NULL;
RQCFG_323_.old_tb3_8(57):=null;
RQCFG_323_.tb3_8(57):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (57)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(57),
RQCFG_323_.tb3_1(57),
RQCFG_323_.tb3_2(57),
RQCFG_323_.tb3_3(57),
RQCFG_323_.tb3_4(57),
RQCFG_323_.tb3_5(57),
RQCFG_323_.tb3_6(57),
RQCFG_323_.tb3_7(57),
RQCFG_323_.tb3_8(57),
null,
108570,
17,
'Identificador del registro'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(57):=1646270;
RQCFG_323_.tb5_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(57):=RQCFG_323_.tb5_0(57);
RQCFG_323_.old_tb5_1(57):=90167564;
RQCFG_323_.tb5_1(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(57),-1)));
RQCFG_323_.old_tb5_2(57):=null;
RQCFG_323_.tb5_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(57),-1)));
RQCFG_323_.tb5_3(57):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(57):=RQCFG_323_.tb3_0(57);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(57),
RQCFG_323_.tb5_1(57),
RQCFG_323_.tb5_2(57),
RQCFG_323_.tb5_3(57),
RQCFG_323_.tb5_4(57),
'C'
,
'Y'
,
17,
'N'
,
'Identificador del registro'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(58):=1159094;
RQCFG_323_.tb3_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(58):=RQCFG_323_.tb3_0(58);
RQCFG_323_.old_tb3_1(58):=2036;
RQCFG_323_.tb3_1(58):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(58),-1)));
RQCFG_323_.old_tb3_2(58):=90167568;
RQCFG_323_.tb3_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(58),-1)));
RQCFG_323_.old_tb3_3(58):=255;
RQCFG_323_.tb3_3(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(58),-1)));
RQCFG_323_.old_tb3_4(58):=null;
RQCFG_323_.tb3_4(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(58),-1)));
RQCFG_323_.tb3_5(58):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(58):=null;
RQCFG_323_.tb3_6(58):=NULL;
RQCFG_323_.old_tb3_7(58):=null;
RQCFG_323_.tb3_7(58):=NULL;
RQCFG_323_.old_tb3_8(58):=null;
RQCFG_323_.tb3_8(58):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (58)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(58),
RQCFG_323_.tb3_1(58),
RQCFG_323_.tb3_2(58),
RQCFG_323_.tb3_3(58),
RQCFG_323_.tb3_4(58),
RQCFG_323_.tb3_5(58),
RQCFG_323_.tb3_6(58),
RQCFG_323_.tb3_7(58),
RQCFG_323_.tb3_8(58),
null,
108571,
18,
'Identificador de la solicitud'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(58):=1646271;
RQCFG_323_.tb5_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(58):=RQCFG_323_.tb5_0(58);
RQCFG_323_.old_tb5_1(58):=90167568;
RQCFG_323_.tb5_1(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(58),-1)));
RQCFG_323_.old_tb5_2(58):=null;
RQCFG_323_.tb5_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(58),-1)));
RQCFG_323_.tb5_3(58):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(58):=RQCFG_323_.tb3_0(58);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (58)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(58),
RQCFG_323_.tb5_1(58),
RQCFG_323_.tb5_2(58),
RQCFG_323_.tb5_3(58),
RQCFG_323_.tb5_4(58),
'C'
,
'Y'
,
18,
'N'
,
'Identificador de la solicitud'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(59):=1159095;
RQCFG_323_.tb3_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(59):=RQCFG_323_.tb3_0(59);
RQCFG_323_.old_tb3_1(59):=2036;
RQCFG_323_.tb3_1(59):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(59),-1)));
RQCFG_323_.old_tb3_2(59):=90167567;
RQCFG_323_.tb3_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(59),-1)));
RQCFG_323_.old_tb3_3(59):=null;
RQCFG_323_.tb3_3(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(59),-1)));
RQCFG_323_.old_tb3_4(59):=null;
RQCFG_323_.tb3_4(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(59),-1)));
RQCFG_323_.tb3_5(59):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(59):=121371433;
RQCFG_323_.tb3_6(59):=NULL;
RQCFG_323_.old_tb3_7(59):=null;
RQCFG_323_.tb3_7(59):=NULL;
RQCFG_323_.old_tb3_8(59):=null;
RQCFG_323_.tb3_8(59):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (59)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(59),
RQCFG_323_.tb3_1(59),
RQCFG_323_.tb3_2(59),
RQCFG_323_.tb3_3(59),
RQCFG_323_.tb3_4(59),
RQCFG_323_.tb3_5(59),
RQCFG_323_.tb3_6(59),
RQCFG_323_.tb3_7(59),
RQCFG_323_.tb3_8(59),
null,
108572,
19,
'Identificador del t¿cnico'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(59):=1646272;
RQCFG_323_.tb5_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(59):=RQCFG_323_.tb5_0(59);
RQCFG_323_.old_tb5_1(59):=90167567;
RQCFG_323_.tb5_1(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(59),-1)));
RQCFG_323_.old_tb5_2(59):=null;
RQCFG_323_.tb5_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(59),-1)));
RQCFG_323_.tb5_3(59):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(59):=RQCFG_323_.tb3_0(59);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (59)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(59),
RQCFG_323_.tb5_1(59),
RQCFG_323_.tb5_2(59),
RQCFG_323_.tb5_3(59),
RQCFG_323_.tb5_4(59),
'C'
,
'Y'
,
19,
'N'
,
'Identificador del t¿cnico'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(60):=1159106;
RQCFG_323_.tb3_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(60):=RQCFG_323_.tb3_0(60);
RQCFG_323_.old_tb3_1(60):=2036;
RQCFG_323_.tb3_1(60):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(60),-1)));
RQCFG_323_.old_tb3_2(60):=90188539;
RQCFG_323_.tb3_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(60),-1)));
RQCFG_323_.old_tb3_3(60):=255;
RQCFG_323_.tb3_3(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(60),-1)));
RQCFG_323_.old_tb3_4(60):=null;
RQCFG_323_.tb3_4(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(60),-1)));
RQCFG_323_.tb3_5(60):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(60):=null;
RQCFG_323_.tb3_6(60):=NULL;
RQCFG_323_.old_tb3_7(60):=null;
RQCFG_323_.tb3_7(60):=NULL;
RQCFG_323_.old_tb3_8(60):=null;
RQCFG_323_.tb3_8(60):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (60)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(60),
RQCFG_323_.tb3_1(60),
RQCFG_323_.tb3_2(60),
RQCFG_323_.tb3_3(60),
RQCFG_323_.tb3_4(60),
RQCFG_323_.tb3_5(60),
RQCFG_323_.tb3_6(60),
RQCFG_323_.tb3_7(60),
RQCFG_323_.tb3_8(60),
null,
107478,
24,
'Solicitud Venta a Constructora'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(60):=1646283;
RQCFG_323_.tb5_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(60):=RQCFG_323_.tb5_0(60);
RQCFG_323_.old_tb5_1(60):=90188539;
RQCFG_323_.tb5_1(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(60),-1)));
RQCFG_323_.old_tb5_2(60):=null;
RQCFG_323_.tb5_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(60),-1)));
RQCFG_323_.tb5_3(60):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(60):=RQCFG_323_.tb3_0(60);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (60)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(60),
RQCFG_323_.tb5_1(60),
RQCFG_323_.tb5_2(60),
RQCFG_323_.tb5_3(60),
RQCFG_323_.tb5_4(60),
'C'
,
'Y'
,
24,
'N'
,
'Solicitud Venta a Constructora'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb3_0(61):=1159107;
RQCFG_323_.tb3_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_323_.tb3_0(61):=RQCFG_323_.tb3_0(61);
RQCFG_323_.old_tb3_1(61):=2036;
RQCFG_323_.tb3_1(61):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_323_.TBENTITYNAME(NVL(RQCFG_323_.old_tb3_1(61),-1)));
RQCFG_323_.old_tb3_2(61):=90188540;
RQCFG_323_.tb3_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_2(61),-1)));
RQCFG_323_.old_tb3_3(61):=null;
RQCFG_323_.tb3_3(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_3(61),-1)));
RQCFG_323_.old_tb3_4(61):=null;
RQCFG_323_.tb3_4(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb3_4(61),-1)));
RQCFG_323_.tb3_5(61):=RQCFG_323_.tb2_2(0);
RQCFG_323_.old_tb3_6(61):=121371495;
RQCFG_323_.tb3_6(61):=NULL;
RQCFG_323_.old_tb3_7(61):=null;
RQCFG_323_.tb3_7(61):=NULL;
RQCFG_323_.old_tb3_8(61):=null;
RQCFG_323_.tb3_8(61):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (61)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_323_.tb3_0(61),
RQCFG_323_.tb3_1(61),
RQCFG_323_.tb3_2(61),
RQCFG_323_.tb3_3(61),
RQCFG_323_.tb3_4(61),
RQCFG_323_.tb3_5(61),
RQCFG_323_.tb3_6(61),
RQCFG_323_.tb3_7(61),
RQCFG_323_.tb3_8(61),
null,
107479,
25,
'PORTAL VENTA Y - N'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_323_.blProcessStatus) then
 return;
end if;

RQCFG_323_.old_tb5_0(61):=1646284;
RQCFG_323_.tb5_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_323_.tb5_0(61):=RQCFG_323_.tb5_0(61);
RQCFG_323_.old_tb5_1(61):=90188540;
RQCFG_323_.tb5_1(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_1(61),-1)));
RQCFG_323_.old_tb5_2(61):=null;
RQCFG_323_.tb5_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_323_.TBENTITYATTRIBUTENAME(NVL(RQCFG_323_.old_tb5_2(61),-1)));
RQCFG_323_.tb5_3(61):=RQCFG_323_.tb4_0(2);
RQCFG_323_.tb5_4(61):=RQCFG_323_.tb3_0(61);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (61)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_323_.tb5_0(61),
RQCFG_323_.tb5_1(61),
RQCFG_323_.tb5_2(61),
RQCFG_323_.tb5_3(61),
RQCFG_323_.tb5_4(61),
'C'
,
'Y'
,
25,
'N'
,
'PORTAL VENTA Y - N'
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
RQCFG_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (323);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (323)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_323_.blProcessStatus) then
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
AND     external_root_id = 323
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
AND     external_root_id = 323
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
AND     external_root_id = 323
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 323, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 323)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 323, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 323)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 323, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 323)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 323, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 323)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_323_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_323_.tbCompositions.FIRST..RQCFG_323_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_323_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_323_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_323_.blProcessStatus := false;
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
 nuIndex := RQCFG_323_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_323_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_323_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_323_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_323_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_323_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_323_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_323_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_323_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_323_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_323_',
'CREATE OR REPLACE PACKAGE I18N_R_323_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_323_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_323_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 323
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_323_.blProcessStatus) then
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
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(3):='C_GENERICO_90'
;
I18N_R_323_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(3),
I18N_R_323_.tb0_1(3),
'WE8ISO8859P1'
,
'Gen¿rico'
,
'Gen¿rico'
,
null,
'Gen¿rico'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(4):='C_GENERICO_90'
;
I18N_R_323_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(4),
I18N_R_323_.tb0_1(4),
'WE8ISO8859P1'
,
'Gen¿rico'
,
'Gen¿rico'
,
null,
'Gen¿rico'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(5):='C_GENERICO_90'
;
I18N_R_323_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(5),
I18N_R_323_.tb0_1(5),
'WE8ISO8859P1'
,
'Gen¿rico'
,
'Gen¿rico'
,
null,
'Gen¿rico'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(0):='M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
;
I18N_R_323_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(0),
I18N_R_323_.tb0_1(0),
'WE8ISO8859P1'
,
'Solicitud de Trabajos para una Constructora'
,
'Solicitud de Trabajos para una Constructora'
,
null,
'Solicitud de Trabajos para una Constructora'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(1):='M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
;
I18N_R_323_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(1),
I18N_R_323_.tb0_1(1),
'WE8ISO8859P1'
,
'Solicitud de Trabajos para una Constructora'
,
'Solicitud de Trabajos para una Constructora'
,
null,
'Solicitud de Trabajos para una Constructora'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(2):='M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114'
;
I18N_R_323_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(2),
I18N_R_323_.tb0_1(2),
'WE8ISO8859P1'
,
'Solicitud de Trabajos para una Constructora'
,
'Solicitud de Trabajos para una Constructora'
,
null,
'Solicitud de Trabajos para una Constructora'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(6):='PAQUETE'
;
I18N_R_323_.tb0_1(6):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(6),
I18N_R_323_.tb0_1(6),
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
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(7):='PAQUETE'
;
I18N_R_323_.tb0_1(7):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (7)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(7),
I18N_R_323_.tb0_1(7),
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
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(8):='PAQUETE'
;
I18N_R_323_.tb0_1(8):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (8)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(8),
I18N_R_323_.tb0_1(8),
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
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_323_.blProcessStatus) then
 return;
end if;

I18N_R_323_.tb0_0(9):='PAQUETE'
;
I18N_R_323_.tb0_1(9):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (9)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_323_.tb0_0(9),
I18N_R_323_.tb0_1(9),
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
I18N_R_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_323_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_323_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_323_',
'CREATE OR REPLACE PACKAGE RQEXEC_323_ IS ' || chr(10) ||
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
'END RQEXEC_323_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_323_******************************'); END;
/


BEGIN

if (not RQEXEC_323_.blProcessStatus) then
 return;
end if;

RQEXEC_323_.old_tb0_0(0):='P_VENTA_A_CONSTRUCTORAS_323'
;
RQEXEC_323_.tb0_0(0):=UPPER(RQEXEC_323_.old_tb0_0(0));
RQEXEC_323_.old_tb0_1(0):=19711;
RQEXEC_323_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_323_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_323_.tb0_1(0):=RQEXEC_323_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_323_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_323_.tb0_1(0),
DESCRIPTION='Venta a Constructoras'
,
PATH=null,
VERSION='119'
,
EXECUTABLE_TYPE_ID=3,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=16,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP='ges_comercial_aten_clie_herramientas_pto_unico_atencion_Venta_a_Constructoras.htm'
,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='N'
,
TIMES_EXECUTED=27,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=to_date('18-04-2018 23:02:42','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_323_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_323_.tb0_0(0),
RQEXEC_323_.tb0_1(0),
'Venta a Constructoras'
,
null,
'119'
,
3,
2,
16,
1,
null,
'N'
,
'ges_comercial_aten_clie_herramientas_pto_unico_atencion_Venta_a_Constructoras.htm'
,
'N'
,
'N'
,
27,
'O',
to_date('18-04-2018 23:02:42','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_323_.blProcessStatus) then
 return;
end if;

RQEXEC_323_.tb1_0(0):=1;
RQEXEC_323_.tb1_1(0):=RQEXEC_323_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_323_.tb1_0(0),
RQEXEC_323_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_323_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_323_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_323_******************************'); end;
/

