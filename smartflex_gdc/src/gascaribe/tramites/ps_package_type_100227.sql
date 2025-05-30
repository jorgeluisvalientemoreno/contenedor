BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100227_',
'CREATE OR REPLACE PACKAGE RQTY_100227_ IS ' || chr(10) ||
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
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100227 ' || chr(10) ||
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
'END RQTY_100227_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100227_******************************'); END;
/

BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
AND     external_root_id = 100227
)
);

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100227_.cuExpressions;
fetch RQTY_100227_.cuExpressions bulk collect INTO RQTY_100227_.tbExpressionsId;
close RQTY_100227_.cuExpressions;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100227_.tbEntityName(-1) := 'NULL';
   RQTY_100227_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQTY_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100227_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQTY_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100227_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQTY_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQTY_100227_.tbEntityAttributeName(90191174) := 'LDC_UO_TRASLADO_PAGO@PACKAGE_ID';
   RQTY_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQTY_100227_.tbEntityAttributeName(90191175) := 'LDC_UO_TRASLADO_PAGO@OPERATING_UNIT_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100227_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   RQTY_100227_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100227_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100227_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100227_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100227_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100227
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100227
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100227
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100227
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100227_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100227_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100227_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100227_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100227_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100227_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100227_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227))));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227))));

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100227_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100227_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100227_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100227_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100227_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100227_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100227_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100227_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227)));

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227));
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100227_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227);
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100227_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100227_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100227_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100227_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100227;
nuIndex binary_integer;
BEGIN

if (not RQTY_100227_.blProcessStatus) then
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100227_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100227_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100227_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100227_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100227_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100227_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100227_.tb0_0(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb1_0(0):=1;
RQTY_100227_.tb1_1(0):=RQTY_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100227_.tb1_0(0),
MODULE_ID=RQTY_100227_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100227_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100227_.tb1_0(0),
RQTY_100227_.tb1_1(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(0):=121381306;
RQTY_100227_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(0):=RQTY_100227_.tb2_0(0);
RQTY_100227_.old_tb2_1(0):='GE_EXEACTION_CT1E121381306'
;
RQTY_100227_.tb2_1(0):=RQTY_100227_.tb2_0(0);
RQTY_100227_.tb2_2(0):=RQTY_100227_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(0),
RQTY_100227_.tb2_1(0),
RQTY_100227_.tb2_2(0),
'nuSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();dtRequestDate = CC_BOBOSSUTIL.FDTREQUESTDATE(nuSolicitud);sbSysdate = UT_DATE.FSBSTR_SYSDATE();dtSysdate = UT_CONVERT.FNUCHARTODATE(sbSysdate);dtRequestDate = UT_DATE.FDTTRUNCATEDATE(dtRequestDate);dtSysdate = UT_DATE.FDTTRUNCATEDATE(dtSysdate);nuPackageType = 100227;if (dtRequestDate <> dtSysdate,inuEntityID = 2012;GE_BOALERTMESSAGEPARAM.VERANDSENDNOTIF(inuEntityID,nuPackageType,nuSolicitud,null,osbNotifSends,osbLogNotif);,);nuMotiveId = CF_BOSTATEMENTSWF.FNUGETINITMOTIVE(nuSolicitud);nuAnswerId = MO_BOMOTIVE.FNUGETANSWERID(nuMotiveId);if (nuAnswerId = null,MO_BOATTENTION.ACTCREATEPLANWF();,cnuRechazada = 39;if (CC_BOANSWER.FNUGETANSWERTYPEID(nuAnswerId) = cnuRechazada,CF_BOACTIONS.ATTENDREQUEST(nuSolicitud);,MO_BOATTENTION.ACTCREATEPLANWF();););cnuTipoFechaPQR = 17;dtFechaSolicitud = MO_BODATA.FDTGETVALUE("MO_PACKAGES", "REQUEST_DATE", nuSolicitud);CC_BOPACKADDIDATE.REGISTERPACKAGEDATE(UT_CONVERT.FNUCHARTONUMBER(nuSolicitud),cnuTi' ||
'poFechaPQR,dtFechaSolicitud)'
,
'LBTEST'
,
to_date('11-08-2012 12:19:25','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:37','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:37','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Atención Traslado de Pagos a Otro Contrato'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb3_0(0):=8140;
RQTY_100227_.tb3_1(0):=RQTY_100227_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100227_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100227_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='Atención Traslado de Pagos a Otro Contrato'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100227_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100227_.tb3_0(0),
RQTY_100227_.tb3_1(0),
5,
'Atención Traslado de Pagos a Otro Contrato'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb4_0(0):=RQTY_100227_.tb3_0(0);
RQTY_100227_.tb4_1(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100227_.tb4_0(0),
VALID_MODULE_ID=RQTY_100227_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100227_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100227_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100227_.tb4_0(0),
RQTY_100227_.tb4_1(0));
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb4_0(1):=RQTY_100227_.tb3_0(0);
RQTY_100227_.tb4_1(1):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100227_.tb4_0(1),
VALID_MODULE_ID=RQTY_100227_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100227_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100227_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100227_.tb4_0(1),
RQTY_100227_.tb4_1(1));
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb5_0(0):=100227;
RQTY_100227_.tb5_1(0):=RQTY_100227_.tb3_0(0);
RQTY_100227_.tb5_4(0):='P_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100227'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100227_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100227_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100227_.tb5_4(0),
DESCRIPTION='Traslado de Pago a otro Contrato'
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
 WHERE PACKAGE_TYPE_ID = RQTY_100227_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100227_.tb5_0(0),
RQTY_100227_.tb5_1(0),
null,
null,
RQTY_100227_.tb5_4(0),
'Traslado de Pago a otro Contrato'
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100227_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100227_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100227_.tb0_0(1),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb1_0(1):=23;
RQTY_100227_.tb1_1(1):=RQTY_100227_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100227_.tb1_0(1),
MODULE_ID=RQTY_100227_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100227_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100227_.tb1_0(1),
RQTY_100227_.tb1_1(1),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(1):=121381308;
RQTY_100227_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(1):=RQTY_100227_.tb2_0(1);
RQTY_100227_.old_tb2_1(1):='MO_INITATRIB_CT23E121381308'
;
RQTY_100227_.tb2_1(1):=RQTY_100227_.tb2_0(1);
RQTY_100227_.tb2_2(1):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(1),
RQTY_100227_.tb2_1(1),
RQTY_100227_.tb2_2(1),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg)'
,
'LBTEST'
,
to_date('11-08-2012 10:09:58','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:40','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:40','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb1_0(2):=26;
RQTY_100227_.tb1_1(2):=RQTY_100227_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100227_.tb1_0(2),
MODULE_ID=RQTY_100227_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100227_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100227_.tb1_0(2),
RQTY_100227_.tb1_1(2),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(2):=121381309;
RQTY_100227_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(2):=RQTY_100227_.tb2_0(2);
RQTY_100227_.old_tb2_1(2):='MO_VALIDATTR_CT26E121381309'
;
RQTY_100227_.tb2_1(2):=RQTY_100227_.tb2_0(2);
RQTY_100227_.tb2_2(2):=RQTY_100227_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(2),
RQTY_100227_.tb2_1(2),
RQTY_100227_.tb2_2(2),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100227;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No está permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,););)'
,
'LBTEST'
,
to_date('11-08-2012 10:31:15','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:41','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:41','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(0):=105545;
RQTY_100227_.tb6_1(0):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(0):=17;
RQTY_100227_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(0),-1)));
RQTY_100227_.old_tb6_3(0):=258;
RQTY_100227_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(0),-1)));
RQTY_100227_.old_tb6_4(0):=null;
RQTY_100227_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(0),-1)));
RQTY_100227_.old_tb6_5(0):=null;
RQTY_100227_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(0),-1)));
RQTY_100227_.tb6_7(0):=RQTY_100227_.tb2_0(1);
RQTY_100227_.tb6_8(0):=RQTY_100227_.tb2_0(2);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(0),
ENTITY_ID=RQTY_100227_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(0),
VALID_EXPRESSION_ID=RQTY_100227_.tb6_8(0),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(0),
RQTY_100227_.tb6_1(0),
RQTY_100227_.tb6_2(0),
RQTY_100227_.tb6_3(0),
RQTY_100227_.tb6_4(0),
RQTY_100227_.tb6_5(0),
null,
RQTY_100227_.tb6_7(0),
RQTY_100227_.tb6_8(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(1):=105546;
RQTY_100227_.tb6_1(1):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(1):=17;
RQTY_100227_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(1),-1)));
RQTY_100227_.old_tb6_3(1):=255;
RQTY_100227_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(1),-1)));
RQTY_100227_.old_tb6_4(1):=null;
RQTY_100227_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(1),-1)));
RQTY_100227_.old_tb6_5(1):=null;
RQTY_100227_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(1),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(1),
ENTITY_ID=RQTY_100227_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(1),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(1),
RQTY_100227_.tb6_1(1),
RQTY_100227_.tb6_2(1),
RQTY_100227_.tb6_3(1),
RQTY_100227_.tb6_4(1),
RQTY_100227_.tb6_5(1),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(3):=121381310;
RQTY_100227_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(3):=RQTY_100227_.tb2_0(3);
RQTY_100227_.old_tb2_1(3):='MO_INITATRIB_CT23E121381310'
;
RQTY_100227_.tb2_1(3):=RQTY_100227_.tb2_0(3);
RQTY_100227_.tb2_2(3):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(3),
RQTY_100227_.tb2_1(3),
RQTY_100227_.tb2_2(3),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETPERSONID())'
,
'LBTEST'
,
to_date('11-08-2012 10:10:00','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:41','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:41','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb7_0(0):=120191271;
RQTY_100227_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100227_.tb7_0(0):=RQTY_100227_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100227_.tb7_0(0),
5,
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb8_0(0):=RQTY_100227_.tb7_0(0);
RQTY_100227_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
    <Length>108</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (0)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100227_.tb8_0(0),
null,
RQTY_100227_.clColumn_1,
null);

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(2):=105547;
RQTY_100227_.tb6_1(2):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(2):=17;
RQTY_100227_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(2),-1)));
RQTY_100227_.old_tb6_3(2):=50001162;
RQTY_100227_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(2),-1)));
RQTY_100227_.old_tb6_4(2):=null;
RQTY_100227_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(2),-1)));
RQTY_100227_.old_tb6_5(2):=null;
RQTY_100227_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(2),-1)));
RQTY_100227_.tb6_6(2):=RQTY_100227_.tb7_0(0);
RQTY_100227_.tb6_7(2):=RQTY_100227_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(2),
ENTITY_ID=RQTY_100227_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(2),
STATEMENT_ID=RQTY_100227_.tb6_6(2),
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(2),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(2),
RQTY_100227_.tb6_1(2),
RQTY_100227_.tb6_2(2),
RQTY_100227_.tb6_3(2),
RQTY_100227_.tb6_4(2),
RQTY_100227_.tb6_5(2),
RQTY_100227_.tb6_6(2),
RQTY_100227_.tb6_7(2),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(4):=121381311;
RQTY_100227_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(4):=RQTY_100227_.tb2_0(4);
RQTY_100227_.old_tb2_1(4):='MO_INITATRIB_CT23E121381311'
;
RQTY_100227_.tb2_1(4):=RQTY_100227_.tb2_0(4);
RQTY_100227_.tb2_2(4):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(4),
RQTY_100227_.tb2_1(4),
RQTY_100227_.tb2_2(4),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'LBTEST'
,
to_date('11-08-2012 10:10:02','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:41','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:41','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb7_0(1):=120191272;
RQTY_100227_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100227_.tb7_0(1):=RQTY_100227_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100227_.tb7_0(1),
5,
'Lista de Valores Unidad Operativa'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')'
,
'Lista de Valores Unidad Operativa'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(3):=105548;
RQTY_100227_.tb6_1(3):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(3):=17;
RQTY_100227_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(3),-1)));
RQTY_100227_.old_tb6_3(3):=109479;
RQTY_100227_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(3),-1)));
RQTY_100227_.old_tb6_4(3):=null;
RQTY_100227_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(3),-1)));
RQTY_100227_.old_tb6_5(3):=null;
RQTY_100227_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(3),-1)));
RQTY_100227_.tb6_6(3):=RQTY_100227_.tb7_0(1);
RQTY_100227_.tb6_7(3):=RQTY_100227_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(3),
ENTITY_ID=RQTY_100227_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(3),
STATEMENT_ID=RQTY_100227_.tb6_6(3),
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(3),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(3),
RQTY_100227_.tb6_1(3),
RQTY_100227_.tb6_2(3),
RQTY_100227_.tb6_3(3),
RQTY_100227_.tb6_4(3),
RQTY_100227_.tb6_5(3),
RQTY_100227_.tb6_6(3),
RQTY_100227_.tb6_7(3),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(5):=121381312;
RQTY_100227_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(5):=RQTY_100227_.tb2_0(5);
RQTY_100227_.old_tb2_1(5):='MO_INITATRIB_CT23E121381312'
;
RQTY_100227_.tb2_1(5):=RQTY_100227_.tb2_0(5);
RQTY_100227_.tb2_2(5):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(5),
RQTY_100227_.tb2_1(5),
RQTY_100227_.tb2_2(5),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'LBTEST'
,
to_date('11-08-2012 10:12:34','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:42','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb7_0(2):=120191273;
RQTY_100227_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100227_.tb7_0(2):=RQTY_100227_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100227_.tb7_0(2),
5,
'Sentencia Medio de Recepción'
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
'Sentencia Medio de Recepción'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(4):=105549;
RQTY_100227_.tb6_1(4):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(4):=17;
RQTY_100227_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(4),-1)));
RQTY_100227_.old_tb6_3(4):=2683;
RQTY_100227_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(4),-1)));
RQTY_100227_.old_tb6_4(4):=null;
RQTY_100227_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(4),-1)));
RQTY_100227_.old_tb6_5(4):=null;
RQTY_100227_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(4),-1)));
RQTY_100227_.tb6_6(4):=RQTY_100227_.tb7_0(2);
RQTY_100227_.tb6_7(4):=RQTY_100227_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(4),
ENTITY_ID=RQTY_100227_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(4),
STATEMENT_ID=RQTY_100227_.tb6_6(4),
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(4),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(4),
RQTY_100227_.tb6_1(4),
RQTY_100227_.tb6_2(4),
RQTY_100227_.tb6_3(4),
RQTY_100227_.tb6_4(4),
RQTY_100227_.tb6_5(4),
RQTY_100227_.tb6_6(4),
RQTY_100227_.tb6_7(4),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(6):=121381313;
RQTY_100227_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(6):=RQTY_100227_.tb2_0(6);
RQTY_100227_.old_tb2_1(6):='MO_INITATRIB_CT23E121381313'
;
RQTY_100227_.tb2_1(6):=RQTY_100227_.tb2_0(6);
RQTY_100227_.tb2_2(6):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(6),
RQTY_100227_.tb2_1(6),
RQTY_100227_.tb2_2(6),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'LBTEST'
,
to_date('11-08-2012 10:12:34','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:42','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:42','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(5):=105550;
RQTY_100227_.tb6_1(5):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(5):=17;
RQTY_100227_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(5),-1)));
RQTY_100227_.old_tb6_3(5):=146755;
RQTY_100227_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(5),-1)));
RQTY_100227_.old_tb6_4(5):=null;
RQTY_100227_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(5),-1)));
RQTY_100227_.old_tb6_5(5):=null;
RQTY_100227_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(5),-1)));
RQTY_100227_.tb6_7(5):=RQTY_100227_.tb2_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(5),
ENTITY_ID=RQTY_100227_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(5),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(5),
RQTY_100227_.tb6_1(5),
RQTY_100227_.tb6_2(5),
RQTY_100227_.tb6_3(5),
RQTY_100227_.tb6_4(5),
RQTY_100227_.tb6_5(5),
null,
RQTY_100227_.tb6_7(5),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(7):=121381314;
RQTY_100227_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(7):=RQTY_100227_.tb2_0(7);
RQTY_100227_.old_tb2_1(7):='MO_INITATRIB_CT23E121381314'
;
RQTY_100227_.tb2_1(7):=RQTY_100227_.tb2_0(7);
RQTY_100227_.tb2_2(7):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(7),
RQTY_100227_.tb2_1(7),
RQTY_100227_.tb2_2(7),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'LBTEST'
,
to_date('11-08-2012 10:38:53','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:42','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PACKAGES - ADDRESS_ID - inicialización de la dirección de respuesta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(6):=105551;
RQTY_100227_.tb6_1(6):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(6):=17;
RQTY_100227_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(6),-1)));
RQTY_100227_.old_tb6_3(6):=146756;
RQTY_100227_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(6),-1)));
RQTY_100227_.old_tb6_4(6):=null;
RQTY_100227_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(6),-1)));
RQTY_100227_.old_tb6_5(6):=null;
RQTY_100227_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(6),-1)));
RQTY_100227_.tb6_7(6):=RQTY_100227_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(6),
ENTITY_ID=RQTY_100227_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Dirección de Respuesta'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(6),
RQTY_100227_.tb6_1(6),
RQTY_100227_.tb6_2(6),
RQTY_100227_.tb6_3(6),
RQTY_100227_.tb6_4(6),
RQTY_100227_.tb6_5(6),
null,
RQTY_100227_.tb6_7(6),
null,
null,
7,
'Dirección de Respuesta'
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(7):=105552;
RQTY_100227_.tb6_1(7):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(7):=17;
RQTY_100227_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(7),-1)));
RQTY_100227_.old_tb6_3(7):=146754;
RQTY_100227_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(7),-1)));
RQTY_100227_.old_tb6_4(7):=null;
RQTY_100227_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(7),-1)));
RQTY_100227_.old_tb6_5(7):=null;
RQTY_100227_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(7),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(7),
ENTITY_ID=RQTY_100227_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(7),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(7),
RQTY_100227_.tb6_1(7),
RQTY_100227_.tb6_2(7),
RQTY_100227_.tb6_3(7),
RQTY_100227_.tb6_4(7),
RQTY_100227_.tb6_5(7),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb7_0(3):=120191274;
RQTY_100227_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100227_.tb7_0(3):=RQTY_100227_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100227_.tb7_0(3),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb8_0(1):=RQTY_100227_.tb7_0(3);
RQTY_100227_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
    <Description>Descripción Del Rol </Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
    <Entity>CC_ROLE</Entity>
    <Column>DESCRIPTION</Column>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (1)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100227_.tb8_0(1),
