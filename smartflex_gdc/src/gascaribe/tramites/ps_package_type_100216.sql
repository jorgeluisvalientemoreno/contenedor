BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100216_',
'CREATE OR REPLACE PACKAGE RQTY_100216_ IS ' || chr(10) ||
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
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100216 ' || chr(10) ||
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
'END RQTY_100216_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100216_******************************'); END;
/

BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
AND     external_root_id = 100216
)
);

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100216_.cuExpressions;
fetch RQTY_100216_.cuExpressions bulk collect INTO RQTY_100216_.tbExpressionsId;
close RQTY_100216_.cuExpressions;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100216_.tbEntityName(-1) := 'NULL';
   RQTY_100216_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100216_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQTY_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100216_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100216_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100216_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100216_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100216
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100216
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100216
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100216
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100216_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100216_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100216_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100216_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100216_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100216_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100216_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216))));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216))));

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100216_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100216_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100216_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100216_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100216_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100216_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100216_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100216_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216)));

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216));
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100216_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216);
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100216_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100216_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100216_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100216_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100216;
nuIndex binary_integer;
BEGIN

if (not RQTY_100216_.blProcessStatus) then
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100216_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100216_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100216_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100216_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100216_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100216_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100216_.tb0_0(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb1_0(0):=1;
RQTY_100216_.tb1_1(0):=RQTY_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100216_.tb1_0(0),
MODULE_ID=RQTY_100216_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100216_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100216_.tb1_0(0),
RQTY_100216_.tb1_1(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(0):=121317867;
RQTY_100216_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(0):=RQTY_100216_.tb2_0(0);
RQTY_100216_.old_tb2_1(0):='GE_EXEACTION_CT1E121317867'
;
RQTY_100216_.tb2_1(0):=RQTY_100216_.tb2_0(0);
RQTY_100216_.tb2_2(0):=RQTY_100216_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(0),
RQTY_100216_.tb2_1(0),
RQTY_100216_.tb2_2(0),
'nuSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();dtRequestDate = CC_BOBOSSUTIL.FDTREQUESTDATE(nuSolicitud);sbSysdate = UT_DATE.FSBSTR_SYSDATE();dtSysdate = UT_CONVERT.FNUCHARTODATE(sbSysdate);dtRequestDate = UT_DATE.FDTTRUNCATEDATE(dtRequestDate);dtSysdate = UT_DATE.FDTTRUNCATEDATE(dtSysdate);nuPackageType = 100216;if (dtRequestDate <> dtSysdate,inuEntityID = 2012;GE_BOALERTMESSAGEPARAM.VERANDSENDNOTIF(inuEntityID,nuPackageType,nuSolicitud,null,osbNotifSends,osbLogNotif);,);nuMotiveId = CF_BOSTATEMENTSWF.FNUGETINITMOTIVE(nuSolicitud);nuAnswerId = MO_BOMOTIVE.FNUGETANSWERID(nuMotiveId);if (nuAnswerId = null,MO_BOATTENTION.ACTCREATEPLANWF();,if (CC_BOANSWER.FNUGETANSWERTYPEID(nuAnswerId) = 40,MO_BODATACHANGE.ProcessMotiveUpdate(nuMotiveId);CF_BOACTIONS.ATTENDREQUEST(nuSolicitud);,CF_BOACTIONS.ATTENDREQUEST(nuSolicitud);););cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", nuSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.FNUCHAR' ||
'TONUMBER(nuSolicitud),cnuTipoFechaPQR,dtFechaSolicitud)'
,
'LBTEST'
,
to_date('27-04-2012 11:39:10','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:46','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'ACCIÓN - Registro de Actualización de Datos de Cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb3_0(0):=8122;
RQTY_100216_.tb3_1(0):=RQTY_100216_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100216_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100216_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='ACCIÓN - Registro de Actualización de Datos de Cliente'
,
EXE_AT_STATUS_CHANGE='Y'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100216_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100216_.tb3_0(0),
RQTY_100216_.tb3_1(0),
5,
'ACCIÓN - Registro de Actualización de Datos de Cliente'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb4_0(0):=RQTY_100216_.tb3_0(0);
RQTY_100216_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100216_.tb4_0(0),
VALID_MODULE_ID=RQTY_100216_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100216_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100216_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100216_.tb4_0(0),
RQTY_100216_.tb4_1(0));
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb4_0(1):=RQTY_100216_.tb3_0(0);
RQTY_100216_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100216_.tb4_0(1),
VALID_MODULE_ID=RQTY_100216_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100216_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100216_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100216_.tb4_0(1),
RQTY_100216_.tb4_1(1));
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb4_0(2):=RQTY_100216_.tb3_0(0);
RQTY_100216_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100216_.tb4_0(2),
VALID_MODULE_ID=RQTY_100216_.tb4_1(2)
 WHERE ACTION_ID = RQTY_100216_.tb4_0(2) AND VALID_MODULE_ID = RQTY_100216_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100216_.tb4_0(2),
RQTY_100216_.tb4_1(2));
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb5_0(0):=100216;
RQTY_100216_.tb5_1(0):=RQTY_100216_.tb3_0(0);
RQTY_100216_.tb5_4(0):='P_ACTUALIZACION_DE_DATOS_DE_CLIENTE_100216'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100216_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100216_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100216_.tb5_4(0),
DESCRIPTION='Corrección Datos del Cliente'
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
 WHERE PACKAGE_TYPE_ID = RQTY_100216_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100216_.tb5_0(0),
RQTY_100216_.tb5_1(0),
null,
null,
RQTY_100216_.tb5_4(0),
'Corrección Datos del Cliente'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100216_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100216_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100216_.tb0_0(1),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb1_0(1):=23;
RQTY_100216_.tb1_1(1):=RQTY_100216_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100216_.tb1_0(1),
MODULE_ID=RQTY_100216_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100216_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100216_.tb1_0(1),
RQTY_100216_.tb1_1(1),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(1):=121317868;
RQTY_100216_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(1):=RQTY_100216_.tb2_0(1);
RQTY_100216_.old_tb2_1(1):='MO_INITATRIB_CT23E121317868'
;
RQTY_100216_.tb2_1(1):=RQTY_100216_.tb2_0(1);
RQTY_100216_.tb2_2(1):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(1),
RQTY_100216_.tb2_1(1),
RQTY_100216_.tb2_2(1),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",nuSubscriberId)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:43','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:46','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - REQUEST_DATE - Inicialización fecha de solicitud con fecha del sistema y carga del cliente a la instancia'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb1_0(2):=26;
RQTY_100216_.tb1_1(2):=RQTY_100216_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100216_.tb1_0(2),
MODULE_ID=RQTY_100216_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100216_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100216_.tb1_0(2),
RQTY_100216_.tb1_1(2),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(2):=121317869;
RQTY_100216_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(2):=RQTY_100216_.tb2_0(2);
RQTY_100216_.old_tb2_1(2):='MO_VALIDATTR_CT26E121317869'
;
RQTY_100216_.tb2_1(2):=RQTY_100216_.tb2_0(2);
RQTY_100216_.tb2_2(2):=RQTY_100216_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(2),
RQTY_100216_.tb2_1(2),
RQTY_100216_.tb2_2(2),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100216;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No está permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,););)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:43','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:46','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PACKAGES - REQUEST_DATE - Validación fecha máxima de días hacía atras en los que se puede registrar la solicitud'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(0):=105296;
RQTY_100216_.tb6_1(0):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(0):=17;
RQTY_100216_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(0),-1)));
RQTY_100216_.old_tb6_3(0):=258;
RQTY_100216_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(0),-1)));
RQTY_100216_.old_tb6_4(0):=null;
RQTY_100216_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(0),-1)));
RQTY_100216_.old_tb6_5(0):=null;
RQTY_100216_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(0),-1)));
RQTY_100216_.tb6_7(0):=RQTY_100216_.tb2_0(1);
RQTY_100216_.tb6_8(0):=RQTY_100216_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(0),
ENTITY_ID=RQTY_100216_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(0),
VALID_EXPRESSION_ID=RQTY_100216_.tb6_8(0),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(0),
RQTY_100216_.tb6_1(0),
RQTY_100216_.tb6_2(0),
RQTY_100216_.tb6_3(0),
RQTY_100216_.tb6_4(0),
RQTY_100216_.tb6_5(0),
null,
RQTY_100216_.tb6_7(0),
RQTY_100216_.tb6_8(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(1):=105297;
RQTY_100216_.tb6_1(1):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(1):=17;
RQTY_100216_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(1),-1)));
RQTY_100216_.old_tb6_3(1):=255;
RQTY_100216_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(1),-1)));
RQTY_100216_.old_tb6_4(1):=null;
RQTY_100216_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(1),-1)));
RQTY_100216_.old_tb6_5(1):=null;
RQTY_100216_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(1),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(1),
ENTITY_ID=RQTY_100216_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(1),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(1),
RQTY_100216_.tb6_1(1),
RQTY_100216_.tb6_2(1),
RQTY_100216_.tb6_3(1),
RQTY_100216_.tb6_4(1),
RQTY_100216_.tb6_5(1),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(3):=121317870;
RQTY_100216_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(3):=RQTY_100216_.tb2_0(3);
RQTY_100216_.old_tb2_1(3):='MO_INITATRIB_CT23E121317870'
;
RQTY_100216_.tb2_1(3):=RQTY_100216_.tb2_0(3);
RQTY_100216_.tb2_2(3):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(3),
RQTY_100216_.tb2_1(3),
RQTY_100216_.tb2_2(3),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('27-04-2012 16:57:44','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb7_0(0):=120163732;
RQTY_100216_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100216_.tb7_0(0):=RQTY_100216_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100216_.tb7_0(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(2):=105298;
RQTY_100216_.tb6_1(2):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(2):=17;
RQTY_100216_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(2),-1)));
RQTY_100216_.old_tb6_3(2):=50001162;
RQTY_100216_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(2),-1)));
RQTY_100216_.old_tb6_4(2):=null;
RQTY_100216_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(2),-1)));
RQTY_100216_.old_tb6_5(2):=null;
RQTY_100216_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(2),-1)));
RQTY_100216_.tb6_6(2):=RQTY_100216_.tb7_0(0);
RQTY_100216_.tb6_7(2):=RQTY_100216_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(2),
ENTITY_ID=RQTY_100216_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(2),
STATEMENT_ID=RQTY_100216_.tb6_6(2),
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(2),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(2),
RQTY_100216_.tb6_1(2),
RQTY_100216_.tb6_2(2),
RQTY_100216_.tb6_3(2),
RQTY_100216_.tb6_4(2),
RQTY_100216_.tb6_5(2),
RQTY_100216_.tb6_6(2),
RQTY_100216_.tb6_7(2),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(4):=121317871;
RQTY_100216_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(4):=RQTY_100216_.tb2_0(4);
RQTY_100216_.old_tb2_1(4):='MO_INITATRIB_CT23E121317871'
;
RQTY_100216_.tb2_1(4):=RQTY_100216_.tb2_0(4);
RQTY_100216_.tb2_2(4):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(4),
RQTY_100216_.tb2_1(4),
RQTY_100216_.tb2_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:44','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - POS_OPER_UNIT_ID - inicialización del punto de atención'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb7_0(1):=120163733;
RQTY_100216_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100216_.tb7_0(1):=RQTY_100216_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100216_.tb7_0(1),
16,
'Lista Puntos de Atención'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')
'
,
'Lista Puntos de Atención'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(3):=105299;
RQTY_100216_.tb6_1(3):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(3):=17;
RQTY_100216_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(3),-1)));
RQTY_100216_.old_tb6_3(3):=109479;
RQTY_100216_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(3),-1)));
RQTY_100216_.old_tb6_4(3):=null;
RQTY_100216_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(3),-1)));
RQTY_100216_.old_tb6_5(3):=null;
RQTY_100216_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(3),-1)));
RQTY_100216_.tb6_6(3):=RQTY_100216_.tb7_0(1);
RQTY_100216_.tb6_7(3):=RQTY_100216_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(3),
ENTITY_ID=RQTY_100216_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(3),
STATEMENT_ID=RQTY_100216_.tb6_6(3),
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(3),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(3),
RQTY_100216_.tb6_1(3),
RQTY_100216_.tb6_2(3),
RQTY_100216_.tb6_3(3),
RQTY_100216_.tb6_4(3),
RQTY_100216_.tb6_5(3),
RQTY_100216_.tb6_6(3),
RQTY_100216_.tb6_7(3),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(5):=121317872;
RQTY_100216_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(5):=RQTY_100216_.tb2_0(5);
RQTY_100216_.old_tb2_1(5):='MO_INITATRIB_CT23E121317872'
;
RQTY_100216_.tb2_1(5):=RQTY_100216_.tb2_0(5);
RQTY_100216_.tb2_2(5):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(5),
RQTY_100216_.tb2_1(5),
RQTY_100216_.tb2_2(5),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:44','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - RECEPTION_TYPE_ID - Inicialización del medio de recepción'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb7_0(2):=120163734;
RQTY_100216_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100216_.tb7_0(2):=RQTY_100216_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100216_.tb7_0(2),
16,
'Listado Medios de Recepción'
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
'Listado Medios de Recepción'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(4):=105300;
RQTY_100216_.tb6_1(4):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(4):=17;
RQTY_100216_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(4),-1)));
RQTY_100216_.old_tb6_3(4):=2683;
RQTY_100216_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(4),-1)));
RQTY_100216_.old_tb6_4(4):=null;
RQTY_100216_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(4),-1)));
RQTY_100216_.old_tb6_5(4):=null;
RQTY_100216_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(4),-1)));
RQTY_100216_.tb6_6(4):=RQTY_100216_.tb7_0(2);
RQTY_100216_.tb6_7(4):=RQTY_100216_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(4),
ENTITY_ID=RQTY_100216_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(4),
STATEMENT_ID=RQTY_100216_.tb6_6(4),
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(4),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(4),
RQTY_100216_.tb6_1(4),
RQTY_100216_.tb6_2(4),
RQTY_100216_.tb6_3(4),
RQTY_100216_.tb6_4(4),
RQTY_100216_.tb6_5(4),
RQTY_100216_.tb6_6(4),
RQTY_100216_.tb6_7(4),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(6):=121317873;
RQTY_100216_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(6):=RQTY_100216_.tb2_0(6);
RQTY_100216_.old_tb2_1(6):='MO_INITATRIB_CT23E121317873'
;
RQTY_100216_.tb2_1(6):=RQTY_100216_.tb2_0(6);
RQTY_100216_.tb2_2(6):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(6),
RQTY_100216_.tb2_1(6),
RQTY_100216_.tb2_2(6),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:45','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - CONTACT_ID - Inicialización del solicitante'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(5):=105301;
RQTY_100216_.tb6_1(5):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(5):=17;
RQTY_100216_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(5),-1)));
RQTY_100216_.old_tb6_3(5):=146755;
RQTY_100216_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(5),-1)));
RQTY_100216_.old_tb6_4(5):=null;
RQTY_100216_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(5),-1)));
RQTY_100216_.old_tb6_5(5):=null;
RQTY_100216_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(5),-1)));
RQTY_100216_.tb6_7(5):=RQTY_100216_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(5),
ENTITY_ID=RQTY_100216_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(5),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(5),
RQTY_100216_.tb6_1(5),
RQTY_100216_.tb6_2(5),
RQTY_100216_.tb6_3(5),
RQTY_100216_.tb6_4(5),
RQTY_100216_.tb6_5(5),
null,
RQTY_100216_.tb6_7(5),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(7):=121317874;
RQTY_100216_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(7):=RQTY_100216_.tb2_0(7);
RQTY_100216_.old_tb2_1(7):='MO_INITATRIB_CT23E121317874'
;
RQTY_100216_.tb2_1(7):=RQTY_100216_.tb2_0(7);
RQTY_100216_.tb2_2(7):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(7),
RQTY_100216_.tb2_1(7),
RQTY_100216_.tb2_2(7),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:45','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - ADDESS_ID - inicialización de la dirección de respuesta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(6):=105302;
RQTY_100216_.tb6_1(6):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(6):=17;
RQTY_100216_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(6),-1)));
RQTY_100216_.old_tb6_3(6):=146756;
RQTY_100216_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(6),-1)));
RQTY_100216_.old_tb6_4(6):=null;
RQTY_100216_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(6),-1)));
RQTY_100216_.old_tb6_5(6):=null;
RQTY_100216_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(6),-1)));
RQTY_100216_.tb6_7(6):=RQTY_100216_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(6),
ENTITY_ID=RQTY_100216_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(6),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(6),
RQTY_100216_.tb6_1(6),
RQTY_100216_.tb6_2(6),
RQTY_100216_.tb6_3(6),
RQTY_100216_.tb6_4(6),
RQTY_100216_.tb6_5(6),
null,
RQTY_100216_.tb6_7(6),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(7):=105303;
RQTY_100216_.tb6_1(7):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(7):=17;
RQTY_100216_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(7),-1)));
RQTY_100216_.old_tb6_3(7):=146754;
RQTY_100216_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(7),-1)));
RQTY_100216_.old_tb6_4(7):=null;
RQTY_100216_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(7),-1)));
RQTY_100216_.old_tb6_5(7):=null;
RQTY_100216_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(7),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(7),
ENTITY_ID=RQTY_100216_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Observación'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(7),
RQTY_100216_.tb6_1(7),
RQTY_100216_.tb6_2(7),
RQTY_100216_.tb6_3(7),
RQTY_100216_.tb6_4(7),
RQTY_100216_.tb6_5(7),
null,
null,
null,
null,
8,
'Observación'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(8):=105304;
RQTY_100216_.tb6_1(8):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(8):=9179;
RQTY_100216_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(8),-1)));
RQTY_100216_.old_tb6_3(8):=39387;
RQTY_100216_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(8),-1)));
RQTY_100216_.old_tb6_4(8):=255;
RQTY_100216_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(8),-1)));
RQTY_100216_.old_tb6_5(8):=null;
RQTY_100216_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(8),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(8),
ENTITY_ID=RQTY_100216_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=9,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(8),
RQTY_100216_.tb6_1(8),
RQTY_100216_.tb6_2(8),
RQTY_100216_.tb6_3(8),
RQTY_100216_.tb6_4(8),
RQTY_100216_.tb6_5(8),
null,
null,
null,
null,
9,
'Identificador De Solicitud'
,
9,
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(8):=121317875;
RQTY_100216_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(8):=RQTY_100216_.tb2_0(8);
RQTY_100216_.old_tb2_1(8):='MO_INITATRIB_CT23E121317875'
;
RQTY_100216_.tb2_1(8):=RQTY_100216_.tb2_0(8);
RQTY_100216_.tb2_2(8):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(8),
RQTY_100216_.tb2_1(8),
RQTY_100216_.tb2_2(8),
'sbSequence = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_SUBS_TYPE_MOTIV", "SEQ_MO_SUBS_TYPE_MOTIV");nuSequence = UT_CONVERT.FNUCHARTONUMBER(sbSequence);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSequence)'
,
'LBTEST'
,
to_date('30-05-2012 11:46:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(9):=105305;
RQTY_100216_.tb6_1(9):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(9):=9179;
RQTY_100216_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(9),-1)));
RQTY_100216_.old_tb6_3(9):=50000603;
RQTY_100216_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(9),-1)));
RQTY_100216_.old_tb6_4(9):=null;
RQTY_100216_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(9),-1)));
RQTY_100216_.old_tb6_5(9):=null;
RQTY_100216_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(9),-1)));
RQTY_100216_.tb6_7(9):=RQTY_100216_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(9),
ENTITY_ID=RQTY_100216_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Identificador de suscriptor por motivo'
,
DISPLAY_ORDER=10,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(9),
RQTY_100216_.tb6_1(9),
RQTY_100216_.tb6_2(9),
RQTY_100216_.tb6_3(9),
RQTY_100216_.tb6_4(9),
RQTY_100216_.tb6_5(9),
null,
RQTY_100216_.tb6_7(9),
null,
null,
10,
'Identificador de suscriptor por motivo'
,
10,
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(10):=105306;
RQTY_100216_.tb6_1(10):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(10):=9179;
RQTY_100216_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(10),-1)));
RQTY_100216_.old_tb6_3(10):=50000606;
RQTY_100216_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(10),-1)));
RQTY_100216_.old_tb6_4(10):=146755;
RQTY_100216_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(10),-1)));
RQTY_100216_.old_tb6_5(10):=null;
RQTY_100216_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(10),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(10),
ENTITY_ID=RQTY_100216_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Usuario del Servicio'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(10),
RQTY_100216_.tb6_1(10),
RQTY_100216_.tb6_2(10),
RQTY_100216_.tb6_3(10),
RQTY_100216_.tb6_4(10),
RQTY_100216_.tb6_5(10),
null,
null,
null,
null,
11,
'Usuario del Servicio'
,
11,
'N'
,
'N'
,
'Y'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb7_0(3):=120163735;
RQTY_100216_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100216_.tb7_0(3):=RQTY_100216_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100216_.tb7_0(3),
16,
'Listado Relación del Solicitante con el Predio'
,
'SELECT ROLE_ID ID, DESCRIPTION FROM cc_role'
,
'Listado Relación del Solicitante con el Predio'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(11):=105307;
RQTY_100216_.tb6_1(11):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(11):=9179;
RQTY_100216_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(11),-1)));
RQTY_100216_.old_tb6_3(11):=149340;
RQTY_100216_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(11),-1)));
RQTY_100216_.old_tb6_4(11):=null;
RQTY_100216_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(11),-1)));
RQTY_100216_.old_tb6_5(11):=null;
RQTY_100216_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(11),-1)));
RQTY_100216_.tb6_6(11):=RQTY_100216_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(11),
ENTITY_ID=RQTY_100216_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(11),
STATEMENT_ID=RQTY_100216_.tb6_6(11),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Relación del Solicitante con el Predio'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(11),
RQTY_100216_.tb6_1(11),
RQTY_100216_.tb6_2(11),
RQTY_100216_.tb6_3(11),
RQTY_100216_.tb6_4(11),
RQTY_100216_.tb6_5(11),
RQTY_100216_.tb6_6(11),
null,
null,
null,
12,
'Relación del Solicitante con el Predio'
,
12,
'Y'
,
'N'
,
'Y'
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
'Y'
);
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(12):=105308;
RQTY_100216_.tb6_1(12):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(12):=17;
RQTY_100216_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(12),-1)));
RQTY_100216_.old_tb6_3(12):=42118;
RQTY_100216_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(12),-1)));
RQTY_100216_.old_tb6_4(12):=109479;
RQTY_100216_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(12),-1)));
RQTY_100216_.old_tb6_5(12):=null;
RQTY_100216_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(12),
ENTITY_ID=RQTY_100216_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Código Canal De Ventas'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(12),
RQTY_100216_.tb6_1(12),
RQTY_100216_.tb6_2(12),
RQTY_100216_.tb6_3(12),
RQTY_100216_.tb6_4(12),
RQTY_100216_.tb6_5(12),
null,
null,
null,
null,
13,
'Código Canal De Ventas'
,
13,
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(9):=121317876;
RQTY_100216_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(9):=RQTY_100216_.tb2_0(9);
RQTY_100216_.old_tb2_1(9):='MO_INITATRIB_CT23E121317876'
;
RQTY_100216_.tb2_1(9):=RQTY_100216_.tb2_0(9);
RQTY_100216_.tb2_2(9):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(9),
RQTY_100216_.tb2_1(9),
RQTY_100216_.tb2_2(9),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FDTSYSDATE())'
,
'LBTEST'
,
to_date('27-04-2012 16:57:46','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - MESSAG_DELIVERY_DATE - Inicialización de la fecha de envío desde atención al cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(13):=105310;
RQTY_100216_.tb6_1(13):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(13):=17;
RQTY_100216_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(13),-1)));
RQTY_100216_.old_tb6_3(13):=259;
RQTY_100216_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(13),-1)));
RQTY_100216_.old_tb6_4(13):=null;
RQTY_100216_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(13),-1)));
RQTY_100216_.old_tb6_5(13):=null;
RQTY_100216_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(13),-1)));
RQTY_100216_.tb6_7(13):=RQTY_100216_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(13),
ENTITY_ID=RQTY_100216_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(13),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Fecha envío mensajes'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='FECHA_ENVIO_MENSAJES'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(13),
RQTY_100216_.tb6_1(13),
RQTY_100216_.tb6_2(13),
RQTY_100216_.tb6_3(13),
RQTY_100216_.tb6_4(13),
RQTY_100216_.tb6_5(13),
null,
RQTY_100216_.tb6_7(13),
null,
null,
14,
'Fecha envío mensajes'
,
14,
'N'
,
'N'
,
'N'
,
'FECHA_ENVIO_MENSAJES'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(10):=121317877;
RQTY_100216_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(10):=RQTY_100216_.tb2_0(10);
RQTY_100216_.old_tb2_1(10):='MO_INITATRIB_CT23E121317877'
;
RQTY_100216_.tb2_1(10):=RQTY_100216_.tb2_0(10);
RQTY_100216_.tb2_2(10):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(10),
RQTY_100216_.tb2_1(10),
RQTY_100216_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbSubscriberId);,)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:46','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - SUBSCRIBER_ID - Inicialización del suscriptor'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(14):=105311;
RQTY_100216_.tb6_1(14):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(14):=17;
RQTY_100216_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(14),-1)));
RQTY_100216_.old_tb6_3(14):=4015;
RQTY_100216_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(14),-1)));
RQTY_100216_.old_tb6_4(14):=null;
RQTY_100216_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(14),-1)));
RQTY_100216_.old_tb6_5(14):=null;
RQTY_100216_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(14),-1)));
RQTY_100216_.tb6_7(14):=RQTY_100216_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(14),
ENTITY_ID=RQTY_100216_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Suscriptor'
,
DISPLAY_ORDER=15,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(14),
RQTY_100216_.tb6_1(14),
RQTY_100216_.tb6_2(14),
RQTY_100216_.tb6_3(14),
RQTY_100216_.tb6_4(14),
RQTY_100216_.tb6_5(14),
null,
RQTY_100216_.tb6_7(14),
null,
null,
15,
'Suscriptor'
,
15,
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(11):=121317878;
RQTY_100216_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(11):=RQTY_100216_.tb2_0(11);
RQTY_100216_.old_tb2_1(11):='MO_INITATRIB_CT23E121317878'
;
RQTY_100216_.tb2_1(11):=RQTY_100216_.tb2_0(11);
RQTY_100216_.tb2_2(11):=RQTY_100216_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(11),
RQTY_100216_.tb2_1(11),
RQTY_100216_.tb2_2(11),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('27-04-2012 16:57:39','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb6_0(15):=105295;
RQTY_100216_.tb6_1(15):=RQTY_100216_.tb5_0(0);
RQTY_100216_.old_tb6_2(15):=17;
RQTY_100216_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100216_.TBENTITYNAME(NVL(RQTY_100216_.old_tb6_2(15),-1)));
RQTY_100216_.old_tb6_3(15):=257;
RQTY_100216_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_3(15),-1)));
RQTY_100216_.old_tb6_4(15):=null;
RQTY_100216_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_4(15),-1)));
RQTY_100216_.old_tb6_5(15):=null;
RQTY_100216_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100216_.TBENTITYATTRIBUTENAME(NVL(RQTY_100216_.old_tb6_5(15),-1)));
RQTY_100216_.tb6_7(15):=RQTY_100216_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100216_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100216_.tb6_1(15),
ENTITY_ID=RQTY_100216_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100216_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100216_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100216_.tb6_5(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100216_.tb6_7(15),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100216_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100216_.tb6_0(15),
RQTY_100216_.tb6_1(15),
RQTY_100216_.tb6_2(15),
RQTY_100216_.tb6_3(15),
RQTY_100216_.tb6_4(15),
RQTY_100216_.tb6_5(15),
null,
RQTY_100216_.tb6_7(15),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb8_0(0):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100216_.tb8_0(0),
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

 WHERE ATTRIBUTE_ID = RQTY_100216_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100216_.tb8_0(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb9_0(0):=RQTY_100216_.tb5_0(0);
RQTY_100216_.tb9_1(0):=RQTY_100216_.tb8_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100216_.tb9_0(0),
RQTY_100216_.tb9_1(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb1_0(3):=69;
RQTY_100216_.tb1_1(3):=RQTY_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100216_.tb1_0(3),
MODULE_ID=RQTY_100216_.tb1_1(3),
DESCRIPTION='Reglas validación de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULVAL_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100216_.tb1_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100216_.tb1_0(3),
RQTY_100216_.tb1_1(3),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.old_tb2_0(12):=121317879;
RQTY_100216_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100216_.tb2_0(12):=RQTY_100216_.tb2_0(12);
RQTY_100216_.old_tb2_1(12):='GEGE_EXERULVAL_CT69E121317879'
;
RQTY_100216_.tb2_1(12):=RQTY_100216_.tb2_0(12);
RQTY_100216_.tb2_2(12):=RQTY_100216_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100216_.tb2_0(12),
RQTY_100216_.tb2_1(12),
RQTY_100216_.tb2_2(12),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",nuSubscriberId);sbTagName = "P_ACTUALIZACION_DE_DATOS_DE_CLIENTE_100216";mo_bogenericvalid.FirstPackActiveByClient(nuSubscriberId,sbTagName,onuPackageTypeId,onuPackageId);if (ut_convert.fblisnumbernull(onuPackageId) = GE_BOCONSTANTS.GETFALSE(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El cliente tiene un trámite de Actualizaciones de datos de Cliente Pendiente");,)'
,
'LBTEST'
,
to_date('25-07-2012 18:02:49','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:53:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida que el cliente no tenga un trámite de actualizaciones de datos pendiente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb8_0(1):=5000025;
RQTY_100216_.tb8_1(1):=RQTY_100216_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100216_.tb8_0(1),
VALID_EXPRESSION=RQTY_100216_.tb8_1(1),
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=16,
ATTRIBUTE_CLASS_ID=20,
NAME_ATTRIBUTE='VAL_CLIENT_DATA_CHANGE_PEND'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Valida que el cliente no tenga un trámite de actualizaciones de datos pendiente'
,
DISPLAY_NAME='Valida que el cliente no tenga un trámite de actualizaciones de datos pendiente'

 WHERE ATTRIBUTE_ID = RQTY_100216_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100216_.tb8_0(1),
RQTY_100216_.tb8_1(1),
null,
1,
16,
20,
'VAL_CLIENT_DATA_CHANGE_PEND'
,
null,
null,
null,
null,
null,
'Valida que el cliente no tenga un trámite de actualizaciones de datos pendiente'
,
'Valida que el cliente no tenga un trámite de actualizaciones de datos pendiente'
);
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb9_0(1):=RQTY_100216_.tb5_0(0);
RQTY_100216_.tb9_1(1):=RQTY_100216_.tb8_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100216_.tb9_0(1),
RQTY_100216_.tb9_1(1),
'Valida que el cliente no tenga un tr¿mite de actualizaciones de datos pendiente'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb10_0(0):=10000000214;
RQTY_100216_.tb10_1(0):=RQTY_100216_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100216_.tb10_0(0),
PACKAGE_TYPE_ID=RQTY_100216_.tb10_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=100381,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100216_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100216_.tb10_0(0),
RQTY_100216_.tb10_1(0),
null,
null,
100381,
21);
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb11_0(0):=100214;
RQTY_100216_.tb11_1(0):=RQTY_100216_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100216_.tb11_0(0),
VALUE_1=RQTY_100216_.tb11_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=100381,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Corrección Datos del Cliente'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100216_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100216_.tb11_0(0),
RQTY_100216_.tb11_1(0),
null,
21,
100381,
0,
31536000,
0,
'Corrección Datos del Cliente'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb12_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100216_.tb12_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb13_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100216_.tb13_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb14_0(0):=6121;
RQTY_100216_.tb14_2(0):=RQTY_100216_.tb12_0(0);
RQTY_100216_.tb14_3(0):=RQTY_100216_.tb13_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100216_.tb14_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100216_.tb14_2(0),
SERVSETI=RQTY_100216_.tb14_3(0),
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
 WHERE SERVCODI = RQTY_100216_.tb14_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100216_.tb14_0(0),
