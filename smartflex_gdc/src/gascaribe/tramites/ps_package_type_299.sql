BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_299_',
'CREATE OR REPLACE PACKAGE RQTY_299_ IS ' || chr(10) ||
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
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 299 ' || chr(10) ||
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
'END RQTY_299_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_299_******************************'); END;
/

BEGIN

if (not RQTY_299_.blProcessStatus) then
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
AND     external_root_id = 299
)
);

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_299_.cuExpressions;
fetch RQTY_299_.cuExpressions bulk collect INTO RQTY_299_.tbExpressionsId;
close RQTY_299_.cuExpressions;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_299_.tbEntityName(-1) := 'NULL';
   RQTY_299_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_299_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_299_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQTY_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_299_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 299
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 299
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 299
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 299
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_299_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_299_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_299_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_299_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_299_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_299_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_299_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299))));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299))));

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_299_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_299_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_299_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_299_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_299_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_299_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_299_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_299_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299)));

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299));
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_299_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299);
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_299_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_299_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_299_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_299_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=299;
nuIndex binary_integer;
BEGIN

if (not RQTY_299_.blProcessStatus) then
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_299_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_299_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_299_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_299_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_299_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_299_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_299_.tb0_0(0),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb1_0(0):=1;
RQTY_299_.tb1_1(0):=RQTY_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_299_.tb1_0(0),
MODULE_ID=RQTY_299_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_299_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_299_.tb1_0(0),
RQTY_299_.tb1_1(0),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(0):=121408159;
RQTY_299_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(0):=RQTY_299_.tb2_0(0);
RQTY_299_.old_tb2_1(0):='GE_EXEACTION_CT1E121408159'
;
RQTY_299_.tb2_1(0):=RQTY_299_.tb2_0(0);
RQTY_299_.tb2_2(0):=RQTY_299_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(0),
RQTY_299_.tb2_1(0),
RQTY_299_.tb2_2(0),
'cf_boactions.RegVentaServIng();sbIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", sbIdSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.FNUCHARTONUMBER(sbIdSolicitud),cnuTipoFechaPQR,dtFechaSolicitud)'
,
'LBTEST'
,
to_date('08-09-2012 16:36:54','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Registro Servicio Tecnico Externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb3_0(0):=295;
RQTY_299_.tb3_1(0):=RQTY_299_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_299_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_299_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Registro Servicio Tecnico Externo'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_299_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_299_.tb3_0(0),
RQTY_299_.tb3_1(0),
5,
'Registro Servicio Tecnico Externo'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb4_0(0):=RQTY_299_.tb3_0(0);
RQTY_299_.tb4_1(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_299_.tb4_0(0),
VALID_MODULE_ID=RQTY_299_.tb4_1(0)
 WHERE ACTION_ID = RQTY_299_.tb4_0(0) AND VALID_MODULE_ID = RQTY_299_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_299_.tb4_0(0),
RQTY_299_.tb4_1(0));
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb4_0(1):=RQTY_299_.tb3_0(0);
RQTY_299_.tb4_1(1):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_299_.tb4_0(1),
VALID_MODULE_ID=RQTY_299_.tb4_1(1)
 WHERE ACTION_ID = RQTY_299_.tb4_0(1) AND VALID_MODULE_ID = RQTY_299_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_299_.tb4_0(1),
RQTY_299_.tb4_1(1));
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb5_0(0):=299;
RQTY_299_.tb5_1(0):=RQTY_299_.tb3_0(0);
RQTY_299_.tb5_4(0):='P_SOLICITUD_DE_SERVICIO_TECNICO_CLIENTES_EXTERNOS_299'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_299_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_299_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_299_.tb5_4(0),
DESCRIPTION='Solicitud de Servicio Técnico Clientes Externos '
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
 WHERE PACKAGE_TYPE_ID = RQTY_299_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_299_.tb5_0(0),
RQTY_299_.tb5_1(0),
null,
null,
RQTY_299_.tb5_4(0),
'Solicitud de Servicio Técnico Clientes Externos '
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_299_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_299_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_299_.tb0_0(1),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb1_0(1):=23;
RQTY_299_.tb1_1(1):=RQTY_299_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_299_.tb1_0(1),
MODULE_ID=RQTY_299_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_299_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_299_.tb1_0(1),
RQTY_299_.tb1_1(1),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(1):=121408160;
RQTY_299_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(1):=RQTY_299_.tb2_0(1);
RQTY_299_.old_tb2_1(1):='MO_INITATRIB_CT23E121408160'
;
RQTY_299_.tb2_1(1):=RQTY_299_.tb2_0(1);
RQTY_299_.tb2_2(1):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(1),
RQTY_299_.tb2_1(1),
RQTY_299_.tb2_2(1),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",Null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);sbSubscriber = "SUBSCRIBER_ID";sbSubscriber = UT_STRING.FSBCONCAT(sbSubscriber, sbSubscriberId, "=");blExistContract = GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", Null, "PR_SUBSCRIPTION", "SUBSCRIPTION_ID", 1);if (blExistContract = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",Null,"PR_SUBSCRIPTION","SUBSCRIPTION_ID",sbSubscriptionId);sbSubscription = "SUBSCRIPTION_ID";sbSubscription = UT_STRING.FSBCONCAT(sbSubscription, sbSubscriptionId, "=");cadena = UT_STRING.FSBCONCAT(sbSubscriber, sbSubscription, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(cadena);,cadena = sbSubscriber;GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(cadena);)'
,
'LBTEST'
,
to_date('18-07-2012 15:03:51','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PACKAGES - MO_PROCESS - CONTRACT_INFORMATION - Inicializa Atributo de Modificación de Cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb1_0(2):=26;
RQTY_299_.tb1_1(2):=RQTY_299_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_299_.tb1_0(2),
MODULE_ID=RQTY_299_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_299_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_299_.tb1_0(2),
RQTY_299_.tb1_1(2),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(2):=121408161;
RQTY_299_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(2):=RQTY_299_.tb2_0(2);
RQTY_299_.old_tb2_1(2):='MO_VALIDATTR_CT26E121408161'
;
RQTY_299_.tb2_1(2):=RQTY_299_.tb2_0(2);
RQTY_299_.tb2_2(2):=RQTY_299_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(2),
RQTY_299_.tb2_1(2),
RQTY_299_.tb2_2(2),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbContrato);nuIdContrato = UT_STRING.GETPARAMETERVALUE(sbContrato, "SUBSCRIPTION_ID", "|", "=");GE_BOINSTANCECONTROL.LOADENTITYOLDVALUESID("WORK_INSTANCE",NULL,"SUSCRIPC",nuIdContrato,GE_BOCONSTANTS.GETFALSE(),GE_BOCONSTANTS.GETFALSE(),GE_BOCONSTANTS.GETFALSE())'
,
'LBTEST'
,
to_date('23-08-2012 18:33:21','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Val- Contrato Servicio tecnico externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(0):=1491;
RQTY_299_.tb6_1(0):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(0):=68;
RQTY_299_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(0),-1)));
RQTY_299_.old_tb6_3(0):=2826;
RQTY_299_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(0),-1)));
RQTY_299_.old_tb6_4(0):=null;
RQTY_299_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(0),-1)));
RQTY_299_.old_tb6_5(0):=null;
RQTY_299_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(0),-1)));
RQTY_299_.tb6_7(0):=RQTY_299_.tb2_0(1);
RQTY_299_.tb6_8(0):=RQTY_299_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(0),
ENTITY_ID=RQTY_299_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(0),
VALID_EXPRESSION_ID=RQTY_299_.tb6_8(0),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Información de contrato'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(0),
RQTY_299_.tb6_1(0),
RQTY_299_.tb6_2(0),
RQTY_299_.tb6_3(0),
RQTY_299_.tb6_4(0),
RQTY_299_.tb6_5(0),
null,
RQTY_299_.tb6_7(0),
RQTY_299_.tb6_8(0),
null,
13,
'Información de contrato'
,
13,
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(3):=121408162;
RQTY_299_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(3):=RQTY_299_.tb2_0(3);
RQTY_299_.old_tb2_1(3):='MO_INITATRIB_CT23E121408162'
;
RQTY_299_.tb2_1(3):=RQTY_299_.tb2_0(3);
RQTY_299_.tb2_2(3):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(3),
RQTY_299_.tb2_1(3),
RQTY_299_.tb2_2(3),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('16-07-2012 14:12:31','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:41','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(1):=1474;
RQTY_299_.tb6_1(1):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(1):=17;
RQTY_299_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(1),-1)));
RQTY_299_.old_tb6_3(1):=257;
RQTY_299_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(1),-1)));
RQTY_299_.old_tb6_4(1):=null;
RQTY_299_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(1),-1)));
RQTY_299_.old_tb6_5(1):=null;
RQTY_299_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(1),-1)));
RQTY_299_.tb6_7(1):=RQTY_299_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(1),
ENTITY_ID=RQTY_299_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(1),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(1),
RQTY_299_.tb6_1(1),
RQTY_299_.tb6_2(1),
RQTY_299_.tb6_3(1),
RQTY_299_.tb6_4(1),
RQTY_299_.tb6_5(1),
null,
RQTY_299_.tb6_7(1),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(2):=1475;
RQTY_299_.tb6_1(2):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(2):=17;
RQTY_299_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(2),-1)));
RQTY_299_.old_tb6_3(2):=269;
RQTY_299_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(2),-1)));
RQTY_299_.old_tb6_4(2):=null;
RQTY_299_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(2),-1)));
RQTY_299_.old_tb6_5(2):=null;
RQTY_299_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(2),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(2),
ENTITY_ID=RQTY_299_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Código del Tipo de Paquete'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(2),
RQTY_299_.tb6_1(2),
RQTY_299_.tb6_2(2),
RQTY_299_.tb6_3(2),
RQTY_299_.tb6_4(2),
RQTY_299_.tb6_5(2),
null,
null,
null,
null,
1,
'Código del Tipo de Paquete'
,
1,
'N'
,
'N'
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(3):=1476;
RQTY_299_.tb6_1(3):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(3):=17;
RQTY_299_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(3),-1)));
RQTY_299_.old_tb6_3(3):=255;
RQTY_299_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(3),-1)));
RQTY_299_.old_tb6_4(3):=null;
RQTY_299_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(3),-1)));
RQTY_299_.old_tb6_5(3):=null;
RQTY_299_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(3),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(3),
ENTITY_ID=RQTY_299_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(3),
RQTY_299_.tb6_1(3),
RQTY_299_.tb6_2(3),
RQTY_299_.tb6_3(3),
RQTY_299_.tb6_4(3),
RQTY_299_.tb6_5(3),
null,
null,
null,
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(4):=121408163;
RQTY_299_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(4):=RQTY_299_.tb2_0(4);
RQTY_299_.old_tb2_1(4):='MO_INITATRIB_CT23E121408163'
;
RQTY_299_.tb2_1(4):=RQTY_299_.tb2_0(4);
RQTY_299_.tb2_2(4):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(4),
RQTY_299_.tb2_1(4),
RQTY_299_.tb2_2(4),
'CF_BOINITRULES.INIREQUESTDATE()'
,
'LBTEST'
,
to_date('16-07-2012 14:11:53','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(5):=121408164;
RQTY_299_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(5):=RQTY_299_.tb2_0(5);
RQTY_299_.old_tb2_1(5):='MO_VALIDATTR_CT26E121408164'
;
RQTY_299_.tb2_1(5):=RQTY_299_.tb2_0(5);
RQTY_299_.tb2_2(5):=RQTY_299_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(5),
RQTY_299_.tb2_1(5),
RQTY_299_.tb2_2(5),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PROCESS","PACKAGE_TYPE_ID",nuPackageTypeId);nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPackageTypeId, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No está permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,););)'
,
'JUANPAMP'
,
to_date('15-04-2013 10:43:08','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(4):=1477;
RQTY_299_.tb6_1(4):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(4):=17;
RQTY_299_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(4),-1)));
RQTY_299_.old_tb6_3(4):=258;
RQTY_299_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(4),-1)));
RQTY_299_.old_tb6_4(4):=null;
RQTY_299_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(4),-1)));
RQTY_299_.old_tb6_5(4):=null;
RQTY_299_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(4),-1)));
RQTY_299_.tb6_7(4):=RQTY_299_.tb2_0(4);
RQTY_299_.tb6_8(4):=RQTY_299_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(4),
ENTITY_ID=RQTY_299_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(4),
VALID_EXPRESSION_ID=RQTY_299_.tb6_8(4),
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(4),
RQTY_299_.tb6_1(4),
RQTY_299_.tb6_2(4),
RQTY_299_.tb6_3(4),
RQTY_299_.tb6_4(4),
RQTY_299_.tb6_5(4),
null,
RQTY_299_.tb6_7(4),
RQTY_299_.tb6_8(4),
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
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(6):=121408165;
RQTY_299_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(6):=RQTY_299_.tb2_0(6);
RQTY_299_.old_tb2_1(6):='MO_INITATRIB_CT23E121408165'
;
RQTY_299_.tb2_1(6):=RQTY_299_.tb2_0(6);
RQTY_299_.tb2_2(6):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(6),
RQTY_299_.tb2_1(6),
RQTY_299_.tb2_2(6),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('16-07-2012 14:13:46','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PACKAGE - PERSON_ID - Incializa el Vendedor'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(7):=121408166;
RQTY_299_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(7):=RQTY_299_.tb2_0(7);
RQTY_299_.old_tb2_1(7):='MO_VALIDATTR_CT26E121408166'
;
RQTY_299_.tb2_1(7):=RQTY_299_.tb2_0(7);
RQTY_299_.tb2_2(7):=RQTY_299_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(7),
RQTY_299_.tb2_1(7),
RQTY_299_.tb2_2(7),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPersonId);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,Null,"MO_PACKAGES","OPERATING_UNIT_ID",nuSaleChannel,True)'
,
'LBTEST'
,
to_date('09-10-2012 14:52:40','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb7_0(0):=120198274;
RQTY_299_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_299_.tb7_0(0):=RQTY_299_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_299_.tb7_0(0),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(5):=1478;
RQTY_299_.tb6_1(5):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(5):=17;
RQTY_299_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(5),-1)));
RQTY_299_.old_tb6_3(5):=50001162;
RQTY_299_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(5),-1)));
RQTY_299_.old_tb6_4(5):=null;
RQTY_299_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(5),-1)));
RQTY_299_.old_tb6_5(5):=null;
RQTY_299_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(5),-1)));
RQTY_299_.tb6_6(5):=RQTY_299_.tb7_0(0);
RQTY_299_.tb6_7(5):=RQTY_299_.tb2_0(6);
RQTY_299_.tb6_8(5):=RQTY_299_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(5),
ENTITY_ID=RQTY_299_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(5),
STATEMENT_ID=RQTY_299_.tb6_6(5),
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(5),
VALID_EXPRESSION_ID=RQTY_299_.tb6_8(5),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(5),
RQTY_299_.tb6_1(5),
RQTY_299_.tb6_2(5),
RQTY_299_.tb6_3(5),
RQTY_299_.tb6_4(5),
RQTY_299_.tb6_5(5),
RQTY_299_.tb6_6(5),
RQTY_299_.tb6_7(5),
RQTY_299_.tb6_8(5),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(8):=121408167;
RQTY_299_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(8):=RQTY_299_.tb2_0(8);
RQTY_299_.old_tb2_1(8):='MO_INITATRIB_CT23E121408167'
;
RQTY_299_.tb2_1(8):=RQTY_299_.tb2_0(8);
RQTY_299_.tb2_2(8):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(8),
RQTY_299_.tb2_1(8),
RQTY_299_.tb2_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('16-07-2012 14:13:16','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb7_0(1):=120198275;
RQTY_299_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_299_.tb7_0(1):=RQTY_299_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_299_.tb7_0(1),
16,
'Tipos de Recepción de Queja'
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
'Tipos de Recepción de Queja'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(6):=1481;
RQTY_299_.tb6_1(6):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(6):=17;
RQTY_299_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(6),-1)));
RQTY_299_.old_tb6_3(6):=2683;
RQTY_299_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(6),-1)));
RQTY_299_.old_tb6_4(6):=null;
RQTY_299_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(6),-1)));
RQTY_299_.old_tb6_5(6):=null;
RQTY_299_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(6),-1)));
RQTY_299_.tb6_6(6):=RQTY_299_.tb7_0(1);
RQTY_299_.tb6_7(6):=RQTY_299_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(6),
ENTITY_ID=RQTY_299_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(6),
STATEMENT_ID=RQTY_299_.tb6_6(6),
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Medio de recepción'
,
DISPLAY_ORDER=6,
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(6),
RQTY_299_.tb6_1(6),
RQTY_299_.tb6_2(6),
RQTY_299_.tb6_3(6),
RQTY_299_.tb6_4(6),
RQTY_299_.tb6_5(6),
RQTY_299_.tb6_6(6),
RQTY_299_.tb6_7(6),
null,
null,
6,
'Medio de recepción'
,
6,
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
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(9):=121408168;
RQTY_299_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(9):=RQTY_299_.tb2_0(9);
RQTY_299_.old_tb2_1(9):='MO_INITATRIB_CT23E121408168'
;
RQTY_299_.tb2_1(9):=RQTY_299_.tb2_0(9);
RQTY_299_.tb2_2(9):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(9),
RQTY_299_.tb2_1(9),
RQTY_299_.tb2_2(9),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('16-07-2012 14:30:25','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(7):=1482;
RQTY_299_.tb6_1(7):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(7):=17;
RQTY_299_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(7),-1)));
RQTY_299_.old_tb6_3(7):=146755;
RQTY_299_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(7),-1)));
RQTY_299_.old_tb6_4(7):=null;
RQTY_299_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(7),-1)));
RQTY_299_.old_tb6_5(7):=null;
RQTY_299_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(7),-1)));
RQTY_299_.tb6_7(7):=RQTY_299_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(7),
ENTITY_ID=RQTY_299_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(7),
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(7),
RQTY_299_.tb6_1(7),
RQTY_299_.tb6_2(7),
RQTY_299_.tb6_3(7),
RQTY_299_.tb6_4(7),
RQTY_299_.tb6_5(7),
null,
RQTY_299_.tb6_7(7),
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
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(10):=121408169;
RQTY_299_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(10):=RQTY_299_.tb2_0(10);
RQTY_299_.old_tb2_1(10):='MO_INITATRIB_CT23E121408169'
;
RQTY_299_.tb2_1(10):=RQTY_299_.tb2_0(10);
RQTY_299_.tb2_2(10):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(10),
RQTY_299_.tb2_1(10),
RQTY_299_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'LBTEST'
,
to_date('16-07-2012 14:16:06','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(8):=1483;
RQTY_299_.tb6_1(8):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(8):=17;
RQTY_299_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(8),-1)));
RQTY_299_.old_tb6_3(8):=146756;
RQTY_299_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(8),-1)));
RQTY_299_.old_tb6_4(8):=null;
RQTY_299_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(8),-1)));
RQTY_299_.old_tb6_5(8):=null;
RQTY_299_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(8),-1)));
RQTY_299_.tb6_7(8):=RQTY_299_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(8),
ENTITY_ID=RQTY_299_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(8),
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(8),
RQTY_299_.tb6_1(8),
RQTY_299_.tb6_2(8),
RQTY_299_.tb6_3(8),
RQTY_299_.tb6_4(8),
RQTY_299_.tb6_5(8),
null,
RQTY_299_.tb6_7(8),
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
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(11):=121408170;
RQTY_299_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(11):=RQTY_299_.tb2_0(11);
RQTY_299_.old_tb2_1(11):='MO_INITATRIB_CT23E121408170'
;
RQTY_299_.tb2_1(11):=RQTY_299_.tb2_0(11);
RQTY_299_.tb2_2(11):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(11),
RQTY_299_.tb2_1(11),
RQTY_299_.tb2_2(11),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'LBTEST'
,
to_date('16-07-2012 17:22:24','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(9):=1484;
RQTY_299_.tb6_1(9):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(9):=17;
RQTY_299_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(9),-1)));
RQTY_299_.old_tb6_3(9):=259;
RQTY_299_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(9),-1)));
RQTY_299_.old_tb6_4(9):=null;
RQTY_299_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(9),-1)));
RQTY_299_.old_tb6_5(9):=null;
RQTY_299_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(9),-1)));
RQTY_299_.tb6_7(9):=RQTY_299_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(9),
ENTITY_ID=RQTY_299_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Fecha de Envío'
,
DISPLAY_ORDER=9,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(9),
RQTY_299_.tb6_1(9),
RQTY_299_.tb6_2(9),
RQTY_299_.tb6_3(9),
RQTY_299_.tb6_4(9),
RQTY_299_.tb6_5(9),
null,
RQTY_299_.tb6_7(9),
null,
null,
9,
'Fecha de Envío'
,
9,
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(10):=1485;
RQTY_299_.tb6_1(10):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(10):=17;
RQTY_299_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(10),-1)));
RQTY_299_.old_tb6_3(10):=109478;
RQTY_299_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(10),-1)));
RQTY_299_.old_tb6_4(10):=null;
RQTY_299_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(10),-1)));
RQTY_299_.old_tb6_5(10):=null;
RQTY_299_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(10),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(10),
ENTITY_ID=RQTY_299_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Unidad Operativa Del Vendedor'
,
DISPLAY_ORDER=10,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(10),
RQTY_299_.tb6_1(10),
RQTY_299_.tb6_2(10),
RQTY_299_.tb6_3(10),
RQTY_299_.tb6_4(10),
RQTY_299_.tb6_5(10),
null,
null,
null,
null,
10,
'Unidad Operativa Del Vendedor'
,
10,
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(11):=1486;
RQTY_299_.tb6_1(11):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(11):=17;
RQTY_299_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(11),-1)));
RQTY_299_.old_tb6_3(11):=42118;
RQTY_299_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(11),-1)));
RQTY_299_.old_tb6_4(11):=109479;
RQTY_299_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(11),-1)));
RQTY_299_.old_tb6_5(11):=null;
RQTY_299_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(11),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(11),
ENTITY_ID=RQTY_299_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Código Canal De Ventas'
,
DISPLAY_ORDER=11,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(11),
RQTY_299_.tb6_1(11),
RQTY_299_.tb6_2(11),
RQTY_299_.tb6_3(11),
RQTY_299_.tb6_4(11),
RQTY_299_.tb6_5(11),
null,
null,
null,
null,
11,
'Código Canal De Ventas'
,
11,
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(12):=121408171;
RQTY_299_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(12):=RQTY_299_.tb2_0(12);
RQTY_299_.old_tb2_1(12):='MO_INITATRIB_CT23E121408171'
;
RQTY_299_.tb2_1(12):=RQTY_299_.tb2_0(12);
RQTY_299_.tb2_2(12):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(12),
RQTY_299_.tb2_1(12),
RQTY_299_.tb2_2(12),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbId)'
,
'LBTEST'
,
to_date('16-07-2012 14:17:13','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGES.SUBSCRIBER_ID - Modificación Datos de Cliente'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(12):=1487;
RQTY_299_.tb6_1(12):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(12):=17;
RQTY_299_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(12),-1)));
RQTY_299_.old_tb6_3(12):=4015;
RQTY_299_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(12),-1)));
RQTY_299_.old_tb6_4(12):=null;
RQTY_299_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(12),-1)));
RQTY_299_.old_tb6_5(12):=null;
RQTY_299_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(12),-1)));
RQTY_299_.tb6_7(12):=RQTY_299_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(12),
ENTITY_ID=RQTY_299_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(12),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador del Cliente'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='N'
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(12),
RQTY_299_.tb6_1(12),
RQTY_299_.tb6_2(12),
RQTY_299_.tb6_3(12),
RQTY_299_.tb6_4(12),
RQTY_299_.tb6_5(12),
null,
RQTY_299_.tb6_7(12),
null,
null,
12,
'Identificador del Cliente'
,
12,
'N'
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
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(13):=1488;
RQTY_299_.tb6_1(13):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(13):=17;
RQTY_299_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(13),-1)));
RQTY_299_.old_tb6_3(13):=146754;
RQTY_299_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(13),-1)));
RQTY_299_.old_tb6_4(13):=null;
RQTY_299_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(13),-1)));
RQTY_299_.old_tb6_5(13):=null;
RQTY_299_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(13),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(13),
ENTITY_ID=RQTY_299_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Observación'
,
DISPLAY_ORDER=14,
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(13),
RQTY_299_.tb6_1(13),
RQTY_299_.tb6_2(13),
RQTY_299_.tb6_3(13),
RQTY_299_.tb6_4(13),
RQTY_299_.tb6_5(13),
null,
null,
null,
null,
14,
'Observación'
,
14,
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
'N'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(13):=121408172;
RQTY_299_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(13):=RQTY_299_.tb2_0(13);
RQTY_299_.old_tb2_1(13):='MO_INITATRIB_CT23E121408172'
;
RQTY_299_.tb2_1(13):=RQTY_299_.tb2_0(13);
RQTY_299_.tb2_2(13):=RQTY_299_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(13),
RQTY_299_.tb2_1(13),
RQTY_299_.tb2_2(13),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('09-10-2012 15:03:52','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:43','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:43','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb7_0(2):=120198276;
RQTY_299_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_299_.tb7_0(2):=RQTY_299_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_299_.tb7_0(2),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb6_0(14):=2165;
RQTY_299_.tb6_1(14):=RQTY_299_.tb5_0(0);
RQTY_299_.old_tb6_2(14):=17;
RQTY_299_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_299_.TBENTITYNAME(NVL(RQTY_299_.old_tb6_2(14),-1)));
RQTY_299_.old_tb6_3(14):=109479;
RQTY_299_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_3(14),-1)));
RQTY_299_.old_tb6_4(14):=null;
RQTY_299_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_4(14),-1)));
RQTY_299_.old_tb6_5(14):=null;
RQTY_299_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_299_.TBENTITYATTRIBUTENAME(NVL(RQTY_299_.old_tb6_5(14),-1)));
RQTY_299_.tb6_6(14):=RQTY_299_.tb7_0(2);
RQTY_299_.tb6_7(14):=RQTY_299_.tb2_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_299_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_299_.tb6_1(14),
ENTITY_ID=RQTY_299_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_299_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_299_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_299_.tb6_5(14),
STATEMENT_ID=RQTY_299_.tb6_6(14),
INIT_EXPRESSION_ID=RQTY_299_.tb6_7(14),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_299_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_299_.tb6_0(14),
RQTY_299_.tb6_1(14),
RQTY_299_.tb6_2(14),
RQTY_299_.tb6_3(14),
RQTY_299_.tb6_4(14),
RQTY_299_.tb6_5(14),
RQTY_299_.tb6_6(14),
RQTY_299_.tb6_7(14),
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
'Y'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb8_0(0):=204;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_299_.tb8_0(0),
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

 WHERE ATTRIBUTE_ID = RQTY_299_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_299_.tb8_0(0),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb9_0(0):=RQTY_299_.tb5_0(0);
