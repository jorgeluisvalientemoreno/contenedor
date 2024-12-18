BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100219_',
'CREATE OR REPLACE PACKAGE RQTY_100219_ IS ' || chr(10) ||
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
'tb7_0 ty7_0;type ty8_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty10_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb10_3 ty10_3; ' || chr(10) ||
'tb10_3 ty10_3;type ty11_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty12_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty12_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_2 ty12_2; ' || chr(10) ||
'tb12_2 ty12_2;type ty12_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_3 ty12_3; ' || chr(10) ||
'tb12_3 ty12_3;type ty13_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty13_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_1 ty13_1; ' || chr(10) ||
'tb13_1 ty13_1;type ty13_3 is table of PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_3 ty13_3; ' || chr(10) ||
'tb13_3 ty13_3;--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM ' || chr(10) ||
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100219 ' || chr(10) ||
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
'END RQTY_100219_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100219_******************************'); END;
/

BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
AND     external_root_id = 100219
)
);

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100219_.cuExpressions;
fetch RQTY_100219_.cuExpressions bulk collect INTO RQTY_100219_.tbExpressionsId;
close RQTY_100219_.cuExpressions;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100219_.tbEntityName(-1) := 'NULL';
   RQTY_100219_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQTY_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100219_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100219_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQTY_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQTY_100219_.tbEntityAttributeName(106099) := 'MO_PACKAGES_ASSO@PACKAGES_ASSO_ID';
   RQTY_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQTY_100219_.tbEntityAttributeName(127931) := 'MO_PACKAGES_ASSO@ANNUL_DEPENDENT';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQTY_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100219_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQTY_100219_.tbEntityAttributeName(39946) := 'MO_PACKAGES_ASSO@PACKAGE_ID_ASSO';
   RQTY_100219_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   RQTY_100219_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(282) := 'MO_ADDRESS@ADDRESS';
   RQTY_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100219_.tbEntityAttributeName(475) := 'MO_ADDRESS@GEOGRAP_LOCATION_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQTY_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQTY_100219_.tbEntityAttributeName(39945) := 'MO_PACKAGES_ASSO@PACKAGE_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100219_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100219
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100219
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100219
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100219
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100219_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100219_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100219_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100219_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100219_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100219_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100219_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219))));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219))));

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100219_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100219_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100219_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100219_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100219_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100219_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100219_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100219_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219)));

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219));
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100219_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219);
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100219_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100219_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100219_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100219_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100219;
nuIndex binary_integer;
BEGIN

if (not RQTY_100219_.blProcessStatus) then
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100219_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100219_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100219_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100219_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100219_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100219_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100219_.tb0_0(0),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb1_0(0):=1;
RQTY_100219_.tb1_1(0):=RQTY_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100219_.tb1_0(0),
MODULE_ID=RQTY_100219_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100219_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100219_.tb1_0(0),
RQTY_100219_.tb1_1(0),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(0):=121057120;
RQTY_100219_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(0):=RQTY_100219_.tb2_0(0);
RQTY_100219_.old_tb2_1(0):='GE_EXEACTION_CT1E121057120'
;
RQTY_100219_.tb2_1(0):=RQTY_100219_.tb2_0(0);
RQTY_100219_.tb2_2(0):=RQTY_100219_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(0),
RQTY_100219_.tb2_1(0),
RQTY_100219_.tb2_2(0),
'Sbpack = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();nupack = UT_CONVERT.FNUCHARTONUMBER(Sbpack);PR_BOCREATIONPRODUCT.INITIALCREATIONPRODUCT(nupack)'
,
'OPEN'
,
to_date('30-04-2013 18:02:51','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Creación producto Brilla'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb3_0(0):=8191;
RQTY_100219_.tb3_1(0):=RQTY_100219_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100219_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100219_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='LDC - Creación producto brilla'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100219_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100219_.tb3_0(0),
RQTY_100219_.tb3_1(0),
5,
'LDC - Creación producto brilla'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb4_0(0):=RQTY_100219_.tb3_0(0);
RQTY_100219_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100219_.tb4_0(0),
VALID_MODULE_ID=RQTY_100219_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100219_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100219_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100219_.tb4_0(0),
RQTY_100219_.tb4_1(0));
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb4_0(1):=RQTY_100219_.tb3_0(0);
RQTY_100219_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100219_.tb4_0(1),
VALID_MODULE_ID=RQTY_100219_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100219_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100219_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100219_.tb4_0(1),
RQTY_100219_.tb4_1(1));
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb4_0(2):=RQTY_100219_.tb3_0(0);
RQTY_100219_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100219_.tb4_0(2),
VALID_MODULE_ID=RQTY_100219_.tb4_1(2)
 WHERE ACTION_ID = RQTY_100219_.tb4_0(2) AND VALID_MODULE_ID = RQTY_100219_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100219_.tb4_0(2),
RQTY_100219_.tb4_1(2));
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb5_0(0):=100219;
RQTY_100219_.tb5_1(0):=RQTY_100219_.tb3_0(0);
RQTY_100219_.tb5_4(0):='P_VENTA_SERVICIOS_FINANCIEROS_100219'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100219_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100219_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100219_.tb5_4(0),
DESCRIPTION='Venta Servicios Financieros'
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
ANSWER_REQUIRED='N'
,
LIQUIDATION_METHOD=2
 WHERE PACKAGE_TYPE_ID = RQTY_100219_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100219_.tb5_0(0),