null,
RQTY_100216_.tb14_2(0),
RQTY_100216_.tb14_3(0),
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb15_0(0):=14;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100216_.tb15_0(0),
CLASS_REGISTER_ID=6,
DESCRIPTION='CAMBIO DE DATOS'
,
ASSIGNABLE='N'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_CAMBIO_DE_DATOS'
,
ACTIVITY_TYPE='A'

 WHERE MOTIVE_TYPE_ID = RQTY_100216_.tb15_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100216_.tb15_0(0),
6,
'CAMBIO DE DATOS'
,
'N'
,
'Y'
,
'MOTY_CAMBIO_DE_DATOS'
,
'A'
);
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb16_0(0):=100231;
RQTY_100216_.tb16_1(0):=RQTY_100216_.tb14_0(0);
RQTY_100216_.tb16_2(0):=RQTY_100216_.tb15_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100216_.tb16_0(0),
RQTY_100216_.tb16_1(0),
RQTY_100216_.tb16_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_DATOS_DEL_CLIENTE_100231'
,
'Datos del Cliente'
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
RQTY_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;

RQTY_100216_.tb17_0(0):=100231;
RQTY_100216_.tb17_1(0):=RQTY_100216_.tb16_0(0);
RQTY_100216_.tb17_3(0):=RQTY_100216_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100216_.tb17_0(0),
PRODUCT_MOTIVE_ID=RQTY_100216_.tb17_1(0),
PRODUCT_TYPE_ID=6121,
PACKAGE_TYPE_ID=RQTY_100216_.tb17_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100216_.tb17_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100216_.tb17_0(0),
RQTY_100216_.tb17_1(0),
6121,
RQTY_100216_.tb17_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100216_.blProcessStatus := false;
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
nuIndex := RQTY_100216_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100216_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100216_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100216_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100216_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100216_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100216_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100216_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100216_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100216_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100216_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100216_.blProcessStatus := false;
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
 nuIndex := RQTY_100216_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100216_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100216_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100216_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100216_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100216_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100216_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100216_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100216_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100216_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100216_',
'CREATE OR REPLACE PACKAGE RQPMT_100216_ IS ' || chr(10) ||
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
'where  package_type_id = 100216; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100216 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100216 ' || chr(10) ||
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
'END RQPMT_100216_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100216_******************************'); END;
/

BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100216_.cuExpressions;
fetch RQPMT_100216_.cuExpressions bulk collect INTO RQPMT_100216_.tbExpressionsId;
close RQPMT_100216_.cuExpressions;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100216_.tbEntityName(-1) := 'NULL';
   RQPMT_100216_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(2410) := 'MO_PROCESS@IDENTIFICATION';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(455) := 'MO_MOTIVE@CUSTOM_DECISION_FLAG';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(1032) := 'MO_PROCESS@PROVISIONAL_FLAG';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(39655) := 'MO_PROCESS@VALUE';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(2414) := 'MO_PROCESS@IDENT_TYPE_ID';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(1137) := 'MO_PROCESS@NACIONALITY';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100216_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(39716) := 'MO_PROCESS@DESCRIPTION';
   RQPMT_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100216_.tbEntityAttributeName(39675) := 'MO_PROCESS@PARTIAL_FLAG';
   RQPMT_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100216_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100216
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
WHERE PACKAGE_type_id = 100216
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
WHERE PACKAGE_type_id = 100216
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
WHERE PACKAGE_type_id = 100216
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
WHERE PACKAGE_type_id = 100216
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
WHERE PACKAGE_type_id = 100216
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100216_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100216
))));

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100216_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100216_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100216_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100216_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100216
))));

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100216
))));

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100216_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100216_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100216
)))));

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100216_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100216_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100216_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100216_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100216_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100216_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100216
))));

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
))));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100216
))));

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
)));
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100216_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100216_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100216_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100216_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100216_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100216_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100216_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100216
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb0_0(0):=100231;
RQPMT_100216_.tb0_1(0):=6121;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100216_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100216_.tb0_1(0),
MOTIVE_TYPE_ID=14,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_DATOS_DEL_CLIENTE_100231'
,
DESCRIPTION='Datos del Cliente'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100216_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100216_.tb0_0(0),
RQPMT_100216_.tb0_1(0),
14,
null,
'N'
,
'N'
,
'N'
,
'M_DATOS_DEL_CLIENTE_100231'
,
'Datos del Cliente'
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb1_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100216_.tb1_0(0),
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

 WHERE MODULE_ID = RQPMT_100216_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100216_.tb1_0(0),
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb2_0(0):=23;
RQPMT_100216_.tb2_1(0):=RQPMT_100216_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100216_.tb2_0(0),
MODULE_ID=RQPMT_100216_.tb2_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100216_.tb2_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100216_.tb2_0(0),
RQPMT_100216_.tb2_1(0),
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(0):=121317882;
RQPMT_100216_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(0):=RQPMT_100216_.tb3_0(0);
RQPMT_100216_.old_tb3_1(0):='MO_INITATRIB_CT23E121317882'
;
RQPMT_100216_.tb3_1(0):=RQPMT_100216_.tb3_0(0);
RQPMT_100216_.tb3_2(0):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(0),
RQPMT_100216_.tb3_1(0),
RQPMT_100216_.tb3_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'LBTEST'
,
to_date('02-05-2012 17:38:21','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - MOTIVE_ID - Inicialización del motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(0):=103141;
RQPMT_100216_.old_tb4_1(0):=8;
RQPMT_100216_.tb4_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(0),-1)));
RQPMT_100216_.old_tb4_2(0):=187;
RQPMT_100216_.tb4_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(0),-1)));
RQPMT_100216_.old_tb4_3(0):=null;
RQPMT_100216_.tb4_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(0),-1)));
RQPMT_100216_.old_tb4_4(0):=null;
RQPMT_100216_.tb4_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(0),-1)));
RQPMT_100216_.tb4_6(0):=RQPMT_100216_.tb3_0(0);
RQPMT_100216_.tb4_9(0):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(0),
ENTITY_ID=RQPMT_100216_.tb4_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(0),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(0),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Código'
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
TAG_NAME='CODIGO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(0),
RQPMT_100216_.tb4_1(0),
RQPMT_100216_.tb4_2(0),
RQPMT_100216_.tb4_3(0),
RQPMT_100216_.tb4_4(0),
null,
RQPMT_100216_.tb4_6(0),
null,
null,
RQPMT_100216_.tb4_9(0),
0,
'Código'
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
'CODIGO'
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(1):=103142;
RQPMT_100216_.old_tb4_1(1):=8;
RQPMT_100216_.tb4_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(1),-1)));
RQPMT_100216_.old_tb4_2(1):=213;
RQPMT_100216_.tb4_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(1),-1)));
RQPMT_100216_.old_tb4_3(1):=255;
RQPMT_100216_.tb4_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(1),-1)));
RQPMT_100216_.old_tb4_4(1):=null;
RQPMT_100216_.tb4_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(1),-1)));
RQPMT_100216_.tb4_9(1):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(1),
ENTITY_ID=RQPMT_100216_.tb4_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(1),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(1),
RQPMT_100216_.tb4_1(1),
RQPMT_100216_.tb4_2(1),
RQPMT_100216_.tb4_3(1),
RQPMT_100216_.tb4_4(1),
null,
null,
null,
null,
RQPMT_100216_.tb4_9(1),
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(1):=121317883;
RQPMT_100216_.tb3_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(1):=RQPMT_100216_.tb3_0(1);
RQPMT_100216_.old_tb3_1(1):='MO_INITATRIB_CT23E121317883'
;
RQPMT_100216_.tb3_1(1):=RQPMT_100216_.tb3_0(1);
RQPMT_100216_.tb3_2(1):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(1),
RQPMT_100216_.tb3_1(1),
RQPMT_100216_.tb3_2(1),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,"SUSCRIPC","SUSCCODI",sbContrato);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbContrato);,)'
,
'LBTEST'
,
to_date('27-06-2012 11:23:37','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - SUBSCRIPTION_ID - Inicialización del contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(2):=103144;
RQPMT_100216_.old_tb4_1(2):=8;
RQPMT_100216_.tb4_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(2),-1)));
RQPMT_100216_.old_tb4_2(2):=11403;
RQPMT_100216_.tb4_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(2),-1)));
RQPMT_100216_.old_tb4_3(2):=null;
RQPMT_100216_.tb4_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(2),-1)));
RQPMT_100216_.old_tb4_4(2):=null;
RQPMT_100216_.tb4_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(2),-1)));
RQPMT_100216_.tb4_6(2):=RQPMT_100216_.tb3_0(1);
RQPMT_100216_.tb4_9(2):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(2),
ENTITY_ID=RQPMT_100216_.tb4_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(2),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(2),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Contrato'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(2),
RQPMT_100216_.tb4_1(2),
RQPMT_100216_.tb4_2(2),
RQPMT_100216_.tb4_3(2),
RQPMT_100216_.tb4_4(2),
null,
RQPMT_100216_.tb4_6(2),
null,
null,
RQPMT_100216_.tb4_9(2),
2,
'Contrato'
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb2_0(1):=26;
RQPMT_100216_.tb2_1(1):=RQPMT_100216_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100216_.tb2_0(1),
MODULE_ID=RQPMT_100216_.tb2_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100216_.tb2_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100216_.tb2_0(1),
RQPMT_100216_.tb2_1(1),
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(2):=121317880;
RQPMT_100216_.tb3_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(2):=RQPMT_100216_.tb3_0(2);
RQPMT_100216_.old_tb3_1(2):='MO_VALIDATTR_CT26E121317880'
;
RQPMT_100216_.tb3_1(2):=RQPMT_100216_.tb3_0(2);
RQPMT_100216_.tb3_2(2):=RQPMT_100216_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(2),
RQPMT_100216_.tb3_1(2),
RQPMT_100216_.tb3_2(2),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"MO_PROCESS","VALUE",sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone = NULL,,if (UT_STRING.FNULENGTH(nuPhone) <> 7 '||chr(38)||''||chr(38)||' UT_STRING.FNULENGTH(nuPhone) <> 10,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono deber ser de 7 o 10 dígitos");,);)'
,
'OPEN'
,
to_date('16-10-2017 17:53:34','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VALIDACION DE TELEFONO'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(3):=121317881;
RQPMT_100216_.tb3_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(3):=RQPMT_100216_.tb3_0(3);
RQPMT_100216_.old_tb3_1(3):='MO_INITATRIB_CT23E121317881'
;
RQPMT_100216_.tb3_1(3):=RQPMT_100216_.tb3_0(3);
RQPMT_100216_.tb3_2(3):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(3),
RQPMT_100216_.tb3_1(3),
RQPMT_100216_.tb3_2(3),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","PHONE",nuTelefono);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuTelefono)'
,
'OPEN'
,
to_date('16-10-2017 17:53:33','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI VALOR DE TEELFONO'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(3):=105228;
RQPMT_100216_.old_tb4_1(3):=68;
RQPMT_100216_.tb4_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(3),-1)));
RQPMT_100216_.old_tb4_2(3):=39655;
RQPMT_100216_.tb4_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(3),-1)));
RQPMT_100216_.old_tb4_3(3):=null;
RQPMT_100216_.tb4_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(3),-1)));
RQPMT_100216_.old_tb4_4(3):=null;
RQPMT_100216_.tb4_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(3),-1)));
RQPMT_100216_.tb4_6(3):=RQPMT_100216_.tb3_0(3);
RQPMT_100216_.tb4_7(3):=RQPMT_100216_.tb3_0(2);
RQPMT_100216_.tb4_9(3):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(3),
ENTITY_ID=RQPMT_100216_.tb4_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(3),
VALID_EXPRESSION_ID=RQPMT_100216_.tb4_7(3),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(3),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Telefono'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='TELEFONO'
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
ATTRI_TECHNICAL_NAME='VALUE'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(3),
RQPMT_100216_.tb4_1(3),
RQPMT_100216_.tb4_2(3),
RQPMT_100216_.tb4_3(3),
RQPMT_100216_.tb4_4(3),
null,
RQPMT_100216_.tb4_6(3),
RQPMT_100216_.tb4_7(3),
null,
RQPMT_100216_.tb4_9(3),
14,
'Telefono'
,
14,
'Y'
,
'N'
,
'N'
,
'Y'
,
'TELEFONO'
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
'VALUE'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(4):=121317884;
RQPMT_100216_.tb3_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(4):=RQPMT_100216_.tb3_0(4);
RQPMT_100216_.old_tb3_1(4):='MO_INITATRIB_CT23E121317884'
;
RQPMT_100216_.tb3_1(4):=RQPMT_100216_.tb3_0(4);
RQPMT_100216_.tb3_2(4):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(4),
RQPMT_100216_.tb3_1(4),
RQPMT_100216_.tb3_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",nuProductId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductId);,)'
,
'LBTEST'
,
to_date('02-05-2012 17:38:21','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - PRODUCT_ID - Inicialización del producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(4):=103146;
RQPMT_100216_.old_tb4_1(4):=8;
RQPMT_100216_.tb4_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(4),-1)));
RQPMT_100216_.old_tb4_2(4):=413;
RQPMT_100216_.tb4_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(4),-1)));
RQPMT_100216_.old_tb4_3(4):=null;
RQPMT_100216_.tb4_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(4),-1)));
RQPMT_100216_.old_tb4_4(4):=null;
RQPMT_100216_.tb4_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(4),-1)));
RQPMT_100216_.tb4_6(4):=RQPMT_100216_.tb3_0(4);
RQPMT_100216_.tb4_9(4):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(4),
ENTITY_ID=RQPMT_100216_.tb4_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(4),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(4),
RQPMT_100216_.tb4_1(4),
RQPMT_100216_.tb4_2(4),
RQPMT_100216_.tb4_3(4),
RQPMT_100216_.tb4_4(4),
null,
RQPMT_100216_.tb4_6(4),
null,
null,
RQPMT_100216_.tb4_9(4),
3,
'Producto'
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(5):=121317885;
RQPMT_100216_.tb3_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(5):=RQPMT_100216_.tb3_0(5);
RQPMT_100216_.old_tb3_1(5):='MO_INITATRIB_CT23E121317885'
;
RQPMT_100216_.tb3_1(5):=RQPMT_100216_.tb3_0(5);
RQPMT_100216_.tb3_2(5):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(5),
RQPMT_100216_.tb3_1(5),
RQPMT_100216_.tb3_2(5),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_TYPE_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_TYPE_ID",nuProductTypeId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuProductTypeId);,)'
,
'LBTEST'
,
to_date('02-05-2012 17:38:21','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - PRODUCT_TYPE_ID - Inicialización del tipo de producto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(5):=103147;
RQPMT_100216_.old_tb4_1(5):=8;
RQPMT_100216_.tb4_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(5),-1)));
RQPMT_100216_.old_tb4_2(5):=192;
RQPMT_100216_.tb4_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(5),-1)));
RQPMT_100216_.old_tb4_3(5):=null;
RQPMT_100216_.tb4_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(5),-1)));
RQPMT_100216_.old_tb4_4(5):=null;
RQPMT_100216_.tb4_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(5),-1)));
RQPMT_100216_.tb4_6(5):=RQPMT_100216_.tb3_0(5);
RQPMT_100216_.tb4_9(5):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(5),
ENTITY_ID=RQPMT_100216_.tb4_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(5),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Tipo de producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(5),
RQPMT_100216_.tb4_1(5),
RQPMT_100216_.tb4_2(5),
RQPMT_100216_.tb4_3(5),
RQPMT_100216_.tb4_4(5),
null,
RQPMT_100216_.tb4_6(5),
null,
null,
RQPMT_100216_.tb4_9(5),
4,
'Tipo de producto'
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb5_0(0):=120163736;
RQPMT_100216_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100216_.tb5_0(0):=RQPMT_100216_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100216_.tb5_0(0),
16,
'Listado Respuesta de atención inmediata'
,
'SELECT b.answer_id ID, b.description DESCRIPTION
FROM cc_answer b
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'b.request_type_id = 100216 '||chr(64)||' --código del tipo de paquete
'||chr(64)||'b.is_immediate_attent = '|| chr(39) ||'Y'|| chr(39) ||' '||chr(64)||'
'||chr(64)||'b.answer_id = :ID '||chr(64)||'
'||chr(64)||'b.description like :DESCRIPTION '||chr(64)||''
,
'Listado Respuesta de atención inmediata'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(6):=103150;
RQPMT_100216_.old_tb4_1(6):=8;
RQPMT_100216_.tb4_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(6),-1)));
RQPMT_100216_.old_tb4_2(6):=144591;
RQPMT_100216_.tb4_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(6),-1)));
RQPMT_100216_.old_tb4_3(6):=null;
RQPMT_100216_.tb4_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(6),-1)));
RQPMT_100216_.old_tb4_4(6):=null;
RQPMT_100216_.tb4_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(6),-1)));
RQPMT_100216_.tb4_5(6):=RQPMT_100216_.tb5_0(0);
RQPMT_100216_.tb4_9(6):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(6),
ENTITY_ID=RQPMT_100216_.tb4_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(6),
STATEMENT_ID=RQPMT_100216_.tb4_5(6),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(6),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Respuesta de Atención'
,
DISPLAY_ORDER=5,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(6),
RQPMT_100216_.tb4_1(6),
RQPMT_100216_.tb4_2(6),
RQPMT_100216_.tb4_3(6),
RQPMT_100216_.tb4_4(6),
RQPMT_100216_.tb4_5(6),
null,
null,
null,
RQPMT_100216_.tb4_9(6),
5,
'Respuesta de Atención'
,
5,
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(7):=103149;
RQPMT_100216_.old_tb4_1(7):=8;
RQPMT_100216_.tb4_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(7),-1)));
RQPMT_100216_.old_tb4_2(7):=455;
RQPMT_100216_.tb4_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(7),-1)));
RQPMT_100216_.old_tb4_3(7):=null;
RQPMT_100216_.tb4_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(7),-1)));
RQPMT_100216_.old_tb4_4(7):=null;
RQPMT_100216_.tb4_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(7),-1)));
RQPMT_100216_.tb4_9(7):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(7),
ENTITY_ID=RQPMT_100216_.tb4_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(7),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Documentación Completa'
,
DISPLAY_ORDER=6,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='DOCUMENTACION_COMPLETA'
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
ATTRI_TECHNICAL_NAME='CUSTOM_DECISION_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(7),
RQPMT_100216_.tb4_1(7),
RQPMT_100216_.tb4_2(7),
RQPMT_100216_.tb4_3(7),
RQPMT_100216_.tb4_4(7),
null,
null,
null,
null,
RQPMT_100216_.tb4_9(7),
6,
'Documentación Completa'
,
6,
'Y'
,
'N'
,
'N'
,
'Y'
,
'DOCUMENTACION_COMPLETA'
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
'CUSTOM_DECISION_FLAG'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(6):=121317886;
RQPMT_100216_.tb3_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(6):=RQPMT_100216_.tb3_0(6);
RQPMT_100216_.old_tb3_1(6):='MO_INITATRIB_CT23E121317886'
;
RQPMT_100216_.tb3_1(6):=RQPMT_100216_.tb3_0(6);
RQPMT_100216_.tb3_2(6):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(6),
RQPMT_100216_.tb3_1(6),
RQPMT_100216_.tb3_2(6),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","IDENT_TYPE_ID",nuIdentTypeId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuIdentTypeId)'
,
'LBTEST'
,
to_date('03-05-2012 11:21:58','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - IDENT_TYPE_ID - Inicialzación del tipo de identificación del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb5_0(1):=120163737;
RQPMT_100216_.tb5_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100216_.tb5_0(1):=RQPMT_100216_.tb5_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100216_.tb5_0(1),
16,
'Tipos de identificación del cliente'
,
'SELECT ident_type_id id, description FROM ge_identifica_type'
,
'Tipos de identificación del cliente'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(8):=103151;
RQPMT_100216_.old_tb4_1(8):=68;
RQPMT_100216_.tb4_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(8),-1)));
RQPMT_100216_.old_tb4_2(8):=2414;
RQPMT_100216_.tb4_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(8),-1)));
RQPMT_100216_.old_tb4_3(8):=null;
RQPMT_100216_.tb4_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(8),-1)));
RQPMT_100216_.old_tb4_4(8):=null;
RQPMT_100216_.tb4_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(8),-1)));
RQPMT_100216_.tb4_5(8):=RQPMT_100216_.tb5_0(1);
RQPMT_100216_.tb4_6(8):=RQPMT_100216_.tb3_0(6);
RQPMT_100216_.tb4_9(8):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(8),
ENTITY_ID=RQPMT_100216_.tb4_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(8),
STATEMENT_ID=RQPMT_100216_.tb4_5(8),
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(8),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Tipo de Identificación del Cliente'
,
DISPLAY_ORDER=7,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='TIPO_DE_IDENTIFICACION_DEL_CLIENTE'
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
ATTRI_TECHNICAL_NAME='IDENT_TYPE_ID'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(8),
RQPMT_100216_.tb4_1(8),
RQPMT_100216_.tb4_2(8),
RQPMT_100216_.tb4_3(8),
RQPMT_100216_.tb4_4(8),
RQPMT_100216_.tb4_5(8),
RQPMT_100216_.tb4_6(8),
null,
null,
RQPMT_100216_.tb4_9(8),
7,
'Tipo de Identificación del Cliente'
,
7,
'Y'
,
'N'
,
'N'
,
'Y'
,
'TIPO_DE_IDENTIFICACION_DEL_CLIENTE'
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
'IDENT_TYPE_ID'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(7):=121317887;
RQPMT_100216_.tb3_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(7):=RQPMT_100216_.tb3_0(7);
RQPMT_100216_.old_tb3_1(7):='MO_VALIDATTR_CT26E121317887'
;
RQPMT_100216_.tb3_1(7):=RQPMT_100216_.tb3_0(7);
RQPMT_100216_.tb3_2(7):=RQPMT_100216_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(7),
RQPMT_100216_.tb3_1(7),
RQPMT_100216_.tb3_2(7),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrentInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbIdentId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,null,"MO_PROCESS","IDENT_TYPE_ID",sbIdentTypeId);nuIdentTypeId = UT_CONVERT.FNUCHARTONUMBER(sbIdentTypeId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);if (GE_BOSUBSCRIBER.VALIDIDENTIFICATION(sbIdentId, nuIdentTypeId, onuSubscriberId) = GE_BOCONSTANTS.GETTRUE(),if (nuSubscriberId <> onuSubscriberId,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El cliente que trata de Crear ya existe");,);,);if (LDC_FNUVALICEDUDUMMY(onuSubscriberId) > 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Debe digitar una cedula diferente a la del cliente Dummy");,)'
,
'LBTEST'
,
to_date('17-05-2012 16:26:39','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 21:24:11','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 21:24:11','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MOT - MO_PROCESS - IDENTIFICATION - Validación identificación del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(8):=121317888;
RQPMT_100216_.tb3_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(8):=RQPMT_100216_.tb3_0(8);
RQPMT_100216_.old_tb3_1(8):='MO_INITATRIB_CT23E121317888'
;
RQPMT_100216_.tb3_1(8):=RQPMT_100216_.tb3_0(8);
RQPMT_100216_.tb3_2(8):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(8),
RQPMT_100216_.tb3_1(8),
RQPMT_100216_.tb3_2(8),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","IDENTIFICATION",nuIdentification);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuIdentification)'
,
'LBTEST'
,
to_date('03-05-2012 11:36:22','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - IDENTIFICATION - Inicialzación de la identificación del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(9):=103152;
RQPMT_100216_.old_tb4_1(9):=68;
RQPMT_100216_.tb4_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(9),-1)));
RQPMT_100216_.old_tb4_2(9):=2410;
RQPMT_100216_.tb4_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(9),-1)));
RQPMT_100216_.old_tb4_3(9):=null;
RQPMT_100216_.tb4_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(9),-1)));
RQPMT_100216_.old_tb4_4(9):=null;
RQPMT_100216_.tb4_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(9),-1)));
RQPMT_100216_.tb4_6(9):=RQPMT_100216_.tb3_0(8);
RQPMT_100216_.tb4_7(9):=RQPMT_100216_.tb3_0(7);
RQPMT_100216_.tb4_9(9):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(9),
ENTITY_ID=RQPMT_100216_.tb4_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(9),
VALID_EXPRESSION_ID=RQPMT_100216_.tb4_7(9),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(9),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Identificación del Cliente'
,
DISPLAY_ORDER=8,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='IDENTIFICACION_DEL_CLIENTE'
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
ATTRI_TECHNICAL_NAME='IDENTIFICATION'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(9),
RQPMT_100216_.tb4_1(9),
RQPMT_100216_.tb4_2(9),
RQPMT_100216_.tb4_3(9),
RQPMT_100216_.tb4_4(9),
null,
RQPMT_100216_.tb4_6(9),
RQPMT_100216_.tb4_7(9),
null,
RQPMT_100216_.tb4_9(9),
8,
'Identificación del Cliente'
,
8,
'Y'
,
'N'
,
'N'
,
'Y'
,
'IDENTIFICACION_DEL_CLIENTE'
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
'IDENTIFICATION'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(9):=121317889;
RQPMT_100216_.tb3_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(9):=RQPMT_100216_.tb3_0(9);
RQPMT_100216_.old_tb3_1(9):='MO_INITATRIB_CT23E121317889'
;
RQPMT_100216_.tb3_1(9):=RQPMT_100216_.tb3_0(9);
RQPMT_100216_.tb3_2(9):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(9),
RQPMT_100216_.tb3_1(9),
RQPMT_100216_.tb3_2(9),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_NAME",sbSubscriberName);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbSubscriberName)'
,
'LBTEST'
,
to_date('03-05-2012 13:48:11','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - DESCRIPTION - Inicialzación del nombre del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(10):=103153;
RQPMT_100216_.old_tb4_1(10):=68;
RQPMT_100216_.tb4_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(10),-1)));
RQPMT_100216_.old_tb4_2(10):=39716;
RQPMT_100216_.tb4_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(10),-1)));
RQPMT_100216_.old_tb4_3(10):=null;
RQPMT_100216_.tb4_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(10),-1)));
RQPMT_100216_.old_tb4_4(10):=null;
RQPMT_100216_.tb4_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(10),-1)));
RQPMT_100216_.tb4_6(10):=RQPMT_100216_.tb3_0(9);
RQPMT_100216_.tb4_9(10):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(10),
ENTITY_ID=RQPMT_100216_.tb4_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(10),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Nombre'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='NOMBRE'
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
ATTRI_TECHNICAL_NAME='DESCRIPTION'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(10),
RQPMT_100216_.tb4_1(10),
RQPMT_100216_.tb4_2(10),
RQPMT_100216_.tb4_3(10),
RQPMT_100216_.tb4_4(10),
null,
RQPMT_100216_.tb4_6(10),
null,
null,
RQPMT_100216_.tb4_9(10),
9,
'Nombre'
,
9,
'Y'
,
'N'
,
'N'
,
'Y'
,
'NOMBRE'
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
'DESCRIPTION'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(10):=121317891;
RQPMT_100216_.tb3_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(10):=RQPMT_100216_.tb3_0(10);
RQPMT_100216_.old_tb3_1(10):='MO_INITATRIB_CT23E121317891'
;
RQPMT_100216_.tb3_1(10):=RQPMT_100216_.tb3_0(10);
RQPMT_100216_.tb3_2(10):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(10),
RQPMT_100216_.tb3_1(10),
RQPMT_100216_.tb3_2(10),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);CC_BOSUBSCRIBERDATA.GETSUBSPHONEDATA(nuSubscriberId,sbTel1,sbTel2,sbIdTel1,sbIdTel2);if (sbIdTel1 <> null,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbTel1);,)'
,
'LBTEST'
,
to_date('20-06-2012 09:49:08','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - VARCHAR_1 - Inicialización del telefono de contacto 1 del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(11):=103155;
RQPMT_100216_.old_tb4_1(11):=68;
RQPMT_100216_.tb4_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(11),-1)));
RQPMT_100216_.old_tb4_2(11):=6732;
RQPMT_100216_.tb4_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(11),-1)));
RQPMT_100216_.old_tb4_3(11):=null;
RQPMT_100216_.tb4_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(11),-1)));
RQPMT_100216_.old_tb4_4(11):=null;
RQPMT_100216_.tb4_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(11),-1)));
RQPMT_100216_.tb4_6(11):=RQPMT_100216_.tb3_0(10);
RQPMT_100216_.tb4_9(11):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(11),
ENTITY_ID=RQPMT_100216_.tb4_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(11),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Teléfono de Contacto 1'
,
DISPLAY_ORDER=11,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='TELEFONO_DE_CONTACTO_1'
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
ATTRI_TECHNICAL_NAME='VARCHAR_1'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(11),
RQPMT_100216_.tb4_1(11),
RQPMT_100216_.tb4_2(11),
RQPMT_100216_.tb4_3(11),
RQPMT_100216_.tb4_4(11),
null,
RQPMT_100216_.tb4_6(11),
null,
null,
RQPMT_100216_.tb4_9(11),
11,
'Teléfono de Contacto 1'
,
11,
'Y'
,
'N'
,
'N'
,
'N'
,
'TELEFONO_DE_CONTACTO_1'
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
'VARCHAR_1'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(11):=121317892;
RQPMT_100216_.tb3_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(11):=RQPMT_100216_.tb3_0(11);
RQPMT_100216_.old_tb3_1(11):='MO_VALIDATTR_CT26E121317892'
;
RQPMT_100216_.tb3_1(11):=RQPMT_100216_.tb3_0(11);
RQPMT_100216_.tb3_2(11):=RQPMT_100216_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(11),
RQPMT_100216_.tb3_1(11),
RQPMT_100216_.tb3_2(11),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VARCHAR_1",sbTelNew1);if (UT_CONVERT.FBLISSTRINGNULL(sbTelNew1) = GE_BOCONSTANTS.GETTRUE(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Debe diligenciar primero el Teléfono de Contacto 1");,)'
,
'KARICERO'
,
to_date('10-05-2013 17:30:42','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MO_PROCESS - VARCHAR2 - Valida teléfono número uno'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(12):=121317893;
RQPMT_100216_.tb3_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(12):=RQPMT_100216_.tb3_0(12);
RQPMT_100216_.old_tb3_1(12):='MO_INITATRIB_CT23E121317893'
;
RQPMT_100216_.tb3_1(12):=RQPMT_100216_.tb3_0(12);
RQPMT_100216_.tb3_2(12):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(12),
RQPMT_100216_.tb3_1(12),
RQPMT_100216_.tb3_2(12),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);CC_BOSUBSCRIBERDATA.GETSUBSPHONEDATA(nuSubscriberId,sbTel1,sbTel2,sbIdTel1,sbIdTel2);if (sbIdTel2 <> null '||chr(38)||''||chr(38)||' sbIdTel2 <> sbIdTel1,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbTel2);,)'
,
'LBTEST'
,
to_date('20-06-2012 09:50:36','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - VARCHAR_2 - Inicialización del telefono de contacto 2 del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(12):=103156;
RQPMT_100216_.old_tb4_1(12):=68;
RQPMT_100216_.tb4_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(12),-1)));
RQPMT_100216_.old_tb4_2(12):=6733;
RQPMT_100216_.tb4_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(12),-1)));
RQPMT_100216_.old_tb4_3(12):=null;
RQPMT_100216_.tb4_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(12),-1)));
RQPMT_100216_.old_tb4_4(12):=null;
RQPMT_100216_.tb4_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(12),-1)));
RQPMT_100216_.tb4_6(12):=RQPMT_100216_.tb3_0(12);
RQPMT_100216_.tb4_7(12):=RQPMT_100216_.tb3_0(11);
RQPMT_100216_.tb4_9(12):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(12),
ENTITY_ID=RQPMT_100216_.tb4_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(12),
VALID_EXPRESSION_ID=RQPMT_100216_.tb4_7(12),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(12),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Teléfono de Contacto 2'
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
TAG_NAME='TELEFONO_DE_CONTACTO_2'
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
ATTRI_TECHNICAL_NAME='VARCHAR_2'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(12),
RQPMT_100216_.tb4_1(12),
RQPMT_100216_.tb4_2(12),
RQPMT_100216_.tb4_3(12),
RQPMT_100216_.tb4_4(12),
null,
RQPMT_100216_.tb4_6(12),
RQPMT_100216_.tb4_7(12),
null,
RQPMT_100216_.tb4_9(12),
12,
'Teléfono de Contacto 2'
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
'TELEFONO_DE_CONTACTO_2'
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
'VARCHAR_2'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(13):=121317894;
RQPMT_100216_.tb3_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(13):=RQPMT_100216_.tb3_0(13);
RQPMT_100216_.old_tb3_1(13):='MO_VALIDATTR_CT26E121317894'
;
RQPMT_100216_.tb3_1(13):=RQPMT_100216_.tb3_0(13);
RQPMT_100216_.tb3_2(13):=RQPMT_100216_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(13),
RQPMT_100216_.tb3_1(13),
RQPMT_100216_.tb3_2(13),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(emailNew);if (UT_MAIL.FBLVALIDATEMAIL(emailNew) = GE_BOCONSTANTS.GETFALSE(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El formato del correo electrónico es incorrecto");,)'
,
'GERMCAME'
,
to_date('26-06-2013 10:22:41','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MOT - MO_PROCESS - NATIONALITY - Valida si el formato del nuevo correo electrónico es correcto'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(14):=121317895;
RQPMT_100216_.tb3_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(14):=RQPMT_100216_.tb3_0(14);
RQPMT_100216_.old_tb3_1(14):='MO_INITATRIB_CT23E121317895'
;
RQPMT_100216_.tb3_1(14):=RQPMT_100216_.tb3_0(14);
RQPMT_100216_.tb3_2(14):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(14),
RQPMT_100216_.tb3_1(14),
RQPMT_100216_.tb3_2(14),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","E_MAIL",sbEmail);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbEmail)'
,
'GERMCAME'
,
to_date('26-06-2013 10:22:41','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - NATIONALITY - Inicialzación del email del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(13):=103636;
RQPMT_100216_.old_tb4_1(13):=68;
RQPMT_100216_.tb4_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(13),-1)));
RQPMT_100216_.old_tb4_2(13):=1137;
RQPMT_100216_.tb4_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(13),-1)));
RQPMT_100216_.old_tb4_3(13):=null;
RQPMT_100216_.tb4_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(13),-1)));
RQPMT_100216_.old_tb4_4(13):=null;
RQPMT_100216_.tb4_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(13),-1)));
RQPMT_100216_.tb4_6(13):=RQPMT_100216_.tb3_0(14);
RQPMT_100216_.tb4_7(13):=RQPMT_100216_.tb3_0(13);
RQPMT_100216_.tb4_9(13):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(13),
ENTITY_ID=RQPMT_100216_.tb4_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(13),
VALID_EXPRESSION_ID=RQPMT_100216_.tb4_7(13),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(13),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Correo Electrónico'
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
TAG_NAME='CORREO_ELECTRONICO'
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
ATTRI_TECHNICAL_NAME='NACIONALITY'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(13),
RQPMT_100216_.tb4_1(13),
RQPMT_100216_.tb4_2(13),
RQPMT_100216_.tb4_3(13),
RQPMT_100216_.tb4_4(13),
null,
RQPMT_100216_.tb4_6(13),
RQPMT_100216_.tb4_7(13),
null,
RQPMT_100216_.tb4_9(13),
13,
'Correo Electrónico'
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
'CORREO_ELECTRONICO'
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
'NACIONALITY'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(15):=121317896;
RQPMT_100216_.tb3_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(15):=RQPMT_100216_.tb3_0(15);
RQPMT_100216_.old_tb3_1(15):='MO_INITATRIB_CT23E121317896'
;
RQPMT_100216_.tb3_1(15):=RQPMT_100216_.tb3_0(15);
RQPMT_100216_.tb3_2(15):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(15),
RQPMT_100216_.tb3_1(15),
RQPMT_100216_.tb3_2(15),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","DATA_SEND",sbAutoriza);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbAutoriza)'
,
'OPEN'
,
to_date('14-10-2017 11:31:48','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI- AUTORIZA FLAG'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(14):=104132;
RQPMT_100216_.old_tb4_1(14):=68;
RQPMT_100216_.tb4_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(14),-1)));
RQPMT_100216_.old_tb4_2(14):=1032;
RQPMT_100216_.tb4_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(14),-1)));
RQPMT_100216_.old_tb4_3(14):=null;
RQPMT_100216_.tb4_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(14),-1)));
RQPMT_100216_.old_tb4_4(14):=null;
RQPMT_100216_.tb4_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(14),-1)));
RQPMT_100216_.tb4_6(14):=RQPMT_100216_.tb3_0(15);
RQPMT_100216_.tb4_9(14):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(14),
ENTITY_ID=RQPMT_100216_.tb4_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(14),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Flag Autoriza Envio Info.'
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
TAG_NAME='FLAG_AUTORIZA_ENVIO_INFO'
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
ATTRI_TECHNICAL_NAME='PROVISIONAL_FLAG'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(14),
RQPMT_100216_.tb4_1(14),
RQPMT_100216_.tb4_2(14),
RQPMT_100216_.tb4_3(14),
RQPMT_100216_.tb4_4(14),
null,
RQPMT_100216_.tb4_6(14),
null,
null,
RQPMT_100216_.tb4_9(14),
15,
'Flag Autoriza Envio Info.'
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
'FLAG_AUTORIZA_ENVIO_INFO'
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
'PROVISIONAL_FLAG'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(16):=121317890;
RQPMT_100216_.tb3_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(16):=RQPMT_100216_.tb3_0(16);
RQPMT_100216_.old_tb3_1(16):='MO_INITATRIB_CT23E121317890'
;
RQPMT_100216_.tb3_1(16):=RQPMT_100216_.tb3_0(16);
RQPMT_100216_.tb3_2(16):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(16),
RQPMT_100216_.tb3_1(16),
RQPMT_100216_.tb3_2(16),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBS_LAST_NAME",sbSubsLastName);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbSubsLastName)'
,
'LBTEST'
,
to_date('03-05-2012 13:48:11','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:16','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_PROCESS - COMMENTARY - Inicialzación del apellido del cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(15):=103154;
RQPMT_100216_.old_tb4_1(15):=68;
RQPMT_100216_.tb4_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(15),-1)));
RQPMT_100216_.old_tb4_2(15):=20371;
RQPMT_100216_.tb4_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(15),-1)));
RQPMT_100216_.old_tb4_3(15):=null;
RQPMT_100216_.tb4_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(15),-1)));
RQPMT_100216_.old_tb4_4(15):=null;
RQPMT_100216_.tb4_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(15),-1)));
RQPMT_100216_.tb4_6(15):=RQPMT_100216_.tb3_0(16);
RQPMT_100216_.tb4_9(15):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(15),
ENTITY_ID=RQPMT_100216_.tb4_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(15),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(15),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Apellido'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='N'
,
TAG_NAME='APELLIDO'
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
ATTRI_TECHNICAL_NAME='COMMENTARY'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(15),
RQPMT_100216_.tb4_1(15),
RQPMT_100216_.tb4_2(15),
RQPMT_100216_.tb4_3(15),
RQPMT_100216_.tb4_4(15),
null,
RQPMT_100216_.tb4_6(15),
null,
null,
RQPMT_100216_.tb4_9(15),
10,
'Apellido'
,
10,
'Y'
,
'N'
,
'N'
,
'N'
,
'APELLIDO'
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
'COMMENTARY'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(17):=121317897;
RQPMT_100216_.tb3_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(17):=RQPMT_100216_.tb3_0(17);
RQPMT_100216_.old_tb3_1(17):='MO_INITATRIB_CT23E121317897'
;
RQPMT_100216_.tb3_1(17):=RQPMT_100216_.tb3_0(17);
RQPMT_100216_.tb3_2(17):=RQPMT_100216_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(17),
RQPMT_100216_.tb3_1(17),
RQPMT_100216_.tb3_2(17),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","ACCEPT_CALL",sbCall);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbCall)'
,
'OPEN'
,
to_date('14-10-2017 11:31:50','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - ACEPTA LLAMADA'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb4_0(16):=104133;
RQPMT_100216_.old_tb4_1(16):=68;
RQPMT_100216_.tb4_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100216_.TBENTITYNAME(NVL(RQPMT_100216_.old_tb4_1(16),-1)));
RQPMT_100216_.old_tb4_2(16):=39675;
RQPMT_100216_.tb4_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_2(16),-1)));
RQPMT_100216_.old_tb4_3(16):=null;
RQPMT_100216_.tb4_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_3(16),-1)));
RQPMT_100216_.old_tb4_4(16):=null;
RQPMT_100216_.tb4_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100216_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100216_.old_tb4_4(16),-1)));
RQPMT_100216_.tb4_6(16):=RQPMT_100216_.tb3_0(17);
RQPMT_100216_.tb4_9(16):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100216_.tb4_0(16),
ENTITY_ID=RQPMT_100216_.tb4_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100216_.tb4_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100216_.tb4_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100216_.tb4_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100216_.tb4_6(16),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb4_9(16),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Acepta Llamada'
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
TAG_NAME='ACEPTA_LLAMADA'
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
ATTRI_TECHNICAL_NAME='PARTIAL_FLAG'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100216_.tb4_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100216_.tb4_0(16),
RQPMT_100216_.tb4_1(16),
RQPMT_100216_.tb4_2(16),
RQPMT_100216_.tb4_3(16),
RQPMT_100216_.tb4_4(16),
null,
RQPMT_100216_.tb4_6(16),
null,
null,
RQPMT_100216_.tb4_9(16),
16,
'Acepta Llamada'
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
'ACEPTA_LLAMADA'
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
'PARTIAL_FLAG'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb6_0(0):=10104;
RQPMT_100216_.tb6_1(0):=RQPMT_100216_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_EVENTS fila (0)',1);
UPDATE PS_PROD_MOTI_EVENTS SET PROD_MOTI_EVENTS_ID=RQPMT_100216_.tb6_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100216_.tb6_1(0),
EVENT_ID=1
 WHERE PROD_MOTI_EVENTS_ID = RQPMT_100216_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_EVENTS(PROD_MOTI_EVENTS_ID,PRODUCT_MOTIVE_ID,EVENT_ID) 