RQTY_299_.tb9_1(0):=RQTY_299_.tb8_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_299_.tb9_0(0),
RQTY_299_.tb9_1(0),
'Se planean actividades para ser usadas en la cotizacion?'
,
'N'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb8_0(1):=108;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_299_.tb8_0(1),
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

 WHERE ATTRIBUTE_ID = RQTY_299_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_299_.tb8_0(1),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb9_0(1):=RQTY_299_.tb5_0(0);
RQTY_299_.tb9_1(1):=RQTY_299_.tb8_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_299_.tb9_0(1),
RQTY_299_.tb9_1(1),
'Plan comercial por defecto'
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb8_0(2):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_299_.tb8_0(2),
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

 WHERE ATTRIBUTE_ID = RQTY_299_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_299_.tb8_0(2),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb9_0(2):=RQTY_299_.tb5_0(0);
RQTY_299_.tb9_1(2):=RQTY_299_.tb8_0(2);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (2)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_299_.tb9_0(2),
RQTY_299_.tb9_1(2),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb10_0(0):=73;
RQTY_299_.tb10_1(0):=RQTY_299_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_299_.tb10_0(0),
PACKAGE_TYPE_ID=RQTY_299_.tb10_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=218,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_299_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_299_.tb10_0(0),
RQTY_299_.tb10_1(0),
null,
null,
218,
21);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb11_0(0):=26;
RQTY_299_.tb11_1(0):=RQTY_299_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_299_.tb11_0(0),
VALUE_1=RQTY_299_.tb11_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=218,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Solicitud de Servicio Técnico Clientes Externos '
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_299_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_299_.tb11_0(0),
RQTY_299_.tb11_1(0),
null,
21,
218,
0,
31536000,
0,
'Solicitud de Servicio Técnico Clientes Externos '
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb12_0(0):=15;
RQTY_299_.tb12_1(0):=RQTY_299_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_EVENTS fila (0)',1);
UPDATE PS_PACKAGE_EVENTS SET PACKAGE_EVENTS_ID=RQTY_299_.tb12_0(0),
PACKAGE_TYPE_ID=RQTY_299_.tb12_1(0),
EVENT_ID=1
 WHERE PACKAGE_EVENTS_ID = RQTY_299_.tb12_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_EVENTS(PACKAGE_EVENTS_ID,PACKAGE_TYPE_ID,EVENT_ID) 
VALUES (RQTY_299_.tb12_0(0),
RQTY_299_.tb12_1(0),
1);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb1_0(3):=65;
RQTY_299_.tb1_1(3):=RQTY_299_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_299_.tb1_0(3),
MODULE_ID=RQTY_299_.tb1_1(3),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQTY_299_.tb1_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_299_.tb1_0(3),
RQTY_299_.tb1_1(3),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.old_tb2_0(14):=121408173;
RQTY_299_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_299_.tb2_0(14):=RQTY_299_.tb2_0(14);
RQTY_299_.old_tb2_1(14):='MO_EVE_COMP_CT65E121408173'
;
RQTY_299_.tb2_1(14):=RQTY_299_.tb2_0(14);
RQTY_299_.tb2_2(14):=RQTY_299_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_299_.tb2_0(14),
RQTY_299_.tb2_1(14),
RQTY_299_.tb2_2(14),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);if (GE_BOINSTANCECONTROL.FBLACCKEYENTITYSTACK(sbInstancia, null, "MO_BILLING_ADDRESS", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.DESTROYENTITY(sbInstancia,null,"MO_BILLING_ADDRESS");GE_BOINSTANCECONTROL.DESTROYENTITY(sbInstancia,null,"MO_SUBSCRIPTION");,)'
,
'LBTEST'
,
to_date('18-07-2012 15:08:07','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:43','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:45:43','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'EVE - PRE - Instancia Contrato - VtaServTecExt'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb13_0(0):=21;
RQTY_299_.tb13_1(0):=RQTY_299_.tb12_0(0);
RQTY_299_.tb13_2(0):=RQTY_299_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_PACKAGE fila (0)',1);
UPDATE PS_WHEN_PACKAGE SET WHEN_PACKAGE_ID=RQTY_299_.tb13_0(0),
PACKAGE_EVENT_ID=RQTY_299_.tb13_1(0),
CONFIG_EXPRESSION_ID=RQTY_299_.tb13_2(0),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_PACKAGE_ID = RQTY_299_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_PACKAGE(WHEN_PACKAGE_ID,PACKAGE_EVENT_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQTY_299_.tb13_0(0),
RQTY_299_.tb13_1(0),
RQTY_299_.tb13_2(0),
'B'
,
'Y'
);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb14_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_299_.tb14_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb15_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_299_.tb15_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb16_0(0):=6121;
RQTY_299_.tb16_2(0):=RQTY_299_.tb14_0(0);
RQTY_299_.tb16_3(0):=RQTY_299_.tb15_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_299_.tb16_0(0),
SERVCLAS=null,
SERVTISE=RQTY_299_.tb16_2(0),
SERVSETI=RQTY_299_.tb16_3(0),
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
 WHERE SERVCODI = RQTY_299_.tb16_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_299_.tb16_0(0),
null,
RQTY_299_.tb16_2(0),
RQTY_299_.tb16_3(0),
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb17_0(0):=22;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_299_.tb17_0(0),
CLASS_REGISTER_ID=6,
DESCRIPTION='Servicio Tecnico Externo'
,
ASSIGNABLE='N'
,
USE_WF_PLAN='Y'
,
TAG_NAME='MOTY_SERVICIO_TECNICO_EXTERNO'
,
ACTIVITY_TYPE=null
 WHERE MOTIVE_TYPE_ID = RQTY_299_.tb17_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_299_.tb17_0(0),
6,
'Servicio Tecnico Externo'
,
'N'
,
'Y'
,
'MOTY_SERVICIO_TECNICO_EXTERNO'
,
null);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb18_0(0):=99;
RQTY_299_.tb18_1(0):=RQTY_299_.tb16_0(0);
RQTY_299_.tb18_2(0):=RQTY_299_.tb17_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_299_.tb18_0(0),
RQTY_299_.tb18_1(0),
RQTY_299_.tb18_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
,
'Servicio Técnico Clientes Externos '
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
RQTY_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_299_.blProcessStatus) then
 return;
end if;

RQTY_299_.tb19_0(0):=106;
RQTY_299_.tb19_1(0):=RQTY_299_.tb18_0(0);
RQTY_299_.tb19_3(0):=RQTY_299_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_299_.tb19_0(0),
PRODUCT_MOTIVE_ID=RQTY_299_.tb19_1(0),
PRODUCT_TYPE_ID=6121,
PACKAGE_TYPE_ID=RQTY_299_.tb19_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_299_.tb19_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_299_.tb19_0(0),
RQTY_299_.tb19_1(0),
6121,
RQTY_299_.tb19_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_299_.blProcessStatus := false;
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
nuIndex := RQTY_299_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_299_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_299_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_299_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_299_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_299_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_299_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_299_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_299_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_299_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_299_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_299_.blProcessStatus := false;
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
 nuIndex := RQTY_299_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_299_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_299_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_299_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_299_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_299_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_299_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_299_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_299_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_299_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_299_',
'CREATE OR REPLACE PACKAGE RQPMT_299_ IS ' || chr(10) ||
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
'where  package_type_id = 299; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 299 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 299 ' || chr(10) ||
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
'END RQPMT_299_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_299_******************************'); END;
/

BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_299_.cuExpressions;
fetch RQPMT_299_.cuExpressions bulk collect INTO RQPMT_299_.tbExpressionsId;
close RQPMT_299_.cuExpressions;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_299_.tbEntityName(-1) := 'NULL';
   RQPMT_299_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_299_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_299_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(204) := 'MO_MOTIVE@MOTIV_RECORDING_DATE';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(36570) := 'MO_MOTIVE@TAG_NAME';
   RQPMT_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_299_.tbEntityAttributeName(175194) := 'MO_DATA_FOR_ORDER@QUANTITY';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQPMT_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_299_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQPMT_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_299_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQPMT_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_299_.tbEntityAttributeName(44501) := 'MO_DATA_FOR_ORDER@ITEM_ID';
   RQPMT_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_299_.tbEntityAttributeName(2877) := 'MO_DATA_FOR_ORDER@MOTIVE_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_299_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_299_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQPMT_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_299_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQPMT_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_299_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQPMT_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_299_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQPMT_299_.tbEntityAttributeName(2875) := 'MO_DATA_FOR_ORDER@DATA_FOR_ORDER_ID';
   RQPMT_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_299_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQPMT_299_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_299_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
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
WHERE PACKAGE_type_id = 299
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
WHERE PACKAGE_type_id = 299
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
WHERE PACKAGE_type_id = 299
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
WHERE PACKAGE_type_id = 299
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
WHERE PACKAGE_type_id = 299
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
WHERE PACKAGE_type_id = 299
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_299_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 299
))));

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_299_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_299_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_299_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_299_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 299
))));

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 299
))));

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_299_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_299_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 299
)))));

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_299_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_299_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_299_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_299_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_299_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_299_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 299
))));

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
))));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 299
))));

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
)));
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_299_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_299_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_299_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_299_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_299_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_299_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_299_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_299_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 299
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_299_.blProcessStatus) then
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb0_0(0):=99;
RQPMT_299_.tb0_1(0):=6121;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_299_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_299_.tb0_1(0),
MOTIVE_TYPE_ID=22,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
,
DESCRIPTION='Servicio Técnico Clientes Externos '
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_299_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_299_.tb0_0(0),
RQPMT_299_.tb0_1(0),
22,
null,
'N'
,
'N'
,
'N'
,
'M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
,
'Servicio Técnico Clientes Externos '
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(0):=103761;
RQPMT_299_.old_tb1_1(0):=118;
RQPMT_299_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(0),-1)));
RQPMT_299_.old_tb1_2(0):=2877;
RQPMT_299_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(0),-1)));
RQPMT_299_.old_tb1_3(0):=187;
RQPMT_299_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(0),-1)));
RQPMT_299_.old_tb1_4(0):=null;
RQPMT_299_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(0),-1)));
RQPMT_299_.tb1_9(0):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(0),
ENTITY_ID=RQPMT_299_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(0),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Id Del Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(0),
RQPMT_299_.tb1_1(0),
RQPMT_299_.tb1_2(0),
RQPMT_299_.tb1_3(0),
RQPMT_299_.tb1_4(0),
null,
null,
null,
null,
RQPMT_299_.tb1_9(0),
15,
'Id Del Motivo'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_299_.tb2_0(0),
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

 WHERE MODULE_ID = RQPMT_299_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_299_.tb2_0(0),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb3_0(0):=23;