RQTY_100219_.tb5_1(0),
null,
null,
RQTY_100219_.tb5_4(0),
'Venta Servicios Financieros'
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
'N'
,
2);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(0):=105528;
RQTY_100219_.tb6_1(0):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(0):=17;
RQTY_100219_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(0),-1)));
RQTY_100219_.old_tb6_3(0):=42118;
RQTY_100219_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(0),-1)));
RQTY_100219_.old_tb6_4(0):=109479;
RQTY_100219_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(0),-1)));
RQTY_100219_.old_tb6_5(0):=null;
RQTY_100219_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(0),
ENTITY_ID=RQTY_100219_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(0),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(0),
RQTY_100219_.tb6_1(0),
RQTY_100219_.tb6_2(0),
RQTY_100219_.tb6_3(0),
RQTY_100219_.tb6_4(0),
RQTY_100219_.tb6_5(0),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100219_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100219_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100219_.tb0_0(1),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb1_0(1):=23;
RQTY_100219_.tb1_1(1):=RQTY_100219_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100219_.tb1_0(1),
MODULE_ID=RQTY_100219_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100219_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100219_.tb1_0(1),
RQTY_100219_.tb1_1(1),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(1):=121057121;
RQTY_100219_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(1):=RQTY_100219_.tb2_0(1);
RQTY_100219_.old_tb2_1(1):='MO_INITATRIB_CT23E121057121'
;
RQTY_100219_.tb2_1(1):=RQTY_100219_.tb2_0(1);
RQTY_100219_.tb2_2(1):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(1),
RQTY_100219_.tb2_1(1),
RQTY_100219_.tb2_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'OPEN'
,
to_date('01-05-2013 11:04:55','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(1):=105535;
RQTY_100219_.tb6_1(1):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(1):=17;
RQTY_100219_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(1),-1)));
RQTY_100219_.old_tb6_3(1):=259;
RQTY_100219_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(1),-1)));
RQTY_100219_.old_tb6_4(1):=null;
RQTY_100219_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(1),-1)));
RQTY_100219_.old_tb6_5(1):=null;
RQTY_100219_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(1),-1)));
RQTY_100219_.tb6_7(1):=RQTY_100219_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(1),
ENTITY_ID=RQTY_100219_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(1),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(1),
RQTY_100219_.tb6_1(1),
RQTY_100219_.tb6_2(1),
RQTY_100219_.tb6_3(1),
RQTY_100219_.tb6_4(1),
RQTY_100219_.tb6_5(1),
null,
RQTY_100219_.tb6_7(1),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(2):=105536;
RQTY_100219_.tb6_1(2):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(2):=17;
RQTY_100219_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(2),-1)));
RQTY_100219_.old_tb6_3(2):=11619;
RQTY_100219_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(2),-1)));
RQTY_100219_.old_tb6_4(2):=null;
RQTY_100219_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(2),-1)));
RQTY_100219_.old_tb6_5(2):=null;
RQTY_100219_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(2),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(2),
ENTITY_ID=RQTY_100219_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(2),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(2),
RQTY_100219_.tb6_1(2),
RQTY_100219_.tb6_2(2),
RQTY_100219_.tb6_3(2),
RQTY_100219_.tb6_4(2),
RQTY_100219_.tb6_5(2),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(3):=105537;
RQTY_100219_.tb6_1(3):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(3):=17;
RQTY_100219_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(3),-1)));
RQTY_100219_.old_tb6_3(3):=4015;
RQTY_100219_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(3),-1)));
RQTY_100219_.old_tb6_4(3):=793;
RQTY_100219_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(3),-1)));
RQTY_100219_.old_tb6_5(3):=null;
RQTY_100219_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(3),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(3),
ENTITY_ID=RQTY_100219_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(3),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(3),
RQTY_100219_.tb6_1(3),
RQTY_100219_.tb6_2(3),
RQTY_100219_.tb6_3(3),
RQTY_100219_.tb6_4(3),
RQTY_100219_.tb6_5(3),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(2):=121057122;
RQTY_100219_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(2):=RQTY_100219_.tb2_0(2);
RQTY_100219_.old_tb2_1(2):='MO_INITATRIB_CT23E121057122'
;
RQTY_100219_.tb2_1(2):=RQTY_100219_.tb2_0(2);
RQTY_100219_.tb2_2(2):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(2),
RQTY_100219_.tb2_1(2),
RQTY_100219_.tb2_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("1")'
,
'OPEN'
,
to_date('01-05-2013 11:04:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(4):=105626;
RQTY_100219_.tb6_1(4):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(4):=21;
RQTY_100219_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(4),-1)));
RQTY_100219_.old_tb6_3(4):=476;
RQTY_100219_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(4),-1)));
RQTY_100219_.old_tb6_4(4):=null;
RQTY_100219_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(4),-1)));
RQTY_100219_.old_tb6_5(4):=null;
RQTY_100219_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(4),-1)));
RQTY_100219_.tb6_7(4):=RQTY_100219_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(4),
ENTITY_ID=RQTY_100219_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(4),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(4),
RQTY_100219_.tb6_1(4),
RQTY_100219_.tb6_2(4),
RQTY_100219_.tb6_3(4),
RQTY_100219_.tb6_4(4),
RQTY_100219_.tb6_5(4),
null,
RQTY_100219_.tb6_7(4),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(3):=121057123;
RQTY_100219_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(3):=RQTY_100219_.tb2_0(3);
RQTY_100219_.old_tb2_1(3):='MO_INITATRIB_CT23E121057123'
;
RQTY_100219_.tb2_1(3):=RQTY_100219_.tb2_0(3);
RQTY_100219_.tb2_2(3):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(3),
RQTY_100219_.tb2_1(3),
RQTY_100219_.tb2_2(3),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSusc);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSusc)'
,
'OPEN'
,
to_date('01-05-2013 11:04:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACK SUSC'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(5):=105627;
RQTY_100219_.tb6_1(5):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(5):=17;
RQTY_100219_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(5),-1)));
RQTY_100219_.old_tb6_3(5):=11621;
RQTY_100219_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(5),-1)));
RQTY_100219_.old_tb6_4(5):=null;
RQTY_100219_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(5),-1)));
RQTY_100219_.old_tb6_5(5):=null;
RQTY_100219_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(5),-1)));
RQTY_100219_.tb6_7(5):=RQTY_100219_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(5),
ENTITY_ID=RQTY_100219_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Contrato pendiente'
,
DISPLAY_ORDER=23,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='CONTRATO_PENDIENTE'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(5),
RQTY_100219_.tb6_1(5),
RQTY_100219_.tb6_2(5),
RQTY_100219_.tb6_3(5),
RQTY_100219_.tb6_4(5),
RQTY_100219_.tb6_5(5),
null,
RQTY_100219_.tb6_7(5),
null,
null,
23,
'Contrato pendiente'
,
23,
'N'
,
'N'
,
'N'
,
'CONTRATO_PENDIENTE'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(4):=121057124;
RQTY_100219_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(4):=RQTY_100219_.tb2_0(4);
RQTY_100219_.old_tb2_1(4):='MO_INITATRIB_CT23E121057124'
;
RQTY_100219_.tb2_1(4):=RQTY_100219_.tb2_0(4);
RQTY_100219_.tb2_2(4):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(4),
RQTY_100219_.tb2_1(4),
RQTY_100219_.tb2_2(4),
'nuSeq = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_ADDRESS", "SEQ_MO_ADDRESS");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSeq)'
,
'OPEN'
,
to_date('01-05-2013 11:04:55','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(6):=105538;
RQTY_100219_.tb6_1(6):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(6):=21;
RQTY_100219_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(6),-1)));
RQTY_100219_.old_tb6_3(6):=474;
RQTY_100219_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(6),-1)));
RQTY_100219_.old_tb6_4(6):=null;
RQTY_100219_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(6),-1)));
RQTY_100219_.old_tb6_5(6):=null;
RQTY_100219_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(6),-1)));
RQTY_100219_.tb6_7(6):=RQTY_100219_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(6),
ENTITY_ID=RQTY_100219_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='C¿digo de la Direcci¿n'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
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
ENTITY_NAME='MO_ADDRESS'
,
ATTRI_TECHNICAL_NAME='ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(6),
RQTY_100219_.tb6_1(6),
RQTY_100219_.tb6_2(6),
RQTY_100219_.tb6_3(6),
RQTY_100219_.tb6_4(6),
RQTY_100219_.tb6_5(6),
null,
RQTY_100219_.tb6_7(6),
null,
null,
16,
'C¿digo de la Direcci¿n'
,
16,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(5):=121057125;
RQTY_100219_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(5):=RQTY_100219_.tb2_0(5);
RQTY_100219_.old_tb2_1(5):='MO_INITATRIB_CT23E121057125'
;
RQTY_100219_.tb2_1(5):=RQTY_100219_.tb2_0(5);
RQTY_100219_.tb2_2(5):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(5),
RQTY_100219_.tb2_1(5),
RQTY_100219_.tb2_2(5),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSuscripc);nuSusc = UT_CONVERT.FNUCHARTONUMBER(nuSuscripc);CC_BOSUSCRIPTIONDATA.GETADDRESSBYID(nuSusc,onuAddressId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuAddressId)'
,
'OPEN'
,
to_date('01-05-2013 11:04:55','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:25','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Direccion y ubicaciÓn geografica del contrato Serv Financieros'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(7):=105539;
RQTY_100219_.tb6_1(7):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(7):=21;
RQTY_100219_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(7),-1)));
RQTY_100219_.old_tb6_3(7):=11376;
RQTY_100219_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(7),-1)));
RQTY_100219_.old_tb6_4(7):=null;
RQTY_100219_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(7),-1)));
RQTY_100219_.old_tb6_5(7):=null;
RQTY_100219_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(7),-1)));
RQTY_100219_.tb6_7(7):=RQTY_100219_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(7),
ENTITY_ID=RQTY_100219_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Direccion de instalaci¿n'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(7),
RQTY_100219_.tb6_1(7),
RQTY_100219_.tb6_2(7),
RQTY_100219_.tb6_3(7),
RQTY_100219_.tb6_4(7),
RQTY_100219_.tb6_5(7),
null,
RQTY_100219_.tb6_7(7),
null,
null,
17,
'Direccion de instalaci¿n'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(6):=121057126;
RQTY_100219_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(6):=RQTY_100219_.tb2_0(6);
RQTY_100219_.old_tb2_1(6):='MO_INITATRIB_CT23E121057126'
;
RQTY_100219_.tb2_1(6):=RQTY_100219_.tb2_0(6);
RQTY_100219_.tb2_2(6):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(6),
RQTY_100219_.tb2_1(6),
RQTY_100219_.tb2_2(6),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSusc);LD_BOSECUREMANAGEMENT.GETADDRESS(nuSusc,onuValue);if (onuValue <> NULL,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuValue);,CC_BOSUSCRIPTIONDATA.GETADDRESSBYID(nuSusc,nuAddressId);LD_BOFLOWFNBPACK.GETPARSEDADDRBYID(nuAddressId,osbAddress,osbGeoLoc);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(osbAddress);)'
,
'OPEN'
,
to_date('01-05-2013 11:04:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicialización dirección Parseada del Contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(8):=105542;
RQTY_100219_.tb6_1(8):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(8):=21;
RQTY_100219_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(8),-1)));
RQTY_100219_.old_tb6_3(8):=282;
RQTY_100219_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(8),-1)));
RQTY_100219_.old_tb6_4(8):=null;
RQTY_100219_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(8),-1)));
RQTY_100219_.old_tb6_5(8):=null;
RQTY_100219_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(8),-1)));
RQTY_100219_.tb6_7(8):=RQTY_100219_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(8),
ENTITY_ID=RQTY_100219_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Direcci¿n'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(8),
RQTY_100219_.tb6_1(8),
RQTY_100219_.tb6_2(8),
RQTY_100219_.tb6_3(8),
RQTY_100219_.tb6_4(8),
RQTY_100219_.tb6_5(8),
null,
RQTY_100219_.tb6_7(8),
null,
null,
18,
'Direcci¿n'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(7):=121057127;
RQTY_100219_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(7):=RQTY_100219_.tb2_0(7);
RQTY_100219_.old_tb2_1(7):='MO_INITATRIB_CT23E121057127'
;
RQTY_100219_.tb2_1(7):=RQTY_100219_.tb2_0(7);
RQTY_100219_.tb2_2(7):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(7),
RQTY_100219_.tb2_1(7),
RQTY_100219_.tb2_2(7),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSuscripc);nuSusc = UT_CONVERT.FNUCHARTONUMBER(nuSuscripc);LD_BOSECUREMANAGEMENT.GETADDRESSBYSUSC(nuSusc,onuAdd,onuGeo);if (onuGeo <> NULL,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuGeo);,CC_BOSUSCRIPTIONDATA.GETADDRESSBYID(nuSusc,nuAddressId);LD_BOFLOWFNBPACK.GETPARSEDADDRBYID(nuAddressId,onuAddr,onuGeoLoc);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuGeoLoc);)'
,
'OPEN'
,
to_date('01-05-2013 11:04:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicialización Ubicación Geográfica del Contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(9):=105588;
RQTY_100219_.tb6_1(9):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(9):=21;
RQTY_100219_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(9),-1)));
RQTY_100219_.old_tb6_3(9):=475;
RQTY_100219_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(9),-1)));
RQTY_100219_.old_tb6_4(9):=null;
RQTY_100219_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(9),-1)));
RQTY_100219_.old_tb6_5(9):=null;
RQTY_100219_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(9),-1)));
RQTY_100219_.tb6_7(9):=RQTY_100219_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(9),
ENTITY_ID=RQTY_100219_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Código de la Ubicación Geográfica'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(9),
RQTY_100219_.tb6_1(9),
RQTY_100219_.tb6_2(9),
RQTY_100219_.tb6_3(9),
RQTY_100219_.tb6_4(9),
RQTY_100219_.tb6_5(9),
null,
RQTY_100219_.tb6_7(9),
null,
null,
19,
'Código de la Ubicación Geográfica'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(8):=121057128;
RQTY_100219_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(8):=RQTY_100219_.tb2_0(8);
RQTY_100219_.old_tb2_1(8):='MO_INITATRIB_CT23E121057128'
;
RQTY_100219_.tb2_1(8):=RQTY_100219_.tb2_0(8);
RQTY_100219_.tb2_2(8):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(8),
RQTY_100219_.tb2_1(8),
RQTY_100219_.tb2_2(8),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'OPEN'
,
to_date('01-05-2013 11:04:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(10):=105592;
RQTY_100219_.tb6_1(10):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(10):=21;
RQTY_100219_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(10),-1)));
RQTY_100219_.old_tb6_3(10):=2;
RQTY_100219_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(10),-1)));
RQTY_100219_.old_tb6_4(10):=null;
RQTY_100219_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(10),-1)));
RQTY_100219_.old_tb6_5(10):=null;
RQTY_100219_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(10),-1)));
RQTY_100219_.tb6_7(10):=RQTY_100219_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(10),
ENTITY_ID=RQTY_100219_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(10),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(10),
RQTY_100219_.tb6_1(10),
RQTY_100219_.tb6_2(10),
RQTY_100219_.tb6_3(10),
RQTY_100219_.tb6_4(10),
RQTY_100219_.tb6_5(10),
null,
RQTY_100219_.tb6_7(10),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(11):=105619;
RQTY_100219_.tb6_1(11):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(11):=21;
RQTY_100219_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(11),-1)));
RQTY_100219_.old_tb6_3(11):=39322;
RQTY_100219_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(11),-1)));
RQTY_100219_.old_tb6_4(11):=255;
RQTY_100219_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(11),-1)));
RQTY_100219_.old_tb6_5(11):=null;
RQTY_100219_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(11),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(11),
ENTITY_ID=RQTY_100219_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(11),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(11),
RQTY_100219_.tb6_1(11),
RQTY_100219_.tb6_2(11),
RQTY_100219_.tb6_3(11),
RQTY_100219_.tb6_4(11),
RQTY_100219_.tb6_5(11),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(9):=121057129;
RQTY_100219_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(9):=RQTY_100219_.tb2_0(9);
RQTY_100219_.old_tb2_1(9):='MO_INITATRIB_CT23E121057129'
;
RQTY_100219_.tb2_1(9):=RQTY_100219_.tb2_0(9);
RQTY_100219_.tb2_2(9):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(9),
RQTY_100219_.tb2_1(9),
RQTY_100219_.tb2_2(9),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbSusc);nuSuscr = UT_CONVERT.FNUCHARTONUMBER(sbSusc);LD_BOFLOWFNBPACK.GETCATSUBBYSUSCRIPC(nuSuscr,nuCategory,nuSubcateg);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuCategory)'
,
'OPEN'
,
to_date('01-05-2013 11:04:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicialización de categoría del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb7_0(0):=120029760;
RQTY_100219_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100219_.tb7_0(0):=RQTY_100219_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100219_.tb7_0(0),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(12):=105629;
RQTY_100219_.tb6_1(12):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(12):=68;
RQTY_100219_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(12),-1)));
RQTY_100219_.old_tb6_3(12):=440;
RQTY_100219_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(12),-1)));
RQTY_100219_.old_tb6_4(12):=null;
RQTY_100219_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(12),-1)));
RQTY_100219_.old_tb6_5(12):=null;
RQTY_100219_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(12),-1)));
RQTY_100219_.tb6_6(12):=RQTY_100219_.tb7_0(0);
RQTY_100219_.tb6_7(12):=RQTY_100219_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(12),
ENTITY_ID=RQTY_100219_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(12),
STATEMENT_ID=RQTY_100219_.tb6_6(12),
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(12),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Categoria'
,
DISPLAY_ORDER=24,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(12),
RQTY_100219_.tb6_1(12),
RQTY_100219_.tb6_2(12),
RQTY_100219_.tb6_3(12),
RQTY_100219_.tb6_4(12),
RQTY_100219_.tb6_5(12),
RQTY_100219_.tb6_6(12),
RQTY_100219_.tb6_7(12),
null,
null,
24,
'Categoria'
,
24,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(13):=105632;
RQTY_100219_.tb6_1(13):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(13):=1313;
RQTY_100219_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(13),-1)));
RQTY_100219_.old_tb6_3(13):=39946;
RQTY_100219_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(13),-1)));
RQTY_100219_.old_tb6_4(13):=255;
RQTY_100219_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(13),-1)));
RQTY_100219_.old_tb6_5(13):=null;
RQTY_100219_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(13),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(13),
ENTITY_ID=RQTY_100219_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=27,
DISPLAY_NAME='Código del Paquete Asociado'
,
DISPLAY_ORDER=27,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PACKAGE_ID_ASSO'
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
ENTITY_NAME='MO_PACKAGES_ASSO'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID_ASSO'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(13),
RQTY_100219_.tb6_1(13),
RQTY_100219_.tb6_2(13),
RQTY_100219_.tb6_3(13),
RQTY_100219_.tb6_4(13),
RQTY_100219_.tb6_5(13),
null,
null,
null,
null,
27,
'Código del Paquete Asociado'
,
27,
'N'
,
'N'
,
'N'
,
'PACKAGE_ID_ASSO'
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
'MO_PACKAGES_ASSO'
,
'PACKAGE_ID_ASSO'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(10):=121057130;
RQTY_100219_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(10):=RQTY_100219_.tb2_0(10);
RQTY_100219_.old_tb2_1(10):='MO_INITATRIB_CT23E121057130'
;
RQTY_100219_.tb2_1(10):=RQTY_100219_.tb2_0(10);
RQTY_100219_.tb2_2(10):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(10),
RQTY_100219_.tb2_1(10),
RQTY_100219_.tb2_2(10),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("N")'
,
'OPEN'
,
to_date('01-05-2013 11:07:20','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Campo en No'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(14):=105633;
RQTY_100219_.tb6_1(14):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(14):=1313;
RQTY_100219_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(14),-1)));
RQTY_100219_.old_tb6_3(14):=127931;
RQTY_100219_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(14),-1)));
RQTY_100219_.old_tb6_4(14):=null;
RQTY_100219_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(14),-1)));
RQTY_100219_.old_tb6_5(14):=null;
RQTY_100219_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(14),-1)));
RQTY_100219_.tb6_7(14):=RQTY_100219_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(14),
ENTITY_ID=RQTY_100219_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=28,
DISPLAY_NAME='Indica si existe dependencia en anulación'
,
DISPLAY_ORDER=28,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ANNUL_DEPENDENT'
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
ENTITY_NAME='MO_PACKAGES_ASSO'
,
ATTRI_TECHNICAL_NAME='ANNUL_DEPENDENT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(14),
RQTY_100219_.tb6_1(14),
RQTY_100219_.tb6_2(14),
RQTY_100219_.tb6_3(14),
RQTY_100219_.tb6_4(14),
RQTY_100219_.tb6_5(14),
null,
RQTY_100219_.tb6_7(14),
null,
null,
28,
'Indica si existe dependencia en anulación'
,
28,
'N'
,
'N'
,
'N'
,
'ANNUL_DEPENDENT'
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
'MO_PACKAGES_ASSO'
,
'ANNUL_DEPENDENT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(15):=105636;
RQTY_100219_.tb6_1(15):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(15):=68;
RQTY_100219_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(15),-1)));
RQTY_100219_.old_tb6_3(15):=1111;
RQTY_100219_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(15),-1)));
RQTY_100219_.old_tb6_4(15):=null;
RQTY_100219_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(15),-1)));
RQTY_100219_.old_tb6_5(15):=null;
RQTY_100219_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(15),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(15),
ENTITY_ID=RQTY_100219_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(15),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(15),
RQTY_100219_.tb6_1(15),
RQTY_100219_.tb6_2(15),
RQTY_100219_.tb6_3(15),
RQTY_100219_.tb6_4(15),
RQTY_100219_.tb6_5(15),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(11):=121057131;
RQTY_100219_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(11):=RQTY_100219_.tb2_0(11);
RQTY_100219_.old_tb2_1(11):='MO_INITATRIB_CT23E121057131'
;
RQTY_100219_.tb2_1(11):=RQTY_100219_.tb2_0(11);
RQTY_100219_.tb2_2(11):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(11),
RQTY_100219_.tb2_1(11),
RQTY_100219_.tb2_2(11),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETSEQ_MO_PACKAGES_ASSO())'
,
'OPEN'
,
to_date('01-05-2013 17:14:28','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI-MO_PACKAGES_ASSO.PACKAGES_ASSO_ID-Inicializa con la secuencia'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(16):=105639;
RQTY_100219_.tb6_1(16):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(16):=1313;
RQTY_100219_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(16),-1)));
RQTY_100219_.old_tb6_3(16):=106099;
RQTY_100219_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(16),-1)));
RQTY_100219_.old_tb6_4(16):=null;
RQTY_100219_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(16),-1)));
RQTY_100219_.old_tb6_5(16):=null;
RQTY_100219_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(16),-1)));
RQTY_100219_.tb6_7(16):=RQTY_100219_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(16),
ENTITY_ID=RQTY_100219_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(16),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=29,
DISPLAY_NAME='Identificador'
,
DISPLAY_ORDER=29,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='PACKAGES_ASSO_ID'
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
ENTITY_NAME='MO_PACKAGES_ASSO'
,
ATTRI_TECHNICAL_NAME='PACKAGES_ASSO_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(16),
RQTY_100219_.tb6_1(16),
RQTY_100219_.tb6_2(16),
RQTY_100219_.tb6_3(16),
RQTY_100219_.tb6_4(16),
RQTY_100219_.tb6_5(16),
null,
RQTY_100219_.tb6_7(16),
null,
null,
29,
'Identificador'
,
29,
'N'
,
'N'
,
'N'
,
'PACKAGES_ASSO_ID'
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
'MO_PACKAGES_ASSO'
,
'PACKAGES_ASSO_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(12):=121057132;
RQTY_100219_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(12):=RQTY_100219_.tb2_0(12);
RQTY_100219_.old_tb2_1(12):='MO_INITATRIB_CT23E121057132'
;
RQTY_100219_.tb2_1(12):=RQTY_100219_.tb2_0(12);
RQTY_100219_.tb2_2(12):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(12),
RQTY_100219_.tb2_1(12),
RQTY_100219_.tb2_2(12),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbSusc);nuSuscr = UT_CONVERT.FNUCHARTONUMBER(sbSusc);LD_BOFLOWFNBPACK.GETCATSUBBYSUSCRIPC(nuSuscr,nuCategory,nuSubcateg);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSubcateg)'
,
'OPEN'
,
to_date('01-05-2013 11:04:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicialización de subcategoría del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb7_0(1):=120029761;
RQTY_100219_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100219_.tb7_0(1):=RQTY_100219_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100219_.tb7_0(1),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(17):=105630;
RQTY_100219_.tb6_1(17):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(17):=68;
RQTY_100219_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(17),-1)));
RQTY_100219_.old_tb6_3(17):=441;
RQTY_100219_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(17),-1)));
RQTY_100219_.old_tb6_4(17):=null;
RQTY_100219_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(17),-1)));
RQTY_100219_.old_tb6_5(17):=null;
RQTY_100219_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(17),-1)));
RQTY_100219_.tb6_6(17):=RQTY_100219_.tb7_0(1);
RQTY_100219_.tb6_7(17):=RQTY_100219_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(17),
ENTITY_ID=RQTY_100219_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(17),
STATEMENT_ID=RQTY_100219_.tb6_6(17),
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(17),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=25,
DISPLAY_NAME='Subcategoria'
,
DISPLAY_ORDER=25,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(17),
RQTY_100219_.tb6_1(17),
RQTY_100219_.tb6_2(17),
RQTY_100219_.tb6_3(17),
RQTY_100219_.tb6_4(17),
RQTY_100219_.tb6_5(17),
RQTY_100219_.tb6_6(17),
RQTY_100219_.tb6_7(17),
null,
null,
25,
'Subcategoria'
,
25,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(18):=105631;
RQTY_100219_.tb6_1(18):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(18):=1313;
RQTY_100219_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(18),-1)));
RQTY_100219_.old_tb6_3(18):=39945;
RQTY_100219_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(18),-1)));
RQTY_100219_.old_tb6_4(18):=null;
RQTY_100219_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(18),-1)));
RQTY_100219_.old_tb6_5(18):=null;
RQTY_100219_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(18),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(18),
ENTITY_ID=RQTY_100219_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=26,
DISPLAY_NAME='Código del Paquete'
,
DISPLAY_ORDER=26,
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
ENTITY_NAME='MO_PACKAGES_ASSO'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(18),
RQTY_100219_.tb6_1(18),
RQTY_100219_.tb6_2(18),
RQTY_100219_.tb6_3(18),
RQTY_100219_.tb6_4(18),
RQTY_100219_.tb6_5(18),
null,
null,
null,
null,
26,
'Código del Paquete'
,
26,
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
'MO_PACKAGES_ASSO'
,
'PACKAGE_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(13):=121057133;
RQTY_100219_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(13):=RQTY_100219_.tb2_0(13);
RQTY_100219_.old_tb2_1(13):='MO_INITATRIB_CT23E121057133'
;
RQTY_100219_.tb2_1(13):=RQTY_100219_.tb2_0(13);
RQTY_100219_.tb2_2(13):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(13),
RQTY_100219_.tb2_1(13),
RQTY_100219_.tb2_2(13),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'OPEN'
,
to_date('01-05-2013 11:04:51','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:26','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(19):=105514;
RQTY_100219_.tb6_1(19):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(19):=17;
RQTY_100219_.tb6_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(19),-1)));
RQTY_100219_.old_tb6_3(19):=257;
RQTY_100219_.tb6_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(19),-1)));
RQTY_100219_.old_tb6_4(19):=null;
RQTY_100219_.tb6_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(19),-1)));
RQTY_100219_.old_tb6_5(19):=null;
RQTY_100219_.tb6_5(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(19),-1)));
RQTY_100219_.tb6_7(19):=RQTY_100219_.tb2_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (19)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(19),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(19),
ENTITY_ID=RQTY_100219_.tb6_2(19),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(19),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(19),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(19),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Interacción'
,
DISPLAY_ORDER=1,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(19);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(19),
RQTY_100219_.tb6_1(19),
RQTY_100219_.tb6_2(19),
RQTY_100219_.tb6_3(19),
RQTY_100219_.tb6_4(19),
RQTY_100219_.tb6_5(19),
null,
RQTY_100219_.tb6_7(19),
null,
null,
1,
'Interacción'
,
1,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(14):=121057134;
RQTY_100219_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(14):=RQTY_100219_.tb2_0(14);
RQTY_100219_.old_tb2_1(14):='MO_INITATRIB_CT23E121057134'
;
RQTY_100219_.tb2_1(14):=RQTY_100219_.tb2_0(14);
RQTY_100219_.tb2_2(14):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(14),
RQTY_100219_.tb2_1(14),
RQTY_100219_.tb2_2(14),
'CF_BOINITRULES.INIREQUESTDATE()'
,
'OPEN'
,
to_date('01-05-2013 11:04:52','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb1_0(2):=26;
RQTY_100219_.tb1_1(2):=RQTY_100219_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100219_.tb1_0(2),
MODULE_ID=RQTY_100219_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100219_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100219_.tb1_0(2),
RQTY_100219_.tb1_1(2),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(15):=121057135;
RQTY_100219_.tb2_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(15):=RQTY_100219_.tb2_0(15);
RQTY_100219_.old_tb2_1(15):='MO_VALIDATTR_CT26E121057135'
;
RQTY_100219_.tb2_1(15):=RQTY_100219_.tb2_0(15);
RQTY_100219_.tb2_2(15):=RQTY_100219_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(15),
RQTY_100219_.tb2_1(15),
RQTY_100219_.tb2_2(15),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100236;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No est¿ permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,););)'
,
'OPEN'
,
to_date('01-05-2013 11:04:52','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Val - Fecha de Solicitud - Venta de Seguros'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(20):=105515;
RQTY_100219_.tb6_1(20):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(20):=17;
RQTY_100219_.tb6_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(20),-1)));
RQTY_100219_.old_tb6_3(20):=258;
RQTY_100219_.tb6_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(20),-1)));
RQTY_100219_.old_tb6_4(20):=null;
RQTY_100219_.tb6_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(20),-1)));
RQTY_100219_.old_tb6_5(20):=null;
RQTY_100219_.tb6_5(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(20),-1)));
RQTY_100219_.tb6_7(20):=RQTY_100219_.tb2_0(14);
RQTY_100219_.tb6_8(20):=RQTY_100219_.tb2_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (20)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(20),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(20),
ENTITY_ID=RQTY_100219_.tb6_2(20),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(20),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(20),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(20),
VALID_EXPRESSION_ID=RQTY_100219_.tb6_8(20),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Fecha de Solicitud'
,
DISPLAY_ORDER=2,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(20);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(20),
RQTY_100219_.tb6_1(20),
RQTY_100219_.tb6_2(20),
RQTY_100219_.tb6_3(20),
RQTY_100219_.tb6_4(20),
RQTY_100219_.tb6_5(20),
null,
RQTY_100219_.tb6_7(20),
RQTY_100219_.tb6_8(20),
null,
2,
'Fecha de Solicitud'
,
2,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(16):=121057136;
RQTY_100219_.tb2_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(16):=RQTY_100219_.tb2_0(16);
RQTY_100219_.old_tb2_1(16):='MO_VALIDATTR_CT26E121057136'
;
RQTY_100219_.tb2_1(16):=RQTY_100219_.tb2_0(16);
RQTY_100219_.tb2_2(16):=RQTY_100219_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(16),
RQTY_100219_.tb2_1(16),
RQTY_100219_.tb2_2(16),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",null,"MO_PACKAGES","PACKAGE_NEW_ID",sbValue,TRUE)'
,
'OPEN'
,
to_date('01-05-2013 11:04:53','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(21):=105517;
RQTY_100219_.tb6_1(21):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(21):=17;
RQTY_100219_.tb6_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(21),-1)));
RQTY_100219_.old_tb6_3(21):=255;
RQTY_100219_.tb6_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(21),-1)));
RQTY_100219_.old_tb6_4(21):=null;
RQTY_100219_.tb6_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(21),-1)));
RQTY_100219_.old_tb6_5(21):=null;
RQTY_100219_.tb6_5(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(21),-1)));
RQTY_100219_.tb6_8(21):=RQTY_100219_.tb2_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (21)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(21),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(21),
ENTITY_ID=RQTY_100219_.tb6_2(21),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(21),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(21),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100219_.tb6_8(21),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Número de Solicitud'
,
DISPLAY_ORDER=3,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(21);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(21),
RQTY_100219_.tb6_1(21),
RQTY_100219_.tb6_2(21),
RQTY_100219_.tb6_3(21),
RQTY_100219_.tb6_4(21),
RQTY_100219_.tb6_5(21),
null,
null,
RQTY_100219_.tb6_8(21),
null,
3,
'Número de Solicitud'
,
3,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(17):=121057137;
RQTY_100219_.tb2_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(17):=RQTY_100219_.tb2_0(17);
RQTY_100219_.old_tb2_1(17):='MO_INITATRIB_CT23E121057137'
;
RQTY_100219_.tb2_1(17):=RQTY_100219_.tb2_0(17);
RQTY_100219_.tb2_2(17):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(17),
RQTY_100219_.tb2_1(17),
RQTY_100219_.tb2_2(17),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'OPEN'
,
to_date('01-05-2013 11:04:53','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(18):=121057138;
RQTY_100219_.tb2_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(18):=RQTY_100219_.tb2_0(18);
RQTY_100219_.old_tb2_1(18):='MO_VALIDATTR_CT26E121057138'
;
RQTY_100219_.tb2_1(18):=RQTY_100219_.tb2_0(18);
RQTY_100219_.tb2_2(18):=RQTY_100219_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(18),
RQTY_100219_.tb2_1(18),
RQTY_100219_.tb2_2(18),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPersonId);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,Null,"MO_PACKAGES","POS_OPER_UNIT_ID",nuSaleChannel,True)'
,
'OPEN'
,
to_date('01-05-2013 11:04:53','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb7_0(2):=120029762;
RQTY_100219_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100219_.tb7_0(2):=RQTY_100219_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100219_.tb7_0(2),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(22):=105518;
RQTY_100219_.tb6_1(22):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(22):=17;
RQTY_100219_.tb6_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(22),-1)));
RQTY_100219_.old_tb6_3(22):=50001162;
RQTY_100219_.tb6_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(22),-1)));
RQTY_100219_.old_tb6_4(22):=null;
RQTY_100219_.tb6_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(22),-1)));
RQTY_100219_.old_tb6_5(22):=null;
RQTY_100219_.tb6_5(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(22),-1)));
RQTY_100219_.tb6_6(22):=RQTY_100219_.tb7_0(2);
RQTY_100219_.tb6_7(22):=RQTY_100219_.tb2_0(17);
RQTY_100219_.tb6_8(22):=RQTY_100219_.tb2_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (22)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(22),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(22),
ENTITY_ID=RQTY_100219_.tb6_2(22),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(22),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(22),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(22),
STATEMENT_ID=RQTY_100219_.tb6_6(22),
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(22),
VALID_EXPRESSION_ID=RQTY_100219_.tb6_8(22),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Funcionario'
,
DISPLAY_ORDER=4,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(22);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(22),
RQTY_100219_.tb6_1(22),
RQTY_100219_.tb6_2(22),
RQTY_100219_.tb6_3(22),
RQTY_100219_.tb6_4(22),
RQTY_100219_.tb6_5(22),
RQTY_100219_.tb6_6(22),
RQTY_100219_.tb6_7(22),
RQTY_100219_.tb6_8(22),
null,
4,
'Funcionario'
,
4,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(19):=121057139;
RQTY_100219_.tb2_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(19):=RQTY_100219_.tb2_0(19);
RQTY_100219_.old_tb2_1(19):='MO_INITATRIB_CT23E121057139'
;
RQTY_100219_.tb2_1(19):=RQTY_100219_.tb2_0(19);
RQTY_100219_.tb2_2(19):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(19),
RQTY_100219_.tb2_1(19),
RQTY_100219_.tb2_2(19),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'OPEN'
,
to_date('01-05-2013 11:04:53','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb7_0(3):=120029763;
RQTY_100219_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100219_.tb7_0(3):=RQTY_100219_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100219_.tb7_0(3),
16,
'Lista Puntos de Atención SCL'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')'
,
'Lista Puntos de Atención SCL'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(23):=105519;
RQTY_100219_.tb6_1(23):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(23):=17;
RQTY_100219_.tb6_2(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(23),-1)));
RQTY_100219_.old_tb6_3(23):=109479;
RQTY_100219_.tb6_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(23),-1)));
RQTY_100219_.old_tb6_4(23):=null;
RQTY_100219_.tb6_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(23),-1)));
RQTY_100219_.old_tb6_5(23):=null;
RQTY_100219_.tb6_5(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(23),-1)));
RQTY_100219_.tb6_6(23):=RQTY_100219_.tb7_0(3);
RQTY_100219_.tb6_7(23):=RQTY_100219_.tb2_0(19);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (23)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(23),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(23),
ENTITY_ID=RQTY_100219_.tb6_2(23),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(23),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(23),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(23),
STATEMENT_ID=RQTY_100219_.tb6_6(23),
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(23),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Punto de Atención'
,
DISPLAY_ORDER=5,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(23);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(23),
RQTY_100219_.tb6_1(23),
RQTY_100219_.tb6_2(23),
RQTY_100219_.tb6_3(23),
RQTY_100219_.tb6_4(23),
RQTY_100219_.tb6_5(23),
RQTY_100219_.tb6_6(23),
RQTY_100219_.tb6_7(23),
null,
null,
5,
'Punto de Atención'
,
5,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(20):=121057140;
RQTY_100219_.tb2_0(20):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(20):=RQTY_100219_.tb2_0(20);
RQTY_100219_.old_tb2_1(20):='MO_INITATRIB_CT23E121057140'
;
RQTY_100219_.tb2_1(20):=RQTY_100219_.tb2_0(20);
RQTY_100219_.tb2_2(20):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (20)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(20),
RQTY_100219_.tb2_1(20),
RQTY_100219_.tb2_2(20),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'OPEN'
,
to_date('01-05-2013 11:04:54','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(24):=105520;
RQTY_100219_.tb6_1(24):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(24):=17;
RQTY_100219_.tb6_2(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(24),-1)));
RQTY_100219_.old_tb6_3(24):=2683;
RQTY_100219_.tb6_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(24),-1)));
RQTY_100219_.old_tb6_4(24):=null;
RQTY_100219_.tb6_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(24),-1)));
RQTY_100219_.old_tb6_5(24):=null;
RQTY_100219_.tb6_5(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(24),-1)));
RQTY_100219_.tb6_7(24):=RQTY_100219_.tb2_0(20);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (24)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(24),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(24),
ENTITY_ID=RQTY_100219_.tb6_2(24),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(24),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(24),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(24),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Medio de recepción'
,
DISPLAY_ORDER=6,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(24);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(24),
RQTY_100219_.tb6_1(24),
RQTY_100219_.tb6_2(24),
RQTY_100219_.tb6_3(24),
RQTY_100219_.tb6_4(24),
RQTY_100219_.tb6_5(24),
null,
RQTY_100219_.tb6_7(24),
null,
null,
6,
'Medio de recepción'
,
6,
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(21):=121057141;
RQTY_100219_.tb2_0(21):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(21):=RQTY_100219_.tb2_0(21);
RQTY_100219_.old_tb2_1(21):='MO_INITATRIB_CT23E121057141'
;
RQTY_100219_.tb2_1(21):=RQTY_100219_.tb2_0(21);
RQTY_100219_.tb2_2(21):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (21)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(21),
RQTY_100219_.tb2_1(21),
RQTY_100219_.tb2_2(21),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'OPEN'
,
to_date('01-05-2013 11:04:54','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(25):=105521;
RQTY_100219_.tb6_1(25):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(25):=17;
RQTY_100219_.tb6_2(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(25),-1)));
RQTY_100219_.old_tb6_3(25):=146755;
RQTY_100219_.tb6_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(25),-1)));
RQTY_100219_.old_tb6_4(25):=null;
RQTY_100219_.tb6_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(25),-1)));
RQTY_100219_.old_tb6_5(25):=null;
RQTY_100219_.tb6_5(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(25),-1)));
RQTY_100219_.tb6_7(25):=RQTY_100219_.tb2_0(21);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (25)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(25),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(25),
ENTITY_ID=RQTY_100219_.tb6_2(25),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(25),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(25),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(25),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Información del Solicitante'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(25);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(25),
RQTY_100219_.tb6_1(25),
RQTY_100219_.tb6_2(25),
RQTY_100219_.tb6_3(25),
RQTY_100219_.tb6_4(25),
RQTY_100219_.tb6_5(25),
null,
RQTY_100219_.tb6_7(25),
null,
null,
7,
'Información del Solicitante'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.old_tb2_0(22):=121057142;
RQTY_100219_.tb2_0(22):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100219_.tb2_0(22):=RQTY_100219_.tb2_0(22);
RQTY_100219_.old_tb2_1(22):='MO_INITATRIB_CT23E121057142'
;
RQTY_100219_.tb2_1(22):=RQTY_100219_.tb2_0(22);
RQTY_100219_.tb2_2(22):=RQTY_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (22)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100219_.tb2_0(22),
RQTY_100219_.tb2_1(22),
RQTY_100219_.tb2_2(22),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'OPEN'
,
to_date('01-05-2013 11:04:54','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:27','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(26):=105523;
RQTY_100219_.tb6_1(26):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(26):=17;
RQTY_100219_.tb6_2(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(26),-1)));
RQTY_100219_.old_tb6_3(26):=146756;
RQTY_100219_.tb6_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(26),-1)));
RQTY_100219_.old_tb6_4(26):=null;
RQTY_100219_.tb6_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(26),-1)));
RQTY_100219_.old_tb6_5(26):=null;
RQTY_100219_.tb6_5(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(26),-1)));
RQTY_100219_.tb6_7(26):=RQTY_100219_.tb2_0(22);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (26)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(26),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(26),
ENTITY_ID=RQTY_100219_.tb6_2(26),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(26),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(26),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(26),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100219_.tb6_7(26),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Dirección de Respuesta'
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(26);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(26),
RQTY_100219_.tb6_1(26),
RQTY_100219_.tb6_2(26),
RQTY_100219_.tb6_3(26),
RQTY_100219_.tb6_4(26),
RQTY_100219_.tb6_5(26),
null,
RQTY_100219_.tb6_7(26),
null,
null,
8,
'Dirección de Respuesta'
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
'N'
);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(27):=105524;
RQTY_100219_.tb6_1(27):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(27):=17;
RQTY_100219_.tb6_2(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(27),-1)));
RQTY_100219_.old_tb6_3(27):=146754;
RQTY_100219_.tb6_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(27),-1)));
RQTY_100219_.old_tb6_4(27):=null;
RQTY_100219_.tb6_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(27),-1)));
RQTY_100219_.old_tb6_5(27):=null;
RQTY_100219_.tb6_5(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(27),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (27)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(27),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(27),
ENTITY_ID=RQTY_100219_.tb6_2(27),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(27),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(27),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(27),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Observación'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(27);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(27),
RQTY_100219_.tb6_1(27),
RQTY_100219_.tb6_2(27),
RQTY_100219_.tb6_3(27),
RQTY_100219_.tb6_4(27),
RQTY_100219_.tb6_5(27),
null,
null,
null,
null,
9,
'Observación'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(28):=105525;
RQTY_100219_.tb6_1(28):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(28):=17;
RQTY_100219_.tb6_2(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(28),-1)));
RQTY_100219_.old_tb6_3(28):=269;
RQTY_100219_.tb6_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(28),-1)));
RQTY_100219_.old_tb6_4(28):=null;
RQTY_100219_.tb6_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(28),-1)));
RQTY_100219_.old_tb6_5(28):=null;
RQTY_100219_.tb6_5(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(28),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (28)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(28),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(28),
ENTITY_ID=RQTY_100219_.tb6_2(28),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(28),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(28),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(28),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(28);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(28),
RQTY_100219_.tb6_1(28),
RQTY_100219_.tb6_2(28),
RQTY_100219_.tb6_3(28),
RQTY_100219_.tb6_4(28),
RQTY_100219_.tb6_5(28),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb6_0(29):=105526;
RQTY_100219_.tb6_1(29):=RQTY_100219_.tb5_0(0);
RQTY_100219_.old_tb6_2(29):=17;
RQTY_100219_.tb6_2(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100219_.TBENTITYNAME(NVL(RQTY_100219_.old_tb6_2(29),-1)));
RQTY_100219_.old_tb6_3(29):=109478;
RQTY_100219_.tb6_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_3(29),-1)));
RQTY_100219_.old_tb6_4(29):=null;
RQTY_100219_.tb6_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_4(29),-1)));
RQTY_100219_.old_tb6_5(29):=null;
RQTY_100219_.tb6_5(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100219_.TBENTITYATTRIBUTENAME(NVL(RQTY_100219_.old_tb6_5(29),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (29)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100219_.tb6_0(29),
PACKAGE_TYPE_ID=RQTY_100219_.tb6_1(29),
ENTITY_ID=RQTY_100219_.tb6_2(29),
ENTITY_ATTRIBUTE_ID=RQTY_100219_.tb6_3(29),
MIRROR_ENTI_ATTRIB=RQTY_100219_.tb6_4(29),
PARENT_ATTRIBUTE_ID=RQTY_100219_.tb6_5(29),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100219_.tb6_0(29);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100219_.tb6_0(29),
RQTY_100219_.tb6_1(29),
RQTY_100219_.tb6_2(29),
RQTY_100219_.tb6_3(29),
RQTY_100219_.tb6_4(29),
RQTY_100219_.tb6_5(29),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb8_0(0):='99'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100219_.tb8_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb9_0(0):=99;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100219_.tb9_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb10_0(0):=7055;
RQTY_100219_.tb10_2(0):=RQTY_100219_.tb8_0(0);
RQTY_100219_.tb10_3(0):=RQTY_100219_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100219_.tb10_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100219_.tb10_2(0),
SERVSETI=RQTY_100219_.tb10_3(0),
SERVDESC='Servicios Financieros'
,
SERVCOEX='7055'
,
SERVFLST='N'
,
SERVFLBA='N'
,
SERVFLAC='S'
,
SERVFLIM='N'
,
SERVPRRE=2,
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
SERVTXML='PR_SERVICIOS_FINANCIEROS_7055'
,
SERVASAU='N'
,
SERVPRFI='N'
,
SERVCOLC='N'
,
SERVTICO='V'
,
SERVDIMI=1
 WHERE SERVCODI = RQTY_100219_.tb10_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100219_.tb10_0(0),
null,
RQTY_100219_.tb10_2(0),
RQTY_100219_.tb10_3(0),
'Servicios Financieros'
,
'7055'
,
'N'
,
'N'
,
'S'
,
'N'
,
2,
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
'PR_SERVICIOS_FINANCIEROS_7055'
,
'N'
,
'N'
,
'N'
,
'V'
,
1);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb11_0(0):=8;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100219_.tb11_0(0),
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

 WHERE MOTIVE_TYPE_ID = RQTY_100219_.tb11_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100219_.tb11_0(0),
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb12_0(0):=100218;
RQTY_100219_.tb12_1(0):=RQTY_100219_.tb10_0(0);
RQTY_100219_.tb12_2(0):=RQTY_100219_.tb11_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100219_.tb12_0(0),
RQTY_100219_.tb12_1(0),
RQTY_100219_.tb12_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
,
'Instalación de Servicios Financieros'
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
RQTY_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;

RQTY_100219_.tb13_0(0):=100218;
RQTY_100219_.tb13_1(0):=RQTY_100219_.tb12_0(0);
RQTY_100219_.tb13_3(0):=RQTY_100219_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100219_.tb13_0(0),
PRODUCT_MOTIVE_ID=RQTY_100219_.tb13_1(0),
PRODUCT_TYPE_ID=7055,
PACKAGE_TYPE_ID=RQTY_100219_.tb13_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100219_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100219_.tb13_0(0),
RQTY_100219_.tb13_1(0),
7055,
RQTY_100219_.tb13_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100219_.blProcessStatus := false;
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
nuIndex := RQTY_100219_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100219_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100219_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100219_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100219_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100219_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100219_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100219_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100219_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100219_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100219_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100219_.blProcessStatus := false;
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
 nuIndex := RQTY_100219_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100219_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100219_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100219_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100219_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100219_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100219_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100219_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100219_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100219_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100219_',
'CREATE OR REPLACE PACKAGE RQPMT_100219_ IS ' || chr(10) ||
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
'tb0_1 ty0_1;type ty1_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of PS_PROD_MOTI_ATTRIB.PROD_MOTI_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of PS_PROD_MOTI_ATTRIB.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of PS_PROD_MOTI_ATTRIB.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_3 is table of PS_PROD_MOTI_ATTRIB.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb2_3 ty2_3; ' || chr(10) ||
'tb2_3 ty2_3;type ty2_4 is table of PS_PROD_MOTI_ATTRIB.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_4 ty2_4; ' || chr(10) ||
'tb2_4 ty2_4;type ty2_5 is table of PS_PROD_MOTI_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty2_6 is table of PS_PROD_MOTI_ATTRIB.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_6 ty2_6; ' || chr(10) ||
'tb2_6 ty2_6;type ty2_7 is table of PS_PROD_MOTI_ATTRIB.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_7 ty2_7; ' || chr(10) ||
'tb2_7 ty2_7;type ty2_8 is table of PS_PROD_MOTI_ATTRIB.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_8 ty2_8; ' || chr(10) ||
'tb2_8 ty2_8;type ty2_9 is table of PS_PROD_MOTI_ATTRIB.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_9 ty2_9; ' || chr(10) ||
'tb2_9 ty2_9;type ty3_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty4_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GR_CONFIGURA_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty5_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty6_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_COMPONENT_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty8_0 is table of PS_PROD_MOTIVE_COMP.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of PS_PROD_MOTIVE_COMP.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of PS_PROD_MOTIVE_COMP.PARENT_COMP%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty8_4 is table of PS_PROD_MOTIVE_COMP.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_4 ty8_4; ' || chr(10) ||
'tb8_4 ty8_4;type ty9_0 is table of PS_MOTI_COMP_ATTRIBS.MOTI_COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty9_2 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_2 ty9_2; ' || chr(10) ||
'tb9_2 ty9_2;type ty9_3 is table of PS_MOTI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb9_3 ty9_3; ' || chr(10) ||
'tb9_3 ty9_3;type ty9_4 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_4 ty9_4; ' || chr(10) ||
'tb9_4 ty9_4;type ty9_5 is table of PS_MOTI_COMP_ATTRIBS.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_5 ty9_5; ' || chr(10) ||
'tb9_5 ty9_5;type ty9_6 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_6 ty9_6; ' || chr(10) ||
'tb9_6 ty9_6;type ty9_7 is table of PS_MOTI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_7 ty9_7; ' || chr(10) ||
'tb9_7 ty9_7;type ty9_8 is table of PS_MOTI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_8 ty9_8; ' || chr(10) ||
'tb9_8 ty9_8;type ty9_9 is table of PS_MOTI_COMP_ATTRIBS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_9 ty9_9; ' || chr(10) ||
'tb9_9 ty9_9;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 100219; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100219 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100219 ' || chr(10) ||
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
'END RQPMT_100219_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100219_******************************'); END;
/

BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100219_.cuExpressions;
fetch RQPMT_100219_.cuExpressions bulk collect INTO RQPMT_100219_.tbExpressionsId;
close RQPMT_100219_.cuExpressions;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100219_.tbEntityName(-1) := 'NULL';
   RQPMT_100219_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQPMT_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100219_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQPMT_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100219_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQPMT_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100219_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100219_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQPMT_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100219_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100219_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100219_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100219
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
WHERE PACKAGE_type_id = 100219
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
WHERE PACKAGE_type_id = 100219
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
WHERE PACKAGE_type_id = 100219
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
WHERE PACKAGE_type_id = 100219
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
WHERE PACKAGE_type_id = 100219
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100219_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100219
))));

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100219_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100219_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100219_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100219_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100219
))));

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100219
))));

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100219_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100219_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100219
)))));

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100219_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100219_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100219_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100219_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100219_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100219_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100219
))));

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
))));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100219
))));

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
)));
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100219_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100219_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100219_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100219_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100219_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100219_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100219_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100219
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb0_0(0):=100218;
RQPMT_100219_.tb0_1(0):=7055;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100219_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100219_.tb0_1(0),
MOTIVE_TYPE_ID=8,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
,
DESCRIPTION='Instalación de Servicios Financieros'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100219_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100219_.tb0_0(0),
RQPMT_100219_.tb0_1(0),
8,
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
,
'Instalación de Servicios Financieros'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb1_0(0):=120029764;
RQPMT_100219_.tb1_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100219_.tb1_0(0):=RQPMT_100219_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100219_.tb1_0(0),
16,
'Tipos de respuesta para solicitud venta Promigas'
,
'select cc_answer.answer_id ID, cc_answer.description DESCRIPTION
from cc_answer
order by id'
,
'Tipos de respuesta para solicitud venta Promigas'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(0):=103408;
RQPMT_100219_.old_tb2_1(0):=8;
RQPMT_100219_.tb2_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(0),-1)));
RQPMT_100219_.old_tb2_2(0):=144591;
RQPMT_100219_.tb2_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(0),-1)));
RQPMT_100219_.old_tb2_3(0):=null;
RQPMT_100219_.tb2_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(0),-1)));
RQPMT_100219_.old_tb2_4(0):=null;
RQPMT_100219_.tb2_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(0),-1)));
RQPMT_100219_.tb2_5(0):=RQPMT_100219_.tb1_0(0);
RQPMT_100219_.tb2_9(0):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(0),
ENTITY_ID=RQPMT_100219_.tb2_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(0),
STATEMENT_ID=RQPMT_100219_.tb2_5(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(0),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Respuesta '
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(0),
RQPMT_100219_.tb2_1(0),
RQPMT_100219_.tb2_2(0),
RQPMT_100219_.tb2_3(0),
RQPMT_100219_.tb2_4(0),
RQPMT_100219_.tb2_5(0),
null,
null,
null,
RQPMT_100219_.tb2_9(0),
0,
'Respuesta '
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb3_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100219_.tb3_0(0),
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

 WHERE MODULE_ID = RQPMT_100219_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100219_.tb3_0(0),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb4_0(0):=23;
RQPMT_100219_.tb4_1(0):=RQPMT_100219_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100219_.tb4_0(0),
MODULE_ID=RQPMT_100219_.tb4_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100219_.tb4_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100219_.tb4_0(0),
RQPMT_100219_.tb4_1(0),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(0):=121057143;
RQPMT_100219_.tb5_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(0):=RQPMT_100219_.tb5_0(0);
RQPMT_100219_.old_tb5_1(0):='MO_INITATRIB_CT23E121057143'
;
RQPMT_100219_.tb5_1(0):=RQPMT_100219_.tb5_0(0);
RQPMT_100219_.tb5_2(0):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(0),
RQPMT_100219_.tb5_1(0),
RQPMT_100219_.tb5_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'OPEN'
,
to_date('29-04-2013 18:30:52','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(1):=103415;
RQPMT_100219_.old_tb2_1(1):=8;
RQPMT_100219_.tb2_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(1),-1)));
RQPMT_100219_.old_tb2_2(1):=187;
RQPMT_100219_.tb2_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(1),-1)));
RQPMT_100219_.old_tb2_3(1):=null;
RQPMT_100219_.tb2_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(1),-1)));
RQPMT_100219_.old_tb2_4(1):=null;
RQPMT_100219_.tb2_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(1),-1)));
RQPMT_100219_.tb2_6(1):=RQPMT_100219_.tb5_0(0);
RQPMT_100219_.tb2_9(1):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(1),
ENTITY_ID=RQPMT_100219_.tb2_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb2_6(1),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(1),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(1),
RQPMT_100219_.tb2_1(1),
RQPMT_100219_.tb2_2(1),
RQPMT_100219_.tb2_3(1),
RQPMT_100219_.tb2_4(1),
null,
RQPMT_100219_.tb2_6(1),
null,
null,
RQPMT_100219_.tb2_9(1),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(2):=103418;
RQPMT_100219_.old_tb2_1(2):=8;
RQPMT_100219_.tb2_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(2),-1)));
RQPMT_100219_.old_tb2_2(2):=213;
RQPMT_100219_.tb2_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(2),-1)));
RQPMT_100219_.old_tb2_3(2):=255;
RQPMT_100219_.tb2_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(2),-1)));
RQPMT_100219_.old_tb2_4(2):=null;
RQPMT_100219_.tb2_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(2),-1)));
RQPMT_100219_.tb2_9(2):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(2),
ENTITY_ID=RQPMT_100219_.tb2_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(2),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Identificador del Paquete'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(2),
RQPMT_100219_.tb2_1(2),
RQPMT_100219_.tb2_2(2),
RQPMT_100219_.tb2_3(2),
RQPMT_100219_.tb2_4(2),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(2),
2,
'Identificador del Paquete'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(1):=121057144;
RQPMT_100219_.tb5_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(1):=RQPMT_100219_.tb5_0(1);
RQPMT_100219_.old_tb5_1(1):='MO_INITATRIB_CT23E121057144'
;
RQPMT_100219_.tb5_1(1):=RQPMT_100219_.tb5_0(1);
RQPMT_100219_.tb5_2(1):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(1),
RQPMT_100219_.tb5_1(1),
RQPMT_100219_.tb5_2(1),
'CF_BOINITRULES.INIPRIORITY()'
,
'OPEN'
,
to_date('29-04-2013 18:30:52','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(3):=103419;
RQPMT_100219_.old_tb2_1(3):=8;
RQPMT_100219_.tb2_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(3),-1)));
RQPMT_100219_.old_tb2_2(3):=203;
RQPMT_100219_.tb2_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(3),-1)));
RQPMT_100219_.old_tb2_3(3):=null;
RQPMT_100219_.tb2_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(3),-1)));
RQPMT_100219_.old_tb2_4(3):=null;
RQPMT_100219_.tb2_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(3),-1)));
RQPMT_100219_.tb2_6(3):=RQPMT_100219_.tb5_0(1);
RQPMT_100219_.tb2_9(3):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(3),
ENTITY_ID=RQPMT_100219_.tb2_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb2_6(3),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(3),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Prioridad'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(3),
RQPMT_100219_.tb2_1(3),
RQPMT_100219_.tb2_2(3),
RQPMT_100219_.tb2_3(3),
RQPMT_100219_.tb2_4(3),
null,
RQPMT_100219_.tb2_6(3),
null,
null,
RQPMT_100219_.tb2_9(3),
3,
'Prioridad'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(2):=121057145;
RQPMT_100219_.tb5_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(2):=RQPMT_100219_.tb5_0(2);
RQPMT_100219_.old_tb5_1(2):='MO_INITATRIB_CT23E121057145'
;
RQPMT_100219_.tb5_1(2):=RQPMT_100219_.tb5_0(2);
RQPMT_100219_.tb5_2(2):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(2),
RQPMT_100219_.tb5_1(2),
RQPMT_100219_.tb5_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'OPEN'
,
to_date('29-04-2013 18:30:52','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(4):=103420;
RQPMT_100219_.old_tb2_1(4):=8;
RQPMT_100219_.tb2_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(4),-1)));
RQPMT_100219_.old_tb2_2(4):=322;
RQPMT_100219_.tb2_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(4),-1)));
RQPMT_100219_.old_tb2_3(4):=null;
RQPMT_100219_.tb2_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(4),-1)));
RQPMT_100219_.old_tb2_4(4):=null;
RQPMT_100219_.tb2_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(4),-1)));
RQPMT_100219_.tb2_6(4):=RQPMT_100219_.tb5_0(2);
RQPMT_100219_.tb2_9(4):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(4),
ENTITY_ID=RQPMT_100219_.tb2_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb2_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(4),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Entregas Parciales'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(4),
RQPMT_100219_.tb2_1(4),
RQPMT_100219_.tb2_2(4),
RQPMT_100219_.tb2_3(4),
RQPMT_100219_.tb2_4(4),
null,
RQPMT_100219_.tb2_6(4),
null,
null,
RQPMT_100219_.tb2_9(4),
4,
'Entregas Parciales'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(5):=103421;
RQPMT_100219_.old_tb2_1(5):=8;
RQPMT_100219_.tb2_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(5),-1)));
RQPMT_100219_.old_tb2_2(5):=2641;
RQPMT_100219_.tb2_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(5),-1)));
RQPMT_100219_.old_tb2_3(5):=null;
RQPMT_100219_.tb2_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(5),-1)));
RQPMT_100219_.old_tb2_4(5):=null;
RQPMT_100219_.tb2_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(5),-1)));
RQPMT_100219_.tb2_9(5):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(5),
ENTITY_ID=RQPMT_100219_.tb2_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(5),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='L¿mite de Cr¿dito'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(5),
RQPMT_100219_.tb2_1(5),
RQPMT_100219_.tb2_2(5),
RQPMT_100219_.tb2_3(5),
RQPMT_100219_.tb2_4(5),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(5),
5,
'L¿mite de Cr¿dito'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(6):=103422;
RQPMT_100219_.old_tb2_1(6):=8;
RQPMT_100219_.tb2_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(6),-1)));
RQPMT_100219_.old_tb2_2(6):=197;
RQPMT_100219_.tb2_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(6),-1)));
RQPMT_100219_.old_tb2_3(6):=null;
RQPMT_100219_.tb2_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(6),-1)));
RQPMT_100219_.old_tb2_4(6):=null;
RQPMT_100219_.tb2_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(6),-1)));
RQPMT_100219_.tb2_9(6):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(6),
ENTITY_ID=RQPMT_100219_.tb2_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(6),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='PRIVACY_FLAG'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(6),
RQPMT_100219_.tb2_1(6),
RQPMT_100219_.tb2_2(6),
RQPMT_100219_.tb2_3(6),
RQPMT_100219_.tb2_4(6),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(6),
6,
'PRIVACY_FLAG'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(7):=103423;
RQPMT_100219_.old_tb2_1(7):=8;
RQPMT_100219_.tb2_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(7),-1)));
RQPMT_100219_.old_tb2_2(7):=189;
RQPMT_100219_.tb2_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(7),-1)));
RQPMT_100219_.old_tb2_3(7):=255;
RQPMT_100219_.tb2_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(7),-1)));
RQPMT_100219_.old_tb2_4(7):=null;
RQPMT_100219_.tb2_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(7),-1)));
RQPMT_100219_.tb2_9(7):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(7),
ENTITY_ID=RQPMT_100219_.tb2_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(7),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='N¿mero Petici¿n Atenci¿n al cliente'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(7),
RQPMT_100219_.tb2_1(7),
RQPMT_100219_.tb2_2(7),
RQPMT_100219_.tb2_3(7),
RQPMT_100219_.tb2_4(7),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(7),
7,
'N¿mero Petici¿n Atenci¿n al cliente'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(8):=103424;
RQPMT_100219_.old_tb2_1(8):=8;
RQPMT_100219_.tb2_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(8),-1)));
RQPMT_100219_.old_tb2_2(8):=413;
RQPMT_100219_.tb2_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(8),-1)));
RQPMT_100219_.old_tb2_3(8):=null;
RQPMT_100219_.tb2_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(8),-1)));
RQPMT_100219_.old_tb2_4(8):=null;
RQPMT_100219_.tb2_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(8),-1)));
RQPMT_100219_.tb2_9(8):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(8),
ENTITY_ID=RQPMT_100219_.tb2_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(8),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='PRODUCT_ID'
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
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(8),
RQPMT_100219_.tb2_1(8),
RQPMT_100219_.tb2_2(8),
RQPMT_100219_.tb2_3(8),
RQPMT_100219_.tb2_4(8),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(8),
8,
'PRODUCT_ID'
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
'N'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(9):=103425;
RQPMT_100219_.old_tb2_1(9):=8;
RQPMT_100219_.tb2_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(9),-1)));
RQPMT_100219_.old_tb2_2(9):=50001324;
RQPMT_100219_.tb2_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(9),-1)));
RQPMT_100219_.old_tb2_3(9):=null;
RQPMT_100219_.tb2_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(9),-1)));
RQPMT_100219_.old_tb2_4(9):=null;
RQPMT_100219_.tb2_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(9),-1)));
RQPMT_100219_.tb2_9(9):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(9),
ENTITY_ID=RQPMT_100219_.tb2_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(9),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Ubicaci¿n Geogr¿fica'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(9),
RQPMT_100219_.tb2_1(9),
RQPMT_100219_.tb2_2(9),
RQPMT_100219_.tb2_3(9),
RQPMT_100219_.tb2_4(9),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(9),
9,
'Ubicaci¿n Geogr¿fica'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(3):=121057146;
RQPMT_100219_.tb5_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(3):=RQPMT_100219_.tb5_0(3);
RQPMT_100219_.old_tb5_1(3):='MO_INITATRIB_CT23E121057146'
;
RQPMT_100219_.tb5_1(3):=RQPMT_100219_.tb5_0(3);
RQPMT_100219_.tb5_2(3):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(3),
RQPMT_100219_.tb5_1(3),
RQPMT_100219_.tb5_2(3),
'CF_BOINITRULES.INIPROVISIONALFLAG()'
,
'OPEN'
,
to_date('29-04-2013 18:30:53','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(10):=103433;
RQPMT_100219_.old_tb2_1(10):=8;
RQPMT_100219_.tb2_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(10),-1)));
RQPMT_100219_.old_tb2_2(10):=198;
RQPMT_100219_.tb2_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(10),-1)));
RQPMT_100219_.old_tb2_3(10):=null;
RQPMT_100219_.tb2_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(10),-1)));
RQPMT_100219_.old_tb2_4(10):=null;
RQPMT_100219_.tb2_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(10),-1)));
RQPMT_100219_.tb2_6(10):=RQPMT_100219_.tb5_0(3);
RQPMT_100219_.tb2_9(10):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(10),
ENTITY_ID=RQPMT_100219_.tb2_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb2_6(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(10),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Provisional'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(10),
RQPMT_100219_.tb2_1(10),
RQPMT_100219_.tb2_2(10),
RQPMT_100219_.tb2_3(10),
RQPMT_100219_.tb2_4(10),
null,
RQPMT_100219_.tb2_6(10),
null,
null,
RQPMT_100219_.tb2_9(10),
10,
'Provisional'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(11):=103434;
RQPMT_100219_.old_tb2_1(11):=8;
RQPMT_100219_.tb2_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(11),-1)));
RQPMT_100219_.old_tb2_2(11):=498;
RQPMT_100219_.tb2_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(11),-1)));
RQPMT_100219_.old_tb2_3(11):=null;
RQPMT_100219_.tb2_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(11),-1)));
RQPMT_100219_.old_tb2_4(11):=null;
RQPMT_100219_.tb2_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(11),-1)));
RQPMT_100219_.tb2_9(11):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(11),
ENTITY_ID=RQPMT_100219_.tb2_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(11),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Fecha de Atenci¿n'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(11),
RQPMT_100219_.tb2_1(11),
RQPMT_100219_.tb2_2(11),
RQPMT_100219_.tb2_3(11),
RQPMT_100219_.tb2_4(11),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(11),
11,
'Fecha de Atenci¿n'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(12):=103435;
RQPMT_100219_.old_tb2_1(12):=8;
RQPMT_100219_.tb2_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(12),-1)));
RQPMT_100219_.old_tb2_2(12):=220;
RQPMT_100219_.tb2_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(12),-1)));
RQPMT_100219_.old_tb2_3(12):=null;
RQPMT_100219_.tb2_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(12),-1)));
RQPMT_100219_.old_tb2_4(12):=null;
RQPMT_100219_.tb2_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(12),-1)));
RQPMT_100219_.tb2_9(12):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(12),
ENTITY_ID=RQPMT_100219_.tb2_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(12),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador de Distribuci¿n Administrativa'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(12),
RQPMT_100219_.tb2_1(12),
RQPMT_100219_.tb2_2(12),
RQPMT_100219_.tb2_3(12),
RQPMT_100219_.tb2_4(12),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(12),
12,
'Identificador de Distribuci¿n Administrativa'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(13):=103436;
RQPMT_100219_.old_tb2_1(13):=8;
RQPMT_100219_.tb2_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(13),-1)));
RQPMT_100219_.old_tb2_2(13):=524;
RQPMT_100219_.tb2_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(13),-1)));
RQPMT_100219_.old_tb2_3(13):=null;
RQPMT_100219_.tb2_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(13),-1)));
RQPMT_100219_.old_tb2_4(13):=null;
RQPMT_100219_.tb2_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(13),-1)));
RQPMT_100219_.tb2_9(13):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(13),
ENTITY_ID=RQPMT_100219_.tb2_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(13),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Estado del Motivo'
,
DISPLAY_ORDER=13,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(13),
RQPMT_100219_.tb2_1(13),
RQPMT_100219_.tb2_2(13),
RQPMT_100219_.tb2_3(13),
RQPMT_100219_.tb2_4(13),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(13),
13,
'Estado del Motivo'
,
13,
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(14):=103437;
RQPMT_100219_.old_tb2_1(14):=8;
RQPMT_100219_.tb2_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(14),-1)));
RQPMT_100219_.old_tb2_2(14):=191;
RQPMT_100219_.tb2_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(14),-1)));
RQPMT_100219_.old_tb2_3(14):=null;
RQPMT_100219_.tb2_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(14),-1)));
RQPMT_100219_.old_tb2_4(14):=null;
RQPMT_100219_.tb2_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(14),-1)));
RQPMT_100219_.tb2_9(14):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(14),
ENTITY_ID=RQPMT_100219_.tb2_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(14),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Identificador del Tipo de Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(14),
RQPMT_100219_.tb2_1(14),
RQPMT_100219_.tb2_2(14),
RQPMT_100219_.tb2_3(14),
RQPMT_100219_.tb2_4(14),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(14),
14,
'Identificador del Tipo de Motivo'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(15):=103438;
RQPMT_100219_.old_tb2_1(15):=8;
RQPMT_100219_.tb2_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(15),-1)));
RQPMT_100219_.old_tb2_2(15):=192;
RQPMT_100219_.tb2_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(15),-1)));
RQPMT_100219_.old_tb2_3(15):=null;
RQPMT_100219_.tb2_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(15),-1)));
RQPMT_100219_.old_tb2_4(15):=null;
RQPMT_100219_.tb2_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(15),-1)));
RQPMT_100219_.tb2_9(15):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(15),
ENTITY_ID=RQPMT_100219_.tb2_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(15),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Identificador del Tipo de Producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(15),
RQPMT_100219_.tb2_1(15),
RQPMT_100219_.tb2_2(15),
RQPMT_100219_.tb2_3(15),
RQPMT_100219_.tb2_4(15),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(15),
15,
'Identificador del Tipo de Producto'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(16):=103439;
RQPMT_100219_.old_tb2_1(16):=8;
RQPMT_100219_.tb2_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(16),-1)));
RQPMT_100219_.old_tb2_2(16):=4011;
RQPMT_100219_.tb2_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(16),-1)));
RQPMT_100219_.old_tb2_3(16):=null;
RQPMT_100219_.tb2_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(16),-1)));
RQPMT_100219_.old_tb2_4(16):=null;
RQPMT_100219_.tb2_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(16),-1)));
RQPMT_100219_.tb2_9(16):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(16),
ENTITY_ID=RQPMT_100219_.tb2_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(16),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='N¿mero del Servicio'
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
TAG_NAME='N_MERO_DEL_SERVICIO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(16),
RQPMT_100219_.tb2_1(16),
RQPMT_100219_.tb2_2(16),
RQPMT_100219_.tb2_3(16),
RQPMT_100219_.tb2_4(16),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(16),
16,
'N¿mero del Servicio'
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
'N_MERO_DEL_SERVICIO'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(17):=103440;
RQPMT_100219_.old_tb2_1(17):=8;
RQPMT_100219_.tb2_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(17),-1)));
RQPMT_100219_.old_tb2_2(17):=11403;
RQPMT_100219_.tb2_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(17),-1)));
RQPMT_100219_.old_tb2_3(17):=1111;
RQPMT_100219_.tb2_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(17),-1)));
RQPMT_100219_.old_tb2_4(17):=null;
RQPMT_100219_.tb2_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(17),-1)));
RQPMT_100219_.tb2_9(17):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(17),
ENTITY_ID=RQPMT_100219_.tb2_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(17),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Identificador de la Suscripci¿n'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(17),
RQPMT_100219_.tb2_1(17),
RQPMT_100219_.tb2_2(17),
RQPMT_100219_.tb2_3(17),
RQPMT_100219_.tb2_4(17),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(17),
17,
'Identificador de la Suscripci¿n'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(18):=103441;
RQPMT_100219_.old_tb2_1(18):=8;
RQPMT_100219_.tb2_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(18),-1)));
RQPMT_100219_.old_tb2_2(18):=6683;
RQPMT_100219_.tb2_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(18),-1)));
RQPMT_100219_.old_tb2_3(18):=null;
RQPMT_100219_.tb2_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(18),-1)));
RQPMT_100219_.old_tb2_4(18):=null;
RQPMT_100219_.tb2_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(18),-1)));
RQPMT_100219_.tb2_9(18):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(18),
ENTITY_ID=RQPMT_100219_.tb2_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(18),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='CLIENT_PRIVACY_FLAG'
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
ATTRI_TECHNICAL_NAME='CLIENT_PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(18),
RQPMT_100219_.tb2_1(18),
RQPMT_100219_.tb2_2(18),
RQPMT_100219_.tb2_3(18),
RQPMT_100219_.tb2_4(18),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(18),
18,
'CLIENT_PRIVACY_FLAG'
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
'CLIENT_PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(4):=121057147;
RQPMT_100219_.tb5_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(4):=RQPMT_100219_.tb5_0(4);
RQPMT_100219_.old_tb5_1(4):='MO_INITATRIB_CT23E121057147'
;
RQPMT_100219_.tb5_1(4):=RQPMT_100219_.tb5_0(4);
RQPMT_100219_.tb5_2(4):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(4),
RQPMT_100219_.tb5_1(4),
RQPMT_100219_.tb5_2(4),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(0)'
,
'OPEN'
,
to_date('29-04-2013 18:30:54','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(19):=103442;
RQPMT_100219_.old_tb2_1(19):=8;
RQPMT_100219_.tb2_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(19),-1)));
RQPMT_100219_.old_tb2_2(19):=20362;
RQPMT_100219_.tb2_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(19),-1)));
RQPMT_100219_.old_tb2_3(19):=null;
RQPMT_100219_.tb2_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(19),-1)));
RQPMT_100219_.old_tb2_4(19):=null;
RQPMT_100219_.tb2_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(19),-1)));
RQPMT_100219_.tb2_6(19):=RQPMT_100219_.tb5_0(4);
RQPMT_100219_.tb2_9(19):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (19)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(19),
ENTITY_ID=RQPMT_100219_.tb2_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb2_6(19),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(19),
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Valor a cobrar'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(19);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(19),
RQPMT_100219_.tb2_1(19),
RQPMT_100219_.tb2_2(19),
RQPMT_100219_.tb2_3(19),
RQPMT_100219_.tb2_4(19),
null,
RQPMT_100219_.tb2_6(19),
null,
null,
RQPMT_100219_.tb2_9(19),
19,
'Valor a cobrar'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(5):=121057148;
RQPMT_100219_.tb5_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(5):=RQPMT_100219_.tb5_0(5);
RQPMT_100219_.old_tb5_1(5):='MO_INITATRIB_CT23E121057148'
;
RQPMT_100219_.tb5_1(5):=RQPMT_100219_.tb5_0(5);
RQPMT_100219_.tb5_2(5):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(5),
RQPMT_100219_.tb5_1(5),
RQPMT_100219_.tb5_2(5),
'LD_BOFLOWFNBPACK.GETLDPARAMATER("COD_COMERCIAL_PLAN_FNB","N",sbplanComercial);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbplanComercial)'
,
'OPEN'
,
to_date('30-04-2013 18:21:55','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - Plan Comercial - Venta brilla promigas'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(20):=103443;
RQPMT_100219_.old_tb2_1(20):=8;
RQPMT_100219_.tb2_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(20),-1)));
RQPMT_100219_.old_tb2_2(20):=45189;
RQPMT_100219_.tb2_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(20),-1)));
RQPMT_100219_.old_tb2_3(20):=null;
RQPMT_100219_.tb2_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(20),-1)));
RQPMT_100219_.old_tb2_4(20):=null;
RQPMT_100219_.tb2_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(20),-1)));
RQPMT_100219_.tb2_6(20):=RQPMT_100219_.tb5_0(5);
RQPMT_100219_.tb2_9(20):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (20)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(20),
ENTITY_ID=RQPMT_100219_.tb2_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb2_6(20),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(20),
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Identificador Plan Comercial'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(20);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(20),
RQPMT_100219_.tb2_1(20),
RQPMT_100219_.tb2_2(20),
RQPMT_100219_.tb2_3(20),
RQPMT_100219_.tb2_4(20),
null,
RQPMT_100219_.tb2_6(20),
null,
null,
RQPMT_100219_.tb2_9(20),
20,
'Identificador Plan Comercial'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(21):=103992;
RQPMT_100219_.old_tb2_1(21):=8;
RQPMT_100219_.tb2_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(21),-1)));
RQPMT_100219_.old_tb2_2(21):=147336;
RQPMT_100219_.tb2_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(21),-1)));
RQPMT_100219_.old_tb2_3(21):=440;
RQPMT_100219_.tb2_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(21),-1)));
RQPMT_100219_.old_tb2_4(21):=null;
RQPMT_100219_.tb2_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(21),-1)));
RQPMT_100219_.tb2_9(21):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (21)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(21),
ENTITY_ID=RQPMT_100219_.tb2_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(21),
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Categoría'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(21);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(21),
RQPMT_100219_.tb2_1(21),
RQPMT_100219_.tb2_2(21),
RQPMT_100219_.tb2_3(21),
RQPMT_100219_.tb2_4(21),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(21),
21,
'Categoría'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb2_0(22):=103995;
RQPMT_100219_.old_tb2_1(22):=8;
RQPMT_100219_.tb2_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb2_1(22),-1)));
RQPMT_100219_.old_tb2_2(22):=147337;
RQPMT_100219_.tb2_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_2(22),-1)));
RQPMT_100219_.old_tb2_3(22):=441;
RQPMT_100219_.tb2_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_3(22),-1)));
RQPMT_100219_.old_tb2_4(22):=null;
RQPMT_100219_.tb2_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb2_4(22),-1)));
RQPMT_100219_.tb2_9(22):=RQPMT_100219_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (22)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100219_.tb2_0(22),
ENTITY_ID=RQPMT_100219_.tb2_1(22),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb2_2(22),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb2_3(22),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb2_4(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb2_9(22),
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Subcategoría'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100219_.tb2_0(22);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb2_0(22),
RQPMT_100219_.tb2_1(22),
RQPMT_100219_.tb2_2(22),
RQPMT_100219_.tb2_3(22),
RQPMT_100219_.tb2_4(22),
null,
null,
null,
null,
RQPMT_100219_.tb2_9(22),
22,
'Subcategoría'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb6_0(0):=99;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQPMT_100219_.tb6_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb7_0(0):=7112;
RQPMT_100219_.tb7_1(0):=RQPMT_100219_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (0)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=RQPMT_100219_.tb7_0(0),
SERVICE_TYPE_ID=RQPMT_100219_.tb7_1(0),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Servicios Financieros'
,
ACCEPT_IF_PROJECTED='N'
,
ASSIGNABLE='N'
,
TAG_NAME='CP_SERVICIOS_FINANCIEROS_7112'
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

 WHERE COMPONENT_TYPE_ID = RQPMT_100219_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (RQPMT_100219_.tb7_0(0),
RQPMT_100219_.tb7_1(0),
null,
'Servicios Financieros'
,
'N'
,
'N'
,
'CP_SERVICIOS_FINANCIEROS_7112'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb8_0(0):=10306;
RQPMT_100219_.tb8_1(0):=RQPMT_100219_.tb0_0(0);
RQPMT_100219_.tb8_4(0):=RQPMT_100219_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTIVE_COMP fila (0)',1);
UPDATE PS_PROD_MOTIVE_COMP SET PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb8_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100219_.tb8_1(0),
PARENT_COMP=null,
SERVICE_COMPONENT=10326,
COMPONENT_TYPE_ID=RQPMT_100219_.tb8_4(0),
MOTIVE_TYPE_ID=8,
TAG_NAME='C_SERVICIOS_FINANCIEROS_10306'
,
ASSIGN_ORDER=3,
MIN_COMPONENTS=1,
MAX_COMPONENTS=1,
IS_OPTIONAL='N'
,
DESCRIPTION='Servicios Financieros'
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

 WHERE PROD_MOTIVE_COMP_ID = RQPMT_100219_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTIVE_COMP(PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,SERVICE_COMPONENT,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN) 
VALUES (RQPMT_100219_.tb8_0(0),
RQPMT_100219_.tb8_1(0),
null,
10326,
RQPMT_100219_.tb8_4(0),
8,
'C_SERVICIOS_FINANCIEROS_10306'
,
3,
1,
1,
'N'
,
'Servicios Financieros'
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(0):=105103;
RQPMT_100219_.old_tb9_1(0):=43;
RQPMT_100219_.tb9_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(0),-1)));
RQPMT_100219_.old_tb9_2(0):=456;
RQPMT_100219_.tb9_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(0),-1)));
RQPMT_100219_.old_tb9_3(0):=187;
RQPMT_100219_.tb9_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(0),-1)));
RQPMT_100219_.old_tb9_4(0):=null;
RQPMT_100219_.tb9_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(0),-1)));
RQPMT_100219_.tb9_5(0):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (0)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(0),
ENTITY_ID=RQPMT_100219_.tb9_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(0),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(0),
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(0);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(0),
RQPMT_100219_.tb9_1(0),
RQPMT_100219_.tb9_2(0),
RQPMT_100219_.tb9_3(0),
RQPMT_100219_.tb9_4(0),
RQPMT_100219_.tb9_5(0),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb5_0(6):=121057149;
RQPMT_100219_.tb5_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100219_.tb5_0(6):=RQPMT_100219_.tb5_0(6);
RQPMT_100219_.old_tb5_1(6):='MO_INITATRIB_CT23E121057149'
;
RQPMT_100219_.tb5_1(6):=RQPMT_100219_.tb5_0(6);
RQPMT_100219_.tb5_2(6):=RQPMT_100219_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100219_.tb5_0(6),
RQPMT_100219_.tb5_1(6),
RQPMT_100219_.tb5_2(6),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETCOMPONENTID())'
,
'OPEN'
,
to_date('29-04-2013 18:30:55','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 10:52:46','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(1):=105102;
RQPMT_100219_.old_tb9_1(1):=43;
RQPMT_100219_.tb9_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(1),-1)));
RQPMT_100219_.old_tb9_2(1):=338;
RQPMT_100219_.tb9_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(1),-1)));
RQPMT_100219_.old_tb9_3(1):=null;
RQPMT_100219_.tb9_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(1),-1)));
RQPMT_100219_.old_tb9_4(1):=null;
RQPMT_100219_.tb9_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(1),-1)));
RQPMT_100219_.tb9_5(1):=RQPMT_100219_.tb8_0(0);
RQPMT_100219_.tb9_8(1):=RQPMT_100219_.tb5_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (1)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(1),
ENTITY_ID=RQPMT_100219_.tb9_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(1),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(1),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100219_.tb9_8(1),
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(1);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(1),
RQPMT_100219_.tb9_1(1),
RQPMT_100219_.tb9_2(1),
RQPMT_100219_.tb9_3(1),
RQPMT_100219_.tb9_4(1),
RQPMT_100219_.tb9_5(1),
null,
null,
RQPMT_100219_.tb9_8(1),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(2):=105109;
RQPMT_100219_.old_tb9_1(2):=43;
RQPMT_100219_.tb9_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(2),-1)));
RQPMT_100219_.old_tb9_2(2):=696;
RQPMT_100219_.tb9_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(2),-1)));
RQPMT_100219_.old_tb9_3(2):=697;
RQPMT_100219_.tb9_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(2),-1)));
RQPMT_100219_.old_tb9_4(2):=null;
RQPMT_100219_.tb9_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(2),-1)));
RQPMT_100219_.tb9_5(2):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (2)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(2),
ENTITY_ID=RQPMT_100219_.tb9_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(2),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(2),
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(2);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(2),
RQPMT_100219_.tb9_1(2),
RQPMT_100219_.tb9_2(2),
RQPMT_100219_.tb9_3(2),
RQPMT_100219_.tb9_4(2),
RQPMT_100219_.tb9_5(2),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(3):=105110;
RQPMT_100219_.old_tb9_1(3):=43;
RQPMT_100219_.tb9_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(3),-1)));
RQPMT_100219_.old_tb9_2(3):=1026;
RQPMT_100219_.tb9_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(3),-1)));
RQPMT_100219_.old_tb9_3(3):=null;
RQPMT_100219_.tb9_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(3),-1)));
RQPMT_100219_.old_tb9_4(3):=null;
RQPMT_100219_.tb9_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(3),-1)));
RQPMT_100219_.tb9_5(3):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (3)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(3),
ENTITY_ID=RQPMT_100219_.tb9_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(3),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(3),
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(3);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(3),
RQPMT_100219_.tb9_1(3),
RQPMT_100219_.tb9_2(3),
RQPMT_100219_.tb9_3(3),
RQPMT_100219_.tb9_4(3),
RQPMT_100219_.tb9_5(3),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(4):=105111;
RQPMT_100219_.old_tb9_1(4):=43;
RQPMT_100219_.tb9_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(4),-1)));
RQPMT_100219_.old_tb9_2(4):=50000937;
RQPMT_100219_.tb9_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(4),-1)));
RQPMT_100219_.old_tb9_3(4):=255;
RQPMT_100219_.tb9_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(4),-1)));
RQPMT_100219_.old_tb9_4(4):=null;
RQPMT_100219_.tb9_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(4),-1)));
RQPMT_100219_.tb9_5(4):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (4)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(4),
ENTITY_ID=RQPMT_100219_.tb9_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(4),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(4),
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(4);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(4),
RQPMT_100219_.tb9_1(4),
RQPMT_100219_.tb9_2(4),
RQPMT_100219_.tb9_3(4),
RQPMT_100219_.tb9_4(4),
RQPMT_100219_.tb9_5(4),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(5):=105112;
RQPMT_100219_.old_tb9_1(5):=43;
RQPMT_100219_.tb9_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(5),-1)));
RQPMT_100219_.old_tb9_2(5):=50000936;
RQPMT_100219_.tb9_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(5),-1)));
RQPMT_100219_.old_tb9_3(5):=null;
RQPMT_100219_.tb9_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(5),-1)));
RQPMT_100219_.old_tb9_4(5):=null;
RQPMT_100219_.tb9_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(5),-1)));
RQPMT_100219_.tb9_5(5):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (5)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(5),
ENTITY_ID=RQPMT_100219_.tb9_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(5),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(5),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='PRODUCT_ID'
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
ATTRI_TECHNICAL_NAME='PRODUCT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(5);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(5),
RQPMT_100219_.tb9_1(5),
RQPMT_100219_.tb9_2(5),
RQPMT_100219_.tb9_3(5),
RQPMT_100219_.tb9_4(5),
RQPMT_100219_.tb9_5(5),
null,
null,
null,
null,
6,
'PRODUCT_ID'
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
'PRODUCT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(6):=105113;
RQPMT_100219_.old_tb9_1(6):=43;
RQPMT_100219_.tb9_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(6),-1)));
RQPMT_100219_.old_tb9_2(6):=4013;
RQPMT_100219_.tb9_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(6),-1)));
RQPMT_100219_.old_tb9_3(6):=null;
RQPMT_100219_.tb9_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(6),-1)));
RQPMT_100219_.old_tb9_4(6):=null;
RQPMT_100219_.tb9_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(6),-1)));
RQPMT_100219_.tb9_5(6):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (6)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(6),
ENTITY_ID=RQPMT_100219_.tb9_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(6),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(6),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='SERVICE_NUMBER'
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
ATTRI_TECHNICAL_NAME='SERVICE_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(6);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(6),
RQPMT_100219_.tb9_1(6),
RQPMT_100219_.tb9_2(6),
RQPMT_100219_.tb9_3(6),
RQPMT_100219_.tb9_4(6),
RQPMT_100219_.tb9_5(6),
null,
null,
null,
null,
7,
'SERVICE_NUMBER'
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
'SERVICE_NUMBER'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(7):=105114;
RQPMT_100219_.old_tb9_1(7):=43;
RQPMT_100219_.tb9_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(7),-1)));
RQPMT_100219_.old_tb9_2(7):=362;
RQPMT_100219_.tb9_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(7),-1)));
RQPMT_100219_.old_tb9_3(7):=null;
RQPMT_100219_.tb9_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(7),-1)));
RQPMT_100219_.old_tb9_4(7):=null;
RQPMT_100219_.tb9_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(7),-1)));
RQPMT_100219_.tb9_5(7):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (7)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(7),
ENTITY_ID=RQPMT_100219_.tb9_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(7),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(7),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='MOTIVE_TYPE_ID'
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
ATTRI_TECHNICAL_NAME='MOTIVE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(7);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(7),
RQPMT_100219_.tb9_1(7),
RQPMT_100219_.tb9_2(7),
RQPMT_100219_.tb9_3(7),
RQPMT_100219_.tb9_4(7),
RQPMT_100219_.tb9_5(7),
null,
null,
null,
null,
8,
'MOTIVE_TYPE_ID'
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
'MOTIVE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(8):=105115;
RQPMT_100219_.old_tb9_1(8):=43;
RQPMT_100219_.tb9_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(8),-1)));
RQPMT_100219_.old_tb9_2(8):=361;
RQPMT_100219_.tb9_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(8),-1)));
RQPMT_100219_.old_tb9_3(8):=null;
RQPMT_100219_.tb9_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(8),-1)));
RQPMT_100219_.old_tb9_4(8):=null;
RQPMT_100219_.tb9_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(8),-1)));
RQPMT_100219_.tb9_5(8):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (8)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(8),
ENTITY_ID=RQPMT_100219_.tb9_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(8),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(8),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='COMPONENT_TYPE_ID'
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
ATTRI_TECHNICAL_NAME='COMPONENT_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(8);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(8),
RQPMT_100219_.tb9_1(8),
RQPMT_100219_.tb9_2(8),
RQPMT_100219_.tb9_3(8),
RQPMT_100219_.tb9_4(8),
RQPMT_100219_.tb9_5(8),
null,
null,
null,
null,
9,
'COMPONENT_TYPE_ID'
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
'COMPONENT_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(9):=105116;
RQPMT_100219_.old_tb9_1(9):=43;
RQPMT_100219_.tb9_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(9),-1)));
RQPMT_100219_.old_tb9_2(9):=355;
RQPMT_100219_.tb9_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(9),-1)));
RQPMT_100219_.old_tb9_3(9):=null;
RQPMT_100219_.tb9_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(9),-1)));
RQPMT_100219_.old_tb9_4(9):=null;
RQPMT_100219_.tb9_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(9),-1)));
RQPMT_100219_.tb9_5(9):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (9)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(9),
ENTITY_ID=RQPMT_100219_.tb9_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(9),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(9),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='DISTRICT_ID'
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
ATTRI_TECHNICAL_NAME='DISTRICT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(9);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(9),
RQPMT_100219_.tb9_1(9),
RQPMT_100219_.tb9_2(9),
RQPMT_100219_.tb9_3(9),
RQPMT_100219_.tb9_4(9),
RQPMT_100219_.tb9_5(9),
null,
null,
null,
null,
10,
'DISTRICT_ID'
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
'DISTRICT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.old_tb1_0(1):=120029765;
RQPMT_100219_.tb1_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100219_.tb1_0(1):=RQPMT_100219_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100219_.tb1_0(1),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(10):=105117;
RQPMT_100219_.old_tb9_1(10):=43;
RQPMT_100219_.tb9_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(10),-1)));
RQPMT_100219_.old_tb9_2(10):=1801;
RQPMT_100219_.tb9_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(10),-1)));
RQPMT_100219_.old_tb9_3(10):=null;
RQPMT_100219_.tb9_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(10),-1)));
RQPMT_100219_.old_tb9_4(10):=null;
RQPMT_100219_.tb9_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(10),-1)));
RQPMT_100219_.tb9_5(10):=RQPMT_100219_.tb8_0(0);
RQPMT_100219_.tb9_9(10):=RQPMT_100219_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (10)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(10),
ENTITY_ID=RQPMT_100219_.tb9_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(10),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(10),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=RQPMT_100219_.tb9_9(10),
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(10);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(10),
RQPMT_100219_.tb9_1(10),
RQPMT_100219_.tb9_2(10),
RQPMT_100219_.tb9_3(10),
RQPMT_100219_.tb9_4(10),
RQPMT_100219_.tb9_5(10),
null,
null,
null,
RQPMT_100219_.tb9_9(10),
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
RQPMT_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;