VALUES (RQPMT_100216_.tb6_0(0),
RQPMT_100216_.tb6_1(0),
1);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb2_0(2):=65;
RQPMT_100216_.tb2_1(2):=RQPMT_100216_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100216_.tb2_0(2),
MODULE_ID=RQPMT_100216_.tb2_1(2),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100216_.tb2_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100216_.tb2_0(2),
RQPMT_100216_.tb2_1(2),
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
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(18):=121317898;
RQPMT_100216_.tb3_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(18):=RQPMT_100216_.tb3_0(18);
RQPMT_100216_.old_tb3_1(18):='MO_EVE_COMP_CT65E121317898'
;
RQPMT_100216_.tb3_1(18):=RQPMT_100216_.tb3_0(18);
RQPMT_100216_.tb3_2(18):=RQPMT_100216_.tb2_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(18),
RQPMT_100216_.tb3_1(18),
RQPMT_100216_.tb3_2(18),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",nuSubscriberId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","IDENT_TYPE_ID",nuIdentTypeIdOld);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","IDENTIFICATION",nuIdentificationOld);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_NAME",sbNameOld);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBS_LAST_NAME",sbLastNameOld);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","E_MAIL",sbEmailOld);CC_BOSUBSCRIBERDATA.GETSUBSPHONEDATA(nuSubscriberId,sbTele1Old,sbTele2Old,sbIdTel1Old,sbIdTel2Old);CC_BOSubscriberData.ValidateDataChange(nuIdentTypeIdOld,nuIdentificationOld,sbNameOld,sbLastNameOld,sbEmailOld,sbTele1Old,sbTele2Old)'
,
'LBTEST'
,
to_date('24-07-2012 15:48:06','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'PRE - MOT - Validación modificación de información'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb7_0(0):=10119;
RQPMT_100216_.tb7_1(0):=RQPMT_100216_.tb6_0(0);
RQPMT_100216_.tb7_2(0):=RQPMT_100216_.tb3_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (0)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100216_.tb7_0(0),
PROD_MOTI_EVENTS_ID=RQPMT_100216_.tb7_1(0),
CONFIG_EXPRESSION_ID=RQPMT_100216_.tb7_2(0),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100216_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100216_.tb7_0(0),
RQPMT_100216_.tb7_1(0),
RQPMT_100216_.tb7_2(0),
'B'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.old_tb3_0(19):=121317899;
RQPMT_100216_.tb3_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100216_.tb3_0(19):=RQPMT_100216_.tb3_0(19);
RQPMT_100216_.old_tb3_1(19):='MO_EVE_COMP_CT65E121317899'
;
RQPMT_100216_.tb3_1(19):=RQPMT_100216_.tb3_0(19);
RQPMT_100216_.tb3_2(19):=RQPMT_100216_.tb2_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100216_.tb3_0(19),
RQPMT_100216_.tb3_1(19),
RQPMT_100216_.tb3_2(19),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_MOTIVE","ANSWER_ID",sbAnswerId);nuAnswerId = UT_CONVERT.FNUCHARTONUMBER(sbAnswerId);if (UT_CONVERT.FBLISNUMBERNULL(nuAnswerId) = GE_BOCONSTANTS.GETTRUE(),CC_BOSubscriberData.LoadUpdatedClientData();LDC_PROCARGATELMODATACHAGE();,if (CC_BOANSWER.FNUGETANSWERTYPEID(nuAnswerId) = 40,CC_BOSubscriberData.LoadUpdatedClientData();LDC_PROCARGATELMODATACHAGE();,);)'
,
'LBTEST'
,
to_date('24-07-2012 15:48:07','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
to_date('17-11-2018 19:54:17','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'POST - MOT - Actualización datos de cliente - Carga datos a instancia por Metodo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;

RQPMT_100216_.tb7_0(1):=10118;
RQPMT_100216_.tb7_1(1):=RQPMT_100216_.tb6_0(0);
RQPMT_100216_.tb7_2(1):=RQPMT_100216_.tb3_0(19);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (1)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100216_.tb7_0(1),
PROD_MOTI_EVENTS_ID=RQPMT_100216_.tb7_1(1),
CONFIG_EXPRESSION_ID=RQPMT_100216_.tb7_2(1),
EXECUTING_TIME='AF'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100216_.tb7_0(1);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100216_.tb7_0(1),
RQPMT_100216_.tb7_1(1),
RQPMT_100216_.tb7_2(1),
'AF'
,
'Y'
);
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
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

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100216, sbSuccess);
FOR rc in RQPMT_100216_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
nuIndex := RQPMT_100216_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100216_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100216_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100216_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100216_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100216_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100216_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100216_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100216_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100216_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100216_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100216_.blProcessStatus := false;
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
 nuIndex := RQPMT_100216_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100216_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100216_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100216_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100216_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100216_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100216_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100216_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100216_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100216_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100216_',
'CREATE OR REPLACE PACKAGE RQCFG_100216_ IS ' || chr(10) ||
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
'AND     external_root_id = 100216 ' || chr(10) ||
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
'END RQCFG_100216_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100216_******************************'); END;
/

BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100216_.cuCompositions;
fetch RQCFG_100216_.cuCompositions bulk collect INTO RQCFG_100216_.tbCompositions;
close RQCFG_100216_.cuCompositions;

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100216_.tbEntityName(-1) := 'NULL';
   RQCFG_100216_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100216_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100216_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100216_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100216_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(455) := 'MO_MOTIVE@CUSTOM_DECISION_FLAG';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(1032) := 'MO_PROCESS@PROVISIONAL_FLAG';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(1137) := 'MO_PROCESS@NACIONALITY';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(2410) := 'MO_PROCESS@IDENTIFICATION';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(2414) := 'MO_PROCESS@IDENT_TYPE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(39655) := 'MO_PROCESS@VALUE';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(39675) := 'MO_PROCESS@PARTIAL_FLAG';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(39716) := 'MO_PROCESS@DESCRIPTION';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(2410) := 'MO_PROCESS@IDENTIFICATION';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(455) := 'MO_MOTIVE@CUSTOM_DECISION_FLAG';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(1032) := 'MO_PROCESS@PROVISIONAL_FLAG';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(39655) := 'MO_PROCESS@VALUE';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100216_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100216_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(2414) := 'MO_PROCESS@IDENT_TYPE_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(1137) := 'MO_PROCESS@NACIONALITY';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100216_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100216_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100216_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100216_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(39716) := 'MO_PROCESS@DESCRIPTION';
   RQCFG_100216_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100216_.tbEntityAttributeName(39675) := 'MO_PROCESS@PARTIAL_FLAG';
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
AND     external_root_id = 100216
)
);
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100216_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100216, 4);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100216_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100216_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100216_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100216_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100216_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216))));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216)));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100216, 4);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100216_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216))));
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216))));
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216))));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216)));

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100216_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100216_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100216_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100216_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100216_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100216;

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb0_0(0):=8943;
RQCFG_100216_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100216_.tb0_0(0):=RQCFG_100216_.tb0_0(0);
RQCFG_100216_.old_tb0_2(0):=2012;
RQCFG_100216_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100216_.tb0_0(0),
100216,
RQCFG_100216_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb1_0(0):=1061664;
RQCFG_100216_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100216_.tb1_0(0):=RQCFG_100216_.tb1_0(0);
RQCFG_100216_.old_tb1_1(0):=100216;
RQCFG_100216_.tb1_1(0):=RQCFG_100216_.old_tb1_1(0);
RQCFG_100216_.old_tb1_2(0):=2012;
RQCFG_100216_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb1_2(0),-1)));
RQCFG_100216_.old_tb1_3(0):=8943;
RQCFG_100216_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb1_2(0),-1))), RQCFG_100216_.old_tb1_1(0), 4);
RQCFG_100216_.tb1_3(0):=RQCFG_100216_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100216_.tb1_0(0),
RQCFG_100216_.tb1_1(0),
RQCFG_100216_.tb1_2(0),
RQCFG_100216_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb2_0(0):=100027171;
RQCFG_100216_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100216_.tb2_0(0):=RQCFG_100216_.tb2_0(0);
RQCFG_100216_.tb2_1(0):=RQCFG_100216_.tb0_0(0);
RQCFG_100216_.tb2_2(0):=RQCFG_100216_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100216_.tb2_0(0),
RQCFG_100216_.tb2_1(0),
RQCFG_100216_.tb2_2(0),
null,
6121,
1,
1,
1);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb1_0(1):=1061665;
RQCFG_100216_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100216_.tb1_0(1):=RQCFG_100216_.tb1_0(1);
RQCFG_100216_.old_tb1_1(1):=100231;
RQCFG_100216_.tb1_1(1):=RQCFG_100216_.old_tb1_1(1);
RQCFG_100216_.old_tb1_2(1):=2013;
RQCFG_100216_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb1_2(1),-1)));
RQCFG_100216_.old_tb1_3(1):=null;
RQCFG_100216_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb1_2(1),-1))), RQCFG_100216_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100216_.tb1_0(1),
RQCFG_100216_.tb1_1(1),
RQCFG_100216_.tb1_2(1),
RQCFG_100216_.tb1_3(1),
null,
'M_DATOS_DEL_CLIENTE_100231'
,
1,
1,
4);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb2_0(1):=100027172;
RQCFG_100216_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100216_.tb2_0(1):=RQCFG_100216_.tb2_0(1);
RQCFG_100216_.tb2_1(1):=RQCFG_100216_.tb0_0(0);
RQCFG_100216_.tb2_2(1):=RQCFG_100216_.tb1_0(1);
RQCFG_100216_.tb2_3(1):=RQCFG_100216_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100216_.tb2_0(1),
RQCFG_100216_.tb2_1(1),
RQCFG_100216_.tb2_2(1),
RQCFG_100216_.tb2_3(1),
6121,
2,
1,
1);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(0):=1157615;
RQCFG_100216_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(0):=RQCFG_100216_.tb3_0(0);
RQCFG_100216_.old_tb3_1(0):=3334;
RQCFG_100216_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(0),-1)));
RQCFG_100216_.old_tb3_2(0):=1137;
RQCFG_100216_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(0),-1)));
RQCFG_100216_.old_tb3_3(0):=null;
RQCFG_100216_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(0),-1)));
RQCFG_100216_.old_tb3_4(0):=null;
RQCFG_100216_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(0),-1)));
RQCFG_100216_.tb3_5(0):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(0):=121317895;
RQCFG_100216_.tb3_6(0):=NULL;
RQCFG_100216_.old_tb3_7(0):=121317894;
RQCFG_100216_.tb3_7(0):=NULL;
RQCFG_100216_.old_tb3_8(0):=null;
RQCFG_100216_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(0),
RQCFG_100216_.tb3_1(0),
RQCFG_100216_.tb3_2(0),
RQCFG_100216_.tb3_3(0),
RQCFG_100216_.tb3_4(0),
RQCFG_100216_.tb3_5(0),
RQCFG_100216_.tb3_6(0),
RQCFG_100216_.tb3_7(0),
RQCFG_100216_.tb3_8(0),
null,
103636,
13,
'Correo Electrónico'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb4_0(0):=7491;
RQCFG_100216_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100216_.tb4_0(0):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb4_1(0):=RQCFG_100216_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100216_.tb4_0(0),
RQCFG_100216_.tb4_1(0),
null,
null,
'FRAME-M_DATOS_DEL_CLIENTE_100231-1061665'
,
2);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(0):=1548872;
RQCFG_100216_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(0):=RQCFG_100216_.tb5_0(0);
RQCFG_100216_.old_tb5_1(0):=1137;
RQCFG_100216_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(0),-1)));
RQCFG_100216_.old_tb5_2(0):=null;
RQCFG_100216_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(0),-1)));
RQCFG_100216_.tb5_3(0):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(0):=RQCFG_100216_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(0),
RQCFG_100216_.tb5_1(0),
RQCFG_100216_.tb5_2(0),
RQCFG_100216_.tb5_3(0),
RQCFG_100216_.tb5_4(0),
'Y'
,
'Y'
,
13,
'N'
,
'Correo Electrónico'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(1):=1157616;
RQCFG_100216_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(1):=RQCFG_100216_.tb3_0(1);
RQCFG_100216_.old_tb3_1(1):=3334;
RQCFG_100216_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(1),-1)));
RQCFG_100216_.old_tb3_2(1):=187;
RQCFG_100216_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(1),-1)));
RQCFG_100216_.old_tb3_3(1):=null;
RQCFG_100216_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(1),-1)));
RQCFG_100216_.old_tb3_4(1):=null;
RQCFG_100216_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(1),-1)));
RQCFG_100216_.tb3_5(1):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(1):=121317882;
RQCFG_100216_.tb3_6(1):=NULL;
RQCFG_100216_.old_tb3_7(1):=null;
RQCFG_100216_.tb3_7(1):=NULL;
RQCFG_100216_.old_tb3_8(1):=null;
RQCFG_100216_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(1),
RQCFG_100216_.tb3_1(1),
RQCFG_100216_.tb3_2(1),
RQCFG_100216_.tb3_3(1),
RQCFG_100216_.tb3_4(1),
RQCFG_100216_.tb3_5(1),
RQCFG_100216_.tb3_6(1),
RQCFG_100216_.tb3_7(1),
RQCFG_100216_.tb3_8(1),
null,
103141,
0,
'Código'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(1):=1548873;
RQCFG_100216_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(1):=RQCFG_100216_.tb5_0(1);
RQCFG_100216_.old_tb5_1(1):=187;
RQCFG_100216_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(1),-1)));
RQCFG_100216_.old_tb5_2(1):=null;
RQCFG_100216_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(1),-1)));
RQCFG_100216_.tb5_3(1):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(1):=RQCFG_100216_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(1),
RQCFG_100216_.tb5_1(1),
RQCFG_100216_.tb5_2(1),
RQCFG_100216_.tb5_3(1),
RQCFG_100216_.tb5_4(1),
'C'
,
'Y'
,
0,
'N'
,
'Código'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(2):=1157617;
RQCFG_100216_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(2):=RQCFG_100216_.tb3_0(2);
RQCFG_100216_.old_tb3_1(2):=3334;
RQCFG_100216_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(2),-1)));
RQCFG_100216_.old_tb3_2(2):=213;
RQCFG_100216_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(2),-1)));
RQCFG_100216_.old_tb3_3(2):=255;
RQCFG_100216_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(2),-1)));
RQCFG_100216_.old_tb3_4(2):=null;
RQCFG_100216_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(2),-1)));
RQCFG_100216_.tb3_5(2):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(2):=null;
RQCFG_100216_.tb3_6(2):=NULL;
RQCFG_100216_.old_tb3_7(2):=null;
RQCFG_100216_.tb3_7(2):=NULL;
RQCFG_100216_.old_tb3_8(2):=null;
RQCFG_100216_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(2),
RQCFG_100216_.tb3_1(2),
RQCFG_100216_.tb3_2(2),
RQCFG_100216_.tb3_3(2),
RQCFG_100216_.tb3_4(2),
RQCFG_100216_.tb3_5(2),
RQCFG_100216_.tb3_6(2),
RQCFG_100216_.tb3_7(2),
RQCFG_100216_.tb3_8(2),
null,
103142,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(2):=1548874;
RQCFG_100216_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(2):=RQCFG_100216_.tb5_0(2);
RQCFG_100216_.old_tb5_1(2):=213;
RQCFG_100216_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(2),-1)));
RQCFG_100216_.old_tb5_2(2):=null;
RQCFG_100216_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(2),-1)));
RQCFG_100216_.tb5_3(2):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(2):=RQCFG_100216_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(2),
RQCFG_100216_.tb5_1(2),
RQCFG_100216_.tb5_2(2),
RQCFG_100216_.tb5_3(2),
RQCFG_100216_.tb5_4(2),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(3):=1157618;
RQCFG_100216_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(3):=RQCFG_100216_.tb3_0(3);
RQCFG_100216_.old_tb3_1(3):=3334;
RQCFG_100216_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(3),-1)));
RQCFG_100216_.old_tb3_2(3):=11403;
RQCFG_100216_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(3),-1)));
RQCFG_100216_.old_tb3_3(3):=null;
RQCFG_100216_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(3),-1)));
RQCFG_100216_.old_tb3_4(3):=null;
RQCFG_100216_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(3),-1)));
RQCFG_100216_.tb3_5(3):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(3):=121317883;
RQCFG_100216_.tb3_6(3):=NULL;
RQCFG_100216_.old_tb3_7(3):=null;
RQCFG_100216_.tb3_7(3):=NULL;
RQCFG_100216_.old_tb3_8(3):=null;
RQCFG_100216_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(3),
RQCFG_100216_.tb3_1(3),
RQCFG_100216_.tb3_2(3),
RQCFG_100216_.tb3_3(3),
RQCFG_100216_.tb3_4(3),
RQCFG_100216_.tb3_5(3),
RQCFG_100216_.tb3_6(3),
RQCFG_100216_.tb3_7(3),
RQCFG_100216_.tb3_8(3),
null,
103144,
2,
'Contrato'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(3):=1548875;
RQCFG_100216_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(3):=RQCFG_100216_.tb5_0(3);
RQCFG_100216_.old_tb5_1(3):=11403;
RQCFG_100216_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(3),-1)));
RQCFG_100216_.old_tb5_2(3):=null;
RQCFG_100216_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(3),-1)));
RQCFG_100216_.tb5_3(3):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(3):=RQCFG_100216_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(3),
RQCFG_100216_.tb5_1(3),
RQCFG_100216_.tb5_2(3),
RQCFG_100216_.tb5_3(3),
RQCFG_100216_.tb5_4(3),
'C'
,
'Y'
,
2,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(4):=1157619;
RQCFG_100216_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(4):=RQCFG_100216_.tb3_0(4);
RQCFG_100216_.old_tb3_1(4):=3334;
RQCFG_100216_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(4),-1)));
RQCFG_100216_.old_tb3_2(4):=413;
RQCFG_100216_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(4),-1)));
RQCFG_100216_.old_tb3_3(4):=null;
RQCFG_100216_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(4),-1)));
RQCFG_100216_.old_tb3_4(4):=null;
RQCFG_100216_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(4),-1)));
RQCFG_100216_.tb3_5(4):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(4):=121317884;
RQCFG_100216_.tb3_6(4):=NULL;
RQCFG_100216_.old_tb3_7(4):=null;
RQCFG_100216_.tb3_7(4):=NULL;
RQCFG_100216_.old_tb3_8(4):=null;
RQCFG_100216_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(4),
RQCFG_100216_.tb3_1(4),
RQCFG_100216_.tb3_2(4),
RQCFG_100216_.tb3_3(4),
RQCFG_100216_.tb3_4(4),
RQCFG_100216_.tb3_5(4),
RQCFG_100216_.tb3_6(4),
RQCFG_100216_.tb3_7(4),
RQCFG_100216_.tb3_8(4),
null,
103146,
3,
'Producto'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(4):=1548876;
RQCFG_100216_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(4):=RQCFG_100216_.tb5_0(4);
RQCFG_100216_.old_tb5_1(4):=413;
RQCFG_100216_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(4),-1)));
RQCFG_100216_.old_tb5_2(4):=null;
RQCFG_100216_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(4),-1)));
RQCFG_100216_.tb5_3(4):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(4):=RQCFG_100216_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(4),
RQCFG_100216_.tb5_1(4),
RQCFG_100216_.tb5_2(4),
RQCFG_100216_.tb5_3(4),
RQCFG_100216_.tb5_4(4),
'C'
,
'Y'
,
3,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(5):=1157620;
RQCFG_100216_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(5):=RQCFG_100216_.tb3_0(5);
RQCFG_100216_.old_tb3_1(5):=3334;
RQCFG_100216_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(5),-1)));
RQCFG_100216_.old_tb3_2(5):=192;
RQCFG_100216_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(5),-1)));
RQCFG_100216_.old_tb3_3(5):=null;
RQCFG_100216_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(5),-1)));
RQCFG_100216_.old_tb3_4(5):=null;
RQCFG_100216_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(5),-1)));
RQCFG_100216_.tb3_5(5):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(5):=121317885;
RQCFG_100216_.tb3_6(5):=NULL;
RQCFG_100216_.old_tb3_7(5):=null;
RQCFG_100216_.tb3_7(5):=NULL;
RQCFG_100216_.old_tb3_8(5):=null;
RQCFG_100216_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(5),
RQCFG_100216_.tb3_1(5),
RQCFG_100216_.tb3_2(5),
RQCFG_100216_.tb3_3(5),
RQCFG_100216_.tb3_4(5),
RQCFG_100216_.tb3_5(5),
RQCFG_100216_.tb3_6(5),
RQCFG_100216_.tb3_7(5),
RQCFG_100216_.tb3_8(5),
null,
103147,
4,
'Tipo de producto'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(5):=1548877;
RQCFG_100216_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(5):=RQCFG_100216_.tb5_0(5);
RQCFG_100216_.old_tb5_1(5):=192;
RQCFG_100216_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(5),-1)));
RQCFG_100216_.old_tb5_2(5):=null;
RQCFG_100216_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(5),-1)));
RQCFG_100216_.tb5_3(5):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(5):=RQCFG_100216_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(5),
RQCFG_100216_.tb5_1(5),
RQCFG_100216_.tb5_2(5),
RQCFG_100216_.tb5_3(5),
RQCFG_100216_.tb5_4(5),
'C'
,
'Y'
,
4,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(6):=1157621;
RQCFG_100216_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(6):=RQCFG_100216_.tb3_0(6);
RQCFG_100216_.old_tb3_1(6):=3334;
RQCFG_100216_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(6),-1)));
RQCFG_100216_.old_tb3_2(6):=144591;
RQCFG_100216_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(6),-1)));
RQCFG_100216_.old_tb3_3(6):=null;
RQCFG_100216_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(6),-1)));
RQCFG_100216_.old_tb3_4(6):=null;
RQCFG_100216_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(6),-1)));
RQCFG_100216_.tb3_5(6):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(6):=null;
RQCFG_100216_.tb3_6(6):=NULL;
RQCFG_100216_.old_tb3_7(6):=null;
RQCFG_100216_.tb3_7(6):=NULL;
RQCFG_100216_.old_tb3_8(6):=120163736;
RQCFG_100216_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(6),
RQCFG_100216_.tb3_1(6),
RQCFG_100216_.tb3_2(6),
RQCFG_100216_.tb3_3(6),
RQCFG_100216_.tb3_4(6),
RQCFG_100216_.tb3_5(6),
RQCFG_100216_.tb3_6(6),
RQCFG_100216_.tb3_7(6),
RQCFG_100216_.tb3_8(6),
null,
103150,
5,
'Respuesta de Atención'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(6):=1548878;
RQCFG_100216_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(6):=RQCFG_100216_.tb5_0(6);
RQCFG_100216_.old_tb5_1(6):=144591;
RQCFG_100216_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(6),-1)));
RQCFG_100216_.old_tb5_2(6):=null;
RQCFG_100216_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(6),-1)));
RQCFG_100216_.tb5_3(6):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(6):=RQCFG_100216_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(6),
RQCFG_100216_.tb5_1(6),
RQCFG_100216_.tb5_2(6),
RQCFG_100216_.tb5_3(6),
RQCFG_100216_.tb5_4(6),
'Y'
,
'Y'
,
5,
'N'
,
'Respuesta de Atención'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(7):=1157622;
RQCFG_100216_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(7):=RQCFG_100216_.tb3_0(7);
RQCFG_100216_.old_tb3_1(7):=3334;
RQCFG_100216_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(7),-1)));
RQCFG_100216_.old_tb3_2(7):=455;
RQCFG_100216_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(7),-1)));
RQCFG_100216_.old_tb3_3(7):=null;
RQCFG_100216_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(7),-1)));
RQCFG_100216_.old_tb3_4(7):=null;
RQCFG_100216_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(7),-1)));
RQCFG_100216_.tb3_5(7):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(7):=null;
RQCFG_100216_.tb3_6(7):=NULL;
RQCFG_100216_.old_tb3_7(7):=null;
RQCFG_100216_.tb3_7(7):=NULL;
RQCFG_100216_.old_tb3_8(7):=null;
RQCFG_100216_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(7),
RQCFG_100216_.tb3_1(7),
RQCFG_100216_.tb3_2(7),
RQCFG_100216_.tb3_3(7),
RQCFG_100216_.tb3_4(7),
RQCFG_100216_.tb3_5(7),
RQCFG_100216_.tb3_6(7),
RQCFG_100216_.tb3_7(7),
RQCFG_100216_.tb3_8(7),
null,
103149,
6,
'Documentación Completa'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(7):=1548879;
RQCFG_100216_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(7):=RQCFG_100216_.tb5_0(7);
RQCFG_100216_.old_tb5_1(7):=455;
RQCFG_100216_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(7),-1)));
RQCFG_100216_.old_tb5_2(7):=null;
RQCFG_100216_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(7),-1)));
RQCFG_100216_.tb5_3(7):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(7):=RQCFG_100216_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(7),
RQCFG_100216_.tb5_1(7),
RQCFG_100216_.tb5_2(7),
RQCFG_100216_.tb5_3(7),
RQCFG_100216_.tb5_4(7),
'Y'
,
'Y'
,
6,
'Y'
,
'Documentación Completa'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(8):=1157623;
RQCFG_100216_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(8):=RQCFG_100216_.tb3_0(8);
RQCFG_100216_.old_tb3_1(8):=3334;
RQCFG_100216_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(8),-1)));
RQCFG_100216_.old_tb3_2(8):=2414;
RQCFG_100216_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(8),-1)));
RQCFG_100216_.old_tb3_3(8):=null;
RQCFG_100216_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(8),-1)));
RQCFG_100216_.old_tb3_4(8):=null;
RQCFG_100216_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(8),-1)));
RQCFG_100216_.tb3_5(8):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(8):=121317886;
RQCFG_100216_.tb3_6(8):=NULL;
RQCFG_100216_.old_tb3_7(8):=null;
RQCFG_100216_.tb3_7(8):=NULL;
RQCFG_100216_.old_tb3_8(8):=120163737;
RQCFG_100216_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(8),
RQCFG_100216_.tb3_1(8),
RQCFG_100216_.tb3_2(8),
RQCFG_100216_.tb3_3(8),
RQCFG_100216_.tb3_4(8),
RQCFG_100216_.tb3_5(8),
RQCFG_100216_.tb3_6(8),
RQCFG_100216_.tb3_7(8),
RQCFG_100216_.tb3_8(8),
null,
103151,
7,
'Tipo de Identificación del Cliente'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(8):=1548880;
RQCFG_100216_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(8):=RQCFG_100216_.tb5_0(8);
RQCFG_100216_.old_tb5_1(8):=2414;
RQCFG_100216_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(8),-1)));
RQCFG_100216_.old_tb5_2(8):=null;
RQCFG_100216_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(8),-1)));
RQCFG_100216_.tb5_3(8):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(8):=RQCFG_100216_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(8),
RQCFG_100216_.tb5_1(8),
RQCFG_100216_.tb5_2(8),
RQCFG_100216_.tb5_3(8),
RQCFG_100216_.tb5_4(8),
'Y'
,
'Y'
,
7,
'Y'
,
'Tipo de Identificación del Cliente'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(9):=1157624;
RQCFG_100216_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(9):=RQCFG_100216_.tb3_0(9);
RQCFG_100216_.old_tb3_1(9):=3334;
RQCFG_100216_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(9),-1)));
RQCFG_100216_.old_tb3_2(9):=2410;
RQCFG_100216_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(9),-1)));
RQCFG_100216_.old_tb3_3(9):=null;
RQCFG_100216_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(9),-1)));
RQCFG_100216_.old_tb3_4(9):=null;
RQCFG_100216_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(9),-1)));
RQCFG_100216_.tb3_5(9):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(9):=121317888;
RQCFG_100216_.tb3_6(9):=NULL;
RQCFG_100216_.old_tb3_7(9):=121317887;
RQCFG_100216_.tb3_7(9):=NULL;
RQCFG_100216_.old_tb3_8(9):=null;
RQCFG_100216_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(9),
RQCFG_100216_.tb3_1(9),
RQCFG_100216_.tb3_2(9),
RQCFG_100216_.tb3_3(9),
RQCFG_100216_.tb3_4(9),
RQCFG_100216_.tb3_5(9),
RQCFG_100216_.tb3_6(9),
RQCFG_100216_.tb3_7(9),
RQCFG_100216_.tb3_8(9),
null,
103152,
8,
'Identificación del Cliente'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(9):=1548881;
RQCFG_100216_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(9):=RQCFG_100216_.tb5_0(9);
RQCFG_100216_.old_tb5_1(9):=2410;
RQCFG_100216_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(9),-1)));
RQCFG_100216_.old_tb5_2(9):=null;
RQCFG_100216_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(9),-1)));
RQCFG_100216_.tb5_3(9):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(9):=RQCFG_100216_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(9),
RQCFG_100216_.tb5_1(9),
RQCFG_100216_.tb5_2(9),
RQCFG_100216_.tb5_3(9),
RQCFG_100216_.tb5_4(9),
'Y'
,
'Y'
,
8,
'Y'
,
'Identificación del Cliente'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(10):=1157625;
RQCFG_100216_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(10):=RQCFG_100216_.tb3_0(10);
RQCFG_100216_.old_tb3_1(10):=3334;
RQCFG_100216_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(10),-1)));
RQCFG_100216_.old_tb3_2(10):=39716;
RQCFG_100216_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(10),-1)));
RQCFG_100216_.old_tb3_3(10):=null;
RQCFG_100216_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(10),-1)));
RQCFG_100216_.old_tb3_4(10):=null;
RQCFG_100216_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(10),-1)));
RQCFG_100216_.tb3_5(10):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(10):=121317889;
RQCFG_100216_.tb3_6(10):=NULL;
RQCFG_100216_.old_tb3_7(10):=null;
RQCFG_100216_.tb3_7(10):=NULL;
RQCFG_100216_.old_tb3_8(10):=null;
RQCFG_100216_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(10),
RQCFG_100216_.tb3_1(10),
RQCFG_100216_.tb3_2(10),
RQCFG_100216_.tb3_3(10),
RQCFG_100216_.tb3_4(10),
RQCFG_100216_.tb3_5(10),
RQCFG_100216_.tb3_6(10),
RQCFG_100216_.tb3_7(10),
RQCFG_100216_.tb3_8(10),
null,
103153,
9,
'Nombre'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(10):=1548882;
RQCFG_100216_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(10):=RQCFG_100216_.tb5_0(10);
RQCFG_100216_.old_tb5_1(10):=39716;
RQCFG_100216_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(10),-1)));
RQCFG_100216_.old_tb5_2(10):=null;
RQCFG_100216_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(10),-1)));
RQCFG_100216_.tb5_3(10):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(10):=RQCFG_100216_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(10),
RQCFG_100216_.tb5_1(10),
RQCFG_100216_.tb5_2(10),
RQCFG_100216_.tb5_3(10),
RQCFG_100216_.tb5_4(10),
'Y'
,
'Y'
,
9,
'Y'
,
'Nombre'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(11):=1157626;
RQCFG_100216_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(11):=RQCFG_100216_.tb3_0(11);
RQCFG_100216_.old_tb3_1(11):=3334;
RQCFG_100216_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(11),-1)));
RQCFG_100216_.old_tb3_2(11):=20371;
RQCFG_100216_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(11),-1)));
RQCFG_100216_.old_tb3_3(11):=null;
RQCFG_100216_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(11),-1)));
RQCFG_100216_.old_tb3_4(11):=null;
RQCFG_100216_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(11),-1)));
RQCFG_100216_.tb3_5(11):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(11):=121317890;
RQCFG_100216_.tb3_6(11):=NULL;
RQCFG_100216_.old_tb3_7(11):=null;
RQCFG_100216_.tb3_7(11):=NULL;
RQCFG_100216_.old_tb3_8(11):=null;
RQCFG_100216_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(11),
RQCFG_100216_.tb3_1(11),
RQCFG_100216_.tb3_2(11),
RQCFG_100216_.tb3_3(11),
RQCFG_100216_.tb3_4(11),
RQCFG_100216_.tb3_5(11),
RQCFG_100216_.tb3_6(11),
RQCFG_100216_.tb3_7(11),
RQCFG_100216_.tb3_8(11),
null,
103154,
10,
'Apellido'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(11):=1548883;
RQCFG_100216_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(11):=RQCFG_100216_.tb5_0(11);
RQCFG_100216_.old_tb5_1(11):=20371;
RQCFG_100216_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(11),-1)));
RQCFG_100216_.old_tb5_2(11):=null;
RQCFG_100216_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(11),-1)));
RQCFG_100216_.tb5_3(11):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(11):=RQCFG_100216_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(11),
RQCFG_100216_.tb5_1(11),
RQCFG_100216_.tb5_2(11),
RQCFG_100216_.tb5_3(11),
RQCFG_100216_.tb5_4(11),
'Y'
,
'Y'
,
10,
'N'
,
'Apellido'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(12):=1157627;
RQCFG_100216_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(12):=RQCFG_100216_.tb3_0(12);
RQCFG_100216_.old_tb3_1(12):=3334;
RQCFG_100216_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(12),-1)));
RQCFG_100216_.old_tb3_2(12):=6732;
RQCFG_100216_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(12),-1)));
RQCFG_100216_.old_tb3_3(12):=null;
RQCFG_100216_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(12),-1)));
RQCFG_100216_.old_tb3_4(12):=null;
RQCFG_100216_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(12),-1)));
RQCFG_100216_.tb3_5(12):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(12):=121317891;
RQCFG_100216_.tb3_6(12):=NULL;
RQCFG_100216_.old_tb3_7(12):=null;
RQCFG_100216_.tb3_7(12):=NULL;
RQCFG_100216_.old_tb3_8(12):=null;
RQCFG_100216_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(12),
RQCFG_100216_.tb3_1(12),
RQCFG_100216_.tb3_2(12),
RQCFG_100216_.tb3_3(12),
RQCFG_100216_.tb3_4(12),
RQCFG_100216_.tb3_5(12),
RQCFG_100216_.tb3_6(12),
RQCFG_100216_.tb3_7(12),
RQCFG_100216_.tb3_8(12),
null,
103155,
11,
'Teléfono de Contacto 1'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(12):=1548884;
RQCFG_100216_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(12):=RQCFG_100216_.tb5_0(12);
RQCFG_100216_.old_tb5_1(12):=6732;
RQCFG_100216_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(12),-1)));
RQCFG_100216_.old_tb5_2(12):=null;
RQCFG_100216_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(12),-1)));
RQCFG_100216_.tb5_3(12):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(12):=RQCFG_100216_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(12),
RQCFG_100216_.tb5_1(12),
RQCFG_100216_.tb5_2(12),
RQCFG_100216_.tb5_3(12),
RQCFG_100216_.tb5_4(12),
'Y'
,
'Y'
,
11,
'N'
,
'Teléfono de Contacto 1'
,
'N'
,
'N'
,
'U'
,
null,
127,
null,
null,
null);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(13):=1157628;
RQCFG_100216_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(13):=RQCFG_100216_.tb3_0(13);
RQCFG_100216_.old_tb3_1(13):=3334;
RQCFG_100216_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(13),-1)));
RQCFG_100216_.old_tb3_2(13):=6733;
RQCFG_100216_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(13),-1)));
RQCFG_100216_.old_tb3_3(13):=null;
RQCFG_100216_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(13),-1)));
RQCFG_100216_.old_tb3_4(13):=null;
RQCFG_100216_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(13),-1)));
RQCFG_100216_.tb3_5(13):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(13):=121317893;
RQCFG_100216_.tb3_6(13):=NULL;
RQCFG_100216_.old_tb3_7(13):=121317892;
RQCFG_100216_.tb3_7(13):=NULL;
RQCFG_100216_.old_tb3_8(13):=null;
RQCFG_100216_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(13),
RQCFG_100216_.tb3_1(13),
RQCFG_100216_.tb3_2(13),
RQCFG_100216_.tb3_3(13),
RQCFG_100216_.tb3_4(13),
RQCFG_100216_.tb3_5(13),
RQCFG_100216_.tb3_6(13),
RQCFG_100216_.tb3_7(13),
RQCFG_100216_.tb3_8(13),
null,
103156,
12,
'Teléfono de Contacto 2'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(13):=1548885;
RQCFG_100216_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(13):=RQCFG_100216_.tb5_0(13);
RQCFG_100216_.old_tb5_1(13):=6733;
RQCFG_100216_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(13),-1)));
RQCFG_100216_.old_tb5_2(13):=null;
RQCFG_100216_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(13),-1)));
RQCFG_100216_.tb5_3(13):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(13):=RQCFG_100216_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(13),
RQCFG_100216_.tb5_1(13),
RQCFG_100216_.tb5_2(13),
RQCFG_100216_.tb5_3(13),
RQCFG_100216_.tb5_4(13),
'Y'
,
'Y'
,
12,
'N'
,
'Teléfono de Contacto 2'
,
'N'
,
'N'
,
'U'
,
null,
127,
null,
null,
null);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(14):=1157629;
RQCFG_100216_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(14):=RQCFG_100216_.tb3_0(14);
RQCFG_100216_.old_tb3_1(14):=3334;
RQCFG_100216_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(14),-1)));
RQCFG_100216_.old_tb3_2(14):=1032;
RQCFG_100216_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(14),-1)));
RQCFG_100216_.old_tb3_3(14):=null;
RQCFG_100216_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(14),-1)));
RQCFG_100216_.old_tb3_4(14):=null;
RQCFG_100216_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(14),-1)));
RQCFG_100216_.tb3_5(14):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(14):=121317896;
RQCFG_100216_.tb3_6(14):=NULL;
RQCFG_100216_.old_tb3_7(14):=null;
RQCFG_100216_.tb3_7(14):=NULL;
RQCFG_100216_.old_tb3_8(14):=null;
RQCFG_100216_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(14),
RQCFG_100216_.tb3_1(14),
RQCFG_100216_.tb3_2(14),
RQCFG_100216_.tb3_3(14),
RQCFG_100216_.tb3_4(14),
RQCFG_100216_.tb3_5(14),
RQCFG_100216_.tb3_6(14),
RQCFG_100216_.tb3_7(14),
RQCFG_100216_.tb3_8(14),
null,
104132,
15,
'Flag Autoriza Envio Info.'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(14):=1548886;
RQCFG_100216_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(14):=RQCFG_100216_.tb5_0(14);
RQCFG_100216_.old_tb5_1(14):=1032;
RQCFG_100216_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(14),-1)));
RQCFG_100216_.old_tb5_2(14):=null;
RQCFG_100216_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(14),-1)));
RQCFG_100216_.tb5_3(14):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(14):=RQCFG_100216_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(14),
RQCFG_100216_.tb5_1(14),
RQCFG_100216_.tb5_2(14),
RQCFG_100216_.tb5_3(14),
RQCFG_100216_.tb5_4(14),
'Y'
,
'Y'
,
15,
'N'
,
'Flag Autoriza Envio Info.'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(15):=1157630;
RQCFG_100216_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(15):=RQCFG_100216_.tb3_0(15);
RQCFG_100216_.old_tb3_1(15):=3334;
RQCFG_100216_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(15),-1)));
RQCFG_100216_.old_tb3_2(15):=39675;
RQCFG_100216_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(15),-1)));
RQCFG_100216_.old_tb3_3(15):=null;
RQCFG_100216_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(15),-1)));
RQCFG_100216_.old_tb3_4(15):=null;
RQCFG_100216_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(15),-1)));
RQCFG_100216_.tb3_5(15):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(15):=121317897;
RQCFG_100216_.tb3_6(15):=NULL;
RQCFG_100216_.old_tb3_7(15):=null;
RQCFG_100216_.tb3_7(15):=NULL;
RQCFG_100216_.old_tb3_8(15):=null;
RQCFG_100216_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(15),
RQCFG_100216_.tb3_1(15),
RQCFG_100216_.tb3_2(15),
RQCFG_100216_.tb3_3(15),
RQCFG_100216_.tb3_4(15),
RQCFG_100216_.tb3_5(15),
RQCFG_100216_.tb3_6(15),
RQCFG_100216_.tb3_7(15),
RQCFG_100216_.tb3_8(15),
null,
104133,
16,
'Acepta Llamada'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(15):=1548887;
RQCFG_100216_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(15):=RQCFG_100216_.tb5_0(15);
RQCFG_100216_.old_tb5_1(15):=39675;
RQCFG_100216_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(15),-1)));
RQCFG_100216_.old_tb5_2(15):=null;
RQCFG_100216_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(15),-1)));
RQCFG_100216_.tb5_3(15):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(15):=RQCFG_100216_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(15),
RQCFG_100216_.tb5_1(15),
RQCFG_100216_.tb5_2(15),
RQCFG_100216_.tb5_3(15),
RQCFG_100216_.tb5_4(15),
'Y'
,
'Y'
,
16,
'N'
,
'Acepta Llamada'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(16):=1157631;
RQCFG_100216_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(16):=RQCFG_100216_.tb3_0(16);
RQCFG_100216_.old_tb3_1(16):=3334;
RQCFG_100216_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(16),-1)));
RQCFG_100216_.old_tb3_2(16):=39655;
RQCFG_100216_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(16),-1)));
RQCFG_100216_.old_tb3_3(16):=null;
RQCFG_100216_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(16),-1)));
RQCFG_100216_.old_tb3_4(16):=null;
RQCFG_100216_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(16),-1)));
RQCFG_100216_.tb3_5(16):=RQCFG_100216_.tb2_2(1);
RQCFG_100216_.old_tb3_6(16):=121317881;
RQCFG_100216_.tb3_6(16):=NULL;
RQCFG_100216_.old_tb3_7(16):=121317880;
RQCFG_100216_.tb3_7(16):=NULL;
RQCFG_100216_.old_tb3_8(16):=null;
RQCFG_100216_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(16),
RQCFG_100216_.tb3_1(16),
RQCFG_100216_.tb3_2(16),
RQCFG_100216_.tb3_3(16),
RQCFG_100216_.tb3_4(16),
RQCFG_100216_.tb3_5(16),
RQCFG_100216_.tb3_6(16),
RQCFG_100216_.tb3_7(16),
RQCFG_100216_.tb3_8(16),
null,
105228,
14,
'Telefono'
,
'N'
,
'Y'
,
'Y'
,
14,
null,
null);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(16):=1548888;
RQCFG_100216_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(16):=RQCFG_100216_.tb5_0(16);
RQCFG_100216_.old_tb5_1(16):=39655;
RQCFG_100216_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(16),-1)));
RQCFG_100216_.old_tb5_2(16):=null;
RQCFG_100216_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(16),-1)));
RQCFG_100216_.tb5_3(16):=RQCFG_100216_.tb4_0(0);
RQCFG_100216_.tb5_4(16):=RQCFG_100216_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(16),
RQCFG_100216_.tb5_1(16),
RQCFG_100216_.tb5_2(16),
RQCFG_100216_.tb5_3(16),
RQCFG_100216_.tb5_4(16),
'Y'
,
'Y'
,
14,
'Y'
,
'Telefono'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(17):=1157632;
RQCFG_100216_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(17):=RQCFG_100216_.tb3_0(17);
RQCFG_100216_.old_tb3_1(17):=2036;
RQCFG_100216_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(17),-1)));
RQCFG_100216_.old_tb3_2(17):=257;
RQCFG_100216_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(17),-1)));
RQCFG_100216_.old_tb3_3(17):=null;
RQCFG_100216_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(17),-1)));
RQCFG_100216_.old_tb3_4(17):=null;
RQCFG_100216_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(17),-1)));
RQCFG_100216_.tb3_5(17):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(17):=121317878;
RQCFG_100216_.tb3_6(17):=NULL;
RQCFG_100216_.old_tb3_7(17):=null;
RQCFG_100216_.tb3_7(17):=NULL;
RQCFG_100216_.old_tb3_8(17):=null;
RQCFG_100216_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(17),
RQCFG_100216_.tb3_1(17),
RQCFG_100216_.tb3_2(17),
RQCFG_100216_.tb3_3(17),
RQCFG_100216_.tb3_4(17),
RQCFG_100216_.tb3_5(17),
RQCFG_100216_.tb3_6(17),
RQCFG_100216_.tb3_7(17),
RQCFG_100216_.tb3_8(17),
null,
105295,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb4_0(1):=7492;
RQCFG_100216_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100216_.tb4_0(1):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb4_1(1):=RQCFG_100216_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100216_.tb4_0(1),
RQCFG_100216_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1061664'
,
1);

