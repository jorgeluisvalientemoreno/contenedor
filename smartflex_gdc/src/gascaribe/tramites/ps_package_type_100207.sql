BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100207_',
'CREATE OR REPLACE PACKAGE RQTY_100207_ IS ' || chr(10) ||
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
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100207 ' || chr(10) ||
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
'END RQTY_100207_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100207_******************************'); END;
/

BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
AND     external_root_id = 100207
)
);

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100207_.cuExpressions;
fetch RQTY_100207_.cuExpressions bulk collect INTO RQTY_100207_.tbExpressionsId;
close RQTY_100207_.cuExpressions;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100207_.tbEntityName(-1) := 'NULL';
   RQTY_100207_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100207_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQTY_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100207_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100207_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100207_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100207_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100207
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100207
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100207
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100207
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100207_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100207_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100207_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100207_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100207_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100207_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100207_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207))));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207))));

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100207_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100207_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100207_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100207_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100207_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100207_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100207_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100207_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207)));

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207));
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100207_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207);
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100207_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100207_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100207_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100207_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100207;
nuIndex binary_integer;
BEGIN

if (not RQTY_100207_.blProcessStatus) then
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100207_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100207_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100207_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100207_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100207_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100207_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100207_.tb0_0(0),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb1_0(0):=1;
RQTY_100207_.tb1_1(0):=RQTY_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100207_.tb1_0(0),
MODULE_ID=RQTY_100207_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100207_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100207_.tb1_0(0),
RQTY_100207_.tb1_1(0),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(0):=121341143;
RQTY_100207_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(0):=RQTY_100207_.tb2_0(0);
RQTY_100207_.old_tb2_1(0):='GE_EXEACTION_CT1E121341143'
;
RQTY_100207_.tb2_1(0):=RQTY_100207_.tb2_0(0);
RQTY_100207_.tb2_2(0):=RQTY_100207_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(0),
RQTY_100207_.tb2_1(0),
RQTY_100207_.tb2_2(0),
'nuSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();nuMotive = MO_BOPACKAGES.FNUGETFIRSTMOTIVE(nuSolicitud);dtRequestDate = CC_BOOSSPACKAGEDATA.FDTGETREQUESTDATE(nuSolicitud);sbSysdate = UT_DATE.FSBSTR_SYSDATE();dtSysdate = UT_CONVERT.FNUCHARTODATE(sbSysdate);nuDays = UT_DATE.FDTDIFFDATE(UT_DATE.FDTTRUNCATEDATE(dtRequestDate), UT_DATE.FDTTRUNCATEDATE(dtSysdate));nuAtribNumMaxDias = 17;nuPackageType = 100207;nuValParam = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPackageType, nuAtribNumMaxDias, true));if (nuDays > nuValParam,inuEntityID = 2012;GE_BOALERTMESSAGEPARAM.VERANDSENDNOTIF(inuEntityID,nuPackageType,null,null,osbNotifSends,osbLogNotif);,);MO_BOATTENTION.ACTCREATEPLANWF()'
,
'LBTEST'
,
to_date('09-03-2012 14:15:36','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:13','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:13','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla de Creaci¿n Plan en WorkFlow solicitud de Red'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb3_0(0):=8113;
RQTY_100207_.tb3_1(0):=RQTY_100207_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100207_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100207_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Creaci¿n Plan en WorkFlow solicitud de Red'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100207_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100207_.tb3_0(0),
RQTY_100207_.tb3_1(0),
5,
'Creaci¿n Plan en WorkFlow solicitud de Red'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb4_0(0):=RQTY_100207_.tb3_0(0);
RQTY_100207_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100207_.tb4_0(0),
VALID_MODULE_ID=RQTY_100207_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100207_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100207_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100207_.tb4_0(0),
RQTY_100207_.tb4_1(0));
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb4_0(1):=RQTY_100207_.tb3_0(0);
RQTY_100207_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100207_.tb4_0(1),
VALID_MODULE_ID=RQTY_100207_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100207_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100207_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100207_.tb4_0(1),
RQTY_100207_.tb4_1(1));
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb4_0(2):=RQTY_100207_.tb3_0(0);
RQTY_100207_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100207_.tb4_0(2),
VALID_MODULE_ID=RQTY_100207_.tb4_1(2)
 WHERE ACTION_ID = RQTY_100207_.tb4_0(2) AND VALID_MODULE_ID = RQTY_100207_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100207_.tb4_0(2),
RQTY_100207_.tb4_1(2));
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb5_0(0):=100207;
RQTY_100207_.tb5_1(0):=RQTY_100207_.tb3_0(0);
RQTY_100207_.tb5_4(0):='P_SOLICITUD_DE_RED_100207'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100207_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100207_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100207_.tb5_4(0),
DESCRIPTION='Solicitud de Red'
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
 WHERE PACKAGE_TYPE_ID = RQTY_100207_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100207_.tb5_0(0),
RQTY_100207_.tb5_1(0),
null,
null,
RQTY_100207_.tb5_4(0),
'Solicitud de Red'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(0):=105147;
RQTY_100207_.tb6_1(0):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(0):=17;
RQTY_100207_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(0),-1)));
RQTY_100207_.old_tb6_3(0):=42118;
RQTY_100207_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(0),-1)));
RQTY_100207_.old_tb6_4(0):=109479;
RQTY_100207_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(0),-1)));
RQTY_100207_.old_tb6_5(0):=null;
RQTY_100207_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(0),
ENTITY_ID=RQTY_100207_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='C¿digo Canal De Ventas'
,
DISPLAY_ORDER=10,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(0),
RQTY_100207_.tb6_1(0),
RQTY_100207_.tb6_2(0),
RQTY_100207_.tb6_3(0),
RQTY_100207_.tb6_4(0),
RQTY_100207_.tb6_5(0),
null,
null,
null,
null,
10,
'C¿digo Canal De Ventas'
,
10,
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100207_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100207_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100207_.tb0_0(1),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb1_0(1):=23;
RQTY_100207_.tb1_1(1):=RQTY_100207_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100207_.tb1_0(1),
MODULE_ID=RQTY_100207_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100207_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100207_.tb1_0(1),
RQTY_100207_.tb1_1(1),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(1):=121341147;
RQTY_100207_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(1):=RQTY_100207_.tb2_0(1);
RQTY_100207_.old_tb2_1(1):='MO_INITATRIB_CT23E121341147'
;
RQTY_100207_.tb2_1(1):=RQTY_100207_.tb2_0(1);
RQTY_100207_.tb2_2(1):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(1),
RQTY_100207_.tb2_1(1),
RQTY_100207_.tb2_2(1),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:45','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:15','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:15','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - REQUEST_DATE'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb1_0(2):=26;
RQTY_100207_.tb1_1(2):=RQTY_100207_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100207_.tb1_0(2),
MODULE_ID=RQTY_100207_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100207_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100207_.tb1_0(2),
RQTY_100207_.tb1_1(2),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(2):=121341148;
RQTY_100207_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(2):=RQTY_100207_.tb2_0(2);
RQTY_100207_.old_tb2_1(2):='MO_VALIDATTR_CT26E121341148'
;
RQTY_100207_.tb2_1(2):=RQTY_100207_.tb2_0(2);
RQTY_100207_.tb2_2(2):=RQTY_100207_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(2),
RQTY_100207_.tb2_1(2),
RQTY_100207_.tb2_2(2),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100207;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No est¿ permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro est¿ fuera del rango permitido para el tipo de solicitud");,););)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:45','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:15','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:15','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(1):=105137;
RQTY_100207_.tb6_1(1):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(1):=17;
RQTY_100207_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(1),-1)));
RQTY_100207_.old_tb6_3(1):=258;
RQTY_100207_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(1),-1)));
RQTY_100207_.old_tb6_4(1):=null;
RQTY_100207_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(1),-1)));
RQTY_100207_.old_tb6_5(1):=null;
RQTY_100207_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(1),-1)));
RQTY_100207_.tb6_7(1):=RQTY_100207_.tb2_0(1);
RQTY_100207_.tb6_8(1):=RQTY_100207_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(1),
ENTITY_ID=RQTY_100207_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(1),
VALID_EXPRESSION_ID=RQTY_100207_.tb6_8(1),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Fecha De Solicitud'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(1),
RQTY_100207_.tb6_1(1),
RQTY_100207_.tb6_2(1),
RQTY_100207_.tb6_3(1),
RQTY_100207_.tb6_4(1),
RQTY_100207_.tb6_5(1),
null,
RQTY_100207_.tb6_7(1),
RQTY_100207_.tb6_8(1),
null,
1,
'Fecha De Solicitud'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(2):=105138;
RQTY_100207_.tb6_1(2):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(2):=17;
RQTY_100207_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(2),-1)));
RQTY_100207_.old_tb6_3(2):=255;
RQTY_100207_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(2),-1)));
RQTY_100207_.old_tb6_4(2):=null;
RQTY_100207_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(2),-1)));
RQTY_100207_.old_tb6_5(2):=null;
RQTY_100207_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(2),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(2),
ENTITY_ID=RQTY_100207_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='N¿mero De Solicitud'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(2),
RQTY_100207_.tb6_1(2),
RQTY_100207_.tb6_2(2),
RQTY_100207_.tb6_3(2),
RQTY_100207_.tb6_4(2),
RQTY_100207_.tb6_5(2),
null,
null,
null,
null,
2,
'N¿mero De Solicitud'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(3):=121341149;
RQTY_100207_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(3):=RQTY_100207_.tb2_0(3);
RQTY_100207_.old_tb2_1(3):='MO_INITATRIB_CT23E121341149'
;
RQTY_100207_.tb2_1(3):=RQTY_100207_.tb2_0(3);
RQTY_100207_.tb2_2(3):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(3),
RQTY_100207_.tb2_1(3),
RQTY_100207_.tb2_2(3),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('08-03-2012 09:37:46','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:15','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:15','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb7_0(0):=120174541;
RQTY_100207_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100207_.tb7_0(0):=RQTY_100207_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100207_.tb7_0(0),
16,
'Listado de vendedores'
,
'SELECT   a.person_id ID, a.name_ DESCRIPTION FROM   GE_PERSON a'
,
'Listado de vendedores'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(3):=105139;
RQTY_100207_.tb6_1(3):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(3):=17;
RQTY_100207_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(3),-1)));
RQTY_100207_.old_tb6_3(3):=50001162;
RQTY_100207_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(3),-1)));
RQTY_100207_.old_tb6_4(3):=null;
RQTY_100207_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(3),-1)));
RQTY_100207_.old_tb6_5(3):=null;
RQTY_100207_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(3),-1)));
RQTY_100207_.tb6_6(3):=RQTY_100207_.tb7_0(0);
RQTY_100207_.tb6_7(3):=RQTY_100207_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(3),
ENTITY_ID=RQTY_100207_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(3),
STATEMENT_ID=RQTY_100207_.tb6_6(3),
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(3),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(3),
RQTY_100207_.tb6_1(3),
RQTY_100207_.tb6_2(3),
RQTY_100207_.tb6_3(3),
RQTY_100207_.tb6_4(3),
RQTY_100207_.tb6_5(3),
RQTY_100207_.tb6_6(3),
RQTY_100207_.tb6_7(3),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(4):=121341150;
RQTY_100207_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(4):=RQTY_100207_.tb2_0(4);
RQTY_100207_.old_tb2_1(4):='MO_INITATRIB_CT23E121341150'
;
RQTY_100207_.tb2_1(4):=RQTY_100207_.tb2_0(4);
RQTY_100207_.tb2_2(4):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(4),
RQTY_100207_.tb2_1(4),
RQTY_100207_.tb2_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:46','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb7_0(1):=120174542;
RQTY_100207_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100207_.tb7_0(1):=RQTY_100207_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100207_.tb7_0(1),
5,
'Lista de valores Unidad Operativa'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')'
,
'Lista de valores Unidad Operativa'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(4):=105140;
RQTY_100207_.tb6_1(4):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(4):=17;
RQTY_100207_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(4),-1)));
RQTY_100207_.old_tb6_3(4):=109479;
RQTY_100207_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(4),-1)));
RQTY_100207_.old_tb6_4(4):=null;
RQTY_100207_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(4),-1)));
RQTY_100207_.old_tb6_5(4):=null;
RQTY_100207_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(4),-1)));
RQTY_100207_.tb6_6(4):=RQTY_100207_.tb7_0(1);
RQTY_100207_.tb6_7(4):=RQTY_100207_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(4),
ENTITY_ID=RQTY_100207_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(4),
STATEMENT_ID=RQTY_100207_.tb6_6(4),
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Punto De Atenci¿n'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(4),
RQTY_100207_.tb6_1(4),
RQTY_100207_.tb6_2(4),
RQTY_100207_.tb6_3(4),
RQTY_100207_.tb6_4(4),
RQTY_100207_.tb6_5(4),
RQTY_100207_.tb6_6(4),
RQTY_100207_.tb6_7(4),
null,
null,
4,
'Punto De Atenci¿n'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(5):=121341151;
RQTY_100207_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(5):=RQTY_100207_.tb2_0(5);
RQTY_100207_.old_tb2_1(5):='MO_INITATRIB_CT23E121341151'
;
RQTY_100207_.tb2_1(5):=RQTY_100207_.tb2_0(5);
RQTY_100207_.tb2_2(5):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(5),
RQTY_100207_.tb2_1(5),
RQTY_100207_.tb2_2(5),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:46','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb7_0(2):=120174543;
RQTY_100207_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100207_.tb7_0(2):=RQTY_100207_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100207_.tb7_0(2),
5,
'Sentencia Medio de recepci¿n'
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
'Sentencia Medio de recepci¿n'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(5):=105141;
RQTY_100207_.tb6_1(5):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(5):=17;
RQTY_100207_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(5),-1)));
RQTY_100207_.old_tb6_3(5):=2683;
RQTY_100207_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(5),-1)));
RQTY_100207_.old_tb6_4(5):=null;
RQTY_100207_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(5),-1)));
RQTY_100207_.old_tb6_5(5):=109479;
RQTY_100207_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(5),-1)));
RQTY_100207_.tb6_6(5):=RQTY_100207_.tb7_0(2);
RQTY_100207_.tb6_7(5):=RQTY_100207_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(5),
ENTITY_ID=RQTY_100207_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(5),
STATEMENT_ID=RQTY_100207_.tb6_6(5),
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Medio de recepci¿n'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(5),
RQTY_100207_.tb6_1(5),
RQTY_100207_.tb6_2(5),
RQTY_100207_.tb6_3(5),
RQTY_100207_.tb6_4(5),
RQTY_100207_.tb6_5(5),
RQTY_100207_.tb6_6(5),
RQTY_100207_.tb6_7(5),
null,
null,
5,
'Medio de recepci¿n'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(6):=121341152;
RQTY_100207_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(6):=RQTY_100207_.tb2_0(6);
RQTY_100207_.old_tb2_1(6):='MO_INITATRIB_CT23E121341152'
;
RQTY_100207_.tb2_1(6):=RQTY_100207_.tb2_0(6);
RQTY_100207_.tb2_2(6):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(6),
RQTY_100207_.tb2_1(6),
RQTY_100207_.tb2_2(6),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:46','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(6):=105142;
RQTY_100207_.tb6_1(6):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(6):=17;
RQTY_100207_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(6),-1)));
RQTY_100207_.old_tb6_3(6):=146755;
RQTY_100207_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(6),-1)));
RQTY_100207_.old_tb6_4(6):=null;
RQTY_100207_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(6),-1)));
RQTY_100207_.old_tb6_5(6):=null;
RQTY_100207_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(6),-1)));
RQTY_100207_.tb6_7(6):=RQTY_100207_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(6),
ENTITY_ID=RQTY_100207_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Informaci¿n del Solicitante'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(6),
RQTY_100207_.tb6_1(6),
RQTY_100207_.tb6_2(6),
RQTY_100207_.tb6_3(6),
RQTY_100207_.tb6_4(6),
RQTY_100207_.tb6_5(6),
null,
RQTY_100207_.tb6_7(6),
null,
null,
6,
'Informaci¿n del Solicitante'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(7):=105717;
RQTY_100207_.tb6_1(7):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(7):=17;
RQTY_100207_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(7),-1)));
RQTY_100207_.old_tb6_3(7):=4015;
RQTY_100207_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(7),-1)));
RQTY_100207_.old_tb6_4(7):=146755;
RQTY_100207_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(7),-1)));
RQTY_100207_.old_tb6_5(7):=null;
RQTY_100207_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(7),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(7),
ENTITY_ID=RQTY_100207_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(7),
RQTY_100207_.tb6_1(7),
RQTY_100207_.tb6_2(7),
RQTY_100207_.tb6_3(7),
RQTY_100207_.tb6_4(7),
RQTY_100207_.tb6_5(7),
null,
null,
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(7):=121341153;
RQTY_100207_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(7):=RQTY_100207_.tb2_0(7);
RQTY_100207_.old_tb2_1(7):='MO_INITATRIB_CT23E121341153'
;
RQTY_100207_.tb2_1(7):=RQTY_100207_.tb2_0(7);
RQTY_100207_.tb2_2(7):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(7),
RQTY_100207_.tb2_1(7),
RQTY_100207_.tb2_2(7),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:45','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:16','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(8):=105136;
RQTY_100207_.tb6_1(8):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(8):=17;
RQTY_100207_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(8),-1)));
RQTY_100207_.old_tb6_3(8):=257;
RQTY_100207_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(8),-1)));
RQTY_100207_.old_tb6_4(8):=null;
RQTY_100207_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(8),-1)));
RQTY_100207_.old_tb6_5(8):=null;
RQTY_100207_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(8),-1)));
RQTY_100207_.tb6_7(8):=RQTY_100207_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(8),
ENTITY_ID=RQTY_100207_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(8),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(8),
RQTY_100207_.tb6_1(8),
RQTY_100207_.tb6_2(8),
RQTY_100207_.tb6_3(8),
RQTY_100207_.tb6_4(8),
RQTY_100207_.tb6_5(8),
null,
RQTY_100207_.tb6_7(8),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb7_0(3):=120174544;
RQTY_100207_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100207_.tb7_0(3):=RQTY_100207_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100207_.tb7_0(3),
5,
'Lista de Roles'
,
'SELECT role_id ID, description
FROM cc_role'
,
'Lista de Roles'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb8_0(0):=RQTY_100207_.tb7_0(3);
RQTY_100207_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
    <Description>Descripci¿n Del Rol </Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
    <Entity>CC_ROLE</Entity>
    <Column>DESCRIPTION</Column>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (0)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100207_.tb8_0(0),
