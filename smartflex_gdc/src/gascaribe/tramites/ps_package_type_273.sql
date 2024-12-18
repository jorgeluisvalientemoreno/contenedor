BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_273_',
'CREATE OR REPLACE PACKAGE RQTY_273_ IS ' || chr(10) ||
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
'tb9_1 ty9_1;type ty10_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty11_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty12_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty12_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb12_2 ty12_2; ' || chr(10) ||
'tb12_2 ty12_2;type ty12_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb12_3 ty12_3; ' || chr(10) ||
'tb12_3 ty12_3;type ty13_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty14_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty14_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_1 ty14_1; ' || chr(10) ||
'tb14_1 ty14_1;type ty14_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_2 ty14_2; ' || chr(10) ||
'tb14_2 ty14_2;type ty14_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_3 ty14_3; ' || chr(10) ||
'tb14_3 ty14_3;type ty15_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_0 ty15_0; ' || chr(10) ||
'tb15_0 ty15_0;type ty15_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_1 ty15_1; ' || chr(10) ||
'tb15_1 ty15_1;type ty15_3 is table of PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb15_3 ty15_3; ' || chr(10) ||
'tb15_3 ty15_3;--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM ' || chr(10) ||
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 273 ' || chr(10) ||
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
'END RQTY_273_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_273_******************************'); END;
/

BEGIN

if (not RQTY_273_.blProcessStatus) then
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
AND     external_root_id = 273
)
);

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_273_.cuExpressions;
fetch RQTY_273_.cuExpressions bulk collect INTO RQTY_273_.tbExpressionsId;
close RQTY_273_.cuExpressions;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_273_.tbEntityName(-1) := 'NULL';
   RQTY_273_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_273_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_273_.tbEntityAttributeName(20368) := 'MO_PROCESS@PROV_FINAL_DATE';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_273_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_273_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_273_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_273_.tbEntityAttributeName(20367) := 'MO_PROCESS@PROV_INITIAL_DATE';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_273_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 273
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 273
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 273
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 273
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_273_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_273_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_273_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_273_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_273_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_273_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_273_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273))));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273))));

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_273_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_273_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_273_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_273_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_273_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_273_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_273_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_273_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273)));

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273));
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_273_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273);
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_273_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_273_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_273_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_273_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=273;
nuIndex binary_integer;
BEGIN

if (not RQTY_273_.blProcessStatus) then
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_273_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_273_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_273_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_273_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_273_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_273_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_273_.tb0_0(0),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb1_0(0):=1;
RQTY_273_.tb1_1(0):=RQTY_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_273_.tb1_0(0),
MODULE_ID=RQTY_273_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_273_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_273_.tb1_0(0),
RQTY_273_.tb1_1(0),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(0):=121057250;
RQTY_273_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(0):=RQTY_273_.tb2_0(0);
RQTY_273_.old_tb2_1(0):='GE_EXEACTION_CT1E121057250'
;
RQTY_273_.tb2_1(0):=RQTY_273_.tb2_0(0);
RQTY_273_.tb2_2(0):=RQTY_273_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(0),
RQTY_273_.tb2_1(0),
RQTY_273_.tb2_2(0),
'nuSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();dtRequestDate = CC_BOBOSSUTIL.FDTREQUESTDATE(nuSolicitud);sbSysdate = UT_DATE.FSBSTR_SYSDATE();dtSysdate = UT_CONVERT.FNUCHARTODATE(sbSysdate);dtRequestDate = UT_DATE.FDTTRUNCATEDATE(dtRequestDate);dtSysdate = UT_DATE.FDTTRUNCATEDATE(dtSysdate);nuPackageType = 273;if (dtRequestDate <> dtSysdate,inuEntityID = 2012;GE_BOALERTMESSAGEPARAM.VERANDSENDNOTIF(inuEntityID,nuPackageType,nuSolicitud,null,osbNotifSends,osbLogNotif);,);nuReceptionType = MO_BOPackages.fnuGetReceptionType(nuSolicitud);if (GE_BOReception_Type.fboGetIsWrite(nuReceptionType) = GE_BOCONSTANTS.GETFALSE(),CC_BSCERTIFICATE.GENCERTIFICATEBALRES(nuSolicitud,nuErrorCode,sbErrorMessage);if (nuErrorCode <> 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,sbErrorMessage);,);,);CF_BOACTIONS.ATTENDREQUEST(nuSolicitud)'
,
'LBTEST'
,
to_date('15-08-2012 09:42:21','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:55','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'ACCIÓN - Atención Solicitud Certificado de Estado de Cuenta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb3_0(0):=248;
RQTY_273_.tb3_1(0):=RQTY_273_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_273_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_273_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='ACCIÓN - Atención Solicitud Certificado de Estado de Cuenta'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_273_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_273_.tb3_0(0),
RQTY_273_.tb3_1(0),
5,
'ACCIÓN - Atención Solicitud Certificado de Estado de Cuenta'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb4_0(0):=RQTY_273_.tb3_0(0);
RQTY_273_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_273_.tb4_0(0),
VALID_MODULE_ID=RQTY_273_.tb4_1(0)
 WHERE ACTION_ID = RQTY_273_.tb4_0(0) AND VALID_MODULE_ID = RQTY_273_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_273_.tb4_0(0),
RQTY_273_.tb4_1(0));
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb4_0(1):=RQTY_273_.tb3_0(0);
RQTY_273_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_273_.tb4_0(1),
VALID_MODULE_ID=RQTY_273_.tb4_1(1)
 WHERE ACTION_ID = RQTY_273_.tb4_0(1) AND VALID_MODULE_ID = RQTY_273_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_273_.tb4_0(1),
RQTY_273_.tb4_1(1));
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb4_0(2):=RQTY_273_.tb3_0(0);
RQTY_273_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_273_.tb4_0(2),
VALID_MODULE_ID=RQTY_273_.tb4_1(2)
 WHERE ACTION_ID = RQTY_273_.tb4_0(2) AND VALID_MODULE_ID = RQTY_273_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_273_.tb4_0(2),
RQTY_273_.tb4_1(2));
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb5_0(0):=273;
RQTY_273_.tb5_1(0):=RQTY_273_.tb3_0(0);
RQTY_273_.tb5_4(0):='P_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_273'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_273_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_273_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_273_.tb5_4(0),
DESCRIPTION='Solicitud de Certificado de Estado de Cuenta'
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
IS_ANNULABLE='N'
,
IS_DEMAND_REQUEST='N'
,
ANSWER_REQUIRED='Y'
,
LIQUIDATION_METHOD=2
 WHERE PACKAGE_TYPE_ID = RQTY_273_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_273_.tb5_0(0),
