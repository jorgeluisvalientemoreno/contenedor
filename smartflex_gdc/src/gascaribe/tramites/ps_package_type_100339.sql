BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100339_',
'CREATE OR REPLACE PACKAGE RQTY_100339_ IS ' || chr(10) ||
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
'tb11_1 ty11_1;type ty12_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty13_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty14_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty14_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb14_1 ty14_1; ' || chr(10) ||
'tb14_1 ty14_1;type ty14_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb14_2 ty14_2; ' || chr(10) ||
'tb14_2 ty14_2;type ty14_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb14_3 ty14_3; ' || chr(10) ||
'tb14_3 ty14_3;type ty15_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_0 ty15_0; ' || chr(10) ||
'tb15_0 ty15_0;type ty16_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb16_0 ty16_0; ' || chr(10) ||
'tb16_0 ty16_0;type ty16_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb16_1 ty16_1; ' || chr(10) ||
'tb16_1 ty16_1;type ty16_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb16_2 ty16_2; ' || chr(10) ||
'tb16_2 ty16_2;type ty16_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb16_3 ty16_3; ' || chr(10) ||
'tb16_3 ty16_3;type ty17_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_0 ty17_0; ' || chr(10) ||
'tb17_0 ty17_0;type ty17_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_1 ty17_1; ' || chr(10) ||
'tb17_1 ty17_1;type ty17_3 is table of PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb17_3 ty17_3; ' || chr(10) ||
'tb17_3 ty17_3;--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM ' || chr(10) ||
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100339 ' || chr(10) ||
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
'END RQTY_100339_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100339_******************************'); END;
/

BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
AND     external_root_id = 100339
)
);

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100339_.cuExpressions;
fetch RQTY_100339_.cuExpressions bulk collect INTO RQTY_100339_.tbExpressionsId;
close RQTY_100339_.cuExpressions;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100339_.tbEntityName(-1) := 'NULL';
   RQTY_100339_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(260) := 'MO_PACKAGES@USER_ID';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(515) := 'MO_PROCESS@SEPARATOR_GUI_2';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(39259) := 'MO_PROCESS@VALUE_7';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(261) := 'MO_PACKAGES@TERMINAL_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(2508) := 'MO_PROCESS@DUMMY';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(40909) := 'MO_PACKAGES@ORGANIZAT_AREA_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(182398) := 'MO_PACKAGES@MANAGEMENT_AREA_ID';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100339_.tbEntityAttributeName(39298) := 'MO_PROCESS@VALUE_8';
   RQTY_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100339_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100339
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100339
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100339
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100339
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100339_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100339_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100339_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100339_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100339_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100339_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100339_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339))));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339))));

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100339_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100339_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100339_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100339_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100339_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100339_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100339_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100339_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339)));

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339));
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100339_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339);
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100339_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100339_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100339_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100339_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100339;
nuIndex binary_integer;
BEGIN

if (not RQTY_100339_.blProcessStatus) then
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100339_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100339_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100339_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100339_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100339_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100339_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100339_.tb0_0(0),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb1_0(0):=1;
RQTY_100339_.tb1_1(0):=RQTY_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100339_.tb1_0(0),
MODULE_ID=RQTY_100339_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100339_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100339_.tb1_0(0),
RQTY_100339_.tb1_1(0),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(0):=121269253;
RQTY_100339_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(0):=RQTY_100339_.tb2_0(0);
RQTY_100339_.old_tb2_1(0):='GE_EXEACTION_CT1E121269253'
;
RQTY_100339_.tb2_1(0):=RQTY_100339_.tb2_0(0);
RQTY_100339_.tb2_2(0):=RQTY_100339_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(0),
RQTY_100339_.tb2_1(0),
RQTY_100339_.tb2_2(0),
'MO_BOATTENTION.ACTCREATEPLANWF();nuIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", nuIdSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.FNUCHARTONUMBER(nuIdSolicitud),cnuTipoFechaPQR,dtFechaSolicitud)'
,
'CARLPARR'
,
to_date('18-04-2013 14:17:09','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:25','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla de Creación Plan en Workflow y Registro Adicional de Fecha'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb3_0(0):=8177;
RQTY_100339_.tb3_1(0):=RQTY_100339_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100339_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100339_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Creación Plan en Workflow y Registro Adicional de Fecha'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100339_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100339_.tb3_0(0),
RQTY_100339_.tb3_1(0),
5,
'Creación Plan en Workflow y Registro Adicional de Fecha'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb4_0(0):=RQTY_100339_.tb3_0(0);
RQTY_100339_.tb4_1(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100339_.tb4_0(0),
VALID_MODULE_ID=RQTY_100339_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100339_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100339_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100339_.tb4_0(0),
RQTY_100339_.tb4_1(0));
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb4_0(1):=RQTY_100339_.tb3_0(0);
RQTY_100339_.tb4_1(1):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100339_.tb4_0(1),
VALID_MODULE_ID=RQTY_100339_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100339_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100339_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100339_.tb4_0(1),
RQTY_100339_.tb4_1(1));
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb5_0(0):=100339;
RQTY_100339_.tb5_1(0):=RQTY_100339_.tb3_0(0);
RQTY_100339_.tb5_4(0):='P_REGISTRO_DE_DANO_A_PRODUCTO_POR_XML_100339'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100339_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100339_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100339_.tb5_4(0),
DESCRIPTION='Registro de Daño a Producto por XML'
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
 WHERE PACKAGE_TYPE_ID = RQTY_100339_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100339_.tb5_0(0),