null,
RQTY_100227_.clColumn_1,
null);

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(8):=105553;
RQTY_100227_.tb6_1(8):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(8):=9179;
RQTY_100227_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(8),-1)));
RQTY_100227_.old_tb6_3(8):=149340;
RQTY_100227_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(8),-1)));
RQTY_100227_.old_tb6_4(8):=null;
RQTY_100227_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(8),-1)));
RQTY_100227_.old_tb6_5(8):=null;
RQTY_100227_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(8),-1)));
RQTY_100227_.tb6_6(8):=RQTY_100227_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(8),
ENTITY_ID=RQTY_100227_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(8),
STATEMENT_ID=RQTY_100227_.tb6_6(8),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Relación del solicitante con el predio'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(8),
RQTY_100227_.tb6_1(8),
RQTY_100227_.tb6_2(8),
RQTY_100227_.tb6_3(8),
RQTY_100227_.tb6_4(8),
RQTY_100227_.tb6_5(8),
RQTY_100227_.tb6_6(8),
null,
null,
null,
9,
'Relación del solicitante con el predio'
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(9):=105554;
RQTY_100227_.tb6_1(9):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(9):=9179;
RQTY_100227_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(9),-1)));
RQTY_100227_.old_tb6_3(9):=39387;
RQTY_100227_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(9),-1)));
RQTY_100227_.old_tb6_4(9):=255;
RQTY_100227_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(9),-1)));
RQTY_100227_.old_tb6_5(9):=null;
RQTY_100227_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(9),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(9),
ENTITY_ID=RQTY_100227_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=14,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(9),
RQTY_100227_.tb6_1(9),
RQTY_100227_.tb6_2(9),
RQTY_100227_.tb6_3(9),
RQTY_100227_.tb6_4(9),
RQTY_100227_.tb6_5(9),
null,
null,
null,
null,
14,
'Identificador De Solicitud'
,
14,
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(8):=121381315;
RQTY_100227_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(8):=RQTY_100227_.tb2_0(8);
RQTY_100227_.old_tb2_1(8):='MO_INITATRIB_CT23E121381315'
;
RQTY_100227_.tb2_1(8):=RQTY_100227_.tb2_0(8);
RQTY_100227_.tb2_2(8):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(8),
RQTY_100227_.tb2_1(8),
RQTY_100227_.tb2_2(8),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETSEQMO_SUBS_TYPE_MOTIV())'
,
'TESTOSS'
,
to_date('25-06-2007 10:29:04','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:43','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:43','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(10):=105555;
RQTY_100227_.tb6_1(10):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(10):=9179;
RQTY_100227_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(10),-1)));
RQTY_100227_.old_tb6_3(10):=50000603;
RQTY_100227_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(10),-1)));
RQTY_100227_.old_tb6_4(10):=null;
RQTY_100227_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(10),-1)));
RQTY_100227_.old_tb6_5(10):=null;
RQTY_100227_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(10),-1)));
RQTY_100227_.tb6_7(10):=RQTY_100227_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(10),
ENTITY_ID=RQTY_100227_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Identificador de suscriptor por motivo'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(10),
RQTY_100227_.tb6_1(10),
RQTY_100227_.tb6_2(10),
RQTY_100227_.tb6_3(10),
RQTY_100227_.tb6_4(10),
RQTY_100227_.tb6_5(10),
null,
RQTY_100227_.tb6_7(10),
null,
null,
13,
'Identificador de suscriptor por motivo'
,
13,
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(11):=105556;
RQTY_100227_.tb6_1(11):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(11):=9179;
RQTY_100227_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(11),-1)));
RQTY_100227_.old_tb6_3(11):=50000606;
RQTY_100227_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(11),-1)));
RQTY_100227_.old_tb6_4(11):=4015;
RQTY_100227_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(11),-1)));
RQTY_100227_.old_tb6_5(11):=null;
RQTY_100227_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(11),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(11),
ENTITY_ID=RQTY_100227_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Usuario del Servicio'
,
DISPLAY_ORDER=16,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(11),
RQTY_100227_.tb6_1(11),
RQTY_100227_.tb6_2(11),
RQTY_100227_.tb6_3(11),
RQTY_100227_.tb6_4(11),
RQTY_100227_.tb6_5(11),
null,
null,
null,
null,
16,
'Usuario del Servicio'
,
16,
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(12):=105557;
RQTY_100227_.tb6_1(12):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(12):=17;
RQTY_100227_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(12),-1)));
RQTY_100227_.old_tb6_3(12):=42118;
RQTY_100227_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(12),-1)));
RQTY_100227_.old_tb6_4(12):=109479;
RQTY_100227_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(12),-1)));
RQTY_100227_.old_tb6_5(12):=null;
RQTY_100227_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(12),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(12),
ENTITY_ID=RQTY_100227_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(12),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(12),
RQTY_100227_.tb6_1(12),
RQTY_100227_.tb6_2(12),
RQTY_100227_.tb6_3(12),
RQTY_100227_.tb6_4(12),
RQTY_100227_.tb6_5(12),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(9):=121381316;
RQTY_100227_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(9):=RQTY_100227_.tb2_0(9);
RQTY_100227_.old_tb2_1(9):='MO_INITATRIB_CT23E121381316'
;
RQTY_100227_.tb2_1(9):=RQTY_100227_.tb2_0(9);
RQTY_100227_.tb2_2(9):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(9),
RQTY_100227_.tb2_1(9),
RQTY_100227_.tb2_2(9),
'dtFechaReg = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dtFechaReg)'
,
'LBTEST'
,
to_date('11-08-2012 10:38:54','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:43','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:43','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(13):=105558;
RQTY_100227_.tb6_1(13):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(13):=17;
RQTY_100227_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(13),-1)));
RQTY_100227_.old_tb6_3(13):=259;
RQTY_100227_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(13),-1)));
RQTY_100227_.old_tb6_4(13):=null;
RQTY_100227_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(13),-1)));
RQTY_100227_.old_tb6_5(13):=null;
RQTY_100227_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(13),-1)));
RQTY_100227_.tb6_7(13):=RQTY_100227_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(13),
ENTITY_ID=RQTY_100227_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(13),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Fecha envío mensajes'
,
DISPLAY_ORDER=12,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(13),
RQTY_100227_.tb6_1(13),
RQTY_100227_.tb6_2(13),
RQTY_100227_.tb6_3(13),
RQTY_100227_.tb6_4(13),
RQTY_100227_.tb6_5(13),
null,
RQTY_100227_.tb6_7(13),
null,
null,
12,
'Fecha envío mensajes'
,
12,
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(10):=121381317;
RQTY_100227_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(10):=RQTY_100227_.tb2_0(10);
RQTY_100227_.old_tb2_1(10):='MO_INITATRIB_CT23E121381317'
;
RQTY_100227_.tb2_1(10):=RQTY_100227_.tb2_0(10);
RQTY_100227_.tb2_2(10):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(10),
RQTY_100227_.tb2_1(10),
RQTY_100227_.tb2_2(10),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);sbSubscription = "SUBSCRIPTION_ID";sbProduct = "PRODUCT_ID";sbNull = "null";if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",sbSubscriptionId);sbSubscription = UT_STRING.FSBCONCAT(sbSubscription, sbSubscriptionId, "=");if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "PRODUCT_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","PRODUCT_ID",sbProductId);sbProduct = UT_STRING.FSBCONCAT(sbProduct, sbProductId, "=");sbCadena = UT_STRING.FSBCONCAT(sbSubscription, sbProduct, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbCadena);,sbProduct = UT_STRING.FSBCONCAT(sbProduct, sbNull, "=");sbCadena = UT_STRING.FSBCONCAT(sbSubscription, sbProduct, "|");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(s' ||
'bCadena););,)'
,
'LBTEST'
,
to_date('11-08-2012 11:21:01','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:43','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:43','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PROCESS - VARCHAR_1 - Actualización de Datos de Usuario'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(14):=105559;
RQTY_100227_.tb6_1(14):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(14):=68;
RQTY_100227_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(14),-1)));
RQTY_100227_.old_tb6_3(14):=6732;
RQTY_100227_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(14),-1)));
RQTY_100227_.old_tb6_4(14):=null;
RQTY_100227_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(14),-1)));
RQTY_100227_.old_tb6_5(14):=null;
RQTY_100227_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(14),-1)));
RQTY_100227_.tb6_7(14):=RQTY_100227_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(14),
ENTITY_ID=RQTY_100227_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Información de Actualización'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='INFORMACION_DE_ACTUALIZACION'
,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(14),
RQTY_100227_.tb6_1(14),
RQTY_100227_.tb6_2(14),
RQTY_100227_.tb6_3(14),
RQTY_100227_.tb6_4(14),
RQTY_100227_.tb6_5(14),
null,
RQTY_100227_.tb6_7(14),
null,
null,
10,
'Información de Actualización'
,
10,
'Y'
,
'N'
,
'N'
,
'INFORMACION_DE_ACTUALIZACION'
,
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(15):=105560;
RQTY_100227_.tb6_1(15):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(15):=17;
RQTY_100227_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(15),-1)));
RQTY_100227_.old_tb6_3(15):=4015;
RQTY_100227_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(15),-1)));
RQTY_100227_.old_tb6_4(15):=793;
RQTY_100227_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(15),-1)));
RQTY_100227_.old_tb6_5(15):=null;
RQTY_100227_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(15),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(15),
ENTITY_ID=RQTY_100227_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(15),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(15),
RQTY_100227_.tb6_1(15),
RQTY_100227_.tb6_2(15),
RQTY_100227_.tb6_3(15),
RQTY_100227_.tb6_4(15),
RQTY_100227_.tb6_5(15),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb2_0(11):=121381307;
RQTY_100227_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100227_.tb2_0(11):=RQTY_100227_.tb2_0(11);
RQTY_100227_.old_tb2_1(11):='MO_INITATRIB_CT23E121381307'
;
RQTY_100227_.tb2_1(11):=RQTY_100227_.tb2_0(11);
RQTY_100227_.tb2_2(11):=RQTY_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100227_.tb2_0(11),
RQTY_100227_.tb2_1(11),
RQTY_100227_.tb2_2(11),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'LBTEST'
,
to_date('11-08-2012 10:09:51','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:39','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:36:39','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(16):=105544;
RQTY_100227_.tb6_1(16):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(16):=17;
RQTY_100227_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(16),-1)));
RQTY_100227_.old_tb6_3(16):=257;
RQTY_100227_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(16),-1)));
RQTY_100227_.old_tb6_4(16):=null;
RQTY_100227_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(16),-1)));
RQTY_100227_.old_tb6_5(16):=null;
RQTY_100227_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(16),-1)));
RQTY_100227_.tb6_7(16):=RQTY_100227_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(16),
ENTITY_ID=RQTY_100227_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100227_.tb6_7(16),
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(16),
RQTY_100227_.tb6_1(16),
RQTY_100227_.tb6_2(16),
RQTY_100227_.tb6_3(16),
RQTY_100227_.tb6_4(16),
RQTY_100227_.tb6_5(16),
null,
RQTY_100227_.tb6_7(16),
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
'Y'
);
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(17):=107519;
RQTY_100227_.tb6_1(17):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(17):=5864;
RQTY_100227_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(17),-1)));
RQTY_100227_.old_tb6_3(17):=90191174;
RQTY_100227_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(17),-1)));
RQTY_100227_.old_tb6_4(17):=255;
RQTY_100227_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(17),-1)));
RQTY_100227_.old_tb6_5(17):=null;
RQTY_100227_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(17),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(17),
ENTITY_ID=RQTY_100227_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Identificador de la Solicitud'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
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
ENTITY_NAME='LDC_UO_TRASLADO_PAGO'
,
ATTRI_TECHNICAL_NAME='PACKAGE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(17),
RQTY_100227_.tb6_1(17),
RQTY_100227_.tb6_2(17),
RQTY_100227_.tb6_3(17),
RQTY_100227_.tb6_4(17),
RQTY_100227_.tb6_5(17),
null,
null,
null,
null,
17,
'Identificador de la Solicitud'
,
17,
'N'
,
'N'
,
'Y'
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
'LDC_UO_TRASLADO_PAGO'
,
'PACKAGE_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.old_tb7_0(4):=120191279;
RQTY_100227_.tb7_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100227_.tb7_0(4):=RQTY_100227_.tb7_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100227_.tb7_0(4),
61,
'Unidad Operativa que Gestiona, parametro "LDC_UO_TRASLADO_PAGO"'
,
'SELECT  operating_unit_id id, 
        name description
FROM    open.or_operating_unit
WHERE   operating_unit_id IN (( SELECT to_number(regexp_substr(DALD_PARAMETER.FSBGETVALUE_CHAIN('|| chr(39) ||'LDC_UO_TRASLADO_PAGO'|| chr(39) ||', NULL),'|| chr(39) ||'[^,]+'|| chr(39) ||', 1, LEVEL)) AS activi
                                FROM   dual
                                CONNECT BY regexp_substr(DALD_PARAMETER.FSBGETVALUE_CHAIN('|| chr(39) ||'LDC_UO_TRASLADO_PAGO'|| chr(39) ||', NULL), '|| chr(39) ||'[^,]+'|| chr(39) ||', 1, LEVEL) IS NOT NULL
						  ))'