RQTY_273_.tb5_1(0),
null,
null,
RQTY_273_.tb5_4(0),
'Solicitud de Certificado de Estado de Cuenta'
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
'N'
,
'N'
,
'Y'
,
2);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_273_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_273_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_273_.tb0_0(1),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb1_0(1):=26;
RQTY_273_.tb1_1(1):=RQTY_273_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_273_.tb1_0(1),
MODULE_ID=RQTY_273_.tb1_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_273_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_273_.tb1_0(1),
RQTY_273_.tb1_1(1),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(1):=121057251;
RQTY_273_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(1):=RQTY_273_.tb2_0(1);
RQTY_273_.old_tb2_1(1):='MO_VALIDATTR_CT26E121057251'
;
RQTY_273_.tb2_1(1):=RQTY_273_.tb2_0(1);
RQTY_273_.tb2_2(1):=RQTY_273_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(1),
RQTY_273_.tb2_1(1),
RQTY_273_.tb2_2(1),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbInitDate);dtInitDate = UT_CONVERT.FNUCHARTODATE(sbInitDate);dtFechaAct = UT_DATE.FDTSYSDATE();if (UT_DATE.FDTDIFFDATE(dtFechaAct, dtInitDate) < 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha inicial no puede ser mayor a la fecha actual");,)'
,
'LBTEST'
,
to_date('15-08-2012 09:06:42','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PROCESS - INITIAL_DATE - valida que la fecha ingresada no sea mayor a la actual'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(0):=1653;
RQTY_273_.tb6_1(0):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(0):=68;
RQTY_273_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(0),-1)));
RQTY_273_.old_tb6_3(0):=20367;
RQTY_273_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(0),-1)));
RQTY_273_.old_tb6_4(0):=null;
RQTY_273_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(0),-1)));
RQTY_273_.old_tb6_5(0):=null;
RQTY_273_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(0),-1)));
RQTY_273_.tb6_8(0):=RQTY_273_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(0),
ENTITY_ID=RQTY_273_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_273_.tb6_8(0),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Fecha Inicial'
,
DISPLAY_ORDER=15,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_INICIAL'
,
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
ATTRI_TECHNICAL_NAME='PROV_INITIAL_DATE'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(0),
RQTY_273_.tb6_1(0),
RQTY_273_.tb6_2(0),
RQTY_273_.tb6_3(0),
RQTY_273_.tb6_4(0),
RQTY_273_.tb6_5(0),
null,
null,
RQTY_273_.tb6_8(0),
null,
15,
'Fecha Inicial'
,
15,
'Y'
,
'N'
,
'Y'
,
'FECHA_INICIAL'
,
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
'PROV_INITIAL_DATE'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(2):=121057252;
RQTY_273_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(2):=RQTY_273_.tb2_0(2);
RQTY_273_.old_tb2_1(2):='MO_VALIDATTR_CT26E121057252'
;
RQTY_273_.tb2_1(2):=RQTY_273_.tb2_0(2);
RQTY_273_.tb2_2(2):=RQTY_273_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(2),
RQTY_273_.tb2_1(2),
RQTY_273_.tb2_2(2),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbFinalDate);dtFinalDate = UT_CONVERT.FNUCHARTODATE(sbFinalDate);dtFechaAct = UT_DATE.FDTSYSDATE();ge_boinstancecontrol.GetCurrentInstance(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"MO_PROCESS","PROV_INITIAL_DATE",sbInitDate);dtInitDate = UT_CONVERT.FNUCHARTODATE(sbInitDate);if (UT_DATE.FDTDIFFDATE(dtFechaAct, dtFinalDate) < 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha Final no puede ser mayor a la fecha actual");,if (UT_DATE.FDTDIFFDATE(dtFinalDate, dtInitDate) < 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La Fecha Final no puede ser menor a la Fecha Inicial");,);)'
,
'LBTEST'
,
to_date('15-08-2012 09:27:38','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PROCESS - PROV_FINAL_DATE - Validaciones de fecha'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(1):=1659;
RQTY_273_.tb6_1(1):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(1):=68;
RQTY_273_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(1),-1)));
RQTY_273_.old_tb6_3(1):=20368;
RQTY_273_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(1),-1)));
RQTY_273_.old_tb6_4(1):=null;
RQTY_273_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(1),-1)));
RQTY_273_.old_tb6_5(1):=null;
RQTY_273_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(1),-1)));
RQTY_273_.tb6_8(1):=RQTY_273_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(1),
ENTITY_ID=RQTY_273_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_273_.tb6_8(1),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Fecha Final'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_FINAL'
,
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
ATTRI_TECHNICAL_NAME='PROV_FINAL_DATE'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(1),
RQTY_273_.tb6_1(1),
RQTY_273_.tb6_2(1),
RQTY_273_.tb6_3(1),
RQTY_273_.tb6_4(1),
RQTY_273_.tb6_5(1),
null,
null,
RQTY_273_.tb6_8(1),
null,
16,
'Fecha Final'
,
16,
'Y'
,
'N'
,
'Y'
,
'FECHA_FINAL'
,
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
'PROV_FINAL_DATE'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb1_0(2):=23;
RQTY_273_.tb1_1(2):=RQTY_273_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_273_.tb1_0(2),
MODULE_ID=RQTY_273_.tb1_1(2),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_273_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_273_.tb1_0(2),
RQTY_273_.tb1_1(2),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(3):=121057253;
RQTY_273_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(3):=RQTY_273_.tb2_0(3);
RQTY_273_.old_tb2_1(3):='MO_INITATRIB_CT23E121057253'
;
RQTY_273_.tb2_1(3):=RQTY_273_.tb2_0(3);
RQTY_273_.tb2_2(3):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(3),
RQTY_273_.tb2_1(3),
RQTY_273_.tb2_2(3),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);nuIdPet = CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuIdPet);,nuIdPet = CC_BOPETITIONMGR.FNUGETPETITIONID(null);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuIdPet);)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:39','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - CUST_CARE_REQUEST_NUM - Inicialización de la interación'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(2):=1625;
RQTY_273_.tb6_1(2):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(2):=17;
RQTY_273_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(2),-1)));
RQTY_273_.old_tb6_3(2):=257;
RQTY_273_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(2),-1)));
RQTY_273_.old_tb6_4(2):=null;
RQTY_273_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(2),-1)));
RQTY_273_.old_tb6_5(2):=null;
RQTY_273_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(2),-1)));
RQTY_273_.tb6_7(2):=RQTY_273_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(2),
ENTITY_ID=RQTY_273_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(2),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(2),
RQTY_273_.tb6_1(2),
RQTY_273_.tb6_2(2),
RQTY_273_.tb6_3(2),
RQTY_273_.tb6_4(2),
RQTY_273_.tb6_5(2),
null,
RQTY_273_.tb6_7(2),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(3):=1626;
RQTY_273_.tb6_1(3):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(3):=17;
RQTY_273_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(3),-1)));
RQTY_273_.old_tb6_3(3):=269;
RQTY_273_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(3),-1)));
RQTY_273_.old_tb6_4(3):=null;
RQTY_273_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(3),-1)));
RQTY_273_.old_tb6_5(3):=null;
RQTY_273_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(3),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(3),
ENTITY_ID=RQTY_273_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Tipo paquete'
,
DISPLAY_ORDER=2,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(3),
RQTY_273_.tb6_1(3),
RQTY_273_.tb6_2(3),
RQTY_273_.tb6_3(3),
RQTY_273_.tb6_4(3),
RQTY_273_.tb6_5(3),
null,
null,
null,
null,
2,
'Tipo paquete'
,
2,
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(4):=121057254;
RQTY_273_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(4):=RQTY_273_.tb2_0(4);
RQTY_273_.old_tb2_1(4):='MO_INITATRIB_CT23E121057254'
;
RQTY_273_.tb2_1(4):=RQTY_273_.tb2_0(4);
RQTY_273_.tb2_2(4):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(4),
RQTY_273_.tb2_1(4),
RQTY_273_.tb2_2(4),
'nuPackageId = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_PACKAGES", "SEQ_MO_PACKAGES");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuPackageId)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:41','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - PACKAGE_ID - Inicialización de la solicitud'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(4):=1627;
RQTY_273_.tb6_1(4):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(4):=17;
RQTY_273_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(4),-1)));
RQTY_273_.old_tb6_3(4):=255;
RQTY_273_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(4),-1)));
RQTY_273_.old_tb6_4(4):=null;
RQTY_273_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(4),-1)));
RQTY_273_.old_tb6_5(4):=null;
RQTY_273_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(4),-1)));
RQTY_273_.tb6_7(4):=RQTY_273_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(4),
ENTITY_ID=RQTY_273_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Número Solicitud'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='NUMERO_SOLICITUD'
,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(4),
RQTY_273_.tb6_1(4),
RQTY_273_.tb6_2(4),
RQTY_273_.tb6_3(4),
RQTY_273_.tb6_4(4),
RQTY_273_.tb6_5(4),
null,
RQTY_273_.tb6_7(4),
null,
null,
3,
'Número Solicitud'
,
3,
'Y'
,
'N'
,
'Y'
,
'NUMERO_SOLICITUD'
,
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(5):=121057257;
RQTY_273_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(5):=RQTY_273_.tb2_0(5);
RQTY_273_.old_tb2_1(5):='MO_INITATRIB_CT23E121057257'
;
RQTY_273_.tb2_1(5):=RQTY_273_.tb2_0(5);
RQTY_273_.tb2_2(5):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(5),
RQTY_273_.tb2_1(5),
RQTY_273_.tb2_2(5),
'nuFuncionario = GE_BOPERSONAL.FNUGETPERSONID();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuFuncionario)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:42','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - PERSON_ID - Inicialización del funcionario'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb7_0(0):=120029891;
RQTY_273_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_273_.tb7_0(0):=RQTY_273_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_273_.tb7_0(0),
16,
'Vendedores'
,
'SELECT   a.person_id ID, a.name_ DESCRIPTION FROM   GE_PERSON a'
,
'Vendedores'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(5):=1629;
RQTY_273_.tb6_1(5):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(5):=17;
RQTY_273_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(5),-1)));
RQTY_273_.old_tb6_3(5):=50001162;
RQTY_273_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(5),-1)));
RQTY_273_.old_tb6_4(5):=null;
RQTY_273_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(5),-1)));
RQTY_273_.old_tb6_5(5):=null;
RQTY_273_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(5),-1)));
RQTY_273_.tb6_6(5):=RQTY_273_.tb7_0(0);
RQTY_273_.tb6_7(5):=RQTY_273_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(5),
ENTITY_ID=RQTY_273_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(5),
STATEMENT_ID=RQTY_273_.tb6_6(5),
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(5),
VALID_EXPRESSION_ID=null,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(5),
RQTY_273_.tb6_1(5),
RQTY_273_.tb6_2(5),
RQTY_273_.tb6_3(5),
RQTY_273_.tb6_4(5),
RQTY_273_.tb6_5(5),
RQTY_273_.tb6_6(5),
RQTY_273_.tb6_7(5),
null,
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(6):=121057258;
RQTY_273_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(6):=RQTY_273_.tb2_0(6);
RQTY_273_.old_tb2_1(6):='MO_INITATRIB_CT23E121057258'
;
RQTY_273_.tb2_1(6):=RQTY_273_.tb2_0(6);
RQTY_273_.tb2_2(6):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(6),
RQTY_273_.tb2_1(6),
RQTY_273_.tb2_2(6),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);nuOperUnit = GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuOperUnit);,nuOperUnit = GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuOperUnit);)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:42','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - POS_OPER_UNIT_ID - Inicialización del punto de atención'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb7_0(1):=120029892;
RQTY_273_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_273_.tb7_0(1):=RQTY_273_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_273_.tb7_0(1),
16,
'Puntos de atención'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')
'
,
'Puntos de Atención'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(6):=1630;
RQTY_273_.tb6_1(6):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(6):=17;
RQTY_273_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(6),-1)));
RQTY_273_.old_tb6_3(6):=109479;
RQTY_273_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(6),-1)));
RQTY_273_.old_tb6_4(6):=null;
RQTY_273_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(6),-1)));
RQTY_273_.old_tb6_5(6):=null;
RQTY_273_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(6),-1)));
RQTY_273_.tb6_6(6):=RQTY_273_.tb7_0(1);
RQTY_273_.tb6_7(6):=RQTY_273_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(6),
ENTITY_ID=RQTY_273_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(6),
STATEMENT_ID=RQTY_273_.tb6_6(6),
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(6),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(6),
RQTY_273_.tb6_1(6),
RQTY_273_.tb6_2(6),
RQTY_273_.tb6_3(6),
RQTY_273_.tb6_4(6),
RQTY_273_.tb6_5(6),
RQTY_273_.tb6_6(6),
RQTY_273_.tb6_7(6),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(7):=121057259;
RQTY_273_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(7):=RQTY_273_.tb2_0(7);
RQTY_273_.old_tb2_1(7):='MO_INITATRIB_CT23E121057259'
;
RQTY_273_.tb2_1(7):=RQTY_273_.tb2_0(7);
RQTY_273_.tb2_2(7):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(7),
RQTY_273_.tb2_1(7),
RQTY_273_.tb2_2(7),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);nuReceptionType = CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuReceptionType);,nuReceptionType = CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuReceptionType);)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:42','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb7_0(2):=120029893;
RQTY_273_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_273_.tb7_0(2):=RQTY_273_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_273_.tb7_0(2),
16,
'Medios de Recepción'
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
'Medios de Recepción'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(7):=1631;
RQTY_273_.tb6_1(7):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(7):=17;
RQTY_273_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(7),-1)));
RQTY_273_.old_tb6_3(7):=2683;
RQTY_273_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(7),-1)));
RQTY_273_.old_tb6_4(7):=null;
RQTY_273_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(7),-1)));
RQTY_273_.old_tb6_5(7):=null;
RQTY_273_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(7),-1)));
RQTY_273_.tb6_6(7):=RQTY_273_.tb7_0(2);
RQTY_273_.tb6_7(7):=RQTY_273_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(7),
ENTITY_ID=RQTY_273_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(7),
STATEMENT_ID=RQTY_273_.tb6_6(7),
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Medio recepción'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(7),
RQTY_273_.tb6_1(7),
RQTY_273_.tb6_2(7),
RQTY_273_.tb6_3(7),
RQTY_273_.tb6_4(7),
RQTY_273_.tb6_5(7),
RQTY_273_.tb6_6(7),
RQTY_273_.tb6_7(7),
null,
null,
6,
'Medio recepción'
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(8):=121057260;
RQTY_273_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(8):=RQTY_273_.tb2_0(8);
RQTY_273_.old_tb2_1(8):='MO_INITATRIB_CT23E121057260'
;
RQTY_273_.tb2_1(8):=RQTY_273_.tb2_0(8);
RQTY_273_.tb2_2(8):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(8),
RQTY_273_.tb2_1(8),
RQTY_273_.tb2_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('12-10-2012 10:11:14','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(8):=1632;
RQTY_273_.tb6_1(8):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(8):=17;
RQTY_273_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(8),-1)));
RQTY_273_.old_tb6_3(8):=146755;
RQTY_273_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(8),-1)));
RQTY_273_.old_tb6_4(8):=null;
RQTY_273_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(8),-1)));
RQTY_273_.old_tb6_5(8):=null;
RQTY_273_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(8),-1)));
RQTY_273_.tb6_7(8):=RQTY_273_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(8),
ENTITY_ID=RQTY_273_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(8),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(8),
RQTY_273_.tb6_1(8),
RQTY_273_.tb6_2(8),
RQTY_273_.tb6_3(8),
RQTY_273_.tb6_4(8),
RQTY_273_.tb6_5(8),
null,
RQTY_273_.tb6_7(8),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(9):=121057261;
RQTY_273_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(9):=RQTY_273_.tb2_0(9);
RQTY_273_.old_tb2_1(9):='MO_INITATRIB_CT23E121057261'
;
RQTY_273_.tb2_1(9):=RQTY_273_.tb2_0(9);
RQTY_273_.tb2_2(9):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(9),
RQTY_273_.tb2_1(9),
RQTY_273_.tb2_2(9),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);nuAnswerAddress = CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuAnswerAddress);,nuAnswerAddress = CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuAnswerAddress);)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:43','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - ADDRESS_ID - Inicialización de la dirección de respuesta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(9):=1641;
RQTY_273_.tb6_1(9):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(9):=17;
RQTY_273_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(9),-1)));
RQTY_273_.old_tb6_3(9):=146756;
RQTY_273_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(9),-1)));
RQTY_273_.old_tb6_4(9):=null;
RQTY_273_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(9),-1)));
RQTY_273_.old_tb6_5(9):=null;
RQTY_273_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(9),-1)));
RQTY_273_.tb6_7(9):=RQTY_273_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(9),
ENTITY_ID=RQTY_273_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Dirección De Respuesta'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(9),
RQTY_273_.tb6_1(9),
RQTY_273_.tb6_2(9),
RQTY_273_.tb6_3(9),
RQTY_273_.tb6_4(9),
RQTY_273_.tb6_5(9),
null,
RQTY_273_.tb6_7(9),
null,
null,
8,
'Dirección De Respuesta'
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(10):=121057262;
RQTY_273_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(10):=RQTY_273_.tb2_0(10);
RQTY_273_.old_tb2_1(10):='MO_INITATRIB_CT23E121057262'
;
RQTY_273_.tb2_1(10):=RQTY_273_.tb2_0(10);
RQTY_273_.tb2_2(10):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(10),
RQTY_273_.tb2_1(10),
RQTY_273_.tb2_2(10),
'dtSysdate = UT_DATE.FDTSYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtSysdate)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:43','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(10):=1642;
RQTY_273_.tb6_1(10):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(10):=17;
RQTY_273_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(10),-1)));
RQTY_273_.old_tb6_3(10):=259;
RQTY_273_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(10),-1)));
RQTY_273_.old_tb6_4(10):=null;
RQTY_273_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(10),-1)));
RQTY_273_.old_tb6_5(10):=null;
RQTY_273_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(10),-1)));
RQTY_273_.tb6_7(10):=RQTY_273_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(10),
ENTITY_ID=RQTY_273_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Fecha envío mensajes'
,
DISPLAY_ORDER=9,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(10),
RQTY_273_.tb6_1(10),
RQTY_273_.tb6_2(10),
RQTY_273_.tb6_3(10),
RQTY_273_.tb6_4(10),
RQTY_273_.tb6_5(10),
null,
RQTY_273_.tb6_7(10),
null,
null,
9,
'Fecha envío mensajes'
,
9,
'N'
,
'N'
,
'Y'
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(11):=1643;
RQTY_273_.tb6_1(11):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(11):=17;
RQTY_273_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(11),-1)));
RQTY_273_.old_tb6_3(11):=109478;
RQTY_273_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(11),-1)));
RQTY_273_.old_tb6_4(11):=null;
RQTY_273_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(11),-1)));
RQTY_273_.old_tb6_5(11):=null;
RQTY_273_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(11),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(11),
ENTITY_ID=RQTY_273_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(11),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(11),
RQTY_273_.tb6_1(11),
RQTY_273_.tb6_2(11),
RQTY_273_.tb6_3(11),
RQTY_273_.tb6_4(11),
RQTY_273_.tb6_5(11),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(12):=1646;
RQTY_273_.tb6_1(12):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(12):=17;
RQTY_273_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(12),-1)));
RQTY_273_.old_tb6_3(12):=42118;
RQTY_273_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(12),-1)));
RQTY_273_.old_tb6_4(12):=109479;
RQTY_273_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(12),-1)));
RQTY_273_.old_tb6_5(12):=null;
RQTY_273_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(12),
ENTITY_ID=RQTY_273_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(12),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(12),
RQTY_273_.tb6_1(12),
RQTY_273_.tb6_2(12),
RQTY_273_.tb6_3(12),
RQTY_273_.tb6_4(12),
RQTY_273_.tb6_5(12),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(11):=121057263;
RQTY_273_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(11):=RQTY_273_.tb2_0(11);
RQTY_273_.old_tb2_1(11):='MO_INITATRIB_CT23E121057263'
;
RQTY_273_.tb2_1(11):=RQTY_273_.tb2_0(11);
RQTY_273_.tb2_2(11):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(11),
RQTY_273_.tb2_1(11),
RQTY_273_.tb2_2(11),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbId);,)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:43','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_PACKAGES.SUBSCRIBER_ID'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(13):=1647;
RQTY_273_.tb6_1(13):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(13):=17;
RQTY_273_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(13),-1)));
RQTY_273_.old_tb6_3(13):=4015;
RQTY_273_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(13),-1)));
RQTY_273_.old_tb6_4(13):=null;
RQTY_273_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(13),-1)));
RQTY_273_.old_tb6_5(13):=null;
RQTY_273_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(13),-1)));
RQTY_273_.tb6_7(13):=RQTY_273_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(13),
ENTITY_ID=RQTY_273_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(13),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Suscriptor'
,
DISPLAY_ORDER=12,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(13),
RQTY_273_.tb6_1(13),
RQTY_273_.tb6_2(13),
RQTY_273_.tb6_3(13),
RQTY_273_.tb6_4(13),
RQTY_273_.tb6_5(13),
null,
RQTY_273_.tb6_7(13),
null,
null,
12,
'Suscriptor'
,
12,
'N'
,
'N'
,
'Y'
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb7_0(3):=120029894;
RQTY_273_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_273_.tb7_0(3):=RQTY_273_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_273_.tb7_0(3),
16,
'Relacion del Solicitante con el Predio'
,
'select role_ID Id, Description FROM CC_ROLE'
,
'Relacion del Solicitante con el Predio'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(14):=1648;
RQTY_273_.tb6_1(14):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(14):=68;
RQTY_273_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(14),-1)));
RQTY_273_.old_tb6_3(14):=2558;
RQTY_273_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(14),-1)));
RQTY_273_.old_tb6_4(14):=null;
RQTY_273_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(14),-1)));
RQTY_273_.old_tb6_5(14):=null;
RQTY_273_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(14),-1)));
RQTY_273_.tb6_6(14):=RQTY_273_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(14),
ENTITY_ID=RQTY_273_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(14),
STATEMENT_ID=RQTY_273_.tb6_6(14),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Relación del Solicitante con el Predio'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='RELACION_DEL_SOLICITANTE_CON_EL_PREDIO'
,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(14),
RQTY_273_.tb6_1(14),
RQTY_273_.tb6_2(14),
RQTY_273_.tb6_3(14),
RQTY_273_.tb6_4(14),
RQTY_273_.tb6_5(14),
RQTY_273_.tb6_6(14),
null,
null,
null,
14,
'Relación del Solicitante con el Predio'
,
14,
'Y'
,
'N'
,
'Y'
,
'RELACION_DEL_SOLICITANTE_CON_EL_PREDIO'
,
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(12):=121057264;
RQTY_273_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(12):=RQTY_273_.tb2_0(12);
RQTY_273_.old_tb2_1(12):='MO_VALIDATTR_CT26E121057264'
;
RQTY_273_.tb2_1(12):=RQTY_273_.tb2_0(12);
RQTY_273_.tb2_2(12):=RQTY_273_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(12),
RQTY_273_.tb2_1(12),
RQTY_273_.tb2_2(12),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbComment);nuTamComment = UT_STRING.FNULENGTH(sbComment);if (nuTamComment < 20,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La observación debe ser minímo de 20 carácteres");,)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:44','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MO_PACKAGES - COMMENT_ - Valida minimo 20 caracteres en la observación'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(15):=1649;
RQTY_273_.tb6_1(15):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(15):=17;
RQTY_273_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(15),-1)));
RQTY_273_.old_tb6_3(15):=146754;
RQTY_273_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(15),-1)));
RQTY_273_.old_tb6_4(15):=null;
RQTY_273_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(15),-1)));
RQTY_273_.old_tb6_5(15):=null;
RQTY_273_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(15),-1)));
RQTY_273_.tb6_8(15):=RQTY_273_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(15),
ENTITY_ID=RQTY_273_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_273_.tb6_8(15),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Observación'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(15),
RQTY_273_.tb6_1(15),
RQTY_273_.tb6_2(15),
RQTY_273_.tb6_3(15),
RQTY_273_.tb6_4(15),
RQTY_273_.tb6_5(15),
null,
null,
RQTY_273_.tb6_8(15),
null,
13,
'Observación'
,
13,
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(13):=121057255;
RQTY_273_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(13):=RQTY_273_.tb2_0(13);
RQTY_273_.old_tb2_1(13):='MO_INITATRIB_CT23E121057255'
;
RQTY_273_.tb2_1(13):=RQTY_273_.tb2_0(13);
RQTY_273_.tb2_2(13):=RQTY_273_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(13),
RQTY_273_.tb2_1(13),
RQTY_273_.tb2_2(13),
'dtFechaSistema = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaSistema)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:41','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - REQUEST_DATE - Inicialización con la fecha del sistema'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.old_tb2_0(14):=121057256;
RQTY_273_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_273_.tb2_0(14):=RQTY_273_.tb2_0(14);
RQTY_273_.old_tb2_1(14):='MO_VALIDATTR_CT26E121057256'
;
RQTY_273_.tb2_1(14):=RQTY_273_.tb2_0(14);
RQTY_273_.tb2_2(14):=RQTY_273_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_273_.tb2_0(14),
RQTY_273_.tb2_1(14),
RQTY_273_.tb2_2(14),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);ge_boinstancecontrol.GetCurrentInstance(sbInstancia);nuPsPacktype = 273;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No esta permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro esta fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro esta fuera del rango permitido para el tipo de solicitud");,););)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:41','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:03:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PACKAGES - REQUEST_DATE - Validación fecha de registro'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb6_0(16):=1628;
RQTY_273_.tb6_1(16):=RQTY_273_.tb5_0(0);
RQTY_273_.old_tb6_2(16):=17;
RQTY_273_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_273_.TBENTITYNAME(NVL(RQTY_273_.old_tb6_2(16),-1)));
RQTY_273_.old_tb6_3(16):=258;
RQTY_273_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_3(16),-1)));
RQTY_273_.old_tb6_4(16):=null;
RQTY_273_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_4(16),-1)));
RQTY_273_.old_tb6_5(16):=null;
RQTY_273_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_273_.TBENTITYATTRIBUTENAME(NVL(RQTY_273_.old_tb6_5(16),-1)));
RQTY_273_.tb6_7(16):=RQTY_273_.tb2_0(13);
RQTY_273_.tb6_8(16):=RQTY_273_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_273_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_273_.tb6_1(16),
ENTITY_ID=RQTY_273_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_273_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_273_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_273_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_273_.tb6_7(16),
VALID_EXPRESSION_ID=RQTY_273_.tb6_8(16),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Fecha solicitud'
,
DISPLAY_ORDER=1,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_SOLICITUD'
,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_273_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_273_.tb6_0(16),
RQTY_273_.tb6_1(16),
RQTY_273_.tb6_2(16),
RQTY_273_.tb6_3(16),
RQTY_273_.tb6_4(16),
RQTY_273_.tb6_5(16),
null,
RQTY_273_.tb6_7(16),
RQTY_273_.tb6_8(16),
null,
1,
'Fecha solicitud'
,
1,
'Y'
,
'N'
,
'Y'
,
'FECHA_SOLICITUD'
,
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb8_0(0):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_273_.tb8_0(0),
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

 WHERE ATTRIBUTE_ID = RQTY_273_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_273_.tb8_0(0),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb9_0(0):=RQTY_273_.tb5_0(0);