RQPMT_100219_.tb9_0(11):=105118;
RQPMT_100219_.old_tb9_1(11):=43;
RQPMT_100219_.tb9_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100219_.TBENTITYNAME(NVL(RQPMT_100219_.old_tb9_1(11),-1)));
RQPMT_100219_.old_tb9_2(11):=8064;
RQPMT_100219_.tb9_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_2(11),-1)));
RQPMT_100219_.old_tb9_3(11):=null;
RQPMT_100219_.tb9_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_3(11),-1)));
RQPMT_100219_.old_tb9_4(11):=null;
RQPMT_100219_.tb9_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100219_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100219_.old_tb9_4(11),-1)));
RQPMT_100219_.tb9_5(11):=RQPMT_100219_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (11)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100219_.tb9_0(11),
ENTITY_ID=RQPMT_100219_.tb9_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100219_.tb9_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100219_.tb9_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100219_.tb9_4(11),
PROD_MOTIVE_COMP_ID=RQPMT_100219_.tb9_5(11),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Id Del Componente Del Producto'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100219_.tb9_0(11);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100219_.tb9_0(11),
RQPMT_100219_.tb9_1(11),
RQPMT_100219_.tb9_2(11),
RQPMT_100219_.tb9_3(11),
RQPMT_100219_.tb9_4(11),
RQPMT_100219_.tb9_5(11),
null,
null,
null,
null,
11,
'Id Del Componente Del Producto'
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
RQPMT_100219_.blProcessStatus := false;
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

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100219, sbSuccess);
FOR rc in RQPMT_100219_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
nuIndex := RQPMT_100219_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100219_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100219_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100219_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100219_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100219_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100219_.tb5_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100219_.tb5_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100219_.tb5_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100219_.tb5_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100219_.tb5_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100219_.blProcessStatus := false;
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
 nuIndex := RQPMT_100219_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100219_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100219_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100219_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100219_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100219_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100219_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100219_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100219_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100219_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100219_',
