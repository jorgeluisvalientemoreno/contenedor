BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100209_',
'CREATE OR REPLACE PACKAGE RQTY_100209_ IS ' || chr(10) ||
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
'tb5_4 ty5_4;type ty6_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of PS_PACKAGE_ATTRIBS.PACKAGE_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_PACKAGE_ATTRIBS.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of PS_PACKAGE_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty7_3 is table of PS_PACKAGE_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_3 ty7_3; ' || chr(10) ||
'tb7_3 ty7_3;type ty7_4 is table of PS_PACKAGE_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb7_4 ty7_4; ' || chr(10) ||
'tb7_4 ty7_4;type ty7_5 is table of PS_PACKAGE_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_5 ty7_5; ' || chr(10) ||
'tb7_5 ty7_5;type ty7_6 is table of PS_PACKAGE_ATTRIBS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_6 ty7_6; ' || chr(10) ||
'tb7_6 ty7_6;type ty7_7 is table of PS_PACKAGE_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_7 ty7_7; ' || chr(10) ||
'tb7_7 ty7_7;type ty7_8 is table of PS_PACKAGE_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_8 ty7_8; ' || chr(10) ||
'tb7_8 ty7_8;type ty7_9 is table of PS_PACKAGE_ATTRIBS.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_9 ty7_9; ' || chr(10) ||
'tb7_9 ty7_9;type ty8_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
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
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100209 ' || chr(10) ||
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
'END RQTY_100209_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100209_******************************'); END;
/

BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
AND     external_root_id = 100209
)
);

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100209_.cuExpressions;
fetch RQTY_100209_.cuExpressions bulk collect INTO RQTY_100209_.tbExpressionsId;
close RQTY_100209_.cuExpressions;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100209_.tbEntityName(-1) := 'NULL';
   RQTY_100209_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100209_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQTY_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100209_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQTY_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100209_.tbEntityAttributeName(1863) := 'MO_PROCESS@SUSPENSION_TYPE_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100209_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100209_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100209_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100209_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100209
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100209
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100209
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100209
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100209_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100209_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100209_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100209_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100209_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100209_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100209_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209))));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209))));

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100209_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100209_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100209_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100209_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100209_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100209_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100209_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100209_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209)));

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209));
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100209_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209);
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100209_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100209_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100209_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100209_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100209;
nuIndex binary_integer;
BEGIN

if (not RQTY_100209_.blProcessStatus) then
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100209_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100209_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100209_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100209_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100209_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100209_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100209_.tb0_0(0),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb1_0(0):=1;
RQTY_100209_.tb1_1(0):=RQTY_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100209_.tb1_0(0),
MODULE_ID=RQTY_100209_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100209_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100209_.tb1_0(0),
RQTY_100209_.tb1_1(0),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(0):=121048616;
RQTY_100209_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(0):=RQTY_100209_.tb2_0(0);
RQTY_100209_.old_tb2_1(0):='GE_EXEACTION_CT1E121048616'
;
RQTY_100209_.tb2_1(0):=RQTY_100209_.tb2_0(0);
RQTY_100209_.tb2_2(0):=RQTY_100209_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(0),
RQTY_100209_.tb2_1(0),
RQTY_100209_.tb2_2(0),
'nuSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();dtRequestDate = CC_BOBOSSUTIL.FDTREQUESTDATE(nuSolicitud);sbSysdate = UT_DATE.FSBSTR_SYSDATE();dtSysdate = UT_CONVERT.FNUCHARTODATE(sbSysdate);dtRequestDate = UT_DATE.FDTTRUNCATEDATE(dtRequestDate);dtSysdate = UT_DATE.FDTTRUNCATEDATE(dtSysdate);nuPackageType = 100209;if (dtRequestDate <> dtSysdate,inuEntityID = 2012;GE_BOALERTMESSAGEPARAM.VERANDSENDNOTIF(inuEntityID,nuPackageType,nuSolicitud,null,osbNotifSends,osbLogNotif);,);nuMotiveId = CF_BOSTATEMENTSWF.FNUGETINITMOTIVE(nuSolicitud);nuAnswerId = MO_BOMOTIVE.FNUGETANSWERID(nuMotiveId);if (nuAnswerId = null,MO_BOATTENTION.ACTCREATEPLANWF();,cnuAceptada = 40;if (CC_BOANSWER.FNUGETANSWERTYPEID(nuAnswerId) = cnuAceptada,MO_BOSUSPENSION.SUSPVOLPRODATTENTION(nuMotiveId);,MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(nuSolicitud,60);););cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", nuSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.' ||
'FNUCHARTONUMBER(nuSolicitud),cnuTipoFechaPQR,dtFechaSolicitud)'
,
'LBTEST'
,
to_date('15-03-2012 18:19:41','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:15','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:15','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Acci¿n de Atenci¿n de Solicitud de Suspensi¿n Voluntaria'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb3_0(0):=8115;
RQTY_100209_.tb3_1(0):=RQTY_100209_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100209_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100209_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Atenci¿n Solicitud de Suspensi¿n Voluntaria'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100209_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100209_.tb3_0(0),
RQTY_100209_.tb3_1(0),
5,
'Atenci¿n Solicitud de Suspensi¿n Voluntaria'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb4_0(0):=RQTY_100209_.tb3_0(0);
RQTY_100209_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100209_.tb4_0(0),
VALID_MODULE_ID=RQTY_100209_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100209_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100209_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100209_.tb4_0(0),
RQTY_100209_.tb4_1(0));
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb4_0(1):=RQTY_100209_.tb3_0(0);
RQTY_100209_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100209_.tb4_0(1),
VALID_MODULE_ID=RQTY_100209_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100209_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100209_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100209_.tb4_0(1),
RQTY_100209_.tb4_1(1));
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb4_0(2):=RQTY_100209_.tb3_0(0);
RQTY_100209_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100209_.tb4_0(2),
VALID_MODULE_ID=RQTY_100209_.tb4_1(2)
 WHERE ACTION_ID = RQTY_100209_.tb4_0(2) AND VALID_MODULE_ID = RQTY_100209_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100209_.tb4_0(2),
RQTY_100209_.tb4_1(2));
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb5_0(0):=100209;
RQTY_100209_.tb5_1(0):=RQTY_100209_.tb3_0(0);
RQTY_100209_.tb5_4(0):='P_SUSPENSION_VOLUNTARIA_100209'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100209_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100209_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100209_.tb5_4(0),
DESCRIPTION='Suspensión Voluntaria'
,
PROCESS_WITH_XML='N'
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
IS_DEMAND_REQUEST='N'
,
ANSWER_REQUIRED='Y'
,
LIQUIDATION_METHOD=2
 WHERE PACKAGE_TYPE_ID = RQTY_100209_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100209_.tb5_0(0),