RQTY_273_.tb9_1(0):=RQTY_273_.tb8_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_273_.tb9_0(0),
RQTY_273_.tb9_1(0),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb8_0(1):=42;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_273_.tb8_0(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
ATTRIBUTE_TYPE_ID=1,
MODULE_ID=5,
ATTRIBUTE_CLASS_ID=8,
NAME_ATTRIBUTE='SUCCESS_PACK_ANSWER'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Respuesta de Éxito por Defecto para Solicitudes'
,
DISPLAY_NAME='Respuesta de Éxito por Defecto para Solicitudes'

 WHERE ATTRIBUTE_ID = RQTY_273_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_273_.tb8_0(1),
null,
null,
1,
5,
8,
'SUCCESS_PACK_ANSWER'
,
null,
null,
null,
null,
null,
'Respuesta de Éxito por Defecto para Solicitudes'
,
'Respuesta de Éxito por Defecto para Solicitudes'
);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb9_0(1):=RQTY_273_.tb5_0(0);
RQTY_273_.tb9_1(1):=RQTY_273_.tb8_0(1);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (1)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_273_.tb9_0(1),
RQTY_273_.tb9_1(1),
'Respuesta de Éxito por Defecto para Solicitudes'
,
'729'
,
0,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb10_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_273_.tb10_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb11_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_273_.tb11_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb12_0(0):=6121;
RQTY_273_.tb12_2(0):=RQTY_273_.tb10_0(0);
RQTY_273_.tb12_3(0):=RQTY_273_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_273_.tb12_0(0),
SERVCLAS=null,
SERVTISE=RQTY_273_.tb12_2(0),
SERVSETI=RQTY_273_.tb12_3(0),
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
 WHERE SERVCODI = RQTY_273_.tb12_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_273_.tb12_0(0),
null,
RQTY_273_.tb12_2(0),
RQTY_273_.tb12_3(0),
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb13_0(0):=75;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_273_.tb13_0(0),
CLASS_REGISTER_ID=606,
DESCRIPTION='Generico'
,
ASSIGNABLE='N'
,
USE_WF_PLAN='N'
,
TAG_NAME='MOTY_GENERICO'
,
ACTIVITY_TYPE=null
 WHERE MOTIVE_TYPE_ID = RQTY_273_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_273_.tb13_0(0),
606,
'Generico'
,
'N'
,
'N'
,
'MOTY_GENERICO'
,
null);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb14_0(0):=82;
RQTY_273_.tb14_1(0):=RQTY_273_.tb12_0(0);
RQTY_273_.tb14_2(0):=RQTY_273_.tb13_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_273_.tb14_0(0),
RQTY_273_.tb14_1(0),
RQTY_273_.tb14_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
,
'Productos por estado de Cuenta'
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
RQTY_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_273_.blProcessStatus) then
 return;
end if;

RQTY_273_.tb15_0(0):=86;
RQTY_273_.tb15_1(0):=RQTY_273_.tb14_0(0);
RQTY_273_.tb15_3(0):=RQTY_273_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_273_.tb15_0(0),
PRODUCT_MOTIVE_ID=RQTY_273_.tb15_1(0),
PRODUCT_TYPE_ID=6121,
PACKAGE_TYPE_ID=RQTY_273_.tb15_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=9999,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_273_.tb15_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_273_.tb15_0(0),
RQTY_273_.tb15_1(0),
6121,
RQTY_273_.tb15_3(0),
1,
9999,
2);
end if;

exception when others then
RQTY_273_.blProcessStatus := false;
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
nuIndex := RQTY_273_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_273_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_273_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_273_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_273_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_273_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_273_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_273_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_273_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_273_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_273_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_273_.blProcessStatus := false;
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
 nuIndex := RQTY_273_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_273_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_273_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_273_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_273_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_273_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_273_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_273_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_273_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_273_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_273_',
'CREATE OR REPLACE PACKAGE RQPMT_273_ IS ' || chr(10) ||
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
'where  package_type_id = 273; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 273 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 273 ' || chr(10) ||
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
'END RQPMT_273_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_273_******************************'); END;
/

BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_273_.cuExpressions;
fetch RQPMT_273_.cuExpressions bulk collect INTO RQPMT_273_.tbExpressionsId;
close RQPMT_273_.cuExpressions;

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_273_.tbEntityName(-1) := 'NULL';
   RQPMT_273_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQPMT_273_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQPMT_273_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(204) := 'MO_MOTIVE@MOTIV_RECORDING_DATE';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(36570) := 'MO_MOTIVE@TAG_NAME';
   RQPMT_273_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_273_.tbEntityAttributeName(20368) := 'MO_PROCESS@PROV_FINAL_DATE';
   RQPMT_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_273_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQPMT_273_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_273_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQPMT_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_273_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQPMT_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQPMT_273_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQPMT_273_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_273_.tbEntityAttributeName(20367) := 'MO_PROCESS@PROV_INITIAL_DATE';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQPMT_273_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_273_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQPMT_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQPMT_273_.tbEntityAttributeName(50000604) := 'MO_SUBS_TYPE_MOTIV@MOTIVE_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_273_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_273_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 273
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
WHERE PACKAGE_type_id = 273
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
WHERE PACKAGE_type_id = 273
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
WHERE PACKAGE_type_id = 273
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
WHERE PACKAGE_type_id = 273
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
WHERE PACKAGE_type_id = 273
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_273_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 273
))));

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_273_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_273_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_273_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_273_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 273
))));

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 273
))));

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_273_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_273_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 273
)))));

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_273_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_273_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_273_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_273_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_273_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_273_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 273
))));

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
))));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 273
))));

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
)));
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_273_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_273_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_273_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_273_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_273_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_273_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_273_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_273_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 273
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_273_.blProcessStatus) then
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb0_0(0):=82;
RQPMT_273_.tb0_1(0):=6121;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_273_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_273_.tb0_1(0),
MOTIVE_TYPE_ID=75,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
,
DESCRIPTION='Productos por estado de Cuenta'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_273_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_273_.tb0_0(0),
RQPMT_273_.tb0_1(0),
75,
null,
'N'
,
'N'
,
'N'
,
'M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
,
'Productos por estado de Cuenta'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(0):=1784;
RQPMT_273_.old_tb1_1(0):=8;
RQPMT_273_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(0),-1)));
RQPMT_273_.old_tb1_2(0):=201;
RQPMT_273_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(0),-1)));
RQPMT_273_.old_tb1_3(0):=20367;
RQPMT_273_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(0),-1)));
RQPMT_273_.old_tb1_4(0):=null;
RQPMT_273_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(0),-1)));
RQPMT_273_.tb1_9(0):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(0),
ENTITY_ID=RQPMT_273_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(0),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Fecha inicial provisionalidad'
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
TAG_NAME='FECHA_INICIAL_PROVISIONALIDAD'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(0),
RQPMT_273_.tb1_1(0),
RQPMT_273_.tb1_2(0),
RQPMT_273_.tb1_3(0),
RQPMT_273_.tb1_4(0),
null,
null,
null,
null,
RQPMT_273_.tb1_9(0),
16,
'Fecha inicial provisionalidad'
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
'FECHA_INICIAL_PROVISIONALIDAD'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(1):=1785;
RQPMT_273_.old_tb1_1(1):=8;
RQPMT_273_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(1),-1)));
RQPMT_273_.old_tb1_2(1):=202;
RQPMT_273_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(1),-1)));
RQPMT_273_.old_tb1_3(1):=20368;
RQPMT_273_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(1),-1)));
RQPMT_273_.old_tb1_4(1):=null;
RQPMT_273_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(1),-1)));
RQPMT_273_.tb1_9(1):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(1),
ENTITY_ID=RQPMT_273_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(1),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Fecha final provisionalidad'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='FECHA_FINAL_PROVISIONALIDAD'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(1),
RQPMT_273_.tb1_1(1),
RQPMT_273_.tb1_2(1),
RQPMT_273_.tb1_3(1),
RQPMT_273_.tb1_4(1),
null,
null,
null,
null,
RQPMT_273_.tb1_9(1),
17,
'Fecha final provisionalidad'
,
17,
'N'
,
'N'
,
'N'
,
'Y'
,
'FECHA_FINAL_PROVISIONALIDAD'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(2):=1779;
RQPMT_273_.old_tb1_1(2):=9179;
RQPMT_273_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(2),-1)));
RQPMT_273_.old_tb1_2(2):=50000604;
RQPMT_273_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(2),-1)));
RQPMT_273_.old_tb1_3(2):=187;
RQPMT_273_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(2),-1)));
RQPMT_273_.old_tb1_4(2):=null;
RQPMT_273_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(2),-1)));
RQPMT_273_.tb1_9(2):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(2),
ENTITY_ID=RQPMT_273_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(2),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Identificador del Motivo'
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
TAG_NAME='IDENTIFICADOR_DEL_MOTIVO'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='MOTIVE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(2),
RQPMT_273_.tb1_1(2),
RQPMT_273_.tb1_2(2),
RQPMT_273_.tb1_3(2),
RQPMT_273_.tb1_4(2),
null,
null,
null,
null,
RQPMT_273_.tb1_9(2),
11,
'Identificador del Motivo'
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
'IDENTIFICADOR_DEL_MOTIVO'
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
'MO_SUBS_TYPE_MOTIV'
,
'MOTIVE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(3):=2201;
RQPMT_273_.old_tb1_1(3):=8;
RQPMT_273_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(3),-1)));
RQPMT_273_.old_tb1_2(3):=192;
RQPMT_273_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(3),-1)));
RQPMT_273_.old_tb1_3(3):=null;
RQPMT_273_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(3),-1)));
RQPMT_273_.old_tb1_4(3):=null;
RQPMT_273_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(3),-1)));
RQPMT_273_.tb1_9(3):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(3),
ENTITY_ID=RQPMT_273_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(3),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Tipo de producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(3),
RQPMT_273_.tb1_1(3),
RQPMT_273_.tb1_2(3),
RQPMT_273_.tb1_3(3),
RQPMT_273_.tb1_4(3),
null,
null,
null,
null,
RQPMT_273_.tb1_9(3),
9,
'Tipo de producto'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_273_.tb2_0(0),
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

 WHERE MODULE_ID = RQPMT_273_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_273_.tb2_0(0),
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb3_0(0):=23;
RQPMT_273_.tb3_1(0):=RQPMT_273_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_273_.tb3_0(0),
MODULE_ID=RQPMT_273_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_273_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_273_.tb3_0(0),
RQPMT_273_.tb3_1(0),
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.old_tb4_0(0):=121057266;
RQPMT_273_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_273_.tb4_0(0):=RQPMT_273_.tb4_0(0);
RQPMT_273_.old_tb4_1(0):='MO_INITATRIB_CT23E121057266'
;
RQPMT_273_.tb4_1(0):=RQPMT_273_.tb4_0(0);
RQPMT_273_.tb4_2(0):=RQPMT_273_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_273_.tb4_0(0),
RQPMT_273_.tb4_1(0),
RQPMT_273_.tb4_2(0),
'nuMotiveId = MO_BOSEQUENCES.FNUGETMOTIVEID();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuMotiveId)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:44','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - MO_MOTIVE - MOTIVE_ID - Inicialización del id del motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(4):=1768;
RQPMT_273_.old_tb1_1(4):=8;
RQPMT_273_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(4),-1)));
RQPMT_273_.old_tb1_2(4):=187;
RQPMT_273_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(4),-1)));
RQPMT_273_.old_tb1_3(4):=null;
RQPMT_273_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(4),-1)));
RQPMT_273_.old_tb1_4(4):=null;
RQPMT_273_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(4),-1)));
RQPMT_273_.tb1_6(4):=RQPMT_273_.tb4_0(0);
RQPMT_273_.tb1_9(4):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(4),
ENTITY_ID=RQPMT_273_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_273_.tb1_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(4),
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
REQUIRED='Y'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(4),
RQPMT_273_.tb1_1(4),
RQPMT_273_.tb1_2(4),
RQPMT_273_.tb1_3(4),
RQPMT_273_.tb1_4(4),
null,
RQPMT_273_.tb1_6(4),
null,
null,
RQPMT_273_.tb1_9(4),
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
'Y'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(5):=1770;
RQPMT_273_.old_tb1_1(5):=8;
RQPMT_273_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(5),-1)));
RQPMT_273_.old_tb1_2(5):=204;
RQPMT_273_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(5),-1)));
RQPMT_273_.old_tb1_3(5):=258;
RQPMT_273_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(5),-1)));
RQPMT_273_.old_tb1_4(5):=null;
RQPMT_273_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(5),-1)));
RQPMT_273_.tb1_9(5):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(5),
ENTITY_ID=RQPMT_273_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(5),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Fecha registro'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(5),
RQPMT_273_.tb1_1(5),
RQPMT_273_.tb1_2(5),
RQPMT_273_.tb1_3(5),
RQPMT_273_.tb1_4(5),
null,
null,
null,
null,
RQPMT_273_.tb1_9(5),
1,
'Fecha registro'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(6):=1771;
RQPMT_273_.old_tb1_1(6):=8;
RQPMT_273_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(6),-1)));
RQPMT_273_.old_tb1_2(6):=213;
RQPMT_273_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(6),-1)));
RQPMT_273_.old_tb1_3(6):=255;
RQPMT_273_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(6),-1)));
RQPMT_273_.old_tb1_4(6):=null;
RQPMT_273_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(6),-1)));
RQPMT_273_.tb1_9(6):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(6),
ENTITY_ID=RQPMT_273_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(6),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Solicitud'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(6),
RQPMT_273_.tb1_1(6),
RQPMT_273_.tb1_2(6),
RQPMT_273_.tb1_3(6),
RQPMT_273_.tb1_4(6),
null,
null,
null,
null,
RQPMT_273_.tb1_9(6),
2,
'Solicitud'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(7):=1782;
RQPMT_273_.old_tb1_1(7):=9179;
RQPMT_273_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(7),-1)));
RQPMT_273_.old_tb1_2(7):=50000606;
RQPMT_273_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(7),-1)));
RQPMT_273_.old_tb1_3(7):=4015;
RQPMT_273_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(7),-1)));
RQPMT_273_.old_tb1_4(7):=null;
RQPMT_273_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(7),-1)));
RQPMT_273_.tb1_9(7):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(7),
ENTITY_ID=RQPMT_273_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(7),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Usuario del Servicio'
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
TAG_NAME='USUARIO_DEL_SERVICIO'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='SUBSCRIBER_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(7),
RQPMT_273_.tb1_1(7),
RQPMT_273_.tb1_2(7),
RQPMT_273_.tb1_3(7),
RQPMT_273_.tb1_4(7),
null,
null,
null,
null,
RQPMT_273_.tb1_9(7),
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
'Y'
,
'USUARIO_DEL_SERVICIO'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.old_tb4_0(1):=121057265;
RQPMT_273_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_273_.tb4_0(1):=RQPMT_273_.tb4_0(1);
RQPMT_273_.old_tb4_1(1):='MO_INITATRIB_CT23E121057265'
;
RQPMT_273_.tb4_1(1):=RQPMT_273_.tb4_0(1);
RQPMT_273_.tb4_2(1):=RQPMT_273_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_273_.tb4_0(1),
RQPMT_273_.tb4_1(1),
RQPMT_273_.tb4_2(1),
'nuSeq = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_SUBS_TYPE_MOTIV", "SEQ_MO_SUBS_TYPE_MOTIV");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSeq)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:46','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:07','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:07','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - SUBS_TYPE_MOTIV - MO_SUBS_TYPE_MOTIV'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(8):=1783;
RQPMT_273_.old_tb1_1(8):=9179;
RQPMT_273_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(8),-1)));
RQPMT_273_.old_tb1_2(8):=50000603;
RQPMT_273_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(8),-1)));
RQPMT_273_.old_tb1_3(8):=null;
RQPMT_273_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(8),-1)));
RQPMT_273_.old_tb1_4(8):=null;
RQPMT_273_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(8),-1)));
RQPMT_273_.tb1_6(8):=RQPMT_273_.tb4_0(1);
RQPMT_273_.tb1_9(8):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(8),
ENTITY_ID=RQPMT_273_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_273_.tb1_6(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(8),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Identificador de suscriptor por motivo'
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
TAG_NAME='IDENTIFICADOR_DE_SUSCRIPTOR_POR_MOTIVO'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='SUBS_TYPE_MOTIV_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(8),
RQPMT_273_.tb1_1(8),
RQPMT_273_.tb1_2(8),
RQPMT_273_.tb1_3(8),
RQPMT_273_.tb1_4(8),
null,
RQPMT_273_.tb1_6(8),
null,
null,
RQPMT_273_.tb1_9(8),
15,
'Identificador de suscriptor por motivo'
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
'IDENTIFICADOR_DE_SUSCRIPTOR_POR_MOTIVO'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(9):=1772;
RQPMT_273_.old_tb1_1(9):=8;
RQPMT_273_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(9),-1)));
RQPMT_273_.old_tb1_2(9):=189;
RQPMT_273_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(9),-1)));
RQPMT_273_.old_tb1_3(9):=257;
RQPMT_273_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(9),-1)));
RQPMT_273_.old_tb1_4(9):=null;
RQPMT_273_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(9),-1)));
RQPMT_273_.tb1_9(9):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(9),
ENTITY_ID=RQPMT_273_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(9),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Solicitud atención al cliente'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(9),
RQPMT_273_.tb1_1(9),
RQPMT_273_.tb1_2(9),
RQPMT_273_.tb1_3(9),
RQPMT_273_.tb1_4(9),
null,
null,
null,
null,
RQPMT_273_.tb1_9(9),
3,
'Solicitud atención al cliente'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(10):=1773;
RQPMT_273_.old_tb1_1(10):=8;
RQPMT_273_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(10),-1)));
RQPMT_273_.old_tb1_2(10):=191;
RQPMT_273_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(10),-1)));
RQPMT_273_.old_tb1_3(10):=null;
RQPMT_273_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(10),-1)));
RQPMT_273_.old_tb1_4(10):=null;
RQPMT_273_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(10),-1)));
RQPMT_273_.tb1_9(10):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(10),
ENTITY_ID=RQPMT_273_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(10),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Tipo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(10),
RQPMT_273_.tb1_1(10),
RQPMT_273_.tb1_2(10),
RQPMT_273_.tb1_3(10),
RQPMT_273_.tb1_4(10),
null,
null,
null,
null,
RQPMT_273_.tb1_9(10),
4,
'Tipo'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.old_tb4_0(2):=121057267;
RQPMT_273_.tb4_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_273_.tb4_0(2):=RQPMT_273_.tb4_0(2);
RQPMT_273_.old_tb4_1(2):='MO_INITATRIB_CT23E121057267'
;
RQPMT_273_.tb4_1(2):=RQPMT_273_.tb4_0(2);
RQPMT_273_.tb4_2(2):=RQPMT_273_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_273_.tb4_0(2),
RQPMT_273_.tb4_1(2),
RQPMT_273_.tb4_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSTATUSPARAMETER.FNUGETSTATUS_NULL_MOTIVE())'
,
'LBTEST'
,
to_date('14-08-2012 19:08:45','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(11):=1774;
RQPMT_273_.old_tb1_1(11):=8;
RQPMT_273_.tb1_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(11),-1)));
RQPMT_273_.old_tb1_2(11):=524;
RQPMT_273_.tb1_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(11),-1)));
RQPMT_273_.old_tb1_3(11):=null;
RQPMT_273_.tb1_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(11),-1)));
RQPMT_273_.old_tb1_4(11):=null;
RQPMT_273_.tb1_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(11),-1)));
RQPMT_273_.tb1_6(11):=RQPMT_273_.tb4_0(2);
RQPMT_273_.tb1_9(11):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(11),
ENTITY_ID=RQPMT_273_.tb1_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_273_.tb1_6(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(11),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Estado'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(11),
RQPMT_273_.tb1_1(11),
RQPMT_273_.tb1_2(11),
RQPMT_273_.tb1_3(11),
RQPMT_273_.tb1_4(11),
null,
RQPMT_273_.tb1_6(11),
null,
null,
RQPMT_273_.tb1_9(11),
5,
'Estado'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(12):=1775;
RQPMT_273_.old_tb1_1(12):=8;
RQPMT_273_.tb1_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(12),-1)));
RQPMT_273_.old_tb1_2(12):=697;
RQPMT_273_.tb1_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(12),-1)));
RQPMT_273_.old_tb1_3(12):=null;
RQPMT_273_.tb1_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(12),-1)));
RQPMT_273_.old_tb1_4(12):=null;
RQPMT_273_.tb1_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(12),-1)));
RQPMT_273_.tb1_9(12):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(12),
ENTITY_ID=RQPMT_273_.tb1_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(12),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Producto motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(12),
RQPMT_273_.tb1_1(12),
RQPMT_273_.tb1_2(12),
RQPMT_273_.tb1_3(12),
RQPMT_273_.tb1_4(12),
null,
null,
null,
null,
RQPMT_273_.tb1_9(12),
6,
'Producto motivo'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(13):=1776;
RQPMT_273_.old_tb1_1(13):=8;
RQPMT_273_.tb1_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(13),-1)));
RQPMT_273_.old_tb1_2(13):=36570;
RQPMT_273_.tb1_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(13),-1)));
RQPMT_273_.old_tb1_3(13):=null;
RQPMT_273_.tb1_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(13),-1)));
RQPMT_273_.old_tb1_4(13):=null;
RQPMT_273_.tb1_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(13),-1)));
RQPMT_273_.tb1_9(13):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(13),
ENTITY_ID=RQPMT_273_.tb1_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(13),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Etiqueta XML'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(13),
RQPMT_273_.tb1_1(13),
RQPMT_273_.tb1_2(13),
RQPMT_273_.tb1_3(13),
RQPMT_273_.tb1_4(13),
null,
null,
null,
null,
RQPMT_273_.tb1_9(13),
7,
'Etiqueta XML'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb3_0(1):=26;
RQPMT_273_.tb3_1(1):=RQPMT_273_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_273_.tb3_0(1),
MODULE_ID=RQPMT_273_.tb3_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_273_.tb3_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_273_.tb3_0(1),
RQPMT_273_.tb3_1(1),
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.old_tb4_0(3):=121057268;
RQPMT_273_.tb4_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_273_.tb4_0(3):=RQPMT_273_.tb4_0(3);
RQPMT_273_.old_tb4_1(3):='MO_VALIDATTR_CT26E121057268'
;
RQPMT_273_.tb4_1(3):=RQPMT_273_.tb4_0(3);
RQPMT_273_.tb4_2(3):=RQPMT_273_.tb3_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_273_.tb4_0(3),
RQPMT_273_.tb4_1(3),
RQPMT_273_.tb4_2(3),
'GI_BOINSTANCE.EXISTFIELDVALIDATE();GE_BOINSTANCECONTROL.GETCURRENTDATA(osbInstance,osbGroup,osbEntity,osbAttribute);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbProductId);nuProductId = UT_CONVERT.FNUCHARTONUMBER(sbProductId);nuProductTypeId = PR_BODATA.FNUGETVALUE("PR_PRODUCT", "PRODUCT_TYPE_ID", nuProductId);GE_BOINSTANCECONTROL.ADDATTRIBUTE(osbInstance,osbGroup,"MO_MOTIVE","PRODUCT_TYPE_ID",nuProductTypeId,GE_BOCONSTANTS.GETTRUE())'
,
'LBTEST'
,
to_date('04-09-2012 09:58:03','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MOT - MO_MOTIVE - PRODUCT_ID - Valida Unicidad del Campo en Multirregistro'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.old_tb5_0(0):=120029895;
RQPMT_273_.tb5_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_273_.tb5_0(0):=RQPMT_273_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_273_.tb5_0(0),
16,
'Lista de productos por contrato'
,
'SELECT a.product_id ID, a.service_number||'|| chr(39) ||' - '|| chr(39) ||'||b.servdesc DESCRIPTION
FROM pr_product a, servicio b
WHERE
a.product_type_id = b.servcodi
AND a.subscription_id = ge_boInstanceControl.fsbGetFieldValue('|| chr(39) ||'MO_MOTIVE'|| chr(39) ||','|| chr(39) ||'SUBSCRIPTION_ID'|| chr(39) ||')'
,
'Lista de productos por contrato'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(14):=1777;
RQPMT_273_.old_tb1_1(14):=8;
RQPMT_273_.tb1_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(14),-1)));
RQPMT_273_.old_tb1_2(14):=413;
RQPMT_273_.tb1_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(14),-1)));
RQPMT_273_.old_tb1_3(14):=null;
RQPMT_273_.tb1_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(14),-1)));
RQPMT_273_.old_tb1_4(14):=null;
RQPMT_273_.tb1_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(14),-1)));
RQPMT_273_.tb1_5(14):=RQPMT_273_.tb5_0(0);
RQPMT_273_.tb1_7(14):=RQPMT_273_.tb4_0(3);
RQPMT_273_.tb1_9(14):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(14),
ENTITY_ID=RQPMT_273_.tb1_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(14),
STATEMENT_ID=RQPMT_273_.tb1_5(14),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_273_.tb1_7(14),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(14),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(14),
RQPMT_273_.tb1_1(14),
RQPMT_273_.tb1_2(14),
RQPMT_273_.tb1_3(14),
RQPMT_273_.tb1_4(14),
RQPMT_273_.tb1_5(14),
null,
RQPMT_273_.tb1_7(14),
null,
RQPMT_273_.tb1_9(14),
8,
'Producto'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.old_tb4_0(4):=121057269;
RQPMT_273_.tb4_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_273_.tb4_0(4):=RQPMT_273_.tb4_0(4);
RQPMT_273_.old_tb4_1(4):='MO_INITATRIB_CT23E121057269'
;
RQPMT_273_.tb4_1(4):=RQPMT_273_.tb4_0(4);
RQPMT_273_.tb4_2(4):=RQPMT_273_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_273_.tb4_0(4),
RQPMT_273_.tb4_1(4),
RQPMT_273_.tb4_2(4),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuSubscriptionId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSubscriptionId)'
,
'LBTEST'
,
to_date('14-08-2012 19:08:45','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
to_date('02-12-2013 17:04:08','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(15):=1778;
RQPMT_273_.old_tb1_1(15):=8;
RQPMT_273_.tb1_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(15),-1)));
RQPMT_273_.old_tb1_2(15):=11403;
RQPMT_273_.tb1_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(15),-1)));
RQPMT_273_.old_tb1_3(15):=null;
RQPMT_273_.tb1_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(15),-1)));
RQPMT_273_.old_tb1_4(15):=null;
RQPMT_273_.tb1_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(15),-1)));
RQPMT_273_.tb1_6(15):=RQPMT_273_.tb4_0(4);
RQPMT_273_.tb1_9(15):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(15),
ENTITY_ID=RQPMT_273_.tb1_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_273_.tb1_6(15),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(15),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(15),
RQPMT_273_.tb1_1(15),
RQPMT_273_.tb1_2(15),
RQPMT_273_.tb1_3(15),
RQPMT_273_.tb1_4(15),
null,
RQPMT_273_.tb1_6(15),
null,
null,
RQPMT_273_.tb1_9(15),
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(16):=1780;
RQPMT_273_.old_tb1_1(16):=9179;
RQPMT_273_.tb1_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(16),-1)));
RQPMT_273_.old_tb1_2(16):=39387;
RQPMT_273_.tb1_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(16),-1)));
RQPMT_273_.old_tb1_3(16):=255;
RQPMT_273_.tb1_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(16),-1)));
RQPMT_273_.old_tb1_4(16):=null;
RQPMT_273_.tb1_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(16),-1)));
RQPMT_273_.tb1_9(16):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(16),
ENTITY_ID=RQPMT_273_.tb1_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(16),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador De Solicitud'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(16),
RQPMT_273_.tb1_1(16),
RQPMT_273_.tb1_2(16),
RQPMT_273_.tb1_3(16),
RQPMT_273_.tb1_4(16),
null,
null,
null,
null,
RQPMT_273_.tb1_9(16),
12,
'Identificador De Solicitud'
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
RQPMT_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;