'CREATE OR REPLACE PACKAGE RQCFG_100219_ IS ' || chr(10) ||
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
'AND     external_root_id = 100219 ' || chr(10) ||
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
'END RQCFG_100219_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100219_******************************'); END;
/

BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100219_.cuCompositions;
fetch RQCFG_100219_.cuCompositions bulk collect INTO RQCFG_100219_.tbCompositions;
close RQCFG_100219_.cuCompositions;

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100219_.tbEntityName(-1) := 'NULL';
   RQCFG_100219_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100219_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100219_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100219_.tbEntityName(2014) := 'PS_PROD_MOTIVE_COMP';
   RQCFG_100219_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100219_.tbEntityName(2042) := 'PS_MOTI_COMP_ATTRIBS';
   RQCFG_100219_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(282) := 'MO_ADDRESS@ADDRESS';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(475) := 'MO_ADDRESS@GEOGRAP_LOCATION_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(39945) := 'MO_PACKAGES_ASSO@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(39946) := 'MO_PACKAGES_ASSO@PACKAGE_ID_ASSO';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(106099) := 'MO_PACKAGES_ASSO@PACKAGES_ASSO_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(127931) := 'MO_PACKAGES_ASSO@ANNUL_DEPENDENT';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_100219_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   RQCFG_100219_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(361) := 'MO_COMPONENT@COMPONENT_TYPE_ID';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(106099) := 'MO_PACKAGES_ASSO@PACKAGES_ASSO_ID';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(127931) := 'MO_PACKAGES_ASSO@ANNUL_DEPENDENT';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(11376) := 'MO_ADDRESS@PARSER_ADDRESS_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(39946) := 'MO_PACKAGES_ASSO@PACKAGE_ID_ASSO';
   RQCFG_100219_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100219_.tbEntityAttributeName(1111) := 'MO_PROCESS@SUBSCRIPTION_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(355) := 'MO_COMPONENT@DISTRICT_ID';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(282) := 'MO_ADDRESS@ADDRESS';
   RQCFG_100219_.tbEntityName(1313) := 'MO_PACKAGES_ASSO';
   RQCFG_100219_.tbEntityAttributeName(39945) := 'MO_PACKAGES_ASSO@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_100219_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100219_.tbEntityAttributeName(475) := 'MO_ADDRESS@GEOGRAP_LOCATION_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100219_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100219_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100219_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100219_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100219_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100219_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
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
AND     external_root_id = 100219
)
);
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100219_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100219, 4);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100219_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100219_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100219_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100219_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100219_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219))));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219)));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100219, 4);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100219_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219))));
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219))));
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219))));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219)));

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100219_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100219_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100219_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100219_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100219_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100219_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100219;

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb0_0(0):=7616;
RQCFG_100219_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100219_.tb0_0(0):=RQCFG_100219_.tb0_0(0);
RQCFG_100219_.old_tb0_2(0):=2012;
RQCFG_100219_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100219_.tb0_0(0),
100219,
RQCFG_100219_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb1_0(0):=1037818;
RQCFG_100219_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100219_.tb1_0(0):=RQCFG_100219_.tb1_0(0);
RQCFG_100219_.old_tb1_1(0):=100219;
RQCFG_100219_.tb1_1(0):=RQCFG_100219_.old_tb1_1(0);
RQCFG_100219_.old_tb1_2(0):=2012;
RQCFG_100219_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb1_2(0),-1)));
RQCFG_100219_.old_tb1_3(0):=7616;
RQCFG_100219_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb1_2(0),-1))), RQCFG_100219_.old_tb1_1(0), 4);
RQCFG_100219_.tb1_3(0):=RQCFG_100219_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100219_.tb1_0(0),
RQCFG_100219_.tb1_1(0),
RQCFG_100219_.tb1_2(0),
RQCFG_100219_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb2_0(0):=100022884;
RQCFG_100219_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100219_.tb2_0(0):=RQCFG_100219_.tb2_0(0);
RQCFG_100219_.tb2_1(0):=RQCFG_100219_.tb0_0(0);
RQCFG_100219_.tb2_2(0):=RQCFG_100219_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100219_.tb2_0(0),
RQCFG_100219_.tb2_1(0),
RQCFG_100219_.tb2_2(0),
null,
7055,
1,
1,
1);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb1_0(1):=1037819;
RQCFG_100219_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100219_.tb1_0(1):=RQCFG_100219_.tb1_0(1);
RQCFG_100219_.old_tb1_1(1):=100218;
RQCFG_100219_.tb1_1(1):=RQCFG_100219_.old_tb1_1(1);
RQCFG_100219_.old_tb1_2(1):=2013;
RQCFG_100219_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb1_2(1),-1)));
RQCFG_100219_.old_tb1_3(1):=null;
RQCFG_100219_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb1_2(1),-1))), RQCFG_100219_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100219_.tb1_0(1),
RQCFG_100219_.tb1_1(1),
RQCFG_100219_.tb1_2(1),
RQCFG_100219_.tb1_3(1),
null,
'M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
,
1,
1,
4);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb2_0(1):=100022885;
RQCFG_100219_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100219_.tb2_0(1):=RQCFG_100219_.tb2_0(1);
RQCFG_100219_.tb2_1(1):=RQCFG_100219_.tb0_0(0);
RQCFG_100219_.tb2_2(1):=RQCFG_100219_.tb1_0(1);
RQCFG_100219_.tb2_3(1):=RQCFG_100219_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100219_.tb2_0(1),
RQCFG_100219_.tb2_1(1),
RQCFG_100219_.tb2_2(1),
RQCFG_100219_.tb2_3(1),
7055,
2,
1,
1);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb1_0(2):=1037820;
RQCFG_100219_.tb1_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100219_.tb1_0(2):=RQCFG_100219_.tb1_0(2);
RQCFG_100219_.old_tb1_1(2):=10306;
RQCFG_100219_.tb1_1(2):=RQCFG_100219_.old_tb1_1(2);
RQCFG_100219_.old_tb1_2(2):=2014;
RQCFG_100219_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb1_2(2),-1)));
RQCFG_100219_.old_tb1_3(2):=null;
RQCFG_100219_.tb1_3(2):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb1_2(2),-1))), RQCFG_100219_.old_tb1_1(2), 4);
RQCFG_100219_.tb1_4(2):=RQCFG_100219_.tb1_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100219_.tb1_0(2),
RQCFG_100219_.tb1_1(2),
RQCFG_100219_.tb1_2(2),
RQCFG_100219_.tb1_3(2),
RQCFG_100219_.tb1_4(2),
'C_SERVICIOS_FINANCIEROS_10306'
,
1,
1,
4);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb2_0(2):=100022886;
RQCFG_100219_.tb2_0(2):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100219_.tb2_0(2):=RQCFG_100219_.tb2_0(2);
RQCFG_100219_.tb2_1(2):=RQCFG_100219_.tb0_0(0);
RQCFG_100219_.tb2_2(2):=RQCFG_100219_.tb1_0(2);
RQCFG_100219_.tb2_3(2):=RQCFG_100219_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (2)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100219_.tb2_0(2),
RQCFG_100219_.tb2_1(2),
RQCFG_100219_.tb2_2(2),
RQCFG_100219_.tb2_3(2),
7055,
3,
1,
1);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(0):=1082824;
RQCFG_100219_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(0):=RQCFG_100219_.tb3_0(0);
RQCFG_100219_.old_tb3_1(0):=2042;
RQCFG_100219_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(0),-1)));
RQCFG_100219_.old_tb3_2(0):=338;
RQCFG_100219_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(0),-1)));
RQCFG_100219_.old_tb3_3(0):=null;
RQCFG_100219_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(0),-1)));
RQCFG_100219_.old_tb3_4(0):=null;
RQCFG_100219_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(0),-1)));
RQCFG_100219_.tb3_5(0):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(0):=121057149;
RQCFG_100219_.tb3_6(0):=NULL;
RQCFG_100219_.old_tb3_7(0):=null;
RQCFG_100219_.tb3_7(0):=NULL;
RQCFG_100219_.old_tb3_8(0):=null;
RQCFG_100219_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(0),
RQCFG_100219_.tb3_1(0),
RQCFG_100219_.tb3_2(0),
RQCFG_100219_.tb3_3(0),
RQCFG_100219_.tb3_4(0),
RQCFG_100219_.tb3_5(0),
RQCFG_100219_.tb3_6(0),
RQCFG_100219_.tb3_7(0),
RQCFG_100219_.tb3_8(0),
null,
105102,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb4_0(0):=96949;
RQCFG_100219_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100219_.tb4_0(0):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb4_1(0):=RQCFG_100219_.tb2_2(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100219_.tb4_0(0),
RQCFG_100219_.tb4_1(0),
null,
null,
'FRAME-C_SERVICIOS_FINANCIEROS_10306-1032407'
,
3);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(0):=1285920;
RQCFG_100219_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(0):=RQCFG_100219_.tb5_0(0);
RQCFG_100219_.old_tb5_1(0):=338;
RQCFG_100219_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(0),-1)));
RQCFG_100219_.old_tb5_2(0):=null;
RQCFG_100219_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(0),-1)));
RQCFG_100219_.tb5_3(0):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(0):=RQCFG_100219_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(0),
RQCFG_100219_.tb5_1(0),
RQCFG_100219_.tb5_2(0),
RQCFG_100219_.tb5_3(0),
RQCFG_100219_.tb5_4(0),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(1):=1082825;
RQCFG_100219_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(1):=RQCFG_100219_.tb3_0(1);
RQCFG_100219_.old_tb3_1(1):=2042;
RQCFG_100219_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(1),-1)));
RQCFG_100219_.old_tb3_2(1):=456;
RQCFG_100219_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(1),-1)));
RQCFG_100219_.old_tb3_3(1):=187;
RQCFG_100219_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(1),-1)));
RQCFG_100219_.old_tb3_4(1):=null;
RQCFG_100219_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(1),-1)));
RQCFG_100219_.tb3_5(1):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(1):=null;
RQCFG_100219_.tb3_6(1):=NULL;
RQCFG_100219_.old_tb3_7(1):=null;
RQCFG_100219_.tb3_7(1):=NULL;
RQCFG_100219_.old_tb3_8(1):=null;
RQCFG_100219_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(1),
RQCFG_100219_.tb3_1(1),
RQCFG_100219_.tb3_2(1),
RQCFG_100219_.tb3_3(1),
RQCFG_100219_.tb3_4(1),
RQCFG_100219_.tb3_5(1),
RQCFG_100219_.tb3_6(1),
RQCFG_100219_.tb3_7(1),
RQCFG_100219_.tb3_8(1),
null,
105103,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(1):=1285921;
RQCFG_100219_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(1):=RQCFG_100219_.tb5_0(1);
RQCFG_100219_.old_tb5_1(1):=456;
RQCFG_100219_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(1),-1)));
RQCFG_100219_.old_tb5_2(1):=null;
RQCFG_100219_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(1),-1)));
RQCFG_100219_.tb5_3(1):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(1):=RQCFG_100219_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(1),
RQCFG_100219_.tb5_1(1),
RQCFG_100219_.tb5_2(1),
RQCFG_100219_.tb5_3(1),
RQCFG_100219_.tb5_4(1),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(2):=1082826;
RQCFG_100219_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(2):=RQCFG_100219_.tb3_0(2);
RQCFG_100219_.old_tb3_1(2):=2042;
RQCFG_100219_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(2),-1)));
RQCFG_100219_.old_tb3_2(2):=696;
RQCFG_100219_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(2),-1)));
RQCFG_100219_.old_tb3_3(2):=697;
RQCFG_100219_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(2),-1)));
RQCFG_100219_.old_tb3_4(2):=null;
RQCFG_100219_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(2),-1)));
RQCFG_100219_.tb3_5(2):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(2):=null;
RQCFG_100219_.tb3_6(2):=NULL;
RQCFG_100219_.old_tb3_7(2):=null;
RQCFG_100219_.tb3_7(2):=NULL;
RQCFG_100219_.old_tb3_8(2):=null;
RQCFG_100219_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(2),
RQCFG_100219_.tb3_1(2),
RQCFG_100219_.tb3_2(2),
RQCFG_100219_.tb3_3(2),
RQCFG_100219_.tb3_4(2),
RQCFG_100219_.tb3_5(2),
RQCFG_100219_.tb3_6(2),
RQCFG_100219_.tb3_7(2),
RQCFG_100219_.tb3_8(2),
null,
105109,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(2):=1285922;
RQCFG_100219_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(2):=RQCFG_100219_.tb5_0(2);
RQCFG_100219_.old_tb5_1(2):=696;
RQCFG_100219_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(2),-1)));
RQCFG_100219_.old_tb5_2(2):=null;
RQCFG_100219_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(2),-1)));
RQCFG_100219_.tb5_3(2):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(2):=RQCFG_100219_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(2),
RQCFG_100219_.tb5_1(2),
RQCFG_100219_.tb5_2(2),
RQCFG_100219_.tb5_3(2),
RQCFG_100219_.tb5_4(2),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(3):=1082827;
RQCFG_100219_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(3):=RQCFG_100219_.tb3_0(3);
RQCFG_100219_.old_tb3_1(3):=2042;
RQCFG_100219_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(3),-1)));
RQCFG_100219_.old_tb3_2(3):=1026;
RQCFG_100219_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(3),-1)));
RQCFG_100219_.old_tb3_3(3):=null;
RQCFG_100219_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(3),-1)));
RQCFG_100219_.old_tb3_4(3):=null;
RQCFG_100219_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(3),-1)));
RQCFG_100219_.tb3_5(3):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(3):=null;
RQCFG_100219_.tb3_6(3):=NULL;
RQCFG_100219_.old_tb3_7(3):=null;
RQCFG_100219_.tb3_7(3):=NULL;
RQCFG_100219_.old_tb3_8(3):=null;
RQCFG_100219_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(3),
RQCFG_100219_.tb3_1(3),
RQCFG_100219_.tb3_2(3),
RQCFG_100219_.tb3_3(3),
RQCFG_100219_.tb3_4(3),
RQCFG_100219_.tb3_5(3),
RQCFG_100219_.tb3_6(3),
RQCFG_100219_.tb3_7(3),
RQCFG_100219_.tb3_8(3),
null,
105110,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(3):=1285923;
RQCFG_100219_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(3):=RQCFG_100219_.tb5_0(3);
RQCFG_100219_.old_tb5_1(3):=1026;
RQCFG_100219_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(3),-1)));
RQCFG_100219_.old_tb5_2(3):=null;
RQCFG_100219_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(3),-1)));
RQCFG_100219_.tb5_3(3):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(3):=RQCFG_100219_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(3),
RQCFG_100219_.tb5_1(3),
RQCFG_100219_.tb5_2(3),
RQCFG_100219_.tb5_3(3),
RQCFG_100219_.tb5_4(3),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(4):=1082828;
RQCFG_100219_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(4):=RQCFG_100219_.tb3_0(4);
RQCFG_100219_.old_tb3_1(4):=2042;
RQCFG_100219_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(4),-1)));
RQCFG_100219_.old_tb3_2(4):=50000937;
RQCFG_100219_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(4),-1)));
RQCFG_100219_.old_tb3_3(4):=255;
RQCFG_100219_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(4),-1)));
RQCFG_100219_.old_tb3_4(4):=null;
RQCFG_100219_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(4),-1)));
RQCFG_100219_.tb3_5(4):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(4):=null;
RQCFG_100219_.tb3_6(4):=NULL;
RQCFG_100219_.old_tb3_7(4):=null;
RQCFG_100219_.tb3_7(4):=NULL;
RQCFG_100219_.old_tb3_8(4):=null;
RQCFG_100219_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(4),
RQCFG_100219_.tb3_1(4),
RQCFG_100219_.tb3_2(4),
RQCFG_100219_.tb3_3(4),
RQCFG_100219_.tb3_4(4),
RQCFG_100219_.tb3_5(4),
RQCFG_100219_.tb3_6(4),
RQCFG_100219_.tb3_7(4),
RQCFG_100219_.tb3_8(4),
null,
105111,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(4):=1285924;
RQCFG_100219_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(4):=RQCFG_100219_.tb5_0(4);
RQCFG_100219_.old_tb5_1(4):=50000937;
RQCFG_100219_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(4),-1)));
RQCFG_100219_.old_tb5_2(4):=null;
RQCFG_100219_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(4),-1)));
RQCFG_100219_.tb5_3(4):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(4):=RQCFG_100219_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(4),
RQCFG_100219_.tb5_1(4),
RQCFG_100219_.tb5_2(4),
RQCFG_100219_.tb5_3(4),
RQCFG_100219_.tb5_4(4),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(5):=1082829;
RQCFG_100219_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(5):=RQCFG_100219_.tb3_0(5);
RQCFG_100219_.old_tb3_1(5):=2042;
RQCFG_100219_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(5),-1)));
RQCFG_100219_.old_tb3_2(5):=50000936;
RQCFG_100219_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(5),-1)));
RQCFG_100219_.old_tb3_3(5):=null;
RQCFG_100219_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(5),-1)));
RQCFG_100219_.old_tb3_4(5):=null;
RQCFG_100219_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(5),-1)));
RQCFG_100219_.tb3_5(5):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(5):=null;
RQCFG_100219_.tb3_6(5):=NULL;
RQCFG_100219_.old_tb3_7(5):=null;
RQCFG_100219_.tb3_7(5):=NULL;
RQCFG_100219_.old_tb3_8(5):=null;
RQCFG_100219_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(5),
RQCFG_100219_.tb3_1(5),
RQCFG_100219_.tb3_2(5),
RQCFG_100219_.tb3_3(5),
RQCFG_100219_.tb3_4(5),
RQCFG_100219_.tb3_5(5),
RQCFG_100219_.tb3_6(5),
RQCFG_100219_.tb3_7(5),
RQCFG_100219_.tb3_8(5),
null,
105112,
6,
'PRODUCT_ID'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(5):=1285925;
RQCFG_100219_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(5):=RQCFG_100219_.tb5_0(5);
RQCFG_100219_.old_tb5_1(5):=50000936;
RQCFG_100219_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(5),-1)));
RQCFG_100219_.old_tb5_2(5):=null;
RQCFG_100219_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(5),-1)));
RQCFG_100219_.tb5_3(5):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(5):=RQCFG_100219_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(5),
RQCFG_100219_.tb5_1(5),
RQCFG_100219_.tb5_2(5),
RQCFG_100219_.tb5_3(5),
RQCFG_100219_.tb5_4(5),
'N'
,
'N'
,
6,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(6):=1082830;
RQCFG_100219_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(6):=RQCFG_100219_.tb3_0(6);
RQCFG_100219_.old_tb3_1(6):=2042;
RQCFG_100219_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(6),-1)));
RQCFG_100219_.old_tb3_2(6):=4013;
RQCFG_100219_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(6),-1)));
RQCFG_100219_.old_tb3_3(6):=null;
RQCFG_100219_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(6),-1)));
RQCFG_100219_.old_tb3_4(6):=null;
RQCFG_100219_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(6),-1)));
RQCFG_100219_.tb3_5(6):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(6):=null;
RQCFG_100219_.tb3_6(6):=NULL;
RQCFG_100219_.old_tb3_7(6):=null;
RQCFG_100219_.tb3_7(6):=NULL;
RQCFG_100219_.old_tb3_8(6):=null;
RQCFG_100219_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(6),
RQCFG_100219_.tb3_1(6),
RQCFG_100219_.tb3_2(6),
RQCFG_100219_.tb3_3(6),
RQCFG_100219_.tb3_4(6),
RQCFG_100219_.tb3_5(6),
RQCFG_100219_.tb3_6(6),
RQCFG_100219_.tb3_7(6),
RQCFG_100219_.tb3_8(6),
null,
105113,
7,
'SERVICE_NUMBER'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(6):=1285926;
RQCFG_100219_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(6):=RQCFG_100219_.tb5_0(6);
RQCFG_100219_.old_tb5_1(6):=4013;
RQCFG_100219_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(6),-1)));
RQCFG_100219_.old_tb5_2(6):=null;
RQCFG_100219_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(6),-1)));
RQCFG_100219_.tb5_3(6):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(6):=RQCFG_100219_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(6),
RQCFG_100219_.tb5_1(6),
RQCFG_100219_.tb5_2(6),
RQCFG_100219_.tb5_3(6),
RQCFG_100219_.tb5_4(6),
'N'
,
'N'
,
7,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(7):=1082831;
RQCFG_100219_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(7):=RQCFG_100219_.tb3_0(7);
RQCFG_100219_.old_tb3_1(7):=2042;
RQCFG_100219_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(7),-1)));
RQCFG_100219_.old_tb3_2(7):=362;
RQCFG_100219_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(7),-1)));
RQCFG_100219_.old_tb3_3(7):=null;
RQCFG_100219_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(7),-1)));
RQCFG_100219_.old_tb3_4(7):=null;
RQCFG_100219_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(7),-1)));
RQCFG_100219_.tb3_5(7):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(7):=null;
RQCFG_100219_.tb3_6(7):=NULL;
RQCFG_100219_.old_tb3_7(7):=null;
RQCFG_100219_.tb3_7(7):=NULL;
RQCFG_100219_.old_tb3_8(7):=null;
RQCFG_100219_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(7),
RQCFG_100219_.tb3_1(7),
RQCFG_100219_.tb3_2(7),
RQCFG_100219_.tb3_3(7),
RQCFG_100219_.tb3_4(7),
RQCFG_100219_.tb3_5(7),
RQCFG_100219_.tb3_6(7),
RQCFG_100219_.tb3_7(7),
RQCFG_100219_.tb3_8(7),
null,
105114,
8,
'MOTIVE_TYPE_ID'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(7):=1285927;
RQCFG_100219_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(7):=RQCFG_100219_.tb5_0(7);
RQCFG_100219_.old_tb5_1(7):=362;
RQCFG_100219_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(7),-1)));
RQCFG_100219_.old_tb5_2(7):=null;
RQCFG_100219_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(7),-1)));
RQCFG_100219_.tb5_3(7):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(7):=RQCFG_100219_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(7),
RQCFG_100219_.tb5_1(7),
RQCFG_100219_.tb5_2(7),
RQCFG_100219_.tb5_3(7),
RQCFG_100219_.tb5_4(7),
'N'
,
'N'
,
8,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(8):=1082832;
RQCFG_100219_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(8):=RQCFG_100219_.tb3_0(8);
RQCFG_100219_.old_tb3_1(8):=2042;
RQCFG_100219_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(8),-1)));
RQCFG_100219_.old_tb3_2(8):=361;
RQCFG_100219_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(8),-1)));
RQCFG_100219_.old_tb3_3(8):=null;
RQCFG_100219_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(8),-1)));
RQCFG_100219_.old_tb3_4(8):=null;
RQCFG_100219_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(8),-1)));
RQCFG_100219_.tb3_5(8):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(8):=null;
RQCFG_100219_.tb3_6(8):=NULL;
RQCFG_100219_.old_tb3_7(8):=null;
RQCFG_100219_.tb3_7(8):=NULL;
RQCFG_100219_.old_tb3_8(8):=null;
RQCFG_100219_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(8),
RQCFG_100219_.tb3_1(8),
RQCFG_100219_.tb3_2(8),
RQCFG_100219_.tb3_3(8),
RQCFG_100219_.tb3_4(8),
RQCFG_100219_.tb3_5(8),
RQCFG_100219_.tb3_6(8),
RQCFG_100219_.tb3_7(8),
RQCFG_100219_.tb3_8(8),
null,
105115,
9,
'COMPONENT_TYPE_ID'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(8):=1285928;
RQCFG_100219_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(8):=RQCFG_100219_.tb5_0(8);
RQCFG_100219_.old_tb5_1(8):=361;
RQCFG_100219_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(8),-1)));
RQCFG_100219_.old_tb5_2(8):=null;
RQCFG_100219_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(8),-1)));
RQCFG_100219_.tb5_3(8):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(8):=RQCFG_100219_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(8),
RQCFG_100219_.tb5_1(8),
RQCFG_100219_.tb5_2(8),
RQCFG_100219_.tb5_3(8),
RQCFG_100219_.tb5_4(8),
'N'
,
'N'
,
9,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(9):=1082833;
RQCFG_100219_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(9):=RQCFG_100219_.tb3_0(9);
RQCFG_100219_.old_tb3_1(9):=2042;
RQCFG_100219_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(9),-1)));
RQCFG_100219_.old_tb3_2(9):=355;
RQCFG_100219_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(9),-1)));
RQCFG_100219_.old_tb3_3(9):=null;
RQCFG_100219_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(9),-1)));
RQCFG_100219_.old_tb3_4(9):=null;
RQCFG_100219_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(9),-1)));
RQCFG_100219_.tb3_5(9):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(9):=null;
RQCFG_100219_.tb3_6(9):=NULL;
RQCFG_100219_.old_tb3_7(9):=null;
RQCFG_100219_.tb3_7(9):=NULL;
RQCFG_100219_.old_tb3_8(9):=null;
RQCFG_100219_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(9),
RQCFG_100219_.tb3_1(9),
RQCFG_100219_.tb3_2(9),
RQCFG_100219_.tb3_3(9),
RQCFG_100219_.tb3_4(9),
RQCFG_100219_.tb3_5(9),
RQCFG_100219_.tb3_6(9),
RQCFG_100219_.tb3_7(9),
RQCFG_100219_.tb3_8(9),
null,
105116,
10,
'DISTRICT_ID'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(9):=1285929;
RQCFG_100219_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(9):=RQCFG_100219_.tb5_0(9);
RQCFG_100219_.old_tb5_1(9):=355;
RQCFG_100219_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(9),-1)));
RQCFG_100219_.old_tb5_2(9):=null;
RQCFG_100219_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(9),-1)));
RQCFG_100219_.tb5_3(9):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(9):=RQCFG_100219_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(9),
RQCFG_100219_.tb5_1(9),
RQCFG_100219_.tb5_2(9),
RQCFG_100219_.tb5_3(9),
RQCFG_100219_.tb5_4(9),
'N'
,
'N'
,
10,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(10):=1082834;
RQCFG_100219_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(10):=RQCFG_100219_.tb3_0(10);
RQCFG_100219_.old_tb3_1(10):=2042;
RQCFG_100219_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(10),-1)));
RQCFG_100219_.old_tb3_2(10):=1801;
RQCFG_100219_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(10),-1)));
RQCFG_100219_.old_tb3_3(10):=null;
RQCFG_100219_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(10),-1)));
RQCFG_100219_.old_tb3_4(10):=null;
RQCFG_100219_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(10),-1)));
RQCFG_100219_.tb3_5(10):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(10):=null;
RQCFG_100219_.tb3_6(10):=NULL;
RQCFG_100219_.old_tb3_7(10):=null;
RQCFG_100219_.tb3_7(10):=NULL;
RQCFG_100219_.old_tb3_8(10):=120029765;
RQCFG_100219_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(10),
RQCFG_100219_.tb3_1(10),
RQCFG_100219_.tb3_2(10),
RQCFG_100219_.tb3_3(10),
RQCFG_100219_.tb3_4(10),
RQCFG_100219_.tb3_5(10),
RQCFG_100219_.tb3_6(10),
RQCFG_100219_.tb3_7(10),
RQCFG_100219_.tb3_8(10),
null,
105117,
0,
'Alternativa'
,
'N'
,
'N'
,
'N'
,
0,
null,
null);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(10):=1285930;
RQCFG_100219_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(10):=RQCFG_100219_.tb5_0(10);
RQCFG_100219_.old_tb5_1(10):=1801;
RQCFG_100219_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(10),-1)));
RQCFG_100219_.old_tb5_2(10):=null;
RQCFG_100219_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(10),-1)));
RQCFG_100219_.tb5_3(10):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(10):=RQCFG_100219_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(10),
RQCFG_100219_.tb5_1(10),
RQCFG_100219_.tb5_2(10),
RQCFG_100219_.tb5_3(10),
RQCFG_100219_.tb5_4(10),
'N'
,
'Y'
,
0,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(11):=1082835;
RQCFG_100219_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(11):=RQCFG_100219_.tb3_0(11);
RQCFG_100219_.old_tb3_1(11):=2042;
RQCFG_100219_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(11),-1)));
RQCFG_100219_.old_tb3_2(11):=8064;
RQCFG_100219_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(11),-1)));
RQCFG_100219_.old_tb3_3(11):=null;
RQCFG_100219_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(11),-1)));
RQCFG_100219_.old_tb3_4(11):=null;
RQCFG_100219_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(11),-1)));
RQCFG_100219_.tb3_5(11):=RQCFG_100219_.tb2_2(2);
RQCFG_100219_.old_tb3_6(11):=null;
RQCFG_100219_.tb3_6(11):=NULL;
RQCFG_100219_.old_tb3_7(11):=null;
RQCFG_100219_.tb3_7(11):=NULL;
RQCFG_100219_.old_tb3_8(11):=null;
RQCFG_100219_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(11),
RQCFG_100219_.tb3_1(11),
RQCFG_100219_.tb3_2(11),
RQCFG_100219_.tb3_3(11),
RQCFG_100219_.tb3_4(11),
RQCFG_100219_.tb3_5(11),
RQCFG_100219_.tb3_6(11),
RQCFG_100219_.tb3_7(11),
RQCFG_100219_.tb3_8(11),
null,
105118,
11,
'Id Del Componente Del Producto'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(11):=1285931;
RQCFG_100219_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(11):=RQCFG_100219_.tb5_0(11);
RQCFG_100219_.old_tb5_1(11):=8064;
RQCFG_100219_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(11),-1)));
RQCFG_100219_.old_tb5_2(11):=null;
RQCFG_100219_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(11),-1)));
RQCFG_100219_.tb5_3(11):=RQCFG_100219_.tb4_0(0);
RQCFG_100219_.tb5_4(11):=RQCFG_100219_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(11),
RQCFG_100219_.tb5_1(11),
RQCFG_100219_.tb5_2(11),
RQCFG_100219_.tb5_3(11),
RQCFG_100219_.tb5_4(11),
'C'
,
'Y'
,
11,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(12):=1082836;
RQCFG_100219_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(12):=RQCFG_100219_.tb3_0(12);
RQCFG_100219_.old_tb3_1(12):=3334;
RQCFG_100219_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(12),-1)));
RQCFG_100219_.old_tb3_2(12):=498;
RQCFG_100219_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(12),-1)));
RQCFG_100219_.old_tb3_3(12):=null;
RQCFG_100219_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(12),-1)));
RQCFG_100219_.old_tb3_4(12):=null;
RQCFG_100219_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(12),-1)));
RQCFG_100219_.tb3_5(12):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(12):=null;
RQCFG_100219_.tb3_6(12):=NULL;
RQCFG_100219_.old_tb3_7(12):=null;
RQCFG_100219_.tb3_7(12):=NULL;
RQCFG_100219_.old_tb3_8(12):=null;
RQCFG_100219_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(12),
RQCFG_100219_.tb3_1(12),
RQCFG_100219_.tb3_2(12),
RQCFG_100219_.tb3_3(12),
RQCFG_100219_.tb3_4(12),
RQCFG_100219_.tb3_5(12),
RQCFG_100219_.tb3_6(12),
RQCFG_100219_.tb3_7(12),
RQCFG_100219_.tb3_8(12),
null,
103434,
11,
'Fecha de Atenci¿n'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb4_0(1):=96950;
RQCFG_100219_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100219_.tb4_0(1):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb4_1(1):=RQCFG_100219_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100219_.tb4_0(1),
RQCFG_100219_.tb4_1(1),
null,
null,
'FRAME-M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218-1032406'
,
2);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(12):=1285932;
RQCFG_100219_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(12):=RQCFG_100219_.tb5_0(12);
RQCFG_100219_.old_tb5_1(12):=498;
RQCFG_100219_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(12),-1)));
RQCFG_100219_.old_tb5_2(12):=null;
RQCFG_100219_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(12),-1)));
RQCFG_100219_.tb5_3(12):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(12):=RQCFG_100219_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(12),
RQCFG_100219_.tb5_1(12),
RQCFG_100219_.tb5_2(12),
RQCFG_100219_.tb5_3(12),
RQCFG_100219_.tb5_4(12),
'N'
,
'Y'
,
11,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(13):=1082837;
RQCFG_100219_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(13):=RQCFG_100219_.tb3_0(13);
RQCFG_100219_.old_tb3_1(13):=3334;
RQCFG_100219_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(13),-1)));
RQCFG_100219_.old_tb3_2(13):=220;
RQCFG_100219_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(13),-1)));
RQCFG_100219_.old_tb3_3(13):=null;
RQCFG_100219_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(13),-1)));
RQCFG_100219_.old_tb3_4(13):=null;
RQCFG_100219_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(13),-1)));
RQCFG_100219_.tb3_5(13):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(13):=null;
RQCFG_100219_.tb3_6(13):=NULL;
RQCFG_100219_.old_tb3_7(13):=null;
RQCFG_100219_.tb3_7(13):=NULL;
RQCFG_100219_.old_tb3_8(13):=null;
RQCFG_100219_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(13),
RQCFG_100219_.tb3_1(13),
RQCFG_100219_.tb3_2(13),
RQCFG_100219_.tb3_3(13),
RQCFG_100219_.tb3_4(13),
RQCFG_100219_.tb3_5(13),
RQCFG_100219_.tb3_6(13),
RQCFG_100219_.tb3_7(13),
RQCFG_100219_.tb3_8(13),
null,
103435,
12,
'Identificador de Distribuci¿n Administrativa'
,
'N'
,
'N'
,
'N'
,
12,
null,
null);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(13):=1285933;
RQCFG_100219_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(13):=RQCFG_100219_.tb5_0(13);
RQCFG_100219_.old_tb5_1(13):=220;
RQCFG_100219_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(13),-1)));
RQCFG_100219_.old_tb5_2(13):=null;
RQCFG_100219_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(13),-1)));
RQCFG_100219_.tb5_3(13):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(13):=RQCFG_100219_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(13),
RQCFG_100219_.tb5_1(13),
RQCFG_100219_.tb5_2(13),
RQCFG_100219_.tb5_3(13),
RQCFG_100219_.tb5_4(13),
'N'
,
'Y'
,
12,
'N'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(14):=1082838;
RQCFG_100219_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(14):=RQCFG_100219_.tb3_0(14);
RQCFG_100219_.old_tb3_1(14):=3334;
RQCFG_100219_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(14),-1)));
RQCFG_100219_.old_tb3_2(14):=524;
RQCFG_100219_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(14),-1)));
RQCFG_100219_.old_tb3_3(14):=null;
RQCFG_100219_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(14),-1)));
RQCFG_100219_.old_tb3_4(14):=null;
RQCFG_100219_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(14),-1)));
RQCFG_100219_.tb3_5(14):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(14):=null;
RQCFG_100219_.tb3_6(14):=NULL;
RQCFG_100219_.old_tb3_7(14):=null;
RQCFG_100219_.tb3_7(14):=NULL;
RQCFG_100219_.old_tb3_8(14):=null;
RQCFG_100219_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(14),
RQCFG_100219_.tb3_1(14),
RQCFG_100219_.tb3_2(14),
RQCFG_100219_.tb3_3(14),
RQCFG_100219_.tb3_4(14),
RQCFG_100219_.tb3_5(14),
RQCFG_100219_.tb3_6(14),
RQCFG_100219_.tb3_7(14),
RQCFG_100219_.tb3_8(14),
null,
103436,
13,
'Estado del Motivo'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(14):=1285934;
RQCFG_100219_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(14):=RQCFG_100219_.tb5_0(14);
RQCFG_100219_.old_tb5_1(14):=524;
RQCFG_100219_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(14),-1)));
RQCFG_100219_.old_tb5_2(14):=null;
RQCFG_100219_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(14),-1)));
RQCFG_100219_.tb5_3(14):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(14):=RQCFG_100219_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(14),
RQCFG_100219_.tb5_1(14),
RQCFG_100219_.tb5_2(14),
RQCFG_100219_.tb5_3(14),
RQCFG_100219_.tb5_4(14),
'C'
,
'Y'
,
13,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(15):=1082839;
RQCFG_100219_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(15):=RQCFG_100219_.tb3_0(15);
RQCFG_100219_.old_tb3_1(15):=3334;
RQCFG_100219_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(15),-1)));
RQCFG_100219_.old_tb3_2(15):=191;
RQCFG_100219_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(15),-1)));
RQCFG_100219_.old_tb3_3(15):=null;
RQCFG_100219_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(15),-1)));
RQCFG_100219_.old_tb3_4(15):=null;
RQCFG_100219_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(15),-1)));
RQCFG_100219_.tb3_5(15):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(15):=null;
RQCFG_100219_.tb3_6(15):=NULL;
RQCFG_100219_.old_tb3_7(15):=null;
RQCFG_100219_.tb3_7(15):=NULL;
RQCFG_100219_.old_tb3_8(15):=null;
RQCFG_100219_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(15),
RQCFG_100219_.tb3_1(15),
RQCFG_100219_.tb3_2(15),
RQCFG_100219_.tb3_3(15),
RQCFG_100219_.tb3_4(15),
RQCFG_100219_.tb3_5(15),
RQCFG_100219_.tb3_6(15),
RQCFG_100219_.tb3_7(15),
RQCFG_100219_.tb3_8(15),
null,
103437,
14,
'Identificador del Tipo de Motivo'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(15):=1285935;
RQCFG_100219_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(15):=RQCFG_100219_.tb5_0(15);
RQCFG_100219_.old_tb5_1(15):=191;
RQCFG_100219_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(15),-1)));
RQCFG_100219_.old_tb5_2(15):=null;
RQCFG_100219_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(15),-1)));
RQCFG_100219_.tb5_3(15):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(15):=RQCFG_100219_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(15),
RQCFG_100219_.tb5_1(15),
RQCFG_100219_.tb5_2(15),
RQCFG_100219_.tb5_3(15),
RQCFG_100219_.tb5_4(15),
'C'
,
'Y'
,
14,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(16):=1082840;
RQCFG_100219_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(16):=RQCFG_100219_.tb3_0(16);
RQCFG_100219_.old_tb3_1(16):=3334;
RQCFG_100219_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(16),-1)));
RQCFG_100219_.old_tb3_2(16):=192;
RQCFG_100219_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(16),-1)));
RQCFG_100219_.old_tb3_3(16):=null;
RQCFG_100219_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(16),-1)));
RQCFG_100219_.old_tb3_4(16):=null;
RQCFG_100219_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(16),-1)));
RQCFG_100219_.tb3_5(16):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(16):=null;
RQCFG_100219_.tb3_6(16):=NULL;
RQCFG_100219_.old_tb3_7(16):=null;
RQCFG_100219_.tb3_7(16):=NULL;
RQCFG_100219_.old_tb3_8(16):=null;
RQCFG_100219_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(16),
RQCFG_100219_.tb3_1(16),
RQCFG_100219_.tb3_2(16),
RQCFG_100219_.tb3_3(16),
RQCFG_100219_.tb3_4(16),
RQCFG_100219_.tb3_5(16),
RQCFG_100219_.tb3_6(16),
RQCFG_100219_.tb3_7(16),
RQCFG_100219_.tb3_8(16),
null,
103438,
15,
'Identificador del Tipo de Producto'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(16):=1285936;
RQCFG_100219_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(16):=RQCFG_100219_.tb5_0(16);
RQCFG_100219_.old_tb5_1(16):=192;
RQCFG_100219_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(16),-1)));
RQCFG_100219_.old_tb5_2(16):=null;
RQCFG_100219_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(16),-1)));
RQCFG_100219_.tb5_3(16):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(16):=RQCFG_100219_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(16),
RQCFG_100219_.tb5_1(16),
RQCFG_100219_.tb5_2(16),
RQCFG_100219_.tb5_3(16),
RQCFG_100219_.tb5_4(16),
'C'
,
'Y'
,
15,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(17):=1082841;
RQCFG_100219_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(17):=RQCFG_100219_.tb3_0(17);
RQCFG_100219_.old_tb3_1(17):=3334;
RQCFG_100219_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(17),-1)));
RQCFG_100219_.old_tb3_2(17):=4011;
RQCFG_100219_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(17),-1)));
RQCFG_100219_.old_tb3_3(17):=null;
RQCFG_100219_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(17),-1)));
RQCFG_100219_.old_tb3_4(17):=null;
RQCFG_100219_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(17),-1)));
RQCFG_100219_.tb3_5(17):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(17):=null;
RQCFG_100219_.tb3_6(17):=NULL;
RQCFG_100219_.old_tb3_7(17):=null;
RQCFG_100219_.tb3_7(17):=NULL;
RQCFG_100219_.old_tb3_8(17):=null;
RQCFG_100219_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(17),
RQCFG_100219_.tb3_1(17),
RQCFG_100219_.tb3_2(17),
RQCFG_100219_.tb3_3(17),
RQCFG_100219_.tb3_4(17),
RQCFG_100219_.tb3_5(17),
RQCFG_100219_.tb3_6(17),
RQCFG_100219_.tb3_7(17),
RQCFG_100219_.tb3_8(17),
null,
103439,
16,
'N¿mero del Servicio'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(17):=1285937;
RQCFG_100219_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(17):=RQCFG_100219_.tb5_0(17);
RQCFG_100219_.old_tb5_1(17):=4011;
RQCFG_100219_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(17),-1)));
RQCFG_100219_.old_tb5_2(17):=null;
RQCFG_100219_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(17),-1)));
RQCFG_100219_.tb5_3(17):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(17):=RQCFG_100219_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(17),
RQCFG_100219_.tb5_1(17),
RQCFG_100219_.tb5_2(17),
RQCFG_100219_.tb5_3(17),
RQCFG_100219_.tb5_4(17),
'C'
,
'Y'
,
16,
'Y'
,
'N¿mero del Servicio'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(18):=1082842;
RQCFG_100219_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(18):=RQCFG_100219_.tb3_0(18);
RQCFG_100219_.old_tb3_1(18):=3334;
RQCFG_100219_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(18),-1)));
RQCFG_100219_.old_tb3_2(18):=187;
RQCFG_100219_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(18),-1)));
RQCFG_100219_.old_tb3_3(18):=null;
RQCFG_100219_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(18),-1)));
RQCFG_100219_.old_tb3_4(18):=null;
RQCFG_100219_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(18),-1)));
RQCFG_100219_.tb3_5(18):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(18):=121057143;
RQCFG_100219_.tb3_6(18):=NULL;
RQCFG_100219_.old_tb3_7(18):=null;
RQCFG_100219_.tb3_7(18):=NULL;
RQCFG_100219_.old_tb3_8(18):=null;
RQCFG_100219_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(18),
RQCFG_100219_.tb3_1(18),
RQCFG_100219_.tb3_2(18),
RQCFG_100219_.tb3_3(18),
RQCFG_100219_.tb3_4(18),
RQCFG_100219_.tb3_5(18),
RQCFG_100219_.tb3_6(18),
RQCFG_100219_.tb3_7(18),
RQCFG_100219_.tb3_8(18),
null,
103415,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(18):=1285938;
RQCFG_100219_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(18):=RQCFG_100219_.tb5_0(18);
RQCFG_100219_.old_tb5_1(18):=187;
RQCFG_100219_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(18),-1)));
RQCFG_100219_.old_tb5_2(18):=null;
RQCFG_100219_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(18),-1)));
RQCFG_100219_.tb5_3(18):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(18):=RQCFG_100219_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(18),
RQCFG_100219_.tb5_1(18),
RQCFG_100219_.tb5_2(18),
RQCFG_100219_.tb5_3(18),
RQCFG_100219_.tb5_4(18),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(19):=1082843;
RQCFG_100219_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(19):=RQCFG_100219_.tb3_0(19);
RQCFG_100219_.old_tb3_1(19):=3334;
RQCFG_100219_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(19),-1)));
RQCFG_100219_.old_tb3_2(19):=213;
RQCFG_100219_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(19),-1)));
RQCFG_100219_.old_tb3_3(19):=255;
RQCFG_100219_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(19),-1)));
RQCFG_100219_.old_tb3_4(19):=null;
RQCFG_100219_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(19),-1)));
RQCFG_100219_.tb3_5(19):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(19):=null;
RQCFG_100219_.tb3_6(19):=NULL;
RQCFG_100219_.old_tb3_7(19):=null;
RQCFG_100219_.tb3_7(19):=NULL;
RQCFG_100219_.old_tb3_8(19):=null;
RQCFG_100219_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(19),
RQCFG_100219_.tb3_1(19),
RQCFG_100219_.tb3_2(19),
RQCFG_100219_.tb3_3(19),
RQCFG_100219_.tb3_4(19),
RQCFG_100219_.tb3_5(19),
RQCFG_100219_.tb3_6(19),
RQCFG_100219_.tb3_7(19),
RQCFG_100219_.tb3_8(19),
null,
103418,
2,
'Identificador del Paquete'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(19):=1285939;
RQCFG_100219_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(19):=RQCFG_100219_.tb5_0(19);
RQCFG_100219_.old_tb5_1(19):=213;
RQCFG_100219_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(19),-1)));
RQCFG_100219_.old_tb5_2(19):=null;
RQCFG_100219_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(19),-1)));
RQCFG_100219_.tb5_3(19):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(19):=RQCFG_100219_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(19),
RQCFG_100219_.tb5_1(19),
RQCFG_100219_.tb5_2(19),
RQCFG_100219_.tb5_3(19),
RQCFG_100219_.tb5_4(19),
'C'
,
'Y'
,
2,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(20):=1082844;
RQCFG_100219_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(20):=RQCFG_100219_.tb3_0(20);
RQCFG_100219_.old_tb3_1(20):=3334;
RQCFG_100219_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(20),-1)));
RQCFG_100219_.old_tb3_2(20):=203;
RQCFG_100219_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(20),-1)));
RQCFG_100219_.old_tb3_3(20):=null;
RQCFG_100219_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(20),-1)));
RQCFG_100219_.old_tb3_4(20):=null;
RQCFG_100219_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(20),-1)));
RQCFG_100219_.tb3_5(20):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(20):=121057144;
RQCFG_100219_.tb3_6(20):=NULL;
RQCFG_100219_.old_tb3_7(20):=null;
RQCFG_100219_.tb3_7(20):=NULL;
RQCFG_100219_.old_tb3_8(20):=null;
RQCFG_100219_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(20),
RQCFG_100219_.tb3_1(20),
RQCFG_100219_.tb3_2(20),
RQCFG_100219_.tb3_3(20),
RQCFG_100219_.tb3_4(20),
RQCFG_100219_.tb3_5(20),
RQCFG_100219_.tb3_6(20),
RQCFG_100219_.tb3_7(20),
RQCFG_100219_.tb3_8(20),
null,
103419,
3,
'Prioridad'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(20):=1285940;
RQCFG_100219_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(20):=RQCFG_100219_.tb5_0(20);
RQCFG_100219_.old_tb5_1(20):=203;
RQCFG_100219_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(20),-1)));
RQCFG_100219_.old_tb5_2(20):=null;
RQCFG_100219_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(20),-1)));
RQCFG_100219_.tb5_3(20):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(20):=RQCFG_100219_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(20),
RQCFG_100219_.tb5_1(20),
RQCFG_100219_.tb5_2(20),
RQCFG_100219_.tb5_3(20),
RQCFG_100219_.tb5_4(20),
'C'
,
'Y'
,
3,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(21):=1082845;
RQCFG_100219_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(21):=RQCFG_100219_.tb3_0(21);
RQCFG_100219_.old_tb3_1(21):=3334;
RQCFG_100219_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(21),-1)));
RQCFG_100219_.old_tb3_2(21):=322;
RQCFG_100219_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(21),-1)));
RQCFG_100219_.old_tb3_3(21):=null;
RQCFG_100219_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(21),-1)));
RQCFG_100219_.old_tb3_4(21):=null;
RQCFG_100219_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(21),-1)));
RQCFG_100219_.tb3_5(21):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(21):=121057145;
RQCFG_100219_.tb3_6(21):=NULL;
RQCFG_100219_.old_tb3_7(21):=null;
RQCFG_100219_.tb3_7(21):=NULL;
RQCFG_100219_.old_tb3_8(21):=null;
RQCFG_100219_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(21),
RQCFG_100219_.tb3_1(21),
RQCFG_100219_.tb3_2(21),
RQCFG_100219_.tb3_3(21),
RQCFG_100219_.tb3_4(21),
RQCFG_100219_.tb3_5(21),
RQCFG_100219_.tb3_6(21),
RQCFG_100219_.tb3_7(21),
RQCFG_100219_.tb3_8(21),
null,
103420,
4,
'Entregas Parciales'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(21):=1285941;
RQCFG_100219_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(21):=RQCFG_100219_.tb5_0(21);
RQCFG_100219_.old_tb5_1(21):=322;
RQCFG_100219_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(21),-1)));
RQCFG_100219_.old_tb5_2(21):=null;
RQCFG_100219_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(21),-1)));
RQCFG_100219_.tb5_3(21):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(21):=RQCFG_100219_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(21),
RQCFG_100219_.tb5_1(21),
RQCFG_100219_.tb5_2(21),
RQCFG_100219_.tb5_3(21),
RQCFG_100219_.tb5_4(21),
'C'
,
'Y'
,
4,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(22):=1082846;
RQCFG_100219_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(22):=RQCFG_100219_.tb3_0(22);
RQCFG_100219_.old_tb3_1(22):=3334;
RQCFG_100219_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(22),-1)));
RQCFG_100219_.old_tb3_2(22):=2641;
RQCFG_100219_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(22),-1)));
RQCFG_100219_.old_tb3_3(22):=null;
RQCFG_100219_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(22),-1)));
RQCFG_100219_.old_tb3_4(22):=null;
RQCFG_100219_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(22),-1)));
RQCFG_100219_.tb3_5(22):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(22):=null;
RQCFG_100219_.tb3_6(22):=NULL;
RQCFG_100219_.old_tb3_7(22):=null;
RQCFG_100219_.tb3_7(22):=NULL;
RQCFG_100219_.old_tb3_8(22):=null;
RQCFG_100219_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(22),
RQCFG_100219_.tb3_1(22),
RQCFG_100219_.tb3_2(22),
RQCFG_100219_.tb3_3(22),
RQCFG_100219_.tb3_4(22),
RQCFG_100219_.tb3_5(22),
RQCFG_100219_.tb3_6(22),
RQCFG_100219_.tb3_7(22),
RQCFG_100219_.tb3_8(22),
null,
103421,
5,
'L¿mite de Cr¿dito'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(22):=1285942;
RQCFG_100219_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(22):=RQCFG_100219_.tb5_0(22);
RQCFG_100219_.old_tb5_1(22):=2641;
RQCFG_100219_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(22),-1)));
RQCFG_100219_.old_tb5_2(22):=null;
RQCFG_100219_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(22),-1)));
RQCFG_100219_.tb5_3(22):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(22):=RQCFG_100219_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(22),
RQCFG_100219_.tb5_1(22),
RQCFG_100219_.tb5_2(22),
RQCFG_100219_.tb5_3(22),
RQCFG_100219_.tb5_4(22),
'N'
,
'Y'
,
5,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(23):=1082847;
RQCFG_100219_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(23):=RQCFG_100219_.tb3_0(23);
RQCFG_100219_.old_tb3_1(23):=3334;
RQCFG_100219_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(23),-1)));
RQCFG_100219_.old_tb3_2(23):=197;
RQCFG_100219_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(23),-1)));
RQCFG_100219_.old_tb3_3(23):=null;
RQCFG_100219_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(23),-1)));
RQCFG_100219_.old_tb3_4(23):=null;
RQCFG_100219_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(23),-1)));
RQCFG_100219_.tb3_5(23):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(23):=null;
RQCFG_100219_.tb3_6(23):=NULL;
RQCFG_100219_.old_tb3_7(23):=null;
RQCFG_100219_.tb3_7(23):=NULL;
RQCFG_100219_.old_tb3_8(23):=null;
RQCFG_100219_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(23),
RQCFG_100219_.tb3_1(23),
RQCFG_100219_.tb3_2(23),
RQCFG_100219_.tb3_3(23),
RQCFG_100219_.tb3_4(23),
RQCFG_100219_.tb3_5(23),
RQCFG_100219_.tb3_6(23),
RQCFG_100219_.tb3_7(23),
RQCFG_100219_.tb3_8(23),
null,
103422,
6,
'PRIVACY_FLAG'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(23):=1285943;
RQCFG_100219_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(23):=RQCFG_100219_.tb5_0(23);
RQCFG_100219_.old_tb5_1(23):=197;
RQCFG_100219_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(23),-1)));
RQCFG_100219_.old_tb5_2(23):=null;
RQCFG_100219_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(23),-1)));
RQCFG_100219_.tb5_3(23):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(23):=RQCFG_100219_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(23),
RQCFG_100219_.tb5_1(23),
RQCFG_100219_.tb5_2(23),
RQCFG_100219_.tb5_3(23),
RQCFG_100219_.tb5_4(23),
'N'
,
'N'
,
6,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(24):=1082848;
RQCFG_100219_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(24):=RQCFG_100219_.tb3_0(24);
RQCFG_100219_.old_tb3_1(24):=3334;
RQCFG_100219_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(24),-1)));
RQCFG_100219_.old_tb3_2(24):=189;
RQCFG_100219_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(24),-1)));
RQCFG_100219_.old_tb3_3(24):=255;
RQCFG_100219_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(24),-1)));
RQCFG_100219_.old_tb3_4(24):=null;
RQCFG_100219_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(24),-1)));
RQCFG_100219_.tb3_5(24):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(24):=null;
RQCFG_100219_.tb3_6(24):=NULL;
RQCFG_100219_.old_tb3_7(24):=null;
RQCFG_100219_.tb3_7(24):=NULL;
RQCFG_100219_.old_tb3_8(24):=null;
RQCFG_100219_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(24),
RQCFG_100219_.tb3_1(24),
RQCFG_100219_.tb3_2(24),
RQCFG_100219_.tb3_3(24),
RQCFG_100219_.tb3_4(24),
RQCFG_100219_.tb3_5(24),
RQCFG_100219_.tb3_6(24),
RQCFG_100219_.tb3_7(24),
RQCFG_100219_.tb3_8(24),
null,
103423,
7,
'N¿mero Petici¿n Atenci¿n al cliente'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(24):=1285944;
RQCFG_100219_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(24):=RQCFG_100219_.tb5_0(24);
RQCFG_100219_.old_tb5_1(24):=189;
RQCFG_100219_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(24),-1)));
RQCFG_100219_.old_tb5_2(24):=null;
RQCFG_100219_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(24),-1)));
RQCFG_100219_.tb5_3(24):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(24):=RQCFG_100219_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(24),
RQCFG_100219_.tb5_1(24),
RQCFG_100219_.tb5_2(24),
RQCFG_100219_.tb5_3(24),
RQCFG_100219_.tb5_4(24),
'C'
,
'Y'
,
7,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(25):=1082849;
RQCFG_100219_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(25):=RQCFG_100219_.tb3_0(25);
RQCFG_100219_.old_tb3_1(25):=3334;
RQCFG_100219_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(25),-1)));
RQCFG_100219_.old_tb3_2(25):=413;
RQCFG_100219_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(25),-1)));
RQCFG_100219_.old_tb3_3(25):=null;
RQCFG_100219_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(25),-1)));
RQCFG_100219_.old_tb3_4(25):=null;
RQCFG_100219_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(25),-1)));
RQCFG_100219_.tb3_5(25):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(25):=null;
RQCFG_100219_.tb3_6(25):=NULL;
RQCFG_100219_.old_tb3_7(25):=null;
RQCFG_100219_.tb3_7(25):=NULL;
RQCFG_100219_.old_tb3_8(25):=null;
RQCFG_100219_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(25),
RQCFG_100219_.tb3_1(25),
RQCFG_100219_.tb3_2(25),
RQCFG_100219_.tb3_3(25),
RQCFG_100219_.tb3_4(25),
RQCFG_100219_.tb3_5(25),
RQCFG_100219_.tb3_6(25),
RQCFG_100219_.tb3_7(25),
RQCFG_100219_.tb3_8(25),
null,
103424,
8,
'PRODUCT_ID'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(25):=1285945;
RQCFG_100219_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(25):=RQCFG_100219_.tb5_0(25);
RQCFG_100219_.old_tb5_1(25):=413;
RQCFG_100219_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(25),-1)));
RQCFG_100219_.old_tb5_2(25):=null;
RQCFG_100219_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(25),-1)));
RQCFG_100219_.tb5_3(25):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(25):=RQCFG_100219_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(25),
RQCFG_100219_.tb5_1(25),
RQCFG_100219_.tb5_2(25),
RQCFG_100219_.tb5_3(25),
RQCFG_100219_.tb5_4(25),
'N'
,
'N'
,
8,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(26):=1082850;
RQCFG_100219_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(26):=RQCFG_100219_.tb3_0(26);
RQCFG_100219_.old_tb3_1(26):=3334;
RQCFG_100219_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(26),-1)));
RQCFG_100219_.old_tb3_2(26):=50001324;
RQCFG_100219_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(26),-1)));
RQCFG_100219_.old_tb3_3(26):=null;
RQCFG_100219_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(26),-1)));
RQCFG_100219_.old_tb3_4(26):=null;
RQCFG_100219_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(26),-1)));
RQCFG_100219_.tb3_5(26):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(26):=null;
RQCFG_100219_.tb3_6(26):=NULL;
RQCFG_100219_.old_tb3_7(26):=null;
RQCFG_100219_.tb3_7(26):=NULL;
RQCFG_100219_.old_tb3_8(26):=null;
RQCFG_100219_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(26),
RQCFG_100219_.tb3_1(26),
RQCFG_100219_.tb3_2(26),
RQCFG_100219_.tb3_3(26),
RQCFG_100219_.tb3_4(26),
RQCFG_100219_.tb3_5(26),
RQCFG_100219_.tb3_6(26),
RQCFG_100219_.tb3_7(26),
RQCFG_100219_.tb3_8(26),
null,
103425,
9,
'Ubicaci¿n Geogr¿fica'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(26):=1285946;
RQCFG_100219_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(26):=RQCFG_100219_.tb5_0(26);
RQCFG_100219_.old_tb5_1(26):=50001324;
RQCFG_100219_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(26),-1)));
RQCFG_100219_.old_tb5_2(26):=null;
RQCFG_100219_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(26),-1)));
RQCFG_100219_.tb5_3(26):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(26):=RQCFG_100219_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(26),
RQCFG_100219_.tb5_1(26),
RQCFG_100219_.tb5_2(26),
RQCFG_100219_.tb5_3(26),
RQCFG_100219_.tb5_4(26),
'C'
,
'Y'
,
9,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(27):=1082851;
RQCFG_100219_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(27):=RQCFG_100219_.tb3_0(27);
RQCFG_100219_.old_tb3_1(27):=3334;
RQCFG_100219_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(27),-1)));
RQCFG_100219_.old_tb3_2(27):=198;
RQCFG_100219_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(27),-1)));
RQCFG_100219_.old_tb3_3(27):=null;
RQCFG_100219_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(27),-1)));
RQCFG_100219_.old_tb3_4(27):=null;
RQCFG_100219_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(27),-1)));
RQCFG_100219_.tb3_5(27):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(27):=121057146;
RQCFG_100219_.tb3_6(27):=NULL;
RQCFG_100219_.old_tb3_7(27):=null;
RQCFG_100219_.tb3_7(27):=NULL;
RQCFG_100219_.old_tb3_8(27):=null;
RQCFG_100219_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(27),
RQCFG_100219_.tb3_1(27),
RQCFG_100219_.tb3_2(27),
RQCFG_100219_.tb3_3(27),
RQCFG_100219_.tb3_4(27),
RQCFG_100219_.tb3_5(27),
RQCFG_100219_.tb3_6(27),
RQCFG_100219_.tb3_7(27),
RQCFG_100219_.tb3_8(27),
null,
103433,
10,
'Provisional'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(27):=1285947;
RQCFG_100219_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(27):=RQCFG_100219_.tb5_0(27);
RQCFG_100219_.old_tb5_1(27):=198;
RQCFG_100219_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(27),-1)));
RQCFG_100219_.old_tb5_2(27):=null;
RQCFG_100219_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(27),-1)));
RQCFG_100219_.tb5_3(27):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(27):=RQCFG_100219_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(27),
RQCFG_100219_.tb5_1(27),
RQCFG_100219_.tb5_2(27),
RQCFG_100219_.tb5_3(27),
RQCFG_100219_.tb5_4(27),
'C'
,
'N'
,
10,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(28):=1082852;
RQCFG_100219_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(28):=RQCFG_100219_.tb3_0(28);
RQCFG_100219_.old_tb3_1(28):=3334;
RQCFG_100219_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(28),-1)));
RQCFG_100219_.old_tb3_2(28):=11403;
RQCFG_100219_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(28),-1)));
RQCFG_100219_.old_tb3_3(28):=1111;
RQCFG_100219_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(28),-1)));
RQCFG_100219_.old_tb3_4(28):=null;
RQCFG_100219_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(28),-1)));
RQCFG_100219_.tb3_5(28):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(28):=null;
RQCFG_100219_.tb3_6(28):=NULL;
RQCFG_100219_.old_tb3_7(28):=null;
RQCFG_100219_.tb3_7(28):=NULL;
RQCFG_100219_.old_tb3_8(28):=null;
RQCFG_100219_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(28),
RQCFG_100219_.tb3_1(28),
RQCFG_100219_.tb3_2(28),
RQCFG_100219_.tb3_3(28),
RQCFG_100219_.tb3_4(28),
RQCFG_100219_.tb3_5(28),
RQCFG_100219_.tb3_6(28),
RQCFG_100219_.tb3_7(28),
RQCFG_100219_.tb3_8(28),
null,
103440,
17,
'Identificador de la Suscripci¿n'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(28):=1285948;
RQCFG_100219_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(28):=RQCFG_100219_.tb5_0(28);
RQCFG_100219_.old_tb5_1(28):=11403;
RQCFG_100219_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(28),-1)));
RQCFG_100219_.old_tb5_2(28):=null;
RQCFG_100219_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(28),-1)));
RQCFG_100219_.tb5_3(28):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(28):=RQCFG_100219_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(28),
RQCFG_100219_.tb5_1(28),
RQCFG_100219_.tb5_2(28),
RQCFG_100219_.tb5_3(28),
RQCFG_100219_.tb5_4(28),
'C'
,
'N'
,
17,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(29):=1082853;
RQCFG_100219_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(29):=RQCFG_100219_.tb3_0(29);
RQCFG_100219_.old_tb3_1(29):=3334;
RQCFG_100219_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(29),-1)));
RQCFG_100219_.old_tb3_2(29):=6683;
RQCFG_100219_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(29),-1)));
RQCFG_100219_.old_tb3_3(29):=null;
RQCFG_100219_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(29),-1)));
RQCFG_100219_.old_tb3_4(29):=null;
RQCFG_100219_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(29),-1)));
RQCFG_100219_.tb3_5(29):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(29):=null;
RQCFG_100219_.tb3_6(29):=NULL;
RQCFG_100219_.old_tb3_7(29):=null;
RQCFG_100219_.tb3_7(29):=NULL;
RQCFG_100219_.old_tb3_8(29):=null;
RQCFG_100219_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(29),
RQCFG_100219_.tb3_1(29),
RQCFG_100219_.tb3_2(29),
RQCFG_100219_.tb3_3(29),
RQCFG_100219_.tb3_4(29),
RQCFG_100219_.tb3_5(29),
RQCFG_100219_.tb3_6(29),
RQCFG_100219_.tb3_7(29),
RQCFG_100219_.tb3_8(29),
null,
103441,
18,
'CLIENT_PRIVACY_FLAG'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(29):=1285949;
RQCFG_100219_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(29):=RQCFG_100219_.tb5_0(29);
RQCFG_100219_.old_tb5_1(29):=6683;
RQCFG_100219_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(29),-1)));
RQCFG_100219_.old_tb5_2(29):=null;
RQCFG_100219_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(29),-1)));
RQCFG_100219_.tb5_3(29):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(29):=RQCFG_100219_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(29),
RQCFG_100219_.tb5_1(29),
RQCFG_100219_.tb5_2(29),
RQCFG_100219_.tb5_3(29),
RQCFG_100219_.tb5_4(29),
'N'
,
'N'
,
18,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(30):=1082854;
RQCFG_100219_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(30):=RQCFG_100219_.tb3_0(30);
RQCFG_100219_.old_tb3_1(30):=3334;
RQCFG_100219_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(30),-1)));
RQCFG_100219_.old_tb3_2(30):=20362;
RQCFG_100219_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(30),-1)));
RQCFG_100219_.old_tb3_3(30):=null;
RQCFG_100219_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(30),-1)));
RQCFG_100219_.old_tb3_4(30):=null;
RQCFG_100219_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(30),-1)));
RQCFG_100219_.tb3_5(30):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(30):=121057147;
RQCFG_100219_.tb3_6(30):=NULL;
RQCFG_100219_.old_tb3_7(30):=null;
RQCFG_100219_.tb3_7(30):=NULL;
RQCFG_100219_.old_tb3_8(30):=null;
RQCFG_100219_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(30),
RQCFG_100219_.tb3_1(30),
RQCFG_100219_.tb3_2(30),
RQCFG_100219_.tb3_3(30),
RQCFG_100219_.tb3_4(30),
RQCFG_100219_.tb3_5(30),
RQCFG_100219_.tb3_6(30),
RQCFG_100219_.tb3_7(30),
RQCFG_100219_.tb3_8(30),
null,
103442,
19,
'Valor a cobrar'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(30):=1285950;
RQCFG_100219_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(30):=RQCFG_100219_.tb5_0(30);
RQCFG_100219_.old_tb5_1(30):=20362;
RQCFG_100219_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(30),-1)));
RQCFG_100219_.old_tb5_2(30):=null;
RQCFG_100219_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(30),-1)));
RQCFG_100219_.tb5_3(30):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(30):=RQCFG_100219_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(30),
RQCFG_100219_.tb5_1(30),
RQCFG_100219_.tb5_2(30),
RQCFG_100219_.tb5_3(30),
RQCFG_100219_.tb5_4(30),
'C'
,
'Y'
,
19,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(31):=1082855;
RQCFG_100219_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(31):=RQCFG_100219_.tb3_0(31);
RQCFG_100219_.old_tb3_1(31):=3334;
RQCFG_100219_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(31),-1)));
RQCFG_100219_.old_tb3_2(31):=45189;
RQCFG_100219_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(31),-1)));
RQCFG_100219_.old_tb3_3(31):=null;
RQCFG_100219_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(31),-1)));
RQCFG_100219_.old_tb3_4(31):=null;
RQCFG_100219_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(31),-1)));
RQCFG_100219_.tb3_5(31):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(31):=121057148;
RQCFG_100219_.tb3_6(31):=NULL;
RQCFG_100219_.old_tb3_7(31):=null;
RQCFG_100219_.tb3_7(31):=NULL;
RQCFG_100219_.old_tb3_8(31):=null;
RQCFG_100219_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(31),
RQCFG_100219_.tb3_1(31),
RQCFG_100219_.tb3_2(31),
RQCFG_100219_.tb3_3(31),
RQCFG_100219_.tb3_4(31),
RQCFG_100219_.tb3_5(31),
RQCFG_100219_.tb3_6(31),
RQCFG_100219_.tb3_7(31),
RQCFG_100219_.tb3_8(31),
null,
103443,
20,
'Identificador Plan Comercial'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(31):=1285951;
RQCFG_100219_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(31):=RQCFG_100219_.tb5_0(31);
RQCFG_100219_.old_tb5_1(31):=45189;
RQCFG_100219_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(31),-1)));
RQCFG_100219_.old_tb5_2(31):=null;
RQCFG_100219_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(31),-1)));
RQCFG_100219_.tb5_3(31):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(31):=RQCFG_100219_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(31),
RQCFG_100219_.tb5_1(31),
RQCFG_100219_.tb5_2(31),
RQCFG_100219_.tb5_3(31),
RQCFG_100219_.tb5_4(31),
'C'
,
'Y'
,
20,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(32):=1082856;
RQCFG_100219_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(32):=RQCFG_100219_.tb3_0(32);
RQCFG_100219_.old_tb3_1(32):=3334;
RQCFG_100219_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(32),-1)));
RQCFG_100219_.old_tb3_2(32):=144591;
RQCFG_100219_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(32),-1)));
RQCFG_100219_.old_tb3_3(32):=null;
RQCFG_100219_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(32),-1)));
RQCFG_100219_.old_tb3_4(32):=null;
RQCFG_100219_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(32),-1)));
RQCFG_100219_.tb3_5(32):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(32):=null;
RQCFG_100219_.tb3_6(32):=NULL;
RQCFG_100219_.old_tb3_7(32):=null;
RQCFG_100219_.tb3_7(32):=NULL;
RQCFG_100219_.old_tb3_8(32):=120029764;
RQCFG_100219_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(32),
RQCFG_100219_.tb3_1(32),
RQCFG_100219_.tb3_2(32),
RQCFG_100219_.tb3_3(32),
RQCFG_100219_.tb3_4(32),
RQCFG_100219_.tb3_5(32),
RQCFG_100219_.tb3_6(32),
RQCFG_100219_.tb3_7(32),
RQCFG_100219_.tb3_8(32),
null,
103408,
0,
'Respuesta '
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(32):=1285952;
RQCFG_100219_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(32):=RQCFG_100219_.tb5_0(32);
RQCFG_100219_.old_tb5_1(32):=144591;
RQCFG_100219_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(32),-1)));
RQCFG_100219_.old_tb5_2(32):=null;
RQCFG_100219_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(32),-1)));
RQCFG_100219_.tb5_3(32):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(32):=RQCFG_100219_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(32),
RQCFG_100219_.tb5_1(32),
RQCFG_100219_.tb5_2(32),
RQCFG_100219_.tb5_3(32),
RQCFG_100219_.tb5_4(32),
'C'
,
'E'
,
0,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(33):=1082857;
RQCFG_100219_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(33):=RQCFG_100219_.tb3_0(33);
RQCFG_100219_.old_tb3_1(33):=3334;
RQCFG_100219_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(33),-1)));
RQCFG_100219_.old_tb3_2(33):=147336;
RQCFG_100219_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(33),-1)));
RQCFG_100219_.old_tb3_3(33):=440;
RQCFG_100219_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(33),-1)));
RQCFG_100219_.old_tb3_4(33):=null;
RQCFG_100219_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(33),-1)));
RQCFG_100219_.tb3_5(33):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(33):=null;
RQCFG_100219_.tb3_6(33):=NULL;
RQCFG_100219_.old_tb3_7(33):=null;
RQCFG_100219_.tb3_7(33):=NULL;
RQCFG_100219_.old_tb3_8(33):=null;
RQCFG_100219_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(33),
RQCFG_100219_.tb3_1(33),
RQCFG_100219_.tb3_2(33),
RQCFG_100219_.tb3_3(33),
RQCFG_100219_.tb3_4(33),
RQCFG_100219_.tb3_5(33),
RQCFG_100219_.tb3_6(33),
RQCFG_100219_.tb3_7(33),
RQCFG_100219_.tb3_8(33),
null,
103992,
21,
'Categoría'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(33):=1285953;
RQCFG_100219_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(33):=RQCFG_100219_.tb5_0(33);
RQCFG_100219_.old_tb5_1(33):=147336;
RQCFG_100219_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(33),-1)));
RQCFG_100219_.old_tb5_2(33):=null;
RQCFG_100219_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(33),-1)));
RQCFG_100219_.tb5_3(33):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(33):=RQCFG_100219_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(33),
RQCFG_100219_.tb5_1(33),
RQCFG_100219_.tb5_2(33),
RQCFG_100219_.tb5_3(33),
RQCFG_100219_.tb5_4(33),
'C'
,
'Y'
,
21,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(34):=1082858;
RQCFG_100219_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(34):=RQCFG_100219_.tb3_0(34);
RQCFG_100219_.old_tb3_1(34):=3334;
RQCFG_100219_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(34),-1)));
RQCFG_100219_.old_tb3_2(34):=147337;
RQCFG_100219_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(34),-1)));
RQCFG_100219_.old_tb3_3(34):=441;
RQCFG_100219_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(34),-1)));
RQCFG_100219_.old_tb3_4(34):=null;
RQCFG_100219_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(34),-1)));
RQCFG_100219_.tb3_5(34):=RQCFG_100219_.tb2_2(1);
RQCFG_100219_.old_tb3_6(34):=null;
RQCFG_100219_.tb3_6(34):=NULL;
RQCFG_100219_.old_tb3_7(34):=null;
RQCFG_100219_.tb3_7(34):=NULL;
RQCFG_100219_.old_tb3_8(34):=null;
RQCFG_100219_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(34),
RQCFG_100219_.tb3_1(34),
RQCFG_100219_.tb3_2(34),
RQCFG_100219_.tb3_3(34),
RQCFG_100219_.tb3_4(34),
RQCFG_100219_.tb3_5(34),
RQCFG_100219_.tb3_6(34),
RQCFG_100219_.tb3_7(34),
RQCFG_100219_.tb3_8(34),
null,
103995,
22,
'Subcategoría'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(34):=1285954;
RQCFG_100219_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(34):=RQCFG_100219_.tb5_0(34);
RQCFG_100219_.old_tb5_1(34):=147337;
RQCFG_100219_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(34),-1)));
RQCFG_100219_.old_tb5_2(34):=null;
RQCFG_100219_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(34),-1)));
RQCFG_100219_.tb5_3(34):=RQCFG_100219_.tb4_0(1);
RQCFG_100219_.tb5_4(34):=RQCFG_100219_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(34),
RQCFG_100219_.tb5_1(34),
RQCFG_100219_.tb5_2(34),
RQCFG_100219_.tb5_3(34),
RQCFG_100219_.tb5_4(34),
'C'
,
'Y'
,
22,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(35):=1082859;
RQCFG_100219_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(35):=RQCFG_100219_.tb3_0(35);
RQCFG_100219_.old_tb3_1(35):=2036;
RQCFG_100219_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(35),-1)));
RQCFG_100219_.old_tb3_2(35):=441;
RQCFG_100219_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(35),-1)));
RQCFG_100219_.old_tb3_3(35):=null;
RQCFG_100219_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(35),-1)));
RQCFG_100219_.old_tb3_4(35):=null;
RQCFG_100219_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(35),-1)));
RQCFG_100219_.tb3_5(35):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(35):=121057132;
RQCFG_100219_.tb3_6(35):=NULL;
RQCFG_100219_.old_tb3_7(35):=null;
RQCFG_100219_.tb3_7(35):=NULL;
RQCFG_100219_.old_tb3_8(35):=120029761;
RQCFG_100219_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(35),
RQCFG_100219_.tb3_1(35),
RQCFG_100219_.tb3_2(35),
RQCFG_100219_.tb3_3(35),
RQCFG_100219_.tb3_4(35),
RQCFG_100219_.tb3_5(35),
RQCFG_100219_.tb3_6(35),
RQCFG_100219_.tb3_7(35),
RQCFG_100219_.tb3_8(35),
null,
105630,
25,
'Subcategoria'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb4_0(2):=96951;
RQCFG_100219_.tb4_0(2):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100219_.tb4_0(2):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb4_1(2):=RQCFG_100219_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (2)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100219_.tb4_0(2),
RQCFG_100219_.tb4_1(2),
null,
null,
'FRAME-PAQUETE-1032405'
,
1);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(35):=1285955;
RQCFG_100219_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(35):=RQCFG_100219_.tb5_0(35);
RQCFG_100219_.old_tb5_1(35):=441;
RQCFG_100219_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(35),-1)));
RQCFG_100219_.old_tb5_2(35):=null;
RQCFG_100219_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(35),-1)));
RQCFG_100219_.tb5_3(35):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(35):=RQCFG_100219_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(35),
RQCFG_100219_.tb5_1(35),
RQCFG_100219_.tb5_2(35),
RQCFG_100219_.tb5_3(35),
RQCFG_100219_.tb5_4(35),
'C'
,
'Y'
,
25,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(36):=1082860;
RQCFG_100219_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(36):=RQCFG_100219_.tb3_0(36);
RQCFG_100219_.old_tb3_1(36):=2036;
RQCFG_100219_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(36),-1)));
RQCFG_100219_.old_tb3_2(36):=282;
RQCFG_100219_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(36),-1)));
RQCFG_100219_.old_tb3_3(36):=null;
RQCFG_100219_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(36),-1)));
RQCFG_100219_.old_tb3_4(36):=null;
RQCFG_100219_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(36),-1)));
RQCFG_100219_.tb3_5(36):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(36):=121057126;
RQCFG_100219_.tb3_6(36):=NULL;
RQCFG_100219_.old_tb3_7(36):=null;
RQCFG_100219_.tb3_7(36):=NULL;
RQCFG_100219_.old_tb3_8(36):=null;
RQCFG_100219_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(36),
RQCFG_100219_.tb3_1(36),
RQCFG_100219_.tb3_2(36),
RQCFG_100219_.tb3_3(36),
RQCFG_100219_.tb3_4(36),
RQCFG_100219_.tb3_5(36),
RQCFG_100219_.tb3_6(36),
RQCFG_100219_.tb3_7(36),
RQCFG_100219_.tb3_8(36),
null,
105542,
18,
'Direcci¿n'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(36):=1285956;
RQCFG_100219_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(36):=RQCFG_100219_.tb5_0(36);
RQCFG_100219_.old_tb5_1(36):=282;
RQCFG_100219_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(36),-1)));
RQCFG_100219_.old_tb5_2(36):=null;
RQCFG_100219_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(36),-1)));
RQCFG_100219_.tb5_3(36):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(36):=RQCFG_100219_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(36),
RQCFG_100219_.tb5_1(36),
RQCFG_100219_.tb5_2(36),
RQCFG_100219_.tb5_3(36),
RQCFG_100219_.tb5_4(36),
'C'
,
'Y'
,
18,
'N'
,
'Direcci¿n'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(37):=1082861;
RQCFG_100219_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(37):=RQCFG_100219_.tb3_0(37);
RQCFG_100219_.old_tb3_1(37):=2036;
RQCFG_100219_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(37),-1)));
RQCFG_100219_.old_tb3_2(37):=106099;
RQCFG_100219_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(37),-1)));
RQCFG_100219_.old_tb3_3(37):=null;
RQCFG_100219_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(37),-1)));
RQCFG_100219_.old_tb3_4(37):=null;
RQCFG_100219_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(37),-1)));
RQCFG_100219_.tb3_5(37):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(37):=121057131;
RQCFG_100219_.tb3_6(37):=NULL;
RQCFG_100219_.old_tb3_7(37):=null;
RQCFG_100219_.tb3_7(37):=NULL;
RQCFG_100219_.old_tb3_8(37):=null;
RQCFG_100219_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(37),
RQCFG_100219_.tb3_1(37),
RQCFG_100219_.tb3_2(37),
RQCFG_100219_.tb3_3(37),
RQCFG_100219_.tb3_4(37),
RQCFG_100219_.tb3_5(37),
RQCFG_100219_.tb3_6(37),
RQCFG_100219_.tb3_7(37),
RQCFG_100219_.tb3_8(37),
null,
105639,
29,
'Identificador'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(37):=1285957;
RQCFG_100219_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(37):=RQCFG_100219_.tb5_0(37);
RQCFG_100219_.old_tb5_1(37):=106099;
RQCFG_100219_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(37),-1)));
RQCFG_100219_.old_tb5_2(37):=null;
RQCFG_100219_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(37),-1)));
RQCFG_100219_.tb5_3(37):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(37):=RQCFG_100219_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(37),
RQCFG_100219_.tb5_1(37),
RQCFG_100219_.tb5_2(37),
RQCFG_100219_.tb5_3(37),
RQCFG_100219_.tb5_4(37),
'C'
,
'Y'
,
29,
'N'
,
'Identificador'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(38):=1082862;
RQCFG_100219_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(38):=RQCFG_100219_.tb3_0(38);
RQCFG_100219_.old_tb3_1(38):=2036;
RQCFG_100219_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(38),-1)));
RQCFG_100219_.old_tb3_2(38):=39945;
RQCFG_100219_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(38),-1)));
RQCFG_100219_.old_tb3_3(38):=null;
RQCFG_100219_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(38),-1)));
RQCFG_100219_.old_tb3_4(38):=null;
RQCFG_100219_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(38),-1)));
RQCFG_100219_.tb3_5(38):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(38):=null;
RQCFG_100219_.tb3_6(38):=NULL;
RQCFG_100219_.old_tb3_7(38):=null;
RQCFG_100219_.tb3_7(38):=NULL;
RQCFG_100219_.old_tb3_8(38):=null;
RQCFG_100219_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(38),
RQCFG_100219_.tb3_1(38),
RQCFG_100219_.tb3_2(38),
RQCFG_100219_.tb3_3(38),
RQCFG_100219_.tb3_4(38),
RQCFG_100219_.tb3_5(38),
RQCFG_100219_.tb3_6(38),
RQCFG_100219_.tb3_7(38),
RQCFG_100219_.tb3_8(38),
null,
105631,
26,
'Código del Paquete'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(38):=1285958;
RQCFG_100219_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(38):=RQCFG_100219_.tb5_0(38);
RQCFG_100219_.old_tb5_1(38):=39945;
RQCFG_100219_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(38),-1)));
RQCFG_100219_.old_tb5_2(38):=null;
RQCFG_100219_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(38),-1)));
RQCFG_100219_.tb5_3(38):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(38):=RQCFG_100219_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(38),
RQCFG_100219_.tb5_1(38),
RQCFG_100219_.tb5_2(38),
RQCFG_100219_.tb5_3(38),
RQCFG_100219_.tb5_4(38),
'C'
,
'Y'
,
26,
'N'
,
'Código del Paquete'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(39):=1082863;
RQCFG_100219_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(39):=RQCFG_100219_.tb3_0(39);
RQCFG_100219_.old_tb3_1(39):=2036;
RQCFG_100219_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(39),-1)));
RQCFG_100219_.old_tb3_2(39):=39946;
RQCFG_100219_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(39),-1)));
RQCFG_100219_.old_tb3_3(39):=255;
RQCFG_100219_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(39),-1)));
RQCFG_100219_.old_tb3_4(39):=null;
RQCFG_100219_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(39),-1)));
RQCFG_100219_.tb3_5(39):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(39):=null;
RQCFG_100219_.tb3_6(39):=NULL;
RQCFG_100219_.old_tb3_7(39):=null;
RQCFG_100219_.tb3_7(39):=NULL;
RQCFG_100219_.old_tb3_8(39):=null;
RQCFG_100219_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(39),
RQCFG_100219_.tb3_1(39),
RQCFG_100219_.tb3_2(39),
RQCFG_100219_.tb3_3(39),
RQCFG_100219_.tb3_4(39),
RQCFG_100219_.tb3_5(39),
RQCFG_100219_.tb3_6(39),
RQCFG_100219_.tb3_7(39),
RQCFG_100219_.tb3_8(39),
null,
105632,
27,
'Código del Paquete Asociado'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(39):=1285959;
RQCFG_100219_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(39):=RQCFG_100219_.tb5_0(39);
RQCFG_100219_.old_tb5_1(39):=39946;
RQCFG_100219_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(39),-1)));
RQCFG_100219_.old_tb5_2(39):=null;
RQCFG_100219_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(39),-1)));
RQCFG_100219_.tb5_3(39):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(39):=RQCFG_100219_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(39),
RQCFG_100219_.tb5_1(39),
RQCFG_100219_.tb5_2(39),
RQCFG_100219_.tb5_3(39),
RQCFG_100219_.tb5_4(39),
'C'
,
'Y'
,
27,
'N'
,
'Código del Paquete Asociado'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(40):=1082864;
RQCFG_100219_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(40):=RQCFG_100219_.tb3_0(40);
RQCFG_100219_.old_tb3_1(40):=2036;
RQCFG_100219_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(40),-1)));
RQCFG_100219_.old_tb3_2(40):=127931;
RQCFG_100219_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(40),-1)));
RQCFG_100219_.old_tb3_3(40):=null;
RQCFG_100219_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(40),-1)));
RQCFG_100219_.old_tb3_4(40):=null;
RQCFG_100219_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(40),-1)));
RQCFG_100219_.tb3_5(40):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(40):=121057130;
RQCFG_100219_.tb3_6(40):=NULL;
RQCFG_100219_.old_tb3_7(40):=null;
RQCFG_100219_.tb3_7(40):=NULL;
RQCFG_100219_.old_tb3_8(40):=null;
RQCFG_100219_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(40),
RQCFG_100219_.tb3_1(40),
RQCFG_100219_.tb3_2(40),
RQCFG_100219_.tb3_3(40),
RQCFG_100219_.tb3_4(40),
RQCFG_100219_.tb3_5(40),
RQCFG_100219_.tb3_6(40),
RQCFG_100219_.tb3_7(40),
RQCFG_100219_.tb3_8(40),
null,
105633,
28,
'Indica si existe dependencia en anulación'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(40):=1285960;
RQCFG_100219_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(40):=RQCFG_100219_.tb5_0(40);
RQCFG_100219_.old_tb5_1(40):=127931;
RQCFG_100219_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(40),-1)));
RQCFG_100219_.old_tb5_2(40):=null;
RQCFG_100219_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(40),-1)));
RQCFG_100219_.tb5_3(40):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(40):=RQCFG_100219_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(40),
RQCFG_100219_.tb5_1(40),
RQCFG_100219_.tb5_2(40),
RQCFG_100219_.tb5_3(40),
RQCFG_100219_.tb5_4(40),
'C'
,
'Y'
,
28,
'N'
,
'Indica si existe dependencia en anulación'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(41):=1082865;
RQCFG_100219_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(41):=RQCFG_100219_.tb3_0(41);
RQCFG_100219_.old_tb3_1(41):=2036;
RQCFG_100219_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(41),-1)));
RQCFG_100219_.old_tb3_2(41):=1111;
RQCFG_100219_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(41),-1)));
RQCFG_100219_.old_tb3_3(41):=null;
RQCFG_100219_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(41),-1)));
RQCFG_100219_.old_tb3_4(41):=null;
RQCFG_100219_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(41),-1)));
RQCFG_100219_.tb3_5(41):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(41):=null;
RQCFG_100219_.tb3_6(41):=NULL;
RQCFG_100219_.old_tb3_7(41):=null;
RQCFG_100219_.tb3_7(41):=NULL;
RQCFG_100219_.old_tb3_8(41):=null;
RQCFG_100219_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(41),
RQCFG_100219_.tb3_1(41),
RQCFG_100219_.tb3_2(41),
RQCFG_100219_.tb3_3(41),
RQCFG_100219_.tb3_4(41),
RQCFG_100219_.tb3_5(41),
RQCFG_100219_.tb3_6(41),
RQCFG_100219_.tb3_7(41),
RQCFG_100219_.tb3_8(41),
null,
105636,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(41):=1285961;
RQCFG_100219_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(41):=RQCFG_100219_.tb5_0(41);
RQCFG_100219_.old_tb5_1(41):=1111;
RQCFG_100219_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(41),-1)));
RQCFG_100219_.old_tb5_2(41):=null;
RQCFG_100219_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(41),-1)));
RQCFG_100219_.tb5_3(41):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(41):=RQCFG_100219_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(41),
RQCFG_100219_.tb5_1(41),
RQCFG_100219_.tb5_2(41),
RQCFG_100219_.tb5_3(41),
RQCFG_100219_.tb5_4(41),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(42):=1082866;
RQCFG_100219_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(42):=RQCFG_100219_.tb3_0(42);
RQCFG_100219_.old_tb3_1(42):=2036;
RQCFG_100219_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(42),-1)));
RQCFG_100219_.old_tb3_2(42):=257;
RQCFG_100219_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(42),-1)));
RQCFG_100219_.old_tb3_3(42):=null;
RQCFG_100219_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(42),-1)));
RQCFG_100219_.old_tb3_4(42):=null;
RQCFG_100219_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(42),-1)));
RQCFG_100219_.tb3_5(42):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(42):=121057133;
RQCFG_100219_.tb3_6(42):=NULL;
RQCFG_100219_.old_tb3_7(42):=null;
RQCFG_100219_.tb3_7(42):=NULL;
RQCFG_100219_.old_tb3_8(42):=null;
RQCFG_100219_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(42),
RQCFG_100219_.tb3_1(42),
RQCFG_100219_.tb3_2(42),
RQCFG_100219_.tb3_3(42),
RQCFG_100219_.tb3_4(42),
RQCFG_100219_.tb3_5(42),
RQCFG_100219_.tb3_6(42),
RQCFG_100219_.tb3_7(42),
RQCFG_100219_.tb3_8(42),
null,
105514,
1,
'Interacción'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(42):=1285962;
RQCFG_100219_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(42):=RQCFG_100219_.tb5_0(42);
RQCFG_100219_.old_tb5_1(42):=257;
RQCFG_100219_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(42),-1)));
RQCFG_100219_.old_tb5_2(42):=null;
RQCFG_100219_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(42),-1)));
RQCFG_100219_.tb5_3(42):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(42):=RQCFG_100219_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(42),
RQCFG_100219_.tb5_1(42),
RQCFG_100219_.tb5_2(42),
RQCFG_100219_.tb5_3(42),
RQCFG_100219_.tb5_4(42),
'Y'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(43):=1082867;
RQCFG_100219_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(43):=RQCFG_100219_.tb3_0(43);
RQCFG_100219_.old_tb3_1(43):=2036;
RQCFG_100219_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(43),-1)));
RQCFG_100219_.old_tb3_2(43):=258;
RQCFG_100219_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(43),-1)));
RQCFG_100219_.old_tb3_3(43):=null;
RQCFG_100219_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(43),-1)));
RQCFG_100219_.old_tb3_4(43):=null;
RQCFG_100219_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(43),-1)));
RQCFG_100219_.tb3_5(43):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(43):=121057134;
RQCFG_100219_.tb3_6(43):=NULL;
RQCFG_100219_.old_tb3_7(43):=121057135;
RQCFG_100219_.tb3_7(43):=NULL;
RQCFG_100219_.old_tb3_8(43):=null;
RQCFG_100219_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(43),
RQCFG_100219_.tb3_1(43),
RQCFG_100219_.tb3_2(43),
RQCFG_100219_.tb3_3(43),
RQCFG_100219_.tb3_4(43),
RQCFG_100219_.tb3_5(43),
RQCFG_100219_.tb3_6(43),
RQCFG_100219_.tb3_7(43),
RQCFG_100219_.tb3_8(43),
null,
105515,
2,
'Fecha de Solicitud'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(43):=1285963;
RQCFG_100219_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(43):=RQCFG_100219_.tb5_0(43);
RQCFG_100219_.old_tb5_1(43):=258;
RQCFG_100219_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(43),-1)));
RQCFG_100219_.old_tb5_2(43):=null;
RQCFG_100219_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(43),-1)));
RQCFG_100219_.tb5_3(43):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(43):=RQCFG_100219_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(43),
RQCFG_100219_.tb5_1(43),
RQCFG_100219_.tb5_2(43),
RQCFG_100219_.tb5_3(43),
RQCFG_100219_.tb5_4(43),
'Y'
,
'Y'
,
2,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(44):=1082868;
RQCFG_100219_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(44):=RQCFG_100219_.tb3_0(44);
RQCFG_100219_.old_tb3_1(44):=2036;
RQCFG_100219_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(44),-1)));
RQCFG_100219_.old_tb3_2(44):=255;
RQCFG_100219_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(44),-1)));
RQCFG_100219_.old_tb3_3(44):=null;
RQCFG_100219_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(44),-1)));
RQCFG_100219_.old_tb3_4(44):=null;
RQCFG_100219_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(44),-1)));
RQCFG_100219_.tb3_5(44):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(44):=null;
RQCFG_100219_.tb3_6(44):=NULL;
RQCFG_100219_.old_tb3_7(44):=121057136;
RQCFG_100219_.tb3_7(44):=NULL;
RQCFG_100219_.old_tb3_8(44):=null;
RQCFG_100219_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(44),
RQCFG_100219_.tb3_1(44),
RQCFG_100219_.tb3_2(44),
RQCFG_100219_.tb3_3(44),
RQCFG_100219_.tb3_4(44),
RQCFG_100219_.tb3_5(44),
RQCFG_100219_.tb3_6(44),
RQCFG_100219_.tb3_7(44),
RQCFG_100219_.tb3_8(44),
null,
105517,
3,
'Número de Solicitud'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(44):=1285964;
RQCFG_100219_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(44):=RQCFG_100219_.tb5_0(44);
RQCFG_100219_.old_tb5_1(44):=255;
RQCFG_100219_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(44),-1)));
RQCFG_100219_.old_tb5_2(44):=null;
RQCFG_100219_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(44),-1)));
RQCFG_100219_.tb5_3(44):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(44):=RQCFG_100219_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(44),
RQCFG_100219_.tb5_1(44),
RQCFG_100219_.tb5_2(44),
RQCFG_100219_.tb5_3(44),
RQCFG_100219_.tb5_4(44),
'Y'
,
'N'
,
3,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(45):=1082869;
RQCFG_100219_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(45):=RQCFG_100219_.tb3_0(45);
RQCFG_100219_.old_tb3_1(45):=2036;
RQCFG_100219_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(45),-1)));
RQCFG_100219_.old_tb3_2(45):=50001162;
RQCFG_100219_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(45),-1)));
RQCFG_100219_.old_tb3_3(45):=null;
RQCFG_100219_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(45),-1)));
RQCFG_100219_.old_tb3_4(45):=null;
RQCFG_100219_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(45),-1)));
RQCFG_100219_.tb3_5(45):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(45):=121057137;
RQCFG_100219_.tb3_6(45):=NULL;
RQCFG_100219_.old_tb3_7(45):=121057138;
RQCFG_100219_.tb3_7(45):=NULL;
RQCFG_100219_.old_tb3_8(45):=120029762;
RQCFG_100219_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(45),
RQCFG_100219_.tb3_1(45),
RQCFG_100219_.tb3_2(45),
RQCFG_100219_.tb3_3(45),
RQCFG_100219_.tb3_4(45),
RQCFG_100219_.tb3_5(45),
RQCFG_100219_.tb3_6(45),
RQCFG_100219_.tb3_7(45),
RQCFG_100219_.tb3_8(45),
null,
105518,
4,
'Funcionario'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(45):=1285965;
RQCFG_100219_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(45):=RQCFG_100219_.tb5_0(45);
RQCFG_100219_.old_tb5_1(45):=50001162;
RQCFG_100219_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(45),-1)));
RQCFG_100219_.old_tb5_2(45):=null;
RQCFG_100219_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(45),-1)));
RQCFG_100219_.tb5_3(45):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(45):=RQCFG_100219_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(45),
RQCFG_100219_.tb5_1(45),
RQCFG_100219_.tb5_2(45),
RQCFG_100219_.tb5_3(45),
RQCFG_100219_.tb5_4(45),
'Y'
,
'N'
,
4,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(46):=1082870;
RQCFG_100219_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(46):=RQCFG_100219_.tb3_0(46);
RQCFG_100219_.old_tb3_1(46):=2036;
RQCFG_100219_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(46),-1)));
RQCFG_100219_.old_tb3_2(46):=109479;
RQCFG_100219_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(46),-1)));
RQCFG_100219_.old_tb3_3(46):=null;
RQCFG_100219_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(46),-1)));
RQCFG_100219_.old_tb3_4(46):=null;
RQCFG_100219_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(46),-1)));
RQCFG_100219_.tb3_5(46):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(46):=121057139;
RQCFG_100219_.tb3_6(46):=NULL;
RQCFG_100219_.old_tb3_7(46):=null;
RQCFG_100219_.tb3_7(46):=NULL;
RQCFG_100219_.old_tb3_8(46):=120029763;
RQCFG_100219_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(46),
RQCFG_100219_.tb3_1(46),
RQCFG_100219_.tb3_2(46),
RQCFG_100219_.tb3_3(46),
RQCFG_100219_.tb3_4(46),
RQCFG_100219_.tb3_5(46),
RQCFG_100219_.tb3_6(46),
RQCFG_100219_.tb3_7(46),
RQCFG_100219_.tb3_8(46),
null,
105519,
5,
'Punto de Atención'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(46):=1285966;
RQCFG_100219_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(46):=RQCFG_100219_.tb5_0(46);
RQCFG_100219_.old_tb5_1(46):=109479;
RQCFG_100219_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(46),-1)));
RQCFG_100219_.old_tb5_2(46):=null;
RQCFG_100219_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(46),-1)));
RQCFG_100219_.tb5_3(46):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(46):=RQCFG_100219_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(46),
RQCFG_100219_.tb5_1(46),
RQCFG_100219_.tb5_2(46),
RQCFG_100219_.tb5_3(46),
RQCFG_100219_.tb5_4(46),
'Y'
,
'N'
,
5,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(47):=1082871;
RQCFG_100219_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(47):=RQCFG_100219_.tb3_0(47);
RQCFG_100219_.old_tb3_1(47):=2036;
RQCFG_100219_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(47),-1)));
RQCFG_100219_.old_tb3_2(47):=2683;
RQCFG_100219_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(47),-1)));
RQCFG_100219_.old_tb3_3(47):=null;
RQCFG_100219_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(47),-1)));
RQCFG_100219_.old_tb3_4(47):=null;
RQCFG_100219_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(47),-1)));
RQCFG_100219_.tb3_5(47):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(47):=121057140;
RQCFG_100219_.tb3_6(47):=NULL;
RQCFG_100219_.old_tb3_7(47):=null;
RQCFG_100219_.tb3_7(47):=NULL;
RQCFG_100219_.old_tb3_8(47):=null;
RQCFG_100219_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(47),
RQCFG_100219_.tb3_1(47),
RQCFG_100219_.tb3_2(47),
RQCFG_100219_.tb3_3(47),
RQCFG_100219_.tb3_4(47),
RQCFG_100219_.tb3_5(47),
RQCFG_100219_.tb3_6(47),
RQCFG_100219_.tb3_7(47),
RQCFG_100219_.tb3_8(47),
null,
105520,
6,
'Medio de recepción'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(47):=1285967;
RQCFG_100219_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(47):=RQCFG_100219_.tb5_0(47);
RQCFG_100219_.old_tb5_1(47):=2683;
RQCFG_100219_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(47),-1)));
RQCFG_100219_.old_tb5_2(47):=null;
RQCFG_100219_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(47),-1)));
RQCFG_100219_.tb5_3(47):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(47):=RQCFG_100219_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(47),
RQCFG_100219_.tb5_1(47),
RQCFG_100219_.tb5_2(47),
RQCFG_100219_.tb5_3(47),
RQCFG_100219_.tb5_4(47),
'C'
,
'Y'
,
6,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(48):=1082872;
RQCFG_100219_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(48):=RQCFG_100219_.tb3_0(48);
RQCFG_100219_.old_tb3_1(48):=2036;
RQCFG_100219_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(48),-1)));
RQCFG_100219_.old_tb3_2(48):=146755;
RQCFG_100219_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(48),-1)));
RQCFG_100219_.old_tb3_3(48):=null;
RQCFG_100219_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(48),-1)));
RQCFG_100219_.old_tb3_4(48):=null;
RQCFG_100219_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(48),-1)));
RQCFG_100219_.tb3_5(48):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(48):=121057141;
RQCFG_100219_.tb3_6(48):=NULL;
RQCFG_100219_.old_tb3_7(48):=null;
RQCFG_100219_.tb3_7(48):=NULL;
RQCFG_100219_.old_tb3_8(48):=null;
RQCFG_100219_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(48),
RQCFG_100219_.tb3_1(48),
RQCFG_100219_.tb3_2(48),
RQCFG_100219_.tb3_3(48),
RQCFG_100219_.tb3_4(48),
RQCFG_100219_.tb3_5(48),
RQCFG_100219_.tb3_6(48),
RQCFG_100219_.tb3_7(48),
RQCFG_100219_.tb3_8(48),
null,
105521,
7,
'Información del Solicitante'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(48):=1285968;
RQCFG_100219_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(48):=RQCFG_100219_.tb5_0(48);
RQCFG_100219_.old_tb5_1(48):=146755;
RQCFG_100219_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(48),-1)));
RQCFG_100219_.old_tb5_2(48):=null;
RQCFG_100219_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(48),-1)));
RQCFG_100219_.tb5_3(48):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(48):=RQCFG_100219_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(48),
RQCFG_100219_.tb5_1(48),
RQCFG_100219_.tb5_2(48),
RQCFG_100219_.tb5_3(48),
RQCFG_100219_.tb5_4(48),
'Y'
,
'Y'
,
7,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(49):=1082873;
RQCFG_100219_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(49):=RQCFG_100219_.tb3_0(49);
RQCFG_100219_.old_tb3_1(49):=2036;
RQCFG_100219_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(49),-1)));
RQCFG_100219_.old_tb3_2(49):=146756;
RQCFG_100219_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(49),-1)));
RQCFG_100219_.old_tb3_3(49):=null;
RQCFG_100219_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(49),-1)));
RQCFG_100219_.old_tb3_4(49):=null;
RQCFG_100219_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(49),-1)));
RQCFG_100219_.tb3_5(49):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(49):=121057142;
RQCFG_100219_.tb3_6(49):=NULL;
RQCFG_100219_.old_tb3_7(49):=null;
RQCFG_100219_.tb3_7(49):=NULL;
RQCFG_100219_.old_tb3_8(49):=null;
RQCFG_100219_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(49),
RQCFG_100219_.tb3_1(49),
RQCFG_100219_.tb3_2(49),
RQCFG_100219_.tb3_3(49),
RQCFG_100219_.tb3_4(49),
RQCFG_100219_.tb3_5(49),
RQCFG_100219_.tb3_6(49),
RQCFG_100219_.tb3_7(49),
RQCFG_100219_.tb3_8(49),
null,
105523,
8,
'Dirección de Respuesta'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(49):=1285969;
RQCFG_100219_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(49):=RQCFG_100219_.tb5_0(49);
RQCFG_100219_.old_tb5_1(49):=146756;
RQCFG_100219_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(49),-1)));
RQCFG_100219_.old_tb5_2(49):=null;
RQCFG_100219_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(49),-1)));
RQCFG_100219_.tb5_3(49):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(49):=RQCFG_100219_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(49),
RQCFG_100219_.tb5_1(49),
RQCFG_100219_.tb5_2(49),
RQCFG_100219_.tb5_3(49),
RQCFG_100219_.tb5_4(49),
'C'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(50):=1082874;
RQCFG_100219_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(50):=RQCFG_100219_.tb3_0(50);
RQCFG_100219_.old_tb3_1(50):=2036;
RQCFG_100219_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(50),-1)));
RQCFG_100219_.old_tb3_2(50):=146754;
RQCFG_100219_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(50),-1)));
RQCFG_100219_.old_tb3_3(50):=null;
RQCFG_100219_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(50),-1)));
RQCFG_100219_.old_tb3_4(50):=null;
RQCFG_100219_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(50),-1)));
RQCFG_100219_.tb3_5(50):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(50):=null;
RQCFG_100219_.tb3_6(50):=NULL;
RQCFG_100219_.old_tb3_7(50):=null;
RQCFG_100219_.tb3_7(50):=NULL;
RQCFG_100219_.old_tb3_8(50):=null;
RQCFG_100219_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(50),
RQCFG_100219_.tb3_1(50),
RQCFG_100219_.tb3_2(50),
RQCFG_100219_.tb3_3(50),
RQCFG_100219_.tb3_4(50),
RQCFG_100219_.tb3_5(50),
RQCFG_100219_.tb3_6(50),
RQCFG_100219_.tb3_7(50),
RQCFG_100219_.tb3_8(50),
null,
105524,
9,
'Observación'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(50):=1285970;
RQCFG_100219_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(50):=RQCFG_100219_.tb5_0(50);
RQCFG_100219_.old_tb5_1(50):=146754;
RQCFG_100219_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(50),-1)));
RQCFG_100219_.old_tb5_2(50):=null;
RQCFG_100219_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(50),-1)));
RQCFG_100219_.tb5_3(50):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(50):=RQCFG_100219_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(50),
RQCFG_100219_.tb5_1(50),
RQCFG_100219_.tb5_2(50),
RQCFG_100219_.tb5_3(50),
RQCFG_100219_.tb5_4(50),
'Y'
,
'Y'
,
9,
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
null,
null,
null,
null);