null,
RQTY_100207_.clColumn_1,
null);

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(9):=105165;
RQTY_100207_.tb6_1(9):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(9):=9179;
RQTY_100207_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(9),-1)));
RQTY_100207_.old_tb6_3(9):=149340;
RQTY_100207_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(9),-1)));
RQTY_100207_.old_tb6_4(9):=null;
RQTY_100207_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(9),-1)));
RQTY_100207_.old_tb6_5(9):=null;
RQTY_100207_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(9),-1)));
RQTY_100207_.tb6_6(9):=RQTY_100207_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(9),
ENTITY_ID=RQTY_100207_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(9),
STATEMENT_ID=RQTY_100207_.tb6_6(9),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Relaci¿n del solicitante con el predio'
,
DISPLAY_ORDER=9,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(9),
RQTY_100207_.tb6_1(9),
RQTY_100207_.tb6_2(9),
RQTY_100207_.tb6_3(9),
RQTY_100207_.tb6_4(9),
RQTY_100207_.tb6_5(9),
RQTY_100207_.tb6_6(9),
null,
null,
null,
9,
'Relaci¿n del solicitante con el predio'
,
9,
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(8):=121341144;
RQTY_100207_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(8):=RQTY_100207_.tb2_0(8);
RQTY_100207_.old_tb2_1(8):='MO_INITATRIB_CT23E121341144'
;
RQTY_100207_.tb2_1(8):=RQTY_100207_.tb2_0(8);
RQTY_100207_.tb2_2(8):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(8),
RQTY_100207_.tb2_1(8),
RQTY_100207_.tb2_2(8),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg)'
,
'LBTEST'
,
to_date('12-03-2012 17:12:38','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:14','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - MESSAG_DELIVERY_DATE'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(10):=105162;
RQTY_100207_.tb6_1(10):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(10):=17;
RQTY_100207_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(10),-1)));
RQTY_100207_.old_tb6_3(10):=259;
RQTY_100207_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(10),-1)));
RQTY_100207_.old_tb6_4(10):=null;
RQTY_100207_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(10),-1)));
RQTY_100207_.old_tb6_5(10):=null;
RQTY_100207_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(10),-1)));
RQTY_100207_.tb6_7(10):=RQTY_100207_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(10),
ENTITY_ID=RQTY_100207_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Fecha env¿o mensajes'
,
DISPLAY_ORDER=11,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(10),
RQTY_100207_.tb6_1(10),
RQTY_100207_.tb6_2(10),
RQTY_100207_.tb6_3(10),
RQTY_100207_.tb6_4(10),
RQTY_100207_.tb6_5(10),
null,
RQTY_100207_.tb6_7(10),
null,
null,
11,
'Fecha env¿o mensajes'
,
11,
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(9):=121341145;
RQTY_100207_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(9):=RQTY_100207_.tb2_0(9);
RQTY_100207_.old_tb2_1(9):='MO_INITATRIB_CT23E121341145'
;
RQTY_100207_.tb2_1(9):=RQTY_100207_.tb2_0(9);
RQTY_100207_.tb2_2(9):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(9),
RQTY_100207_.tb2_1(9),
RQTY_100207_.tb2_2(9),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETSEQMO_SUBS_TYPE_MOTIV())'
,
'TESTOSS'
,
to_date('25-06-2007 10:29:04','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:14','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - ATTRIBUTO - MO_SUBS_TYPE_MOTIV - SUBS_TYPE_MOTIV_ID - Obtiene nuevo identificador del tipo de suscriptor por motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(11):=105163;
RQTY_100207_.tb6_1(11):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(11):=9179;
RQTY_100207_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(11),-1)));
RQTY_100207_.old_tb6_3(11):=50000603;
RQTY_100207_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(11),-1)));
RQTY_100207_.old_tb6_4(11):=null;
RQTY_100207_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(11),-1)));
RQTY_100207_.old_tb6_5(11):=null;
RQTY_100207_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(11),-1)));
RQTY_100207_.tb6_7(11):=RQTY_100207_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(11),
ENTITY_ID=RQTY_100207_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador de suscriptor por motivo'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(11),
RQTY_100207_.tb6_1(11),
RQTY_100207_.tb6_2(11),
RQTY_100207_.tb6_3(11),
RQTY_100207_.tb6_4(11),
RQTY_100207_.tb6_5(11),
null,
RQTY_100207_.tb6_7(11),
null,
null,
12,
'Identificador de suscriptor por motivo'
,
12,
'N'
,
'N'
,
'N'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(12):=105164;
RQTY_100207_.tb6_1(12):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(12):=9179;
RQTY_100207_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(12),-1)));
RQTY_100207_.old_tb6_3(12):=39387;
RQTY_100207_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(12),-1)));
RQTY_100207_.old_tb6_4(12):=255;
RQTY_100207_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(12),-1)));
RQTY_100207_.old_tb6_5(12):=null;
RQTY_100207_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(12),
ENTITY_ID=RQTY_100207_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(12),
RQTY_100207_.tb6_1(12),
RQTY_100207_.tb6_2(12),
RQTY_100207_.tb6_3(12),
RQTY_100207_.tb6_4(12),
RQTY_100207_.tb6_5(12),
null,
null,
null,
null,
13,
'Identificador De Solicitud'
,
13,
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(13):=105166;
RQTY_100207_.tb6_1(13):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(13):=9179;
RQTY_100207_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(13),-1)));
RQTY_100207_.old_tb6_3(13):=50000606;
RQTY_100207_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(13),-1)));
RQTY_100207_.old_tb6_4(13):=146755;
RQTY_100207_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(13),-1)));
RQTY_100207_.old_tb6_5(13):=null;
RQTY_100207_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(13),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(13),
ENTITY_ID=RQTY_100207_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Usuario del Servicio'
,
DISPLAY_ORDER=14,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(13),
RQTY_100207_.tb6_1(13),
RQTY_100207_.tb6_2(13),
RQTY_100207_.tb6_3(13),
RQTY_100207_.tb6_4(13),
RQTY_100207_.tb6_5(13),
null,
null,
null,
null,
14,
'Usuario del Servicio'
,
14,
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.old_tb2_0(10):=121341146;
RQTY_100207_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100207_.tb2_0(10):=RQTY_100207_.tb2_0(10);
RQTY_100207_.old_tb2_1(10):='MO_INITATRIB_CT23E121341146'
;
RQTY_100207_.tb2_1(10):=RQTY_100207_.tb2_0(10);
RQTY_100207_.tb2_2(10):=RQTY_100207_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100207_.tb2_0(10),
RQTY_100207_.tb2_1(10),
RQTY_100207_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,)'
,
'LBTEST'
,
to_date('08-03-2012 09:37:47','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:14','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:14','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(14):=105143;
RQTY_100207_.tb6_1(14):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(14):=17;
RQTY_100207_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(14),-1)));
RQTY_100207_.old_tb6_3(14):=146756;
RQTY_100207_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(14),-1)));
RQTY_100207_.old_tb6_4(14):=null;
RQTY_100207_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(14),-1)));
RQTY_100207_.old_tb6_5(14):=null;
RQTY_100207_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(14),-1)));
RQTY_100207_.tb6_7(14):=RQTY_100207_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(14),
ENTITY_ID=RQTY_100207_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100207_.tb6_7(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Direcci¿n De Respuesta'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(14),
RQTY_100207_.tb6_1(14),
RQTY_100207_.tb6_2(14),
RQTY_100207_.tb6_3(14),
RQTY_100207_.tb6_4(14),
RQTY_100207_.tb6_5(14),
null,
RQTY_100207_.tb6_7(14),
null,
null,
7,
'Direcci¿n De Respuesta'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb6_0(15):=105144;
RQTY_100207_.tb6_1(15):=RQTY_100207_.tb5_0(0);
RQTY_100207_.old_tb6_2(15):=17;
RQTY_100207_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100207_.TBENTITYNAME(NVL(RQTY_100207_.old_tb6_2(15),-1)));
RQTY_100207_.old_tb6_3(15):=146754;
RQTY_100207_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_3(15),-1)));
RQTY_100207_.old_tb6_4(15):=null;
RQTY_100207_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_4(15),-1)));
RQTY_100207_.old_tb6_5(15):=null;
RQTY_100207_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100207_.TBENTITYATTRIBUTENAME(NVL(RQTY_100207_.old_tb6_5(15),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100207_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100207_.tb6_1(15),
ENTITY_ID=RQTY_100207_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100207_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100207_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100207_.tb6_5(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Observaci¿n'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100207_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100207_.tb6_0(15),
RQTY_100207_.tb6_1(15),
RQTY_100207_.tb6_2(15),
RQTY_100207_.tb6_3(15),
RQTY_100207_.tb6_4(15),
RQTY_100207_.tb6_5(15),
null,
null,
null,
null,
8,
'Observaci¿n'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb9_0(0):=5000011;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100207_.tb9_0(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=1,
ATTRIBUTE_CLASS_ID=8,
NAME_ATTRIBUTE='DAYS_MAX_PACKAGE'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='N¿mero de d¿as m¿ximo para no tener en cuenta la solicitud'
,
DISPLAY_NAME='N¿mero de d¿as m¿ximo para no tener en cuenta la solicitud'

 WHERE ATTRIBUTE_ID = RQTY_100207_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100207_.tb9_0(0),
null,
null,
1,
1,
8,
'DAYS_MAX_PACKAGE'
,
null,
null,
null,
null,
null,
'N¿mero de d¿as m¿ximo para no tener en cuenta la solicitud'
,
'N¿mero de d¿as m¿ximo para no tener en cuenta la solicitud'
);
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb10_0(0):=RQTY_100207_.tb5_0(0);
RQTY_100207_.tb10_1(0):=RQTY_100207_.tb9_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100207_.tb10_0(0),
RQTY_100207_.tb10_1(0),
'N¿mero de d¿as m¿ximo para no tener en cuenta la solicitud'
,
'1'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb9_0(1):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100207_.tb9_0(1),
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

 WHERE ATTRIBUTE_ID = RQTY_100207_.tb9_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100207_.tb9_0(1),
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb10_0(1):=RQTY_100207_.tb5_0(0);
RQTY_100207_.tb10_1(1):=RQTY_100207_.tb9_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100207_.tb10_0(1),
RQTY_100207_.tb10_1(1),
'N¿mero m¿ximo de d¿as'
,
'5'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb11_0(0):=10000000208;
RQTY_100207_.tb11_1(0):=RQTY_100207_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100207_.tb11_0(0),
PACKAGE_TYPE_ID=RQTY_100207_.tb11_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=100351,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100207_.tb11_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100207_.tb11_0(0),
RQTY_100207_.tb11_1(0),
null,
null,
100351,
21);
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb12_0(0):=100208;
RQTY_100207_.tb12_1(0):=RQTY_100207_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100207_.tb12_0(0),
VALUE_1=RQTY_100207_.tb12_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=100351,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Solicitud de Red'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100207_.tb12_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100207_.tb12_0(0),
RQTY_100207_.tb12_1(0),
null,
21,
100351,
0,
31536000,
0,
'Solicitud de Red'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb13_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100207_.tb13_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb14_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100207_.tb14_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb15_0(0):=225;
RQTY_100207_.tb15_2(0):=RQTY_100207_.tb13_0(0);
RQTY_100207_.tb15_3(0):=RQTY_100207_.tb14_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100207_.tb15_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100207_.tb15_2(0),
SERVSETI=RQTY_100207_.tb15_3(0),
SERVDESC='Patr¿n'
,
SERVCOEX='225'
,
SERVFLST='N'
,
SERVFLBA='N'
,
SERVFLAC='N'
,
SERVFLIM='N'
,
SERVPRRE=0,
SERVFLFR=null,
SERVFLRE=null,
SERVAPFR=null,
SERVVAAF=null,
SERVFLPC='N'
,
SERVTECO=null,
SERVFLFI=null,
SERVNVEC=null,
SERVLIQU='N'
,
SERVNPRC=null,
SERVORLE=1,
SERVREUB='N'
,
SERVCEDI='N'
,
SERVTXML='PR_PATRON'
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
 WHERE SERVCODI = RQTY_100207_.tb15_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100207_.tb15_0(0),
null,
RQTY_100207_.tb15_2(0),
RQTY_100207_.tb15_3(0),
'Patr¿n'
,
'225'
,
'N'
,
'N'
,
'N'
,
'N'
,
0,
null,
null,
null,
null,
'N'
,
null,
null,
null,
'N'
,
null,
1,
'N'
,
'N'
,
'PR_PATRON'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb16_0(0):=36;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100207_.tb16_0(0),
CLASS_REGISTER_ID=601,
DESCRIPTION='QUEJAS'
,
ASSIGNABLE='Y'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_QUEJAS'
,
ACTIVITY_TYPE=null
 WHERE MOTIVE_TYPE_ID = RQTY_100207_.tb16_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100207_.tb16_0(0),
601,
'QUEJAS'
,
'Y'
,
'Y'
,
'MOTY_QUEJAS'
,
null);
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb17_0(0):=100205;
RQTY_100207_.tb17_1(0):=RQTY_100207_.tb15_0(0);
RQTY_100207_.tb17_2(0):=RQTY_100207_.tb16_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100207_.tb17_0(0),
RQTY_100207_.tb17_1(0),
RQTY_100207_.tb17_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_SOLICITUD_DE_RED_100205'
,
'Solicitud de Red'
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
RQTY_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;

RQTY_100207_.tb18_0(0):=100205;
RQTY_100207_.tb18_1(0):=RQTY_100207_.tb17_0(0);
RQTY_100207_.tb18_3(0):=RQTY_100207_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100207_.tb18_0(0),
PRODUCT_MOTIVE_ID=RQTY_100207_.tb18_1(0),
PRODUCT_TYPE_ID=225,
PACKAGE_TYPE_ID=RQTY_100207_.tb18_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100207_.tb18_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100207_.tb18_0(0),
RQTY_100207_.tb18_1(0),
225,
RQTY_100207_.tb18_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100207_.blProcessStatus := false;
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
nuIndex := RQTY_100207_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100207_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100207_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100207_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100207_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100207_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100207_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100207_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100207_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100207_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100207_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100207_.blProcessStatus := false;
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
 nuIndex := RQTY_100207_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100207_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100207_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100207_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100207_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100207_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100207_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100207_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100207_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100207_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100207_',
'CREATE OR REPLACE PACKAGE RQPMT_100207_ IS ' || chr(10) ||
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
'tb5_0 ty5_0;type ty6_0 is table of GE_STATEMENT_COLUMNS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of PS_PROD_MOTI_EVENTS.PROD_MOTI_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_PROD_MOTI_EVENTS.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty8_0 is table of PS_WHEN_MOTIVE.WHEN_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of PS_WHEN_MOTIVE.PROD_MOTI_EVENTS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of PS_WHEN_MOTIVE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 100207; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100207 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100207 ' || chr(10) ||
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
'END RQPMT_100207_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100207_******************************'); END;
/

BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100207_.cuExpressions;
fetch RQPMT_100207_.cuExpressions bulk collect INTO RQPMT_100207_.tbExpressionsId;
close RQPMT_100207_.cuExpressions;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100207_.tbEntityName(-1) := 'NULL';
   RQPMT_100207_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100207_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100207_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100207_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQPMT_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100207_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityAttributeName(455) := 'MO_MOTIVE@CUSTOM_DECISION_FLAG';
   RQPMT_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100207_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQPMT_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQPMT_100207_.tbEntityAttributeName(90170588) := 'LDC_DATOS_SOL_RED_CUS_FAL@DIRECCION_SOL';
   RQPMT_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQPMT_100207_.tbEntityAttributeName(90170589) := 'LDC_DATOS_SOL_RED_CUS_FAL@COMMENT_LEGA_FAL';
   RQPMT_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100207_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQPMT_100207_.tbEntityAttributeName(90170587) := 'LDC_DATOS_SOL_RED_CUS_FAL@NRO_SOLICITUD';
   RQPMT_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100207_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100207
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
WHERE PACKAGE_type_id = 100207
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
WHERE PACKAGE_type_id = 100207
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
WHERE PACKAGE_type_id = 100207
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
WHERE PACKAGE_type_id = 100207
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
WHERE PACKAGE_type_id = 100207
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100207_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100207
))));

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100207_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100207_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100207_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100207_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100207
))));

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100207
))));

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100207_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100207_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100207
)))));

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100207_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100207_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100207_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100207_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100207_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100207_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100207
))));

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
))));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100207
))));

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
)));
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100207_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100207_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100207_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100207_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100207_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100207_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100207_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100207
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb0_0(0):=100205;
RQPMT_100207_.tb0_1(0):=225;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100207_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100207_.tb0_1(0),
MOTIVE_TYPE_ID=36,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_SOLICITUD_DE_RED_100205'
,
DESCRIPTION='Solicitud de Red'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100207_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100207_.tb0_0(0),
RQPMT_100207_.tb0_1(0),
36,
null,
'N'
,
'N'
,
'N'
,
'M_SOLICITUD_DE_RED_100205'
,
'Solicitud de Red'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb1_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100207_.tb1_0(0),
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

 WHERE MODULE_ID = RQPMT_100207_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100207_.tb1_0(0),
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb2_0(0):=26;
RQPMT_100207_.tb2_1(0):=RQPMT_100207_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100207_.tb2_0(0),
MODULE_ID=RQPMT_100207_.tb2_1(0),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100207_.tb2_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100207_.tb2_0(0),
RQPMT_100207_.tb2_1(0),
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(0):=121341155;
RQPMT_100207_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(0):=RQPMT_100207_.tb3_0(0);
RQPMT_100207_.old_tb3_1(0):='MO_VALIDATTR_CT26E121341155'
;
RQPMT_100207_.tb3_1(0):=RQPMT_100207_.tb3_0(0);
RQPMT_100207_.tb3_2(0):=RQPMT_100207_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(0),
RQPMT_100207_.tb3_1(0),
RQPMT_100207_.tb3_2(0),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(isbAddressID);inuAddressID = UT_CONVERT.FNUCHARTONUMBER(isbAddressID);isbTagPackType = "P_SOLICITUD_DE_RED_100207";nuEstadoFinal = "N";onuPackageID = MO_BOADDRESS.FNUVALPACKINADDRESS(inuAddressID, isbTagPackType, nuEstadoFinal, null);if (onuPackageID <> null,if (LDC_CONFIGURACIONRQ.APLICAPARAGDO("CRM_JLVM_RNP_191") = TRUE,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La direcci¿n ingresada tiene una Solicitud de Red pendiente");,);,nuEstadoFinal = "Y";onuPackageID = MO_BOADDRESS.FNUVALPACKINADDRESS(inuAddressID, isbTagPackType, nuEstadoFinal, null);if (onuPackageID <> null,dtFechaUltimaSolicitud = CC_BOBOSSUTIL.FDTREQUESTDATE(onuPackageID);nuDiferenciaFechas = UT_DATE.FDTDIFFDATE(UT_DATE.FDTSYSDATE(), dtFechaUltimaSolicitud);if (nuDiferenciaFechas < UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(100207, 5000011, FALSE)),if (LDC_CONFIGURACIONRQ.APLICAPARAGDO("CRM_JLVM_RNP_191") = TRUE,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La direcci¿n' ||
' ingresada tiene una Solicitud de Red atendida antes de los d¿as indicados en el par¿metro");,);,);,););nuEstadoProductoFacturable = null;nuProductosInstalados = PR_BOPRODUCT.FSBVALPRODINADDRESS(inuAddressID, nuEstadoProductoFacturable);if (nuProductosInstalados = "Y",if (LDC_CONFIGURACIONRQ.APLICAPARAGDO("CRM_JLVM_RNP_191") = TRUE,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"En la direcci¿n ingresada existe registrado un producto");,);,);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.LOADENTITYOLDVALUESID(sbInstance,null,"AB_ADDRESS",inuAddressID,TRUE,FALSE,TRUE);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_MOTIVE","MOTIVE_ID",onuMotiveID);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"AB_ADDRESS","ADDRESS",onuAddress);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"AB_ADDRESS","ADDRESS_ID",onuParserAddressID);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"AB_ADDRESS","GEOGRAP_LOCATION_ID",onuGeograpLocationID);os' ||
'bIsAddressMain = "N";GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","MOTIVE_ID",onuMotiveID,TRUE);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","ADDRESS",onuAddress,TRUE);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","PARSER_ADDRESS_ID",onuParserAddressID,TRUE);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","GEOGRAP_LOCATION_ID",onuGeograpLocationID,TRUE);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","IS_ADDRESS_MAIN",osbIsAddressMain,TRUE);nuAddressTypeId = GE_BOPARAMETER.FNUGET("ADDRESS_TYPE_PRINCIP", "Y");GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","ADDRESS_TYPE_ID",nuAddressTypeId,TRUE)'
,
'LBTEST'
,
to_date('21-03-2012 14:37:34','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:35','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:35','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MOT - MO_PROCESS - ADDRESS_MAIN_MOTIVE - Validaci¿n que la direcci¿n no tenga solicitud de red pendiente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(0):=103075;
RQPMT_100207_.old_tb4_1(0):=68;
RQPMT_100207_.tb4_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(0),-1)));
RQPMT_100207_.old_tb4_2(0):=1035;
RQPMT_100207_.tb4_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(0),-1)));
RQPMT_100207_.old_tb4_3(0):=null;
RQPMT_100207_.tb4_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(0),-1)));
RQPMT_100207_.old_tb4_4(0):=null;
RQPMT_100207_.tb4_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(0),-1)));
RQPMT_100207_.tb4_7(0):=RQPMT_100207_.tb3_0(0);
RQPMT_100207_.tb4_9(0):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(0),
ENTITY_ID=RQPMT_100207_.tb4_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100207_.tb4_7(0),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(0),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Direcci¿n de Instalaci¿n'
,
DISPLAY_ORDER=0,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='DIRECCI_N_DE_INSTALACI_N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(0),
RQPMT_100207_.tb4_1(0),
RQPMT_100207_.tb4_2(0),
RQPMT_100207_.tb4_3(0),
RQPMT_100207_.tb4_4(0),
null,
null,
RQPMT_100207_.tb4_7(0),
null,
RQPMT_100207_.tb4_9(0),
0,
'Direcci¿n de Instalaci¿n'
,
0,
'Y'
,
'N'
,
'N'
,
'Y'
,
'DIRECCI_N_DE_INSTALACI_N'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb5_0(0):=120174546;
RQPMT_100207_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100207_.tb5_0(0):=RQPMT_100207_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100207_.tb5_0(0),
16,
'Lista de estrato'
,
'SELECT sucacodi id,sucadesc description
FROM subcateg
WHERE sucacate = to_number(ge_boInstanceControl.fsbGetFieldValue('|| chr(39) ||'MO_MOTIVE'|| chr(39) ||','|| chr(39) ||'CATEGORY_ID'|| chr(39) ||'))'
,
'Lista de estrato'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(1):=103028;
RQPMT_100207_.old_tb4_1(1):=8;
RQPMT_100207_.tb4_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(1),-1)));
RQPMT_100207_.old_tb4_2(1):=147337;
RQPMT_100207_.tb4_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(1),-1)));
RQPMT_100207_.old_tb4_3(1):=null;
RQPMT_100207_.tb4_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(1),-1)));
RQPMT_100207_.old_tb4_4(1):=147336;
RQPMT_100207_.tb4_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(1),-1)));
RQPMT_100207_.tb4_5(1):=RQPMT_100207_.tb5_0(0);
RQPMT_100207_.tb4_9(1):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(1),
ENTITY_ID=RQPMT_100207_.tb4_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(1),
STATEMENT_ID=RQPMT_100207_.tb4_5(1),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(1),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Subcategor¿a'
,
DISPLAY_ORDER=2,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(1),
RQPMT_100207_.tb4_1(1),
RQPMT_100207_.tb4_2(1),
RQPMT_100207_.tb4_3(1),
RQPMT_100207_.tb4_4(1),
RQPMT_100207_.tb4_5(1),
null,
null,
null,
RQPMT_100207_.tb4_9(1),
2,
'Subcategor¿a'
,
2,
'Y'
,
'N'
,
'N'
,
'Y'
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
'Y'
);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(2):=103029;
RQPMT_100207_.old_tb4_1(2):=8;
RQPMT_100207_.tb4_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(2),-1)));
RQPMT_100207_.old_tb4_2(2):=144591;
RQPMT_100207_.tb4_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(2),-1)));
RQPMT_100207_.old_tb4_3(2):=null;
RQPMT_100207_.tb4_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(2),-1)));
RQPMT_100207_.old_tb4_4(2):=null;
RQPMT_100207_.tb4_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(2),-1)));
RQPMT_100207_.tb4_9(2):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(2),
ENTITY_ID=RQPMT_100207_.tb4_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(2),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Respuesta De Atenci¿n'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(2),
RQPMT_100207_.tb4_1(2),
RQPMT_100207_.tb4_2(2),
RQPMT_100207_.tb4_3(2),
RQPMT_100207_.tb4_4(2),
null,
null,
null,
null,
RQPMT_100207_.tb4_9(2),
4,
'Respuesta De Atenci¿n'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(1):=121341157;
RQPMT_100207_.tb3_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(1):=RQPMT_100207_.tb3_0(1);
RQPMT_100207_.old_tb3_1(1):='MO_VALIDATTR_CT26E121341157'
;
RQPMT_100207_.tb3_1(1):=RQPMT_100207_.tb3_0(1);
RQPMT_100207_.tb3_2(1):=RQPMT_100207_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(1),
RQPMT_100207_.tb3_1(1),
RQPMT_100207_.tb3_2(1),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbflag);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",NULL,"MO_MOTIVE","CUSTOM_DECISION_FLAG",sbflag,TRUE)'
,
'OPEN'
,
to_date('23-11-2018 10:12:45','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'instancia documentacion completa'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb2_0(1):=23;
RQPMT_100207_.tb2_1(1):=RQPMT_100207_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100207_.tb2_0(1),
MODULE_ID=RQPMT_100207_.tb2_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100207_.tb2_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100207_.tb2_0(1),
RQPMT_100207_.tb2_1(1),
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(2):=121341158;
RQPMT_100207_.tb3_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(2):=RQPMT_100207_.tb3_0(2);
RQPMT_100207_.old_tb3_1(2):='MO_INITATRIB_CT23E121341158'
;
RQPMT_100207_.tb3_1(2):=RQPMT_100207_.tb3_0(2);
RQPMT_100207_.tb3_2(2):=RQPMT_100207_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(2),
RQPMT_100207_.tb3_1(2),
RQPMT_100207_.tb3_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'OPEN'
,
to_date('26-11-2018 21:27:44','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'inicializa atributo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(3):=103034;
RQPMT_100207_.old_tb4_1(3):=8;
RQPMT_100207_.tb4_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(3),-1)));
RQPMT_100207_.old_tb4_2(3):=455;
RQPMT_100207_.tb4_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(3),-1)));
RQPMT_100207_.old_tb4_3(3):=null;
RQPMT_100207_.tb4_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(3),-1)));
RQPMT_100207_.old_tb4_4(3):=null;
RQPMT_100207_.tb4_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(3),-1)));
RQPMT_100207_.tb4_6(3):=RQPMT_100207_.tb3_0(2);
RQPMT_100207_.tb4_7(3):=RQPMT_100207_.tb3_0(1);
RQPMT_100207_.tb4_9(3):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(3),
ENTITY_ID=RQPMT_100207_.tb4_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100207_.tb4_6(3),
VALID_EXPRESSION_ID=RQPMT_100207_.tb4_7(3),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(3),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Documentaci¿n Completa'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='DOCUMENTACI_N_COMPLETA'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(3),
RQPMT_100207_.tb4_1(3),
RQPMT_100207_.tb4_2(3),
RQPMT_100207_.tb4_3(3),
RQPMT_100207_.tb4_4(3),
null,
RQPMT_100207_.tb4_6(3),
RQPMT_100207_.tb4_7(3),
null,
RQPMT_100207_.tb4_9(3),
3,
'Documentaci¿n Completa'
,
3,
'Y'
,
'N'
,
'N'
,
'Y'
,
'DOCUMENTACI_N_COMPLETA'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(3):=121341159;
RQPMT_100207_.tb3_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(3):=RQPMT_100207_.tb3_0(3);
RQPMT_100207_.old_tb3_1(3):='MO_INITATRIB_CT23E121341159'
;
RQPMT_100207_.tb3_1(3):=RQPMT_100207_.tb3_0(3);
RQPMT_100207_.tb3_2(3):=RQPMT_100207_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(3),
RQPMT_100207_.tb3_1(3),
RQPMT_100207_.tb3_2(3),
'nuMotiveID = MO_BOSEQUENCES.FNUGETMOTIVEID();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuMotiveID)'
,
'LBTEST'
,
to_date('12-03-2012 17:56:08','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - MOTIVE_ID - Secuencia Motive_id'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(4):=103043;
RQPMT_100207_.old_tb4_1(4):=8;
RQPMT_100207_.tb4_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(4),-1)));
RQPMT_100207_.old_tb4_2(4):=187;
RQPMT_100207_.tb4_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(4),-1)));
RQPMT_100207_.old_tb4_3(4):=null;
RQPMT_100207_.tb4_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(4),-1)));
RQPMT_100207_.old_tb4_4(4):=null;
RQPMT_100207_.tb4_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(4),-1)));
RQPMT_100207_.tb4_6(4):=RQPMT_100207_.tb3_0(3);
RQPMT_100207_.tb4_9(4):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(4),
ENTITY_ID=RQPMT_100207_.tb4_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100207_.tb4_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(4),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='C¿digo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(4),
RQPMT_100207_.tb4_1(4),
RQPMT_100207_.tb4_2(4),
RQPMT_100207_.tb4_3(4),
RQPMT_100207_.tb4_4(4),
null,
RQPMT_100207_.tb4_6(4),
null,
null,
RQPMT_100207_.tb4_9(4),
5,
'C¿digo'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(5):=103044;
RQPMT_100207_.old_tb4_1(5):=8;
RQPMT_100207_.tb4_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(5),-1)));
RQPMT_100207_.old_tb4_2(5):=213;
RQPMT_100207_.tb4_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(5),-1)));
RQPMT_100207_.old_tb4_3(5):=255;
RQPMT_100207_.tb4_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(5),-1)));
RQPMT_100207_.old_tb4_4(5):=null;
RQPMT_100207_.tb4_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(5),-1)));
RQPMT_100207_.tb4_9(5):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(5),
ENTITY_ID=RQPMT_100207_.tb4_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(5),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Solicitud'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(5),
RQPMT_100207_.tb4_1(5),
RQPMT_100207_.tb4_2(5),
RQPMT_100207_.tb4_3(5),
RQPMT_100207_.tb4_4(5),
null,
null,
null,
null,
RQPMT_100207_.tb4_9(5),
6,
'Solicitud'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(6):=105561;
RQPMT_100207_.old_tb4_1(6):=5105;
RQPMT_100207_.tb4_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(6),-1)));
RQPMT_100207_.old_tb4_2(6):=90170587;
RQPMT_100207_.tb4_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(6),-1)));
RQPMT_100207_.old_tb4_3(6):=255;
RQPMT_100207_.tb4_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(6),-1)));
RQPMT_100207_.old_tb4_4(6):=null;
RQPMT_100207_.tb4_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(6),-1)));
RQPMT_100207_.tb4_9(6):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(6),
ENTITY_ID=RQPMT_100207_.tb4_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(6),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Solicitud'
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
ENTITY_NAME='LDC_DATOS_SOL_RED_CUS_FAL'
,
ATTRI_TECHNICAL_NAME='NRO_SOLICITUD'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(6),
RQPMT_100207_.tb4_1(6),
RQPMT_100207_.tb4_2(6),
RQPMT_100207_.tb4_3(6),
RQPMT_100207_.tb4_4(6),
null,
null,
null,
null,
RQPMT_100207_.tb4_9(6),
9,
'Solicitud'
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
'LDC_DATOS_SOL_RED_CUS_FAL'
,
'NRO_SOLICITUD'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(7):=105562;
RQPMT_100207_.old_tb4_1(7):=5105;
RQPMT_100207_.tb4_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(7),-1)));
RQPMT_100207_.old_tb4_2(7):=90170588;
RQPMT_100207_.tb4_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(7),-1)));
RQPMT_100207_.old_tb4_3(7):=1035;
RQPMT_100207_.tb4_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(7),-1)));
RQPMT_100207_.old_tb4_4(7):=null;
RQPMT_100207_.tb4_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(7),-1)));
RQPMT_100207_.tb4_9(7):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(7),
ENTITY_ID=RQPMT_100207_.tb4_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(7),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Direccion instalacion'
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
TAG_NAME='DIRECCION_INSTALACION'
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
ENTITY_NAME='LDC_DATOS_SOL_RED_CUS_FAL'
,
ATTRI_TECHNICAL_NAME='DIRECCION_SOL'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(7),
RQPMT_100207_.tb4_1(7),
RQPMT_100207_.tb4_2(7),
RQPMT_100207_.tb4_3(7),
RQPMT_100207_.tb4_4(7),
null,
null,
null,
null,
RQPMT_100207_.tb4_9(7),
10,
'Direccion instalacion'
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
'DIRECCION_INSTALACION'
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
'LDC_DATOS_SOL_RED_CUS_FAL'
,
'DIRECCION_SOL'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(4):=121341160;
RQPMT_100207_.tb3_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(4):=RQPMT_100207_.tb3_0(4);
RQPMT_100207_.old_tb3_1(4):='MO_VALIDATTR_CT26E121341160'
;
RQPMT_100207_.tb3_1(4):=RQPMT_100207_.tb3_0(4);
RQPMT_100207_.tb3_2(4):=RQPMT_100207_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(4),
RQPMT_100207_.tb3_1(4),
RQPMT_100207_.tb3_2(4),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbcomentario);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",NULL,"LDC_DATOS_SOL_RED_CUS_FAL","COMMENT_LEGA_FAL",sbcomentario,TRUE)'
,
'OPEN'
,
to_date('01-12-2018 10:32:10','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'instancia comentario'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(8):=105563;
RQPMT_100207_.old_tb4_1(8):=5105;
RQPMT_100207_.tb4_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(8),-1)));
RQPMT_100207_.old_tb4_2(8):=90170589;
RQPMT_100207_.tb4_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(8),-1)));
RQPMT_100207_.old_tb4_3(8):=null;
RQPMT_100207_.tb4_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(8),-1)));
RQPMT_100207_.old_tb4_4(8):=null;
RQPMT_100207_.tb4_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(8),-1)));
RQPMT_100207_.tb4_7(8):=RQPMT_100207_.tb3_0(4);
RQPMT_100207_.tb4_9(8):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(8),
ENTITY_ID=RQPMT_100207_.tb4_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100207_.tb4_7(8),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(8),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Observacion legalizacion'
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
TAG_NAME='OBSERVACION_LEGALIZACION'
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
ENTITY_NAME='LDC_DATOS_SOL_RED_CUS_FAL'
,
ATTRI_TECHNICAL_NAME='COMMENT_LEGA_FAL'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(8),
RQPMT_100207_.tb4_1(8),
RQPMT_100207_.tb4_2(8),
RQPMT_100207_.tb4_3(8),
RQPMT_100207_.tb4_4(8),
null,
null,
RQPMT_100207_.tb4_7(8),
null,
RQPMT_100207_.tb4_9(8),
11,
'Observacion legalizacion'
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
'OBSERVACION_LEGALIZACION'
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
'LDC_DATOS_SOL_RED_CUS_FAL'
,
'COMMENT_LEGA_FAL'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(5):=121341156;
RQPMT_100207_.tb3_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(5):=RQPMT_100207_.tb3_0(5);
RQPMT_100207_.old_tb3_1(5):='MO_INITATRIB_CT23E121341156'
;
RQPMT_100207_.tb3_1(5):=RQPMT_100207_.tb3_0(5);
RQPMT_100207_.tb3_2(5):=RQPMT_100207_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(5),
RQPMT_100207_.tb3_1(5),
RQPMT_100207_.tb3_2(5),
'nuSecuencia = PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_MO_ADDRESS");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSecuencia)'
,
'LBTEST'
,
to_date('21-03-2012 14:37:34','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
to_date('18-07-2019 09:51:37','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_ADDRESS - ADDRESS_ID - Inicializa la secuencia de address_id.rule'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(9):=103076;
RQPMT_100207_.old_tb4_1(9):=21;
RQPMT_100207_.tb4_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(9),-1)));
RQPMT_100207_.old_tb4_2(9):=474;
RQPMT_100207_.tb4_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(9),-1)));
RQPMT_100207_.old_tb4_3(9):=null;
RQPMT_100207_.tb4_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(9),-1)));
RQPMT_100207_.old_tb4_4(9):=null;
RQPMT_100207_.tb4_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(9),-1)));
RQPMT_100207_.tb4_6(9):=RQPMT_100207_.tb3_0(5);
RQPMT_100207_.tb4_9(9):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(9),
ENTITY_ID=RQPMT_100207_.tb4_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100207_.tb4_6(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(9),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='C¿digo de la Direcci¿n'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(9),
RQPMT_100207_.tb4_1(9),
RQPMT_100207_.tb4_2(9),
RQPMT_100207_.tb4_3(9),
RQPMT_100207_.tb4_4(9),
null,
RQPMT_100207_.tb4_6(9),
null,
null,
RQPMT_100207_.tb4_9(9),
7,
'C¿digo de la Direcci¿n'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(10):=103077;
RQPMT_100207_.old_tb4_1(10):=21;
RQPMT_100207_.tb4_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(10),-1)));
RQPMT_100207_.old_tb4_2(10):=39322;
RQPMT_100207_.tb4_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(10),-1)));
RQPMT_100207_.old_tb4_3(10):=255;
RQPMT_100207_.tb4_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(10),-1)));
RQPMT_100207_.old_tb4_4(10):=null;
RQPMT_100207_.tb4_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(10),-1)));
RQPMT_100207_.tb4_9(10):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(10),
ENTITY_ID=RQPMT_100207_.tb4_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(10),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Identificador De Solicitud'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(10),
RQPMT_100207_.tb4_1(10),
RQPMT_100207_.tb4_2(10),
RQPMT_100207_.tb4_3(10),
RQPMT_100207_.tb4_4(10),
null,
null,
null,
null,
RQPMT_100207_.tb4_9(10),
8,
'Identificador De Solicitud'
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb5_0(1):=120174545;
RQPMT_100207_.tb5_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100207_.tb5_0(1):=RQPMT_100207_.tb5_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100207_.tb5_0(1),
16,
'Lista de uso del servicio'
,
'SELECT catecodi id,catedesc description
FROM categori'
,
'Lista de uso del servicio'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb6_0(0):=RQPMT_100207_.tb5_0(1);
RQPMT_100207_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ID</Name>
    <Description>ID</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPTION</Name>
    <Description>DESCRIPTION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT_COLUMNS fila (0)',1);