RQPMT_273_.tb1_0(17):=1781;
RQPMT_273_.old_tb1_1(17):=9179;
RQPMT_273_.tb1_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_273_.TBENTITYNAME(NVL(RQPMT_273_.old_tb1_1(17),-1)));
RQPMT_273_.old_tb1_2(17):=149340;
RQPMT_273_.tb1_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_2(17),-1)));
RQPMT_273_.old_tb1_3(17):=2558;
RQPMT_273_.tb1_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_3(17),-1)));
RQPMT_273_.old_tb1_4(17):=null;
RQPMT_273_.tb1_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_273_.TBENTITYATTRIBUTENAME(NVL(RQPMT_273_.old_tb1_4(17),-1)));
RQPMT_273_.tb1_9(17):=RQPMT_273_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_273_.tb1_0(17),
ENTITY_ID=RQPMT_273_.tb1_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_273_.tb1_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_273_.tb1_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_273_.tb1_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_273_.tb1_9(17),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Identificador Del Rol.'
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
TAG_NAME='ROLE_ID'
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
ENTITY_NAME='MO_SUBS_TYPE_MOTIV'
,
ATTRI_TECHNICAL_NAME='ROLE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_273_.tb1_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_273_.tb1_0(17),
RQPMT_273_.tb1_1(17),
RQPMT_273_.tb1_2(17),
RQPMT_273_.tb1_3(17),
RQPMT_273_.tb1_4(17),
null,
null,
null,
null,
RQPMT_273_.tb1_9(17),
13,
'Identificador Del Rol.'
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
'ROLE_ID'
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
RQPMT_273_.blProcessStatus := false;
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

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(273, sbSuccess);
FOR rc in RQPMT_273_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_273_.blProcessStatus := false;
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
nuIndex := RQPMT_273_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_273_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_273_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_273_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_273_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_273_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_273_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_273_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_273_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_273_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_273_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_273_.blProcessStatus := false;
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
 nuIndex := RQPMT_273_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_273_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_273_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_273_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_273_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_273_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_273_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_273_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_273_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_273_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_273_',
'CREATE OR REPLACE PACKAGE RQCFG_273_ IS ' || chr(10) ||
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
'AND     external_root_id = 273 ' || chr(10) ||
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
'END RQCFG_273_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_273_******************************'); END;
/

BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_273_.cuCompositions;
fetch RQCFG_273_.cuCompositions bulk collect INTO RQCFG_273_.tbCompositions;
close RQCFG_273_.cuCompositions;

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_273_.tbEntityName(-1) := 'NULL';
   RQCFG_273_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_273_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_273_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_273_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_273_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(204) := 'MO_MOTIVE@MOTIV_RECORDING_DATE';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(20367) := 'MO_PROCESS@PROV_INITIAL_DATE';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(20368) := 'MO_PROCESS@PROV_FINAL_DATE';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(36570) := 'MO_MOTIVE@TAG_NAME';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(50000604) := 'MO_SUBS_TYPE_MOTIV@MOTIVE_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(20367) := 'MO_PROCESS@PROV_INITIAL_DATE';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(20368) := 'MO_PROCESS@PROV_FINAL_DATE';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(20368) := 'MO_PROCESS@PROV_FINAL_DATE';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(36570) := 'MO_MOTIVE@TAG_NAME';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(204) := 'MO_MOTIVE@MOTIV_RECORDING_DATE';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_273_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_273_.tbEntityAttributeName(20367) := 'MO_PROCESS@PROV_INITIAL_DATE';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_273_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_273_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_273_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_273_.tbEntityAttributeName(50000604) := 'MO_SUBS_TYPE_MOTIV@MOTIVE_ID';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   RQCFG_273_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_273_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
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
AND     external_root_id = 273
)
);
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_273_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 273, 4);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_273_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_273_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_273_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_273_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_273_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273))));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273)));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 273, 4);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_273_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273))));
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273))));
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273))));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273)));

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_273_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_273_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_273_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_273_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_273_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_273_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273));
nuIndex binary_integer;
BEGIN