,
'Unidad Operativa que Gestiona'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb8_0(2):=RQTY_100227_.tb7_0(4);
RQTY_100227_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (2)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100227_.tb8_0(2),
null,
RQTY_100227_.clColumn_1,
null);

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb6_0(18):=107520;
RQTY_100227_.tb6_1(18):=RQTY_100227_.tb5_0(0);
RQTY_100227_.old_tb6_2(18):=5864;
RQTY_100227_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100227_.TBENTITYNAME(NVL(RQTY_100227_.old_tb6_2(18),-1)));
RQTY_100227_.old_tb6_3(18):=90191175;
RQTY_100227_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_3(18),-1)));
RQTY_100227_.old_tb6_4(18):=null;
RQTY_100227_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_4(18),-1)));
RQTY_100227_.old_tb6_5(18):=null;
RQTY_100227_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100227_.TBENTITYATTRIBUTENAME(NVL(RQTY_100227_.old_tb6_5(18),-1)));
RQTY_100227_.tb6_6(18):=RQTY_100227_.tb7_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100227_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_100227_.tb6_1(18),
ENTITY_ID=RQTY_100227_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_100227_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_100227_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_100227_.tb6_5(18),
STATEMENT_ID=RQTY_100227_.tb6_6(18),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Unidad Operativa que Gestiona'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='UNIDAD_OPERATIVA_QUE_GESTIONA'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='LDC_UO_TRASLADO_PAGO'
,
ATTRI_TECHNICAL_NAME='OPERATING_UNIT_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100227_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100227_.tb6_0(18),
RQTY_100227_.tb6_1(18),
RQTY_100227_.tb6_2(18),
RQTY_100227_.tb6_3(18),
RQTY_100227_.tb6_4(18),
RQTY_100227_.tb6_5(18),
RQTY_100227_.tb6_6(18),
null,
null,
null,
18,
'Unidad Operativa que Gestiona'
,
18,
'Y'
,
'N'
,
'Y'
,
'UNIDAD_OPERATIVA_QUE_GESTIONA'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'LDC_UO_TRASLADO_PAGO'
,
'OPERATING_UNIT_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb9_0(0):=17;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=RQTY_100227_.tb9_0(0),
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

 WHERE ATTRIBUTE_ID = RQTY_100227_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,VALID_EXPRESSION,FATHER_ID,ATTRIBUTE_TYPE_ID,MODULE_ID,ATTRIBUTE_CLASS_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (RQTY_100227_.tb9_0(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb10_0(0):=RQTY_100227_.tb5_0(0);
RQTY_100227_.tb10_1(0):=RQTY_100227_.tb9_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PACK_TYPE_PARAM fila (0)',1);
INSERT INTO PS_PACK_TYPE_PARAM(PACKAGE_TYPE_ID,ATTRIBUTE_ID,DESCRIPTION,VALUE,PARAMETER_ORDER,CLASS,RESTRICTION_TYPE) 
VALUES (RQTY_100227_.tb10_0(0),
RQTY_100227_.tb10_1(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb11_0(0):=10000000218;
RQTY_100227_.tb11_1(0):=RQTY_100227_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100227_.tb11_0(0),
PACKAGE_TYPE_ID=RQTY_100227_.tb11_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=100405,
INTERFACE_CONFIG_ID=21
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100227_.tb11_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100227_.tb11_0(0),
RQTY_100227_.tb11_1(0),
null,
null,
100405,
21);
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb12_0(0):=100218;
RQTY_100227_.tb12_1(0):=RQTY_100227_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=RQTY_100227_.tb12_0(0),
VALUE_1=RQTY_100227_.tb12_1(0),
VALUE_2=null,
INTERFACE_CONFIG_ID=21,
UNIT_TYPE_ID=100405,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Traslado de Pago a otro Contrato'
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
 WHERE ATTRIBUTES_EQUIV_ID = RQTY_100227_.tb12_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (RQTY_100227_.tb12_0(0),
RQTY_100227_.tb12_1(0),
null,
21,
100405,
0,
31536000,
0,
'Traslado de Pago a otro Contrato'
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb13_0(0):='5'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100227_.tb13_0(0),
'GENÉRICO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb14_0(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100227_.tb14_0(0),
'Genérico'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb15_0(0):=6121;
RQTY_100227_.tb15_2(0):=RQTY_100227_.tb13_0(0);
RQTY_100227_.tb15_3(0):=RQTY_100227_.tb14_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100227_.tb15_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100227_.tb15_2(0),
SERVSETI=RQTY_100227_.tb15_3(0),
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
 WHERE SERVCODI = RQTY_100227_.tb15_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100227_.tb15_0(0),
null,
RQTY_100227_.tb15_2(0),
RQTY_100227_.tb15_3(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb16_0(0):=75;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100227_.tb16_0(0),
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
 WHERE MOTIVE_TYPE_ID = RQTY_100227_.tb16_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100227_.tb16_0(0),
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb17_0(0):=100241;
RQTY_100227_.tb17_1(0):=RQTY_100227_.tb15_0(0);
RQTY_100227_.tb17_2(0):=RQTY_100227_.tb16_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100227_.tb17_0(0),
RQTY_100227_.tb17_1(0),
RQTY_100227_.tb17_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
,
'Traslado de Pago a otro Contrato'
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
RQTY_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;

RQTY_100227_.tb18_0(0):=100241;
RQTY_100227_.tb18_1(0):=RQTY_100227_.tb17_0(0);
RQTY_100227_.tb18_3(0):=RQTY_100227_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100227_.tb18_0(0),
PRODUCT_MOTIVE_ID=RQTY_100227_.tb18_1(0),
PRODUCT_TYPE_ID=6121,
PACKAGE_TYPE_ID=RQTY_100227_.tb18_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100227_.tb18_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100227_.tb18_0(0),
RQTY_100227_.tb18_1(0),
6121,
RQTY_100227_.tb18_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100227_.blProcessStatus := false;
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
nuIndex := RQTY_100227_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100227_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100227_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100227_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100227_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100227_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100227_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100227_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100227_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100227_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100227_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100227_.blProcessStatus := false;
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
 nuIndex := RQTY_100227_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100227_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100227_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100227_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100227_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100227_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100227_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100227_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100227_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100227_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100227_',
'CREATE OR REPLACE PACKAGE RQPMT_100227_ IS ' || chr(10) ||
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
'tb5_2 ty5_2;type ty6_0 is table of GE_STATEMENT_COLUMNS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
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
'where  package_type_id = 100227; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100227 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100227 ' || chr(10) ||
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
'END RQPMT_100227_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100227_******************************'); END;
/

BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100227_.cuExpressions;
fetch RQPMT_100227_.cuExpressions bulk collect INTO RQPMT_100227_.tbExpressionsId;
close RQPMT_100227_.cuExpressions;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100227_.tbEntityName(-1) := 'NULL';
   RQPMT_100227_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQPMT_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100227_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQPMT_100227_.tbEntityName(91) := 'SUSCRIPC';
   RQPMT_100227_.tbEntityAttributeName(897) := 'SUSCRIPC@SUSCCODI';
   RQPMT_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100227_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQPMT_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100227_.tbEntityAttributeName(2655) := 'MO_PROCESS@VALUE_4';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQPMT_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100227_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQPMT_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100227_.tbEntityAttributeName(39655) := 'MO_PROCESS@VALUE';
   RQPMT_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100227_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQPMT_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100227_.tbEntityAttributeName(443) := 'MO_PROCESS@APLICATION_DATE';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQPMT_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100227_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQPMT_100227_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQPMT_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100227_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100227_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100227
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
WHERE PACKAGE_type_id = 100227
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
WHERE PACKAGE_type_id = 100227
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
WHERE PACKAGE_type_id = 100227
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
WHERE PACKAGE_type_id = 100227
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
WHERE PACKAGE_type_id = 100227
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100227_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100227
))));

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100227_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100227_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100227_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100227_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100227
))));

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100227
))));

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100227_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100227_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100227
)))));

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100227_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100227_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100227_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100227_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100227_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100227_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100227
))));

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
))));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100227
))));

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
)));
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100227_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100227_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100227_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100227_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100227_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100227_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100227_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100227
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb0_0(0):=100241;
RQPMT_100227_.tb0_1(0):=6121;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100227_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100227_.tb0_1(0),
MOTIVE_TYPE_ID=75,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
,
DESCRIPTION='Traslado de Pago a otro Contrato'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100227_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100227_.tb0_0(0),
RQPMT_100227_.tb0_1(0),
75,
null,
'N'
,
'N'
,
'N'
,
'M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
,
'Traslado de Pago a otro Contrato'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb1_0(0):=120191275;
RQPMT_100227_.tb1_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100227_.tb1_0(0):=RQPMT_100227_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100227_.tb1_0(0),
5,
'Lista de Contratos'
,
'SELECT SUSCCODI ID, SUBSCRIBER_NAME||'|| chr(39) ||' '|| chr(39) ||'||SUBS_LAST_NAME DESCRIPTION
FROM suscripc, ge_subscriber
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'SUBSCRIBER_ID = suscclie'||chr(64)||'
'||chr(64)||'susccodi > 0'||chr(64)||'
'||chr(64)||'susccodi <> 99999999'||chr(64)||'
'||chr(64)||'SUSCCODI = :ID'||chr(64)||'
'||chr(64)||'SUBSCRIBER_NAME||'|| chr(39) ||' '|| chr(39) ||'||SUBS_LAST_NAME like :DESCRIPTION'||chr(64)||''
,
'Lista de Contratos'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(0):=103341;
RQPMT_100227_.old_tb2_1(0):=68;
RQPMT_100227_.tb2_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(0),-1)));
RQPMT_100227_.old_tb2_2(0):=39655;
RQPMT_100227_.tb2_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(0),-1)));
RQPMT_100227_.old_tb2_3(0):=null;
RQPMT_100227_.tb2_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(0),-1)));
RQPMT_100227_.old_tb2_4(0):=null;
RQPMT_100227_.tb2_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(0),-1)));
RQPMT_100227_.tb2_5(0):=RQPMT_100227_.tb1_0(0);
RQPMT_100227_.tb2_9(0):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(0),
ENTITY_ID=RQPMT_100227_.tb2_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(0),
STATEMENT_ID=RQPMT_100227_.tb2_5(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(0),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Contrato Destino'
,
DISPLAY_ORDER=10,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
USED_ASSIGNATION='N'
,
REQUIRED='Y'
,
TAG_NAME='CONTRATO_DESTINO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(0),
RQPMT_100227_.tb2_1(0),
RQPMT_100227_.tb2_2(0),
RQPMT_100227_.tb2_3(0),
RQPMT_100227_.tb2_4(0),
RQPMT_100227_.tb2_5(0),
null,
null,
null,
RQPMT_100227_.tb2_9(0),
10,
'Contrato Destino'
,
10,
'Y'
,
'N'
,
'N'
,
'Y'
,
'CONTRATO_DESTINO'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb1_0(1):=120191276;
RQPMT_100227_.tb1_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100227_.tb1_0(1):=RQPMT_100227_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100227_.tb1_0(1),
5,
'Lista Sucursal de Recaudo'
,
'SELECT subacodi ID, subanomb DESCRIPTION FROM sucubanc WHERE subacodi not like -1 AND subabanc = ge_boinstanceControl.fsbGetFieldValue('|| chr(39) ||'MO_PROCESS'|| chr(39) ||' , '|| chr(39) ||'VALUE_1'|| chr(39) ||')'
,
'Lista Sucursal de Recaudo'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(1):=103342;
RQPMT_100227_.old_tb2_1(1):=68;
RQPMT_100227_.tb2_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(1),-1)));
RQPMT_100227_.old_tb2_2(1):=6732;
RQPMT_100227_.tb2_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(1),-1)));
RQPMT_100227_.old_tb2_3(1):=null;
RQPMT_100227_.tb2_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(1),-1)));
RQPMT_100227_.old_tb2_4(1):=2558;
RQPMT_100227_.tb2_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(1),-1)));
RQPMT_100227_.tb2_5(1):=RQPMT_100227_.tb1_0(1);
RQPMT_100227_.tb2_9(1):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(1),
ENTITY_ID=RQPMT_100227_.tb2_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(1),
STATEMENT_ID=RQPMT_100227_.tb2_5(1),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(1),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Sucursal de Recaudo'
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
TAG_NAME='SUCURSAL_DE_RECAUDO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(1),
RQPMT_100227_.tb2_1(1),
RQPMT_100227_.tb2_2(1),
RQPMT_100227_.tb2_3(1),
RQPMT_100227_.tb2_4(1),
RQPMT_100227_.tb2_5(1),
null,
null,
null,
RQPMT_100227_.tb2_9(1),
12,
'Sucursal de Recaudo'
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
'SUCURSAL_DE_RECAUDO'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(2):=103343;
RQPMT_100227_.old_tb2_1(2):=21;
RQPMT_100227_.tb2_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(2),-1)));
RQPMT_100227_.old_tb2_2(2):=39322;
RQPMT_100227_.tb2_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(2),-1)));
RQPMT_100227_.old_tb2_3(2):=255;
RQPMT_100227_.tb2_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(2),-1)));
RQPMT_100227_.old_tb2_4(2):=null;
RQPMT_100227_.tb2_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(2),-1)));
RQPMT_100227_.tb2_9(2):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(2),
ENTITY_ID=RQPMT_100227_.tb2_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(2),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=16,
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(2),
RQPMT_100227_.tb2_1(2),
RQPMT_100227_.tb2_2(2),
RQPMT_100227_.tb2_3(2),
RQPMT_100227_.tb2_4(2),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(2),
16,
'Identificador De Solicitud'
,
16,
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(3):=103344;
RQPMT_100227_.old_tb2_1(3):=21;
RQPMT_100227_.tb2_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(3),-1)));
RQPMT_100227_.old_tb2_2(3):=281;
RQPMT_100227_.tb2_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(3),-1)));
RQPMT_100227_.old_tb2_3(3):=187;
RQPMT_100227_.tb2_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(3),-1)));
RQPMT_100227_.old_tb2_4(3):=null;
RQPMT_100227_.tb2_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(3),-1)));
RQPMT_100227_.tb2_9(3):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(3),
ENTITY_ID=RQPMT_100227_.tb2_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(3),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Consecutivo Interno Motivos'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(3),
RQPMT_100227_.tb2_1(3),
RQPMT_100227_.tb2_2(3),
RQPMT_100227_.tb2_3(3),
RQPMT_100227_.tb2_4(3),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(3),
17,
'Consecutivo Interno Motivos'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb3_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100227_.tb3_0(0),
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

 WHERE MODULE_ID = RQPMT_100227_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100227_.tb3_0(0),
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb4_0(0):=23;
RQPMT_100227_.tb4_1(0):=RQPMT_100227_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100227_.tb4_0(0),
MODULE_ID=RQPMT_100227_.tb4_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100227_.tb4_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100227_.tb4_0(0),
RQPMT_100227_.tb4_1(0),
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(0):=121381318;
RQPMT_100227_.tb5_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(0):=RQPMT_100227_.tb5_0(0);
RQPMT_100227_.old_tb5_1(0):='MO_INITATRIB_CT23E121381318'
;
RQPMT_100227_.tb5_1(0):=RQPMT_100227_.tb5_0(0);
RQPMT_100227_.tb5_2(0):=RQPMT_100227_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(0),
RQPMT_100227_.tb5_1(0),
RQPMT_100227_.tb5_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_MO_ADDRESS"))'
,
'LBTEST'
,
to_date('22-08-2012 13:44:45','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:51','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MO_ADDRESS - ADDRESS_ID - Inicializa la secuencia de la dirección de motivo'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(4):=103345;
RQPMT_100227_.old_tb2_1(4):=21;
RQPMT_100227_.tb2_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(4),-1)));
RQPMT_100227_.old_tb2_2(4):=474;
RQPMT_100227_.tb2_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(4),-1)));
RQPMT_100227_.old_tb2_3(4):=null;
RQPMT_100227_.tb2_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(4),-1)));
RQPMT_100227_.old_tb2_4(4):=null;
RQPMT_100227_.tb2_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(4),-1)));
RQPMT_100227_.tb2_6(4):=RQPMT_100227_.tb5_0(0);
RQPMT_100227_.tb2_9(4):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(4),
ENTITY_ID=RQPMT_100227_.tb2_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100227_.tb2_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(4),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Código de la Dirección'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(4),
RQPMT_100227_.tb2_1(4),
RQPMT_100227_.tb2_2(4),
RQPMT_100227_.tb2_3(4),
RQPMT_100227_.tb2_4(4),
null,
RQPMT_100227_.tb2_6(4),
null,
null,
RQPMT_100227_.tb2_9(4),
18,
'Código de la Dirección'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(5):=103258;
RQPMT_100227_.old_tb2_1(5):=8;
RQPMT_100227_.tb2_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(5),-1)));
RQPMT_100227_.old_tb2_2(5):=189;
RQPMT_100227_.tb2_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(5),-1)));
RQPMT_100227_.old_tb2_3(5):=257;
RQPMT_100227_.tb2_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(5),-1)));
RQPMT_100227_.old_tb2_4(5):=null;
RQPMT_100227_.tb2_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(5),-1)));
RQPMT_100227_.tb2_9(5):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(5),
ENTITY_ID=RQPMT_100227_.tb2_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(5),
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Solicitud atención al cliente'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(5),
RQPMT_100227_.tb2_1(5),
RQPMT_100227_.tb2_2(5),
RQPMT_100227_.tb2_3(5),
RQPMT_100227_.tb2_4(5),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(5),
0,
'Solicitud atención al cliente'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(6):=103259;
RQPMT_100227_.old_tb2_1(6):=8;
RQPMT_100227_.tb2_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(6),-1)));
RQPMT_100227_.old_tb2_2(6):=197;
RQPMT_100227_.tb2_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(6),-1)));
RQPMT_100227_.old_tb2_3(6):=null;
RQPMT_100227_.tb2_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(6),-1)));
RQPMT_100227_.old_tb2_4(6):=null;
RQPMT_100227_.tb2_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(6),-1)));
RQPMT_100227_.tb2_9(6):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(6),
ENTITY_ID=RQPMT_100227_.tb2_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(6),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Privado'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(6),
RQPMT_100227_.tb2_1(6),
RQPMT_100227_.tb2_2(6),
RQPMT_100227_.tb2_3(6),
RQPMT_100227_.tb2_4(6),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(6),
1,
'Privado'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(7):=103260;
RQPMT_100227_.old_tb2_1(7):=8;
RQPMT_100227_.tb2_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(7),-1)));
RQPMT_100227_.old_tb2_2(7):=2641;
RQPMT_100227_.tb2_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(7),-1)));
RQPMT_100227_.old_tb2_3(7):=null;
RQPMT_100227_.tb2_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(7),-1)));
RQPMT_100227_.old_tb2_4(7):=null;
RQPMT_100227_.tb2_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(7),-1)));
RQPMT_100227_.tb2_9(7):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(7),
ENTITY_ID=RQPMT_100227_.tb2_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(7),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Limite crédito'
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
TAG_NAME='LIMITE_CREDITO'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(7),
RQPMT_100227_.tb2_1(7),
RQPMT_100227_.tb2_2(7),
RQPMT_100227_.tb2_3(7),
RQPMT_100227_.tb2_4(7),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(7),
2,
'Limite crédito'
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
'LIMITE_CREDITO'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(8):=103261;
RQPMT_100227_.old_tb2_1(8):=8;
RQPMT_100227_.tb2_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(8),-1)));
RQPMT_100227_.old_tb2_2(8):=213;
RQPMT_100227_.tb2_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(8),-1)));
RQPMT_100227_.old_tb2_3(8):=255;
RQPMT_100227_.tb2_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(8),-1)));
RQPMT_100227_.old_tb2_4(8):=null;
RQPMT_100227_.tb2_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(8),-1)));
RQPMT_100227_.tb2_9(8):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(8),
ENTITY_ID=RQPMT_100227_.tb2_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(8),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(8),
RQPMT_100227_.tb2_1(8),
RQPMT_100227_.tb2_2(8),
RQPMT_100227_.tb2_3(8),
RQPMT_100227_.tb2_4(8),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(8),
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(1):=121381319;
RQPMT_100227_.tb5_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(1):=RQPMT_100227_.tb5_0(1);
RQPMT_100227_.old_tb5_1(1):='MO_INITATRIB_CT23E121381319'
;
RQPMT_100227_.tb5_1(1):=RQPMT_100227_.tb5_0(1);
RQPMT_100227_.tb5_2(1):=RQPMT_100227_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(1),
RQPMT_100227_.tb5_1(1),
RQPMT_100227_.tb5_2(1),
'nuMotiveID = MO_BOSEQUENCES.FNUGETMOTIVEID();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuMotiveID)'
,
'LBTEST'
,
to_date('11-08-2012 12:06:20','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:51','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:51','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(9):=103262;
RQPMT_100227_.old_tb2_1(9):=8;
RQPMT_100227_.tb2_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(9),-1)));
RQPMT_100227_.old_tb2_2(9):=187;
RQPMT_100227_.tb2_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(9),-1)));
RQPMT_100227_.old_tb2_3(9):=null;
RQPMT_100227_.tb2_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(9),-1)));
RQPMT_100227_.old_tb2_4(9):=null;
RQPMT_100227_.tb2_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(9),-1)));
RQPMT_100227_.tb2_6(9):=RQPMT_100227_.tb5_0(1);
RQPMT_100227_.tb2_9(9):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(9),
ENTITY_ID=RQPMT_100227_.tb2_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100227_.tb2_6(9),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(9),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Código'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(9),
RQPMT_100227_.tb2_1(9),
RQPMT_100227_.tb2_2(9),
RQPMT_100227_.tb2_3(9),
RQPMT_100227_.tb2_4(9),
null,
RQPMT_100227_.tb2_6(9),
null,
null,
RQPMT_100227_.tb2_9(9),
4,
'Código'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(2):=121381320;
RQPMT_100227_.tb5_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(2):=RQPMT_100227_.tb5_0(2);
RQPMT_100227_.old_tb5_1(2):='MO_INITATRIB_CT23E121381320'
;
RQPMT_100227_.tb5_1(2):=RQPMT_100227_.tb5_0(2);
RQPMT_100227_.tb5_2(2):=RQPMT_100227_.tb4_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(2),
RQPMT_100227_.tb5_1(2),
RQPMT_100227_.tb5_2(2),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_ADDRESS", "GEOGRAP_LOCATION_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_ADDRESS","GEOGRAP_LOCATION_ID",nuUbGeografica);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuUbGeografica);,);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, null, "MO_PREMISE", "GEOGRAP_LOCATION_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PREMISE","GEOGRAP_LOCATION_ID",nuUbGeografica);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuUbGeografica);,);if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "PR_PRODUCT", "GEOGRAP_LOCATION_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"PR_PRODUCT","GEOGRAP_LOCATION_ID",nuUbGeografica);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuUbGeografica);,)'
,
'CONFBOSS'
,
to_date('22-04-2004 15:39:00','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'CM - TP - LIBA - Obtener Ubicacion Geografica'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(10):=103263;
RQPMT_100227_.old_tb2_1(10):=8;
RQPMT_100227_.tb2_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(10),-1)));
RQPMT_100227_.old_tb2_2(10):=50001324;
RQPMT_100227_.tb2_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(10),-1)));
RQPMT_100227_.old_tb2_3(10):=null;
RQPMT_100227_.tb2_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(10),-1)));
RQPMT_100227_.old_tb2_4(10):=null;
RQPMT_100227_.tb2_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(10),-1)));
RQPMT_100227_.tb2_6(10):=RQPMT_100227_.tb5_0(2);
RQPMT_100227_.tb2_9(10):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(10),
ENTITY_ID=RQPMT_100227_.tb2_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100227_.tb2_6(10),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(10),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Ubicación geográfica'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(10),
RQPMT_100227_.tb2_1(10),
RQPMT_100227_.tb2_2(10),
RQPMT_100227_.tb2_3(10),
RQPMT_100227_.tb2_4(10),
null,
RQPMT_100227_.tb2_6(10),
null,
null,
RQPMT_100227_.tb2_9(10),
5,
'Ubicación geográfica'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(11):=103264;
RQPMT_100227_.old_tb2_1(11):=8;
RQPMT_100227_.tb2_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(11),-1)));
RQPMT_100227_.old_tb2_2(11):=6683;
RQPMT_100227_.tb2_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(11),-1)));
RQPMT_100227_.old_tb2_3(11):=null;
RQPMT_100227_.tb2_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(11),-1)));
RQPMT_100227_.old_tb2_4(11):=null;
RQPMT_100227_.tb2_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(11),-1)));
RQPMT_100227_.tb2_9(11):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(11),
ENTITY_ID=RQPMT_100227_.tb2_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(11),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Privado'
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
ATTRI_TECHNICAL_NAME='CLIENT_PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(11),
RQPMT_100227_.tb2_1(11),
RQPMT_100227_.tb2_2(11),
RQPMT_100227_.tb2_3(11),
RQPMT_100227_.tb2_4(11),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(11),
6,
'Privado'
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
'CLIENT_PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(12):=103265;
RQPMT_100227_.old_tb2_1(12):=8;
RQPMT_100227_.tb2_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(12),-1)));
RQPMT_100227_.old_tb2_2(12):=11403;
RQPMT_100227_.tb2_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(12),-1)));
RQPMT_100227_.old_tb2_3(12):=897;
RQPMT_100227_.tb2_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(12),-1)));
RQPMT_100227_.old_tb2_4(12):=null;
RQPMT_100227_.tb2_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(12),-1)));
RQPMT_100227_.tb2_9(12):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(12),
ENTITY_ID=RQPMT_100227_.tb2_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(12),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Contrato'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(12),
RQPMT_100227_.tb2_1(12),
RQPMT_100227_.tb2_2(12),
RQPMT_100227_.tb2_3(12),
RQPMT_100227_.tb2_4(12),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(12),
7,
'Contrato'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(13):=103266;
RQPMT_100227_.old_tb2_1(13):=8;
RQPMT_100227_.tb2_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(13),-1)));
RQPMT_100227_.old_tb2_2(13):=220;
RQPMT_100227_.tb2_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(13),-1)));
RQPMT_100227_.old_tb2_3(13):=null;
RQPMT_100227_.tb2_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(13),-1)));
RQPMT_100227_.old_tb2_4(13):=null;
RQPMT_100227_.tb2_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(13),-1)));
RQPMT_100227_.tb2_9(13):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(13),
ENTITY_ID=RQPMT_100227_.tb2_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(13),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Distribución administrativa'
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
TAG_NAME='DISTRIBUCION_ADMINISTRATIVA'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(13),
RQPMT_100227_.tb2_1(13),
RQPMT_100227_.tb2_2(13),
RQPMT_100227_.tb2_3(13),
RQPMT_100227_.tb2_4(13),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(13),
8,
'Distribución administrativa'
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
'DISTRIBUCION_ADMINISTRATIVA'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(14):=103267;
RQPMT_100227_.old_tb2_1(14):=8;
RQPMT_100227_.tb2_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(14),-1)));
RQPMT_100227_.old_tb2_2(14):=498;
RQPMT_100227_.tb2_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(14),-1)));
RQPMT_100227_.old_tb2_3(14):=null;
RQPMT_100227_.tb2_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(14),-1)));
RQPMT_100227_.old_tb2_4(14):=null;
RQPMT_100227_.tb2_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(14),-1)));
RQPMT_100227_.tb2_9(14):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(14),
ENTITY_ID=RQPMT_100227_.tb2_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(14),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Fecha atención'
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
TAG_NAME='FECHA_ATENCION'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(14),
RQPMT_100227_.tb2_1(14),
RQPMT_100227_.tb2_2(14),
RQPMT_100227_.tb2_3(14),
RQPMT_100227_.tb2_4(14),
null,
null,
null,
null,
RQPMT_100227_.tb2_9(14),
9,
'Fecha atención'
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
'FECHA_ATENCION'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb1_0(2):=120191277;
RQPMT_100227_.tb1_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100227_.tb1_0(2):=RQPMT_100227_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100227_.tb1_0(2),
5,
'Lista Entidades de Recaudo'
,
'SELECT banccodi ID, BANCNOMB Description FROM banco WHERE banccodi <> -1'
,
'Lista Entidades de Recaudo'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb6_0(0):=RQPMT_100227_.tb1_0(2);
RQPMT_100227_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
    <Length>40</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT_COLUMNS fila (0)',1);