RQTY_100209_.tb5_1(0),
null,
null,
RQTY_100209_.tb5_4(0),
'Suspensión Voluntaria'
,
'N'
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
'N'
,
'Y'
,
2);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb6_0(0):=120023597;
RQTY_100209_.tb6_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100209_.tb6_0(0):=RQTY_100209_.tb6_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100209_.tb6_0(0),
16,
'Relaci¿n entre el solicitante y el predio'
,
'SELECT ROLE_ID ID, DESCRIPTION FROM cc_role'
,
'Relaci¿n entre el solicitante y el predio'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(0):=105180;
RQTY_100209_.tb7_1(0):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(0):=9179;
RQTY_100209_.tb7_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(0),-1)));
RQTY_100209_.old_tb7_3(0):=149340;
RQTY_100209_.tb7_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(0),-1)));
RQTY_100209_.old_tb7_4(0):=null;
RQTY_100209_.tb7_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(0),-1)));
RQTY_100209_.old_tb7_5(0):=null;
RQTY_100209_.tb7_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(0),-1)));
RQTY_100209_.tb7_6(0):=RQTY_100209_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(0),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(0),
ENTITY_ID=RQTY_100209_.tb7_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(0),
STATEMENT_ID=RQTY_100209_.tb7_6(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Relación del Solicitante con el Predio'
,
DISPLAY_ORDER=13,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ROLE_ID'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='ROLE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(0),
RQTY_100209_.tb7_1(0),
RQTY_100209_.tb7_2(0),
RQTY_100209_.tb7_3(0),
RQTY_100209_.tb7_4(0),
RQTY_100209_.tb7_5(0),
RQTY_100209_.tb7_6(0),
null,
null,
null,
13,
'Relación del Solicitante con el Predio'
,
13,
'Y'
,
'N'
,
'N'
,
'ROLE_ID'
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
'MO_SUBS_TYPE_MOTIV'
,
'ROLE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100209_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100209_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100209_.tb0_0(1),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb1_0(1):=23;
RQTY_100209_.tb1_1(1):=RQTY_100209_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100209_.tb1_0(1),
MODULE_ID=RQTY_100209_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100209_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100209_.tb1_0(1),
RQTY_100209_.tb1_1(1),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(1):=121048628;
RQTY_100209_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(1):=RQTY_100209_.tb2_0(1);
RQTY_100209_.old_tb2_1(1):='MO_INITATRIB_CT23E121048628'
;
RQTY_100209_.tb2_1(1):=RQTY_100209_.tb2_0(1);
RQTY_100209_.tb2_2(1):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(1),
RQTY_100209_.tb2_1(1),
RQTY_100209_.tb2_2(1),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",nuSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSubscriberId);,)'
,
'LBTEST'
,
to_date('07-06-2012 15:35:27','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_SUBS_TYPE_MOTIV - SUBSCRIBER_ID - Inicializaci¿n del usuario del servicio'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(1):=105181;
RQTY_100209_.tb7_1(1):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(1):=9179;
RQTY_100209_.tb7_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(1),-1)));
RQTY_100209_.old_tb7_3(1):=50000606;
RQTY_100209_.tb7_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(1),-1)));
RQTY_100209_.old_tb7_4(1):=null;
RQTY_100209_.tb7_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(1),-1)));
RQTY_100209_.old_tb7_5(1):=null;
RQTY_100209_.tb7_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(1),-1)));
RQTY_100209_.tb7_7(1):=RQTY_100209_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(1),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(1),
ENTITY_ID=RQTY_100209_.tb7_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(1),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Usuario del Servicio'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='USUARIO_DEL_SERVICIO'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='SUBSCRIBER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(1),
RQTY_100209_.tb7_1(1),
RQTY_100209_.tb7_2(1),
RQTY_100209_.tb7_3(1),
RQTY_100209_.tb7_4(1),
RQTY_100209_.tb7_5(1),
null,
RQTY_100209_.tb7_7(1),
null,
null,
12,
'Usuario del Servicio'
,
12,
'N'
,
'N'
,
'N'
,
'USUARIO_DEL_SERVICIO'
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
'MO_SUBS_TYPE_MOTIV'
,
'SUBSCRIBER_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(2):=105182;
RQTY_100209_.tb7_1(2):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(2):=9179;
RQTY_100209_.tb7_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(2),-1)));
RQTY_100209_.old_tb7_3(2):=39387;
RQTY_100209_.tb7_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(2),-1)));
RQTY_100209_.old_tb7_4(2):=255;
RQTY_100209_.tb7_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(2),-1)));
RQTY_100209_.old_tb7_5(2):=null;
RQTY_100209_.tb7_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(2),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(2),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(2),
ENTITY_ID=RQTY_100209_.tb7_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=10,
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(2),
RQTY_100209_.tb7_1(2),
RQTY_100209_.tb7_2(2),
RQTY_100209_.tb7_3(2),
RQTY_100209_.tb7_4(2),
RQTY_100209_.tb7_5(2),
null,
null,
null,
null,
10,
'Identificador De Solicitud'
,
10,
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
'MO_SUBS_TYPE_MOTIV'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(3):=105183;
RQTY_100209_.tb7_1(3):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(3):=17;
RQTY_100209_.tb7_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(3),-1)));
RQTY_100209_.old_tb7_3(3):=42118;
RQTY_100209_.tb7_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(3),-1)));
RQTY_100209_.old_tb7_4(3):=109479;
RQTY_100209_.tb7_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(3),-1)));
RQTY_100209_.old_tb7_5(3):=null;
RQTY_100209_.tb7_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(3),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(3),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(3),
ENTITY_ID=RQTY_100209_.tb7_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='C¿digo Canal De Ventas'
,
DISPLAY_ORDER=15,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(3),
RQTY_100209_.tb7_1(3),
RQTY_100209_.tb7_2(3),
RQTY_100209_.tb7_3(3),
RQTY_100209_.tb7_4(3),
RQTY_100209_.tb7_5(3),
null,
null,
null,
null,
15,
'C¿digo Canal De Ventas'
,
15,
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(2):=121048629;
RQTY_100209_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(2):=RQTY_100209_.tb2_0(2);
RQTY_100209_.old_tb2_1(2):='MO_INITATRIB_CT23E121048629'
;
RQTY_100209_.tb2_1(2):=RQTY_100209_.tb2_0(2);
RQTY_100209_.tb2_2(2):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(2),
RQTY_100209_.tb2_1(2),
RQTY_100209_.tb2_2(2),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbSubscriberId);,)'
,
'LBTEST'
,
to_date('17-07-2012 15:17:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - SUBSCRIBER_ID - Inicializaci¿n del suscriptor'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(4):=105533;
RQTY_100209_.tb7_1(4):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(4):=17;
RQTY_100209_.tb7_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(4),-1)));
RQTY_100209_.old_tb7_3(4):=4015;
RQTY_100209_.tb7_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(4),-1)));
RQTY_100209_.old_tb7_4(4):=null;
RQTY_100209_.tb7_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(4),-1)));
RQTY_100209_.old_tb7_5(4):=null;
RQTY_100209_.tb7_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(4),-1)));
RQTY_100209_.tb7_7(4):=RQTY_100209_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(4),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(4),
ENTITY_ID=RQTY_100209_.tb7_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Suscriptor'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SUSCRIPTOR'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(4),
RQTY_100209_.tb7_1(4),
RQTY_100209_.tb7_2(4),
RQTY_100209_.tb7_3(4),
RQTY_100209_.tb7_4(4),
RQTY_100209_.tb7_5(4),
null,
RQTY_100209_.tb7_7(4),
null,
null,
16,
'Suscriptor'
,
16,
'N'
,
'N'
,
'N'
,
'SUSCRIPTOR'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(3):=121048630;
RQTY_100209_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(3):=RQTY_100209_.tb2_0(3);
RQTY_100209_.old_tb2_1(3):='MO_INITATRIB_CT23E121048630'
;
RQTY_100209_.tb2_1(3):=RQTY_100209_.tb2_0(3);
RQTY_100209_.tb2_2(3):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(3),
RQTY_100209_.tb2_1(3),
RQTY_100209_.tb2_2(3),
'dtSysdate = UT_DATE.FDTSYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtSysdate)'
,
'LBTEST'
,
to_date('07-06-2012 15:23:11','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - MESSAG_DELIVEY_DATE - Inicializaci¿n de la fecha de env¿o de mensajes'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(5):=105529;
RQTY_100209_.tb7_1(5):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(5):=17;
RQTY_100209_.tb7_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(5),-1)));
RQTY_100209_.old_tb7_3(5):=259;
RQTY_100209_.tb7_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(5),-1)));
RQTY_100209_.old_tb7_4(5):=null;
RQTY_100209_.tb7_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(5),-1)));
RQTY_100209_.old_tb7_5(5):=null;
RQTY_100209_.tb7_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(5),-1)));
RQTY_100209_.tb7_7(5):=RQTY_100209_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(5),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(5),
ENTITY_ID=RQTY_100209_.tb7_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Fecha env¿o mensajes'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='FECHA_ENV_O_MENSAJES'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(5),
RQTY_100209_.tb7_1(5),
RQTY_100209_.tb7_2(5),
RQTY_100209_.tb7_3(5),
RQTY_100209_.tb7_4(5),
RQTY_100209_.tb7_5(5),
null,
RQTY_100209_.tb7_7(5),
null,
null,
17,
'Fecha env¿o mensajes'
,
17,
'N'
,
'N'
,
'N'
,
'FECHA_ENV_O_MENSAJES'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(4):=121048617;
RQTY_100209_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(4):=RQTY_100209_.tb2_0(4);
RQTY_100209_.old_tb2_1(4):='MO_INITATRIB_CT23E121048617'
;
RQTY_100209_.tb2_1(4):=RQTY_100209_.tb2_0(4);
RQTY_100209_.tb2_2(4):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(4),
RQTY_100209_.tb2_1(4),
RQTY_100209_.tb2_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('15-03-2012 13:46:18','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(6):=105167;
RQTY_100209_.tb7_1(6):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(6):=17;
RQTY_100209_.tb7_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(6),-1)));
RQTY_100209_.old_tb7_3(6):=257;
RQTY_100209_.tb7_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(6),-1)));
RQTY_100209_.old_tb7_4(6):=null;
RQTY_100209_.tb7_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(6),-1)));
RQTY_100209_.old_tb7_5(6):=null;
RQTY_100209_.tb7_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(6),-1)));
RQTY_100209_.tb7_7(6):=RQTY_100209_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(6),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(6),
ENTITY_ID=RQTY_100209_.tb7_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Interacciones'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='INTERACCIONES'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(6),
RQTY_100209_.tb7_1(6),
RQTY_100209_.tb7_2(6),
RQTY_100209_.tb7_3(6),
RQTY_100209_.tb7_4(6),
RQTY_100209_.tb7_5(6),
null,
RQTY_100209_.tb7_7(6),
null,
null,
0,
'Interacciones'
,
0,
'Y'
,
'N'
,
'Y'
,
'INTERACCIONES'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(5):=121048618;
RQTY_100209_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(5):=RQTY_100209_.tb2_0(5);
RQTY_100209_.old_tb2_1(5):='MO_INITATRIB_CT23E121048618'
;
RQTY_100209_.tb2_1(5):=RQTY_100209_.tb2_0(5);
RQTY_100209_.tb2_2(5):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(5),
RQTY_100209_.tb2_1(5),
RQTY_100209_.tb2_2(5),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg)'
,
'LBTEST'
,
to_date('15-03-2012 13:51:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - REQUEST_DATE - Inicializaci¿n fecha de solicitud con fecha del sistema'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb1_0(2):=26;
RQTY_100209_.tb1_1(2):=RQTY_100209_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100209_.tb1_0(2),
MODULE_ID=RQTY_100209_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100209_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100209_.tb1_0(2),
RQTY_100209_.tb1_1(2),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(6):=121048619;
RQTY_100209_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(6):=RQTY_100209_.tb2_0(6);
RQTY_100209_.old_tb2_1(6):='MO_VALIDATTR_CT26E121048619'
;
RQTY_100209_.tb2_1(6):=RQTY_100209_.tb2_0(6);
RQTY_100209_.tb2_2(6):=RQTY_100209_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(6),
RQTY_100209_.tb2_1(6),
RQTY_100209_.tb2_2(6),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100209;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No est¿ permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,););)'
,
'LBTEST'
,
to_date('15-03-2012 13:51:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PACKAGES - REQUEST_DATE - Validaci¿n fecha m¿xima de d¿as hac¿a atras en los que se puede registrar la solicitud'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(7):=105168;
RQTY_100209_.tb7_1(7):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(7):=17;
RQTY_100209_.tb7_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(7),-1)));
RQTY_100209_.old_tb7_3(7):=258;
RQTY_100209_.tb7_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(7),-1)));
RQTY_100209_.old_tb7_4(7):=null;
RQTY_100209_.tb7_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(7),-1)));
RQTY_100209_.old_tb7_5(7):=null;
RQTY_100209_.tb7_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(7),-1)));
RQTY_100209_.tb7_7(7):=RQTY_100209_.tb2_0(5);
RQTY_100209_.tb7_8(7):=RQTY_100209_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(7),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(7),
ENTITY_ID=RQTY_100209_.tb7_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(7),
VALID_EXPRESSION_ID=RQTY_100209_.tb7_8(7),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(7),
RQTY_100209_.tb7_1(7),
RQTY_100209_.tb7_2(7),
RQTY_100209_.tb7_3(7),
RQTY_100209_.tb7_4(7),
RQTY_100209_.tb7_5(7),
null,
RQTY_100209_.tb7_7(7),
RQTY_100209_.tb7_8(7),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(8):=105169;
RQTY_100209_.tb7_1(8):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(8):=17;
RQTY_100209_.tb7_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(8),-1)));
RQTY_100209_.old_tb7_3(8):=255;
RQTY_100209_.tb7_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(8),-1)));
RQTY_100209_.old_tb7_4(8):=null;
RQTY_100209_.tb7_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(8),-1)));
RQTY_100209_.old_tb7_5(8):=null;
RQTY_100209_.tb7_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(8),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(8),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(8),
ENTITY_ID=RQTY_100209_.tb7_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(8),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(8),
RQTY_100209_.tb7_1(8),
RQTY_100209_.tb7_2(8),
RQTY_100209_.tb7_3(8),
RQTY_100209_.tb7_4(8),
RQTY_100209_.tb7_5(8),
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
'Y'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(7):=121048620;
RQTY_100209_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(7):=RQTY_100209_.tb2_0(7);
RQTY_100209_.old_tb2_1(7):='MO_INITATRIB_CT23E121048620'
;
RQTY_100209_.tb2_1(7):=RQTY_100209_.tb2_0(7);
RQTY_100209_.tb2_2(7):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(7),
RQTY_100209_.tb2_1(7),
RQTY_100209_.tb2_2(7),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('15-03-2012 14:01:07','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - PERSON_ID - inicializaci¿n del funcionario'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb6_0(1):=120023593;
RQTY_100209_.tb6_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100209_.tb6_0(1):=RQTY_100209_.tb6_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100209_.tb6_0(1),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(9):=105170;
RQTY_100209_.tb7_1(9):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(9):=17;
RQTY_100209_.tb7_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(9),-1)));
RQTY_100209_.old_tb7_3(9):=50001162;
RQTY_100209_.tb7_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(9),-1)));
RQTY_100209_.old_tb7_4(9):=null;
RQTY_100209_.tb7_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(9),-1)));
RQTY_100209_.old_tb7_5(9):=null;
RQTY_100209_.tb7_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(9),-1)));
RQTY_100209_.tb7_6(9):=RQTY_100209_.tb6_0(1);
RQTY_100209_.tb7_7(9):=RQTY_100209_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(9),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(9),
ENTITY_ID=RQTY_100209_.tb7_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(9),
STATEMENT_ID=RQTY_100209_.tb7_6(9),
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(9),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(9),
RQTY_100209_.tb7_1(9),
RQTY_100209_.tb7_2(9),
RQTY_100209_.tb7_3(9),
RQTY_100209_.tb7_4(9),
RQTY_100209_.tb7_5(9),
RQTY_100209_.tb7_6(9),
RQTY_100209_.tb7_7(9),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(8):=121048621;
RQTY_100209_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(8):=RQTY_100209_.tb2_0(8);
RQTY_100209_.old_tb2_1(8):='MO_INITATRIB_CT23E121048621'
;
RQTY_100209_.tb2_1(8):=RQTY_100209_.tb2_0(8);
RQTY_100209_.tb2_2(8):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(8),
RQTY_100209_.tb2_1(8),
RQTY_100209_.tb2_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('15-03-2012 16:22:11','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:16','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb6_0(2):=120023594;
RQTY_100209_.tb6_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100209_.tb6_0(2):=RQTY_100209_.tb6_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100209_.tb6_0(2),
16,
'Lista Puntos de Atenci¿n'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')'
,
'Lista Puntos de Atenci¿n'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(10):=105171;
RQTY_100209_.tb7_1(10):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(10):=17;
RQTY_100209_.tb7_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(10),-1)));
RQTY_100209_.old_tb7_3(10):=109479;
RQTY_100209_.tb7_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(10),-1)));
RQTY_100209_.old_tb7_4(10):=null;
RQTY_100209_.tb7_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(10),-1)));
RQTY_100209_.old_tb7_5(10):=null;
RQTY_100209_.tb7_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(10),-1)));
RQTY_100209_.tb7_6(10):=RQTY_100209_.tb6_0(2);
RQTY_100209_.tb7_7(10):=RQTY_100209_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(10),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(10),
ENTITY_ID=RQTY_100209_.tb7_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(10),
STATEMENT_ID=RQTY_100209_.tb7_6(10),
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Punto de Atención'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(10),
RQTY_100209_.tb7_1(10),
RQTY_100209_.tb7_2(10),
RQTY_100209_.tb7_3(10),
RQTY_100209_.tb7_4(10),
RQTY_100209_.tb7_5(10),
RQTY_100209_.tb7_6(10),
RQTY_100209_.tb7_7(10),
null,
null,
4,
'Punto de Atención'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(9):=121048622;
RQTY_100209_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(9):=RQTY_100209_.tb2_0(9);
RQTY_100209_.old_tb2_1(9):='MO_INITATRIB_CT23E121048622'
;
RQTY_100209_.tb2_1(9):=RQTY_100209_.tb2_0(9);
RQTY_100209_.tb2_2(9):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(9),
RQTY_100209_.tb2_1(9),
RQTY_100209_.tb2_2(9),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('04-04-2012 14:37:00','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb6_0(3):=120023595;
RQTY_100209_.tb6_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100209_.tb6_0(3):=RQTY_100209_.tb6_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100209_.tb6_0(3),
5,
'Listado Medios de Recepci¿n'
,
'SELECT r.RECEPTION_TYPE_ID id, r.description
FROM ge_reception_type r, or_ope_uni_rece_type o, or_operating_unit u
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'r.RECEPTION_TYPE_ID <> GE_BOPARAMETER.fnuGet('|| chr(39) ||'EXTERN_RECEPTION'|| chr(39) ||') '||chr(64)||'
'||chr(64)||'r.RECEPTION_TYPE_ID = :RECEPTION_ID '||chr(64)||'
'||chr(64)||'r.description like :DESCRIPTION '||chr(64)||'
'||chr(64)||'r.reception_type_id = o.reception_type_id '||chr(64)||'
'||chr(64)||'o.operating_unit_id = u.operating_unit_id '||chr(64)||'
'||chr(64)||'u.operating_unit_id = ge_boInstanceControl.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'POS_OPER_UNIT_ID'|| chr(39) ||') '||chr(64)||''
,
'Listado Medios de Recepci¿n'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(11):=105172;
RQTY_100209_.tb7_1(11):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(11):=17;
RQTY_100209_.tb7_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(11),-1)));
RQTY_100209_.old_tb7_3(11):=2683;
RQTY_100209_.tb7_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(11),-1)));
RQTY_100209_.old_tb7_4(11):=null;
RQTY_100209_.tb7_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(11),-1)));
RQTY_100209_.old_tb7_5(11):=null;
RQTY_100209_.tb7_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(11),-1)));
RQTY_100209_.tb7_6(11):=RQTY_100209_.tb6_0(3);
RQTY_100209_.tb7_7(11):=RQTY_100209_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(11),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(11),
ENTITY_ID=RQTY_100209_.tb7_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(11),
STATEMENT_ID=RQTY_100209_.tb7_6(11),
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Medio de Recepción'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(11),
RQTY_100209_.tb7_1(11),
RQTY_100209_.tb7_2(11),
RQTY_100209_.tb7_3(11),
RQTY_100209_.tb7_4(11),
RQTY_100209_.tb7_5(11),
RQTY_100209_.tb7_6(11),
RQTY_100209_.tb7_7(11),
null,
null,
5,
'Medio de Recepción'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(10):=121048623;
RQTY_100209_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(10):=RQTY_100209_.tb2_0(10);
RQTY_100209_.old_tb2_1(10):='MO_INITATRIB_CT23E121048623'
;
RQTY_100209_.tb2_1(10):=RQTY_100209_.tb2_0(10);
RQTY_100209_.tb2_2(10):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(10),
RQTY_100209_.tb2_1(10),
RQTY_100209_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('15-03-2012 17:19:04','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(12):=105173;
RQTY_100209_.tb7_1(12):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(12):=17;
RQTY_100209_.tb7_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(12),-1)));
RQTY_100209_.old_tb7_3(12):=146755;
RQTY_100209_.tb7_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(12),-1)));
RQTY_100209_.old_tb7_4(12):=null;
RQTY_100209_.tb7_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(12),-1)));
RQTY_100209_.old_tb7_5(12):=null;
RQTY_100209_.tb7_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(12),-1)));
RQTY_100209_.tb7_7(12):=RQTY_100209_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(12),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(12),
ENTITY_ID=RQTY_100209_.tb7_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(12),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Información del Solicitante'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(12),
RQTY_100209_.tb7_1(12),
RQTY_100209_.tb7_2(12),
RQTY_100209_.tb7_3(12),
RQTY_100209_.tb7_4(12),
RQTY_100209_.tb7_5(12),
null,
RQTY_100209_.tb7_7(12),
null,
null,
6,
'Información del Solicitante'
,
6,
'Y'
,
'N'
,
'N'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(11):=121048624;
RQTY_100209_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(11):=RQTY_100209_.tb2_0(11);
RQTY_100209_.old_tb2_1(11):='MO_INITATRIB_CT23E121048624'
;
RQTY_100209_.tb2_1(11):=RQTY_100209_.tb2_0(11);
RQTY_100209_.tb2_2(11):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(11),
RQTY_100209_.tb2_1(11),
RQTY_100209_.tb2_2(11),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'LBTEST'
,
to_date('15-03-2012 17:19:04','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(13):=105174;
RQTY_100209_.tb7_1(13):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(13):=17;
RQTY_100209_.tb7_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(13),-1)));
RQTY_100209_.old_tb7_3(13):=146756;
RQTY_100209_.tb7_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(13),-1)));
RQTY_100209_.old_tb7_4(13):=null;
RQTY_100209_.tb7_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(13),-1)));
RQTY_100209_.old_tb7_5(13):=null;
RQTY_100209_.tb7_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(13),-1)));
RQTY_100209_.tb7_7(13):=RQTY_100209_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(13),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(13),
ENTITY_ID=RQTY_100209_.tb7_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(13),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Dirección De Respuesta'
,
DISPLAY_ORDER=7,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(13),
RQTY_100209_.tb7_1(13),
RQTY_100209_.tb7_2(13),
RQTY_100209_.tb7_3(13),
RQTY_100209_.tb7_4(13),
RQTY_100209_.tb7_5(13),
null,
RQTY_100209_.tb7_7(13),
null,
null,
7,
'Dirección De Respuesta'
,
7,
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(14):=105175;
RQTY_100209_.tb7_1(14):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(14):=17;
RQTY_100209_.tb7_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(14),-1)));
RQTY_100209_.old_tb7_3(14):=146754;
RQTY_100209_.tb7_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(14),-1)));
RQTY_100209_.old_tb7_4(14):=null;
RQTY_100209_.tb7_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(14),-1)));
RQTY_100209_.old_tb7_5(14):=null;
RQTY_100209_.tb7_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(14),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(14),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(14),
ENTITY_ID=RQTY_100209_.tb7_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Observaciones'
,
DISPLAY_ORDER=8,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(14),
RQTY_100209_.tb7_1(14),
RQTY_100209_.tb7_2(14),
RQTY_100209_.tb7_3(14),
RQTY_100209_.tb7_4(14),
RQTY_100209_.tb7_5(14),
null,
null,
null,
null,
8,
'Observaciones'
,
8,
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(12):=121048625;
RQTY_100209_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(12):=RQTY_100209_.tb2_0(12);
RQTY_100209_.old_tb2_1(12):='MO_INITATRIB_CT23E121048625'
;
RQTY_100209_.tb2_1(12):=RQTY_100209_.tb2_0(12);
RQTY_100209_.tb2_2(12):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(12),
RQTY_100209_.tb2_1(12),
RQTY_100209_.tb2_2(12),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(5)'
,
'LBTEST'
,
to_date('16-03-2012 16:06:08','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PROCESS - SUSPENSION_TYPE_ID - Inicializaci¿n del tipo de suspensi¿n voluntaria'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb6_0(4):=120023596;
RQTY_100209_.tb6_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100209_.tb6_0(4):=RQTY_100209_.tb6_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100209_.tb6_0(4),
16,
'Tipo de Suspensi¿n Voluntaria'
,
'SELECT suspension_type_id id, description FROM ge_suspension_type'
,
'Tipo de Suspensi¿n Voluntaria'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(15):=105176;
RQTY_100209_.tb7_1(15):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(15):=68;
RQTY_100209_.tb7_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(15),-1)));
RQTY_100209_.old_tb7_3(15):=1863;
RQTY_100209_.tb7_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(15),-1)));
RQTY_100209_.old_tb7_4(15):=null;
RQTY_100209_.tb7_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(15),-1)));
RQTY_100209_.old_tb7_5(15):=null;
RQTY_100209_.tb7_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(15),-1)));
RQTY_100209_.tb7_6(15):=RQTY_100209_.tb6_0(4);
RQTY_100209_.tb7_7(15):=RQTY_100209_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(15),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(15),
ENTITY_ID=RQTY_100209_.tb7_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(15),
STATEMENT_ID=RQTY_100209_.tb7_6(15),
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(15),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Tipo de Suspensión'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='TIPO_DE_SUSPENSION'
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
ATTRI_TECHNICAL_NAME='SUSPENSION_TYPE_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(15),
RQTY_100209_.tb7_1(15),
RQTY_100209_.tb7_2(15),
RQTY_100209_.tb7_3(15),
RQTY_100209_.tb7_4(15),
RQTY_100209_.tb7_5(15),
RQTY_100209_.tb7_6(15),
RQTY_100209_.tb7_7(15),
null,
null,
9,
'Tipo de Suspensión'
,
9,
'Y'
,
'N'
,
'Y'
,
'TIPO_DE_SUSPENSION'
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
'SUSPENSION_TYPE_ID'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(13):=121048626;
RQTY_100209_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(13):=RQTY_100209_.tb2_0(13);
RQTY_100209_.old_tb2_1(13):='MO_INITATRIB_CT23E121048626'
;
RQTY_100209_.tb2_1(13):=RQTY_100209_.tb2_0(13);
RQTY_100209_.tb2_2(13):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(13),
RQTY_100209_.tb2_1(13),
RQTY_100209_.tb2_2(13),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);sbSubscription = "SUBSCRIPTION_ID";sbProduct = "PRODUCT_ID";sbNull = "null";if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbSubscriptionId);sbSubscription = UT_STRING.FSBCONCAT(sbSubscription, sbSubscriptionId, "=");if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",sbProductId);sbProduct = UT_STRING.FSBCONCAT(sbProduct, sbProductId, "=");sbCadena = UT_STRING.FSBCONCAT(sbSubscription, sbProduct, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbCadena);,sbProduct = UT_STRING.FSBCONCAT(sbProduct, sbNull, "=");sbCadena = UT_STRING.FSBCONCAT(sbSubscription, sbProduct, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(s' ||
'bCadena););,)'
,
'LBTEST'
,
to_date('11-04-2012 08:19:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PROCESS - VARCHAR_1 - Inicializaci¿n componente de actualizaci¿n de datos'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(16):=105177;
RQTY_100209_.tb7_1(16):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(16):=68;
RQTY_100209_.tb7_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(16),-1)));
RQTY_100209_.old_tb7_3(16):=6732;
RQTY_100209_.tb7_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(16),-1)));
RQTY_100209_.old_tb7_4(16):=null;
RQTY_100209_.tb7_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(16),-1)));
RQTY_100209_.old_tb7_5(16):=null;
RQTY_100209_.tb7_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(16),-1)));
RQTY_100209_.tb7_7(16):=RQTY_100209_.tb2_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(16),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(16),
ENTITY_ID=RQTY_100209_.tb7_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(16),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Actualización de Datos'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ACTUALIZACION_DE_DATOS'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(16),
RQTY_100209_.tb7_1(16),
RQTY_100209_.tb7_2(16),
RQTY_100209_.tb7_3(16),
RQTY_100209_.tb7_4(16),
RQTY_100209_.tb7_5(16),
null,
RQTY_100209_.tb7_7(16),
null,
null,
14,
'Actualización de Datos'
,
14,
'Y'
,
'N'
,
'N'
,
'ACTUALIZACION_DE_DATOS'
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
'Y'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(14):=121048627;
RQTY_100209_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(14):=RQTY_100209_.tb2_0(14);
RQTY_100209_.old_tb2_1(14):='MO_INITATRIB_CT23E121048627'
;
RQTY_100209_.tb2_1(14):=RQTY_100209_.tb2_0(14);
RQTY_100209_.tb2_2(14):=RQTY_100209_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(14),
RQTY_100209_.tb2_1(14),
RQTY_100209_.tb2_2(14),
'sbSequence = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_SUBS_TYPE_MOTIV", "SEQ_MO_SUBS_TYPE_MOTIV");nuSequence = UT_CONVERT.FNUCHARTONUMBER(sbSequence);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSequence)'
,
'LBTEST'
,
to_date('30-05-2012 11:04:07','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_SUBS_TYPE_MOTIV - SUBS_TYPE_MOTIV_ID - Obtiene nuevo identificador del tipo de suscriptor por motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb7_0(17):=105179;
RQTY_100209_.tb7_1(17):=RQTY_100209_.tb5_0(0);
RQTY_100209_.old_tb7_2(17):=9179;
RQTY_100209_.tb7_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100209_.TBENTITYNAME(NVL(RQTY_100209_.old_tb7_2(17),-1)));
RQTY_100209_.old_tb7_3(17):=50000603;
RQTY_100209_.tb7_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_3(17),-1)));
RQTY_100209_.old_tb7_4(17):=null;
RQTY_100209_.tb7_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_4(17),-1)));
RQTY_100209_.old_tb7_5(17):=null;
RQTY_100209_.tb7_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100209_.TBENTITYATTRIBUTENAME(NVL(RQTY_100209_.old_tb7_5(17),-1)));
RQTY_100209_.tb7_7(17):=RQTY_100209_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100209_.tb7_0(17),
PACKAGE_TYPE_ID=RQTY_100209_.tb7_1(17),
ENTITY_ID=RQTY_100209_.tb7_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100209_.tb7_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100209_.tb7_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100209_.tb7_5(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100209_.tb7_7(17),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Identificador de suscriptor por motivo'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICADOR_DE_SUSCRIPTOR_POR_MOTIVO'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='SUBS_TYPE_MOTIV_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100209_.tb7_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100209_.tb7_0(17),
RQTY_100209_.tb7_1(17),
RQTY_100209_.tb7_2(17),
RQTY_100209_.tb7_3(17),
RQTY_100209_.tb7_4(17),
RQTY_100209_.tb7_5(17),
null,
RQTY_100209_.tb7_7(17),
null,
null,
11,
'Identificador de suscriptor por motivo'
,
11,
'N'
,
'N'
,
'Y'
,
'IDENTIFICADOR_DE_SUSCRIPTOR_POR_MOTIVO'
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
'MO_SUBS_TYPE_MOTIV'
,
'SUBS_TYPE_MOTIV_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb1_0(3):=69;
RQTY_100209_.tb1_1(3):=RQTY_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100209_.tb1_0(3),
MODULE_ID=RQTY_100209_.tb1_1(3),
DESCRIPTION='Reglas validación de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULVAL_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100209_.tb1_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100209_.tb1_0(3),
RQTY_100209_.tb1_1(3),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(15):=121048678;
RQTY_100209_.tb2_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(15):=RQTY_100209_.tb2_0(15);
RQTY_100209_.old_tb2_1(15):='GEGE_EXERULVAL_CT69E121048678'
;
RQTY_100209_.tb2_1(15):=RQTY_100209_.tb2_0(15);
RQTY_100209_.tb2_2(15):=RQTY_100209_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(15),
RQTY_100209_.tb2_1(15),
RQTY_100209_.tb2_2(15),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);OBTBALANVALBYPRODUCT(nuIdProd,nuEstado,nuVlrCte,nuVlrDif,nuError,sbError);if (nuError = 0,if (nuEstado = 1,GE_BOERRORS.SETERRORCODEARGUMENT(901110,UT_STRING.FSBCONCATSTRING("El producto tiene Saldo en Cartera Corriente por valor de", nuVlrCte, " "));,);if (nuEstado = 2,GE_BOERRORS.SETERRORCODEARGUMENT(901110,UT_STRING.FSBCONCATSTRING("El producto tiene Saldo en Cartera Diferida por valor de", nuVlrDif, " "));,);if (nuEstado = 3,nuTotCar = nuVlrCte + nuVlrDif;GE_BOERRORS.SETERRORCODEARGUMENT(901110,UT_STRING.FSBCONCATSTRING("El producto tiene Saldo en Cartera Corriente y Diferida por valor de", nuTotCar, " "));,);,GE_BOERRORS.SETERRORCODEARGUMENT(901110,"Se presento un error obteniendo el saldo de cartera del producto");)'
,
'EDGANINO'
,
to_date('25-04-2013 14:25:23','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:46','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida  que el producto no tenga saldo en pendiente en cartera corriente ni diferida'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(0):=5001169;
RQTY_100209_.tb8_1(0):=RQTY_100209_.tb2_0(15);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(0),
VALID_EXPRESSION=RQTY_100209_.tb8_1(0),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_SALDO_PEND_PROD'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida  que el producto no tenga saldo en pendiente en cartera corriente ni diferida'
,
DISPLAY_NAME='Valida  que el producto no tenga saldo en pendiente en cartera corriente ni diferida'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(0),
RQTY_100209_.tb8_1(0),
null,
1,
5,
22,
'VAL_SALDO_PEND_PROD'
,
4,
0,
0,
null,
null,
'Valida  que el producto no tenga saldo en pendiente en cartera corriente ni diferida'
,
'Valida  que el producto no tenga saldo en pendiente en cartera corriente ni diferida'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(0):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(0):=RQTY_100209_.tb8_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(0),
RQTY_100209_.tb9_1(0),
'Valida  que el producto no tenga saldo en pendiente en cartera corriente ni diferida'
,
'Y'
,
1,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb1_0(4):=64;
RQTY_100209_.tb1_1(4):=RQTY_100209_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (4)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100209_.tb1_0(4),
MODULE_ID=RQTY_100209_.tb1_1(4),
DESCRIPTION='Validaci¿n Tramites'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDTRAM_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100209_.tb1_0(4);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100209_.tb1_0(4),
RQTY_100209_.tb1_1(4),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(16):=121061866;
RQTY_100209_.tb2_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(16):=RQTY_100209_.tb2_0(16);
RQTY_100209_.old_tb2_1(16):='MO_VALIDTRAM_CT64E121061866'
;
RQTY_100209_.tb2_1(16):=RQTY_100209_.tb2_0(16);
RQTY_100209_.tb2_2(16):=RQTY_100209_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(16),
RQTY_100209_.tb2_1(16),
RQTY_100209_.tb2_2(16),
'INUPRODUCTID=GE_BOINSTANCEUTILITIES.FSBGETWORKINSTANCEATTRIBUTE(NULL, "PR_PRODUCT", "PRODUCT_ID");INUSUBSCRIPTIONID=PR_BOPRODUCT.GETSUBSCRIPTIONID(INUPRODUCTID);INUSERVNUM=PR_BOPRODUCT.FSBGETSERVNUMBBYPROD(INUPRODUCTID);NUSUBSCRIBER  = PKBODATA.FNUGETVALUE("SUSCRIPC","SUSCCLIE",INUSUBSCRIPTIONID);NUTYPE= DAGE_SUBSCRIBER.FNUGETSUBSCRIBER_TYPE_ID(NUSUBSCRIBER);SBSUBSCRIBERTYPE = DAGE_SUBSCRIBER_TYPE.FSBGETDESCRIPTION(NUTYPE,1);SBCONCATENACADENA=UT_STRING.FSBCONCAT(INUPRODUCTID,SBSUBSCRIBERTYPE,"|");NUMAXBILL = DAGE_SUBSCRIBER_TYPE.FNUGETMAX_EXPIRED_BILLS(NUTYPE);IF(NUMAXBILL = NULL,GI_BOERRORS.SETERRORCODEARGUMENT(3089,SBSUBSCRIBERTYPE);,);PKSERVNUMBER.GETNUMBEREXPACCOUNTS (INUPRODUCTID, NUEXPBILLPROD,NUERRORCODE,SBERRORMESSAGE);IF(NUERRORCODE <> 0, GI_BOERRORS.SETERRORCODE(NUERRORCODE);,);IF(NUEXPBILLPROD > NUMAXBILL, GI_BOERRORS.SETERRORCODEARGUMENT(3088,SBCONCATENACADENA);,)'
,
'CONFBOSS'
,
to_date('06-05-2005 00:00:00','DD-MM-YYYY HH24:MI:SS'),
to_date('03-04-2014 21:54:52','DD-MM-YYYY HH24:MI:SS'),
to_date('03-04-2014 21:54:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR - Valida maximo numero de cuentas vencidas x producto x tipo de cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(1):=30;
RQTY_100209_.tb8_1(1):=RQTY_100209_.tb2_0(16);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(1),
VALID_EXPRESSION=RQTY_100209_.tb8_1(1),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VALIDA_MAXFACVEN_PRODUCTO'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida Maximo numero de cuentas vencidas por tipo de cliente x producto'
,
DISPLAY_NAME='Valida Maximo numero de cuentas vencidas por tipo de cliente x producto'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(1),
RQTY_100209_.tb8_1(1),
null,
1,
5,
22,
'VALIDA_MAXFACVEN_PRODUCTO'
,
4,
0,
0,
null,
null,
'Valida Maximo numero de cuentas vencidas por tipo de cliente x producto'
,
'Valida Maximo numero de cuentas vencidas por tipo de cliente x producto'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(1):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(1):=RQTY_100209_.tb8_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(1),
RQTY_100209_.tb9_1(1),
'Valida Maximo numero de cuentas vencidas por tipo de cliente x producto'
,
'Y'
,
0,
'M'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(17):=121192148;
RQTY_100209_.tb2_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(17):=RQTY_100209_.tb2_0(17);
RQTY_100209_.old_tb2_1(17):='GEGE_EXERULVAL_CT69E121192148'
;
RQTY_100209_.tb2_1(17):=RQTY_100209_.tb2_0(17);
RQTY_100209_.tb2_2(17):=RQTY_100209_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(17),
RQTY_100209_.tb2_1(17),
RQTY_100209_.tb2_2(17),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);nuEstadoActivo = DAGE_PARAMETER.FSBGETVALUE("PRODACTI");nuEstadoProd = dapr_product.fnugetproduct_status_id(nuProductId);if (nuEstadoProd <> UT_CONVERT.FNUCHARTONUMBER(nuEstadoActivo),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El producto no se encuentra activo, el tr¿mite s¿lo se permite sobre un producto activo");,)'
,
'LBTEST'
,
to_date('27-08-2010 11:25:30','DD-MM-YYYY HH24:MI:SS'),
to_date('26-05-2016 20:08:41','DD-MM-YYYY HH24:MI:SS'),
to_date('26-05-2016 20:08:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida estado activo del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(2):=3897541;
RQTY_100209_.tb8_1(2):=RQTY_100209_.tb2_0(17);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(2),
VALID_EXPRESSION=RQTY_100209_.tb8_1(2),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='ACTIVE_PRODUCT'
,
LENGTH=100,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida estado activo del producto.'
,
DISPLAY_NAME='Valida estado activo del producto'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(2),
RQTY_100209_.tb8_1(2),
null,
1,
5,
22,
'ACTIVE_PRODUCT'
,
100,
null,
null,
null,
null,
'Valida estado activo del producto.'
,
'Valida estado activo del producto'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(2):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(2):=RQTY_100209_.tb8_0(2);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (2)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(2),
RQTY_100209_.tb9_1(2),
'Valida estado activo del producto'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(18):=121122840;
RQTY_100209_.tb2_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(18):=RQTY_100209_.tb2_0(18);
RQTY_100209_.old_tb2_1(18):='MO_VALIDTRAM_CT64E121122840'
;
RQTY_100209_.tb2_1(18):=RQTY_100209_.tb2_0(18);
RQTY_100209_.tb2_2(18):=RQTY_100209_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(18),
RQTY_100209_.tb2_1(18),
RQTY_100209_.tb2_2(18),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);sbProdEsProvi = DAPR_PRODUCT.FSBGETIS_PROVISIONAL(nuIdProd);if (sbProdEsProvi = "Y",GE_BOERRORS.SETERRORCODE(284);,)'
,
'CONFBOSS'
,
to_date('23-05-2005 12:09:55','DD-MM-YYYY HH24:MI:SS'),
to_date('25-11-2014 08:00:09','DD-MM-YYYY HH24:MI:SS'),
to_date('25-11-2014 08:00:09','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR - Valida si el producto es provisional'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(3):=32;
RQTY_100209_.tb8_1(3):=RQTY_100209_.tb2_0(18);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (3)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(3),
VALID_EXPRESSION=RQTY_100209_.tb8_1(3),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VALIDA_PROVISIONAL'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida si el producto es provisional'
,
DISPLAY_NAME='Valida si el producto es provisional'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(3);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(3),
RQTY_100209_.tb8_1(3),
null,
1,
5,
22,
'VALIDA_PROVISIONAL'
,
4,
0,
0,
null,
null,
'Valida si el producto es provisional'
,
'Valida si el producto es provisional'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(3):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(3):=RQTY_100209_.tb8_0(3);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (3)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(3),
RQTY_100209_.tb9_1(3),
'Valida si el producto es provisional'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(19):=121192149;
RQTY_100209_.tb2_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(19):=RQTY_100209_.tb2_0(19);
RQTY_100209_.old_tb2_1(19):='MO_VALIDTRAM_CT64E121192149'
;
RQTY_100209_.tb2_1(19):=RQTY_100209_.tb2_0(19);
RQTY_100209_.tb2_2(19):=RQTY_100209_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(19),
RQTY_100209_.tb2_1(19),
RQTY_100209_.tb2_2(19),
'GE_BOINSTANCECONTROL.GetAttributeNewValue("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.GetAttributeNewValue("WORK_INSTANCE",null,"MO_PROCESS","PACKAGE_TYPE_ID",nuPackageTypeId);PS_BOPackTypeValidate.valpendPackTypeProd(nuPackageTypeId,nuProductId,GE_BOParameter.fsbget("YES"),sbResponse);if (nuPackageTypeId = "100225",PR_BOPRODUCT.GETUSESTRATUM(nuProductId,nuCategoria,nuSubcategoria);if (nuCategoria <> 1 '||chr(38)||''||chr(38)||' nuCategoria <> 2,LDC_OSF_VALPENDPACKTYPEPROD(288,nuProductId,GE_BOParameter.fsbget("YES"),sbResponse);,);,)'
,
'CONFBOSS'
,
to_date('17-06-2005 12:02:46','DD-MM-YYYY HH24:MI:SS'),
to_date('26-05-2016 20:08:42','DD-MM-YYYY HH24:MI:SS'),
to_date('26-05-2016 20:08:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - CON - Valida tramites pendientes segun el tramite en que este, dado el producto.'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(4):=80;
RQTY_100209_.tb8_1(4):=RQTY_100209_.tb2_0(19);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (4)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(4),
VALID_EXPRESSION=RQTY_100209_.tb8_1(4),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VALIDA_TRAM_POR_PACK_PROD'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que no pueda hacerse el tr¿mite si tiene alg¿n tr¿mite pendiente dado el producto.'
,
DISPLAY_NAME='Valida que no pueda hacerse el tr¿mite si tiene alg¿n tr¿mite pendiente dado el producto.'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(4);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(4),
RQTY_100209_.tb8_1(4),
null,
1,
5,
22,
'VALIDA_TRAM_POR_PACK_PROD'
,
4,
0,
0,
null,
null,
'Valida que no pueda hacerse el tr¿mite si tiene alg¿n tr¿mite pendiente dado el producto.'
,
'Valida que no pueda hacerse el tr¿mite si tiene alg¿n tr¿mite pendiente dado el producto.'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(4):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(4):=RQTY_100209_.tb8_0(4);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (4)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(4),
RQTY_100209_.tb9_1(4),
'Valida que no pueda hacerse el tr¿mite si tiene alg¿n tr¿mite pendiente dado el producto.'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(20):=121122848;
RQTY_100209_.tb2_0(20):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(20):=RQTY_100209_.tb2_0(20);
RQTY_100209_.old_tb2_1(20):='MO_VALIDTRAM_CT64E121122848'
;
RQTY_100209_.tb2_1(20):=RQTY_100209_.tb2_0(20);
RQTY_100209_.tb2_2(20):=RQTY_100209_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (20)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(20),
RQTY_100209_.tb2_1(20),
RQTY_100209_.tb2_2(20),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_STATUS_ID",sbProdStatusId);if (UT_CONVERT.FNUCHARTONUMBER(sbProdStatusId) <> 15,PKSERVNUMBERINQUIRY.VALIDATEISBILLIABLE(nuIdProd,sbEsco,nuError,sbError);if (nuError = 0,if (sbEsco <> 0,GE_BOERRORS.SETERRORCODE(34);,);,GE_BOERRORS.SETERRORCODE(37););,)'
,
'CONFBOSS'
,
to_date('23-05-2005 15:01:06','DD-MM-YYYY HH24:MI:SS'),
to_date('25-11-2014 08:00:09','DD-MM-YYYY HH24:MI:SS'),
to_date('25-11-2014 08:00:09','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR - Valida estado de facturacion del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(5):=624;
RQTY_100209_.tb8_1(5):=RQTY_100209_.tb2_0(20);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (5)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(5),
VALID_EXPRESSION=RQTY_100209_.tb8_1(5),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_ESTADO_FACT_PROD'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='VALIDA ESTADO DE FACTURACION DEL PRODUCTO'
,
DISPLAY_NAME='VALIDA ESTADO DE FACTURACION DEL PRODUCTO'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(5);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(5),
RQTY_100209_.tb8_1(5),
null,
1,
5,
22,
'VAL_ESTADO_FACT_PROD'
,
4,
0,
0,
null,
null,
'VALIDA ESTADO DE FACTURACION DEL PRODUCTO'
,
'VALIDA ESTADO DE FACTURACION DEL PRODUCTO'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(5):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(5):=RQTY_100209_.tb8_0(5);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (5)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(5),
RQTY_100209_.tb9_1(5),
'VALIDA ESTADO DE FACTURACION DEL PRODUCTO'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(21):=121207012;
RQTY_100209_.tb2_0(21):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(21):=RQTY_100209_.tb2_0(21);
RQTY_100209_.old_tb2_1(21):='MO_VALIDTRAM_CT64E121207012'
;
RQTY_100209_.tb2_1(21):=RQTY_100209_.tb2_0(21);
RQTY_100209_.tb2_2(21):=RQTY_100209_.tb1_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (21)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(21),
RQTY_100209_.tb2_1(21),
RQTY_100209_.tb2_2(21),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuIdProd);blSal = PR_BOVALIDATE.FBLVALIDATEPENDINGPROD(nuIdProd, true)'
,
'CONFBOSS'
,
to_date('18-05-2007 08:56:08','DD-MM-YYYY HH24:MI:SS'),
to_date('23-08-2016 22:55:59','DD-MM-YYYY HH24:MI:SS'),
to_date('23-08-2016 22:55:59','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR - Valida si el producto est¿ en estado Pendiente de Instalaci¿n'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(6):=728;
RQTY_100209_.tb8_1(6):=RQTY_100209_.tb2_0(21);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (6)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(6),
VALID_EXPRESSION=RQTY_100209_.tb8_1(6),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PROD_STATUS_IS_PEND_INSTALL'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida si el producto est¿ en estado Pendiente de Instalaci¿n'
,
DISPLAY_NAME='Valida si el producto est¿ en estado Pendiente de Instalaci¿n'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(6);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(6),
RQTY_100209_.tb8_1(6),
null,
1,
5,
22,
'VAL_PROD_STATUS_IS_PEND_INSTALL'
,
4,
0,
0,
null,
null,
'Valida si el producto est¿ en estado Pendiente de Instalaci¿n'
,
'Valida si el producto est¿ en estado Pendiente de Instalaci¿n'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(6):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(6):=RQTY_100209_.tb8_0(6);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (6)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(6),
RQTY_100209_.tb9_1(6),
'Valida si el producto est¿ en estado Pendiente de Instalaci¿n'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(22):=121203952;
RQTY_100209_.tb2_0(22):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(22):=RQTY_100209_.tb2_0(22);
RQTY_100209_.old_tb2_1(22):='GEGE_EXERULVAL_CT69E121203952'
;
RQTY_100209_.tb2_1(22):=RQTY_100209_.tb2_0(22);
RQTY_100209_.tb2_2(22):=RQTY_100209_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (22)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(22),
RQTY_100209_.tb2_1(22),
RQTY_100209_.tb2_2(22),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,"PR_PRODUCT","PRODUCT_ID",sbpPoductId);nuProductId = UT_CONVERT.FNUCHARTONUMBER(sbpPoductId);sbAnswer = PR_BOCNFSUSPENSION.FSBPRODHASPENDORACTSUSP(nuProductId);if (sbAnswer = "Y",GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El producto se encuentre suspendido o en proceso de suspensi¿n");,)'
,
'LBTEST'
,
to_date('27-02-2012 18:06:15','DD-MM-YYYY HH24:MI:SS'),
to_date('09-08-2016 20:44:00','DD-MM-YYYY HH24:MI:SS'),
to_date('09-08-2016 20:44:00','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida si el producto est¿ suspendidos o tiene suspensiones pendientes'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(7):=16;
RQTY_100209_.tb8_1(7):=RQTY_100209_.tb2_0(22);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (7)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(7),
VALID_EXPRESSION=RQTY_100209_.tb8_1(7),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=2,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_PROD_NO_SUSPENDIDO '
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida si el producto est¿ suspendido'
,
DISPLAY_NAME='Valida si el producto est¿ suspendido'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(7);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(7),
RQTY_100209_.tb8_1(7),
null,
2,
5,
22,
'VAL_PROD_NO_SUSPENDIDO '
,
null,
null,
null,
null,
null,
'Valida si el producto est¿ suspendido'
,
'Valida si el producto est¿ suspendido'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(7):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(7):=RQTY_100209_.tb8_0(7);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (7)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(7),
RQTY_100209_.tb9_1(7),
'Valida si el producto est¿ suspendido'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.old_tb2_0(23):=121122861;
RQTY_100209_.tb2_0(23):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100209_.tb2_0(23):=RQTY_100209_.tb2_0(23);
RQTY_100209_.old_tb2_1(23):='GEGE_EXERULVAL_CT69E121122861'
;
RQTY_100209_.tb2_1(23):=RQTY_100209_.tb2_0(23);
RQTY_100209_.tb2_2(23):=RQTY_100209_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (23)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100209_.tb2_0(23),
RQTY_100209_.tb2_1(23),
RQTY_100209_.tb2_2(23),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_TYPE_ID",nuProductTypeId);MO_BOGENERICVALID.VALACTIVABLESUSPPRD("V",nuProductId,nuProductTypeId,sbresponse);if (sbresponse = "N",GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No existe configuración de tipos de suspensiones voluntarias por tipo de producto. ");,)'
,
'CARLPARR'
,
to_date('04-04-2013 11:43:30','DD-MM-YYYY HH24:MI:SS'),
to_date('25-11-2014 08:00:10','DD-MM-YYYY HH24:MI:SS'),
to_date('25-11-2014 08:00:10','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALTRAM - PR- Valida que existan tipos suspensiones Voluntarias activas para el tipo de producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(8):=5000112;
RQTY_100209_.tb8_1(8):=RQTY_100209_.tb2_0(23);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (8)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(8),
VALID_EXPRESSION=RQTY_100209_.tb8_1(8),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=22,
NAME_ATTRIBUTE='VAL_SUSP_VOL_ACT'
,
LENGTH=4,
PRECISION=0,
SCALE=0,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que existan tipos suspensiones Voluntarias activas para el tipo de producto'
,
DISPLAY_NAME='Valida que existan tipos suspensiones Voluntarias activas para el tipo de producto'

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(8);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(8),
RQTY_100209_.tb8_1(8),
null,
1,
5,
22,
'VAL_SUSP_VOL_ACT'
,
4,
0,
0,
null,
null,
'Valida que existan tipos suspensiones Voluntarias activas para el tipo de producto'
,
'Valida que existan tipos suspensiones Voluntarias activas para el tipo de producto'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(8):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(8):=RQTY_100209_.tb8_0(8);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (8)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(8),
RQTY_100209_.tb9_1(8),
'Valida que existan tipos suspensiones Voluntarias activas para el tipo de producto'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb8_0(9):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (9)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100209_.tb8_0(9),
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

 WHERE ATTRIBUTE_ID = RQTY_100209_.tb8_0(9);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100209_.tb8_0(9),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb9_0(9):=RQTY_100209_.tb5_0(0);
RQTY_100209_.tb9_1(9):=RQTY_100209_.tb8_0(9);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (9)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100209_.tb9_0(9),
RQTY_100209_.tb9_1(9),
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb10_0(0):=10000000211;
RQTY_100209_.tb10_1(0):=RQTY_100209_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100209_.tb10_0(0),
PACKAGE_TYPE_ID=RQTY_100209_.tb10_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=100361,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100209_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100209_.tb10_0(0),
RQTY_100209_.tb10_1(0),
null,
null,
100361,
21);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb11_0(0):=100211;
RQTY_100209_.tb11_1(0):=RQTY_100209_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100209_.tb11_0(0),
VALUE_1=RQTY_100209_.tb11_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=100361,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Suspensión Voluntaria'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100209_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100209_.tb11_0(0),
RQTY_100209_.tb11_1(0),
null,
21,
100361,
0,
31536000,
0,
'Suspensión Voluntaria'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb12_0(0):='104'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100209_.tb12_0(0),
'Utilities'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb13_0(0):=104;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100209_.tb13_0(0),
'Utilities'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb14_0(0):=7014;
RQTY_100209_.tb14_2(0):=RQTY_100209_.tb12_0(0);
RQTY_100209_.tb14_3(0):=RQTY_100209_.tb13_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100209_.tb14_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100209_.tb14_2(0),
SERVSETI=RQTY_100209_.tb14_3(0),
SERVDESC='Gas'
,
SERVCOEX='7014'
,
SERVFLST='N'
,
SERVFLBA='N'
,
SERVFLAC='S'
,
SERVFLIM='N'
,
SERVPRRE=1,
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
SERVTXML='PR_GAS_7014'
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
 WHERE SERVCODI = RQTY_100209_.tb14_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100209_.tb14_0(0),
null,
RQTY_100209_.tb14_2(0),
RQTY_100209_.tb14_3(0),
'Gas'
,
'7014'
,
'N'
,
'N'
,
'S'
,
'N'
,
1,
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
'PR_GAS_7014'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb15_0(0):=7;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100209_.tb15_0(0),
CLASS_REGISTER_ID=6,
DESCRIPTION='Suspensi¿n'
,
ASSIGNABLE='Y'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_SUSPENSION'
,
ACTIVITY_TYPE='S'

 WHERE MOTIVE_TYPE_ID = RQTY_100209_.tb15_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100209_.tb15_0(0),
6,
'Suspensi¿n'
,
'Y'
,
'Y'
,
'MOTY_SUSPENSION'
,
'S'
);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb16_0(0):=100239;
RQTY_100209_.tb16_1(0):=RQTY_100209_.tb14_0(0);
RQTY_100209_.tb16_2(0):=RQTY_100209_.tb15_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100209_.tb16_0(0),
RQTY_100209_.tb16_1(0),
RQTY_100209_.tb16_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_GAS_100239'
,
'Suspensión Voluntaria de Gas'
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
RQTY_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;

RQTY_100209_.tb17_0(0):=100239;
RQTY_100209_.tb17_1(0):=RQTY_100209_.tb16_0(0);
RQTY_100209_.tb17_3(0):=RQTY_100209_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100209_.tb17_0(0),
PRODUCT_MOTIVE_ID=RQTY_100209_.tb17_1(0),
PRODUCT_TYPE_ID=7014,
PACKAGE_TYPE_ID=RQTY_100209_.tb17_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100209_.tb17_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100209_.tb17_0(0),
RQTY_100209_.tb17_1(0),
7014,
RQTY_100209_.tb17_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100209_.blProcessStatus := false;
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
nuIndex := RQTY_100209_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100209_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100209_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100209_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100209_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100209_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100209_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100209_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100209_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100209_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100209_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100209_.blProcessStatus := false;
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
 nuIndex := RQTY_100209_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100209_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100209_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100209_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100209_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100209_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100209_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100209_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100209_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100209_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100209_',
'CREATE OR REPLACE PACKAGE RQPMT_100209_ IS ' || chr(10) ||
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
'tb5_0 ty5_0;type ty6_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
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
'where  package_type_id = 100209; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100209 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100209 ' || chr(10) ||
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
'END RQPMT_100209_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100209_******************************'); END;
/

BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100209_.cuExpressions;
fetch RQPMT_100209_.cuExpressions bulk collect INTO RQPMT_100209_.tbExpressionsId;
close RQPMT_100209_.cuExpressions;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100209_.tbEntityName(-1) := 'NULL';
   RQPMT_100209_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityAttributeName(312) := 'MO_SUSPENSION@REGISTER_DATE';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityAttributeName(309) := 'MO_SUSPENSION@MOTIVE_ID';
   RQPMT_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100209_.tbEntityAttributeName(1863) := 'MO_PROCESS@SUSPENSION_TYPE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityAttributeName(311) := 'MO_SUSPENSION@SUSPENSION_TYPE_ID';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityAttributeName(313) := 'MO_SUSPENSION@APLICATION_DATE';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8084) := 'MO_SUSPENSION_COMP@REGISTER_DATE';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8085) := 'MO_SUSPENSION_COMP@APLICATION_DATE';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8082) := 'MO_SUSPENSION_COMP@COMPONENT_ID';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8083) := 'MO_SUSPENSION_COMP@SUSPENSION_TYPE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(89620) := 'MO_COMPONENT@ADDRESS_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8082) := 'MO_SUSPENSION_COMP@COMPONENT_ID';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8083) := 'MO_SUSPENSION_COMP@SUSPENSION_TYPE_ID';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8084) := 'MO_SUSPENSION_COMP@REGISTER_DATE';
   RQPMT_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQPMT_100209_.tbEntityAttributeName(8085) := 'MO_SUSPENSION_COMP@APLICATION_DATE';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(89620) := 'MO_COMPONENT@ADDRESS_ID';
   RQPMT_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityAttributeName(311) := 'MO_SUSPENSION@SUSPENSION_TYPE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQPMT_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQPMT_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQPMT_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQPMT_100209_.tbEntityAttributeName(311) := 'MO_SUSPENSION@SUSPENSION_TYPE_ID';
   RQPMT_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100209_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100209
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
WHERE PACKAGE_type_id = 100209
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
WHERE PACKAGE_type_id = 100209
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
WHERE PACKAGE_type_id = 100209
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
WHERE PACKAGE_type_id = 100209
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
WHERE PACKAGE_type_id = 100209
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100209_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100209
))));

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100209_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100209_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100209_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100209_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100209
))));

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100209
))));

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100209_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100209_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100209
)))));

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100209_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100209_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100209_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100209_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100209_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100209_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100209
))));

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
))));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100209
))));

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
)));
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100209_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100209_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100209_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100209_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100209_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100209_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100209_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100209
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb0_0(0):=100239;
RQPMT_100209_.tb0_1(0):=7014;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100209_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100209_.tb0_1(0),
MOTIVE_TYPE_ID=7,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_INSTALACION_DE_GAS_100239'
,
DESCRIPTION='Suspensión Voluntaria de Gas'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100209_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100209_.tb0_0(0),
RQPMT_100209_.tb0_1(0),
7,
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_GAS_100239'
,
'Suspensión Voluntaria de Gas'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(0):=103240;
RQPMT_100209_.old_tb1_1(0):=24;
RQPMT_100209_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(0),-1)));
RQPMT_100209_.old_tb1_2(0):=312;
RQPMT_100209_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(0),-1)));
RQPMT_100209_.old_tb1_3(0):=258;
RQPMT_100209_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(0),-1)));
RQPMT_100209_.old_tb1_4(0):=null;
RQPMT_100209_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(0),-1)));
RQPMT_100209_.tb1_9(0):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(0),
ENTITY_ID=RQPMT_100209_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(0),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Fecha de Registro'
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
TAG_NAME='REGISTER_DATE'
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
ENTITY_NAME='MO_SUSPENSION'
,
ATTRI_TECHNICAL_NAME='REGISTER_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(0),
RQPMT_100209_.tb1_1(0),
RQPMT_100209_.tb1_2(0),
RQPMT_100209_.tb1_3(0),
RQPMT_100209_.tb1_4(0),
null,
null,
null,
null,
RQPMT_100209_.tb1_9(0),
9,
'Fecha de Registro'
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
'REGISTER_DATE'
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
'MO_SUSPENSION'
,
'REGISTER_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100209_.tb2_0(0),
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

 WHERE MODULE_ID = RQPMT_100209_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100209_.tb2_0(0),
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb3_0(0):=23;
RQPMT_100209_.tb3_1(0):=RQPMT_100209_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100209_.tb3_0(0),
MODULE_ID=RQPMT_100209_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100209_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100209_.tb3_0(0),
RQPMT_100209_.tb3_1(0),
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(0):=121048640;
RQPMT_100209_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(0):=RQPMT_100209_.tb4_0(0);
RQPMT_100209_.old_tb4_1(0):='MO_INITATRIB_CT23E121048640'
;
RQPMT_100209_.tb4_1(0):=RQPMT_100209_.tb4_0(0);
RQPMT_100209_.tb4_2(0):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(0),
RQPMT_100209_.tb4_1(0),
RQPMT_100209_.tb4_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FDTSYSDATE())'
,
'LBTEST'
,
to_date('15-06-2012 10:27:23','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_SUSPENSION - APLICATION_DATE - Inicializa con la fecha del sistema'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(1):=103249;
RQPMT_100209_.old_tb1_1(1):=24;
RQPMT_100209_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(1),-1)));
RQPMT_100209_.old_tb1_2(1):=313;
RQPMT_100209_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(1),-1)));
RQPMT_100209_.old_tb1_3(1):=null;
RQPMT_100209_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(1),-1)));
RQPMT_100209_.old_tb1_4(1):=null;
RQPMT_100209_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(1),-1)));
RQPMT_100209_.tb1_6(1):=RQPMT_100209_.tb4_0(0);
RQPMT_100209_.tb1_9(1):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(1),
ENTITY_ID=RQPMT_100209_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb1_6(1),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(1),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Fecha de Aplicaci¿n'
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
TAG_NAME='APLICATION_DATE'
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
ENTITY_NAME='MO_SUSPENSION'
,
ATTRI_TECHNICAL_NAME='APLICATION_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(1),
RQPMT_100209_.tb1_1(1),
RQPMT_100209_.tb1_2(1),
RQPMT_100209_.tb1_3(1),
RQPMT_100209_.tb1_4(1),
null,
RQPMT_100209_.tb1_6(1),
null,
null,
RQPMT_100209_.tb1_9(1),
10,
'Fecha de Aplicaci¿n'
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
'APLICATION_DATE'
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
'MO_SUSPENSION'
,
'APLICATION_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(1):=121048641;
RQPMT_100209_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(1):=RQPMT_100209_.tb4_0(1);
RQPMT_100209_.old_tb4_1(1):='MO_INITATRIB_CT23E121048641'
;
RQPMT_100209_.tb4_1(1):=RQPMT_100209_.tb4_0(1);
RQPMT_100209_.tb4_2(1):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(1),
RQPMT_100209_.tb4_1(1),
RQPMT_100209_.tb4_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'LBTEST'
,
to_date('13-06-2012 16:05:09','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - MOTIVE_ID - Secuencia del motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(2):=103230;
RQPMT_100209_.old_tb1_1(2):=8;
RQPMT_100209_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(2),-1)));
RQPMT_100209_.old_tb1_2(2):=187;
RQPMT_100209_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(2),-1)));
RQPMT_100209_.old_tb1_3(2):=null;
RQPMT_100209_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(2),-1)));
RQPMT_100209_.old_tb1_4(2):=null;
RQPMT_100209_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(2),-1)));
RQPMT_100209_.tb1_6(2):=RQPMT_100209_.tb4_0(1);
RQPMT_100209_.tb1_9(2):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(2),
ENTITY_ID=RQPMT_100209_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb1_6(2),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(2),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(2),
RQPMT_100209_.tb1_1(2),
RQPMT_100209_.tb1_2(2),
RQPMT_100209_.tb1_3(2),
RQPMT_100209_.tb1_4(2),
null,
RQPMT_100209_.tb1_6(2),
null,
null,
RQPMT_100209_.tb1_9(2),
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(3):=103231;
RQPMT_100209_.old_tb1_1(3):=8;
RQPMT_100209_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(3),-1)));
RQPMT_100209_.old_tb1_2(3):=213;
RQPMT_100209_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(3),-1)));
RQPMT_100209_.old_tb1_3(3):=255;
RQPMT_100209_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(3),-1)));
RQPMT_100209_.old_tb1_4(3):=null;
RQPMT_100209_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(3),-1)));
RQPMT_100209_.tb1_9(3):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(3),
ENTITY_ID=RQPMT_100209_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(3),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(3),
RQPMT_100209_.tb1_1(3),
RQPMT_100209_.tb1_2(3),
RQPMT_100209_.tb1_3(3),
RQPMT_100209_.tb1_4(3),
null,
null,
null,
null,
RQPMT_100209_.tb1_9(3),
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(2):=121048642;
RQPMT_100209_.tb4_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(2):=RQPMT_100209_.tb4_0(2);
RQPMT_100209_.old_tb4_1(2):='MO_INITATRIB_CT23E121048642'
;
RQPMT_100209_.tb4_1(2):=RQPMT_100209_.tb4_0(2);
RQPMT_100209_.tb4_2(2):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(2),
RQPMT_100209_.tb4_1(2),
RQPMT_100209_.tb4_2(2),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductId);,)'
,
'LBTEST'
,
to_date('13-06-2012 16:15:19','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - PRODUCT_ID - Inicializaci¿n del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(4):=103232;
RQPMT_100209_.old_tb1_1(4):=8;
RQPMT_100209_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(4),-1)));
RQPMT_100209_.old_tb1_2(4):=413;
RQPMT_100209_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(4),-1)));
RQPMT_100209_.old_tb1_3(4):=null;
RQPMT_100209_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(4),-1)));
RQPMT_100209_.old_tb1_4(4):=null;
RQPMT_100209_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(4),-1)));
RQPMT_100209_.tb1_6(4):=RQPMT_100209_.tb4_0(2);
RQPMT_100209_.tb1_9(4):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(4),
ENTITY_ID=RQPMT_100209_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb1_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(4),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(4),
RQPMT_100209_.tb1_1(4),
RQPMT_100209_.tb1_2(4),
RQPMT_100209_.tb1_3(4),
RQPMT_100209_.tb1_4(4),
null,
RQPMT_100209_.tb1_6(4),
null,
null,
RQPMT_100209_.tb1_9(4),
2,
'Producto'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(3):=121048643;
RQPMT_100209_.tb4_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(3):=RQPMT_100209_.tb4_0(3);
RQPMT_100209_.old_tb4_1(3):='MO_INITATRIB_CT23E121048643'
;
RQPMT_100209_.tb4_1(3):=RQPMT_100209_.tb4_0(3);
RQPMT_100209_.tb4_2(3):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(3),
RQPMT_100209_.tb4_1(3),
RQPMT_100209_.tb4_2(3),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_TYPE_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_TYPE_ID",nuProductTypeId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductTypeId);,)'
,
'LBTEST'
,
to_date('13-06-2012 16:15:19','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - PRODUCT_TYPE_ID - Inicializaci¿n del tipo de producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(5):=103233;
RQPMT_100209_.old_tb1_1(5):=8;
RQPMT_100209_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(5),-1)));
RQPMT_100209_.old_tb1_2(5):=192;
RQPMT_100209_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(5),-1)));
RQPMT_100209_.old_tb1_3(5):=null;
RQPMT_100209_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(5),-1)));
RQPMT_100209_.old_tb1_4(5):=null;
RQPMT_100209_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(5),-1)));
RQPMT_100209_.tb1_6(5):=RQPMT_100209_.tb4_0(3);
RQPMT_100209_.tb1_9(5):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(5),
ENTITY_ID=RQPMT_100209_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb1_6(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(5),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Tipo de producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(5),
RQPMT_100209_.tb1_1(5),
RQPMT_100209_.tb1_2(5),
RQPMT_100209_.tb1_3(5),
RQPMT_100209_.tb1_4(5),
null,
RQPMT_100209_.tb1_6(5),
null,
null,
RQPMT_100209_.tb1_9(5),
3,
'Tipo de producto'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(4):=121048644;
RQPMT_100209_.tb4_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(4):=RQPMT_100209_.tb4_0(4);
RQPMT_100209_.old_tb4_1(4):='MO_INITATRIB_CT23E121048644'
;
RQPMT_100209_.tb4_1(4):=RQPMT_100209_.tb4_0(4);
RQPMT_100209_.tb4_2(4):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(4),
RQPMT_100209_.tb4_1(4),
RQPMT_100209_.tb4_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,"SUSCRIPC","SUSCCODI",sbContrato);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbContrato);,)'
,
'LBTEST'
,
to_date('28-06-2012 09:11:15','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - SUBSCRIPTION_ID - Inicializaci¿n del contrato WI'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(6):=103235;
RQPMT_100209_.old_tb1_1(6):=8;
RQPMT_100209_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(6),-1)));
RQPMT_100209_.old_tb1_2(6):=11403;
RQPMT_100209_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(6),-1)));
RQPMT_100209_.old_tb1_3(6):=null;
RQPMT_100209_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(6),-1)));
RQPMT_100209_.old_tb1_4(6):=null;
RQPMT_100209_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(6),-1)));
RQPMT_100209_.tb1_6(6):=RQPMT_100209_.tb4_0(4);
RQPMT_100209_.tb1_9(6):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(6),
ENTITY_ID=RQPMT_100209_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb1_6(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(6),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Contrato'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(6),
RQPMT_100209_.tb1_1(6),
RQPMT_100209_.tb1_2(6),
RQPMT_100209_.tb1_3(6),
RQPMT_100209_.tb1_4(6),
null,
RQPMT_100209_.tb1_6(6),
null,
null,
RQPMT_100209_.tb1_9(6),
4,
'Contrato'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb5_0(0):=120023598;
RQPMT_100209_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100209_.tb5_0(0):=RQPMT_100209_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100209_.tb5_0(0),
16,
'Sentencia Causales Susp Vol'
,
'SELECT u.causal_id      ID
      ,u.description    DESCRIPTION
FROM ps_package_type        p
    ,ps_package_causaltyp   c
    ,cc_causal              u
WHERE p.tag_name        = '|| chr(39) ||'P_SUSPENSION_VOLUNTARIA_100209'|| chr(39) ||'
AND   p.package_type_id = c.package_type_id
AND   c.causal_type_id  = u.causal_type_id
ORDER BY u.description'
,
'Sentencia Causales Susp Vol'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(7):=103236;
RQPMT_100209_.old_tb1_1(7):=8;
RQPMT_100209_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(7),-1)));
RQPMT_100209_.old_tb1_2(7):=144514;
RQPMT_100209_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(7),-1)));
RQPMT_100209_.old_tb1_3(7):=null;
RQPMT_100209_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(7),-1)));
RQPMT_100209_.old_tb1_4(7):=null;
RQPMT_100209_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(7),-1)));
RQPMT_100209_.tb1_5(7):=RQPMT_100209_.tb5_0(0);
RQPMT_100209_.tb1_9(7):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(7),
ENTITY_ID=RQPMT_100209_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(7),
STATEMENT_ID=RQPMT_100209_.tb1_5(7),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(7),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Causal'
,
DISPLAY_ORDER=5,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(7),
RQPMT_100209_.tb1_1(7),
RQPMT_100209_.tb1_2(7),
RQPMT_100209_.tb1_3(7),
RQPMT_100209_.tb1_4(7),
RQPMT_100209_.tb1_5(7),
null,
null,
null,
RQPMT_100209_.tb1_9(7),
5,
'Causal'
,
5,
'Y'
,
'N'
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
'Y'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb5_0(1):=120023599;
RQPMT_100209_.tb5_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100209_.tb5_0(1):=RQPMT_100209_.tb5_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100209_.tb5_0(1),
16,
'Sentencia respuesta de atenci¿n'
,
'SELECT b.answer_id ID, b.description DESCRIPTION
FROM cc_answer b
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'b.request_type_id = 100209 '||chr(64)||'
'||chr(64)||'b.is_immediate_attent = '|| chr(39) ||'Y'|| chr(39) ||' '||chr(64)||'
'||chr(64)||'b.answer_id = :ID '||chr(64)||'
'||chr(64)||'b.description like :DESCRIPTION '||chr(64)||''
,
'Sentencia respuesta de atenci¿n'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(8):=103237;
RQPMT_100209_.old_tb1_1(8):=8;
RQPMT_100209_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(8),-1)));
RQPMT_100209_.old_tb1_2(8):=144591;
RQPMT_100209_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(8),-1)));
RQPMT_100209_.old_tb1_3(8):=null;
RQPMT_100209_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(8),-1)));
RQPMT_100209_.old_tb1_4(8):=null;
RQPMT_100209_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(8),-1)));
RQPMT_100209_.tb1_5(8):=RQPMT_100209_.tb5_0(1);
RQPMT_100209_.tb1_9(8):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(8),
ENTITY_ID=RQPMT_100209_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(8),
STATEMENT_ID=RQPMT_100209_.tb1_5(8),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(8),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Respuesta De Atención'
,
DISPLAY_ORDER=6,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(8),
RQPMT_100209_.tb1_1(8),
RQPMT_100209_.tb1_2(8),
RQPMT_100209_.tb1_3(8),
RQPMT_100209_.tb1_4(8),
RQPMT_100209_.tb1_5(8),
null,
null,
null,
RQPMT_100209_.tb1_9(8),
6,
'Respuesta De Atención'
,
6,
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(9):=103238;
RQPMT_100209_.old_tb1_1(9):=24;
RQPMT_100209_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(9),-1)));
RQPMT_100209_.old_tb1_2(9):=309;
RQPMT_100209_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(9),-1)));
RQPMT_100209_.old_tb1_3(9):=187;
RQPMT_100209_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(9),-1)));
RQPMT_100209_.old_tb1_4(9):=null;
RQPMT_100209_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(9),-1)));
RQPMT_100209_.tb1_9(9):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(9),
ENTITY_ID=RQPMT_100209_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(9),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Consecutivo Interno Motivos'
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
ENTITY_NAME='MO_SUSPENSION'
,
ATTRI_TECHNICAL_NAME='MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(9),
RQPMT_100209_.tb1_1(9),
RQPMT_100209_.tb1_2(9),
RQPMT_100209_.tb1_3(9),
RQPMT_100209_.tb1_4(9),
null,
null,
null,
null,
RQPMT_100209_.tb1_9(9),
7,
'Consecutivo Interno Motivos'
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
'MO_SUSPENSION'
,
'MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb1_0(10):=103239;
RQPMT_100209_.old_tb1_1(10):=24;
RQPMT_100209_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb1_1(10),-1)));
RQPMT_100209_.old_tb1_2(10):=311;
RQPMT_100209_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_2(10),-1)));
RQPMT_100209_.old_tb1_3(10):=1863;
RQPMT_100209_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_3(10),-1)));
RQPMT_100209_.old_tb1_4(10):=null;
RQPMT_100209_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb1_4(10),-1)));
RQPMT_100209_.tb1_9(10):=RQPMT_100209_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100209_.tb1_0(10),
ENTITY_ID=RQPMT_100209_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb1_9(10),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Tipo de Suspensi¿n'
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
TAG_NAME='SUSPENSION_TYPE_ID'
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
ENTITY_NAME='MO_SUSPENSION'
,
ATTRI_TECHNICAL_NAME='SUSPENSION_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100209_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb1_0(10),
RQPMT_100209_.tb1_1(10),
RQPMT_100209_.tb1_2(10),
RQPMT_100209_.tb1_3(10),
RQPMT_100209_.tb1_4(10),
null,
null,
null,
null,
RQPMT_100209_.tb1_9(10),
8,
'Tipo de Suspensi¿n'
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
'SUSPENSION_TYPE_ID'
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
'MO_SUSPENSION'
,
'SUSPENSION_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb6_0(0):=104;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQPMT_100209_.tb6_0(0),
'Utilities'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb7_0(0):=7038;
RQPMT_100209_.tb7_1(0):=RQPMT_100209_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (0)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=RQPMT_100209_.tb7_0(0),
SERVICE_TYPE_ID=RQPMT_100209_.tb7_1(0),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Gas'
,
ACCEPT_IF_PROJECTED='N'
,
ASSIGNABLE='Y'
,
TAG_NAME='CP_GAS_7038'
,
ELEMENT_DAYS_WAIT=null,
IS_AUTOMATIC_ASSIGN='Y'
,
SUSPEND_ALLOWED='Y'
,
IS_DEPENDENT='N'
,
VALIDATE_RETIRE='Y'
,
IS_MEASURABLE='N'
,
IS_MOVEABLE='N'
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

 WHERE COMPONENT_TYPE_ID = RQPMT_100209_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (RQPMT_100209_.tb7_0(0),
RQPMT_100209_.tb7_1(0),
null,
'Gas'
,
'N'
,
'Y'
,
'CP_GAS_7038'
,
null,
'Y'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb8_0(0):=10307;
RQPMT_100209_.tb8_1(0):=RQPMT_100209_.tb0_0(0);
RQPMT_100209_.tb8_4(0):=RQPMT_100209_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTIVE_COMP fila (0)',1);
UPDATE PS_PROD_MOTIVE_COMP SET PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb8_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb8_1(0),
PARENT_COMP=null,
SERVICE_COMPONENT=10213,
COMPONENT_TYPE_ID=RQPMT_100209_.tb8_4(0),
MOTIVE_TYPE_ID=7,
TAG_NAME='C_GAS_10307'
,
ASSIGN_ORDER=3,
MIN_COMPONENTS=1,
MAX_COMPONENTS=1,
IS_OPTIONAL='N'
,
DESCRIPTION='Gas'
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

 WHERE PROD_MOTIVE_COMP_ID = RQPMT_100209_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTIVE_COMP(PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,SERVICE_COMPONENT,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN) 
VALUES (RQPMT_100209_.tb8_0(0),
RQPMT_100209_.tb8_1(0),
null,
10213,
RQPMT_100209_.tb8_4(0),
7,
'C_GAS_10307'
,
3,
1,
1,
'N'
,
'Gas'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb7_0(1):=7039;
RQPMT_100209_.tb7_1(1):=RQPMT_100209_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (1)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=RQPMT_100209_.tb7_0(1),
SERVICE_TYPE_ID=RQPMT_100209_.tb7_1(1),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Medici¿n'
,
ACCEPT_IF_PROJECTED='N'
,
ASSIGNABLE='Y'
,
TAG_NAME='CP_MEDICION_7039'
,
ELEMENT_DAYS_WAIT=null,
IS_AUTOMATIC_ASSIGN='Y'
,
SUSPEND_ALLOWED='Y'
,
IS_DEPENDENT='N'
,
VALIDATE_RETIRE='Y'
,
IS_MEASURABLE='N'
,
IS_MOVEABLE='N'
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

 WHERE COMPONENT_TYPE_ID = RQPMT_100209_.tb7_0(1);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (RQPMT_100209_.tb7_0(1),
RQPMT_100209_.tb7_1(1),
null,
'Medici¿n'
,
'N'
,
'Y'
,
'CP_MEDICION_7039'
,
null,
'Y'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb8_0(1):=10308;
RQPMT_100209_.tb8_1(1):=RQPMT_100209_.tb0_0(0);
RQPMT_100209_.tb8_2(1):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb8_4(1):=RQPMT_100209_.tb7_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTIVE_COMP fila (1)',1);
UPDATE PS_PROD_MOTIVE_COMP SET PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb8_0(1),
PRODUCT_MOTIVE_ID=RQPMT_100209_.tb8_1(1),
PARENT_COMP=RQPMT_100209_.tb8_2(1),
SERVICE_COMPONENT=10214,
COMPONENT_TYPE_ID=RQPMT_100209_.tb8_4(1),
MOTIVE_TYPE_ID=7,
TAG_NAME='C_MEDICION_10308'
,
ASSIGN_ORDER=4,
MIN_COMPONENTS=1,
MAX_COMPONENTS=1,
IS_OPTIONAL='Y'
,
DESCRIPTION='Medici¿n'
,
PROCESS_SEQUENCE=4,
CONTAIN_MAIN_NUMBER='N'
,
LOAD_COMPONENT_INFO='N'
,
COPY_NETWORK_ASSO='N'
,
ELEMENT_CATEGORY_ID=null,
ATTEND_WITH_PARENT='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PROD_MOTIVE_COMP_ID = RQPMT_100209_.tb8_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTIVE_COMP(PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,SERVICE_COMPONENT,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN) 
VALUES (RQPMT_100209_.tb8_0(1),
RQPMT_100209_.tb8_1(1),
RQPMT_100209_.tb8_2(1),
10214,
RQPMT_100209_.tb8_4(1),
7,
'C_MEDICION_10308'
,
4,
1,
1,
'Y'
,
'Medici¿n'
,
4,
'N'
,
'N'
,
'N'
,
null,
'N'
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
null,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(5):=121048645;
RQPMT_100209_.tb4_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(5):=RQPMT_100209_.tb4_0(5);
RQPMT_100209_.old_tb4_1(5):='MO_INITATRIB_CT23E121048645'
;
RQPMT_100209_.tb4_1(5):=RQPMT_100209_.tb4_0(5);
RQPMT_100209_.tb4_2(5):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(5),
RQPMT_100209_.tb4_1(5),
RQPMT_100209_.tb4_2(5),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",sbProductId);nuComponentTypeIdMED = 7039;nuProductId = UT_CONVERT.FNUCHARTONUMBER(sbProductId);nuComponentId = PR_BOCNFCOMPONENT.FNUGETCOMPONENTIDBYPRODUCT(nuProductId, nuComponentTypeIdMED);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuComponentId);,)'
,
'LBTEST'
,
to_date('13-06-2012 21:35:39','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - COMPONENT_ID_PROD - Inicializaci¿n del id del componente del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(0):=105030;
RQPMT_100209_.old_tb9_1(0):=43;
RQPMT_100209_.tb9_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(0),-1)));
RQPMT_100209_.old_tb9_2(0):=8064;
RQPMT_100209_.tb9_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(0),-1)));
RQPMT_100209_.old_tb9_3(0):=null;
RQPMT_100209_.tb9_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(0),-1)));
RQPMT_100209_.old_tb9_4(0):=null;
RQPMT_100209_.tb9_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(0),-1)));
RQPMT_100209_.tb9_5(0):=RQPMT_100209_.tb8_0(1);
RQPMT_100209_.tb9_8(0):=RQPMT_100209_.tb4_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (0)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(0),
ENTITY_ID=RQPMT_100209_.tb9_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(0),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(0),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(0),
STATEMENT_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Id Del Componente Del Producto'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(0);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(0),
RQPMT_100209_.tb9_1(0),
RQPMT_100209_.tb9_2(0),
RQPMT_100209_.tb9_3(0),
RQPMT_100209_.tb9_4(0),
RQPMT_100209_.tb9_5(0),
null,
null,
RQPMT_100209_.tb9_8(0),
null,
8,
'Id Del Componente Del Producto'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(1):=105052;
RQPMT_100209_.old_tb9_1(1):=33;
RQPMT_100209_.tb9_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(1),-1)));
RQPMT_100209_.old_tb9_2(1):=8082;
RQPMT_100209_.tb9_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(1),-1)));
RQPMT_100209_.old_tb9_3(1):=338;
RQPMT_100209_.tb9_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(1),-1)));
RQPMT_100209_.old_tb9_4(1):=null;
RQPMT_100209_.tb9_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(1),-1)));
RQPMT_100209_.tb9_5(1):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (1)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(1),
ENTITY_ID=RQPMT_100209_.tb9_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(1),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(1),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Id Del Componente'
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
TAG_NAME='COMPONENT_ID'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='COMPONENT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(1);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(1),
RQPMT_100209_.tb9_1(1),
RQPMT_100209_.tb9_2(1),
RQPMT_100209_.tb9_3(1),
RQPMT_100209_.tb9_4(1),
RQPMT_100209_.tb9_5(1),
null,
null,
null,
null,
9,
'Id Del Componente'
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
'COMPONENT_ID'
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
'MO_SUSPENSION_COMP'
,
'COMPONENT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(2):=105053;
RQPMT_100209_.old_tb9_1(2):=33;
RQPMT_100209_.tb9_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(2),-1)));
RQPMT_100209_.old_tb9_2(2):=8083;
RQPMT_100209_.tb9_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(2),-1)));
RQPMT_100209_.old_tb9_3(2):=311;
RQPMT_100209_.tb9_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(2),-1)));
RQPMT_100209_.old_tb9_4(2):=null;
RQPMT_100209_.tb9_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(2),-1)));
RQPMT_100209_.tb9_5(2):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (2)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(2),
ENTITY_ID=RQPMT_100209_.tb9_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(2),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(2),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Id Del Tipo De Suspensi¿n'
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
TAG_NAME='SUSPENSION_TYPE_ID'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='SUSPENSION_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(2);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(2),
RQPMT_100209_.tb9_1(2),
RQPMT_100209_.tb9_2(2),
RQPMT_100209_.tb9_3(2),
RQPMT_100209_.tb9_4(2),
RQPMT_100209_.tb9_5(2),
null,
null,
null,
null,
10,
'Id Del Tipo De Suspensi¿n'
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
'SUSPENSION_TYPE_ID'
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
'MO_SUSPENSION_COMP'
,
'SUSPENSION_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(3):=105054;
RQPMT_100209_.old_tb9_1(3):=33;
RQPMT_100209_.tb9_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(3),-1)));
RQPMT_100209_.old_tb9_2(3):=8084;
RQPMT_100209_.tb9_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(3),-1)));
RQPMT_100209_.old_tb9_3(3):=258;
RQPMT_100209_.tb9_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(3),-1)));
RQPMT_100209_.old_tb9_4(3):=null;
RQPMT_100209_.tb9_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(3),-1)));
RQPMT_100209_.tb9_5(3):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (3)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(3),
ENTITY_ID=RQPMT_100209_.tb9_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(3),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(3),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Fecha De Registro De La Suspensi¿n'
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
TAG_NAME='REGISTER_DATE'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='REGISTER_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(3);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(3),
RQPMT_100209_.tb9_1(3),
RQPMT_100209_.tb9_2(3),
RQPMT_100209_.tb9_3(3),
RQPMT_100209_.tb9_4(3),
RQPMT_100209_.tb9_5(3),
null,
null,
null,
null,
11,
'Fecha De Registro De La Suspensi¿n'
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
'REGISTER_DATE'
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
'MO_SUSPENSION_COMP'
,
'REGISTER_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(6):=121048646;
RQPMT_100209_.tb4_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(6):=RQPMT_100209_.tb4_0(6);
RQPMT_100209_.old_tb4_1(6):='MO_INITATRIB_CT23E121048646'
;
RQPMT_100209_.tb4_1(6):=RQPMT_100209_.tb4_0(6);
RQPMT_100209_.tb4_2(6):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(6),
RQPMT_100209_.tb4_1(6),
RQPMT_100209_.tb4_2(6),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FDTSYSDATE())'
,
'LBTEST'
,
to_date('15-06-2012 10:27:25','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_SUSPENSION_COMP - APLICATION_DATE - Inicializaci¿n con fecha del sistema'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(4):=105056;
RQPMT_100209_.old_tb9_1(4):=33;
RQPMT_100209_.tb9_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(4),-1)));
RQPMT_100209_.old_tb9_2(4):=8085;
RQPMT_100209_.tb9_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(4),-1)));
RQPMT_100209_.old_tb9_3(4):=null;
RQPMT_100209_.tb9_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(4),-1)));
RQPMT_100209_.old_tb9_4(4):=null;
RQPMT_100209_.tb9_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(4),-1)));
RQPMT_100209_.tb9_5(4):=RQPMT_100209_.tb8_0(1);
RQPMT_100209_.tb9_8(4):=RQPMT_100209_.tb4_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (4)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(4),
ENTITY_ID=RQPMT_100209_.tb9_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(4),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(4),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(4),
STATEMENT_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
TAG_NAME='APLICATION_DATE'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='APLICATION_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(4);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(4),
RQPMT_100209_.tb9_1(4),
RQPMT_100209_.tb9_2(4),
RQPMT_100209_.tb9_3(4),
RQPMT_100209_.tb9_4(4),
RQPMT_100209_.tb9_5(4),
null,
null,
RQPMT_100209_.tb9_8(4),
null,
12,
'Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
'APLICATION_DATE'
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
'MO_SUSPENSION_COMP'
,
'APLICATION_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(7):=121048647;
RQPMT_100209_.tb4_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(7):=RQPMT_100209_.tb4_0(7);
RQPMT_100209_.old_tb4_1(7):='MO_INITATRIB_CT23E121048647'
;
RQPMT_100209_.tb4_1(7):=RQPMT_100209_.tb4_0(7);
RQPMT_100209_.tb4_2(7):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(7),
RQPMT_100209_.tb4_1(7),
RQPMT_100209_.tb4_2(7),
'componentId = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_COMPONENT", "SEQ_MO_COMPONENT");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(componentId)'
,
'LBTEST'
,
to_date('13-06-2012 21:35:38','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - COMPONENT_ID - Inicializaci¿n de la secuencia de mo_component'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(5):=105022;
RQPMT_100209_.old_tb9_1(5):=43;
RQPMT_100209_.tb9_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(5),-1)));
RQPMT_100209_.old_tb9_2(5):=338;
RQPMT_100209_.tb9_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(5),-1)));
RQPMT_100209_.old_tb9_3(5):=null;
RQPMT_100209_.tb9_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(5),-1)));
RQPMT_100209_.old_tb9_4(5):=null;
RQPMT_100209_.tb9_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(5),-1)));
RQPMT_100209_.tb9_5(5):=RQPMT_100209_.tb8_0(1);
RQPMT_100209_.tb9_8(5):=RQPMT_100209_.tb4_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (5)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(5),
ENTITY_ID=RQPMT_100209_.tb9_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(5),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(5),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(5),
STATEMENT_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='C¿digo de Componente'
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
TAG_NAME='C_DIGO_DE_COMPONENTE'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(5);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(5),
RQPMT_100209_.tb9_1(5),
RQPMT_100209_.tb9_2(5),
RQPMT_100209_.tb9_3(5),
RQPMT_100209_.tb9_4(5),
RQPMT_100209_.tb9_5(5),
null,
null,
RQPMT_100209_.tb9_8(5),
null,
0,
'C¿digo de Componente'
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
'C_DIGO_DE_COMPONENTE'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(6):=105023;
RQPMT_100209_.old_tb9_1(6):=43;
RQPMT_100209_.tb9_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(6),-1)));
RQPMT_100209_.old_tb9_2(6):=456;
RQPMT_100209_.tb9_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(6),-1)));
RQPMT_100209_.old_tb9_3(6):=187;
RQPMT_100209_.tb9_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(6),-1)));
RQPMT_100209_.old_tb9_4(6):=null;
RQPMT_100209_.tb9_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(6),-1)));
RQPMT_100209_.tb9_5(6):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (6)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(6),
ENTITY_ID=RQPMT_100209_.tb9_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(6),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(6),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='C¿digo del Motivo'
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
TAG_NAME='C_DIGO_DEL_MOTIVO'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(6);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(6),
RQPMT_100209_.tb9_1(6),
RQPMT_100209_.tb9_2(6),
RQPMT_100209_.tb9_3(6),
RQPMT_100209_.tb9_4(6),
RQPMT_100209_.tb9_5(6),
null,
null,
null,
null,
1,
'C¿digo del Motivo'
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
'C_DIGO_DEL_MOTIVO'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(7):=105024;
RQPMT_100209_.old_tb9_1(7):=43;
RQPMT_100209_.tb9_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(7),-1)));
RQPMT_100209_.old_tb9_2(7):=362;
RQPMT_100209_.tb9_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(7),-1)));
RQPMT_100209_.old_tb9_3(7):=191;
RQPMT_100209_.tb9_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(7),-1)));
RQPMT_100209_.old_tb9_4(7):=null;
RQPMT_100209_.tb9_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(7),-1)));
RQPMT_100209_.tb9_5(7):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (7)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(7),
ENTITY_ID=RQPMT_100209_.tb9_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(7),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(7),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Tipo Motivo'
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
TAG_NAME='TIPO_MOTIVO'
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
ATTRI_TECHNICAL_NAME='MOTIVE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(7);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(7),
RQPMT_100209_.tb9_1(7),
RQPMT_100209_.tb9_2(7),
RQPMT_100209_.tb9_3(7),
RQPMT_100209_.tb9_4(7),
RQPMT_100209_.tb9_5(7),
null,
null,
null,
null,
2,
'Tipo Motivo'
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
'TIPO_MOTIVO'
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
'MOTIVE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(8):=105025;
RQPMT_100209_.old_tb9_1(8):=43;
RQPMT_100209_.tb9_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(8),-1)));
RQPMT_100209_.old_tb9_2(8):=696;
RQPMT_100209_.tb9_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(8),-1)));
RQPMT_100209_.old_tb9_3(8):=697;
RQPMT_100209_.tb9_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(8),-1)));
RQPMT_100209_.old_tb9_4(8):=null;
RQPMT_100209_.tb9_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(8),-1)));
RQPMT_100209_.tb9_5(8):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (8)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(8),
ENTITY_ID=RQPMT_100209_.tb9_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(8),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(8),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='C¿digo del Producto Motivo'
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
TAG_NAME='C_DIGO_DEL_PRODUCTO_MOTIVO'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(8);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(8),
RQPMT_100209_.tb9_1(8),
RQPMT_100209_.tb9_2(8),
RQPMT_100209_.tb9_3(8),
RQPMT_100209_.tb9_4(8),
RQPMT_100209_.tb9_5(8),
null,
null,
null,
null,
3,
'C¿digo del Producto Motivo'
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
'C_DIGO_DEL_PRODUCTO_MOTIVO'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(9):=105026;
RQPMT_100209_.old_tb9_1(9):=43;
RQPMT_100209_.tb9_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(9),-1)));
RQPMT_100209_.old_tb9_2(9):=50000937;
RQPMT_100209_.tb9_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(9),-1)));
RQPMT_100209_.old_tb9_3(9):=255;
RQPMT_100209_.tb9_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(9),-1)));
RQPMT_100209_.old_tb9_4(9):=null;
RQPMT_100209_.tb9_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(9),-1)));
RQPMT_100209_.tb9_5(9):=RQPMT_100209_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (9)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(9),
ENTITY_ID=RQPMT_100209_.tb9_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(9),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(9),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Identificador del Paquete'
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
TAG_NAME='IDENTIFICADOR_DEL_PAQUETE'
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
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(9);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(9),
RQPMT_100209_.tb9_1(9),
RQPMT_100209_.tb9_2(9),
RQPMT_100209_.tb9_3(9),
RQPMT_100209_.tb9_4(9),
RQPMT_100209_.tb9_5(9),
null,
null,
null,
null,
4,
'Identificador del Paquete'
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
'IDENTIFICADOR_DEL_PAQUETE'
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
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(8):=121048648;
RQPMT_100209_.tb4_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(8):=RQPMT_100209_.tb4_0(8);
RQPMT_100209_.old_tb4_1(8):='MO_INITATRIB_CT23E121048648'
;
RQPMT_100209_.tb4_1(8):=RQPMT_100209_.tb4_0(8);
RQPMT_100209_.tb4_2(8):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(8),
RQPMT_100209_.tb4_1(8),
RQPMT_100209_.tb4_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductId);,)'
,
'LBTEST'
,
to_date('13-06-2012 21:35:38','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI  - COMP - MO_COMPONENT - PRODUCT_ID - Inicializaci¿n del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(10):=105027;
RQPMT_100209_.old_tb9_1(10):=43;
RQPMT_100209_.tb9_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(10),-1)));
RQPMT_100209_.old_tb9_2(10):=50000936;
RQPMT_100209_.tb9_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(10),-1)));
RQPMT_100209_.old_tb9_3(10):=null;
RQPMT_100209_.tb9_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(10),-1)));
RQPMT_100209_.old_tb9_4(10):=null;
RQPMT_100209_.tb9_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(10),-1)));
RQPMT_100209_.tb9_5(10):=RQPMT_100209_.tb8_0(1);
RQPMT_100209_.tb9_8(10):=RQPMT_100209_.tb4_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (10)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(10),
ENTITY_ID=RQPMT_100209_.tb9_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(10),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(10),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(10),
STATEMENT_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Identificador del Producto'
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
TAG_NAME='IDENTIFICADOR_DEL_PRODUCTO'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(10);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(10),
RQPMT_100209_.tb9_1(10),
RQPMT_100209_.tb9_2(10),
RQPMT_100209_.tb9_3(10),
RQPMT_100209_.tb9_4(10),
RQPMT_100209_.tb9_5(10),
null,
null,
RQPMT_100209_.tb9_8(10),
null,
5,
'Identificador del Producto'
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
'IDENTIFICADOR_DEL_PRODUCTO'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(9):=121048649;
RQPMT_100209_.tb4_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(9):=RQPMT_100209_.tb4_0(9);
RQPMT_100209_.old_tb4_1(9):='MO_INITATRIB_CT23E121048649'
;
RQPMT_100209_.tb4_1(9):=RQPMT_100209_.tb4_0(9);
RQPMT_100209_.tb4_2(9):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(9),
RQPMT_100209_.tb4_1(9),
RQPMT_100209_.tb4_2(9),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "SERVICE_NUMBER", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","SERVICE_NUMBER",nuServiceNumber);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuServiceNumber);,)'
,
'LBTEST'
,
to_date('13-06-2012 21:35:38','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - SERVICE_NUMBER - Inicializaci¿n del n¿mero de servicio del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(11):=105028;
RQPMT_100209_.old_tb9_1(11):=43;
RQPMT_100209_.tb9_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(11),-1)));
RQPMT_100209_.old_tb9_2(11):=4013;
RQPMT_100209_.tb9_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(11),-1)));
RQPMT_100209_.old_tb9_3(11):=null;
RQPMT_100209_.tb9_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(11),-1)));
RQPMT_100209_.old_tb9_4(11):=null;
RQPMT_100209_.tb9_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(11),-1)));
RQPMT_100209_.tb9_5(11):=RQPMT_100209_.tb8_0(1);
RQPMT_100209_.tb9_8(11):=RQPMT_100209_.tb4_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (11)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(11),
ENTITY_ID=RQPMT_100209_.tb9_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(11),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(11),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(11),
STATEMENT_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='N¿mero Servicio'
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
TAG_NAME='N_MERO_SERVICIO'
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
ATTRI_TECHNICAL_NAME='SERVICE_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(11);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(11),
RQPMT_100209_.tb9_1(11),
RQPMT_100209_.tb9_2(11),
RQPMT_100209_.tb9_3(11),
RQPMT_100209_.tb9_4(11),
RQPMT_100209_.tb9_5(11),
null,
null,
RQPMT_100209_.tb9_8(11),
null,
6,
'N¿mero Servicio'
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
'N_MERO_SERVICIO'
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
'SERVICE_NUMBER'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(10):=121048650;
RQPMT_100209_.tb4_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(10):=RQPMT_100209_.tb4_0(10);
RQPMT_100209_.old_tb4_1(10):='MO_INITATRIB_CT23E121048650'
;
RQPMT_100209_.tb4_1(10):=RQPMT_100209_.tb4_0(10);
RQPMT_100209_.tb4_2(10):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(10),
RQPMT_100209_.tb4_1(10),
RQPMT_100209_.tb4_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "ADDRESS_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","ADDRESS_ID",nuAddressId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuAddressId);,)'
,
'LBTEST'
,
to_date('13-06-2012 21:35:38','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - ADDRESS_ID - Inicializaci¿n de la direcci¿n del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(12):=105029;
RQPMT_100209_.old_tb9_1(12):=43;
RQPMT_100209_.tb9_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(12),-1)));
RQPMT_100209_.old_tb9_2(12):=89620;
RQPMT_100209_.tb9_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(12),-1)));
RQPMT_100209_.old_tb9_3(12):=null;
RQPMT_100209_.tb9_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(12),-1)));
RQPMT_100209_.old_tb9_4(12):=null;
RQPMT_100209_.tb9_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(12),-1)));
RQPMT_100209_.tb9_5(12):=RQPMT_100209_.tb8_0(1);
RQPMT_100209_.tb9_8(12):=RQPMT_100209_.tb4_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (12)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(12),
ENTITY_ID=RQPMT_100209_.tb9_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(12),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(12),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(12),
STATEMENT_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Direcci¿n De Instalaci¿n'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(12);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(12),
RQPMT_100209_.tb9_1(12),
RQPMT_100209_.tb9_2(12),
RQPMT_100209_.tb9_3(12),
RQPMT_100209_.tb9_4(12),
RQPMT_100209_.tb9_5(12),
null,
null,
RQPMT_100209_.tb9_8(12),
null,
7,
'Direcci¿n De Instalaci¿n'
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
'MO_COMPONENT'
,
'ADDRESS_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(13):=105051;
RQPMT_100209_.old_tb9_1(13):=33;
RQPMT_100209_.tb9_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(13),-1)));
RQPMT_100209_.old_tb9_2(13):=8084;
RQPMT_100209_.tb9_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(13),-1)));
RQPMT_100209_.old_tb9_3(13):=258;
RQPMT_100209_.tb9_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(13),-1)));
RQPMT_100209_.old_tb9_4(13):=null;
RQPMT_100209_.tb9_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(13),-1)));
RQPMT_100209_.tb9_5(13):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (13)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(13),
ENTITY_ID=RQPMT_100209_.tb9_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(13),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(13),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Fecha De Registro De La Suspensi¿n'
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
TAG_NAME='REGISTER_DATE'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='REGISTER_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(13);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(13),
RQPMT_100209_.tb9_1(13),
RQPMT_100209_.tb9_2(13),
RQPMT_100209_.tb9_3(13),
RQPMT_100209_.tb9_4(13),
RQPMT_100209_.tb9_5(13),
null,
null,
null,
null,
11,
'Fecha De Registro De La Suspensi¿n'
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
'REGISTER_DATE'
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
'MO_SUSPENSION_COMP'
,
'REGISTER_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(11):=121048651;
RQPMT_100209_.tb4_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(11):=RQPMT_100209_.tb4_0(11);
RQPMT_100209_.old_tb4_1(11):='MO_INITATRIB_CT23E121048651'
;
RQPMT_100209_.tb4_1(11):=RQPMT_100209_.tb4_0(11);
RQPMT_100209_.tb4_2(11):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(11),
RQPMT_100209_.tb4_1(11),
RQPMT_100209_.tb4_2(11),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FDTSYSDATE())'
,
'LBTEST'
,
to_date('15-06-2012 10:27:25','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_SUSPENSION_COMP - APLICATION_DATE - Inicializa con la fecha del sistema'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(14):=105055;
RQPMT_100209_.old_tb9_1(14):=33;
RQPMT_100209_.tb9_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(14),-1)));
RQPMT_100209_.old_tb9_2(14):=8085;
RQPMT_100209_.tb9_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(14),-1)));
RQPMT_100209_.old_tb9_3(14):=null;
RQPMT_100209_.tb9_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(14),-1)));
RQPMT_100209_.old_tb9_4(14):=null;
RQPMT_100209_.tb9_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(14),-1)));
RQPMT_100209_.tb9_5(14):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb9_8(14):=RQPMT_100209_.tb4_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (14)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(14),
ENTITY_ID=RQPMT_100209_.tb9_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(14),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(14),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(14),
STATEMENT_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
TAG_NAME='APLICATION_DATE'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='APLICATION_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(14);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(14),
RQPMT_100209_.tb9_1(14),
RQPMT_100209_.tb9_2(14),
RQPMT_100209_.tb9_3(14),
RQPMT_100209_.tb9_4(14),
RQPMT_100209_.tb9_5(14),
null,
null,
RQPMT_100209_.tb9_8(14),
null,
12,
'Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
'APLICATION_DATE'
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
'MO_SUSPENSION_COMP'
,
'APLICATION_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(12):=121048652;
RQPMT_100209_.tb4_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(12):=RQPMT_100209_.tb4_0(12);
RQPMT_100209_.old_tb4_1(12):='MO_INITATRIB_CT23E121048652'
;
RQPMT_100209_.tb4_1(12):=RQPMT_100209_.tb4_0(12);
RQPMT_100209_.tb4_2(12):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(12),
RQPMT_100209_.tb4_1(12),
RQPMT_100209_.tb4_2(12),
'componentId = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_COMPONENT", "SEQ_MO_COMPONENT");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(componentId)'
,
'LBTEST'
,
to_date('13-06-2012 18:08:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - COMPONENT_ID - Inicializaci¿n de la secuencia de mo_component'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(15):=105013;
RQPMT_100209_.old_tb9_1(15):=43;
RQPMT_100209_.tb9_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(15),-1)));
RQPMT_100209_.old_tb9_2(15):=338;
RQPMT_100209_.tb9_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(15),-1)));
RQPMT_100209_.old_tb9_3(15):=null;
RQPMT_100209_.tb9_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(15),-1)));
RQPMT_100209_.old_tb9_4(15):=null;
RQPMT_100209_.tb9_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(15),-1)));
RQPMT_100209_.tb9_5(15):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb9_8(15):=RQPMT_100209_.tb4_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (15)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(15),
ENTITY_ID=RQPMT_100209_.tb9_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(15),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(15),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(15),
STATEMENT_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='C¿digo de Componente'
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
TAG_NAME='C_DIGO_DE_COMPONENTE'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(15);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(15),
RQPMT_100209_.tb9_1(15),
RQPMT_100209_.tb9_2(15),
RQPMT_100209_.tb9_3(15),
RQPMT_100209_.tb9_4(15),
RQPMT_100209_.tb9_5(15),
null,
null,
RQPMT_100209_.tb9_8(15),
null,
0,
'C¿digo de Componente'
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
'C_DIGO_DE_COMPONENTE'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(16):=105014;
RQPMT_100209_.old_tb9_1(16):=43;
RQPMT_100209_.tb9_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(16),-1)));
RQPMT_100209_.old_tb9_2(16):=456;
RQPMT_100209_.tb9_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(16),-1)));
RQPMT_100209_.old_tb9_3(16):=187;
RQPMT_100209_.tb9_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(16),-1)));
RQPMT_100209_.old_tb9_4(16):=null;
RQPMT_100209_.tb9_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(16),-1)));
RQPMT_100209_.tb9_5(16):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (16)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(16),
ENTITY_ID=RQPMT_100209_.tb9_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(16),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(16),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='C¿digo del Motivo'
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
TAG_NAME='C_DIGO_DEL_MOTIVO'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(16);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(16),
RQPMT_100209_.tb9_1(16),
RQPMT_100209_.tb9_2(16),
RQPMT_100209_.tb9_3(16),
RQPMT_100209_.tb9_4(16),
RQPMT_100209_.tb9_5(16),
null,
null,
null,
null,
1,
'C¿digo del Motivo'
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
'C_DIGO_DEL_MOTIVO'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(17):=105015;
RQPMT_100209_.old_tb9_1(17):=43;
RQPMT_100209_.tb9_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(17),-1)));
RQPMT_100209_.old_tb9_2(17):=362;
RQPMT_100209_.tb9_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(17),-1)));
RQPMT_100209_.old_tb9_3(17):=191;
RQPMT_100209_.tb9_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(17),-1)));
RQPMT_100209_.old_tb9_4(17):=null;
RQPMT_100209_.tb9_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(17),-1)));
RQPMT_100209_.tb9_5(17):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (17)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(17),
ENTITY_ID=RQPMT_100209_.tb9_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(17),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(17),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Tipo Motivo'
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
TAG_NAME='TIPO_MOTIVO'
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
ATTRI_TECHNICAL_NAME='MOTIVE_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(17);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(17),
RQPMT_100209_.tb9_1(17),
RQPMT_100209_.tb9_2(17),
RQPMT_100209_.tb9_3(17),
RQPMT_100209_.tb9_4(17),
RQPMT_100209_.tb9_5(17),
null,
null,
null,
null,
2,
'Tipo Motivo'
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
'TIPO_MOTIVO'
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
'MOTIVE_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(18):=105016;
RQPMT_100209_.old_tb9_1(18):=43;
RQPMT_100209_.tb9_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(18),-1)));
RQPMT_100209_.old_tb9_2(18):=696;
RQPMT_100209_.tb9_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(18),-1)));
RQPMT_100209_.old_tb9_3(18):=697;
RQPMT_100209_.tb9_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(18),-1)));
RQPMT_100209_.old_tb9_4(18):=null;
RQPMT_100209_.tb9_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(18),-1)));
RQPMT_100209_.tb9_5(18):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (18)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(18),
ENTITY_ID=RQPMT_100209_.tb9_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(18),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(18),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='C¿digo del Producto Motivo'
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
TAG_NAME='C_DIGO_DEL_PRODUCTO_MOTIVO'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(18);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(18),
RQPMT_100209_.tb9_1(18),
RQPMT_100209_.tb9_2(18),
RQPMT_100209_.tb9_3(18),
RQPMT_100209_.tb9_4(18),
RQPMT_100209_.tb9_5(18),
null,
null,
null,
null,
3,
'C¿digo del Producto Motivo'
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
'C_DIGO_DEL_PRODUCTO_MOTIVO'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(19):=105017;
RQPMT_100209_.old_tb9_1(19):=43;
RQPMT_100209_.tb9_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(19),-1)));
RQPMT_100209_.old_tb9_2(19):=50000937;
RQPMT_100209_.tb9_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(19),-1)));
RQPMT_100209_.old_tb9_3(19):=255;
RQPMT_100209_.tb9_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(19),-1)));
RQPMT_100209_.old_tb9_4(19):=null;
RQPMT_100209_.tb9_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(19),-1)));
RQPMT_100209_.tb9_5(19):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (19)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(19),
ENTITY_ID=RQPMT_100209_.tb9_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(19),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(19),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Identificador del Paquete'
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
TAG_NAME='IDENTIFICADOR_DEL_PAQUETE'
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
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(19);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(19),
RQPMT_100209_.tb9_1(19),
RQPMT_100209_.tb9_2(19),
RQPMT_100209_.tb9_3(19),
RQPMT_100209_.tb9_4(19),
RQPMT_100209_.tb9_5(19),
null,
null,
null,
null,
4,
'Identificador del Paquete'
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
'IDENTIFICADOR_DEL_PAQUETE'
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
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(13):=121048653;
RQPMT_100209_.tb4_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(13):=RQPMT_100209_.tb4_0(13);
RQPMT_100209_.old_tb4_1(13):='MO_INITATRIB_CT23E121048653'
;
RQPMT_100209_.tb4_1(13):=RQPMT_100209_.tb4_0(13);
RQPMT_100209_.tb4_2(13):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(13),
RQPMT_100209_.tb4_1(13),
RQPMT_100209_.tb4_2(13),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductId);,)'
,
'LBTEST'
,
to_date('13-06-2012 18:08:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI  - COMP - MO_COMPONENT - PRODUCT_ID - Inicializaci¿n del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(20):=105018;
RQPMT_100209_.old_tb9_1(20):=43;
RQPMT_100209_.tb9_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(20),-1)));
RQPMT_100209_.old_tb9_2(20):=50000936;
RQPMT_100209_.tb9_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(20),-1)));
RQPMT_100209_.old_tb9_3(20):=null;
RQPMT_100209_.tb9_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(20),-1)));
RQPMT_100209_.old_tb9_4(20):=null;
RQPMT_100209_.tb9_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(20),-1)));
RQPMT_100209_.tb9_5(20):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb9_8(20):=RQPMT_100209_.tb4_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (20)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(20),
ENTITY_ID=RQPMT_100209_.tb9_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(20),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(20),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(20),
STATEMENT_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Identificador del Producto'
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
TAG_NAME='IDENTIFICADOR_DEL_PRODUCTO'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(20);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(20),
RQPMT_100209_.tb9_1(20),
RQPMT_100209_.tb9_2(20),
RQPMT_100209_.tb9_3(20),
RQPMT_100209_.tb9_4(20),
RQPMT_100209_.tb9_5(20),
null,
null,
RQPMT_100209_.tb9_8(20),
null,
5,
'Identificador del Producto'
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
'IDENTIFICADOR_DEL_PRODUCTO'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(14):=121048654;
RQPMT_100209_.tb4_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(14):=RQPMT_100209_.tb4_0(14);
RQPMT_100209_.old_tb4_1(14):='MO_INITATRIB_CT23E121048654'
;
RQPMT_100209_.tb4_1(14):=RQPMT_100209_.tb4_0(14);
RQPMT_100209_.tb4_2(14):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(14),
RQPMT_100209_.tb4_1(14),
RQPMT_100209_.tb4_2(14),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "SERVICE_NUMBER", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","SERVICE_NUMBER",nuServiceNumber);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuServiceNumber);,)'
,
'LBTEST'
,
to_date('13-06-2012 18:08:45','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - SERVICE_NUMBER - Inicializaci¿n del n¿mero de servicio del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(21):=105019;
RQPMT_100209_.old_tb9_1(21):=43;
RQPMT_100209_.tb9_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(21),-1)));
RQPMT_100209_.old_tb9_2(21):=4013;
RQPMT_100209_.tb9_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(21),-1)));
RQPMT_100209_.old_tb9_3(21):=null;
RQPMT_100209_.tb9_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(21),-1)));
RQPMT_100209_.old_tb9_4(21):=null;
RQPMT_100209_.tb9_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(21),-1)));
RQPMT_100209_.tb9_5(21):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb9_8(21):=RQPMT_100209_.tb4_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (21)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(21),
ENTITY_ID=RQPMT_100209_.tb9_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(21),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(21),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(21),
STATEMENT_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='N¿mero Servicio'
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
TAG_NAME='N_MERO_SERVICIO'
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
ATTRI_TECHNICAL_NAME='SERVICE_NUMBER'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(21);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(21),
RQPMT_100209_.tb9_1(21),
RQPMT_100209_.tb9_2(21),
RQPMT_100209_.tb9_3(21),
RQPMT_100209_.tb9_4(21),
RQPMT_100209_.tb9_5(21),
null,
null,
RQPMT_100209_.tb9_8(21),
null,
6,
'N¿mero Servicio'
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
'N_MERO_SERVICIO'
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
'SERVICE_NUMBER'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(15):=121048655;
RQPMT_100209_.tb4_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(15):=RQPMT_100209_.tb4_0(15);
RQPMT_100209_.old_tb4_1(15):='MO_INITATRIB_CT23E121048655'
;
RQPMT_100209_.tb4_1(15):=RQPMT_100209_.tb4_0(15);
RQPMT_100209_.tb4_2(15):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(15),
RQPMT_100209_.tb4_1(15),
RQPMT_100209_.tb4_2(15),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "ADDRESS_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","ADDRESS_ID",nuAddressId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuAddressId);,)'
,
'LBTEST'
,
to_date('13-06-2012 18:13:19','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - ADDRESS_ID - Inicializaci¿n de la direcci¿n del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(22):=105020;
RQPMT_100209_.old_tb9_1(22):=43;
RQPMT_100209_.tb9_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(22),-1)));
RQPMT_100209_.old_tb9_2(22):=89620;
RQPMT_100209_.tb9_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(22),-1)));
RQPMT_100209_.old_tb9_3(22):=null;
RQPMT_100209_.tb9_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(22),-1)));
RQPMT_100209_.old_tb9_4(22):=null;
RQPMT_100209_.tb9_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(22),-1)));
RQPMT_100209_.tb9_5(22):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb9_8(22):=RQPMT_100209_.tb4_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (22)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(22),
ENTITY_ID=RQPMT_100209_.tb9_1(22),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(22),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(22),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(22),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(22),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(22),
STATEMENT_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Direcci¿n De Instalaci¿n'
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
ENTITY_NAME='MO_COMPONENT'
,
ATTRI_TECHNICAL_NAME='ADDRESS_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(22);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(22),
RQPMT_100209_.tb9_1(22),
RQPMT_100209_.tb9_2(22),
RQPMT_100209_.tb9_3(22),
RQPMT_100209_.tb9_4(22),
RQPMT_100209_.tb9_5(22),
null,
null,
RQPMT_100209_.tb9_8(22),
null,
7,
'Direcci¿n De Instalaci¿n'
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
'MO_COMPONENT'
,
'ADDRESS_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.old_tb4_0(16):=121048656;
RQPMT_100209_.tb4_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100209_.tb4_0(16):=RQPMT_100209_.tb4_0(16);
RQPMT_100209_.old_tb4_1(16):='MO_INITATRIB_CT23E121048656'
;
RQPMT_100209_.tb4_1(16):=RQPMT_100209_.tb4_0(16);
RQPMT_100209_.tb4_2(16):=RQPMT_100209_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100209_.tb4_0(16),
RQPMT_100209_.tb4_1(16),
RQPMT_100209_.tb4_2(16),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",sbProductId);nuComponentTypeIdGAS = 7038;nuProductId = UT_CONVERT.FNUCHARTONUMBER(sbProductId);nuComponentId = PR_BOCNFCOMPONENT.FNUGETCOMPONENTIDBYPRODUCT(nuProductId, nuComponentTypeIdGAS);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuComponentId);,)'
,
'LBTEST'
,
to_date('13-06-2012 21:09:32','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
to_date('03-09-2013 14:02:34','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - COMP - MO_COMPONENT - COMPONENT_ID_PROD - Inicializaci¿n del id del componente del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(23):=105021;
RQPMT_100209_.old_tb9_1(23):=43;
RQPMT_100209_.tb9_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(23),-1)));
RQPMT_100209_.old_tb9_2(23):=8064;
RQPMT_100209_.tb9_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(23),-1)));
RQPMT_100209_.old_tb9_3(23):=null;
RQPMT_100209_.tb9_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(23),-1)));
RQPMT_100209_.old_tb9_4(23):=null;
RQPMT_100209_.tb9_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(23),-1)));
RQPMT_100209_.tb9_5(23):=RQPMT_100209_.tb8_0(0);
RQPMT_100209_.tb9_8(23):=RQPMT_100209_.tb4_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (23)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(23),
ENTITY_ID=RQPMT_100209_.tb9_1(23),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(23),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(23),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(23),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(23),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=RQPMT_100209_.tb9_8(23),
STATEMENT_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Id Del Componente Del Producto'
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

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(23);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(23),
RQPMT_100209_.tb9_1(23),
RQPMT_100209_.tb9_2(23),
RQPMT_100209_.tb9_3(23),
RQPMT_100209_.tb9_4(23),
RQPMT_100209_.tb9_5(23),
null,
null,
RQPMT_100209_.tb9_8(23),
null,
8,
'Id Del Componente Del Producto'
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
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(24):=105049;
RQPMT_100209_.old_tb9_1(24):=33;
RQPMT_100209_.tb9_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(24),-1)));
RQPMT_100209_.old_tb9_2(24):=8082;
RQPMT_100209_.tb9_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(24),-1)));
RQPMT_100209_.old_tb9_3(24):=338;
RQPMT_100209_.tb9_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(24),-1)));
RQPMT_100209_.old_tb9_4(24):=null;
RQPMT_100209_.tb9_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(24),-1)));
RQPMT_100209_.tb9_5(24):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (24)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(24),
ENTITY_ID=RQPMT_100209_.tb9_1(24),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(24),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(24),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(24),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(24),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Id Del Componente'
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
TAG_NAME='COMPONENT_ID'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='COMPONENT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(24);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(24),
RQPMT_100209_.tb9_1(24),
RQPMT_100209_.tb9_2(24),
RQPMT_100209_.tb9_3(24),
RQPMT_100209_.tb9_4(24),
RQPMT_100209_.tb9_5(24),
null,
null,
null,
null,
9,
'Id Del Componente'
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
'COMPONENT_ID'
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
'MO_SUSPENSION_COMP'
,
'COMPONENT_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;