RQTY_100339_.tb5_1(0),
null,
null,
RQTY_100339_.tb5_4(0),
'Registro de Daño a Producto por XML'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(0):=108282;
RQTY_100339_.tb6_1(0):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(0):=17;
RQTY_100339_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(0),-1)));
RQTY_100339_.old_tb6_3(0):=146756;
RQTY_100339_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(0),-1)));
RQTY_100339_.old_tb6_4(0):=null;
RQTY_100339_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(0),-1)));
RQTY_100339_.old_tb6_5(0):=null;
RQTY_100339_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(0),
ENTITY_ID=RQTY_100339_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Dirección de Respuesta'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(0),
RQTY_100339_.tb6_1(0),
RQTY_100339_.tb6_2(0),
RQTY_100339_.tb6_3(0),
RQTY_100339_.tb6_4(0),
RQTY_100339_.tb6_5(0),
null,
null,
null,
null,
8,
'Dirección de Respuesta'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(1):=108283;
RQTY_100339_.tb6_1(1):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(1):=68;
RQTY_100339_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(1),-1)));
RQTY_100339_.old_tb6_3(1):=189644;
RQTY_100339_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(1),-1)));
RQTY_100339_.old_tb6_4(1):=null;
RQTY_100339_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(1),-1)));
RQTY_100339_.old_tb6_5(1):=null;
RQTY_100339_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(1),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(1),
ENTITY_ID=RQTY_100339_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(1),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(1),
RQTY_100339_.tb6_1(1),
RQTY_100339_.tb6_2(1),
RQTY_100339_.tb6_3(1),
RQTY_100339_.tb6_4(1),
RQTY_100339_.tb6_5(1),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb7_0(0):=120142777;
RQTY_100339_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100339_.tb7_0(0):=RQTY_100339_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100339_.tb7_0(0),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(2):=108284;
RQTY_100339_.tb6_1(2):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(2):=17;
RQTY_100339_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(2),-1)));
RQTY_100339_.old_tb6_3(2):=40909;
RQTY_100339_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(2),-1)));
RQTY_100339_.old_tb6_4(2):=null;
RQTY_100339_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(2),-1)));
RQTY_100339_.old_tb6_5(2):=189644;
RQTY_100339_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(2),-1)));
RQTY_100339_.tb6_6(2):=RQTY_100339_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(2),
ENTITY_ID=RQTY_100339_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(2),
STATEMENT_ID=RQTY_100339_.tb6_6(2),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Área Organizacional Causante'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(2),
RQTY_100339_.tb6_1(2),
RQTY_100339_.tb6_2(2),
RQTY_100339_.tb6_3(2),
RQTY_100339_.tb6_4(2),
RQTY_100339_.tb6_5(2),
RQTY_100339_.tb6_6(2),
null,
null,
null,
10,
'Área Organizacional Causante'
,
10,
'Y'
,
'N'
,
'N'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb7_0(1):=120142778;
RQTY_100339_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100339_.tb7_0(1):=RQTY_100339_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100339_.tb7_0(1),
5,
'Sentencia Obtiene las posibles areas que gestionan - segun tipo de paquete y causa'
,
'PS_BOListOfValues.GetManagementAreas(ID, DESCRIPTION, OUTPUT)'
,
'Sentencia Obtiene las posibles areas que gestionan - segun tipo de paquete y causa'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(3):=108285;
RQTY_100339_.tb6_1(3):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(3):=17;
RQTY_100339_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(3),-1)));
RQTY_100339_.old_tb6_3(3):=182398;
RQTY_100339_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(3),-1)));
RQTY_100339_.old_tb6_4(3):=null;
RQTY_100339_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(3),-1)));
RQTY_100339_.old_tb6_5(3):=189644;
RQTY_100339_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(3),-1)));
RQTY_100339_.tb6_6(3):=RQTY_100339_.tb7_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(3),
ENTITY_ID=RQTY_100339_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(3),
STATEMENT_ID=RQTY_100339_.tb6_6(3),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Área Que Gestiona La Solicitud'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(3),
RQTY_100339_.tb6_1(3),
RQTY_100339_.tb6_2(3),
RQTY_100339_.tb6_3(3),
RQTY_100339_.tb6_4(3),
RQTY_100339_.tb6_5(3),
RQTY_100339_.tb6_6(3),
null,
null,
null,
11,
'Área Que Gestiona La Solicitud'
,
11,
'Y'
,
'N'
,
'N'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(4):=108286;
RQTY_100339_.tb6_1(4):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(4):=17;
RQTY_100339_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(4),-1)));
RQTY_100339_.old_tb6_3(4):=146754;
RQTY_100339_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(4),-1)));
RQTY_100339_.old_tb6_4(4):=null;
RQTY_100339_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(4),-1)));
RQTY_100339_.old_tb6_5(4):=null;
RQTY_100339_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(4),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(4),
ENTITY_ID=RQTY_100339_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Observación'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(4),
RQTY_100339_.tb6_1(4),
RQTY_100339_.tb6_2(4),
RQTY_100339_.tb6_3(4),
RQTY_100339_.tb6_4(4),
RQTY_100339_.tb6_5(4),
null,
null,
null,
null,
12,
'Observación'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(5):=108287;
RQTY_100339_.tb6_1(5):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(5):=68;
RQTY_100339_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(5),-1)));
RQTY_100339_.old_tb6_3(5):=2508;
RQTY_100339_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(5),-1)));
RQTY_100339_.old_tb6_4(5):=null;
RQTY_100339_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(5),-1)));
RQTY_100339_.old_tb6_5(5):=null;
RQTY_100339_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(5),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(5),
ENTITY_ID=RQTY_100339_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(5),
RQTY_100339_.tb6_1(5),
RQTY_100339_.tb6_2(5),
RQTY_100339_.tb6_3(5),
RQTY_100339_.tb6_4(5),
RQTY_100339_.tb6_5(5),
null,
null,
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(6):=108288;
RQTY_100339_.tb6_1(6):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(6):=68;
RQTY_100339_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(6),-1)));
RQTY_100339_.old_tb6_3(6):=20371;
RQTY_100339_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(6),-1)));
RQTY_100339_.old_tb6_4(6):=null;
RQTY_100339_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(6),-1)));
RQTY_100339_.old_tb6_5(6):=null;
RQTY_100339_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(6),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(6),
ENTITY_ID=RQTY_100339_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(6),
RQTY_100339_.tb6_1(6),
RQTY_100339_.tb6_2(6),
RQTY_100339_.tb6_3(6),
RQTY_100339_.tb6_4(6),
RQTY_100339_.tb6_5(6),
null,
null,
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(7):=108289;
RQTY_100339_.tb6_1(7):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(7):=17;
RQTY_100339_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(7),-1)));
RQTY_100339_.old_tb6_3(7):=269;
RQTY_100339_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(7),-1)));
RQTY_100339_.old_tb6_4(7):=null;
RQTY_100339_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(7),-1)));
RQTY_100339_.old_tb6_5(7):=null;
RQTY_100339_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(7),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(7),
ENTITY_ID=RQTY_100339_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Código del Tipo de Paquete'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(7),
RQTY_100339_.tb6_1(7),
RQTY_100339_.tb6_2(7),
RQTY_100339_.tb6_3(7),
RQTY_100339_.tb6_4(7),
RQTY_100339_.tb6_5(7),
null,
null,
null,
null,
15,
'Código del Tipo de Paquete'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100339_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100339_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100339_.tb0_0(1),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb1_0(1):=23;
RQTY_100339_.tb1_1(1):=RQTY_100339_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100339_.tb1_0(1),
MODULE_ID=RQTY_100339_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100339_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100339_.tb1_0(1),
RQTY_100339_.tb1_1(1),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(1):=121269255;
RQTY_100339_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(1):=RQTY_100339_.tb2_0(1);
RQTY_100339_.old_tb2_1(1):='MO_INITATRIB_CT23E121269255'
;
RQTY_100339_.tb2_1(1):=RQTY_100339_.tb2_0(1);
RQTY_100339_.tb2_2(1):=RQTY_100339_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(1),
RQTY_100339_.tb2_1(1),
RQTY_100339_.tb2_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'OPEN'
,
to_date('26-08-2017 12:10:58','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI-DAÑO- MO_PACKAGES-MESAG_DELIVERY_DATE'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(8):=108290;
RQTY_100339_.tb6_1(8):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(8):=17;
RQTY_100339_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(8),-1)));
RQTY_100339_.old_tb6_3(8):=259;
RQTY_100339_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(8),-1)));
RQTY_100339_.old_tb6_4(8):=null;
RQTY_100339_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(8),-1)));
RQTY_100339_.old_tb6_5(8):=null;
RQTY_100339_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(8),-1)));
RQTY_100339_.tb6_7(8):=RQTY_100339_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(8),
ENTITY_ID=RQTY_100339_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100339_.tb6_7(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Fecha de Envío'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_DE_ENVIO'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(8),
RQTY_100339_.tb6_1(8),
RQTY_100339_.tb6_2(8),
RQTY_100339_.tb6_3(8),
RQTY_100339_.tb6_4(8),
RQTY_100339_.tb6_5(8),
null,
RQTY_100339_.tb6_7(8),
null,
null,
16,
'Fecha de Envío'
,
16,
'N'
,
'N'
,
'Y'
,
'FECHA_DE_ENVIO'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(9):=108291;
RQTY_100339_.tb6_1(9):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(9):=17;
RQTY_100339_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(9),-1)));
RQTY_100339_.old_tb6_3(9):=42118;
RQTY_100339_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(9),-1)));
RQTY_100339_.old_tb6_4(9):=109479;
RQTY_100339_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(9),-1)));
RQTY_100339_.old_tb6_5(9):=null;
RQTY_100339_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(9),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(9),
ENTITY_ID=RQTY_100339_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Código Canal De Ventas'
,
DISPLAY_ORDER=17,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(9),
RQTY_100339_.tb6_1(9),
RQTY_100339_.tb6_2(9),
RQTY_100339_.tb6_3(9),
RQTY_100339_.tb6_4(9),
RQTY_100339_.tb6_5(9),
null,
null,
null,
null,
17,
'Código Canal De Ventas'
,
17,
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(10):=108292;
RQTY_100339_.tb6_1(10):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(10):=68;
RQTY_100339_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(10),-1)));
RQTY_100339_.old_tb6_3(10):=515;
RQTY_100339_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(10),-1)));
RQTY_100339_.old_tb6_4(10):=null;
RQTY_100339_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(10),-1)));
RQTY_100339_.old_tb6_5(10):=null;
RQTY_100339_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(10),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(10),
ENTITY_ID=RQTY_100339_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Datos del Daño'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DATOS_DEL_DANO'
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
ATTRI_TECHNICAL_NAME='SEPARATOR_GUI_2'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(10),
RQTY_100339_.tb6_1(10),
RQTY_100339_.tb6_2(10),
RQTY_100339_.tb6_3(10),
RQTY_100339_.tb6_4(10),
RQTY_100339_.tb6_5(10),
null,
null,
null,
null,
18,
'Datos del Daño'
,
18,
'Y'
,
'N'
,
'N'
,
'DATOS_DEL_DANO'
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
'SEPARATOR_GUI_2'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(11):=108293;
RQTY_100339_.tb6_1(11):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(11):=68;
RQTY_100339_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(11),-1)));
RQTY_100339_.old_tb6_3(11):=39259;
RQTY_100339_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(11),-1)));
RQTY_100339_.old_tb6_4(11):=null;
RQTY_100339_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(11),-1)));
RQTY_100339_.old_tb6_5(11):=null;
RQTY_100339_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(11),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(11),
ENTITY_ID=RQTY_100339_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Servicio'
,
DISPLAY_ORDER=19,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SERVICIO'
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
ATTRI_TECHNICAL_NAME='VALUE_7'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(11),
RQTY_100339_.tb6_1(11),
RQTY_100339_.tb6_2(11),
RQTY_100339_.tb6_3(11),
RQTY_100339_.tb6_4(11),
RQTY_100339_.tb6_5(11),
null,
null,
null,
null,
19,
'Servicio'
,
19,
'Y'
,
'N'
,
'N'
,
'SERVICIO'
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
'VALUE_7'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(12):=108294;
RQTY_100339_.tb6_1(12):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(12):=68;
RQTY_100339_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(12),-1)));
RQTY_100339_.old_tb6_3(12):=39298;
RQTY_100339_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(12),-1)));
RQTY_100339_.old_tb6_4(12):=null;
RQTY_100339_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(12),-1)));
RQTY_100339_.old_tb6_5(12):=null;
RQTY_100339_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(12),
ENTITY_ID=RQTY_100339_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Número de Servicio'
,
DISPLAY_ORDER=20,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='NUMERO_DE_SERVICIO'
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
ATTRI_TECHNICAL_NAME='VALUE_8'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(12),
RQTY_100339_.tb6_1(12),
RQTY_100339_.tb6_2(12),
RQTY_100339_.tb6_3(12),
RQTY_100339_.tb6_4(12),
RQTY_100339_.tb6_5(12),
null,
null,
null,
null,
20,
'Número de Servicio'
,
20,
'Y'
,
'N'
,
'N'
,
'NUMERO_DE_SERVICIO'
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
'VALUE_8'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(13):=108295;
RQTY_100339_.tb6_1(13):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(13):=68;
RQTY_100339_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(13),-1)));
RQTY_100339_.old_tb6_3(13):=6732;
RQTY_100339_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(13),-1)));
RQTY_100339_.old_tb6_4(13):=null;
RQTY_100339_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(13),-1)));
RQTY_100339_.old_tb6_5(13):=null;
RQTY_100339_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(13),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(13),
ENTITY_ID=RQTY_100339_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Enviar Eventos'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ENVIAR_EVENTOS'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(13),
RQTY_100339_.tb6_1(13),
RQTY_100339_.tb6_2(13),
RQTY_100339_.tb6_3(13),
RQTY_100339_.tb6_4(13),
RQTY_100339_.tb6_5(13),
null,
null,
null,
null,
21,
'Enviar Eventos'
,
21,
'Y'
,
'N'
,
'N'
,
'ENVIAR_EVENTOS'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(14):=108296;
RQTY_100339_.tb6_1(14):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(14):=17;
RQTY_100339_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(14),-1)));
RQTY_100339_.old_tb6_3(14):=260;
RQTY_100339_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(14),-1)));
RQTY_100339_.old_tb6_4(14):=null;
RQTY_100339_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(14),-1)));
RQTY_100339_.old_tb6_5(14):=null;
RQTY_100339_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(14),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(14),
ENTITY_ID=RQTY_100339_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Usuario'
,
DISPLAY_ORDER=22,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(14),
RQTY_100339_.tb6_1(14),
RQTY_100339_.tb6_2(14),
RQTY_100339_.tb6_3(14),
RQTY_100339_.tb6_4(14),
RQTY_100339_.tb6_5(14),
null,
null,
null,
null,
22,
'Usuario'
,
22,
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(15):=108297;
RQTY_100339_.tb6_1(15):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(15):=17;
RQTY_100339_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(15),-1)));
RQTY_100339_.old_tb6_3(15):=261;
RQTY_100339_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(15),-1)));
RQTY_100339_.old_tb6_4(15):=null;
RQTY_100339_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(15),-1)));
RQTY_100339_.old_tb6_5(15):=null;
RQTY_100339_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(15),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(15),
ENTITY_ID=RQTY_100339_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Terminal'
,
DISPLAY_ORDER=23,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(15),
RQTY_100339_.tb6_1(15),
RQTY_100339_.tb6_2(15),
RQTY_100339_.tb6_3(15),
RQTY_100339_.tb6_4(15),
RQTY_100339_.tb6_5(15),
null,
null,
null,
null,
23,
'Terminal'
,
23,
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(16):=108276;
RQTY_100339_.tb6_1(16):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(16):=17;
RQTY_100339_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(16),-1)));
RQTY_100339_.old_tb6_3(16):=255;
RQTY_100339_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(16),-1)));
RQTY_100339_.old_tb6_4(16):=null;
RQTY_100339_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(16),-1)));
RQTY_100339_.old_tb6_5(16):=null;
RQTY_100339_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(16),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(16),
ENTITY_ID=RQTY_100339_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Número de Solicitud'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='NUMERO_DE_SOLICITUD'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(16),
RQTY_100339_.tb6_1(16),
RQTY_100339_.tb6_2(16),
RQTY_100339_.tb6_3(16),
RQTY_100339_.tb6_4(16),
RQTY_100339_.tb6_5(16),
null,
null,
null,
null,
2,
'Número de Solicitud'
,
2,
'Y'
,
'N'
,
'Y'
,
'NUMERO_DE_SOLICITUD'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(17):=108298;
RQTY_100339_.tb6_1(17):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(17):=68;
RQTY_100339_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(17),-1)));
RQTY_100339_.old_tb6_3(17):=1035;
RQTY_100339_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(17),-1)));
RQTY_100339_.old_tb6_4(17):=null;
RQTY_100339_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(17),-1)));
RQTY_100339_.old_tb6_5(17):=null;
RQTY_100339_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(17),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(17),
ENTITY_ID=RQTY_100339_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Dirección'
,
DISPLAY_ORDER=24,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='DIRECCION'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(17),
RQTY_100339_.tb6_1(17),
RQTY_100339_.tb6_2(17),
RQTY_100339_.tb6_3(17),
RQTY_100339_.tb6_4(17),
RQTY_100339_.tb6_5(17),
null,
null,
null,
null,
24,
'Dirección'
,
24,
'N'
,
'N'
,
'N'
,
'DIRECCION'
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
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(2):=121269259;
RQTY_100339_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(2):=RQTY_100339_.tb2_0(2);
RQTY_100339_.old_tb2_1(2):='MO_INITATRIB_CT23E121269259'
;
RQTY_100339_.tb2_1(2):=RQTY_100339_.tb2_0(2);
RQTY_100339_.tb2_2(2):=RQTY_100339_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(2),
RQTY_100339_.tb2_1(2),
RQTY_100339_.tb2_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'OPEN'
,
to_date('26-08-2017 12:10:55','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - PERSON_ID - inicialización del funcionario'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb7_0(2):=120142779;
RQTY_100339_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100339_.tb7_0(2):=RQTY_100339_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100339_.tb7_0(2),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(18):=108277;
RQTY_100339_.tb6_1(18):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(18):=17;
RQTY_100339_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(18),-1)));
RQTY_100339_.old_tb6_3(18):=50001162;
RQTY_100339_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(18),-1)));
RQTY_100339_.old_tb6_4(18):=null;
RQTY_100339_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(18),-1)));
RQTY_100339_.old_tb6_5(18):=null;
RQTY_100339_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(18),-1)));
RQTY_100339_.tb6_6(18):=RQTY_100339_.tb7_0(2);
RQTY_100339_.tb6_7(18):=RQTY_100339_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(18),
ENTITY_ID=RQTY_100339_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(18),
STATEMENT_ID=RQTY_100339_.tb6_6(18),
INIT_EXPRESSION_ID=RQTY_100339_.tb6_7(18),
VALID_EXPRESSION_ID=null,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(18),
RQTY_100339_.tb6_1(18),
RQTY_100339_.tb6_2(18),
RQTY_100339_.tb6_3(18),
RQTY_100339_.tb6_4(18),
RQTY_100339_.tb6_5(18),
RQTY_100339_.tb6_6(18),
RQTY_100339_.tb6_7(18),
null,
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(19):=108278;
RQTY_100339_.tb6_1(19):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(19):=17;
RQTY_100339_.tb6_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(19),-1)));
RQTY_100339_.old_tb6_3(19):=146755;
RQTY_100339_.tb6_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(19),-1)));
RQTY_100339_.old_tb6_4(19):=null;
RQTY_100339_.tb6_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(19),-1)));
RQTY_100339_.old_tb6_5(19):=null;
RQTY_100339_.tb6_5(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(19),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (19)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(19),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(19),
ENTITY_ID=RQTY_100339_.tb6_2(19),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(19),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(19),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Información del Solicitante'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(19);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(19),
RQTY_100339_.tb6_1(19),
RQTY_100339_.tb6_2(19),
RQTY_100339_.tb6_3(19),
RQTY_100339_.tb6_4(19),
RQTY_100339_.tb6_5(19),
null,
null,
null,
null,
4,
'Información del Solicitante'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(20):=108279;
RQTY_100339_.tb6_1(20):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(20):=68;
RQTY_100339_.tb6_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(20),-1)));
RQTY_100339_.old_tb6_3(20):=6733;
RQTY_100339_.tb6_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(20),-1)));
RQTY_100339_.old_tb6_4(20):=null;
RQTY_100339_.tb6_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(20),-1)));
RQTY_100339_.old_tb6_5(20):=146755;
RQTY_100339_.tb6_5(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(20),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (20)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(20),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(20),
ENTITY_ID=RQTY_100339_.tb6_2(20),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(20),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(20),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(20);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(20),
RQTY_100339_.tb6_1(20),
RQTY_100339_.tb6_2(20),
RQTY_100339_.tb6_3(20),
RQTY_100339_.tb6_4(20),
RQTY_100339_.tb6_5(20),
null,
null,
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
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb7_0(3):=120142780;
RQTY_100339_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100339_.tb7_0(3):=RQTY_100339_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100339_.tb7_0(3),
16,
'Lista canal de ventas'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')'
,
'Lista canal de ventas'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(21):=108280;
RQTY_100339_.tb6_1(21):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(21):=17;
RQTY_100339_.tb6_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(21),-1)));
RQTY_100339_.old_tb6_3(21):=109479;
RQTY_100339_.tb6_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(21),-1)));
RQTY_100339_.old_tb6_4(21):=null;
RQTY_100339_.tb6_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(21),-1)));
RQTY_100339_.old_tb6_5(21):=null;
RQTY_100339_.tb6_5(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(21),-1)));
RQTY_100339_.tb6_6(21):=RQTY_100339_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (21)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(21),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(21),
ENTITY_ID=RQTY_100339_.tb6_2(21),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(21),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(21),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(21),
STATEMENT_ID=RQTY_100339_.tb6_6(21),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Punto de Atención'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(21);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(21),
RQTY_100339_.tb6_1(21),
RQTY_100339_.tb6_2(21),
RQTY_100339_.tb6_3(21),
RQTY_100339_.tb6_4(21),
RQTY_100339_.tb6_5(21),
RQTY_100339_.tb6_6(21),
null,
null,
null,
6,
'Punto de Atención'
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
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb7_0(4):=120142781;
RQTY_100339_.tb7_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100339_.tb7_0(4):=RQTY_100339_.tb7_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100339_.tb7_0(4),
16,
'Lista de medios de recepción'
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
'Lista de medios de recepción'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(22):=108281;
RQTY_100339_.tb6_1(22):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(22):=17;
RQTY_100339_.tb6_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(22),-1)));
RQTY_100339_.old_tb6_3(22):=2683;
RQTY_100339_.tb6_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(22),-1)));
RQTY_100339_.old_tb6_4(22):=null;
RQTY_100339_.tb6_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(22),-1)));
RQTY_100339_.old_tb6_5(22):=null;
RQTY_100339_.tb6_5(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(22),-1)));
RQTY_100339_.tb6_6(22):=RQTY_100339_.tb7_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (22)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(22),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(22),
ENTITY_ID=RQTY_100339_.tb6_2(22),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(22),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(22),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(22),
STATEMENT_ID=RQTY_100339_.tb6_6(22),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Medio de Recepción'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(22);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(22),
RQTY_100339_.tb6_1(22),
RQTY_100339_.tb6_2(22),
RQTY_100339_.tb6_3(22),
RQTY_100339_.tb6_4(22),
RQTY_100339_.tb6_5(22),
RQTY_100339_.tb6_6(22),
null,
null,
null,
7,
'Medio de Recepción'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(23):=108299;
RQTY_100339_.tb6_1(23):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(23):=17;
RQTY_100339_.tb6_2(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(23),-1)));
RQTY_100339_.old_tb6_3(23):=4015;
RQTY_100339_.tb6_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(23),-1)));
RQTY_100339_.old_tb6_4(23):=null;
RQTY_100339_.tb6_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(23),-1)));
RQTY_100339_.old_tb6_5(23):=null;
RQTY_100339_.tb6_5(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(23),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (23)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(23),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(23),
ENTITY_ID=RQTY_100339_.tb6_2(23),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(23),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(23),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=25,
DISPLAY_NAME='Identificador del Cliente'
,
DISPLAY_ORDER=25,
INCLUDED_VAL_DOC='Y'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(23);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(23),
RQTY_100339_.tb6_1(23),
RQTY_100339_.tb6_2(23),
RQTY_100339_.tb6_3(23),
RQTY_100339_.tb6_4(23),
RQTY_100339_.tb6_5(23),
null,
null,
null,
null,
25,
'Identificador del Cliente'
,
25,
'Y'
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
'Y'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(3):=121269256;
RQTY_100339_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(3):=RQTY_100339_.tb2_0(3);
RQTY_100339_.old_tb2_1(3):='MO_INITATRIB_CT23E121269256'
;
RQTY_100339_.tb2_1(3):=RQTY_100339_.tb2_0(3);
RQTY_100339_.tb2_2(3):=RQTY_100339_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(3),
RQTY_100339_.tb2_1(3),
RQTY_100339_.tb2_2(3),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'OPEN'
,
to_date('26-08-2017 12:10:54','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - CUST_CARE_REQUES_NUM - Inicialización de la petición'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(24):=108274;
RQTY_100339_.tb6_1(24):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(24):=17;
RQTY_100339_.tb6_2(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(24),-1)));
RQTY_100339_.old_tb6_3(24):=257;
RQTY_100339_.tb6_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(24),-1)));
RQTY_100339_.old_tb6_4(24):=null;
RQTY_100339_.tb6_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(24),-1)));
RQTY_100339_.old_tb6_5(24):=null;
RQTY_100339_.tb6_5(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(24),-1)));
RQTY_100339_.tb6_7(24):=RQTY_100339_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (24)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(24),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(24),
ENTITY_ID=RQTY_100339_.tb6_2(24),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(24),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(24),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100339_.tb6_7(24),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Interacción'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='Y'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(24);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(24),
RQTY_100339_.tb6_1(24),
RQTY_100339_.tb6_2(24),
RQTY_100339_.tb6_3(24),
RQTY_100339_.tb6_4(24),
RQTY_100339_.tb6_5(24),
null,
RQTY_100339_.tb6_7(24),
null,
null,
0,
'Interacción'
,
0,
'Y'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(4):=121269257;
RQTY_100339_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(4):=RQTY_100339_.tb2_0(4);
RQTY_100339_.old_tb2_1(4):='MO_INITATRIB_CT23E121269257'
;
RQTY_100339_.tb2_1(4):=RQTY_100339_.tb2_0(4);
RQTY_100339_.tb2_2(4):=RQTY_100339_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(4),
RQTY_100339_.tb2_1(4),
RQTY_100339_.tb2_2(4),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg)'
,
'OPEN'
,
to_date('26-08-2017 12:10:54','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - REQUEST_DATE - inicialización de la fecha de registro'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb1_0(2):=26;
RQTY_100339_.tb1_1(2):=RQTY_100339_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100339_.tb1_0(2),
MODULE_ID=RQTY_100339_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100339_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100339_.tb1_0(2),
RQTY_100339_.tb1_1(2),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(5):=121269258;
RQTY_100339_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(5):=RQTY_100339_.tb2_0(5);
RQTY_100339_.old_tb2_1(5):='MO_VALIDATTR_CT26E121269258'
;
RQTY_100339_.tb2_1(5):=RQTY_100339_.tb2_0(5);
RQTY_100339_.tb2_2(5):=RQTY_100339_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(5),
RQTY_100339_.tb2_1(5),
RQTY_100339_.tb2_2(5),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PROCESS","PACKAGE_TYPE_ID",nuPackageTypeId);nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPackageTypeId, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No está permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,););)'
,
'OPEN'
,
to_date('26-08-2017 12:10:55','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PACKAGES - REQUEST_DATE - Valida que la fecha de registro hacia atrás no sea mayor al numéro de días definido en el parámetro MAX_DAYS'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb6_0(25):=108275;
RQTY_100339_.tb6_1(25):=RQTY_100339_.tb5_0(0);
RQTY_100339_.old_tb6_2(25):=17;
RQTY_100339_.tb6_2(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100339_.TBENTITYNAME(NVL(RQTY_100339_.old_tb6_2(25),-1)));
RQTY_100339_.old_tb6_3(25):=258;
RQTY_100339_.tb6_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_3(25),-1)));
RQTY_100339_.old_tb6_4(25):=null;
RQTY_100339_.tb6_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_4(25),-1)));
RQTY_100339_.old_tb6_5(25):=null;
RQTY_100339_.tb6_5(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100339_.TBENTITYATTRIBUTENAME(NVL(RQTY_100339_.old_tb6_5(25),-1)));
RQTY_100339_.tb6_7(25):=RQTY_100339_.tb2_0(4);
RQTY_100339_.tb6_8(25):=RQTY_100339_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (25)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100339_.tb6_0(25),
PACKAGE_TYPE_ID=RQTY_100339_.tb6_1(25),
ENTITY_ID=RQTY_100339_.tb6_2(25),
ENTITY_ATTRIBUTE_ID=RQTY_100339_.tb6_3(25),
MIRROR_ENTI_ATTRIB=RQTY_100339_.tb6_4(25),
PARENT_ATTRIBUTE_ID=RQTY_100339_.tb6_5(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100339_.tb6_7(25),
VALID_EXPRESSION_ID=RQTY_100339_.tb6_8(25),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100339_.tb6_0(25);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100339_.tb6_0(25),
RQTY_100339_.tb6_1(25),
RQTY_100339_.tb6_2(25),
RQTY_100339_.tb6_3(25),
RQTY_100339_.tb6_4(25),
RQTY_100339_.tb6_5(25),
null,
RQTY_100339_.tb6_7(25),
RQTY_100339_.tb6_8(25),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb8_0(0):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100339_.tb8_0(0),
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

 WHERE ATTRIBUTE_ID = RQTY_100339_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100339_.tb8_0(0),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb9_0(0):=RQTY_100339_.tb5_0(0);
RQTY_100339_.tb9_1(0):=RQTY_100339_.tb8_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100339_.tb9_0(0),
RQTY_100339_.tb9_1(0),
'Número máximo de días'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb1_0(3):=69;
RQTY_100339_.tb1_1(3):=RQTY_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100339_.tb1_0(3),
MODULE_ID=RQTY_100339_.tb1_1(3),
DESCRIPTION='Reglas validación de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULVAL_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100339_.tb1_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100339_.tb1_0(3),
RQTY_100339_.tb1_1(3),
'Reglas validación de atributos'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(6):=121269260;
RQTY_100339_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(6):=RQTY_100339_.tb2_0(6);
RQTY_100339_.old_tb2_1(6):='GEGE_EXERULVAL_CT69E121269260'
;
RQTY_100339_.tb2_1(6):=RQTY_100339_.tb2_0(6);
RQTY_100339_.tb2_2(6):=RQTY_100339_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(6),
RQTY_100339_.tb2_1(6),
RQTY_100339_.tb2_2(6),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProducto);TT_BOVALIDATERULES.VALPRODABSORB(nuIdProducto)'
,
'LBTEST'
,
to_date('25-07-2012 09:55:46','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla Valida la absorción de un producto en una falla'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb8_0(1):=157;
RQTY_100339_.tb8_1(1):=RQTY_100339_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100339_.tb8_0(1),
VALID_EXPRESSION=RQTY_100339_.tb8_1(1),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PRODUCT_ABSORB_FAULT'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida la absorción de un producto en una falla'
,
DISPLAY_NAME='Valida la absorción de un producto en una falla'

 WHERE ATTRIBUTE_ID = RQTY_100339_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100339_.tb8_0(1),
RQTY_100339_.tb8_1(1),
null,
1,
5,
22,
'VAL_PRODUCT_ABSORB_FAULT'
,
4,
0,
0,
null,
null,
'Valida la absorción de un producto en una falla'
,
'Valida la absorción de un producto en una falla'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb9_0(1):=RQTY_100339_.tb5_0(0);
RQTY_100339_.tb9_1(1):=RQTY_100339_.tb8_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100339_.tb9_0(1),
RQTY_100339_.tb9_1(1),
'Valida la absorción de un producto en una falla'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(7):=121269261;
RQTY_100339_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(7):=RQTY_100339_.tb2_0(7);
RQTY_100339_.old_tb2_1(7):='GEGE_EXERULVAL_CT69E121269261'
;
RQTY_100339_.tb2_1(7):=RQTY_100339_.tb2_0(7);
RQTY_100339_.tb2_2(7):=RQTY_100339_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(7),
RQTY_100339_.tb2_1(7),
RQTY_100339_.tb2_2(7),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuContrato);GC_BOINSOLVENCY.VALIDATESUSCRIPTIONTYPE(nuContrato,sbInsolvente);if (sbInsolvente = GE_BOCONSTANTS.GETYES(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El trámite no puede ser ejecutado ya que el contrato se encuentra en proceso de Insolvencia Económica");,)'
,
'LBTEST'
,
to_date('26-07-2012 19:36:38','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida que el contrato no se encuentre en proceso de insolvencia económica (Nivel Producto)'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb8_0(2):=166;
RQTY_100339_.tb8_1(2):=RQTY_100339_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100339_.tb8_0(2),
VALID_EXPRESSION=RQTY_100339_.tb8_1(2),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_CONTRA_NO_TENGA_INSOL_ECONO_NIV_PROD'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que el contrato no se encuentre en insolvencia económica (NIVEL PRODUCTO)'
,
DISPLAY_NAME='Valida que el contrato no se encuentre en insolvencia económica (NIVEL PRODUCTO)'

 WHERE ATTRIBUTE_ID = RQTY_100339_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100339_.tb8_0(2),
RQTY_100339_.tb8_1(2),
null,
1,
5,
22,
'VAL_CONTRA_NO_TENGA_INSOL_ECONO_NIV_PROD'
,
null,
null,
null,
null,
null,
'Valida que el contrato no se encuentre en insolvencia económica (NIVEL PRODUCTO)'
,
'Valida que el contrato no se encuentre en insolvencia económica (NIVEL PRODUCTO)'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb9_0(2):=RQTY_100339_.tb5_0(0);
RQTY_100339_.tb9_1(2):=RQTY_100339_.tb8_0(2);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (2)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100339_.tb9_0(2),
RQTY_100339_.tb9_1(2),
'Valida que el contrato no se encuentre en insolvencia económica (NIVEL PRODUCTO)'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.old_tb2_0(8):=121269262;
RQTY_100339_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100339_.tb2_0(8):=RQTY_100339_.tb2_0(8);
RQTY_100339_.old_tb2_1(8):='GEGE_EXERULVAL_CT69E121269262'
;
RQTY_100339_.tb2_1(8):=RQTY_100339_.tb2_0(8);
RQTY_100339_.tb2_2(8):=RQTY_100339_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100339_.tb2_0(8),
RQTY_100339_.tb2_1(8),
RQTY_100339_.tb2_2(8),
'TT_BOVALIDATERULES.VALIDATEPRODUCTCUTSTATE()'
,
'TESTOSS'
,
to_date('13-06-2008 11:11:27','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida estado de corte de un producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb8_0(3):=1066;
RQTY_100339_.tb8_1(3):=RQTY_100339_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (3)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100339_.tb8_0(3),
VALID_EXPRESSION=RQTY_100339_.tb8_1(3),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PROD_STATE_CUT'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida estado de un producto'
,
DISPLAY_NAME='Valida estado de corte de un producto'

 WHERE ATTRIBUTE_ID = RQTY_100339_.tb8_0(3);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100339_.tb8_0(3),
RQTY_100339_.tb8_1(3),
null,
1,
5,
22,
'VAL_PROD_STATE_CUT'
,
4,
0,
0,
null,
null,
'Valida estado de un producto'
,
'Valida estado de corte de un producto'
);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb9_0(3):=RQTY_100339_.tb5_0(0);
RQTY_100339_.tb9_1(3):=RQTY_100339_.tb8_0(3);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (3)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100339_.tb9_0(3),
RQTY_100339_.tb9_1(3),
'Valida estado de corte de un producto'
,
'N'
,
3,
'E'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb10_0(0):=10000000317;
RQTY_100339_.tb10_1(0):=RQTY_100339_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100339_.tb10_0(0),
PACKAGE_TYPE_ID=RQTY_100339_.tb10_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=170,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100339_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100339_.tb10_0(0),
RQTY_100339_.tb10_1(0),
null,
null,
170,
21);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb11_0(0):=100321;
RQTY_100339_.tb11_1(0):=RQTY_100339_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100339_.tb11_0(0),
VALUE_1=RQTY_100339_.tb11_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=170,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Registro de Daño a Producto por XML'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100339_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100339_.tb11_0(0),
RQTY_100339_.tb11_1(0),
null,
21,
170,
0,
31536000,
0,
'Registro de Daño a Producto por XML'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb12_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100339_.tb12_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb13_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100339_.tb13_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb14_0(0):=7053;
RQTY_100339_.tb14_2(0):=RQTY_100339_.tb12_0(0);
RQTY_100339_.tb14_3(0):=RQTY_100339_.tb13_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100339_.tb14_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100339_.tb14_2(0),
SERVSETI=RQTY_100339_.tb14_3(0),
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
 WHERE SERVCODI = RQTY_100339_.tb14_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100339_.tb14_0(0),
null,
RQTY_100339_.tb14_2(0),
RQTY_100339_.tb14_3(0),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb15_0(0):=33;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100339_.tb15_0(0),
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
 WHERE MOTIVE_TYPE_ID = RQTY_100339_.tb15_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100339_.tb15_0(0),
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb16_0(0):=100325;
RQTY_100339_.tb16_1(0):=RQTY_100339_.tb14_0(0);
RQTY_100339_.tb16_2(0):=RQTY_100339_.tb15_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100339_.tb16_0(0),
RQTY_100339_.tb16_1(0),
RQTY_100339_.tb16_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_DANO_A_PRODUCTO_100325'
,
'Daño a Producto'
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
RQTY_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;

RQTY_100339_.tb17_0(0):=100336;
RQTY_100339_.tb17_1(0):=RQTY_100339_.tb16_0(0);
RQTY_100339_.tb17_3(0):=RQTY_100339_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100339_.tb17_0(0),
PRODUCT_MOTIVE_ID=RQTY_100339_.tb17_1(0),
PRODUCT_TYPE_ID=7053,
PACKAGE_TYPE_ID=RQTY_100339_.tb17_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100339_.tb17_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100339_.tb17_0(0),
RQTY_100339_.tb17_1(0),
7053,
RQTY_100339_.tb17_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100339_.blProcessStatus := false;
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
nuIndex := RQTY_100339_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100339_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100339_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100339_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100339_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100339_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100339_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100339_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100339_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100339_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100339_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100339_.blProcessStatus := false;
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
 nuIndex := RQTY_100339_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100339_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100339_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100339_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100339_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100339_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100339_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100339_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100339_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100339_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100339_',
'CREATE OR REPLACE PACKAGE RQPMT_100339_ IS ' || chr(10) ||
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
'tb0_1 ty0_1;type ty1_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GR_CONFIGURA_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty4_0 is table of PS_PROD_MOTI_ATTRIB.PROD_MOTI_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of PS_PROD_MOTI_ATTRIB.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of PS_PROD_MOTI_ATTRIB.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of PS_PROD_MOTI_ATTRIB.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty4_4 is table of PS_PROD_MOTI_ATTRIB.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_4 ty4_4; ' || chr(10) ||
'tb4_4 ty4_4;type ty4_5 is table of PS_PROD_MOTI_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_5 ty4_5; ' || chr(10) ||
'tb4_5 ty4_5;type ty4_6 is table of PS_PROD_MOTI_ATTRIB.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_6 ty4_6; ' || chr(10) ||
'tb4_6 ty4_6;type ty4_7 is table of PS_PROD_MOTI_ATTRIB.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_7 ty4_7; ' || chr(10) ||
'tb4_7 ty4_7;type ty4_8 is table of PS_PROD_MOTI_ATTRIB.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_8 ty4_8; ' || chr(10) ||
'tb4_8 ty4_8;type ty4_9 is table of PS_PROD_MOTI_ATTRIB.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_9 ty4_9; ' || chr(10) ||
'tb4_9 ty4_9;type ty5_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty6_0 is table of PS_PROD_MOTI_EVENTS.PROD_MOTI_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of PS_PROD_MOTI_EVENTS.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty7_0 is table of PS_WHEN_MOTIVE.WHEN_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_WHEN_MOTIVE.PROD_MOTI_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of PS_WHEN_MOTIVE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 100339; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100339 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100339 ' || chr(10) ||
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
'END RQPMT_100339_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100339_******************************'); END;
/

BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100339_.cuExpressions;
fetch RQPMT_100339_.cuExpressions bulk collect INTO RQPMT_100339_.tbExpressionsId;
close RQPMT_100339_.cuExpressions;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100339_.tbEntityName(-1) := 'NULL';
   RQPMT_100339_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQPMT_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQPMT_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQPMT_100339_.tbEntityAttributeName(1959) := 'PR_TIMEOUT_COMPONENT@INITIAL_DATE';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQPMT_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQPMT_100339_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQPMT_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100339_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100339_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQPMT_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100339_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQPMT_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100339_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQPMT_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQPMT_100339_.tbEntityAttributeName(97550) := 'PR_TIMEOUT_COMPONENT@PACKAGE_ID';
   RQPMT_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQPMT_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQPMT_100339_.tbEntityAttributeName(1957) := 'PR_TIMEOUT_COMPONENT@TIMEOUT_COMPONENT_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100339_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQPMT_100339_.tbEntityAttributeName(138162) := 'GI_ATTRIBS@ATTRIB02';
   RQPMT_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQPMT_100339_.tbEntityAttributeName(1960) := 'PR_TIMEOUT_COMPONENT@FINAL_DATE';
   RQPMT_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100339_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQPMT_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100339_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100339
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
WHERE PACKAGE_type_id = 100339
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
WHERE PACKAGE_type_id = 100339
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
WHERE PACKAGE_type_id = 100339
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
WHERE PACKAGE_type_id = 100339
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
WHERE PACKAGE_type_id = 100339
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100339_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100339
))));

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100339_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100339_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100339_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100339_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100339
))));

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100339
))));

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100339_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100339_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100339
)))));

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100339_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100339_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100339_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100339_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100339_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100339_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100339
))));

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
))));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100339
))));

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
)));
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100339_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100339_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100339_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100339_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100339_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100339_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100339_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100339
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb0_0(0):=100325;
RQPMT_100339_.tb0_1(0):=7053;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100339_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100339_.tb0_1(0),
MOTIVE_TYPE_ID=33,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_DANO_A_PRODUCTO_100325'
,
DESCRIPTION='Daño a Producto'
,
USE_UNCOMPOSITION='N'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100339_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100339_.tb0_0(0),
RQPMT_100339_.tb0_1(0),
33,
null,
'N'
,
'N'
,
'N'
,
'M_DANO_A_PRODUCTO_100325'
,
'Daño a Producto'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb1_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100339_.tb1_0(0),
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

 WHERE MODULE_ID = RQPMT_100339_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100339_.tb1_0(0),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb2_0(0):=23;