exception when others then
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(17):=1548889;
RQCFG_100216_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(17):=RQCFG_100216_.tb5_0(17);
RQCFG_100216_.old_tb5_1(17):=257;
RQCFG_100216_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(17),-1)));
RQCFG_100216_.old_tb5_2(17):=null;
RQCFG_100216_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(17),-1)));
RQCFG_100216_.tb5_3(17):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(17):=RQCFG_100216_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(17),
RQCFG_100216_.tb5_1(17),
RQCFG_100216_.tb5_2(17),
RQCFG_100216_.tb5_3(17),
RQCFG_100216_.tb5_4(17),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(18):=1157633;
RQCFG_100216_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(18):=RQCFG_100216_.tb3_0(18);
RQCFG_100216_.old_tb3_1(18):=2036;
RQCFG_100216_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(18),-1)));
RQCFG_100216_.old_tb3_2(18):=258;
RQCFG_100216_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(18),-1)));
RQCFG_100216_.old_tb3_3(18):=null;
RQCFG_100216_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(18),-1)));
RQCFG_100216_.old_tb3_4(18):=null;
RQCFG_100216_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(18),-1)));
RQCFG_100216_.tb3_5(18):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(18):=121317868;
RQCFG_100216_.tb3_6(18):=NULL;
RQCFG_100216_.old_tb3_7(18):=121317869;
RQCFG_100216_.tb3_7(18):=NULL;
RQCFG_100216_.old_tb3_8(18):=null;
RQCFG_100216_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(18),
RQCFG_100216_.tb3_1(18),
RQCFG_100216_.tb3_2(18),
RQCFG_100216_.tb3_3(18),
RQCFG_100216_.tb3_4(18),
RQCFG_100216_.tb3_5(18),
RQCFG_100216_.tb3_6(18),
RQCFG_100216_.tb3_7(18),
RQCFG_100216_.tb3_8(18),
null,
105296,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(18):=1548890;
RQCFG_100216_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(18):=RQCFG_100216_.tb5_0(18);
RQCFG_100216_.old_tb5_1(18):=258;
RQCFG_100216_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(18),-1)));
RQCFG_100216_.old_tb5_2(18):=null;
RQCFG_100216_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(18),-1)));
RQCFG_100216_.tb5_3(18):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(18):=RQCFG_100216_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(18),
RQCFG_100216_.tb5_1(18),
RQCFG_100216_.tb5_2(18),
RQCFG_100216_.tb5_3(18),
RQCFG_100216_.tb5_4(18),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(19):=1157634;
RQCFG_100216_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(19):=RQCFG_100216_.tb3_0(19);
RQCFG_100216_.old_tb3_1(19):=2036;
RQCFG_100216_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(19),-1)));
RQCFG_100216_.old_tb3_2(19):=255;
RQCFG_100216_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(19),-1)));
RQCFG_100216_.old_tb3_3(19):=null;
RQCFG_100216_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(19),-1)));
RQCFG_100216_.old_tb3_4(19):=null;
RQCFG_100216_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(19),-1)));
RQCFG_100216_.tb3_5(19):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(19):=null;
RQCFG_100216_.tb3_6(19):=NULL;
RQCFG_100216_.old_tb3_7(19):=null;
RQCFG_100216_.tb3_7(19):=NULL;
RQCFG_100216_.old_tb3_8(19):=null;
RQCFG_100216_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(19),
RQCFG_100216_.tb3_1(19),
RQCFG_100216_.tb3_2(19),
RQCFG_100216_.tb3_3(19),
RQCFG_100216_.tb3_4(19),
RQCFG_100216_.tb3_5(19),
RQCFG_100216_.tb3_6(19),
RQCFG_100216_.tb3_7(19),
RQCFG_100216_.tb3_8(19),
null,
105297,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(19):=1548891;
RQCFG_100216_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(19):=RQCFG_100216_.tb5_0(19);
RQCFG_100216_.old_tb5_1(19):=255;
RQCFG_100216_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(19),-1)));
RQCFG_100216_.old_tb5_2(19):=null;
RQCFG_100216_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(19),-1)));
RQCFG_100216_.tb5_3(19):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(19):=RQCFG_100216_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(19),
RQCFG_100216_.tb5_1(19),
RQCFG_100216_.tb5_2(19),
RQCFG_100216_.tb5_3(19),
RQCFG_100216_.tb5_4(19),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(20):=1157635;
RQCFG_100216_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(20):=RQCFG_100216_.tb3_0(20);
RQCFG_100216_.old_tb3_1(20):=2036;
RQCFG_100216_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(20),-1)));
RQCFG_100216_.old_tb3_2(20):=50001162;
RQCFG_100216_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(20),-1)));
RQCFG_100216_.old_tb3_3(20):=null;
RQCFG_100216_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(20),-1)));
RQCFG_100216_.old_tb3_4(20):=null;
RQCFG_100216_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(20),-1)));
RQCFG_100216_.tb3_5(20):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(20):=121317870;
RQCFG_100216_.tb3_6(20):=NULL;
RQCFG_100216_.old_tb3_7(20):=null;
RQCFG_100216_.tb3_7(20):=NULL;
RQCFG_100216_.old_tb3_8(20):=120163732;
RQCFG_100216_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(20),
RQCFG_100216_.tb3_1(20),
RQCFG_100216_.tb3_2(20),
RQCFG_100216_.tb3_3(20),
RQCFG_100216_.tb3_4(20),
RQCFG_100216_.tb3_5(20),
RQCFG_100216_.tb3_6(20),
RQCFG_100216_.tb3_7(20),
RQCFG_100216_.tb3_8(20),
null,
105298,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(20):=1548892;
RQCFG_100216_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(20):=RQCFG_100216_.tb5_0(20);
RQCFG_100216_.old_tb5_1(20):=50001162;
RQCFG_100216_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(20),-1)));
RQCFG_100216_.old_tb5_2(20):=null;
RQCFG_100216_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(20),-1)));
RQCFG_100216_.tb5_3(20):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(20):=RQCFG_100216_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(20),
RQCFG_100216_.tb5_1(20),
RQCFG_100216_.tb5_2(20),
RQCFG_100216_.tb5_3(20),
RQCFG_100216_.tb5_4(20),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(21):=1157636;
RQCFG_100216_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(21):=RQCFG_100216_.tb3_0(21);
RQCFG_100216_.old_tb3_1(21):=2036;
RQCFG_100216_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(21),-1)));
RQCFG_100216_.old_tb3_2(21):=109479;
RQCFG_100216_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(21),-1)));
RQCFG_100216_.old_tb3_3(21):=null;
RQCFG_100216_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(21),-1)));
RQCFG_100216_.old_tb3_4(21):=null;
RQCFG_100216_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(21),-1)));
RQCFG_100216_.tb3_5(21):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(21):=121317871;
RQCFG_100216_.tb3_6(21):=NULL;
RQCFG_100216_.old_tb3_7(21):=null;
RQCFG_100216_.tb3_7(21):=NULL;
RQCFG_100216_.old_tb3_8(21):=120163733;
RQCFG_100216_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(21),
RQCFG_100216_.tb3_1(21),
RQCFG_100216_.tb3_2(21),
RQCFG_100216_.tb3_3(21),
RQCFG_100216_.tb3_4(21),
RQCFG_100216_.tb3_5(21),
RQCFG_100216_.tb3_6(21),
RQCFG_100216_.tb3_7(21),
RQCFG_100216_.tb3_8(21),
null,
105299,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(21):=1548893;
RQCFG_100216_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(21):=RQCFG_100216_.tb5_0(21);
RQCFG_100216_.old_tb5_1(21):=109479;
RQCFG_100216_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(21),-1)));
RQCFG_100216_.old_tb5_2(21):=null;
RQCFG_100216_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(21),-1)));
RQCFG_100216_.tb5_3(21):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(21):=RQCFG_100216_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(21),
RQCFG_100216_.tb5_1(21),
RQCFG_100216_.tb5_2(21),
RQCFG_100216_.tb5_3(21),
RQCFG_100216_.tb5_4(21),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(22):=1157637;
RQCFG_100216_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(22):=RQCFG_100216_.tb3_0(22);
RQCFG_100216_.old_tb3_1(22):=2036;
RQCFG_100216_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(22),-1)));
RQCFG_100216_.old_tb3_2(22):=2683;
RQCFG_100216_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(22),-1)));
RQCFG_100216_.old_tb3_3(22):=null;
RQCFG_100216_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(22),-1)));
RQCFG_100216_.old_tb3_4(22):=null;
RQCFG_100216_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(22),-1)));
RQCFG_100216_.tb3_5(22):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(22):=121317872;
RQCFG_100216_.tb3_6(22):=NULL;
RQCFG_100216_.old_tb3_7(22):=null;
RQCFG_100216_.tb3_7(22):=NULL;
RQCFG_100216_.old_tb3_8(22):=120163734;
RQCFG_100216_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(22),
RQCFG_100216_.tb3_1(22),
RQCFG_100216_.tb3_2(22),
RQCFG_100216_.tb3_3(22),
RQCFG_100216_.tb3_4(22),
RQCFG_100216_.tb3_5(22),
RQCFG_100216_.tb3_6(22),
RQCFG_100216_.tb3_7(22),
RQCFG_100216_.tb3_8(22),
null,
105300,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(22):=1548894;
RQCFG_100216_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(22):=RQCFG_100216_.tb5_0(22);
RQCFG_100216_.old_tb5_1(22):=2683;
RQCFG_100216_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(22),-1)));
RQCFG_100216_.old_tb5_2(22):=null;
RQCFG_100216_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(22),-1)));
RQCFG_100216_.tb5_3(22):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(22):=RQCFG_100216_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(22),
RQCFG_100216_.tb5_1(22),
RQCFG_100216_.tb5_2(22),
RQCFG_100216_.tb5_3(22),
RQCFG_100216_.tb5_4(22),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(23):=1157638;
RQCFG_100216_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(23):=RQCFG_100216_.tb3_0(23);
RQCFG_100216_.old_tb3_1(23):=2036;
RQCFG_100216_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(23),-1)));
RQCFG_100216_.old_tb3_2(23):=146755;
RQCFG_100216_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(23),-1)));
RQCFG_100216_.old_tb3_3(23):=null;
RQCFG_100216_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(23),-1)));
RQCFG_100216_.old_tb3_4(23):=null;
RQCFG_100216_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(23),-1)));
RQCFG_100216_.tb3_5(23):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(23):=121317873;
RQCFG_100216_.tb3_6(23):=NULL;
RQCFG_100216_.old_tb3_7(23):=null;
RQCFG_100216_.tb3_7(23):=NULL;
RQCFG_100216_.old_tb3_8(23):=null;
RQCFG_100216_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(23),
RQCFG_100216_.tb3_1(23),
RQCFG_100216_.tb3_2(23),
RQCFG_100216_.tb3_3(23),
RQCFG_100216_.tb3_4(23),
RQCFG_100216_.tb3_5(23),
RQCFG_100216_.tb3_6(23),
RQCFG_100216_.tb3_7(23),
RQCFG_100216_.tb3_8(23),
null,
105301,
6,
'Información del Solicitante'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(23):=1548895;
RQCFG_100216_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(23):=RQCFG_100216_.tb5_0(23);
RQCFG_100216_.old_tb5_1(23):=146755;
RQCFG_100216_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(23),-1)));
RQCFG_100216_.old_tb5_2(23):=null;
RQCFG_100216_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(23),-1)));
RQCFG_100216_.tb5_3(23):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(23):=RQCFG_100216_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(23),
RQCFG_100216_.tb5_1(23),
RQCFG_100216_.tb5_2(23),
RQCFG_100216_.tb5_3(23),
RQCFG_100216_.tb5_4(23),
'Y'
,
'E'
,
6,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(24):=1157639;
RQCFG_100216_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(24):=RQCFG_100216_.tb3_0(24);
RQCFG_100216_.old_tb3_1(24):=2036;
RQCFG_100216_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(24),-1)));
RQCFG_100216_.old_tb3_2(24):=146756;
RQCFG_100216_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(24),-1)));
RQCFG_100216_.old_tb3_3(24):=null;
RQCFG_100216_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(24),-1)));
RQCFG_100216_.old_tb3_4(24):=null;
RQCFG_100216_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(24),-1)));
RQCFG_100216_.tb3_5(24):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(24):=121317874;
RQCFG_100216_.tb3_6(24):=NULL;
RQCFG_100216_.old_tb3_7(24):=null;
RQCFG_100216_.tb3_7(24):=NULL;
RQCFG_100216_.old_tb3_8(24):=null;
RQCFG_100216_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(24),
RQCFG_100216_.tb3_1(24),
RQCFG_100216_.tb3_2(24),
RQCFG_100216_.tb3_3(24),
RQCFG_100216_.tb3_4(24),
RQCFG_100216_.tb3_5(24),
RQCFG_100216_.tb3_6(24),
RQCFG_100216_.tb3_7(24),
RQCFG_100216_.tb3_8(24),
null,
105302,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(24):=1548896;
RQCFG_100216_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(24):=RQCFG_100216_.tb5_0(24);
RQCFG_100216_.old_tb5_1(24):=146756;
RQCFG_100216_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(24),-1)));
RQCFG_100216_.old_tb5_2(24):=null;
RQCFG_100216_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(24),-1)));
RQCFG_100216_.tb5_3(24):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(24):=RQCFG_100216_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(24),
RQCFG_100216_.tb5_1(24),
RQCFG_100216_.tb5_2(24),
RQCFG_100216_.tb5_3(24),
RQCFG_100216_.tb5_4(24),
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(25):=1157640;
RQCFG_100216_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(25):=RQCFG_100216_.tb3_0(25);
RQCFG_100216_.old_tb3_1(25):=2036;
RQCFG_100216_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(25),-1)));
RQCFG_100216_.old_tb3_2(25):=146754;
RQCFG_100216_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(25),-1)));
RQCFG_100216_.old_tb3_3(25):=null;
RQCFG_100216_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(25),-1)));
RQCFG_100216_.old_tb3_4(25):=null;
RQCFG_100216_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(25),-1)));
RQCFG_100216_.tb3_5(25):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(25):=null;
RQCFG_100216_.tb3_6(25):=NULL;
RQCFG_100216_.old_tb3_7(25):=null;
RQCFG_100216_.tb3_7(25):=NULL;
RQCFG_100216_.old_tb3_8(25):=null;
RQCFG_100216_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(25),
RQCFG_100216_.tb3_1(25),
RQCFG_100216_.tb3_2(25),
RQCFG_100216_.tb3_3(25),
RQCFG_100216_.tb3_4(25),
RQCFG_100216_.tb3_5(25),
RQCFG_100216_.tb3_6(25),
RQCFG_100216_.tb3_7(25),
RQCFG_100216_.tb3_8(25),
null,
105303,
8,
'Observación'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(25):=1548897;
RQCFG_100216_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(25):=RQCFG_100216_.tb5_0(25);
RQCFG_100216_.old_tb5_1(25):=146754;
RQCFG_100216_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(25),-1)));
RQCFG_100216_.old_tb5_2(25):=null;
RQCFG_100216_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(25),-1)));
RQCFG_100216_.tb5_3(25):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(25):=RQCFG_100216_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(25),
RQCFG_100216_.tb5_1(25),
RQCFG_100216_.tb5_2(25),
RQCFG_100216_.tb5_3(25),
RQCFG_100216_.tb5_4(25),
'Y'
,
'Y'
,
8,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(26):=1157641;
RQCFG_100216_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(26):=RQCFG_100216_.tb3_0(26);
RQCFG_100216_.old_tb3_1(26):=2036;
RQCFG_100216_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(26),-1)));
RQCFG_100216_.old_tb3_2(26):=39387;
RQCFG_100216_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(26),-1)));
RQCFG_100216_.old_tb3_3(26):=255;
RQCFG_100216_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(26),-1)));
RQCFG_100216_.old_tb3_4(26):=null;
RQCFG_100216_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(26),-1)));
RQCFG_100216_.tb3_5(26):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(26):=null;
RQCFG_100216_.tb3_6(26):=NULL;
RQCFG_100216_.old_tb3_7(26):=null;
RQCFG_100216_.tb3_7(26):=NULL;
RQCFG_100216_.old_tb3_8(26):=null;
RQCFG_100216_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(26),
RQCFG_100216_.tb3_1(26),
RQCFG_100216_.tb3_2(26),
RQCFG_100216_.tb3_3(26),
RQCFG_100216_.tb3_4(26),
RQCFG_100216_.tb3_5(26),
RQCFG_100216_.tb3_6(26),
RQCFG_100216_.tb3_7(26),
RQCFG_100216_.tb3_8(26),
null,
105304,
9,
'Identificador De Solicitud'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(26):=1548898;
RQCFG_100216_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(26):=RQCFG_100216_.tb5_0(26);
RQCFG_100216_.old_tb5_1(26):=39387;
RQCFG_100216_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(26),-1)));
RQCFG_100216_.old_tb5_2(26):=null;
RQCFG_100216_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(26),-1)));
RQCFG_100216_.tb5_3(26):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(26):=RQCFG_100216_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(26),
RQCFG_100216_.tb5_1(26),
RQCFG_100216_.tb5_2(26),
RQCFG_100216_.tb5_3(26),
RQCFG_100216_.tb5_4(26),
'C'
,
'Y'
,
9,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(27):=1157642;
RQCFG_100216_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(27):=RQCFG_100216_.tb3_0(27);
RQCFG_100216_.old_tb3_1(27):=2036;
RQCFG_100216_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(27),-1)));
RQCFG_100216_.old_tb3_2(27):=50000603;
RQCFG_100216_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(27),-1)));
RQCFG_100216_.old_tb3_3(27):=null;
RQCFG_100216_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(27),-1)));
RQCFG_100216_.old_tb3_4(27):=null;
RQCFG_100216_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(27),-1)));
RQCFG_100216_.tb3_5(27):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(27):=121317875;
RQCFG_100216_.tb3_6(27):=NULL;
RQCFG_100216_.old_tb3_7(27):=null;
RQCFG_100216_.tb3_7(27):=NULL;
RQCFG_100216_.old_tb3_8(27):=null;
RQCFG_100216_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(27),
RQCFG_100216_.tb3_1(27),
RQCFG_100216_.tb3_2(27),
RQCFG_100216_.tb3_3(27),
RQCFG_100216_.tb3_4(27),
RQCFG_100216_.tb3_5(27),
RQCFG_100216_.tb3_6(27),
RQCFG_100216_.tb3_7(27),
RQCFG_100216_.tb3_8(27),
null,
105305,
10,
'Identificador de suscriptor por motivo'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(27):=1548899;
RQCFG_100216_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(27):=RQCFG_100216_.tb5_0(27);
RQCFG_100216_.old_tb5_1(27):=50000603;
RQCFG_100216_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(27),-1)));
RQCFG_100216_.old_tb5_2(27):=null;
RQCFG_100216_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(27),-1)));
RQCFG_100216_.tb5_3(27):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(27):=RQCFG_100216_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(27),
RQCFG_100216_.tb5_1(27),
RQCFG_100216_.tb5_2(27),
RQCFG_100216_.tb5_3(27),
RQCFG_100216_.tb5_4(27),
'C'
,
'Y'
,
10,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(28):=1157643;
RQCFG_100216_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(28):=RQCFG_100216_.tb3_0(28);
RQCFG_100216_.old_tb3_1(28):=2036;
RQCFG_100216_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(28),-1)));
RQCFG_100216_.old_tb3_2(28):=50000606;
RQCFG_100216_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(28),-1)));
RQCFG_100216_.old_tb3_3(28):=146755;
RQCFG_100216_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(28),-1)));
RQCFG_100216_.old_tb3_4(28):=null;
RQCFG_100216_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(28),-1)));
RQCFG_100216_.tb3_5(28):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(28):=null;
RQCFG_100216_.tb3_6(28):=NULL;
RQCFG_100216_.old_tb3_7(28):=null;
RQCFG_100216_.tb3_7(28):=NULL;
RQCFG_100216_.old_tb3_8(28):=null;
RQCFG_100216_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(28),
RQCFG_100216_.tb3_1(28),
RQCFG_100216_.tb3_2(28),
RQCFG_100216_.tb3_3(28),
RQCFG_100216_.tb3_4(28),
RQCFG_100216_.tb3_5(28),
RQCFG_100216_.tb3_6(28),
RQCFG_100216_.tb3_7(28),
RQCFG_100216_.tb3_8(28),
null,
105306,
11,
'Usuario del Servicio'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(28):=1548900;
RQCFG_100216_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(28):=RQCFG_100216_.tb5_0(28);
RQCFG_100216_.old_tb5_1(28):=50000606;
RQCFG_100216_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(28),-1)));
RQCFG_100216_.old_tb5_2(28):=null;
RQCFG_100216_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(28),-1)));
RQCFG_100216_.tb5_3(28):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(28):=RQCFG_100216_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(28),
RQCFG_100216_.tb5_1(28),
RQCFG_100216_.tb5_2(28),
RQCFG_100216_.tb5_3(28),
RQCFG_100216_.tb5_4(28),
'C'
,
'Y'
,
11,
'Y'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(29):=1157644;
RQCFG_100216_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(29):=RQCFG_100216_.tb3_0(29);
RQCFG_100216_.old_tb3_1(29):=2036;
RQCFG_100216_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(29),-1)));
RQCFG_100216_.old_tb3_2(29):=149340;
RQCFG_100216_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(29),-1)));
RQCFG_100216_.old_tb3_3(29):=null;
RQCFG_100216_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(29),-1)));
RQCFG_100216_.old_tb3_4(29):=null;
RQCFG_100216_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(29),-1)));
RQCFG_100216_.tb3_5(29):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(29):=null;
RQCFG_100216_.tb3_6(29):=NULL;
RQCFG_100216_.old_tb3_7(29):=null;
RQCFG_100216_.tb3_7(29):=NULL;
RQCFG_100216_.old_tb3_8(29):=120163735;
RQCFG_100216_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(29),
RQCFG_100216_.tb3_1(29),
RQCFG_100216_.tb3_2(29),
RQCFG_100216_.tb3_3(29),
RQCFG_100216_.tb3_4(29),
RQCFG_100216_.tb3_5(29),
RQCFG_100216_.tb3_6(29),
RQCFG_100216_.tb3_7(29),
RQCFG_100216_.tb3_8(29),
null,
105307,
12,
'Relación del Solicitante con el Predio'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(29):=1548901;
RQCFG_100216_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(29):=RQCFG_100216_.tb5_0(29);
RQCFG_100216_.old_tb5_1(29):=149340;
RQCFG_100216_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(29),-1)));
RQCFG_100216_.old_tb5_2(29):=null;
RQCFG_100216_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(29),-1)));
RQCFG_100216_.tb5_3(29):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(29):=RQCFG_100216_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(29),
RQCFG_100216_.tb5_1(29),
RQCFG_100216_.tb5_2(29),
RQCFG_100216_.tb5_3(29),
RQCFG_100216_.tb5_4(29),
'Y'
,
'Y'
,
12,
'Y'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(30):=1157645;
RQCFG_100216_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(30):=RQCFG_100216_.tb3_0(30);
RQCFG_100216_.old_tb3_1(30):=2036;
RQCFG_100216_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(30),-1)));
RQCFG_100216_.old_tb3_2(30):=42118;
RQCFG_100216_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(30),-1)));
RQCFG_100216_.old_tb3_3(30):=109479;
RQCFG_100216_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(30),-1)));
RQCFG_100216_.old_tb3_4(30):=null;
RQCFG_100216_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(30),-1)));
RQCFG_100216_.tb3_5(30):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(30):=null;
RQCFG_100216_.tb3_6(30):=NULL;
RQCFG_100216_.old_tb3_7(30):=null;
RQCFG_100216_.tb3_7(30):=NULL;
RQCFG_100216_.old_tb3_8(30):=null;
RQCFG_100216_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(30),
RQCFG_100216_.tb3_1(30),
RQCFG_100216_.tb3_2(30),
RQCFG_100216_.tb3_3(30),
RQCFG_100216_.tb3_4(30),
RQCFG_100216_.tb3_5(30),
RQCFG_100216_.tb3_6(30),
RQCFG_100216_.tb3_7(30),
RQCFG_100216_.tb3_8(30),
null,
105308,
13,
'Código Canal De Ventas'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(30):=1548902;
RQCFG_100216_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(30):=RQCFG_100216_.tb5_0(30);
RQCFG_100216_.old_tb5_1(30):=42118;
RQCFG_100216_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(30),-1)));
RQCFG_100216_.old_tb5_2(30):=null;
RQCFG_100216_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(30),-1)));
RQCFG_100216_.tb5_3(30):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(30):=RQCFG_100216_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(30),
RQCFG_100216_.tb5_1(30),
RQCFG_100216_.tb5_2(30),
RQCFG_100216_.tb5_3(30),
RQCFG_100216_.tb5_4(30),
'C'
,
'Y'
,
13,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(31):=1157646;
RQCFG_100216_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(31):=RQCFG_100216_.tb3_0(31);
RQCFG_100216_.old_tb3_1(31):=2036;
RQCFG_100216_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(31),-1)));
RQCFG_100216_.old_tb3_2(31):=259;
RQCFG_100216_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(31),-1)));
RQCFG_100216_.old_tb3_3(31):=null;
RQCFG_100216_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(31),-1)));
RQCFG_100216_.old_tb3_4(31):=null;
RQCFG_100216_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(31),-1)));
RQCFG_100216_.tb3_5(31):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(31):=121317876;
RQCFG_100216_.tb3_6(31):=NULL;
RQCFG_100216_.old_tb3_7(31):=null;
RQCFG_100216_.tb3_7(31):=NULL;
RQCFG_100216_.old_tb3_8(31):=null;
RQCFG_100216_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(31),
RQCFG_100216_.tb3_1(31),
RQCFG_100216_.tb3_2(31),
RQCFG_100216_.tb3_3(31),
RQCFG_100216_.tb3_4(31),
RQCFG_100216_.tb3_5(31),
RQCFG_100216_.tb3_6(31),
RQCFG_100216_.tb3_7(31),
RQCFG_100216_.tb3_8(31),
null,
105310,
14,
'Fecha envío mensajes'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(31):=1548903;
RQCFG_100216_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(31):=RQCFG_100216_.tb5_0(31);
RQCFG_100216_.old_tb5_1(31):=259;
RQCFG_100216_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(31),-1)));
RQCFG_100216_.old_tb5_2(31):=null;
RQCFG_100216_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(31),-1)));
RQCFG_100216_.tb5_3(31):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(31):=RQCFG_100216_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(31),
RQCFG_100216_.tb5_1(31),
RQCFG_100216_.tb5_2(31),
RQCFG_100216_.tb5_3(31),
RQCFG_100216_.tb5_4(31),
'C'
,
'Y'
,
14,
'N'
,
'Fecha envío mensajes'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb3_0(32):=1157647;
RQCFG_100216_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100216_.tb3_0(32):=RQCFG_100216_.tb3_0(32);
RQCFG_100216_.old_tb3_1(32):=2036;
RQCFG_100216_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100216_.TBENTITYNAME(NVL(RQCFG_100216_.old_tb3_1(32),-1)));
RQCFG_100216_.old_tb3_2(32):=4015;
RQCFG_100216_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_2(32),-1)));
RQCFG_100216_.old_tb3_3(32):=null;
RQCFG_100216_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_3(32),-1)));
RQCFG_100216_.old_tb3_4(32):=null;
RQCFG_100216_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb3_4(32),-1)));
RQCFG_100216_.tb3_5(32):=RQCFG_100216_.tb2_2(0);
RQCFG_100216_.old_tb3_6(32):=121317877;
RQCFG_100216_.tb3_6(32):=NULL;
RQCFG_100216_.old_tb3_7(32):=null;
RQCFG_100216_.tb3_7(32):=NULL;
RQCFG_100216_.old_tb3_8(32):=null;
RQCFG_100216_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100216_.tb3_0(32),
RQCFG_100216_.tb3_1(32),
RQCFG_100216_.tb3_2(32),
RQCFG_100216_.tb3_3(32),
RQCFG_100216_.tb3_4(32),
RQCFG_100216_.tb3_5(32),
RQCFG_100216_.tb3_6(32),
RQCFG_100216_.tb3_7(32),
RQCFG_100216_.tb3_8(32),
null,
105311,
15,
'Suscriptor'
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100216_.blProcessStatus) then
 return;