exception when others then
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(51):=1082875;
RQCFG_100219_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(51):=RQCFG_100219_.tb3_0(51);
RQCFG_100219_.old_tb3_1(51):=2036;
RQCFG_100219_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(51),-1)));
RQCFG_100219_.old_tb3_2(51):=269;
RQCFG_100219_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(51),-1)));
RQCFG_100219_.old_tb3_3(51):=null;
RQCFG_100219_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(51),-1)));
RQCFG_100219_.old_tb3_4(51):=null;
RQCFG_100219_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(51),-1)));
RQCFG_100219_.tb3_5(51):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(51):=null;
RQCFG_100219_.tb3_6(51):=NULL;
RQCFG_100219_.old_tb3_7(51):=null;
RQCFG_100219_.tb3_7(51):=NULL;
RQCFG_100219_.old_tb3_8(51):=null;
RQCFG_100219_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(51),
RQCFG_100219_.tb3_1(51),
RQCFG_100219_.tb3_2(51),
RQCFG_100219_.tb3_3(51),
RQCFG_100219_.tb3_4(51),
RQCFG_100219_.tb3_5(51),
RQCFG_100219_.tb3_6(51),
RQCFG_100219_.tb3_7(51),
RQCFG_100219_.tb3_8(51),
null,
105525,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(51):=1285971;
RQCFG_100219_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(51):=RQCFG_100219_.tb5_0(51);
RQCFG_100219_.old_tb5_1(51):=269;
RQCFG_100219_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(51),-1)));
RQCFG_100219_.old_tb5_2(51):=null;
RQCFG_100219_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(51),-1)));
RQCFG_100219_.tb5_3(51):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(51):=RQCFG_100219_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(51),
RQCFG_100219_.tb5_1(51),
RQCFG_100219_.tb5_2(51),
RQCFG_100219_.tb5_3(51),
RQCFG_100219_.tb5_4(51),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(52):=1082876;
RQCFG_100219_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(52):=RQCFG_100219_.tb3_0(52);
RQCFG_100219_.old_tb3_1(52):=2036;
RQCFG_100219_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(52),-1)));
RQCFG_100219_.old_tb3_2(52):=109478;
RQCFG_100219_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(52),-1)));
RQCFG_100219_.old_tb3_3(52):=null;
RQCFG_100219_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(52),-1)));
RQCFG_100219_.old_tb3_4(52):=null;
RQCFG_100219_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(52),-1)));
RQCFG_100219_.tb3_5(52):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(52):=null;
RQCFG_100219_.tb3_6(52):=NULL;
RQCFG_100219_.old_tb3_7(52):=null;
RQCFG_100219_.tb3_7(52):=NULL;
RQCFG_100219_.old_tb3_8(52):=null;
RQCFG_100219_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(52),
RQCFG_100219_.tb3_1(52),
RQCFG_100219_.tb3_2(52),
RQCFG_100219_.tb3_3(52),
RQCFG_100219_.tb3_4(52),
RQCFG_100219_.tb3_5(52),
RQCFG_100219_.tb3_6(52),
RQCFG_100219_.tb3_7(52),
RQCFG_100219_.tb3_8(52),
null,
105526,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(52):=1285972;
RQCFG_100219_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(52):=RQCFG_100219_.tb5_0(52);
RQCFG_100219_.old_tb5_1(52):=109478;
RQCFG_100219_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(52),-1)));
RQCFG_100219_.old_tb5_2(52):=null;
RQCFG_100219_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(52),-1)));
RQCFG_100219_.tb5_3(52):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(52):=RQCFG_100219_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(52),
RQCFG_100219_.tb5_1(52),
RQCFG_100219_.tb5_2(52),
RQCFG_100219_.tb5_3(52),
RQCFG_100219_.tb5_4(52),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(53):=1082877;
RQCFG_100219_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(53):=RQCFG_100219_.tb3_0(53);
RQCFG_100219_.old_tb3_1(53):=2036;
RQCFG_100219_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(53),-1)));
RQCFG_100219_.old_tb3_2(53):=42118;
RQCFG_100219_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(53),-1)));
RQCFG_100219_.old_tb3_3(53):=109479;
RQCFG_100219_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(53),-1)));
RQCFG_100219_.old_tb3_4(53):=null;
RQCFG_100219_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(53),-1)));
RQCFG_100219_.tb3_5(53):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(53):=null;
RQCFG_100219_.tb3_6(53):=NULL;
RQCFG_100219_.old_tb3_7(53):=null;
RQCFG_100219_.tb3_7(53):=NULL;
RQCFG_100219_.old_tb3_8(53):=null;
RQCFG_100219_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(53),
RQCFG_100219_.tb3_1(53),
RQCFG_100219_.tb3_2(53),
RQCFG_100219_.tb3_3(53),
RQCFG_100219_.tb3_4(53),
RQCFG_100219_.tb3_5(53),
RQCFG_100219_.tb3_6(53),
RQCFG_100219_.tb3_7(53),
RQCFG_100219_.tb3_8(53),
null,
105528,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(53):=1285973;
RQCFG_100219_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(53):=RQCFG_100219_.tb5_0(53);
RQCFG_100219_.old_tb5_1(53):=42118;
RQCFG_100219_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(53),-1)));
RQCFG_100219_.old_tb5_2(53):=null;
RQCFG_100219_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(53),-1)));
RQCFG_100219_.tb5_3(53):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(53):=RQCFG_100219_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(53),
RQCFG_100219_.tb5_1(53),
RQCFG_100219_.tb5_2(53),
RQCFG_100219_.tb5_3(53),
RQCFG_100219_.tb5_4(53),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(54):=1082878;
RQCFG_100219_.tb3_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(54):=RQCFG_100219_.tb3_0(54);
RQCFG_100219_.old_tb3_1(54):=2036;
RQCFG_100219_.tb3_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(54),-1)));
RQCFG_100219_.old_tb3_2(54):=259;
RQCFG_100219_.tb3_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(54),-1)));
RQCFG_100219_.old_tb3_3(54):=null;
RQCFG_100219_.tb3_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(54),-1)));
RQCFG_100219_.old_tb3_4(54):=null;
RQCFG_100219_.tb3_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(54),-1)));
RQCFG_100219_.tb3_5(54):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(54):=121057121;
RQCFG_100219_.tb3_6(54):=NULL;
RQCFG_100219_.old_tb3_7(54):=null;
RQCFG_100219_.tb3_7(54):=NULL;
RQCFG_100219_.old_tb3_8(54):=null;
RQCFG_100219_.tb3_8(54):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(54),
RQCFG_100219_.tb3_1(54),
RQCFG_100219_.tb3_2(54),
RQCFG_100219_.tb3_3(54),
RQCFG_100219_.tb3_4(54),
RQCFG_100219_.tb3_5(54),
RQCFG_100219_.tb3_6(54),
RQCFG_100219_.tb3_7(54),
RQCFG_100219_.tb3_8(54),
null,
105535,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(54):=1285974;
RQCFG_100219_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(54):=RQCFG_100219_.tb5_0(54);
RQCFG_100219_.old_tb5_1(54):=259;
RQCFG_100219_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(54),-1)));
RQCFG_100219_.old_tb5_2(54):=null;
RQCFG_100219_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(54),-1)));
RQCFG_100219_.tb5_3(54):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(54):=RQCFG_100219_.tb3_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(54),
RQCFG_100219_.tb5_1(54),
RQCFG_100219_.tb5_2(54),
RQCFG_100219_.tb5_3(54),
RQCFG_100219_.tb5_4(54),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(55):=1082879;
RQCFG_100219_.tb3_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(55):=RQCFG_100219_.tb3_0(55);
RQCFG_100219_.old_tb3_1(55):=2036;
RQCFG_100219_.tb3_1(55):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(55),-1)));
RQCFG_100219_.old_tb3_2(55):=4015;
RQCFG_100219_.tb3_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(55),-1)));
RQCFG_100219_.old_tb3_3(55):=793;
RQCFG_100219_.tb3_3(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(55),-1)));
RQCFG_100219_.old_tb3_4(55):=null;
RQCFG_100219_.tb3_4(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(55),-1)));
RQCFG_100219_.tb3_5(55):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(55):=null;
RQCFG_100219_.tb3_6(55):=NULL;
RQCFG_100219_.old_tb3_7(55):=null;
RQCFG_100219_.tb3_7(55):=NULL;
RQCFG_100219_.old_tb3_8(55):=null;
RQCFG_100219_.tb3_8(55):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (55)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(55),
RQCFG_100219_.tb3_1(55),
RQCFG_100219_.tb3_2(55),
RQCFG_100219_.tb3_3(55),
RQCFG_100219_.tb3_4(55),
RQCFG_100219_.tb3_5(55),
RQCFG_100219_.tb3_6(55),
RQCFG_100219_.tb3_7(55),
RQCFG_100219_.tb3_8(55),
null,
105537,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(55):=1285975;
RQCFG_100219_.tb5_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(55):=RQCFG_100219_.tb5_0(55);
RQCFG_100219_.old_tb5_1(55):=4015;
RQCFG_100219_.tb5_1(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(55),-1)));
RQCFG_100219_.old_tb5_2(55):=null;
RQCFG_100219_.tb5_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(55),-1)));
RQCFG_100219_.tb5_3(55):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(55):=RQCFG_100219_.tb3_0(55);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(55),
RQCFG_100219_.tb5_1(55),
RQCFG_100219_.tb5_2(55),
RQCFG_100219_.tb5_3(55),
RQCFG_100219_.tb5_4(55),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(56):=1082880;
RQCFG_100219_.tb3_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(56):=RQCFG_100219_.tb3_0(56);
RQCFG_100219_.old_tb3_1(56):=2036;
RQCFG_100219_.tb3_1(56):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(56),-1)));
RQCFG_100219_.old_tb3_2(56):=474;
RQCFG_100219_.tb3_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(56),-1)));
RQCFG_100219_.old_tb3_3(56):=null;
RQCFG_100219_.tb3_3(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(56),-1)));
RQCFG_100219_.old_tb3_4(56):=null;
RQCFG_100219_.tb3_4(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(56),-1)));
RQCFG_100219_.tb3_5(56):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(56):=121057124;
RQCFG_100219_.tb3_6(56):=NULL;
RQCFG_100219_.old_tb3_7(56):=null;
RQCFG_100219_.tb3_7(56):=NULL;
RQCFG_100219_.old_tb3_8(56):=null;
RQCFG_100219_.tb3_8(56):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (56)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(56),
RQCFG_100219_.tb3_1(56),
RQCFG_100219_.tb3_2(56),
RQCFG_100219_.tb3_3(56),
RQCFG_100219_.tb3_4(56),
RQCFG_100219_.tb3_5(56),
RQCFG_100219_.tb3_6(56),
RQCFG_100219_.tb3_7(56),
RQCFG_100219_.tb3_8(56),
null,
105538,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(56):=1285976;
RQCFG_100219_.tb5_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(56):=RQCFG_100219_.tb5_0(56);
RQCFG_100219_.old_tb5_1(56):=474;
RQCFG_100219_.tb5_1(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(56),-1)));
RQCFG_100219_.old_tb5_2(56):=null;
RQCFG_100219_.tb5_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(56),-1)));
RQCFG_100219_.tb5_3(56):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(56):=RQCFG_100219_.tb3_0(56);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(56),
RQCFG_100219_.tb5_1(56),
RQCFG_100219_.tb5_2(56),
RQCFG_100219_.tb5_3(56),
RQCFG_100219_.tb5_4(56),
'C'
,
'E'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(57):=1082881;
RQCFG_100219_.tb3_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(57):=RQCFG_100219_.tb3_0(57);
RQCFG_100219_.old_tb3_1(57):=2036;
RQCFG_100219_.tb3_1(57):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(57),-1)));
RQCFG_100219_.old_tb3_2(57):=11376;
RQCFG_100219_.tb3_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(57),-1)));
RQCFG_100219_.old_tb3_3(57):=null;
RQCFG_100219_.tb3_3(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(57),-1)));
RQCFG_100219_.old_tb3_4(57):=null;
RQCFG_100219_.tb3_4(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(57),-1)));
RQCFG_100219_.tb3_5(57):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(57):=121057125;
RQCFG_100219_.tb3_6(57):=NULL;
RQCFG_100219_.old_tb3_7(57):=null;
RQCFG_100219_.tb3_7(57):=NULL;
RQCFG_100219_.old_tb3_8(57):=null;
RQCFG_100219_.tb3_8(57):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (57)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(57),
RQCFG_100219_.tb3_1(57),
RQCFG_100219_.tb3_2(57),
RQCFG_100219_.tb3_3(57),
RQCFG_100219_.tb3_4(57),
RQCFG_100219_.tb3_5(57),
RQCFG_100219_.tb3_6(57),
RQCFG_100219_.tb3_7(57),
RQCFG_100219_.tb3_8(57),
null,
105539,
17,
'Direccion de instalaci¿n'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(57):=1285977;
RQCFG_100219_.tb5_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(57):=RQCFG_100219_.tb5_0(57);
RQCFG_100219_.old_tb5_1(57):=11376;
RQCFG_100219_.tb5_1(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(57),-1)));
RQCFG_100219_.old_tb5_2(57):=null;
RQCFG_100219_.tb5_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(57),-1)));
RQCFG_100219_.tb5_3(57):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(57):=RQCFG_100219_.tb3_0(57);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(57),
RQCFG_100219_.tb5_1(57),
RQCFG_100219_.tb5_2(57),
RQCFG_100219_.tb5_3(57),
RQCFG_100219_.tb5_4(57),
'C'
,
'Y'
,
17,
'N'
,
'Direccion de instalaci¿n'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(58):=1082882;
RQCFG_100219_.tb3_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(58):=RQCFG_100219_.tb3_0(58);
RQCFG_100219_.old_tb3_1(58):=2036;
RQCFG_100219_.tb3_1(58):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(58),-1)));
RQCFG_100219_.old_tb3_2(58):=11619;
RQCFG_100219_.tb3_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(58),-1)));
RQCFG_100219_.old_tb3_3(58):=null;
RQCFG_100219_.tb3_3(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(58),-1)));
RQCFG_100219_.old_tb3_4(58):=null;
RQCFG_100219_.tb3_4(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(58),-1)));
RQCFG_100219_.tb3_5(58):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(58):=null;
RQCFG_100219_.tb3_6(58):=NULL;
RQCFG_100219_.old_tb3_7(58):=null;
RQCFG_100219_.tb3_7(58):=NULL;
RQCFG_100219_.old_tb3_8(58):=null;
RQCFG_100219_.tb3_8(58):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (58)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(58),
RQCFG_100219_.tb3_1(58),
RQCFG_100219_.tb3_2(58),
RQCFG_100219_.tb3_3(58),
RQCFG_100219_.tb3_4(58),
RQCFG_100219_.tb3_5(58),
RQCFG_100219_.tb3_6(58),
RQCFG_100219_.tb3_7(58),
RQCFG_100219_.tb3_8(58),
null,
105536,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(58):=1285978;
RQCFG_100219_.tb5_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(58):=RQCFG_100219_.tb5_0(58);
RQCFG_100219_.old_tb5_1(58):=11619;
RQCFG_100219_.tb5_1(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(58),-1)));
RQCFG_100219_.old_tb5_2(58):=null;
RQCFG_100219_.tb5_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(58),-1)));
RQCFG_100219_.tb5_3(58):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(58):=RQCFG_100219_.tb3_0(58);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (58)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(58),
RQCFG_100219_.tb5_1(58),
RQCFG_100219_.tb5_2(58),
RQCFG_100219_.tb5_3(58),
RQCFG_100219_.tb5_4(58),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(59):=1082883;
RQCFG_100219_.tb3_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(59):=RQCFG_100219_.tb3_0(59);
RQCFG_100219_.old_tb3_1(59):=2036;
RQCFG_100219_.tb3_1(59):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(59),-1)));
RQCFG_100219_.old_tb3_2(59):=475;
RQCFG_100219_.tb3_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(59),-1)));
RQCFG_100219_.old_tb3_3(59):=null;
RQCFG_100219_.tb3_3(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(59),-1)));
RQCFG_100219_.old_tb3_4(59):=null;
RQCFG_100219_.tb3_4(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(59),-1)));
RQCFG_100219_.tb3_5(59):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(59):=121057127;
RQCFG_100219_.tb3_6(59):=NULL;
RQCFG_100219_.old_tb3_7(59):=null;
RQCFG_100219_.tb3_7(59):=NULL;
RQCFG_100219_.old_tb3_8(59):=null;
RQCFG_100219_.tb3_8(59):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (59)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(59),
RQCFG_100219_.tb3_1(59),
RQCFG_100219_.tb3_2(59),
RQCFG_100219_.tb3_3(59),
RQCFG_100219_.tb3_4(59),
RQCFG_100219_.tb3_5(59),
RQCFG_100219_.tb3_6(59),
RQCFG_100219_.tb3_7(59),
RQCFG_100219_.tb3_8(59),
null,
105588,
19,
'Código de la Ubicación Geográfica'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(59):=1285979;
RQCFG_100219_.tb5_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(59):=RQCFG_100219_.tb5_0(59);
RQCFG_100219_.old_tb5_1(59):=475;
RQCFG_100219_.tb5_1(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(59),-1)));
RQCFG_100219_.old_tb5_2(59):=null;
RQCFG_100219_.tb5_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(59),-1)));
RQCFG_100219_.tb5_3(59):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(59):=RQCFG_100219_.tb3_0(59);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (59)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(59),
RQCFG_100219_.tb5_1(59),
RQCFG_100219_.tb5_2(59),
RQCFG_100219_.tb5_3(59),
RQCFG_100219_.tb5_4(59),
'C'
,
'Y'
,
19,
'N'
,
'Código de la Ubicación Geográfica'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(60):=1082884;
RQCFG_100219_.tb3_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(60):=RQCFG_100219_.tb3_0(60);
RQCFG_100219_.old_tb3_1(60):=2036;
RQCFG_100219_.tb3_1(60):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(60),-1)));
RQCFG_100219_.old_tb3_2(60):=2;
RQCFG_100219_.tb3_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(60),-1)));
RQCFG_100219_.old_tb3_3(60):=null;
RQCFG_100219_.tb3_3(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(60),-1)));
RQCFG_100219_.old_tb3_4(60):=null;
RQCFG_100219_.tb3_4(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(60),-1)));
RQCFG_100219_.tb3_5(60):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(60):=121057128;
RQCFG_100219_.tb3_6(60):=NULL;
RQCFG_100219_.old_tb3_7(60):=null;
RQCFG_100219_.tb3_7(60):=NULL;
RQCFG_100219_.old_tb3_8(60):=null;
RQCFG_100219_.tb3_8(60):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (60)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(60),
RQCFG_100219_.tb3_1(60),
RQCFG_100219_.tb3_2(60),
RQCFG_100219_.tb3_3(60),
RQCFG_100219_.tb3_4(60),
RQCFG_100219_.tb3_5(60),
RQCFG_100219_.tb3_6(60),
RQCFG_100219_.tb3_7(60),
RQCFG_100219_.tb3_8(60),
null,
105592,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(60):=1285980;
RQCFG_100219_.tb5_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(60):=RQCFG_100219_.tb5_0(60);
RQCFG_100219_.old_tb5_1(60):=2;
RQCFG_100219_.tb5_1(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(60),-1)));
RQCFG_100219_.old_tb5_2(60):=null;
RQCFG_100219_.tb5_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(60),-1)));
RQCFG_100219_.tb5_3(60):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(60):=RQCFG_100219_.tb3_0(60);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (60)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(60),
RQCFG_100219_.tb5_1(60),
RQCFG_100219_.tb5_2(60),
RQCFG_100219_.tb5_3(60),
RQCFG_100219_.tb5_4(60),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(61):=1082885;
RQCFG_100219_.tb3_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(61):=RQCFG_100219_.tb3_0(61);
RQCFG_100219_.old_tb3_1(61):=2036;
RQCFG_100219_.tb3_1(61):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(61),-1)));
RQCFG_100219_.old_tb3_2(61):=39322;
RQCFG_100219_.tb3_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(61),-1)));
RQCFG_100219_.old_tb3_3(61):=255;
RQCFG_100219_.tb3_3(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(61),-1)));
RQCFG_100219_.old_tb3_4(61):=null;
RQCFG_100219_.tb3_4(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(61),-1)));
RQCFG_100219_.tb3_5(61):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(61):=null;
RQCFG_100219_.tb3_6(61):=NULL;
RQCFG_100219_.old_tb3_7(61):=null;
RQCFG_100219_.tb3_7(61):=NULL;
RQCFG_100219_.old_tb3_8(61):=null;
RQCFG_100219_.tb3_8(61):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (61)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(61),
RQCFG_100219_.tb3_1(61),
RQCFG_100219_.tb3_2(61),
RQCFG_100219_.tb3_3(61),
RQCFG_100219_.tb3_4(61),
RQCFG_100219_.tb3_5(61),
RQCFG_100219_.tb3_6(61),
RQCFG_100219_.tb3_7(61),
RQCFG_100219_.tb3_8(61),
null,
105619,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(61):=1285981;
RQCFG_100219_.tb5_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(61):=RQCFG_100219_.tb5_0(61);
RQCFG_100219_.old_tb5_1(61):=39322;
RQCFG_100219_.tb5_1(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(61),-1)));
RQCFG_100219_.old_tb5_2(61):=null;
RQCFG_100219_.tb5_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(61),-1)));
RQCFG_100219_.tb5_3(61):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(61):=RQCFG_100219_.tb3_0(61);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (61)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(61),
RQCFG_100219_.tb5_1(61),
RQCFG_100219_.tb5_2(61),
RQCFG_100219_.tb5_3(61),
RQCFG_100219_.tb5_4(61),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(62):=1082886;
RQCFG_100219_.tb3_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(62):=RQCFG_100219_.tb3_0(62);
RQCFG_100219_.old_tb3_1(62):=2036;
RQCFG_100219_.tb3_1(62):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(62),-1)));
RQCFG_100219_.old_tb3_2(62):=476;
RQCFG_100219_.tb3_2(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(62),-1)));
RQCFG_100219_.old_tb3_3(62):=null;
RQCFG_100219_.tb3_3(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(62),-1)));
RQCFG_100219_.old_tb3_4(62):=null;
RQCFG_100219_.tb3_4(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(62),-1)));
RQCFG_100219_.tb3_5(62):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(62):=121057122;
RQCFG_100219_.tb3_6(62):=NULL;
RQCFG_100219_.old_tb3_7(62):=null;
RQCFG_100219_.tb3_7(62):=NULL;
RQCFG_100219_.old_tb3_8(62):=null;
RQCFG_100219_.tb3_8(62):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (62)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(62),
RQCFG_100219_.tb3_1(62),
RQCFG_100219_.tb3_2(62),
RQCFG_100219_.tb3_3(62),
RQCFG_100219_.tb3_4(62),
RQCFG_100219_.tb3_5(62),
RQCFG_100219_.tb3_6(62),
RQCFG_100219_.tb3_7(62),
RQCFG_100219_.tb3_8(62),
null,
105626,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(62):=1285982;
RQCFG_100219_.tb5_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(62):=RQCFG_100219_.tb5_0(62);
RQCFG_100219_.old_tb5_1(62):=476;
RQCFG_100219_.tb5_1(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(62),-1)));
RQCFG_100219_.old_tb5_2(62):=null;
RQCFG_100219_.tb5_2(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(62),-1)));
RQCFG_100219_.tb5_3(62):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(62):=RQCFG_100219_.tb3_0(62);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (62)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(62),
RQCFG_100219_.tb5_1(62),
RQCFG_100219_.tb5_2(62),
RQCFG_100219_.tb5_3(62),
RQCFG_100219_.tb5_4(62),
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(63):=1082887;
RQCFG_100219_.tb3_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(63):=RQCFG_100219_.tb3_0(63);
RQCFG_100219_.old_tb3_1(63):=2036;
RQCFG_100219_.tb3_1(63):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(63),-1)));
RQCFG_100219_.old_tb3_2(63):=11621;
RQCFG_100219_.tb3_2(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(63),-1)));
RQCFG_100219_.old_tb3_3(63):=null;
RQCFG_100219_.tb3_3(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(63),-1)));
RQCFG_100219_.old_tb3_4(63):=null;
RQCFG_100219_.tb3_4(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(63),-1)));
RQCFG_100219_.tb3_5(63):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(63):=121057123;
RQCFG_100219_.tb3_6(63):=NULL;
RQCFG_100219_.old_tb3_7(63):=null;
RQCFG_100219_.tb3_7(63):=NULL;
RQCFG_100219_.old_tb3_8(63):=null;
RQCFG_100219_.tb3_8(63):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (63)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(63),
RQCFG_100219_.tb3_1(63),
RQCFG_100219_.tb3_2(63),
RQCFG_100219_.tb3_3(63),
RQCFG_100219_.tb3_4(63),
RQCFG_100219_.tb3_5(63),
RQCFG_100219_.tb3_6(63),
RQCFG_100219_.tb3_7(63),
RQCFG_100219_.tb3_8(63),
null,
105627,
23,
'Contrato pendiente'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(63):=1285983;
RQCFG_100219_.tb5_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(63):=RQCFG_100219_.tb5_0(63);
RQCFG_100219_.old_tb5_1(63):=11621;
RQCFG_100219_.tb5_1(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(63),-1)));
RQCFG_100219_.old_tb5_2(63):=null;
RQCFG_100219_.tb5_2(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(63),-1)));
RQCFG_100219_.tb5_3(63):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(63):=RQCFG_100219_.tb3_0(63);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (63)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(63),
RQCFG_100219_.tb5_1(63),
RQCFG_100219_.tb5_2(63),
RQCFG_100219_.tb5_3(63),
RQCFG_100219_.tb5_4(63),
'C'
,
'Y'
,
23,
'N'
,
'Contrato pendiente'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb3_0(64):=1082888;
RQCFG_100219_.tb3_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100219_.tb3_0(64):=RQCFG_100219_.tb3_0(64);
RQCFG_100219_.old_tb3_1(64):=2036;
RQCFG_100219_.tb3_1(64):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100219_.TBENTITYNAME(NVL(RQCFG_100219_.old_tb3_1(64),-1)));
RQCFG_100219_.old_tb3_2(64):=440;
RQCFG_100219_.tb3_2(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_2(64),-1)));
RQCFG_100219_.old_tb3_3(64):=null;
RQCFG_100219_.tb3_3(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_3(64),-1)));
RQCFG_100219_.old_tb3_4(64):=null;
RQCFG_100219_.tb3_4(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb3_4(64),-1)));
RQCFG_100219_.tb3_5(64):=RQCFG_100219_.tb2_2(0);
RQCFG_100219_.old_tb3_6(64):=121057129;
RQCFG_100219_.tb3_6(64):=NULL;
RQCFG_100219_.old_tb3_7(64):=null;
RQCFG_100219_.tb3_7(64):=NULL;
RQCFG_100219_.old_tb3_8(64):=120029760;
RQCFG_100219_.tb3_8(64):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (64)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100219_.tb3_0(64),
RQCFG_100219_.tb3_1(64),
RQCFG_100219_.tb3_2(64),
RQCFG_100219_.tb3_3(64),
RQCFG_100219_.tb3_4(64),
RQCFG_100219_.tb3_5(64),
RQCFG_100219_.tb3_6(64),
RQCFG_100219_.tb3_7(64),
RQCFG_100219_.tb3_8(64),
null,
105629,
24,
'Categoria'
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100219_.blProcessStatus) then
 return;