RQPMT_299_.tb3_1(0):=RQPMT_299_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_299_.tb3_0(0),
MODULE_ID=RQPMT_299_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_299_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_299_.tb3_0(0),
RQPMT_299_.tb3_1(0),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(0):=121408174;
RQPMT_299_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(0):=RQPMT_299_.tb4_0(0);
RQPMT_299_.old_tb4_1(0):='MO_INITATRIB_CT23E121408174'
;
RQPMT_299_.tb4_1(0):=RQPMT_299_.tb4_0(0);
RQPMT_299_.tb4_2(0):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(0),
RQPMT_299_.tb4_1(0),
RQPMT_299_.tb4_2(0),
'nuCommPlan = PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(299, 108, GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuCommPlan)'
,
'LBTEST'
,
to_date('18-07-2012 11:20:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - Plan Comercial - VtaSerTecExt'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(1):=1666;
RQPMT_299_.old_tb1_1(1):=8;
RQPMT_299_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(1),-1)));
RQPMT_299_.old_tb1_2(1):=45189;
RQPMT_299_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(1),-1)));
RQPMT_299_.old_tb1_3(1):=null;
RQPMT_299_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(1),-1)));
RQPMT_299_.old_tb1_4(1):=null;
RQPMT_299_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(1),-1)));
RQPMT_299_.tb1_6(1):=RQPMT_299_.tb4_0(0);
RQPMT_299_.tb1_9(1):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(1),
ENTITY_ID=RQPMT_299_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(1),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(1),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Identificador Plan Comercial'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(1),
RQPMT_299_.tb1_1(1),
RQPMT_299_.tb1_2(1),
RQPMT_299_.tb1_3(1),
RQPMT_299_.tb1_4(1),
null,
RQPMT_299_.tb1_6(1),
null,
null,
RQPMT_299_.tb1_9(1),
17,
'Identificador Plan Comercial'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(1):=121408175;
RQPMT_299_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(1):=RQPMT_299_.tb4_0(1);
RQPMT_299_.old_tb4_1(1):='MO_INITATRIB_CT23E121408175'
;
RQPMT_299_.tb4_1(1):=RQPMT_299_.tb4_0(1);
RQPMT_299_.tb4_2(1):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(1),
RQPMT_299_.tb4_1(1),
RQPMT_299_.tb4_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETADDRESSID())'
,
'LBTEST'
,
to_date('23-08-2012 18:39:08','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Ini- MO_ADDRESS.ADDRESS_ID Servicio Tecnico Externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(2):=1851;
RQPMT_299_.old_tb1_1(2):=21;
RQPMT_299_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(2),-1)));
RQPMT_299_.old_tb1_2(2):=474;
RQPMT_299_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(2),-1)));
RQPMT_299_.old_tb1_3(2):=null;
RQPMT_299_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(2),-1)));
RQPMT_299_.old_tb1_4(2):=null;
RQPMT_299_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(2),-1)));
RQPMT_299_.tb1_6(2):=RQPMT_299_.tb4_0(1);
RQPMT_299_.tb1_9(2):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(2),
ENTITY_ID=RQPMT_299_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(2),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(2),
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Código de la Dirección'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(2),
RQPMT_299_.tb1_1(2),
RQPMT_299_.tb1_2(2),
RQPMT_299_.tb1_3(2),
RQPMT_299_.tb1_4(2),
null,
RQPMT_299_.tb1_6(2),
null,
null,
RQPMT_299_.tb1_9(2),
19,
'Código de la Dirección'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(3):=1852;
RQPMT_299_.old_tb1_1(3):=21;
RQPMT_299_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(3),-1)));
RQPMT_299_.old_tb1_2(3):=281;
RQPMT_299_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(3),-1)));
RQPMT_299_.old_tb1_3(3):=187;
RQPMT_299_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(3),-1)));
RQPMT_299_.old_tb1_4(3):=null;
RQPMT_299_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(3),-1)));
RQPMT_299_.tb1_9(3):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(3),
ENTITY_ID=RQPMT_299_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(3),
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Consecutivo Interno Motivos'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(3),
RQPMT_299_.tb1_1(3),
RQPMT_299_.tb1_2(3),
RQPMT_299_.tb1_3(3),
RQPMT_299_.tb1_4(3),
null,
null,
null,
null,
RQPMT_299_.tb1_9(3),
20,
'Consecutivo Interno Motivos'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(4):=1853;
RQPMT_299_.old_tb1_1(4):=21;
RQPMT_299_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(4),-1)));
RQPMT_299_.old_tb1_2(4):=39322;
RQPMT_299_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(4),-1)));
RQPMT_299_.old_tb1_3(4):=255;
RQPMT_299_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(4),-1)));
RQPMT_299_.old_tb1_4(4):=null;
RQPMT_299_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(4),-1)));
RQPMT_299_.tb1_9(4):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(4),
ENTITY_ID=RQPMT_299_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(4),
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Identificador De Solicitud'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(4),
RQPMT_299_.tb1_1(4),
RQPMT_299_.tb1_2(4),
RQPMT_299_.tb1_3(4),
RQPMT_299_.tb1_4(4),
null,
null,
null,
null,
RQPMT_299_.tb1_9(4),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(2):=121408176;
RQPMT_299_.tb4_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(2):=RQPMT_299_.tb4_0(2);
RQPMT_299_.old_tb4_1(2):='MO_INITATRIB_CT23E121408176'
;
RQPMT_299_.tb4_1(2):=RQPMT_299_.tb4_0(2);
RQPMT_299_.tb4_2(2):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(2),
RQPMT_299_.tb4_1(2),
RQPMT_299_.tb4_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'LBTEST'
,
to_date('16-07-2012 14:44:05','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(5):=1646;
RQPMT_299_.old_tb1_1(5):=8;
RQPMT_299_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(5),-1)));
RQPMT_299_.old_tb1_2(5):=187;
RQPMT_299_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(5),-1)));
RQPMT_299_.old_tb1_3(5):=null;
RQPMT_299_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(5),-1)));
RQPMT_299_.old_tb1_4(5):=null;
RQPMT_299_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(5),-1)));
RQPMT_299_.tb1_6(5):=RQPMT_299_.tb4_0(2);
RQPMT_299_.tb1_9(5):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(5),
ENTITY_ID=RQPMT_299_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(5),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Código del Motivo'
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
TAG_NAME='CODIGO_DEL_MOTIVO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(5),
RQPMT_299_.tb1_1(5),
RQPMT_299_.tb1_2(5),
RQPMT_299_.tb1_3(5),
RQPMT_299_.tb1_4(5),
null,
RQPMT_299_.tb1_6(5),
null,
null,
RQPMT_299_.tb1_9(5),
0,
'Código del Motivo'
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
'CODIGO_DEL_MOTIVO'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb2_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_299_.tb2_0(1),
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

 WHERE MODULE_ID = RQPMT_299_.tb2_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_299_.tb2_0(1),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb3_0(1):=69;