end if;

RQCFG_100216_.old_tb5_0(32):=1548904;
RQCFG_100216_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100216_.tb5_0(32):=RQCFG_100216_.tb5_0(32);
RQCFG_100216_.old_tb5_1(32):=4015;
RQCFG_100216_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_1(32),-1)));
RQCFG_100216_.old_tb5_2(32):=null;
RQCFG_100216_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100216_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100216_.old_tb5_2(32),-1)));
RQCFG_100216_.tb5_3(32):=RQCFG_100216_.tb4_0(1);
RQCFG_100216_.tb5_4(32):=RQCFG_100216_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100216_.tb5_0(32),
RQCFG_100216_.tb5_1(32),
RQCFG_100216_.tb5_2(32),
RQCFG_100216_.tb5_3(32),
RQCFG_100216_.tb5_4(32),
'C'
,
'Y'
,
15,
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
RQCFG_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100216);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100216)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100216_.blProcessStatus) then
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
AND     external_root_id = 100216
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
AND     external_root_id = 100216
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
AND     external_root_id = 100216
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100216, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100216)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100216, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100216)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100216, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100216)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100216, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100216)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100216_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100216_.tbCompositions.FIRST..RQCFG_100216_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100216_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100216_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100216_.blProcessStatus := false;
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
 nuIndex := RQCFG_100216_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100216_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100216_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100216_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100216_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100216_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100216_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100216_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100216_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100216_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100216_',