UPDATE GE_STATEMENT_COLUMNS SET STATEMENT_ID=RQPMT_100207_.tb6_0(0),
WIZARD_COLUMNS=null,
SELECT_COLUMNS=RQPMT_100207_.clColumn_1,
LIST_VALUES=null
 WHERE STATEMENT_ID = RQPMT_100207_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQPMT_100207_.tb6_0(0),
null,
RQPMT_100207_.clColumn_1,
null);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb4_0(11):=103027;
RQPMT_100207_.old_tb4_1(11):=8;
RQPMT_100207_.tb4_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100207_.TBENTITYNAME(NVL(RQPMT_100207_.old_tb4_1(11),-1)));
RQPMT_100207_.old_tb4_2(11):=147336;
RQPMT_100207_.tb4_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_2(11),-1)));
RQPMT_100207_.old_tb4_3(11):=null;
RQPMT_100207_.tb4_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_3(11),-1)));
RQPMT_100207_.old_tb4_4(11):=null;
RQPMT_100207_.tb4_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100207_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100207_.old_tb4_4(11),-1)));
RQPMT_100207_.tb4_5(11):=RQPMT_100207_.tb5_0(1);
RQPMT_100207_.tb4_9(11):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100207_.tb4_0(11),
ENTITY_ID=RQPMT_100207_.tb4_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100207_.tb4_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100207_.tb4_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100207_.tb4_4(11),
STATEMENT_ID=RQPMT_100207_.tb4_5(11),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb4_9(11),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Categor¿a'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
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
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100207_.tb4_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100207_.tb4_0(11),
RQPMT_100207_.tb4_1(11),
RQPMT_100207_.tb4_2(11),
RQPMT_100207_.tb4_3(11),
RQPMT_100207_.tb4_4(11),
RQPMT_100207_.tb4_5(11),
null,
null,
null,
RQPMT_100207_.tb4_9(11),
1,
'Categor¿a'
,
1,
'Y'
,
'N'
,
'N'
,
'Y'
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
'Y'
);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb7_0(0):=10168;
RQPMT_100207_.tb7_1(0):=RQPMT_100207_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_EVENTS fila (0)',1);
UPDATE PS_PROD_MOTI_EVENTS SET PROD_MOTI_EVENTS_ID=RQPMT_100207_.tb7_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100207_.tb7_1(0),
EVENT_ID=1
 WHERE PROD_MOTI_EVENTS_ID = RQPMT_100207_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_EVENTS(PROD_MOTI_EVENTS_ID,PRODUCT_MOTIVE_ID,EVENT_ID) 
VALUES (RQPMT_100207_.tb7_0(0),
RQPMT_100207_.tb7_1(0),
1);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb2_0(2):=65;
RQPMT_100207_.tb2_1(2):=RQPMT_100207_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100207_.tb2_0(2),
MODULE_ID=RQPMT_100207_.tb2_1(2),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100207_.tb2_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100207_.tb2_0(2),
RQPMT_100207_.tb2_1(2),
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
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.old_tb3_0(6):=121342428;
RQPMT_100207_.tb3_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100207_.tb3_0(6):=RQPMT_100207_.tb3_0(6);
RQPMT_100207_.old_tb3_1(6):='MO_EVE_COMP_CT65E121342428'
;
RQPMT_100207_.tb3_1(6):=RQPMT_100207_.tb3_0(6);
RQPMT_100207_.tb3_2(6):=RQPMT_100207_.tb2_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100207_.tb3_0(6),
RQPMT_100207_.tb3_1(6),
RQPMT_100207_.tb3_2(6),
'LDC_PROVALDOCCOMOBSELEG()'
,
'OPEN'
,
to_date('25-07-2019 16:22:39','DD-MM-YYYY HH24:MI:SS'),
to_date('25-07-2019 16:22:39','DD-MM-YYYY HH24:MI:SS'),
to_date('25-07-2019 16:22:39','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'validacion de documentacion completa'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;

RQPMT_100207_.tb8_0(0):=10192;
RQPMT_100207_.tb8_1(0):=RQPMT_100207_.tb7_0(0);
RQPMT_100207_.tb8_2(0):=RQPMT_100207_.tb3_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (0)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100207_.tb8_0(0),
PROD_MOTI_EVENTS_ID=RQPMT_100207_.tb8_1(0),
CONFIG_EXPRESSION_ID=RQPMT_100207_.tb8_2(0),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100207_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100207_.tb8_0(0),
RQPMT_100207_.tb8_1(0),
RQPMT_100207_.tb8_2(0),
'B'
,
'Y'
);
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
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

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100207, sbSuccess);
FOR rc in RQPMT_100207_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
nuIndex := RQPMT_100207_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100207_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100207_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100207_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100207_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100207_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100207_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100207_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100207_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100207_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100207_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100207_.blProcessStatus := false;
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
 nuIndex := RQPMT_100207_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100207_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100207_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100207_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100207_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100207_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100207_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100207_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100207_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100207_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100207_',
'CREATE OR REPLACE PACKAGE RQCFG_100207_ IS ' || chr(10) ||
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
'AND     external_root_id = 100207 ' || chr(10) ||
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
'END RQCFG_100207_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100207_******************************'); END;
/

BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100207_.cuCompositions;
fetch RQCFG_100207_.cuCompositions bulk collect INTO RQCFG_100207_.tbCompositions;
close RQCFG_100207_.cuCompositions;

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100207_.tbEntityName(-1) := 'NULL';
   RQCFG_100207_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100207_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100207_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100207_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100207_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(455) := 'MO_MOTIVE@CUSTOM_DECISION_FLAG';
   RQCFG_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100207_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100207_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100207_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100207_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQCFG_100207_.tbEntityAttributeName(90170587) := 'LDC_DATOS_SOL_RED_CUS_FAL@NRO_SOLICITUD';
   RQCFG_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQCFG_100207_.tbEntityAttributeName(90170588) := 'LDC_DATOS_SOL_RED_CUS_FAL@DIRECCION_SOL';
   RQCFG_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQCFG_100207_.tbEntityAttributeName(90170589) := 'LDC_DATOS_SOL_RED_CUS_FAL@COMMENT_LEGA_FAL';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100207_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100207_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100207_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100207_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(455) := 'MO_MOTIVE@CUSTOM_DECISION_FLAG';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100207_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100207_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQCFG_100207_.tbEntityAttributeName(90170589) := 'LDC_DATOS_SOL_RED_CUS_FAL@COMMENT_LEGA_FAL';
   RQCFG_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQCFG_100207_.tbEntityAttributeName(90170588) := 'LDC_DATOS_SOL_RED_CUS_FAL@DIRECCION_SOL';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100207_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100207_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(5105) := 'LDC_DATOS_SOL_RED_CUS_FAL';
   RQCFG_100207_.tbEntityAttributeName(90170587) := 'LDC_DATOS_SOL_RED_CUS_FAL@NRO_SOLICITUD';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100207_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100207_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100207_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100207_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
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
AND     external_root_id = 100207
)
);
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100207_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100207, 4);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100207_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100207_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100207_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100207_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100207_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207))));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207)));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100207, 4);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100207_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207))));
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207))));
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207))));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207)));

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100207_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100207_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100207_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100207_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100207_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100207_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100207;

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb0_0(0):=9186;
RQCFG_100207_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100207_.tb0_0(0):=RQCFG_100207_.tb0_0(0);
RQCFG_100207_.old_tb0_2(0):=2012;
RQCFG_100207_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100207_.tb0_0(0),
100207,
RQCFG_100207_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb1_0(0):=1065134;
RQCFG_100207_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100207_.tb1_0(0):=RQCFG_100207_.tb1_0(0);
RQCFG_100207_.old_tb1_1(0):=100207;
RQCFG_100207_.tb1_1(0):=RQCFG_100207_.old_tb1_1(0);
RQCFG_100207_.old_tb1_2(0):=2012;
RQCFG_100207_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb1_2(0),-1)));
RQCFG_100207_.old_tb1_3(0):=9186;
RQCFG_100207_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb1_2(0),-1))), RQCFG_100207_.old_tb1_1(0), 4);
RQCFG_100207_.tb1_3(0):=RQCFG_100207_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100207_.tb1_0(0),
RQCFG_100207_.tb1_1(0),
RQCFG_100207_.tb1_2(0),
RQCFG_100207_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb2_0(0):=100028072;
RQCFG_100207_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100207_.tb2_0(0):=RQCFG_100207_.tb2_0(0);
RQCFG_100207_.tb2_1(0):=RQCFG_100207_.tb0_0(0);
RQCFG_100207_.tb2_2(0):=RQCFG_100207_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100207_.tb2_0(0),
RQCFG_100207_.tb2_1(0),
RQCFG_100207_.tb2_2(0),
null,
225,
1,
1,
1);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb1_0(1):=1065135;
RQCFG_100207_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100207_.tb1_0(1):=RQCFG_100207_.tb1_0(1);
RQCFG_100207_.old_tb1_1(1):=100205;
RQCFG_100207_.tb1_1(1):=RQCFG_100207_.old_tb1_1(1);
RQCFG_100207_.old_tb1_2(1):=2013;
RQCFG_100207_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb1_2(1),-1)));
RQCFG_100207_.old_tb1_3(1):=null;
RQCFG_100207_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb1_2(1),-1))), RQCFG_100207_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100207_.tb1_0(1),
RQCFG_100207_.tb1_1(1),
RQCFG_100207_.tb1_2(1),
RQCFG_100207_.tb1_3(1),
null,
'M_SOLICITUD_DE_RED_100205'
,
1,
1,
4);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb2_0(1):=100028073;
RQCFG_100207_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100207_.tb2_0(1):=RQCFG_100207_.tb2_0(1);
RQCFG_100207_.tb2_1(1):=RQCFG_100207_.tb0_0(0);
RQCFG_100207_.tb2_2(1):=RQCFG_100207_.tb1_0(1);
RQCFG_100207_.tb2_3(1):=RQCFG_100207_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100207_.tb2_0(1),
RQCFG_100207_.tb2_1(1),
RQCFG_100207_.tb2_2(1),
RQCFG_100207_.tb2_3(1),
225,
2,
1,
1);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(0):=1173139;
RQCFG_100207_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(0):=RQCFG_100207_.tb3_0(0);
RQCFG_100207_.old_tb3_1(0):=3334;
RQCFG_100207_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(0),-1)));
RQCFG_100207_.old_tb3_2(0):=39322;
RQCFG_100207_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(0),-1)));
RQCFG_100207_.old_tb3_3(0):=255;
RQCFG_100207_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(0),-1)));
RQCFG_100207_.old_tb3_4(0):=null;
RQCFG_100207_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(0),-1)));
RQCFG_100207_.tb3_5(0):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(0):=null;
RQCFG_100207_.tb3_6(0):=NULL;
RQCFG_100207_.old_tb3_7(0):=null;
RQCFG_100207_.tb3_7(0):=NULL;
RQCFG_100207_.old_tb3_8(0):=null;
RQCFG_100207_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(0),
RQCFG_100207_.tb3_1(0),
RQCFG_100207_.tb3_2(0),
RQCFG_100207_.tb3_3(0),
RQCFG_100207_.tb3_4(0),
RQCFG_100207_.tb3_5(0),
RQCFG_100207_.tb3_6(0),
RQCFG_100207_.tb3_7(0),
RQCFG_100207_.tb3_8(0),
null,
103077,
8,
'Identificador De Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb4_0(0):=10376;
RQCFG_100207_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100207_.tb4_0(0):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb4_1(0):=RQCFG_100207_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100207_.tb4_0(0),
RQCFG_100207_.tb4_1(0),
null,
null,
'FRAME-M_SOLICITUD_DE_RED_100205-1065135'
,
2);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(0):=1593499;
RQCFG_100207_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(0):=RQCFG_100207_.tb5_0(0);
RQCFG_100207_.old_tb5_1(0):=39322;
RQCFG_100207_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(0),-1)));
RQCFG_100207_.old_tb5_2(0):=null;
RQCFG_100207_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(0),-1)));
RQCFG_100207_.tb5_3(0):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(0):=RQCFG_100207_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(0),
RQCFG_100207_.tb5_1(0),
RQCFG_100207_.tb5_2(0),
RQCFG_100207_.tb5_3(0),
RQCFG_100207_.tb5_4(0),
'C'
,
'Y'
,
8,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(1):=1173140;
RQCFG_100207_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(1):=RQCFG_100207_.tb3_0(1);
RQCFG_100207_.old_tb3_1(1):=3334;
RQCFG_100207_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(1),-1)));
RQCFG_100207_.old_tb3_2(1):=147336;
RQCFG_100207_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(1),-1)));
RQCFG_100207_.old_tb3_3(1):=null;
RQCFG_100207_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(1),-1)));
RQCFG_100207_.old_tb3_4(1):=null;
RQCFG_100207_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(1),-1)));
RQCFG_100207_.tb3_5(1):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(1):=null;
RQCFG_100207_.tb3_6(1):=NULL;
RQCFG_100207_.old_tb3_7(1):=null;
RQCFG_100207_.tb3_7(1):=NULL;
RQCFG_100207_.old_tb3_8(1):=120174545;
RQCFG_100207_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(1),
RQCFG_100207_.tb3_1(1),
RQCFG_100207_.tb3_2(1),
RQCFG_100207_.tb3_3(1),
RQCFG_100207_.tb3_4(1),
RQCFG_100207_.tb3_5(1),
RQCFG_100207_.tb3_6(1),
RQCFG_100207_.tb3_7(1),
RQCFG_100207_.tb3_8(1),
null,
103027,
1,
'Categor¿a'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(1):=1593500;
RQCFG_100207_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(1):=RQCFG_100207_.tb5_0(1);
RQCFG_100207_.old_tb5_1(1):=147336;
RQCFG_100207_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(1),-1)));
RQCFG_100207_.old_tb5_2(1):=null;
RQCFG_100207_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(1),-1)));
RQCFG_100207_.tb5_3(1):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(1):=RQCFG_100207_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(1),
RQCFG_100207_.tb5_1(1),
RQCFG_100207_.tb5_2(1),
RQCFG_100207_.tb5_3(1),
RQCFG_100207_.tb5_4(1),
'Y'
,
'Y'
,
1,
'Y'
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
4,
null,
null,
null);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(2):=1173141;
RQCFG_100207_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(2):=RQCFG_100207_.tb3_0(2);
RQCFG_100207_.old_tb3_1(2):=3334;
RQCFG_100207_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(2),-1)));
RQCFG_100207_.old_tb3_2(2):=147337;
RQCFG_100207_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(2),-1)));
RQCFG_100207_.old_tb3_3(2):=null;
RQCFG_100207_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(2),-1)));
RQCFG_100207_.old_tb3_4(2):=147336;
RQCFG_100207_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(2),-1)));
RQCFG_100207_.tb3_5(2):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(2):=null;
RQCFG_100207_.tb3_6(2):=NULL;
RQCFG_100207_.old_tb3_7(2):=null;
RQCFG_100207_.tb3_7(2):=NULL;
RQCFG_100207_.old_tb3_8(2):=120174546;
RQCFG_100207_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(2),
RQCFG_100207_.tb3_1(2),
RQCFG_100207_.tb3_2(2),
RQCFG_100207_.tb3_3(2),
RQCFG_100207_.tb3_4(2),
RQCFG_100207_.tb3_5(2),
RQCFG_100207_.tb3_6(2),
RQCFG_100207_.tb3_7(2),
RQCFG_100207_.tb3_8(2),
null,
103028,
2,
'Subcategor¿a'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(2):=1593501;
RQCFG_100207_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(2):=RQCFG_100207_.tb5_0(2);
RQCFG_100207_.old_tb5_1(2):=147337;
RQCFG_100207_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(2),-1)));
RQCFG_100207_.old_tb5_2(2):=147336;
RQCFG_100207_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(2),-1)));
RQCFG_100207_.tb5_3(2):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(2):=RQCFG_100207_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(2),
RQCFG_100207_.tb5_1(2),
RQCFG_100207_.tb5_2(2),
RQCFG_100207_.tb5_3(2),
RQCFG_100207_.tb5_4(2),
'Y'
,
'Y'
,
2,
'Y'
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
4,
null,
null,
null);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(3):=1173142;
RQCFG_100207_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(3):=RQCFG_100207_.tb3_0(3);
RQCFG_100207_.old_tb3_1(3):=3334;
RQCFG_100207_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(3),-1)));
RQCFG_100207_.old_tb3_2(3):=144591;
RQCFG_100207_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(3),-1)));
RQCFG_100207_.old_tb3_3(3):=null;
RQCFG_100207_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(3),-1)));
RQCFG_100207_.old_tb3_4(3):=null;
RQCFG_100207_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(3),-1)));
RQCFG_100207_.tb3_5(3):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(3):=null;
RQCFG_100207_.tb3_6(3):=NULL;
RQCFG_100207_.old_tb3_7(3):=null;
RQCFG_100207_.tb3_7(3):=NULL;
RQCFG_100207_.old_tb3_8(3):=null;
RQCFG_100207_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(3),
RQCFG_100207_.tb3_1(3),
RQCFG_100207_.tb3_2(3),
RQCFG_100207_.tb3_3(3),
RQCFG_100207_.tb3_4(3),
RQCFG_100207_.tb3_5(3),
RQCFG_100207_.tb3_6(3),
RQCFG_100207_.tb3_7(3),
RQCFG_100207_.tb3_8(3),
null,
103029,
4,
'Respuesta De Atenci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(3):=1593502;
RQCFG_100207_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(3):=RQCFG_100207_.tb5_0(3);
RQCFG_100207_.old_tb5_1(3):=144591;
RQCFG_100207_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(3),-1)));
RQCFG_100207_.old_tb5_2(3):=null;
RQCFG_100207_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(3),-1)));
RQCFG_100207_.tb5_3(3):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(3):=RQCFG_100207_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(3),
RQCFG_100207_.tb5_1(3),
RQCFG_100207_.tb5_2(3),
RQCFG_100207_.tb5_3(3),
RQCFG_100207_.tb5_4(3),
'C'
,
'Y'
,
4,
'N'
,
'Respuesta De Atenci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(4):=1173143;
RQCFG_100207_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(4):=RQCFG_100207_.tb3_0(4);
RQCFG_100207_.old_tb3_1(4):=3334;
RQCFG_100207_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(4),-1)));
RQCFG_100207_.old_tb3_2(4):=187;
RQCFG_100207_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(4),-1)));
RQCFG_100207_.old_tb3_3(4):=null;
RQCFG_100207_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(4),-1)));
RQCFG_100207_.old_tb3_4(4):=null;
RQCFG_100207_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(4),-1)));
RQCFG_100207_.tb3_5(4):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(4):=121341159;
RQCFG_100207_.tb3_6(4):=NULL;
RQCFG_100207_.old_tb3_7(4):=null;
RQCFG_100207_.tb3_7(4):=NULL;
RQCFG_100207_.old_tb3_8(4):=null;
RQCFG_100207_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(4),
RQCFG_100207_.tb3_1(4),
RQCFG_100207_.tb3_2(4),
RQCFG_100207_.tb3_3(4),
RQCFG_100207_.tb3_4(4),
RQCFG_100207_.tb3_5(4),
RQCFG_100207_.tb3_6(4),
RQCFG_100207_.tb3_7(4),
RQCFG_100207_.tb3_8(4),
null,
103043,
5,
'C¿digo'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(4):=1593503;
RQCFG_100207_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(4):=RQCFG_100207_.tb5_0(4);
RQCFG_100207_.old_tb5_1(4):=187;
RQCFG_100207_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(4),-1)));
RQCFG_100207_.old_tb5_2(4):=null;
RQCFG_100207_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(4),-1)));
RQCFG_100207_.tb5_3(4):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(4):=RQCFG_100207_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(4),
RQCFG_100207_.tb5_1(4),
RQCFG_100207_.tb5_2(4),
RQCFG_100207_.tb5_3(4),
RQCFG_100207_.tb5_4(4),
'C'
,
'Y'
,
5,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(5):=1173144;
RQCFG_100207_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(5):=RQCFG_100207_.tb3_0(5);
RQCFG_100207_.old_tb3_1(5):=3334;
RQCFG_100207_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(5),-1)));
RQCFG_100207_.old_tb3_2(5):=213;
RQCFG_100207_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(5),-1)));
RQCFG_100207_.old_tb3_3(5):=255;
RQCFG_100207_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(5),-1)));
RQCFG_100207_.old_tb3_4(5):=null;
RQCFG_100207_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(5),-1)));
RQCFG_100207_.tb3_5(5):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(5):=null;
RQCFG_100207_.tb3_6(5):=NULL;
RQCFG_100207_.old_tb3_7(5):=null;
RQCFG_100207_.tb3_7(5):=NULL;
RQCFG_100207_.old_tb3_8(5):=null;
RQCFG_100207_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(5),
RQCFG_100207_.tb3_1(5),
RQCFG_100207_.tb3_2(5),
RQCFG_100207_.tb3_3(5),
RQCFG_100207_.tb3_4(5),
RQCFG_100207_.tb3_5(5),
RQCFG_100207_.tb3_6(5),
RQCFG_100207_.tb3_7(5),
RQCFG_100207_.tb3_8(5),
null,
103044,
6,
'Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(5):=1593504;
RQCFG_100207_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(5):=RQCFG_100207_.tb5_0(5);
RQCFG_100207_.old_tb5_1(5):=213;
RQCFG_100207_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(5),-1)));
RQCFG_100207_.old_tb5_2(5):=null;
RQCFG_100207_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(5),-1)));
RQCFG_100207_.tb5_3(5):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(5):=RQCFG_100207_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(5),
RQCFG_100207_.tb5_1(5),
RQCFG_100207_.tb5_2(5),
RQCFG_100207_.tb5_3(5),
RQCFG_100207_.tb5_4(5),
'C'
,
'Y'
,
6,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(6):=1173145;
RQCFG_100207_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(6):=RQCFG_100207_.tb3_0(6);
RQCFG_100207_.old_tb3_1(6):=3334;
RQCFG_100207_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(6),-1)));
RQCFG_100207_.old_tb3_2(6):=455;
RQCFG_100207_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(6),-1)));
RQCFG_100207_.old_tb3_3(6):=null;
RQCFG_100207_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(6),-1)));
RQCFG_100207_.old_tb3_4(6):=null;
RQCFG_100207_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(6),-1)));
RQCFG_100207_.tb3_5(6):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(6):=121341158;
RQCFG_100207_.tb3_6(6):=NULL;
RQCFG_100207_.old_tb3_7(6):=121341157;
RQCFG_100207_.tb3_7(6):=NULL;
RQCFG_100207_.old_tb3_8(6):=null;
RQCFG_100207_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(6),
RQCFG_100207_.tb3_1(6),
RQCFG_100207_.tb3_2(6),
RQCFG_100207_.tb3_3(6),
RQCFG_100207_.tb3_4(6),
RQCFG_100207_.tb3_5(6),
RQCFG_100207_.tb3_6(6),
RQCFG_100207_.tb3_7(6),
RQCFG_100207_.tb3_8(6),
null,
103034,
3,
'Documentaci¿n Completa'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(6):=1593505;
RQCFG_100207_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(6):=RQCFG_100207_.tb5_0(6);
RQCFG_100207_.old_tb5_1(6):=455;
RQCFG_100207_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(6),-1)));
RQCFG_100207_.old_tb5_2(6):=null;
RQCFG_100207_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(6),-1)));
RQCFG_100207_.tb5_3(6):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(6):=RQCFG_100207_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(6),
RQCFG_100207_.tb5_1(6),
RQCFG_100207_.tb5_2(6),
RQCFG_100207_.tb5_3(6),
RQCFG_100207_.tb5_4(6),
'Y'
,
'Y'
,
3,
'Y'
,
'Documentaci¿n Completa'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(7):=1173146;
RQCFG_100207_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(7):=RQCFG_100207_.tb3_0(7);
RQCFG_100207_.old_tb3_1(7):=3334;
RQCFG_100207_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(7),-1)));
RQCFG_100207_.old_tb3_2(7):=1035;
RQCFG_100207_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(7),-1)));
RQCFG_100207_.old_tb3_3(7):=null;
RQCFG_100207_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(7),-1)));
RQCFG_100207_.old_tb3_4(7):=null;
RQCFG_100207_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(7),-1)));
RQCFG_100207_.tb3_5(7):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(7):=null;
RQCFG_100207_.tb3_6(7):=NULL;
RQCFG_100207_.old_tb3_7(7):=121341155;
RQCFG_100207_.tb3_7(7):=NULL;
RQCFG_100207_.old_tb3_8(7):=null;
RQCFG_100207_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(7),
RQCFG_100207_.tb3_1(7),
RQCFG_100207_.tb3_2(7),
RQCFG_100207_.tb3_3(7),
RQCFG_100207_.tb3_4(7),
RQCFG_100207_.tb3_5(7),
RQCFG_100207_.tb3_6(7),
RQCFG_100207_.tb3_7(7),
RQCFG_100207_.tb3_8(7),
null,
103075,
0,
'Direcci¿n de Instalaci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(7):=1593506;
RQCFG_100207_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(7):=RQCFG_100207_.tb5_0(7);
RQCFG_100207_.old_tb5_1(7):=1035;
RQCFG_100207_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(7),-1)));
RQCFG_100207_.old_tb5_2(7):=null;
RQCFG_100207_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(7),-1)));
RQCFG_100207_.tb5_3(7):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(7):=RQCFG_100207_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(7),
RQCFG_100207_.tb5_1(7),
RQCFG_100207_.tb5_2(7),
RQCFG_100207_.tb5_3(7),
RQCFG_100207_.tb5_4(7),
'Y'
,
'Y'
,
0,
'Y'
,
'Direcci¿n de Instalaci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(8):=1173147;
RQCFG_100207_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(8):=RQCFG_100207_.tb3_0(8);
RQCFG_100207_.old_tb3_1(8):=3334;
RQCFG_100207_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(8),-1)));
RQCFG_100207_.old_tb3_2(8):=474;
RQCFG_100207_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(8),-1)));
RQCFG_100207_.old_tb3_3(8):=null;
RQCFG_100207_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(8),-1)));
RQCFG_100207_.old_tb3_4(8):=null;
RQCFG_100207_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(8),-1)));
RQCFG_100207_.tb3_5(8):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(8):=121341156;
RQCFG_100207_.tb3_6(8):=NULL;
RQCFG_100207_.old_tb3_7(8):=null;
RQCFG_100207_.tb3_7(8):=NULL;
RQCFG_100207_.old_tb3_8(8):=null;
RQCFG_100207_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(8),
RQCFG_100207_.tb3_1(8),
RQCFG_100207_.tb3_2(8),
RQCFG_100207_.tb3_3(8),
RQCFG_100207_.tb3_4(8),
RQCFG_100207_.tb3_5(8),
RQCFG_100207_.tb3_6(8),
RQCFG_100207_.tb3_7(8),
RQCFG_100207_.tb3_8(8),
null,
103076,
7,
'C¿digo de la Direcci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(8):=1593507;
RQCFG_100207_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(8):=RQCFG_100207_.tb5_0(8);
RQCFG_100207_.old_tb5_1(8):=474;
RQCFG_100207_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(8),-1)));
RQCFG_100207_.old_tb5_2(8):=null;
RQCFG_100207_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(8),-1)));
RQCFG_100207_.tb5_3(8):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(8):=RQCFG_100207_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(8),
RQCFG_100207_.tb5_1(8),
RQCFG_100207_.tb5_2(8),
RQCFG_100207_.tb5_3(8),
RQCFG_100207_.tb5_4(8),
'C'
,
'Y'
,
7,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(9):=1173148;
RQCFG_100207_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(9):=RQCFG_100207_.tb3_0(9);
RQCFG_100207_.old_tb3_1(9):=3334;
RQCFG_100207_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(9),-1)));
RQCFG_100207_.old_tb3_2(9):=90170587;
RQCFG_100207_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(9),-1)));
RQCFG_100207_.old_tb3_3(9):=255;
RQCFG_100207_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(9),-1)));
RQCFG_100207_.old_tb3_4(9):=null;
RQCFG_100207_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(9),-1)));
RQCFG_100207_.tb3_5(9):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(9):=null;
RQCFG_100207_.tb3_6(9):=NULL;
RQCFG_100207_.old_tb3_7(9):=null;
RQCFG_100207_.tb3_7(9):=NULL;
RQCFG_100207_.old_tb3_8(9):=null;
RQCFG_100207_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(9),
RQCFG_100207_.tb3_1(9),
RQCFG_100207_.tb3_2(9),
RQCFG_100207_.tb3_3(9),
RQCFG_100207_.tb3_4(9),
RQCFG_100207_.tb3_5(9),
RQCFG_100207_.tb3_6(9),
RQCFG_100207_.tb3_7(9),
RQCFG_100207_.tb3_8(9),
null,
105561,
9,
'Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(9):=1593508;
RQCFG_100207_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(9):=RQCFG_100207_.tb5_0(9);
RQCFG_100207_.old_tb5_1(9):=90170587;
RQCFG_100207_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(9),-1)));
RQCFG_100207_.old_tb5_2(9):=null;
RQCFG_100207_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(9),-1)));
RQCFG_100207_.tb5_3(9):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(9):=RQCFG_100207_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(9),
RQCFG_100207_.tb5_1(9),
RQCFG_100207_.tb5_2(9),
RQCFG_100207_.tb5_3(9),
RQCFG_100207_.tb5_4(9),
'C'
,
'Y'
,
9,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(10):=1173149;
RQCFG_100207_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(10):=RQCFG_100207_.tb3_0(10);
RQCFG_100207_.old_tb3_1(10):=3334;
RQCFG_100207_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(10),-1)));
RQCFG_100207_.old_tb3_2(10):=90170588;
RQCFG_100207_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(10),-1)));
RQCFG_100207_.old_tb3_3(10):=1035;
RQCFG_100207_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(10),-1)));
RQCFG_100207_.old_tb3_4(10):=null;
RQCFG_100207_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(10),-1)));
RQCFG_100207_.tb3_5(10):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(10):=null;
RQCFG_100207_.tb3_6(10):=NULL;
RQCFG_100207_.old_tb3_7(10):=null;
RQCFG_100207_.tb3_7(10):=NULL;
RQCFG_100207_.old_tb3_8(10):=null;
RQCFG_100207_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(10),
RQCFG_100207_.tb3_1(10),
RQCFG_100207_.tb3_2(10),
RQCFG_100207_.tb3_3(10),
RQCFG_100207_.tb3_4(10),
RQCFG_100207_.tb3_5(10),
RQCFG_100207_.tb3_6(10),
RQCFG_100207_.tb3_7(10),
RQCFG_100207_.tb3_8(10),
null,
105562,
10,
'Direccion instalacion'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(10):=1593509;
RQCFG_100207_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(10):=RQCFG_100207_.tb5_0(10);
RQCFG_100207_.old_tb5_1(10):=90170588;
RQCFG_100207_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(10),-1)));
RQCFG_100207_.old_tb5_2(10):=null;
RQCFG_100207_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(10),-1)));
RQCFG_100207_.tb5_3(10):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(10):=RQCFG_100207_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(10),
RQCFG_100207_.tb5_1(10),
RQCFG_100207_.tb5_2(10),
RQCFG_100207_.tb5_3(10),
RQCFG_100207_.tb5_4(10),
'C'
,
'Y'
,
10,
'N'
,
'Direccion instalacion'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(11):=1173150;
RQCFG_100207_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(11):=RQCFG_100207_.tb3_0(11);
RQCFG_100207_.old_tb3_1(11):=3334;
RQCFG_100207_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(11),-1)));
RQCFG_100207_.old_tb3_2(11):=90170589;
RQCFG_100207_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(11),-1)));
RQCFG_100207_.old_tb3_3(11):=null;
RQCFG_100207_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(11),-1)));
RQCFG_100207_.old_tb3_4(11):=null;
RQCFG_100207_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(11),-1)));
RQCFG_100207_.tb3_5(11):=RQCFG_100207_.tb2_2(1);
RQCFG_100207_.old_tb3_6(11):=null;
RQCFG_100207_.tb3_6(11):=NULL;
RQCFG_100207_.old_tb3_7(11):=121341160;
RQCFG_100207_.tb3_7(11):=NULL;
RQCFG_100207_.old_tb3_8(11):=null;
RQCFG_100207_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(11),
RQCFG_100207_.tb3_1(11),
RQCFG_100207_.tb3_2(11),
RQCFG_100207_.tb3_3(11),
RQCFG_100207_.tb3_4(11),
RQCFG_100207_.tb3_5(11),
RQCFG_100207_.tb3_6(11),
RQCFG_100207_.tb3_7(11),
RQCFG_100207_.tb3_8(11),
null,
105563,
11,
'Observacion legalizacion'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(11):=1593510;
RQCFG_100207_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(11):=RQCFG_100207_.tb5_0(11);
RQCFG_100207_.old_tb5_1(11):=90170589;
RQCFG_100207_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(11),-1)));
RQCFG_100207_.old_tb5_2(11):=null;
RQCFG_100207_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(11),-1)));
RQCFG_100207_.tb5_3(11):=RQCFG_100207_.tb4_0(0);
RQCFG_100207_.tb5_4(11):=RQCFG_100207_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(11),
RQCFG_100207_.tb5_1(11),
RQCFG_100207_.tb5_2(11),
RQCFG_100207_.tb5_3(11),
RQCFG_100207_.tb5_4(11),
'Y'
,
'Y'
,
11,
'N'
,
'Observacion legalizacion'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(12):=1173151;
RQCFG_100207_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(12):=RQCFG_100207_.tb3_0(12);
RQCFG_100207_.old_tb3_1(12):=2036;
RQCFG_100207_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(12),-1)));
RQCFG_100207_.old_tb3_2(12):=257;
RQCFG_100207_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(12),-1)));
RQCFG_100207_.old_tb3_3(12):=null;
RQCFG_100207_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(12),-1)));
RQCFG_100207_.old_tb3_4(12):=null;
RQCFG_100207_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(12),-1)));
RQCFG_100207_.tb3_5(12):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(12):=121341153;
RQCFG_100207_.tb3_6(12):=NULL;
RQCFG_100207_.old_tb3_7(12):=null;
RQCFG_100207_.tb3_7(12):=NULL;
RQCFG_100207_.old_tb3_8(12):=null;
RQCFG_100207_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(12),
RQCFG_100207_.tb3_1(12),
RQCFG_100207_.tb3_2(12),
RQCFG_100207_.tb3_3(12),
RQCFG_100207_.tb3_4(12),
RQCFG_100207_.tb3_5(12),
RQCFG_100207_.tb3_6(12),
RQCFG_100207_.tb3_7(12),
RQCFG_100207_.tb3_8(12),
null,
105136,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb4_0(1):=10377;
RQCFG_100207_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100207_.tb4_0(1):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb4_1(1):=RQCFG_100207_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100207_.tb4_0(1),
RQCFG_100207_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1065134'
,
1);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(12):=1593511;
RQCFG_100207_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(12):=RQCFG_100207_.tb5_0(12);
RQCFG_100207_.old_tb5_1(12):=257;
RQCFG_100207_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(12),-1)));
RQCFG_100207_.old_tb5_2(12):=null;
RQCFG_100207_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(12),-1)));
RQCFG_100207_.tb5_3(12):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(12):=RQCFG_100207_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(12),
RQCFG_100207_.tb5_1(12),
RQCFG_100207_.tb5_2(12),
RQCFG_100207_.tb5_3(12),
RQCFG_100207_.tb5_4(12),
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(13):=1173152;
RQCFG_100207_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(13):=RQCFG_100207_.tb3_0(13);
RQCFG_100207_.old_tb3_1(13):=2036;
RQCFG_100207_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(13),-1)));
RQCFG_100207_.old_tb3_2(13):=258;
RQCFG_100207_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(13),-1)));
RQCFG_100207_.old_tb3_3(13):=null;
RQCFG_100207_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(13),-1)));
RQCFG_100207_.old_tb3_4(13):=null;
RQCFG_100207_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(13),-1)));
RQCFG_100207_.tb3_5(13):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(13):=121341147;
RQCFG_100207_.tb3_6(13):=NULL;
RQCFG_100207_.old_tb3_7(13):=121341148;
RQCFG_100207_.tb3_7(13):=NULL;
RQCFG_100207_.old_tb3_8(13):=null;
RQCFG_100207_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(13),
RQCFG_100207_.tb3_1(13),
RQCFG_100207_.tb3_2(13),
RQCFG_100207_.tb3_3(13),
RQCFG_100207_.tb3_4(13),
RQCFG_100207_.tb3_5(13),
RQCFG_100207_.tb3_6(13),
RQCFG_100207_.tb3_7(13),
RQCFG_100207_.tb3_8(13),
null,
105137,
1,
'Fecha De Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(13):=1593512;
RQCFG_100207_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(13):=RQCFG_100207_.tb5_0(13);
RQCFG_100207_.old_tb5_1(13):=258;
RQCFG_100207_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(13),-1)));
RQCFG_100207_.old_tb5_2(13):=null;
RQCFG_100207_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(13),-1)));
RQCFG_100207_.tb5_3(13):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(13):=RQCFG_100207_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(13),
RQCFG_100207_.tb5_1(13),
RQCFG_100207_.tb5_2(13),
RQCFG_100207_.tb5_3(13),
RQCFG_100207_.tb5_4(13),
'Y'
,
'Y'
,
1,
'Y'
,
'Fecha De Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(14):=1173153;
RQCFG_100207_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(14):=RQCFG_100207_.tb3_0(14);
RQCFG_100207_.old_tb3_1(14):=2036;
RQCFG_100207_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(14),-1)));
RQCFG_100207_.old_tb3_2(14):=255;
RQCFG_100207_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(14),-1)));
RQCFG_100207_.old_tb3_3(14):=null;
RQCFG_100207_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(14),-1)));
RQCFG_100207_.old_tb3_4(14):=null;
RQCFG_100207_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(14),-1)));
RQCFG_100207_.tb3_5(14):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(14):=null;
RQCFG_100207_.tb3_6(14):=NULL;
RQCFG_100207_.old_tb3_7(14):=null;
RQCFG_100207_.tb3_7(14):=NULL;
RQCFG_100207_.old_tb3_8(14):=null;
RQCFG_100207_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(14),
RQCFG_100207_.tb3_1(14),
RQCFG_100207_.tb3_2(14),
RQCFG_100207_.tb3_3(14),
RQCFG_100207_.tb3_4(14),
RQCFG_100207_.tb3_5(14),
RQCFG_100207_.tb3_6(14),
RQCFG_100207_.tb3_7(14),
RQCFG_100207_.tb3_8(14),
null,
105138,
2,
'N¿mero De Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(14):=1593513;
RQCFG_100207_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(14):=RQCFG_100207_.tb5_0(14);
RQCFG_100207_.old_tb5_1(14):=255;
RQCFG_100207_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(14),-1)));
RQCFG_100207_.old_tb5_2(14):=null;
RQCFG_100207_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(14),-1)));
RQCFG_100207_.tb5_3(14):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(14):=RQCFG_100207_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(14),
RQCFG_100207_.tb5_1(14),
RQCFG_100207_.tb5_2(14),
RQCFG_100207_.tb5_3(14),
RQCFG_100207_.tb5_4(14),
'Y'
,
'E'
,
2,
'Y'
,
'N¿mero De Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(15):=1173154;
RQCFG_100207_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(15):=RQCFG_100207_.tb3_0(15);
RQCFG_100207_.old_tb3_1(15):=2036;
RQCFG_100207_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(15),-1)));
RQCFG_100207_.old_tb3_2(15):=50001162;
RQCFG_100207_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(15),-1)));
RQCFG_100207_.old_tb3_3(15):=null;
RQCFG_100207_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(15),-1)));
RQCFG_100207_.old_tb3_4(15):=null;
RQCFG_100207_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(15),-1)));
RQCFG_100207_.tb3_5(15):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(15):=121341149;
RQCFG_100207_.tb3_6(15):=NULL;
RQCFG_100207_.old_tb3_7(15):=null;
RQCFG_100207_.tb3_7(15):=NULL;
RQCFG_100207_.old_tb3_8(15):=120174541;
RQCFG_100207_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(15),
RQCFG_100207_.tb3_1(15),
RQCFG_100207_.tb3_2(15),
RQCFG_100207_.tb3_3(15),
RQCFG_100207_.tb3_4(15),
RQCFG_100207_.tb3_5(15),
RQCFG_100207_.tb3_6(15),
RQCFG_100207_.tb3_7(15),
RQCFG_100207_.tb3_8(15),
null,
105139,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(15):=1593514;
RQCFG_100207_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(15):=RQCFG_100207_.tb5_0(15);
RQCFG_100207_.old_tb5_1(15):=50001162;
RQCFG_100207_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(15),-1)));
RQCFG_100207_.old_tb5_2(15):=null;
RQCFG_100207_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(15),-1)));
RQCFG_100207_.tb5_3(15):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(15):=RQCFG_100207_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(15),
RQCFG_100207_.tb5_1(15),
RQCFG_100207_.tb5_2(15),
RQCFG_100207_.tb5_3(15),
RQCFG_100207_.tb5_4(15),
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(16):=1173155;
RQCFG_100207_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(16):=RQCFG_100207_.tb3_0(16);
RQCFG_100207_.old_tb3_1(16):=2036;
RQCFG_100207_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(16),-1)));
RQCFG_100207_.old_tb3_2(16):=109479;
RQCFG_100207_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(16),-1)));
RQCFG_100207_.old_tb3_3(16):=null;
RQCFG_100207_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(16),-1)));
RQCFG_100207_.old_tb3_4(16):=null;
RQCFG_100207_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(16),-1)));
RQCFG_100207_.tb3_5(16):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(16):=121341150;
RQCFG_100207_.tb3_6(16):=NULL;
RQCFG_100207_.old_tb3_7(16):=null;
RQCFG_100207_.tb3_7(16):=NULL;
RQCFG_100207_.old_tb3_8(16):=120174542;
RQCFG_100207_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(16),
RQCFG_100207_.tb3_1(16),
RQCFG_100207_.tb3_2(16),
RQCFG_100207_.tb3_3(16),
RQCFG_100207_.tb3_4(16),
RQCFG_100207_.tb3_5(16),
RQCFG_100207_.tb3_6(16),
RQCFG_100207_.tb3_7(16),
RQCFG_100207_.tb3_8(16),
null,
105140,
4,
'Punto De Atenci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(16):=1593515;
RQCFG_100207_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(16):=RQCFG_100207_.tb5_0(16);
RQCFG_100207_.old_tb5_1(16):=109479;
RQCFG_100207_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(16),-1)));
RQCFG_100207_.old_tb5_2(16):=null;
RQCFG_100207_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(16),-1)));
RQCFG_100207_.tb5_3(16):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(16):=RQCFG_100207_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(16),
RQCFG_100207_.tb5_1(16),
RQCFG_100207_.tb5_2(16),
RQCFG_100207_.tb5_3(16),
RQCFG_100207_.tb5_4(16),
'Y'
,
'N'
,
4,
'Y'
,
'Punto De Atenci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(17):=1173156;
RQCFG_100207_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(17):=RQCFG_100207_.tb3_0(17);
RQCFG_100207_.old_tb3_1(17):=2036;
RQCFG_100207_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(17),-1)));
RQCFG_100207_.old_tb3_2(17):=2683;
RQCFG_100207_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(17),-1)));
RQCFG_100207_.old_tb3_3(17):=null;
RQCFG_100207_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(17),-1)));
RQCFG_100207_.old_tb3_4(17):=109479;
RQCFG_100207_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(17),-1)));
RQCFG_100207_.tb3_5(17):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(17):=121341151;
RQCFG_100207_.tb3_6(17):=NULL;
RQCFG_100207_.old_tb3_7(17):=null;
RQCFG_100207_.tb3_7(17):=NULL;
RQCFG_100207_.old_tb3_8(17):=120174543;
RQCFG_100207_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(17),
RQCFG_100207_.tb3_1(17),
RQCFG_100207_.tb3_2(17),
RQCFG_100207_.tb3_3(17),
RQCFG_100207_.tb3_4(17),
RQCFG_100207_.tb3_5(17),
RQCFG_100207_.tb3_6(17),
RQCFG_100207_.tb3_7(17),
RQCFG_100207_.tb3_8(17),
null,
105141,
5,
'Medio de recepci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(17):=1593516;
RQCFG_100207_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(17):=RQCFG_100207_.tb5_0(17);
RQCFG_100207_.old_tb5_1(17):=2683;
RQCFG_100207_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(17),-1)));
RQCFG_100207_.old_tb5_2(17):=109479;
RQCFG_100207_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(17),-1)));
RQCFG_100207_.tb5_3(17):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(17):=RQCFG_100207_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(17),
RQCFG_100207_.tb5_1(17),
RQCFG_100207_.tb5_2(17),
RQCFG_100207_.tb5_3(17),
RQCFG_100207_.tb5_4(17),
'Y'
,
'Y'
,
5,
'Y'
,
'Medio de recepci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(18):=1173157;
RQCFG_100207_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(18):=RQCFG_100207_.tb3_0(18);
RQCFG_100207_.old_tb3_1(18):=2036;
RQCFG_100207_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(18),-1)));
RQCFG_100207_.old_tb3_2(18):=146755;
RQCFG_100207_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(18),-1)));
RQCFG_100207_.old_tb3_3(18):=null;
RQCFG_100207_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(18),-1)));
RQCFG_100207_.old_tb3_4(18):=null;
RQCFG_100207_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(18),-1)));
RQCFG_100207_.tb3_5(18):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(18):=121341152;
RQCFG_100207_.tb3_6(18):=NULL;
RQCFG_100207_.old_tb3_7(18):=null;
RQCFG_100207_.tb3_7(18):=NULL;
RQCFG_100207_.old_tb3_8(18):=null;
RQCFG_100207_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(18),
RQCFG_100207_.tb3_1(18),
RQCFG_100207_.tb3_2(18),
RQCFG_100207_.tb3_3(18),
RQCFG_100207_.tb3_4(18),
RQCFG_100207_.tb3_5(18),
RQCFG_100207_.tb3_6(18),
RQCFG_100207_.tb3_7(18),
RQCFG_100207_.tb3_8(18),
null,
105142,
6,
'Informaci¿n del Solicitante'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(18):=1593517;
RQCFG_100207_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(18):=RQCFG_100207_.tb5_0(18);
RQCFG_100207_.old_tb5_1(18):=146755;
RQCFG_100207_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(18),-1)));
RQCFG_100207_.old_tb5_2(18):=null;
RQCFG_100207_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(18),-1)));
RQCFG_100207_.tb5_3(18):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(18):=RQCFG_100207_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(18),
RQCFG_100207_.tb5_1(18),
RQCFG_100207_.tb5_2(18),
RQCFG_100207_.tb5_3(18),
RQCFG_100207_.tb5_4(18),
'Y'
,
'E'
,
6,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(19):=1173158;
RQCFG_100207_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(19):=RQCFG_100207_.tb3_0(19);
RQCFG_100207_.old_tb3_1(19):=2036;
RQCFG_100207_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(19),-1)));
RQCFG_100207_.old_tb3_2(19):=146756;
RQCFG_100207_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(19),-1)));
RQCFG_100207_.old_tb3_3(19):=null;
RQCFG_100207_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(19),-1)));
RQCFG_100207_.old_tb3_4(19):=null;
RQCFG_100207_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(19),-1)));
RQCFG_100207_.tb3_5(19):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(19):=121341146;
RQCFG_100207_.tb3_6(19):=NULL;
RQCFG_100207_.old_tb3_7(19):=null;
RQCFG_100207_.tb3_7(19):=NULL;
RQCFG_100207_.old_tb3_8(19):=null;
RQCFG_100207_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(19),
RQCFG_100207_.tb3_1(19),
RQCFG_100207_.tb3_2(19),
RQCFG_100207_.tb3_3(19),
RQCFG_100207_.tb3_4(19),
RQCFG_100207_.tb3_5(19),
RQCFG_100207_.tb3_6(19),
RQCFG_100207_.tb3_7(19),
RQCFG_100207_.tb3_8(19),
null,
105143,
7,
'Direcci¿n De Respuesta'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(19):=1593518;
RQCFG_100207_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(19):=RQCFG_100207_.tb5_0(19);
RQCFG_100207_.old_tb5_1(19):=146756;
RQCFG_100207_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(19),-1)));
RQCFG_100207_.old_tb5_2(19):=null;
RQCFG_100207_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(19),-1)));
RQCFG_100207_.tb5_3(19):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(19):=RQCFG_100207_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(19),
RQCFG_100207_.tb5_1(19),
RQCFG_100207_.tb5_2(19),
RQCFG_100207_.tb5_3(19),
RQCFG_100207_.tb5_4(19),
'Y'
,
'E'
,
7,
'N'
,
'Direcci¿n De Respuesta'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(20):=1173159;
RQCFG_100207_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(20):=RQCFG_100207_.tb3_0(20);
RQCFG_100207_.old_tb3_1(20):=2036;
RQCFG_100207_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(20),-1)));
RQCFG_100207_.old_tb3_2(20):=146754;
RQCFG_100207_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(20),-1)));
RQCFG_100207_.old_tb3_3(20):=null;
RQCFG_100207_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(20),-1)));
RQCFG_100207_.old_tb3_4(20):=null;
RQCFG_100207_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(20),-1)));
RQCFG_100207_.tb3_5(20):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(20):=null;
RQCFG_100207_.tb3_6(20):=NULL;
RQCFG_100207_.old_tb3_7(20):=null;
RQCFG_100207_.tb3_7(20):=NULL;
RQCFG_100207_.old_tb3_8(20):=null;
RQCFG_100207_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(20),
RQCFG_100207_.tb3_1(20),
RQCFG_100207_.tb3_2(20),
RQCFG_100207_.tb3_3(20),
RQCFG_100207_.tb3_4(20),
RQCFG_100207_.tb3_5(20),
RQCFG_100207_.tb3_6(20),
RQCFG_100207_.tb3_7(20),
RQCFG_100207_.tb3_8(20),
null,
105144,
8,
'Observaci¿n'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(20):=1593519;
RQCFG_100207_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(20):=RQCFG_100207_.tb5_0(20);
RQCFG_100207_.old_tb5_1(20):=146754;
RQCFG_100207_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(20),-1)));
RQCFG_100207_.old_tb5_2(20):=null;
RQCFG_100207_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(20),-1)));
RQCFG_100207_.tb5_3(20):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(20):=RQCFG_100207_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(20),
RQCFG_100207_.tb5_1(20),
RQCFG_100207_.tb5_2(20),
RQCFG_100207_.tb5_3(20),
RQCFG_100207_.tb5_4(20),
'Y'
,
'Y'
,
8,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(21):=1173160;
RQCFG_100207_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(21):=RQCFG_100207_.tb3_0(21);
RQCFG_100207_.old_tb3_1(21):=2036;
RQCFG_100207_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(21),-1)));
RQCFG_100207_.old_tb3_2(21):=42118;
RQCFG_100207_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(21),-1)));
RQCFG_100207_.old_tb3_3(21):=109479;
RQCFG_100207_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(21),-1)));
RQCFG_100207_.old_tb3_4(21):=null;
RQCFG_100207_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(21),-1)));
RQCFG_100207_.tb3_5(21):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(21):=null;
RQCFG_100207_.tb3_6(21):=NULL;
RQCFG_100207_.old_tb3_7(21):=null;
RQCFG_100207_.tb3_7(21):=NULL;
RQCFG_100207_.old_tb3_8(21):=null;
RQCFG_100207_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(21),
RQCFG_100207_.tb3_1(21),
RQCFG_100207_.tb3_2(21),
RQCFG_100207_.tb3_3(21),
RQCFG_100207_.tb3_4(21),
RQCFG_100207_.tb3_5(21),
RQCFG_100207_.tb3_6(21),
RQCFG_100207_.tb3_7(21),
RQCFG_100207_.tb3_8(21),
null,
105147,
10,
'C¿digo Canal De Ventas'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(21):=1593520;
RQCFG_100207_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(21):=RQCFG_100207_.tb5_0(21);
RQCFG_100207_.old_tb5_1(21):=42118;
RQCFG_100207_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(21),-1)));
RQCFG_100207_.old_tb5_2(21):=null;
RQCFG_100207_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(21),-1)));
RQCFG_100207_.tb5_3(21):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(21):=RQCFG_100207_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(21),
RQCFG_100207_.tb5_1(21),
RQCFG_100207_.tb5_2(21),
RQCFG_100207_.tb5_3(21),
RQCFG_100207_.tb5_4(21),
'C'
,
'Y'
,
10,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(22):=1173161;
RQCFG_100207_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(22):=RQCFG_100207_.tb3_0(22);
RQCFG_100207_.old_tb3_1(22):=2036;
RQCFG_100207_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(22),-1)));
RQCFG_100207_.old_tb3_2(22):=259;
RQCFG_100207_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(22),-1)));
RQCFG_100207_.old_tb3_3(22):=null;
RQCFG_100207_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(22),-1)));
RQCFG_100207_.old_tb3_4(22):=null;
RQCFG_100207_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(22),-1)));
RQCFG_100207_.tb3_5(22):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(22):=121341144;
RQCFG_100207_.tb3_6(22):=NULL;
RQCFG_100207_.old_tb3_7(22):=null;
RQCFG_100207_.tb3_7(22):=NULL;
RQCFG_100207_.old_tb3_8(22):=null;
RQCFG_100207_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(22),
RQCFG_100207_.tb3_1(22),
RQCFG_100207_.tb3_2(22),
RQCFG_100207_.tb3_3(22),
RQCFG_100207_.tb3_4(22),
RQCFG_100207_.tb3_5(22),
RQCFG_100207_.tb3_6(22),
RQCFG_100207_.tb3_7(22),
RQCFG_100207_.tb3_8(22),
null,
105162,
11,
'Fecha env¿o mensajes'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(22):=1593521;
RQCFG_100207_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(22):=RQCFG_100207_.tb5_0(22);
RQCFG_100207_.old_tb5_1(22):=259;
RQCFG_100207_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(22),-1)));
RQCFG_100207_.old_tb5_2(22):=null;
RQCFG_100207_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(22),-1)));
RQCFG_100207_.tb5_3(22):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(22):=RQCFG_100207_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(22),
RQCFG_100207_.tb5_1(22),
RQCFG_100207_.tb5_2(22),
RQCFG_100207_.tb5_3(22),
RQCFG_100207_.tb5_4(22),
'C'
,
'Y'
,
11,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(23):=1173162;
RQCFG_100207_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(23):=RQCFG_100207_.tb3_0(23);
RQCFG_100207_.old_tb3_1(23):=2036;
RQCFG_100207_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(23),-1)));
RQCFG_100207_.old_tb3_2(23):=50000603;
RQCFG_100207_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(23),-1)));
RQCFG_100207_.old_tb3_3(23):=null;
RQCFG_100207_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(23),-1)));
RQCFG_100207_.old_tb3_4(23):=null;
RQCFG_100207_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(23),-1)));
RQCFG_100207_.tb3_5(23):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(23):=121341145;
RQCFG_100207_.tb3_6(23):=NULL;
RQCFG_100207_.old_tb3_7(23):=null;
RQCFG_100207_.tb3_7(23):=NULL;
RQCFG_100207_.old_tb3_8(23):=null;
RQCFG_100207_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(23),
RQCFG_100207_.tb3_1(23),
RQCFG_100207_.tb3_2(23),
RQCFG_100207_.tb3_3(23),
RQCFG_100207_.tb3_4(23),
RQCFG_100207_.tb3_5(23),
RQCFG_100207_.tb3_6(23),
RQCFG_100207_.tb3_7(23),
RQCFG_100207_.tb3_8(23),
null,
105163,
12,
'Identificador de suscriptor por motivo'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(23):=1593522;
RQCFG_100207_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(23):=RQCFG_100207_.tb5_0(23);
RQCFG_100207_.old_tb5_1(23):=50000603;
RQCFG_100207_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(23),-1)));
RQCFG_100207_.old_tb5_2(23):=null;
RQCFG_100207_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(23),-1)));
RQCFG_100207_.tb5_3(23):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(23):=RQCFG_100207_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(23),
RQCFG_100207_.tb5_1(23),
RQCFG_100207_.tb5_2(23),
RQCFG_100207_.tb5_3(23),
RQCFG_100207_.tb5_4(23),
'C'
,
'Y'
,
12,
'N'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(24):=1173163;
RQCFG_100207_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(24):=RQCFG_100207_.tb3_0(24);
RQCFG_100207_.old_tb3_1(24):=2036;
RQCFG_100207_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(24),-1)));
RQCFG_100207_.old_tb3_2(24):=39387;
RQCFG_100207_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(24),-1)));
RQCFG_100207_.old_tb3_3(24):=255;
RQCFG_100207_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(24),-1)));
RQCFG_100207_.old_tb3_4(24):=null;
RQCFG_100207_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(24),-1)));
RQCFG_100207_.tb3_5(24):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(24):=null;
RQCFG_100207_.tb3_6(24):=NULL;
RQCFG_100207_.old_tb3_7(24):=null;
RQCFG_100207_.tb3_7(24):=NULL;
RQCFG_100207_.old_tb3_8(24):=null;
RQCFG_100207_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(24),
RQCFG_100207_.tb3_1(24),
RQCFG_100207_.tb3_2(24),
RQCFG_100207_.tb3_3(24),
RQCFG_100207_.tb3_4(24),
RQCFG_100207_.tb3_5(24),
RQCFG_100207_.tb3_6(24),
RQCFG_100207_.tb3_7(24),
RQCFG_100207_.tb3_8(24),
null,
105164,
13,
'Identificador De Solicitud'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(24):=1593523;
RQCFG_100207_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(24):=RQCFG_100207_.tb5_0(24);
RQCFG_100207_.old_tb5_1(24):=39387;
RQCFG_100207_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(24),-1)));
RQCFG_100207_.old_tb5_2(24):=null;
RQCFG_100207_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(24),-1)));
RQCFG_100207_.tb5_3(24):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(24):=RQCFG_100207_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(24),
RQCFG_100207_.tb5_1(24),
RQCFG_100207_.tb5_2(24),
RQCFG_100207_.tb5_3(24),
RQCFG_100207_.tb5_4(24),
'C'
,
'Y'
,
13,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(25):=1173164;
RQCFG_100207_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(25):=RQCFG_100207_.tb3_0(25);
RQCFG_100207_.old_tb3_1(25):=2036;
RQCFG_100207_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(25),-1)));
RQCFG_100207_.old_tb3_2(25):=149340;
RQCFG_100207_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(25),-1)));
RQCFG_100207_.old_tb3_3(25):=null;
RQCFG_100207_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(25),-1)));
RQCFG_100207_.old_tb3_4(25):=null;
RQCFG_100207_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(25),-1)));
RQCFG_100207_.tb3_5(25):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(25):=null;
RQCFG_100207_.tb3_6(25):=NULL;
RQCFG_100207_.old_tb3_7(25):=null;
RQCFG_100207_.tb3_7(25):=NULL;
RQCFG_100207_.old_tb3_8(25):=120174544;
RQCFG_100207_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(25),
RQCFG_100207_.tb3_1(25),
RQCFG_100207_.tb3_2(25),
RQCFG_100207_.tb3_3(25),
RQCFG_100207_.tb3_4(25),
RQCFG_100207_.tb3_5(25),
RQCFG_100207_.tb3_6(25),
RQCFG_100207_.tb3_7(25),
RQCFG_100207_.tb3_8(25),
null,
105165,
9,
'Relaci¿n del solicitante con el predio'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(25):=1593524;
RQCFG_100207_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(25):=RQCFG_100207_.tb5_0(25);
RQCFG_100207_.old_tb5_1(25):=149340;
RQCFG_100207_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(25),-1)));
RQCFG_100207_.old_tb5_2(25):=null;
RQCFG_100207_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(25),-1)));
RQCFG_100207_.tb5_3(25):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(25):=RQCFG_100207_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(25),
RQCFG_100207_.tb5_1(25),
RQCFG_100207_.tb5_2(25),
RQCFG_100207_.tb5_3(25),
RQCFG_100207_.tb5_4(25),
'Y'
,
'Y'
,
9,
'Y'
,
'Relaci¿n del solicitante con el predio'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(26):=1173165;
RQCFG_100207_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(26):=RQCFG_100207_.tb3_0(26);
RQCFG_100207_.old_tb3_1(26):=2036;
RQCFG_100207_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(26),-1)));
RQCFG_100207_.old_tb3_2(26):=50000606;
RQCFG_100207_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(26),-1)));
RQCFG_100207_.old_tb3_3(26):=146755;
RQCFG_100207_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(26),-1)));
RQCFG_100207_.old_tb3_4(26):=null;
RQCFG_100207_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(26),-1)));
RQCFG_100207_.tb3_5(26):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(26):=null;
RQCFG_100207_.tb3_6(26):=NULL;
RQCFG_100207_.old_tb3_7(26):=null;
RQCFG_100207_.tb3_7(26):=NULL;
RQCFG_100207_.old_tb3_8(26):=null;
RQCFG_100207_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(26),
RQCFG_100207_.tb3_1(26),
RQCFG_100207_.tb3_2(26),
RQCFG_100207_.tb3_3(26),
RQCFG_100207_.tb3_4(26),
RQCFG_100207_.tb3_5(26),
RQCFG_100207_.tb3_6(26),
RQCFG_100207_.tb3_7(26),
RQCFG_100207_.tb3_8(26),
null,
105166,
14,
'Usuario del Servicio'
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(26):=1593525;
RQCFG_100207_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(26):=RQCFG_100207_.tb5_0(26);
RQCFG_100207_.old_tb5_1(26):=50000606;
RQCFG_100207_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(26),-1)));
RQCFG_100207_.old_tb5_2(26):=null;
RQCFG_100207_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(26),-1)));
RQCFG_100207_.tb5_3(26):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(26):=RQCFG_100207_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(26),
RQCFG_100207_.tb5_1(26),
RQCFG_100207_.tb5_2(26),
RQCFG_100207_.tb5_3(26),
RQCFG_100207_.tb5_4(26),
'C'
,
'Y'
,
14,
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
4,
null,
null,
null);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb3_0(27):=1173166;
RQCFG_100207_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100207_.tb3_0(27):=RQCFG_100207_.tb3_0(27);
RQCFG_100207_.old_tb3_1(27):=2036;
RQCFG_100207_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100207_.TBENTITYNAME(NVL(RQCFG_100207_.old_tb3_1(27),-1)));
RQCFG_100207_.old_tb3_2(27):=4015;
RQCFG_100207_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_2(27),-1)));
RQCFG_100207_.old_tb3_3(27):=146755;
RQCFG_100207_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_3(27),-1)));
RQCFG_100207_.old_tb3_4(27):=null;
RQCFG_100207_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb3_4(27),-1)));
RQCFG_100207_.tb3_5(27):=RQCFG_100207_.tb2_2(0);
RQCFG_100207_.old_tb3_6(27):=null;
RQCFG_100207_.tb3_6(27):=NULL;
RQCFG_100207_.old_tb3_7(27):=null;
RQCFG_100207_.tb3_7(27):=NULL;
RQCFG_100207_.old_tb3_8(27):=null;
RQCFG_100207_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100207_.tb3_0(27),
RQCFG_100207_.tb3_1(27),
RQCFG_100207_.tb3_2(27),
RQCFG_100207_.tb3_3(27),
RQCFG_100207_.tb3_4(27),
RQCFG_100207_.tb3_5(27),
RQCFG_100207_.tb3_6(27),
RQCFG_100207_.tb3_7(27),
RQCFG_100207_.tb3_8(27),
null,
105717,
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
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100207_.blProcessStatus) then
 return;