RQPMT_100209_.tb9_0(25):=105050;
RQPMT_100209_.old_tb9_1(25):=33;
RQPMT_100209_.tb9_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100209_.TBENTITYNAME(NVL(RQPMT_100209_.old_tb9_1(25),-1)));
RQPMT_100209_.old_tb9_2(25):=8083;
RQPMT_100209_.tb9_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_2(25),-1)));
RQPMT_100209_.old_tb9_3(25):=311;
RQPMT_100209_.tb9_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_3(25),-1)));
RQPMT_100209_.old_tb9_4(25):=null;
RQPMT_100209_.tb9_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100209_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100209_.old_tb9_4(25),-1)));
RQPMT_100209_.tb9_5(25):=RQPMT_100209_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (25)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=RQPMT_100209_.tb9_0(25),
ENTITY_ID=RQPMT_100209_.tb9_1(25),
ENTITY_ATTRIBUTE_ID=RQPMT_100209_.tb9_2(25),
MIRROR_ENTI_ATTRIB=RQPMT_100209_.tb9_3(25),
PARENT_ATTRIBUTE_ID=RQPMT_100209_.tb9_4(25),
PROD_MOTIVE_COMP_ID=RQPMT_100209_.tb9_5(25),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=null,
STATEMENT_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Id Del Tipo De Suspensi¿n'
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
TAG_NAME='SUSPENSION_TYPE_ID'
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
ENTITY_NAME='MO_SUSPENSION_COMP'
,
ATTRI_TECHNICAL_NAME='SUSPENSION_TYPE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE MOTI_COMP_ATTRIBS_ID = RQPMT_100209_.tb9_0(25);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100209_.tb9_0(25),
RQPMT_100209_.tb9_1(25),
RQPMT_100209_.tb9_2(25),
RQPMT_100209_.tb9_3(25),
RQPMT_100209_.tb9_4(25),
RQPMT_100209_.tb9_5(25),
null,
null,
null,
null,
10,
'Id Del Tipo De Suspensi¿n'
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
'SUSPENSION_TYPE_ID'
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
'MO_SUSPENSION_COMP'
,
'SUSPENSION_TYPE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
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

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100209, sbSuccess);
FOR rc in RQPMT_100209_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
nuIndex := RQPMT_100209_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100209_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100209_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100209_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100209_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100209_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100209_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100209_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100209_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100209_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100209_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100209_.blProcessStatus := false;
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
 nuIndex := RQPMT_100209_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100209_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100209_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100209_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100209_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100209_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100209_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100209_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100209_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100209_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100209_',