end if;

RQCFG_100219_.old_tb5_0(64):=1285984;
RQCFG_100219_.tb5_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100219_.tb5_0(64):=RQCFG_100219_.tb5_0(64);
RQCFG_100219_.old_tb5_1(64):=440;
RQCFG_100219_.tb5_1(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_1(64),-1)));
RQCFG_100219_.old_tb5_2(64):=null;
RQCFG_100219_.tb5_2(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100219_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100219_.old_tb5_2(64),-1)));
RQCFG_100219_.tb5_3(64):=RQCFG_100219_.tb4_0(2);
RQCFG_100219_.tb5_4(64):=RQCFG_100219_.tb3_0(64);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (64)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100219_.tb5_0(64),
RQCFG_100219_.tb5_1(64),
RQCFG_100219_.tb5_2(64),
RQCFG_100219_.tb5_3(64),
RQCFG_100219_.tb5_4(64),
'C'
,
'Y'
,
24,
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
RQCFG_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100219);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100219)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100219_.blProcessStatus) then
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
AND     external_root_id = 100219
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
AND     external_root_id = 100219
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
AND     external_root_id = 100219
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100219, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100219)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100219, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100219)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100219, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100219)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100219, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100219)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100219_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100219_.tbCompositions.FIRST..RQCFG_100219_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100219_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100219_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100219_.blProcessStatus := false;
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
 nuIndex := RQCFG_100219_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100219_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100219_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100219_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100219_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100219_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100219_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100219_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100219_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100219_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100219_',