RQPMT_299_.tb3_1(1):=RQPMT_299_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_299_.tb3_0(1),
MODULE_ID=RQPMT_299_.tb3_1(1),
DESCRIPTION='Reglas validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULVAL_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_299_.tb3_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_299_.tb3_0(1),
RQPMT_299_.tb3_1(1),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(3):=121408177;
RQPMT_299_.tb4_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(3):=RQPMT_299_.tb4_0(3);
RQPMT_299_.old_tb4_1(3):='GEGE_EXERULVAL_CT69E121408177'
;
RQPMT_299_.tb4_1(3):=RQPMT_299_.tb4_0(3);
RQPMT_299_.tb4_2(3):=RQPMT_299_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(3),
RQPMT_299_.tb4_1(3),
RQPMT_299_.tb4_2(3),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbPriority);nuPriority = UT_CONVERT.FNUCHARTONUMBER(sbPriority);if (nuPriority <= 0,GE_BOERRORS.SETERRORCODE(3305);,nuMaximPriority = GE_BOPARAMETER.FNUGET("MAX_PRIORITY", "N");if (nuPriority > nuMaximPriority,GE_BOERRORS.SETERRORCODE(9510);,);)'
,
'INTEGRA'
,
to_date('15-03-2012 11:52:50','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:13','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb3_0(2):=67;
RQPMT_299_.tb3_1(2):=RQPMT_299_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_299_.tb3_0(2),
MODULE_ID=RQPMT_299_.tb3_1(2),
DESCRIPTION='Reglas inicialización de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='GE_EXERULINI_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_299_.tb3_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_299_.tb3_0(2),
RQPMT_299_.tb3_1(2),
'Reglas inicialización de atributos'
,
'PL'
,
'FD'
,
'DS'
,
'GE_EXERULINI_'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(4):=121408178;
RQPMT_299_.tb4_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(4):=RQPMT_299_.tb4_0(4);
RQPMT_299_.old_tb4_1(4):='GEGE_EXERULINI_CT67E121408178'
;
RQPMT_299_.tb4_1(4):=RQPMT_299_.tb4_0(4);
RQPMT_299_.tb4_2(4):=RQPMT_299_.tb3_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(4),
RQPMT_299_.tb4_1(4),
RQPMT_299_.tb4_2(4),
'nuPriority = GE_BOPARAMETER.FNUGET("DEFAULT_PRIORITY", "N");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuPriority)'
,
'INTEGRA'
,
to_date('15-03-2012 11:20:09','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(6):=1647;
RQPMT_299_.old_tb1_1(6):=8;
RQPMT_299_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(6),-1)));
RQPMT_299_.old_tb1_2(6):=203;
RQPMT_299_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(6),-1)));
RQPMT_299_.old_tb1_3(6):=null;
RQPMT_299_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(6),-1)));
RQPMT_299_.old_tb1_4(6):=null;
RQPMT_299_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(6),-1)));
RQPMT_299_.tb1_6(6):=RQPMT_299_.tb4_0(4);
RQPMT_299_.tb1_7(6):=RQPMT_299_.tb4_0(3);
RQPMT_299_.tb1_9(6):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(6),
ENTITY_ID=RQPMT_299_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(6),
VALID_EXPRESSION_ID=RQPMT_299_.tb1_7(6),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(6),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Prioridad'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(6),
RQPMT_299_.tb1_1(6),
RQPMT_299_.tb1_2(6),
RQPMT_299_.tb1_3(6),
RQPMT_299_.tb1_4(6),
null,
RQPMT_299_.tb1_6(6),
RQPMT_299_.tb1_7(6),
null,
RQPMT_299_.tb1_9(6),
1,
'Prioridad'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(5):=121408179;
RQPMT_299_.tb4_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(5):=RQPMT_299_.tb4_0(5);
RQPMT_299_.old_tb4_1(5):='MO_INITATRIB_CT23E121408179'
;
RQPMT_299_.tb4_1(5):=RQPMT_299_.tb4_0(5);
RQPMT_299_.tb4_2(5):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(5),
RQPMT_299_.tb4_1(5),
RQPMT_299_.tb4_2(5),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'OPF5'
,
to_date('22-03-2002 11:58:57','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Fecha de Registro Peticion'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(7):=1648;
RQPMT_299_.old_tb1_1(7):=8;
RQPMT_299_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(7),-1)));
RQPMT_299_.old_tb1_2(7):=204;
RQPMT_299_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(7),-1)));
RQPMT_299_.old_tb1_3(7):=258;
RQPMT_299_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(7),-1)));
RQPMT_299_.old_tb1_4(7):=null;
RQPMT_299_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(7),-1)));
RQPMT_299_.tb1_6(7):=RQPMT_299_.tb4_0(5);
RQPMT_299_.tb1_9(7):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(7),
ENTITY_ID=RQPMT_299_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(7),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Fecha registro'
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
TAG_NAME='FECHA_REGISTRO'
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
ATTRI_TECHNICAL_NAME='MOTIV_RECORDING_DATE'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(7),
RQPMT_299_.tb1_1(7),
RQPMT_299_.tb1_2(7),
RQPMT_299_.tb1_3(7),
RQPMT_299_.tb1_4(7),
null,
RQPMT_299_.tb1_6(7),
null,
null,
RQPMT_299_.tb1_9(7),
2,
'Fecha registro'
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
'FECHA_REGISTRO'
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
'MOTIV_RECORDING_DATE'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(8):=1649;
RQPMT_299_.old_tb1_1(8):=8;
RQPMT_299_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(8),-1)));
RQPMT_299_.old_tb1_2(8):=213;
RQPMT_299_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(8),-1)));
RQPMT_299_.old_tb1_3(8):=255;
RQPMT_299_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(8),-1)));
RQPMT_299_.old_tb1_4(8):=null;
RQPMT_299_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(8),-1)));
RQPMT_299_.tb1_9(8):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(8),
ENTITY_ID=RQPMT_299_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(8),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Solicitud'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(8),
RQPMT_299_.tb1_1(8),
RQPMT_299_.tb1_2(8),
RQPMT_299_.tb1_3(8),
RQPMT_299_.tb1_4(8),
null,
null,
null,
null,
RQPMT_299_.tb1_9(8),
3,
'Solicitud'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(9):=1650;
RQPMT_299_.old_tb1_1(9):=8;
RQPMT_299_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(9),-1)));
RQPMT_299_.old_tb1_2(9):=189;
RQPMT_299_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(9),-1)));
RQPMT_299_.old_tb1_3(9):=257;
RQPMT_299_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(9),-1)));
RQPMT_299_.old_tb1_4(9):=null;
RQPMT_299_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(9),-1)));
RQPMT_299_.tb1_9(9):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(9),
ENTITY_ID=RQPMT_299_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(9),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Solicitud atención al cliente'
,
DISPLAY_ORDER=4,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='SOLICITUD_ATENCION_AL_CLIENTE'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(9),
RQPMT_299_.tb1_1(9),
RQPMT_299_.tb1_2(9),
RQPMT_299_.tb1_3(9),
RQPMT_299_.tb1_4(9),
null,
null,
null,
null,
RQPMT_299_.tb1_9(9),
4,
'Solicitud atención al cliente'
,
4,
'N'
,
'N'
,
'N'
,
'Y'
,
'SOLICITUD_ATENCION_AL_CLIENTE'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(10):=1651;
RQPMT_299_.old_tb1_1(10):=8;
RQPMT_299_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(10),-1)));
RQPMT_299_.old_tb1_2(10):=191;
RQPMT_299_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(10),-1)));
RQPMT_299_.old_tb1_3(10):=null;
RQPMT_299_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(10),-1)));
RQPMT_299_.old_tb1_4(10):=null;
RQPMT_299_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(10),-1)));
RQPMT_299_.tb1_9(10):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(10),
ENTITY_ID=RQPMT_299_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(10),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Tipo'
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
TAG_NAME='TIPO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(10),
RQPMT_299_.tb1_1(10),
RQPMT_299_.tb1_2(10),
RQPMT_299_.tb1_3(10),
RQPMT_299_.tb1_4(10),
null,
null,
null,
null,
RQPMT_299_.tb1_9(10),
5,
'Tipo'
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
'TIPO'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(6):=121408180;
RQPMT_299_.tb4_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(6):=RQPMT_299_.tb4_0(6);
RQPMT_299_.old_tb4_1(6):='MO_INITATRIB_CT23E121408180'
;
RQPMT_299_.tb4_1(6):=RQPMT_299_.tb4_0(6);
RQPMT_299_.tb4_2(6):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(6),
RQPMT_299_.tb4_1(6),
RQPMT_299_.tb4_2(6),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSTATUSPARAMETER.FNUGETSTATUS_NULL_MOTIVE())'
,
'OPF5'
,
to_date('26-03-2002 14:38:39','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Estado Inicial del Motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(11):=1652;
RQPMT_299_.old_tb1_1(11):=8;
RQPMT_299_.tb1_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(11),-1)));
RQPMT_299_.old_tb1_2(11):=524;
RQPMT_299_.tb1_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(11),-1)));
RQPMT_299_.old_tb1_3(11):=null;
RQPMT_299_.tb1_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(11),-1)));
RQPMT_299_.old_tb1_4(11):=null;
RQPMT_299_.tb1_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(11),-1)));
RQPMT_299_.tb1_6(11):=RQPMT_299_.tb4_0(6);
RQPMT_299_.tb1_9(11):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(11),
ENTITY_ID=RQPMT_299_.tb1_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(11),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Estado'
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
TAG_NAME='ESTADO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(11),
RQPMT_299_.tb1_1(11),
RQPMT_299_.tb1_2(11),
RQPMT_299_.tb1_3(11),
RQPMT_299_.tb1_4(11),
null,
RQPMT_299_.tb1_6(11),
null,
null,
RQPMT_299_.tb1_9(11),
6,
'Estado'
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
'ESTADO'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(12):=1653;
RQPMT_299_.old_tb1_1(12):=8;
RQPMT_299_.tb1_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(12),-1)));
RQPMT_299_.old_tb1_2(12):=697;
RQPMT_299_.tb1_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(12),-1)));
RQPMT_299_.old_tb1_3(12):=null;
RQPMT_299_.tb1_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(12),-1)));
RQPMT_299_.old_tb1_4(12):=null;
RQPMT_299_.tb1_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(12),-1)));
RQPMT_299_.tb1_9(12):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(12),
ENTITY_ID=RQPMT_299_.tb1_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(12),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Producto motivo'
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
TAG_NAME='PRODUCTO_MOTIVO'
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
ATTRI_TECHNICAL_NAME='PRODUCT_MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(12),
RQPMT_299_.tb1_1(12),
RQPMT_299_.tb1_2(12),
RQPMT_299_.tb1_3(12),
RQPMT_299_.tb1_4(12),
null,
null,
null,
null,
RQPMT_299_.tb1_9(12),
7,
'Producto motivo'
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
'PRODUCTO_MOTIVO'
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
'PRODUCT_MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(13):=1654;
RQPMT_299_.old_tb1_1(13):=8;
RQPMT_299_.tb1_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(13),-1)));
RQPMT_299_.old_tb1_2(13):=36570;
RQPMT_299_.tb1_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(13),-1)));
RQPMT_299_.old_tb1_3(13):=null;
RQPMT_299_.tb1_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(13),-1)));
RQPMT_299_.old_tb1_4(13):=null;
RQPMT_299_.tb1_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(13),-1)));
RQPMT_299_.tb1_9(13):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(13),
ENTITY_ID=RQPMT_299_.tb1_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(13),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Etiqueta XML'
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
TAG_NAME='TAG_NAME'
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
ATTRI_TECHNICAL_NAME='TAG_NAME'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(13),
RQPMT_299_.tb1_1(13),
RQPMT_299_.tb1_2(13),
RQPMT_299_.tb1_3(13),
RQPMT_299_.tb1_4(13),
null,
null,
null,
null,
RQPMT_299_.tb1_9(13),
8,
'Etiqueta XML'
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
'TAG_NAME'
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
'TAG_NAME'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(14):=1655;
RQPMT_299_.old_tb1_1(14):=8;
RQPMT_299_.tb1_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(14),-1)));
RQPMT_299_.old_tb1_2(14):=413;
RQPMT_299_.tb1_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(14),-1)));
RQPMT_299_.old_tb1_3(14):=null;
RQPMT_299_.tb1_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(14),-1)));
RQPMT_299_.old_tb1_4(14):=null;
RQPMT_299_.tb1_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(14),-1)));
RQPMT_299_.tb1_9(14):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(14),
ENTITY_ID=RQPMT_299_.tb1_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(14),
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
REQUIRED='Y'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(14),
RQPMT_299_.tb1_1(14),
RQPMT_299_.tb1_2(14),
RQPMT_299_.tb1_3(14),
RQPMT_299_.tb1_4(14),
null,
null,
null,
null,
RQPMT_299_.tb1_9(14),
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
'Y'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(7):=121408181;
RQPMT_299_.tb4_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(7):=RQPMT_299_.tb4_0(7);
RQPMT_299_.old_tb4_1(7):='MO_INITATRIB_CT23E121408181'
;
RQPMT_299_.tb4_1(7):=RQPMT_299_.tb4_0(7);
RQPMT_299_.tb4_2(7):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(7),
RQPMT_299_.tb4_1(7),
RQPMT_299_.tb4_2(7),
'CF_BOINITRULES.INIFIELDFROMWI("SUSCRIPC","SUSCCODI")'
,
'LBTEST'
,
to_date('18-07-2012 15:09:08','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(15):=1656;
RQPMT_299_.old_tb1_1(15):=8;
RQPMT_299_.tb1_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(15),-1)));
RQPMT_299_.old_tb1_2(15):=11403;
RQPMT_299_.tb1_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(15),-1)));
RQPMT_299_.old_tb1_3(15):=null;
RQPMT_299_.tb1_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(15),-1)));
RQPMT_299_.old_tb1_4(15):=null;
RQPMT_299_.tb1_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(15),-1)));
RQPMT_299_.tb1_6(15):=RQPMT_299_.tb4_0(7);
RQPMT_299_.tb1_9(15):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(15),
ENTITY_ID=RQPMT_299_.tb1_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(15),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(15),
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
REQUIRED='Y'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(15),
RQPMT_299_.tb1_1(15),
RQPMT_299_.tb1_2(15),
RQPMT_299_.tb1_3(15),
RQPMT_299_.tb1_4(15),
null,
RQPMT_299_.tb1_6(15),
null,
null,
RQPMT_299_.tb1_9(15),
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
'Y'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(8):=121408182;
RQPMT_299_.tb4_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(8):=RQPMT_299_.tb4_0(8);
RQPMT_299_.old_tb4_1(8):='MO_INITATRIB_CT23E121408182'
;
RQPMT_299_.tb4_1(8):=RQPMT_299_.tb4_0(8);
RQPMT_299_.tb4_2(8):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(8),
RQPMT_299_.tb4_1(8),
RQPMT_299_.tb4_2(8),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETSEQ_MO_DATA_FOR_ORDER())'
,
'TESTOSS'
,
to_date('29-06-2005 08:52:45','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(16):=1657;
RQPMT_299_.old_tb1_1(16):=118;
RQPMT_299_.tb1_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(16),-1)));
RQPMT_299_.old_tb1_2(16):=2875;
RQPMT_299_.tb1_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(16),-1)));
RQPMT_299_.old_tb1_3(16):=null;
RQPMT_299_.tb1_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(16),-1)));
RQPMT_299_.old_tb1_4(16):=null;
RQPMT_299_.tb1_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(16),-1)));
RQPMT_299_.tb1_6(16):=RQPMT_299_.tb4_0(8);
RQPMT_299_.tb1_9(16):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(16),
ENTITY_ID=RQPMT_299_.tb1_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(16),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(16),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Id De Data For Order'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(16),
RQPMT_299_.tb1_1(16),
RQPMT_299_.tb1_2(16),
RQPMT_299_.tb1_3(16),
RQPMT_299_.tb1_4(16),
null,
RQPMT_299_.tb1_6(16),
null,
null,
RQPMT_299_.tb1_9(16),
11,
'Id De Data For Order'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb5_0(0):=120198277;
RQPMT_299_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_299_.tb5_0(0):=RQPMT_299_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_299_.tb5_0(0),
16,
'Actividades para Servicio Tecnico Externo'
,
'SELECT DISTINCT a.items_id ID, description DESCRIPTION
FROM ge_items a, or_act_by_req_data b
WHERE b.motive_type_id = 22
AND b.item_id = a.items_id'
,
'Actividades para Servicio Tecnico Externo'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(17):=1658;
RQPMT_299_.old_tb1_1(17):=118;
RQPMT_299_.tb1_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(17),-1)));
RQPMT_299_.old_tb1_2(17):=44501;
RQPMT_299_.tb1_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(17),-1)));
RQPMT_299_.old_tb1_3(17):=null;
RQPMT_299_.tb1_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(17),-1)));
RQPMT_299_.old_tb1_4(17):=null;
RQPMT_299_.tb1_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(17),-1)));
RQPMT_299_.tb1_5(17):=RQPMT_299_.tb5_0(0);
RQPMT_299_.tb1_9(17):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(17),
ENTITY_ID=RQPMT_299_.tb1_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(17),
STATEMENT_ID=RQPMT_299_.tb1_5(17),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(17),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Actividad'
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
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(17),
RQPMT_299_.tb1_1(17),
RQPMT_299_.tb1_2(17),
RQPMT_299_.tb1_3(17),
RQPMT_299_.tb1_4(17),
RQPMT_299_.tb1_5(17),
null,
null,
null,
RQPMT_299_.tb1_9(17),
14,
'Actividad'
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
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb3_0(3):=26;
RQPMT_299_.tb3_1(3):=RQPMT_299_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (3)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_299_.tb3_0(3),
MODULE_ID=RQPMT_299_.tb3_1(3),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_299_.tb3_0(3);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_299_.tb3_0(3),
RQPMT_299_.tb3_1(3),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(9):=121408183;
RQPMT_299_.tb4_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(9):=RQPMT_299_.tb4_0(9);
RQPMT_299_.old_tb4_1(9):='MO_VALIDATTR_CT26E121408183'
;
RQPMT_299_.tb4_1(9):=RQPMT_299_.tb4_0(9);
RQPMT_299_.tb4_2(9):=RQPMT_299_.tb3_0(3);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(9),
RQPMT_299_.tb4_1(9),
RQPMT_299_.tb4_2(9),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuCantidad);if (UT_CONVERT.FNUCHARTONUMBER(nuCantidad) <= 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cantidad debe ser mayor que 0");,);if (UT_CONVERT.FNUCHARTONUMBER(nuCantidad) > 99,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cantidad no puede ser mayor a 99");,)'
,
'LBTEST'
,
to_date('16-07-2012 15:26:10','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - Cantidad Servicio Tecnico Externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(18):=1661;
RQPMT_299_.old_tb1_1(18):=118;
RQPMT_299_.tb1_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(18),-1)));
RQPMT_299_.old_tb1_2(18):=175194;
RQPMT_299_.tb1_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(18),-1)));
RQPMT_299_.old_tb1_3(18):=null;
RQPMT_299_.tb1_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(18),-1)));
RQPMT_299_.old_tb1_4(18):=null;
RQPMT_299_.tb1_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(18),-1)));
RQPMT_299_.tb1_7(18):=RQPMT_299_.tb4_0(9);
RQPMT_299_.tb1_9(18):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(18),
ENTITY_ID=RQPMT_299_.tb1_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_299_.tb1_7(18),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(18),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Cantidad'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='QUANTITY'
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
ATTRI_TECHNICAL_NAME='QUANTITY'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(18),
RQPMT_299_.tb1_1(18),
RQPMT_299_.tb1_2(18),
RQPMT_299_.tb1_3(18),
RQPMT_299_.tb1_4(18),
null,
null,
RQPMT_299_.tb1_7(18),
null,
RQPMT_299_.tb1_9(18),
16,
'Cantidad'
,
16,
'Y'
,
'N'
,
'N'
,
'Y'
,
'QUANTITY'
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
'QUANTITY'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(19):=1667;
RQPMT_299_.old_tb1_1(19):=68;
RQPMT_299_.tb1_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(19),-1)));
RQPMT_299_.old_tb1_2(19):=2559;
RQPMT_299_.tb1_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(19),-1)));
RQPMT_299_.old_tb1_3(19):=2826;
RQPMT_299_.tb1_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(19),-1)));
RQPMT_299_.old_tb1_4(19):=null;
RQPMT_299_.tb1_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(19),-1)));
RQPMT_299_.tb1_9(19):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (19)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(19),
ENTITY_ID=RQPMT_299_.tb1_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(19),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Valor Numerico'
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
TAG_NAME='VALOR_NUMERICO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(19);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(19),
RQPMT_299_.tb1_1(19),
RQPMT_299_.tb1_2(19),
RQPMT_299_.tb1_3(19),
RQPMT_299_.tb1_4(19),
null,
null,
null,
null,
RQPMT_299_.tb1_9(19),
18,
'Valor Numerico'
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
'VALOR_NUMERICO'
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(10):=121408272;
RQPMT_299_.tb4_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(10):=RQPMT_299_.tb4_0(10);
RQPMT_299_.old_tb4_1(10):='MO_INITATRIB_CT23E121408272'
;
RQPMT_299_.tb4_1(10):=RQPMT_299_.tb4_0(10);
RQPMT_299_.tb4_2(10):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(10),
RQPMT_299_.tb4_1(10),
RQPMT_299_.tb4_2(10),
'PKG_REGLAS_TRAM_SERV_TECN_EXT.PRCINISUBCATEGORIA()'
,
'OPEN'
,
to_date('16-05-2025 11:09:19','DD-MM-YYYY HH24:MI:SS'),
to_date('19-05-2025 09:57:42','DD-MM-YYYY HH24:MI:SS'),
to_date('19-05-2025 09:57:42','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - Inicializa subcategoria - Servicio Técnico Externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb5_0(1):=120196537;
RQPMT_299_.tb5_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_299_.tb5_0(1):=RQPMT_299_.tb5_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_299_.tb5_0(1),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(20):=104630;
RQPMT_299_.old_tb1_1(20):=8;
RQPMT_299_.tb1_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(20),-1)));
RQPMT_299_.old_tb1_2(20):=147337;
RQPMT_299_.tb1_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(20),-1)));
RQPMT_299_.old_tb1_3(20):=null;
RQPMT_299_.tb1_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(20),-1)));
RQPMT_299_.old_tb1_4(20):=null;
RQPMT_299_.tb1_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(20),-1)));
RQPMT_299_.tb1_5(20):=RQPMT_299_.tb5_0(1);
RQPMT_299_.tb1_6(20):=RQPMT_299_.tb4_0(10);
RQPMT_299_.tb1_9(20):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (20)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(20),
ENTITY_ID=RQPMT_299_.tb1_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(20),
STATEMENT_ID=RQPMT_299_.tb1_5(20),
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(20),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(20),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Subcategoría'
,
DISPLAY_ORDER=13,
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
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(20);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(20),
RQPMT_299_.tb1_1(20),
RQPMT_299_.tb1_2(20),
RQPMT_299_.tb1_3(20),
RQPMT_299_.tb1_4(20),
RQPMT_299_.tb1_5(20),
RQPMT_299_.tb1_6(20),
null,
null,
RQPMT_299_.tb1_9(20),
13,
'Subcategoría'
,
13,
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
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(11):=121408271;
RQPMT_299_.tb4_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(11):=RQPMT_299_.tb4_0(11);
RQPMT_299_.old_tb4_1(11):='MO_INITATRIB_CT23E121408271'
;
RQPMT_299_.tb4_1(11):=RQPMT_299_.tb4_0(11);
RQPMT_299_.tb4_2(11):=RQPMT_299_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(11),
RQPMT_299_.tb4_1(11),
RQPMT_299_.tb4_2(11),
'PKG_REGLAS_TRAM_SERV_TECN_EXT.PRCINICATEGORIA()'
,
'OPEN'
,
to_date('16-05-2025 11:09:18','DD-MM-YYYY HH24:MI:SS'),
to_date('19-05-2025 09:57:41','DD-MM-YYYY HH24:MI:SS'),
to_date('19-05-2025 09:57:41','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - Inicializa categoria - Servicio Técnico Externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb5_0(2):=120198229;
RQPMT_299_.tb5_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_299_.tb5_0(2):=RQPMT_299_.tb5_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_299_.tb5_0(2),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb6_0(0):=RQPMT_299_.tb5_0(2);
RQPMT_299_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
UPDATE GE_STATEMENT_COLUMNS SET STATEMENT_ID=RQPMT_299_.tb6_0(0),
WIZARD_COLUMNS=null,
SELECT_COLUMNS=RQPMT_299_.clColumn_1,
LIST_VALUES=null
 WHERE STATEMENT_ID = RQPMT_299_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQPMT_299_.tb6_0(0),
null,
RQPMT_299_.clColumn_1,
null);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb1_0(21):=104629;
RQPMT_299_.old_tb1_1(21):=8;
RQPMT_299_.tb1_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_299_.TBENTITYNAME(NVL(RQPMT_299_.old_tb1_1(21),-1)));
RQPMT_299_.old_tb1_2(21):=147336;
RQPMT_299_.tb1_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_2(21),-1)));
RQPMT_299_.old_tb1_3(21):=null;
RQPMT_299_.tb1_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_3(21),-1)));
RQPMT_299_.old_tb1_4(21):=null;
RQPMT_299_.tb1_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_299_.TBENTITYATTRIBUTENAME(NVL(RQPMT_299_.old_tb1_4(21),-1)));
RQPMT_299_.tb1_5(21):=RQPMT_299_.tb5_0(2);
RQPMT_299_.tb1_6(21):=RQPMT_299_.tb4_0(11);
RQPMT_299_.tb1_9(21):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (21)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_299_.tb1_0(21),
ENTITY_ID=RQPMT_299_.tb1_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_299_.tb1_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_299_.tb1_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_299_.tb1_4(21),
STATEMENT_ID=RQPMT_299_.tb1_5(21),
INIT_EXPRESSION_ID=RQPMT_299_.tb1_6(21),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_299_.tb1_9(21),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Categoría'
,
DISPLAY_ORDER=12,
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
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_299_.tb1_0(21);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_299_.tb1_0(21),
RQPMT_299_.tb1_1(21),
RQPMT_299_.tb1_2(21),
RQPMT_299_.tb1_3(21),
RQPMT_299_.tb1_4(21),
RQPMT_299_.tb1_5(21),
RQPMT_299_.tb1_6(21),
null,
null,
RQPMT_299_.tb1_9(21),
12,
'Categoría'
,
12,
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
'N'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb7_0(0):=20;
RQPMT_299_.tb7_1(0):=RQPMT_299_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_EVENTS fila (0)',1);
UPDATE PS_PROD_MOTI_EVENTS SET PROD_MOTI_EVENTS_ID=RQPMT_299_.tb7_0(0),
PRODUCT_MOTIVE_ID=RQPMT_299_.tb7_1(0),
EVENT_ID=1
 WHERE PROD_MOTI_EVENTS_ID = RQPMT_299_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_EVENTS(PROD_MOTI_EVENTS_ID,PRODUCT_MOTIVE_ID,EVENT_ID) 
VALUES (RQPMT_299_.tb7_0(0),
RQPMT_299_.tb7_1(0),
1);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb3_0(4):=65;
RQPMT_299_.tb3_1(4):=RQPMT_299_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (4)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_299_.tb3_0(4),
MODULE_ID=RQPMT_299_.tb3_1(4),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_299_.tb3_0(4);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_299_.tb3_0(4),
RQPMT_299_.tb3_1(4),
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
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(12):=121408184;
RQPMT_299_.tb4_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(12):=RQPMT_299_.tb4_0(12);
RQPMT_299_.old_tb4_1(12):='MO_EVE_COMP_CT65E121408184'
;
RQPMT_299_.tb4_1(12):=RQPMT_299_.tb4_0(12);
RQPMT_299_.tb4_2(12):=RQPMT_299_.tb3_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(12),
RQPMT_299_.tb4_1(12),
RQPMT_299_.tb4_2(12),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCIDDI",sbDireccion);CF_BOREGISTERRULESCRM.LOADADDRESS(sbInstance,sbDireccion)'
,
'LBTEST'
,
to_date('23-08-2012 18:49:47','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'EVE - PRE - MOT - Servicio Tecnico Externo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb8_0(0):=35;
RQPMT_299_.tb8_1(0):=RQPMT_299_.tb7_0(0);
RQPMT_299_.tb8_2(0):=RQPMT_299_.tb4_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (0)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_299_.tb8_0(0),
PROD_MOTI_EVENTS_ID=RQPMT_299_.tb8_1(0),
CONFIG_EXPRESSION_ID=RQPMT_299_.tb8_2(0),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_299_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_299_.tb8_0(0),
RQPMT_299_.tb8_1(0),
RQPMT_299_.tb8_2(0),
'B'
,
'Y'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.old_tb4_0(13):=121408185;
RQPMT_299_.tb4_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_299_.tb4_0(13):=RQPMT_299_.tb4_0(13);
RQPMT_299_.old_tb4_1(13):='MO_EVE_COMP_CT65E121408185'
;
RQPMT_299_.tb4_1(13):=RQPMT_299_.tb4_0(13);
RQPMT_299_.tb4_2(13):=RQPMT_299_.tb3_0(4);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_299_.tb4_0(13),
RQPMT_299_.tb4_1(13),
RQPMT_299_.tb4_2(13),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","VALUE_2",sbContrato);nuIdContrato = UT_STRING.GETPARAMETERVALUE(sbContrato, "SUBSCRIPTION_ID", "|", "=");GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstancia,null,"MO_MOTIVE","SUBSCRIPTION_ID",nuIdContrato,true)'
,
'LBTEST'
,
to_date('18-07-2012 15:06:25','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
to_date('15-05-2025 14:46:14','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'EVE - PRE - MOT - Instancia Contrato - VtaServTecExt'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;

RQPMT_299_.tb8_0(1):=26;
RQPMT_299_.tb8_1(1):=RQPMT_299_.tb7_0(0);
RQPMT_299_.tb8_2(1):=RQPMT_299_.tb4_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (1)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_299_.tb8_0(1),
PROD_MOTI_EVENTS_ID=RQPMT_299_.tb8_1(1),
CONFIG_EXPRESSION_ID=RQPMT_299_.tb8_2(1),
EXECUTING_TIME='AF'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_299_.tb8_0(1);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_299_.tb8_0(1),
RQPMT_299_.tb8_1(1),
RQPMT_299_.tb8_2(1),
'AF'
,
'Y'
);
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
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

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(299, sbSuccess);
FOR rc in RQPMT_299_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_299_.blProcessStatus := false;
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
nuIndex := RQPMT_299_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_299_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_299_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_299_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_299_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_299_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_299_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_299_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_299_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_299_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_299_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_299_.blProcessStatus := false;
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
 nuIndex := RQPMT_299_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_299_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_299_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_299_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_299_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_299_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_299_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_299_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_299_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_299_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_299_',
'CREATE OR REPLACE PACKAGE RQCFG_299_ IS ' || chr(10) ||
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
'AND     external_root_id = 299 ' || chr(10) ||
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
'END RQCFG_299_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_299_******************************'); END;
/

BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_299_.cuCompositions;
fetch RQCFG_299_.cuCompositions bulk collect INTO RQCFG_299_.tbCompositions;
close RQCFG_299_.cuCompositions;

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_299_.tbEntityName(-1) := 'NULL';
   RQCFG_299_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_299_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_299_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_299_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_299_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(204) := 'MO_MOTIVE@MOTIV_RECORDING_DATE';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_299_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_299_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_299_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_299_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_299_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_299_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(2875) := 'MO_DATA_FOR_ORDER@DATA_FOR_ORDER_ID';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(2877) := 'MO_DATA_FOR_ORDER@MOTIVE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(36570) := 'MO_MOTIVE@TAG_NAME';
   RQCFG_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_299_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(44501) := 'MO_DATA_FOR_ORDER@ITEM_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(175194) := 'MO_DATA_FOR_ORDER@QUANTITY';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_299_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_299_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(204) := 'MO_MOTIVE@MOTIV_RECORDING_DATE';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(36570) := 'MO_MOTIVE@TAG_NAME';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(175194) := 'MO_DATA_FOR_ORDER@QUANTITY';
   RQCFG_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_299_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_299_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(44501) := 'MO_DATA_FOR_ORDER@ITEM_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(2877) := 'MO_DATA_FOR_ORDER@MOTIVE_ID';
   RQCFG_299_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_299_.tbEntityAttributeName(2559) := 'MO_PROCESS@VALUE_2';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_299_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_299_.tbEntityAttributeName(2826) := 'MO_PROCESS@CONTRACT_INFORMATION';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_299_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_299_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_299_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_299_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_299_.tbEntityName(118) := 'MO_DATA_FOR_ORDER';
   RQCFG_299_.tbEntityAttributeName(2875) := 'MO_DATA_FOR_ORDER@DATA_FOR_ORDER_ID';
   RQCFG_299_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_299_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
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
AND     external_root_id = 299
)
);
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_299_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 299, 4);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_299_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_299_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_299_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_299_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_299_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299))));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299)));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 299, 4);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_299_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299))));
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299))));
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299))));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299)));

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_299_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_299_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_299_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_299_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_299_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_299_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299));
nuIndex binary_integer;
BEGIN