RQPMT_100339_.tb2_1(0):=RQPMT_100339_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100339_.tb2_0(0),
MODULE_ID=RQPMT_100339_.tb2_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100339_.tb2_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100339_.tb2_0(0),
RQPMT_100339_.tb2_1(0),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.old_tb3_0(0):=121269263;
RQPMT_100339_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100339_.tb3_0(0):=RQPMT_100339_.tb3_0(0);
RQPMT_100339_.old_tb3_1(0):='MO_INITATRIB_CT23E121269263'
;
RQPMT_100339_.tb3_1(0):=RQPMT_100339_.tb3_0(0);
RQPMT_100339_.tb3_2(0):=RQPMT_100339_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100339_.tb3_0(0),
RQPMT_100339_.tb3_1(0),
RQPMT_100339_.tb3_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'OPEN'
,
to_date('26-08-2017 12:11:03','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(0):=105188;
RQPMT_100339_.old_tb4_1(0):=8;
RQPMT_100339_.tb4_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(0),-1)));
RQPMT_100339_.old_tb4_2(0):=187;
RQPMT_100339_.tb4_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(0),-1)));
RQPMT_100339_.old_tb4_3(0):=null;
RQPMT_100339_.tb4_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(0),-1)));
RQPMT_100339_.old_tb4_4(0):=null;
RQPMT_100339_.tb4_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(0),-1)));
RQPMT_100339_.tb4_6(0):=RQPMT_100339_.tb3_0(0);
RQPMT_100339_.tb4_9(0):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(0),
ENTITY_ID=RQPMT_100339_.tb4_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100339_.tb4_6(0),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(0),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(0),
RQPMT_100339_.tb4_1(0),
RQPMT_100339_.tb4_2(0),
RQPMT_100339_.tb4_3(0),
RQPMT_100339_.tb4_4(0),
null,
RQPMT_100339_.tb4_6(0),
null,
null,
RQPMT_100339_.tb4_9(0),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(1):=105189;
RQPMT_100339_.old_tb4_1(1):=8;
RQPMT_100339_.tb4_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(1),-1)));
RQPMT_100339_.old_tb4_2(1):=213;
RQPMT_100339_.tb4_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(1),-1)));
RQPMT_100339_.old_tb4_3(1):=255;
RQPMT_100339_.tb4_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(1),-1)));
RQPMT_100339_.old_tb4_4(1):=null;
RQPMT_100339_.tb4_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(1),-1)));
RQPMT_100339_.tb4_9(1):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(1),
ENTITY_ID=RQPMT_100339_.tb4_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(1),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(1),
RQPMT_100339_.tb4_1(1),
RQPMT_100339_.tb4_2(1),
RQPMT_100339_.tb4_3(1),
RQPMT_100339_.tb4_4(1),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(1),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(2):=105190;
RQPMT_100339_.old_tb4_1(2):=8;
RQPMT_100339_.tb4_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(2),-1)));
RQPMT_100339_.old_tb4_2(2):=2641;
RQPMT_100339_.tb4_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(2),-1)));
RQPMT_100339_.old_tb4_3(2):=null;
RQPMT_100339_.tb4_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(2),-1)));
RQPMT_100339_.old_tb4_4(2):=null;
RQPMT_100339_.tb4_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(2),-1)));
RQPMT_100339_.tb4_9(2):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(2),
ENTITY_ID=RQPMT_100339_.tb4_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(2),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Límite de Crédito'
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
TAG_NAME='LIMITE_DE_CREDITO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(2),
RQPMT_100339_.tb4_1(2),
RQPMT_100339_.tb4_2(2),
RQPMT_100339_.tb4_3(2),
RQPMT_100339_.tb4_4(2),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(2),
2,
'Límite de Crédito'
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
'LIMITE_DE_CREDITO'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(3):=105191;
RQPMT_100339_.old_tb4_1(3):=8;
RQPMT_100339_.tb4_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(3),-1)));
RQPMT_100339_.old_tb4_2(3):=189;
RQPMT_100339_.tb4_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(3),-1)));
RQPMT_100339_.old_tb4_3(3):=257;
RQPMT_100339_.tb4_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(3),-1)));
RQPMT_100339_.old_tb4_4(3):=null;
RQPMT_100339_.tb4_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(3),-1)));
RQPMT_100339_.tb4_9(3):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(3),
ENTITY_ID=RQPMT_100339_.tb4_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(3),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Número Petición Atención al cliente'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(3),
RQPMT_100339_.tb4_1(3),
RQPMT_100339_.tb4_2(3),
RQPMT_100339_.tb4_3(3),
RQPMT_100339_.tb4_4(3),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(3),
3,
'Número Petición Atención al cliente'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(4):=105192;
RQPMT_100339_.old_tb4_1(4):=8;
RQPMT_100339_.tb4_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(4),-1)));
RQPMT_100339_.old_tb4_2(4):=50001324;
RQPMT_100339_.tb4_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(4),-1)));
RQPMT_100339_.old_tb4_3(4):=null;
RQPMT_100339_.tb4_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(4),-1)));
RQPMT_100339_.old_tb4_4(4):=null;
RQPMT_100339_.tb4_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(4),-1)));
RQPMT_100339_.tb4_9(4):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(4),
ENTITY_ID=RQPMT_100339_.tb4_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(4),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Ubicación Geográfica'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(4),
RQPMT_100339_.tb4_1(4),
RQPMT_100339_.tb4_2(4),
RQPMT_100339_.tb4_3(4),
RQPMT_100339_.tb4_4(4),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(4),
4,
'Ubicación Geográfica'
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
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(5):=105193;
RQPMT_100339_.old_tb4_1(5):=8;
RQPMT_100339_.tb4_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(5),-1)));
RQPMT_100339_.old_tb4_2(5):=201;
RQPMT_100339_.tb4_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(5),-1)));
RQPMT_100339_.old_tb4_3(5):=null;
RQPMT_100339_.tb4_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(5),-1)));
RQPMT_100339_.old_tb4_4(5):=null;
RQPMT_100339_.tb4_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(5),-1)));
RQPMT_100339_.tb4_9(5):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(5),
ENTITY_ID=RQPMT_100339_.tb4_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(5),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(5),
RQPMT_100339_.tb4_1(5),
RQPMT_100339_.tb4_2(5),
RQPMT_100339_.tb4_3(5),
RQPMT_100339_.tb4_4(5),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(5),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(6):=105194;
RQPMT_100339_.old_tb4_1(6):=8;
RQPMT_100339_.tb4_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(6),-1)));
RQPMT_100339_.old_tb4_2(6):=202;
RQPMT_100339_.tb4_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(6),-1)));
RQPMT_100339_.old_tb4_3(6):=null;
RQPMT_100339_.tb4_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(6),-1)));
RQPMT_100339_.old_tb4_4(6):=null;
RQPMT_100339_.tb4_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(6),-1)));
RQPMT_100339_.tb4_9(6):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(6),
ENTITY_ID=RQPMT_100339_.tb4_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(6),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(6),
RQPMT_100339_.tb4_1(6),
RQPMT_100339_.tb4_2(6),
RQPMT_100339_.tb4_3(6),
RQPMT_100339_.tb4_4(6),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(6),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(7):=105195;
RQPMT_100339_.old_tb4_1(7):=8;
RQPMT_100339_.tb4_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(7),-1)));
RQPMT_100339_.old_tb4_2(7):=498;
RQPMT_100339_.tb4_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(7),-1)));
RQPMT_100339_.old_tb4_3(7):=null;
RQPMT_100339_.tb4_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(7),-1)));
RQPMT_100339_.old_tb4_4(7):=null;
RQPMT_100339_.tb4_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(7),-1)));
RQPMT_100339_.tb4_9(7):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(7),
ENTITY_ID=RQPMT_100339_.tb4_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(7),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Fecha de Atención'
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
TAG_NAME='FECHA_DE_ATENCION'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(7),
RQPMT_100339_.tb4_1(7),
RQPMT_100339_.tb4_2(7),
RQPMT_100339_.tb4_3(7),
RQPMT_100339_.tb4_4(7),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(7),
7,
'Fecha de Atención'
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
'FECHA_DE_ATENCION'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(8):=105196;
RQPMT_100339_.old_tb4_1(8):=8;
RQPMT_100339_.tb4_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(8),-1)));
RQPMT_100339_.old_tb4_2(8):=220;
RQPMT_100339_.tb4_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(8),-1)));
RQPMT_100339_.old_tb4_3(8):=null;
RQPMT_100339_.tb4_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(8),-1)));
RQPMT_100339_.old_tb4_4(8):=null;
RQPMT_100339_.tb4_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(8),-1)));
RQPMT_100339_.tb4_9(8):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(8),
ENTITY_ID=RQPMT_100339_.tb4_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(8),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Identificador de Distribución Administrativa'
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
TAG_NAME='IDENTIFICADOR_DE_DISTRIBUCION_ADMINISTRATIVA'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(8),
RQPMT_100339_.tb4_1(8),
RQPMT_100339_.tb4_2(8),
RQPMT_100339_.tb4_3(8),
RQPMT_100339_.tb4_4(8),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(8),
8,
'Identificador de Distribución Administrativa'
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
'IDENTIFICADOR_DE_DISTRIBUCION_ADMINISTRATIVA'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(9):=105199;
RQPMT_100339_.old_tb4_1(9):=8;
RQPMT_100339_.tb4_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(9),-1)));
RQPMT_100339_.old_tb4_2(9):=192;
RQPMT_100339_.tb4_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(9),-1)));
RQPMT_100339_.old_tb4_3(9):=null;
RQPMT_100339_.tb4_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(9),-1)));
RQPMT_100339_.old_tb4_4(9):=null;
RQPMT_100339_.tb4_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(9),-1)));
RQPMT_100339_.tb4_9(9):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(9),
ENTITY_ID=RQPMT_100339_.tb4_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(9),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Identificador del Tipo de Producto'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='Y'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(9),
RQPMT_100339_.tb4_1(9),
RQPMT_100339_.tb4_2(9),
RQPMT_100339_.tb4_3(9),
RQPMT_100339_.tb4_4(9),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(9),
11,
'Identificador del Tipo de Producto'
,
11,
'Y'
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
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(10):=105200;
RQPMT_100339_.old_tb4_1(10):=8;
RQPMT_100339_.tb4_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(10),-1)));
RQPMT_100339_.old_tb4_2(10):=11403;
RQPMT_100339_.tb4_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(10),-1)));
RQPMT_100339_.old_tb4_3(10):=null;
RQPMT_100339_.tb4_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(10),-1)));
RQPMT_100339_.old_tb4_4(10):=null;
RQPMT_100339_.tb4_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(10),-1)));
RQPMT_100339_.tb4_9(10):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(10),
ENTITY_ID=RQPMT_100339_.tb4_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(10),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador de la Suscripción'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='Y'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(10),
RQPMT_100339_.tb4_1(10),
RQPMT_100339_.tb4_2(10),
RQPMT_100339_.tb4_3(10),
RQPMT_100339_.tb4_4(10),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(10),
12,
'Identificador de la Suscripción'
,
12,
'Y'
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
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(11):=105201;
RQPMT_100339_.old_tb4_1(11):=8;
RQPMT_100339_.tb4_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(11),-1)));
RQPMT_100339_.old_tb4_2(11):=6683;
RQPMT_100339_.tb4_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(11),-1)));
RQPMT_100339_.old_tb4_3(11):=null;
RQPMT_100339_.tb4_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(11),-1)));
RQPMT_100339_.old_tb4_4(11):=null;
RQPMT_100339_.tb4_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(11),-1)));
RQPMT_100339_.tb4_9(11):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(11),
ENTITY_ID=RQPMT_100339_.tb4_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(11),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='CLIENT_PRIVACY_FLAG'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(11),
RQPMT_100339_.tb4_1(11),
RQPMT_100339_.tb4_2(11),
RQPMT_100339_.tb4_3(11),
RQPMT_100339_.tb4_4(11),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(11),
13,
'CLIENT_PRIVACY_FLAG'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(12):=105202;
RQPMT_100339_.old_tb4_1(12):=5872;
RQPMT_100339_.tb4_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(12),-1)));
RQPMT_100339_.old_tb4_2(12):=138162;
RQPMT_100339_.tb4_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(12),-1)));
RQPMT_100339_.old_tb4_3(12):=null;
RQPMT_100339_.tb4_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(12),-1)));
RQPMT_100339_.old_tb4_4(12):=null;
RQPMT_100339_.tb4_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(12),-1)));
RQPMT_100339_.tb4_9(12):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(12),
ENTITY_ID=RQPMT_100339_.tb4_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(12),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Tiempos Fuera de Servicio'
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
TAG_NAME='TIEMPOS_FUERA_DE_SERVICIO'
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
ATTRI_TECHNICAL_NAME='ATTRIB02'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(12),
RQPMT_100339_.tb4_1(12),
RQPMT_100339_.tb4_2(12),
RQPMT_100339_.tb4_3(12),
RQPMT_100339_.tb4_4(12),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(12),
15,
'Tiempos Fuera de Servicio'
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
'TIEMPOS_FUERA_DE_SERVICIO'
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
'ATTRIB02'
,
'N'
,
'N'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(13):=105203;
RQPMT_100339_.old_tb4_1(13):=205;
RQPMT_100339_.tb4_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(13),-1)));
RQPMT_100339_.old_tb4_2(13):=1959;
RQPMT_100339_.tb4_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(13),-1)));
RQPMT_100339_.old_tb4_3(13):=null;
RQPMT_100339_.tb4_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(13),-1)));
RQPMT_100339_.old_tb4_4(13):=null;
RQPMT_100339_.tb4_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(13),-1)));
RQPMT_100339_.tb4_9(13):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(13),
ENTITY_ID=RQPMT_100339_.tb4_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(13),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Fecha Inicial de Afectación'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='INITIAL_DATE'
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
ENTITY_NAME='PR_TIMEOUT_COMPONENT'
,
ATTRI_TECHNICAL_NAME='INITIAL_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(13),
RQPMT_100339_.tb4_1(13),
RQPMT_100339_.tb4_2(13),
RQPMT_100339_.tb4_3(13),
RQPMT_100339_.tb4_4(13),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(13),
16,
'Fecha Inicial de Afectación'
,
16,
'Y'
,
'N'
,
'N'
,
'N'
,
'INITIAL_DATE'
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
'PR_TIMEOUT_COMPONENT'
,
'INITIAL_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(14):=105204;
RQPMT_100339_.old_tb4_1(14):=205;
RQPMT_100339_.tb4_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(14),-1)));
RQPMT_100339_.old_tb4_2(14):=1960;
RQPMT_100339_.tb4_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(14),-1)));
RQPMT_100339_.old_tb4_3(14):=null;
RQPMT_100339_.tb4_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(14),-1)));
RQPMT_100339_.old_tb4_4(14):=null;
RQPMT_100339_.tb4_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(14),-1)));
RQPMT_100339_.tb4_9(14):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(14),
ENTITY_ID=RQPMT_100339_.tb4_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(14),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Fecha Final de Afectación'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='FINAL_DATE'
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
ENTITY_NAME='PR_TIMEOUT_COMPONENT'
,
ATTRI_TECHNICAL_NAME='FINAL_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(14),
RQPMT_100339_.tb4_1(14),
RQPMT_100339_.tb4_2(14),
RQPMT_100339_.tb4_3(14),
RQPMT_100339_.tb4_4(14),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(14),
17,
'Fecha Final de Afectación'
,
17,
'Y'
,
'N'
,
'N'
,
'N'
,
'FINAL_DATE'
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
'PR_TIMEOUT_COMPONENT'
,
'FINAL_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(15):=105205;
RQPMT_100339_.old_tb4_1(15):=5872;
RQPMT_100339_.tb4_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(15),-1)));
RQPMT_100339_.old_tb4_2(15):=138161;
RQPMT_100339_.tb4_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(15),-1)));
RQPMT_100339_.old_tb4_3(15):=null;
RQPMT_100339_.tb4_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(15),-1)));
RQPMT_100339_.old_tb4_4(15):=null;
RQPMT_100339_.tb4_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(15),-1)));
RQPMT_100339_.tb4_9(15):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(15),
ENTITY_ID=RQPMT_100339_.tb4_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(15),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Atención Inmediata'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='ATENCION_INMEDIATA'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(15),
RQPMT_100339_.tb4_1(15),
RQPMT_100339_.tb4_2(15),
RQPMT_100339_.tb4_3(15),
RQPMT_100339_.tb4_4(15),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(15),
18,
'Atención Inmediata'
,
18,
'Y'
,
'N'
,
'N'
,
'N'
,
'ATENCION_INMEDIATA'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.old_tb3_0(1):=121269264;
RQPMT_100339_.tb3_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100339_.tb3_0(1):=RQPMT_100339_.tb3_0(1);
RQPMT_100339_.old_tb3_1(1):='MO_INITATRIB_CT23E121269264'
;
RQPMT_100339_.tb3_1(1):=RQPMT_100339_.tb3_0(1);
RQPMT_100339_.tb3_2(1):=RQPMT_100339_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100339_.tb3_0(1),
RQPMT_100339_.tb3_1(1),
RQPMT_100339_.tb3_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(SEQ.GETNEXT("SEQ_PR_TIMEOUT_COMPONENT", GE_BOCONSTANTS.GETFALSE()))'
,
'OPEN'
,
to_date('26-08-2017 12:11:05','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - PR_TIMEOUT_COMPONENT - TIMEOUT_COMPONENT_ID - Inicia el identificador de lapsos de tiempo fuera de servicio'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(16):=105206;
RQPMT_100339_.old_tb4_1(16):=205;
RQPMT_100339_.tb4_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(16),-1)));
RQPMT_100339_.old_tb4_2(16):=1957;
RQPMT_100339_.tb4_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(16),-1)));
RQPMT_100339_.old_tb4_3(16):=null;
RQPMT_100339_.tb4_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(16),-1)));
RQPMT_100339_.old_tb4_4(16):=null;
RQPMT_100339_.tb4_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(16),-1)));
RQPMT_100339_.tb4_6(16):=RQPMT_100339_.tb3_0(1);
RQPMT_100339_.tb4_9(16):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(16),
ENTITY_ID=RQPMT_100339_.tb4_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100339_.tb4_6(16),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(16),
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Consecutivo de Tiempos Fuera'
,
DISPLAY_ORDER=19,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='TIMEOUT_COMPONENT_ID'
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
ENTITY_NAME='PR_TIMEOUT_COMPONENT'
,
ATTRI_TECHNICAL_NAME='TIMEOUT_COMPONENT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(16),
RQPMT_100339_.tb4_1(16),
RQPMT_100339_.tb4_2(16),
RQPMT_100339_.tb4_3(16),
RQPMT_100339_.tb4_4(16),
null,
RQPMT_100339_.tb4_6(16),
null,
null,
RQPMT_100339_.tb4_9(16),
19,
'Consecutivo de Tiempos Fuera'
,
19,
'N'
,
'N'
,
'N'
,
'Y'
,
'TIMEOUT_COMPONENT_ID'
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
'PR_TIMEOUT_COMPONENT'
,
'TIMEOUT_COMPONENT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(17):=105207;
RQPMT_100339_.old_tb4_1(17):=205;
RQPMT_100339_.tb4_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(17),-1)));
RQPMT_100339_.old_tb4_2(17):=97550;
RQPMT_100339_.tb4_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(17),-1)));
RQPMT_100339_.old_tb4_3(17):=255;
RQPMT_100339_.tb4_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(17),-1)));
RQPMT_100339_.old_tb4_4(17):=null;
RQPMT_100339_.tb4_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(17),-1)));
RQPMT_100339_.tb4_9(17):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(17),
ENTITY_ID=RQPMT_100339_.tb4_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(17),
PROCESS_SEQUENCE=20,
DISPLAY_NAME='CÓDIGO DEL PAQUETE'
,
DISPLAY_ORDER=20,
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
ENTITY_NAME='PR_TIMEOUT_COMPONENT'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(17),
RQPMT_100339_.tb4_1(17),
RQPMT_100339_.tb4_2(17),
RQPMT_100339_.tb4_3(17),
RQPMT_100339_.tb4_4(17),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(17),
20,
'CÓDIGO DEL PAQUETE'
,
20,
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
'PR_TIMEOUT_COMPONENT'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(18):=105197;
RQPMT_100339_.old_tb4_1(18):=8;
RQPMT_100339_.tb4_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(18),-1)));
RQPMT_100339_.old_tb4_2(18):=524;
RQPMT_100339_.tb4_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(18),-1)));
RQPMT_100339_.old_tb4_3(18):=null;
RQPMT_100339_.tb4_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(18),-1)));
RQPMT_100339_.old_tb4_4(18):=null;
RQPMT_100339_.tb4_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(18),-1)));
RQPMT_100339_.tb4_9(18):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(18),
ENTITY_ID=RQPMT_100339_.tb4_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(18),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(18),
RQPMT_100339_.tb4_1(18),
RQPMT_100339_.tb4_2(18),
RQPMT_100339_.tb4_3(18),
RQPMT_100339_.tb4_4(18),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(18),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(19):=105198;
RQPMT_100339_.old_tb4_1(19):=8;
RQPMT_100339_.tb4_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(19),-1)));
RQPMT_100339_.old_tb4_2(19):=191;
RQPMT_100339_.tb4_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(19),-1)));
RQPMT_100339_.old_tb4_3(19):=null;
RQPMT_100339_.tb4_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(19),-1)));
RQPMT_100339_.old_tb4_4(19):=null;
RQPMT_100339_.tb4_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(19),-1)));
RQPMT_100339_.tb4_9(19):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (19)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(19),
ENTITY_ID=RQPMT_100339_.tb4_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(19),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Identificador del Tipo de Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(19);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(19),
RQPMT_100339_.tb4_1(19),
RQPMT_100339_.tb4_2(19),
RQPMT_100339_.tb4_3(19),
RQPMT_100339_.tb4_4(19),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(19),
10,
'Identificador del Tipo de Motivo'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(20):=105209;
RQPMT_100339_.old_tb4_1(20):=8;
RQPMT_100339_.tb4_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(20),-1)));
RQPMT_100339_.old_tb4_2(20):=144514;
RQPMT_100339_.tb4_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(20),-1)));
RQPMT_100339_.old_tb4_3(20):=189644;
RQPMT_100339_.tb4_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(20),-1)));
RQPMT_100339_.old_tb4_4(20):=null;
RQPMT_100339_.tb4_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(20),-1)));
RQPMT_100339_.tb4_9(20):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (20)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(20),
ENTITY_ID=RQPMT_100339_.tb4_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(20),
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Causal'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(20);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(20),
RQPMT_100339_.tb4_1(20),
RQPMT_100339_.tb4_2(20),
RQPMT_100339_.tb4_3(20),
RQPMT_100339_.tb4_4(20),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(20),
22,
'Causal'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.old_tb5_0(0):=120142782;
RQPMT_100339_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100339_.tb5_0(0):=RQPMT_100339_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100339_.tb5_0(0),
5,
'Respuesta para los registro de Daño a Producto'
,
'SELECT b.answer_id ID, b.description DESCRIPTION
FROM cc_answer b
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'b.request_type_id = 59 '||chr(64)||'
'||chr(64)||'b.is_immediate_attent = '|| chr(39) ||'Y'|| chr(39) ||' '||chr(64)||'
'||chr(64)||'b.answer_id = :ID '||chr(64)||'
'||chr(64)||'b.description like :DESCRIPTION '||chr(64)||''
,
'Respuesta para los registro de Daño a Producto'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(21):=105210;
RQPMT_100339_.old_tb4_1(21):=8;
RQPMT_100339_.tb4_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(21),-1)));
RQPMT_100339_.old_tb4_2(21):=144591;
RQPMT_100339_.tb4_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(21),-1)));
RQPMT_100339_.old_tb4_3(21):=null;
RQPMT_100339_.tb4_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(21),-1)));
RQPMT_100339_.old_tb4_4(21):=null;
RQPMT_100339_.tb4_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(21),-1)));
RQPMT_100339_.tb4_5(21):=RQPMT_100339_.tb5_0(0);
RQPMT_100339_.tb4_9(21):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (21)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(21),
ENTITY_ID=RQPMT_100339_.tb4_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(21),
STATEMENT_ID=RQPMT_100339_.tb4_5(21),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(21),
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Respuesta'
,
DISPLAY_ORDER=23,
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
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(21);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(21),
RQPMT_100339_.tb4_1(21),
RQPMT_100339_.tb4_2(21),
RQPMT_100339_.tb4_3(21),
RQPMT_100339_.tb4_4(21),
RQPMT_100339_.tb4_5(21),
null,
null,
null,
RQPMT_100339_.tb4_9(21),
23,
'Respuesta'
,
23,
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
'N'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(22):=105211;
RQPMT_100339_.old_tb4_1(22):=8;
RQPMT_100339_.tb4_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(22),-1)));
RQPMT_100339_.old_tb4_2(22):=4011;
RQPMT_100339_.tb4_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(22),-1)));
RQPMT_100339_.old_tb4_3(22):=null;
RQPMT_100339_.tb4_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(22),-1)));
RQPMT_100339_.old_tb4_4(22):=null;
RQPMT_100339_.tb4_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(22),-1)));
RQPMT_100339_.tb4_9(22):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (22)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(22),
ENTITY_ID=RQPMT_100339_.tb4_1(22),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(22),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(22),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(22),
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Número del servicio'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(22);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(22),
RQPMT_100339_.tb4_1(22),
RQPMT_100339_.tb4_2(22),
RQPMT_100339_.tb4_3(22),
RQPMT_100339_.tb4_4(22),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(22),
24,
'Número del servicio'
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
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(23):=105212;
RQPMT_100339_.old_tb4_1(23):=21;
RQPMT_100339_.tb4_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(23),-1)));
RQPMT_100339_.old_tb4_2(23):=281;
RQPMT_100339_.tb4_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(23),-1)));
RQPMT_100339_.old_tb4_3(23):=187;
RQPMT_100339_.tb4_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(23),-1)));
RQPMT_100339_.old_tb4_4(23):=null;
RQPMT_100339_.tb4_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(23),-1)));
RQPMT_100339_.tb4_9(23):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (23)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(23),
ENTITY_ID=RQPMT_100339_.tb4_1(23),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(23),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(23),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(23),
PROCESS_SEQUENCE=25,
DISPLAY_NAME='Consecutivo Interno Motivos'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(23);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(23),
RQPMT_100339_.tb4_1(23),
RQPMT_100339_.tb4_2(23),
RQPMT_100339_.tb4_3(23),
RQPMT_100339_.tb4_4(23),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(23),
25,
'Consecutivo Interno Motivos'
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.old_tb3_0(2):=121269265;
RQPMT_100339_.tb3_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100339_.tb3_0(2):=RQPMT_100339_.tb3_0(2);
RQPMT_100339_.old_tb3_1(2):='MO_INITATRIB_CT23E121269265'
;
RQPMT_100339_.tb3_1(2):=RQPMT_100339_.tb3_0(2);
RQPMT_100339_.tb3_2(2):=RQPMT_100339_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100339_.tb3_0(2),
RQPMT_100339_.tb3_1(2),
RQPMT_100339_.tb3_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_MO_ADDRESS"))'
,
'OPEN'
,
to_date('26-08-2017 12:11:07','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_ADDRESS - ADDRESS_ID - Inicia el valor de la secuencia '
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(24):=105213;
RQPMT_100339_.old_tb4_1(24):=21;
RQPMT_100339_.tb4_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(24),-1)));
RQPMT_100339_.old_tb4_2(24):=474;
RQPMT_100339_.tb4_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(24),-1)));
RQPMT_100339_.old_tb4_3(24):=null;
RQPMT_100339_.tb4_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(24),-1)));
RQPMT_100339_.old_tb4_4(24):=null;
RQPMT_100339_.tb4_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(24),-1)));
RQPMT_100339_.tb4_6(24):=RQPMT_100339_.tb3_0(2);
RQPMT_100339_.tb4_9(24):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (24)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(24),
ENTITY_ID=RQPMT_100339_.tb4_1(24),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(24),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(24),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100339_.tb4_6(24),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(24),
PROCESS_SEQUENCE=26,
DISPLAY_NAME='Código de la Dirección'
,
DISPLAY_ORDER=26,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(24);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(24),
RQPMT_100339_.tb4_1(24),
RQPMT_100339_.tb4_2(24),
RQPMT_100339_.tb4_3(24),
RQPMT_100339_.tb4_4(24),
null,
RQPMT_100339_.tb4_6(24),
null,
null,
RQPMT_100339_.tb4_9(24),
26,
'Código de la Dirección'
,
26,
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(25):=105214;
RQPMT_100339_.old_tb4_1(25):=21;
RQPMT_100339_.tb4_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(25),-1)));
RQPMT_100339_.old_tb4_2(25):=39322;
RQPMT_100339_.tb4_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(25),-1)));
RQPMT_100339_.old_tb4_3(25):=213;
RQPMT_100339_.tb4_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(25),-1)));
RQPMT_100339_.old_tb4_4(25):=null;
RQPMT_100339_.tb4_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(25),-1)));
RQPMT_100339_.tb4_9(25):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (25)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(25),
ENTITY_ID=RQPMT_100339_.tb4_1(25),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(25),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(25),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(25),
PROCESS_SEQUENCE=27,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=27,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(25);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(25),
RQPMT_100339_.tb4_1(25),
RQPMT_100339_.tb4_2(25),
RQPMT_100339_.tb4_3(25),
RQPMT_100339_.tb4_4(25),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(25),
27,
'Identificador De Solicitud'
,
27,
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(26):=105208;
RQPMT_100339_.old_tb4_1(26):=8;
RQPMT_100339_.tb4_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(26),-1)));
RQPMT_100339_.old_tb4_2(26):=413;
RQPMT_100339_.tb4_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(26),-1)));
RQPMT_100339_.old_tb4_3(26):=null;
RQPMT_100339_.tb4_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(26),-1)));
RQPMT_100339_.old_tb4_4(26):=null;
RQPMT_100339_.tb4_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(26),-1)));
RQPMT_100339_.tb4_9(26):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (26)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(26),
ENTITY_ID=RQPMT_100339_.tb4_1(26),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(26),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(26),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(26),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(26),
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Producto'
,
DISPLAY_ORDER=21,
INCLUDED_VAL_DOC='Y'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(26);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(26),
RQPMT_100339_.tb4_1(26),
RQPMT_100339_.tb4_2(26),
RQPMT_100339_.tb4_3(26),
RQPMT_100339_.tb4_4(26),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(26),
21,
'Producto'
,
21,
'Y'
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
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb4_0(27):=105216;
RQPMT_100339_.old_tb4_1(27):=21;
RQPMT_100339_.tb4_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100339_.TBENTITYNAME(NVL(RQPMT_100339_.old_tb4_1(27),-1)));
RQPMT_100339_.old_tb4_2(27):=11376;
RQPMT_100339_.tb4_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_2(27),-1)));
RQPMT_100339_.old_tb4_3(27):=null;
RQPMT_100339_.tb4_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_3(27),-1)));
RQPMT_100339_.old_tb4_4(27):=null;
RQPMT_100339_.tb4_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100339_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100339_.old_tb4_4(27),-1)));
RQPMT_100339_.tb4_9(27):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (27)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100339_.tb4_0(27),
ENTITY_ID=RQPMT_100339_.tb4_1(27),
ENTITY_ATTRIBUTE_ID=RQPMT_100339_.tb4_2(27),
MIRROR_ENTI_ATTRIB=RQPMT_100339_.tb4_3(27),
PARENT_ATTRIBUTE_ID=RQPMT_100339_.tb4_4(27),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb4_9(27),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Identificador Parseo Direccion'
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
TAG_NAME='PARSER_ADDRESS_ID'
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
ATTRI_TECHNICAL_NAME='PARSER_ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100339_.tb4_0(27);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100339_.tb4_0(27),
RQPMT_100339_.tb4_1(27),
RQPMT_100339_.tb4_2(27),
RQPMT_100339_.tb4_3(27),
RQPMT_100339_.tb4_4(27),
null,
null,
null,
null,
RQPMT_100339_.tb4_9(27),
14,
'Identificador Parseo Direccion'
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
'PARSER_ADDRESS_ID'
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
'PARSER_ADDRESS_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb6_0(0):=10158;
RQPMT_100339_.tb6_1(0):=RQPMT_100339_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_EVENTS fila (0)',1);
UPDATE PS_PROD_MOTI_EVENTS SET PROD_MOTI_EVENTS_ID=RQPMT_100339_.tb6_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100339_.tb6_1(0),
EVENT_ID=1
 WHERE PROD_MOTI_EVENTS_ID = RQPMT_100339_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_EVENTS(PROD_MOTI_EVENTS_ID,PRODUCT_MOTIVE_ID,EVENT_ID) 