end if;

RQCFG_100207_.old_tb5_0(27):=1593526;
RQCFG_100207_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100207_.tb5_0(27):=RQCFG_100207_.tb5_0(27);
RQCFG_100207_.old_tb5_1(27):=4015;
RQCFG_100207_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_1(27),-1)));
RQCFG_100207_.old_tb5_2(27):=null;
RQCFG_100207_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100207_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100207_.old_tb5_2(27),-1)));
RQCFG_100207_.tb5_3(27):=RQCFG_100207_.tb4_0(1);
RQCFG_100207_.tb5_4(27):=RQCFG_100207_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100207_.tb5_0(27),
RQCFG_100207_.tb5_1(27),
RQCFG_100207_.tb5_2(27),
RQCFG_100207_.tb5_3(27),
RQCFG_100207_.tb5_4(27),
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
4,
null,
null,
null);

exception when others then
RQCFG_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100207);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100207)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100207_.blProcessStatus) then
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
AND     external_root_id = 100207
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
AND     external_root_id = 100207
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
AND     external_root_id = 100207
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100207, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100207)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100207, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100207)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100207, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100207)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100207, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100207)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100207_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100207_.tbCompositions.FIRST..RQCFG_100207_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100207_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100207_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100207_.blProcessStatus := false;
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
 nuIndex := RQCFG_100207_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100207_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100207_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100207_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100207_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100207_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100207_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100207_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100207_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100207_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100207_',