'CREATE OR REPLACE PACKAGE RQCFG_100209_ IS ' || chr(10) ||
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
'AND     external_root_id = 100209 ' || chr(10) ||
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
'END RQCFG_100209_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100209_******************************'); END;
/

BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100209_.cuCompositions;
fetch RQCFG_100209_.cuCompositions bulk collect INTO RQCFG_100209_.tbCompositions;
close RQCFG_100209_.cuCompositions;

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100209_.tbEntityName(-1) := 'NULL';
   RQCFG_100209_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100209_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100209_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100209_.tbEntityName(2014) := 'PS_PROD_MOTIVE_COMP';
   RQCFG_100209_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100209_.tbEntityName(2042) := 'PS_MOTI_COMP_ATTRIBS';
   RQCFG_100209_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(309) := 'MO_SUSPENSION@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(311) := 'MO_SUSPENSION@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(312) := 'MO_SUSPENSION@REGISTER_DATE';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(313) := 'MO_SUSPENSION@APLICATION_DATE';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100209_.tbEntityAttributeName(1863) := 'MO_PROCESS@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100209_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8082) := 'MO_SUSPENSION_COMP@COMPONENT_ID';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8083) := 'MO_SUSPENSION_COMP@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8084) := 'MO_SUSPENSION_COMP@REGISTER_DATE';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8085) := 'MO_SUSPENSION_COMP@APLICATION_DATE';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(89620) := 'MO_COMPONENT@ADDRESS_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(311) := 'MO_SUSPENSION@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100209_.tbEntityAttributeName(1863) := 'MO_PROCESS@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(362) := 'MO_COMPONENT@MOTIVE_TYPE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(50000937) := 'MO_COMPONENT@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100209_.tbEntityAttributeName(1863) := 'MO_PROCESS@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(144514) := 'MO_MOTIVE@CAUSAL_ID';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(309) := 'MO_SUSPENSION@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(312) := 'MO_SUSPENSION@REGISTER_DATE';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(89620) := 'MO_COMPONENT@ADDRESS_ID';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8082) := 'MO_SUSPENSION_COMP@COMPONENT_ID';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8084) := 'MO_SUSPENSION_COMP@REGISTER_DATE';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(311) := 'MO_SUSPENSION@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(4013) := 'MO_COMPONENT@SERVICE_NUMBER';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(50000936) := 'MO_COMPONENT@PRODUCT_ID';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8083) := 'MO_SUSPENSION_COMP@SUSPENSION_TYPE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100209_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100209_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100209_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100209_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100209_.tbEntityName(24) := 'MO_SUSPENSION';
   RQCFG_100209_.tbEntityAttributeName(313) := 'MO_SUSPENSION@APLICATION_DATE';
   RQCFG_100209_.tbEntityName(33) := 'MO_SUSPENSION_COMP';
   RQCFG_100209_.tbEntityAttributeName(8085) := 'MO_SUSPENSION_COMP@APLICATION_DATE';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100209_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100209_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100209_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100209_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100209_.tbEntityName(43) := 'MO_COMPONENT';
   RQCFG_100209_.tbEntityAttributeName(8064) := 'MO_COMPONENT@COMPONENT_ID_PROD';
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
AND     external_root_id = 100209
)
);
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100209_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100209, 4);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100209_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100209_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100209_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100209_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100209_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209))));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209)));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100209, 4);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100209_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209))));
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209))));
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209))));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209)));

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100209_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100209_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100209_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100209_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100209_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100209_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100209;

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb0_0(0):=7423;
RQCFG_100209_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100209_.tb0_0(0):=RQCFG_100209_.tb0_0(0);
RQCFG_100209_.old_tb0_2(0):=2012;
RQCFG_100209_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100209_.tb0_0(0),
100209,
RQCFG_100209_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb1_0(0):=1031741;
RQCFG_100209_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100209_.tb1_0(0):=RQCFG_100209_.tb1_0(0);
RQCFG_100209_.old_tb1_1(0):=100209;
RQCFG_100209_.tb1_1(0):=RQCFG_100209_.old_tb1_1(0);
RQCFG_100209_.old_tb1_2(0):=2012;
RQCFG_100209_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(0),-1)));
RQCFG_100209_.old_tb1_3(0):=7423;
RQCFG_100209_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(0),-1))), RQCFG_100209_.old_tb1_1(0), 4);
RQCFG_100209_.tb1_3(0):=RQCFG_100209_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100209_.tb1_0(0),
RQCFG_100209_.tb1_1(0),
RQCFG_100209_.tb1_2(0),
RQCFG_100209_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb2_0(0):=100022368;
RQCFG_100209_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100209_.tb2_0(0):=RQCFG_100209_.tb2_0(0);
RQCFG_100209_.tb2_1(0):=RQCFG_100209_.tb0_0(0);
RQCFG_100209_.tb2_2(0):=RQCFG_100209_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100209_.tb2_0(0),
RQCFG_100209_.tb2_1(0),
RQCFG_100209_.tb2_2(0),
null,
7014,
1,
1,
1);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb1_0(1):=1031742;
RQCFG_100209_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100209_.tb1_0(1):=RQCFG_100209_.tb1_0(1);
RQCFG_100209_.old_tb1_1(1):=100239;
RQCFG_100209_.tb1_1(1):=RQCFG_100209_.old_tb1_1(1);
RQCFG_100209_.old_tb1_2(1):=2013;
RQCFG_100209_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(1),-1)));
RQCFG_100209_.old_tb1_3(1):=null;
RQCFG_100209_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(1),-1))), RQCFG_100209_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100209_.tb1_0(1),
RQCFG_100209_.tb1_1(1),
RQCFG_100209_.tb1_2(1),
RQCFG_100209_.tb1_3(1),
null,
'M_INSTALACION_DE_GAS_100239'
,
1,
1,
4);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb2_0(1):=100022369;
RQCFG_100209_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100209_.tb2_0(1):=RQCFG_100209_.tb2_0(1);
RQCFG_100209_.tb2_1(1):=RQCFG_100209_.tb0_0(0);
RQCFG_100209_.tb2_2(1):=RQCFG_100209_.tb1_0(1);
RQCFG_100209_.tb2_3(1):=RQCFG_100209_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100209_.tb2_0(1),
RQCFG_100209_.tb2_1(1),
RQCFG_100209_.tb2_2(1),
RQCFG_100209_.tb2_3(1),
7014,
2,
1,
1);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb1_0(2):=1031743;
RQCFG_100209_.tb1_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100209_.tb1_0(2):=RQCFG_100209_.tb1_0(2);
RQCFG_100209_.old_tb1_1(2):=10307;
RQCFG_100209_.tb1_1(2):=RQCFG_100209_.old_tb1_1(2);
RQCFG_100209_.old_tb1_2(2):=2014;
RQCFG_100209_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(2),-1)));
RQCFG_100209_.old_tb1_3(2):=null;
RQCFG_100209_.tb1_3(2):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(2),-1))), RQCFG_100209_.old_tb1_1(2), 4);
RQCFG_100209_.tb1_4(2):=RQCFG_100209_.tb1_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100209_.tb1_0(2),
RQCFG_100209_.tb1_1(2),
RQCFG_100209_.tb1_2(2),
RQCFG_100209_.tb1_3(2),
RQCFG_100209_.tb1_4(2),
'C_GAS_10307'
,
1,
1,
4);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb2_0(2):=100022370;
RQCFG_100209_.tb2_0(2):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100209_.tb2_0(2):=RQCFG_100209_.tb2_0(2);
RQCFG_100209_.tb2_1(2):=RQCFG_100209_.tb0_0(0);
RQCFG_100209_.tb2_2(2):=RQCFG_100209_.tb1_0(2);
RQCFG_100209_.tb2_3(2):=RQCFG_100209_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (2)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100209_.tb2_0(2),
RQCFG_100209_.tb2_1(2),
RQCFG_100209_.tb2_2(2),
RQCFG_100209_.tb2_3(2),
7014,
3,
1,
1);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb1_0(3):=1031744;
RQCFG_100209_.tb1_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100209_.tb1_0(3):=RQCFG_100209_.tb1_0(3);
RQCFG_100209_.old_tb1_1(3):=10308;
RQCFG_100209_.tb1_1(3):=RQCFG_100209_.old_tb1_1(3);
RQCFG_100209_.old_tb1_2(3):=2014;
RQCFG_100209_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(3),-1)));
RQCFG_100209_.old_tb1_3(3):=null;
RQCFG_100209_.tb1_3(3):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb1_2(3),-1))), RQCFG_100209_.old_tb1_1(3), 4);
RQCFG_100209_.tb1_4(3):=RQCFG_100209_.tb1_0(2);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (3)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100209_.tb1_0(3),
RQCFG_100209_.tb1_1(3),
RQCFG_100209_.tb1_2(3),
RQCFG_100209_.tb1_3(3),
RQCFG_100209_.tb1_4(3),
'C_MEDICION_10308'
,
1,
1,
4);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb2_0(3):=100022371;
RQCFG_100209_.tb2_0(3):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100209_.tb2_0(3):=RQCFG_100209_.tb2_0(3);
RQCFG_100209_.tb2_1(3):=RQCFG_100209_.tb0_0(0);
RQCFG_100209_.tb2_2(3):=RQCFG_100209_.tb1_0(3);
RQCFG_100209_.tb2_3(3):=RQCFG_100209_.tb2_0(2);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (3)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100209_.tb2_0(3),
RQCFG_100209_.tb2_1(3),
RQCFG_100209_.tb2_2(3),
RQCFG_100209_.tb2_3(3),
7014,
4,
1,
1);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(0):=1070614;
RQCFG_100209_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(0):=RQCFG_100209_.tb3_0(0);
RQCFG_100209_.old_tb3_1(0):=2042;
RQCFG_100209_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(0),-1)));
RQCFG_100209_.old_tb3_2(0):=50000936;
RQCFG_100209_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(0),-1)));
RQCFG_100209_.old_tb3_3(0):=null;
RQCFG_100209_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(0),-1)));
RQCFG_100209_.old_tb3_4(0):=null;
RQCFG_100209_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(0),-1)));
RQCFG_100209_.tb3_5(0):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(0):=121048648;
RQCFG_100209_.tb3_6(0):=NULL;
RQCFG_100209_.old_tb3_7(0):=null;
RQCFG_100209_.tb3_7(0):=NULL;
RQCFG_100209_.old_tb3_8(0):=null;
RQCFG_100209_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(0),
RQCFG_100209_.tb3_1(0),
RQCFG_100209_.tb3_2(0),
RQCFG_100209_.tb3_3(0),
RQCFG_100209_.tb3_4(0),
RQCFG_100209_.tb3_5(0),
RQCFG_100209_.tb3_6(0),
RQCFG_100209_.tb3_7(0),
RQCFG_100209_.tb3_8(0),
null,
105027,
5,
'Identificador del Producto'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb4_0(0):=98442;
RQCFG_100209_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100209_.tb4_0(0):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb4_1(0):=RQCFG_100209_.tb2_2(3);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100209_.tb4_0(0),
RQCFG_100209_.tb4_1(0),
null,
null,
'FRAME-C_MEDICION_10308-1026298'
,
4);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(0):=1216477;
RQCFG_100209_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(0):=RQCFG_100209_.tb5_0(0);
RQCFG_100209_.old_tb5_1(0):=50000936;
RQCFG_100209_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(0),-1)));
RQCFG_100209_.old_tb5_2(0):=null;
RQCFG_100209_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(0),-1)));
RQCFG_100209_.tb5_3(0):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(0):=RQCFG_100209_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(0),
RQCFG_100209_.tb5_1(0),
RQCFG_100209_.tb5_2(0),
RQCFG_100209_.tb5_3(0),
RQCFG_100209_.tb5_4(0),
'C'
,
'Y'
,
5,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(1):=1070615;
RQCFG_100209_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(1):=RQCFG_100209_.tb3_0(1);
RQCFG_100209_.old_tb3_1(1):=2042;
RQCFG_100209_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(1),-1)));
RQCFG_100209_.old_tb3_2(1):=4013;
RQCFG_100209_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(1),-1)));
RQCFG_100209_.old_tb3_3(1):=null;
RQCFG_100209_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(1),-1)));
RQCFG_100209_.old_tb3_4(1):=null;
RQCFG_100209_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(1),-1)));
RQCFG_100209_.tb3_5(1):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(1):=121048649;
RQCFG_100209_.tb3_6(1):=NULL;
RQCFG_100209_.old_tb3_7(1):=null;
RQCFG_100209_.tb3_7(1):=NULL;
RQCFG_100209_.old_tb3_8(1):=null;
RQCFG_100209_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(1),
RQCFG_100209_.tb3_1(1),
RQCFG_100209_.tb3_2(1),
RQCFG_100209_.tb3_3(1),
RQCFG_100209_.tb3_4(1),
RQCFG_100209_.tb3_5(1),
RQCFG_100209_.tb3_6(1),
RQCFG_100209_.tb3_7(1),
RQCFG_100209_.tb3_8(1),
null,
105028,
6,
'N¿mero Servicio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(1):=1216478;
RQCFG_100209_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(1):=RQCFG_100209_.tb5_0(1);
RQCFG_100209_.old_tb5_1(1):=4013;
RQCFG_100209_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(1),-1)));
RQCFG_100209_.old_tb5_2(1):=null;
RQCFG_100209_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(1),-1)));
RQCFG_100209_.tb5_3(1):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(1):=RQCFG_100209_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(1),
RQCFG_100209_.tb5_1(1),
RQCFG_100209_.tb5_2(1),
RQCFG_100209_.tb5_3(1),
RQCFG_100209_.tb5_4(1),
'C'
,
'Y'
,
6,
'N'
,
'N¿mero Servicio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(2):=1070616;
RQCFG_100209_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(2):=RQCFG_100209_.tb3_0(2);
RQCFG_100209_.old_tb3_1(2):=2042;
RQCFG_100209_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(2),-1)));
RQCFG_100209_.old_tb3_2(2):=89620;
RQCFG_100209_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(2),-1)));
RQCFG_100209_.old_tb3_3(2):=null;
RQCFG_100209_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(2),-1)));
RQCFG_100209_.old_tb3_4(2):=null;
RQCFG_100209_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(2),-1)));
RQCFG_100209_.tb3_5(2):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(2):=121048650;
RQCFG_100209_.tb3_6(2):=NULL;
RQCFG_100209_.old_tb3_7(2):=null;
RQCFG_100209_.tb3_7(2):=NULL;
RQCFG_100209_.old_tb3_8(2):=null;
RQCFG_100209_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(2),
RQCFG_100209_.tb3_1(2),
RQCFG_100209_.tb3_2(2),
RQCFG_100209_.tb3_3(2),
RQCFG_100209_.tb3_4(2),
RQCFG_100209_.tb3_5(2),
RQCFG_100209_.tb3_6(2),
RQCFG_100209_.tb3_7(2),
RQCFG_100209_.tb3_8(2),
null,
105029,
7,
'Direcci¿n De Instalaci¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(2):=1216479;
RQCFG_100209_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(2):=RQCFG_100209_.tb5_0(2);
RQCFG_100209_.old_tb5_1(2):=89620;
RQCFG_100209_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(2),-1)));
RQCFG_100209_.old_tb5_2(2):=null;
RQCFG_100209_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(2),-1)));
RQCFG_100209_.tb5_3(2):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(2):=RQCFG_100209_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(2),
RQCFG_100209_.tb5_1(2),
RQCFG_100209_.tb5_2(2),
RQCFG_100209_.tb5_3(2),
RQCFG_100209_.tb5_4(2),
'C'
,
'Y'
,
7,
'N'
,
'Direcci¿n De Instalaci¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(3):=1070617;
RQCFG_100209_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(3):=RQCFG_100209_.tb3_0(3);
RQCFG_100209_.old_tb3_1(3):=2042;
RQCFG_100209_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(3),-1)));
RQCFG_100209_.old_tb3_2(3):=8064;
RQCFG_100209_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(3),-1)));
RQCFG_100209_.old_tb3_3(3):=null;
RQCFG_100209_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(3),-1)));
RQCFG_100209_.old_tb3_4(3):=null;
RQCFG_100209_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(3),-1)));
RQCFG_100209_.tb3_5(3):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(3):=121048645;
RQCFG_100209_.tb3_6(3):=NULL;
RQCFG_100209_.old_tb3_7(3):=null;
RQCFG_100209_.tb3_7(3):=NULL;
RQCFG_100209_.old_tb3_8(3):=null;
RQCFG_100209_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(3),
RQCFG_100209_.tb3_1(3),
RQCFG_100209_.tb3_2(3),
RQCFG_100209_.tb3_3(3),
RQCFG_100209_.tb3_4(3),
RQCFG_100209_.tb3_5(3),
RQCFG_100209_.tb3_6(3),
RQCFG_100209_.tb3_7(3),
RQCFG_100209_.tb3_8(3),
null,
105030,
8,
'Id Del Componente Del Producto'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(3):=1216480;
RQCFG_100209_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(3):=RQCFG_100209_.tb5_0(3);
RQCFG_100209_.old_tb5_1(3):=8064;
RQCFG_100209_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(3),-1)));
RQCFG_100209_.old_tb5_2(3):=null;
RQCFG_100209_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(3),-1)));
RQCFG_100209_.tb5_3(3):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(3):=RQCFG_100209_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(3),
RQCFG_100209_.tb5_1(3),
RQCFG_100209_.tb5_2(3),
RQCFG_100209_.tb5_3(3),
RQCFG_100209_.tb5_4(3),
'C'
,
'Y'
,
8,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(4):=1070618;
RQCFG_100209_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(4):=RQCFG_100209_.tb3_0(4);
RQCFG_100209_.old_tb3_1(4):=2042;
RQCFG_100209_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(4),-1)));
RQCFG_100209_.old_tb3_2(4):=456;
RQCFG_100209_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(4),-1)));
RQCFG_100209_.old_tb3_3(4):=187;
RQCFG_100209_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(4),-1)));
RQCFG_100209_.old_tb3_4(4):=null;
RQCFG_100209_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(4),-1)));
RQCFG_100209_.tb3_5(4):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(4):=null;
RQCFG_100209_.tb3_6(4):=NULL;
RQCFG_100209_.old_tb3_7(4):=null;
RQCFG_100209_.tb3_7(4):=NULL;
RQCFG_100209_.old_tb3_8(4):=null;
RQCFG_100209_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(4),
RQCFG_100209_.tb3_1(4),
RQCFG_100209_.tb3_2(4),
RQCFG_100209_.tb3_3(4),
RQCFG_100209_.tb3_4(4),
RQCFG_100209_.tb3_5(4),
RQCFG_100209_.tb3_6(4),
RQCFG_100209_.tb3_7(4),
RQCFG_100209_.tb3_8(4),
null,
105023,
1,
'C¿digo del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(4):=1216481;
RQCFG_100209_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(4):=RQCFG_100209_.tb5_0(4);
RQCFG_100209_.old_tb5_1(4):=456;
RQCFG_100209_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(4),-1)));
RQCFG_100209_.old_tb5_2(4):=null;
RQCFG_100209_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(4),-1)));
RQCFG_100209_.tb5_3(4):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(4):=RQCFG_100209_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(4),
RQCFG_100209_.tb5_1(4),
RQCFG_100209_.tb5_2(4),
RQCFG_100209_.tb5_3(4),
RQCFG_100209_.tb5_4(4),
'C'
,
'Y'
,
1,
'N'
,
'C¿digo del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(5):=1070619;
RQCFG_100209_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(5):=RQCFG_100209_.tb3_0(5);
RQCFG_100209_.old_tb3_1(5):=2042;
RQCFG_100209_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(5),-1)));
RQCFG_100209_.old_tb3_2(5):=362;
RQCFG_100209_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(5),-1)));
RQCFG_100209_.old_tb3_3(5):=191;
RQCFG_100209_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(5),-1)));
RQCFG_100209_.old_tb3_4(5):=null;
RQCFG_100209_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(5),-1)));
RQCFG_100209_.tb3_5(5):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(5):=null;
RQCFG_100209_.tb3_6(5):=NULL;
RQCFG_100209_.old_tb3_7(5):=null;
RQCFG_100209_.tb3_7(5):=NULL;
RQCFG_100209_.old_tb3_8(5):=null;
RQCFG_100209_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(5),
RQCFG_100209_.tb3_1(5),
RQCFG_100209_.tb3_2(5),
RQCFG_100209_.tb3_3(5),
RQCFG_100209_.tb3_4(5),
RQCFG_100209_.tb3_5(5),
RQCFG_100209_.tb3_6(5),
RQCFG_100209_.tb3_7(5),
RQCFG_100209_.tb3_8(5),
null,
105024,
2,
'Tipo Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(5):=1216482;
RQCFG_100209_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(5):=RQCFG_100209_.tb5_0(5);
RQCFG_100209_.old_tb5_1(5):=362;
RQCFG_100209_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(5),-1)));
RQCFG_100209_.old_tb5_2(5):=null;
RQCFG_100209_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(5),-1)));
RQCFG_100209_.tb5_3(5):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(5):=RQCFG_100209_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(5),
RQCFG_100209_.tb5_1(5),
RQCFG_100209_.tb5_2(5),
RQCFG_100209_.tb5_3(5),
RQCFG_100209_.tb5_4(5),
'C'
,
'Y'
,
2,
'N'
,
'Tipo Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(6):=1070620;
RQCFG_100209_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(6):=RQCFG_100209_.tb3_0(6);
RQCFG_100209_.old_tb3_1(6):=2042;
RQCFG_100209_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(6),-1)));
RQCFG_100209_.old_tb3_2(6):=696;
RQCFG_100209_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(6),-1)));
RQCFG_100209_.old_tb3_3(6):=697;
RQCFG_100209_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(6),-1)));
RQCFG_100209_.old_tb3_4(6):=null;
RQCFG_100209_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(6),-1)));
RQCFG_100209_.tb3_5(6):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(6):=null;
RQCFG_100209_.tb3_6(6):=NULL;
RQCFG_100209_.old_tb3_7(6):=null;
RQCFG_100209_.tb3_7(6):=NULL;
RQCFG_100209_.old_tb3_8(6):=null;
RQCFG_100209_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(6),
RQCFG_100209_.tb3_1(6),
RQCFG_100209_.tb3_2(6),
RQCFG_100209_.tb3_3(6),
RQCFG_100209_.tb3_4(6),
RQCFG_100209_.tb3_5(6),
RQCFG_100209_.tb3_6(6),
RQCFG_100209_.tb3_7(6),
RQCFG_100209_.tb3_8(6),
null,
105025,
3,
'C¿digo del Producto Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(6):=1216483;
RQCFG_100209_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(6):=RQCFG_100209_.tb5_0(6);
RQCFG_100209_.old_tb5_1(6):=696;
RQCFG_100209_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(6),-1)));
RQCFG_100209_.old_tb5_2(6):=null;
RQCFG_100209_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(6),-1)));
RQCFG_100209_.tb5_3(6):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(6):=RQCFG_100209_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(6),
RQCFG_100209_.tb5_1(6),
RQCFG_100209_.tb5_2(6),
RQCFG_100209_.tb5_3(6),
RQCFG_100209_.tb5_4(6),
'C'
,
'Y'
,
3,
'N'
,
'C¿digo del Producto Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(7):=1070621;
RQCFG_100209_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(7):=RQCFG_100209_.tb3_0(7);
RQCFG_100209_.old_tb3_1(7):=2042;
RQCFG_100209_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(7),-1)));
RQCFG_100209_.old_tb3_2(7):=338;
RQCFG_100209_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(7),-1)));
RQCFG_100209_.old_tb3_3(7):=null;
RQCFG_100209_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(7),-1)));
RQCFG_100209_.old_tb3_4(7):=null;
RQCFG_100209_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(7),-1)));
RQCFG_100209_.tb3_5(7):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(7):=121048647;
RQCFG_100209_.tb3_6(7):=NULL;
RQCFG_100209_.old_tb3_7(7):=null;
RQCFG_100209_.tb3_7(7):=NULL;
RQCFG_100209_.old_tb3_8(7):=null;
RQCFG_100209_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(7),
RQCFG_100209_.tb3_1(7),
RQCFG_100209_.tb3_2(7),
RQCFG_100209_.tb3_3(7),
RQCFG_100209_.tb3_4(7),
RQCFG_100209_.tb3_5(7),
RQCFG_100209_.tb3_6(7),
RQCFG_100209_.tb3_7(7),
RQCFG_100209_.tb3_8(7),
null,
105022,
0,
'C¿digo de Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(7):=1216484;
RQCFG_100209_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(7):=RQCFG_100209_.tb5_0(7);
RQCFG_100209_.old_tb5_1(7):=338;
RQCFG_100209_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(7),-1)));
RQCFG_100209_.old_tb5_2(7):=null;
RQCFG_100209_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(7),-1)));
RQCFG_100209_.tb5_3(7):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(7):=RQCFG_100209_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(7),
RQCFG_100209_.tb5_1(7),
RQCFG_100209_.tb5_2(7),
RQCFG_100209_.tb5_3(7),
RQCFG_100209_.tb5_4(7),
'C'
,
'Y'
,
0,
'N'
,
'C¿digo de Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(8):=1070622;
RQCFG_100209_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(8):=RQCFG_100209_.tb3_0(8);
RQCFG_100209_.old_tb3_1(8):=2042;
RQCFG_100209_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(8),-1)));
RQCFG_100209_.old_tb3_2(8):=8082;
RQCFG_100209_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(8),-1)));
RQCFG_100209_.old_tb3_3(8):=338;
RQCFG_100209_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(8),-1)));
RQCFG_100209_.old_tb3_4(8):=null;
RQCFG_100209_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(8),-1)));
RQCFG_100209_.tb3_5(8):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(8):=null;
RQCFG_100209_.tb3_6(8):=NULL;
RQCFG_100209_.old_tb3_7(8):=null;
RQCFG_100209_.tb3_7(8):=NULL;
RQCFG_100209_.old_tb3_8(8):=null;
RQCFG_100209_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(8),
RQCFG_100209_.tb3_1(8),
RQCFG_100209_.tb3_2(8),
RQCFG_100209_.tb3_3(8),
RQCFG_100209_.tb3_4(8),
RQCFG_100209_.tb3_5(8),
RQCFG_100209_.tb3_6(8),
RQCFG_100209_.tb3_7(8),
RQCFG_100209_.tb3_8(8),
null,
105052,
9,
'Id Del Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(8):=1216485;
RQCFG_100209_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(8):=RQCFG_100209_.tb5_0(8);
RQCFG_100209_.old_tb5_1(8):=8082;
RQCFG_100209_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(8),-1)));
RQCFG_100209_.old_tb5_2(8):=null;
RQCFG_100209_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(8),-1)));
RQCFG_100209_.tb5_3(8):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(8):=RQCFG_100209_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(8),
RQCFG_100209_.tb5_1(8),
RQCFG_100209_.tb5_2(8),
RQCFG_100209_.tb5_3(8),
RQCFG_100209_.tb5_4(8),
'C'
,
'Y'
,
9,
'N'
,
'Id Del Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(9):=1070623;
RQCFG_100209_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(9):=RQCFG_100209_.tb3_0(9);
RQCFG_100209_.old_tb3_1(9):=2042;
RQCFG_100209_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(9),-1)));
RQCFG_100209_.old_tb3_2(9):=8083;
RQCFG_100209_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(9),-1)));
RQCFG_100209_.old_tb3_3(9):=311;
RQCFG_100209_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(9),-1)));
RQCFG_100209_.old_tb3_4(9):=null;
RQCFG_100209_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(9),-1)));
RQCFG_100209_.tb3_5(9):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(9):=null;
RQCFG_100209_.tb3_6(9):=NULL;
RQCFG_100209_.old_tb3_7(9):=null;
RQCFG_100209_.tb3_7(9):=NULL;
RQCFG_100209_.old_tb3_8(9):=null;
RQCFG_100209_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(9),
RQCFG_100209_.tb3_1(9),
RQCFG_100209_.tb3_2(9),
RQCFG_100209_.tb3_3(9),
RQCFG_100209_.tb3_4(9),
RQCFG_100209_.tb3_5(9),
RQCFG_100209_.tb3_6(9),
RQCFG_100209_.tb3_7(9),
RQCFG_100209_.tb3_8(9),
null,
105053,
10,
'Id Del Tipo De Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(9):=1216486;
RQCFG_100209_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(9):=RQCFG_100209_.tb5_0(9);
RQCFG_100209_.old_tb5_1(9):=8083;
RQCFG_100209_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(9),-1)));
RQCFG_100209_.old_tb5_2(9):=null;
RQCFG_100209_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(9),-1)));
RQCFG_100209_.tb5_3(9):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(9):=RQCFG_100209_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(9),
RQCFG_100209_.tb5_1(9),
RQCFG_100209_.tb5_2(9),
RQCFG_100209_.tb5_3(9),
RQCFG_100209_.tb5_4(9),
'C'
,
'Y'
,
10,
'N'
,
'Id Del Tipo De Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(10):=1070624;
RQCFG_100209_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(10):=RQCFG_100209_.tb3_0(10);
RQCFG_100209_.old_tb3_1(10):=2042;
RQCFG_100209_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(10),-1)));
RQCFG_100209_.old_tb3_2(10):=8084;
RQCFG_100209_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(10),-1)));
RQCFG_100209_.old_tb3_3(10):=258;
RQCFG_100209_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(10),-1)));
RQCFG_100209_.old_tb3_4(10):=null;
RQCFG_100209_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(10),-1)));
RQCFG_100209_.tb3_5(10):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(10):=null;
RQCFG_100209_.tb3_6(10):=NULL;
RQCFG_100209_.old_tb3_7(10):=null;
RQCFG_100209_.tb3_7(10):=NULL;
RQCFG_100209_.old_tb3_8(10):=null;
RQCFG_100209_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(10),
RQCFG_100209_.tb3_1(10),
RQCFG_100209_.tb3_2(10),
RQCFG_100209_.tb3_3(10),
RQCFG_100209_.tb3_4(10),
RQCFG_100209_.tb3_5(10),
RQCFG_100209_.tb3_6(10),
RQCFG_100209_.tb3_7(10),
RQCFG_100209_.tb3_8(10),
null,
105054,
11,
'Fecha De Registro De La Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(10):=1216487;
RQCFG_100209_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(10):=RQCFG_100209_.tb5_0(10);
RQCFG_100209_.old_tb5_1(10):=8084;
RQCFG_100209_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(10),-1)));
RQCFG_100209_.old_tb5_2(10):=null;
RQCFG_100209_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(10),-1)));
RQCFG_100209_.tb5_3(10):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(10):=RQCFG_100209_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(10),
RQCFG_100209_.tb5_1(10),
RQCFG_100209_.tb5_2(10),
RQCFG_100209_.tb5_3(10),
RQCFG_100209_.tb5_4(10),
'C'
,
'Y'
,
11,
'N'
,
'Fecha De Registro De La Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(11):=1070625;
RQCFG_100209_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(11):=RQCFG_100209_.tb3_0(11);
RQCFG_100209_.old_tb3_1(11):=2042;
RQCFG_100209_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(11),-1)));
RQCFG_100209_.old_tb3_2(11):=8085;
RQCFG_100209_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(11),-1)));
RQCFG_100209_.old_tb3_3(11):=null;
RQCFG_100209_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(11),-1)));
RQCFG_100209_.old_tb3_4(11):=null;
RQCFG_100209_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(11),-1)));
RQCFG_100209_.tb3_5(11):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(11):=121048646;
RQCFG_100209_.tb3_6(11):=NULL;
RQCFG_100209_.old_tb3_7(11):=null;
RQCFG_100209_.tb3_7(11):=NULL;
RQCFG_100209_.old_tb3_8(11):=null;
RQCFG_100209_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(11),
RQCFG_100209_.tb3_1(11),
RQCFG_100209_.tb3_2(11),
RQCFG_100209_.tb3_3(11),
RQCFG_100209_.tb3_4(11),
RQCFG_100209_.tb3_5(11),
RQCFG_100209_.tb3_6(11),
RQCFG_100209_.tb3_7(11),
RQCFG_100209_.tb3_8(11),
null,
105056,
12,
'Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(11):=1216488;
RQCFG_100209_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(11):=RQCFG_100209_.tb5_0(11);
RQCFG_100209_.old_tb5_1(11):=8085;
RQCFG_100209_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(11),-1)));
RQCFG_100209_.old_tb5_2(11):=null;
RQCFG_100209_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(11),-1)));
RQCFG_100209_.tb5_3(11):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(11):=RQCFG_100209_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(11),
RQCFG_100209_.tb5_1(11),
RQCFG_100209_.tb5_2(11),
RQCFG_100209_.tb5_3(11),
RQCFG_100209_.tb5_4(11),
'C'
,
'Y'
,
12,
'N'
,
'Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(12):=1070626;
RQCFG_100209_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(12):=RQCFG_100209_.tb3_0(12);
RQCFG_100209_.old_tb3_1(12):=2042;
RQCFG_100209_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(12),-1)));
RQCFG_100209_.old_tb3_2(12):=50000937;
RQCFG_100209_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(12),-1)));
RQCFG_100209_.old_tb3_3(12):=255;
RQCFG_100209_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(12),-1)));
RQCFG_100209_.old_tb3_4(12):=null;
RQCFG_100209_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(12),-1)));
RQCFG_100209_.tb3_5(12):=RQCFG_100209_.tb2_2(3);
RQCFG_100209_.old_tb3_6(12):=null;
RQCFG_100209_.tb3_6(12):=NULL;
RQCFG_100209_.old_tb3_7(12):=null;
RQCFG_100209_.tb3_7(12):=NULL;
RQCFG_100209_.old_tb3_8(12):=null;
RQCFG_100209_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(12),
RQCFG_100209_.tb3_1(12),
RQCFG_100209_.tb3_2(12),
RQCFG_100209_.tb3_3(12),
RQCFG_100209_.tb3_4(12),
RQCFG_100209_.tb3_5(12),
RQCFG_100209_.tb3_6(12),
RQCFG_100209_.tb3_7(12),
RQCFG_100209_.tb3_8(12),
null,
105026,
4,
'Identificador del Paquete'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(12):=1216489;
RQCFG_100209_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(12):=RQCFG_100209_.tb5_0(12);
RQCFG_100209_.old_tb5_1(12):=50000937;
RQCFG_100209_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(12),-1)));
RQCFG_100209_.old_tb5_2(12):=null;
RQCFG_100209_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(12),-1)));
RQCFG_100209_.tb5_3(12):=RQCFG_100209_.tb4_0(0);
RQCFG_100209_.tb5_4(12):=RQCFG_100209_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(12),
RQCFG_100209_.tb5_1(12),
RQCFG_100209_.tb5_2(12),
RQCFG_100209_.tb5_3(12),
RQCFG_100209_.tb5_4(12),
'C'
,
'Y'
,
4,
'N'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(13):=1070627;
RQCFG_100209_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(13):=RQCFG_100209_.tb3_0(13);
RQCFG_100209_.old_tb3_1(13):=2042;
RQCFG_100209_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(13),-1)));
RQCFG_100209_.old_tb3_2(13):=338;
RQCFG_100209_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(13),-1)));
RQCFG_100209_.old_tb3_3(13):=null;
RQCFG_100209_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(13),-1)));
RQCFG_100209_.old_tb3_4(13):=null;
RQCFG_100209_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(13),-1)));
RQCFG_100209_.tb3_5(13):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(13):=121048652;
RQCFG_100209_.tb3_6(13):=NULL;
RQCFG_100209_.old_tb3_7(13):=null;
RQCFG_100209_.tb3_7(13):=NULL;
RQCFG_100209_.old_tb3_8(13):=null;
RQCFG_100209_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(13),
RQCFG_100209_.tb3_1(13),
RQCFG_100209_.tb3_2(13),
RQCFG_100209_.tb3_3(13),
RQCFG_100209_.tb3_4(13),
RQCFG_100209_.tb3_5(13),
RQCFG_100209_.tb3_6(13),
RQCFG_100209_.tb3_7(13),
RQCFG_100209_.tb3_8(13),
null,
105013,
0,
'C¿digo de Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb4_0(1):=98443;
RQCFG_100209_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100209_.tb4_0(1):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb4_1(1):=RQCFG_100209_.tb2_2(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100209_.tb4_0(1),
RQCFG_100209_.tb4_1(1),
null,
null,
'FRAME-C_GAS_10307-1026297'
,
3);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(13):=1216490;
RQCFG_100209_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(13):=RQCFG_100209_.tb5_0(13);
RQCFG_100209_.old_tb5_1(13):=338;
RQCFG_100209_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(13),-1)));
RQCFG_100209_.old_tb5_2(13):=null;
RQCFG_100209_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(13),-1)));
RQCFG_100209_.tb5_3(13):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(13):=RQCFG_100209_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(13),
RQCFG_100209_.tb5_1(13),
RQCFG_100209_.tb5_2(13),
RQCFG_100209_.tb5_3(13),
RQCFG_100209_.tb5_4(13),
'C'
,
'Y'
,
0,
'N'
,
'C¿digo de Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(14):=1070628;
RQCFG_100209_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(14):=RQCFG_100209_.tb3_0(14);
RQCFG_100209_.old_tb3_1(14):=2042;
RQCFG_100209_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(14),-1)));
RQCFG_100209_.old_tb3_2(14):=456;
RQCFG_100209_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(14),-1)));
RQCFG_100209_.old_tb3_3(14):=187;
RQCFG_100209_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(14),-1)));
RQCFG_100209_.old_tb3_4(14):=null;
RQCFG_100209_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(14),-1)));
RQCFG_100209_.tb3_5(14):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(14):=null;
RQCFG_100209_.tb3_6(14):=NULL;
RQCFG_100209_.old_tb3_7(14):=null;
RQCFG_100209_.tb3_7(14):=NULL;
RQCFG_100209_.old_tb3_8(14):=null;
RQCFG_100209_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(14),
RQCFG_100209_.tb3_1(14),
RQCFG_100209_.tb3_2(14),
RQCFG_100209_.tb3_3(14),
RQCFG_100209_.tb3_4(14),
RQCFG_100209_.tb3_5(14),
RQCFG_100209_.tb3_6(14),
RQCFG_100209_.tb3_7(14),
RQCFG_100209_.tb3_8(14),
null,
105014,
1,
'C¿digo del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(14):=1216491;
RQCFG_100209_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(14):=RQCFG_100209_.tb5_0(14);
RQCFG_100209_.old_tb5_1(14):=456;
RQCFG_100209_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(14),-1)));
RQCFG_100209_.old_tb5_2(14):=null;
RQCFG_100209_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(14),-1)));
RQCFG_100209_.tb5_3(14):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(14):=RQCFG_100209_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(14),
RQCFG_100209_.tb5_1(14),
RQCFG_100209_.tb5_2(14),
RQCFG_100209_.tb5_3(14),
RQCFG_100209_.tb5_4(14),
'C'
,
'Y'
,
1,
'N'
,
'C¿digo del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(15):=1070629;
RQCFG_100209_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(15):=RQCFG_100209_.tb3_0(15);
RQCFG_100209_.old_tb3_1(15):=2042;
RQCFG_100209_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(15),-1)));
RQCFG_100209_.old_tb3_2(15):=362;
RQCFG_100209_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(15),-1)));
RQCFG_100209_.old_tb3_3(15):=191;
RQCFG_100209_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(15),-1)));
RQCFG_100209_.old_tb3_4(15):=null;
RQCFG_100209_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(15),-1)));
RQCFG_100209_.tb3_5(15):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(15):=null;
RQCFG_100209_.tb3_6(15):=NULL;
RQCFG_100209_.old_tb3_7(15):=null;
RQCFG_100209_.tb3_7(15):=NULL;
RQCFG_100209_.old_tb3_8(15):=null;
RQCFG_100209_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(15),
RQCFG_100209_.tb3_1(15),
RQCFG_100209_.tb3_2(15),
RQCFG_100209_.tb3_3(15),
RQCFG_100209_.tb3_4(15),
RQCFG_100209_.tb3_5(15),
RQCFG_100209_.tb3_6(15),
RQCFG_100209_.tb3_7(15),
RQCFG_100209_.tb3_8(15),
null,
105015,
2,
'Tipo Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(15):=1216492;
RQCFG_100209_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(15):=RQCFG_100209_.tb5_0(15);
RQCFG_100209_.old_tb5_1(15):=362;
RQCFG_100209_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(15),-1)));
RQCFG_100209_.old_tb5_2(15):=null;
RQCFG_100209_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(15),-1)));
RQCFG_100209_.tb5_3(15):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(15):=RQCFG_100209_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(15),
RQCFG_100209_.tb5_1(15),
RQCFG_100209_.tb5_2(15),
RQCFG_100209_.tb5_3(15),
RQCFG_100209_.tb5_4(15),
'C'
,
'Y'
,
2,
'N'
,
'Tipo Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(16):=1070630;
RQCFG_100209_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(16):=RQCFG_100209_.tb3_0(16);
RQCFG_100209_.old_tb3_1(16):=2042;
RQCFG_100209_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(16),-1)));
RQCFG_100209_.old_tb3_2(16):=696;
RQCFG_100209_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(16),-1)));
RQCFG_100209_.old_tb3_3(16):=697;
RQCFG_100209_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(16),-1)));
RQCFG_100209_.old_tb3_4(16):=null;
RQCFG_100209_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(16),-1)));
RQCFG_100209_.tb3_5(16):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(16):=null;
RQCFG_100209_.tb3_6(16):=NULL;
RQCFG_100209_.old_tb3_7(16):=null;
RQCFG_100209_.tb3_7(16):=NULL;
RQCFG_100209_.old_tb3_8(16):=null;
RQCFG_100209_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(16),
RQCFG_100209_.tb3_1(16),
RQCFG_100209_.tb3_2(16),
RQCFG_100209_.tb3_3(16),
RQCFG_100209_.tb3_4(16),
RQCFG_100209_.tb3_5(16),
RQCFG_100209_.tb3_6(16),
RQCFG_100209_.tb3_7(16),
RQCFG_100209_.tb3_8(16),
null,
105016,
3,
'C¿digo del Producto Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(16):=1216493;
RQCFG_100209_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(16):=RQCFG_100209_.tb5_0(16);
RQCFG_100209_.old_tb5_1(16):=696;
RQCFG_100209_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(16),-1)));
RQCFG_100209_.old_tb5_2(16):=null;
RQCFG_100209_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(16),-1)));
RQCFG_100209_.tb5_3(16):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(16):=RQCFG_100209_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(16),
RQCFG_100209_.tb5_1(16),
RQCFG_100209_.tb5_2(16),
RQCFG_100209_.tb5_3(16),
RQCFG_100209_.tb5_4(16),
'C'
,
'Y'
,
3,
'N'
,
'C¿digo del Producto Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(17):=1070631;
RQCFG_100209_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(17):=RQCFG_100209_.tb3_0(17);
RQCFG_100209_.old_tb3_1(17):=2042;
RQCFG_100209_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(17),-1)));
RQCFG_100209_.old_tb3_2(17):=50000937;
RQCFG_100209_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(17),-1)));
RQCFG_100209_.old_tb3_3(17):=255;
RQCFG_100209_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(17),-1)));
RQCFG_100209_.old_tb3_4(17):=null;
RQCFG_100209_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(17),-1)));
RQCFG_100209_.tb3_5(17):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(17):=null;
RQCFG_100209_.tb3_6(17):=NULL;
RQCFG_100209_.old_tb3_7(17):=null;
RQCFG_100209_.tb3_7(17):=NULL;
RQCFG_100209_.old_tb3_8(17):=null;
RQCFG_100209_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(17),
RQCFG_100209_.tb3_1(17),
RQCFG_100209_.tb3_2(17),
RQCFG_100209_.tb3_3(17),
RQCFG_100209_.tb3_4(17),
RQCFG_100209_.tb3_5(17),
RQCFG_100209_.tb3_6(17),
RQCFG_100209_.tb3_7(17),
RQCFG_100209_.tb3_8(17),
null,
105017,
4,
'Identificador del Paquete'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(17):=1216494;
RQCFG_100209_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(17):=RQCFG_100209_.tb5_0(17);
RQCFG_100209_.old_tb5_1(17):=50000937;
RQCFG_100209_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(17),-1)));
RQCFG_100209_.old_tb5_2(17):=null;
RQCFG_100209_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(17),-1)));
RQCFG_100209_.tb5_3(17):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(17):=RQCFG_100209_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(17),
RQCFG_100209_.tb5_1(17),
RQCFG_100209_.tb5_2(17),
RQCFG_100209_.tb5_3(17),
RQCFG_100209_.tb5_4(17),
'C'
,
'Y'
,
4,
'N'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(18):=1070632;
RQCFG_100209_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(18):=RQCFG_100209_.tb3_0(18);
RQCFG_100209_.old_tb3_1(18):=2042;
RQCFG_100209_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(18),-1)));
RQCFG_100209_.old_tb3_2(18):=50000936;
RQCFG_100209_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(18),-1)));
RQCFG_100209_.old_tb3_3(18):=null;
RQCFG_100209_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(18),-1)));
RQCFG_100209_.old_tb3_4(18):=null;
RQCFG_100209_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(18),-1)));
RQCFG_100209_.tb3_5(18):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(18):=121048653;
RQCFG_100209_.tb3_6(18):=NULL;
RQCFG_100209_.old_tb3_7(18):=null;
RQCFG_100209_.tb3_7(18):=NULL;
RQCFG_100209_.old_tb3_8(18):=null;
RQCFG_100209_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(18),
RQCFG_100209_.tb3_1(18),
RQCFG_100209_.tb3_2(18),
RQCFG_100209_.tb3_3(18),
RQCFG_100209_.tb3_4(18),
RQCFG_100209_.tb3_5(18),
RQCFG_100209_.tb3_6(18),
RQCFG_100209_.tb3_7(18),
RQCFG_100209_.tb3_8(18),
null,
105018,
5,
'Identificador del Producto'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(18):=1216495;
RQCFG_100209_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(18):=RQCFG_100209_.tb5_0(18);
RQCFG_100209_.old_tb5_1(18):=50000936;
RQCFG_100209_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(18),-1)));
RQCFG_100209_.old_tb5_2(18):=null;
RQCFG_100209_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(18),-1)));
RQCFG_100209_.tb5_3(18):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(18):=RQCFG_100209_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(18),
RQCFG_100209_.tb5_1(18),
RQCFG_100209_.tb5_2(18),
RQCFG_100209_.tb5_3(18),
RQCFG_100209_.tb5_4(18),
'C'
,
'Y'
,
5,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(19):=1070633;
RQCFG_100209_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(19):=RQCFG_100209_.tb3_0(19);
RQCFG_100209_.old_tb3_1(19):=2042;
RQCFG_100209_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(19),-1)));
RQCFG_100209_.old_tb3_2(19):=4013;
RQCFG_100209_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(19),-1)));
RQCFG_100209_.old_tb3_3(19):=null;
RQCFG_100209_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(19),-1)));
RQCFG_100209_.old_tb3_4(19):=null;
RQCFG_100209_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(19),-1)));
RQCFG_100209_.tb3_5(19):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(19):=121048654;
RQCFG_100209_.tb3_6(19):=NULL;
RQCFG_100209_.old_tb3_7(19):=null;
RQCFG_100209_.tb3_7(19):=NULL;
RQCFG_100209_.old_tb3_8(19):=null;
RQCFG_100209_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(19),
RQCFG_100209_.tb3_1(19),
RQCFG_100209_.tb3_2(19),
RQCFG_100209_.tb3_3(19),
RQCFG_100209_.tb3_4(19),
RQCFG_100209_.tb3_5(19),
RQCFG_100209_.tb3_6(19),
RQCFG_100209_.tb3_7(19),
RQCFG_100209_.tb3_8(19),
null,
105019,
6,
'N¿mero Servicio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(19):=1216496;
RQCFG_100209_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(19):=RQCFG_100209_.tb5_0(19);
RQCFG_100209_.old_tb5_1(19):=4013;
RQCFG_100209_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(19),-1)));
RQCFG_100209_.old_tb5_2(19):=null;
RQCFG_100209_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(19),-1)));
RQCFG_100209_.tb5_3(19):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(19):=RQCFG_100209_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(19),
RQCFG_100209_.tb5_1(19),
RQCFG_100209_.tb5_2(19),
RQCFG_100209_.tb5_3(19),
RQCFG_100209_.tb5_4(19),
'C'
,
'Y'
,
6,
'N'
,
'N¿mero Servicio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(20):=1070634;
RQCFG_100209_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(20):=RQCFG_100209_.tb3_0(20);
RQCFG_100209_.old_tb3_1(20):=2042;
RQCFG_100209_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(20),-1)));
RQCFG_100209_.old_tb3_2(20):=89620;
RQCFG_100209_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(20),-1)));
RQCFG_100209_.old_tb3_3(20):=null;
RQCFG_100209_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(20),-1)));
RQCFG_100209_.old_tb3_4(20):=null;
RQCFG_100209_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(20),-1)));
RQCFG_100209_.tb3_5(20):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(20):=121048655;
RQCFG_100209_.tb3_6(20):=NULL;
RQCFG_100209_.old_tb3_7(20):=null;
RQCFG_100209_.tb3_7(20):=NULL;
RQCFG_100209_.old_tb3_8(20):=null;
RQCFG_100209_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(20),
RQCFG_100209_.tb3_1(20),
RQCFG_100209_.tb3_2(20),
RQCFG_100209_.tb3_3(20),
RQCFG_100209_.tb3_4(20),
RQCFG_100209_.tb3_5(20),
RQCFG_100209_.tb3_6(20),
RQCFG_100209_.tb3_7(20),
RQCFG_100209_.tb3_8(20),
null,
105020,
7,
'Direcci¿n De Instalaci¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(20):=1216497;
RQCFG_100209_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(20):=RQCFG_100209_.tb5_0(20);
RQCFG_100209_.old_tb5_1(20):=89620;
RQCFG_100209_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(20),-1)));
RQCFG_100209_.old_tb5_2(20):=null;
RQCFG_100209_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(20),-1)));
RQCFG_100209_.tb5_3(20):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(20):=RQCFG_100209_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(20),
RQCFG_100209_.tb5_1(20),
RQCFG_100209_.tb5_2(20),
RQCFG_100209_.tb5_3(20),
RQCFG_100209_.tb5_4(20),
'C'
,
'Y'
,
7,
'N'
,
'Direcci¿n De Instalaci¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(21):=1070635;
RQCFG_100209_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(21):=RQCFG_100209_.tb3_0(21);
RQCFG_100209_.old_tb3_1(21):=2042;
RQCFG_100209_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(21),-1)));
RQCFG_100209_.old_tb3_2(21):=8064;
RQCFG_100209_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(21),-1)));
RQCFG_100209_.old_tb3_3(21):=null;
RQCFG_100209_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(21),-1)));
RQCFG_100209_.old_tb3_4(21):=null;
RQCFG_100209_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(21),-1)));
RQCFG_100209_.tb3_5(21):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(21):=121048656;
RQCFG_100209_.tb3_6(21):=NULL;
RQCFG_100209_.old_tb3_7(21):=null;
RQCFG_100209_.tb3_7(21):=NULL;
RQCFG_100209_.old_tb3_8(21):=null;
RQCFG_100209_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(21),
RQCFG_100209_.tb3_1(21),
RQCFG_100209_.tb3_2(21),
RQCFG_100209_.tb3_3(21),
RQCFG_100209_.tb3_4(21),
RQCFG_100209_.tb3_5(21),
RQCFG_100209_.tb3_6(21),
RQCFG_100209_.tb3_7(21),
RQCFG_100209_.tb3_8(21),
null,
105021,
8,
'Id Del Componente Del Producto'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(21):=1216498;
RQCFG_100209_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(21):=RQCFG_100209_.tb5_0(21);
RQCFG_100209_.old_tb5_1(21):=8064;
RQCFG_100209_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(21),-1)));
RQCFG_100209_.old_tb5_2(21):=null;
RQCFG_100209_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(21),-1)));
RQCFG_100209_.tb5_3(21):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(21):=RQCFG_100209_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(21),
RQCFG_100209_.tb5_1(21),
RQCFG_100209_.tb5_2(21),
RQCFG_100209_.tb5_3(21),
RQCFG_100209_.tb5_4(21),
'C'
,
'Y'
,
8,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(22):=1070636;
RQCFG_100209_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(22):=RQCFG_100209_.tb3_0(22);
RQCFG_100209_.old_tb3_1(22):=2042;
RQCFG_100209_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(22),-1)));
RQCFG_100209_.old_tb3_2(22):=8082;
RQCFG_100209_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(22),-1)));
RQCFG_100209_.old_tb3_3(22):=338;
RQCFG_100209_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(22),-1)));
RQCFG_100209_.old_tb3_4(22):=null;
RQCFG_100209_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(22),-1)));
RQCFG_100209_.tb3_5(22):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(22):=null;
RQCFG_100209_.tb3_6(22):=NULL;
RQCFG_100209_.old_tb3_7(22):=null;
RQCFG_100209_.tb3_7(22):=NULL;
RQCFG_100209_.old_tb3_8(22):=null;
RQCFG_100209_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(22),
RQCFG_100209_.tb3_1(22),
RQCFG_100209_.tb3_2(22),
RQCFG_100209_.tb3_3(22),
RQCFG_100209_.tb3_4(22),
RQCFG_100209_.tb3_5(22),
RQCFG_100209_.tb3_6(22),
RQCFG_100209_.tb3_7(22),
RQCFG_100209_.tb3_8(22),
null,
105049,
9,
'Id Del Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(22):=1216499;
RQCFG_100209_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(22):=RQCFG_100209_.tb5_0(22);
RQCFG_100209_.old_tb5_1(22):=8082;
RQCFG_100209_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(22),-1)));
RQCFG_100209_.old_tb5_2(22):=null;
RQCFG_100209_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(22),-1)));
RQCFG_100209_.tb5_3(22):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(22):=RQCFG_100209_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(22),
RQCFG_100209_.tb5_1(22),
RQCFG_100209_.tb5_2(22),
RQCFG_100209_.tb5_3(22),
RQCFG_100209_.tb5_4(22),
'C'
,
'Y'
,
9,
'N'
,
'Id Del Componente'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(23):=1070637;
RQCFG_100209_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(23):=RQCFG_100209_.tb3_0(23);
RQCFG_100209_.old_tb3_1(23):=2042;
RQCFG_100209_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(23),-1)));
RQCFG_100209_.old_tb3_2(23):=8083;
RQCFG_100209_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(23),-1)));
RQCFG_100209_.old_tb3_3(23):=311;
RQCFG_100209_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(23),-1)));
RQCFG_100209_.old_tb3_4(23):=null;
RQCFG_100209_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(23),-1)));
RQCFG_100209_.tb3_5(23):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(23):=null;
RQCFG_100209_.tb3_6(23):=NULL;
RQCFG_100209_.old_tb3_7(23):=null;
RQCFG_100209_.tb3_7(23):=NULL;
RQCFG_100209_.old_tb3_8(23):=null;
RQCFG_100209_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(23),
RQCFG_100209_.tb3_1(23),
RQCFG_100209_.tb3_2(23),
RQCFG_100209_.tb3_3(23),
RQCFG_100209_.tb3_4(23),
RQCFG_100209_.tb3_5(23),
RQCFG_100209_.tb3_6(23),
RQCFG_100209_.tb3_7(23),
RQCFG_100209_.tb3_8(23),
null,
105050,
10,
'Id Del Tipo De Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(23):=1216500;
RQCFG_100209_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(23):=RQCFG_100209_.tb5_0(23);
RQCFG_100209_.old_tb5_1(23):=8083;
RQCFG_100209_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(23),-1)));
RQCFG_100209_.old_tb5_2(23):=null;
RQCFG_100209_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(23),-1)));
RQCFG_100209_.tb5_3(23):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(23):=RQCFG_100209_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(23),
RQCFG_100209_.tb5_1(23),
RQCFG_100209_.tb5_2(23),
RQCFG_100209_.tb5_3(23),
RQCFG_100209_.tb5_4(23),
'C'
,
'Y'
,
10,
'N'
,
'Id Del Tipo De Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(24):=1070638;
RQCFG_100209_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(24):=RQCFG_100209_.tb3_0(24);
RQCFG_100209_.old_tb3_1(24):=2042;
RQCFG_100209_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(24),-1)));
RQCFG_100209_.old_tb3_2(24):=8084;
RQCFG_100209_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(24),-1)));
RQCFG_100209_.old_tb3_3(24):=258;
RQCFG_100209_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(24),-1)));
RQCFG_100209_.old_tb3_4(24):=null;
RQCFG_100209_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(24),-1)));
RQCFG_100209_.tb3_5(24):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(24):=null;
RQCFG_100209_.tb3_6(24):=NULL;
RQCFG_100209_.old_tb3_7(24):=null;
RQCFG_100209_.tb3_7(24):=NULL;
RQCFG_100209_.old_tb3_8(24):=null;
RQCFG_100209_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(24),
RQCFG_100209_.tb3_1(24),
RQCFG_100209_.tb3_2(24),
RQCFG_100209_.tb3_3(24),
RQCFG_100209_.tb3_4(24),
RQCFG_100209_.tb3_5(24),
RQCFG_100209_.tb3_6(24),
RQCFG_100209_.tb3_7(24),
RQCFG_100209_.tb3_8(24),
null,
105051,
11,
'Fecha De Registro De La Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(24):=1216501;
RQCFG_100209_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(24):=RQCFG_100209_.tb5_0(24);
RQCFG_100209_.old_tb5_1(24):=8084;
RQCFG_100209_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(24),-1)));
RQCFG_100209_.old_tb5_2(24):=null;
RQCFG_100209_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(24),-1)));
RQCFG_100209_.tb5_3(24):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(24):=RQCFG_100209_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(24),
RQCFG_100209_.tb5_1(24),
RQCFG_100209_.tb5_2(24),
RQCFG_100209_.tb5_3(24),
RQCFG_100209_.tb5_4(24),
'C'
,
'Y'
,
11,
'N'
,
'Fecha De Registro De La Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(25):=1070639;
RQCFG_100209_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(25):=RQCFG_100209_.tb3_0(25);
RQCFG_100209_.old_tb3_1(25):=2042;
RQCFG_100209_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(25),-1)));
RQCFG_100209_.old_tb3_2(25):=8085;
RQCFG_100209_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(25),-1)));
RQCFG_100209_.old_tb3_3(25):=null;
RQCFG_100209_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(25),-1)));
RQCFG_100209_.old_tb3_4(25):=null;
RQCFG_100209_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(25),-1)));
RQCFG_100209_.tb3_5(25):=RQCFG_100209_.tb2_2(2);
RQCFG_100209_.old_tb3_6(25):=121048651;
RQCFG_100209_.tb3_6(25):=NULL;
RQCFG_100209_.old_tb3_7(25):=null;
RQCFG_100209_.tb3_7(25):=NULL;
RQCFG_100209_.old_tb3_8(25):=null;
RQCFG_100209_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(25),
RQCFG_100209_.tb3_1(25),
RQCFG_100209_.tb3_2(25),
RQCFG_100209_.tb3_3(25),
RQCFG_100209_.tb3_4(25),
RQCFG_100209_.tb3_5(25),
RQCFG_100209_.tb3_6(25),
RQCFG_100209_.tb3_7(25),
RQCFG_100209_.tb3_8(25),
null,
105055,
12,
'Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(25):=1216502;
RQCFG_100209_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(25):=RQCFG_100209_.tb5_0(25);
RQCFG_100209_.old_tb5_1(25):=8085;
RQCFG_100209_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(25),-1)));
RQCFG_100209_.old_tb5_2(25):=null;
RQCFG_100209_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(25),-1)));
RQCFG_100209_.tb5_3(25):=RQCFG_100209_.tb4_0(1);
RQCFG_100209_.tb5_4(25):=RQCFG_100209_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(25),
RQCFG_100209_.tb5_1(25),
RQCFG_100209_.tb5_2(25),
RQCFG_100209_.tb5_3(25),
RQCFG_100209_.tb5_4(25),
'C'
,
'Y'
,
12,
'N'
,
'Fecha En Que Se Hace Efectiva La Suspensi¿n Del Motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(26):=1070640;
RQCFG_100209_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(26):=RQCFG_100209_.tb3_0(26);
RQCFG_100209_.old_tb3_1(26):=3334;
RQCFG_100209_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(26),-1)));
RQCFG_100209_.old_tb3_2(26):=187;
RQCFG_100209_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(26),-1)));
RQCFG_100209_.old_tb3_3(26):=null;
RQCFG_100209_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(26),-1)));
RQCFG_100209_.old_tb3_4(26):=null;
RQCFG_100209_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(26),-1)));
RQCFG_100209_.tb3_5(26):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(26):=121048641;
RQCFG_100209_.tb3_6(26):=NULL;
RQCFG_100209_.old_tb3_7(26):=null;
RQCFG_100209_.tb3_7(26):=NULL;
RQCFG_100209_.old_tb3_8(26):=null;
RQCFG_100209_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(26),
RQCFG_100209_.tb3_1(26),
RQCFG_100209_.tb3_2(26),
RQCFG_100209_.tb3_3(26),
RQCFG_100209_.tb3_4(26),
RQCFG_100209_.tb3_5(26),
RQCFG_100209_.tb3_6(26),
RQCFG_100209_.tb3_7(26),
RQCFG_100209_.tb3_8(26),
null,
103230,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb4_0(2):=98444;
RQCFG_100209_.tb4_0(2):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100209_.tb4_0(2):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb4_1(2):=RQCFG_100209_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (2)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100209_.tb4_0(2),
RQCFG_100209_.tb4_1(2),
null,
null,
'FRAME-M_INSTALACION_DE_GAS_100239-1026296'
,
2);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(26):=1216503;
RQCFG_100209_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(26):=RQCFG_100209_.tb5_0(26);
RQCFG_100209_.old_tb5_1(26):=187;
RQCFG_100209_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(26),-1)));
RQCFG_100209_.old_tb5_2(26):=null;
RQCFG_100209_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(26),-1)));
RQCFG_100209_.tb5_3(26):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(26):=RQCFG_100209_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(26),
RQCFG_100209_.tb5_1(26),
RQCFG_100209_.tb5_2(26),
RQCFG_100209_.tb5_3(26),
RQCFG_100209_.tb5_4(26),
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(27):=1070641;
RQCFG_100209_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(27):=RQCFG_100209_.tb3_0(27);
RQCFG_100209_.old_tb3_1(27):=3334;
RQCFG_100209_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(27),-1)));
RQCFG_100209_.old_tb3_2(27):=213;
RQCFG_100209_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(27),-1)));
RQCFG_100209_.old_tb3_3(27):=255;
RQCFG_100209_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(27),-1)));
RQCFG_100209_.old_tb3_4(27):=null;
RQCFG_100209_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(27),-1)));
RQCFG_100209_.tb3_5(27):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(27):=null;
RQCFG_100209_.tb3_6(27):=NULL;
RQCFG_100209_.old_tb3_7(27):=null;
RQCFG_100209_.tb3_7(27):=NULL;
RQCFG_100209_.old_tb3_8(27):=null;
RQCFG_100209_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(27),
RQCFG_100209_.tb3_1(27),
RQCFG_100209_.tb3_2(27),
RQCFG_100209_.tb3_3(27),
RQCFG_100209_.tb3_4(27),
RQCFG_100209_.tb3_5(27),
RQCFG_100209_.tb3_6(27),
RQCFG_100209_.tb3_7(27),
RQCFG_100209_.tb3_8(27),
null,
103231,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(27):=1216504;
RQCFG_100209_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(27):=RQCFG_100209_.tb5_0(27);
RQCFG_100209_.old_tb5_1(27):=213;
RQCFG_100209_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(27),-1)));
RQCFG_100209_.old_tb5_2(27):=null;
RQCFG_100209_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(27),-1)));
RQCFG_100209_.tb5_3(27):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(27):=RQCFG_100209_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(27),
RQCFG_100209_.tb5_1(27),
RQCFG_100209_.tb5_2(27),
RQCFG_100209_.tb5_3(27),
RQCFG_100209_.tb5_4(27),
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(28):=1070642;
RQCFG_100209_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(28):=RQCFG_100209_.tb3_0(28);
RQCFG_100209_.old_tb3_1(28):=3334;
RQCFG_100209_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(28),-1)));
RQCFG_100209_.old_tb3_2(28):=413;
RQCFG_100209_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(28),-1)));
RQCFG_100209_.old_tb3_3(28):=null;
RQCFG_100209_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(28),-1)));
RQCFG_100209_.old_tb3_4(28):=null;
RQCFG_100209_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(28),-1)));
RQCFG_100209_.tb3_5(28):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(28):=121048642;
RQCFG_100209_.tb3_6(28):=NULL;
RQCFG_100209_.old_tb3_7(28):=null;
RQCFG_100209_.tb3_7(28):=NULL;
RQCFG_100209_.old_tb3_8(28):=null;
RQCFG_100209_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(28),
RQCFG_100209_.tb3_1(28),
RQCFG_100209_.tb3_2(28),
RQCFG_100209_.tb3_3(28),
RQCFG_100209_.tb3_4(28),
RQCFG_100209_.tb3_5(28),
RQCFG_100209_.tb3_6(28),
RQCFG_100209_.tb3_7(28),
RQCFG_100209_.tb3_8(28),
null,
103232,
2,
'Producto'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(28):=1216505;
RQCFG_100209_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(28):=RQCFG_100209_.tb5_0(28);
RQCFG_100209_.old_tb5_1(28):=413;
RQCFG_100209_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(28),-1)));
RQCFG_100209_.old_tb5_2(28):=null;
RQCFG_100209_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(28),-1)));
RQCFG_100209_.tb5_3(28):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(28):=RQCFG_100209_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(28),
RQCFG_100209_.tb5_1(28),
RQCFG_100209_.tb5_2(28),
RQCFG_100209_.tb5_3(28),
RQCFG_100209_.tb5_4(28),
'C'
,
'Y'
,
2,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(29):=1070643;
RQCFG_100209_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(29):=RQCFG_100209_.tb3_0(29);
RQCFG_100209_.old_tb3_1(29):=3334;
RQCFG_100209_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(29),-1)));
RQCFG_100209_.old_tb3_2(29):=192;
RQCFG_100209_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(29),-1)));
RQCFG_100209_.old_tb3_3(29):=null;
RQCFG_100209_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(29),-1)));
RQCFG_100209_.old_tb3_4(29):=null;
RQCFG_100209_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(29),-1)));
RQCFG_100209_.tb3_5(29):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(29):=121048643;
RQCFG_100209_.tb3_6(29):=NULL;
RQCFG_100209_.old_tb3_7(29):=null;
RQCFG_100209_.tb3_7(29):=NULL;
RQCFG_100209_.old_tb3_8(29):=null;
RQCFG_100209_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(29),
RQCFG_100209_.tb3_1(29),
RQCFG_100209_.tb3_2(29),
RQCFG_100209_.tb3_3(29),
RQCFG_100209_.tb3_4(29),
RQCFG_100209_.tb3_5(29),
RQCFG_100209_.tb3_6(29),
RQCFG_100209_.tb3_7(29),
RQCFG_100209_.tb3_8(29),
null,
103233,
3,
'Tipo de producto'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(29):=1216506;
RQCFG_100209_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(29):=RQCFG_100209_.tb5_0(29);
RQCFG_100209_.old_tb5_1(29):=192;
RQCFG_100209_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(29),-1)));
RQCFG_100209_.old_tb5_2(29):=null;
RQCFG_100209_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(29),-1)));
RQCFG_100209_.tb5_3(29):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(29):=RQCFG_100209_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(29),
RQCFG_100209_.tb5_1(29),
RQCFG_100209_.tb5_2(29),
RQCFG_100209_.tb5_3(29),
RQCFG_100209_.tb5_4(29),
'C'
,
'Y'
,
3,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(30):=1070644;
RQCFG_100209_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(30):=RQCFG_100209_.tb3_0(30);
RQCFG_100209_.old_tb3_1(30):=3334;
RQCFG_100209_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(30),-1)));
RQCFG_100209_.old_tb3_2(30):=11403;
RQCFG_100209_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(30),-1)));
RQCFG_100209_.old_tb3_3(30):=null;
RQCFG_100209_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(30),-1)));
RQCFG_100209_.old_tb3_4(30):=null;
RQCFG_100209_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(30),-1)));
RQCFG_100209_.tb3_5(30):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(30):=121048644;
RQCFG_100209_.tb3_6(30):=NULL;
RQCFG_100209_.old_tb3_7(30):=null;
RQCFG_100209_.tb3_7(30):=NULL;
RQCFG_100209_.old_tb3_8(30):=null;
RQCFG_100209_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(30),
RQCFG_100209_.tb3_1(30),
RQCFG_100209_.tb3_2(30),
RQCFG_100209_.tb3_3(30),
RQCFG_100209_.tb3_4(30),
RQCFG_100209_.tb3_5(30),
RQCFG_100209_.tb3_6(30),
RQCFG_100209_.tb3_7(30),
RQCFG_100209_.tb3_8(30),
null,
103235,
4,
'Contrato'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(30):=1216507;
RQCFG_100209_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(30):=RQCFG_100209_.tb5_0(30);
RQCFG_100209_.old_tb5_1(30):=11403;
RQCFG_100209_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(30),-1)));
RQCFG_100209_.old_tb5_2(30):=null;
RQCFG_100209_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(30),-1)));
RQCFG_100209_.tb5_3(30):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(30):=RQCFG_100209_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(30),
RQCFG_100209_.tb5_1(30),
RQCFG_100209_.tb5_2(30),
RQCFG_100209_.tb5_3(30),
RQCFG_100209_.tb5_4(30),
'C'
,
'Y'
,
4,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(31):=1070645;
RQCFG_100209_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(31):=RQCFG_100209_.tb3_0(31);
RQCFG_100209_.old_tb3_1(31):=3334;
RQCFG_100209_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(31),-1)));
RQCFG_100209_.old_tb3_2(31):=144514;
RQCFG_100209_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(31),-1)));
RQCFG_100209_.old_tb3_3(31):=null;
RQCFG_100209_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(31),-1)));
RQCFG_100209_.old_tb3_4(31):=null;
RQCFG_100209_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(31),-1)));
RQCFG_100209_.tb3_5(31):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(31):=null;
RQCFG_100209_.tb3_6(31):=NULL;
RQCFG_100209_.old_tb3_7(31):=null;
RQCFG_100209_.tb3_7(31):=NULL;
RQCFG_100209_.old_tb3_8(31):=120023598;
RQCFG_100209_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(31),
RQCFG_100209_.tb3_1(31),
RQCFG_100209_.tb3_2(31),
RQCFG_100209_.tb3_3(31),
RQCFG_100209_.tb3_4(31),
RQCFG_100209_.tb3_5(31),
RQCFG_100209_.tb3_6(31),
RQCFG_100209_.tb3_7(31),
RQCFG_100209_.tb3_8(31),
null,
103236,
5,
'Causal'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(31):=1216508;
RQCFG_100209_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(31):=RQCFG_100209_.tb5_0(31);
RQCFG_100209_.old_tb5_1(31):=144514;
RQCFG_100209_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(31),-1)));
RQCFG_100209_.old_tb5_2(31):=null;
RQCFG_100209_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(31),-1)));
RQCFG_100209_.tb5_3(31):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(31):=RQCFG_100209_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(31),
RQCFG_100209_.tb5_1(31),
RQCFG_100209_.tb5_2(31),
RQCFG_100209_.tb5_3(31),
RQCFG_100209_.tb5_4(31),
'Y'
,
'Y'
,
5,
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
4,
null,
null,
null);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(32):=1070646;
RQCFG_100209_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(32):=RQCFG_100209_.tb3_0(32);
RQCFG_100209_.old_tb3_1(32):=3334;
RQCFG_100209_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(32),-1)));
RQCFG_100209_.old_tb3_2(32):=144591;
RQCFG_100209_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(32),-1)));
RQCFG_100209_.old_tb3_3(32):=null;
RQCFG_100209_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(32),-1)));
RQCFG_100209_.old_tb3_4(32):=null;
RQCFG_100209_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(32),-1)));
RQCFG_100209_.tb3_5(32):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(32):=null;
RQCFG_100209_.tb3_6(32):=NULL;
RQCFG_100209_.old_tb3_7(32):=null;
RQCFG_100209_.tb3_7(32):=NULL;
RQCFG_100209_.old_tb3_8(32):=120023599;
RQCFG_100209_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(32),
RQCFG_100209_.tb3_1(32),
RQCFG_100209_.tb3_2(32),
RQCFG_100209_.tb3_3(32),
RQCFG_100209_.tb3_4(32),
RQCFG_100209_.tb3_5(32),
RQCFG_100209_.tb3_6(32),
RQCFG_100209_.tb3_7(32),
RQCFG_100209_.tb3_8(32),
null,
103237,
6,
'Respuesta De Atención'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(32):=1216509;
RQCFG_100209_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(32):=RQCFG_100209_.tb5_0(32);
RQCFG_100209_.old_tb5_1(32):=144591;
RQCFG_100209_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(32),-1)));
RQCFG_100209_.old_tb5_2(32):=null;
RQCFG_100209_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(32),-1)));
RQCFG_100209_.tb5_3(32):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(32):=RQCFG_100209_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(32),
RQCFG_100209_.tb5_1(32),
RQCFG_100209_.tb5_2(32),
RQCFG_100209_.tb5_3(32),
RQCFG_100209_.tb5_4(32),
'Y'
,
'Y'
,
6,
'N'
,
'Respuesta De Atención'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(33):=1070647;
RQCFG_100209_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(33):=RQCFG_100209_.tb3_0(33);
RQCFG_100209_.old_tb3_1(33):=3334;
RQCFG_100209_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(33),-1)));
RQCFG_100209_.old_tb3_2(33):=309;
RQCFG_100209_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(33),-1)));
RQCFG_100209_.old_tb3_3(33):=187;
RQCFG_100209_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(33),-1)));
RQCFG_100209_.old_tb3_4(33):=null;
RQCFG_100209_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(33),-1)));
RQCFG_100209_.tb3_5(33):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(33):=null;
RQCFG_100209_.tb3_6(33):=NULL;
RQCFG_100209_.old_tb3_7(33):=null;
RQCFG_100209_.tb3_7(33):=NULL;
RQCFG_100209_.old_tb3_8(33):=null;
RQCFG_100209_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(33),
RQCFG_100209_.tb3_1(33),
RQCFG_100209_.tb3_2(33),
RQCFG_100209_.tb3_3(33),
RQCFG_100209_.tb3_4(33),
RQCFG_100209_.tb3_5(33),
RQCFG_100209_.tb3_6(33),
RQCFG_100209_.tb3_7(33),
RQCFG_100209_.tb3_8(33),
null,
103238,
7,
'Consecutivo Interno Motivos'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(33):=1216510;
RQCFG_100209_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(33):=RQCFG_100209_.tb5_0(33);
RQCFG_100209_.old_tb5_1(33):=309;
RQCFG_100209_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(33),-1)));
RQCFG_100209_.old_tb5_2(33):=null;
RQCFG_100209_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(33),-1)));
RQCFG_100209_.tb5_3(33):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(33):=RQCFG_100209_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(33),
RQCFG_100209_.tb5_1(33),
RQCFG_100209_.tb5_2(33),
RQCFG_100209_.tb5_3(33),
RQCFG_100209_.tb5_4(33),
'C'
,
'Y'
,
7,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(34):=1070648;
RQCFG_100209_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(34):=RQCFG_100209_.tb3_0(34);
RQCFG_100209_.old_tb3_1(34):=3334;
RQCFG_100209_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(34),-1)));
RQCFG_100209_.old_tb3_2(34):=311;
RQCFG_100209_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(34),-1)));
RQCFG_100209_.old_tb3_3(34):=1863;
RQCFG_100209_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(34),-1)));
RQCFG_100209_.old_tb3_4(34):=null;
RQCFG_100209_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(34),-1)));
RQCFG_100209_.tb3_5(34):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(34):=null;
RQCFG_100209_.tb3_6(34):=NULL;
RQCFG_100209_.old_tb3_7(34):=null;
RQCFG_100209_.tb3_7(34):=NULL;
RQCFG_100209_.old_tb3_8(34):=null;
RQCFG_100209_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(34),
RQCFG_100209_.tb3_1(34),
RQCFG_100209_.tb3_2(34),
RQCFG_100209_.tb3_3(34),
RQCFG_100209_.tb3_4(34),
RQCFG_100209_.tb3_5(34),
RQCFG_100209_.tb3_6(34),
RQCFG_100209_.tb3_7(34),
RQCFG_100209_.tb3_8(34),
null,
103239,
8,
'Tipo de Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(34):=1216511;
RQCFG_100209_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(34):=RQCFG_100209_.tb5_0(34);
RQCFG_100209_.old_tb5_1(34):=311;
RQCFG_100209_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(34),-1)));
RQCFG_100209_.old_tb5_2(34):=null;
RQCFG_100209_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(34),-1)));
RQCFG_100209_.tb5_3(34):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(34):=RQCFG_100209_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(34),
RQCFG_100209_.tb5_1(34),
RQCFG_100209_.tb5_2(34),
RQCFG_100209_.tb5_3(34),
RQCFG_100209_.tb5_4(34),
'C'
,
'Y'
,
8,
'Y'
,
'Tipo de Suspensi¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(35):=1070649;
RQCFG_100209_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(35):=RQCFG_100209_.tb3_0(35);
RQCFG_100209_.old_tb3_1(35):=3334;
RQCFG_100209_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(35),-1)));
RQCFG_100209_.old_tb3_2(35):=312;
RQCFG_100209_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(35),-1)));
RQCFG_100209_.old_tb3_3(35):=258;
RQCFG_100209_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(35),-1)));
RQCFG_100209_.old_tb3_4(35):=null;
RQCFG_100209_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(35),-1)));
RQCFG_100209_.tb3_5(35):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(35):=null;
RQCFG_100209_.tb3_6(35):=NULL;
RQCFG_100209_.old_tb3_7(35):=null;
RQCFG_100209_.tb3_7(35):=NULL;
RQCFG_100209_.old_tb3_8(35):=null;
RQCFG_100209_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(35),
RQCFG_100209_.tb3_1(35),
RQCFG_100209_.tb3_2(35),
RQCFG_100209_.tb3_3(35),
RQCFG_100209_.tb3_4(35),
RQCFG_100209_.tb3_5(35),
RQCFG_100209_.tb3_6(35),
RQCFG_100209_.tb3_7(35),
RQCFG_100209_.tb3_8(35),
null,
103240,
9,
'Fecha de Registro'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(35):=1216512;
RQCFG_100209_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(35):=RQCFG_100209_.tb5_0(35);
RQCFG_100209_.old_tb5_1(35):=312;
RQCFG_100209_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(35),-1)));
RQCFG_100209_.old_tb5_2(35):=null;
RQCFG_100209_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(35),-1)));
RQCFG_100209_.tb5_3(35):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(35):=RQCFG_100209_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(35),
RQCFG_100209_.tb5_1(35),
RQCFG_100209_.tb5_2(35),
RQCFG_100209_.tb5_3(35),
RQCFG_100209_.tb5_4(35),
'C'
,
'Y'
,
9,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(36):=1070650;
RQCFG_100209_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(36):=RQCFG_100209_.tb3_0(36);
RQCFG_100209_.old_tb3_1(36):=3334;
RQCFG_100209_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(36),-1)));
RQCFG_100209_.old_tb3_2(36):=313;
RQCFG_100209_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(36),-1)));
RQCFG_100209_.old_tb3_3(36):=null;
RQCFG_100209_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(36),-1)));
RQCFG_100209_.old_tb3_4(36):=null;
RQCFG_100209_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(36),-1)));
RQCFG_100209_.tb3_5(36):=RQCFG_100209_.tb2_2(1);
RQCFG_100209_.old_tb3_6(36):=121048640;
RQCFG_100209_.tb3_6(36):=NULL;
RQCFG_100209_.old_tb3_7(36):=null;
RQCFG_100209_.tb3_7(36):=NULL;
RQCFG_100209_.old_tb3_8(36):=null;
RQCFG_100209_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(36),
RQCFG_100209_.tb3_1(36),
RQCFG_100209_.tb3_2(36),
RQCFG_100209_.tb3_3(36),
RQCFG_100209_.tb3_4(36),
RQCFG_100209_.tb3_5(36),
RQCFG_100209_.tb3_6(36),
RQCFG_100209_.tb3_7(36),
RQCFG_100209_.tb3_8(36),
null,
103249,
10,
'Fecha de Aplicaci¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(36):=1216513;
RQCFG_100209_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(36):=RQCFG_100209_.tb5_0(36);
RQCFG_100209_.old_tb5_1(36):=313;
RQCFG_100209_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(36),-1)));
RQCFG_100209_.old_tb5_2(36):=null;
RQCFG_100209_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(36),-1)));
RQCFG_100209_.tb5_3(36):=RQCFG_100209_.tb4_0(2);
RQCFG_100209_.tb5_4(36):=RQCFG_100209_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(36),
RQCFG_100209_.tb5_1(36),
RQCFG_100209_.tb5_2(36),
RQCFG_100209_.tb5_3(36),
RQCFG_100209_.tb5_4(36),
'C'
,
'Y'
,
10,
'N'
,
'Fecha de Aplicaci¿n'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(37):=1070651;
RQCFG_100209_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(37):=RQCFG_100209_.tb3_0(37);
RQCFG_100209_.old_tb3_1(37):=2036;
RQCFG_100209_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(37),-1)));
RQCFG_100209_.old_tb3_2(37):=259;
RQCFG_100209_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(37),-1)));
RQCFG_100209_.old_tb3_3(37):=null;
RQCFG_100209_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(37),-1)));
RQCFG_100209_.old_tb3_4(37):=null;
RQCFG_100209_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(37),-1)));
RQCFG_100209_.tb3_5(37):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(37):=121048630;
RQCFG_100209_.tb3_6(37):=NULL;
RQCFG_100209_.old_tb3_7(37):=null;
RQCFG_100209_.tb3_7(37):=NULL;
RQCFG_100209_.old_tb3_8(37):=null;
RQCFG_100209_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(37),
RQCFG_100209_.tb3_1(37),
RQCFG_100209_.tb3_2(37),
RQCFG_100209_.tb3_3(37),
RQCFG_100209_.tb3_4(37),
RQCFG_100209_.tb3_5(37),
RQCFG_100209_.tb3_6(37),
RQCFG_100209_.tb3_7(37),
RQCFG_100209_.tb3_8(37),
null,
105529,
17,
'Fecha env¿o mensajes'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb4_0(3):=98445;
RQCFG_100209_.tb4_0(3):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100209_.tb4_0(3):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb4_1(3):=RQCFG_100209_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (3)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100209_.tb4_0(3),
RQCFG_100209_.tb4_1(3),
null,
null,
'FRAME-PAQUETE-1026295'
,
1);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(37):=1216514;
RQCFG_100209_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(37):=RQCFG_100209_.tb5_0(37);
RQCFG_100209_.old_tb5_1(37):=259;
RQCFG_100209_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(37),-1)));
RQCFG_100209_.old_tb5_2(37):=null;
RQCFG_100209_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(37),-1)));
RQCFG_100209_.tb5_3(37):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(37):=RQCFG_100209_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(37),
RQCFG_100209_.tb5_1(37),
RQCFG_100209_.tb5_2(37),
RQCFG_100209_.tb5_3(37),
RQCFG_100209_.tb5_4(37),
'C'
,
'Y'
,
17,
'N'
,
'Fecha env¿o mensajes'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(38):=1070652;
RQCFG_100209_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(38):=RQCFG_100209_.tb3_0(38);
RQCFG_100209_.old_tb3_1(38):=2036;
RQCFG_100209_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(38),-1)));
RQCFG_100209_.old_tb3_2(38):=42118;
RQCFG_100209_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(38),-1)));
RQCFG_100209_.old_tb3_3(38):=109479;
RQCFG_100209_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(38),-1)));
RQCFG_100209_.old_tb3_4(38):=null;
RQCFG_100209_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(38),-1)));
RQCFG_100209_.tb3_5(38):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(38):=null;
RQCFG_100209_.tb3_6(38):=NULL;
RQCFG_100209_.old_tb3_7(38):=null;
RQCFG_100209_.tb3_7(38):=NULL;
RQCFG_100209_.old_tb3_8(38):=null;
RQCFG_100209_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(38),
RQCFG_100209_.tb3_1(38),
RQCFG_100209_.tb3_2(38),
RQCFG_100209_.tb3_3(38),
RQCFG_100209_.tb3_4(38),
RQCFG_100209_.tb3_5(38),
RQCFG_100209_.tb3_6(38),
RQCFG_100209_.tb3_7(38),
RQCFG_100209_.tb3_8(38),
null,
105183,
15,
'C¿digo Canal De Ventas'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(38):=1216515;
RQCFG_100209_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(38):=RQCFG_100209_.tb5_0(38);
RQCFG_100209_.old_tb5_1(38):=42118;
RQCFG_100209_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(38),-1)));
RQCFG_100209_.old_tb5_2(38):=null;
RQCFG_100209_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(38),-1)));
RQCFG_100209_.tb5_3(38):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(38):=RQCFG_100209_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(38),
RQCFG_100209_.tb5_1(38),
RQCFG_100209_.tb5_2(38),
RQCFG_100209_.tb5_3(38),
RQCFG_100209_.tb5_4(38),
'C'
,
'Y'
,
15,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(39):=1070653;
RQCFG_100209_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(39):=RQCFG_100209_.tb3_0(39);
RQCFG_100209_.old_tb3_1(39):=2036;
RQCFG_100209_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(39),-1)));
RQCFG_100209_.old_tb3_2(39):=4015;
RQCFG_100209_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(39),-1)));
RQCFG_100209_.old_tb3_3(39):=null;
RQCFG_100209_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(39),-1)));
RQCFG_100209_.old_tb3_4(39):=null;
RQCFG_100209_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(39),-1)));
RQCFG_100209_.tb3_5(39):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(39):=121048629;
RQCFG_100209_.tb3_6(39):=NULL;
RQCFG_100209_.old_tb3_7(39):=null;
RQCFG_100209_.tb3_7(39):=NULL;
RQCFG_100209_.old_tb3_8(39):=null;
RQCFG_100209_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(39),
RQCFG_100209_.tb3_1(39),
RQCFG_100209_.tb3_2(39),
RQCFG_100209_.tb3_3(39),
RQCFG_100209_.tb3_4(39),
RQCFG_100209_.tb3_5(39),
RQCFG_100209_.tb3_6(39),
RQCFG_100209_.tb3_7(39),
RQCFG_100209_.tb3_8(39),
null,
105533,
16,
'Suscriptor'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(39):=1216516;
RQCFG_100209_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(39):=RQCFG_100209_.tb5_0(39);
RQCFG_100209_.old_tb5_1(39):=4015;
RQCFG_100209_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(39),-1)));
RQCFG_100209_.old_tb5_2(39):=null;
RQCFG_100209_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(39),-1)));
RQCFG_100209_.tb5_3(39):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(39):=RQCFG_100209_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(39),
RQCFG_100209_.tb5_1(39),
RQCFG_100209_.tb5_2(39),
RQCFG_100209_.tb5_3(39),
RQCFG_100209_.tb5_4(39),
'C'
,
'Y'
,
16,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(40):=1070654;
RQCFG_100209_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(40):=RQCFG_100209_.tb3_0(40);
RQCFG_100209_.old_tb3_1(40):=2036;
RQCFG_100209_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(40),-1)));
RQCFG_100209_.old_tb3_2(40):=257;
RQCFG_100209_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(40),-1)));
RQCFG_100209_.old_tb3_3(40):=null;
RQCFG_100209_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(40),-1)));
RQCFG_100209_.old_tb3_4(40):=null;
RQCFG_100209_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(40),-1)));
RQCFG_100209_.tb3_5(40):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(40):=121048617;
RQCFG_100209_.tb3_6(40):=NULL;
RQCFG_100209_.old_tb3_7(40):=null;
RQCFG_100209_.tb3_7(40):=NULL;
RQCFG_100209_.old_tb3_8(40):=null;
RQCFG_100209_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(40),
RQCFG_100209_.tb3_1(40),
RQCFG_100209_.tb3_2(40),
RQCFG_100209_.tb3_3(40),
RQCFG_100209_.tb3_4(40),
RQCFG_100209_.tb3_5(40),
RQCFG_100209_.tb3_6(40),
RQCFG_100209_.tb3_7(40),
RQCFG_100209_.tb3_8(40),
null,
105167,
0,
'Interacciones'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(40):=1216517;
RQCFG_100209_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(40):=RQCFG_100209_.tb5_0(40);
RQCFG_100209_.old_tb5_1(40):=257;
RQCFG_100209_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(40),-1)));
RQCFG_100209_.old_tb5_2(40):=null;
RQCFG_100209_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(40),-1)));
RQCFG_100209_.tb5_3(40):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(40):=RQCFG_100209_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(40),
RQCFG_100209_.tb5_1(40),
RQCFG_100209_.tb5_2(40),
RQCFG_100209_.tb5_3(40),
RQCFG_100209_.tb5_4(40),
'Y'
,
'N'
,
0,
'Y'
,
'Interacciones'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(41):=1070655;
RQCFG_100209_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(41):=RQCFG_100209_.tb3_0(41);
RQCFG_100209_.old_tb3_1(41):=2036;
RQCFG_100209_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(41),-1)));
RQCFG_100209_.old_tb3_2(41):=258;
RQCFG_100209_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(41),-1)));
RQCFG_100209_.old_tb3_3(41):=null;
RQCFG_100209_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(41),-1)));
RQCFG_100209_.old_tb3_4(41):=null;
RQCFG_100209_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(41),-1)));
RQCFG_100209_.tb3_5(41):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(41):=121048618;
RQCFG_100209_.tb3_6(41):=NULL;
RQCFG_100209_.old_tb3_7(41):=121048619;
RQCFG_100209_.tb3_7(41):=NULL;
RQCFG_100209_.old_tb3_8(41):=null;
RQCFG_100209_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(41),
RQCFG_100209_.tb3_1(41),
RQCFG_100209_.tb3_2(41),
RQCFG_100209_.tb3_3(41),
RQCFG_100209_.tb3_4(41),
RQCFG_100209_.tb3_5(41),
RQCFG_100209_.tb3_6(41),
RQCFG_100209_.tb3_7(41),
RQCFG_100209_.tb3_8(41),
null,
105168,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(41):=1216518;
RQCFG_100209_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(41):=RQCFG_100209_.tb5_0(41);
RQCFG_100209_.old_tb5_1(41):=258;
RQCFG_100209_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(41),-1)));
RQCFG_100209_.old_tb5_2(41):=null;
RQCFG_100209_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(41),-1)));
RQCFG_100209_.tb5_3(41):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(41):=RQCFG_100209_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(41),
RQCFG_100209_.tb5_1(41),
RQCFG_100209_.tb5_2(41),
RQCFG_100209_.tb5_3(41),
RQCFG_100209_.tb5_4(41),
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(42):=1070656;
RQCFG_100209_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(42):=RQCFG_100209_.tb3_0(42);
RQCFG_100209_.old_tb3_1(42):=2036;
RQCFG_100209_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(42),-1)));
RQCFG_100209_.old_tb3_2(42):=255;
RQCFG_100209_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(42),-1)));
RQCFG_100209_.old_tb3_3(42):=null;
RQCFG_100209_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(42),-1)));
RQCFG_100209_.old_tb3_4(42):=null;
RQCFG_100209_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(42),-1)));
RQCFG_100209_.tb3_5(42):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(42):=null;
RQCFG_100209_.tb3_6(42):=NULL;
RQCFG_100209_.old_tb3_7(42):=null;
RQCFG_100209_.tb3_7(42):=NULL;
RQCFG_100209_.old_tb3_8(42):=null;
RQCFG_100209_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(42),
RQCFG_100209_.tb3_1(42),
RQCFG_100209_.tb3_2(42),
RQCFG_100209_.tb3_3(42),
RQCFG_100209_.tb3_4(42),
RQCFG_100209_.tb3_5(42),
RQCFG_100209_.tb3_6(42),
RQCFG_100209_.tb3_7(42),
RQCFG_100209_.tb3_8(42),
null,
105169,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(42):=1216519;
RQCFG_100209_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(42):=RQCFG_100209_.tb5_0(42);
RQCFG_100209_.old_tb5_1(42):=255;
RQCFG_100209_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(42),-1)));
RQCFG_100209_.old_tb5_2(42):=null;
RQCFG_100209_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(42),-1)));
RQCFG_100209_.tb5_3(42):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(42):=RQCFG_100209_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(42),
RQCFG_100209_.tb5_1(42),
RQCFG_100209_.tb5_2(42),
RQCFG_100209_.tb5_3(42),
RQCFG_100209_.tb5_4(42),
'Y'
,
'N'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(43):=1070657;
RQCFG_100209_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(43):=RQCFG_100209_.tb3_0(43);
RQCFG_100209_.old_tb3_1(43):=2036;
RQCFG_100209_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(43),-1)));
RQCFG_100209_.old_tb3_2(43):=50001162;
RQCFG_100209_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(43),-1)));
RQCFG_100209_.old_tb3_3(43):=null;
RQCFG_100209_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(43),-1)));
RQCFG_100209_.old_tb3_4(43):=null;
RQCFG_100209_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(43),-1)));
RQCFG_100209_.tb3_5(43):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(43):=121048620;
RQCFG_100209_.tb3_6(43):=NULL;
RQCFG_100209_.old_tb3_7(43):=null;
RQCFG_100209_.tb3_7(43):=NULL;
RQCFG_100209_.old_tb3_8(43):=120023593;
RQCFG_100209_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(43),
RQCFG_100209_.tb3_1(43),
RQCFG_100209_.tb3_2(43),
RQCFG_100209_.tb3_3(43),
RQCFG_100209_.tb3_4(43),
RQCFG_100209_.tb3_5(43),
RQCFG_100209_.tb3_6(43),
RQCFG_100209_.tb3_7(43),
RQCFG_100209_.tb3_8(43),
null,
105170,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(43):=1216520;
RQCFG_100209_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(43):=RQCFG_100209_.tb5_0(43);
RQCFG_100209_.old_tb5_1(43):=50001162;
RQCFG_100209_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(43),-1)));
RQCFG_100209_.old_tb5_2(43):=null;
RQCFG_100209_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(43),-1)));
RQCFG_100209_.tb5_3(43):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(43):=RQCFG_100209_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(43),
RQCFG_100209_.tb5_1(43),
RQCFG_100209_.tb5_2(43),
RQCFG_100209_.tb5_3(43),
RQCFG_100209_.tb5_4(43),
'Y'
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
null,
null,
null,
null);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(44):=1070658;
RQCFG_100209_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(44):=RQCFG_100209_.tb3_0(44);
RQCFG_100209_.old_tb3_1(44):=2036;
RQCFG_100209_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(44),-1)));
RQCFG_100209_.old_tb3_2(44):=109479;
RQCFG_100209_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(44),-1)));
RQCFG_100209_.old_tb3_3(44):=null;
RQCFG_100209_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(44),-1)));
RQCFG_100209_.old_tb3_4(44):=null;
RQCFG_100209_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(44),-1)));
RQCFG_100209_.tb3_5(44):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(44):=121048621;
RQCFG_100209_.tb3_6(44):=NULL;
RQCFG_100209_.old_tb3_7(44):=null;
RQCFG_100209_.tb3_7(44):=NULL;
RQCFG_100209_.old_tb3_8(44):=120023594;
RQCFG_100209_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(44),
RQCFG_100209_.tb3_1(44),
RQCFG_100209_.tb3_2(44),
RQCFG_100209_.tb3_3(44),
RQCFG_100209_.tb3_4(44),
RQCFG_100209_.tb3_5(44),
RQCFG_100209_.tb3_6(44),
RQCFG_100209_.tb3_7(44),
RQCFG_100209_.tb3_8(44),
null,
105171,
4,
'Punto de Atención'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(44):=1216521;
RQCFG_100209_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(44):=RQCFG_100209_.tb5_0(44);
RQCFG_100209_.old_tb5_1(44):=109479;
RQCFG_100209_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(44),-1)));
RQCFG_100209_.old_tb5_2(44):=null;
RQCFG_100209_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(44),-1)));
RQCFG_100209_.tb5_3(44):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(44):=RQCFG_100209_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(44),
RQCFG_100209_.tb5_1(44),
RQCFG_100209_.tb5_2(44),
RQCFG_100209_.tb5_3(44),
RQCFG_100209_.tb5_4(44),
'Y'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(45):=1070659;
RQCFG_100209_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(45):=RQCFG_100209_.tb3_0(45);
RQCFG_100209_.old_tb3_1(45):=2036;
RQCFG_100209_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(45),-1)));
RQCFG_100209_.old_tb3_2(45):=2683;
RQCFG_100209_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(45),-1)));
RQCFG_100209_.old_tb3_3(45):=null;
RQCFG_100209_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(45),-1)));
RQCFG_100209_.old_tb3_4(45):=null;
RQCFG_100209_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(45),-1)));
RQCFG_100209_.tb3_5(45):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(45):=121048622;
RQCFG_100209_.tb3_6(45):=NULL;
RQCFG_100209_.old_tb3_7(45):=null;
RQCFG_100209_.tb3_7(45):=NULL;
RQCFG_100209_.old_tb3_8(45):=120023595;
RQCFG_100209_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(45),
RQCFG_100209_.tb3_1(45),
RQCFG_100209_.tb3_2(45),
RQCFG_100209_.tb3_3(45),
RQCFG_100209_.tb3_4(45),
RQCFG_100209_.tb3_5(45),
RQCFG_100209_.tb3_6(45),
RQCFG_100209_.tb3_7(45),
RQCFG_100209_.tb3_8(45),
null,
105172,
5,
'Medio de Recepción'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(45):=1216522;
RQCFG_100209_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(45):=RQCFG_100209_.tb5_0(45);
RQCFG_100209_.old_tb5_1(45):=2683;
RQCFG_100209_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(45),-1)));
RQCFG_100209_.old_tb5_2(45):=null;
RQCFG_100209_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(45),-1)));
RQCFG_100209_.tb5_3(45):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(45):=RQCFG_100209_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(45),
RQCFG_100209_.tb5_1(45),
RQCFG_100209_.tb5_2(45),
RQCFG_100209_.tb5_3(45),
RQCFG_100209_.tb5_4(45),
'Y'
,
'Y'
,
5,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(46):=1070660;
RQCFG_100209_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(46):=RQCFG_100209_.tb3_0(46);
RQCFG_100209_.old_tb3_1(46):=2036;
RQCFG_100209_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(46),-1)));
RQCFG_100209_.old_tb3_2(46):=146755;
RQCFG_100209_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(46),-1)));
RQCFG_100209_.old_tb3_3(46):=null;
RQCFG_100209_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(46),-1)));
RQCFG_100209_.old_tb3_4(46):=null;
RQCFG_100209_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(46),-1)));
RQCFG_100209_.tb3_5(46):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(46):=121048623;
RQCFG_100209_.tb3_6(46):=NULL;
RQCFG_100209_.old_tb3_7(46):=null;
RQCFG_100209_.tb3_7(46):=NULL;
RQCFG_100209_.old_tb3_8(46):=null;
RQCFG_100209_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(46),
RQCFG_100209_.tb3_1(46),
RQCFG_100209_.tb3_2(46),
RQCFG_100209_.tb3_3(46),
RQCFG_100209_.tb3_4(46),
RQCFG_100209_.tb3_5(46),
RQCFG_100209_.tb3_6(46),
RQCFG_100209_.tb3_7(46),
RQCFG_100209_.tb3_8(46),
null,
105173,
6,
'Información del Solicitante'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(46):=1216523;
RQCFG_100209_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(46):=RQCFG_100209_.tb5_0(46);
RQCFG_100209_.old_tb5_1(46):=146755;
RQCFG_100209_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(46),-1)));
RQCFG_100209_.old_tb5_2(46):=null;
RQCFG_100209_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(46),-1)));
RQCFG_100209_.tb5_3(46):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(46):=RQCFG_100209_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(46),
RQCFG_100209_.tb5_1(46),
RQCFG_100209_.tb5_2(46),
RQCFG_100209_.tb5_3(46),
RQCFG_100209_.tb5_4(46),
'Y'
,
'E'
,
6,
'N'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(47):=1070661;
RQCFG_100209_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(47):=RQCFG_100209_.tb3_0(47);
RQCFG_100209_.old_tb3_1(47):=2036;
RQCFG_100209_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(47),-1)));
RQCFG_100209_.old_tb3_2(47):=146756;
RQCFG_100209_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(47),-1)));
RQCFG_100209_.old_tb3_3(47):=null;
RQCFG_100209_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(47),-1)));
RQCFG_100209_.old_tb3_4(47):=null;
RQCFG_100209_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(47),-1)));
RQCFG_100209_.tb3_5(47):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(47):=121048624;
RQCFG_100209_.tb3_6(47):=NULL;
RQCFG_100209_.old_tb3_7(47):=null;
RQCFG_100209_.tb3_7(47):=NULL;
RQCFG_100209_.old_tb3_8(47):=null;
RQCFG_100209_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(47),
RQCFG_100209_.tb3_1(47),
RQCFG_100209_.tb3_2(47),
RQCFG_100209_.tb3_3(47),
RQCFG_100209_.tb3_4(47),
RQCFG_100209_.tb3_5(47),
RQCFG_100209_.tb3_6(47),
RQCFG_100209_.tb3_7(47),
RQCFG_100209_.tb3_8(47),
null,
105174,
7,
'Dirección De Respuesta'
,
'N'
,
'Y'
,
'N'
,
7,
null,
null);