UPDATE GE_STATEMENT_COLUMNS SET STATEMENT_ID=RQPMT_100227_.tb6_0(0),
WIZARD_COLUMNS=null,
SELECT_COLUMNS=RQPMT_100227_.clColumn_1,
LIST_VALUES=null
 WHERE STATEMENT_ID = RQPMT_100227_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQPMT_100227_.tb6_0(0),
null,
RQPMT_100227_.clColumn_1,
null);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(15):=103269;
RQPMT_100227_.old_tb2_1(15):=68;
RQPMT_100227_.tb2_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(15),-1)));
RQPMT_100227_.old_tb2_2(15):=2558;
RQPMT_100227_.tb2_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(15),-1)));
RQPMT_100227_.old_tb2_3(15):=null;
RQPMT_100227_.tb2_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(15),-1)));
RQPMT_100227_.old_tb2_4(15):=null;
RQPMT_100227_.tb2_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(15),-1)));
RQPMT_100227_.tb2_5(15):=RQPMT_100227_.tb1_0(2);
RQPMT_100227_.tb2_9(15):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(15),
ENTITY_ID=RQPMT_100227_.tb2_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(15),
STATEMENT_ID=RQPMT_100227_.tb2_5(15),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(15),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Entidad de Recaudo'
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
TAG_NAME='ENTIDAD_DE_RECAUDO'
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
ATTRI_TECHNICAL_NAME='VALUE_1'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(15),
RQPMT_100227_.tb2_1(15),
RQPMT_100227_.tb2_2(15),
RQPMT_100227_.tb2_3(15),
RQPMT_100227_.tb2_4(15),
RQPMT_100227_.tb2_5(15),
null,
null,
null,
RQPMT_100227_.tb2_9(15),
11,
'Entidad de Recaudo'
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
'ENTIDAD_DE_RECAUDO'
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
'VALUE_1'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb4_0(1):=26;
RQPMT_100227_.tb4_1(1):=RQPMT_100227_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100227_.tb4_0(1),
MODULE_ID=RQPMT_100227_.tb4_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100227_.tb4_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100227_.tb4_0(1),
RQPMT_100227_.tb4_1(1),
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(3):=121381321;
RQPMT_100227_.tb5_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(3):=RQPMT_100227_.tb5_0(3);
RQPMT_100227_.old_tb5_1(3):='MO_VALIDATTR_CT26E121381321'
;
RQPMT_100227_.tb5_1(3):=RQPMT_100227_.tb5_0(3);
RQPMT_100227_.tb5_2(3):=RQPMT_100227_.tb4_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(3),
RQPMT_100227_.tb5_1(3),
RQPMT_100227_.tb5_2(3),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbRegisDate);dtRegisDate = UT_CONVERT.FNUCHARTODATE(sbRegisDate);if (dtRegisDate > UT_DATE.FDTSYSDATE(),GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de pago no puede ser mayor a la fecha actual");,)'
,
'LBTEST'
,
to_date('11-08-2012 11:57:03','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MOT - MO_PROCESS - APPLICATION_DATE - Validación de fecha de aplicación de pago'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(16):=103271;
RQPMT_100227_.old_tb2_1(16):=68;
RQPMT_100227_.tb2_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(16),-1)));
RQPMT_100227_.old_tb2_2(16):=443;
RQPMT_100227_.tb2_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(16),-1)));
RQPMT_100227_.old_tb2_3(16):=null;
RQPMT_100227_.tb2_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(16),-1)));
RQPMT_100227_.old_tb2_4(16):=null;
RQPMT_100227_.tb2_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(16),-1)));
RQPMT_100227_.tb2_7(16):=RQPMT_100227_.tb5_0(3);
RQPMT_100227_.tb2_9(16):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(16),
ENTITY_ID=RQPMT_100227_.tb2_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100227_.tb2_7(16),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(16),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Fecha de Pago'
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
TAG_NAME='FECHA_DE_PAGO'
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
ATTRI_TECHNICAL_NAME='APLICATION_DATE'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(16),
RQPMT_100227_.tb2_1(16),
RQPMT_100227_.tb2_2(16),
RQPMT_100227_.tb2_3(16),
RQPMT_100227_.tb2_4(16),
null,
null,
RQPMT_100227_.tb2_7(16),
null,
RQPMT_100227_.tb2_9(16),
13,
'Fecha de Pago'
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
'FECHA_DE_PAGO'
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
'APLICATION_DATE'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(4):=121381322;
RQPMT_100227_.tb5_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(4):=RQPMT_100227_.tb5_0(4);
RQPMT_100227_.old_tb5_1(4):='MO_VALIDATTR_CT26E121381322'
;
RQPMT_100227_.tb5_1(4):=RQPMT_100227_.tb5_0(4);
RQPMT_100227_.tb5_2(4):=RQPMT_100227_.tb4_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(4),
RQPMT_100227_.tb5_1(4),
RQPMT_100227_.tb5_2(4),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbPayAmmount);nuPayAmmount = UT_CONVERT.fnuchartonumber(sbPayAmmount);IF (nuPayAmmount <= 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El pago debe ser mayor a 0");,)'
,
'LBTEST'
,
to_date('11-08-2012 12:00:46','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - MOT - MO_PROCESS - VALUE_4 - Valida que el pago sea mayor a 0'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(17):=103272;
RQPMT_100227_.old_tb2_1(17):=68;
RQPMT_100227_.tb2_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(17),-1)));
RQPMT_100227_.old_tb2_2(17):=2655;
RQPMT_100227_.tb2_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(17),-1)));
RQPMT_100227_.old_tb2_3(17):=null;
RQPMT_100227_.tb2_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(17),-1)));
RQPMT_100227_.old_tb2_4(17):=null;
RQPMT_100227_.tb2_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(17),-1)));
RQPMT_100227_.tb2_7(17):=RQPMT_100227_.tb5_0(4);
RQPMT_100227_.tb2_9(17):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(17),
ENTITY_ID=RQPMT_100227_.tb2_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQPMT_100227_.tb2_7(17),
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(17),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Valor del Pago'
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
TAG_NAME='VALOR_DEL_PAGO'
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
ATTRI_TECHNICAL_NAME='VALUE_4'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(17),
RQPMT_100227_.tb2_1(17),
RQPMT_100227_.tb2_2(17),
RQPMT_100227_.tb2_3(17),
RQPMT_100227_.tb2_4(17),
null,
null,
RQPMT_100227_.tb2_7(17),
null,
RQPMT_100227_.tb2_9(17),
14,
'Valor del Pago'
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
'VALOR_DEL_PAGO'
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
'VALUE_4'
,
'N'
,
'Y'
);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb1_0(3):=120191278;
RQPMT_100227_.tb1_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQPMT_100227_.tb1_0(3):=RQPMT_100227_.tb1_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQPMT_100227_.tb1_0(3),
5,
'Lista de Respuestas'
,
'SELECT b.answer_id ID, b.description DESCRIPTION
FROM cc_answer b
'||chr(64)||'WHERE'||chr(64)||'
'||chr(64)||'b.request_type_id = 100227 '||chr(64)||' --código del tipo de paquete
'||chr(64)||'b.is_immediate_attent = '|| chr(39) ||'Y'|| chr(39) ||' '||chr(64)||'
'||chr(64)||'b.answer_id = :ID '||chr(64)||'
'||chr(64)||'b.description like :DESCRIPTION '||chr(64)||''
,
'Lista de Respuestas'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb2_0(18):=103273;
RQPMT_100227_.old_tb2_1(18):=8;
RQPMT_100227_.tb2_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100227_.TBENTITYNAME(NVL(RQPMT_100227_.old_tb2_1(18),-1)));
RQPMT_100227_.old_tb2_2(18):=144591;
RQPMT_100227_.tb2_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_2(18),-1)));
RQPMT_100227_.old_tb2_3(18):=null;
RQPMT_100227_.tb2_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_3(18),-1)));
RQPMT_100227_.old_tb2_4(18):=null;
RQPMT_100227_.tb2_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100227_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100227_.old_tb2_4(18),-1)));
RQPMT_100227_.tb2_5(18):=RQPMT_100227_.tb1_0(3);
RQPMT_100227_.tb2_9(18):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100227_.tb2_0(18),
ENTITY_ID=RQPMT_100227_.tb2_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_100227_.tb2_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_100227_.tb2_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_100227_.tb2_4(18),
STATEMENT_ID=RQPMT_100227_.tb2_5(18),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb2_9(18),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Respuesta de Atención'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100227_.tb2_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100227_.tb2_0(18),
RQPMT_100227_.tb2_1(18),
RQPMT_100227_.tb2_2(18),
RQPMT_100227_.tb2_3(18),
RQPMT_100227_.tb2_4(18),
RQPMT_100227_.tb2_5(18),
null,
null,
null,
RQPMT_100227_.tb2_9(18),
15,
'Respuesta de Atención'
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb7_0(0):=10116;
RQPMT_100227_.tb7_1(0):=RQPMT_100227_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_EVENTS fila (0)',1);
UPDATE PS_PROD_MOTI_EVENTS SET PROD_MOTI_EVENTS_ID=RQPMT_100227_.tb7_0(0),
PRODUCT_MOTIVE_ID=RQPMT_100227_.tb7_1(0),
EVENT_ID=1
 WHERE PROD_MOTI_EVENTS_ID = RQPMT_100227_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_EVENTS(PROD_MOTI_EVENTS_ID,PRODUCT_MOTIVE_ID,EVENT_ID) 
VALUES (RQPMT_100227_.tb7_0(0),
RQPMT_100227_.tb7_1(0),
1);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb4_0(2):=65;
RQPMT_100227_.tb4_1(2):=RQPMT_100227_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100227_.tb4_0(2),
MODULE_ID=RQPMT_100227_.tb4_1(2),
DESCRIPTION='Configuraci¿n eventos de componentes'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EVE_COMP_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100227_.tb4_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100227_.tb4_0(2),
RQPMT_100227_.tb4_1(2),
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
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(5):=121381323;
RQPMT_100227_.tb5_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(5):=RQPMT_100227_.tb5_0(5);
RQPMT_100227_.old_tb5_1(5):='MO_EVE_COMP_CT65E121381323'
;
RQPMT_100227_.tb5_1(5):=RQPMT_100227_.tb5_0(5);
RQPMT_100227_.tb5_2(5):=RQPMT_100227_.tb4_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(5),
RQPMT_100227_.tb5_1(5),
RQPMT_100227_.tb5_2(5),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuContractId);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_MOTIVE","MOTIVE_ID",nuMotiveId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VALUE",nuDesSubscrId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VALUE_1",nuBancId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VARCHAR_1",nuSucursalId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","APLICATION_DATE",sbPaymentDate);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VALUE_4",nuPaymentAmmount);dtPaymentDate = ut_convert.fnuchartodate(sbPaymentDate);nuPaymentId = PKBOCONSULTASRECAUDOS.FNUSUBSCRIPTIONPAYMENT(nuContractId, nuBancId, nuSucursalId, dtPaymentDate, nuPaymentAmmount);MO_BODATACHANGE.INIT();MO_BODATACHANGE.ADDINSTANCEMOTDATACHANGE(sbInstance,nuMotiveI' ||
'd,"PAGOS",nuPaymentId,"PAGOSUSC",nuDesSubscrId,nuContractId);MO_BODATACHANGE.ADDINSTANCEMOTDATACHANGE(sbInstance,nuMotiveId,"PAGOS",nuPaymentId,"PAGOBANC",nuBancId,null);MO_BODATACHANGE.ADDINSTANCEMOTDATACHANGE(sbInstance,nuMotiveId,"PAGOS",nuPaymentId,"PAGOSUBA",nuSucursalId,null);MO_BODATACHANGE.ADDINSTANCEMOTDATACHANGE(sbInstance,nuMotiveId,"PAGOS",nuPaymentId,"PAGOFEPA",sbPaymentDate,null);MO_BODATACHANGE.ADDINSTANCEMOTDATACHANGE(sbInstance,nuMotiveId,"PAGOS",nuPaymentId,"PAGOVAPA",nuPaymentAmmount,null)'
,
'LBTEST'
,
to_date('21-08-2012 15:15:07','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'POS - MOT - carga datos de la instancia a MO_DATA_CHANGE'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb8_0(0):=10129;
RQPMT_100227_.tb8_1(0):=RQPMT_100227_.tb7_0(0);
RQPMT_100227_.tb8_2(0):=RQPMT_100227_.tb5_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (0)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100227_.tb8_0(0),
PROD_MOTI_EVENTS_ID=RQPMT_100227_.tb8_1(0),
CONFIG_EXPRESSION_ID=RQPMT_100227_.tb8_2(0),
EXECUTING_TIME='AF'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100227_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100227_.tb8_0(0),
RQPMT_100227_.tb8_1(0),
RQPMT_100227_.tb8_2(0),
'AF'
,
'Y'
);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.old_tb5_0(6):=121381324;
RQPMT_100227_.tb5_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100227_.tb5_0(6):=RQPMT_100227_.tb5_0(6);
RQPMT_100227_.old_tb5_1(6):='MO_EVE_COMP_CT65E121381324'
;
RQPMT_100227_.tb5_1(6):=RQPMT_100227_.tb5_0(6);
RQPMT_100227_.tb5_2(6):=RQPMT_100227_.tb4_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100227_.tb5_0(6),
RQPMT_100227_.tb5_1(6),
RQPMT_100227_.tb5_2(6),
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"SUSCRIPC","SUSCCODI",nuContractId);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VALUE_1",nuBancId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VARCHAR_1",nuSucursalId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","APLICATION_DATE",sbPaymentDate);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","VALUE_4",nuPaymentAmmount);dtPaymentDate = ut_convert.fnuchartodate(sbPaymentDate);nuPaymentId = PKBOCONSULTASRECAUDOS.FNUSUBSCRIPTIONPAYMENT(nuContractId, nuBancId, nuSucursalId, dtPaymentDate, nuPaymentAmmount);if (nuPaymentId = null,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No existe un pago en el contrato origen que cumpla con las condiciones dadas");,);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);if (GE_BOINSTANCECONTROL.fblacckeyattributestack(sbInstance, null, "MO_MOTIV' ||
'E", "SUBSCRIPTION_ID", "1") = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_MOTIVE","SUBSCRIPTION_ID",sbSuscId);nuSuscId = UT_CONVERT.FNUCHARTONUMBER(sbSuscId);nuAddressId = PKBODATA.FNUGETVALUE("SUSCRIPC", "SUSCIDDI", nuSuscId);CF_BOREGISTERRULESCRM.LOADADDRESS(sbInstance,nuAddressId);,)'
,
'LBTEST'
,
to_date('17-08-2012 08:09:18','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:53','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2022 14:37:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'PRE - MOT - Valida que exista pago asociado al contrato origen y Carga la dirección del contrato a MO_ADDRESS'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;

RQPMT_100227_.tb8_0(1):=10127;
RQPMT_100227_.tb8_1(1):=RQPMT_100227_.tb7_0(0);
RQPMT_100227_.tb8_2(1):=RQPMT_100227_.tb5_0(6);
ut_trace.trace('Actualizar o insertar tabla: PS_WHEN_MOTIVE fila (1)',1);
UPDATE PS_WHEN_MOTIVE SET WHEN_MOTIVE_ID=RQPMT_100227_.tb8_0(1),
PROD_MOTI_EVENTS_ID=RQPMT_100227_.tb8_1(1),
CONFIG_EXPRESSION_ID=RQPMT_100227_.tb8_2(1),
EXECUTING_TIME='B'
,
ACTIVE='Y'

 WHERE WHEN_MOTIVE_ID = RQPMT_100227_.tb8_0(1);
if not (sql%found) then
INSERT INTO PS_WHEN_MOTIVE(WHEN_MOTIVE_ID,PROD_MOTI_EVENTS_ID,CONFIG_EXPRESSION_ID,EXECUTING_TIME,ACTIVE) 
VALUES (RQPMT_100227_.tb8_0(1),
RQPMT_100227_.tb8_1(1),
RQPMT_100227_.tb8_2(1),
'B'
,
'Y'
);
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
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

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100227, sbSuccess);
FOR rc in RQPMT_100227_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
nuIndex := RQPMT_100227_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100227_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100227_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100227_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100227_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100227_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100227_.tb5_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100227_.tb5_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100227_.tb5_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100227_.tb5_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100227_.tb5_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100227_.blProcessStatus := false;
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
 nuIndex := RQPMT_100227_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100227_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100227_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100227_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100227_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100227_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100227_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100227_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100227_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100227_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100227_',
'CREATE OR REPLACE PACKAGE RQCFG_100227_ IS ' || chr(10) ||
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
'AND     external_root_id = 100227 ' || chr(10) ||
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
'END RQCFG_100227_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100227_******************************'); END;
/

BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100227_.cuCompositions;
fetch RQCFG_100227_.cuCompositions bulk collect INTO RQCFG_100227_.tbCompositions;
close RQCFG_100227_.cuCompositions;

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100227_.tbEntityName(-1) := 'NULL';
   RQCFG_100227_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100227_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100227_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100227_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100227_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100227_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(443) := 'MO_PROCESS@APLICATION_DATE';
   RQCFG_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100227_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(2655) := 'MO_PROCESS@VALUE_4';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100227_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(39655) := 'MO_PROCESS@VALUE';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQCFG_100227_.tbEntityAttributeName(90191174) := 'LDC_UO_TRASLADO_PAGO@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQCFG_100227_.tbEntityAttributeName(90191175) := 'LDC_UO_TRASLADO_PAGO@OPERATING_UNIT_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100227_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   RQCFG_100227_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   RQCFG_100227_.tbEntityName(91) := 'SUSCRIPC';
   RQCFG_100227_.tbEntityAttributeName(897) := 'SUSCRIPC@SUSCCODI';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQCFG_100227_.tbEntityAttributeName(90191174) := 'LDC_UO_TRASLADO_PAGO@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(5864) := 'LDC_UO_TRASLADO_PAGO';
   RQCFG_100227_.tbEntityAttributeName(90191175) := 'LDC_UO_TRASLADO_PAGO@OPERATING_UNIT_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100227_.tbEntityAttributeName(39322) := 'MO_ADDRESS@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(2655) := 'MO_PROCESS@VALUE_4';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(144591) := 'MO_MOTIVE@ANSWER_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100227_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(443) := 'MO_PROCESS@APLICATION_DATE';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(39655) := 'MO_PROCESS@VALUE';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100227_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100227_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100227_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100227_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100227_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100227_.tbEntityAttributeName(281) := 'MO_ADDRESS@MOTIVE_ID';
   RQCFG_100227_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100227_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100227_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100227_.tbEntityAttributeName(2558) := 'MO_PROCESS@VALUE_1';
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
AND     external_root_id = 100227
)
);
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100227_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100227, 4);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100227_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100227_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100227_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100227_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100227_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227))));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227)));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100227, 4);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100227_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227))));
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227))));
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227))));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227)));

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100227_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100227_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100227_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100227_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100227_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100227_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100227;

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb0_0(0):=9360;
RQCFG_100227_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100227_.tb0_0(0):=RQCFG_100227_.tb0_0(0);
RQCFG_100227_.old_tb0_2(0):=2012;
RQCFG_100227_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100227_.tb0_0(0),
100227,
RQCFG_100227_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb1_0(0):=1072447;
RQCFG_100227_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100227_.tb1_0(0):=RQCFG_100227_.tb1_0(0);
RQCFG_100227_.old_tb1_1(0):=100227;
RQCFG_100227_.tb1_1(0):=RQCFG_100227_.old_tb1_1(0);
RQCFG_100227_.old_tb1_2(0):=2012;
RQCFG_100227_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb1_2(0),-1)));
RQCFG_100227_.old_tb1_3(0):=9360;
RQCFG_100227_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb1_2(0),-1))), RQCFG_100227_.old_tb1_1(0), 4);
RQCFG_100227_.tb1_3(0):=RQCFG_100227_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100227_.tb1_0(0),
RQCFG_100227_.tb1_1(0),
RQCFG_100227_.tb1_2(0),
RQCFG_100227_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb2_0(0):=100027443;
RQCFG_100227_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100227_.tb2_0(0):=RQCFG_100227_.tb2_0(0);
RQCFG_100227_.tb2_1(0):=RQCFG_100227_.tb0_0(0);
RQCFG_100227_.tb2_2(0):=RQCFG_100227_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100227_.tb2_0(0),
RQCFG_100227_.tb2_1(0),
RQCFG_100227_.tb2_2(0),
null,
6121,
1,
1,
1);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb1_0(1):=1072448;
RQCFG_100227_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100227_.tb1_0(1):=RQCFG_100227_.tb1_0(1);
RQCFG_100227_.old_tb1_1(1):=100241;
RQCFG_100227_.tb1_1(1):=RQCFG_100227_.old_tb1_1(1);
RQCFG_100227_.old_tb1_2(1):=2013;
RQCFG_100227_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb1_2(1),-1)));
RQCFG_100227_.old_tb1_3(1):=null;
RQCFG_100227_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb1_2(1),-1))), RQCFG_100227_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100227_.tb1_0(1),
RQCFG_100227_.tb1_1(1),
RQCFG_100227_.tb1_2(1),
RQCFG_100227_.tb1_3(1),
null,
'M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
,
1,
1,
4);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb2_0(1):=100027444;
RQCFG_100227_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100227_.tb2_0(1):=RQCFG_100227_.tb2_0(1);
RQCFG_100227_.tb2_1(1):=RQCFG_100227_.tb0_0(0);
RQCFG_100227_.tb2_2(1):=RQCFG_100227_.tb1_0(1);
RQCFG_100227_.tb2_3(1):=RQCFG_100227_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100227_.tb2_0(1),
RQCFG_100227_.tb2_1(1),
RQCFG_100227_.tb2_2(1),
RQCFG_100227_.tb2_3(1),
6121,
2,
1,
1);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(0):=1171097;
RQCFG_100227_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(0):=RQCFG_100227_.tb3_0(0);
RQCFG_100227_.old_tb3_1(0):=3334;
RQCFG_100227_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(0),-1)));
RQCFG_100227_.old_tb3_2(0):=39322;
RQCFG_100227_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(0),-1)));
RQCFG_100227_.old_tb3_3(0):=255;
RQCFG_100227_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(0),-1)));
RQCFG_100227_.old_tb3_4(0):=null;
RQCFG_100227_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(0),-1)));
RQCFG_100227_.tb3_5(0):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(0):=null;
RQCFG_100227_.tb3_6(0):=NULL;
RQCFG_100227_.old_tb3_7(0):=null;
RQCFG_100227_.tb3_7(0):=NULL;
RQCFG_100227_.old_tb3_8(0):=null;
RQCFG_100227_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(0),
RQCFG_100227_.tb3_1(0),
RQCFG_100227_.tb3_2(0),
RQCFG_100227_.tb3_3(0),
RQCFG_100227_.tb3_4(0),
RQCFG_100227_.tb3_5(0),
RQCFG_100227_.tb3_6(0),
RQCFG_100227_.tb3_7(0),
RQCFG_100227_.tb3_8(0),
null,
103343,
16,
'Identificador De Solicitud'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb4_0(0):=7602;
RQCFG_100227_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100227_.tb4_0(0):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb4_1(0):=RQCFG_100227_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100227_.tb4_0(0),
RQCFG_100227_.tb4_1(0),
null,
null,
'FRAME-M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241-1072448'
,
2);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(0):=1679942;
RQCFG_100227_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(0):=RQCFG_100227_.tb5_0(0);
RQCFG_100227_.old_tb5_1(0):=39322;
RQCFG_100227_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(0),-1)));
RQCFG_100227_.old_tb5_2(0):=null;
RQCFG_100227_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(0),-1)));
RQCFG_100227_.tb5_3(0):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(0):=RQCFG_100227_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(0),
RQCFG_100227_.tb5_1(0),
RQCFG_100227_.tb5_2(0),
RQCFG_100227_.tb5_3(0),
RQCFG_100227_.tb5_4(0),
'C'
,
'Y'
,
16,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(1):=1171098;
RQCFG_100227_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(1):=RQCFG_100227_.tb3_0(1);
RQCFG_100227_.old_tb3_1(1):=3334;
RQCFG_100227_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(1),-1)));
RQCFG_100227_.old_tb3_2(1):=281;
RQCFG_100227_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(1),-1)));
RQCFG_100227_.old_tb3_3(1):=187;
RQCFG_100227_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(1),-1)));
RQCFG_100227_.old_tb3_4(1):=null;
RQCFG_100227_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(1),-1)));
RQCFG_100227_.tb3_5(1):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(1):=null;
RQCFG_100227_.tb3_6(1):=NULL;
RQCFG_100227_.old_tb3_7(1):=null;
RQCFG_100227_.tb3_7(1):=NULL;
RQCFG_100227_.old_tb3_8(1):=null;
RQCFG_100227_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(1),
RQCFG_100227_.tb3_1(1),
RQCFG_100227_.tb3_2(1),
RQCFG_100227_.tb3_3(1),
RQCFG_100227_.tb3_4(1),
RQCFG_100227_.tb3_5(1),
RQCFG_100227_.tb3_6(1),
RQCFG_100227_.tb3_7(1),
RQCFG_100227_.tb3_8(1),
null,
103344,
17,
'Consecutivo Interno Motivos'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(1):=1679943;
RQCFG_100227_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(1):=RQCFG_100227_.tb5_0(1);
RQCFG_100227_.old_tb5_1(1):=281;
RQCFG_100227_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(1),-1)));
RQCFG_100227_.old_tb5_2(1):=null;
RQCFG_100227_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(1),-1)));
RQCFG_100227_.tb5_3(1):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(1):=RQCFG_100227_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(1),
RQCFG_100227_.tb5_1(1),
RQCFG_100227_.tb5_2(1),
RQCFG_100227_.tb5_3(1),
RQCFG_100227_.tb5_4(1),
'C'
,
'Y'
,
17,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(2):=1171099;
RQCFG_100227_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(2):=RQCFG_100227_.tb3_0(2);
RQCFG_100227_.old_tb3_1(2):=3334;
RQCFG_100227_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(2),-1)));
RQCFG_100227_.old_tb3_2(2):=474;
RQCFG_100227_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(2),-1)));
RQCFG_100227_.old_tb3_3(2):=null;
RQCFG_100227_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(2),-1)));
RQCFG_100227_.old_tb3_4(2):=null;
RQCFG_100227_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(2),-1)));
RQCFG_100227_.tb3_5(2):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(2):=121381318;
RQCFG_100227_.tb3_6(2):=NULL;
RQCFG_100227_.old_tb3_7(2):=null;
RQCFG_100227_.tb3_7(2):=NULL;
RQCFG_100227_.old_tb3_8(2):=null;
RQCFG_100227_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(2),
RQCFG_100227_.tb3_1(2),
RQCFG_100227_.tb3_2(2),
RQCFG_100227_.tb3_3(2),
RQCFG_100227_.tb3_4(2),
RQCFG_100227_.tb3_5(2),
RQCFG_100227_.tb3_6(2),
RQCFG_100227_.tb3_7(2),
RQCFG_100227_.tb3_8(2),
null,
103345,
18,
'Código de la Dirección'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(2):=1679944;
RQCFG_100227_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(2):=RQCFG_100227_.tb5_0(2);
RQCFG_100227_.old_tb5_1(2):=474;
RQCFG_100227_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(2),-1)));
RQCFG_100227_.old_tb5_2(2):=null;
RQCFG_100227_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(2),-1)));
RQCFG_100227_.tb5_3(2):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(2):=RQCFG_100227_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(2),
RQCFG_100227_.tb5_1(2),
RQCFG_100227_.tb5_2(2),
RQCFG_100227_.tb5_3(2),
RQCFG_100227_.tb5_4(2),
'C'
,
'Y'
,
18,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(3):=1171100;
RQCFG_100227_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(3):=RQCFG_100227_.tb3_0(3);
RQCFG_100227_.old_tb3_1(3):=3334;
RQCFG_100227_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(3),-1)));
RQCFG_100227_.old_tb3_2(3):=189;
RQCFG_100227_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(3),-1)));
RQCFG_100227_.old_tb3_3(3):=257;
RQCFG_100227_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(3),-1)));
RQCFG_100227_.old_tb3_4(3):=null;
RQCFG_100227_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(3),-1)));
RQCFG_100227_.tb3_5(3):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(3):=null;
RQCFG_100227_.tb3_6(3):=NULL;
RQCFG_100227_.old_tb3_7(3):=null;
RQCFG_100227_.tb3_7(3):=NULL;
RQCFG_100227_.old_tb3_8(3):=null;
RQCFG_100227_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(3),
RQCFG_100227_.tb3_1(3),
RQCFG_100227_.tb3_2(3),
RQCFG_100227_.tb3_3(3),
RQCFG_100227_.tb3_4(3),
RQCFG_100227_.tb3_5(3),
RQCFG_100227_.tb3_6(3),
RQCFG_100227_.tb3_7(3),
RQCFG_100227_.tb3_8(3),
null,
103258,
0,
'Solicitud atención al cliente'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(3):=1679945;
RQCFG_100227_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(3):=RQCFG_100227_.tb5_0(3);
RQCFG_100227_.old_tb5_1(3):=189;
RQCFG_100227_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(3),-1)));
RQCFG_100227_.old_tb5_2(3):=null;
RQCFG_100227_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(3),-1)));
RQCFG_100227_.tb5_3(3):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(3):=RQCFG_100227_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(3),
RQCFG_100227_.tb5_1(3),
RQCFG_100227_.tb5_2(3),
RQCFG_100227_.tb5_3(3),
RQCFG_100227_.tb5_4(3),
'C'
,
'Y'
,
0,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(4):=1171101;
RQCFG_100227_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(4):=RQCFG_100227_.tb3_0(4);
RQCFG_100227_.old_tb3_1(4):=3334;
RQCFG_100227_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(4),-1)));
RQCFG_100227_.old_tb3_2(4):=197;
RQCFG_100227_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(4),-1)));
RQCFG_100227_.old_tb3_3(4):=null;
RQCFG_100227_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(4),-1)));
RQCFG_100227_.old_tb3_4(4):=null;
RQCFG_100227_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(4),-1)));
RQCFG_100227_.tb3_5(4):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(4):=null;
RQCFG_100227_.tb3_6(4):=NULL;
RQCFG_100227_.old_tb3_7(4):=null;
RQCFG_100227_.tb3_7(4):=NULL;
RQCFG_100227_.old_tb3_8(4):=null;
RQCFG_100227_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(4),
RQCFG_100227_.tb3_1(4),
RQCFG_100227_.tb3_2(4),
RQCFG_100227_.tb3_3(4),
RQCFG_100227_.tb3_4(4),
RQCFG_100227_.tb3_5(4),
RQCFG_100227_.tb3_6(4),
RQCFG_100227_.tb3_7(4),
RQCFG_100227_.tb3_8(4),
null,
103259,
1,
'Privado'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(4):=1679946;
RQCFG_100227_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(4):=RQCFG_100227_.tb5_0(4);
RQCFG_100227_.old_tb5_1(4):=197;
RQCFG_100227_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(4),-1)));
RQCFG_100227_.old_tb5_2(4):=null;
RQCFG_100227_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(4),-1)));
RQCFG_100227_.tb5_3(4):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(4):=RQCFG_100227_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(4),
RQCFG_100227_.tb5_1(4),
RQCFG_100227_.tb5_2(4),
RQCFG_100227_.tb5_3(4),
RQCFG_100227_.tb5_4(4),
'C'
,
'Y'
,
1,
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
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(5):=1171102;
RQCFG_100227_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(5):=RQCFG_100227_.tb3_0(5);
RQCFG_100227_.old_tb3_1(5):=3334;
RQCFG_100227_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(5),-1)));
RQCFG_100227_.old_tb3_2(5):=2641;
RQCFG_100227_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(5),-1)));
RQCFG_100227_.old_tb3_3(5):=null;
RQCFG_100227_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(5),-1)));
RQCFG_100227_.old_tb3_4(5):=null;
RQCFG_100227_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(5),-1)));
RQCFG_100227_.tb3_5(5):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(5):=null;
RQCFG_100227_.tb3_6(5):=NULL;
RQCFG_100227_.old_tb3_7(5):=null;
RQCFG_100227_.tb3_7(5):=NULL;
RQCFG_100227_.old_tb3_8(5):=null;
RQCFG_100227_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(5),
RQCFG_100227_.tb3_1(5),
RQCFG_100227_.tb3_2(5),
RQCFG_100227_.tb3_3(5),
RQCFG_100227_.tb3_4(5),
RQCFG_100227_.tb3_5(5),
RQCFG_100227_.tb3_6(5),
RQCFG_100227_.tb3_7(5),
RQCFG_100227_.tb3_8(5),
null,
103260,
2,
'Limite crédito'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(5):=1679947;
RQCFG_100227_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(5):=RQCFG_100227_.tb5_0(5);
RQCFG_100227_.old_tb5_1(5):=2641;
RQCFG_100227_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(5),-1)));
RQCFG_100227_.old_tb5_2(5):=null;
RQCFG_100227_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(5),-1)));
RQCFG_100227_.tb5_3(5):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(5):=RQCFG_100227_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(5),
RQCFG_100227_.tb5_1(5),
RQCFG_100227_.tb5_2(5),
RQCFG_100227_.tb5_3(5),
RQCFG_100227_.tb5_4(5),
'C'
,
'Y'
,
2,
'N'
,
'Limite crédito'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(6):=1171103;
RQCFG_100227_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(6):=RQCFG_100227_.tb3_0(6);
RQCFG_100227_.old_tb3_1(6):=3334;
RQCFG_100227_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(6),-1)));
RQCFG_100227_.old_tb3_2(6):=213;
RQCFG_100227_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(6),-1)));
RQCFG_100227_.old_tb3_3(6):=255;
RQCFG_100227_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(6),-1)));
RQCFG_100227_.old_tb3_4(6):=null;
RQCFG_100227_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(6),-1)));
RQCFG_100227_.tb3_5(6):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(6):=null;
RQCFG_100227_.tb3_6(6):=NULL;
RQCFG_100227_.old_tb3_7(6):=null;
RQCFG_100227_.tb3_7(6):=NULL;
RQCFG_100227_.old_tb3_8(6):=null;
RQCFG_100227_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(6),
RQCFG_100227_.tb3_1(6),
RQCFG_100227_.tb3_2(6),
RQCFG_100227_.tb3_3(6),
RQCFG_100227_.tb3_4(6),
RQCFG_100227_.tb3_5(6),
RQCFG_100227_.tb3_6(6),
RQCFG_100227_.tb3_7(6),
RQCFG_100227_.tb3_8(6),
null,
103261,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(6):=1679948;
RQCFG_100227_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(6):=RQCFG_100227_.tb5_0(6);
RQCFG_100227_.old_tb5_1(6):=213;
RQCFG_100227_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(6),-1)));
RQCFG_100227_.old_tb5_2(6):=null;
RQCFG_100227_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(6),-1)));
RQCFG_100227_.tb5_3(6):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(6):=RQCFG_100227_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(6),
RQCFG_100227_.tb5_1(6),
RQCFG_100227_.tb5_2(6),
RQCFG_100227_.tb5_3(6),
RQCFG_100227_.tb5_4(6),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(7):=1171104;
RQCFG_100227_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(7):=RQCFG_100227_.tb3_0(7);
RQCFG_100227_.old_tb3_1(7):=3334;
RQCFG_100227_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(7),-1)));
RQCFG_100227_.old_tb3_2(7):=187;
RQCFG_100227_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(7),-1)));
RQCFG_100227_.old_tb3_3(7):=null;
RQCFG_100227_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(7),-1)));
RQCFG_100227_.old_tb3_4(7):=null;
RQCFG_100227_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(7),-1)));
RQCFG_100227_.tb3_5(7):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(7):=121381319;
RQCFG_100227_.tb3_6(7):=NULL;
RQCFG_100227_.old_tb3_7(7):=null;
RQCFG_100227_.tb3_7(7):=NULL;
RQCFG_100227_.old_tb3_8(7):=null;
RQCFG_100227_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(7),
RQCFG_100227_.tb3_1(7),
RQCFG_100227_.tb3_2(7),
RQCFG_100227_.tb3_3(7),
RQCFG_100227_.tb3_4(7),
RQCFG_100227_.tb3_5(7),
RQCFG_100227_.tb3_6(7),
RQCFG_100227_.tb3_7(7),
RQCFG_100227_.tb3_8(7),
null,
103262,
4,
'Código'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(7):=1679949;
RQCFG_100227_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(7):=RQCFG_100227_.tb5_0(7);
RQCFG_100227_.old_tb5_1(7):=187;
RQCFG_100227_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(7),-1)));
RQCFG_100227_.old_tb5_2(7):=null;
RQCFG_100227_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(7),-1)));
RQCFG_100227_.tb5_3(7):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(7):=RQCFG_100227_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(7),
RQCFG_100227_.tb5_1(7),
RQCFG_100227_.tb5_2(7),
RQCFG_100227_.tb5_3(7),
RQCFG_100227_.tb5_4(7),
'C'
,
'Y'
,
4,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(8):=1171105;
RQCFG_100227_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(8):=RQCFG_100227_.tb3_0(8);
RQCFG_100227_.old_tb3_1(8):=3334;
RQCFG_100227_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(8),-1)));
RQCFG_100227_.old_tb3_2(8):=50001324;
RQCFG_100227_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(8),-1)));
RQCFG_100227_.old_tb3_3(8):=null;
RQCFG_100227_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(8),-1)));
RQCFG_100227_.old_tb3_4(8):=null;
RQCFG_100227_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(8),-1)));
RQCFG_100227_.tb3_5(8):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(8):=121381320;
RQCFG_100227_.tb3_6(8):=NULL;
RQCFG_100227_.old_tb3_7(8):=null;
RQCFG_100227_.tb3_7(8):=NULL;
RQCFG_100227_.old_tb3_8(8):=null;
RQCFG_100227_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(8),
RQCFG_100227_.tb3_1(8),
RQCFG_100227_.tb3_2(8),
RQCFG_100227_.tb3_3(8),
RQCFG_100227_.tb3_4(8),
RQCFG_100227_.tb3_5(8),
RQCFG_100227_.tb3_6(8),
RQCFG_100227_.tb3_7(8),
RQCFG_100227_.tb3_8(8),
null,
103263,
5,
'Ubicación geográfica'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(8):=1679950;
RQCFG_100227_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(8):=RQCFG_100227_.tb5_0(8);
RQCFG_100227_.old_tb5_1(8):=50001324;
RQCFG_100227_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(8),-1)));
RQCFG_100227_.old_tb5_2(8):=null;
RQCFG_100227_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(8),-1)));
RQCFG_100227_.tb5_3(8):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(8):=RQCFG_100227_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(8),
RQCFG_100227_.tb5_1(8),
RQCFG_100227_.tb5_2(8),
RQCFG_100227_.tb5_3(8),
RQCFG_100227_.tb5_4(8),
'C'
,
'Y'
,
5,
'N'
,
'Ubicación geográfica'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(9):=1171106;
RQCFG_100227_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(9):=RQCFG_100227_.tb3_0(9);
RQCFG_100227_.old_tb3_1(9):=3334;
RQCFG_100227_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(9),-1)));
RQCFG_100227_.old_tb3_2(9):=6683;
RQCFG_100227_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(9),-1)));
RQCFG_100227_.old_tb3_3(9):=null;
RQCFG_100227_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(9),-1)));
RQCFG_100227_.old_tb3_4(9):=null;
RQCFG_100227_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(9),-1)));
RQCFG_100227_.tb3_5(9):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(9):=null;
RQCFG_100227_.tb3_6(9):=NULL;
RQCFG_100227_.old_tb3_7(9):=null;
RQCFG_100227_.tb3_7(9):=NULL;
RQCFG_100227_.old_tb3_8(9):=null;
RQCFG_100227_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(9),
RQCFG_100227_.tb3_1(9),
RQCFG_100227_.tb3_2(9),
RQCFG_100227_.tb3_3(9),
RQCFG_100227_.tb3_4(9),
RQCFG_100227_.tb3_5(9),
RQCFG_100227_.tb3_6(9),
RQCFG_100227_.tb3_7(9),
RQCFG_100227_.tb3_8(9),
null,
103264,
6,
'Privado'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(9):=1679951;
RQCFG_100227_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(9):=RQCFG_100227_.tb5_0(9);
RQCFG_100227_.old_tb5_1(9):=6683;
RQCFG_100227_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(9),-1)));
RQCFG_100227_.old_tb5_2(9):=null;
RQCFG_100227_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(9),-1)));
RQCFG_100227_.tb5_3(9):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(9):=RQCFG_100227_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(9),
RQCFG_100227_.tb5_1(9),
RQCFG_100227_.tb5_2(9),
RQCFG_100227_.tb5_3(9),
RQCFG_100227_.tb5_4(9),
'C'
,
'Y'
,
6,
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
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(10):=1171107;
RQCFG_100227_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(10):=RQCFG_100227_.tb3_0(10);
RQCFG_100227_.old_tb3_1(10):=3334;
RQCFG_100227_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(10),-1)));
RQCFG_100227_.old_tb3_2(10):=11403;
RQCFG_100227_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(10),-1)));
RQCFG_100227_.old_tb3_3(10):=897;
RQCFG_100227_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(10),-1)));
RQCFG_100227_.old_tb3_4(10):=null;
RQCFG_100227_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(10),-1)));
RQCFG_100227_.tb3_5(10):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(10):=null;
RQCFG_100227_.tb3_6(10):=NULL;
RQCFG_100227_.old_tb3_7(10):=null;
RQCFG_100227_.tb3_7(10):=NULL;
RQCFG_100227_.old_tb3_8(10):=null;
RQCFG_100227_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(10),
RQCFG_100227_.tb3_1(10),
RQCFG_100227_.tb3_2(10),
RQCFG_100227_.tb3_3(10),
RQCFG_100227_.tb3_4(10),
RQCFG_100227_.tb3_5(10),
RQCFG_100227_.tb3_6(10),
RQCFG_100227_.tb3_7(10),
RQCFG_100227_.tb3_8(10),
null,
103265,
7,
'Contrato'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(10):=1679952;
RQCFG_100227_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(10):=RQCFG_100227_.tb5_0(10);
RQCFG_100227_.old_tb5_1(10):=11403;
RQCFG_100227_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(10),-1)));
RQCFG_100227_.old_tb5_2(10):=null;
RQCFG_100227_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(10),-1)));
RQCFG_100227_.tb5_3(10):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(10):=RQCFG_100227_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(10),
RQCFG_100227_.tb5_1(10),
RQCFG_100227_.tb5_2(10),
RQCFG_100227_.tb5_3(10),
RQCFG_100227_.tb5_4(10),
'C'
,
'Y'
,
7,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(11):=1171108;
RQCFG_100227_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(11):=RQCFG_100227_.tb3_0(11);
RQCFG_100227_.old_tb3_1(11):=3334;
RQCFG_100227_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(11),-1)));
RQCFG_100227_.old_tb3_2(11):=220;
RQCFG_100227_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(11),-1)));
RQCFG_100227_.old_tb3_3(11):=null;
RQCFG_100227_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(11),-1)));
RQCFG_100227_.old_tb3_4(11):=null;
RQCFG_100227_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(11),-1)));
RQCFG_100227_.tb3_5(11):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(11):=null;
RQCFG_100227_.tb3_6(11):=NULL;
RQCFG_100227_.old_tb3_7(11):=null;
RQCFG_100227_.tb3_7(11):=NULL;
RQCFG_100227_.old_tb3_8(11):=null;
RQCFG_100227_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(11),
RQCFG_100227_.tb3_1(11),
RQCFG_100227_.tb3_2(11),
RQCFG_100227_.tb3_3(11),
RQCFG_100227_.tb3_4(11),
RQCFG_100227_.tb3_5(11),
RQCFG_100227_.tb3_6(11),
RQCFG_100227_.tb3_7(11),
RQCFG_100227_.tb3_8(11),
null,
103266,
8,
'Distribución administrativa'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(11):=1679953;
RQCFG_100227_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(11):=RQCFG_100227_.tb5_0(11);
RQCFG_100227_.old_tb5_1(11):=220;
RQCFG_100227_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(11),-1)));
RQCFG_100227_.old_tb5_2(11):=null;
RQCFG_100227_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(11),-1)));
RQCFG_100227_.tb5_3(11):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(11):=RQCFG_100227_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(11),
RQCFG_100227_.tb5_1(11),
RQCFG_100227_.tb5_2(11),
RQCFG_100227_.tb5_3(11),
RQCFG_100227_.tb5_4(11),
'C'
,
'Y'
,
8,
'N'
,
'Distribución administrativa'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(12):=1171109;
RQCFG_100227_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(12):=RQCFG_100227_.tb3_0(12);
RQCFG_100227_.old_tb3_1(12):=3334;
RQCFG_100227_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(12),-1)));
RQCFG_100227_.old_tb3_2(12):=498;
RQCFG_100227_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(12),-1)));
RQCFG_100227_.old_tb3_3(12):=null;
RQCFG_100227_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(12),-1)));
RQCFG_100227_.old_tb3_4(12):=null;
RQCFG_100227_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(12),-1)));
RQCFG_100227_.tb3_5(12):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(12):=null;
RQCFG_100227_.tb3_6(12):=NULL;
RQCFG_100227_.old_tb3_7(12):=null;
RQCFG_100227_.tb3_7(12):=NULL;
RQCFG_100227_.old_tb3_8(12):=null;
RQCFG_100227_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(12),
RQCFG_100227_.tb3_1(12),
RQCFG_100227_.tb3_2(12),
RQCFG_100227_.tb3_3(12),
RQCFG_100227_.tb3_4(12),
RQCFG_100227_.tb3_5(12),
RQCFG_100227_.tb3_6(12),
RQCFG_100227_.tb3_7(12),
RQCFG_100227_.tb3_8(12),
null,
103267,
9,
'Fecha atención'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(12):=1679954;
RQCFG_100227_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(12):=RQCFG_100227_.tb5_0(12);
RQCFG_100227_.old_tb5_1(12):=498;
RQCFG_100227_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(12),-1)));
RQCFG_100227_.old_tb5_2(12):=null;
RQCFG_100227_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(12),-1)));
RQCFG_100227_.tb5_3(12):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(12):=RQCFG_100227_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(12),
RQCFG_100227_.tb5_1(12),
RQCFG_100227_.tb5_2(12),
RQCFG_100227_.tb5_3(12),
RQCFG_100227_.tb5_4(12),
'C'
,
'Y'
,
9,
'N'
,
'Fecha atención'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(13):=1171110;
RQCFG_100227_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(13):=RQCFG_100227_.tb3_0(13);
RQCFG_100227_.old_tb3_1(13):=3334;
RQCFG_100227_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(13),-1)));
RQCFG_100227_.old_tb3_2(13):=2558;
RQCFG_100227_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(13),-1)));
RQCFG_100227_.old_tb3_3(13):=null;
RQCFG_100227_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(13),-1)));
RQCFG_100227_.old_tb3_4(13):=null;
RQCFG_100227_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(13),-1)));
RQCFG_100227_.tb3_5(13):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(13):=null;
RQCFG_100227_.tb3_6(13):=NULL;
RQCFG_100227_.old_tb3_7(13):=null;
RQCFG_100227_.tb3_7(13):=NULL;
RQCFG_100227_.old_tb3_8(13):=120191277;
RQCFG_100227_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(13),
RQCFG_100227_.tb3_1(13),
RQCFG_100227_.tb3_2(13),
RQCFG_100227_.tb3_3(13),
RQCFG_100227_.tb3_4(13),
RQCFG_100227_.tb3_5(13),
RQCFG_100227_.tb3_6(13),
RQCFG_100227_.tb3_7(13),
RQCFG_100227_.tb3_8(13),
null,
103269,
11,
'Entidad de Recaudo'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(13):=1679955;
RQCFG_100227_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(13):=RQCFG_100227_.tb5_0(13);
RQCFG_100227_.old_tb5_1(13):=2558;
RQCFG_100227_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(13),-1)));
RQCFG_100227_.old_tb5_2(13):=null;
RQCFG_100227_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(13),-1)));
RQCFG_100227_.tb5_3(13):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(13):=RQCFG_100227_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(13),
RQCFG_100227_.tb5_1(13),
RQCFG_100227_.tb5_2(13),
RQCFG_100227_.tb5_3(13),
RQCFG_100227_.tb5_4(13),
'Y'
,
'Y'
,
11,
'Y'
,
'Entidad de Recaudo'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(14):=1171111;
RQCFG_100227_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(14):=RQCFG_100227_.tb3_0(14);
RQCFG_100227_.old_tb3_1(14):=3334;
RQCFG_100227_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(14),-1)));
RQCFG_100227_.old_tb3_2(14):=443;
RQCFG_100227_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(14),-1)));
RQCFG_100227_.old_tb3_3(14):=null;
RQCFG_100227_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(14),-1)));
RQCFG_100227_.old_tb3_4(14):=null;
RQCFG_100227_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(14),-1)));
RQCFG_100227_.tb3_5(14):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(14):=null;
RQCFG_100227_.tb3_6(14):=NULL;
RQCFG_100227_.old_tb3_7(14):=121381321;
RQCFG_100227_.tb3_7(14):=NULL;
RQCFG_100227_.old_tb3_8(14):=null;
RQCFG_100227_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(14),
RQCFG_100227_.tb3_1(14),
RQCFG_100227_.tb3_2(14),
RQCFG_100227_.tb3_3(14),
RQCFG_100227_.tb3_4(14),
RQCFG_100227_.tb3_5(14),
RQCFG_100227_.tb3_6(14),
RQCFG_100227_.tb3_7(14),
RQCFG_100227_.tb3_8(14),
null,
103271,
13,
'Fecha de Pago'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(14):=1679956;
RQCFG_100227_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(14):=RQCFG_100227_.tb5_0(14);
RQCFG_100227_.old_tb5_1(14):=443;
RQCFG_100227_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(14),-1)));
RQCFG_100227_.old_tb5_2(14):=null;
RQCFG_100227_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(14),-1)));
RQCFG_100227_.tb5_3(14):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(14):=RQCFG_100227_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(14),
RQCFG_100227_.tb5_1(14),
RQCFG_100227_.tb5_2(14),
RQCFG_100227_.tb5_3(14),
RQCFG_100227_.tb5_4(14),
'Y'
,
'Y'
,
13,
'Y'
,
'Fecha de Pago'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(15):=1171112;
RQCFG_100227_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(15):=RQCFG_100227_.tb3_0(15);
RQCFG_100227_.old_tb3_1(15):=3334;
RQCFG_100227_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(15),-1)));
RQCFG_100227_.old_tb3_2(15):=2655;
RQCFG_100227_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(15),-1)));
RQCFG_100227_.old_tb3_3(15):=null;
RQCFG_100227_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(15),-1)));
RQCFG_100227_.old_tb3_4(15):=null;
RQCFG_100227_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(15),-1)));
RQCFG_100227_.tb3_5(15):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(15):=null;
RQCFG_100227_.tb3_6(15):=NULL;
RQCFG_100227_.old_tb3_7(15):=121381322;
RQCFG_100227_.tb3_7(15):=NULL;
RQCFG_100227_.old_tb3_8(15):=null;
RQCFG_100227_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(15),
RQCFG_100227_.tb3_1(15),
RQCFG_100227_.tb3_2(15),
RQCFG_100227_.tb3_3(15),
RQCFG_100227_.tb3_4(15),
RQCFG_100227_.tb3_5(15),
RQCFG_100227_.tb3_6(15),
RQCFG_100227_.tb3_7(15),
RQCFG_100227_.tb3_8(15),
null,
103272,
14,
'Valor del Pago'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(15):=1679957;
RQCFG_100227_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(15):=RQCFG_100227_.tb5_0(15);
RQCFG_100227_.old_tb5_1(15):=2655;
RQCFG_100227_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(15),-1)));
RQCFG_100227_.old_tb5_2(15):=null;
RQCFG_100227_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(15),-1)));
RQCFG_100227_.tb5_3(15):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(15):=RQCFG_100227_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(15),
RQCFG_100227_.tb5_1(15),
RQCFG_100227_.tb5_2(15),
RQCFG_100227_.tb5_3(15),
RQCFG_100227_.tb5_4(15),
'Y'
,
'Y'
,
14,
'Y'
,
'Valor del Pago'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(16):=1171113;
RQCFG_100227_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(16):=RQCFG_100227_.tb3_0(16);
RQCFG_100227_.old_tb3_1(16):=3334;
RQCFG_100227_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(16),-1)));
RQCFG_100227_.old_tb3_2(16):=144591;
RQCFG_100227_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(16),-1)));
RQCFG_100227_.old_tb3_3(16):=null;
RQCFG_100227_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(16),-1)));
RQCFG_100227_.old_tb3_4(16):=null;
RQCFG_100227_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(16),-1)));
RQCFG_100227_.tb3_5(16):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(16):=null;
RQCFG_100227_.tb3_6(16):=NULL;
RQCFG_100227_.old_tb3_7(16):=null;
RQCFG_100227_.tb3_7(16):=NULL;
RQCFG_100227_.old_tb3_8(16):=120191278;
RQCFG_100227_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(16),
RQCFG_100227_.tb3_1(16),
RQCFG_100227_.tb3_2(16),
RQCFG_100227_.tb3_3(16),
RQCFG_100227_.tb3_4(16),
RQCFG_100227_.tb3_5(16),
RQCFG_100227_.tb3_6(16),
RQCFG_100227_.tb3_7(16),
RQCFG_100227_.tb3_8(16),
null,
103273,
15,
'Respuesta de Atención'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(16):=1679958;
RQCFG_100227_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(16):=RQCFG_100227_.tb5_0(16);
RQCFG_100227_.old_tb5_1(16):=144591;
RQCFG_100227_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(16),-1)));
RQCFG_100227_.old_tb5_2(16):=null;
RQCFG_100227_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(16),-1)));
RQCFG_100227_.tb5_3(16):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(16):=RQCFG_100227_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(16),
RQCFG_100227_.tb5_1(16),
RQCFG_100227_.tb5_2(16),
RQCFG_100227_.tb5_3(16),
RQCFG_100227_.tb5_4(16),
'Y'
,
'Y'
,
15,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(17):=1171114;
RQCFG_100227_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(17):=RQCFG_100227_.tb3_0(17);
RQCFG_100227_.old_tb3_1(17):=3334;
RQCFG_100227_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(17),-1)));
RQCFG_100227_.old_tb3_2(17):=39655;
RQCFG_100227_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(17),-1)));
RQCFG_100227_.old_tb3_3(17):=null;
RQCFG_100227_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(17),-1)));
RQCFG_100227_.old_tb3_4(17):=null;
RQCFG_100227_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(17),-1)));
RQCFG_100227_.tb3_5(17):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(17):=null;
RQCFG_100227_.tb3_6(17):=NULL;
RQCFG_100227_.old_tb3_7(17):=null;
RQCFG_100227_.tb3_7(17):=NULL;
RQCFG_100227_.old_tb3_8(17):=120191275;
RQCFG_100227_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(17),
RQCFG_100227_.tb3_1(17),
RQCFG_100227_.tb3_2(17),
RQCFG_100227_.tb3_3(17),
RQCFG_100227_.tb3_4(17),
RQCFG_100227_.tb3_5(17),
RQCFG_100227_.tb3_6(17),
RQCFG_100227_.tb3_7(17),
RQCFG_100227_.tb3_8(17),
null,
103341,
10,
'Contrato Destino'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(17):=1679959;
RQCFG_100227_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(17):=RQCFG_100227_.tb5_0(17);
RQCFG_100227_.old_tb5_1(17):=39655;
RQCFG_100227_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(17),-1)));
RQCFG_100227_.old_tb5_2(17):=null;
RQCFG_100227_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(17),-1)));
RQCFG_100227_.tb5_3(17):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(17):=RQCFG_100227_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(17),
RQCFG_100227_.tb5_1(17),
RQCFG_100227_.tb5_2(17),
RQCFG_100227_.tb5_3(17),
RQCFG_100227_.tb5_4(17),
'Y'
,
'Y'
,
10,
'Y'
,
'Contrato Destino'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(18):=1171115;
RQCFG_100227_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(18):=RQCFG_100227_.tb3_0(18);
RQCFG_100227_.old_tb3_1(18):=3334;
RQCFG_100227_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(18),-1)));
RQCFG_100227_.old_tb3_2(18):=6732;
RQCFG_100227_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(18),-1)));
RQCFG_100227_.old_tb3_3(18):=null;
RQCFG_100227_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(18),-1)));
RQCFG_100227_.old_tb3_4(18):=2558;
RQCFG_100227_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(18),-1)));
RQCFG_100227_.tb3_5(18):=RQCFG_100227_.tb2_2(1);
RQCFG_100227_.old_tb3_6(18):=null;
RQCFG_100227_.tb3_6(18):=NULL;
RQCFG_100227_.old_tb3_7(18):=null;
RQCFG_100227_.tb3_7(18):=NULL;
RQCFG_100227_.old_tb3_8(18):=120191276;
RQCFG_100227_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(18),
RQCFG_100227_.tb3_1(18),
RQCFG_100227_.tb3_2(18),
RQCFG_100227_.tb3_3(18),
RQCFG_100227_.tb3_4(18),
RQCFG_100227_.tb3_5(18),
RQCFG_100227_.tb3_6(18),
RQCFG_100227_.tb3_7(18),
RQCFG_100227_.tb3_8(18),
null,
103342,
12,
'Sucursal de Recaudo'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(18):=1679960;
RQCFG_100227_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(18):=RQCFG_100227_.tb5_0(18);
RQCFG_100227_.old_tb5_1(18):=6732;
RQCFG_100227_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(18),-1)));
RQCFG_100227_.old_tb5_2(18):=2558;
RQCFG_100227_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(18),-1)));
RQCFG_100227_.tb5_3(18):=RQCFG_100227_.tb4_0(0);
RQCFG_100227_.tb5_4(18):=RQCFG_100227_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(18),
RQCFG_100227_.tb5_1(18),
RQCFG_100227_.tb5_2(18),
RQCFG_100227_.tb5_3(18),
RQCFG_100227_.tb5_4(18),
'Y'
,
'Y'
,
12,
'Y'
,
'Sucursal de Recaudo'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(19):=1171116;
RQCFG_100227_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(19):=RQCFG_100227_.tb3_0(19);
RQCFG_100227_.old_tb3_1(19):=2036;
RQCFG_100227_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(19),-1)));
RQCFG_100227_.old_tb3_2(19):=50001162;
RQCFG_100227_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(19),-1)));
RQCFG_100227_.old_tb3_3(19):=null;
RQCFG_100227_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(19),-1)));
RQCFG_100227_.old_tb3_4(19):=null;
RQCFG_100227_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(19),-1)));
RQCFG_100227_.tb3_5(19):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(19):=121381310;
RQCFG_100227_.tb3_6(19):=NULL;
RQCFG_100227_.old_tb3_7(19):=null;
RQCFG_100227_.tb3_7(19):=NULL;
RQCFG_100227_.old_tb3_8(19):=120191271;
RQCFG_100227_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(19),
RQCFG_100227_.tb3_1(19),
RQCFG_100227_.tb3_2(19),
RQCFG_100227_.tb3_3(19),
RQCFG_100227_.tb3_4(19),
RQCFG_100227_.tb3_5(19),
RQCFG_100227_.tb3_6(19),
RQCFG_100227_.tb3_7(19),
RQCFG_100227_.tb3_8(19),
null,
105547,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb4_0(1):=7603;
RQCFG_100227_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100227_.tb4_0(1):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb4_1(1):=RQCFG_100227_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100227_.tb4_0(1),
RQCFG_100227_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1072447'
,
1);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(19):=1679961;
RQCFG_100227_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(19):=RQCFG_100227_.tb5_0(19);
RQCFG_100227_.old_tb5_1(19):=50001162;
RQCFG_100227_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(19),-1)));
RQCFG_100227_.old_tb5_2(19):=null;
RQCFG_100227_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(19),-1)));
RQCFG_100227_.tb5_3(19):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(19):=RQCFG_100227_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(19),
RQCFG_100227_.tb5_1(19),
RQCFG_100227_.tb5_2(19),
RQCFG_100227_.tb5_3(19),
RQCFG_100227_.tb5_4(19),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(20):=1171117;
RQCFG_100227_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(20):=RQCFG_100227_.tb3_0(20);
RQCFG_100227_.old_tb3_1(20):=2036;
RQCFG_100227_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(20),-1)));
RQCFG_100227_.old_tb3_2(20):=109479;
RQCFG_100227_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(20),-1)));
RQCFG_100227_.old_tb3_3(20):=null;
RQCFG_100227_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(20),-1)));
RQCFG_100227_.old_tb3_4(20):=null;
RQCFG_100227_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(20),-1)));
RQCFG_100227_.tb3_5(20):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(20):=121381311;
RQCFG_100227_.tb3_6(20):=NULL;
RQCFG_100227_.old_tb3_7(20):=null;
RQCFG_100227_.tb3_7(20):=NULL;
RQCFG_100227_.old_tb3_8(20):=120191272;
RQCFG_100227_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(20),
RQCFG_100227_.tb3_1(20),
RQCFG_100227_.tb3_2(20),
RQCFG_100227_.tb3_3(20),
RQCFG_100227_.tb3_4(20),
RQCFG_100227_.tb3_5(20),
RQCFG_100227_.tb3_6(20),
RQCFG_100227_.tb3_7(20),
RQCFG_100227_.tb3_8(20),
null,
105548,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(20):=1679962;
RQCFG_100227_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(20):=RQCFG_100227_.tb5_0(20);
RQCFG_100227_.old_tb5_1(20):=109479;
RQCFG_100227_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(20),-1)));
RQCFG_100227_.old_tb5_2(20):=null;
RQCFG_100227_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(20),-1)));
RQCFG_100227_.tb5_3(20):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(20):=RQCFG_100227_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(20),
RQCFG_100227_.tb5_1(20),
RQCFG_100227_.tb5_2(20),
RQCFG_100227_.tb5_3(20),
RQCFG_100227_.tb5_4(20),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(21):=1171118;
RQCFG_100227_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(21):=RQCFG_100227_.tb3_0(21);
RQCFG_100227_.old_tb3_1(21):=2036;
RQCFG_100227_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(21),-1)));
RQCFG_100227_.old_tb3_2(21):=2683;
RQCFG_100227_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(21),-1)));
RQCFG_100227_.old_tb3_3(21):=null;
RQCFG_100227_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(21),-1)));
RQCFG_100227_.old_tb3_4(21):=null;
RQCFG_100227_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(21),-1)));
RQCFG_100227_.tb3_5(21):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(21):=121381312;
RQCFG_100227_.tb3_6(21):=NULL;
RQCFG_100227_.old_tb3_7(21):=null;
RQCFG_100227_.tb3_7(21):=NULL;
RQCFG_100227_.old_tb3_8(21):=120191273;
RQCFG_100227_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(21),
RQCFG_100227_.tb3_1(21),
RQCFG_100227_.tb3_2(21),
RQCFG_100227_.tb3_3(21),
RQCFG_100227_.tb3_4(21),
RQCFG_100227_.tb3_5(21),
RQCFG_100227_.tb3_6(21),
RQCFG_100227_.tb3_7(21),
RQCFG_100227_.tb3_8(21),
null,
105549,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(21):=1679963;
RQCFG_100227_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(21):=RQCFG_100227_.tb5_0(21);
RQCFG_100227_.old_tb5_1(21):=2683;
RQCFG_100227_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(21),-1)));
RQCFG_100227_.old_tb5_2(21):=null;
RQCFG_100227_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(21),-1)));
RQCFG_100227_.tb5_3(21):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(21):=RQCFG_100227_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(21),
RQCFG_100227_.tb5_1(21),
RQCFG_100227_.tb5_2(21),
RQCFG_100227_.tb5_3(21),
RQCFG_100227_.tb5_4(21),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(22):=1171119;
RQCFG_100227_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(22):=RQCFG_100227_.tb3_0(22);
RQCFG_100227_.old_tb3_1(22):=2036;
RQCFG_100227_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(22),-1)));
RQCFG_100227_.old_tb3_2(22):=146755;
RQCFG_100227_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(22),-1)));
RQCFG_100227_.old_tb3_3(22):=null;
RQCFG_100227_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(22),-1)));
RQCFG_100227_.old_tb3_4(22):=null;
RQCFG_100227_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(22),-1)));
RQCFG_100227_.tb3_5(22):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(22):=121381313;
RQCFG_100227_.tb3_6(22):=NULL;
RQCFG_100227_.old_tb3_7(22):=null;
RQCFG_100227_.tb3_7(22):=NULL;
RQCFG_100227_.old_tb3_8(22):=null;
RQCFG_100227_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(22),
RQCFG_100227_.tb3_1(22),
RQCFG_100227_.tb3_2(22),
RQCFG_100227_.tb3_3(22),
RQCFG_100227_.tb3_4(22),
RQCFG_100227_.tb3_5(22),
RQCFG_100227_.tb3_6(22),
RQCFG_100227_.tb3_7(22),
RQCFG_100227_.tb3_8(22),
null,
105550,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(22):=1679964;
RQCFG_100227_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(22):=RQCFG_100227_.tb5_0(22);
RQCFG_100227_.old_tb5_1(22):=146755;
RQCFG_100227_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(22),-1)));
RQCFG_100227_.old_tb5_2(22):=null;
RQCFG_100227_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(22),-1)));
RQCFG_100227_.tb5_3(22):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(22):=RQCFG_100227_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(22),
RQCFG_100227_.tb5_1(22),
RQCFG_100227_.tb5_2(22),
RQCFG_100227_.tb5_3(22),
RQCFG_100227_.tb5_4(22),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(23):=1171120;
RQCFG_100227_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(23):=RQCFG_100227_.tb3_0(23);
RQCFG_100227_.old_tb3_1(23):=2036;
RQCFG_100227_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(23),-1)));
RQCFG_100227_.old_tb3_2(23):=146756;
RQCFG_100227_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(23),-1)));
RQCFG_100227_.old_tb3_3(23):=null;
RQCFG_100227_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(23),-1)));
RQCFG_100227_.old_tb3_4(23):=null;
RQCFG_100227_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(23),-1)));
RQCFG_100227_.tb3_5(23):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(23):=121381314;
RQCFG_100227_.tb3_6(23):=NULL;
RQCFG_100227_.old_tb3_7(23):=null;
RQCFG_100227_.tb3_7(23):=NULL;
RQCFG_100227_.old_tb3_8(23):=null;
RQCFG_100227_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(23),
RQCFG_100227_.tb3_1(23),
RQCFG_100227_.tb3_2(23),
RQCFG_100227_.tb3_3(23),
RQCFG_100227_.tb3_4(23),
RQCFG_100227_.tb3_5(23),
RQCFG_100227_.tb3_6(23),
RQCFG_100227_.tb3_7(23),
RQCFG_100227_.tb3_8(23),
null,
105551,
7,
'Dirección de Respuesta'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(23):=1679965;
RQCFG_100227_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(23):=RQCFG_100227_.tb5_0(23);
RQCFG_100227_.old_tb5_1(23):=146756;
RQCFG_100227_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(23),-1)));
RQCFG_100227_.old_tb5_2(23):=null;
RQCFG_100227_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(23),-1)));
RQCFG_100227_.tb5_3(23):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(23):=RQCFG_100227_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(23),
RQCFG_100227_.tb5_1(23),
RQCFG_100227_.tb5_2(23),
RQCFG_100227_.tb5_3(23),
RQCFG_100227_.tb5_4(23),
'Y'
,
'E'
,
7,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(24):=1171133;
RQCFG_100227_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(24):=RQCFG_100227_.tb3_0(24);
RQCFG_100227_.old_tb3_1(24):=2036;
RQCFG_100227_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(24),-1)));
RQCFG_100227_.old_tb3_2(24):=90191174;
RQCFG_100227_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(24),-1)));
RQCFG_100227_.old_tb3_3(24):=255;
RQCFG_100227_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(24),-1)));
RQCFG_100227_.old_tb3_4(24):=null;
RQCFG_100227_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(24),-1)));
RQCFG_100227_.tb3_5(24):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(24):=null;
RQCFG_100227_.tb3_6(24):=NULL;
RQCFG_100227_.old_tb3_7(24):=null;
RQCFG_100227_.tb3_7(24):=NULL;
RQCFG_100227_.old_tb3_8(24):=null;
RQCFG_100227_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(24),
RQCFG_100227_.tb3_1(24),
RQCFG_100227_.tb3_2(24),
RQCFG_100227_.tb3_3(24),
RQCFG_100227_.tb3_4(24),
RQCFG_100227_.tb3_5(24),
RQCFG_100227_.tb3_6(24),
RQCFG_100227_.tb3_7(24),
RQCFG_100227_.tb3_8(24),
null,
107519,
17,
'Identificador de la Solicitud'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(24):=1679978;
RQCFG_100227_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(24):=RQCFG_100227_.tb5_0(24);
RQCFG_100227_.old_tb5_1(24):=90191174;
RQCFG_100227_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(24),-1)));
RQCFG_100227_.old_tb5_2(24):=null;
RQCFG_100227_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(24),-1)));
RQCFG_100227_.tb5_3(24):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(24):=RQCFG_100227_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(24),
RQCFG_100227_.tb5_1(24),
RQCFG_100227_.tb5_2(24),
RQCFG_100227_.tb5_3(24),
RQCFG_100227_.tb5_4(24),
'C'
,
'Y'
,
17,
'Y'
,
'Identificador de la Solicitud'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(25):=1171134;
RQCFG_100227_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(25):=RQCFG_100227_.tb3_0(25);
RQCFG_100227_.old_tb3_1(25):=2036;
RQCFG_100227_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(25),-1)));
RQCFG_100227_.old_tb3_2(25):=90191175;
RQCFG_100227_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(25),-1)));
RQCFG_100227_.old_tb3_3(25):=null;
RQCFG_100227_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(25),-1)));
RQCFG_100227_.old_tb3_4(25):=null;
RQCFG_100227_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(25),-1)));
RQCFG_100227_.tb3_5(25):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(25):=null;
RQCFG_100227_.tb3_6(25):=NULL;
RQCFG_100227_.old_tb3_7(25):=null;
RQCFG_100227_.tb3_7(25):=NULL;
RQCFG_100227_.old_tb3_8(25):=120191279;
RQCFG_100227_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(25),
RQCFG_100227_.tb3_1(25),
RQCFG_100227_.tb3_2(25),
RQCFG_100227_.tb3_3(25),
RQCFG_100227_.tb3_4(25),
RQCFG_100227_.tb3_5(25),
RQCFG_100227_.tb3_6(25),
RQCFG_100227_.tb3_7(25),
RQCFG_100227_.tb3_8(25),
null,
107520,
18,
'Unidad Operativa que Gestiona'
,
'N'
,
'Y'
,
'Y'
,
18,
null,
null);