'CREATE OR REPLACE PACKAGE I18N_R_100219_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100219_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100219_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100219
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
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
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(0):='C_SERVICIOS_FINANCIEROS_10306'
;
I18N_R_100219_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(0),
I18N_R_100219_.tb0_1(0),
'WE8ISO8859P1'
,
'Servicios Financieros'
,
'Servicios Financieros'
,
null,
'Servicios Financieros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(1):='C_SERVICIOS_FINANCIEROS_10306'
;
I18N_R_100219_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(1),
I18N_R_100219_.tb0_1(1),
'WE8ISO8859P1'
,
'Servicios Financieros'
,
'Servicios Financieros'
,
null,
'Servicios Financieros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(2):='C_SERVICIOS_FINANCIEROS_10306'
;
I18N_R_100219_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(2),
I18N_R_100219_.tb0_1(2),
'WE8ISO8859P1'
,
'Servicios Financieros'
,
'Servicios Financieros'
,
null,
'Servicios Financieros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(3):='M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
;
I18N_R_100219_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(3),
I18N_R_100219_.tb0_1(3),
'WE8ISO8859P1'
,
'Instalación de Servicios Financieros'
,
'Instalación de Servicios Financieros'
,
null,
'Instalación de Servicios Financieros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(4):='M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
;
I18N_R_100219_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(4),
I18N_R_100219_.tb0_1(4),
'WE8ISO8859P1'
,
'Instalación de Servicios Financieros'
,
'Instalación de Servicios Financieros'
,
null,
'Instalación de Servicios Financieros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(5):='M_INSTALACION_DE_SERVICIOS_FINANCIEROS_100218'
;
I18N_R_100219_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(5),
I18N_R_100219_.tb0_1(5),
'WE8ISO8859P1'
,
'Instalación de Servicios Financieros'
,
'Instalación de Servicios Financieros'
,
null,
'Instalación de Servicios Financieros'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(6):='PAQUETE'
;
I18N_R_100219_.tb0_1(6):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(6),
I18N_R_100219_.tb0_1(6),
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
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(7):='PAQUETE'
;
I18N_R_100219_.tb0_1(7):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (7)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(7),
I18N_R_100219_.tb0_1(7),
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
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(8):='PAQUETE'
;
I18N_R_100219_.tb0_1(8):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (8)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(8),
I18N_R_100219_.tb0_1(8),
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
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100219_.blProcessStatus) then
 return;