VALUES (RQPMT_100339_.tb6_0(0),
RQPMT_100339_.tb6_1(0),
1);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb2_0(1):=65;
RQPMT_100339_.tb2_1(1):=RQPMT_100339_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100339_.tb2_0(1),
MODULE_ID=RQPMT_100339_.tb2_1(1),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100339_.tb2_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100339_.tb2_0(1),
RQPMT_100339_.tb2_1(1),
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
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.old_tb3_0(3):=121269268;
RQPMT_100339_.tb3_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100339_.tb3_0(3):=RQPMT_100339_.tb3_0(3);
RQPMT_100339_.old_tb3_1(3):='MO_EVE_COMP_CT65E121269268'
;
RQPMT_100339_.tb3_1(3):=RQPMT_100339_.tb3_0(3);
RQPMT_100339_.tb3_2(3):=RQPMT_100339_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100339_.tb3_0(3),
RQPMT_100339_.tb3_1(3),
RQPMT_100339_.tb3_2(3),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_ADDRESS","PARSER_ADDRESS_ID",sbDireccion);CF_BOREGISTERRULESCRM.LOADADDRESS(sbInstancia,sbDireccion);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_MOTIVE","ANSWER_ID",sbIdRespuesta);if (UT_CONVERT.FBLISSTRINGNULL(sbIdRespuesta) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETFATHERINSTANCE(sbInstancia,sbInstPadre);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_MOTIVE","PRODUCT_TYPE_ID",idTipoProducto);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_MOTIVE","MOTIVE_ID",IdMotive);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstPadre,null,"MO_PACKAGES","PACKAGE_TYPE_ID",idTipoPaquete);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_MOTIVE","CAUSAL_ID",idCausal);PS_BOPACKAGE_ACTIVITIES.GETACTIVITYBYFORMDATA(idCausal,idTipoPaquete,idTipoProducto,onuItemId);nuIdMoDataOrd = PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL(' ||
'"SEQ_MO_DATA_FOR_ORDER");GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia,null,"MO_DATA_FOR_ORDER","DATA_FOR_ORDER_ID",nuIdMoDataOrd,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia,null,"MO_DATA_FOR_ORDER","MOTIVE_ID",IdMotive,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia,null,"MO_DATA_FOR_ORDER","ITEM_ID",onuItemId,GE_BOCONSTANTS.GETTRUE());,)'
,
'OPEN'
,
to_date('26-08-2017 15:13:23','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 15:51:53','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 15:51:53','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'post_proceso'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb7_0(0):=10180;
RQPMT_100339_.tb7_1(0):=RQPMT_100339_.tb6_0(0);
RQPMT_100339_.tb7_2(0):=RQPMT_100339_.tb3_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (0)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100339_.tb7_0(0),
PROD_MOTI_EVENTS_ID=RQPMT_100339_.tb7_1(0),
CONFIG_EXPRESSION_ID=RQPMT_100339_.tb7_2(0),
EXECUTING_TIME='AF'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100339_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100339_.tb7_0(0),
RQPMT_100339_.tb7_1(0),
RQPMT_100339_.tb7_2(0),
'AF'
,
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.old_tb3_0(4):=121269266;
RQPMT_100339_.tb3_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100339_.tb3_0(4):=RQPMT_100339_.tb3_0(4);
RQPMT_100339_.old_tb3_1(4):='MO_EVE_COMP_CT65E121269266'
;
RQPMT_100339_.tb3_1(4):=RQPMT_100339_.tb3_0(4);
RQPMT_100339_.tb3_2(4):=RQPMT_100339_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100339_.tb3_0(4),
RQPMT_100339_.tb3_1(4),
RQPMT_100339_.tb3_2(4),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_MOTIVE","ANSWER_ID",sbIdRespuesta);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"PR_TIMEOUT_COMPONENT","INITIAL_DATE",sbFechaInicial);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"PR_TIMEOUT_COMPONENT","FINAL_DATE",sbFechaFinal);dtFechaInicial = UT_CONVERT.FNUCHARTODATE(sbFechaInicial);dtFechaFinal = UT_CONVERT.FNUCHARTODATE(sbFechaFinal);dtFechaSistema = UT_DATE.FDTSYSDATE();if (UT_CONVERT.FBLISSTRINGNULL(sbIdRespuesta) = GE_BOCONSTANTS.GETFALSE(),sbFlagRequiereTiempos = CC_BOPRODUCTDAMAGE.FSBISREQUIREDTIMEOUT(UT_CONVERT.FNUCHARTONUMBER(sbIdRespuesta));if (sbFlagRequiereTiempos = GE_BOCONSTANTS.GETYES(),if (UT_CONVERT.FBLISSTRINGNULL(sbFechaInicial) = GE_BOCONSTANTS.GETTRUE() || UT_CONVERT.FBLISSTRINGNULL(sbFechaFinal) = GE_BOCONSTANTS.GETTRUE(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La respuesta ingresada requiere el registro de los tiempos f' ||
'uera del servicio. ");,);,);,);if (UT_CONVERT.FBLISSTRINGNULL(sbFechaInicial) = GE_BOCONSTANTS.GETFALSE() '||chr(38)||''||chr(38)||' UT_CONVERT.FBLISSTRINGNULL(sbFechaFinal) = GE_BOCONSTANTS.GETFALSE(),if (dtFechaFinal <= dtFechaInicial,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha final de afectación no puede ser menor a la fecha inicial de afectación.");,);,);if (UT_CONVERT.FBLISSTRINGNULL(sbFechaInicial) = GE_BOCONSTANTS.GETFALSE() || UT_CONVERT.FBLISSTRINGNULL(sbFechaFinal) = GE_BOCONSTANTS.GETFALSE(),if (dtFechaInicial > dtFechaSistema || dtFechaFinal > dtFechaSistema,GI_BOERRORS.SETERRORCODE(3852);,);,);if (UT_CONVERT.FBLISSTRINGNULL(sbFechaFinal) = GE_BOCONSTANTS.GETFALSE() '||chr(38)||''||chr(38)||' UT_CONVERT.FBLISSTRINGNULL(sbFechaInicial) = GE_BOCONSTANTS.GETTRUE(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No es posible ingresar fecha final de afectación sin ingresar la fecha inicial de afectación. ");,);if (UT_CONVERT.FBLISSTRINGNULL(sbFechaInicial) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.DESTROYENTITY(sbInstancia' ||
',null,"PR_TIMEOUT_COMPONENT");,)'
,
'OPEN'
,
to_date('26-08-2017 12:11:01','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
to_date('26-08-2017 14:42:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'pre_validacion'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;

RQPMT_100339_.tb7_0(1):=10178;
RQPMT_100339_.tb7_1(1):=RQPMT_100339_.tb6_0(0);
RQPMT_100339_.tb7_2(1):=RQPMT_100339_.tb3_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (1)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100339_.tb7_0(1),
PROD_MOTI_EVENTS_ID=RQPMT_100339_.tb7_1(1),
CONFIG_EXPRESSION_ID=RQPMT_100339_.tb7_2(1),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100339_.tb7_0(1);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100339_.tb7_0(1),
RQPMT_100339_.tb7_1(1),
RQPMT_100339_.tb7_2(1),
'B'
,
'Y'
);
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
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

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100339, sbSuccess);
FOR rc in RQPMT_100339_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
nuIndex := RQPMT_100339_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100339_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100339_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100339_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100339_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100339_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100339_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100339_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100339_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100339_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100339_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100339_.blProcessStatus := false;
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
 nuIndex := RQPMT_100339_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100339_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100339_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100339_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100339_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100339_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100339_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100339_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100339_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100339_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100339_',
'CREATE OR REPLACE PACKAGE RQCFG_100339_ IS ' || chr(10) ||
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
'AND     external_root_id = 100339 ' || chr(10) ||
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
'END RQCFG_100339_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100339_******************************'); END;
/

BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100339_.cuCompositions;
fetch RQCFG_100339_.cuCompositions bulk collect INTO RQCFG_100339_.tbCompositions;
close RQCFG_100339_.cuCompositions;

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100339_.tbEntityName(-1) := 'NULL';
   RQCFG_100339_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100339_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100339_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100339_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100339_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(260) := 'MO_PACKAGES@USER_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(261) := 'MO_PACKAGES@TERMINAL_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(515) := 'MO_PROCESS@SEPARATOR_GUI_2';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(1957) := 'PR_TIMEOUT_COMPONENT@TIMEOUT_COMPONENT_ID';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(1959) := 'PR_TIMEOUT_COMPONENT@INITIAL_DATE';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(1960) := 'PR_TIMEOUT_COMPONENT@FINAL_DATE';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(2508) := 'MO_PROCESS@DUMMY';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(39259) := 'MO_PROCESS@VALUE_7';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(39298) := 'MO_PROCESS@VALUE_8';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(40909) := 'MO_PACKAGES@ORGANIZAT_AREA_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(97550) := 'PR_TIMEOUT_COMPONENT@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100339_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQCFG_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100339_.tbEntityAttributeName(138162) := 'GI_ATTRIBS@ATTRIB02';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(182398) := 'MO_PACKAGES@MANAGEMENT_AREA_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(1959) := 'PR_TIMEOUT_COMPONENT@INITIAL_DATE';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100339_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(260) := 'MO_PACKAGES@USER_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(515) := 'MO_PROCESS@SEPARATOR_GUI_2';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(39259) := 'MO_PROCESS@VALUE_7';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(97550) := 'PR_TIMEOUT_COMPONENT@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(261) := 'MO_PACKAGES@TERMINAL_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(40909) := 'MO_PACKAGES@ORGANIZAT_AREA_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(2508) := 'MO_PROCESS@DUMMY';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(1957) := 'PR_TIMEOUT_COMPONENT@TIMEOUT_COMPONENT_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(182398) := 'MO_PACKAGES@MANAGEMENT_AREA_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(39298) := 'MO_PROCESS@VALUE_8';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100339_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100339_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100339_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100339_.tbEntityAttributeName(138162) := 'GI_ATTRIBS@ATTRIB02';
   RQCFG_100339_.tbEntityName(205) := 'PR_TIMEOUT_COMPONENT';
   RQCFG_100339_.tbEntityAttributeName(1960) := 'PR_TIMEOUT_COMPONENT@FINAL_DATE';
   RQCFG_100339_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100339_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_100339_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100339_.tbEntityAttributeName(189644) := 'MO_PROCESS@CAUSAL_ID';
   RQCFG_100339_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100339_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
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
AND     external_root_id = 100339
)
);
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100339_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100339, 4);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100339_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100339_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100339_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100339_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100339_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339))));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339)));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100339, 4);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100339_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339))));
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339))));
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339))));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339)));

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100339_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100339_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100339_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100339_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100339_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100339_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100339;

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb0_0(0):=8481;
RQCFG_100339_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100339_.tb0_0(0):=RQCFG_100339_.tb0_0(0);
RQCFG_100339_.old_tb0_2(0):=2012;
RQCFG_100339_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100339_.tb0_0(0),
100339,
RQCFG_100339_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb1_0(0):=1052885;
RQCFG_100339_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100339_.tb1_0(0):=RQCFG_100339_.tb1_0(0);
RQCFG_100339_.old_tb1_1(0):=100339;
RQCFG_100339_.tb1_1(0):=RQCFG_100339_.old_tb1_1(0);
RQCFG_100339_.old_tb1_2(0):=2012;
RQCFG_100339_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb1_2(0),-1)));
RQCFG_100339_.old_tb1_3(0):=8481;
RQCFG_100339_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb1_2(0),-1))), RQCFG_100339_.old_tb1_1(0), 4);
RQCFG_100339_.tb1_3(0):=RQCFG_100339_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100339_.tb1_0(0),
RQCFG_100339_.tb1_1(0),
RQCFG_100339_.tb1_2(0),
RQCFG_100339_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb2_0(0):=100025552;
RQCFG_100339_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100339_.tb2_0(0):=RQCFG_100339_.tb2_0(0);
RQCFG_100339_.tb2_1(0):=RQCFG_100339_.tb0_0(0);
RQCFG_100339_.tb2_2(0):=RQCFG_100339_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100339_.tb2_0(0),
RQCFG_100339_.tb2_1(0),
RQCFG_100339_.tb2_2(0),
null,
7053,
1,
1,
1);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb1_0(1):=1052886;
RQCFG_100339_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100339_.tb1_0(1):=RQCFG_100339_.tb1_0(1);
RQCFG_100339_.old_tb1_1(1):=100325;
RQCFG_100339_.tb1_1(1):=RQCFG_100339_.old_tb1_1(1);
RQCFG_100339_.old_tb1_2(1):=2013;
RQCFG_100339_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb1_2(1),-1)));
RQCFG_100339_.old_tb1_3(1):=null;
RQCFG_100339_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb1_2(1),-1))), RQCFG_100339_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100339_.tb1_0(1),
RQCFG_100339_.tb1_1(1),
RQCFG_100339_.tb1_2(1),
RQCFG_100339_.tb1_3(1),
null,
'M_DANO_A_PRODUCTO_100325'
,
1,
1,
4);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb2_0(1):=100025553;
RQCFG_100339_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100339_.tb2_0(1):=RQCFG_100339_.tb2_0(1);
RQCFG_100339_.tb2_1(1):=RQCFG_100339_.tb0_0(0);
RQCFG_100339_.tb2_2(1):=RQCFG_100339_.tb1_0(1);
RQCFG_100339_.tb2_3(1):=RQCFG_100339_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100339_.tb2_0(1),
RQCFG_100339_.tb2_1(1),
RQCFG_100339_.tb2_2(1),
RQCFG_100339_.tb2_3(1),
7053,
2,
1,
1);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(0):=1128284;
RQCFG_100339_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(0):=RQCFG_100339_.tb3_0(0);
RQCFG_100339_.old_tb3_1(0):=3334;
RQCFG_100339_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(0),-1)));
RQCFG_100339_.old_tb3_2(0):=11376;
RQCFG_100339_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(0),-1)));
RQCFG_100339_.old_tb3_3(0):=null;
RQCFG_100339_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(0),-1)));
RQCFG_100339_.old_tb3_4(0):=null;
RQCFG_100339_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(0),-1)));
RQCFG_100339_.tb3_5(0):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(0):=null;
RQCFG_100339_.tb3_6(0):=NULL;
RQCFG_100339_.old_tb3_7(0):=null;
RQCFG_100339_.tb3_7(0):=NULL;
RQCFG_100339_.old_tb3_8(0):=null;
RQCFG_100339_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(0),
RQCFG_100339_.tb3_1(0),
RQCFG_100339_.tb3_2(0),
RQCFG_100339_.tb3_3(0),
RQCFG_100339_.tb3_4(0),
RQCFG_100339_.tb3_5(0),
RQCFG_100339_.tb3_6(0),
RQCFG_100339_.tb3_7(0),
RQCFG_100339_.tb3_8(0),
null,
105216,
14,
'Identificador Parseo Direccion'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb4_0(0):=692;
RQCFG_100339_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100339_.tb4_0(0):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb4_1(0):=RQCFG_100339_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100339_.tb4_0(0),
RQCFG_100339_.tb4_1(0),
null,
null,
'FRAME-M_DANO_A_PRODUCTO_100325-1052886'
,
2);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(0):=1440631;
RQCFG_100339_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(0):=RQCFG_100339_.tb5_0(0);
RQCFG_100339_.old_tb5_1(0):=11376;
RQCFG_100339_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(0),-1)));
RQCFG_100339_.old_tb5_2(0):=null;
RQCFG_100339_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(0),-1)));
RQCFG_100339_.tb5_3(0):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(0):=RQCFG_100339_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(0),
RQCFG_100339_.tb5_1(0),
RQCFG_100339_.tb5_2(0),
RQCFG_100339_.tb5_3(0),
RQCFG_100339_.tb5_4(0),
'C'
,
'Y'
,
14,
'N'
,
'Identificador Parseo Direccion'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(1):=1128230;
RQCFG_100339_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(1):=RQCFG_100339_.tb3_0(1);
RQCFG_100339_.old_tb3_1(1):=3334;
RQCFG_100339_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(1),-1)));
RQCFG_100339_.old_tb3_2(1):=187;
RQCFG_100339_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(1),-1)));
RQCFG_100339_.old_tb3_3(1):=null;
RQCFG_100339_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(1),-1)));
RQCFG_100339_.old_tb3_4(1):=null;
RQCFG_100339_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(1),-1)));
RQCFG_100339_.tb3_5(1):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(1):=121269263;
RQCFG_100339_.tb3_6(1):=NULL;
RQCFG_100339_.old_tb3_7(1):=null;
RQCFG_100339_.tb3_7(1):=NULL;
RQCFG_100339_.old_tb3_8(1):=null;
RQCFG_100339_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(1),
RQCFG_100339_.tb3_1(1),
RQCFG_100339_.tb3_2(1),
RQCFG_100339_.tb3_3(1),
RQCFG_100339_.tb3_4(1),
RQCFG_100339_.tb3_5(1),
RQCFG_100339_.tb3_6(1),
RQCFG_100339_.tb3_7(1),
RQCFG_100339_.tb3_8(1),
null,
105188,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(1):=1440577;
RQCFG_100339_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(1):=RQCFG_100339_.tb5_0(1);
RQCFG_100339_.old_tb5_1(1):=187;
RQCFG_100339_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(1),-1)));
RQCFG_100339_.old_tb5_2(1):=null;
RQCFG_100339_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(1),-1)));
RQCFG_100339_.tb5_3(1):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(1):=RQCFG_100339_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(1),
RQCFG_100339_.tb5_1(1),
RQCFG_100339_.tb5_2(1),
RQCFG_100339_.tb5_3(1),
RQCFG_100339_.tb5_4(1),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(2):=1128231;
RQCFG_100339_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(2):=RQCFG_100339_.tb3_0(2);
RQCFG_100339_.old_tb3_1(2):=3334;
RQCFG_100339_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(2),-1)));
RQCFG_100339_.old_tb3_2(2):=213;
RQCFG_100339_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(2),-1)));
RQCFG_100339_.old_tb3_3(2):=255;
RQCFG_100339_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(2),-1)));
RQCFG_100339_.old_tb3_4(2):=null;
RQCFG_100339_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(2),-1)));
RQCFG_100339_.tb3_5(2):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(2):=null;
RQCFG_100339_.tb3_6(2):=NULL;
RQCFG_100339_.old_tb3_7(2):=null;
RQCFG_100339_.tb3_7(2):=NULL;
RQCFG_100339_.old_tb3_8(2):=null;
RQCFG_100339_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(2),
RQCFG_100339_.tb3_1(2),
RQCFG_100339_.tb3_2(2),
RQCFG_100339_.tb3_3(2),
RQCFG_100339_.tb3_4(2),
RQCFG_100339_.tb3_5(2),
RQCFG_100339_.tb3_6(2),
RQCFG_100339_.tb3_7(2),
RQCFG_100339_.tb3_8(2),
null,
105189,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(2):=1440578;
RQCFG_100339_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(2):=RQCFG_100339_.tb5_0(2);
RQCFG_100339_.old_tb5_1(2):=213;
RQCFG_100339_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(2),-1)));
RQCFG_100339_.old_tb5_2(2):=null;
RQCFG_100339_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(2),-1)));
RQCFG_100339_.tb5_3(2):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(2):=RQCFG_100339_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(2),
RQCFG_100339_.tb5_1(2),
RQCFG_100339_.tb5_2(2),
RQCFG_100339_.tb5_3(2),
RQCFG_100339_.tb5_4(2),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(3):=1128232;
RQCFG_100339_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(3):=RQCFG_100339_.tb3_0(3);
RQCFG_100339_.old_tb3_1(3):=3334;
RQCFG_100339_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(3),-1)));
RQCFG_100339_.old_tb3_2(3):=2641;
RQCFG_100339_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(3),-1)));
RQCFG_100339_.old_tb3_3(3):=null;
RQCFG_100339_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(3),-1)));
RQCFG_100339_.old_tb3_4(3):=null;
RQCFG_100339_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(3),-1)));
RQCFG_100339_.tb3_5(3):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(3):=null;
RQCFG_100339_.tb3_6(3):=NULL;
RQCFG_100339_.old_tb3_7(3):=null;
RQCFG_100339_.tb3_7(3):=NULL;
RQCFG_100339_.old_tb3_8(3):=null;
RQCFG_100339_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(3),
RQCFG_100339_.tb3_1(3),
RQCFG_100339_.tb3_2(3),
RQCFG_100339_.tb3_3(3),
RQCFG_100339_.tb3_4(3),
RQCFG_100339_.tb3_5(3),
RQCFG_100339_.tb3_6(3),
RQCFG_100339_.tb3_7(3),
RQCFG_100339_.tb3_8(3),
null,
105190,
2,
'Límite de Crédito'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(3):=1440579;
RQCFG_100339_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(3):=RQCFG_100339_.tb5_0(3);
RQCFG_100339_.old_tb5_1(3):=2641;
RQCFG_100339_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(3),-1)));
RQCFG_100339_.old_tb5_2(3):=null;
RQCFG_100339_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(3),-1)));
RQCFG_100339_.tb5_3(3):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(3):=RQCFG_100339_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(3),
RQCFG_100339_.tb5_1(3),
RQCFG_100339_.tb5_2(3),
RQCFG_100339_.tb5_3(3),
RQCFG_100339_.tb5_4(3),
'C'
,
'Y'
,
2,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(4):=1128233;
RQCFG_100339_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(4):=RQCFG_100339_.tb3_0(4);
RQCFG_100339_.old_tb3_1(4):=3334;
RQCFG_100339_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(4),-1)));
RQCFG_100339_.old_tb3_2(4):=189;
RQCFG_100339_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(4),-1)));
RQCFG_100339_.old_tb3_3(4):=257;
RQCFG_100339_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(4),-1)));
RQCFG_100339_.old_tb3_4(4):=null;
RQCFG_100339_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(4),-1)));
RQCFG_100339_.tb3_5(4):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(4):=null;
RQCFG_100339_.tb3_6(4):=NULL;
RQCFG_100339_.old_tb3_7(4):=null;
RQCFG_100339_.tb3_7(4):=NULL;
RQCFG_100339_.old_tb3_8(4):=null;
RQCFG_100339_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(4),
RQCFG_100339_.tb3_1(4),
RQCFG_100339_.tb3_2(4),
RQCFG_100339_.tb3_3(4),
RQCFG_100339_.tb3_4(4),
RQCFG_100339_.tb3_5(4),
RQCFG_100339_.tb3_6(4),
RQCFG_100339_.tb3_7(4),
RQCFG_100339_.tb3_8(4),
null,
105191,
3,
'Número Petición Atención al cliente'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(4):=1440580;
RQCFG_100339_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(4):=RQCFG_100339_.tb5_0(4);
RQCFG_100339_.old_tb5_1(4):=189;
RQCFG_100339_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(4),-1)));
RQCFG_100339_.old_tb5_2(4):=null;
RQCFG_100339_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(4),-1)));
RQCFG_100339_.tb5_3(4):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(4):=RQCFG_100339_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(4),
RQCFG_100339_.tb5_1(4),
RQCFG_100339_.tb5_2(4),
RQCFG_100339_.tb5_3(4),
RQCFG_100339_.tb5_4(4),
'C'
,
'Y'
,
3,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(5):=1128234;
RQCFG_100339_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(5):=RQCFG_100339_.tb3_0(5);
RQCFG_100339_.old_tb3_1(5):=3334;
RQCFG_100339_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(5),-1)));
RQCFG_100339_.old_tb3_2(5):=50001324;
RQCFG_100339_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(5),-1)));
RQCFG_100339_.old_tb3_3(5):=null;
RQCFG_100339_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(5),-1)));
RQCFG_100339_.old_tb3_4(5):=null;
RQCFG_100339_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(5),-1)));
RQCFG_100339_.tb3_5(5):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(5):=null;
RQCFG_100339_.tb3_6(5):=NULL;
RQCFG_100339_.old_tb3_7(5):=null;
RQCFG_100339_.tb3_7(5):=NULL;
RQCFG_100339_.old_tb3_8(5):=null;
RQCFG_100339_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(5),
RQCFG_100339_.tb3_1(5),
RQCFG_100339_.tb3_2(5),
RQCFG_100339_.tb3_3(5),
RQCFG_100339_.tb3_4(5),
RQCFG_100339_.tb3_5(5),
RQCFG_100339_.tb3_6(5),
RQCFG_100339_.tb3_7(5),
RQCFG_100339_.tb3_8(5),
null,
105192,
4,
'Ubicación Geográfica'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(5):=1440581;
RQCFG_100339_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(5):=RQCFG_100339_.tb5_0(5);
RQCFG_100339_.old_tb5_1(5):=50001324;
RQCFG_100339_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(5),-1)));
RQCFG_100339_.old_tb5_2(5):=null;
RQCFG_100339_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(5),-1)));
RQCFG_100339_.tb5_3(5):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(5):=RQCFG_100339_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(5),
RQCFG_100339_.tb5_1(5),
RQCFG_100339_.tb5_2(5),
RQCFG_100339_.tb5_3(5),
RQCFG_100339_.tb5_4(5),
'C'
,
'Y'
,
4,
'N'
,
'Ubicación Geográfica'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(6):=1128235;
RQCFG_100339_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(6):=RQCFG_100339_.tb3_0(6);
RQCFG_100339_.old_tb3_1(6):=3334;
RQCFG_100339_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(6),-1)));
RQCFG_100339_.old_tb3_2(6):=201;
RQCFG_100339_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(6),-1)));
RQCFG_100339_.old_tb3_3(6):=null;
RQCFG_100339_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(6),-1)));
RQCFG_100339_.old_tb3_4(6):=null;
RQCFG_100339_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(6),-1)));
RQCFG_100339_.tb3_5(6):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(6):=null;
RQCFG_100339_.tb3_6(6):=NULL;
RQCFG_100339_.old_tb3_7(6):=null;
RQCFG_100339_.tb3_7(6):=NULL;
RQCFG_100339_.old_tb3_8(6):=null;
RQCFG_100339_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(6),
RQCFG_100339_.tb3_1(6),
RQCFG_100339_.tb3_2(6),
RQCFG_100339_.tb3_3(6),
RQCFG_100339_.tb3_4(6),
RQCFG_100339_.tb3_5(6),
RQCFG_100339_.tb3_6(6),
RQCFG_100339_.tb3_7(6),
RQCFG_100339_.tb3_8(6),
null,
105193,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(6):=1440582;
RQCFG_100339_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(6):=RQCFG_100339_.tb5_0(6);
RQCFG_100339_.old_tb5_1(6):=201;
RQCFG_100339_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(6),-1)));
RQCFG_100339_.old_tb5_2(6):=null;
RQCFG_100339_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(6),-1)));
RQCFG_100339_.tb5_3(6):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(6):=RQCFG_100339_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(6),
RQCFG_100339_.tb5_1(6),
RQCFG_100339_.tb5_2(6),
RQCFG_100339_.tb5_3(6),
RQCFG_100339_.tb5_4(6),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(7):=1128236;
RQCFG_100339_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(7):=RQCFG_100339_.tb3_0(7);
RQCFG_100339_.old_tb3_1(7):=3334;
RQCFG_100339_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(7),-1)));
RQCFG_100339_.old_tb3_2(7):=202;
RQCFG_100339_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(7),-1)));
RQCFG_100339_.old_tb3_3(7):=null;
RQCFG_100339_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(7),-1)));
RQCFG_100339_.old_tb3_4(7):=null;
RQCFG_100339_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(7),-1)));
RQCFG_100339_.tb3_5(7):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(7):=null;
RQCFG_100339_.tb3_6(7):=NULL;
RQCFG_100339_.old_tb3_7(7):=null;
RQCFG_100339_.tb3_7(7):=NULL;
RQCFG_100339_.old_tb3_8(7):=null;
RQCFG_100339_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(7),
RQCFG_100339_.tb3_1(7),
RQCFG_100339_.tb3_2(7),
RQCFG_100339_.tb3_3(7),
RQCFG_100339_.tb3_4(7),
RQCFG_100339_.tb3_5(7),
RQCFG_100339_.tb3_6(7),
RQCFG_100339_.tb3_7(7),
RQCFG_100339_.tb3_8(7),
null,
105194,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(7):=1440583;
RQCFG_100339_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(7):=RQCFG_100339_.tb5_0(7);
RQCFG_100339_.old_tb5_1(7):=202;
RQCFG_100339_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(7),-1)));
RQCFG_100339_.old_tb5_2(7):=null;
RQCFG_100339_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(7),-1)));
RQCFG_100339_.tb5_3(7):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(7):=RQCFG_100339_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(7),
RQCFG_100339_.tb5_1(7),
RQCFG_100339_.tb5_2(7),
RQCFG_100339_.tb5_3(7),
RQCFG_100339_.tb5_4(7),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(8):=1128237;
RQCFG_100339_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(8):=RQCFG_100339_.tb3_0(8);
RQCFG_100339_.old_tb3_1(8):=3334;
RQCFG_100339_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(8),-1)));
RQCFG_100339_.old_tb3_2(8):=498;
RQCFG_100339_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(8),-1)));
RQCFG_100339_.old_tb3_3(8):=null;
RQCFG_100339_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(8),-1)));
RQCFG_100339_.old_tb3_4(8):=null;
RQCFG_100339_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(8),-1)));
RQCFG_100339_.tb3_5(8):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(8):=null;
RQCFG_100339_.tb3_6(8):=NULL;
RQCFG_100339_.old_tb3_7(8):=null;
RQCFG_100339_.tb3_7(8):=NULL;
RQCFG_100339_.old_tb3_8(8):=null;
RQCFG_100339_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(8),
RQCFG_100339_.tb3_1(8),
RQCFG_100339_.tb3_2(8),
RQCFG_100339_.tb3_3(8),
RQCFG_100339_.tb3_4(8),
RQCFG_100339_.tb3_5(8),
RQCFG_100339_.tb3_6(8),
RQCFG_100339_.tb3_7(8),
RQCFG_100339_.tb3_8(8),
null,
105195,
7,
'Fecha de Atención'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(8):=1440584;
RQCFG_100339_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(8):=RQCFG_100339_.tb5_0(8);
RQCFG_100339_.old_tb5_1(8):=498;
RQCFG_100339_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(8),-1)));
RQCFG_100339_.old_tb5_2(8):=null;
RQCFG_100339_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(8),-1)));
RQCFG_100339_.tb5_3(8):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(8):=RQCFG_100339_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(8),
RQCFG_100339_.tb5_1(8),
RQCFG_100339_.tb5_2(8),
RQCFG_100339_.tb5_3(8),
RQCFG_100339_.tb5_4(8),
'C'
,
'Y'
,
7,
'Y'
,
'Fecha de Atención'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(9):=1128238;
RQCFG_100339_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(9):=RQCFG_100339_.tb3_0(9);
RQCFG_100339_.old_tb3_1(9):=3334;
RQCFG_100339_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(9),-1)));
RQCFG_100339_.old_tb3_2(9):=220;
RQCFG_100339_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(9),-1)));
RQCFG_100339_.old_tb3_3(9):=null;
RQCFG_100339_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(9),-1)));
RQCFG_100339_.old_tb3_4(9):=null;
RQCFG_100339_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(9),-1)));
RQCFG_100339_.tb3_5(9):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(9):=null;
RQCFG_100339_.tb3_6(9):=NULL;
RQCFG_100339_.old_tb3_7(9):=null;
RQCFG_100339_.tb3_7(9):=NULL;
RQCFG_100339_.old_tb3_8(9):=null;
RQCFG_100339_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(9),
RQCFG_100339_.tb3_1(9),
RQCFG_100339_.tb3_2(9),
RQCFG_100339_.tb3_3(9),
RQCFG_100339_.tb3_4(9),
RQCFG_100339_.tb3_5(9),
RQCFG_100339_.tb3_6(9),
RQCFG_100339_.tb3_7(9),
RQCFG_100339_.tb3_8(9),
null,
105196,
8,
'Identificador de Distribución Administrativa'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(9):=1440585;
RQCFG_100339_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(9):=RQCFG_100339_.tb5_0(9);
RQCFG_100339_.old_tb5_1(9):=220;
RQCFG_100339_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(9),-1)));
RQCFG_100339_.old_tb5_2(9):=null;
RQCFG_100339_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(9),-1)));
RQCFG_100339_.tb5_3(9):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(9):=RQCFG_100339_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(9),
RQCFG_100339_.tb5_1(9),
RQCFG_100339_.tb5_2(9),
RQCFG_100339_.tb5_3(9),
RQCFG_100339_.tb5_4(9),
'C'
,
'Y'
,
8,
'Y'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(10):=1128239;
RQCFG_100339_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(10):=RQCFG_100339_.tb3_0(10);
RQCFG_100339_.old_tb3_1(10):=3334;
RQCFG_100339_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(10),-1)));
RQCFG_100339_.old_tb3_2(10):=524;
RQCFG_100339_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(10),-1)));
RQCFG_100339_.old_tb3_3(10):=null;
RQCFG_100339_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(10),-1)));
RQCFG_100339_.old_tb3_4(10):=null;
RQCFG_100339_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(10),-1)));
RQCFG_100339_.tb3_5(10):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(10):=null;
RQCFG_100339_.tb3_6(10):=NULL;
RQCFG_100339_.old_tb3_7(10):=null;
RQCFG_100339_.tb3_7(10):=NULL;
RQCFG_100339_.old_tb3_8(10):=null;
RQCFG_100339_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(10),
RQCFG_100339_.tb3_1(10),
RQCFG_100339_.tb3_2(10),
RQCFG_100339_.tb3_3(10),
RQCFG_100339_.tb3_4(10),
RQCFG_100339_.tb3_5(10),
RQCFG_100339_.tb3_6(10),
RQCFG_100339_.tb3_7(10),
RQCFG_100339_.tb3_8(10),
null,
105197,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(10):=1440586;
RQCFG_100339_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(10):=RQCFG_100339_.tb5_0(10);
RQCFG_100339_.old_tb5_1(10):=524;
RQCFG_100339_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(10),-1)));
RQCFG_100339_.old_tb5_2(10):=null;
RQCFG_100339_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(10),-1)));
RQCFG_100339_.tb5_3(10):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(10):=RQCFG_100339_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(10),
RQCFG_100339_.tb5_1(10),
RQCFG_100339_.tb5_2(10),
RQCFG_100339_.tb5_3(10),
RQCFG_100339_.tb5_4(10),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(11):=1128240;
RQCFG_100339_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(11):=RQCFG_100339_.tb3_0(11);
RQCFG_100339_.old_tb3_1(11):=3334;
RQCFG_100339_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(11),-1)));
RQCFG_100339_.old_tb3_2(11):=191;
RQCFG_100339_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(11),-1)));
RQCFG_100339_.old_tb3_3(11):=null;
RQCFG_100339_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(11),-1)));
RQCFG_100339_.old_tb3_4(11):=null;
RQCFG_100339_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(11),-1)));
RQCFG_100339_.tb3_5(11):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(11):=null;
RQCFG_100339_.tb3_6(11):=NULL;
RQCFG_100339_.old_tb3_7(11):=null;
RQCFG_100339_.tb3_7(11):=NULL;
RQCFG_100339_.old_tb3_8(11):=null;
RQCFG_100339_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(11),
RQCFG_100339_.tb3_1(11),
RQCFG_100339_.tb3_2(11),
RQCFG_100339_.tb3_3(11),
RQCFG_100339_.tb3_4(11),
RQCFG_100339_.tb3_5(11),
RQCFG_100339_.tb3_6(11),
RQCFG_100339_.tb3_7(11),
RQCFG_100339_.tb3_8(11),
null,
105198,
10,
'Identificador del Tipo de Motivo'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(11):=1440587;
RQCFG_100339_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(11):=RQCFG_100339_.tb5_0(11);
RQCFG_100339_.old_tb5_1(11):=191;
RQCFG_100339_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(11),-1)));
RQCFG_100339_.old_tb5_2(11):=null;
RQCFG_100339_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(11),-1)));
RQCFG_100339_.tb5_3(11):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(11):=RQCFG_100339_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(11),
RQCFG_100339_.tb5_1(11),
RQCFG_100339_.tb5_2(11),
RQCFG_100339_.tb5_3(11),
RQCFG_100339_.tb5_4(11),
'C'
,
'Y'
,
10,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(12):=1128241;
RQCFG_100339_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(12):=RQCFG_100339_.tb3_0(12);
RQCFG_100339_.old_tb3_1(12):=3334;
RQCFG_100339_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(12),-1)));
RQCFG_100339_.old_tb3_2(12):=192;
RQCFG_100339_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(12),-1)));
RQCFG_100339_.old_tb3_3(12):=null;
RQCFG_100339_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(12),-1)));
RQCFG_100339_.old_tb3_4(12):=null;
RQCFG_100339_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(12),-1)));
RQCFG_100339_.tb3_5(12):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(12):=null;
RQCFG_100339_.tb3_6(12):=NULL;
RQCFG_100339_.old_tb3_7(12):=null;
RQCFG_100339_.tb3_7(12):=NULL;
RQCFG_100339_.old_tb3_8(12):=null;
RQCFG_100339_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(12),
RQCFG_100339_.tb3_1(12),
RQCFG_100339_.tb3_2(12),
RQCFG_100339_.tb3_3(12),
RQCFG_100339_.tb3_4(12),
RQCFG_100339_.tb3_5(12),
RQCFG_100339_.tb3_6(12),
RQCFG_100339_.tb3_7(12),
RQCFG_100339_.tb3_8(12),
null,
105199,
11,
'Identificador del Tipo de Producto'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(12):=1440588;
RQCFG_100339_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(12):=RQCFG_100339_.tb5_0(12);
RQCFG_100339_.old_tb5_1(12):=192;
RQCFG_100339_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(12),-1)));
RQCFG_100339_.old_tb5_2(12):=null;
RQCFG_100339_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(12),-1)));
RQCFG_100339_.tb5_3(12):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(12):=RQCFG_100339_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(12),
RQCFG_100339_.tb5_1(12),
RQCFG_100339_.tb5_2(12),
RQCFG_100339_.tb5_3(12),
RQCFG_100339_.tb5_4(12),
'Y'
,
'Y'
,
11,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(13):=1128242;
RQCFG_100339_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(13):=RQCFG_100339_.tb3_0(13);
RQCFG_100339_.old_tb3_1(13):=3334;
RQCFG_100339_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(13),-1)));
RQCFG_100339_.old_tb3_2(13):=11403;
RQCFG_100339_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(13),-1)));
RQCFG_100339_.old_tb3_3(13):=null;
RQCFG_100339_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(13),-1)));
RQCFG_100339_.old_tb3_4(13):=null;
RQCFG_100339_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(13),-1)));
RQCFG_100339_.tb3_5(13):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(13):=null;
RQCFG_100339_.tb3_6(13):=NULL;
RQCFG_100339_.old_tb3_7(13):=null;
RQCFG_100339_.tb3_7(13):=NULL;
RQCFG_100339_.old_tb3_8(13):=null;
RQCFG_100339_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(13),
RQCFG_100339_.tb3_1(13),
RQCFG_100339_.tb3_2(13),
RQCFG_100339_.tb3_3(13),
RQCFG_100339_.tb3_4(13),
RQCFG_100339_.tb3_5(13),
RQCFG_100339_.tb3_6(13),
RQCFG_100339_.tb3_7(13),
RQCFG_100339_.tb3_8(13),
null,
105200,
12,
'Identificador de la Suscripción'
,
'N'
,
'Y'
,
'N'
,
12,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(13):=1440589;
RQCFG_100339_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(13):=RQCFG_100339_.tb5_0(13);
RQCFG_100339_.old_tb5_1(13):=11403;
RQCFG_100339_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(13),-1)));
RQCFG_100339_.old_tb5_2(13):=null;
RQCFG_100339_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(13),-1)));
RQCFG_100339_.tb5_3(13):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(13):=RQCFG_100339_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(13),
RQCFG_100339_.tb5_1(13),
RQCFG_100339_.tb5_2(13),
RQCFG_100339_.tb5_3(13),
RQCFG_100339_.tb5_4(13),
'Y'
,
'Y'
,
12,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(14):=1128243;
RQCFG_100339_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(14):=RQCFG_100339_.tb3_0(14);
RQCFG_100339_.old_tb3_1(14):=3334;
RQCFG_100339_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(14),-1)));
RQCFG_100339_.old_tb3_2(14):=6683;
RQCFG_100339_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(14),-1)));
RQCFG_100339_.old_tb3_3(14):=null;
RQCFG_100339_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(14),-1)));
RQCFG_100339_.old_tb3_4(14):=null;
RQCFG_100339_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(14),-1)));
RQCFG_100339_.tb3_5(14):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(14):=null;
RQCFG_100339_.tb3_6(14):=NULL;
RQCFG_100339_.old_tb3_7(14):=null;
RQCFG_100339_.tb3_7(14):=NULL;
RQCFG_100339_.old_tb3_8(14):=null;
RQCFG_100339_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(14),
RQCFG_100339_.tb3_1(14),
RQCFG_100339_.tb3_2(14),
RQCFG_100339_.tb3_3(14),
RQCFG_100339_.tb3_4(14),
RQCFG_100339_.tb3_5(14),
RQCFG_100339_.tb3_6(14),
RQCFG_100339_.tb3_7(14),
RQCFG_100339_.tb3_8(14),
null,
105201,
13,
'CLIENT_PRIVACY_FLAG'
,
'N'
,
'N'
,
'N'
,
13,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(14):=1440590;
RQCFG_100339_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(14):=RQCFG_100339_.tb5_0(14);
RQCFG_100339_.old_tb5_1(14):=6683;
RQCFG_100339_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(14),-1)));
RQCFG_100339_.old_tb5_2(14):=null;
RQCFG_100339_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(14),-1)));
RQCFG_100339_.tb5_3(14):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(14):=RQCFG_100339_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(14),
RQCFG_100339_.tb5_1(14),
RQCFG_100339_.tb5_2(14),
RQCFG_100339_.tb5_3(14),
RQCFG_100339_.tb5_4(14),
'N'
,
'N'
,
13,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(15):=1128244;
RQCFG_100339_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(15):=RQCFG_100339_.tb3_0(15);
RQCFG_100339_.old_tb3_1(15):=3334;
RQCFG_100339_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(15),-1)));
RQCFG_100339_.old_tb3_2(15):=138162;
RQCFG_100339_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(15),-1)));
RQCFG_100339_.old_tb3_3(15):=null;
RQCFG_100339_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(15),-1)));
RQCFG_100339_.old_tb3_4(15):=null;
RQCFG_100339_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(15),-1)));
RQCFG_100339_.tb3_5(15):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(15):=null;
RQCFG_100339_.tb3_6(15):=NULL;
RQCFG_100339_.old_tb3_7(15):=null;
RQCFG_100339_.tb3_7(15):=NULL;
RQCFG_100339_.old_tb3_8(15):=null;
RQCFG_100339_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(15),
RQCFG_100339_.tb3_1(15),
RQCFG_100339_.tb3_2(15),
RQCFG_100339_.tb3_3(15),
RQCFG_100339_.tb3_4(15),
RQCFG_100339_.tb3_5(15),
RQCFG_100339_.tb3_6(15),
RQCFG_100339_.tb3_7(15),
RQCFG_100339_.tb3_8(15),
null,
105202,
15,
'Tiempos Fuera de Servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(15):=1440591;
RQCFG_100339_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(15):=RQCFG_100339_.tb5_0(15);
RQCFG_100339_.old_tb5_1(15):=138162;
RQCFG_100339_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(15),-1)));
RQCFG_100339_.old_tb5_2(15):=null;
RQCFG_100339_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(15),-1)));
RQCFG_100339_.tb5_3(15):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(15):=RQCFG_100339_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(15),
RQCFG_100339_.tb5_1(15),
RQCFG_100339_.tb5_2(15),
RQCFG_100339_.tb5_3(15),
RQCFG_100339_.tb5_4(15),
'Y'
,
'Y'
,
15,
'N'
,
'Tiempos Fuera de Servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(16):=1128245;
RQCFG_100339_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(16):=RQCFG_100339_.tb3_0(16);
RQCFG_100339_.old_tb3_1(16):=3334;
RQCFG_100339_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(16),-1)));
RQCFG_100339_.old_tb3_2(16):=1959;
RQCFG_100339_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(16),-1)));
RQCFG_100339_.old_tb3_3(16):=null;
RQCFG_100339_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(16),-1)));
RQCFG_100339_.old_tb3_4(16):=null;
RQCFG_100339_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(16),-1)));
RQCFG_100339_.tb3_5(16):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(16):=null;
RQCFG_100339_.tb3_6(16):=NULL;
RQCFG_100339_.old_tb3_7(16):=null;
RQCFG_100339_.tb3_7(16):=NULL;
RQCFG_100339_.old_tb3_8(16):=null;
RQCFG_100339_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(16),
RQCFG_100339_.tb3_1(16),
RQCFG_100339_.tb3_2(16),
RQCFG_100339_.tb3_3(16),
RQCFG_100339_.tb3_4(16),
RQCFG_100339_.tb3_5(16),
RQCFG_100339_.tb3_6(16),
RQCFG_100339_.tb3_7(16),
RQCFG_100339_.tb3_8(16),
null,
105203,
16,
'Fecha Inicial de Afectación'
,
'N'
,
'Y'
,
'N'
,
16,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(16):=1440592;
RQCFG_100339_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(16):=RQCFG_100339_.tb5_0(16);
RQCFG_100339_.old_tb5_1(16):=1959;
RQCFG_100339_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(16),-1)));
RQCFG_100339_.old_tb5_2(16):=null;
RQCFG_100339_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(16),-1)));
RQCFG_100339_.tb5_3(16):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(16):=RQCFG_100339_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(16),
RQCFG_100339_.tb5_1(16),
RQCFG_100339_.tb5_2(16),
RQCFG_100339_.tb5_3(16),
RQCFG_100339_.tb5_4(16),
'Y'
,
'Y'
,
16,
'N'
,
'Fecha Inicial de Afectación'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(17):=1128246;
RQCFG_100339_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(17):=RQCFG_100339_.tb3_0(17);
RQCFG_100339_.old_tb3_1(17):=3334;
RQCFG_100339_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(17),-1)));
RQCFG_100339_.old_tb3_2(17):=1960;
RQCFG_100339_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(17),-1)));
RQCFG_100339_.old_tb3_3(17):=null;
RQCFG_100339_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(17),-1)));
RQCFG_100339_.old_tb3_4(17):=null;
RQCFG_100339_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(17),-1)));
RQCFG_100339_.tb3_5(17):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(17):=null;
RQCFG_100339_.tb3_6(17):=NULL;
RQCFG_100339_.old_tb3_7(17):=null;
RQCFG_100339_.tb3_7(17):=NULL;
RQCFG_100339_.old_tb3_8(17):=null;
RQCFG_100339_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(17),
RQCFG_100339_.tb3_1(17),
RQCFG_100339_.tb3_2(17),
RQCFG_100339_.tb3_3(17),
RQCFG_100339_.tb3_4(17),
RQCFG_100339_.tb3_5(17),
RQCFG_100339_.tb3_6(17),
RQCFG_100339_.tb3_7(17),
RQCFG_100339_.tb3_8(17),
null,
105204,
17,
'Fecha Final de Afectación'
,
'N'
,
'Y'
,
'N'
,
17,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(17):=1440593;
RQCFG_100339_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(17):=RQCFG_100339_.tb5_0(17);
RQCFG_100339_.old_tb5_1(17):=1960;
RQCFG_100339_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(17),-1)));
RQCFG_100339_.old_tb5_2(17):=null;
RQCFG_100339_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(17),-1)));
RQCFG_100339_.tb5_3(17):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(17):=RQCFG_100339_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(17),
RQCFG_100339_.tb5_1(17),
RQCFG_100339_.tb5_2(17),
RQCFG_100339_.tb5_3(17),
RQCFG_100339_.tb5_4(17),
'Y'
,
'Y'
,
17,
'N'
,
'Fecha Final de Afectación'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(18):=1128247;
RQCFG_100339_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(18):=RQCFG_100339_.tb3_0(18);
RQCFG_100339_.old_tb3_1(18):=3334;
RQCFG_100339_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(18),-1)));
RQCFG_100339_.old_tb3_2(18):=138161;
RQCFG_100339_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(18),-1)));
RQCFG_100339_.old_tb3_3(18):=null;
RQCFG_100339_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(18),-1)));
RQCFG_100339_.old_tb3_4(18):=null;
RQCFG_100339_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(18),-1)));
RQCFG_100339_.tb3_5(18):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(18):=null;
RQCFG_100339_.tb3_6(18):=NULL;
RQCFG_100339_.old_tb3_7(18):=null;
RQCFG_100339_.tb3_7(18):=NULL;
RQCFG_100339_.old_tb3_8(18):=null;
RQCFG_100339_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(18),
RQCFG_100339_.tb3_1(18),
RQCFG_100339_.tb3_2(18),
RQCFG_100339_.tb3_3(18),
RQCFG_100339_.tb3_4(18),
RQCFG_100339_.tb3_5(18),
RQCFG_100339_.tb3_6(18),
RQCFG_100339_.tb3_7(18),
RQCFG_100339_.tb3_8(18),
null,
105205,
18,
'Atención Inmediata'
,
'N'
,
'Y'
,
'N'
,
18,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(18):=1440594;
RQCFG_100339_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(18):=RQCFG_100339_.tb5_0(18);
RQCFG_100339_.old_tb5_1(18):=138161;
RQCFG_100339_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(18),-1)));
RQCFG_100339_.old_tb5_2(18):=null;
RQCFG_100339_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(18),-1)));
RQCFG_100339_.tb5_3(18):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(18):=RQCFG_100339_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(18),
RQCFG_100339_.tb5_1(18),
RQCFG_100339_.tb5_2(18),
RQCFG_100339_.tb5_3(18),
RQCFG_100339_.tb5_4(18),
'Y'
,
'Y'
,
18,
'N'
,
'Atención Inmediata'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(19):=1128248;
RQCFG_100339_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(19):=RQCFG_100339_.tb3_0(19);
RQCFG_100339_.old_tb3_1(19):=3334;
RQCFG_100339_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(19),-1)));
RQCFG_100339_.old_tb3_2(19):=1957;
RQCFG_100339_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(19),-1)));
RQCFG_100339_.old_tb3_3(19):=null;
RQCFG_100339_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(19),-1)));
RQCFG_100339_.old_tb3_4(19):=null;
RQCFG_100339_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(19),-1)));
RQCFG_100339_.tb3_5(19):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(19):=121269264;
RQCFG_100339_.tb3_6(19):=NULL;
RQCFG_100339_.old_tb3_7(19):=null;
RQCFG_100339_.tb3_7(19):=NULL;
RQCFG_100339_.old_tb3_8(19):=null;
RQCFG_100339_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(19),
RQCFG_100339_.tb3_1(19),
RQCFG_100339_.tb3_2(19),
RQCFG_100339_.tb3_3(19),
RQCFG_100339_.tb3_4(19),
RQCFG_100339_.tb3_5(19),
RQCFG_100339_.tb3_6(19),
RQCFG_100339_.tb3_7(19),
RQCFG_100339_.tb3_8(19),
null,
105206,
19,
'Consecutivo de Tiempos Fuera'
,
'N'
,
'C'
,
'Y'
,
19,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(19):=1440595;
RQCFG_100339_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(19):=RQCFG_100339_.tb5_0(19);
RQCFG_100339_.old_tb5_1(19):=1957;
RQCFG_100339_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(19),-1)));
RQCFG_100339_.old_tb5_2(19):=null;
RQCFG_100339_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(19),-1)));
RQCFG_100339_.tb5_3(19):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(19):=RQCFG_100339_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(19),
RQCFG_100339_.tb5_1(19),
RQCFG_100339_.tb5_2(19),
RQCFG_100339_.tb5_3(19),
RQCFG_100339_.tb5_4(19),
'C'
,
'Y'
,
19,
'Y'
,
'Consecutivo de Tiempos Fuera'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(20):=1128249;
RQCFG_100339_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(20):=RQCFG_100339_.tb3_0(20);
RQCFG_100339_.old_tb3_1(20):=3334;
RQCFG_100339_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(20),-1)));
RQCFG_100339_.old_tb3_2(20):=97550;
RQCFG_100339_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(20),-1)));
RQCFG_100339_.old_tb3_3(20):=255;
RQCFG_100339_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(20),-1)));
RQCFG_100339_.old_tb3_4(20):=null;
RQCFG_100339_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(20),-1)));
RQCFG_100339_.tb3_5(20):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(20):=null;
RQCFG_100339_.tb3_6(20):=NULL;
RQCFG_100339_.old_tb3_7(20):=null;
RQCFG_100339_.tb3_7(20):=NULL;
RQCFG_100339_.old_tb3_8(20):=null;
RQCFG_100339_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(20),
RQCFG_100339_.tb3_1(20),
RQCFG_100339_.tb3_2(20),
RQCFG_100339_.tb3_3(20),
RQCFG_100339_.tb3_4(20),
RQCFG_100339_.tb3_5(20),
RQCFG_100339_.tb3_6(20),
RQCFG_100339_.tb3_7(20),
RQCFG_100339_.tb3_8(20),
null,
105207,
20,
'CÓDIGO DEL PAQUETE'
,
'N'
,
'C'
,
'Y'
,
20,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(20):=1440596;
RQCFG_100339_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(20):=RQCFG_100339_.tb5_0(20);
RQCFG_100339_.old_tb5_1(20):=97550;
RQCFG_100339_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(20),-1)));
RQCFG_100339_.old_tb5_2(20):=null;
RQCFG_100339_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(20),-1)));
RQCFG_100339_.tb5_3(20):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(20):=RQCFG_100339_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(20),
RQCFG_100339_.tb5_1(20),
RQCFG_100339_.tb5_2(20),
RQCFG_100339_.tb5_3(20),
RQCFG_100339_.tb5_4(20),
'C'
,
'Y'
,
20,
'Y'
,
'CÓDIGO DEL PAQUETE'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(21):=1128250;
RQCFG_100339_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(21):=RQCFG_100339_.tb3_0(21);
RQCFG_100339_.old_tb3_1(21):=3334;
RQCFG_100339_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(21),-1)));
RQCFG_100339_.old_tb3_2(21):=413;
RQCFG_100339_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(21),-1)));
RQCFG_100339_.old_tb3_3(21):=null;
RQCFG_100339_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(21),-1)));
RQCFG_100339_.old_tb3_4(21):=null;
RQCFG_100339_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(21),-1)));
RQCFG_100339_.tb3_5(21):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(21):=null;
RQCFG_100339_.tb3_6(21):=NULL;
RQCFG_100339_.old_tb3_7(21):=null;
RQCFG_100339_.tb3_7(21):=NULL;
RQCFG_100339_.old_tb3_8(21):=null;
RQCFG_100339_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(21),
RQCFG_100339_.tb3_1(21),
RQCFG_100339_.tb3_2(21),
RQCFG_100339_.tb3_3(21),
RQCFG_100339_.tb3_4(21),
RQCFG_100339_.tb3_5(21),
RQCFG_100339_.tb3_6(21),
RQCFG_100339_.tb3_7(21),
RQCFG_100339_.tb3_8(21),
null,
105208,
21,
'Producto'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(21):=1440597;
RQCFG_100339_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(21):=RQCFG_100339_.tb5_0(21);
RQCFG_100339_.old_tb5_1(21):=413;
RQCFG_100339_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(21),-1)));
RQCFG_100339_.old_tb5_2(21):=null;
RQCFG_100339_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(21),-1)));
RQCFG_100339_.tb5_3(21):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(21):=RQCFG_100339_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(21),
RQCFG_100339_.tb5_1(21),
RQCFG_100339_.tb5_2(21),
RQCFG_100339_.tb5_3(21),
RQCFG_100339_.tb5_4(21),
'Y'
,
'Y'
,
21,
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
null,
null,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(22):=1128251;
RQCFG_100339_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(22):=RQCFG_100339_.tb3_0(22);
RQCFG_100339_.old_tb3_1(22):=3334;
RQCFG_100339_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(22),-1)));
RQCFG_100339_.old_tb3_2(22):=144514;
RQCFG_100339_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(22),-1)));
RQCFG_100339_.old_tb3_3(22):=189644;
RQCFG_100339_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(22),-1)));
RQCFG_100339_.old_tb3_4(22):=null;
RQCFG_100339_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(22),-1)));
RQCFG_100339_.tb3_5(22):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(22):=null;
RQCFG_100339_.tb3_6(22):=NULL;
RQCFG_100339_.old_tb3_7(22):=null;
RQCFG_100339_.tb3_7(22):=NULL;
RQCFG_100339_.old_tb3_8(22):=null;
RQCFG_100339_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(22),
RQCFG_100339_.tb3_1(22),
RQCFG_100339_.tb3_2(22),
RQCFG_100339_.tb3_3(22),
RQCFG_100339_.tb3_4(22),
RQCFG_100339_.tb3_5(22),
RQCFG_100339_.tb3_6(22),
RQCFG_100339_.tb3_7(22),
RQCFG_100339_.tb3_8(22),
null,
105209,
22,
'Causal'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(22):=1440598;
RQCFG_100339_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(22):=RQCFG_100339_.tb5_0(22);
RQCFG_100339_.old_tb5_1(22):=144514;
RQCFG_100339_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(22),-1)));
RQCFG_100339_.old_tb5_2(22):=null;
RQCFG_100339_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(22),-1)));
RQCFG_100339_.tb5_3(22):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(22):=RQCFG_100339_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(22),
RQCFG_100339_.tb5_1(22),
RQCFG_100339_.tb5_2(22),
RQCFG_100339_.tb5_3(22),
RQCFG_100339_.tb5_4(22),
'C'
,
'Y'
,
22,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(23):=1128252;
RQCFG_100339_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(23):=RQCFG_100339_.tb3_0(23);
RQCFG_100339_.old_tb3_1(23):=3334;
RQCFG_100339_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(23),-1)));
RQCFG_100339_.old_tb3_2(23):=144591;
RQCFG_100339_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(23),-1)));
RQCFG_100339_.old_tb3_3(23):=null;
RQCFG_100339_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(23),-1)));
RQCFG_100339_.old_tb3_4(23):=null;
RQCFG_100339_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(23),-1)));
RQCFG_100339_.tb3_5(23):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(23):=null;
RQCFG_100339_.tb3_6(23):=NULL;
RQCFG_100339_.old_tb3_7(23):=null;
RQCFG_100339_.tb3_7(23):=NULL;
RQCFG_100339_.old_tb3_8(23):=120142782;
RQCFG_100339_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(23),
RQCFG_100339_.tb3_1(23),
RQCFG_100339_.tb3_2(23),
RQCFG_100339_.tb3_3(23),
RQCFG_100339_.tb3_4(23),
RQCFG_100339_.tb3_5(23),
RQCFG_100339_.tb3_6(23),
RQCFG_100339_.tb3_7(23),
RQCFG_100339_.tb3_8(23),
null,
105210,
23,
'Respuesta'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(23):=1440599;
RQCFG_100339_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(23):=RQCFG_100339_.tb5_0(23);
RQCFG_100339_.old_tb5_1(23):=144591;
RQCFG_100339_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(23),-1)));
RQCFG_100339_.old_tb5_2(23):=null;
RQCFG_100339_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(23),-1)));
RQCFG_100339_.tb5_3(23):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(23):=RQCFG_100339_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(23),
RQCFG_100339_.tb5_1(23),
RQCFG_100339_.tb5_2(23),
RQCFG_100339_.tb5_3(23),
RQCFG_100339_.tb5_4(23),
'Y'
,
'Y'
,
23,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(24):=1128253;
RQCFG_100339_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(24):=RQCFG_100339_.tb3_0(24);
RQCFG_100339_.old_tb3_1(24):=3334;
RQCFG_100339_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(24),-1)));
RQCFG_100339_.old_tb3_2(24):=4011;
RQCFG_100339_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(24),-1)));
RQCFG_100339_.old_tb3_3(24):=null;
RQCFG_100339_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(24),-1)));
RQCFG_100339_.old_tb3_4(24):=null;
RQCFG_100339_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(24),-1)));
RQCFG_100339_.tb3_5(24):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(24):=null;
RQCFG_100339_.tb3_6(24):=NULL;
RQCFG_100339_.old_tb3_7(24):=null;
RQCFG_100339_.tb3_7(24):=NULL;
RQCFG_100339_.old_tb3_8(24):=null;
RQCFG_100339_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(24),
RQCFG_100339_.tb3_1(24),
RQCFG_100339_.tb3_2(24),
RQCFG_100339_.tb3_3(24),
RQCFG_100339_.tb3_4(24),
RQCFG_100339_.tb3_5(24),
RQCFG_100339_.tb3_6(24),
RQCFG_100339_.tb3_7(24),
RQCFG_100339_.tb3_8(24),
null,
105211,
24,
'Número del servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(24):=1440600;
RQCFG_100339_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(24):=RQCFG_100339_.tb5_0(24);
RQCFG_100339_.old_tb5_1(24):=4011;
RQCFG_100339_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(24),-1)));
RQCFG_100339_.old_tb5_2(24):=null;
RQCFG_100339_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(24),-1)));
RQCFG_100339_.tb5_3(24):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(24):=RQCFG_100339_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(24),
RQCFG_100339_.tb5_1(24),
RQCFG_100339_.tb5_2(24),
RQCFG_100339_.tb5_3(24),
RQCFG_100339_.tb5_4(24),
'C'
,
'Y'
,
24,
'Y'
,
'Número del servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(25):=1128254;
RQCFG_100339_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(25):=RQCFG_100339_.tb3_0(25);
RQCFG_100339_.old_tb3_1(25):=3334;
RQCFG_100339_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(25),-1)));
RQCFG_100339_.old_tb3_2(25):=281;
RQCFG_100339_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(25),-1)));
RQCFG_100339_.old_tb3_3(25):=187;
RQCFG_100339_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(25),-1)));
RQCFG_100339_.old_tb3_4(25):=null;
RQCFG_100339_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(25),-1)));
RQCFG_100339_.tb3_5(25):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(25):=null;
RQCFG_100339_.tb3_6(25):=NULL;
RQCFG_100339_.old_tb3_7(25):=null;
RQCFG_100339_.tb3_7(25):=NULL;
RQCFG_100339_.old_tb3_8(25):=null;
RQCFG_100339_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(25),
RQCFG_100339_.tb3_1(25),
RQCFG_100339_.tb3_2(25),
RQCFG_100339_.tb3_3(25),
RQCFG_100339_.tb3_4(25),
RQCFG_100339_.tb3_5(25),
RQCFG_100339_.tb3_6(25),
RQCFG_100339_.tb3_7(25),
RQCFG_100339_.tb3_8(25),
null,
105212,
25,
'Consecutivo Interno Motivos'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(25):=1440601;
RQCFG_100339_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(25):=RQCFG_100339_.tb5_0(25);
RQCFG_100339_.old_tb5_1(25):=281;
RQCFG_100339_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(25),-1)));
RQCFG_100339_.old_tb5_2(25):=null;
RQCFG_100339_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(25),-1)));
RQCFG_100339_.tb5_3(25):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(25):=RQCFG_100339_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(25),
RQCFG_100339_.tb5_1(25),
RQCFG_100339_.tb5_2(25),
RQCFG_100339_.tb5_3(25),
RQCFG_100339_.tb5_4(25),
'C'
,
'Y'
,
25,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(26):=1128255;
RQCFG_100339_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(26):=RQCFG_100339_.tb3_0(26);
RQCFG_100339_.old_tb3_1(26):=3334;
RQCFG_100339_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(26),-1)));
RQCFG_100339_.old_tb3_2(26):=474;
RQCFG_100339_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(26),-1)));
RQCFG_100339_.old_tb3_3(26):=null;
RQCFG_100339_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(26),-1)));
RQCFG_100339_.old_tb3_4(26):=null;
RQCFG_100339_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(26),-1)));
RQCFG_100339_.tb3_5(26):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(26):=121269265;
RQCFG_100339_.tb3_6(26):=NULL;
RQCFG_100339_.old_tb3_7(26):=null;
RQCFG_100339_.tb3_7(26):=NULL;
RQCFG_100339_.old_tb3_8(26):=null;
RQCFG_100339_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(26),
RQCFG_100339_.tb3_1(26),
RQCFG_100339_.tb3_2(26),
RQCFG_100339_.tb3_3(26),
RQCFG_100339_.tb3_4(26),
RQCFG_100339_.tb3_5(26),
RQCFG_100339_.tb3_6(26),
RQCFG_100339_.tb3_7(26),
RQCFG_100339_.tb3_8(26),
null,
105213,
26,
'Código de la Dirección'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(26):=1440602;
RQCFG_100339_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(26):=RQCFG_100339_.tb5_0(26);
RQCFG_100339_.old_tb5_1(26):=474;
RQCFG_100339_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(26),-1)));
RQCFG_100339_.old_tb5_2(26):=null;
RQCFG_100339_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(26),-1)));
RQCFG_100339_.tb5_3(26):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(26):=RQCFG_100339_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(26),
RQCFG_100339_.tb5_1(26),
RQCFG_100339_.tb5_2(26),
RQCFG_100339_.tb5_3(26),
RQCFG_100339_.tb5_4(26),
'C'
,
'Y'
,
26,
'Y'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(27):=1128256;
RQCFG_100339_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(27):=RQCFG_100339_.tb3_0(27);
RQCFG_100339_.old_tb3_1(27):=3334;
RQCFG_100339_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(27),-1)));
RQCFG_100339_.old_tb3_2(27):=39322;
RQCFG_100339_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(27),-1)));
RQCFG_100339_.old_tb3_3(27):=213;
RQCFG_100339_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(27),-1)));
RQCFG_100339_.old_tb3_4(27):=null;
RQCFG_100339_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(27),-1)));
RQCFG_100339_.tb3_5(27):=RQCFG_100339_.tb2_2(1);
RQCFG_100339_.old_tb3_6(27):=null;
RQCFG_100339_.tb3_6(27):=NULL;
RQCFG_100339_.old_tb3_7(27):=null;
RQCFG_100339_.tb3_7(27):=NULL;
RQCFG_100339_.old_tb3_8(27):=null;
RQCFG_100339_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(27),
RQCFG_100339_.tb3_1(27),
RQCFG_100339_.tb3_2(27),
RQCFG_100339_.tb3_3(27),
RQCFG_100339_.tb3_4(27),
RQCFG_100339_.tb3_5(27),
RQCFG_100339_.tb3_6(27),
RQCFG_100339_.tb3_7(27),
RQCFG_100339_.tb3_8(27),
null,
105214,
27,
'Identificador De Solicitud'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(27):=1440603;
RQCFG_100339_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(27):=RQCFG_100339_.tb5_0(27);
RQCFG_100339_.old_tb5_1(27):=39322;
RQCFG_100339_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(27),-1)));
RQCFG_100339_.old_tb5_2(27):=null;
RQCFG_100339_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(27),-1)));
RQCFG_100339_.tb5_3(27):=RQCFG_100339_.tb4_0(0);
RQCFG_100339_.tb5_4(27):=RQCFG_100339_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(27),
RQCFG_100339_.tb5_1(27),
RQCFG_100339_.tb5_2(27),
RQCFG_100339_.tb5_3(27),
RQCFG_100339_.tb5_4(27),
'C'
,
'Y'
,
27,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(28):=1128270;
RQCFG_100339_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(28):=RQCFG_100339_.tb3_0(28);
RQCFG_100339_.old_tb3_1(28):=2036;
RQCFG_100339_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(28),-1)));
RQCFG_100339_.old_tb3_2(28):=255;
RQCFG_100339_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(28),-1)));
RQCFG_100339_.old_tb3_3(28):=null;
RQCFG_100339_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(28),-1)));
RQCFG_100339_.old_tb3_4(28):=null;
RQCFG_100339_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(28),-1)));
RQCFG_100339_.tb3_5(28):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(28):=null;
RQCFG_100339_.tb3_6(28):=NULL;
RQCFG_100339_.old_tb3_7(28):=null;
RQCFG_100339_.tb3_7(28):=NULL;
RQCFG_100339_.old_tb3_8(28):=null;
RQCFG_100339_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(28),
RQCFG_100339_.tb3_1(28),
RQCFG_100339_.tb3_2(28),
RQCFG_100339_.tb3_3(28),
RQCFG_100339_.tb3_4(28),
RQCFG_100339_.tb3_5(28),
RQCFG_100339_.tb3_6(28),
RQCFG_100339_.tb3_7(28),
RQCFG_100339_.tb3_8(28),
null,
108276,
2,
'Número de Solicitud'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb4_0(1):=693;
RQCFG_100339_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100339_.tb4_0(1):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb4_1(1):=RQCFG_100339_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100339_.tb4_0(1),
RQCFG_100339_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1052885'
,
1);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(28):=1440617;
RQCFG_100339_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(28):=RQCFG_100339_.tb5_0(28);
RQCFG_100339_.old_tb5_1(28):=255;
RQCFG_100339_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(28),-1)));
RQCFG_100339_.old_tb5_2(28):=null;
RQCFG_100339_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(28),-1)));
RQCFG_100339_.tb5_3(28):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(28):=RQCFG_100339_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(28),
RQCFG_100339_.tb5_1(28),
RQCFG_100339_.tb5_2(28),
RQCFG_100339_.tb5_3(28),
RQCFG_100339_.tb5_4(28),
'Y'
,
'E'
,
2,
'Y'
,
'Número de Solicitud'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(29):=1128271;
RQCFG_100339_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(29):=RQCFG_100339_.tb3_0(29);
RQCFG_100339_.old_tb3_1(29):=2036;
RQCFG_100339_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(29),-1)));
RQCFG_100339_.old_tb3_2(29):=50001162;
RQCFG_100339_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(29),-1)));
RQCFG_100339_.old_tb3_3(29):=null;
RQCFG_100339_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(29),-1)));
RQCFG_100339_.old_tb3_4(29):=null;
RQCFG_100339_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(29),-1)));
RQCFG_100339_.tb3_5(29):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(29):=121269259;
RQCFG_100339_.tb3_6(29):=NULL;
RQCFG_100339_.old_tb3_7(29):=null;
RQCFG_100339_.tb3_7(29):=NULL;
RQCFG_100339_.old_tb3_8(29):=120142779;
RQCFG_100339_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(29),
RQCFG_100339_.tb3_1(29),
RQCFG_100339_.tb3_2(29),
RQCFG_100339_.tb3_3(29),
RQCFG_100339_.tb3_4(29),
RQCFG_100339_.tb3_5(29),
RQCFG_100339_.tb3_6(29),
RQCFG_100339_.tb3_7(29),
RQCFG_100339_.tb3_8(29),
null,
108277,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(29):=1440618;
RQCFG_100339_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(29):=RQCFG_100339_.tb5_0(29);
RQCFG_100339_.old_tb5_1(29):=50001162;
RQCFG_100339_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(29),-1)));
RQCFG_100339_.old_tb5_2(29):=null;
RQCFG_100339_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(29),-1)));
RQCFG_100339_.tb5_3(29):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(29):=RQCFG_100339_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(29),
RQCFG_100339_.tb5_1(29),
RQCFG_100339_.tb5_2(29),
RQCFG_100339_.tb5_3(29),
RQCFG_100339_.tb5_4(29),
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
'M'
,
null,
4,
null,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(30):=1128272;
RQCFG_100339_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(30):=RQCFG_100339_.tb3_0(30);
RQCFG_100339_.old_tb3_1(30):=2036;
RQCFG_100339_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(30),-1)));
RQCFG_100339_.old_tb3_2(30):=146755;
RQCFG_100339_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(30),-1)));
RQCFG_100339_.old_tb3_3(30):=null;
RQCFG_100339_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(30),-1)));
RQCFG_100339_.old_tb3_4(30):=null;
RQCFG_100339_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(30),-1)));
RQCFG_100339_.tb3_5(30):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(30):=null;
RQCFG_100339_.tb3_6(30):=NULL;
RQCFG_100339_.old_tb3_7(30):=null;
RQCFG_100339_.tb3_7(30):=NULL;
RQCFG_100339_.old_tb3_8(30):=null;
RQCFG_100339_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(30),
RQCFG_100339_.tb3_1(30),
RQCFG_100339_.tb3_2(30),
RQCFG_100339_.tb3_3(30),
RQCFG_100339_.tb3_4(30),
RQCFG_100339_.tb3_5(30),
RQCFG_100339_.tb3_6(30),
RQCFG_100339_.tb3_7(30),
RQCFG_100339_.tb3_8(30),
null,
108278,
4,
'Información del Solicitante'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(30):=1440619;
RQCFG_100339_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(30):=RQCFG_100339_.tb5_0(30);
RQCFG_100339_.old_tb5_1(30):=146755;
RQCFG_100339_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(30),-1)));
RQCFG_100339_.old_tb5_2(30):=null;
RQCFG_100339_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(30),-1)));
RQCFG_100339_.tb5_3(30):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(30):=RQCFG_100339_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(30),
RQCFG_100339_.tb5_1(30),
RQCFG_100339_.tb5_2(30),
RQCFG_100339_.tb5_3(30),
RQCFG_100339_.tb5_4(30),
'Y'
,
'E'
,
4,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(31):=1128273;
RQCFG_100339_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(31):=RQCFG_100339_.tb3_0(31);
RQCFG_100339_.old_tb3_1(31):=2036;
RQCFG_100339_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(31),-1)));
RQCFG_100339_.old_tb3_2(31):=6733;
RQCFG_100339_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(31),-1)));
RQCFG_100339_.old_tb3_3(31):=null;
RQCFG_100339_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(31),-1)));
RQCFG_100339_.old_tb3_4(31):=146755;
RQCFG_100339_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(31),-1)));
RQCFG_100339_.tb3_5(31):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(31):=null;
RQCFG_100339_.tb3_6(31):=NULL;
RQCFG_100339_.old_tb3_7(31):=null;
RQCFG_100339_.tb3_7(31):=NULL;
RQCFG_100339_.old_tb3_8(31):=null;
RQCFG_100339_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(31),
RQCFG_100339_.tb3_1(31),
RQCFG_100339_.tb3_2(31),
RQCFG_100339_.tb3_3(31),
RQCFG_100339_.tb3_4(31),
RQCFG_100339_.tb3_5(31),
RQCFG_100339_.tb3_6(31),
RQCFG_100339_.tb3_7(31),
RQCFG_100339_.tb3_8(31),
null,
108279,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(31):=1440620;
RQCFG_100339_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(31):=RQCFG_100339_.tb5_0(31);
RQCFG_100339_.old_tb5_1(31):=6733;
RQCFG_100339_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(31),-1)));
RQCFG_100339_.old_tb5_2(31):=146755;
RQCFG_100339_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(31),-1)));
RQCFG_100339_.tb5_3(31):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(31):=RQCFG_100339_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(31),
RQCFG_100339_.tb5_1(31),
RQCFG_100339_.tb5_2(31),
RQCFG_100339_.tb5_3(31),
RQCFG_100339_.tb5_4(31),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(32):=1128274;
RQCFG_100339_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(32):=RQCFG_100339_.tb3_0(32);
RQCFG_100339_.old_tb3_1(32):=2036;
RQCFG_100339_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(32),-1)));
RQCFG_100339_.old_tb3_2(32):=109479;
RQCFG_100339_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(32),-1)));
RQCFG_100339_.old_tb3_3(32):=null;
RQCFG_100339_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(32),-1)));
RQCFG_100339_.old_tb3_4(32):=null;
RQCFG_100339_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(32),-1)));
RQCFG_100339_.tb3_5(32):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(32):=null;
RQCFG_100339_.tb3_6(32):=NULL;
RQCFG_100339_.old_tb3_7(32):=null;
RQCFG_100339_.tb3_7(32):=NULL;
RQCFG_100339_.old_tb3_8(32):=120142780;
RQCFG_100339_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(32),
RQCFG_100339_.tb3_1(32),
RQCFG_100339_.tb3_2(32),
RQCFG_100339_.tb3_3(32),
RQCFG_100339_.tb3_4(32),
RQCFG_100339_.tb3_5(32),
RQCFG_100339_.tb3_6(32),
RQCFG_100339_.tb3_7(32),
RQCFG_100339_.tb3_8(32),
null,
108280,
6,
'Punto de Atención'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(32):=1440621;
RQCFG_100339_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(32):=RQCFG_100339_.tb5_0(32);
RQCFG_100339_.old_tb5_1(32):=109479;
RQCFG_100339_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(32),-1)));
RQCFG_100339_.old_tb5_2(32):=null;
RQCFG_100339_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(32),-1)));
RQCFG_100339_.tb5_3(32):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(32):=RQCFG_100339_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(32),
RQCFG_100339_.tb5_1(32),
RQCFG_100339_.tb5_2(32),
RQCFG_100339_.tb5_3(32),
RQCFG_100339_.tb5_4(32),
'Y'
,
'N'
,
6,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(33):=1128275;
RQCFG_100339_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(33):=RQCFG_100339_.tb3_0(33);
RQCFG_100339_.old_tb3_1(33):=2036;
RQCFG_100339_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(33),-1)));
RQCFG_100339_.old_tb3_2(33):=2683;
RQCFG_100339_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(33),-1)));
RQCFG_100339_.old_tb3_3(33):=null;
RQCFG_100339_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(33),-1)));
RQCFG_100339_.old_tb3_4(33):=null;
RQCFG_100339_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(33),-1)));
RQCFG_100339_.tb3_5(33):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(33):=null;
RQCFG_100339_.tb3_6(33):=NULL;
RQCFG_100339_.old_tb3_7(33):=null;
RQCFG_100339_.tb3_7(33):=NULL;
RQCFG_100339_.old_tb3_8(33):=120142781;
RQCFG_100339_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(33),
RQCFG_100339_.tb3_1(33),
RQCFG_100339_.tb3_2(33),
RQCFG_100339_.tb3_3(33),
RQCFG_100339_.tb3_4(33),
RQCFG_100339_.tb3_5(33),
RQCFG_100339_.tb3_6(33),
RQCFG_100339_.tb3_7(33),
RQCFG_100339_.tb3_8(33),
null,
108281,
7,
'Medio de Recepción'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(33):=1440622;
RQCFG_100339_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(33):=RQCFG_100339_.tb5_0(33);
RQCFG_100339_.old_tb5_1(33):=2683;
RQCFG_100339_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(33),-1)));
RQCFG_100339_.old_tb5_2(33):=null;
RQCFG_100339_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(33),-1)));
RQCFG_100339_.tb5_3(33):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(33):=RQCFG_100339_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(33),
RQCFG_100339_.tb5_1(33),
RQCFG_100339_.tb5_2(33),
RQCFG_100339_.tb5_3(33),
RQCFG_100339_.tb5_4(33),
'Y'
,
'Y'
,
7,
'Y'
,
'Medio de Recepción'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(34):=1128276;
RQCFG_100339_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(34):=RQCFG_100339_.tb3_0(34);
RQCFG_100339_.old_tb3_1(34):=2036;
RQCFG_100339_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(34),-1)));
RQCFG_100339_.old_tb3_2(34):=146756;
RQCFG_100339_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(34),-1)));
RQCFG_100339_.old_tb3_3(34):=null;
RQCFG_100339_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(34),-1)));
RQCFG_100339_.old_tb3_4(34):=null;
RQCFG_100339_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(34),-1)));
RQCFG_100339_.tb3_5(34):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(34):=null;
RQCFG_100339_.tb3_6(34):=NULL;
RQCFG_100339_.old_tb3_7(34):=null;
RQCFG_100339_.tb3_7(34):=NULL;
RQCFG_100339_.old_tb3_8(34):=null;
RQCFG_100339_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(34),
RQCFG_100339_.tb3_1(34),
RQCFG_100339_.tb3_2(34),
RQCFG_100339_.tb3_3(34),
RQCFG_100339_.tb3_4(34),
RQCFG_100339_.tb3_5(34),
RQCFG_100339_.tb3_6(34),
RQCFG_100339_.tb3_7(34),
RQCFG_100339_.tb3_8(34),
null,
108282,
8,
'Dirección de Respuesta'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(34):=1440623;
RQCFG_100339_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(34):=RQCFG_100339_.tb5_0(34);
RQCFG_100339_.old_tb5_1(34):=146756;
RQCFG_100339_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(34),-1)));
RQCFG_100339_.old_tb5_2(34):=null;
RQCFG_100339_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(34),-1)));
RQCFG_100339_.tb5_3(34):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(34):=RQCFG_100339_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(34),
RQCFG_100339_.tb5_1(34),
RQCFG_100339_.tb5_2(34),
RQCFG_100339_.tb5_3(34),
RQCFG_100339_.tb5_4(34),
'Y'
,
'E'
,
8,
'N'
,
'Dirección de Respuesta'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(35):=1128277;
RQCFG_100339_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(35):=RQCFG_100339_.tb3_0(35);
RQCFG_100339_.old_tb3_1(35):=2036;
RQCFG_100339_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(35),-1)));
RQCFG_100339_.old_tb3_2(35):=189644;
RQCFG_100339_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(35),-1)));
RQCFG_100339_.old_tb3_3(35):=null;
RQCFG_100339_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(35),-1)));
RQCFG_100339_.old_tb3_4(35):=null;
RQCFG_100339_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(35),-1)));
RQCFG_100339_.tb3_5(35):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(35):=null;
RQCFG_100339_.tb3_6(35):=NULL;
RQCFG_100339_.old_tb3_7(35):=null;
RQCFG_100339_.tb3_7(35):=NULL;
RQCFG_100339_.old_tb3_8(35):=null;
RQCFG_100339_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(35),
RQCFG_100339_.tb3_1(35),
RQCFG_100339_.tb3_2(35),
RQCFG_100339_.tb3_3(35),
RQCFG_100339_.tb3_4(35),
RQCFG_100339_.tb3_5(35),
RQCFG_100339_.tb3_6(35),
RQCFG_100339_.tb3_7(35),
RQCFG_100339_.tb3_8(35),
null,
108283,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(35):=1440624;
RQCFG_100339_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(35):=RQCFG_100339_.tb5_0(35);
RQCFG_100339_.old_tb5_1(35):=189644;
RQCFG_100339_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(35),-1)));
RQCFG_100339_.old_tb5_2(35):=null;
RQCFG_100339_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(35),-1)));
RQCFG_100339_.tb5_3(35):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(35):=RQCFG_100339_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(35),
RQCFG_100339_.tb5_1(35),
RQCFG_100339_.tb5_2(35),
RQCFG_100339_.tb5_3(35),
RQCFG_100339_.tb5_4(35),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(36):=1128278;
RQCFG_100339_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(36):=RQCFG_100339_.tb3_0(36);
RQCFG_100339_.old_tb3_1(36):=2036;
RQCFG_100339_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(36),-1)));
RQCFG_100339_.old_tb3_2(36):=40909;
RQCFG_100339_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(36),-1)));
RQCFG_100339_.old_tb3_3(36):=null;
RQCFG_100339_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(36),-1)));
RQCFG_100339_.old_tb3_4(36):=189644;
RQCFG_100339_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(36),-1)));
RQCFG_100339_.tb3_5(36):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(36):=null;
RQCFG_100339_.tb3_6(36):=NULL;
RQCFG_100339_.old_tb3_7(36):=null;
RQCFG_100339_.tb3_7(36):=NULL;
RQCFG_100339_.old_tb3_8(36):=120142777;
RQCFG_100339_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(36),
RQCFG_100339_.tb3_1(36),
RQCFG_100339_.tb3_2(36),
RQCFG_100339_.tb3_3(36),
RQCFG_100339_.tb3_4(36),
RQCFG_100339_.tb3_5(36),
RQCFG_100339_.tb3_6(36),
RQCFG_100339_.tb3_7(36),
RQCFG_100339_.tb3_8(36),
null,
108284,
10,
'Área Organizacional Causante'
,
'N'
,
'Y'
,
'N'
,
10,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(36):=1440625;
RQCFG_100339_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(36):=RQCFG_100339_.tb5_0(36);
RQCFG_100339_.old_tb5_1(36):=40909;
RQCFG_100339_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(36),-1)));
RQCFG_100339_.old_tb5_2(36):=189644;
RQCFG_100339_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(36),-1)));
RQCFG_100339_.tb5_3(36):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(36):=RQCFG_100339_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(36),
RQCFG_100339_.tb5_1(36),
RQCFG_100339_.tb5_2(36),
RQCFG_100339_.tb5_3(36),
RQCFG_100339_.tb5_4(36),
'Y'
,
'Y'
,
10,
'N'
,
'Área Organizacional Causante'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(37):=1128279;
RQCFG_100339_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(37):=RQCFG_100339_.tb3_0(37);
RQCFG_100339_.old_tb3_1(37):=2036;
RQCFG_100339_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(37),-1)));
RQCFG_100339_.old_tb3_2(37):=182398;
RQCFG_100339_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(37),-1)));
RQCFG_100339_.old_tb3_3(37):=null;
RQCFG_100339_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(37),-1)));
RQCFG_100339_.old_tb3_4(37):=189644;
RQCFG_100339_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(37),-1)));
RQCFG_100339_.tb3_5(37):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(37):=null;
RQCFG_100339_.tb3_6(37):=NULL;
RQCFG_100339_.old_tb3_7(37):=null;
RQCFG_100339_.tb3_7(37):=NULL;
RQCFG_100339_.old_tb3_8(37):=120142778;
RQCFG_100339_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(37),
RQCFG_100339_.tb3_1(37),
RQCFG_100339_.tb3_2(37),
RQCFG_100339_.tb3_3(37),
RQCFG_100339_.tb3_4(37),
RQCFG_100339_.tb3_5(37),
RQCFG_100339_.tb3_6(37),
RQCFG_100339_.tb3_7(37),
RQCFG_100339_.tb3_8(37),
null,
108285,
11,
'Área Que Gestiona La Solicitud'
,
'N'
,
'Y'
,
'N'
,
11,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(37):=1440626;
RQCFG_100339_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(37):=RQCFG_100339_.tb5_0(37);
RQCFG_100339_.old_tb5_1(37):=182398;
RQCFG_100339_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(37),-1)));
RQCFG_100339_.old_tb5_2(37):=189644;
RQCFG_100339_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(37),-1)));
RQCFG_100339_.tb5_3(37):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(37):=RQCFG_100339_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(37),
RQCFG_100339_.tb5_1(37),
RQCFG_100339_.tb5_2(37),
RQCFG_100339_.tb5_3(37),
RQCFG_100339_.tb5_4(37),
'Y'
,
'Y'
,
11,
'N'
,
'Área Que Gestiona La Solicitud'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(38):=1128280;
RQCFG_100339_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(38):=RQCFG_100339_.tb3_0(38);
RQCFG_100339_.old_tb3_1(38):=2036;
RQCFG_100339_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(38),-1)));
RQCFG_100339_.old_tb3_2(38):=146754;
RQCFG_100339_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(38),-1)));
RQCFG_100339_.old_tb3_3(38):=null;
RQCFG_100339_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(38),-1)));
RQCFG_100339_.old_tb3_4(38):=null;
RQCFG_100339_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(38),-1)));
RQCFG_100339_.tb3_5(38):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(38):=null;
RQCFG_100339_.tb3_6(38):=NULL;
RQCFG_100339_.old_tb3_7(38):=null;
RQCFG_100339_.tb3_7(38):=NULL;
RQCFG_100339_.old_tb3_8(38):=null;
RQCFG_100339_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(38),
RQCFG_100339_.tb3_1(38),
RQCFG_100339_.tb3_2(38),
RQCFG_100339_.tb3_3(38),
RQCFG_100339_.tb3_4(38),
RQCFG_100339_.tb3_5(38),
RQCFG_100339_.tb3_6(38),
RQCFG_100339_.tb3_7(38),
RQCFG_100339_.tb3_8(38),
null,
108286,
12,
'Observación'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(38):=1440627;
RQCFG_100339_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(38):=RQCFG_100339_.tb5_0(38);
RQCFG_100339_.old_tb5_1(38):=146754;
RQCFG_100339_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(38),-1)));
RQCFG_100339_.old_tb5_2(38):=null;
RQCFG_100339_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(38),-1)));
RQCFG_100339_.tb5_3(38):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(38):=RQCFG_100339_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(38),
RQCFG_100339_.tb5_1(38),
RQCFG_100339_.tb5_2(38),
RQCFG_100339_.tb5_3(38),
RQCFG_100339_.tb5_4(38),
'Y'
,
'Y'
,
12,
'Y'
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
110,
null,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(39):=1128281;
RQCFG_100339_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(39):=RQCFG_100339_.tb3_0(39);
RQCFG_100339_.old_tb3_1(39):=2036;
RQCFG_100339_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(39),-1)));
RQCFG_100339_.old_tb3_2(39):=2508;
RQCFG_100339_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(39),-1)));
RQCFG_100339_.old_tb3_3(39):=null;
RQCFG_100339_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(39),-1)));
RQCFG_100339_.old_tb3_4(39):=null;
RQCFG_100339_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(39),-1)));
RQCFG_100339_.tb3_5(39):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(39):=null;
RQCFG_100339_.tb3_6(39):=NULL;
RQCFG_100339_.old_tb3_7(39):=null;
RQCFG_100339_.tb3_7(39):=NULL;
RQCFG_100339_.old_tb3_8(39):=null;
RQCFG_100339_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(39),
RQCFG_100339_.tb3_1(39),
RQCFG_100339_.tb3_2(39),
RQCFG_100339_.tb3_3(39),
RQCFG_100339_.tb3_4(39),
RQCFG_100339_.tb3_5(39),
RQCFG_100339_.tb3_6(39),
RQCFG_100339_.tb3_7(39),
RQCFG_100339_.tb3_8(39),
null,
108287,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(39):=1440628;
RQCFG_100339_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(39):=RQCFG_100339_.tb5_0(39);
RQCFG_100339_.old_tb5_1(39):=2508;
RQCFG_100339_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(39),-1)));
RQCFG_100339_.old_tb5_2(39):=null;
RQCFG_100339_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(39),-1)));
RQCFG_100339_.tb5_3(39):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(39):=RQCFG_100339_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(39),
RQCFG_100339_.tb5_1(39),
RQCFG_100339_.tb5_2(39),
RQCFG_100339_.tb5_3(39),
RQCFG_100339_.tb5_4(39),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(40):=1128282;
RQCFG_100339_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(40):=RQCFG_100339_.tb3_0(40);
RQCFG_100339_.old_tb3_1(40):=2036;
RQCFG_100339_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(40),-1)));
RQCFG_100339_.old_tb3_2(40):=20371;
RQCFG_100339_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(40),-1)));
RQCFG_100339_.old_tb3_3(40):=null;
RQCFG_100339_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(40),-1)));
RQCFG_100339_.old_tb3_4(40):=null;
RQCFG_100339_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(40),-1)));
RQCFG_100339_.tb3_5(40):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(40):=null;
RQCFG_100339_.tb3_6(40):=NULL;
RQCFG_100339_.old_tb3_7(40):=null;
RQCFG_100339_.tb3_7(40):=NULL;
RQCFG_100339_.old_tb3_8(40):=null;
RQCFG_100339_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(40),
RQCFG_100339_.tb3_1(40),
RQCFG_100339_.tb3_2(40),
RQCFG_100339_.tb3_3(40),
RQCFG_100339_.tb3_4(40),
RQCFG_100339_.tb3_5(40),
RQCFG_100339_.tb3_6(40),
RQCFG_100339_.tb3_7(40),
RQCFG_100339_.tb3_8(40),
null,
108288,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(40):=1440629;
RQCFG_100339_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(40):=RQCFG_100339_.tb5_0(40);
RQCFG_100339_.old_tb5_1(40):=20371;
RQCFG_100339_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(40),-1)));
RQCFG_100339_.old_tb5_2(40):=null;
RQCFG_100339_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(40),-1)));
RQCFG_100339_.tb5_3(40):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(40):=RQCFG_100339_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(40),
RQCFG_100339_.tb5_1(40),
RQCFG_100339_.tb5_2(40),
RQCFG_100339_.tb5_3(40),
RQCFG_100339_.tb5_4(40),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(41):=1128257;
RQCFG_100339_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(41):=RQCFG_100339_.tb3_0(41);
RQCFG_100339_.old_tb3_1(41):=2036;
RQCFG_100339_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(41),-1)));
RQCFG_100339_.old_tb3_2(41):=269;
RQCFG_100339_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(41),-1)));
RQCFG_100339_.old_tb3_3(41):=null;
RQCFG_100339_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(41),-1)));
RQCFG_100339_.old_tb3_4(41):=null;
RQCFG_100339_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(41),-1)));
RQCFG_100339_.tb3_5(41):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(41):=null;
RQCFG_100339_.tb3_6(41):=NULL;
RQCFG_100339_.old_tb3_7(41):=null;
RQCFG_100339_.tb3_7(41):=NULL;
RQCFG_100339_.old_tb3_8(41):=null;
RQCFG_100339_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(41),
RQCFG_100339_.tb3_1(41),
RQCFG_100339_.tb3_2(41),
RQCFG_100339_.tb3_3(41),
RQCFG_100339_.tb3_4(41),
RQCFG_100339_.tb3_5(41),
RQCFG_100339_.tb3_6(41),
RQCFG_100339_.tb3_7(41),
RQCFG_100339_.tb3_8(41),
null,
108289,
15,
'Código del Tipo de Paquete'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(41):=1440604;
RQCFG_100339_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(41):=RQCFG_100339_.tb5_0(41);
RQCFG_100339_.old_tb5_1(41):=269;
RQCFG_100339_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(41),-1)));
RQCFG_100339_.old_tb5_2(41):=null;
RQCFG_100339_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(41),-1)));
RQCFG_100339_.tb5_3(41):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(41):=RQCFG_100339_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(41),
RQCFG_100339_.tb5_1(41),
RQCFG_100339_.tb5_2(41),
RQCFG_100339_.tb5_3(41),
RQCFG_100339_.tb5_4(41),
'C'
,
'Y'
,
15,
'Y'
,
'Código del Tipo de Paquete'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(42):=1128258;
RQCFG_100339_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(42):=RQCFG_100339_.tb3_0(42);
RQCFG_100339_.old_tb3_1(42):=2036;
RQCFG_100339_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(42),-1)));
RQCFG_100339_.old_tb3_2(42):=259;
RQCFG_100339_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(42),-1)));
RQCFG_100339_.old_tb3_3(42):=null;
RQCFG_100339_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(42),-1)));
RQCFG_100339_.old_tb3_4(42):=null;
RQCFG_100339_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(42),-1)));
RQCFG_100339_.tb3_5(42):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(42):=121269255;
RQCFG_100339_.tb3_6(42):=NULL;
RQCFG_100339_.old_tb3_7(42):=null;
RQCFG_100339_.tb3_7(42):=NULL;
RQCFG_100339_.old_tb3_8(42):=null;
RQCFG_100339_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(42),
RQCFG_100339_.tb3_1(42),
RQCFG_100339_.tb3_2(42),
RQCFG_100339_.tb3_3(42),
RQCFG_100339_.tb3_4(42),
RQCFG_100339_.tb3_5(42),
RQCFG_100339_.tb3_6(42),
RQCFG_100339_.tb3_7(42),
RQCFG_100339_.tb3_8(42),
null,
108290,
16,
'Fecha de Envío'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(42):=1440605;
RQCFG_100339_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(42):=RQCFG_100339_.tb5_0(42);
RQCFG_100339_.old_tb5_1(42):=259;
RQCFG_100339_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(42),-1)));
RQCFG_100339_.old_tb5_2(42):=null;
RQCFG_100339_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(42),-1)));
RQCFG_100339_.tb5_3(42):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(42):=RQCFG_100339_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(42),
RQCFG_100339_.tb5_1(42),
RQCFG_100339_.tb5_2(42),
RQCFG_100339_.tb5_3(42),
RQCFG_100339_.tb5_4(42),
'C'
,
'Y'
,
16,
'Y'
,
'Fecha de Envío'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(43):=1128259;
RQCFG_100339_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(43):=RQCFG_100339_.tb3_0(43);
RQCFG_100339_.old_tb3_1(43):=2036;
RQCFG_100339_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(43),-1)));
RQCFG_100339_.old_tb3_2(43):=42118;
RQCFG_100339_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(43),-1)));
RQCFG_100339_.old_tb3_3(43):=109479;
RQCFG_100339_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(43),-1)));
RQCFG_100339_.old_tb3_4(43):=null;
RQCFG_100339_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(43),-1)));
RQCFG_100339_.tb3_5(43):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(43):=null;
RQCFG_100339_.tb3_6(43):=NULL;
RQCFG_100339_.old_tb3_7(43):=null;
RQCFG_100339_.tb3_7(43):=NULL;
RQCFG_100339_.old_tb3_8(43):=null;
RQCFG_100339_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(43),
RQCFG_100339_.tb3_1(43),
RQCFG_100339_.tb3_2(43),
RQCFG_100339_.tb3_3(43),
RQCFG_100339_.tb3_4(43),
RQCFG_100339_.tb3_5(43),
RQCFG_100339_.tb3_6(43),
RQCFG_100339_.tb3_7(43),
RQCFG_100339_.tb3_8(43),
null,
108291,
17,
'Código Canal De Ventas'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(43):=1440606;
RQCFG_100339_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(43):=RQCFG_100339_.tb5_0(43);
RQCFG_100339_.old_tb5_1(43):=42118;
RQCFG_100339_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(43),-1)));
RQCFG_100339_.old_tb5_2(43):=null;
RQCFG_100339_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(43),-1)));
RQCFG_100339_.tb5_3(43):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(43):=RQCFG_100339_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(43),
RQCFG_100339_.tb5_1(43),
RQCFG_100339_.tb5_2(43),
RQCFG_100339_.tb5_3(43),
RQCFG_100339_.tb5_4(43),
'C'
,
'Y'
,
17,
'N'
,
'Código Canal De Ventas'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(44):=1128260;
RQCFG_100339_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(44):=RQCFG_100339_.tb3_0(44);
RQCFG_100339_.old_tb3_1(44):=2036;
RQCFG_100339_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(44),-1)));
RQCFG_100339_.old_tb3_2(44):=515;
RQCFG_100339_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(44),-1)));
RQCFG_100339_.old_tb3_3(44):=null;
RQCFG_100339_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(44),-1)));
RQCFG_100339_.old_tb3_4(44):=null;
RQCFG_100339_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(44),-1)));
RQCFG_100339_.tb3_5(44):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(44):=null;
RQCFG_100339_.tb3_6(44):=NULL;
RQCFG_100339_.old_tb3_7(44):=null;
RQCFG_100339_.tb3_7(44):=NULL;
RQCFG_100339_.old_tb3_8(44):=null;
RQCFG_100339_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(44),
RQCFG_100339_.tb3_1(44),
RQCFG_100339_.tb3_2(44),
RQCFG_100339_.tb3_3(44),
RQCFG_100339_.tb3_4(44),
RQCFG_100339_.tb3_5(44),
RQCFG_100339_.tb3_6(44),
RQCFG_100339_.tb3_7(44),
RQCFG_100339_.tb3_8(44),
null,
108292,
18,
'Datos del Daño'
,
'N'
,
'Y'
,
'N'
,
18,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(44):=1440607;
RQCFG_100339_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(44):=RQCFG_100339_.tb5_0(44);
RQCFG_100339_.old_tb5_1(44):=515;
RQCFG_100339_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(44),-1)));
RQCFG_100339_.old_tb5_2(44):=null;
RQCFG_100339_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(44),-1)));
RQCFG_100339_.tb5_3(44):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(44):=RQCFG_100339_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(44),
RQCFG_100339_.tb5_1(44),
RQCFG_100339_.tb5_2(44),
RQCFG_100339_.tb5_3(44),
RQCFG_100339_.tb5_4(44),
'Y'
,
'Y'
,
18,
'N'
,
'Datos del Daño'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(45):=1128261;
RQCFG_100339_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(45):=RQCFG_100339_.tb3_0(45);
RQCFG_100339_.old_tb3_1(45):=2036;
RQCFG_100339_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(45),-1)));
RQCFG_100339_.old_tb3_2(45):=39259;
RQCFG_100339_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(45),-1)));
RQCFG_100339_.old_tb3_3(45):=null;
RQCFG_100339_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(45),-1)));
RQCFG_100339_.old_tb3_4(45):=null;
RQCFG_100339_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(45),-1)));
RQCFG_100339_.tb3_5(45):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(45):=null;
RQCFG_100339_.tb3_6(45):=NULL;
RQCFG_100339_.old_tb3_7(45):=null;
RQCFG_100339_.tb3_7(45):=NULL;
RQCFG_100339_.old_tb3_8(45):=null;
RQCFG_100339_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(45),
RQCFG_100339_.tb3_1(45),
RQCFG_100339_.tb3_2(45),
RQCFG_100339_.tb3_3(45),
RQCFG_100339_.tb3_4(45),
RQCFG_100339_.tb3_5(45),
RQCFG_100339_.tb3_6(45),
RQCFG_100339_.tb3_7(45),
RQCFG_100339_.tb3_8(45),
null,
108293,
19,
'Servicio'
,
'N'
,
'Y'
,
'N'
,
19,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(45):=1440608;
RQCFG_100339_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(45):=RQCFG_100339_.tb5_0(45);
RQCFG_100339_.old_tb5_1(45):=39259;
RQCFG_100339_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(45),-1)));
RQCFG_100339_.old_tb5_2(45):=null;
RQCFG_100339_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(45),-1)));
RQCFG_100339_.tb5_3(45):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(45):=RQCFG_100339_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(45),
RQCFG_100339_.tb5_1(45),
RQCFG_100339_.tb5_2(45),
RQCFG_100339_.tb5_3(45),
RQCFG_100339_.tb5_4(45),
'Y'
,
'N'
,
19,
'N'
,
'Servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(46):=1128262;
RQCFG_100339_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(46):=RQCFG_100339_.tb3_0(46);
RQCFG_100339_.old_tb3_1(46):=2036;
RQCFG_100339_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(46),-1)));
RQCFG_100339_.old_tb3_2(46):=39298;
RQCFG_100339_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(46),-1)));
RQCFG_100339_.old_tb3_3(46):=null;
RQCFG_100339_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(46),-1)));
RQCFG_100339_.old_tb3_4(46):=null;
RQCFG_100339_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(46),-1)));
RQCFG_100339_.tb3_5(46):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(46):=null;
RQCFG_100339_.tb3_6(46):=NULL;
RQCFG_100339_.old_tb3_7(46):=null;
RQCFG_100339_.tb3_7(46):=NULL;
RQCFG_100339_.old_tb3_8(46):=null;
RQCFG_100339_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(46),
RQCFG_100339_.tb3_1(46),
RQCFG_100339_.tb3_2(46),
RQCFG_100339_.tb3_3(46),
RQCFG_100339_.tb3_4(46),
RQCFG_100339_.tb3_5(46),
RQCFG_100339_.tb3_6(46),
RQCFG_100339_.tb3_7(46),
RQCFG_100339_.tb3_8(46),
null,
108294,
20,
'Número de Servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(46):=1440609;
RQCFG_100339_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(46):=RQCFG_100339_.tb5_0(46);
RQCFG_100339_.old_tb5_1(46):=39298;
RQCFG_100339_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(46),-1)));
RQCFG_100339_.old_tb5_2(46):=null;
RQCFG_100339_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(46),-1)));
RQCFG_100339_.tb5_3(46):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(46):=RQCFG_100339_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(46),
RQCFG_100339_.tb5_1(46),
RQCFG_100339_.tb5_2(46),
RQCFG_100339_.tb5_3(46),
RQCFG_100339_.tb5_4(46),
'Y'
,
'N'
,
20,
'N'
,
'Número de Servicio'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(47):=1128263;
RQCFG_100339_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(47):=RQCFG_100339_.tb3_0(47);
RQCFG_100339_.old_tb3_1(47):=2036;
RQCFG_100339_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(47),-1)));
RQCFG_100339_.old_tb3_2(47):=6732;
RQCFG_100339_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(47),-1)));
RQCFG_100339_.old_tb3_3(47):=null;
RQCFG_100339_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(47),-1)));
RQCFG_100339_.old_tb3_4(47):=null;
RQCFG_100339_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(47),-1)));
RQCFG_100339_.tb3_5(47):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(47):=null;
RQCFG_100339_.tb3_6(47):=NULL;
RQCFG_100339_.old_tb3_7(47):=null;
RQCFG_100339_.tb3_7(47):=NULL;
RQCFG_100339_.old_tb3_8(47):=null;
RQCFG_100339_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(47),
RQCFG_100339_.tb3_1(47),
RQCFG_100339_.tb3_2(47),
RQCFG_100339_.tb3_3(47),
RQCFG_100339_.tb3_4(47),
RQCFG_100339_.tb3_5(47),
RQCFG_100339_.tb3_6(47),
RQCFG_100339_.tb3_7(47),
RQCFG_100339_.tb3_8(47),
null,
108295,
21,
'Enviar Eventos'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(47):=1440610;
RQCFG_100339_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(47):=RQCFG_100339_.tb5_0(47);
RQCFG_100339_.old_tb5_1(47):=6732;
RQCFG_100339_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(47),-1)));
RQCFG_100339_.old_tb5_2(47):=null;
RQCFG_100339_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(47),-1)));
RQCFG_100339_.tb5_3(47):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(47):=RQCFG_100339_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(47),
RQCFG_100339_.tb5_1(47),
RQCFG_100339_.tb5_2(47),
RQCFG_100339_.tb5_3(47),
RQCFG_100339_.tb5_4(47),
'Y'
,
'Y'
,
21,
'N'
,
'Enviar Eventos'
,
'N'
,
'N'
,
'U'
,
null,
131,
null,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(48):=1128264;
RQCFG_100339_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(48):=RQCFG_100339_.tb3_0(48);
RQCFG_100339_.old_tb3_1(48):=2036;
RQCFG_100339_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(48),-1)));
RQCFG_100339_.old_tb3_2(48):=260;
RQCFG_100339_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(48),-1)));
RQCFG_100339_.old_tb3_3(48):=null;
RQCFG_100339_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(48),-1)));
RQCFG_100339_.old_tb3_4(48):=null;
RQCFG_100339_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(48),-1)));
RQCFG_100339_.tb3_5(48):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(48):=null;
RQCFG_100339_.tb3_6(48):=NULL;
RQCFG_100339_.old_tb3_7(48):=null;
RQCFG_100339_.tb3_7(48):=NULL;
RQCFG_100339_.old_tb3_8(48):=null;
RQCFG_100339_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(48),
RQCFG_100339_.tb3_1(48),
RQCFG_100339_.tb3_2(48),
RQCFG_100339_.tb3_3(48),
RQCFG_100339_.tb3_4(48),
RQCFG_100339_.tb3_5(48),
RQCFG_100339_.tb3_6(48),
RQCFG_100339_.tb3_7(48),
RQCFG_100339_.tb3_8(48),
null,
108296,
22,
'Usuario'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(48):=1440611;
RQCFG_100339_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(48):=RQCFG_100339_.tb5_0(48);
RQCFG_100339_.old_tb5_1(48):=260;
RQCFG_100339_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(48),-1)));
RQCFG_100339_.old_tb5_2(48):=null;
RQCFG_100339_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(48),-1)));
RQCFG_100339_.tb5_3(48):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(48):=RQCFG_100339_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(48),
RQCFG_100339_.tb5_1(48),
RQCFG_100339_.tb5_2(48),
RQCFG_100339_.tb5_3(48),
RQCFG_100339_.tb5_4(48),
'C'
,
'Y'
,
22,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(49):=1128265;
RQCFG_100339_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(49):=RQCFG_100339_.tb3_0(49);
RQCFG_100339_.old_tb3_1(49):=2036;
RQCFG_100339_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(49),-1)));
RQCFG_100339_.old_tb3_2(49):=261;
RQCFG_100339_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(49),-1)));
RQCFG_100339_.old_tb3_3(49):=null;
RQCFG_100339_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(49),-1)));
RQCFG_100339_.old_tb3_4(49):=null;
RQCFG_100339_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(49),-1)));
RQCFG_100339_.tb3_5(49):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(49):=null;
RQCFG_100339_.tb3_6(49):=NULL;
RQCFG_100339_.old_tb3_7(49):=null;
RQCFG_100339_.tb3_7(49):=NULL;
RQCFG_100339_.old_tb3_8(49):=null;
RQCFG_100339_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(49),
RQCFG_100339_.tb3_1(49),
RQCFG_100339_.tb3_2(49),
RQCFG_100339_.tb3_3(49),
RQCFG_100339_.tb3_4(49),
RQCFG_100339_.tb3_5(49),
RQCFG_100339_.tb3_6(49),
RQCFG_100339_.tb3_7(49),
RQCFG_100339_.tb3_8(49),
null,
108297,
23,
'Terminal'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(49):=1440612;
RQCFG_100339_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(49):=RQCFG_100339_.tb5_0(49);
RQCFG_100339_.old_tb5_1(49):=261;
RQCFG_100339_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(49),-1)));
RQCFG_100339_.old_tb5_2(49):=null;
RQCFG_100339_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(49),-1)));
RQCFG_100339_.tb5_3(49):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(49):=RQCFG_100339_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(49),
RQCFG_100339_.tb5_1(49),
RQCFG_100339_.tb5_2(49),
RQCFG_100339_.tb5_3(49),
RQCFG_100339_.tb5_4(49),
'C'
,
'Y'
,
23,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(50):=1128266;
RQCFG_100339_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(50):=RQCFG_100339_.tb3_0(50);
RQCFG_100339_.old_tb3_1(50):=2036;
RQCFG_100339_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(50),-1)));
RQCFG_100339_.old_tb3_2(50):=1035;
RQCFG_100339_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(50),-1)));
RQCFG_100339_.old_tb3_3(50):=null;
RQCFG_100339_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(50),-1)));
RQCFG_100339_.old_tb3_4(50):=null;
RQCFG_100339_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(50),-1)));
RQCFG_100339_.tb3_5(50):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(50):=null;
RQCFG_100339_.tb3_6(50):=NULL;
RQCFG_100339_.old_tb3_7(50):=null;
RQCFG_100339_.tb3_7(50):=NULL;
RQCFG_100339_.old_tb3_8(50):=null;
RQCFG_100339_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(50),
RQCFG_100339_.tb3_1(50),
RQCFG_100339_.tb3_2(50),
RQCFG_100339_.tb3_3(50),
RQCFG_100339_.tb3_4(50),
RQCFG_100339_.tb3_5(50),
RQCFG_100339_.tb3_6(50),
RQCFG_100339_.tb3_7(50),
RQCFG_100339_.tb3_8(50),
null,
108298,
24,
'Dirección'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(50):=1440613;
RQCFG_100339_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(50):=RQCFG_100339_.tb5_0(50);
RQCFG_100339_.old_tb5_1(50):=1035;
RQCFG_100339_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(50),-1)));
RQCFG_100339_.old_tb5_2(50):=null;
RQCFG_100339_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(50),-1)));
RQCFG_100339_.tb5_3(50):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(50):=RQCFG_100339_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(50),
RQCFG_100339_.tb5_1(50),
RQCFG_100339_.tb5_2(50),
RQCFG_100339_.tb5_3(50),
RQCFG_100339_.tb5_4(50),
'C'
,
'Y'
,
24,
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
2,
null,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(51):=1128267;
RQCFG_100339_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(51):=RQCFG_100339_.tb3_0(51);
RQCFG_100339_.old_tb3_1(51):=2036;
RQCFG_100339_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(51),-1)));
RQCFG_100339_.old_tb3_2(51):=4015;
RQCFG_100339_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(51),-1)));
RQCFG_100339_.old_tb3_3(51):=null;
RQCFG_100339_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(51),-1)));
RQCFG_100339_.old_tb3_4(51):=null;
RQCFG_100339_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(51),-1)));
RQCFG_100339_.tb3_5(51):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(51):=null;
RQCFG_100339_.tb3_6(51):=NULL;
RQCFG_100339_.old_tb3_7(51):=null;
RQCFG_100339_.tb3_7(51):=NULL;
RQCFG_100339_.old_tb3_8(51):=null;
RQCFG_100339_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(51),
RQCFG_100339_.tb3_1(51),
RQCFG_100339_.tb3_2(51),
RQCFG_100339_.tb3_3(51),
RQCFG_100339_.tb3_4(51),
RQCFG_100339_.tb3_5(51),
RQCFG_100339_.tb3_6(51),
RQCFG_100339_.tb3_7(51),
RQCFG_100339_.tb3_8(51),
null,
108299,
25,
'Identificador del Cliente'
,
'N'
,
'Y'
,
'N'
,
25,
null,
null);