exception when others then
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(25):=1679979;
RQCFG_100227_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(25):=RQCFG_100227_.tb5_0(25);
RQCFG_100227_.old_tb5_1(25):=90191175;
RQCFG_100227_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(25),-1)));
RQCFG_100227_.old_tb5_2(25):=null;
RQCFG_100227_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(25),-1)));
RQCFG_100227_.tb5_3(25):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(25):=RQCFG_100227_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(25),
RQCFG_100227_.tb5_1(25),
RQCFG_100227_.tb5_2(25),
RQCFG_100227_.tb5_3(25),
RQCFG_100227_.tb5_4(25),
'Y'
,
'Y'
,
18,
'Y'
,
'Unidad Operativa que Gestiona'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(26):=1171121;
RQCFG_100227_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(26):=RQCFG_100227_.tb3_0(26);
RQCFG_100227_.old_tb3_1(26):=2036;
RQCFG_100227_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(26),-1)));
RQCFG_100227_.old_tb3_2(26):=146754;
RQCFG_100227_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(26),-1)));
RQCFG_100227_.old_tb3_3(26):=null;
RQCFG_100227_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(26),-1)));
RQCFG_100227_.old_tb3_4(26):=null;
RQCFG_100227_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(26),-1)));
RQCFG_100227_.tb3_5(26):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(26):=null;
RQCFG_100227_.tb3_6(26):=NULL;
RQCFG_100227_.old_tb3_7(26):=null;
RQCFG_100227_.tb3_7(26):=NULL;
RQCFG_100227_.old_tb3_8(26):=null;
RQCFG_100227_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(26),
RQCFG_100227_.tb3_1(26),
RQCFG_100227_.tb3_2(26),
RQCFG_100227_.tb3_3(26),
RQCFG_100227_.tb3_4(26),
RQCFG_100227_.tb3_5(26),
RQCFG_100227_.tb3_6(26),
RQCFG_100227_.tb3_7(26),
RQCFG_100227_.tb3_8(26),
null,
105552,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(26):=1679966;
RQCFG_100227_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(26):=RQCFG_100227_.tb5_0(26);
RQCFG_100227_.old_tb5_1(26):=146754;
RQCFG_100227_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(26),-1)));
RQCFG_100227_.old_tb5_2(26):=null;
RQCFG_100227_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(26),-1)));
RQCFG_100227_.tb5_3(26):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(26):=RQCFG_100227_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(26),
RQCFG_100227_.tb5_1(26),
RQCFG_100227_.tb5_2(26),
RQCFG_100227_.tb5_3(26),
RQCFG_100227_.tb5_4(26),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(27):=1171122;
RQCFG_100227_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(27):=RQCFG_100227_.tb3_0(27);
RQCFG_100227_.old_tb3_1(27):=2036;
RQCFG_100227_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(27),-1)));
RQCFG_100227_.old_tb3_2(27):=149340;
RQCFG_100227_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(27),-1)));
RQCFG_100227_.old_tb3_3(27):=null;
RQCFG_100227_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(27),-1)));
RQCFG_100227_.old_tb3_4(27):=null;
RQCFG_100227_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(27),-1)));
RQCFG_100227_.tb3_5(27):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(27):=null;
RQCFG_100227_.tb3_6(27):=NULL;
RQCFG_100227_.old_tb3_7(27):=null;
RQCFG_100227_.tb3_7(27):=NULL;
RQCFG_100227_.old_tb3_8(27):=120191274;
RQCFG_100227_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(27),
RQCFG_100227_.tb3_1(27),
RQCFG_100227_.tb3_2(27),
RQCFG_100227_.tb3_3(27),
RQCFG_100227_.tb3_4(27),
RQCFG_100227_.tb3_5(27),
RQCFG_100227_.tb3_6(27),
RQCFG_100227_.tb3_7(27),
RQCFG_100227_.tb3_8(27),
null,
105553,
9,
'Relación del solicitante con el predio'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(27):=1679967;
RQCFG_100227_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(27):=RQCFG_100227_.tb5_0(27);
RQCFG_100227_.old_tb5_1(27):=149340;
RQCFG_100227_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(27),-1)));
RQCFG_100227_.old_tb5_2(27):=null;
RQCFG_100227_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(27),-1)));
RQCFG_100227_.tb5_3(27):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(27):=RQCFG_100227_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(27),
RQCFG_100227_.tb5_1(27),
RQCFG_100227_.tb5_2(27),
RQCFG_100227_.tb5_3(27),
RQCFG_100227_.tb5_4(27),
'Y'
,
'Y'
,
9,
'Y'
,
'Relación del solicitante con el predio'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(28):=1171123;
RQCFG_100227_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(28):=RQCFG_100227_.tb3_0(28);
RQCFG_100227_.old_tb3_1(28):=2036;
RQCFG_100227_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(28),-1)));
RQCFG_100227_.old_tb3_2(28):=39387;
RQCFG_100227_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(28),-1)));
RQCFG_100227_.old_tb3_3(28):=255;
RQCFG_100227_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(28),-1)));
RQCFG_100227_.old_tb3_4(28):=null;
RQCFG_100227_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(28),-1)));
RQCFG_100227_.tb3_5(28):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(28):=null;
RQCFG_100227_.tb3_6(28):=NULL;
RQCFG_100227_.old_tb3_7(28):=null;
RQCFG_100227_.tb3_7(28):=NULL;
RQCFG_100227_.old_tb3_8(28):=null;
RQCFG_100227_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(28),
RQCFG_100227_.tb3_1(28),
RQCFG_100227_.tb3_2(28),
RQCFG_100227_.tb3_3(28),
RQCFG_100227_.tb3_4(28),
RQCFG_100227_.tb3_5(28),
RQCFG_100227_.tb3_6(28),
RQCFG_100227_.tb3_7(28),
RQCFG_100227_.tb3_8(28),
null,
105554,
14,
'Identificador De Solicitud'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(28):=1679968;
RQCFG_100227_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(28):=RQCFG_100227_.tb5_0(28);
RQCFG_100227_.old_tb5_1(28):=39387;
RQCFG_100227_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(28),-1)));
RQCFG_100227_.old_tb5_2(28):=null;
RQCFG_100227_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(28),-1)));
RQCFG_100227_.tb5_3(28):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(28):=RQCFG_100227_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(28),
RQCFG_100227_.tb5_1(28),
RQCFG_100227_.tb5_2(28),
RQCFG_100227_.tb5_3(28),
RQCFG_100227_.tb5_4(28),
'C'
,
'Y'
,
14,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(29):=1171124;
RQCFG_100227_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(29):=RQCFG_100227_.tb3_0(29);
RQCFG_100227_.old_tb3_1(29):=2036;
RQCFG_100227_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(29),-1)));
RQCFG_100227_.old_tb3_2(29):=50000603;
RQCFG_100227_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(29),-1)));
RQCFG_100227_.old_tb3_3(29):=null;
RQCFG_100227_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(29),-1)));
RQCFG_100227_.old_tb3_4(29):=null;
RQCFG_100227_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(29),-1)));
RQCFG_100227_.tb3_5(29):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(29):=121381315;
RQCFG_100227_.tb3_6(29):=NULL;
RQCFG_100227_.old_tb3_7(29):=null;
RQCFG_100227_.tb3_7(29):=NULL;
RQCFG_100227_.old_tb3_8(29):=null;
RQCFG_100227_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(29),
RQCFG_100227_.tb3_1(29),
RQCFG_100227_.tb3_2(29),
RQCFG_100227_.tb3_3(29),
RQCFG_100227_.tb3_4(29),
RQCFG_100227_.tb3_5(29),
RQCFG_100227_.tb3_6(29),
RQCFG_100227_.tb3_7(29),
RQCFG_100227_.tb3_8(29),
null,
105555,
13,
'Identificador de suscriptor por motivo'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(29):=1679969;
RQCFG_100227_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(29):=RQCFG_100227_.tb5_0(29);
RQCFG_100227_.old_tb5_1(29):=50000603;
RQCFG_100227_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(29),-1)));
RQCFG_100227_.old_tb5_2(29):=null;
RQCFG_100227_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(29),-1)));
RQCFG_100227_.tb5_3(29):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(29):=RQCFG_100227_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(29),
RQCFG_100227_.tb5_1(29),
RQCFG_100227_.tb5_2(29),
RQCFG_100227_.tb5_3(29),
RQCFG_100227_.tb5_4(29),
'C'
,
'Y'
,
13,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(30):=1171125;
RQCFG_100227_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(30):=RQCFG_100227_.tb3_0(30);
RQCFG_100227_.old_tb3_1(30):=2036;
RQCFG_100227_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(30),-1)));
RQCFG_100227_.old_tb3_2(30):=50000606;
RQCFG_100227_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(30),-1)));
RQCFG_100227_.old_tb3_3(30):=4015;
RQCFG_100227_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(30),-1)));
RQCFG_100227_.old_tb3_4(30):=null;
RQCFG_100227_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(30),-1)));
RQCFG_100227_.tb3_5(30):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(30):=null;
RQCFG_100227_.tb3_6(30):=NULL;
RQCFG_100227_.old_tb3_7(30):=null;
RQCFG_100227_.tb3_7(30):=NULL;
RQCFG_100227_.old_tb3_8(30):=null;
RQCFG_100227_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(30),
RQCFG_100227_.tb3_1(30),
RQCFG_100227_.tb3_2(30),
RQCFG_100227_.tb3_3(30),
RQCFG_100227_.tb3_4(30),
RQCFG_100227_.tb3_5(30),
RQCFG_100227_.tb3_6(30),
RQCFG_100227_.tb3_7(30),
RQCFG_100227_.tb3_8(30),
null,
105556,
16,
'Usuario del Servicio'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(30):=1679970;
RQCFG_100227_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(30):=RQCFG_100227_.tb5_0(30);
RQCFG_100227_.old_tb5_1(30):=50000606;
RQCFG_100227_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(30),-1)));
RQCFG_100227_.old_tb5_2(30):=null;
RQCFG_100227_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(30),-1)));
RQCFG_100227_.tb5_3(30):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(30):=RQCFG_100227_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(30),
RQCFG_100227_.tb5_1(30),
RQCFG_100227_.tb5_2(30),
RQCFG_100227_.tb5_3(30),
RQCFG_100227_.tb5_4(30),
'C'
,
'Y'
,
16,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(31):=1171126;
RQCFG_100227_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(31):=RQCFG_100227_.tb3_0(31);
RQCFG_100227_.old_tb3_1(31):=2036;
RQCFG_100227_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(31),-1)));
RQCFG_100227_.old_tb3_2(31):=42118;
RQCFG_100227_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(31),-1)));
RQCFG_100227_.old_tb3_3(31):=109479;
RQCFG_100227_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(31),-1)));
RQCFG_100227_.old_tb3_4(31):=null;
RQCFG_100227_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(31),-1)));
RQCFG_100227_.tb3_5(31):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(31):=null;
RQCFG_100227_.tb3_6(31):=NULL;
RQCFG_100227_.old_tb3_7(31):=null;
RQCFG_100227_.tb3_7(31):=NULL;
RQCFG_100227_.old_tb3_8(31):=null;
RQCFG_100227_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(31),
RQCFG_100227_.tb3_1(31),
RQCFG_100227_.tb3_2(31),
RQCFG_100227_.tb3_3(31),
RQCFG_100227_.tb3_4(31),
RQCFG_100227_.tb3_5(31),
RQCFG_100227_.tb3_6(31),
RQCFG_100227_.tb3_7(31),
RQCFG_100227_.tb3_8(31),
null,
105557,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(31):=1679971;
RQCFG_100227_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(31):=RQCFG_100227_.tb5_0(31);
RQCFG_100227_.old_tb5_1(31):=42118;
RQCFG_100227_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(31),-1)));
RQCFG_100227_.old_tb5_2(31):=null;
RQCFG_100227_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(31),-1)));
RQCFG_100227_.tb5_3(31):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(31):=RQCFG_100227_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(31),
RQCFG_100227_.tb5_1(31),
RQCFG_100227_.tb5_2(31),
RQCFG_100227_.tb5_3(31),
RQCFG_100227_.tb5_4(31),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(32):=1171127;
RQCFG_100227_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(32):=RQCFG_100227_.tb3_0(32);
RQCFG_100227_.old_tb3_1(32):=2036;
RQCFG_100227_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(32),-1)));
RQCFG_100227_.old_tb3_2(32):=259;
RQCFG_100227_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(32),-1)));
RQCFG_100227_.old_tb3_3(32):=null;
RQCFG_100227_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(32),-1)));
RQCFG_100227_.old_tb3_4(32):=null;
RQCFG_100227_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(32),-1)));
RQCFG_100227_.tb3_5(32):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(32):=121381316;
RQCFG_100227_.tb3_6(32):=NULL;
RQCFG_100227_.old_tb3_7(32):=null;
RQCFG_100227_.tb3_7(32):=NULL;
RQCFG_100227_.old_tb3_8(32):=null;
RQCFG_100227_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(32),
RQCFG_100227_.tb3_1(32),
RQCFG_100227_.tb3_2(32),
RQCFG_100227_.tb3_3(32),
RQCFG_100227_.tb3_4(32),
RQCFG_100227_.tb3_5(32),
RQCFG_100227_.tb3_6(32),
RQCFG_100227_.tb3_7(32),
RQCFG_100227_.tb3_8(32),
null,
105558,
12,
'Fecha envío mensajes'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(32):=1679972;
RQCFG_100227_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(32):=RQCFG_100227_.tb5_0(32);
RQCFG_100227_.old_tb5_1(32):=259;
RQCFG_100227_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(32),-1)));
RQCFG_100227_.old_tb5_2(32):=null;
RQCFG_100227_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(32),-1)));
RQCFG_100227_.tb5_3(32):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(32):=RQCFG_100227_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(32),
RQCFG_100227_.tb5_1(32),
RQCFG_100227_.tb5_2(32),
RQCFG_100227_.tb5_3(32),
RQCFG_100227_.tb5_4(32),
'C'
,
'Y'
,
12,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(33):=1171128;
RQCFG_100227_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(33):=RQCFG_100227_.tb3_0(33);
RQCFG_100227_.old_tb3_1(33):=2036;
RQCFG_100227_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(33),-1)));
RQCFG_100227_.old_tb3_2(33):=6732;
RQCFG_100227_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(33),-1)));
RQCFG_100227_.old_tb3_3(33):=null;
RQCFG_100227_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(33),-1)));
RQCFG_100227_.old_tb3_4(33):=null;
RQCFG_100227_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(33),-1)));
RQCFG_100227_.tb3_5(33):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(33):=121381317;
RQCFG_100227_.tb3_6(33):=NULL;
RQCFG_100227_.old_tb3_7(33):=null;
RQCFG_100227_.tb3_7(33):=NULL;
RQCFG_100227_.old_tb3_8(33):=null;
RQCFG_100227_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(33),
RQCFG_100227_.tb3_1(33),
RQCFG_100227_.tb3_2(33),
RQCFG_100227_.tb3_3(33),
RQCFG_100227_.tb3_4(33),
RQCFG_100227_.tb3_5(33),
RQCFG_100227_.tb3_6(33),
RQCFG_100227_.tb3_7(33),
RQCFG_100227_.tb3_8(33),
null,
105559,
10,
'Información de Actualización'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(33):=1679973;
RQCFG_100227_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(33):=RQCFG_100227_.tb5_0(33);
RQCFG_100227_.old_tb5_1(33):=6732;
RQCFG_100227_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(33),-1)));
RQCFG_100227_.old_tb5_2(33):=null;
RQCFG_100227_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(33),-1)));
RQCFG_100227_.tb5_3(33):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(33):=RQCFG_100227_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(33),
RQCFG_100227_.tb5_1(33),
RQCFG_100227_.tb5_2(33),
RQCFG_100227_.tb5_3(33),
RQCFG_100227_.tb5_4(33),
'Y'
,
'Y'
,
10,
'N'
,
'Información de Actualización'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(34):=1171129;
RQCFG_100227_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(34):=RQCFG_100227_.tb3_0(34);
RQCFG_100227_.old_tb3_1(34):=2036;
RQCFG_100227_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(34),-1)));
RQCFG_100227_.old_tb3_2(34):=4015;
RQCFG_100227_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(34),-1)));
RQCFG_100227_.old_tb3_3(34):=793;
RQCFG_100227_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(34),-1)));
RQCFG_100227_.old_tb3_4(34):=null;
RQCFG_100227_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(34),-1)));
RQCFG_100227_.tb3_5(34):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(34):=null;
RQCFG_100227_.tb3_6(34):=NULL;
RQCFG_100227_.old_tb3_7(34):=null;
RQCFG_100227_.tb3_7(34):=NULL;
RQCFG_100227_.old_tb3_8(34):=null;
RQCFG_100227_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(34),
RQCFG_100227_.tb3_1(34),
RQCFG_100227_.tb3_2(34),
RQCFG_100227_.tb3_3(34),
RQCFG_100227_.tb3_4(34),
RQCFG_100227_.tb3_5(34),
RQCFG_100227_.tb3_6(34),
RQCFG_100227_.tb3_7(34),
RQCFG_100227_.tb3_8(34),
null,
105560,
15,
'Suscriptor'
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(34):=1679974;
RQCFG_100227_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(34):=RQCFG_100227_.tb5_0(34);
RQCFG_100227_.old_tb5_1(34):=4015;
RQCFG_100227_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(34),-1)));
RQCFG_100227_.old_tb5_2(34):=null;
RQCFG_100227_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(34),-1)));
RQCFG_100227_.tb5_3(34):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(34):=RQCFG_100227_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(34),
RQCFG_100227_.tb5_1(34),
RQCFG_100227_.tb5_2(34),
RQCFG_100227_.tb5_3(34),
RQCFG_100227_.tb5_4(34),
'C'
,
'Y'
,
15,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(35):=1171130;
RQCFG_100227_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(35):=RQCFG_100227_.tb3_0(35);
RQCFG_100227_.old_tb3_1(35):=2036;
RQCFG_100227_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(35),-1)));
RQCFG_100227_.old_tb3_2(35):=257;
RQCFG_100227_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(35),-1)));
RQCFG_100227_.old_tb3_3(35):=null;
RQCFG_100227_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(35),-1)));
RQCFG_100227_.old_tb3_4(35):=null;
RQCFG_100227_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(35),-1)));
RQCFG_100227_.tb3_5(35):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(35):=121381307;
RQCFG_100227_.tb3_6(35):=NULL;
RQCFG_100227_.old_tb3_7(35):=null;
RQCFG_100227_.tb3_7(35):=NULL;
RQCFG_100227_.old_tb3_8(35):=null;
RQCFG_100227_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(35),
RQCFG_100227_.tb3_1(35),
RQCFG_100227_.tb3_2(35),
RQCFG_100227_.tb3_3(35),
RQCFG_100227_.tb3_4(35),
RQCFG_100227_.tb3_5(35),
RQCFG_100227_.tb3_6(35),
RQCFG_100227_.tb3_7(35),
RQCFG_100227_.tb3_8(35),
null,
105544,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(35):=1679975;
RQCFG_100227_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(35):=RQCFG_100227_.tb5_0(35);
RQCFG_100227_.old_tb5_1(35):=257;
RQCFG_100227_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(35),-1)));
RQCFG_100227_.old_tb5_2(35):=null;
RQCFG_100227_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(35),-1)));
RQCFG_100227_.tb5_3(35):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(35):=RQCFG_100227_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(35),
RQCFG_100227_.tb5_1(35),
RQCFG_100227_.tb5_2(35),
RQCFG_100227_.tb5_3(35),
RQCFG_100227_.tb5_4(35),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(36):=1171131;
RQCFG_100227_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(36):=RQCFG_100227_.tb3_0(36);
RQCFG_100227_.old_tb3_1(36):=2036;
RQCFG_100227_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(36),-1)));
RQCFG_100227_.old_tb3_2(36):=258;
RQCFG_100227_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(36),-1)));
RQCFG_100227_.old_tb3_3(36):=null;
RQCFG_100227_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(36),-1)));
RQCFG_100227_.old_tb3_4(36):=null;
RQCFG_100227_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(36),-1)));
RQCFG_100227_.tb3_5(36):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(36):=121381308;
RQCFG_100227_.tb3_6(36):=NULL;
RQCFG_100227_.old_tb3_7(36):=121381309;
RQCFG_100227_.tb3_7(36):=NULL;
RQCFG_100227_.old_tb3_8(36):=null;
RQCFG_100227_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(36),
RQCFG_100227_.tb3_1(36),
RQCFG_100227_.tb3_2(36),
RQCFG_100227_.tb3_3(36),
RQCFG_100227_.tb3_4(36),
RQCFG_100227_.tb3_5(36),
RQCFG_100227_.tb3_6(36),
RQCFG_100227_.tb3_7(36),
RQCFG_100227_.tb3_8(36),
null,
105545,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(36):=1679976;
RQCFG_100227_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(36):=RQCFG_100227_.tb5_0(36);
RQCFG_100227_.old_tb5_1(36):=258;
RQCFG_100227_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(36),-1)));
RQCFG_100227_.old_tb5_2(36):=null;
RQCFG_100227_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(36),-1)));
RQCFG_100227_.tb5_3(36):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(36):=RQCFG_100227_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(36),
RQCFG_100227_.tb5_1(36),
RQCFG_100227_.tb5_2(36),
RQCFG_100227_.tb5_3(36),
RQCFG_100227_.tb5_4(36),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb3_0(37):=1171132;
RQCFG_100227_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100227_.tb3_0(37):=RQCFG_100227_.tb3_0(37);
RQCFG_100227_.old_tb3_1(37):=2036;
RQCFG_100227_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100227_.TBENTITYNAME(NVL(RQCFG_100227_.old_tb3_1(37),-1)));
RQCFG_100227_.old_tb3_2(37):=255;
RQCFG_100227_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_2(37),-1)));
RQCFG_100227_.old_tb3_3(37):=null;
RQCFG_100227_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_3(37),-1)));
RQCFG_100227_.old_tb3_4(37):=null;
RQCFG_100227_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb3_4(37),-1)));
RQCFG_100227_.tb3_5(37):=RQCFG_100227_.tb2_2(0);
RQCFG_100227_.old_tb3_6(37):=null;
RQCFG_100227_.tb3_6(37):=NULL;
RQCFG_100227_.old_tb3_7(37):=null;
RQCFG_100227_.tb3_7(37):=NULL;
RQCFG_100227_.old_tb3_8(37):=null;
RQCFG_100227_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100227_.tb3_0(37),
RQCFG_100227_.tb3_1(37),
RQCFG_100227_.tb3_2(37),
RQCFG_100227_.tb3_3(37),
RQCFG_100227_.tb3_4(37),
RQCFG_100227_.tb3_5(37),
RQCFG_100227_.tb3_6(37),
RQCFG_100227_.tb3_7(37),
RQCFG_100227_.tb3_8(37),
null,
105546,
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100227_.blProcessStatus) then
 return;