'CREATE OR REPLACE PACKAGE I18N_R_100207_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100207_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100207_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100207
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
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
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(0):='M_SOLICITUD_DE_RED_100205'
;
I18N_R_100207_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(0),
I18N_R_100207_.tb0_1(0),
'WE8ISO8859P1'
,
'Solicitud de Red'
,
'Solicitud de Red'
,
null,
'Solicitud de Red'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(1):='M_SOLICITUD_DE_RED_100205'
;
I18N_R_100207_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(1),
I18N_R_100207_.tb0_1(1),
'WE8ISO8859P1'
,
'Solicitud de Red'
,
'Solicitud de Red'
,
null,
'Solicitud de Red'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(2):='M_SOLICITUD_DE_RED_100205'
;
I18N_R_100207_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(2),
I18N_R_100207_.tb0_1(2),
'WE8ISO8859P1'
,
'Solicitud de Red'
,
'Solicitud de Red'
,
null,
'Solicitud de Red'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(3):='PAQUETE'
;
I18N_R_100207_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(3),
I18N_R_100207_.tb0_1(3),
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
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(4):='PAQUETE'
;
I18N_R_100207_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(4),
I18N_R_100207_.tb0_1(4),
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
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(5):='PAQUETE'
;
I18N_R_100207_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(5),
I18N_R_100207_.tb0_1(5),
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
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100207_.blProcessStatus) then
 return;