if (not RQCFG_299_.blProcessStatus) then
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 299;

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb0_0(0):=8957;
RQCFG_299_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_299_.tb0_0(0):=RQCFG_299_.tb0_0(0);
RQCFG_299_.old_tb0_2(0):=2012;
RQCFG_299_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_299_.tb0_0(0),
299,
RQCFG_299_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb1_0(0):=1066390;
RQCFG_299_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_299_.tb1_0(0):=RQCFG_299_.tb1_0(0);
RQCFG_299_.old_tb1_1(0):=299;
RQCFG_299_.tb1_1(0):=RQCFG_299_.old_tb1_1(0);
RQCFG_299_.old_tb1_2(0):=2012;
RQCFG_299_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb1_2(0),-1)));
RQCFG_299_.old_tb1_3(0):=8957;
RQCFG_299_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb1_2(0),-1))), RQCFG_299_.old_tb1_1(0), 4);
RQCFG_299_.tb1_3(0):=RQCFG_299_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_299_.tb1_0(0),
RQCFG_299_.tb1_1(0),
RQCFG_299_.tb1_2(0),
RQCFG_299_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb2_0(0):=100026305;
RQCFG_299_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_299_.tb2_0(0):=RQCFG_299_.tb2_0(0);
RQCFG_299_.tb2_1(0):=RQCFG_299_.tb0_0(0);
RQCFG_299_.tb2_2(0):=RQCFG_299_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_299_.tb2_0(0),
RQCFG_299_.tb2_1(0),
RQCFG_299_.tb2_2(0),
null,
6121,
1,
1,
1);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb1_0(1):=1066391;
RQCFG_299_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_299_.tb1_0(1):=RQCFG_299_.tb1_0(1);
RQCFG_299_.old_tb1_1(1):=99;
RQCFG_299_.tb1_1(1):=RQCFG_299_.old_tb1_1(1);
RQCFG_299_.old_tb1_2(1):=2013;
RQCFG_299_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb1_2(1),-1)));
RQCFG_299_.old_tb1_3(1):=null;
RQCFG_299_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb1_2(1),-1))), RQCFG_299_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_299_.tb1_0(1),
RQCFG_299_.tb1_1(1),
RQCFG_299_.tb1_2(1),
RQCFG_299_.tb1_3(1),
null,
'M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
,
1,
1,
4);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb2_0(1):=100026306;
RQCFG_299_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_299_.tb2_0(1):=RQCFG_299_.tb2_0(1);
RQCFG_299_.tb2_1(1):=RQCFG_299_.tb0_0(0);
RQCFG_299_.tb2_2(1):=RQCFG_299_.tb1_0(1);
RQCFG_299_.tb2_3(1):=RQCFG_299_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_299_.tb2_0(1),
RQCFG_299_.tb2_1(1),
RQCFG_299_.tb2_2(1),
RQCFG_299_.tb2_3(1),
6121,
2,
1,
1);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(0):=1152837;
RQCFG_299_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(0):=RQCFG_299_.tb3_0(0);
RQCFG_299_.old_tb3_1(0):=3334;
RQCFG_299_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(0),-1)));
RQCFG_299_.old_tb3_2(0):=2877;
RQCFG_299_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(0),-1)));
RQCFG_299_.old_tb3_3(0):=187;
RQCFG_299_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(0),-1)));
RQCFG_299_.old_tb3_4(0):=null;
RQCFG_299_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(0),-1)));
RQCFG_299_.tb3_5(0):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(0):=null;
RQCFG_299_.tb3_6(0):=NULL;
RQCFG_299_.old_tb3_7(0):=null;
RQCFG_299_.tb3_7(0):=NULL;
RQCFG_299_.old_tb3_8(0):=null;
RQCFG_299_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(0),
RQCFG_299_.tb3_1(0),
RQCFG_299_.tb3_2(0),
RQCFG_299_.tb3_3(0),
RQCFG_299_.tb3_4(0),
RQCFG_299_.tb3_5(0),
RQCFG_299_.tb3_6(0),
RQCFG_299_.tb3_7(0),
RQCFG_299_.tb3_8(0),
null,
103761,
15,
'Id Del Motivo'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb4_0(0):=2809;
RQCFG_299_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_299_.tb4_0(0):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb4_1(0):=RQCFG_299_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_299_.tb4_0(0),
RQCFG_299_.tb4_1(0),
null,
null,
'FRAME-M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99-1066391'
,
2);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(0):=1608317;
RQCFG_299_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(0):=RQCFG_299_.tb5_0(0);
RQCFG_299_.old_tb5_1(0):=2877;
RQCFG_299_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(0),-1)));
RQCFG_299_.old_tb5_2(0):=null;
RQCFG_299_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(0),-1)));
RQCFG_299_.tb5_3(0):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(0):=RQCFG_299_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(0),
RQCFG_299_.tb5_1(0),
RQCFG_299_.tb5_2(0),
RQCFG_299_.tb5_3(0),
RQCFG_299_.tb5_4(0),
'C'
,
'Y'
,
15,
'Y'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(1):=1152838;
RQCFG_299_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(1):=RQCFG_299_.tb3_0(1);
RQCFG_299_.old_tb3_1(1):=3334;
RQCFG_299_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(1),-1)));
RQCFG_299_.old_tb3_2(1):=2559;
RQCFG_299_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(1),-1)));
RQCFG_299_.old_tb3_3(1):=2826;
RQCFG_299_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(1),-1)));
RQCFG_299_.old_tb3_4(1):=null;
RQCFG_299_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(1),-1)));
RQCFG_299_.tb3_5(1):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(1):=null;
RQCFG_299_.tb3_6(1):=NULL;
RQCFG_299_.old_tb3_7(1):=null;
RQCFG_299_.tb3_7(1):=NULL;
RQCFG_299_.old_tb3_8(1):=null;
RQCFG_299_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(1),
RQCFG_299_.tb3_1(1),
RQCFG_299_.tb3_2(1),
RQCFG_299_.tb3_3(1),
RQCFG_299_.tb3_4(1),
RQCFG_299_.tb3_5(1),
RQCFG_299_.tb3_6(1),
RQCFG_299_.tb3_7(1),
RQCFG_299_.tb3_8(1),
null,
1667,
18,
'Valor Numerico'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(1):=1608318;
RQCFG_299_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(1):=RQCFG_299_.tb5_0(1);
RQCFG_299_.old_tb5_1(1):=2559;
RQCFG_299_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(1),-1)));
RQCFG_299_.old_tb5_2(1):=null;
RQCFG_299_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(1),-1)));
RQCFG_299_.tb5_3(1):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(1):=RQCFG_299_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(1),
RQCFG_299_.tb5_1(1),
RQCFG_299_.tb5_2(1),
RQCFG_299_.tb5_3(1),
RQCFG_299_.tb5_4(1),
'C'
,
'Y'
,
18,
'N'
,
'Valor Numerico'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(2):=1152839;
RQCFG_299_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(2):=RQCFG_299_.tb3_0(2);
RQCFG_299_.old_tb3_1(2):=3334;
RQCFG_299_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(2),-1)));
RQCFG_299_.old_tb3_2(2):=187;
RQCFG_299_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(2),-1)));
RQCFG_299_.old_tb3_3(2):=null;
RQCFG_299_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(2),-1)));
RQCFG_299_.old_tb3_4(2):=null;
RQCFG_299_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(2),-1)));
RQCFG_299_.tb3_5(2):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(2):=121408176;
RQCFG_299_.tb3_6(2):=NULL;
RQCFG_299_.old_tb3_7(2):=null;
RQCFG_299_.tb3_7(2):=NULL;
RQCFG_299_.old_tb3_8(2):=null;
RQCFG_299_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(2),
RQCFG_299_.tb3_1(2),
RQCFG_299_.tb3_2(2),
RQCFG_299_.tb3_3(2),
RQCFG_299_.tb3_4(2),
RQCFG_299_.tb3_5(2),
RQCFG_299_.tb3_6(2),
RQCFG_299_.tb3_7(2),
RQCFG_299_.tb3_8(2),
null,
1646,
0,
'Código del Motivo'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(2):=1608319;
RQCFG_299_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(2):=RQCFG_299_.tb5_0(2);
RQCFG_299_.old_tb5_1(2):=187;
RQCFG_299_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(2),-1)));
RQCFG_299_.old_tb5_2(2):=null;
RQCFG_299_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(2),-1)));
RQCFG_299_.tb5_3(2):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(2):=RQCFG_299_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(2),
RQCFG_299_.tb5_1(2),
RQCFG_299_.tb5_2(2),
RQCFG_299_.tb5_3(2),
RQCFG_299_.tb5_4(2),
'C'
,
'Y'
,
0,
'Y'
,
'Código del Motivo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(3):=1152840;
RQCFG_299_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(3):=RQCFG_299_.tb3_0(3);
RQCFG_299_.old_tb3_1(3):=3334;
RQCFG_299_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(3),-1)));
RQCFG_299_.old_tb3_2(3):=203;
RQCFG_299_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(3),-1)));
RQCFG_299_.old_tb3_3(3):=null;
RQCFG_299_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(3),-1)));
RQCFG_299_.old_tb3_4(3):=null;
RQCFG_299_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(3),-1)));
RQCFG_299_.tb3_5(3):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(3):=121408178;
RQCFG_299_.tb3_6(3):=NULL;
RQCFG_299_.old_tb3_7(3):=121408177;
RQCFG_299_.tb3_7(3):=NULL;
RQCFG_299_.old_tb3_8(3):=null;
RQCFG_299_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(3),
RQCFG_299_.tb3_1(3),
RQCFG_299_.tb3_2(3),
RQCFG_299_.tb3_3(3),
RQCFG_299_.tb3_4(3),
RQCFG_299_.tb3_5(3),
RQCFG_299_.tb3_6(3),
RQCFG_299_.tb3_7(3),
RQCFG_299_.tb3_8(3),
null,
1647,
1,
'Prioridad'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(3):=1608320;
RQCFG_299_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(3):=RQCFG_299_.tb5_0(3);
RQCFG_299_.old_tb5_1(3):=203;
RQCFG_299_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(3),-1)));
RQCFG_299_.old_tb5_2(3):=null;
RQCFG_299_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(3),-1)));
RQCFG_299_.tb5_3(3):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(3):=RQCFG_299_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(3),
RQCFG_299_.tb5_1(3),
RQCFG_299_.tb5_2(3),
RQCFG_299_.tb5_3(3),
RQCFG_299_.tb5_4(3),
'C'
,
'Y'
,
1,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(4):=1152841;
RQCFG_299_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(4):=RQCFG_299_.tb3_0(4);
RQCFG_299_.old_tb3_1(4):=3334;
RQCFG_299_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(4),-1)));
RQCFG_299_.old_tb3_2(4):=204;
RQCFG_299_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(4),-1)));
RQCFG_299_.old_tb3_3(4):=258;
RQCFG_299_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(4),-1)));
RQCFG_299_.old_tb3_4(4):=null;
RQCFG_299_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(4),-1)));
RQCFG_299_.tb3_5(4):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(4):=121408179;
RQCFG_299_.tb3_6(4):=NULL;
RQCFG_299_.old_tb3_7(4):=null;
RQCFG_299_.tb3_7(4):=NULL;
RQCFG_299_.old_tb3_8(4):=null;
RQCFG_299_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(4),
RQCFG_299_.tb3_1(4),
RQCFG_299_.tb3_2(4),
RQCFG_299_.tb3_3(4),
RQCFG_299_.tb3_4(4),
RQCFG_299_.tb3_5(4),
RQCFG_299_.tb3_6(4),
RQCFG_299_.tb3_7(4),
RQCFG_299_.tb3_8(4),
null,
1648,
2,
'Fecha registro'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(4):=1608321;
RQCFG_299_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(4):=RQCFG_299_.tb5_0(4);
RQCFG_299_.old_tb5_1(4):=204;
RQCFG_299_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(4),-1)));
RQCFG_299_.old_tb5_2(4):=null;
RQCFG_299_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(4),-1)));
RQCFG_299_.tb5_3(4):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(4):=RQCFG_299_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(4),
RQCFG_299_.tb5_1(4),
RQCFG_299_.tb5_2(4),
RQCFG_299_.tb5_3(4),
RQCFG_299_.tb5_4(4),
'C'
,
'Y'
,
2,
'Y'
,
'Fecha registro'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(5):=1152842;
RQCFG_299_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(5):=RQCFG_299_.tb3_0(5);
RQCFG_299_.old_tb3_1(5):=3334;
RQCFG_299_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(5),-1)));
RQCFG_299_.old_tb3_2(5):=213;
RQCFG_299_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(5),-1)));
RQCFG_299_.old_tb3_3(5):=255;
RQCFG_299_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(5),-1)));
RQCFG_299_.old_tb3_4(5):=null;
RQCFG_299_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(5),-1)));
RQCFG_299_.tb3_5(5):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(5):=null;
RQCFG_299_.tb3_6(5):=NULL;
RQCFG_299_.old_tb3_7(5):=null;
RQCFG_299_.tb3_7(5):=NULL;
RQCFG_299_.old_tb3_8(5):=null;
RQCFG_299_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(5),
RQCFG_299_.tb3_1(5),
RQCFG_299_.tb3_2(5),
RQCFG_299_.tb3_3(5),
RQCFG_299_.tb3_4(5),
RQCFG_299_.tb3_5(5),
RQCFG_299_.tb3_6(5),
RQCFG_299_.tb3_7(5),
RQCFG_299_.tb3_8(5),
null,
1649,
3,
'Solicitud'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(5):=1608322;
RQCFG_299_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(5):=RQCFG_299_.tb5_0(5);
RQCFG_299_.old_tb5_1(5):=213;
RQCFG_299_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(5),-1)));
RQCFG_299_.old_tb5_2(5):=null;
RQCFG_299_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(5),-1)));
RQCFG_299_.tb5_3(5):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(5):=RQCFG_299_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(5),
RQCFG_299_.tb5_1(5),
RQCFG_299_.tb5_2(5),
RQCFG_299_.tb5_3(5),
RQCFG_299_.tb5_4(5),
'C'
,
'Y'
,
3,
'Y'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(6):=1152843;
RQCFG_299_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(6):=RQCFG_299_.tb3_0(6);
RQCFG_299_.old_tb3_1(6):=3334;
RQCFG_299_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(6),-1)));
RQCFG_299_.old_tb3_2(6):=189;
RQCFG_299_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(6),-1)));
RQCFG_299_.old_tb3_3(6):=257;
RQCFG_299_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(6),-1)));
RQCFG_299_.old_tb3_4(6):=null;
RQCFG_299_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(6),-1)));
RQCFG_299_.tb3_5(6):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(6):=null;
RQCFG_299_.tb3_6(6):=NULL;
RQCFG_299_.old_tb3_7(6):=null;
RQCFG_299_.tb3_7(6):=NULL;
RQCFG_299_.old_tb3_8(6):=null;
RQCFG_299_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(6),
RQCFG_299_.tb3_1(6),
RQCFG_299_.tb3_2(6),
RQCFG_299_.tb3_3(6),
RQCFG_299_.tb3_4(6),
RQCFG_299_.tb3_5(6),
RQCFG_299_.tb3_6(6),
RQCFG_299_.tb3_7(6),
RQCFG_299_.tb3_8(6),
null,
1650,
4,
'Solicitud atención al cliente'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(6):=1608323;
RQCFG_299_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(6):=RQCFG_299_.tb5_0(6);
RQCFG_299_.old_tb5_1(6):=189;
RQCFG_299_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(6),-1)));
RQCFG_299_.old_tb5_2(6):=null;
RQCFG_299_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(6),-1)));
RQCFG_299_.tb5_3(6):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(6):=RQCFG_299_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(6),
RQCFG_299_.tb5_1(6),
RQCFG_299_.tb5_2(6),
RQCFG_299_.tb5_3(6),
RQCFG_299_.tb5_4(6),
'C'
,
'Y'
,
4,
'Y'
,
'Solicitud atención al cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(7):=1152844;
RQCFG_299_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(7):=RQCFG_299_.tb3_0(7);
RQCFG_299_.old_tb3_1(7):=3334;
RQCFG_299_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(7),-1)));
RQCFG_299_.old_tb3_2(7):=191;
RQCFG_299_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(7),-1)));
RQCFG_299_.old_tb3_3(7):=null;
RQCFG_299_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(7),-1)));
RQCFG_299_.old_tb3_4(7):=null;
RQCFG_299_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(7),-1)));
RQCFG_299_.tb3_5(7):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(7):=null;
RQCFG_299_.tb3_6(7):=NULL;
RQCFG_299_.old_tb3_7(7):=null;
RQCFG_299_.tb3_7(7):=NULL;
RQCFG_299_.old_tb3_8(7):=null;
RQCFG_299_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(7),
RQCFG_299_.tb3_1(7),
RQCFG_299_.tb3_2(7),
RQCFG_299_.tb3_3(7),
RQCFG_299_.tb3_4(7),
RQCFG_299_.tb3_5(7),
RQCFG_299_.tb3_6(7),
RQCFG_299_.tb3_7(7),
RQCFG_299_.tb3_8(7),
null,
1651,
5,
'Tipo'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(7):=1608324;
RQCFG_299_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(7):=RQCFG_299_.tb5_0(7);
RQCFG_299_.old_tb5_1(7):=191;
RQCFG_299_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(7),-1)));
RQCFG_299_.old_tb5_2(7):=null;
RQCFG_299_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(7),-1)));
RQCFG_299_.tb5_3(7):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(7):=RQCFG_299_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(7),
RQCFG_299_.tb5_1(7),
RQCFG_299_.tb5_2(7),
RQCFG_299_.tb5_3(7),
RQCFG_299_.tb5_4(7),
'C'
,
'Y'
,
5,
'Y'
,
'Tipo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(8):=1152845;
RQCFG_299_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(8):=RQCFG_299_.tb3_0(8);
RQCFG_299_.old_tb3_1(8):=3334;
RQCFG_299_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(8),-1)));
RQCFG_299_.old_tb3_2(8):=524;
RQCFG_299_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(8),-1)));
RQCFG_299_.old_tb3_3(8):=null;
RQCFG_299_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(8),-1)));
RQCFG_299_.old_tb3_4(8):=null;
RQCFG_299_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(8),-1)));
RQCFG_299_.tb3_5(8):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(8):=121408180;
RQCFG_299_.tb3_6(8):=NULL;
RQCFG_299_.old_tb3_7(8):=null;
RQCFG_299_.tb3_7(8):=NULL;
RQCFG_299_.old_tb3_8(8):=null;
RQCFG_299_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(8),
RQCFG_299_.tb3_1(8),
RQCFG_299_.tb3_2(8),
RQCFG_299_.tb3_3(8),
RQCFG_299_.tb3_4(8),
RQCFG_299_.tb3_5(8),
RQCFG_299_.tb3_6(8),
RQCFG_299_.tb3_7(8),
RQCFG_299_.tb3_8(8),
null,
1652,
6,
'Estado'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(8):=1608325;
RQCFG_299_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(8):=RQCFG_299_.tb5_0(8);
RQCFG_299_.old_tb5_1(8):=524;
RQCFG_299_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(8),-1)));
RQCFG_299_.old_tb5_2(8):=null;
RQCFG_299_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(8),-1)));
RQCFG_299_.tb5_3(8):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(8):=RQCFG_299_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(8),
RQCFG_299_.tb5_1(8),
RQCFG_299_.tb5_2(8),
RQCFG_299_.tb5_3(8),
RQCFG_299_.tb5_4(8),
'C'
,
'Y'
,
6,
'Y'
,
'Estado'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(9):=1152846;
RQCFG_299_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(9):=RQCFG_299_.tb3_0(9);
RQCFG_299_.old_tb3_1(9):=3334;
RQCFG_299_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(9),-1)));
RQCFG_299_.old_tb3_2(9):=697;
RQCFG_299_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(9),-1)));
RQCFG_299_.old_tb3_3(9):=null;
RQCFG_299_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(9),-1)));
RQCFG_299_.old_tb3_4(9):=null;
RQCFG_299_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(9),-1)));
RQCFG_299_.tb3_5(9):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(9):=null;
RQCFG_299_.tb3_6(9):=NULL;
RQCFG_299_.old_tb3_7(9):=null;
RQCFG_299_.tb3_7(9):=NULL;
RQCFG_299_.old_tb3_8(9):=null;
RQCFG_299_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(9),
RQCFG_299_.tb3_1(9),
RQCFG_299_.tb3_2(9),
RQCFG_299_.tb3_3(9),
RQCFG_299_.tb3_4(9),
RQCFG_299_.tb3_5(9),
RQCFG_299_.tb3_6(9),
RQCFG_299_.tb3_7(9),
RQCFG_299_.tb3_8(9),
null,
1653,
7,
'Producto motivo'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(9):=1608326;
RQCFG_299_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(9):=RQCFG_299_.tb5_0(9);
RQCFG_299_.old_tb5_1(9):=697;
RQCFG_299_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(9),-1)));
RQCFG_299_.old_tb5_2(9):=null;
RQCFG_299_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(9),-1)));
RQCFG_299_.tb5_3(9):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(9):=RQCFG_299_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(9),
RQCFG_299_.tb5_1(9),
RQCFG_299_.tb5_2(9),
RQCFG_299_.tb5_3(9),
RQCFG_299_.tb5_4(9),
'C'
,
'Y'
,
7,
'Y'
,
'Producto motivo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(10):=1152847;
RQCFG_299_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(10):=RQCFG_299_.tb3_0(10);
RQCFG_299_.old_tb3_1(10):=3334;
RQCFG_299_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(10),-1)));
RQCFG_299_.old_tb3_2(10):=36570;
RQCFG_299_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(10),-1)));
RQCFG_299_.old_tb3_3(10):=null;
RQCFG_299_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(10),-1)));
RQCFG_299_.old_tb3_4(10):=null;
RQCFG_299_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(10),-1)));
RQCFG_299_.tb3_5(10):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(10):=null;
RQCFG_299_.tb3_6(10):=NULL;
RQCFG_299_.old_tb3_7(10):=null;
RQCFG_299_.tb3_7(10):=NULL;
RQCFG_299_.old_tb3_8(10):=null;
RQCFG_299_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(10),
RQCFG_299_.tb3_1(10),
RQCFG_299_.tb3_2(10),
RQCFG_299_.tb3_3(10),
RQCFG_299_.tb3_4(10),
RQCFG_299_.tb3_5(10),
RQCFG_299_.tb3_6(10),
RQCFG_299_.tb3_7(10),
RQCFG_299_.tb3_8(10),
null,
1654,
8,
'Etiqueta XML'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(10):=1608327;
RQCFG_299_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(10):=RQCFG_299_.tb5_0(10);
RQCFG_299_.old_tb5_1(10):=36570;
RQCFG_299_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(10),-1)));
RQCFG_299_.old_tb5_2(10):=null;
RQCFG_299_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(10),-1)));
RQCFG_299_.tb5_3(10):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(10):=RQCFG_299_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(10),
RQCFG_299_.tb5_1(10),
RQCFG_299_.tb5_2(10),
RQCFG_299_.tb5_3(10),
RQCFG_299_.tb5_4(10),
'C'
,
'Y'
,
8,
'Y'
,
'Etiqueta XML'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(11):=1152848;
RQCFG_299_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(11):=RQCFG_299_.tb3_0(11);
RQCFG_299_.old_tb3_1(11):=3334;
RQCFG_299_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(11),-1)));
RQCFG_299_.old_tb3_2(11):=413;
RQCFG_299_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(11),-1)));
RQCFG_299_.old_tb3_3(11):=null;
RQCFG_299_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(11),-1)));
RQCFG_299_.old_tb3_4(11):=null;
RQCFG_299_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(11),-1)));
RQCFG_299_.tb3_5(11):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(11):=null;
RQCFG_299_.tb3_6(11):=NULL;
RQCFG_299_.old_tb3_7(11):=null;
RQCFG_299_.tb3_7(11):=NULL;
RQCFG_299_.old_tb3_8(11):=null;
RQCFG_299_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(11),
RQCFG_299_.tb3_1(11),
RQCFG_299_.tb3_2(11),
RQCFG_299_.tb3_3(11),
RQCFG_299_.tb3_4(11),
RQCFG_299_.tb3_5(11),
RQCFG_299_.tb3_6(11),
RQCFG_299_.tb3_7(11),
RQCFG_299_.tb3_8(11),
null,
1655,
9,
'Producto'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(11):=1608328;
RQCFG_299_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(11):=RQCFG_299_.tb5_0(11);
RQCFG_299_.old_tb5_1(11):=413;
RQCFG_299_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(11),-1)));
RQCFG_299_.old_tb5_2(11):=null;
RQCFG_299_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(11),-1)));
RQCFG_299_.tb5_3(11):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(11):=RQCFG_299_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(11),
RQCFG_299_.tb5_1(11),
RQCFG_299_.tb5_2(11),
RQCFG_299_.tb5_3(11),
RQCFG_299_.tb5_4(11),
'C'
,
'Y'
,
9,
'Y'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(12):=1152849;
RQCFG_299_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(12):=RQCFG_299_.tb3_0(12);
RQCFG_299_.old_tb3_1(12):=3334;
RQCFG_299_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(12),-1)));
RQCFG_299_.old_tb3_2(12):=11403;
RQCFG_299_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(12),-1)));
RQCFG_299_.old_tb3_3(12):=null;
RQCFG_299_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(12),-1)));
RQCFG_299_.old_tb3_4(12):=null;
RQCFG_299_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(12),-1)));
RQCFG_299_.tb3_5(12):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(12):=121408181;
RQCFG_299_.tb3_6(12):=NULL;
RQCFG_299_.old_tb3_7(12):=null;
RQCFG_299_.tb3_7(12):=NULL;
RQCFG_299_.old_tb3_8(12):=null;
RQCFG_299_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(12),
RQCFG_299_.tb3_1(12),
RQCFG_299_.tb3_2(12),
RQCFG_299_.tb3_3(12),
RQCFG_299_.tb3_4(12),
RQCFG_299_.tb3_5(12),
RQCFG_299_.tb3_6(12),
RQCFG_299_.tb3_7(12),
RQCFG_299_.tb3_8(12),
null,
1656,
10,
'Contrato'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(12):=1608329;
RQCFG_299_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(12):=RQCFG_299_.tb5_0(12);
RQCFG_299_.old_tb5_1(12):=11403;
RQCFG_299_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(12),-1)));
RQCFG_299_.old_tb5_2(12):=null;
RQCFG_299_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(12),-1)));
RQCFG_299_.tb5_3(12):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(12):=RQCFG_299_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(12),
RQCFG_299_.tb5_1(12),
RQCFG_299_.tb5_2(12),
RQCFG_299_.tb5_3(12),
RQCFG_299_.tb5_4(12),
'C'
,
'Y'
,
10,
'Y'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(13):=1152850;
RQCFG_299_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(13):=RQCFG_299_.tb3_0(13);
RQCFG_299_.old_tb3_1(13):=3334;
RQCFG_299_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(13),-1)));
RQCFG_299_.old_tb3_2(13):=2875;
RQCFG_299_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(13),-1)));
RQCFG_299_.old_tb3_3(13):=null;
RQCFG_299_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(13),-1)));
RQCFG_299_.old_tb3_4(13):=null;
RQCFG_299_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(13),-1)));
RQCFG_299_.tb3_5(13):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(13):=121408182;
RQCFG_299_.tb3_6(13):=NULL;
RQCFG_299_.old_tb3_7(13):=null;
RQCFG_299_.tb3_7(13):=NULL;
RQCFG_299_.old_tb3_8(13):=null;
RQCFG_299_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(13),
RQCFG_299_.tb3_1(13),
RQCFG_299_.tb3_2(13),
RQCFG_299_.tb3_3(13),
RQCFG_299_.tb3_4(13),
RQCFG_299_.tb3_5(13),
RQCFG_299_.tb3_6(13),
RQCFG_299_.tb3_7(13),
RQCFG_299_.tb3_8(13),
null,
1657,
11,
'Id De Data For Order'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(13):=1608330;
RQCFG_299_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(13):=RQCFG_299_.tb5_0(13);
RQCFG_299_.old_tb5_1(13):=2875;
RQCFG_299_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(13),-1)));
RQCFG_299_.old_tb5_2(13):=null;
RQCFG_299_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(13),-1)));
RQCFG_299_.tb5_3(13):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(13):=RQCFG_299_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(13),
RQCFG_299_.tb5_1(13),
RQCFG_299_.tb5_2(13),
RQCFG_299_.tb5_3(13),
RQCFG_299_.tb5_4(13),
'C'
,
'Y'
,
11,
'Y'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(14):=1152851;
RQCFG_299_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(14):=RQCFG_299_.tb3_0(14);
RQCFG_299_.old_tb3_1(14):=3334;
RQCFG_299_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(14),-1)));
RQCFG_299_.old_tb3_2(14):=44501;
RQCFG_299_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(14),-1)));
RQCFG_299_.old_tb3_3(14):=null;
RQCFG_299_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(14),-1)));
RQCFG_299_.old_tb3_4(14):=null;
RQCFG_299_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(14),-1)));
RQCFG_299_.tb3_5(14):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(14):=null;
RQCFG_299_.tb3_6(14):=NULL;
RQCFG_299_.old_tb3_7(14):=null;
RQCFG_299_.tb3_7(14):=NULL;
RQCFG_299_.old_tb3_8(14):=120198277;
RQCFG_299_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(14),
RQCFG_299_.tb3_1(14),
RQCFG_299_.tb3_2(14),
RQCFG_299_.tb3_3(14),
RQCFG_299_.tb3_4(14),
RQCFG_299_.tb3_5(14),
RQCFG_299_.tb3_6(14),
RQCFG_299_.tb3_7(14),
RQCFG_299_.tb3_8(14),
null,
1658,
14,
'Actividad'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(14):=1608331;
RQCFG_299_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(14):=RQCFG_299_.tb5_0(14);
RQCFG_299_.old_tb5_1(14):=44501;
RQCFG_299_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(14),-1)));
RQCFG_299_.old_tb5_2(14):=null;
RQCFG_299_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(14),-1)));
RQCFG_299_.tb5_3(14):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(14):=RQCFG_299_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(14),
RQCFG_299_.tb5_1(14),
RQCFG_299_.tb5_2(14),
RQCFG_299_.tb5_3(14),
RQCFG_299_.tb5_4(14),
'Y'
,
'Y'
,
14,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(15):=1152852;
RQCFG_299_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(15):=RQCFG_299_.tb3_0(15);
RQCFG_299_.old_tb3_1(15):=3334;
RQCFG_299_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(15),-1)));
RQCFG_299_.old_tb3_2(15):=175194;
RQCFG_299_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(15),-1)));
RQCFG_299_.old_tb3_3(15):=null;
RQCFG_299_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(15),-1)));
RQCFG_299_.old_tb3_4(15):=null;
RQCFG_299_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(15),-1)));
RQCFG_299_.tb3_5(15):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(15):=null;
RQCFG_299_.tb3_6(15):=NULL;
RQCFG_299_.old_tb3_7(15):=121408183;
RQCFG_299_.tb3_7(15):=NULL;
RQCFG_299_.old_tb3_8(15):=null;
RQCFG_299_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(15),
RQCFG_299_.tb3_1(15),
RQCFG_299_.tb3_2(15),
RQCFG_299_.tb3_3(15),
RQCFG_299_.tb3_4(15),
RQCFG_299_.tb3_5(15),
RQCFG_299_.tb3_6(15),
RQCFG_299_.tb3_7(15),
RQCFG_299_.tb3_8(15),
null,
1661,
16,
'Cantidad'
,
'N'
,
'Y'
,
'Y'
,
16,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(15):=1608332;
RQCFG_299_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(15):=RQCFG_299_.tb5_0(15);
RQCFG_299_.old_tb5_1(15):=175194;
RQCFG_299_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(15),-1)));
RQCFG_299_.old_tb5_2(15):=null;
RQCFG_299_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(15),-1)));
RQCFG_299_.tb5_3(15):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(15):=RQCFG_299_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(15),
RQCFG_299_.tb5_1(15),
RQCFG_299_.tb5_2(15),
RQCFG_299_.tb5_3(15),
RQCFG_299_.tb5_4(15),
'Y'
,
'Y'
,
16,
'Y'
,
'Cantidad'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(16):=1152853;
RQCFG_299_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(16):=RQCFG_299_.tb3_0(16);
RQCFG_299_.old_tb3_1(16):=3334;
RQCFG_299_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(16),-1)));
RQCFG_299_.old_tb3_2(16):=474;
RQCFG_299_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(16),-1)));
RQCFG_299_.old_tb3_3(16):=null;
RQCFG_299_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(16),-1)));
RQCFG_299_.old_tb3_4(16):=null;
RQCFG_299_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(16),-1)));
RQCFG_299_.tb3_5(16):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(16):=121408175;
RQCFG_299_.tb3_6(16):=NULL;
RQCFG_299_.old_tb3_7(16):=null;
RQCFG_299_.tb3_7(16):=NULL;
RQCFG_299_.old_tb3_8(16):=null;
RQCFG_299_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(16),
RQCFG_299_.tb3_1(16),
RQCFG_299_.tb3_2(16),
RQCFG_299_.tb3_3(16),
RQCFG_299_.tb3_4(16),
RQCFG_299_.tb3_5(16),
RQCFG_299_.tb3_6(16),
RQCFG_299_.tb3_7(16),
RQCFG_299_.tb3_8(16),
null,
1851,
19,
'Código de la Dirección'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(16):=1608333;
RQCFG_299_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(16):=RQCFG_299_.tb5_0(16);
RQCFG_299_.old_tb5_1(16):=474;
RQCFG_299_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(16),-1)));
RQCFG_299_.old_tb5_2(16):=null;
RQCFG_299_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(16),-1)));
RQCFG_299_.tb5_3(16):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(16):=RQCFG_299_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(16),
RQCFG_299_.tb5_1(16),
RQCFG_299_.tb5_2(16),
RQCFG_299_.tb5_3(16),
RQCFG_299_.tb5_4(16),
'C'
,
'Y'
,
19,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(17):=1152854;
RQCFG_299_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(17):=RQCFG_299_.tb3_0(17);
RQCFG_299_.old_tb3_1(17):=3334;
RQCFG_299_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(17),-1)));
RQCFG_299_.old_tb3_2(17):=281;
RQCFG_299_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(17),-1)));
RQCFG_299_.old_tb3_3(17):=187;
RQCFG_299_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(17),-1)));
RQCFG_299_.old_tb3_4(17):=null;
RQCFG_299_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(17),-1)));
RQCFG_299_.tb3_5(17):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(17):=null;
RQCFG_299_.tb3_6(17):=NULL;
RQCFG_299_.old_tb3_7(17):=null;
RQCFG_299_.tb3_7(17):=NULL;
RQCFG_299_.old_tb3_8(17):=null;
RQCFG_299_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(17),
RQCFG_299_.tb3_1(17),
RQCFG_299_.tb3_2(17),
RQCFG_299_.tb3_3(17),
RQCFG_299_.tb3_4(17),
RQCFG_299_.tb3_5(17),
RQCFG_299_.tb3_6(17),
RQCFG_299_.tb3_7(17),
RQCFG_299_.tb3_8(17),
null,
1852,
20,
'Consecutivo Interno Motivos'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(17):=1608334;
RQCFG_299_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(17):=RQCFG_299_.tb5_0(17);
RQCFG_299_.old_tb5_1(17):=281;
RQCFG_299_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(17),-1)));
RQCFG_299_.old_tb5_2(17):=null;
RQCFG_299_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(17),-1)));
RQCFG_299_.tb5_3(17):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(17):=RQCFG_299_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(17),
RQCFG_299_.tb5_1(17),
RQCFG_299_.tb5_2(17),
RQCFG_299_.tb5_3(17),
RQCFG_299_.tb5_4(17),
'C'
,
'Y'
,
20,
'N'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(18):=1152855;
RQCFG_299_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(18):=RQCFG_299_.tb3_0(18);
RQCFG_299_.old_tb3_1(18):=3334;
RQCFG_299_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(18),-1)));
RQCFG_299_.old_tb3_2(18):=39322;
RQCFG_299_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(18),-1)));
RQCFG_299_.old_tb3_3(18):=255;
RQCFG_299_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(18),-1)));
RQCFG_299_.old_tb3_4(18):=null;
RQCFG_299_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(18),-1)));
RQCFG_299_.tb3_5(18):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(18):=null;
RQCFG_299_.tb3_6(18):=NULL;
RQCFG_299_.old_tb3_7(18):=null;
RQCFG_299_.tb3_7(18):=NULL;
RQCFG_299_.old_tb3_8(18):=null;
RQCFG_299_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(18),
RQCFG_299_.tb3_1(18),
RQCFG_299_.tb3_2(18),
RQCFG_299_.tb3_3(18),
RQCFG_299_.tb3_4(18),
RQCFG_299_.tb3_5(18),
RQCFG_299_.tb3_6(18),
RQCFG_299_.tb3_7(18),
RQCFG_299_.tb3_8(18),
null,
1853,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(18):=1608335;
RQCFG_299_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(18):=RQCFG_299_.tb5_0(18);
RQCFG_299_.old_tb5_1(18):=39322;
RQCFG_299_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(18),-1)));
RQCFG_299_.old_tb5_2(18):=null;
RQCFG_299_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(18),-1)));
RQCFG_299_.tb5_3(18):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(18):=RQCFG_299_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(18),
RQCFG_299_.tb5_1(18),
RQCFG_299_.tb5_2(18),
RQCFG_299_.tb5_3(18),
RQCFG_299_.tb5_4(18),
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(19):=1152856;
RQCFG_299_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(19):=RQCFG_299_.tb3_0(19);
RQCFG_299_.old_tb3_1(19):=3334;
RQCFG_299_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(19),-1)));
RQCFG_299_.old_tb3_2(19):=45189;
RQCFG_299_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(19),-1)));
RQCFG_299_.old_tb3_3(19):=null;
RQCFG_299_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(19),-1)));
RQCFG_299_.old_tb3_4(19):=null;
RQCFG_299_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(19),-1)));
RQCFG_299_.tb3_5(19):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(19):=121408174;
RQCFG_299_.tb3_6(19):=NULL;
RQCFG_299_.old_tb3_7(19):=null;
RQCFG_299_.tb3_7(19):=NULL;
RQCFG_299_.old_tb3_8(19):=null;
RQCFG_299_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(19),
RQCFG_299_.tb3_1(19),
RQCFG_299_.tb3_2(19),
RQCFG_299_.tb3_3(19),
RQCFG_299_.tb3_4(19),
RQCFG_299_.tb3_5(19),
RQCFG_299_.tb3_6(19),
RQCFG_299_.tb3_7(19),
RQCFG_299_.tb3_8(19),
null,
1666,
17,
'Identificador Plan Comercial'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(19):=1608336;
RQCFG_299_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(19):=RQCFG_299_.tb5_0(19);
RQCFG_299_.old_tb5_1(19):=45189;
RQCFG_299_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(19),-1)));
RQCFG_299_.old_tb5_2(19):=null;
RQCFG_299_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(19),-1)));
RQCFG_299_.tb5_3(19):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(19):=RQCFG_299_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(19),
RQCFG_299_.tb5_1(19),
RQCFG_299_.tb5_2(19),
RQCFG_299_.tb5_3(19),
RQCFG_299_.tb5_4(19),
'C'
,
'Y'
,
17,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(20):=1153427;
RQCFG_299_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(20):=RQCFG_299_.tb3_0(20);
RQCFG_299_.old_tb3_1(20):=3334;
RQCFG_299_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(20),-1)));
RQCFG_299_.old_tb3_2(20):=147336;
RQCFG_299_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(20),-1)));
RQCFG_299_.old_tb3_3(20):=null;
RQCFG_299_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(20),-1)));
RQCFG_299_.old_tb3_4(20):=null;
RQCFG_299_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(20),-1)));
RQCFG_299_.tb3_5(20):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(20):=121408271;
RQCFG_299_.tb3_6(20):=NULL;
RQCFG_299_.old_tb3_7(20):=null;
RQCFG_299_.tb3_7(20):=NULL;
RQCFG_299_.old_tb3_8(20):=120198229;
RQCFG_299_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(20),
RQCFG_299_.tb3_1(20),
RQCFG_299_.tb3_2(20),
RQCFG_299_.tb3_3(20),
RQCFG_299_.tb3_4(20),
RQCFG_299_.tb3_5(20),
RQCFG_299_.tb3_6(20),
RQCFG_299_.tb3_7(20),
RQCFG_299_.tb3_8(20),
null,
104629,
12,
'Categoría'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(20):=1617373;
RQCFG_299_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(20):=RQCFG_299_.tb5_0(20);
RQCFG_299_.old_tb5_1(20):=147336;
RQCFG_299_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(20),-1)));
RQCFG_299_.old_tb5_2(20):=null;
RQCFG_299_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(20),-1)));
RQCFG_299_.tb5_3(20):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(20):=RQCFG_299_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(20),
RQCFG_299_.tb5_1(20),
RQCFG_299_.tb5_2(20),
RQCFG_299_.tb5_3(20),
RQCFG_299_.tb5_4(20),
'Y'
,
'N'
,
12,
'Y'
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
4,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(21):=1153428;
RQCFG_299_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(21):=RQCFG_299_.tb3_0(21);
RQCFG_299_.old_tb3_1(21):=3334;
RQCFG_299_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(21),-1)));
RQCFG_299_.old_tb3_2(21):=147337;
RQCFG_299_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(21),-1)));
RQCFG_299_.old_tb3_3(21):=null;
RQCFG_299_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(21),-1)));
RQCFG_299_.old_tb3_4(21):=null;
RQCFG_299_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(21),-1)));
RQCFG_299_.tb3_5(21):=RQCFG_299_.tb2_2(1);
RQCFG_299_.old_tb3_6(21):=121408272;
RQCFG_299_.tb3_6(21):=NULL;
RQCFG_299_.old_tb3_7(21):=null;
RQCFG_299_.tb3_7(21):=NULL;
RQCFG_299_.old_tb3_8(21):=120196537;
RQCFG_299_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(21),
RQCFG_299_.tb3_1(21),
RQCFG_299_.tb3_2(21),
RQCFG_299_.tb3_3(21),
RQCFG_299_.tb3_4(21),
RQCFG_299_.tb3_5(21),
RQCFG_299_.tb3_6(21),
RQCFG_299_.tb3_7(21),
RQCFG_299_.tb3_8(21),
null,
104630,
13,
'Subcategoría'
,
'N'
,
'Y'
,
'Y'
,
13,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(21):=1617374;
RQCFG_299_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(21):=RQCFG_299_.tb5_0(21);
RQCFG_299_.old_tb5_1(21):=147337;
RQCFG_299_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(21),-1)));
RQCFG_299_.old_tb5_2(21):=null;
RQCFG_299_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(21),-1)));
RQCFG_299_.tb5_3(21):=RQCFG_299_.tb4_0(0);
RQCFG_299_.tb5_4(21):=RQCFG_299_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(21),
RQCFG_299_.tb5_1(21),
RQCFG_299_.tb5_2(21),
RQCFG_299_.tb5_3(21),
RQCFG_299_.tb5_4(21),
'Y'
,
'N'
,
13,
'Y'
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
4,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(22):=1152857;
RQCFG_299_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(22):=RQCFG_299_.tb3_0(22);
RQCFG_299_.old_tb3_1(22):=2036;
RQCFG_299_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(22),-1)));
RQCFG_299_.old_tb3_2(22):=2826;
RQCFG_299_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(22),-1)));
RQCFG_299_.old_tb3_3(22):=null;
RQCFG_299_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(22),-1)));
RQCFG_299_.old_tb3_4(22):=null;
RQCFG_299_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(22),-1)));
RQCFG_299_.tb3_5(22):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(22):=121408160;
RQCFG_299_.tb3_6(22):=NULL;
RQCFG_299_.old_tb3_7(22):=121408161;
RQCFG_299_.tb3_7(22):=NULL;
RQCFG_299_.old_tb3_8(22):=null;
RQCFG_299_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(22),
RQCFG_299_.tb3_1(22),
RQCFG_299_.tb3_2(22),
RQCFG_299_.tb3_3(22),
RQCFG_299_.tb3_4(22),
RQCFG_299_.tb3_5(22),
RQCFG_299_.tb3_6(22),
RQCFG_299_.tb3_7(22),
RQCFG_299_.tb3_8(22),
null,
1491,
13,
'Información de contrato'
,
'N'
,
'Y'
,
'Y'
,
13,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb4_0(1):=2810;
RQCFG_299_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_299_.tb4_0(1):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb4_1(1):=RQCFG_299_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_299_.tb4_0(1),
RQCFG_299_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1066390'
,
1);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(22):=1608337;
RQCFG_299_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(22):=RQCFG_299_.tb5_0(22);
RQCFG_299_.old_tb5_1(22):=2826;
RQCFG_299_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(22),-1)));
RQCFG_299_.old_tb5_2(22):=null;
RQCFG_299_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(22),-1)));
RQCFG_299_.tb5_3(22):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(22):=RQCFG_299_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(22),
RQCFG_299_.tb5_1(22),
RQCFG_299_.tb5_2(22),
RQCFG_299_.tb5_3(22),
RQCFG_299_.tb5_4(22),
'Y'
,
'E'
,
13,
'Y'
,
'Información de contrato'
,
'N'
,
'N'
,
'U'
,
null,
123,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(23):=1152858;
RQCFG_299_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(23):=RQCFG_299_.tb3_0(23);
RQCFG_299_.old_tb3_1(23):=2036;
RQCFG_299_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(23),-1)));
RQCFG_299_.old_tb3_2(23):=146755;
RQCFG_299_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(23),-1)));
RQCFG_299_.old_tb3_3(23):=null;
RQCFG_299_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(23),-1)));
RQCFG_299_.old_tb3_4(23):=null;
RQCFG_299_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(23),-1)));
RQCFG_299_.tb3_5(23):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(23):=121408168;
RQCFG_299_.tb3_6(23):=NULL;
RQCFG_299_.old_tb3_7(23):=null;
RQCFG_299_.tb3_7(23):=NULL;
RQCFG_299_.old_tb3_8(23):=null;
RQCFG_299_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(23),
RQCFG_299_.tb3_1(23),
RQCFG_299_.tb3_2(23),
RQCFG_299_.tb3_3(23),
RQCFG_299_.tb3_4(23),
RQCFG_299_.tb3_5(23),
RQCFG_299_.tb3_6(23),
RQCFG_299_.tb3_7(23),
RQCFG_299_.tb3_8(23),
null,
1482,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(23):=1608338;
RQCFG_299_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(23):=RQCFG_299_.tb5_0(23);
RQCFG_299_.old_tb5_1(23):=146755;
RQCFG_299_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(23),-1)));
RQCFG_299_.old_tb5_2(23):=null;
RQCFG_299_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(23),-1)));
RQCFG_299_.tb5_3(23):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(23):=RQCFG_299_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(23),
RQCFG_299_.tb5_1(23),
RQCFG_299_.tb5_2(23),
RQCFG_299_.tb5_3(23),
RQCFG_299_.tb5_4(23),
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(24):=1152859;
RQCFG_299_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(24):=RQCFG_299_.tb3_0(24);
RQCFG_299_.old_tb3_1(24):=2036;
RQCFG_299_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(24),-1)));
RQCFG_299_.old_tb3_2(24):=146756;
RQCFG_299_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(24),-1)));
RQCFG_299_.old_tb3_3(24):=null;
RQCFG_299_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(24),-1)));
RQCFG_299_.old_tb3_4(24):=null;
RQCFG_299_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(24),-1)));
RQCFG_299_.tb3_5(24):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(24):=121408169;
RQCFG_299_.tb3_6(24):=NULL;
RQCFG_299_.old_tb3_7(24):=null;
RQCFG_299_.tb3_7(24):=NULL;
RQCFG_299_.old_tb3_8(24):=null;
RQCFG_299_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(24),
RQCFG_299_.tb3_1(24),
RQCFG_299_.tb3_2(24),
RQCFG_299_.tb3_3(24),
RQCFG_299_.tb3_4(24),
RQCFG_299_.tb3_5(24),
RQCFG_299_.tb3_6(24),
RQCFG_299_.tb3_7(24),
RQCFG_299_.tb3_8(24),
null,
1483,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(24):=1608339;
RQCFG_299_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(24):=RQCFG_299_.tb5_0(24);
RQCFG_299_.old_tb5_1(24):=146756;
RQCFG_299_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(24),-1)));
RQCFG_299_.old_tb5_2(24):=null;
RQCFG_299_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(24),-1)));
RQCFG_299_.tb5_3(24):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(24):=RQCFG_299_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(24),
RQCFG_299_.tb5_1(24),
RQCFG_299_.tb5_2(24),
RQCFG_299_.tb5_3(24),
RQCFG_299_.tb5_4(24),
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(25):=1152860;
RQCFG_299_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(25):=RQCFG_299_.tb3_0(25);
RQCFG_299_.old_tb3_1(25):=2036;
RQCFG_299_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(25),-1)));
RQCFG_299_.old_tb3_2(25):=259;
RQCFG_299_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(25),-1)));
RQCFG_299_.old_tb3_3(25):=null;
RQCFG_299_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(25),-1)));
RQCFG_299_.old_tb3_4(25):=null;
RQCFG_299_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(25),-1)));
RQCFG_299_.tb3_5(25):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(25):=121408170;
RQCFG_299_.tb3_6(25):=NULL;
RQCFG_299_.old_tb3_7(25):=null;
RQCFG_299_.tb3_7(25):=NULL;
RQCFG_299_.old_tb3_8(25):=null;
RQCFG_299_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(25),
RQCFG_299_.tb3_1(25),
RQCFG_299_.tb3_2(25),
RQCFG_299_.tb3_3(25),
RQCFG_299_.tb3_4(25),
RQCFG_299_.tb3_5(25),
RQCFG_299_.tb3_6(25),
RQCFG_299_.tb3_7(25),
RQCFG_299_.tb3_8(25),
null,
1484,
9,
'Fecha de Envío'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(25):=1608340;
RQCFG_299_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(25):=RQCFG_299_.tb5_0(25);
RQCFG_299_.old_tb5_1(25):=259;
RQCFG_299_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(25),-1)));
RQCFG_299_.old_tb5_2(25):=null;
RQCFG_299_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(25),-1)));
RQCFG_299_.tb5_3(25):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(25):=RQCFG_299_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(25),
RQCFG_299_.tb5_1(25),
RQCFG_299_.tb5_2(25),
RQCFG_299_.tb5_3(25),
RQCFG_299_.tb5_4(25),
'C'
,
'Y'
,
9,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(26):=1152861;
RQCFG_299_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(26):=RQCFG_299_.tb3_0(26);
RQCFG_299_.old_tb3_1(26):=2036;
RQCFG_299_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(26),-1)));
RQCFG_299_.old_tb3_2(26):=109478;
RQCFG_299_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(26),-1)));
RQCFG_299_.old_tb3_3(26):=null;
RQCFG_299_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(26),-1)));
RQCFG_299_.old_tb3_4(26):=null;
RQCFG_299_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(26),-1)));
RQCFG_299_.tb3_5(26):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(26):=null;
RQCFG_299_.tb3_6(26):=NULL;
RQCFG_299_.old_tb3_7(26):=null;
RQCFG_299_.tb3_7(26):=NULL;
RQCFG_299_.old_tb3_8(26):=null;
RQCFG_299_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(26),
RQCFG_299_.tb3_1(26),
RQCFG_299_.tb3_2(26),
RQCFG_299_.tb3_3(26),
RQCFG_299_.tb3_4(26),
RQCFG_299_.tb3_5(26),
RQCFG_299_.tb3_6(26),
RQCFG_299_.tb3_7(26),
RQCFG_299_.tb3_8(26),
null,
1485,
10,
'Unidad Operativa Del Vendedor'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(26):=1608341;
RQCFG_299_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(26):=RQCFG_299_.tb5_0(26);
RQCFG_299_.old_tb5_1(26):=109478;
RQCFG_299_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(26),-1)));
RQCFG_299_.old_tb5_2(26):=null;
RQCFG_299_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(26),-1)));
RQCFG_299_.tb5_3(26):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(26):=RQCFG_299_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(26),
RQCFG_299_.tb5_1(26),
RQCFG_299_.tb5_2(26),
RQCFG_299_.tb5_3(26),
RQCFG_299_.tb5_4(26),
'C'
,
'Y'
,
10,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(27):=1152862;
RQCFG_299_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(27):=RQCFG_299_.tb3_0(27);
RQCFG_299_.old_tb3_1(27):=2036;
RQCFG_299_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(27),-1)));
RQCFG_299_.old_tb3_2(27):=42118;
RQCFG_299_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(27),-1)));
RQCFG_299_.old_tb3_3(27):=109479;
RQCFG_299_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(27),-1)));
RQCFG_299_.old_tb3_4(27):=null;
RQCFG_299_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(27),-1)));
RQCFG_299_.tb3_5(27):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(27):=null;
RQCFG_299_.tb3_6(27):=NULL;
RQCFG_299_.old_tb3_7(27):=null;
RQCFG_299_.tb3_7(27):=NULL;
RQCFG_299_.old_tb3_8(27):=null;
RQCFG_299_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(27),
RQCFG_299_.tb3_1(27),
RQCFG_299_.tb3_2(27),
RQCFG_299_.tb3_3(27),
RQCFG_299_.tb3_4(27),
RQCFG_299_.tb3_5(27),
RQCFG_299_.tb3_6(27),
RQCFG_299_.tb3_7(27),
RQCFG_299_.tb3_8(27),
null,
1486,
11,
'Código Canal De Ventas'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(27):=1608342;
RQCFG_299_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(27):=RQCFG_299_.tb5_0(27);
RQCFG_299_.old_tb5_1(27):=42118;
RQCFG_299_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(27),-1)));
RQCFG_299_.old_tb5_2(27):=null;
RQCFG_299_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(27),-1)));
RQCFG_299_.tb5_3(27):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(27):=RQCFG_299_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(27),
RQCFG_299_.tb5_1(27),
RQCFG_299_.tb5_2(27),
RQCFG_299_.tb5_3(27),
RQCFG_299_.tb5_4(27),
'C'
,
'Y'
,
11,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(28):=1152863;
RQCFG_299_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(28):=RQCFG_299_.tb3_0(28);
RQCFG_299_.old_tb3_1(28):=2036;
RQCFG_299_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(28),-1)));
RQCFG_299_.old_tb3_2(28):=4015;
RQCFG_299_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(28),-1)));
RQCFG_299_.old_tb3_3(28):=null;
RQCFG_299_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(28),-1)));
RQCFG_299_.old_tb3_4(28):=null;
RQCFG_299_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(28),-1)));
RQCFG_299_.tb3_5(28):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(28):=121408171;
RQCFG_299_.tb3_6(28):=NULL;
RQCFG_299_.old_tb3_7(28):=null;
RQCFG_299_.tb3_7(28):=NULL;
RQCFG_299_.old_tb3_8(28):=null;
RQCFG_299_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(28),
RQCFG_299_.tb3_1(28),
RQCFG_299_.tb3_2(28),
RQCFG_299_.tb3_3(28),
RQCFG_299_.tb3_4(28),
RQCFG_299_.tb3_5(28),
RQCFG_299_.tb3_6(28),
RQCFG_299_.tb3_7(28),
RQCFG_299_.tb3_8(28),
null,
1487,
12,
'Identificador del Cliente'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(28):=1608343;
RQCFG_299_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(28):=RQCFG_299_.tb5_0(28);
RQCFG_299_.old_tb5_1(28):=4015;
RQCFG_299_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(28),-1)));
RQCFG_299_.old_tb5_2(28):=null;
RQCFG_299_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(28),-1)));
RQCFG_299_.tb5_3(28):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(28):=RQCFG_299_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(28),
RQCFG_299_.tb5_1(28),
RQCFG_299_.tb5_2(28),
RQCFG_299_.tb5_3(28),
RQCFG_299_.tb5_4(28),
'C'
,
'Y'
,
12,
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
null,
null,
null,
null);