exception when others then
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(51):=1440614;
RQCFG_100339_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(51):=RQCFG_100339_.tb5_0(51);
RQCFG_100339_.old_tb5_1(51):=4015;
RQCFG_100339_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(51),-1)));
RQCFG_100339_.old_tb5_2(51):=null;
RQCFG_100339_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(51),-1)));
RQCFG_100339_.tb5_3(51):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(51):=RQCFG_100339_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(51),
RQCFG_100339_.tb5_1(51),
RQCFG_100339_.tb5_2(51),
RQCFG_100339_.tb5_3(51),
RQCFG_100339_.tb5_4(51),
'Y'
,
'Y'
,
25,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(52):=1128268;
RQCFG_100339_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(52):=RQCFG_100339_.tb3_0(52);
RQCFG_100339_.old_tb3_1(52):=2036;
RQCFG_100339_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(52),-1)));
RQCFG_100339_.old_tb3_2(52):=257;
RQCFG_100339_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(52),-1)));
RQCFG_100339_.old_tb3_3(52):=null;
RQCFG_100339_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(52),-1)));
RQCFG_100339_.old_tb3_4(52):=null;
RQCFG_100339_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(52),-1)));
RQCFG_100339_.tb3_5(52):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(52):=121269256;
RQCFG_100339_.tb3_6(52):=NULL;
RQCFG_100339_.old_tb3_7(52):=null;
RQCFG_100339_.tb3_7(52):=NULL;
RQCFG_100339_.old_tb3_8(52):=null;
RQCFG_100339_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(52),
RQCFG_100339_.tb3_1(52),
RQCFG_100339_.tb3_2(52),
RQCFG_100339_.tb3_3(52),
RQCFG_100339_.tb3_4(52),
RQCFG_100339_.tb3_5(52),
RQCFG_100339_.tb3_6(52),
RQCFG_100339_.tb3_7(52),
RQCFG_100339_.tb3_8(52),
null,
108274,
0,
'Interacción'
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(52):=1440615;
RQCFG_100339_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(52):=RQCFG_100339_.tb5_0(52);
RQCFG_100339_.old_tb5_1(52):=257;
RQCFG_100339_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(52),-1)));
RQCFG_100339_.old_tb5_2(52):=null;
RQCFG_100339_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(52),-1)));
RQCFG_100339_.tb5_3(52):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(52):=RQCFG_100339_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(52),
RQCFG_100339_.tb5_1(52),
RQCFG_100339_.tb5_2(52),
RQCFG_100339_.tb5_3(52),
RQCFG_100339_.tb5_4(52),
'Y'
,
'E'
,
0,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb3_0(53):=1128269;
RQCFG_100339_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100339_.tb3_0(53):=RQCFG_100339_.tb3_0(53);
RQCFG_100339_.old_tb3_1(53):=2036;
RQCFG_100339_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100339_.TBENTITYNAME(NVL(RQCFG_100339_.old_tb3_1(53),-1)));
RQCFG_100339_.old_tb3_2(53):=258;
RQCFG_100339_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_2(53),-1)));
RQCFG_100339_.old_tb3_3(53):=null;
RQCFG_100339_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_3(53),-1)));
RQCFG_100339_.old_tb3_4(53):=null;
RQCFG_100339_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb3_4(53),-1)));
RQCFG_100339_.tb3_5(53):=RQCFG_100339_.tb2_2(0);
RQCFG_100339_.old_tb3_6(53):=121269257;
RQCFG_100339_.tb3_6(53):=NULL;
RQCFG_100339_.old_tb3_7(53):=121269258;
RQCFG_100339_.tb3_7(53):=NULL;
RQCFG_100339_.old_tb3_8(53):=null;
RQCFG_100339_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100339_.tb3_0(53),
RQCFG_100339_.tb3_1(53),
RQCFG_100339_.tb3_2(53),
RQCFG_100339_.tb3_3(53),
RQCFG_100339_.tb3_4(53),
RQCFG_100339_.tb3_5(53),
RQCFG_100339_.tb3_6(53),
RQCFG_100339_.tb3_7(53),
RQCFG_100339_.tb3_8(53),
null,
108275,
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100339_.blProcessStatus) then
 return;