exception when others then
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(47):=1216524;
RQCFG_100209_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(47):=RQCFG_100209_.tb5_0(47);
RQCFG_100209_.old_tb5_1(47):=146756;
RQCFG_100209_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(47),-1)));
RQCFG_100209_.old_tb5_2(47):=null;
RQCFG_100209_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(47),-1)));
RQCFG_100209_.tb5_3(47):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(47):=RQCFG_100209_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(47),
RQCFG_100209_.tb5_1(47),
RQCFG_100209_.tb5_2(47),
RQCFG_100209_.tb5_3(47),
RQCFG_100209_.tb5_4(47),
'Y'
,
'E'
,
7,
'N'
,
'Dirección De Respuesta'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(48):=1070662;
RQCFG_100209_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(48):=RQCFG_100209_.tb3_0(48);
RQCFG_100209_.old_tb3_1(48):=2036;
RQCFG_100209_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(48),-1)));
RQCFG_100209_.old_tb3_2(48):=146754;
RQCFG_100209_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(48),-1)));
RQCFG_100209_.old_tb3_3(48):=null;
RQCFG_100209_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(48),-1)));
RQCFG_100209_.old_tb3_4(48):=null;
RQCFG_100209_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(48),-1)));
RQCFG_100209_.tb3_5(48):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(48):=null;
RQCFG_100209_.tb3_6(48):=NULL;
RQCFG_100209_.old_tb3_7(48):=null;
RQCFG_100209_.tb3_7(48):=NULL;
RQCFG_100209_.old_tb3_8(48):=null;
RQCFG_100209_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(48),
RQCFG_100209_.tb3_1(48),
RQCFG_100209_.tb3_2(48),
RQCFG_100209_.tb3_3(48),
RQCFG_100209_.tb3_4(48),
RQCFG_100209_.tb3_5(48),
RQCFG_100209_.tb3_6(48),
RQCFG_100209_.tb3_7(48),
RQCFG_100209_.tb3_8(48),
null,
105175,
8,
'Observaciones'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(48):=1216525;
RQCFG_100209_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(48):=RQCFG_100209_.tb5_0(48);
RQCFG_100209_.old_tb5_1(48):=146754;
RQCFG_100209_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(48),-1)));
RQCFG_100209_.old_tb5_2(48):=null;
RQCFG_100209_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(48),-1)));
RQCFG_100209_.tb5_3(48):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(48):=RQCFG_100209_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(48),
RQCFG_100209_.tb5_1(48),
RQCFG_100209_.tb5_2(48),
RQCFG_100209_.tb5_3(48),
RQCFG_100209_.tb5_4(48),
'Y'
,
'Y'
,
8,
'Y'
,
'Observaciones'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(49):=1070663;
RQCFG_100209_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(49):=RQCFG_100209_.tb3_0(49);
RQCFG_100209_.old_tb3_1(49):=2036;
RQCFG_100209_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(49),-1)));
RQCFG_100209_.old_tb3_2(49):=1863;
RQCFG_100209_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(49),-1)));
RQCFG_100209_.old_tb3_3(49):=null;
RQCFG_100209_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(49),-1)));
RQCFG_100209_.old_tb3_4(49):=null;
RQCFG_100209_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(49),-1)));
RQCFG_100209_.tb3_5(49):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(49):=121048625;
RQCFG_100209_.tb3_6(49):=NULL;
RQCFG_100209_.old_tb3_7(49):=null;
RQCFG_100209_.tb3_7(49):=NULL;
RQCFG_100209_.old_tb3_8(49):=120023596;
RQCFG_100209_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(49),
RQCFG_100209_.tb3_1(49),
RQCFG_100209_.tb3_2(49),
RQCFG_100209_.tb3_3(49),
RQCFG_100209_.tb3_4(49),
RQCFG_100209_.tb3_5(49),
RQCFG_100209_.tb3_6(49),
RQCFG_100209_.tb3_7(49),
RQCFG_100209_.tb3_8(49),
null,
105176,
9,
'Tipo de Suspensión'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(49):=1216526;
RQCFG_100209_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(49):=RQCFG_100209_.tb5_0(49);
RQCFG_100209_.old_tb5_1(49):=1863;
RQCFG_100209_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(49),-1)));
RQCFG_100209_.old_tb5_2(49):=null;
RQCFG_100209_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(49),-1)));
RQCFG_100209_.tb5_3(49):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(49):=RQCFG_100209_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(49),
RQCFG_100209_.tb5_1(49),
RQCFG_100209_.tb5_2(49),
RQCFG_100209_.tb5_3(49),
RQCFG_100209_.tb5_4(49),
'Y'
,
'N'
,
9,
'Y'
,
'Tipo de Suspensión'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(50):=1070664;
RQCFG_100209_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(50):=RQCFG_100209_.tb3_0(50);
RQCFG_100209_.old_tb3_1(50):=2036;
RQCFG_100209_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(50),-1)));
RQCFG_100209_.old_tb3_2(50):=6732;
RQCFG_100209_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(50),-1)));
RQCFG_100209_.old_tb3_3(50):=null;
RQCFG_100209_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(50),-1)));
RQCFG_100209_.old_tb3_4(50):=null;
RQCFG_100209_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(50),-1)));
RQCFG_100209_.tb3_5(50):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(50):=121048626;
RQCFG_100209_.tb3_6(50):=NULL;
RQCFG_100209_.old_tb3_7(50):=null;
RQCFG_100209_.tb3_7(50):=NULL;
RQCFG_100209_.old_tb3_8(50):=null;
RQCFG_100209_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(50),
RQCFG_100209_.tb3_1(50),
RQCFG_100209_.tb3_2(50),
RQCFG_100209_.tb3_3(50),
RQCFG_100209_.tb3_4(50),
RQCFG_100209_.tb3_5(50),
RQCFG_100209_.tb3_6(50),
RQCFG_100209_.tb3_7(50),
RQCFG_100209_.tb3_8(50),
null,
105177,
14,
'Actualización de Datos'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(50):=1216527;
RQCFG_100209_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(50):=RQCFG_100209_.tb5_0(50);
RQCFG_100209_.old_tb5_1(50):=6732;
RQCFG_100209_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(50),-1)));
RQCFG_100209_.old_tb5_2(50):=null;
RQCFG_100209_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(50),-1)));
RQCFG_100209_.tb5_3(50):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(50):=RQCFG_100209_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(50),
RQCFG_100209_.tb5_1(50),
RQCFG_100209_.tb5_2(50),
RQCFG_100209_.tb5_3(50),
RQCFG_100209_.tb5_4(50),
'Y'
,
'Y'
,
14,
'N'
,
'Actualización de Datos'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(51):=1070665;
RQCFG_100209_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(51):=RQCFG_100209_.tb3_0(51);
RQCFG_100209_.old_tb3_1(51):=2036;
RQCFG_100209_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(51),-1)));
RQCFG_100209_.old_tb3_2(51):=50000603;
RQCFG_100209_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(51),-1)));
RQCFG_100209_.old_tb3_3(51):=null;
RQCFG_100209_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(51),-1)));
RQCFG_100209_.old_tb3_4(51):=null;
RQCFG_100209_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(51),-1)));
RQCFG_100209_.tb3_5(51):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(51):=121048627;
RQCFG_100209_.tb3_6(51):=NULL;
RQCFG_100209_.old_tb3_7(51):=null;
RQCFG_100209_.tb3_7(51):=NULL;
RQCFG_100209_.old_tb3_8(51):=null;
RQCFG_100209_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(51),
RQCFG_100209_.tb3_1(51),
RQCFG_100209_.tb3_2(51),
RQCFG_100209_.tb3_3(51),
RQCFG_100209_.tb3_4(51),
RQCFG_100209_.tb3_5(51),
RQCFG_100209_.tb3_6(51),
RQCFG_100209_.tb3_7(51),
RQCFG_100209_.tb3_8(51),
null,
105179,
11,
'Identificador de suscriptor por motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(51):=1216528;
RQCFG_100209_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(51):=RQCFG_100209_.tb5_0(51);
RQCFG_100209_.old_tb5_1(51):=50000603;
RQCFG_100209_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(51),-1)));
RQCFG_100209_.old_tb5_2(51):=null;
RQCFG_100209_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(51),-1)));
RQCFG_100209_.tb5_3(51):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(51):=RQCFG_100209_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(51),
RQCFG_100209_.tb5_1(51),
RQCFG_100209_.tb5_2(51),
RQCFG_100209_.tb5_3(51),
RQCFG_100209_.tb5_4(51),
'C'
,
'Y'
,
11,
'Y'
,
'Identificador de suscriptor por motivo'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(52):=1070666;
RQCFG_100209_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(52):=RQCFG_100209_.tb3_0(52);
RQCFG_100209_.old_tb3_1(52):=2036;
RQCFG_100209_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(52),-1)));
RQCFG_100209_.old_tb3_2(52):=149340;
RQCFG_100209_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(52),-1)));
RQCFG_100209_.old_tb3_3(52):=null;
RQCFG_100209_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(52),-1)));
RQCFG_100209_.old_tb3_4(52):=null;
RQCFG_100209_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(52),-1)));
RQCFG_100209_.tb3_5(52):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(52):=null;
RQCFG_100209_.tb3_6(52):=NULL;
RQCFG_100209_.old_tb3_7(52):=null;
RQCFG_100209_.tb3_7(52):=NULL;
RQCFG_100209_.old_tb3_8(52):=120023597;
RQCFG_100209_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(52),
RQCFG_100209_.tb3_1(52),
RQCFG_100209_.tb3_2(52),
RQCFG_100209_.tb3_3(52),
RQCFG_100209_.tb3_4(52),
RQCFG_100209_.tb3_5(52),
RQCFG_100209_.tb3_6(52),
RQCFG_100209_.tb3_7(52),
RQCFG_100209_.tb3_8(52),
null,
105180,
13,
'Relación del Solicitante con el Predio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(52):=1216529;
RQCFG_100209_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(52):=RQCFG_100209_.tb5_0(52);
RQCFG_100209_.old_tb5_1(52):=149340;
RQCFG_100209_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(52),-1)));
RQCFG_100209_.old_tb5_2(52):=null;
RQCFG_100209_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(52),-1)));
RQCFG_100209_.tb5_3(52):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(52):=RQCFG_100209_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(52),
RQCFG_100209_.tb5_1(52),
RQCFG_100209_.tb5_2(52),
RQCFG_100209_.tb5_3(52),
RQCFG_100209_.tb5_4(52),
'Y'
,
'Y'
,
13,
'N'
,
'Relación del Solicitante con el Predio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(53):=1070667;
RQCFG_100209_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(53):=RQCFG_100209_.tb3_0(53);
RQCFG_100209_.old_tb3_1(53):=2036;
RQCFG_100209_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(53),-1)));
RQCFG_100209_.old_tb3_2(53):=50000606;
RQCFG_100209_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(53),-1)));
RQCFG_100209_.old_tb3_3(53):=null;
RQCFG_100209_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(53),-1)));
RQCFG_100209_.old_tb3_4(53):=null;
RQCFG_100209_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(53),-1)));
RQCFG_100209_.tb3_5(53):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(53):=121048628;
RQCFG_100209_.tb3_6(53):=NULL;
RQCFG_100209_.old_tb3_7(53):=null;
RQCFG_100209_.tb3_7(53):=NULL;
RQCFG_100209_.old_tb3_8(53):=null;
RQCFG_100209_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(53),
RQCFG_100209_.tb3_1(53),
RQCFG_100209_.tb3_2(53),
RQCFG_100209_.tb3_3(53),
RQCFG_100209_.tb3_4(53),
RQCFG_100209_.tb3_5(53),
RQCFG_100209_.tb3_6(53),
RQCFG_100209_.tb3_7(53),
RQCFG_100209_.tb3_8(53),
null,
105181,
12,
'Usuario del Servicio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(53):=1216530;
RQCFG_100209_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(53):=RQCFG_100209_.tb5_0(53);
RQCFG_100209_.old_tb5_1(53):=50000606;
RQCFG_100209_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(53),-1)));
RQCFG_100209_.old_tb5_2(53):=null;
RQCFG_100209_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(53),-1)));
RQCFG_100209_.tb5_3(53):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(53):=RQCFG_100209_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(53),
RQCFG_100209_.tb5_1(53),
RQCFG_100209_.tb5_2(53),
RQCFG_100209_.tb5_3(53),
RQCFG_100209_.tb5_4(53),
'C'
,
'Y'
,
12,
'N'
,
'Usuario del Servicio'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb3_0(54):=1070668;
RQCFG_100209_.tb3_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100209_.tb3_0(54):=RQCFG_100209_.tb3_0(54);
RQCFG_100209_.old_tb3_1(54):=2036;
RQCFG_100209_.tb3_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100209_.TBENTITYNAME(NVL(RQCFG_100209_.old_tb3_1(54),-1)));
RQCFG_100209_.old_tb3_2(54):=39387;
RQCFG_100209_.tb3_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_2(54),-1)));
RQCFG_100209_.old_tb3_3(54):=255;
RQCFG_100209_.tb3_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_3(54),-1)));
RQCFG_100209_.old_tb3_4(54):=null;
RQCFG_100209_.tb3_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb3_4(54),-1)));
RQCFG_100209_.tb3_5(54):=RQCFG_100209_.tb2_2(0);
RQCFG_100209_.old_tb3_6(54):=null;
RQCFG_100209_.tb3_6(54):=NULL;
RQCFG_100209_.old_tb3_7(54):=null;
RQCFG_100209_.tb3_7(54):=NULL;
RQCFG_100209_.old_tb3_8(54):=null;
RQCFG_100209_.tb3_8(54):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100209_.tb3_0(54),
RQCFG_100209_.tb3_1(54),
RQCFG_100209_.tb3_2(54),
RQCFG_100209_.tb3_3(54),
RQCFG_100209_.tb3_4(54),
RQCFG_100209_.tb3_5(54),
RQCFG_100209_.tb3_6(54),
RQCFG_100209_.tb3_7(54),
RQCFG_100209_.tb3_8(54),
null,
105182,
10,
'Identificador De Solicitud'
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100209_.blProcessStatus) then
 return;