end if;

I18N_R_100219_.tb0_0(9):='PAQUETE'
;
I18N_R_100219_.tb0_1(9):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (9)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100219_.tb0_0(9),
I18N_R_100219_.tb0_1(9),
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
I18N_R_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100219_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100219_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100219_',
'CREATE OR REPLACE PACKAGE RQEXEC_100219_ IS ' || chr(10) ||
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
'END RQEXEC_100219_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100219_******************************'); END;
/


BEGIN

if (not RQEXEC_100219_.blProcessStatus) then
 return;
end if;

RQEXEC_100219_.old_tb0_0(0):='P_VENTA_SERVICIOS_FINANCIEROS_100219'
;
RQEXEC_100219_.tb0_0(0):=UPPER(RQEXEC_100219_.old_tb0_0(0));
RQEXEC_100219_.old_tb0_1(0):=500000000001091;
RQEXEC_100219_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100219_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100219_.tb0_1(0):=RQEXEC_100219_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100219_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100219_.tb0_1(0),
DESCRIPTION='Venta Servicios Financieros'
,
PATH=null,
VERSION='85'
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
 WHERE EXECUTABLE_ID = RQEXEC_100219_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100219_.tb0_0(0),
RQEXEC_100219_.tb0_1(0),
'Venta Servicios Financieros'
,
null,
'85'
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
RQEXEC_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100219_.blProcessStatus) then
 return;
end if;

RQEXEC_100219_.tb1_0(0):=1;
RQEXEC_100219_.tb1_1(0):=RQEXEC_100219_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100219_.tb1_0(0),
RQEXEC_100219_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100219_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100219_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100219_******************************'); end;
/