end if;

RQCFG_100339_.old_tb5_0(53):=1440616;
RQCFG_100339_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100339_.tb5_0(53):=RQCFG_100339_.tb5_0(53);
RQCFG_100339_.old_tb5_1(53):=258;
RQCFG_100339_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_1(53),-1)));
RQCFG_100339_.old_tb5_2(53):=null;
RQCFG_100339_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100339_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100339_.old_tb5_2(53),-1)));
RQCFG_100339_.tb5_3(53):=RQCFG_100339_.tb4_0(1);
RQCFG_100339_.tb5_4(53):=RQCFG_100339_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100339_.tb5_0(53),
RQCFG_100339_.tb5_1(53),
RQCFG_100339_.tb5_2(53),
RQCFG_100339_.tb5_3(53),
RQCFG_100339_.tb5_4(53),
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
RQCFG_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100339);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100339)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100339_.blProcessStatus) then
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
AND     external_root_id = 100339
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
AND     external_root_id = 100339
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
AND     external_root_id = 100339
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100339, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100339)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100339, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100339)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100339, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100339)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100339, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100339)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100339_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100339_.tbCompositions.FIRST..RQCFG_100339_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100339_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100339_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100339_.blProcessStatus := false;
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
 nuIndex := RQCFG_100339_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100339_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100339_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100339_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100339_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100339_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100339_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100339_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100339_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100339_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100339_',