'CREATE OR REPLACE PACKAGE I18N_R_100216_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100216_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100216_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100216
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
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
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(0):='M_DATOS_DEL_CLIENTE_100231'
;
I18N_R_100216_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(0),
I18N_R_100216_.tb0_1(0),
'WE8ISO8859P1'
,
'Datos del Cliente'
,
'Datos del Cliente'
,
null,
'Datos del Cliente'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(1):='M_DATOS_DEL_CLIENTE_100231'
;
I18N_R_100216_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(1),
I18N_R_100216_.tb0_1(1),
'WE8ISO8859P1'
,
'Datos del Cliente'
,
'Datos del Cliente'
,
null,
'Datos del Cliente'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(2):='M_DATOS_DEL_CLIENTE_100231'
;
I18N_R_100216_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(2),
I18N_R_100216_.tb0_1(2),
'WE8ISO8859P1'
,
'Datos del Cliente'
,
'Datos del Cliente'
,
null,
'Datos del Cliente'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(3):='PAQUETE'
;
I18N_R_100216_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(3),
I18N_R_100216_.tb0_1(3),
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
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(4):='PAQUETE'
;
I18N_R_100216_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(4),
I18N_R_100216_.tb0_1(4),
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
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(5):='PAQUETE'
;
I18N_R_100216_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(5),
I18N_R_100216_.tb0_1(5),
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
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100216_.blProcessStatus) then
 return;
end if;

I18N_R_100216_.tb0_0(6):='PAQUETE'
;
I18N_R_100216_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100216_.tb0_0(6),
I18N_R_100216_.tb0_1(6),
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
I18N_R_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100216_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100216_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100216_',
'CREATE OR REPLACE PACKAGE RQEXEC_100216_ IS ' || chr(10) ||
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
'END RQEXEC_100216_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100216_******************************'); END;
/


BEGIN

if (not RQEXEC_100216_.blProcessStatus) then
 return;
end if;

RQEXEC_100216_.old_tb0_0(0):='P_ACTUALIZACION_DE_DATOS_DE_CLIENTE_100216'
;
RQEXEC_100216_.tb0_0(0):=UPPER(RQEXEC_100216_.old_tb0_0(0));
RQEXEC_100216_.old_tb0_1(0):=200022;
RQEXEC_100216_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100216_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100216_.tb0_1(0):=RQEXEC_100216_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100216_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100216_.tb0_1(0),
DESCRIPTION='Actualización de Datos de Cliente'
,
PATH=null,
VERSION='221'
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
TIMES_EXECUTED=41,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=to_date('17-11-2018 21:12:38','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100216_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100216_.tb0_0(0),
RQEXEC_100216_.tb0_1(0),
'Actualización de Datos de Cliente'
,
null,
'221'
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
41,
'O',
to_date('17-11-2018 21:12:38','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100216_.blProcessStatus) then
 return;
end if;

RQEXEC_100216_.tb1_0(0):=1;
RQEXEC_100216_.tb1_1(0):=RQEXEC_100216_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100216_.tb1_0(0),
RQEXEC_100216_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100216_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100216_******************************'); end;
/