exception when others then
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(29):=1152864;
RQCFG_299_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(29):=RQCFG_299_.tb3_0(29);
RQCFG_299_.old_tb3_1(29):=2036;
RQCFG_299_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(29),-1)));
RQCFG_299_.old_tb3_2(29):=146754;
RQCFG_299_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(29),-1)));
RQCFG_299_.old_tb3_3(29):=null;
RQCFG_299_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(29),-1)));
RQCFG_299_.old_tb3_4(29):=null;
RQCFG_299_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(29),-1)));
RQCFG_299_.tb3_5(29):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(29):=null;
RQCFG_299_.tb3_6(29):=NULL;
RQCFG_299_.old_tb3_7(29):=null;
RQCFG_299_.tb3_7(29):=NULL;
RQCFG_299_.old_tb3_8(29):=null;
RQCFG_299_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(29),
RQCFG_299_.tb3_1(29),
RQCFG_299_.tb3_2(29),
RQCFG_299_.tb3_3(29),
RQCFG_299_.tb3_4(29),
RQCFG_299_.tb3_5(29),
RQCFG_299_.tb3_6(29),
RQCFG_299_.tb3_7(29),
RQCFG_299_.tb3_8(29),
null,
1488,
14,
'Observación'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(29):=1608344;
RQCFG_299_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(29):=RQCFG_299_.tb5_0(29);
RQCFG_299_.old_tb5_1(29):=146754;
RQCFG_299_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(29),-1)));
RQCFG_299_.old_tb5_2(29):=null;
RQCFG_299_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(29),-1)));
RQCFG_299_.tb5_3(29):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(29):=RQCFG_299_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(29),
RQCFG_299_.tb5_1(29),
RQCFG_299_.tb5_2(29),
RQCFG_299_.tb5_3(29),
RQCFG_299_.tb5_4(29),
'Y'
,
'Y'
,
14,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(30):=1152865;
RQCFG_299_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(30):=RQCFG_299_.tb3_0(30);
RQCFG_299_.old_tb3_1(30):=2036;
RQCFG_299_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(30),-1)));
RQCFG_299_.old_tb3_2(30):=257;
RQCFG_299_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(30),-1)));
RQCFG_299_.old_tb3_3(30):=null;
RQCFG_299_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(30),-1)));
RQCFG_299_.old_tb3_4(30):=null;
RQCFG_299_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(30),-1)));
RQCFG_299_.tb3_5(30):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(30):=121408162;
RQCFG_299_.tb3_6(30):=NULL;
RQCFG_299_.old_tb3_7(30):=null;
RQCFG_299_.tb3_7(30):=NULL;
RQCFG_299_.old_tb3_8(30):=null;
RQCFG_299_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(30),
RQCFG_299_.tb3_1(30),
RQCFG_299_.tb3_2(30),
RQCFG_299_.tb3_3(30),
RQCFG_299_.tb3_4(30),
RQCFG_299_.tb3_5(30),
RQCFG_299_.tb3_6(30),
RQCFG_299_.tb3_7(30),
RQCFG_299_.tb3_8(30),
null,
1474,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(30):=1608345;
RQCFG_299_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(30):=RQCFG_299_.tb5_0(30);
RQCFG_299_.old_tb5_1(30):=257;
RQCFG_299_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(30),-1)));
RQCFG_299_.old_tb5_2(30):=null;
RQCFG_299_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(30),-1)));
RQCFG_299_.tb5_3(30):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(30):=RQCFG_299_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(30),
RQCFG_299_.tb5_1(30),
RQCFG_299_.tb5_2(30),
RQCFG_299_.tb5_3(30),
RQCFG_299_.tb5_4(30),
'Y'
,
'N'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(31):=1152866;
RQCFG_299_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(31):=RQCFG_299_.tb3_0(31);
RQCFG_299_.old_tb3_1(31):=2036;
RQCFG_299_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(31),-1)));
RQCFG_299_.old_tb3_2(31):=269;
RQCFG_299_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(31),-1)));
RQCFG_299_.old_tb3_3(31):=null;
RQCFG_299_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(31),-1)));
RQCFG_299_.old_tb3_4(31):=null;
RQCFG_299_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(31),-1)));
RQCFG_299_.tb3_5(31):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(31):=null;
RQCFG_299_.tb3_6(31):=NULL;
RQCFG_299_.old_tb3_7(31):=null;
RQCFG_299_.tb3_7(31):=NULL;
RQCFG_299_.old_tb3_8(31):=null;
RQCFG_299_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(31),
RQCFG_299_.tb3_1(31),
RQCFG_299_.tb3_2(31),
RQCFG_299_.tb3_3(31),
RQCFG_299_.tb3_4(31),
RQCFG_299_.tb3_5(31),
RQCFG_299_.tb3_6(31),
RQCFG_299_.tb3_7(31),
RQCFG_299_.tb3_8(31),
null,
1475,
1,
'Código del Tipo de Paquete'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(31):=1608346;
RQCFG_299_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(31):=RQCFG_299_.tb5_0(31);
RQCFG_299_.old_tb5_1(31):=269;
RQCFG_299_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(31),-1)));
RQCFG_299_.old_tb5_2(31):=null;
RQCFG_299_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(31),-1)));
RQCFG_299_.tb5_3(31):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(31):=RQCFG_299_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(31),
RQCFG_299_.tb5_1(31),
RQCFG_299_.tb5_2(31),
RQCFG_299_.tb5_3(31),
RQCFG_299_.tb5_4(31),
'C'
,
'Y'
,
1,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(32):=1152867;
RQCFG_299_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(32):=RQCFG_299_.tb3_0(32);
RQCFG_299_.old_tb3_1(32):=2036;
RQCFG_299_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(32),-1)));
RQCFG_299_.old_tb3_2(32):=255;
RQCFG_299_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(32),-1)));
RQCFG_299_.old_tb3_3(32):=null;
RQCFG_299_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(32),-1)));
RQCFG_299_.old_tb3_4(32):=null;
RQCFG_299_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(32),-1)));
RQCFG_299_.tb3_5(32):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(32):=null;
RQCFG_299_.tb3_6(32):=NULL;
RQCFG_299_.old_tb3_7(32):=null;
RQCFG_299_.tb3_7(32):=NULL;
RQCFG_299_.old_tb3_8(32):=null;
RQCFG_299_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(32),
RQCFG_299_.tb3_1(32),
RQCFG_299_.tb3_2(32),
RQCFG_299_.tb3_3(32),
RQCFG_299_.tb3_4(32),
RQCFG_299_.tb3_5(32),
RQCFG_299_.tb3_6(32),
RQCFG_299_.tb3_7(32),
RQCFG_299_.tb3_8(32),
null,
1476,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(32):=1608347;
RQCFG_299_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(32):=RQCFG_299_.tb5_0(32);
RQCFG_299_.old_tb5_1(32):=255;
RQCFG_299_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(32),-1)));
RQCFG_299_.old_tb5_2(32):=null;
RQCFG_299_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(32),-1)));
RQCFG_299_.tb5_3(32):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(32):=RQCFG_299_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(32),
RQCFG_299_.tb5_1(32),
RQCFG_299_.tb5_2(32),
RQCFG_299_.tb5_3(32),
RQCFG_299_.tb5_4(32),
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(33):=1152868;
RQCFG_299_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(33):=RQCFG_299_.tb3_0(33);
RQCFG_299_.old_tb3_1(33):=2036;
RQCFG_299_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(33),-1)));
RQCFG_299_.old_tb3_2(33):=258;
RQCFG_299_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(33),-1)));
RQCFG_299_.old_tb3_3(33):=null;
RQCFG_299_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(33),-1)));
RQCFG_299_.old_tb3_4(33):=null;
RQCFG_299_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(33),-1)));
RQCFG_299_.tb3_5(33):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(33):=121408163;
RQCFG_299_.tb3_6(33):=NULL;
RQCFG_299_.old_tb3_7(33):=121408164;
RQCFG_299_.tb3_7(33):=NULL;
RQCFG_299_.old_tb3_8(33):=null;
RQCFG_299_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(33),
RQCFG_299_.tb3_1(33),
RQCFG_299_.tb3_2(33),
RQCFG_299_.tb3_3(33),
RQCFG_299_.tb3_4(33),
RQCFG_299_.tb3_5(33),
RQCFG_299_.tb3_6(33),
RQCFG_299_.tb3_7(33),
RQCFG_299_.tb3_8(33),
null,
1477,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(33):=1608348;
RQCFG_299_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(33):=RQCFG_299_.tb5_0(33);
RQCFG_299_.old_tb5_1(33):=258;
RQCFG_299_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(33),-1)));
RQCFG_299_.old_tb5_2(33):=null;
RQCFG_299_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(33),-1)));
RQCFG_299_.tb5_3(33):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(33):=RQCFG_299_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(33),
RQCFG_299_.tb5_1(33),
RQCFG_299_.tb5_2(33),
RQCFG_299_.tb5_3(33),
RQCFG_299_.tb5_4(33),
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(34):=1152869;
RQCFG_299_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(34):=RQCFG_299_.tb3_0(34);
RQCFG_299_.old_tb3_1(34):=2036;
RQCFG_299_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(34),-1)));
RQCFG_299_.old_tb3_2(34):=50001162;
RQCFG_299_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(34),-1)));
RQCFG_299_.old_tb3_3(34):=null;
RQCFG_299_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(34),-1)));
RQCFG_299_.old_tb3_4(34):=null;
RQCFG_299_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(34),-1)));
RQCFG_299_.tb3_5(34):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(34):=121408165;
RQCFG_299_.tb3_6(34):=NULL;
RQCFG_299_.old_tb3_7(34):=121408166;
RQCFG_299_.tb3_7(34):=NULL;
RQCFG_299_.old_tb3_8(34):=120198274;
RQCFG_299_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(34),
RQCFG_299_.tb3_1(34),
RQCFG_299_.tb3_2(34),
RQCFG_299_.tb3_3(34),
RQCFG_299_.tb3_4(34),
RQCFG_299_.tb3_5(34),
RQCFG_299_.tb3_6(34),
RQCFG_299_.tb3_7(34),
RQCFG_299_.tb3_8(34),
null,
1478,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(34):=1608349;
RQCFG_299_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(34):=RQCFG_299_.tb5_0(34);
RQCFG_299_.old_tb5_1(34):=50001162;
RQCFG_299_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(34),-1)));
RQCFG_299_.old_tb5_2(34):=null;
RQCFG_299_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(34),-1)));
RQCFG_299_.tb5_3(34):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(34):=RQCFG_299_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(34),
RQCFG_299_.tb5_1(34),
RQCFG_299_.tb5_2(34),
RQCFG_299_.tb5_3(34),
RQCFG_299_.tb5_4(34),
'Y'
,
'E'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(35):=1152870;
RQCFG_299_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(35):=RQCFG_299_.tb3_0(35);
RQCFG_299_.old_tb3_1(35):=2036;
RQCFG_299_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(35),-1)));
RQCFG_299_.old_tb3_2(35):=2683;
RQCFG_299_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(35),-1)));
RQCFG_299_.old_tb3_3(35):=null;
RQCFG_299_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(35),-1)));
RQCFG_299_.old_tb3_4(35):=null;
RQCFG_299_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(35),-1)));
RQCFG_299_.tb3_5(35):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(35):=121408167;
RQCFG_299_.tb3_6(35):=NULL;
RQCFG_299_.old_tb3_7(35):=null;
RQCFG_299_.tb3_7(35):=NULL;
RQCFG_299_.old_tb3_8(35):=120198275;
RQCFG_299_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(35),
RQCFG_299_.tb3_1(35),
RQCFG_299_.tb3_2(35),
RQCFG_299_.tb3_3(35),
RQCFG_299_.tb3_4(35),
RQCFG_299_.tb3_5(35),
RQCFG_299_.tb3_6(35),
RQCFG_299_.tb3_7(35),
RQCFG_299_.tb3_8(35),
null,
1481,
6,
'Medio de recepción'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(35):=1608350;
RQCFG_299_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(35):=RQCFG_299_.tb5_0(35);
RQCFG_299_.old_tb5_1(35):=2683;
RQCFG_299_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(35),-1)));
RQCFG_299_.old_tb5_2(35):=null;
RQCFG_299_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(35),-1)));
RQCFG_299_.tb5_3(35):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(35):=RQCFG_299_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(35),
RQCFG_299_.tb5_1(35),
RQCFG_299_.tb5_2(35),
RQCFG_299_.tb5_3(35),
RQCFG_299_.tb5_4(35),
'Y'
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb3_0(36):=1152871;
RQCFG_299_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_299_.tb3_0(36):=RQCFG_299_.tb3_0(36);
RQCFG_299_.old_tb3_1(36):=2036;
RQCFG_299_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_299_.TBENTITYNAME(NVL(RQCFG_299_.old_tb3_1(36),-1)));
RQCFG_299_.old_tb3_2(36):=109479;
RQCFG_299_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_2(36),-1)));
RQCFG_299_.old_tb3_3(36):=null;
RQCFG_299_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_3(36),-1)));
RQCFG_299_.old_tb3_4(36):=null;
RQCFG_299_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb3_4(36),-1)));
RQCFG_299_.tb3_5(36):=RQCFG_299_.tb2_2(0);
RQCFG_299_.old_tb3_6(36):=121408172;
RQCFG_299_.tb3_6(36):=NULL;
RQCFG_299_.old_tb3_7(36):=null;
RQCFG_299_.tb3_7(36):=NULL;
RQCFG_299_.old_tb3_8(36):=120198276;
RQCFG_299_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_299_.tb3_0(36),
RQCFG_299_.tb3_1(36),
RQCFG_299_.tb3_2(36),
RQCFG_299_.tb3_3(36),
RQCFG_299_.tb3_4(36),
RQCFG_299_.tb3_5(36),
RQCFG_299_.tb3_6(36),
RQCFG_299_.tb3_7(36),
RQCFG_299_.tb3_8(36),
null,
2165,
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_299_.blProcessStatus) then
 return;