if (not RQCFG_273_.blProcessStatus) then
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 273;

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb0_0(0):=7619;
RQCFG_273_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_273_.tb0_0(0):=RQCFG_273_.tb0_0(0);
RQCFG_273_.old_tb0_2(0):=2012;
RQCFG_273_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_273_.tb0_0(0),
273,
RQCFG_273_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb1_0(0):=1038055;
RQCFG_273_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_273_.tb1_0(0):=RQCFG_273_.tb1_0(0);
RQCFG_273_.old_tb1_1(0):=273;
RQCFG_273_.tb1_1(0):=RQCFG_273_.old_tb1_1(0);
RQCFG_273_.old_tb1_2(0):=2012;
RQCFG_273_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb1_2(0),-1)));
RQCFG_273_.old_tb1_3(0):=7619;
RQCFG_273_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb1_2(0),-1))), RQCFG_273_.old_tb1_1(0), 4);
RQCFG_273_.tb1_3(0):=RQCFG_273_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_273_.tb1_0(0),
RQCFG_273_.tb1_1(0),
RQCFG_273_.tb1_2(0),
RQCFG_273_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb2_0(0):=100022889;
RQCFG_273_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_273_.tb2_0(0):=RQCFG_273_.tb2_0(0);
RQCFG_273_.tb2_1(0):=RQCFG_273_.tb0_0(0);
RQCFG_273_.tb2_2(0):=RQCFG_273_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_273_.tb2_0(0),
RQCFG_273_.tb2_1(0),
RQCFG_273_.tb2_2(0),
null,
6121,
1,
1,
1);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb1_0(1):=1038056;
RQCFG_273_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_273_.tb1_0(1):=RQCFG_273_.tb1_0(1);
RQCFG_273_.old_tb1_1(1):=82;
RQCFG_273_.tb1_1(1):=RQCFG_273_.old_tb1_1(1);
RQCFG_273_.old_tb1_2(1):=2013;
RQCFG_273_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb1_2(1),-1)));
RQCFG_273_.old_tb1_3(1):=null;
RQCFG_273_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb1_2(1),-1))), RQCFG_273_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_273_.tb1_0(1),
RQCFG_273_.tb1_1(1),
RQCFG_273_.tb1_2(1),
RQCFG_273_.tb1_3(1),
null,
'M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
,
1,
9999,
4);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb2_0(1):=100022890;
RQCFG_273_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_273_.tb2_0(1):=RQCFG_273_.tb2_0(1);
RQCFG_273_.tb2_1(1):=RQCFG_273_.tb0_0(0);
RQCFG_273_.tb2_2(1):=RQCFG_273_.tb1_0(1);
RQCFG_273_.tb2_3(1):=RQCFG_273_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_273_.tb2_0(1),
RQCFG_273_.tb2_1(1),
RQCFG_273_.tb2_2(1),
RQCFG_273_.tb2_3(1),
6121,
2,
1,
9999);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(0):=1083104;
RQCFG_273_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(0):=RQCFG_273_.tb3_0(0);
RQCFG_273_.old_tb3_1(0):=3334;
RQCFG_273_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(0),-1)));
RQCFG_273_.old_tb3_2(0):=189;
RQCFG_273_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(0),-1)));
RQCFG_273_.old_tb3_3(0):=257;
RQCFG_273_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(0),-1)));
RQCFG_273_.old_tb3_4(0):=null;
RQCFG_273_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(0),-1)));
RQCFG_273_.tb3_5(0):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(0):=null;
RQCFG_273_.tb3_6(0):=NULL;
RQCFG_273_.old_tb3_7(0):=null;
RQCFG_273_.tb3_7(0):=NULL;
RQCFG_273_.old_tb3_8(0):=null;
RQCFG_273_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(0),
RQCFG_273_.tb3_1(0),
RQCFG_273_.tb3_2(0),
RQCFG_273_.tb3_3(0),
RQCFG_273_.tb3_4(0),
RQCFG_273_.tb3_5(0),
RQCFG_273_.tb3_6(0),
RQCFG_273_.tb3_7(0),
RQCFG_273_.tb3_8(0),
null,
1772,
3,
'Solicitud atención al cliente'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb4_0(0):=97169;
RQCFG_273_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_273_.tb4_0(0):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb4_1(0):=RQCFG_273_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_273_.tb4_0(0),
RQCFG_273_.tb4_1(0),
null,
null,
'FRAME-M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82-1030808'
,
2);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(0):=1288717;
RQCFG_273_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(0):=RQCFG_273_.tb5_0(0);
RQCFG_273_.old_tb5_1(0):=189;
RQCFG_273_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(0),-1)));
RQCFG_273_.old_tb5_2(0):=null;
RQCFG_273_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(0),-1)));
RQCFG_273_.tb5_3(0):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(0):=RQCFG_273_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(0),
RQCFG_273_.tb5_1(0),
RQCFG_273_.tb5_2(0),
RQCFG_273_.tb5_3(0),
RQCFG_273_.tb5_4(0),
'C'
,
'Y'
,
3,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(1):=1083105;
RQCFG_273_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(1):=RQCFG_273_.tb3_0(1);
RQCFG_273_.old_tb3_1(1):=3334;
RQCFG_273_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(1),-1)));
RQCFG_273_.old_tb3_2(1):=191;
RQCFG_273_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(1),-1)));
RQCFG_273_.old_tb3_3(1):=null;
RQCFG_273_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(1),-1)));
RQCFG_273_.old_tb3_4(1):=null;
RQCFG_273_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(1),-1)));
RQCFG_273_.tb3_5(1):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(1):=null;
RQCFG_273_.tb3_6(1):=NULL;
RQCFG_273_.old_tb3_7(1):=null;
RQCFG_273_.tb3_7(1):=NULL;
RQCFG_273_.old_tb3_8(1):=null;
RQCFG_273_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(1),
RQCFG_273_.tb3_1(1),
RQCFG_273_.tb3_2(1),
RQCFG_273_.tb3_3(1),
RQCFG_273_.tb3_4(1),
RQCFG_273_.tb3_5(1),
RQCFG_273_.tb3_6(1),
RQCFG_273_.tb3_7(1),
RQCFG_273_.tb3_8(1),
null,
1773,
4,
'Tipo'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(1):=1288718;
RQCFG_273_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(1):=RQCFG_273_.tb5_0(1);
RQCFG_273_.old_tb5_1(1):=191;
RQCFG_273_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(1),-1)));
RQCFG_273_.old_tb5_2(1):=null;
RQCFG_273_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(1),-1)));
RQCFG_273_.tb5_3(1):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(1):=RQCFG_273_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(1),
RQCFG_273_.tb5_1(1),
RQCFG_273_.tb5_2(1),
RQCFG_273_.tb5_3(1),
RQCFG_273_.tb5_4(1),
'C'
,
'Y'
,
4,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(2):=1083106;
RQCFG_273_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(2):=RQCFG_273_.tb3_0(2);
RQCFG_273_.old_tb3_1(2):=3334;
RQCFG_273_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(2),-1)));
RQCFG_273_.old_tb3_2(2):=524;
RQCFG_273_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(2),-1)));
RQCFG_273_.old_tb3_3(2):=null;
RQCFG_273_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(2),-1)));
RQCFG_273_.old_tb3_4(2):=null;
RQCFG_273_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(2),-1)));
RQCFG_273_.tb3_5(2):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(2):=121057267;
RQCFG_273_.tb3_6(2):=NULL;
RQCFG_273_.old_tb3_7(2):=null;
RQCFG_273_.tb3_7(2):=NULL;
RQCFG_273_.old_tb3_8(2):=null;
RQCFG_273_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(2),
RQCFG_273_.tb3_1(2),
RQCFG_273_.tb3_2(2),
RQCFG_273_.tb3_3(2),
RQCFG_273_.tb3_4(2),
RQCFG_273_.tb3_5(2),
RQCFG_273_.tb3_6(2),
RQCFG_273_.tb3_7(2),
RQCFG_273_.tb3_8(2),
null,
1774,
5,
'Estado'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(2):=1288719;
RQCFG_273_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(2):=RQCFG_273_.tb5_0(2);
RQCFG_273_.old_tb5_1(2):=524;
RQCFG_273_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(2),-1)));
RQCFG_273_.old_tb5_2(2):=null;
RQCFG_273_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(2),-1)));
RQCFG_273_.tb5_3(2):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(2):=RQCFG_273_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(2),
RQCFG_273_.tb5_1(2),
RQCFG_273_.tb5_2(2),
RQCFG_273_.tb5_3(2),
RQCFG_273_.tb5_4(2),
'C'
,
'Y'
,
5,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(3):=1083107;
RQCFG_273_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(3):=RQCFG_273_.tb3_0(3);
RQCFG_273_.old_tb3_1(3):=3334;
RQCFG_273_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(3),-1)));
RQCFG_273_.old_tb3_2(3):=697;
RQCFG_273_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(3),-1)));
RQCFG_273_.old_tb3_3(3):=null;
RQCFG_273_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(3),-1)));
RQCFG_273_.old_tb3_4(3):=null;
RQCFG_273_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(3),-1)));
RQCFG_273_.tb3_5(3):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(3):=null;
RQCFG_273_.tb3_6(3):=NULL;
RQCFG_273_.old_tb3_7(3):=null;
RQCFG_273_.tb3_7(3):=NULL;
RQCFG_273_.old_tb3_8(3):=null;
RQCFG_273_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(3),
RQCFG_273_.tb3_1(3),
RQCFG_273_.tb3_2(3),
RQCFG_273_.tb3_3(3),
RQCFG_273_.tb3_4(3),
RQCFG_273_.tb3_5(3),
RQCFG_273_.tb3_6(3),
RQCFG_273_.tb3_7(3),
RQCFG_273_.tb3_8(3),
null,
1775,
6,
'Producto motivo'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(3):=1288720;
RQCFG_273_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(3):=RQCFG_273_.tb5_0(3);
RQCFG_273_.old_tb5_1(3):=697;
RQCFG_273_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(3),-1)));
RQCFG_273_.old_tb5_2(3):=null;
RQCFG_273_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(3),-1)));
RQCFG_273_.tb5_3(3):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(3):=RQCFG_273_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(3),
RQCFG_273_.tb5_1(3),
RQCFG_273_.tb5_2(3),
RQCFG_273_.tb5_3(3),
RQCFG_273_.tb5_4(3),
'C'
,
'Y'
,
6,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(4):=1083108;
RQCFG_273_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(4):=RQCFG_273_.tb3_0(4);
RQCFG_273_.old_tb3_1(4):=3334;
RQCFG_273_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(4),-1)));
RQCFG_273_.old_tb3_2(4):=36570;
RQCFG_273_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(4),-1)));
RQCFG_273_.old_tb3_3(4):=null;
RQCFG_273_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(4),-1)));
RQCFG_273_.old_tb3_4(4):=null;
RQCFG_273_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(4),-1)));
RQCFG_273_.tb3_5(4):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(4):=null;
RQCFG_273_.tb3_6(4):=NULL;
RQCFG_273_.old_tb3_7(4):=null;
RQCFG_273_.tb3_7(4):=NULL;
RQCFG_273_.old_tb3_8(4):=null;
RQCFG_273_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(4),
RQCFG_273_.tb3_1(4),
RQCFG_273_.tb3_2(4),
RQCFG_273_.tb3_3(4),
RQCFG_273_.tb3_4(4),
RQCFG_273_.tb3_5(4),
RQCFG_273_.tb3_6(4),
RQCFG_273_.tb3_7(4),
RQCFG_273_.tb3_8(4),
null,
1776,
7,
'Etiqueta XML'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(4):=1288721;
RQCFG_273_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(4):=RQCFG_273_.tb5_0(4);
RQCFG_273_.old_tb5_1(4):=36570;
RQCFG_273_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(4),-1)));
RQCFG_273_.old_tb5_2(4):=null;
RQCFG_273_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(4),-1)));
RQCFG_273_.tb5_3(4):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(4):=RQCFG_273_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(4),
RQCFG_273_.tb5_1(4),
RQCFG_273_.tb5_2(4),
RQCFG_273_.tb5_3(4),
RQCFG_273_.tb5_4(4),
'C'
,
'Y'
,
7,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(5):=1083109;
RQCFG_273_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(5):=RQCFG_273_.tb3_0(5);
RQCFG_273_.old_tb3_1(5):=3334;
RQCFG_273_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(5),-1)));
RQCFG_273_.old_tb3_2(5):=413;
RQCFG_273_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(5),-1)));
RQCFG_273_.old_tb3_3(5):=null;
RQCFG_273_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(5),-1)));
RQCFG_273_.old_tb3_4(5):=null;
RQCFG_273_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(5),-1)));
RQCFG_273_.tb3_5(5):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(5):=null;
RQCFG_273_.tb3_6(5):=NULL;
RQCFG_273_.old_tb3_7(5):=121057268;
RQCFG_273_.tb3_7(5):=NULL;
RQCFG_273_.old_tb3_8(5):=120029895;
RQCFG_273_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(5),
RQCFG_273_.tb3_1(5),
RQCFG_273_.tb3_2(5),
RQCFG_273_.tb3_3(5),
RQCFG_273_.tb3_4(5),
RQCFG_273_.tb3_5(5),
RQCFG_273_.tb3_6(5),
RQCFG_273_.tb3_7(5),
RQCFG_273_.tb3_8(5),
null,
1777,
8,
'Producto'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(5):=1288722;
RQCFG_273_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(5):=RQCFG_273_.tb5_0(5);
RQCFG_273_.old_tb5_1(5):=413;
RQCFG_273_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(5),-1)));
RQCFG_273_.old_tb5_2(5):=null;
RQCFG_273_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(5),-1)));
RQCFG_273_.tb5_3(5):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(5):=RQCFG_273_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(5),
RQCFG_273_.tb5_1(5),
RQCFG_273_.tb5_2(5),
RQCFG_273_.tb5_3(5),
RQCFG_273_.tb5_4(5),
'Y'
,
'Y'
,
8,
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
4,
null,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(6):=1083110;
RQCFG_273_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(6):=RQCFG_273_.tb3_0(6);
RQCFG_273_.old_tb3_1(6):=3334;
RQCFG_273_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(6),-1)));
RQCFG_273_.old_tb3_2(6):=11403;
RQCFG_273_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(6),-1)));
RQCFG_273_.old_tb3_3(6):=null;
RQCFG_273_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(6),-1)));
RQCFG_273_.old_tb3_4(6):=null;
RQCFG_273_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(6),-1)));
RQCFG_273_.tb3_5(6):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(6):=121057269;
RQCFG_273_.tb3_6(6):=NULL;
RQCFG_273_.old_tb3_7(6):=null;
RQCFG_273_.tb3_7(6):=NULL;
RQCFG_273_.old_tb3_8(6):=null;
RQCFG_273_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(6),
RQCFG_273_.tb3_1(6),
RQCFG_273_.tb3_2(6),
RQCFG_273_.tb3_3(6),
RQCFG_273_.tb3_4(6),
RQCFG_273_.tb3_5(6),
RQCFG_273_.tb3_6(6),
RQCFG_273_.tb3_7(6),
RQCFG_273_.tb3_8(6),
null,
1778,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(6):=1288723;
RQCFG_273_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(6):=RQCFG_273_.tb5_0(6);
RQCFG_273_.old_tb5_1(6):=11403;
RQCFG_273_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(6),-1)));
RQCFG_273_.old_tb5_2(6):=null;
RQCFG_273_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(6),-1)));
RQCFG_273_.tb5_3(6):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(6):=RQCFG_273_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(6),
RQCFG_273_.tb5_1(6),
RQCFG_273_.tb5_2(6),
RQCFG_273_.tb5_3(6),
RQCFG_273_.tb5_4(6),
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(7):=1083111;
RQCFG_273_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(7):=RQCFG_273_.tb3_0(7);
RQCFG_273_.old_tb3_1(7):=3334;
RQCFG_273_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(7),-1)));
RQCFG_273_.old_tb3_2(7):=50000604;
RQCFG_273_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(7),-1)));
RQCFG_273_.old_tb3_3(7):=187;
RQCFG_273_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(7),-1)));
RQCFG_273_.old_tb3_4(7):=null;
RQCFG_273_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(7),-1)));
RQCFG_273_.tb3_5(7):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(7):=null;
RQCFG_273_.tb3_6(7):=NULL;
RQCFG_273_.old_tb3_7(7):=null;
RQCFG_273_.tb3_7(7):=NULL;
RQCFG_273_.old_tb3_8(7):=null;
RQCFG_273_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(7),
RQCFG_273_.tb3_1(7),
RQCFG_273_.tb3_2(7),
RQCFG_273_.tb3_3(7),
RQCFG_273_.tb3_4(7),
RQCFG_273_.tb3_5(7),
RQCFG_273_.tb3_6(7),
RQCFG_273_.tb3_7(7),
RQCFG_273_.tb3_8(7),
null,
1779,
11,
'Identificador del Motivo'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(7):=1288724;
RQCFG_273_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(7):=RQCFG_273_.tb5_0(7);
RQCFG_273_.old_tb5_1(7):=50000604;
RQCFG_273_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(7),-1)));
RQCFG_273_.old_tb5_2(7):=null;
RQCFG_273_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(7),-1)));
RQCFG_273_.tb5_3(7):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(7):=RQCFG_273_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(7),
RQCFG_273_.tb5_1(7),
RQCFG_273_.tb5_2(7),
RQCFG_273_.tb5_3(7),
RQCFG_273_.tb5_4(7),
'C'
,
'Y'
,
11,
'Y'
,
'Identificador del Motivo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(8):=1083112;
RQCFG_273_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(8):=RQCFG_273_.tb3_0(8);
RQCFG_273_.old_tb3_1(8):=3334;
RQCFG_273_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(8),-1)));
RQCFG_273_.old_tb3_2(8):=39387;
RQCFG_273_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(8),-1)));
RQCFG_273_.old_tb3_3(8):=255;
RQCFG_273_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(8),-1)));
RQCFG_273_.old_tb3_4(8):=null;
RQCFG_273_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(8),-1)));
RQCFG_273_.tb3_5(8):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(8):=null;
RQCFG_273_.tb3_6(8):=NULL;
RQCFG_273_.old_tb3_7(8):=null;
RQCFG_273_.tb3_7(8):=NULL;
RQCFG_273_.old_tb3_8(8):=null;
RQCFG_273_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(8),
RQCFG_273_.tb3_1(8),
RQCFG_273_.tb3_2(8),
RQCFG_273_.tb3_3(8),
RQCFG_273_.tb3_4(8),
RQCFG_273_.tb3_5(8),
RQCFG_273_.tb3_6(8),
RQCFG_273_.tb3_7(8),
RQCFG_273_.tb3_8(8),
null,
1780,
12,
'Identificador De Solicitud'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(8):=1288725;
RQCFG_273_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(8):=RQCFG_273_.tb5_0(8);
RQCFG_273_.old_tb5_1(8):=39387;
RQCFG_273_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(8),-1)));
RQCFG_273_.old_tb5_2(8):=null;
RQCFG_273_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(8),-1)));
RQCFG_273_.tb5_3(8):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(8):=RQCFG_273_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(8),
RQCFG_273_.tb5_1(8),
RQCFG_273_.tb5_2(8),
RQCFG_273_.tb5_3(8),
RQCFG_273_.tb5_4(8),
'C'
,
'Y'
,
12,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(9):=1083113;
RQCFG_273_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(9):=RQCFG_273_.tb3_0(9);
RQCFG_273_.old_tb3_1(9):=3334;
RQCFG_273_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(9),-1)));
RQCFG_273_.old_tb3_2(9):=149340;
RQCFG_273_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(9),-1)));
RQCFG_273_.old_tb3_3(9):=2558;
RQCFG_273_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(9),-1)));
RQCFG_273_.old_tb3_4(9):=null;
RQCFG_273_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(9),-1)));
RQCFG_273_.tb3_5(9):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(9):=null;
RQCFG_273_.tb3_6(9):=NULL;
RQCFG_273_.old_tb3_7(9):=null;
RQCFG_273_.tb3_7(9):=NULL;
RQCFG_273_.old_tb3_8(9):=null;
RQCFG_273_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(9),
RQCFG_273_.tb3_1(9),
RQCFG_273_.tb3_2(9),
RQCFG_273_.tb3_3(9),
RQCFG_273_.tb3_4(9),
RQCFG_273_.tb3_5(9),
RQCFG_273_.tb3_6(9),
RQCFG_273_.tb3_7(9),
RQCFG_273_.tb3_8(9),
null,
1781,
13,
'Identificador Del Rol.'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(9):=1288726;
RQCFG_273_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(9):=RQCFG_273_.tb5_0(9);
RQCFG_273_.old_tb5_1(9):=149340;
RQCFG_273_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(9),-1)));
RQCFG_273_.old_tb5_2(9):=null;
RQCFG_273_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(9),-1)));
RQCFG_273_.tb5_3(9):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(9):=RQCFG_273_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(9),
RQCFG_273_.tb5_1(9),
RQCFG_273_.tb5_2(9),
RQCFG_273_.tb5_3(9),
RQCFG_273_.tb5_4(9),
'C'
,
'Y'
,
13,
'Y'
,
'Identificador Del Rol.'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(10):=1083114;
RQCFG_273_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(10):=RQCFG_273_.tb3_0(10);
RQCFG_273_.old_tb3_1(10):=3334;
RQCFG_273_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(10),-1)));
RQCFG_273_.old_tb3_2(10):=50000606;
RQCFG_273_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(10),-1)));
RQCFG_273_.old_tb3_3(10):=4015;
RQCFG_273_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(10),-1)));
RQCFG_273_.old_tb3_4(10):=null;
RQCFG_273_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(10),-1)));
RQCFG_273_.tb3_5(10):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(10):=null;
RQCFG_273_.tb3_6(10):=NULL;
RQCFG_273_.old_tb3_7(10):=null;
RQCFG_273_.tb3_7(10):=NULL;
RQCFG_273_.old_tb3_8(10):=null;
RQCFG_273_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(10),
RQCFG_273_.tb3_1(10),
RQCFG_273_.tb3_2(10),
RQCFG_273_.tb3_3(10),
RQCFG_273_.tb3_4(10),
RQCFG_273_.tb3_5(10),
RQCFG_273_.tb3_6(10),
RQCFG_273_.tb3_7(10),
RQCFG_273_.tb3_8(10),
null,
1782,
14,
'Usuario del Servicio'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(10):=1288727;
RQCFG_273_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(10):=RQCFG_273_.tb5_0(10);
RQCFG_273_.old_tb5_1(10):=50000606;
RQCFG_273_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(10),-1)));
RQCFG_273_.old_tb5_2(10):=null;
RQCFG_273_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(10),-1)));
RQCFG_273_.tb5_3(10):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(10):=RQCFG_273_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(10),
RQCFG_273_.tb5_1(10),
RQCFG_273_.tb5_2(10),
RQCFG_273_.tb5_3(10),
RQCFG_273_.tb5_4(10),
'C'
,
'Y'
,
14,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(11):=1083115;
RQCFG_273_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(11):=RQCFG_273_.tb3_0(11);
RQCFG_273_.old_tb3_1(11):=3334;
RQCFG_273_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(11),-1)));
RQCFG_273_.old_tb3_2(11):=50000603;
RQCFG_273_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(11),-1)));
RQCFG_273_.old_tb3_3(11):=null;
RQCFG_273_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(11),-1)));
RQCFG_273_.old_tb3_4(11):=null;
RQCFG_273_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(11),-1)));
RQCFG_273_.tb3_5(11):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(11):=121057265;
RQCFG_273_.tb3_6(11):=NULL;
RQCFG_273_.old_tb3_7(11):=null;
RQCFG_273_.tb3_7(11):=NULL;
RQCFG_273_.old_tb3_8(11):=null;
RQCFG_273_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(11),
RQCFG_273_.tb3_1(11),
RQCFG_273_.tb3_2(11),
RQCFG_273_.tb3_3(11),
RQCFG_273_.tb3_4(11),
RQCFG_273_.tb3_5(11),
RQCFG_273_.tb3_6(11),
RQCFG_273_.tb3_7(11),
RQCFG_273_.tb3_8(11),
null,
1783,
15,
'Identificador de suscriptor por motivo'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(11):=1288728;
RQCFG_273_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(11):=RQCFG_273_.tb5_0(11);
RQCFG_273_.old_tb5_1(11):=50000603;
RQCFG_273_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(11),-1)));
RQCFG_273_.old_tb5_2(11):=null;
RQCFG_273_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(11),-1)));
RQCFG_273_.tb5_3(11):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(11):=RQCFG_273_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(11),
RQCFG_273_.tb5_1(11),
RQCFG_273_.tb5_2(11),
RQCFG_273_.tb5_3(11),
RQCFG_273_.tb5_4(11),
'C'
,
'Y'
,
15,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(12):=1083116;
RQCFG_273_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(12):=RQCFG_273_.tb3_0(12);
RQCFG_273_.old_tb3_1(12):=3334;
RQCFG_273_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(12),-1)));
RQCFG_273_.old_tb3_2(12):=201;
RQCFG_273_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(12),-1)));
RQCFG_273_.old_tb3_3(12):=20367;
RQCFG_273_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(12),-1)));
RQCFG_273_.old_tb3_4(12):=null;
RQCFG_273_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(12),-1)));
RQCFG_273_.tb3_5(12):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(12):=null;
RQCFG_273_.tb3_6(12):=NULL;
RQCFG_273_.old_tb3_7(12):=null;
RQCFG_273_.tb3_7(12):=NULL;
RQCFG_273_.old_tb3_8(12):=null;
RQCFG_273_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(12),
RQCFG_273_.tb3_1(12),
RQCFG_273_.tb3_2(12),
RQCFG_273_.tb3_3(12),
RQCFG_273_.tb3_4(12),
RQCFG_273_.tb3_5(12),
RQCFG_273_.tb3_6(12),
RQCFG_273_.tb3_7(12),
RQCFG_273_.tb3_8(12),
null,
1784,
16,
'Fecha inicial provisionalidad'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(12):=1288729;
RQCFG_273_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(12):=RQCFG_273_.tb5_0(12);
RQCFG_273_.old_tb5_1(12):=201;
RQCFG_273_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(12),-1)));
RQCFG_273_.old_tb5_2(12):=null;
RQCFG_273_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(12),-1)));
RQCFG_273_.tb5_3(12):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(12):=RQCFG_273_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(12),
RQCFG_273_.tb5_1(12),
RQCFG_273_.tb5_2(12),
RQCFG_273_.tb5_3(12),
RQCFG_273_.tb5_4(12),
'C'
,
'Y'
,
16,
'Y'
,
'Fecha inicial provisionalidad'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(13):=1083117;
RQCFG_273_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(13):=RQCFG_273_.tb3_0(13);
RQCFG_273_.old_tb3_1(13):=3334;
RQCFG_273_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(13),-1)));
RQCFG_273_.old_tb3_2(13):=202;
RQCFG_273_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(13),-1)));
RQCFG_273_.old_tb3_3(13):=20368;
RQCFG_273_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(13),-1)));
RQCFG_273_.old_tb3_4(13):=null;
RQCFG_273_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(13),-1)));
RQCFG_273_.tb3_5(13):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(13):=null;
RQCFG_273_.tb3_6(13):=NULL;
RQCFG_273_.old_tb3_7(13):=null;
RQCFG_273_.tb3_7(13):=NULL;
RQCFG_273_.old_tb3_8(13):=null;
RQCFG_273_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(13),
RQCFG_273_.tb3_1(13),
RQCFG_273_.tb3_2(13),
RQCFG_273_.tb3_3(13),
RQCFG_273_.tb3_4(13),
RQCFG_273_.tb3_5(13),
RQCFG_273_.tb3_6(13),
RQCFG_273_.tb3_7(13),
RQCFG_273_.tb3_8(13),
null,
1785,
17,
'Fecha final provisionalidad'
,
'N'
,
'C'
,
'Y'
,
17,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(13):=1288730;
RQCFG_273_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(13):=RQCFG_273_.tb5_0(13);
RQCFG_273_.old_tb5_1(13):=202;
RQCFG_273_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(13),-1)));
RQCFG_273_.old_tb5_2(13):=null;
RQCFG_273_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(13),-1)));
RQCFG_273_.tb5_3(13):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(13):=RQCFG_273_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(13),
RQCFG_273_.tb5_1(13),
RQCFG_273_.tb5_2(13),
RQCFG_273_.tb5_3(13),
RQCFG_273_.tb5_4(13),
'C'
,
'Y'
,
17,
'Y'
,
'Fecha final provisionalidad'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(14):=1083118;
RQCFG_273_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(14):=RQCFG_273_.tb3_0(14);
RQCFG_273_.old_tb3_1(14):=3334;
RQCFG_273_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(14),-1)));
RQCFG_273_.old_tb3_2(14):=192;
RQCFG_273_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(14),-1)));
RQCFG_273_.old_tb3_3(14):=null;
RQCFG_273_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(14),-1)));
RQCFG_273_.old_tb3_4(14):=null;
RQCFG_273_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(14),-1)));
RQCFG_273_.tb3_5(14):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(14):=null;
RQCFG_273_.tb3_6(14):=NULL;
RQCFG_273_.old_tb3_7(14):=null;
RQCFG_273_.tb3_7(14):=NULL;
RQCFG_273_.old_tb3_8(14):=null;
RQCFG_273_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(14),
RQCFG_273_.tb3_1(14),
RQCFG_273_.tb3_2(14),
RQCFG_273_.tb3_3(14),
RQCFG_273_.tb3_4(14),
RQCFG_273_.tb3_5(14),
RQCFG_273_.tb3_6(14),
RQCFG_273_.tb3_7(14),
RQCFG_273_.tb3_8(14),
null,
2201,
9,
'Tipo de producto'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(14):=1288731;
RQCFG_273_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(14):=RQCFG_273_.tb5_0(14);
RQCFG_273_.old_tb5_1(14):=192;
RQCFG_273_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(14),-1)));
RQCFG_273_.old_tb5_2(14):=null;
RQCFG_273_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(14),-1)));
RQCFG_273_.tb5_3(14):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(14):=RQCFG_273_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(14),
RQCFG_273_.tb5_1(14),
RQCFG_273_.tb5_2(14),
RQCFG_273_.tb5_3(14),
RQCFG_273_.tb5_4(14),
'C'
,
'Y'
,
9,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(15):=1083119;
RQCFG_273_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(15):=RQCFG_273_.tb3_0(15);
RQCFG_273_.old_tb3_1(15):=3334;
RQCFG_273_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(15),-1)));
RQCFG_273_.old_tb3_2(15):=187;
RQCFG_273_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(15),-1)));
RQCFG_273_.old_tb3_3(15):=null;
RQCFG_273_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(15),-1)));
RQCFG_273_.old_tb3_4(15):=null;
RQCFG_273_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(15),-1)));
RQCFG_273_.tb3_5(15):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(15):=121057266;
RQCFG_273_.tb3_6(15):=NULL;
RQCFG_273_.old_tb3_7(15):=null;
RQCFG_273_.tb3_7(15):=NULL;
RQCFG_273_.old_tb3_8(15):=null;
RQCFG_273_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(15),
RQCFG_273_.tb3_1(15),
RQCFG_273_.tb3_2(15),
RQCFG_273_.tb3_3(15),
RQCFG_273_.tb3_4(15),
RQCFG_273_.tb3_5(15),
RQCFG_273_.tb3_6(15),
RQCFG_273_.tb3_7(15),
RQCFG_273_.tb3_8(15),
null,
1768,
0,
'Código'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(15):=1288732;
RQCFG_273_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(15):=RQCFG_273_.tb5_0(15);
RQCFG_273_.old_tb5_1(15):=187;
RQCFG_273_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(15),-1)));
RQCFG_273_.old_tb5_2(15):=null;
RQCFG_273_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(15),-1)));
RQCFG_273_.tb5_3(15):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(15):=RQCFG_273_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(15),
RQCFG_273_.tb5_1(15),
RQCFG_273_.tb5_2(15),
RQCFG_273_.tb5_3(15),
RQCFG_273_.tb5_4(15),
'C'
,
'Y'
,
0,
'Y'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(16):=1083120;
RQCFG_273_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(16):=RQCFG_273_.tb3_0(16);
RQCFG_273_.old_tb3_1(16):=3334;
RQCFG_273_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(16),-1)));
RQCFG_273_.old_tb3_2(16):=204;
RQCFG_273_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(16),-1)));
RQCFG_273_.old_tb3_3(16):=258;
RQCFG_273_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(16),-1)));
RQCFG_273_.old_tb3_4(16):=null;
RQCFG_273_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(16),-1)));
RQCFG_273_.tb3_5(16):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(16):=null;
RQCFG_273_.tb3_6(16):=NULL;
RQCFG_273_.old_tb3_7(16):=null;
RQCFG_273_.tb3_7(16):=NULL;
RQCFG_273_.old_tb3_8(16):=null;
RQCFG_273_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(16),
RQCFG_273_.tb3_1(16),
RQCFG_273_.tb3_2(16),
RQCFG_273_.tb3_3(16),
RQCFG_273_.tb3_4(16),
RQCFG_273_.tb3_5(16),
RQCFG_273_.tb3_6(16),
RQCFG_273_.tb3_7(16),
RQCFG_273_.tb3_8(16),
null,
1770,
1,
'Fecha registro'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(16):=1288733;
RQCFG_273_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(16):=RQCFG_273_.tb5_0(16);
RQCFG_273_.old_tb5_1(16):=204;
RQCFG_273_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(16),-1)));
RQCFG_273_.old_tb5_2(16):=null;
RQCFG_273_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(16),-1)));
RQCFG_273_.tb5_3(16):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(16):=RQCFG_273_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(16),
RQCFG_273_.tb5_1(16),
RQCFG_273_.tb5_2(16),
RQCFG_273_.tb5_3(16),
RQCFG_273_.tb5_4(16),
'C'
,
'Y'
,
1,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(17):=1083121;
RQCFG_273_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(17):=RQCFG_273_.tb3_0(17);
RQCFG_273_.old_tb3_1(17):=3334;
RQCFG_273_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(17),-1)));
RQCFG_273_.old_tb3_2(17):=213;
RQCFG_273_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(17),-1)));
RQCFG_273_.old_tb3_3(17):=255;
RQCFG_273_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(17),-1)));
RQCFG_273_.old_tb3_4(17):=null;
RQCFG_273_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(17),-1)));
RQCFG_273_.tb3_5(17):=RQCFG_273_.tb2_2(1);
RQCFG_273_.old_tb3_6(17):=null;
RQCFG_273_.tb3_6(17):=NULL;
RQCFG_273_.old_tb3_7(17):=null;
RQCFG_273_.tb3_7(17):=NULL;
RQCFG_273_.old_tb3_8(17):=null;
RQCFG_273_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(17),
RQCFG_273_.tb3_1(17),
RQCFG_273_.tb3_2(17),
RQCFG_273_.tb3_3(17),
RQCFG_273_.tb3_4(17),
RQCFG_273_.tb3_5(17),
RQCFG_273_.tb3_6(17),
RQCFG_273_.tb3_7(17),
RQCFG_273_.tb3_8(17),
null,
1771,
2,
'Solicitud'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(17):=1288734;
RQCFG_273_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(17):=RQCFG_273_.tb5_0(17);
RQCFG_273_.old_tb5_1(17):=213;
RQCFG_273_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(17),-1)));
RQCFG_273_.old_tb5_2(17):=null;
RQCFG_273_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(17),-1)));
RQCFG_273_.tb5_3(17):=RQCFG_273_.tb4_0(0);
RQCFG_273_.tb5_4(17):=RQCFG_273_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(17),
RQCFG_273_.tb5_1(17),
RQCFG_273_.tb5_2(17),
RQCFG_273_.tb5_3(17),
RQCFG_273_.tb5_4(17),
'C'
,
'Y'
,
2,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(18):=1083122;
RQCFG_273_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(18):=RQCFG_273_.tb3_0(18);
RQCFG_273_.old_tb3_1(18):=2036;
RQCFG_273_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(18),-1)));
RQCFG_273_.old_tb3_2(18):=257;
RQCFG_273_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(18),-1)));
RQCFG_273_.old_tb3_3(18):=null;
RQCFG_273_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(18),-1)));
RQCFG_273_.old_tb3_4(18):=null;
RQCFG_273_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(18),-1)));
RQCFG_273_.tb3_5(18):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(18):=121057253;
RQCFG_273_.tb3_6(18):=NULL;
RQCFG_273_.old_tb3_7(18):=null;
RQCFG_273_.tb3_7(18):=NULL;
RQCFG_273_.old_tb3_8(18):=null;
RQCFG_273_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(18),
RQCFG_273_.tb3_1(18),
RQCFG_273_.tb3_2(18),
RQCFG_273_.tb3_3(18),
RQCFG_273_.tb3_4(18),
RQCFG_273_.tb3_5(18),
RQCFG_273_.tb3_6(18),
RQCFG_273_.tb3_7(18),
RQCFG_273_.tb3_8(18),
null,
1625,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb4_0(1):=97170;
RQCFG_273_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_273_.tb4_0(1):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb4_1(1):=RQCFG_273_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_273_.tb4_0(1),
RQCFG_273_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1030807'
,
1);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(18):=1288735;
RQCFG_273_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(18):=RQCFG_273_.tb5_0(18);
RQCFG_273_.old_tb5_1(18):=257;
RQCFG_273_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(18),-1)));
RQCFG_273_.old_tb5_2(18):=null;
RQCFG_273_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(18),-1)));
RQCFG_273_.tb5_3(18):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(18):=RQCFG_273_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(18),
RQCFG_273_.tb5_1(18),
RQCFG_273_.tb5_2(18),
RQCFG_273_.tb5_3(18),
RQCFG_273_.tb5_4(18),
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(19):=1083123;
RQCFG_273_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(19):=RQCFG_273_.tb3_0(19);
RQCFG_273_.old_tb3_1(19):=2036;
RQCFG_273_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(19),-1)));
RQCFG_273_.old_tb3_2(19):=269;
RQCFG_273_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(19),-1)));
RQCFG_273_.old_tb3_3(19):=null;
RQCFG_273_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(19),-1)));
RQCFG_273_.old_tb3_4(19):=null;
RQCFG_273_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(19),-1)));
RQCFG_273_.tb3_5(19):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(19):=null;
RQCFG_273_.tb3_6(19):=NULL;
RQCFG_273_.old_tb3_7(19):=null;
RQCFG_273_.tb3_7(19):=NULL;
RQCFG_273_.old_tb3_8(19):=null;
RQCFG_273_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(19),
RQCFG_273_.tb3_1(19),
RQCFG_273_.tb3_2(19),
RQCFG_273_.tb3_3(19),
RQCFG_273_.tb3_4(19),
RQCFG_273_.tb3_5(19),
RQCFG_273_.tb3_6(19),
RQCFG_273_.tb3_7(19),
RQCFG_273_.tb3_8(19),
null,
1626,
2,
'Tipo paquete'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(19):=1288736;
RQCFG_273_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(19):=RQCFG_273_.tb5_0(19);
RQCFG_273_.old_tb5_1(19):=269;
RQCFG_273_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(19),-1)));
RQCFG_273_.old_tb5_2(19):=null;
RQCFG_273_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(19),-1)));
RQCFG_273_.tb5_3(19):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(19):=RQCFG_273_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(19),
RQCFG_273_.tb5_1(19),
RQCFG_273_.tb5_2(19),
RQCFG_273_.tb5_3(19),
RQCFG_273_.tb5_4(19),
'C'
,
'Y'
,
2,
'Y'
,
'Tipo paquete'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(20):=1083124;
RQCFG_273_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(20):=RQCFG_273_.tb3_0(20);
RQCFG_273_.old_tb3_1(20):=2036;
RQCFG_273_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(20),-1)));
RQCFG_273_.old_tb3_2(20):=255;
RQCFG_273_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(20),-1)));
RQCFG_273_.old_tb3_3(20):=null;
RQCFG_273_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(20),-1)));
RQCFG_273_.old_tb3_4(20):=null;
RQCFG_273_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(20),-1)));
RQCFG_273_.tb3_5(20):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(20):=121057254;
RQCFG_273_.tb3_6(20):=NULL;
RQCFG_273_.old_tb3_7(20):=null;
RQCFG_273_.tb3_7(20):=NULL;
RQCFG_273_.old_tb3_8(20):=null;
RQCFG_273_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(20),
RQCFG_273_.tb3_1(20),
RQCFG_273_.tb3_2(20),
RQCFG_273_.tb3_3(20),
RQCFG_273_.tb3_4(20),
RQCFG_273_.tb3_5(20),
RQCFG_273_.tb3_6(20),
RQCFG_273_.tb3_7(20),
RQCFG_273_.tb3_8(20),
null,
1627,
3,
'Número Solicitud'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(20):=1288737;
RQCFG_273_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(20):=RQCFG_273_.tb5_0(20);
RQCFG_273_.old_tb5_1(20):=255;
RQCFG_273_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(20),-1)));
RQCFG_273_.old_tb5_2(20):=null;
RQCFG_273_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(20),-1)));
RQCFG_273_.tb5_3(20):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(20):=RQCFG_273_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(20),
RQCFG_273_.tb5_1(20),
RQCFG_273_.tb5_2(20),
RQCFG_273_.tb5_3(20),
RQCFG_273_.tb5_4(20),
'Y'
,
'N'
,
3,
'Y'
,
'Número Solicitud'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(21):=1083125;
RQCFG_273_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(21):=RQCFG_273_.tb3_0(21);
RQCFG_273_.old_tb3_1(21):=2036;
RQCFG_273_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(21),-1)));
RQCFG_273_.old_tb3_2(21):=258;
RQCFG_273_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(21),-1)));
RQCFG_273_.old_tb3_3(21):=null;
RQCFG_273_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(21),-1)));
RQCFG_273_.old_tb3_4(21):=null;
RQCFG_273_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(21),-1)));
RQCFG_273_.tb3_5(21):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(21):=121057255;
RQCFG_273_.tb3_6(21):=NULL;
RQCFG_273_.old_tb3_7(21):=121057256;
RQCFG_273_.tb3_7(21):=NULL;
RQCFG_273_.old_tb3_8(21):=null;
RQCFG_273_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(21),
RQCFG_273_.tb3_1(21),
RQCFG_273_.tb3_2(21),
RQCFG_273_.tb3_3(21),
RQCFG_273_.tb3_4(21),
RQCFG_273_.tb3_5(21),
RQCFG_273_.tb3_6(21),
RQCFG_273_.tb3_7(21),
RQCFG_273_.tb3_8(21),
null,
1628,
1,
'Fecha solicitud'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(21):=1288738;
RQCFG_273_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(21):=RQCFG_273_.tb5_0(21);
RQCFG_273_.old_tb5_1(21):=258;
RQCFG_273_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(21),-1)));
RQCFG_273_.old_tb5_2(21):=null;
RQCFG_273_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(21),-1)));
RQCFG_273_.tb5_3(21):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(21):=RQCFG_273_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(21),
RQCFG_273_.tb5_1(21),
RQCFG_273_.tb5_2(21),
RQCFG_273_.tb5_3(21),
RQCFG_273_.tb5_4(21),
'Y'
,
'Y'
,
1,
'Y'
,
'Fecha solicitud'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(22):=1083126;
RQCFG_273_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(22):=RQCFG_273_.tb3_0(22);
RQCFG_273_.old_tb3_1(22):=2036;
RQCFG_273_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(22),-1)));
RQCFG_273_.old_tb3_2(22):=50001162;
RQCFG_273_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(22),-1)));
RQCFG_273_.old_tb3_3(22):=null;
RQCFG_273_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(22),-1)));
RQCFG_273_.old_tb3_4(22):=null;
RQCFG_273_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(22),-1)));
RQCFG_273_.tb3_5(22):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(22):=121057257;
RQCFG_273_.tb3_6(22):=NULL;
RQCFG_273_.old_tb3_7(22):=null;
RQCFG_273_.tb3_7(22):=NULL;
RQCFG_273_.old_tb3_8(22):=120029891;
RQCFG_273_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(22),
RQCFG_273_.tb3_1(22),
RQCFG_273_.tb3_2(22),
RQCFG_273_.tb3_3(22),
RQCFG_273_.tb3_4(22),
RQCFG_273_.tb3_5(22),
RQCFG_273_.tb3_6(22),
RQCFG_273_.tb3_7(22),
RQCFG_273_.tb3_8(22),
null,
1629,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(22):=1288739;
RQCFG_273_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(22):=RQCFG_273_.tb5_0(22);
RQCFG_273_.old_tb5_1(22):=50001162;
RQCFG_273_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(22),-1)));
RQCFG_273_.old_tb5_2(22):=null;
RQCFG_273_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(22),-1)));
RQCFG_273_.tb5_3(22):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(22):=RQCFG_273_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(22),
RQCFG_273_.tb5_1(22),
RQCFG_273_.tb5_2(22),
RQCFG_273_.tb5_3(22),
RQCFG_273_.tb5_4(22),
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(23):=1083127;
RQCFG_273_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(23):=RQCFG_273_.tb3_0(23);
RQCFG_273_.old_tb3_1(23):=2036;
RQCFG_273_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(23),-1)));
RQCFG_273_.old_tb3_2(23):=109479;
RQCFG_273_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(23),-1)));
RQCFG_273_.old_tb3_3(23):=null;
RQCFG_273_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(23),-1)));
RQCFG_273_.old_tb3_4(23):=null;
RQCFG_273_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(23),-1)));
RQCFG_273_.tb3_5(23):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(23):=121057258;
RQCFG_273_.tb3_6(23):=NULL;
RQCFG_273_.old_tb3_7(23):=null;
RQCFG_273_.tb3_7(23):=NULL;
RQCFG_273_.old_tb3_8(23):=120029892;
RQCFG_273_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(23),
RQCFG_273_.tb3_1(23),
RQCFG_273_.tb3_2(23),
RQCFG_273_.tb3_3(23),
RQCFG_273_.tb3_4(23),
RQCFG_273_.tb3_5(23),
RQCFG_273_.tb3_6(23),
RQCFG_273_.tb3_7(23),
RQCFG_273_.tb3_8(23),
null,
1630,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(23):=1288740;
RQCFG_273_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(23):=RQCFG_273_.tb5_0(23);
RQCFG_273_.old_tb5_1(23):=109479;
RQCFG_273_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(23),-1)));
RQCFG_273_.old_tb5_2(23):=null;
RQCFG_273_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(23),-1)));
RQCFG_273_.tb5_3(23):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(23):=RQCFG_273_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(23),
RQCFG_273_.tb5_1(23),
RQCFG_273_.tb5_2(23),
RQCFG_273_.tb5_3(23),
RQCFG_273_.tb5_4(23),
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(24):=1083128;
RQCFG_273_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(24):=RQCFG_273_.tb3_0(24);
RQCFG_273_.old_tb3_1(24):=2036;
RQCFG_273_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(24),-1)));
RQCFG_273_.old_tb3_2(24):=2683;
RQCFG_273_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(24),-1)));
RQCFG_273_.old_tb3_3(24):=null;
RQCFG_273_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(24),-1)));
RQCFG_273_.old_tb3_4(24):=null;
RQCFG_273_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(24),-1)));
RQCFG_273_.tb3_5(24):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(24):=121057259;
RQCFG_273_.tb3_6(24):=NULL;
RQCFG_273_.old_tb3_7(24):=null;
RQCFG_273_.tb3_7(24):=NULL;
RQCFG_273_.old_tb3_8(24):=120029893;
RQCFG_273_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(24),
RQCFG_273_.tb3_1(24),
RQCFG_273_.tb3_2(24),
RQCFG_273_.tb3_3(24),
RQCFG_273_.tb3_4(24),
RQCFG_273_.tb3_5(24),
RQCFG_273_.tb3_6(24),
RQCFG_273_.tb3_7(24),
RQCFG_273_.tb3_8(24),
null,
1631,
6,
'Medio recepción'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(24):=1288741;
RQCFG_273_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(24):=RQCFG_273_.tb5_0(24);
RQCFG_273_.old_tb5_1(24):=2683;
RQCFG_273_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(24),-1)));
RQCFG_273_.old_tb5_2(24):=null;
RQCFG_273_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(24),-1)));
RQCFG_273_.tb5_3(24):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(24):=RQCFG_273_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(24),
RQCFG_273_.tb5_1(24),
RQCFG_273_.tb5_2(24),
RQCFG_273_.tb5_3(24),
RQCFG_273_.tb5_4(24),
'Y'
,
'Y'
,
6,
'Y'
,
'Medio recepción'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(25):=1083129;
RQCFG_273_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(25):=RQCFG_273_.tb3_0(25);
RQCFG_273_.old_tb3_1(25):=2036;
RQCFG_273_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(25),-1)));
RQCFG_273_.old_tb3_2(25):=146755;
RQCFG_273_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(25),-1)));
RQCFG_273_.old_tb3_3(25):=null;
RQCFG_273_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(25),-1)));
RQCFG_273_.old_tb3_4(25):=null;
RQCFG_273_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(25),-1)));
RQCFG_273_.tb3_5(25):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(25):=121057260;
RQCFG_273_.tb3_6(25):=NULL;
RQCFG_273_.old_tb3_7(25):=null;
RQCFG_273_.tb3_7(25):=NULL;
RQCFG_273_.old_tb3_8(25):=null;
RQCFG_273_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(25),
RQCFG_273_.tb3_1(25),
RQCFG_273_.tb3_2(25),
RQCFG_273_.tb3_3(25),
RQCFG_273_.tb3_4(25),
RQCFG_273_.tb3_5(25),
RQCFG_273_.tb3_6(25),
RQCFG_273_.tb3_7(25),
RQCFG_273_.tb3_8(25),
null,
1632,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(25):=1288742;
RQCFG_273_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(25):=RQCFG_273_.tb5_0(25);
RQCFG_273_.old_tb5_1(25):=146755;
RQCFG_273_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(25),-1)));
RQCFG_273_.old_tb5_2(25):=null;
RQCFG_273_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(25),-1)));
RQCFG_273_.tb5_3(25):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(25):=RQCFG_273_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(25),
RQCFG_273_.tb5_1(25),
RQCFG_273_.tb5_2(25),
RQCFG_273_.tb5_3(25),
RQCFG_273_.tb5_4(25),
'Y'
,
'E'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(26):=1083130;
RQCFG_273_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(26):=RQCFG_273_.tb3_0(26);
RQCFG_273_.old_tb3_1(26):=2036;
RQCFG_273_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(26),-1)));
RQCFG_273_.old_tb3_2(26):=146756;
RQCFG_273_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(26),-1)));
RQCFG_273_.old_tb3_3(26):=null;
RQCFG_273_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(26),-1)));
RQCFG_273_.old_tb3_4(26):=null;
RQCFG_273_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(26),-1)));
RQCFG_273_.tb3_5(26):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(26):=121057261;
RQCFG_273_.tb3_6(26):=NULL;
RQCFG_273_.old_tb3_7(26):=null;
RQCFG_273_.tb3_7(26):=NULL;
RQCFG_273_.old_tb3_8(26):=null;
RQCFG_273_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(26),
RQCFG_273_.tb3_1(26),
RQCFG_273_.tb3_2(26),
RQCFG_273_.tb3_3(26),
RQCFG_273_.tb3_4(26),
RQCFG_273_.tb3_5(26),
RQCFG_273_.tb3_6(26),
RQCFG_273_.tb3_7(26),
RQCFG_273_.tb3_8(26),
null,
1641,
8,
'Dirección De Respuesta'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(26):=1288743;
RQCFG_273_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(26):=RQCFG_273_.tb5_0(26);
RQCFG_273_.old_tb5_1(26):=146756;
RQCFG_273_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(26),-1)));
RQCFG_273_.old_tb5_2(26):=null;
RQCFG_273_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(26),-1)));
RQCFG_273_.tb5_3(26):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(26):=RQCFG_273_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(26),
RQCFG_273_.tb5_1(26),
RQCFG_273_.tb5_2(26),
RQCFG_273_.tb5_3(26),
RQCFG_273_.tb5_4(26),
'Y'
,
'E'
,
8,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(27):=1083131;
RQCFG_273_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(27):=RQCFG_273_.tb3_0(27);
RQCFG_273_.old_tb3_1(27):=2036;
RQCFG_273_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(27),-1)));
RQCFG_273_.old_tb3_2(27):=259;
RQCFG_273_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(27),-1)));
RQCFG_273_.old_tb3_3(27):=null;
RQCFG_273_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(27),-1)));
RQCFG_273_.old_tb3_4(27):=null;
RQCFG_273_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(27),-1)));
RQCFG_273_.tb3_5(27):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(27):=121057262;
RQCFG_273_.tb3_6(27):=NULL;
RQCFG_273_.old_tb3_7(27):=null;
RQCFG_273_.tb3_7(27):=NULL;
RQCFG_273_.old_tb3_8(27):=null;
RQCFG_273_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(27),
RQCFG_273_.tb3_1(27),
RQCFG_273_.tb3_2(27),
RQCFG_273_.tb3_3(27),
RQCFG_273_.tb3_4(27),
RQCFG_273_.tb3_5(27),
RQCFG_273_.tb3_6(27),
RQCFG_273_.tb3_7(27),
RQCFG_273_.tb3_8(27),
null,
1642,
9,
'Fecha envío mensajes'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(27):=1288744;
RQCFG_273_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(27):=RQCFG_273_.tb5_0(27);
RQCFG_273_.old_tb5_1(27):=259;
RQCFG_273_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(27),-1)));
RQCFG_273_.old_tb5_2(27):=null;
RQCFG_273_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(27),-1)));
RQCFG_273_.tb5_3(27):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(27):=RQCFG_273_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(27),
RQCFG_273_.tb5_1(27),
RQCFG_273_.tb5_2(27),
RQCFG_273_.tb5_3(27),
RQCFG_273_.tb5_4(27),
'C'
,
'Y'
,
9,
'Y'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(28):=1083132;
RQCFG_273_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(28):=RQCFG_273_.tb3_0(28);
RQCFG_273_.old_tb3_1(28):=2036;
RQCFG_273_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(28),-1)));
RQCFG_273_.old_tb3_2(28):=109478;
RQCFG_273_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(28),-1)));
RQCFG_273_.old_tb3_3(28):=null;
RQCFG_273_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(28),-1)));
RQCFG_273_.old_tb3_4(28):=null;
RQCFG_273_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(28),-1)));
RQCFG_273_.tb3_5(28):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(28):=null;
RQCFG_273_.tb3_6(28):=NULL;
RQCFG_273_.old_tb3_7(28):=null;
RQCFG_273_.tb3_7(28):=NULL;
RQCFG_273_.old_tb3_8(28):=null;
RQCFG_273_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(28),
RQCFG_273_.tb3_1(28),
RQCFG_273_.tb3_2(28),
RQCFG_273_.tb3_3(28),
RQCFG_273_.tb3_4(28),
RQCFG_273_.tb3_5(28),
RQCFG_273_.tb3_6(28),
RQCFG_273_.tb3_7(28),
RQCFG_273_.tb3_8(28),
null,
1643,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(28):=1288745;
RQCFG_273_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(28):=RQCFG_273_.tb5_0(28);
RQCFG_273_.old_tb5_1(28):=109478;
RQCFG_273_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(28),-1)));
RQCFG_273_.old_tb5_2(28):=null;
RQCFG_273_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(28),-1)));
RQCFG_273_.tb5_3(28):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(28):=RQCFG_273_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(28),
RQCFG_273_.tb5_1(28),
RQCFG_273_.tb5_2(28),
RQCFG_273_.tb5_3(28),
RQCFG_273_.tb5_4(28),
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(29):=1083133;
RQCFG_273_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(29):=RQCFG_273_.tb3_0(29);
RQCFG_273_.old_tb3_1(29):=2036;
RQCFG_273_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(29),-1)));
RQCFG_273_.old_tb3_2(29):=42118;
RQCFG_273_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(29),-1)));
RQCFG_273_.old_tb3_3(29):=109479;
RQCFG_273_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(29),-1)));
RQCFG_273_.old_tb3_4(29):=null;
RQCFG_273_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(29),-1)));
RQCFG_273_.tb3_5(29):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(29):=null;
RQCFG_273_.tb3_6(29):=NULL;
RQCFG_273_.old_tb3_7(29):=null;
RQCFG_273_.tb3_7(29):=NULL;
RQCFG_273_.old_tb3_8(29):=null;
RQCFG_273_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(29),
RQCFG_273_.tb3_1(29),
RQCFG_273_.tb3_2(29),
RQCFG_273_.tb3_3(29),
RQCFG_273_.tb3_4(29),
RQCFG_273_.tb3_5(29),
RQCFG_273_.tb3_6(29),
RQCFG_273_.tb3_7(29),
RQCFG_273_.tb3_8(29),
null,
1646,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(29):=1288746;
RQCFG_273_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(29):=RQCFG_273_.tb5_0(29);
RQCFG_273_.old_tb5_1(29):=42118;
RQCFG_273_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(29),-1)));
RQCFG_273_.old_tb5_2(29):=null;
RQCFG_273_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(29),-1)));
RQCFG_273_.tb5_3(29):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(29):=RQCFG_273_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(29),
RQCFG_273_.tb5_1(29),
RQCFG_273_.tb5_2(29),
RQCFG_273_.tb5_3(29),
RQCFG_273_.tb5_4(29),
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(30):=1083134;
RQCFG_273_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(30):=RQCFG_273_.tb3_0(30);
RQCFG_273_.old_tb3_1(30):=2036;
RQCFG_273_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(30),-1)));
RQCFG_273_.old_tb3_2(30):=4015;
RQCFG_273_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(30),-1)));
RQCFG_273_.old_tb3_3(30):=null;
RQCFG_273_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(30),-1)));
RQCFG_273_.old_tb3_4(30):=null;
RQCFG_273_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(30),-1)));
RQCFG_273_.tb3_5(30):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(30):=121057263;
RQCFG_273_.tb3_6(30):=NULL;
RQCFG_273_.old_tb3_7(30):=null;
RQCFG_273_.tb3_7(30):=NULL;
RQCFG_273_.old_tb3_8(30):=null;
RQCFG_273_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(30),
RQCFG_273_.tb3_1(30),
RQCFG_273_.tb3_2(30),
RQCFG_273_.tb3_3(30),
RQCFG_273_.tb3_4(30),
RQCFG_273_.tb3_5(30),
RQCFG_273_.tb3_6(30),
RQCFG_273_.tb3_7(30),
RQCFG_273_.tb3_8(30),
null,
1647,
12,
'Suscriptor'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(30):=1288747;
RQCFG_273_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(30):=RQCFG_273_.tb5_0(30);
RQCFG_273_.old_tb5_1(30):=4015;
RQCFG_273_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(30),-1)));
RQCFG_273_.old_tb5_2(30):=null;
RQCFG_273_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(30),-1)));
RQCFG_273_.tb5_3(30):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(30):=RQCFG_273_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(30),
RQCFG_273_.tb5_1(30),
RQCFG_273_.tb5_2(30),
RQCFG_273_.tb5_3(30),
RQCFG_273_.tb5_4(30),
'C'
,
'Y'
,
12,
'Y'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(31):=1083135;
RQCFG_273_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(31):=RQCFG_273_.tb3_0(31);
RQCFG_273_.old_tb3_1(31):=2036;
RQCFG_273_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(31),-1)));
RQCFG_273_.old_tb3_2(31):=2558;
RQCFG_273_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(31),-1)));
RQCFG_273_.old_tb3_3(31):=null;
RQCFG_273_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(31),-1)));
RQCFG_273_.old_tb3_4(31):=null;
RQCFG_273_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(31),-1)));
RQCFG_273_.tb3_5(31):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(31):=null;
RQCFG_273_.tb3_6(31):=NULL;
RQCFG_273_.old_tb3_7(31):=null;
RQCFG_273_.tb3_7(31):=NULL;
RQCFG_273_.old_tb3_8(31):=120029894;
RQCFG_273_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(31),
RQCFG_273_.tb3_1(31),
RQCFG_273_.tb3_2(31),
RQCFG_273_.tb3_3(31),
RQCFG_273_.tb3_4(31),
RQCFG_273_.tb3_5(31),
RQCFG_273_.tb3_6(31),
RQCFG_273_.tb3_7(31),
RQCFG_273_.tb3_8(31),
null,
1648,
14,
'Relación del Solicitante con el Predio'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(31):=1288748;
RQCFG_273_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(31):=RQCFG_273_.tb5_0(31);
RQCFG_273_.old_tb5_1(31):=2558;
RQCFG_273_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(31),-1)));
RQCFG_273_.old_tb5_2(31):=null;
RQCFG_273_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(31),-1)));
RQCFG_273_.tb5_3(31):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(31):=RQCFG_273_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(31),
RQCFG_273_.tb5_1(31),
RQCFG_273_.tb5_2(31),
RQCFG_273_.tb5_3(31),
RQCFG_273_.tb5_4(31),
'Y'
,
'Y'
,
14,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(32):=1083136;
RQCFG_273_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(32):=RQCFG_273_.tb3_0(32);
RQCFG_273_.old_tb3_1(32):=2036;
RQCFG_273_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(32),-1)));
RQCFG_273_.old_tb3_2(32):=146754;
RQCFG_273_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(32),-1)));
RQCFG_273_.old_tb3_3(32):=null;
RQCFG_273_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(32),-1)));
RQCFG_273_.old_tb3_4(32):=null;
RQCFG_273_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(32),-1)));
RQCFG_273_.tb3_5(32):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(32):=null;
RQCFG_273_.tb3_6(32):=NULL;
RQCFG_273_.old_tb3_7(32):=121057264;
RQCFG_273_.tb3_7(32):=NULL;
RQCFG_273_.old_tb3_8(32):=null;
RQCFG_273_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(32),
RQCFG_273_.tb3_1(32),
RQCFG_273_.tb3_2(32),
RQCFG_273_.tb3_3(32),
RQCFG_273_.tb3_4(32),
RQCFG_273_.tb3_5(32),
RQCFG_273_.tb3_6(32),
RQCFG_273_.tb3_7(32),
RQCFG_273_.tb3_8(32),
null,
1649,
13,
'Observación'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(32):=1288749;
RQCFG_273_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(32):=RQCFG_273_.tb5_0(32);
RQCFG_273_.old_tb5_1(32):=146754;
RQCFG_273_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(32),-1)));
RQCFG_273_.old_tb5_2(32):=null;
RQCFG_273_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(32),-1)));
RQCFG_273_.tb5_3(32):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(32):=RQCFG_273_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(32),
RQCFG_273_.tb5_1(32),
RQCFG_273_.tb5_2(32),
RQCFG_273_.tb5_3(32),
RQCFG_273_.tb5_4(32),
'Y'
,
'Y'
,
13,
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(33):=1083137;
RQCFG_273_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(33):=RQCFG_273_.tb3_0(33);
RQCFG_273_.old_tb3_1(33):=2036;
RQCFG_273_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(33),-1)));
RQCFG_273_.old_tb3_2(33):=20367;
RQCFG_273_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(33),-1)));
RQCFG_273_.old_tb3_3(33):=null;
RQCFG_273_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(33),-1)));
RQCFG_273_.old_tb3_4(33):=null;
RQCFG_273_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(33),-1)));
RQCFG_273_.tb3_5(33):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(33):=null;
RQCFG_273_.tb3_6(33):=NULL;
RQCFG_273_.old_tb3_7(33):=121057251;
RQCFG_273_.tb3_7(33):=NULL;
RQCFG_273_.old_tb3_8(33):=null;
RQCFG_273_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(33),
RQCFG_273_.tb3_1(33),
RQCFG_273_.tb3_2(33),
RQCFG_273_.tb3_3(33),
RQCFG_273_.tb3_4(33),
RQCFG_273_.tb3_5(33),
RQCFG_273_.tb3_6(33),
RQCFG_273_.tb3_7(33),
RQCFG_273_.tb3_8(33),
null,
1653,
15,
'Fecha Inicial'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(33):=1288750;
RQCFG_273_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(33):=RQCFG_273_.tb5_0(33);
RQCFG_273_.old_tb5_1(33):=20367;
RQCFG_273_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(33),-1)));
RQCFG_273_.old_tb5_2(33):=null;
RQCFG_273_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(33),-1)));
RQCFG_273_.tb5_3(33):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(33):=RQCFG_273_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(33),
RQCFG_273_.tb5_1(33),
RQCFG_273_.tb5_2(33),
RQCFG_273_.tb5_3(33),
RQCFG_273_.tb5_4(33),
'Y'
,
'Y'
,
15,
'Y'
,
'Fecha Inicial'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb3_0(34):=1083138;
RQCFG_273_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_273_.tb3_0(34):=RQCFG_273_.tb3_0(34);
RQCFG_273_.old_tb3_1(34):=2036;
RQCFG_273_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_273_.TBENTITYNAME(NVL(RQCFG_273_.old_tb3_1(34),-1)));
RQCFG_273_.old_tb3_2(34):=20368;
RQCFG_273_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_2(34),-1)));
RQCFG_273_.old_tb3_3(34):=null;
RQCFG_273_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_3(34),-1)));
RQCFG_273_.old_tb3_4(34):=null;
RQCFG_273_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb3_4(34),-1)));
RQCFG_273_.tb3_5(34):=RQCFG_273_.tb2_2(0);
RQCFG_273_.old_tb3_6(34):=null;
RQCFG_273_.tb3_6(34):=NULL;
RQCFG_273_.old_tb3_7(34):=121057252;
RQCFG_273_.tb3_7(34):=NULL;
RQCFG_273_.old_tb3_8(34):=null;
RQCFG_273_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_273_.tb3_0(34),
RQCFG_273_.tb3_1(34),
RQCFG_273_.tb3_2(34),
RQCFG_273_.tb3_3(34),
RQCFG_273_.tb3_4(34),
RQCFG_273_.tb3_5(34),
RQCFG_273_.tb3_6(34),
RQCFG_273_.tb3_7(34),
RQCFG_273_.tb3_8(34),
null,
1659,
16,
'Fecha Final'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_273_.blProcessStatus) then
 return;