end if;

RQCFG_100209_.old_tb5_0(54):=1216531;
RQCFG_100209_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100209_.tb5_0(54):=RQCFG_100209_.tb5_0(54);
RQCFG_100209_.old_tb5_1(54):=39387;
RQCFG_100209_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_1(54),-1)));
RQCFG_100209_.old_tb5_2(54):=null;
RQCFG_100209_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100209_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100209_.old_tb5_2(54),-1)));
RQCFG_100209_.tb5_3(54):=RQCFG_100209_.tb4_0(3);
RQCFG_100209_.tb5_4(54):=RQCFG_100209_.tb3_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100209_.tb5_0(54),
RQCFG_100209_.tb5_1(54),
RQCFG_100209_.tb5_2(54),
RQCFG_100209_.tb5_3(54),
RQCFG_100209_.tb5_4(54),
'C'
,
'Y'
,
10,
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
RQCFG_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100209);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100209)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100209_.blProcessStatus) then
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
AND     external_root_id = 100209
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
AND     external_root_id = 100209
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
AND     external_root_id = 100209
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100209, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100209)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100209, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100209)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100209, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100209)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100209, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100209)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100209_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100209_.tbCompositions.FIRST..RQCFG_100209_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100209_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100209_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100209_.blProcessStatus := false;
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
 nuIndex := RQCFG_100209_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100209_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100209_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100209_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100209_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100209_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100209_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100209_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100209_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100209_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100209_',