end if;

RQCFG_299_.old_tb5_0(36):=1608351;
RQCFG_299_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_299_.tb5_0(36):=RQCFG_299_.tb5_0(36);
RQCFG_299_.old_tb5_1(36):=109479;
RQCFG_299_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_1(36),-1)));
RQCFG_299_.old_tb5_2(36):=null;
RQCFG_299_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_299_.TBENTITYATTRIBUTENAME(NVL(RQCFG_299_.old_tb5_2(36),-1)));
RQCFG_299_.tb5_3(36):=RQCFG_299_.tb4_0(1);
RQCFG_299_.tb5_4(36):=RQCFG_299_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_299_.tb5_0(36),
RQCFG_299_.tb5_1(36),
RQCFG_299_.tb5_2(36),
RQCFG_299_.tb5_3(36),
RQCFG_299_.tb5_4(36),
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
RQCFG_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (299);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (299)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_299_.blProcessStatus) then
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
AND     external_root_id = 299
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
AND     external_root_id = 299
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
AND     external_root_id = 299
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 299, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 299)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 299, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 299)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 299, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 299)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 299, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 299)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_299_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_299_.tbCompositions.FIRST..RQCFG_299_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_299_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_299_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_299_.blProcessStatus := false;
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
 nuIndex := RQCFG_299_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_299_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_299_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_299_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_299_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_299_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_299_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_299_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_299_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_299_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_299_',