end if;

RQCFG_273_.old_tb5_0(34):=1288751;
RQCFG_273_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_273_.tb5_0(34):=RQCFG_273_.tb5_0(34);
RQCFG_273_.old_tb5_1(34):=20368;
RQCFG_273_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_1(34),-1)));
RQCFG_273_.old_tb5_2(34):=null;
RQCFG_273_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_273_.TBENTITYATTRIBUTENAME(NVL(RQCFG_273_.old_tb5_2(34),-1)));
RQCFG_273_.tb5_3(34):=RQCFG_273_.tb4_0(1);
RQCFG_273_.tb5_4(34):=RQCFG_273_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_273_.tb5_0(34),
RQCFG_273_.tb5_1(34),
RQCFG_273_.tb5_2(34),
RQCFG_273_.tb5_3(34),
RQCFG_273_.tb5_4(34),
'Y'
,
'Y'
,
16,
'Y'
,
'Fecha Final'
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
RQCFG_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (273);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (273)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_273_.blProcessStatus) then
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
AND     external_root_id = 273
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
AND     external_root_id = 273
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
AND     external_root_id = 273
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 273, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 273)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 273, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 273)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 273, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 273)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 273, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 273)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_273_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_273_.tbCompositions.FIRST..RQCFG_273_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_273_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_273_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_273_.blProcessStatus := false;
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
 nuIndex := RQCFG_273_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_273_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_273_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_273_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_273_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_273_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_273_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_273_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_273_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_273_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_273_',