end if;

RQCFG_100227_.old_tb5_0(37):=1679977;
RQCFG_100227_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100227_.tb5_0(37):=RQCFG_100227_.tb5_0(37);
RQCFG_100227_.old_tb5_1(37):=255;
RQCFG_100227_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_1(37),-1)));
RQCFG_100227_.old_tb5_2(37):=null;
RQCFG_100227_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100227_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100227_.old_tb5_2(37),-1)));
RQCFG_100227_.tb5_3(37):=RQCFG_100227_.tb4_0(1);
RQCFG_100227_.tb5_4(37):=RQCFG_100227_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100227_.tb5_0(37),
RQCFG_100227_.tb5_1(37),
RQCFG_100227_.tb5_2(37),
RQCFG_100227_.tb5_3(37),
RQCFG_100227_.tb5_4(37),
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
RQCFG_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100227);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100227)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100227_.blProcessStatus) then
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
AND     external_root_id = 100227
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
AND     external_root_id = 100227
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
AND     external_root_id = 100227
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100227, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100227)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100227, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100227)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100227, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100227)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100227, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100227)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100227_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100227_.tbCompositions.FIRST..RQCFG_100227_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100227_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100227_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100227_.blProcessStatus := false;
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
 nuIndex := RQCFG_100227_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100227_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100227_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100227_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100227_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100227_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100227_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100227_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100227_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100227_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100227_',