'CREATE OR REPLACE PACKAGE I18N_R_299_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_299_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_299_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 299
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_299_.blProcessStatus) then
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
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(0):='M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
;
I18N_R_299_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(0),
I18N_R_299_.tb0_1(0),
'WE8ISO8859P1'
,
'Servicio Técnico Clientes Externos '
,
'Servicio Técnico Clientes Externos '
,
null,
'Servicio Técnico Clientes Externos '
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(1):='M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
;
I18N_R_299_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(1),
I18N_R_299_.tb0_1(1),
'WE8ISO8859P1'
,
'Servicio Técnico Clientes Externos '
,
'Servicio Técnico Clientes Externos '
,
null,
'Servicio Técnico Clientes Externos '
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(2):='M_SERVICIO_TECNICO_CLIENTES_EXTERNOS_99'
;
I18N_R_299_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(2),
I18N_R_299_.tb0_1(2),
'WE8ISO8859P1'
,
'Servicio Técnico Clientes Externos '
,
'Servicio Técnico Clientes Externos '
,
null,
'Servicio Técnico Clientes Externos '
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(3):='PAQUETE'
;
I18N_R_299_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(3),
I18N_R_299_.tb0_1(3),
'WE8ISO8859P1'
,
'Datos Básicos Solicitud'
,
'Datos Básicos Solicitud'
,
null,
'Datos Básicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(4):='PAQUETE'
;
I18N_R_299_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(4),
I18N_R_299_.tb0_1(4),
'WE8ISO8859P1'
,
'Datos Básicos Solicitud'
,
'Datos Básicos Solicitud'
,
null,
'Datos Básicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(5):='PAQUETE'
;
I18N_R_299_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(5),
I18N_R_299_.tb0_1(5),
'WE8ISO8859P1'
,
'Datos Básicos Solicitud'
,
'Datos Básicos Solicitud'
,
null,
'Datos Básicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_299_.blProcessStatus) then
 return;
end if;

I18N_R_299_.tb0_0(6):='PAQUETE'
;
I18N_R_299_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_299_.tb0_0(6),
I18N_R_299_.tb0_1(6),
'WE8ISO8859P1'
,
'Datos Básicos Solicitud'
,
'Datos Básicos Solicitud'
,
null,
'Datos Básicos Solicitud'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_299_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_299_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_299_',
'CREATE OR REPLACE PACKAGE RQEXEC_299_ IS ' || chr(10) ||
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
'END RQEXEC_299_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_299_******************************'); END;
/


BEGIN

if (not RQEXEC_299_.blProcessStatus) then
 return;
end if;

RQEXEC_299_.old_tb0_0(0):='P_SOLICITUD_DE_SERVICIO_TECNICO_CLIENTES_EXTERNOS_299'
;
RQEXEC_299_.tb0_0(0):=UPPER(RQEXEC_299_.old_tb0_0(0));
RQEXEC_299_.old_tb0_1(0):=18139;
RQEXEC_299_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_299_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_299_.tb0_1(0):=RQEXEC_299_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_299_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_299_.tb0_1(0),
DESCRIPTION='Solicitud de Servicio Técnico Clientes Externos '
,
PATH=null,
VERSION='151'
,
EXECUTABLE_TYPE_ID=3,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=16,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP='ges_comercial_aten_clie_herramientas_pto_unico_atencion_Solicitud_Serv_Tecn_Ext.htm'
,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION=null,
TIMES_EXECUTED=442,
EXEC_OWNER='O'
,
LAST_DATE_EXECUTED=to_date('19-05-2025 14:58:24','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_299_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_299_.tb0_0(0),
RQEXEC_299_.tb0_1(0),
'Solicitud de Servicio Técnico Clientes Externos '
,
null,
'151'
,
3,
2,
16,
1,
null,
'N'
,
'ges_comercial_aten_clie_herramientas_pto_unico_atencion_Solicitud_Serv_Tecn_Ext.htm'
,
'N'
,
null,
442,
'O'
,
to_date('19-05-2025 14:58:24','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_299_.blProcessStatus) then
 return;
end if;

RQEXEC_299_.tb1_0(0):=1;
RQEXEC_299_.tb1_1(0):=RQEXEC_299_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_299_.tb1_0(0),
RQEXEC_299_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_299_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_299_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_299_******************************'); end;
/