'CREATE OR REPLACE PACKAGE I18N_R_273_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_273_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_273_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 273
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_273_.blProcessStatus) then
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
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(0):='M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
;
I18N_R_273_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(0),
I18N_R_273_.tb0_1(0),
'WE8ISO8859P1'
,
'Productos por estado de Cuenta'
,
'Productos por estado de Cuenta'
,
null,
'Productos por estado de Cuenta'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(1):='M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
;
I18N_R_273_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(1),
I18N_R_273_.tb0_1(1),
'WE8ISO8859P1'
,
'Productos por estado de Cuenta'
,
'Productos por estado de Cuenta'
,
null,
'Productos por estado de Cuenta'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(2):='M_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_82'
;
I18N_R_273_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(2),
I18N_R_273_.tb0_1(2),
'WE8ISO8859P1'
,
'Productos por estado de Cuenta'
,
'Productos por estado de Cuenta'
,
null,
'Productos por estado de Cuenta'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(3):='PAQUETE'
;
I18N_R_273_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(3),
I18N_R_273_.tb0_1(3),
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
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(4):='PAQUETE'
;
I18N_R_273_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(4),
I18N_R_273_.tb0_1(4),
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
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(5):='PAQUETE'
;
I18N_R_273_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(5),
I18N_R_273_.tb0_1(5),
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
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_273_.blProcessStatus) then
 return;