'CREATE OR REPLACE PACKAGE I18N_R_100209_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100209_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100209_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100209
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
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
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(3):='C_GAS_10307'
;
I18N_R_100209_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(3),
I18N_R_100209_.tb0_1(3),
'WE8ISO8859P1'
,
'Gas'
,
'Gas'
,
null,
'Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(4):='C_GAS_10307'
;
I18N_R_100209_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(4),
I18N_R_100209_.tb0_1(4),
'WE8ISO8859P1'
,
'Gas'
,
'Gas'
,
null,
'Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(5):='C_GAS_10307'
;
I18N_R_100209_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(5),
I18N_R_100209_.tb0_1(5),
'WE8ISO8859P1'
,
'Gas'
,
'Gas'
,
null,
'Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(0):='C_MEDICION_10308'
;
I18N_R_100209_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(0),
I18N_R_100209_.tb0_1(0),
'WE8ISO8859P1'
,
'Medici¿n'
,
'Medici¿n'
,
null,
'Medici¿n'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(1):='C_MEDICION_10308'
;
I18N_R_100209_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(1),
I18N_R_100209_.tb0_1(1),
'WE8ISO8859P1'
,
'Medici¿n'
,
'Medici¿n'
,
null,
'Medici¿n'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(2):='C_MEDICION_10308'
;
I18N_R_100209_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(2),
I18N_R_100209_.tb0_1(2),
'WE8ISO8859P1'
,
'Medici¿n'
,
'Medici¿n'
,
null,
'Medici¿n'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(6):='M_INSTALACION_DE_GAS_100239'
;
I18N_R_100209_.tb0_1(6):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(6),
I18N_R_100209_.tb0_1(6),
'WE8ISO8859P1'
,
'Suspensión Voluntaria de Gas'
,
'Suspensión Voluntaria de Gas'
,
null,
'Suspensión Voluntaria de Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(7):='M_INSTALACION_DE_GAS_100239'
;
I18N_R_100209_.tb0_1(7):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (7)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(7),
I18N_R_100209_.tb0_1(7),
'WE8ISO8859P1'
,
'Suspensión Voluntaria de Gas'
,
'Suspensión Voluntaria de Gas'
,
null,
'Suspensión Voluntaria de Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(8):='M_INSTALACION_DE_GAS_100239'
;
I18N_R_100209_.tb0_1(8):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (8)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(8),
I18N_R_100209_.tb0_1(8),
'WE8ISO8859P1'
,
'Suspensión Voluntaria de Gas'
,
'Suspensión Voluntaria de Gas'
,
null,
'Suspensión Voluntaria de Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(9):='PAQUETE'
;
I18N_R_100209_.tb0_1(9):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (9)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(9),
I18N_R_100209_.tb0_1(9),
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
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(10):='PAQUETE'
;
I18N_R_100209_.tb0_1(10):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (10)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(10),
I18N_R_100209_.tb0_1(10),
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
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(11):='PAQUETE'
;
I18N_R_100209_.tb0_1(11):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (11)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(11),
I18N_R_100209_.tb0_1(11),
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
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100209_.blProcessStatus) then
 return;