'CREATE OR REPLACE PACKAGE I18N_R_100339_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100339_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100339_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100339
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
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
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(0):='M_DANO_A_PRODUCTO_100325'
;
I18N_R_100339_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(0),
I18N_R_100339_.tb0_1(0),
'WE8ISO8859P1'
,
'Daño a Producto'
,
'Daño a Producto'
,
null,
'Daño a Producto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(1):='M_DANO_A_PRODUCTO_100325'
;
I18N_R_100339_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(1),
I18N_R_100339_.tb0_1(1),
'WE8ISO8859P1'
,
'Daño a Producto'
,
'Daño a Producto'
,
null,
'Daño a Producto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(2):='M_DANO_A_PRODUCTO_100325'
;
I18N_R_100339_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(2),
I18N_R_100339_.tb0_1(2),
'WE8ISO8859P1'
,
'Daño a Producto'
,
'Daño a Producto'
,
null,
'Daño a Producto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(3):='PAQUETE'
;
I18N_R_100339_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(3),
I18N_R_100339_.tb0_1(3),
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
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(4):='PAQUETE'
;
I18N_R_100339_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(4),
I18N_R_100339_.tb0_1(4),
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
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(5):='PAQUETE'
;
I18N_R_100339_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(5),
I18N_R_100339_.tb0_1(5),
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
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100339_.blProcessStatus) then
 return;
end if;

I18N_R_100339_.tb0_0(6):='PAQUETE'
;
I18N_R_100339_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100339_.tb0_0(6),
I18N_R_100339_.tb0_1(6),
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
I18N_R_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100339_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100339_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100339_',
'CREATE OR REPLACE PACKAGE RQEXEC_100339_ IS ' || chr(10) ||
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
'END RQEXEC_100339_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100339_******************************'); END;
/


BEGIN

if (not RQEXEC_100339_.blProcessStatus) then
 return;
end if;

RQEXEC_100339_.old_tb0_0(0):='P_REGISTRO_DE_DANO_A_PRODUCTO_POR_XML_100339'
;
RQEXEC_100339_.tb0_0(0):=UPPER(RQEXEC_100339_.old_tb0_0(0));
RQEXEC_100339_.old_tb0_1(0):=500000000012780;
RQEXEC_100339_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100339_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100339_.tb0_1(0):=RQEXEC_100339_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100339_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100339_.tb0_1(0),
DESCRIPTION='Registro de Daño a Producto por XML'
,
PATH=null,
VERSION='33'
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
EXEC_OWNER='C',
LAST_DATE_EXECUTED=null,
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100339_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100339_.tb0_0(0),
RQEXEC_100339_.tb0_1(0),
'Registro de Daño a Producto por XML'
,
null,
'33'
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
'C',
null,
null);
end if;

exception when others then
RQEXEC_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100339_.blProcessStatus) then
 return;
end if;

RQEXEC_100339_.tb1_0(0):=1;
RQEXEC_100339_.tb1_1(0):=RQEXEC_100339_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100339_.tb1_0(0),
RQEXEC_100339_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100339_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100339_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100339_******************************'); end;
/