end if;

I18N_R_273_.tb0_0(6):='PAQUETE'
;
I18N_R_273_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_273_.tb0_0(6),
I18N_R_273_.tb0_1(6),
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
I18N_R_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_273_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_273_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_273_',
'CREATE OR REPLACE PACKAGE RQEXEC_273_ IS ' || chr(10) ||
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
'END RQEXEC_273_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_273_******************************'); END;
/


BEGIN

if (not RQEXEC_273_.blProcessStatus) then
 return;
end if;

RQEXEC_273_.old_tb0_0(0):='P_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_273'
;
RQEXEC_273_.tb0_0(0):=UPPER(RQEXEC_273_.old_tb0_0(0));
RQEXEC_273_.old_tb0_1(0):=16647;
RQEXEC_273_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_273_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_273_.tb0_1(0):=RQEXEC_273_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_273_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_273_.tb0_1(0),
DESCRIPTION='Solicitud de Certificado de Estado de Cuenta'
,
PATH=null,
VERSION='41'
,
EXECUTABLE_TYPE_ID=3,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=16,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP='ges_comercial_aten_clie_herramientas_pto_unico_atencion_Estado_de_Cuenta.htm'
,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='N'
,
TIMES_EXECUTED=2191,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=to_date('24-08-2016 07:46:20','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_273_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_273_.tb0_0(0),
RQEXEC_273_.tb0_1(0),
'Solicitud de Certificado de Estado de Cuenta'
,
null,
'41'
,
3,
2,
16,
1,
null,
'N'
,
'ges_comercial_aten_clie_herramientas_pto_unico_atencion_Estado_de_Cuenta.htm'
,
'N'
,
'N'
,
2191,
'O',
to_date('24-08-2016 07:46:20','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_273_.blProcessStatus) then
 return;
end if;

RQEXEC_273_.tb1_0(0):=1;
RQEXEC_273_.tb1_1(0):=RQEXEC_273_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_273_.tb1_0(0),
RQEXEC_273_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_273_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_273_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_273_******************************'); end;
/