end if;

I18N_R_100209_.tb0_0(12):='PAQUETE'
;
I18N_R_100209_.tb0_1(12):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (12)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100209_.tb0_0(12),
I18N_R_100209_.tb0_1(12),
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
I18N_R_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100209_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100209_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100209_',
'CREATE OR REPLACE PACKAGE RQEXEC_100209_ IS ' || chr(10) ||
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
'END RQEXEC_100209_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100209_******************************'); END;
/


BEGIN

if (not RQEXEC_100209_.blProcessStatus) then
 return;
end if;

RQEXEC_100209_.old_tb0_0(0):='P_SUSPENSION_VOLUNTARIA_100209'
;
RQEXEC_100209_.tb0_0(0):=UPPER(RQEXEC_100209_.old_tb0_0(0));
RQEXEC_100209_.old_tb0_1(0):=200014;
RQEXEC_100209_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100209_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100209_.tb0_1(0):=RQEXEC_100209_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100209_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100209_.tb0_1(0),
DESCRIPTION='Suspensi¿n Voluntaria'
,
PATH=null,
VERSION='100'
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
TIMES_EXECUTED=778,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=to_date('23-08-2016 11:59:35','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100209_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100209_.tb0_0(0),
RQEXEC_100209_.tb0_1(0),
'Suspensi¿n Voluntaria'
,
null,
'100'
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
778,
'O',
to_date('23-08-2016 11:59:35','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100209_.blProcessStatus) then
 return;
end if;

RQEXEC_100209_.tb1_0(0):=1;
RQEXEC_100209_.tb1_1(0):=RQEXEC_100209_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100209_.tb1_0(0),
RQEXEC_100209_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100209_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100209_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100209_******************************'); end;
/