'CREATE OR REPLACE PACKAGE I18N_R_100227_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100227_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100227_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100227
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
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
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(0):='M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
;
I18N_R_100227_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(0),
I18N_R_100227_.tb0_1(0),
'WE8ISO8859P1'
,
'Traslado de Pago a otro Contrato'
,
'Traslado de Pago a otro Contrato'
,
null,
'Traslado de Pago a otro Contrato'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(1):='M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
;
I18N_R_100227_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(1),
I18N_R_100227_.tb0_1(1),
'WE8ISO8859P1'
,
'Traslado de Pago a otro Contrato'
,
'Traslado de Pago a otro Contrato'
,
null,
'Traslado de Pago a otro Contrato'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(2):='M_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100241'
;
I18N_R_100227_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(2),
I18N_R_100227_.tb0_1(2),
'WE8ISO8859P1'
,
'Traslado de Pago a otro Contrato'
,
'Traslado de Pago a otro Contrato'
,
null,
'Traslado de Pago a otro Contrato'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(3):='PAQUETE'
;
I18N_R_100227_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(3),
I18N_R_100227_.tb0_1(3),
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
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(4):='PAQUETE'
;
I18N_R_100227_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(4),
I18N_R_100227_.tb0_1(4),
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
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(5):='PAQUETE'
;
I18N_R_100227_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(5),
I18N_R_100227_.tb0_1(5),
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
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100227_.blProcessStatus) then
 return;
end if;

I18N_R_100227_.tb0_0(6):='PAQUETE'
;
I18N_R_100227_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100227_.tb0_0(6),
I18N_R_100227_.tb0_1(6),
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
I18N_R_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100227_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100227_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100227_',
'CREATE OR REPLACE PACKAGE RQEXEC_100227_ IS ' || chr(10) ||
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
'END RQEXEC_100227_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100227_******************************'); END;
/


BEGIN

if (not RQEXEC_100227_.blProcessStatus) then
 return;
end if;

RQEXEC_100227_.old_tb0_0(0):='P_TRASLADO_DE_PAGO_A_OTRO_CONTRATO_100227'
;
RQEXEC_100227_.tb0_0(0):=UPPER(RQEXEC_100227_.old_tb0_0(0));
RQEXEC_100227_.old_tb0_1(0):=200033;
RQEXEC_100227_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100227_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100227_.tb0_1(0):=RQEXEC_100227_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100227_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100227_.tb0_1(0),
DESCRIPTION='Traslado de Pago a otro Contrato'
,
PATH=null,
VERSION='58'
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
TIMES_EXECUTED=131,
EXEC_OWNER='O',
LAST_DATE_EXECUTED=to_date('28-03-2022 14:34:41','DD-MM-YYYY HH24:MI:SS'),
CLASS_ID=null
 WHERE EXECUTABLE_ID = RQEXEC_100227_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100227_.tb0_0(0),
RQEXEC_100227_.tb0_1(0),
'Traslado de Pago a otro Contrato'
,
null,
'58'
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
131,
'O',
to_date('28-03-2022 14:34:41','DD-MM-YYYY HH24:MI:SS'),
null);
end if;

exception when others then
RQEXEC_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100227_.blProcessStatus) then
 return;
end if;

RQEXEC_100227_.tb1_0(0):=1;
RQEXEC_100227_.tb1_1(0):=RQEXEC_100227_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100227_.tb1_0(0),
RQEXEC_100227_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100227_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100227_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100227_******************************'); end;
/