end if;

I18N_R_100207_.tb0_0(6):='PAQUETE'
;
I18N_R_100207_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100207_.tb0_0(6),
I18N_R_100207_.tb0_1(6),
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
I18N_R_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100207_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100207_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100207_',
'CREATE OR REPLACE PACKAGE RQEXEC_100207_ IS ' || chr(10) ||
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
'END RQEXEC_100207_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100207_******************************'); END;
/


BEGIN

if (not RQEXEC_100207_.blProcessStatus) then
 return;
end if;

RQEXEC_100207_.old_tb0_0(0):='P_SOLICITUD_DE_RED_100207'
;
RQEXEC_100207_.tb0_0(0):=UPPER(RQEXEC_100207_.old_tb0_0(0));
RQEXEC_100207_.old_tb0_1(0):=200010;
RQEXEC_100207_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100207_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100207_.tb0_1(0):=RQEXEC_100207_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100207_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100207_.tb0_1(0),
DESCRIPTION='Solicitud de Red'
,
PATH=null,
VERSION='148'
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
TIMES_EXECUTED=74,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=to_date('01-12-2018 10:39:45','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100207_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100207_.tb0_0(0),
RQEXEC_100207_.tb0_1(0),
'Solicitud de Red'
,
null,
'148'
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
74,
'O',
to_date('01-12-2018 10:39:45','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100207_.blProcessStatus) then
 return;
end if;

RQEXEC_100207_.tb1_0(0):=1;
RQEXEC_100207_.tb1_1(0):=RQEXEC_100207_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100207_.tb1_0(0),
RQEXEC_100207_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100207_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100207_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100207_******************************'); end;
/
