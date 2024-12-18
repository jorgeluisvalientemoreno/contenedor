BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQTY_100268_',
'CREATE OR REPLACE PACKAGE RQTY_100268_ IS ' || chr(10) ||
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
'tb8_0 ty8_0;type ty9_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty11_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty11_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb11_2 ty11_2; ' || chr(10) ||
'tb11_2 ty11_2;type ty11_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb11_3 ty11_3; ' || chr(10) ||
'tb11_3 ty11_3;type ty12_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty13_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty13_1 is table of PS_PRODUCT_MOTIVE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_1 ty13_1; ' || chr(10) ||
'tb13_1 ty13_1;type ty13_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_2 ty13_2; ' || chr(10) ||
'tb13_2 ty13_2;type ty13_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_3 ty13_3; ' || chr(10) ||
'tb13_3 ty13_3;type ty14_0 is table of PS_PACKAGE_UNITTYPE.PACKAGE_UNITTYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_0 ty14_0; ' || chr(10) ||
'tb14_0 ty14_0;type ty14_1 is table of PS_PACKAGE_UNITTYPE.PACKAGE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_1 ty14_1; ' || chr(10) ||
'tb14_1 ty14_1;type ty14_2 is table of PS_PACKAGE_UNITTYPE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb14_2 ty14_2; ' || chr(10) ||
'tb14_2 ty14_2;type ty14_3 is table of PS_PACKAGE_UNITTYPE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
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
'WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100268 ' || chr(10) ||
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
'END RQTY_100268_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQTY_100268_******************************'); END;
/

BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
AND     external_root_id = 100268
)
);

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQTY_100268_.cuExpressions;
fetch RQTY_100268_.cuExpressions bulk collect INTO RQTY_100268_.tbExpressionsId;
close RQTY_100268_.cuExpressions;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQTY_100268_.tbEntityName(-1) := 'NULL';
   RQTY_100268_.tbEntityAttributeName(-1) := 'NULL';

   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQTY_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQTY_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(1037) := 'MO_PROCESS@ADDRESS_MAIN_COMP';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQTY_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100268_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(146751) := 'MO_PACKAGES@REFER_MODE_ID';
   RQTY_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100268_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQTY_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100268_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQTY_100268_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQTY_100268_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQTY_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100268_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQTY_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQTY_100268_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(191044) := 'MO_PACKAGES@RECURRENT_BILLING';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQTY_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100268_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQTY_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQTY_100268_.tbEntityAttributeName(90021316) := 'LD_FA_INFOADIC_REFERIDO@TIPOPREDIO';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQTY_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQTY_100268_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQTY_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQTY_100268_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQTY_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQTY_100268_.tbEntityAttributeName(90021317) := 'LD_FA_INFOADIC_REFERIDO@SUSCCODI';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQTY_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQTY_100268_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQTY_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQTY_100268_.tbEntityAttributeName(90021319) := 'LD_FA_INFOADIC_REFERIDO@ID_PACKAGES';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  --Obtiene Objetos Asociados a PS_PACKAGE_ATTRIBS y GE_ACTION_MODULE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ATTRIBS, GE_ACTION_MODULE
WHERE   PS_PACKAGE_ATTRIBS.package_type_id = 100268
AND     (GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.init_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ATTRIBS.valid_expression_id
OR      GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id)
union all
--Obtiene Objetos Asociados a GE_ATTRIBUTES
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PACK_TYPE_PARAM
WHERE   PS_PACK_TYPE_PARAM.package_type_id = 100268
AND     GE_ATTRIBUTES.attribute_id = PS_PACK_TYPE_PARAM.attribute_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression
union all
--Obtiene Objetos Asociados a PS_WHEN_PACKAGE
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_WHEN_PACKAGE, PS_PACKAGE_EVENTS
WHERE   PS_PACKAGE_EVENTS.package_type_id = 100268
AND     PS_PACKAGE_EVENTS.package_events_id = PS_WHEN_PACKAGE.package_event_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_WHEN_PACKAGE.config_expression_id
union all
--Obtiene Objetos Asociados a PS_PACKAGE_ACTION
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, PS_PACKAGE_ACTION
WHERE   PS_PACKAGE_ACTION.package_type_id = 100268
AND     GR_CONFIG_EXPRESSION.config_expression_id = PS_PACKAGE_ACTION.EXP_EXEC_ID
;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQTY_100268_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_REGIS_EXEC FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACKAGE_ATTRIBS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQTY_100268_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQTY_100268_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ATTRIBUTES WHERE (ATTRIBUTE_ID) in (SELECT ATTRIBUTE_ID FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_PARAM WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQTY_100268_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQTY_100268_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100268_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100268_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACK_TYPE_VALID WHERE (TAG_NAME) in (SELECT TAG_NAME FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
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
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_1) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268) AND INTERFACE_CONFIG_ID = 21;
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_WHEN_PACKAGE WHERE (PACKAGE_EVENT_ID) in (SELECT PACKAGE_EVENTS_ID FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACKAGE_EVENTS WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268))));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268))));

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SERVICIO WHERE (SERVCODI) in (SELECT PRODUCT_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SERVICIO',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbSERVICIORowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PRD_MOTIV_PACKAGE WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100268_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100268_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SERVICIO',1);
nuVarcharIndex:=RQTY_100268_.tbSERVICIORowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SERVICIO where rowid = RQTY_100268_.tbSERVICIORowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbSERVICIORowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbSERVICIORowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=RQTY_100268_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = RQTY_100268_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=RQTY_100268_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = RQTY_100268_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT EXP_EXEC_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268)));

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268));
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQTY_100268_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACKAGE_ACTION WHERE (PACKAGE_TYPE_ID) in (SELECT PACKAGE_TYPE_ID FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100268_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100268_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100268_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100268_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
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
FROM PS_PACKAGE_TYPE WHERE PACKAGE_TYPE_ID=100268;
nuIndex binary_integer;
BEGIN

if (not RQTY_100268_.blProcessStatus) then
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQTY_100268_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQTY_100268_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQTY_100268_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQTY_100268_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100268_.tb0_0(0),
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

 WHERE MODULE_ID = RQTY_100268_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100268_.tb0_0(0),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb1_0(0):=1;
RQTY_100268_.tb1_1(0):=RQTY_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100268_.tb1_0(0),
MODULE_ID=RQTY_100268_.tb1_1(0),
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100268_.tb1_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100268_.tb1_0(0),
RQTY_100268_.tb1_1(0),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(0):=121146291;
RQTY_100268_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(0):=RQTY_100268_.tb2_0(0);
RQTY_100268_.old_tb2_1(0):='GE_EXEACTION_CT1E121146291'
;
RQTY_100268_.tb2_1(0):=RQTY_100268_.tb2_0(0);
RQTY_100268_.tb2_2(0):=RQTY_100268_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(0),
RQTY_100268_.tb2_1(0),
RQTY_100268_.tb2_2(0),
'NUPACKAGEID = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();PKLD_FA_BCREGSOLREF.SALEREGISTER(NUPACKAGEID);MO_BOATTENTION.ACTCREATEPLANWF()'
,
'JRODRIGUEZ'
,
to_date('19-02-2013 16:17:34','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:10','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:10','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Generar Matricula'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb3_0(0):=8105;
RQTY_100268_.tb3_1(0):=RQTY_100268_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=RQTY_100268_.tb3_0(0),
CONFIG_EXPRESSION_ID=RQTY_100268_.tb3_1(0),
MODULE_ID=5,
DESCRIPTION='LD - FA - Solicitud Referido Matricula'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = RQTY_100268_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,CONFIG_EXPRESSION_ID,MODULE_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (RQTY_100268_.tb3_0(0),
RQTY_100268_.tb3_1(0),
5,
'LD - FA - Solicitud Referido Matricula'
,
'N'
,
'N'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb4_0(0):=RQTY_100268_.tb3_0(0);
RQTY_100268_.tb4_1(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (0)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100268_.tb4_0(0),
VALID_MODULE_ID=RQTY_100268_.tb4_1(0)
 WHERE ACTION_ID = RQTY_100268_.tb4_0(0) AND VALID_MODULE_ID = RQTY_100268_.tb4_1(0);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100268_.tb4_0(0),
RQTY_100268_.tb4_1(0));
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb4_0(1):=RQTY_100268_.tb3_0(0);
RQTY_100268_.tb4_1(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (1)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100268_.tb4_0(1),
VALID_MODULE_ID=RQTY_100268_.tb4_1(1)
 WHERE ACTION_ID = RQTY_100268_.tb4_0(1) AND VALID_MODULE_ID = RQTY_100268_.tb4_1(1);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100268_.tb4_0(1),
RQTY_100268_.tb4_1(1));
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb4_0(2):=RQTY_100268_.tb3_0(0);
RQTY_100268_.tb4_1(2):=16;
ut_trace.trace('Actualizar o insertar tabla: GE_VALID_ACTION_MODU fila (2)',1);
UPDATE GE_VALID_ACTION_MODU SET ACTION_ID=RQTY_100268_.tb4_0(2),
VALID_MODULE_ID=RQTY_100268_.tb4_1(2)
 WHERE ACTION_ID = RQTY_100268_.tb4_0(2) AND VALID_MODULE_ID = RQTY_100268_.tb4_1(2);
if not (sql%found) then
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (RQTY_100268_.tb4_0(2),
RQTY_100268_.tb4_1(2));
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb5_0(0):=100268;
RQTY_100268_.tb5_1(0):=RQTY_100268_.tb3_0(0);
RQTY_100268_.tb5_4(0):='P_LDC_VISITA_VENTA_GAS_XML_100268'
;
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_TYPE fila (0)',1);
UPDATE PS_PACKAGE_TYPE SET PACKAGE_TYPE_ID=RQTY_100268_.tb5_0(0),
ACTION_REGIS_EXEC=RQTY_100268_.tb5_1(0),
VALIDATE_XML_ID=null,
CLASS_REGISTER_ID=null,
TAG_NAME=RQTY_100268_.tb5_4(0),
DESCRIPTION='LDC VISITA VENTA GAS XML'
,
PROCESS_WITH_XML='Y'
,
INDICATOR_REGIS_EXEC='M'
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
 WHERE PACKAGE_TYPE_ID = RQTY_100268_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_TYPE(PACKAGE_TYPE_ID,ACTION_REGIS_EXEC,VALIDATE_XML_ID,CLASS_REGISTER_ID,TAG_NAME,DESCRIPTION,PROCESS_WITH_XML,INDICATOR_REGIS_EXEC,STAT_INI_REGIS_EXEC,PROCESS_WITH_WEB,ACTIVE,STATISTICS_INCLUDED,GESTIONABLE_REQUEST,IS_ANNULABLE,IS_DEMAND_REQUEST,ANSWER_REQUIRED,LIQUIDATION_METHOD) 
VALUES (RQTY_100268_.tb5_0(0),
RQTY_100268_.tb5_1(0),
null,
null,
RQTY_100268_.tb5_4(0),
'LDC VISITA VENTA GAS XML'
,
'Y'
,
'M'
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(0):=106729;
RQTY_100268_.tb6_1(0):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(0):=68;
RQTY_100268_.tb6_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(0),-1)));
RQTY_100268_.old_tb6_3(0):=1037;
RQTY_100268_.tb6_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(0),-1)));
RQTY_100268_.old_tb6_4(0):=null;
RQTY_100268_.tb6_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(0),-1)));
RQTY_100268_.old_tb6_5(0):=90021317;
RQTY_100268_.tb6_5(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (0)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(0),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(0),
ENTITY_ID=RQTY_100268_.tb6_2(0),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(0),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(0),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=34,
DISPLAY_NAME='Dirección'
,
DISPLAY_ORDER=34,
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
ATTRI_TECHNICAL_NAME='ADDRESS_MAIN_COMP'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(0),
RQTY_100268_.tb6_1(0),
RQTY_100268_.tb6_2(0),
RQTY_100268_.tb6_3(0),
RQTY_100268_.tb6_4(0),
RQTY_100268_.tb6_5(0),
null,
null,
null,
null,
34,
'Dirección'
,
34,
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
'ADDRESS_MAIN_COMP'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(1):=106730;
RQTY_100268_.tb6_1(1):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(1):=68;
RQTY_100268_.tb6_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(1),-1)));
RQTY_100268_.old_tb6_3(1):=20371;
RQTY_100268_.tb6_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(1),-1)));
RQTY_100268_.old_tb6_4(1):=null;
RQTY_100268_.tb6_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(1),-1)));
RQTY_100268_.old_tb6_5(1):=90021317;
RQTY_100268_.tb6_5(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(1),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (1)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(1),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(1),
ENTITY_ID=RQTY_100268_.tb6_2(1),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(1),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(1),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=35,
DISPLAY_NAME='Teléfono'
,
DISPLAY_ORDER=35,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='TELEFONO'
,
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(1);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(1),
RQTY_100268_.tb6_1(1),
RQTY_100268_.tb6_2(1),
RQTY_100268_.tb6_3(1),
RQTY_100268_.tb6_4(1),
RQTY_100268_.tb6_5(1),
null,
null,
null,
null,
35,
'Teléfono'
,
35,
'N'
,
'N'
,
'N'
,
'TELEFONO'
,
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
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb0_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=RQTY_100268_.tb0_0(1),
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

 WHERE MODULE_ID = RQTY_100268_.tb0_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQTY_100268_.tb0_0(1),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb1_0(1):=23;
RQTY_100268_.tb1_1(1):=RQTY_100268_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100268_.tb1_0(1),
MODULE_ID=RQTY_100268_.tb1_1(1),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100268_.tb1_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100268_.tb1_0(1),
RQTY_100268_.tb1_1(1),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(1):=121146292;
RQTY_100268_.tb2_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(1):=RQTY_100268_.tb2_0(1);
RQTY_100268_.old_tb2_1(1):='MO_INITATRIB_CT23E121146292'
;
RQTY_100268_.tb2_1(1):=RQTY_100268_.tb2_0(1);
RQTY_100268_.tb2_2(1):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(1),
RQTY_100268_.tb2_1(1),
RQTY_100268_.tb2_2(1),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETPETITIONID(null));)'
,
'OPEN'
,
to_date('10-07-2014 09:34:56','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:17','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:17','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(2):=106696;
RQTY_100268_.tb6_1(2):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(2):=17;
RQTY_100268_.tb6_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(2),-1)));
RQTY_100268_.old_tb6_3(2):=257;
RQTY_100268_.tb6_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(2),-1)));
RQTY_100268_.old_tb6_4(2):=null;
RQTY_100268_.tb6_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(2),-1)));
RQTY_100268_.old_tb6_5(2):=null;
RQTY_100268_.tb6_5(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(2),-1)));
RQTY_100268_.tb6_7(2):=RQTY_100268_.tb2_0(1);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (2)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(2),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(2),
ENTITY_ID=RQTY_100268_.tb6_2(2),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(2),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(2),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(2),
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(2);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(2),
RQTY_100268_.tb6_1(2),
RQTY_100268_.tb6_2(2),
RQTY_100268_.tb6_3(2),
RQTY_100268_.tb6_4(2),
RQTY_100268_.tb6_5(2),
null,
RQTY_100268_.tb6_7(2),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(2):=121146293;
RQTY_100268_.tb2_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(2):=RQTY_100268_.tb2_0(2);
RQTY_100268_.old_tb2_1(2):='MO_INITATRIB_CT23E121146293'
;
RQTY_100268_.tb2_1(2):=RQTY_100268_.tb2_0(2);
RQTY_100268_.tb2_2(2):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(2),
RQTY_100268_.tb2_1(2),
RQTY_100268_.tb2_2(2),
'CF_BOINITRULES.INIREQUESTDATE()'
,
'OPEN'
,
to_date('10-07-2014 09:34:57','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb1_0(2):=26;
RQTY_100268_.tb1_1(2):=RQTY_100268_.tb0_0(1);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (2)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQTY_100268_.tb1_0(2),
MODULE_ID=RQTY_100268_.tb1_1(2),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = RQTY_100268_.tb1_0(2);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQTY_100268_.tb1_0(2),
RQTY_100268_.tb1_1(2),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(3):=121146294;
RQTY_100268_.tb2_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(3):=RQTY_100268_.tb2_0(3);
RQTY_100268_.old_tb2_1(3):='MO_VALIDATTR_CT26E121146294'
;
RQTY_100268_.tb2_1(3):=RQTY_100268_.tb2_0(3);
RQTY_100268_.tb2_2(3):=RQTY_100268_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(3),
RQTY_100268_.tb2_1(3),
RQTY_100268_.tb2_2(3),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbReqDate);dtReqDate = UT_CONVERT.FNUCHARTODATE(sbReqDate);nuPsPacktype = 100232;nuParamAttribute = 17;nuMaxDays = UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPacktype, nuParamAttribute, GE_BOCONSTANTS.GETTRUE()));dtFechaAct = UT_DATE.FDTSYSDATE();nuDiasDiferencia = UT_DATE.FDTDIFFDATE(dtFechaAct, dtReqDate);if (dtReqDate > dtFechaAct,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No está permitido registrar una solicitud a futuro");,if (nuMaxDays <= 30,if (nuDiasDiferencia > nuMaxDays,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,);,if (nuDiasDiferencia > 30,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La fecha de registro está fuera del rango permitido para el tipo de solicitud");,););)'
,
'OPEN'
,
to_date('10-07-2014 09:34:57','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(3):=106697;
RQTY_100268_.tb6_1(3):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(3):=17;
RQTY_100268_.tb6_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(3),-1)));
RQTY_100268_.old_tb6_3(3):=258;
RQTY_100268_.tb6_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(3),-1)));
RQTY_100268_.old_tb6_4(3):=null;
RQTY_100268_.tb6_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(3),-1)));
RQTY_100268_.old_tb6_5(3):=null;
RQTY_100268_.tb6_5(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(3),-1)));
RQTY_100268_.tb6_7(3):=RQTY_100268_.tb2_0(2);
RQTY_100268_.tb6_8(3):=RQTY_100268_.tb2_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (3)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(3),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(3),
ENTITY_ID=RQTY_100268_.tb6_2(3),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(3),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(3),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(3),
VALID_EXPRESSION_ID=RQTY_100268_.tb6_8(3),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Fecha de Solicitud'
,
DISPLAY_ORDER=2,
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(3);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(3),
RQTY_100268_.tb6_1(3),
RQTY_100268_.tb6_2(3),
RQTY_100268_.tb6_3(3),
RQTY_100268_.tb6_4(3),
RQTY_100268_.tb6_5(3),
null,
RQTY_100268_.tb6_7(3),
RQTY_100268_.tb6_8(3),
null,
2,
'Fecha de Solicitud'
,
2,
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
'N'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(4):=106695;
RQTY_100268_.tb6_1(4):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(4):=17;
RQTY_100268_.tb6_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(4),-1)));
RQTY_100268_.old_tb6_3(4):=269;
RQTY_100268_.tb6_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(4),-1)));
RQTY_100268_.old_tb6_4(4):=null;
RQTY_100268_.tb6_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(4),-1)));
RQTY_100268_.old_tb6_5(4):=null;
RQTY_100268_.tb6_5(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(4),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (4)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(4),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(4),
ENTITY_ID=RQTY_100268_.tb6_2(4),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(4),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(4),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Código del Tipo de Paquete'
,
DISPLAY_ORDER=0,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(4);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(4),
RQTY_100268_.tb6_1(4),
RQTY_100268_.tb6_2(4),
RQTY_100268_.tb6_3(4),
RQTY_100268_.tb6_4(4),
RQTY_100268_.tb6_5(4),
null,
null,
null,
null,
0,
'Código del Tipo de Paquete'
,
0,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(4):=121146295;
RQTY_100268_.tb2_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(4):=RQTY_100268_.tb2_0(4);
RQTY_100268_.old_tb2_1(4):='MO_VALIDATTR_CT26E121146295'
;
RQTY_100268_.tb2_1(4):=RQTY_100268_.tb2_0(4);
RQTY_100268_.tb2_2(4):=RQTY_100268_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(4),
RQTY_100268_.tb2_1(4),
RQTY_100268_.tb2_2(4),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);GE_BOINSTANCECONTROL.ADDATTRIBUTE("WORK_INSTANCE",null,"MO_PACKAGES","PACKAGE_NEW_ID",sbValue,TRUE)'
,
'OPEN'
,
to_date('10-07-2014 09:34:57','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - Instancia Identificador del Paquete (Requerido para generar la notificación)'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(5):=106698;
RQTY_100268_.tb6_1(5):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(5):=17;
RQTY_100268_.tb6_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(5),-1)));
RQTY_100268_.old_tb6_3(5):=255;
RQTY_100268_.tb6_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(5),-1)));
RQTY_100268_.old_tb6_4(5):=null;
RQTY_100268_.tb6_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(5),-1)));
RQTY_100268_.old_tb6_5(5):=null;
RQTY_100268_.tb6_5(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(5),-1)));
RQTY_100268_.tb6_8(5):=RQTY_100268_.tb2_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (5)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(5),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(5),
ENTITY_ID=RQTY_100268_.tb6_2(5),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(5),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(5),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100268_.tb6_8(5),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Número de Solicitud'
,
DISPLAY_ORDER=3,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(5);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(5),
RQTY_100268_.tb6_1(5),
RQTY_100268_.tb6_2(5),
RQTY_100268_.tb6_3(5),
RQTY_100268_.tb6_4(5),
RQTY_100268_.tb6_5(5),
null,
null,
RQTY_100268_.tb6_8(5),
null,
3,
'Número de Solicitud'
,
3,
'N'
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(5):=121146296;
RQTY_100268_.tb2_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(5):=RQTY_100268_.tb2_0(5);
RQTY_100268_.old_tb2_1(5):='MO_INITATRIB_CT23E121146296'
;
RQTY_100268_.tb2_1(5):=RQTY_100268_.tb2_0(5);
RQTY_100268_.tb2_2(5):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(5),
RQTY_100268_.tb2_1(5),
RQTY_100268_.tb2_2(5),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'OPEN'
,
to_date('10-07-2014 09:34:57','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(6):=106699;
RQTY_100268_.tb6_1(6):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(6):=17;
RQTY_100268_.tb6_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(6),-1)));
RQTY_100268_.old_tb6_3(6):=259;
RQTY_100268_.tb6_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(6),-1)));
RQTY_100268_.old_tb6_4(6):=null;
RQTY_100268_.tb6_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(6),-1)));
RQTY_100268_.old_tb6_5(6):=null;
RQTY_100268_.tb6_5(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(6),-1)));
RQTY_100268_.tb6_7(6):=RQTY_100268_.tb2_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (6)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(6),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(6),
ENTITY_ID=RQTY_100268_.tb6_2(6),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(6),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(6),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(6),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Fecha de Envío'
,
DISPLAY_ORDER=4,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(6);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(6),
RQTY_100268_.tb6_1(6),
RQTY_100268_.tb6_2(6),
RQTY_100268_.tb6_3(6),
RQTY_100268_.tb6_4(6),
RQTY_100268_.tb6_5(6),
null,
RQTY_100268_.tb6_7(6),
null,
null,
4,
'Fecha de Envío'
,
4,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(6):=121146297;
RQTY_100268_.tb2_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(6):=RQTY_100268_.tb2_0(6);
RQTY_100268_.old_tb2_1(6):='MO_INITATRIB_CT23E121146297'
;
RQTY_100268_.tb2_1(6):=RQTY_100268_.tb2_0(6);
RQTY_100268_.tb2_2(6):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(6),
RQTY_100268_.tb2_1(6),
RQTY_100268_.tb2_2(6),
'nuPersonId = GE_BOPERSONAL.FNUGETPERSONID();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuPersonId);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance, Null, "MO_PACKAGES", "POS_OPER_UNIT_ID", nuSaleChannel, True)'
,
'OPEN'
,
to_date('10-07-2014 09:34:57','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(7):=121146298;
RQTY_100268_.tb2_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(7):=RQTY_100268_.tb2_0(7);
RQTY_100268_.old_tb2_1(7):='MO_VALIDATTR_CT26E121146298'
;
RQTY_100268_.tb2_1(7):=RQTY_100268_.tb2_0(7);
RQTY_100268_.tb2_2(7):=RQTY_100268_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(7),
RQTY_100268_.tb2_1(7),
RQTY_100268_.tb2_2(7),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuPersonId);GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonId,nuSaleChannel);GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,Null,"MO_PACKAGES","POS_OPER_UNIT_ID",nuSaleChannel,True)'
,
'OPEN'
,
to_date('10-07-2014 09:34:57','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(0):=120079382;
RQTY_100268_.tb7_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(0):=RQTY_100268_.tb7_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(0),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(7):=106700;
RQTY_100268_.tb6_1(7):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(7):=17;
RQTY_100268_.tb6_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(7),-1)));
RQTY_100268_.old_tb6_3(7):=50001162;
RQTY_100268_.tb6_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(7),-1)));
RQTY_100268_.old_tb6_4(7):=null;
RQTY_100268_.tb6_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(7),-1)));
RQTY_100268_.old_tb6_5(7):=null;
RQTY_100268_.tb6_5(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(7),-1)));
RQTY_100268_.tb6_6(7):=RQTY_100268_.tb7_0(0);
RQTY_100268_.tb6_7(7):=RQTY_100268_.tb2_0(6);
RQTY_100268_.tb6_8(7):=RQTY_100268_.tb2_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (7)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(7),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(7),
ENTITY_ID=RQTY_100268_.tb6_2(7),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(7),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(7),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(7),
STATEMENT_ID=RQTY_100268_.tb6_6(7),
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(7),
VALID_EXPRESSION_ID=RQTY_100268_.tb6_8(7),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Funcionario'
,
DISPLAY_ORDER=5,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(7);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(7),
RQTY_100268_.tb6_1(7),
RQTY_100268_.tb6_2(7),
RQTY_100268_.tb6_3(7),
RQTY_100268_.tb6_4(7),
RQTY_100268_.tb6_5(7),
RQTY_100268_.tb6_6(7),
RQTY_100268_.tb6_7(7),
RQTY_100268_.tb6_8(7),
null,
5,
'Funcionario'
,
5,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(8):=121146299;
RQTY_100268_.tb2_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(8):=RQTY_100268_.tb2_0(8);
RQTY_100268_.old_tb2_1(8):='MO_INITATRIB_CT23E121146299'
;
RQTY_100268_.tb2_1(8):=RQTY_100268_.tb2_0(8);
RQTY_100268_.tb2_2(8):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(8),
RQTY_100268_.tb2_1(8),
RQTY_100268_.tb2_2(8),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "MO_PACKAGES", "PERSON_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"MO_PACKAGES","PERSON_ID",sbPersonId);nuPersonId = UT_CONVERT.FNUCHARTONUMBER(sbPersonId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(nuPersonId, GE_BOCONSTANTS.GETTRUE()));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOPERSONAL.FNUGETCURRENTCHANNEL(null, GE_BOCONSTANTS.GETTRUE()));)'
,
'OPEN'
,
to_date('10-07-2014 09:34:58','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(1):=120079383;
RQTY_100268_.tb7_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(1):=RQTY_100268_.tb7_0(1);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(1),
5,
'Lista Punto de Atención'
,
'SELECT a.organizat_area_id id, a.display_description description
FROM ge_organizat_area a, cc_orga_area_seller b
WHERE a.organizat_area_id = b.organizat_area_id
AND b.person_id = ge_boinstancecontrol.fsbGetFieldValue('|| chr(39) ||'MO_PACKAGES'|| chr(39) ||','|| chr(39) ||'PERSON_ID'|| chr(39) ||')
'
,
'Lista Punto de Atención'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(8):=106701;
RQTY_100268_.tb6_1(8):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(8):=17;
RQTY_100268_.tb6_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(8),-1)));
RQTY_100268_.old_tb6_3(8):=109479;
RQTY_100268_.tb6_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(8),-1)));
RQTY_100268_.old_tb6_4(8):=null;
RQTY_100268_.tb6_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(8),-1)));
RQTY_100268_.old_tb6_5(8):=null;
RQTY_100268_.tb6_5(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(8),-1)));
RQTY_100268_.tb6_6(8):=RQTY_100268_.tb7_0(1);
RQTY_100268_.tb6_7(8):=RQTY_100268_.tb2_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (8)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(8),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(8),
ENTITY_ID=RQTY_100268_.tb6_2(8),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(8),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(8),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(8),
STATEMENT_ID=RQTY_100268_.tb6_6(8),
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Punto de Atención'
,
DISPLAY_ORDER=6,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(8);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(8),
RQTY_100268_.tb6_1(8),
RQTY_100268_.tb6_2(8),
RQTY_100268_.tb6_3(8),
RQTY_100268_.tb6_4(8),
RQTY_100268_.tb6_5(8),
RQTY_100268_.tb6_6(8),
RQTY_100268_.tb6_7(8),
null,
null,
6,
'Punto de Atención'
,
6,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(9):=106702;
RQTY_100268_.tb6_1(9):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(9):=17;
RQTY_100268_.tb6_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(9),-1)));
RQTY_100268_.old_tb6_3(9):=109478;
RQTY_100268_.tb6_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(9),-1)));
RQTY_100268_.old_tb6_4(9):=null;
RQTY_100268_.tb6_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(9),-1)));
RQTY_100268_.old_tb6_5(9):=null;
RQTY_100268_.tb6_5(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(9),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (9)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(9),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(9),
ENTITY_ID=RQTY_100268_.tb6_2(9),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(9),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(9),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Unidad Operativa Del Vendedor'
,
DISPLAY_ORDER=7,
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
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(9);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(9),
RQTY_100268_.tb6_1(9),
RQTY_100268_.tb6_2(9),
RQTY_100268_.tb6_3(9),
RQTY_100268_.tb6_4(9),
RQTY_100268_.tb6_5(9),
null,
null,
null,
null,
7,
'Unidad Operativa Del Vendedor'
,
7,
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
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(10):=106703;
RQTY_100268_.tb6_1(10):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(10):=17;
RQTY_100268_.tb6_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(10),-1)));
RQTY_100268_.old_tb6_3(10):=42118;
RQTY_100268_.tb6_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(10),-1)));
RQTY_100268_.old_tb6_4(10):=109479;
RQTY_100268_.tb6_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(10),-1)));
RQTY_100268_.old_tb6_5(10):=null;
RQTY_100268_.tb6_5(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(10),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (10)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(10),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(10),
ENTITY_ID=RQTY_100268_.tb6_2(10),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(10),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(10),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Código Canal De Ventas'
,
DISPLAY_ORDER=8,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(10);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(10),
RQTY_100268_.tb6_1(10),
RQTY_100268_.tb6_2(10),
RQTY_100268_.tb6_3(10),
RQTY_100268_.tb6_4(10),
RQTY_100268_.tb6_5(10),
null,
null,
null,
null,
8,
'Código Canal De Ventas'
,
8,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(9):=121146300;
RQTY_100268_.tb2_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(9):=RQTY_100268_.tb2_0(9);
RQTY_100268_.old_tb2_1(9):='MO_INITATRIB_CT23E121146300'
;
RQTY_100268_.tb2_1(9):=RQTY_100268_.tb2_0(9);
RQTY_100268_.tb2_2(9):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(9),
RQTY_100268_.tb2_1(9),
RQTY_100268_.tb2_2(9),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETRECEPTIONTYPE(null));)'
,
'OPEN'
,
to_date('10-07-2014 09:34:58','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:18','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(2):=120079384;
RQTY_100268_.tb7_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(2):=RQTY_100268_.tb7_0(2);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(2),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(11):=106704;
RQTY_100268_.tb6_1(11):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(11):=17;
RQTY_100268_.tb6_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(11),-1)));
RQTY_100268_.old_tb6_3(11):=2683;
RQTY_100268_.tb6_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(11),-1)));
RQTY_100268_.old_tb6_4(11):=null;
RQTY_100268_.tb6_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(11),-1)));
RQTY_100268_.old_tb6_5(11):=null;
RQTY_100268_.tb6_5(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(11),-1)));
RQTY_100268_.tb6_6(11):=RQTY_100268_.tb7_0(2);
RQTY_100268_.tb6_7(11):=RQTY_100268_.tb2_0(9);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (11)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(11),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(11),
ENTITY_ID=RQTY_100268_.tb6_2(11),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(11),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(11),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(11),
STATEMENT_ID=RQTY_100268_.tb6_6(11),
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(11),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Medio de recepción'
,
DISPLAY_ORDER=9,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(11);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(11),
RQTY_100268_.tb6_1(11),
RQTY_100268_.tb6_2(11),
RQTY_100268_.tb6_3(11),
RQTY_100268_.tb6_4(11),
RQTY_100268_.tb6_5(11),
RQTY_100268_.tb6_6(11),
RQTY_100268_.tb6_7(11),
null,
null,
9,
'Medio de recepción'
,
9,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(10):=121146301;
RQTY_100268_.tb2_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(10):=RQTY_100268_.tb2_0(10);
RQTY_100268_.old_tb2_1(10):='MO_INITATRIB_CT23E121146301'
;
RQTY_100268_.tb2_1(10):=RQTY_100268_.tb2_0(10);
RQTY_100268_.tb2_2(10):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(10),
RQTY_100268_.tb2_1(10),
RQTY_100268_.tb2_2(10),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETCONTACTID(null));)'
,
'OPEN'
,
to_date('10-07-2014 09:34:58','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(12):=106705;
RQTY_100268_.tb6_1(12):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(12):=17;
RQTY_100268_.tb6_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(12),-1)));
RQTY_100268_.old_tb6_3(12):=146755;
RQTY_100268_.tb6_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(12),-1)));
RQTY_100268_.old_tb6_4(12):=null;
RQTY_100268_.tb6_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(12),-1)));
RQTY_100268_.old_tb6_5(12):=null;
RQTY_100268_.tb6_5(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(12),-1)));
RQTY_100268_.tb6_7(12):=RQTY_100268_.tb2_0(10);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (12)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(12),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(12),
ENTITY_ID=RQTY_100268_.tb6_2(12),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(12),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(12),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(12),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Información del Solicitante'
,
DISPLAY_ORDER=10,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(12);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(12),
RQTY_100268_.tb6_1(12),
RQTY_100268_.tb6_2(12),
RQTY_100268_.tb6_3(12),
RQTY_100268_.tb6_4(12),
RQTY_100268_.tb6_5(12),
null,
RQTY_100268_.tb6_7(12),
null,
null,
10,
'Información del Solicitante'
,
10,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(13):=106706;
RQTY_100268_.tb6_1(13):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(13):=17;
RQTY_100268_.tb6_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(13),-1)));
RQTY_100268_.old_tb6_3(13):=11619;
RQTY_100268_.tb6_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(13),-1)));
RQTY_100268_.old_tb6_4(13):=null;
RQTY_100268_.tb6_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(13),-1)));
RQTY_100268_.old_tb6_5(13):=null;
RQTY_100268_.tb6_5(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(13),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (13)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(13),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(13),
ENTITY_ID=RQTY_100268_.tb6_2(13),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(13),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(13),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Privacidad Suscriptor'
,
DISPLAY_ORDER=11,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(13);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(13),
RQTY_100268_.tb6_1(13),
RQTY_100268_.tb6_2(13),
RQTY_100268_.tb6_3(13),
RQTY_100268_.tb6_4(13),
RQTY_100268_.tb6_5(13),
null,
null,
null,
null,
11,
'Privacidad Suscriptor'
,
11,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(11):=121146302;
RQTY_100268_.tb2_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(11):=RQTY_100268_.tb2_0(11);
RQTY_100268_.old_tb2_1(11):='MO_INITATRIB_CT23E121146302'
;
RQTY_100268_.tb2_1(11):=RQTY_100268_.tb2_0(11);
RQTY_100268_.tb2_2(11):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(11),
RQTY_100268_.tb2_1(11),
RQTY_100268_.tb2_2(11),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'OPEN'
,
to_date('10-07-2014 09:34:58','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(14):=106707;
RQTY_100268_.tb6_1(14):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(14):=17;
RQTY_100268_.tb6_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(14),-1)));
RQTY_100268_.old_tb6_3(14):=191044;
RQTY_100268_.tb6_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(14),-1)));
RQTY_100268_.old_tb6_4(14):=null;
RQTY_100268_.tb6_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(14),-1)));
RQTY_100268_.old_tb6_5(14):=null;
RQTY_100268_.tb6_5(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(14),-1)));
RQTY_100268_.tb6_7(14):=RQTY_100268_.tb2_0(11);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (14)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(14),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(14),
ENTITY_ID=RQTY_100268_.tb6_2(14),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(14),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(14),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Facturación Es En La Recurrente'
,
DISPLAY_ORDER=12,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(14);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(14),
RQTY_100268_.tb6_1(14),
RQTY_100268_.tb6_2(14),
RQTY_100268_.tb6_3(14),
RQTY_100268_.tb6_4(14),
RQTY_100268_.tb6_5(14),
null,
RQTY_100268_.tb6_7(14),
null,
null,
12,
'Facturación Es En La Recurrente'
,
12,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(15):=106708;
RQTY_100268_.tb6_1(15):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(15):=17;
RQTY_100268_.tb6_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(15),-1)));
RQTY_100268_.old_tb6_3(15):=11621;
RQTY_100268_.tb6_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(15),-1)));
RQTY_100268_.old_tb6_4(15):=null;
RQTY_100268_.tb6_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(15),-1)));
RQTY_100268_.old_tb6_5(15):=null;
RQTY_100268_.tb6_5(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(15),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (15)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(15),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(15),
ENTITY_ID=RQTY_100268_.tb6_2(15),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(15),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(15),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Contrato pendiente'
,
DISPLAY_ORDER=13,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(15);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(15),
RQTY_100268_.tb6_1(15),
RQTY_100268_.tb6_2(15),
RQTY_100268_.tb6_3(15),
RQTY_100268_.tb6_4(15),
RQTY_100268_.tb6_5(15),
null,
null,
null,
null,
13,
'Contrato pendiente'
,
13,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(16):=106709;
RQTY_100268_.tb6_1(16):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(16):=17;
RQTY_100268_.tb6_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(16),-1)));
RQTY_100268_.old_tb6_3(16):=4015;
RQTY_100268_.tb6_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(16),-1)));
RQTY_100268_.old_tb6_4(16):=146755;
RQTY_100268_.tb6_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(16),-1)));
RQTY_100268_.old_tb6_5(16):=null;
RQTY_100268_.tb6_5(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(16),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (16)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(16),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(16),
ENTITY_ID=RQTY_100268_.tb6_2(16),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(16),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(16),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Cliente'
,
DISPLAY_ORDER=14,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='CLIENTE'
,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(16);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(16),
RQTY_100268_.tb6_1(16),
RQTY_100268_.tb6_2(16),
RQTY_100268_.tb6_3(16),
RQTY_100268_.tb6_4(16),
RQTY_100268_.tb6_5(16),
null,
null,
null,
null,
14,
'Cliente'
,
14,
'N'
,
'N'
,
'N'
,
'CLIENTE'
,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(12):=121146303;
RQTY_100268_.tb2_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(12):=RQTY_100268_.tb2_0(12);
RQTY_100268_.old_tb2_1(12):='MO_INITATRIB_CT23E121146303'
;
RQTY_100268_.tb2_1(12):=RQTY_100268_.tb2_0(12);
RQTY_100268_.tb2_2(12):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(12),
RQTY_100268_.tb2_1(12),
RQTY_100268_.tb2_2(12),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", null, "GE_SUBSCRIBER", "SUBSCRIBER_ID", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbSubscriberId);nuSubscriberId = UT_CONVERT.FNUCHARTONUMBER(sbSubscriberId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(nuSubscriberId));,GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(CC_BOPETITIONMGR.FNUGETANSWERADDRESSID(null));)'
,
'OPEN'
,
to_date('10-07-2014 09:34:58','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(17):=106710;
RQTY_100268_.tb6_1(17):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(17):=17;
RQTY_100268_.tb6_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(17),-1)));
RQTY_100268_.old_tb6_3(17):=146756;
RQTY_100268_.tb6_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(17),-1)));
RQTY_100268_.old_tb6_4(17):=null;
RQTY_100268_.tb6_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(17),-1)));
RQTY_100268_.old_tb6_5(17):=null;
RQTY_100268_.tb6_5(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(17),-1)));
RQTY_100268_.tb6_7(17):=RQTY_100268_.tb2_0(12);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (17)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(17),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(17),
ENTITY_ID=RQTY_100268_.tb6_2(17),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(17),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(17),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(17),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Dirección de Respuesta'
,
DISPLAY_ORDER=15,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(17);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(17),
RQTY_100268_.tb6_1(17),
RQTY_100268_.tb6_2(17),
RQTY_100268_.tb6_3(17),
RQTY_100268_.tb6_4(17),
RQTY_100268_.tb6_5(17),
null,
RQTY_100268_.tb6_7(17),
null,
null,
15,
'Dirección de Respuesta'
,
15,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(3):=120079385;
RQTY_100268_.tb7_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(3):=RQTY_100268_.tb7_0(3);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(3),
16,
'Medio de Referencia'
,
'select c.refer_mode_id ID,c.description DESCRIPTION from CC_REFER_MODE c'
,
'Medio de Referencia'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb8_0(0):=RQTY_100268_.tb7_0(3);
RQTY_100268_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
    <Description>Descripción</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
    <Entity>CC_REFER_MODE</Entity>
    <Column>DESCRIPTION</Column>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>'
;
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (0)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100268_.tb8_0(0),
null,
RQTY_100268_.clColumn_1,
null);

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(18):=106711;
RQTY_100268_.tb6_1(18):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(18):=17;
RQTY_100268_.tb6_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(18),-1)));
RQTY_100268_.old_tb6_3(18):=146751;
RQTY_100268_.tb6_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(18),-1)));
RQTY_100268_.old_tb6_4(18):=null;
RQTY_100268_.tb6_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(18),-1)));
RQTY_100268_.old_tb6_5(18):=null;
RQTY_100268_.tb6_5(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(18),-1)));
RQTY_100268_.tb6_6(18):=RQTY_100268_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (18)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(18),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(18),
ENTITY_ID=RQTY_100268_.tb6_2(18),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(18),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(18),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(18),
STATEMENT_ID=RQTY_100268_.tb6_6(18),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Medio por el que se enteró'
,
DISPLAY_ORDER=16,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='REFER_MODE_ID'
,
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
ATTRI_TECHNICAL_NAME='REFER_MODE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(18);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(18),
RQTY_100268_.tb6_1(18),
RQTY_100268_.tb6_2(18),
RQTY_100268_.tb6_3(18),
RQTY_100268_.tb6_4(18),
RQTY_100268_.tb6_5(18),
RQTY_100268_.tb6_6(18),
null,
null,
null,
16,
'Medio por el que se enteró'
,
16,
'N'
,
'N'
,
'Y'
,
'REFER_MODE_ID'
,
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
'REFER_MODE_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(19):=106712;
RQTY_100268_.tb6_1(19):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(19):=17;
RQTY_100268_.tb6_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(19),-1)));
RQTY_100268_.old_tb6_3(19):=146754;
RQTY_100268_.tb6_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(19),-1)));
RQTY_100268_.old_tb6_4(19):=null;
RQTY_100268_.tb6_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(19),-1)));
RQTY_100268_.old_tb6_5(19):=null;
RQTY_100268_.tb6_5(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(19),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (19)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(19),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(19),
ENTITY_ID=RQTY_100268_.tb6_2(19),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(19),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(19),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Observación'
,
DISPLAY_ORDER=17,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(19);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(19),
RQTY_100268_.tb6_1(19),
RQTY_100268_.tb6_2(19),
RQTY_100268_.tb6_3(19),
RQTY_100268_.tb6_4(19),
RQTY_100268_.tb6_5(19),
null,
null,
null,
null,
17,
'Observación'
,
17,
'N'
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(4):=120079386;
RQTY_100268_.tb7_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(4):=RQTY_100268_.tb7_0(4);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(4),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(20):=106713;
RQTY_100268_.tb6_1(20):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(20):=9179;
RQTY_100268_.tb6_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(20),-1)));
RQTY_100268_.old_tb6_3(20):=149340;
RQTY_100268_.tb6_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(20),-1)));
RQTY_100268_.old_tb6_4(20):=null;
RQTY_100268_.tb6_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(20),-1)));
RQTY_100268_.old_tb6_5(20):=null;
RQTY_100268_.tb6_5(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(20),-1)));
RQTY_100268_.tb6_6(20):=RQTY_100268_.tb7_0(4);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (20)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(20),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(20),
ENTITY_ID=RQTY_100268_.tb6_2(20),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(20),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(20),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(20),
STATEMENT_ID=RQTY_100268_.tb6_6(20),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=18,
DISPLAY_NAME='Relación del Solicitante con el Predio'
,
DISPLAY_ORDER=18,
INCLUDED_VAL_DOC='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(20);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(20),
RQTY_100268_.tb6_1(20),
RQTY_100268_.tb6_2(20),
RQTY_100268_.tb6_3(20),
RQTY_100268_.tb6_4(20),
RQTY_100268_.tb6_5(20),
RQTY_100268_.tb6_6(20),
null,
null,
null,
18,
'Relación del Solicitante con el Predio'
,
18,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(21):=106714;
RQTY_100268_.tb6_1(21):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(21):=9179;
RQTY_100268_.tb6_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(21),-1)));
RQTY_100268_.old_tb6_3(21):=39387;
RQTY_100268_.tb6_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(21),-1)));
RQTY_100268_.old_tb6_4(21):=255;
RQTY_100268_.tb6_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(21),-1)));
RQTY_100268_.old_tb6_5(21):=null;
RQTY_100268_.tb6_5(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(21),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (21)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(21),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(21),
ENTITY_ID=RQTY_100268_.tb6_2(21),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(21),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(21),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=19,
DISPLAY_NAME='Identificador De Solicitud'
,
DISPLAY_ORDER=19,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(21);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(21),
RQTY_100268_.tb6_1(21),
RQTY_100268_.tb6_2(21),
RQTY_100268_.tb6_3(21),
RQTY_100268_.tb6_4(21),
RQTY_100268_.tb6_5(21),
null,
null,
null,
null,
19,
'Identificador De Solicitud'
,
19,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(13):=121146304;
RQTY_100268_.tb2_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(13):=RQTY_100268_.tb2_0(13);
RQTY_100268_.old_tb2_1(13):='MO_INITATRIB_CT23E121146304'
;
RQTY_100268_.tb2_1(13):=RQTY_100268_.tb2_0(13);
RQTY_100268_.tb2_2(13):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(13),
RQTY_100268_.tb2_1(13),
RQTY_100268_.tb2_2(13),
'sbSequence = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_SUBS_TYPE_MOTIV", "SEQ_MO_SUBS_TYPE_MOTIV");nuSequence = UT_CONVERT.FNUCHARTONUMBER(sbSequence);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSequence)'
,
'OPEN'
,
to_date('10-07-2014 11:08:24','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(22):=106715;
RQTY_100268_.tb6_1(22):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(22):=9179;
RQTY_100268_.tb6_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(22),-1)));
RQTY_100268_.old_tb6_3(22):=50000603;
RQTY_100268_.tb6_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(22),-1)));
RQTY_100268_.old_tb6_4(22):=null;
RQTY_100268_.tb6_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(22),-1)));
RQTY_100268_.old_tb6_5(22):=null;
RQTY_100268_.tb6_5(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(22),-1)));
RQTY_100268_.tb6_7(22):=RQTY_100268_.tb2_0(13);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (22)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(22),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(22),
ENTITY_ID=RQTY_100268_.tb6_2(22),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(22),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(22),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(22),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(22),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Identificador de suscriptor por motivo'
,
DISPLAY_ORDER=20,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(22);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(22),
RQTY_100268_.tb6_1(22),
RQTY_100268_.tb6_2(22),
RQTY_100268_.tb6_3(22),
RQTY_100268_.tb6_4(22),
RQTY_100268_.tb6_5(22),
null,
RQTY_100268_.tb6_7(22),
null,
null,
20,
'Identificador de suscriptor por motivo'
,
20,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(23):=106716;
RQTY_100268_.tb6_1(23):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(23):=9179;
RQTY_100268_.tb6_2(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(23),-1)));
RQTY_100268_.old_tb6_3(23):=50000606;
RQTY_100268_.tb6_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(23),-1)));
RQTY_100268_.old_tb6_4(23):=146755;
RQTY_100268_.tb6_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(23),-1)));
RQTY_100268_.old_tb6_5(23):=null;
RQTY_100268_.tb6_5(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(23),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (23)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(23),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(23),
ENTITY_ID=RQTY_100268_.tb6_2(23),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(23),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(23),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(23),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Usuario del Servicio'
,
DISPLAY_ORDER=21,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(23);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(23),
RQTY_100268_.tb6_1(23),
RQTY_100268_.tb6_2(23),
RQTY_100268_.tb6_3(23),
RQTY_100268_.tb6_4(23),
RQTY_100268_.tb6_5(23),
null,
null,
null,
null,
21,
'Usuario del Servicio'
,
21,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(14):=121146305;
RQTY_100268_.tb2_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(14):=RQTY_100268_.tb2_0(14);
RQTY_100268_.old_tb2_1(14):='MO_INITATRIB_CT23E121146305'
;
RQTY_100268_.tb2_1(14):=RQTY_100268_.tb2_0(14);
RQTY_100268_.tb2_2(14):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(14),
RQTY_100268_.tb2_1(14),
RQTY_100268_.tb2_2(14),
'nuSeq = GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("MO_ADDRESS","SEQ_MO_ADDRESS");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(nuSeq)'
,
'OPEN'
,
to_date('10-07-2014 11:08:25','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(24):=106717;
RQTY_100268_.tb6_1(24):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(24):=21;
RQTY_100268_.tb6_2(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(24),-1)));
RQTY_100268_.old_tb6_3(24):=474;
RQTY_100268_.tb6_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(24),-1)));
RQTY_100268_.old_tb6_4(24):=null;
RQTY_100268_.tb6_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(24),-1)));
RQTY_100268_.old_tb6_5(24):=null;
RQTY_100268_.tb6_5(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(24),-1)));
RQTY_100268_.tb6_7(24):=RQTY_100268_.tb2_0(14);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (24)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(24),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(24),
ENTITY_ID=RQTY_100268_.tb6_2(24),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(24),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(24),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(24),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(24),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=22,
DISPLAY_NAME='Código de la Dirección'
,
DISPLAY_ORDER=22,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(24);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(24),
RQTY_100268_.tb6_1(24),
RQTY_100268_.tb6_2(24),
RQTY_100268_.tb6_3(24),
RQTY_100268_.tb6_4(24),
RQTY_100268_.tb6_5(24),
null,
RQTY_100268_.tb6_7(24),
null,
null,
22,
'Código de la Dirección'
,
22,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(15):=121146306;
RQTY_100268_.tb2_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(15):=RQTY_100268_.tb2_0(15);
RQTY_100268_.old_tb2_1(15):='MO_VALIDATTR_CT26E121146306'
;
RQTY_100268_.tb2_1(15):=RQTY_100268_.tb2_0(15);
RQTY_100268_.tb2_2(15):=RQTY_100268_.tb1_0(2);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(15),
RQTY_100268_.tb2_1(15),
RQTY_100268_.tb2_2(15),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(inuAddressID);PROVALEXISPRODGAS(inuAddressID);PROVALEXISSOLVISVENTA(inuAddressID);PROVALEXISSOLVENTAGAS(inuAddressID);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PACKAGES","REFER_MODE_ID",sbReferMode);nuReferModeId = UT_CONVERT.FNUCHARTONUMBER(sbReferMode);GE_BOINSTANCECONTROL.LOADENTITYOLDVALUESID(sbInstance,null,"AB_ADDRESS",inuAddressID,GE_BOCONSTANTS.GETFALSE(),GE_BOCONSTANTS.GETFALSE(),GE_BOCONSTANTS.GETFALSE());GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PACKAGES","PACKAGE_ID",onuPackageId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"AB_ADDRESS","ADDRESS",onuAddress);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"AB_ADDRESS","ADDRESS_ID",onuParserAddressID);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"AB_ADDRESS","GEOGRAP_LOCATION_ID",onuGeograpLocationID);osbIsAddressMain = "Y";nuMoAddressId = GE_BOSEQUENCE.FNUGE' ||
'TNEXTVALSEQUENCE("MO_ADDRESS", "SEQ_MO_ADDRESS");GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","ADDRESS_ID",nuMoAddressId,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","PACKAGE_ID",onuPackageId,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","ADDRESS",onuAddress,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","PARSER_ADDRESS_ID",onuParserAddressID,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","GEOGRAP_LOCATION_ID",onuGeograpLocationID,GE_BOCONSTANTS.GETTRUE());GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstance,null,"MO_ADDRESS","IS_ADDRESS_MAIN",osbIsAddressMain,GE_BOCONSTANTS.GETTRUE())'
,
'OPEN'
,
to_date('10-07-2014 11:08:25','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:19','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL - PAQ - MO_PROCESS - ADDRESS_MAIN_MOTIVE - Validaci¿n de la Dirección - Visita de Venta'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(25):=106718;
RQTY_100268_.tb6_1(25):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(25):=68;
RQTY_100268_.tb6_2(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(25),-1)));
RQTY_100268_.old_tb6_3(25):=1035;
RQTY_100268_.tb6_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(25),-1)));
RQTY_100268_.old_tb6_4(25):=null;
RQTY_100268_.tb6_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(25),-1)));
RQTY_100268_.old_tb6_5(25):=null;
RQTY_100268_.tb6_5(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(25),-1)));
RQTY_100268_.tb6_8(25):=RQTY_100268_.tb2_0(15);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (25)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(25),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(25),
ENTITY_ID=RQTY_100268_.tb6_2(25),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(25),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(25),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(25),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=RQTY_100268_.tb6_8(25),
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=23,
DISPLAY_NAME='Dirección de Visita'
,
DISPLAY_ORDER=23,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='DIRECCION_DE_VISITA'
,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(25);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(25),
RQTY_100268_.tb6_1(25),
RQTY_100268_.tb6_2(25),
RQTY_100268_.tb6_3(25),
RQTY_100268_.tb6_4(25),
RQTY_100268_.tb6_5(25),
null,
null,
RQTY_100268_.tb6_8(25),
null,
23,
'Dirección de Visita'
,
23,
'N'
,
'N'
,
'Y'
,
'DIRECCION_DE_VISITA'
,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(5):=120079387;
RQTY_100268_.tb7_0(5):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(5):=RQTY_100268_.tb7_0(5);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (5)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(5),
16,
'SAO156410_TIPO_PREDIO'
,
'select AB_PREMISE_TYPE.premise_type_id ID,
       AB_PREMISE_TYPE.description Description
from AB_PREMISE_TYPE'
,
'SAO156410_TIPO_PREDIO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(26):=106719;
RQTY_100268_.tb6_1(26):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(26):=8507;
RQTY_100268_.tb6_2(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(26),-1)));
RQTY_100268_.old_tb6_3(26):=90021316;
RQTY_100268_.tb6_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(26),-1)));
RQTY_100268_.old_tb6_4(26):=null;
RQTY_100268_.tb6_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(26),-1)));
RQTY_100268_.old_tb6_5(26):=null;
RQTY_100268_.tb6_5(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(26),-1)));
RQTY_100268_.tb6_6(26):=RQTY_100268_.tb7_0(5);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (26)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(26),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(26),
ENTITY_ID=RQTY_100268_.tb6_2(26),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(26),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(26),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(26),
STATEMENT_ID=RQTY_100268_.tb6_6(26),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=24,
DISPLAY_NAME='Tipo de Predio'
,
DISPLAY_ORDER=24,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='TIPO_DE_PREDIO'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='LD_FA_INFOADIC_REFERIDO'
,
ATTRI_TECHNICAL_NAME='TIPOPREDIO'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(26);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(26),
RQTY_100268_.tb6_1(26),
RQTY_100268_.tb6_2(26),
RQTY_100268_.tb6_3(26),
RQTY_100268_.tb6_4(26),
RQTY_100268_.tb6_5(26),
RQTY_100268_.tb6_6(26),
null,
null,
null,
24,
'Tipo de Predio'
,
24,
'N'
,
'N'
,
'Y'
,
'TIPO_DE_PREDIO'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'LD_FA_INFOADIC_REFERIDO'
,
'TIPOPREDIO'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(16):=121146307;
RQTY_100268_.tb2_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(16):=RQTY_100268_.tb2_0(16);
RQTY_100268_.old_tb2_1(16):='MO_INITATRIB_CT23E121146307'
;
RQTY_100268_.tb2_1(16):=RQTY_100268_.tb2_0(16);
RQTY_100268_.tb2_2(16):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(16),
RQTY_100268_.tb2_1(16),
RQTY_100268_.tb2_2(16),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_PROCESS","ADDRESS_MAIN_MOTIVE",nuAddressId);GETCATEGORYSUBCATEGORY(nuAddressId,onuCategoryId,onuStratumId);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(onuCategoryId)'
,
'OPEN'
,
to_date('10-07-2014 11:08:26','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:20','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:20','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - PAQ - MO_PROCESS.USE - Inicializa campo con la categoría de la dirección'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(6):=120079388;
RQTY_100268_.tb7_0(6):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(6):=RQTY_100268_.tb7_0(6);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (6)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(6),
16,
'SAO156410_USO_DEL_PREDIO'
,
'select categori.catecodi Id,
       categori.catedesc Description
from categori
order by categori.catecodi'
,
'SAO156410_USO_DEL_PREDIO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb8_0(1):=RQTY_100268_.tb7_0(6);
RQTY_100268_.clColumn_1 := '<?xml version="1.0" encoding="utf-16"?>
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
ut_trace.trace('insertando tabla: GE_STATEMENT_COLUMNS fila (1)',1);
INSERT INTO GE_STATEMENT_COLUMNS(STATEMENT_ID,WIZARD_COLUMNS,SELECT_COLUMNS,LIST_VALUES) 
VALUES (RQTY_100268_.tb8_0(1),
null,
RQTY_100268_.clColumn_1,
null);

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(27):=106720;
RQTY_100268_.tb6_1(27):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(27):=68;
RQTY_100268_.tb6_2(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(27),-1)));
RQTY_100268_.old_tb6_3(27):=440;
RQTY_100268_.tb6_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(27),-1)));
RQTY_100268_.old_tb6_4(27):=null;
RQTY_100268_.tb6_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(27),-1)));
RQTY_100268_.old_tb6_5(27):=1035;
RQTY_100268_.tb6_5(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(27),-1)));
RQTY_100268_.tb6_6(27):=RQTY_100268_.tb7_0(6);
RQTY_100268_.tb6_7(27):=RQTY_100268_.tb2_0(16);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (27)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(27),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(27),
ENTITY_ID=RQTY_100268_.tb6_2(27),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(27),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(27),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(27),
STATEMENT_ID=RQTY_100268_.tb6_6(27),
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(27),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=25,
DISPLAY_NAME='Uso del Predio'
,
DISPLAY_ORDER=25,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='USO_DEL_PREDIO'
,
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(27);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(27),
RQTY_100268_.tb6_1(27),
RQTY_100268_.tb6_2(27),
RQTY_100268_.tb6_3(27),
RQTY_100268_.tb6_4(27),
RQTY_100268_.tb6_5(27),
RQTY_100268_.tb6_6(27),
RQTY_100268_.tb6_7(27),
null,
null,
25,
'Uso del Predio'
,
25,
'N'
,
'N'
,
'Y'
,
'USO_DEL_PREDIO'
,
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
'N'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(7):=120079389;
RQTY_100268_.tb7_0(7):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(7):=RQTY_100268_.tb7_0(7);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (7)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(7),
16,
'SAO156410_ESTRATO'
,
'select subcateg.sucacodi Id,
       subcateg.sucadesc Description
from subcateg
where subcateg.sucacate = ge_boInstanceControl.fsbGetFieldValue ('|| chr(39) ||'MO_PROCESS'|| chr(39) ||', '|| chr(39) ||'USE'|| chr(39) ||')
order by subcateg.sucacodi

'
,
'SAO156410_ESTRATO'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(28):=106721;
RQTY_100268_.tb6_1(28):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(28):=68;
RQTY_100268_.tb6_2(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(28),-1)));
RQTY_100268_.old_tb6_3(28):=441;
RQTY_100268_.tb6_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(28),-1)));
RQTY_100268_.old_tb6_4(28):=null;
RQTY_100268_.tb6_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(28),-1)));
RQTY_100268_.old_tb6_5(28):=440;
RQTY_100268_.tb6_5(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(28),-1)));
RQTY_100268_.tb6_6(28):=RQTY_100268_.tb7_0(7);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (28)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(28),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(28),
ENTITY_ID=RQTY_100268_.tb6_2(28),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(28),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(28),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(28),
STATEMENT_ID=RQTY_100268_.tb6_6(28),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=26,
DISPLAY_NAME='Estrato'
,
DISPLAY_ORDER=26,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='Y'
,
TAG_NAME='ESTRATO'
,
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
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(28);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(28),
RQTY_100268_.tb6_1(28),
RQTY_100268_.tb6_2(28),
RQTY_100268_.tb6_3(28),
RQTY_100268_.tb6_4(28),
RQTY_100268_.tb6_5(28),
RQTY_100268_.tb6_6(28),
null,
null,
null,
26,
'Estrato'
,
26,
'N'
,
'N'
,
'Y'
,
'ESTRATO'
,
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
'N'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(29):=106722;
RQTY_100268_.tb6_1(29):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(29):=8507;
RQTY_100268_.tb6_2(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(29),-1)));
RQTY_100268_.old_tb6_3(29):=90021319;
RQTY_100268_.tb6_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(29),-1)));
RQTY_100268_.old_tb6_4(29):=255;
RQTY_100268_.tb6_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(29),-1)));
RQTY_100268_.old_tb6_5(29):=null;
RQTY_100268_.tb6_5(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(29),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (29)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(29),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(29),
ENTITY_ID=RQTY_100268_.tb6_2(29),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(29),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(29),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(29),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=27,
DISPLAY_NAME='Id del Paquete'
,
DISPLAY_ORDER=27,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='ID_DEL_PAQUETE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='LD_FA_INFOADIC_REFERIDO'
,
ATTRI_TECHNICAL_NAME='ID_PACKAGES'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(29);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(29),
RQTY_100268_.tb6_1(29),
RQTY_100268_.tb6_2(29),
RQTY_100268_.tb6_3(29),
RQTY_100268_.tb6_4(29),
RQTY_100268_.tb6_5(29),
null,
null,
null,
null,
27,
'Id del Paquete'
,
27,
'N'
,
'N'
,
'N'
,
'ID_DEL_PAQUETE'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'LD_FA_INFOADIC_REFERIDO'
,
'ID_PACKAGES'
,
'Y'
,
'N'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(17):=121146308;
RQTY_100268_.tb2_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(17):=RQTY_100268_.tb2_0(17);
RQTY_100268_.old_tb2_1(17):='MO_INITATRIB_CT23E121146308'
;
RQTY_100268_.tb2_1(17):=RQTY_100268_.tb2_0(17);
RQTY_100268_.tb2_2(17):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(17),
RQTY_100268_.tb2_1(17),
RQTY_100268_.tb2_2(17),
'Parametro = GE_BOPARAMETER.FNUGET("ADDRESS_TYPE_PRINCIP", "Y");GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(Parametro)'
,
'OPEN'
,
to_date('10-07-2014 11:08:26','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:20','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:20','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI-ADDRESS_TYPE_ID_MO_ADDRESS_100232'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(30):=106723;
RQTY_100268_.tb6_1(30):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(30):=21;
RQTY_100268_.tb6_2(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(30),-1)));
RQTY_100268_.old_tb6_3(30):=476;
RQTY_100268_.tb6_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(30),-1)));
RQTY_100268_.old_tb6_4(30):=null;
RQTY_100268_.tb6_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(30),-1)));
RQTY_100268_.old_tb6_5(30):=null;
RQTY_100268_.tb6_5(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(30),-1)));
RQTY_100268_.tb6_7(30):=RQTY_100268_.tb2_0(17);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (30)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(30),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(30),
ENTITY_ID=RQTY_100268_.tb6_2(30),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(30),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(30),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(30),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(30),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=28,
DISPLAY_NAME='Código del Tipo Dirección'
,
DISPLAY_ORDER=28,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(30);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(30),
RQTY_100268_.tb6_1(30),
RQTY_100268_.tb6_2(30),
RQTY_100268_.tb6_3(30),
RQTY_100268_.tb6_4(30),
RQTY_100268_.tb6_5(30),
null,
RQTY_100268_.tb6_7(30),
null,
null,
28,
'Código del Tipo Dirección'
,
28,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb2_0(18):=121146310;
RQTY_100268_.tb2_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQTY_100268_.tb2_0(18):=RQTY_100268_.tb2_0(18);
RQTY_100268_.old_tb2_1(18):='MO_INITATRIB_CT23E121146310'
;
RQTY_100268_.tb2_1(18):=RQTY_100268_.tb2_0(18);
RQTY_100268_.tb2_2(18):=RQTY_100268_.tb1_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQTY_100268_.tb2_0(18),
RQTY_100268_.tb2_1(18),
RQTY_100268_.tb2_2(18),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'OPEN'
,
to_date('10-07-2014 11:08:26','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:20','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:20','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI_IS_ADDRESS_MAIN_MO_ADDRESS_100232'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(31):=106724;
RQTY_100268_.tb6_1(31):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(31):=21;
RQTY_100268_.tb6_2(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(31),-1)));
RQTY_100268_.old_tb6_3(31):=2;
RQTY_100268_.tb6_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(31),-1)));
RQTY_100268_.old_tb6_4(31):=null;
RQTY_100268_.tb6_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(31),-1)));
RQTY_100268_.old_tb6_5(31):=null;
RQTY_100268_.tb6_5(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(31),-1)));
RQTY_100268_.tb6_7(31):=RQTY_100268_.tb2_0(18);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (31)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(31),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(31),
ENTITY_ID=RQTY_100268_.tb6_2(31),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(31),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(31),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(31),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQTY_100268_.tb6_7(31),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=29,
DISPLAY_NAME='Is_Address_Main'
,
DISPLAY_ORDER=29,
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(31);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(31),
RQTY_100268_.tb6_1(31),
RQTY_100268_.tb6_2(31),
RQTY_100268_.tb6_3(31),
RQTY_100268_.tb6_4(31),
RQTY_100268_.tb6_5(31),
null,
RQTY_100268_.tb6_7(31),
null,
null,
29,
'Is_Address_Main'
,
29,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(32):=106725;
RQTY_100268_.tb6_1(32):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(32):=5872;
RQTY_100268_.tb6_2(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(32),-1)));
RQTY_100268_.old_tb6_3(32):=138161;
RQTY_100268_.tb6_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(32),-1)));
RQTY_100268_.old_tb6_4(32):=null;
RQTY_100268_.tb6_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(32),-1)));
RQTY_100268_.old_tb6_5(32):=null;
RQTY_100268_.tb6_5(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(32),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (32)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(32),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(32),
ENTITY_ID=RQTY_100268_.tb6_2(32),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(32),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(32),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(32),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=30,
DISPLAY_NAME='Información del Referente'
,
DISPLAY_ORDER=30,
INCLUDED_VAL_DOC='Y'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='INFORMACION_DEL_REFERENTE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(32);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(32),
RQTY_100268_.tb6_1(32),
RQTY_100268_.tb6_2(32),
RQTY_100268_.tb6_3(32),
RQTY_100268_.tb6_4(32),
RQTY_100268_.tb6_5(32),
null,
null,
null,
null,
30,
'Información del Referente'
,
30,
'Y'
,
'N'
,
'N'
,
'INFORMACION_DEL_REFERENTE'
,
'N'
,
1,
'M'
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.old_tb7_0(8):=120079390;
RQTY_100268_.tb7_0(8):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
RQTY_100268_.tb7_0(8):=RQTY_100268_.tb7_0(8);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (8)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (RQTY_100268_.tb7_0(8),
16,
'LDC LISTA DE USUARIOS'
,
'SELECT  /*+ ordered use_nl(suscripc ge_subscriber)*/ SUSCCODI ID,
subscriber_name||'|| chr(39) ||' '|| chr(39) ||'||subs_last_name DESCRIPTION
FROM suscripc, ge_subscriber
WHERE
suscclie = subscriber_id
'
,
'LDC LISTA DE USUARIOS'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(33):=106726;
RQTY_100268_.tb6_1(33):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(33):=8507;
RQTY_100268_.tb6_2(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(33),-1)));
RQTY_100268_.old_tb6_3(33):=90021317;
RQTY_100268_.tb6_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(33),-1)));
RQTY_100268_.old_tb6_4(33):=null;
RQTY_100268_.tb6_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(33),-1)));
RQTY_100268_.old_tb6_5(33):=null;
RQTY_100268_.tb6_5(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(33),-1)));
RQTY_100268_.tb6_6(33):=RQTY_100268_.tb7_0(8);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (33)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(33),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(33),
ENTITY_ID=RQTY_100268_.tb6_2(33),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(33),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(33),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(33),
STATEMENT_ID=RQTY_100268_.tb6_6(33),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=31,
DISPLAY_NAME='Suscripción del Usuario Referente'
,
DISPLAY_ORDER=31,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
,
REQUIRED='N'
,
TAG_NAME='SUSCRIPCION_DEL_USUARIO_REFERENTE'
,
GROUP_ATTRIBUTE_TYPE='N'
,
INSTANCE_AMOUNT=1,
MODULE='M'
,
PROCESS_WITH_XML='Y'
,
ACTIVE='Y'
,
ENTITY_NAME='LD_FA_INFOADIC_REFERIDO'
,
ATTRI_TECHNICAL_NAME='SUSCCODI'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(33);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(33),
RQTY_100268_.tb6_1(33),
RQTY_100268_.tb6_2(33),
RQTY_100268_.tb6_3(33),
RQTY_100268_.tb6_4(33),
RQTY_100268_.tb6_5(33),
RQTY_100268_.tb6_6(33),
null,
null,
null,
31,
'Suscripción del Usuario Referente'
,
31,
'N'
,
'N'
,
'N'
,
'SUSCRIPCION_DEL_USUARIO_REFERENTE'
,
'N'
,
1,
'M'
,
'Y'
,
'Y'
,
'LD_FA_INFOADIC_REFERIDO'
,
'SUSCCODI'
,
'Y'
,
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(34):=106727;
RQTY_100268_.tb6_1(34):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(34):=68;
RQTY_100268_.tb6_2(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(34),-1)));
RQTY_100268_.old_tb6_3(34):=6732;
RQTY_100268_.tb6_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(34),-1)));
RQTY_100268_.old_tb6_4(34):=null;
RQTY_100268_.tb6_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(34),-1)));
RQTY_100268_.old_tb6_5(34):=90021317;
RQTY_100268_.tb6_5(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(34),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (34)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(34),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(34),
ENTITY_ID=RQTY_100268_.tb6_2(34),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(34),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(34),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(34),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=32,
DISPLAY_NAME='Nombre'
,
DISPLAY_ORDER=32,
INCLUDED_VAL_DOC='N'
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
ATTRI_TECHNICAL_NAME='VARCHAR_1'
,
IN_PERSIST='N'
,
INCLUDED_XML='Y'

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(34);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(34),
RQTY_100268_.tb6_1(34),
RQTY_100268_.tb6_2(34),
RQTY_100268_.tb6_3(34),
RQTY_100268_.tb6_4(34),
RQTY_100268_.tb6_5(34),
null,
null,
null,
null,
32,
'Nombre'
,
32,
'N'
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
'VARCHAR_1'
,
'N'
,
'Y'
);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb6_0(35):=106728;
RQTY_100268_.tb6_1(35):=RQTY_100268_.tb5_0(0);
RQTY_100268_.old_tb6_2(35):=68;
RQTY_100268_.tb6_2(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQTY_100268_.TBENTITYNAME(NVL(RQTY_100268_.old_tb6_2(35),-1)));
RQTY_100268_.old_tb6_3(35):=6733;
RQTY_100268_.tb6_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_3(35),-1)));
RQTY_100268_.old_tb6_4(35):=null;
RQTY_100268_.tb6_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_4(35),-1)));
RQTY_100268_.old_tb6_5(35):=90021317;
RQTY_100268_.tb6_5(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQTY_100268_.TBENTITYATTRIBUTENAME(NVL(RQTY_100268_.old_tb6_5(35),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_ATTRIBS fila (35)',1);
UPDATE PS_PACKAGE_ATTRIBS SET PACKAGE_ATTRIBS_ID=RQTY_100268_.tb6_0(35),
PACKAGE_TYPE_ID=RQTY_100268_.tb6_1(35),
ENTITY_ID=RQTY_100268_.tb6_2(35),
ENTITY_ATTRIBUTE_ID=RQTY_100268_.tb6_3(35),
MIRROR_ENTI_ATTRIB=RQTY_100268_.tb6_4(35),
PARENT_ATTRIBUTE_ID=RQTY_100268_.tb6_5(35),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PROCESS_SEQUENCE=33,
DISPLAY_NAME='Apellido'
,
DISPLAY_ORDER=33,
INCLUDED_VAL_DOC='N'
,
HEADER_TAG_XML='N'
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

 WHERE PACKAGE_ATTRIBS_ID = RQTY_100268_.tb6_0(35);
if not (sql%found) then
INSERT INTO PS_PACKAGE_ATTRIBS(PACKAGE_ATTRIBS_ID,PACKAGE_TYPE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQTY_100268_.tb6_0(35),
RQTY_100268_.tb6_1(35),
RQTY_100268_.tb6_2(35),
RQTY_100268_.tb6_3(35),
RQTY_100268_.tb6_4(35),
RQTY_100268_.tb6_5(35),
null,
null,
null,
null,
33,
'Apellido'
,
33,
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb9_0(0):='104'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (RQTY_100268_.tb9_0(0),
'Utilities'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb10_0(0):=104;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (RQTY_100268_.tb10_0(0),
'Utilities'
);

exception 
when dup_val_on_index then 
 return;
when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb11_0(0):=7014;
RQTY_100268_.tb11_2(0):=RQTY_100268_.tb9_0(0);
RQTY_100268_.tb11_3(0):=RQTY_100268_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=RQTY_100268_.tb11_0(0),
SERVCLAS=null,
SERVTISE=RQTY_100268_.tb11_2(0),
SERVSETI=RQTY_100268_.tb11_3(0),
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
 WHERE SERVCODI = RQTY_100268_.tb11_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (RQTY_100268_.tb11_0(0),
null,
RQTY_100268_.tb11_2(0),
RQTY_100268_.tb11_3(0),
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb12_0(0):=147;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=RQTY_100268_.tb12_0(0),
CLASS_REGISTER_ID=6,
DESCRIPTION='VISITA VENTA GAS XML'
,
ASSIGNABLE='N'
,
USE_WF_PLAN='N'
,
TAG_NAME='MOTY_VISITA_VENTA_GAS_XML'
,
ACTIVITY_TYPE=null
 WHERE MOTIVE_TYPE_ID = RQTY_100268_.tb12_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (RQTY_100268_.tb12_0(0),
6,
'VISITA VENTA GAS XML'
,
'N'
,
'N'
,
'MOTY_VISITA_VENTA_GAS_XML'
,
null);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb13_0(0):=100276;
RQTY_100268_.tb13_1(0):=RQTY_100268_.tb11_0(0);
RQTY_100268_.tb13_2(0):=RQTY_100268_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQTY_100268_.tb13_0(0),
PRODUCT_TYPE_ID=RQTY_100268_.tb13_1(0),
MOTIVE_TYPE_ID=RQTY_100268_.tb13_2(0),
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_INSTALACION_DE_GAS_100276'
,
DESCRIPTION='Instalación de Gas'
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

 WHERE PRODUCT_MOTIVE_ID = RQTY_100268_.tb13_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQTY_100268_.tb13_0(0),
RQTY_100268_.tb13_1(0),
RQTY_100268_.tb13_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_GAS_100276'
,
'Instalación de Gas'
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
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb14_0(0):=10000000259;
RQTY_100268_.tb14_1(0):=RQTY_100268_.tb5_0(0);
RQTY_100268_.tb14_3(0):=RQTY_100268_.tb13_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=RQTY_100268_.tb14_0(0),
PACKAGE_TYPE_ID=RQTY_100268_.tb14_1(0),
PRODUCT_TYPE_ID=null,
PRODUCT_MOTIVE_ID=RQTY_100268_.tb14_3(0),
UNIT_TYPE_ID=100549,
INTERFACE_CONFIG_ID=1
 WHERE PACKAGE_UNITTYPE_ID = RQTY_100268_.tb14_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (RQTY_100268_.tb14_0(0),
RQTY_100268_.tb14_1(0),
null,
RQTY_100268_.tb14_3(0),
100549,
1);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;

RQTY_100268_.tb15_0(0):=100279;
RQTY_100268_.tb15_1(0):=RQTY_100268_.tb13_0(0);
RQTY_100268_.tb15_3(0):=RQTY_100268_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=RQTY_100268_.tb15_0(0),
PRODUCT_MOTIVE_ID=RQTY_100268_.tb15_1(0),
PRODUCT_TYPE_ID=7014,
PACKAGE_TYPE_ID=RQTY_100268_.tb15_3(0),
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = RQTY_100268_.tb15_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (RQTY_100268_.tb15_0(0),
RQTY_100268_.tb15_1(0),
7014,
RQTY_100268_.tb15_3(0),
1,
1,
2);
end if;

exception when others then
RQTY_100268_.blProcessStatus := false;
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
nuIndex := RQTY_100268_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQTY_100268_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQTY_100268_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQTY_100268_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQTY_100268_.tbExpressionsId.next(nuIndex);
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

if (not RQTY_100268_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQTY_100268_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQTY_100268_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQTY_100268_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQTY_100268_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := RQTY_100268_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQTY_100268_.blProcessStatus := false;
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
 nuIndex := RQTY_100268_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQTY_100268_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQTY_100268_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQTY_100268_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQTY_100268_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQTY_100268_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQTY_100268_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQTY_100268_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQTY_100268_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQTY_100268_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQPMT_100268_',
'CREATE OR REPLACE PACKAGE RQPMT_100268_ IS ' || chr(10) ||
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
'tb4_2 ty4_2;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  package_type_id = 100268; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prd_motiv_package ' || chr(10) ||
'WHERE PACKAGE_type_id = 100268 ' || chr(10) ||
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
'WHERE PACKAGE_type_id = 100268 ' || chr(10) ||
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
'END RQPMT_100268_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQPMT_100268_******************************'); END;
/

BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open RQPMT_100268_.cuExpressions;
fetch RQPMT_100268_.cuExpressions bulk collect INTO RQPMT_100268_.tbExpressionsId;
close RQPMT_100268_.cuExpressions;

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   RQPMT_100268_.tbEntityName(-1) := 'NULL';
   RQPMT_100268_.tbEntityAttributeName(-1) := 'NULL';

   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQPMT_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQPMT_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQPMT_100268_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQPMT_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQPMT_100268_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQPMT_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQPMT_100268_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
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
WHERE PACKAGE_type_id = 100268
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
WHERE PACKAGE_type_id = 100268
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
WHERE PACKAGE_type_id = 100268
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
WHERE PACKAGE_type_id = 100268
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
WHERE PACKAGE_type_id = 100268
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
WHERE PACKAGE_type_id = 100268
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQPMT_100268_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100268
))));

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100268_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100268_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100268_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100268_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100268
))));

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100268
))));

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=RQPMT_100268_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = RQPMT_100268_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100268
)))));

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=RQPMT_100268_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = RQPMT_100268_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=RQPMT_100268_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = RQPMT_100268_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=RQPMT_100268_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = RQPMT_100268_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100268
))));

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
))));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prd_motiv_package
WHERE PACKAGE_type_id = 100268
))));

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
)));
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
RQPMT_100268_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
));
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100268_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100268_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=RQPMT_100268_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = RQPMT_100268_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQPMT_100268_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQPMT_100268_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
WHERE PACKAGE_type_id = 100268
);
nuIndex binary_integer;
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb0_0(0):=100276;
RQPMT_100268_.tb0_1(0):=7014;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=RQPMT_100268_.tb0_0(0),
PRODUCT_TYPE_ID=RQPMT_100268_.tb0_1(0),
MOTIVE_TYPE_ID=147,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_INSTALACION_DE_GAS_100276'
,
DESCRIPTION='Instalación de Gas'
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

 WHERE PRODUCT_MOTIVE_ID = RQPMT_100268_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (RQPMT_100268_.tb0_0(0),
RQPMT_100268_.tb0_1(0),
147,
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_GAS_100276'
,
'Instalación de Gas'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(0):=104158;
RQPMT_100268_.old_tb1_1(0):=8;
RQPMT_100268_.tb1_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(0),-1)));
RQPMT_100268_.old_tb1_2(0):=4011;
RQPMT_100268_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(0),-1)));
RQPMT_100268_.old_tb1_3(0):=null;
RQPMT_100268_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(0),-1)));
RQPMT_100268_.old_tb1_4(0):=null;
RQPMT_100268_.tb1_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(0),-1)));
RQPMT_100268_.tb1_9(0):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(0),
ENTITY_ID=RQPMT_100268_.tb1_1(0),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(0),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(0),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(0),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Número del Servicio'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(0),
RQPMT_100268_.tb1_1(0),
RQPMT_100268_.tb1_2(0),
RQPMT_100268_.tb1_3(0),
RQPMT_100268_.tb1_4(0),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(0),
15,
'Número del Servicio'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb2_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=RQPMT_100268_.tb2_0(0),
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

 WHERE MODULE_ID = RQPMT_100268_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (RQPMT_100268_.tb2_0(0),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb3_0(0):=23;
RQPMT_100268_.tb3_1(0):=RQPMT_100268_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=RQPMT_100268_.tb3_0(0),
MODULE_ID=RQPMT_100268_.tb3_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = RQPMT_100268_.tb3_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (RQPMT_100268_.tb3_0(0),
RQPMT_100268_.tb3_1(0),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(0):=121146386;
RQPMT_100268_.tb4_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(0):=RQPMT_100268_.tb4_0(0);
RQPMT_100268_.old_tb4_1(0):='MO_INITATRIB_CT23E121146386'
;
RQPMT_100268_.tb4_1(0):=RQPMT_100268_.tb4_0(0);
RQPMT_100268_.tb4_2(0):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(0),
RQPMT_100268_.tb4_1(0),
RQPMT_100268_.tb4_2(0),
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE", NULL, "SUSCRIPC", "SUSCCODI", 1) = GE_BOCONSTANTS.GETTRUE(),GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,"SUSCRIPC","SUSCCODI",SBSUSCRIPTION);GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(SBSUSCRIPTION);,)'
,
'OPEN'
,
to_date('10-07-2014 10:28:48','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI-MOT-MO_MOTIVE-SUSCRIPC-SUSCCODI Identificador de la Suscripcion'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(1):=104159;
RQPMT_100268_.old_tb1_1(1):=8;
RQPMT_100268_.tb1_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(1),-1)));
RQPMT_100268_.old_tb1_2(1):=11403;
RQPMT_100268_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(1),-1)));
RQPMT_100268_.old_tb1_3(1):=null;
RQPMT_100268_.tb1_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(1),-1)));
RQPMT_100268_.old_tb1_4(1):=null;
RQPMT_100268_.tb1_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(1),-1)));
RQPMT_100268_.tb1_6(1):=RQPMT_100268_.tb4_0(0);
RQPMT_100268_.tb1_9(1):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(1),
ENTITY_ID=RQPMT_100268_.tb1_1(1),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(1),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(1),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(1),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(1),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Identificador de la Suscripción'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(1),
RQPMT_100268_.tb1_1(1),
RQPMT_100268_.tb1_2(1),
RQPMT_100268_.tb1_3(1),
RQPMT_100268_.tb1_4(1),
null,
RQPMT_100268_.tb1_6(1),
null,
null,
RQPMT_100268_.tb1_9(1),
16,
'Identificador de la Suscripción'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(2):=104160;
RQPMT_100268_.old_tb1_1(2):=8;
RQPMT_100268_.tb1_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(2),-1)));
RQPMT_100268_.old_tb1_2(2):=6683;
RQPMT_100268_.tb1_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(2),-1)));
RQPMT_100268_.old_tb1_3(2):=null;
RQPMT_100268_.tb1_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(2),-1)));
RQPMT_100268_.old_tb1_4(2):=null;
RQPMT_100268_.tb1_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(2),-1)));
RQPMT_100268_.tb1_9(2):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(2),
ENTITY_ID=RQPMT_100268_.tb1_1(2),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(2),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(2),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(2),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='CLIENT_PRIVACY_FLAG'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(2),
RQPMT_100268_.tb1_1(2),
RQPMT_100268_.tb1_2(2),
RQPMT_100268_.tb1_3(2),
RQPMT_100268_.tb1_4(2),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(2),
17,
'CLIENT_PRIVACY_FLAG'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(1):=121146387;
RQPMT_100268_.tb4_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(1):=RQPMT_100268_.tb4_0(1);
RQPMT_100268_.old_tb4_1(1):='MO_INITATRIB_CT23E121146387'
;
RQPMT_100268_.tb4_1(1):=RQPMT_100268_.tb4_0(1);
RQPMT_100268_.tb4_2(1):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(1),
RQPMT_100268_.tb4_1(1),
RQPMT_100268_.tb4_2(1),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(0)'
,
'OPEN'
,
to_date('10-07-2014 09:36:32','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(3):=104161;
RQPMT_100268_.old_tb1_1(3):=8;
RQPMT_100268_.tb1_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(3),-1)));
RQPMT_100268_.old_tb1_2(3):=20362;
RQPMT_100268_.tb1_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(3),-1)));
RQPMT_100268_.old_tb1_3(3):=null;
RQPMT_100268_.tb1_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(3),-1)));
RQPMT_100268_.old_tb1_4(3):=null;
RQPMT_100268_.tb1_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(3),-1)));
RQPMT_100268_.tb1_6(3):=RQPMT_100268_.tb4_0(1);
RQPMT_100268_.tb1_9(3):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(3),
ENTITY_ID=RQPMT_100268_.tb1_1(3),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(3),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(3),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(3),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(3),
PROCESS_SEQUENCE=18,
DISPLAY_NAME='VALUE_TO_DEBIT'
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
ATTRI_TECHNICAL_NAME='VALUE_TO_DEBIT'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(3),
RQPMT_100268_.tb1_1(3),
RQPMT_100268_.tb1_2(3),
RQPMT_100268_.tb1_3(3),
RQPMT_100268_.tb1_4(3),
null,
RQPMT_100268_.tb1_6(3),
null,
null,
RQPMT_100268_.tb1_9(3),
18,
'VALUE_TO_DEBIT'
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
'VALUE_TO_DEBIT'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(2):=121146388;
RQPMT_100268_.tb4_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(2):=RQPMT_100268_.tb4_0(2);
RQPMT_100268_.old_tb4_1(2):='MO_INITATRIB_CT23E121146388'
;
RQPMT_100268_.tb4_1(2):=RQPMT_100268_.tb4_0(2);
RQPMT_100268_.tb4_2(2):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(2),
RQPMT_100268_.tb4_1(2),
RQPMT_100268_.tb4_2(2),
'LD_BOFLOWFNBPACK.GETLDPARAMATER("COD_COMERCIAL_PLAN","N",sbplanComercial);sbplanComercial = null;GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(sbplanComercial)'
,
'OPEN'
,
to_date('10-07-2014 09:36:32','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'INI - MOT - Plan Comercial - Venta Seguros'
,
'PP'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(4):=104162;
RQPMT_100268_.old_tb1_1(4):=8;
RQPMT_100268_.tb1_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(4),-1)));
RQPMT_100268_.old_tb1_2(4):=45189;
RQPMT_100268_.tb1_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(4),-1)));
RQPMT_100268_.old_tb1_3(4):=null;
RQPMT_100268_.tb1_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(4),-1)));
RQPMT_100268_.old_tb1_4(4):=null;
RQPMT_100268_.tb1_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(4),-1)));
RQPMT_100268_.tb1_6(4):=RQPMT_100268_.tb4_0(2);
RQPMT_100268_.tb1_9(4):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(4),
ENTITY_ID=RQPMT_100268_.tb1_1(4),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(4),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(4),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(4),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(4),
PROCESS_SEQUENCE=19,
DISPLAY_NAME='COMMERCIAL_PLAN_ID'
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
ATTRI_TECHNICAL_NAME='COMMERCIAL_PLAN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(4),
RQPMT_100268_.tb1_1(4),
RQPMT_100268_.tb1_2(4),
RQPMT_100268_.tb1_3(4),
RQPMT_100268_.tb1_4(4),
null,
RQPMT_100268_.tb1_6(4),
null,
null,
RQPMT_100268_.tb1_9(4),
19,
'COMMERCIAL_PLAN_ID'
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
'COMMERCIAL_PLAN_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(3):=121146389;
RQPMT_100268_.tb4_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(3):=RQPMT_100268_.tb4_0(3);
RQPMT_100268_.old_tb4_1(3):='MO_INITATRIB_CT23E121146389'
;
RQPMT_100268_.tb4_1(3):=RQPMT_100268_.tb4_0(3);
RQPMT_100268_.tb4_2(3):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(3),
RQPMT_100268_.tb4_1(3),
RQPMT_100268_.tb4_2(3),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'OPEN'
,
to_date('10-07-2014 10:28:48','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(5):=104143;
RQPMT_100268_.old_tb1_1(5):=8;
RQPMT_100268_.tb1_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(5),-1)));
RQPMT_100268_.old_tb1_2(5):=187;
RQPMT_100268_.tb1_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(5),-1)));
RQPMT_100268_.old_tb1_3(5):=null;
RQPMT_100268_.tb1_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(5),-1)));
RQPMT_100268_.old_tb1_4(5):=null;
RQPMT_100268_.tb1_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(5),-1)));
RQPMT_100268_.tb1_6(5):=RQPMT_100268_.tb4_0(3);
RQPMT_100268_.tb1_9(5):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(5),
ENTITY_ID=RQPMT_100268_.tb1_1(5),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(5),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(5),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(5),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(5),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(5),
RQPMT_100268_.tb1_1(5),
RQPMT_100268_.tb1_2(5),
RQPMT_100268_.tb1_3(5),
RQPMT_100268_.tb1_4(5),
null,
RQPMT_100268_.tb1_6(5),
null,
null,
RQPMT_100268_.tb1_9(5),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(6):=104144;
RQPMT_100268_.old_tb1_1(6):=8;
RQPMT_100268_.tb1_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(6),-1)));
RQPMT_100268_.old_tb1_2(6):=213;
RQPMT_100268_.tb1_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(6),-1)));
RQPMT_100268_.old_tb1_3(6):=255;
RQPMT_100268_.tb1_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(6),-1)));
RQPMT_100268_.old_tb1_4(6):=null;
RQPMT_100268_.tb1_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(6),-1)));
RQPMT_100268_.tb1_9(6):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(6),
ENTITY_ID=RQPMT_100268_.tb1_1(6),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(6),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(6),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(6),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(6),
RQPMT_100268_.tb1_1(6),
RQPMT_100268_.tb1_2(6),
RQPMT_100268_.tb1_3(6),
RQPMT_100268_.tb1_4(6),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(6),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(4):=121146390;
RQPMT_100268_.tb4_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(4):=RQPMT_100268_.tb4_0(4);
RQPMT_100268_.old_tb4_1(4):='MO_INITATRIB_CT23E121146390'
;
RQPMT_100268_.tb4_1(4):=RQPMT_100268_.tb4_0(4);
RQPMT_100268_.tb4_2(4):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(4),
RQPMT_100268_.tb4_1(4),
RQPMT_100268_.tb4_2(4),
'CF_BOINITRULES.INIPRIORITY()'
,
'OPEN'
,
to_date('10-07-2014 10:28:48','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(7):=104145;
RQPMT_100268_.old_tb1_1(7):=8;
RQPMT_100268_.tb1_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(7),-1)));
RQPMT_100268_.old_tb1_2(7):=203;
RQPMT_100268_.tb1_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(7),-1)));
RQPMT_100268_.old_tb1_3(7):=null;
RQPMT_100268_.tb1_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(7),-1)));
RQPMT_100268_.old_tb1_4(7):=null;
RQPMT_100268_.tb1_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(7),-1)));
RQPMT_100268_.tb1_6(7):=RQPMT_100268_.tb4_0(4);
RQPMT_100268_.tb1_9(7):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(7),
ENTITY_ID=RQPMT_100268_.tb1_1(7),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(7),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(7),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(7),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(7),
PROCESS_SEQUENCE=2,
DISPLAY_NAME='Prioridad'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(7),
RQPMT_100268_.tb1_1(7),
RQPMT_100268_.tb1_2(7),
RQPMT_100268_.tb1_3(7),
RQPMT_100268_.tb1_4(7),
null,
RQPMT_100268_.tb1_6(7),
null,
null,
RQPMT_100268_.tb1_9(7),
2,
'Prioridad'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(5):=121146392;
RQPMT_100268_.tb4_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(5):=RQPMT_100268_.tb4_0(5);
RQPMT_100268_.old_tb4_1(5):='MO_INITATRIB_CT23E121146392'
;
RQPMT_100268_.tb4_1(5):=RQPMT_100268_.tb4_0(5);
RQPMT_100268_.tb4_2(5):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(5),
RQPMT_100268_.tb4_1(5),
RQPMT_100268_.tb4_2(5),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'OPEN'
,
to_date('10-07-2014 10:28:48','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(8):=104146;
RQPMT_100268_.old_tb1_1(8):=8;
RQPMT_100268_.tb1_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(8),-1)));
RQPMT_100268_.old_tb1_2(8):=322;
RQPMT_100268_.tb1_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(8),-1)));
RQPMT_100268_.old_tb1_3(8):=null;
RQPMT_100268_.tb1_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(8),-1)));
RQPMT_100268_.old_tb1_4(8):=null;
RQPMT_100268_.tb1_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(8),-1)));
RQPMT_100268_.tb1_6(8):=RQPMT_100268_.tb4_0(5);
RQPMT_100268_.tb1_9(8):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(8),
ENTITY_ID=RQPMT_100268_.tb1_1(8),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(8),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(8),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(8),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(8),
PROCESS_SEQUENCE=3,
DISPLAY_NAME='Entregas Parciales'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(8),
RQPMT_100268_.tb1_1(8),
RQPMT_100268_.tb1_2(8),
RQPMT_100268_.tb1_3(8),
RQPMT_100268_.tb1_4(8),
null,
RQPMT_100268_.tb1_6(8),
null,
null,
RQPMT_100268_.tb1_9(8),
3,
'Entregas Parciales'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(9):=104147;
RQPMT_100268_.old_tb1_1(9):=8;
RQPMT_100268_.tb1_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(9),-1)));
RQPMT_100268_.old_tb1_2(9):=2641;
RQPMT_100268_.tb1_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(9),-1)));
RQPMT_100268_.old_tb1_3(9):=null;
RQPMT_100268_.tb1_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(9),-1)));
RQPMT_100268_.old_tb1_4(9):=null;
RQPMT_100268_.tb1_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(9),-1)));
RQPMT_100268_.tb1_9(9):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(9),
ENTITY_ID=RQPMT_100268_.tb1_1(9),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(9),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(9),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(9),
PROCESS_SEQUENCE=4,
DISPLAY_NAME='Límite de Crédito'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(9),
RQPMT_100268_.tb1_1(9),
RQPMT_100268_.tb1_2(9),
RQPMT_100268_.tb1_3(9),
RQPMT_100268_.tb1_4(9),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(9),
4,
'Límite de Crédito'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(10):=104148;
RQPMT_100268_.old_tb1_1(10):=8;
RQPMT_100268_.tb1_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(10),-1)));
RQPMT_100268_.old_tb1_2(10):=197;
RQPMT_100268_.tb1_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(10),-1)));
RQPMT_100268_.old_tb1_3(10):=null;
RQPMT_100268_.tb1_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(10),-1)));
RQPMT_100268_.old_tb1_4(10):=null;
RQPMT_100268_.tb1_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(10),-1)));
RQPMT_100268_.tb1_9(10):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(10),
ENTITY_ID=RQPMT_100268_.tb1_1(10),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(10),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(10),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(10),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='PRIVACY_FLAG'
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
ATTRI_TECHNICAL_NAME='PRIVACY_FLAG'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(10),
RQPMT_100268_.tb1_1(10),
RQPMT_100268_.tb1_2(10),
RQPMT_100268_.tb1_3(10),
RQPMT_100268_.tb1_4(10),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(10),
5,
'PRIVACY_FLAG'
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
'PRIVACY_FLAG'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(11):=104149;
RQPMT_100268_.old_tb1_1(11):=8;
RQPMT_100268_.tb1_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(11),-1)));
RQPMT_100268_.old_tb1_2(11):=189;
RQPMT_100268_.tb1_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(11),-1)));
RQPMT_100268_.old_tb1_3(11):=255;
RQPMT_100268_.tb1_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(11),-1)));
RQPMT_100268_.old_tb1_4(11):=null;
RQPMT_100268_.tb1_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(11),-1)));
RQPMT_100268_.tb1_9(11):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(11),
ENTITY_ID=RQPMT_100268_.tb1_1(11),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(11),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(11),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(11),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Número Petición Atención al cliente'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(11),
RQPMT_100268_.tb1_1(11),
RQPMT_100268_.tb1_2(11),
RQPMT_100268_.tb1_3(11),
RQPMT_100268_.tb1_4(11),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(11),
6,
'Número Petición Atención al cliente'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(12):=104150;
RQPMT_100268_.old_tb1_1(12):=8;
RQPMT_100268_.tb1_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(12),-1)));
RQPMT_100268_.old_tb1_2(12):=413;
RQPMT_100268_.tb1_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(12),-1)));
RQPMT_100268_.old_tb1_3(12):=null;
RQPMT_100268_.tb1_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(12),-1)));
RQPMT_100268_.old_tb1_4(12):=null;
RQPMT_100268_.tb1_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(12),-1)));
RQPMT_100268_.tb1_9(12):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(12),
ENTITY_ID=RQPMT_100268_.tb1_1(12),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(12),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(12),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(12),
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(12),
RQPMT_100268_.tb1_1(12),
RQPMT_100268_.tb1_2(12),
RQPMT_100268_.tb1_3(12),
RQPMT_100268_.tb1_4(12),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(12),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(13):=104151;
RQPMT_100268_.old_tb1_1(13):=8;
RQPMT_100268_.tb1_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(13),-1)));
RQPMT_100268_.old_tb1_2(13):=50001324;
RQPMT_100268_.tb1_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(13),-1)));
RQPMT_100268_.old_tb1_3(13):=null;
RQPMT_100268_.tb1_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(13),-1)));
RQPMT_100268_.old_tb1_4(13):=null;
RQPMT_100268_.tb1_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(13),-1)));
RQPMT_100268_.tb1_9(13):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(13),
ENTITY_ID=RQPMT_100268_.tb1_1(13),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(13),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(13),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(13),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Ubicación Geográfica'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(13),
RQPMT_100268_.tb1_1(13),
RQPMT_100268_.tb1_2(13),
RQPMT_100268_.tb1_3(13),
RQPMT_100268_.tb1_4(13),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(13),
8,
'Ubicación Geográfica'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.old_tb4_0(6):=121146395;
RQPMT_100268_.tb4_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RQPMT_100268_.tb4_0(6):=RQPMT_100268_.tb4_0(6);
RQPMT_100268_.old_tb4_1(6):='MO_INITATRIB_CT23E121146395'
;
RQPMT_100268_.tb4_1(6):=RQPMT_100268_.tb4_0(6);
RQPMT_100268_.tb4_2(6):=RQPMT_100268_.tb3_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RQPMT_100268_.tb4_0(6),
RQPMT_100268_.tb4_1(6),
RQPMT_100268_.tb4_2(6),
'CF_BOINITRULES.INIPROVISIONALFLAG()'
,
'OPEN'
,
to_date('10-07-2014 09:36:31','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
to_date('13-01-2015 08:12:43','DD-MM-YYYY HH24:MI:SS'),
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(14):=104152;
RQPMT_100268_.old_tb1_1(14):=8;
RQPMT_100268_.tb1_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(14),-1)));
RQPMT_100268_.old_tb1_2(14):=198;
RQPMT_100268_.tb1_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(14),-1)));
RQPMT_100268_.old_tb1_3(14):=null;
RQPMT_100268_.tb1_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(14),-1)));
RQPMT_100268_.old_tb1_4(14):=null;
RQPMT_100268_.tb1_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(14),-1)));
RQPMT_100268_.tb1_6(14):=RQPMT_100268_.tb4_0(6);
RQPMT_100268_.tb1_9(14):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(14),
ENTITY_ID=RQPMT_100268_.tb1_1(14),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(14),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(14),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=RQPMT_100268_.tb1_6(14),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(14),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='PROVISIONAL_FLAG'
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
IS_CHANGE_ATTRIB='N'
,
PROCESS_WITH_XML='N'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(14),
RQPMT_100268_.tb1_1(14),
RQPMT_100268_.tb1_2(14),
RQPMT_100268_.tb1_3(14),
RQPMT_100268_.tb1_4(14),
null,
RQPMT_100268_.tb1_6(14),
null,
null,
RQPMT_100268_.tb1_9(14),
9,
'PROVISIONAL_FLAG'
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
'N'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(15):=104153;
RQPMT_100268_.old_tb1_1(15):=8;
RQPMT_100268_.tb1_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(15),-1)));
RQPMT_100268_.old_tb1_2(15):=498;
RQPMT_100268_.tb1_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(15),-1)));
RQPMT_100268_.old_tb1_3(15):=null;
RQPMT_100268_.tb1_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(15),-1)));
RQPMT_100268_.old_tb1_4(15):=null;
RQPMT_100268_.tb1_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(15),-1)));
RQPMT_100268_.tb1_9(15):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(15),
ENTITY_ID=RQPMT_100268_.tb1_1(15),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(15),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(15),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(15),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Fecha de Atención'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(15),
RQPMT_100268_.tb1_1(15),
RQPMT_100268_.tb1_2(15),
RQPMT_100268_.tb1_3(15),
RQPMT_100268_.tb1_4(15),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(15),
10,
'Fecha de Atención'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(16):=104154;
RQPMT_100268_.old_tb1_1(16):=8;
RQPMT_100268_.tb1_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(16),-1)));
RQPMT_100268_.old_tb1_2(16):=220;
RQPMT_100268_.tb1_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(16),-1)));
RQPMT_100268_.old_tb1_3(16):=null;
RQPMT_100268_.tb1_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(16),-1)));
RQPMT_100268_.old_tb1_4(16):=null;
RQPMT_100268_.tb1_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(16),-1)));
RQPMT_100268_.tb1_9(16):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(16),
ENTITY_ID=RQPMT_100268_.tb1_1(16),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(16),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(16),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(16),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Identificador de Distribución Administrativa'
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
ATTRI_TECHNICAL_NAME='DISTRIBUT_ADMIN_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(16),
RQPMT_100268_.tb1_1(16),
RQPMT_100268_.tb1_2(16),
RQPMT_100268_.tb1_3(16),
RQPMT_100268_.tb1_4(16),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(16),
11,
'Identificador de Distribución Administrativa'
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
'DISTRIBUT_ADMIN_ID'
,
'Y'
,
'N'
);
end if;

exception when others then
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(17):=104155;
RQPMT_100268_.old_tb1_1(17):=8;
RQPMT_100268_.tb1_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(17),-1)));
RQPMT_100268_.old_tb1_2(17):=524;
RQPMT_100268_.tb1_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(17),-1)));
RQPMT_100268_.old_tb1_3(17):=null;
RQPMT_100268_.tb1_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(17),-1)));
RQPMT_100268_.old_tb1_4(17):=null;
RQPMT_100268_.tb1_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(17),-1)));
RQPMT_100268_.tb1_9(17):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(17),
ENTITY_ID=RQPMT_100268_.tb1_1(17),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(17),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(17),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(17),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Estado del Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(17),
RQPMT_100268_.tb1_1(17),
RQPMT_100268_.tb1_2(17),
RQPMT_100268_.tb1_3(17),
RQPMT_100268_.tb1_4(17),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(17),
12,
'Estado del Motivo'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(18):=104156;
RQPMT_100268_.old_tb1_1(18):=8;
RQPMT_100268_.tb1_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(18),-1)));
RQPMT_100268_.old_tb1_2(18):=191;
RQPMT_100268_.tb1_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(18),-1)));
RQPMT_100268_.old_tb1_3(18):=null;
RQPMT_100268_.tb1_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(18),-1)));
RQPMT_100268_.old_tb1_4(18):=null;
RQPMT_100268_.tb1_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(18),-1)));
RQPMT_100268_.tb1_9(18):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (18)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(18),
ENTITY_ID=RQPMT_100268_.tb1_1(18),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(18),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(18),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(18),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(18),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Identificador del Tipo de Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(18);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(18),
RQPMT_100268_.tb1_1(18),
RQPMT_100268_.tb1_2(18),
RQPMT_100268_.tb1_3(18),
RQPMT_100268_.tb1_4(18),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(18),
13,
'Identificador del Tipo de Motivo'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(19):=104157;
RQPMT_100268_.old_tb1_1(19):=8;
RQPMT_100268_.tb1_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(19),-1)));
RQPMT_100268_.old_tb1_2(19):=192;
RQPMT_100268_.tb1_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(19),-1)));
RQPMT_100268_.old_tb1_3(19):=null;
RQPMT_100268_.tb1_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(19),-1)));
RQPMT_100268_.old_tb1_4(19):=null;
RQPMT_100268_.tb1_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(19),-1)));
RQPMT_100268_.tb1_9(19):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (19)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(19),
ENTITY_ID=RQPMT_100268_.tb1_1(19),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(19),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(19),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(19),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(19),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Identificador del Tipo de Producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(19);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(19),
RQPMT_100268_.tb1_1(19),
RQPMT_100268_.tb1_2(19),
RQPMT_100268_.tb1_3(19),
RQPMT_100268_.tb1_4(19),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(19),
14,
'Identificador del Tipo de Producto'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(20):=104245;
RQPMT_100268_.old_tb1_1(20):=8;
RQPMT_100268_.tb1_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(20),-1)));
RQPMT_100268_.old_tb1_2(20):=147336;
RQPMT_100268_.tb1_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(20),-1)));
RQPMT_100268_.old_tb1_3(20):=440;
RQPMT_100268_.tb1_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(20),-1)));
RQPMT_100268_.old_tb1_4(20):=null;
RQPMT_100268_.tb1_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(20),-1)));
RQPMT_100268_.tb1_9(20):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (20)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(20),
ENTITY_ID=RQPMT_100268_.tb1_1(20),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(20),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(20),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(20),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(20),
PROCESS_SEQUENCE=20,
DISPLAY_NAME='Categoría'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(20);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(20),
RQPMT_100268_.tb1_1(20),
RQPMT_100268_.tb1_2(20),
RQPMT_100268_.tb1_3(20),
RQPMT_100268_.tb1_4(20),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(20),
20,
'Categoría'
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
RQPMT_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;

RQPMT_100268_.tb1_0(21):=104246;
RQPMT_100268_.old_tb1_1(21):=8;
RQPMT_100268_.tb1_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQPMT_100268_.TBENTITYNAME(NVL(RQPMT_100268_.old_tb1_1(21),-1)));
RQPMT_100268_.old_tb1_2(21):=147337;
RQPMT_100268_.tb1_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_2(21),-1)));
RQPMT_100268_.old_tb1_3(21):=441;
RQPMT_100268_.tb1_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_3(21),-1)));
RQPMT_100268_.old_tb1_4(21):=null;
RQPMT_100268_.tb1_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQPMT_100268_.TBENTITYATTRIBUTENAME(NVL(RQPMT_100268_.old_tb1_4(21),-1)));
RQPMT_100268_.tb1_9(21):=RQPMT_100268_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (21)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=RQPMT_100268_.tb1_0(21),
ENTITY_ID=RQPMT_100268_.tb1_1(21),
ENTITY_ATTRIBUTE_ID=RQPMT_100268_.tb1_2(21),
MIRROR_ENTI_ATTRIB=RQPMT_100268_.tb1_3(21),
PARENT_ATTRIBUTE_ID=RQPMT_100268_.tb1_4(21),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=RQPMT_100268_.tb1_9(21),
PROCESS_SEQUENCE=21,
DISPLAY_NAME='Subcategoría'
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

 WHERE PROD_MOTI_ATTRIB_ID = RQPMT_100268_.tb1_0(21);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (RQPMT_100268_.tb1_0(21),
RQPMT_100268_.tb1_1(21),
RQPMT_100268_.tb1_2(21),
RQPMT_100268_.tb1_3(21),
RQPMT_100268_.tb1_4(21),
null,
null,
null,
null,
RQPMT_100268_.tb1_9(21),
21,
'Subcategoría'
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
RQPMT_100268_.blProcessStatus := false;
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

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;


mo_boLoadConfiguration.LoadPackTypeConf(100268, sbSuccess);
FOR rc in RQPMT_100268_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
nuIndex := RQPMT_100268_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || RQPMT_100268_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = RQPMT_100268_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || RQPMT_100268_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := RQPMT_100268_.tbExpressionsId.next(nuIndex);
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

if (not RQPMT_100268_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RQPMT_100268_.tb4_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RQPMT_100268_.tb4_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RQPMT_100268_.tb4_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RQPMT_100268_.tb4_0(nuRowProcess),1);
end;
nuRowProcess := RQPMT_100268_.tb4_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RQPMT_100268_.blProcessStatus := false;
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
 nuIndex := RQPMT_100268_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQPMT_100268_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQPMT_100268_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQPMT_100268_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQPMT_100268_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQPMT_100268_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQPMT_100268_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQPMT_100268_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQPMT_100268_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQPMT_100268_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQCFG_100268_',
'CREATE OR REPLACE PACKAGE RQCFG_100268_ IS ' || chr(10) ||
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
'AND     external_root_id = 100268 ' || chr(10) ||
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
'END RQCFG_100268_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQCFG_100268_******************************'); END;
/

BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Inicia BeforeScript. Se cargan Composiciones a memoria', 8);
open RQCFG_100268_.cuCompositions;
fetch RQCFG_100268_.cuCompositions bulk collect INTO RQCFG_100268_.tbCompositions;
close RQCFG_100268_.cuCompositions;

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   RQCFG_100268_.tbEntityName(-1) := 'NULL';
   RQCFG_100268_.tbEntityAttributeName(-1) := 'NULL';

   RQCFG_100268_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   RQCFG_100268_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   RQCFG_100268_.tbEntityName(2036) := 'PS_PACKAGE_ATTRIBS';
   RQCFG_100268_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   RQCFG_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100268_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100268_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100268_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(1037) := 'MO_PROCESS@ADDRESS_MAIN_COMP';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100268_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100268_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146751) := 'MO_PACKAGES@REFER_MODE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(191044) := 'MO_PACKAGES@RECURRENT_BILLING';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021316) := 'LD_FA_INFOADIC_REFERIDO@TIPOPREDIO';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021317) := 'LD_FA_INFOADIC_REFERIDO@SUSCCODI';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021319) := 'LD_FA_INFOADIC_REFERIDO@ID_PACKAGES';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021317) := 'LD_FA_INFOADIC_REFERIDO@SUSCCODI';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146751) := 'MO_PACKAGES@REFER_MODE_ID';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(39387) := 'MO_SUBS_TYPE_MOTIV@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(50000603) := 'MO_SUBS_TYPE_MOTIV@SUBS_TYPE_MOTIV_ID';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(6733) := 'MO_PROCESS@VARCHAR_2';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(1037) := 'MO_PROCESS@ADDRESS_MAIN_COMP';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(197) := 'MO_MOTIVE@PRIVACY_FLAG';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(6683) := 'MO_MOTIVE@CLIENT_PRIVACY_FLAG';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(109479) := 'MO_PACKAGES@POS_OPER_UNIT_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(109478) := 'MO_PACKAGES@OPERATING_UNIT_ID';
   RQCFG_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100268_.tbEntityAttributeName(476) := 'MO_ADDRESS@ADDRESS_TYPE_ID';
   RQCFG_100268_.tbEntityName(5872) := 'GI_ATTRIBS';
   RQCFG_100268_.tbEntityAttributeName(138161) := 'GI_ATTRIBS@ATTRIB01';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(147336) := 'MO_MOTIVE@CATEGORY_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(441) := 'MO_PROCESS@STRATUM';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(259) := 'MO_PACKAGES@MESSAG_DELIVERY_DATE';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(147337) := 'MO_MOTIVE@SUBCATEGORY_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(4015) := 'MO_PACKAGES@SUBSCRIBER_ID';
   RQCFG_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100268_.tbEntityAttributeName(474) := 'MO_ADDRESS@ADDRESS_ID';
   RQCFG_100268_.tbEntityName(21) := 'MO_ADDRESS';
   RQCFG_100268_.tbEntityAttributeName(2) := 'MO_ADDRESS@IS_ADDRESS_MAIN';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(20362) := 'MO_MOTIVE@VALUE_TO_DEBIT';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146754) := 'MO_PACKAGES@COMMENT_';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(11619) := 'MO_PACKAGES@CLIENT_PRIVACY_FLAG';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(191044) := 'MO_PACKAGES@RECURRENT_BILLING';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(11621) := 'MO_PACKAGES@SUBSCRIPTION_PEND_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(149340) := 'MO_SUBS_TYPE_MOTIV@ROLE_ID';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021316) := 'LD_FA_INFOADIC_REFERIDO@TIPOPREDIO';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(20371) := 'MO_PROCESS@COMMENTARY';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(269) := 'MO_PACKAGES@PACKAGE_TYPE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(2683) := 'MO_PACKAGES@RECEPTION_TYPE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146755) := 'MO_PACKAGES@CONTACT_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(198) := 'MO_MOTIVE@PROVISIONAL_FLAG';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(146756) := 'MO_PACKAGES@ADDRESS_ID';
   RQCFG_100268_.tbEntityName(9179) := 'MO_SUBS_TYPE_MOTIV';
   RQCFG_100268_.tbEntityAttributeName(50000606) := 'MO_SUBS_TYPE_MOTIV@SUBSCRIBER_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(258) := 'MO_PACKAGES@REQUEST_DATE';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(42118) := 'MO_PACKAGES@SALE_CHANNEL_ID';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021317) := 'LD_FA_INFOADIC_REFERIDO@SUSCCODI';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(6732) := 'MO_PROCESS@VARCHAR_1';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(45189) := 'MO_MOTIVE@COMMERCIAL_PLAN_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(413) := 'MO_MOTIVE@PRODUCT_ID';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021319) := 'LD_FA_INFOADIC_REFERIDO@ID_PACKAGES';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   RQCFG_100268_.tbEntityName(17) := 'MO_PACKAGES';
   RQCFG_100268_.tbEntityAttributeName(50001162) := 'MO_PACKAGES@PERSON_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   RQCFG_100268_.tbEntityName(8) := 'MO_MOTIVE';
   RQCFG_100268_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(440) := 'MO_PROCESS@USE';
   RQCFG_100268_.tbEntityName(68) := 'MO_PROCESS';
   RQCFG_100268_.tbEntityAttributeName(1035) := 'MO_PROCESS@ADDRESS_MAIN_MOTIVE';
   RQCFG_100268_.tbEntityName(8507) := 'LD_FA_INFOADIC_REFERIDO';
   RQCFG_100268_.tbEntityAttributeName(90021317) := 'LD_FA_INFOADIC_REFERIDO@SUSCCODI';
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
AND     external_root_id = 100268
)
);
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  RQCFG_100268_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100268, 4);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100268_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4)));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100268_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100268_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100268_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100268_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268) AND CONFIG_ID <> gi_boconfig.fnuGetConfig(2012, 587, 4);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268))));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268)));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268)))) AND CONFIG_ID = gi_boconfig.fnuGetConfig(2012, 100268, 4);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_CONFIG_COMP',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100268_.tbGI_CONFIG_COMPRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268))));
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268))));
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268))));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268)));

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_CONFIG_COMP',1);
nuVarcharIndex:=RQCFG_100268_.tbGI_CONFIG_COMPRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_CONFIG_COMP where rowid = RQCFG_100268_.tbGI_CONFIG_COMPRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := RQCFG_100268_.tbGI_CONFIG_COMPRowId.next(nuVarcharIndex); 
RQCFG_100268_.tbGI_CONFIG_COMPRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := RQCFG_100268_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
RQCFG_100268_.blProcessStatus := false;
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
FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268));
nuIndex binary_integer;
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 4 AND ENTITY_ROOT_ID = 2012 AND EXTERNAL_ROOT_ID = 100268;

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb0_0(0):=7944;
RQCFG_100268_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
RQCFG_100268_.tb0_0(0):=RQCFG_100268_.tb0_0(0);
RQCFG_100268_.old_tb0_2(0):=2012;
RQCFG_100268_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb0_2(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (RQCFG_100268_.tb0_0(0),
100268,
RQCFG_100268_.tb0_2(0),
4,
'F'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb1_0(0):=1046671;
RQCFG_100268_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100268_.tb1_0(0):=RQCFG_100268_.tb1_0(0);
RQCFG_100268_.old_tb1_1(0):=100268;
RQCFG_100268_.tb1_1(0):=RQCFG_100268_.old_tb1_1(0);
RQCFG_100268_.old_tb1_2(0):=2012;
RQCFG_100268_.tb1_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb1_2(0),-1)));
RQCFG_100268_.old_tb1_3(0):=7944;
RQCFG_100268_.tb1_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb1_2(0),-1))), RQCFG_100268_.old_tb1_1(0), 4);
RQCFG_100268_.tb1_3(0):=RQCFG_100268_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100268_.tb1_0(0),
RQCFG_100268_.tb1_1(0),
RQCFG_100268_.tb1_2(0),
RQCFG_100268_.tb1_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb2_0(0):=100023427;
RQCFG_100268_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100268_.tb2_0(0):=RQCFG_100268_.tb2_0(0);
RQCFG_100268_.tb2_1(0):=RQCFG_100268_.tb0_0(0);
RQCFG_100268_.tb2_2(0):=RQCFG_100268_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100268_.tb2_0(0),
RQCFG_100268_.tb2_1(0),
RQCFG_100268_.tb2_2(0),
null,
7014,
1,
1,
1);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb1_0(1):=1046672;
RQCFG_100268_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
RQCFG_100268_.tb1_0(1):=RQCFG_100268_.tb1_0(1);
RQCFG_100268_.old_tb1_1(1):=100276;
RQCFG_100268_.tb1_1(1):=RQCFG_100268_.old_tb1_1(1);
RQCFG_100268_.old_tb1_2(1):=2013;
RQCFG_100268_.tb1_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb1_2(1),-1)));
RQCFG_100268_.old_tb1_3(1):=null;
RQCFG_100268_.tb1_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb1_2(1),-1))), RQCFG_100268_.old_tb1_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (RQCFG_100268_.tb1_0(1),
RQCFG_100268_.tb1_1(1),
RQCFG_100268_.tb1_2(1),
RQCFG_100268_.tb1_3(1),
null,
'M_INSTALACION_DE_GAS_100276'
,
1,
1,
4);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb2_0(1):=100023428;
RQCFG_100268_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
RQCFG_100268_.tb2_0(1):=RQCFG_100268_.tb2_0(1);
RQCFG_100268_.tb2_1(1):=RQCFG_100268_.tb0_0(0);
RQCFG_100268_.tb2_2(1):=RQCFG_100268_.tb1_0(1);
RQCFG_100268_.tb2_3(1):=RQCFG_100268_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (RQCFG_100268_.tb2_0(1),
RQCFG_100268_.tb2_1(1),
RQCFG_100268_.tb2_2(1),
RQCFG_100268_.tb2_3(1),
7014,
2,
1,
1);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(0):=1098339;
RQCFG_100268_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(0):=RQCFG_100268_.tb3_0(0);
RQCFG_100268_.old_tb3_1(0):=3334;
RQCFG_100268_.tb3_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(0),-1)));
RQCFG_100268_.old_tb3_2(0):=147336;
RQCFG_100268_.tb3_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(0),-1)));
RQCFG_100268_.old_tb3_3(0):=440;
RQCFG_100268_.tb3_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(0),-1)));
RQCFG_100268_.old_tb3_4(0):=null;
RQCFG_100268_.tb3_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(0),-1)));
RQCFG_100268_.tb3_5(0):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(0):=null;
RQCFG_100268_.tb3_6(0):=NULL;
RQCFG_100268_.old_tb3_7(0):=null;
RQCFG_100268_.tb3_7(0):=NULL;
RQCFG_100268_.old_tb3_8(0):=null;
RQCFG_100268_.tb3_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(0),
RQCFG_100268_.tb3_1(0),
RQCFG_100268_.tb3_2(0),
RQCFG_100268_.tb3_3(0),
RQCFG_100268_.tb3_4(0),
RQCFG_100268_.tb3_5(0),
RQCFG_100268_.tb3_6(0),
RQCFG_100268_.tb3_7(0),
RQCFG_100268_.tb3_8(0),
null,
104245,
20,
'Categoría'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb4_0(0):=95253;
RQCFG_100268_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100268_.tb4_0(0):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb4_1(0):=RQCFG_100268_.tb2_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100268_.tb4_0(0),
RQCFG_100268_.tb4_1(0),
null,
null,
'FRAME-M_INSTALACION_DE_GAS_100276-1050294'
,
2);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(0):=1368622;
RQCFG_100268_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(0):=RQCFG_100268_.tb5_0(0);
RQCFG_100268_.old_tb5_1(0):=147336;
RQCFG_100268_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(0),-1)));
RQCFG_100268_.old_tb5_2(0):=null;
RQCFG_100268_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(0),-1)));
RQCFG_100268_.tb5_3(0):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(0):=RQCFG_100268_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(0),
RQCFG_100268_.tb5_1(0),
RQCFG_100268_.tb5_2(0),
RQCFG_100268_.tb5_3(0),
RQCFG_100268_.tb5_4(0),
'C'
,
'Y'
,
20,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(1):=1098340;
RQCFG_100268_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(1):=RQCFG_100268_.tb3_0(1);
RQCFG_100268_.old_tb3_1(1):=3334;
RQCFG_100268_.tb3_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(1),-1)));
RQCFG_100268_.old_tb3_2(1):=147337;
RQCFG_100268_.tb3_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(1),-1)));
RQCFG_100268_.old_tb3_3(1):=441;
RQCFG_100268_.tb3_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(1),-1)));
RQCFG_100268_.old_tb3_4(1):=null;
RQCFG_100268_.tb3_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(1),-1)));
RQCFG_100268_.tb3_5(1):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(1):=null;
RQCFG_100268_.tb3_6(1):=NULL;
RQCFG_100268_.old_tb3_7(1):=null;
RQCFG_100268_.tb3_7(1):=NULL;
RQCFG_100268_.old_tb3_8(1):=null;
RQCFG_100268_.tb3_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(1),
RQCFG_100268_.tb3_1(1),
RQCFG_100268_.tb3_2(1),
RQCFG_100268_.tb3_3(1),
RQCFG_100268_.tb3_4(1),
RQCFG_100268_.tb3_5(1),
RQCFG_100268_.tb3_6(1),
RQCFG_100268_.tb3_7(1),
RQCFG_100268_.tb3_8(1),
null,
104246,
21,
'Subcategoría'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(1):=1368623;
RQCFG_100268_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(1):=RQCFG_100268_.tb5_0(1);
RQCFG_100268_.old_tb5_1(1):=147337;
RQCFG_100268_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(1),-1)));
RQCFG_100268_.old_tb5_2(1):=null;
RQCFG_100268_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(1),-1)));
RQCFG_100268_.tb5_3(1):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(1):=RQCFG_100268_.tb3_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(1),
RQCFG_100268_.tb5_1(1),
RQCFG_100268_.tb5_2(1),
RQCFG_100268_.tb5_3(1),
RQCFG_100268_.tb5_4(1),
'C'
,
'Y'
,
21,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(2):=1098341;
RQCFG_100268_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(2):=RQCFG_100268_.tb3_0(2);
RQCFG_100268_.old_tb3_1(2):=3334;
RQCFG_100268_.tb3_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(2),-1)));
RQCFG_100268_.old_tb3_2(2):=198;
RQCFG_100268_.tb3_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(2),-1)));
RQCFG_100268_.old_tb3_3(2):=null;
RQCFG_100268_.tb3_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(2),-1)));
RQCFG_100268_.old_tb3_4(2):=null;
RQCFG_100268_.tb3_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(2),-1)));
RQCFG_100268_.tb3_5(2):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(2):=121146395;
RQCFG_100268_.tb3_6(2):=NULL;
RQCFG_100268_.old_tb3_7(2):=null;
RQCFG_100268_.tb3_7(2):=NULL;
RQCFG_100268_.old_tb3_8(2):=null;
RQCFG_100268_.tb3_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(2),
RQCFG_100268_.tb3_1(2),
RQCFG_100268_.tb3_2(2),
RQCFG_100268_.tb3_3(2),
RQCFG_100268_.tb3_4(2),
RQCFG_100268_.tb3_5(2),
RQCFG_100268_.tb3_6(2),
RQCFG_100268_.tb3_7(2),
RQCFG_100268_.tb3_8(2),
null,
104152,
9,
'PROVISIONAL_FLAG'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(2):=1368624;
RQCFG_100268_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(2):=RQCFG_100268_.tb5_0(2);
RQCFG_100268_.old_tb5_1(2):=198;
RQCFG_100268_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(2),-1)));
RQCFG_100268_.old_tb5_2(2):=null;
RQCFG_100268_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(2),-1)));
RQCFG_100268_.tb5_3(2):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(2):=RQCFG_100268_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(2),
RQCFG_100268_.tb5_1(2),
RQCFG_100268_.tb5_2(2),
RQCFG_100268_.tb5_3(2),
RQCFG_100268_.tb5_4(2),
'N'
,
'N'
,
9,
'N'
,
'PROVISIONAL_FLAG'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(3):=1098342;
RQCFG_100268_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(3):=RQCFG_100268_.tb3_0(3);
RQCFG_100268_.old_tb3_1(3):=3334;
RQCFG_100268_.tb3_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(3),-1)));
RQCFG_100268_.old_tb3_2(3):=20362;
RQCFG_100268_.tb3_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(3),-1)));
RQCFG_100268_.old_tb3_3(3):=null;
RQCFG_100268_.tb3_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(3),-1)));
RQCFG_100268_.old_tb3_4(3):=null;
RQCFG_100268_.tb3_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(3),-1)));
RQCFG_100268_.tb3_5(3):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(3):=121146387;
RQCFG_100268_.tb3_6(3):=NULL;
RQCFG_100268_.old_tb3_7(3):=null;
RQCFG_100268_.tb3_7(3):=NULL;
RQCFG_100268_.old_tb3_8(3):=null;
RQCFG_100268_.tb3_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(3),
RQCFG_100268_.tb3_1(3),
RQCFG_100268_.tb3_2(3),
RQCFG_100268_.tb3_3(3),
RQCFG_100268_.tb3_4(3),
RQCFG_100268_.tb3_5(3),
RQCFG_100268_.tb3_6(3),
RQCFG_100268_.tb3_7(3),
RQCFG_100268_.tb3_8(3),
null,
104161,
18,
'VALUE_TO_DEBIT'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(3):=1368625;
RQCFG_100268_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(3):=RQCFG_100268_.tb5_0(3);
RQCFG_100268_.old_tb5_1(3):=20362;
RQCFG_100268_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(3),-1)));
RQCFG_100268_.old_tb5_2(3):=null;
RQCFG_100268_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(3),-1)));
RQCFG_100268_.tb5_3(3):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(3):=RQCFG_100268_.tb3_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(3),
RQCFG_100268_.tb5_1(3),
RQCFG_100268_.tb5_2(3),
RQCFG_100268_.tb5_3(3),
RQCFG_100268_.tb5_4(3),
'N'
,
'N'
,
18,
'N'
,
'VALUE_TO_DEBIT'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(4):=1098343;
RQCFG_100268_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(4):=RQCFG_100268_.tb3_0(4);
RQCFG_100268_.old_tb3_1(4):=3334;
RQCFG_100268_.tb3_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(4),-1)));
RQCFG_100268_.old_tb3_2(4):=45189;
RQCFG_100268_.tb3_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(4),-1)));
RQCFG_100268_.old_tb3_3(4):=null;
RQCFG_100268_.tb3_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(4),-1)));
RQCFG_100268_.old_tb3_4(4):=null;
RQCFG_100268_.tb3_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(4),-1)));
RQCFG_100268_.tb3_5(4):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(4):=121146388;
RQCFG_100268_.tb3_6(4):=NULL;
RQCFG_100268_.old_tb3_7(4):=null;
RQCFG_100268_.tb3_7(4):=NULL;
RQCFG_100268_.old_tb3_8(4):=null;
RQCFG_100268_.tb3_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(4),
RQCFG_100268_.tb3_1(4),
RQCFG_100268_.tb3_2(4),
RQCFG_100268_.tb3_3(4),
RQCFG_100268_.tb3_4(4),
RQCFG_100268_.tb3_5(4),
RQCFG_100268_.tb3_6(4),
RQCFG_100268_.tb3_7(4),
RQCFG_100268_.tb3_8(4),
null,
104162,
19,
'COMMERCIAL_PLAN_ID'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(4):=1368626;
RQCFG_100268_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(4):=RQCFG_100268_.tb5_0(4);
RQCFG_100268_.old_tb5_1(4):=45189;
RQCFG_100268_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(4),-1)));
RQCFG_100268_.old_tb5_2(4):=null;
RQCFG_100268_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(4),-1)));
RQCFG_100268_.tb5_3(4):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(4):=RQCFG_100268_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(4),
RQCFG_100268_.tb5_1(4),
RQCFG_100268_.tb5_2(4),
RQCFG_100268_.tb5_3(4),
RQCFG_100268_.tb5_4(4),
'N'
,
'N'
,
19,
'N'
,
'COMMERCIAL_PLAN_ID'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(5):=1098344;
RQCFG_100268_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(5):=RQCFG_100268_.tb3_0(5);
RQCFG_100268_.old_tb3_1(5):=3334;
RQCFG_100268_.tb3_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(5),-1)));
RQCFG_100268_.old_tb3_2(5):=187;
RQCFG_100268_.tb3_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(5),-1)));
RQCFG_100268_.old_tb3_3(5):=null;
RQCFG_100268_.tb3_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(5),-1)));
RQCFG_100268_.old_tb3_4(5):=null;
RQCFG_100268_.tb3_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(5),-1)));
RQCFG_100268_.tb3_5(5):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(5):=121146389;
RQCFG_100268_.tb3_6(5):=NULL;
RQCFG_100268_.old_tb3_7(5):=null;
RQCFG_100268_.tb3_7(5):=NULL;
RQCFG_100268_.old_tb3_8(5):=null;
RQCFG_100268_.tb3_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(5),
RQCFG_100268_.tb3_1(5),
RQCFG_100268_.tb3_2(5),
RQCFG_100268_.tb3_3(5),
RQCFG_100268_.tb3_4(5),
RQCFG_100268_.tb3_5(5),
RQCFG_100268_.tb3_6(5),
RQCFG_100268_.tb3_7(5),
RQCFG_100268_.tb3_8(5),
null,
104143,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(5):=1368627;
RQCFG_100268_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(5):=RQCFG_100268_.tb5_0(5);
RQCFG_100268_.old_tb5_1(5):=187;
RQCFG_100268_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(5),-1)));
RQCFG_100268_.old_tb5_2(5):=null;
RQCFG_100268_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(5),-1)));
RQCFG_100268_.tb5_3(5):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(5):=RQCFG_100268_.tb3_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(5),
RQCFG_100268_.tb5_1(5),
RQCFG_100268_.tb5_2(5),
RQCFG_100268_.tb5_3(5),
RQCFG_100268_.tb5_4(5),
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(6):=1098345;
RQCFG_100268_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(6):=RQCFG_100268_.tb3_0(6);
RQCFG_100268_.old_tb3_1(6):=3334;
RQCFG_100268_.tb3_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(6),-1)));
RQCFG_100268_.old_tb3_2(6):=213;
RQCFG_100268_.tb3_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(6),-1)));
RQCFG_100268_.old_tb3_3(6):=255;
RQCFG_100268_.tb3_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(6),-1)));
RQCFG_100268_.old_tb3_4(6):=null;
RQCFG_100268_.tb3_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(6),-1)));
RQCFG_100268_.tb3_5(6):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(6):=null;
RQCFG_100268_.tb3_6(6):=NULL;
RQCFG_100268_.old_tb3_7(6):=null;
RQCFG_100268_.tb3_7(6):=NULL;
RQCFG_100268_.old_tb3_8(6):=null;
RQCFG_100268_.tb3_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(6),
RQCFG_100268_.tb3_1(6),
RQCFG_100268_.tb3_2(6),
RQCFG_100268_.tb3_3(6),
RQCFG_100268_.tb3_4(6),
RQCFG_100268_.tb3_5(6),
RQCFG_100268_.tb3_6(6),
RQCFG_100268_.tb3_7(6),
RQCFG_100268_.tb3_8(6),
null,
104144,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(6):=1368628;
RQCFG_100268_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(6):=RQCFG_100268_.tb5_0(6);
RQCFG_100268_.old_tb5_1(6):=213;
RQCFG_100268_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(6),-1)));
RQCFG_100268_.old_tb5_2(6):=null;
RQCFG_100268_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(6),-1)));
RQCFG_100268_.tb5_3(6):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(6):=RQCFG_100268_.tb3_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(6),
RQCFG_100268_.tb5_1(6),
RQCFG_100268_.tb5_2(6),
RQCFG_100268_.tb5_3(6),
RQCFG_100268_.tb5_4(6),
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(7):=1098346;
RQCFG_100268_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(7):=RQCFG_100268_.tb3_0(7);
RQCFG_100268_.old_tb3_1(7):=3334;
RQCFG_100268_.tb3_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(7),-1)));
RQCFG_100268_.old_tb3_2(7):=203;
RQCFG_100268_.tb3_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(7),-1)));
RQCFG_100268_.old_tb3_3(7):=null;
RQCFG_100268_.tb3_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(7),-1)));
RQCFG_100268_.old_tb3_4(7):=null;
RQCFG_100268_.tb3_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(7),-1)));
RQCFG_100268_.tb3_5(7):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(7):=121146390;
RQCFG_100268_.tb3_6(7):=NULL;
RQCFG_100268_.old_tb3_7(7):=null;
RQCFG_100268_.tb3_7(7):=NULL;
RQCFG_100268_.old_tb3_8(7):=null;
RQCFG_100268_.tb3_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(7),
RQCFG_100268_.tb3_1(7),
RQCFG_100268_.tb3_2(7),
RQCFG_100268_.tb3_3(7),
RQCFG_100268_.tb3_4(7),
RQCFG_100268_.tb3_5(7),
RQCFG_100268_.tb3_6(7),
RQCFG_100268_.tb3_7(7),
RQCFG_100268_.tb3_8(7),
null,
104145,
2,
'Prioridad'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(7):=1368629;
RQCFG_100268_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(7):=RQCFG_100268_.tb5_0(7);
RQCFG_100268_.old_tb5_1(7):=203;
RQCFG_100268_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(7),-1)));
RQCFG_100268_.old_tb5_2(7):=null;
RQCFG_100268_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(7),-1)));
RQCFG_100268_.tb5_3(7):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(7):=RQCFG_100268_.tb3_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(7),
RQCFG_100268_.tb5_1(7),
RQCFG_100268_.tb5_2(7),
RQCFG_100268_.tb5_3(7),
RQCFG_100268_.tb5_4(7),
'C'
,
'Y'
,
2,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(8):=1098347;
RQCFG_100268_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(8):=RQCFG_100268_.tb3_0(8);
RQCFG_100268_.old_tb3_1(8):=3334;
RQCFG_100268_.tb3_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(8),-1)));
RQCFG_100268_.old_tb3_2(8):=322;
RQCFG_100268_.tb3_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(8),-1)));
RQCFG_100268_.old_tb3_3(8):=null;
RQCFG_100268_.tb3_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(8),-1)));
RQCFG_100268_.old_tb3_4(8):=null;
RQCFG_100268_.tb3_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(8),-1)));
RQCFG_100268_.tb3_5(8):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(8):=121146392;
RQCFG_100268_.tb3_6(8):=NULL;
RQCFG_100268_.old_tb3_7(8):=null;
RQCFG_100268_.tb3_7(8):=NULL;
RQCFG_100268_.old_tb3_8(8):=null;
RQCFG_100268_.tb3_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(8),
RQCFG_100268_.tb3_1(8),
RQCFG_100268_.tb3_2(8),
RQCFG_100268_.tb3_3(8),
RQCFG_100268_.tb3_4(8),
RQCFG_100268_.tb3_5(8),
RQCFG_100268_.tb3_6(8),
RQCFG_100268_.tb3_7(8),
RQCFG_100268_.tb3_8(8),
null,
104146,
3,
'Entregas Parciales'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(8):=1368630;
RQCFG_100268_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(8):=RQCFG_100268_.tb5_0(8);
RQCFG_100268_.old_tb5_1(8):=322;
RQCFG_100268_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(8),-1)));
RQCFG_100268_.old_tb5_2(8):=null;
RQCFG_100268_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(8),-1)));
RQCFG_100268_.tb5_3(8):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(8):=RQCFG_100268_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(8),
RQCFG_100268_.tb5_1(8),
RQCFG_100268_.tb5_2(8),
RQCFG_100268_.tb5_3(8),
RQCFG_100268_.tb5_4(8),
'C'
,
'Y'
,
3,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(9):=1098348;
RQCFG_100268_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(9):=RQCFG_100268_.tb3_0(9);
RQCFG_100268_.old_tb3_1(9):=3334;
RQCFG_100268_.tb3_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(9),-1)));
RQCFG_100268_.old_tb3_2(9):=2641;
RQCFG_100268_.tb3_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(9),-1)));
RQCFG_100268_.old_tb3_3(9):=null;
RQCFG_100268_.tb3_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(9),-1)));
RQCFG_100268_.old_tb3_4(9):=null;
RQCFG_100268_.tb3_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(9),-1)));
RQCFG_100268_.tb3_5(9):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(9):=null;
RQCFG_100268_.tb3_6(9):=NULL;
RQCFG_100268_.old_tb3_7(9):=null;
RQCFG_100268_.tb3_7(9):=NULL;
RQCFG_100268_.old_tb3_8(9):=null;
RQCFG_100268_.tb3_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(9),
RQCFG_100268_.tb3_1(9),
RQCFG_100268_.tb3_2(9),
RQCFG_100268_.tb3_3(9),
RQCFG_100268_.tb3_4(9),
RQCFG_100268_.tb3_5(9),
RQCFG_100268_.tb3_6(9),
RQCFG_100268_.tb3_7(9),
RQCFG_100268_.tb3_8(9),
null,
104147,
4,
'Límite de Crédito'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(9):=1368631;
RQCFG_100268_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(9):=RQCFG_100268_.tb5_0(9);
RQCFG_100268_.old_tb5_1(9):=2641;
RQCFG_100268_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(9),-1)));
RQCFG_100268_.old_tb5_2(9):=null;
RQCFG_100268_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(9),-1)));
RQCFG_100268_.tb5_3(9):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(9):=RQCFG_100268_.tb3_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(9),
RQCFG_100268_.tb5_1(9),
RQCFG_100268_.tb5_2(9),
RQCFG_100268_.tb5_3(9),
RQCFG_100268_.tb5_4(9),
'N'
,
'Y'
,
4,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(10):=1098349;
RQCFG_100268_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(10):=RQCFG_100268_.tb3_0(10);
RQCFG_100268_.old_tb3_1(10):=3334;
RQCFG_100268_.tb3_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(10),-1)));
RQCFG_100268_.old_tb3_2(10):=197;
RQCFG_100268_.tb3_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(10),-1)));
RQCFG_100268_.old_tb3_3(10):=null;
RQCFG_100268_.tb3_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(10),-1)));
RQCFG_100268_.old_tb3_4(10):=null;
RQCFG_100268_.tb3_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(10),-1)));
RQCFG_100268_.tb3_5(10):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(10):=null;
RQCFG_100268_.tb3_6(10):=NULL;
RQCFG_100268_.old_tb3_7(10):=null;
RQCFG_100268_.tb3_7(10):=NULL;
RQCFG_100268_.old_tb3_8(10):=null;
RQCFG_100268_.tb3_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(10),
RQCFG_100268_.tb3_1(10),
RQCFG_100268_.tb3_2(10),
RQCFG_100268_.tb3_3(10),
RQCFG_100268_.tb3_4(10),
RQCFG_100268_.tb3_5(10),
RQCFG_100268_.tb3_6(10),
RQCFG_100268_.tb3_7(10),
RQCFG_100268_.tb3_8(10),
null,
104148,
5,
'PRIVACY_FLAG'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(10):=1368632;
RQCFG_100268_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(10):=RQCFG_100268_.tb5_0(10);
RQCFG_100268_.old_tb5_1(10):=197;
RQCFG_100268_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(10),-1)));
RQCFG_100268_.old_tb5_2(10):=null;
RQCFG_100268_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(10),-1)));
RQCFG_100268_.tb5_3(10):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(10):=RQCFG_100268_.tb3_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(10),
RQCFG_100268_.tb5_1(10),
RQCFG_100268_.tb5_2(10),
RQCFG_100268_.tb5_3(10),
RQCFG_100268_.tb5_4(10),
'N'
,
'N'
,
5,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(11):=1098350;
RQCFG_100268_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(11):=RQCFG_100268_.tb3_0(11);
RQCFG_100268_.old_tb3_1(11):=3334;
RQCFG_100268_.tb3_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(11),-1)));
RQCFG_100268_.old_tb3_2(11):=189;
RQCFG_100268_.tb3_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(11),-1)));
RQCFG_100268_.old_tb3_3(11):=255;
RQCFG_100268_.tb3_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(11),-1)));
RQCFG_100268_.old_tb3_4(11):=null;
RQCFG_100268_.tb3_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(11),-1)));
RQCFG_100268_.tb3_5(11):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(11):=null;
RQCFG_100268_.tb3_6(11):=NULL;
RQCFG_100268_.old_tb3_7(11):=null;
RQCFG_100268_.tb3_7(11):=NULL;
RQCFG_100268_.old_tb3_8(11):=null;
RQCFG_100268_.tb3_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(11),
RQCFG_100268_.tb3_1(11),
RQCFG_100268_.tb3_2(11),
RQCFG_100268_.tb3_3(11),
RQCFG_100268_.tb3_4(11),
RQCFG_100268_.tb3_5(11),
RQCFG_100268_.tb3_6(11),
RQCFG_100268_.tb3_7(11),
RQCFG_100268_.tb3_8(11),
null,
104149,
6,
'Número Petición Atención al cliente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(11):=1368633;
RQCFG_100268_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(11):=RQCFG_100268_.tb5_0(11);
RQCFG_100268_.old_tb5_1(11):=189;
RQCFG_100268_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(11),-1)));
RQCFG_100268_.old_tb5_2(11):=null;
RQCFG_100268_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(11),-1)));
RQCFG_100268_.tb5_3(11):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(11):=RQCFG_100268_.tb3_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(11),
RQCFG_100268_.tb5_1(11),
RQCFG_100268_.tb5_2(11),
RQCFG_100268_.tb5_3(11),
RQCFG_100268_.tb5_4(11),
'C'
,
'Y'
,
6,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(12):=1098351;
RQCFG_100268_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(12):=RQCFG_100268_.tb3_0(12);
RQCFG_100268_.old_tb3_1(12):=3334;
RQCFG_100268_.tb3_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(12),-1)));
RQCFG_100268_.old_tb3_2(12):=413;
RQCFG_100268_.tb3_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(12),-1)));
RQCFG_100268_.old_tb3_3(12):=null;
RQCFG_100268_.tb3_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(12),-1)));
RQCFG_100268_.old_tb3_4(12):=null;
RQCFG_100268_.tb3_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(12),-1)));
RQCFG_100268_.tb3_5(12):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(12):=null;
RQCFG_100268_.tb3_6(12):=NULL;
RQCFG_100268_.old_tb3_7(12):=null;
RQCFG_100268_.tb3_7(12):=NULL;
RQCFG_100268_.old_tb3_8(12):=null;
RQCFG_100268_.tb3_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(12),
RQCFG_100268_.tb3_1(12),
RQCFG_100268_.tb3_2(12),
RQCFG_100268_.tb3_3(12),
RQCFG_100268_.tb3_4(12),
RQCFG_100268_.tb3_5(12),
RQCFG_100268_.tb3_6(12),
RQCFG_100268_.tb3_7(12),
RQCFG_100268_.tb3_8(12),
null,
104150,
7,
'PRODUCT_ID'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(12):=1368634;
RQCFG_100268_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(12):=RQCFG_100268_.tb5_0(12);
RQCFG_100268_.old_tb5_1(12):=413;
RQCFG_100268_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(12),-1)));
RQCFG_100268_.old_tb5_2(12):=null;
RQCFG_100268_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(12),-1)));
RQCFG_100268_.tb5_3(12):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(12):=RQCFG_100268_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(12),
RQCFG_100268_.tb5_1(12),
RQCFG_100268_.tb5_2(12),
RQCFG_100268_.tb5_3(12),
RQCFG_100268_.tb5_4(12),
'N'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(13):=1098352;
RQCFG_100268_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(13):=RQCFG_100268_.tb3_0(13);
RQCFG_100268_.old_tb3_1(13):=3334;
RQCFG_100268_.tb3_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(13),-1)));
RQCFG_100268_.old_tb3_2(13):=50001324;
RQCFG_100268_.tb3_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(13),-1)));
RQCFG_100268_.old_tb3_3(13):=null;
RQCFG_100268_.tb3_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(13),-1)));
RQCFG_100268_.old_tb3_4(13):=null;
RQCFG_100268_.tb3_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(13),-1)));
RQCFG_100268_.tb3_5(13):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(13):=null;
RQCFG_100268_.tb3_6(13):=NULL;
RQCFG_100268_.old_tb3_7(13):=null;
RQCFG_100268_.tb3_7(13):=NULL;
RQCFG_100268_.old_tb3_8(13):=null;
RQCFG_100268_.tb3_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(13),
RQCFG_100268_.tb3_1(13),
RQCFG_100268_.tb3_2(13),
RQCFG_100268_.tb3_3(13),
RQCFG_100268_.tb3_4(13),
RQCFG_100268_.tb3_5(13),
RQCFG_100268_.tb3_6(13),
RQCFG_100268_.tb3_7(13),
RQCFG_100268_.tb3_8(13),
null,
104151,
8,
'Ubicación Geográfica'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(13):=1368635;
RQCFG_100268_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(13):=RQCFG_100268_.tb5_0(13);
RQCFG_100268_.old_tb5_1(13):=50001324;
RQCFG_100268_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(13),-1)));
RQCFG_100268_.old_tb5_2(13):=null;
RQCFG_100268_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(13),-1)));
RQCFG_100268_.tb5_3(13):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(13):=RQCFG_100268_.tb3_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(13),
RQCFG_100268_.tb5_1(13),
RQCFG_100268_.tb5_2(13),
RQCFG_100268_.tb5_3(13),
RQCFG_100268_.tb5_4(13),
'C'
,
'Y'
,
8,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(14):=1098353;
RQCFG_100268_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(14):=RQCFG_100268_.tb3_0(14);
RQCFG_100268_.old_tb3_1(14):=3334;
RQCFG_100268_.tb3_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(14),-1)));
RQCFG_100268_.old_tb3_2(14):=498;
RQCFG_100268_.tb3_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(14),-1)));
RQCFG_100268_.old_tb3_3(14):=null;
RQCFG_100268_.tb3_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(14),-1)));
RQCFG_100268_.old_tb3_4(14):=null;
RQCFG_100268_.tb3_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(14),-1)));
RQCFG_100268_.tb3_5(14):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(14):=null;
RQCFG_100268_.tb3_6(14):=NULL;
RQCFG_100268_.old_tb3_7(14):=null;
RQCFG_100268_.tb3_7(14):=NULL;
RQCFG_100268_.old_tb3_8(14):=null;
RQCFG_100268_.tb3_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(14),
RQCFG_100268_.tb3_1(14),
RQCFG_100268_.tb3_2(14),
RQCFG_100268_.tb3_3(14),
RQCFG_100268_.tb3_4(14),
RQCFG_100268_.tb3_5(14),
RQCFG_100268_.tb3_6(14),
RQCFG_100268_.tb3_7(14),
RQCFG_100268_.tb3_8(14),
null,
104153,
10,
'Fecha de Atención'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(14):=1368636;
RQCFG_100268_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(14):=RQCFG_100268_.tb5_0(14);
RQCFG_100268_.old_tb5_1(14):=498;
RQCFG_100268_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(14),-1)));
RQCFG_100268_.old_tb5_2(14):=null;
RQCFG_100268_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(14),-1)));
RQCFG_100268_.tb5_3(14):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(14):=RQCFG_100268_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(14),
RQCFG_100268_.tb5_1(14),
RQCFG_100268_.tb5_2(14),
RQCFG_100268_.tb5_3(14),
RQCFG_100268_.tb5_4(14),
'N'
,
'Y'
,
10,
'N'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(15):=1098354;
RQCFG_100268_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(15):=RQCFG_100268_.tb3_0(15);
RQCFG_100268_.old_tb3_1(15):=3334;
RQCFG_100268_.tb3_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(15),-1)));
RQCFG_100268_.old_tb3_2(15):=220;
RQCFG_100268_.tb3_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(15),-1)));
RQCFG_100268_.old_tb3_3(15):=null;
RQCFG_100268_.tb3_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(15),-1)));
RQCFG_100268_.old_tb3_4(15):=null;
RQCFG_100268_.tb3_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(15),-1)));
RQCFG_100268_.tb3_5(15):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(15):=null;
RQCFG_100268_.tb3_6(15):=NULL;
RQCFG_100268_.old_tb3_7(15):=null;
RQCFG_100268_.tb3_7(15):=NULL;
RQCFG_100268_.old_tb3_8(15):=null;
RQCFG_100268_.tb3_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(15),
RQCFG_100268_.tb3_1(15),
RQCFG_100268_.tb3_2(15),
RQCFG_100268_.tb3_3(15),
RQCFG_100268_.tb3_4(15),
RQCFG_100268_.tb3_5(15),
RQCFG_100268_.tb3_6(15),
RQCFG_100268_.tb3_7(15),
RQCFG_100268_.tb3_8(15),
null,
104154,
11,
'Identificador de Distribución Administrativa'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(15):=1368637;
RQCFG_100268_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(15):=RQCFG_100268_.tb5_0(15);
RQCFG_100268_.old_tb5_1(15):=220;
RQCFG_100268_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(15),-1)));
RQCFG_100268_.old_tb5_2(15):=null;
RQCFG_100268_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(15),-1)));
RQCFG_100268_.tb5_3(15):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(15):=RQCFG_100268_.tb3_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(15),
RQCFG_100268_.tb5_1(15),
RQCFG_100268_.tb5_2(15),
RQCFG_100268_.tb5_3(15),
RQCFG_100268_.tb5_4(15),
'N'
,
'Y'
,
11,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(16):=1098355;
RQCFG_100268_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(16):=RQCFG_100268_.tb3_0(16);
RQCFG_100268_.old_tb3_1(16):=3334;
RQCFG_100268_.tb3_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(16),-1)));
RQCFG_100268_.old_tb3_2(16):=524;
RQCFG_100268_.tb3_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(16),-1)));
RQCFG_100268_.old_tb3_3(16):=null;
RQCFG_100268_.tb3_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(16),-1)));
RQCFG_100268_.old_tb3_4(16):=null;
RQCFG_100268_.tb3_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(16),-1)));
RQCFG_100268_.tb3_5(16):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(16):=null;
RQCFG_100268_.tb3_6(16):=NULL;
RQCFG_100268_.old_tb3_7(16):=null;
RQCFG_100268_.tb3_7(16):=NULL;
RQCFG_100268_.old_tb3_8(16):=null;
RQCFG_100268_.tb3_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(16),
RQCFG_100268_.tb3_1(16),
RQCFG_100268_.tb3_2(16),
RQCFG_100268_.tb3_3(16),
RQCFG_100268_.tb3_4(16),
RQCFG_100268_.tb3_5(16),
RQCFG_100268_.tb3_6(16),
RQCFG_100268_.tb3_7(16),
RQCFG_100268_.tb3_8(16),
null,
104155,
12,
'Estado del Motivo'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(16):=1368638;
RQCFG_100268_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(16):=RQCFG_100268_.tb5_0(16);
RQCFG_100268_.old_tb5_1(16):=524;
RQCFG_100268_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(16),-1)));
RQCFG_100268_.old_tb5_2(16):=null;
RQCFG_100268_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(16),-1)));
RQCFG_100268_.tb5_3(16):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(16):=RQCFG_100268_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(16),
RQCFG_100268_.tb5_1(16),
RQCFG_100268_.tb5_2(16),
RQCFG_100268_.tb5_3(16),
RQCFG_100268_.tb5_4(16),
'C'
,
'Y'
,
12,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(17):=1098356;
RQCFG_100268_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(17):=RQCFG_100268_.tb3_0(17);
RQCFG_100268_.old_tb3_1(17):=3334;
RQCFG_100268_.tb3_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(17),-1)));
RQCFG_100268_.old_tb3_2(17):=191;
RQCFG_100268_.tb3_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(17),-1)));
RQCFG_100268_.old_tb3_3(17):=null;
RQCFG_100268_.tb3_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(17),-1)));
RQCFG_100268_.old_tb3_4(17):=null;
RQCFG_100268_.tb3_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(17),-1)));
RQCFG_100268_.tb3_5(17):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(17):=null;
RQCFG_100268_.tb3_6(17):=NULL;
RQCFG_100268_.old_tb3_7(17):=null;
RQCFG_100268_.tb3_7(17):=NULL;
RQCFG_100268_.old_tb3_8(17):=null;
RQCFG_100268_.tb3_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(17),
RQCFG_100268_.tb3_1(17),
RQCFG_100268_.tb3_2(17),
RQCFG_100268_.tb3_3(17),
RQCFG_100268_.tb3_4(17),
RQCFG_100268_.tb3_5(17),
RQCFG_100268_.tb3_6(17),
RQCFG_100268_.tb3_7(17),
RQCFG_100268_.tb3_8(17),
null,
104156,
13,
'Identificador del Tipo de Motivo'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(17):=1368639;
RQCFG_100268_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(17):=RQCFG_100268_.tb5_0(17);
RQCFG_100268_.old_tb5_1(17):=191;
RQCFG_100268_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(17),-1)));
RQCFG_100268_.old_tb5_2(17):=null;
RQCFG_100268_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(17),-1)));
RQCFG_100268_.tb5_3(17):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(17):=RQCFG_100268_.tb3_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(17),
RQCFG_100268_.tb5_1(17),
RQCFG_100268_.tb5_2(17),
RQCFG_100268_.tb5_3(17),
RQCFG_100268_.tb5_4(17),
'C'
,
'Y'
,
13,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(18):=1098357;
RQCFG_100268_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(18):=RQCFG_100268_.tb3_0(18);
RQCFG_100268_.old_tb3_1(18):=3334;
RQCFG_100268_.tb3_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(18),-1)));
RQCFG_100268_.old_tb3_2(18):=192;
RQCFG_100268_.tb3_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(18),-1)));
RQCFG_100268_.old_tb3_3(18):=null;
RQCFG_100268_.tb3_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(18),-1)));
RQCFG_100268_.old_tb3_4(18):=null;
RQCFG_100268_.tb3_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(18),-1)));
RQCFG_100268_.tb3_5(18):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(18):=null;
RQCFG_100268_.tb3_6(18):=NULL;
RQCFG_100268_.old_tb3_7(18):=null;
RQCFG_100268_.tb3_7(18):=NULL;
RQCFG_100268_.old_tb3_8(18):=null;
RQCFG_100268_.tb3_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(18),
RQCFG_100268_.tb3_1(18),
RQCFG_100268_.tb3_2(18),
RQCFG_100268_.tb3_3(18),
RQCFG_100268_.tb3_4(18),
RQCFG_100268_.tb3_5(18),
RQCFG_100268_.tb3_6(18),
RQCFG_100268_.tb3_7(18),
RQCFG_100268_.tb3_8(18),
null,
104157,
14,
'Identificador del Tipo de Producto'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(18):=1368640;
RQCFG_100268_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(18):=RQCFG_100268_.tb5_0(18);
RQCFG_100268_.old_tb5_1(18):=192;
RQCFG_100268_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(18),-1)));
RQCFG_100268_.old_tb5_2(18):=null;
RQCFG_100268_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(18),-1)));
RQCFG_100268_.tb5_3(18):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(18):=RQCFG_100268_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(18),
RQCFG_100268_.tb5_1(18),
RQCFG_100268_.tb5_2(18),
RQCFG_100268_.tb5_3(18),
RQCFG_100268_.tb5_4(18),
'C'
,
'Y'
,
14,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(19):=1098358;
RQCFG_100268_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(19):=RQCFG_100268_.tb3_0(19);
RQCFG_100268_.old_tb3_1(19):=3334;
RQCFG_100268_.tb3_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(19),-1)));
RQCFG_100268_.old_tb3_2(19):=4011;
RQCFG_100268_.tb3_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(19),-1)));
RQCFG_100268_.old_tb3_3(19):=null;
RQCFG_100268_.tb3_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(19),-1)));
RQCFG_100268_.old_tb3_4(19):=null;
RQCFG_100268_.tb3_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(19),-1)));
RQCFG_100268_.tb3_5(19):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(19):=null;
RQCFG_100268_.tb3_6(19):=NULL;
RQCFG_100268_.old_tb3_7(19):=null;
RQCFG_100268_.tb3_7(19):=NULL;
RQCFG_100268_.old_tb3_8(19):=null;
RQCFG_100268_.tb3_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(19),
RQCFG_100268_.tb3_1(19),
RQCFG_100268_.tb3_2(19),
RQCFG_100268_.tb3_3(19),
RQCFG_100268_.tb3_4(19),
RQCFG_100268_.tb3_5(19),
RQCFG_100268_.tb3_6(19),
RQCFG_100268_.tb3_7(19),
RQCFG_100268_.tb3_8(19),
null,
104158,
15,
'Número del Servicio'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(19):=1368641;
RQCFG_100268_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(19):=RQCFG_100268_.tb5_0(19);
RQCFG_100268_.old_tb5_1(19):=4011;
RQCFG_100268_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(19),-1)));
RQCFG_100268_.old_tb5_2(19):=null;
RQCFG_100268_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(19),-1)));
RQCFG_100268_.tb5_3(19):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(19):=RQCFG_100268_.tb3_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(19),
RQCFG_100268_.tb5_1(19),
RQCFG_100268_.tb5_2(19),
RQCFG_100268_.tb5_3(19),
RQCFG_100268_.tb5_4(19),
'C'
,
'Y'
,
15,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(20):=1098359;
RQCFG_100268_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(20):=RQCFG_100268_.tb3_0(20);
RQCFG_100268_.old_tb3_1(20):=3334;
RQCFG_100268_.tb3_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(20),-1)));
RQCFG_100268_.old_tb3_2(20):=11403;
RQCFG_100268_.tb3_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(20),-1)));
RQCFG_100268_.old_tb3_3(20):=null;
RQCFG_100268_.tb3_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(20),-1)));
RQCFG_100268_.old_tb3_4(20):=null;
RQCFG_100268_.tb3_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(20),-1)));
RQCFG_100268_.tb3_5(20):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(20):=121146386;
RQCFG_100268_.tb3_6(20):=NULL;
RQCFG_100268_.old_tb3_7(20):=null;
RQCFG_100268_.tb3_7(20):=NULL;
RQCFG_100268_.old_tb3_8(20):=null;
RQCFG_100268_.tb3_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(20),
RQCFG_100268_.tb3_1(20),
RQCFG_100268_.tb3_2(20),
RQCFG_100268_.tb3_3(20),
RQCFG_100268_.tb3_4(20),
RQCFG_100268_.tb3_5(20),
RQCFG_100268_.tb3_6(20),
RQCFG_100268_.tb3_7(20),
RQCFG_100268_.tb3_8(20),
null,
104159,
16,
'Identificador de la Suscripción'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(20):=1368642;
RQCFG_100268_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(20):=RQCFG_100268_.tb5_0(20);
RQCFG_100268_.old_tb5_1(20):=11403;
RQCFG_100268_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(20),-1)));
RQCFG_100268_.old_tb5_2(20):=null;
RQCFG_100268_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(20),-1)));
RQCFG_100268_.tb5_3(20):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(20):=RQCFG_100268_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(20),
RQCFG_100268_.tb5_1(20),
RQCFG_100268_.tb5_2(20),
RQCFG_100268_.tb5_3(20),
RQCFG_100268_.tb5_4(20),
'C'
,
'Y'
,
16,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(21):=1098360;
RQCFG_100268_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(21):=RQCFG_100268_.tb3_0(21);
RQCFG_100268_.old_tb3_1(21):=3334;
RQCFG_100268_.tb3_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(21),-1)));
RQCFG_100268_.old_tb3_2(21):=6683;
RQCFG_100268_.tb3_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(21),-1)));
RQCFG_100268_.old_tb3_3(21):=null;
RQCFG_100268_.tb3_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(21),-1)));
RQCFG_100268_.old_tb3_4(21):=null;
RQCFG_100268_.tb3_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(21),-1)));
RQCFG_100268_.tb3_5(21):=RQCFG_100268_.tb2_2(1);
RQCFG_100268_.old_tb3_6(21):=null;
RQCFG_100268_.tb3_6(21):=NULL;
RQCFG_100268_.old_tb3_7(21):=null;
RQCFG_100268_.tb3_7(21):=NULL;
RQCFG_100268_.old_tb3_8(21):=null;
RQCFG_100268_.tb3_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(21),
RQCFG_100268_.tb3_1(21),
RQCFG_100268_.tb3_2(21),
RQCFG_100268_.tb3_3(21),
RQCFG_100268_.tb3_4(21),
RQCFG_100268_.tb3_5(21),
RQCFG_100268_.tb3_6(21),
RQCFG_100268_.tb3_7(21),
RQCFG_100268_.tb3_8(21),
null,
104160,
17,
'CLIENT_PRIVACY_FLAG'
,
'N'
,
'N'
,
'N'
,
17,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(21):=1368643;
RQCFG_100268_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(21):=RQCFG_100268_.tb5_0(21);
RQCFG_100268_.old_tb5_1(21):=6683;
RQCFG_100268_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(21),-1)));
RQCFG_100268_.old_tb5_2(21):=null;
RQCFG_100268_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(21),-1)));
RQCFG_100268_.tb5_3(21):=RQCFG_100268_.tb4_0(0);
RQCFG_100268_.tb5_4(21):=RQCFG_100268_.tb3_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(21),
RQCFG_100268_.tb5_1(21),
RQCFG_100268_.tb5_2(21),
RQCFG_100268_.tb5_3(21),
RQCFG_100268_.tb5_4(21),
'N'
,
'N'
,
17,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(22):=1098361;
RQCFG_100268_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(22):=RQCFG_100268_.tb3_0(22);
RQCFG_100268_.old_tb3_1(22):=2036;
RQCFG_100268_.tb3_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(22),-1)));
RQCFG_100268_.old_tb3_2(22):=4015;
RQCFG_100268_.tb3_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(22),-1)));
RQCFG_100268_.old_tb3_3(22):=146755;
RQCFG_100268_.tb3_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(22),-1)));
RQCFG_100268_.old_tb3_4(22):=null;
RQCFG_100268_.tb3_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(22),-1)));
RQCFG_100268_.tb3_5(22):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(22):=null;
RQCFG_100268_.tb3_6(22):=NULL;
RQCFG_100268_.old_tb3_7(22):=null;
RQCFG_100268_.tb3_7(22):=NULL;
RQCFG_100268_.old_tb3_8(22):=null;
RQCFG_100268_.tb3_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(22),
RQCFG_100268_.tb3_1(22),
RQCFG_100268_.tb3_2(22),
RQCFG_100268_.tb3_3(22),
RQCFG_100268_.tb3_4(22),
RQCFG_100268_.tb3_5(22),
RQCFG_100268_.tb3_6(22),
RQCFG_100268_.tb3_7(22),
RQCFG_100268_.tb3_8(22),
null,
106709,
14,
'Cliente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb4_0(1):=95254;
RQCFG_100268_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
RQCFG_100268_.tb4_0(1):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb4_1(1):=RQCFG_100268_.tb2_2(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (RQCFG_100268_.tb4_0(1),
RQCFG_100268_.tb4_1(1),
null,
null,
'FRAME-PAQUETE-1050293'
,
1);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(22):=1368644;
RQCFG_100268_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(22):=RQCFG_100268_.tb5_0(22);
RQCFG_100268_.old_tb5_1(22):=4015;
RQCFG_100268_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(22),-1)));
RQCFG_100268_.old_tb5_2(22):=null;
RQCFG_100268_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(22),-1)));
RQCFG_100268_.tb5_3(22):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(22):=RQCFG_100268_.tb3_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(22),
RQCFG_100268_.tb5_1(22),
RQCFG_100268_.tb5_2(22),
RQCFG_100268_.tb5_3(22),
RQCFG_100268_.tb5_4(22),
'C'
,
'E'
,
14,
'N'
,
'Cliente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(23):=1098362;
RQCFG_100268_.tb3_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(23):=RQCFG_100268_.tb3_0(23);
RQCFG_100268_.old_tb3_1(23):=2036;
RQCFG_100268_.tb3_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(23),-1)));
RQCFG_100268_.old_tb3_2(23):=146756;
RQCFG_100268_.tb3_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(23),-1)));
RQCFG_100268_.old_tb3_3(23):=null;
RQCFG_100268_.tb3_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(23),-1)));
RQCFG_100268_.old_tb3_4(23):=null;
RQCFG_100268_.tb3_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(23),-1)));
RQCFG_100268_.tb3_5(23):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(23):=121146303;
RQCFG_100268_.tb3_6(23):=NULL;
RQCFG_100268_.old_tb3_7(23):=null;
RQCFG_100268_.tb3_7(23):=NULL;
RQCFG_100268_.old_tb3_8(23):=null;
RQCFG_100268_.tb3_8(23):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(23),
RQCFG_100268_.tb3_1(23),
RQCFG_100268_.tb3_2(23),
RQCFG_100268_.tb3_3(23),
RQCFG_100268_.tb3_4(23),
RQCFG_100268_.tb3_5(23),
RQCFG_100268_.tb3_6(23),
RQCFG_100268_.tb3_7(23),
RQCFG_100268_.tb3_8(23),
null,
106710,
15,
'Dirección de Respuesta'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(23):=1368645;
RQCFG_100268_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(23):=RQCFG_100268_.tb5_0(23);
RQCFG_100268_.old_tb5_1(23):=146756;
RQCFG_100268_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(23),-1)));
RQCFG_100268_.old_tb5_2(23):=null;
RQCFG_100268_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(23),-1)));
RQCFG_100268_.tb5_3(23):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(23):=RQCFG_100268_.tb3_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(23),
RQCFG_100268_.tb5_1(23),
RQCFG_100268_.tb5_2(23),
RQCFG_100268_.tb5_3(23),
RQCFG_100268_.tb5_4(23),
'C'
,
'E'
,
15,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(24):=1098363;
RQCFG_100268_.tb3_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(24):=RQCFG_100268_.tb3_0(24);
RQCFG_100268_.old_tb3_1(24):=2036;
RQCFG_100268_.tb3_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(24),-1)));
RQCFG_100268_.old_tb3_2(24):=146751;
RQCFG_100268_.tb3_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(24),-1)));
RQCFG_100268_.old_tb3_3(24):=null;
RQCFG_100268_.tb3_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(24),-1)));
RQCFG_100268_.old_tb3_4(24):=null;
RQCFG_100268_.tb3_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(24),-1)));
RQCFG_100268_.tb3_5(24):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(24):=null;
RQCFG_100268_.tb3_6(24):=NULL;
RQCFG_100268_.old_tb3_7(24):=null;
RQCFG_100268_.tb3_7(24):=NULL;
RQCFG_100268_.old_tb3_8(24):=120079385;
RQCFG_100268_.tb3_8(24):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(24),
RQCFG_100268_.tb3_1(24),
RQCFG_100268_.tb3_2(24),
RQCFG_100268_.tb3_3(24),
RQCFG_100268_.tb3_4(24),
RQCFG_100268_.tb3_5(24),
RQCFG_100268_.tb3_6(24),
RQCFG_100268_.tb3_7(24),
RQCFG_100268_.tb3_8(24),
null,
106711,
16,
'Medio por el que se enteró'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(24):=1368646;
RQCFG_100268_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(24):=RQCFG_100268_.tb5_0(24);
RQCFG_100268_.old_tb5_1(24):=146751;
RQCFG_100268_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(24),-1)));
RQCFG_100268_.old_tb5_2(24):=null;
RQCFG_100268_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(24),-1)));
RQCFG_100268_.tb5_3(24):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(24):=RQCFG_100268_.tb3_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(24),
RQCFG_100268_.tb5_1(24),
RQCFG_100268_.tb5_2(24),
RQCFG_100268_.tb5_3(24),
RQCFG_100268_.tb5_4(24),
'C'
,
'Y'
,
16,
'Y'
,
'Medio por el que se enteró'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(25):=1098364;
RQCFG_100268_.tb3_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(25):=RQCFG_100268_.tb3_0(25);
RQCFG_100268_.old_tb3_1(25):=2036;
RQCFG_100268_.tb3_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(25),-1)));
RQCFG_100268_.old_tb3_2(25):=146754;
RQCFG_100268_.tb3_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(25),-1)));
RQCFG_100268_.old_tb3_3(25):=null;
RQCFG_100268_.tb3_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(25),-1)));
RQCFG_100268_.old_tb3_4(25):=null;
RQCFG_100268_.tb3_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(25),-1)));
RQCFG_100268_.tb3_5(25):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(25):=null;
RQCFG_100268_.tb3_6(25):=NULL;
RQCFG_100268_.old_tb3_7(25):=null;
RQCFG_100268_.tb3_7(25):=NULL;
RQCFG_100268_.old_tb3_8(25):=null;
RQCFG_100268_.tb3_8(25):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(25),
RQCFG_100268_.tb3_1(25),
RQCFG_100268_.tb3_2(25),
RQCFG_100268_.tb3_3(25),
RQCFG_100268_.tb3_4(25),
RQCFG_100268_.tb3_5(25),
RQCFG_100268_.tb3_6(25),
RQCFG_100268_.tb3_7(25),
RQCFG_100268_.tb3_8(25),
null,
106712,
17,
'Observación'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(25):=1368647;
RQCFG_100268_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(25):=RQCFG_100268_.tb5_0(25);
RQCFG_100268_.old_tb5_1(25):=146754;
RQCFG_100268_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(25),-1)));
RQCFG_100268_.old_tb5_2(25):=null;
RQCFG_100268_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(25),-1)));
RQCFG_100268_.tb5_3(25):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(25):=RQCFG_100268_.tb3_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(25),
RQCFG_100268_.tb5_1(25),
RQCFG_100268_.tb5_2(25),
RQCFG_100268_.tb5_3(25),
RQCFG_100268_.tb5_4(25),
'C'
,
'Y'
,
17,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(26):=1098365;
RQCFG_100268_.tb3_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(26):=RQCFG_100268_.tb3_0(26);
RQCFG_100268_.old_tb3_1(26):=2036;
RQCFG_100268_.tb3_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(26),-1)));
RQCFG_100268_.old_tb3_2(26):=149340;
RQCFG_100268_.tb3_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(26),-1)));
RQCFG_100268_.old_tb3_3(26):=null;
RQCFG_100268_.tb3_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(26),-1)));
RQCFG_100268_.old_tb3_4(26):=null;
RQCFG_100268_.tb3_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(26),-1)));
RQCFG_100268_.tb3_5(26):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(26):=null;
RQCFG_100268_.tb3_6(26):=NULL;
RQCFG_100268_.old_tb3_7(26):=null;
RQCFG_100268_.tb3_7(26):=NULL;
RQCFG_100268_.old_tb3_8(26):=120079386;
RQCFG_100268_.tb3_8(26):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(26),
RQCFG_100268_.tb3_1(26),
RQCFG_100268_.tb3_2(26),
RQCFG_100268_.tb3_3(26),
RQCFG_100268_.tb3_4(26),
RQCFG_100268_.tb3_5(26),
RQCFG_100268_.tb3_6(26),
RQCFG_100268_.tb3_7(26),
RQCFG_100268_.tb3_8(26),
null,
106713,
18,
'Relación del Solicitante con el Predio'
,
'N'
,
'C'
,
'Y'
,
18,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(26):=1368648;
RQCFG_100268_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(26):=RQCFG_100268_.tb5_0(26);
RQCFG_100268_.old_tb5_1(26):=149340;
RQCFG_100268_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(26),-1)));
RQCFG_100268_.old_tb5_2(26):=null;
RQCFG_100268_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(26),-1)));
RQCFG_100268_.tb5_3(26):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(26):=RQCFG_100268_.tb3_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(26),
RQCFG_100268_.tb5_1(26),
RQCFG_100268_.tb5_2(26),
RQCFG_100268_.tb5_3(26),
RQCFG_100268_.tb5_4(26),
'C'
,
'Y'
,
18,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(27):=1098366;
RQCFG_100268_.tb3_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(27):=RQCFG_100268_.tb3_0(27);
RQCFG_100268_.old_tb3_1(27):=2036;
RQCFG_100268_.tb3_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(27),-1)));
RQCFG_100268_.old_tb3_2(27):=39387;
RQCFG_100268_.tb3_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(27),-1)));
RQCFG_100268_.old_tb3_3(27):=255;
RQCFG_100268_.tb3_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(27),-1)));
RQCFG_100268_.old_tb3_4(27):=null;
RQCFG_100268_.tb3_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(27),-1)));
RQCFG_100268_.tb3_5(27):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(27):=null;
RQCFG_100268_.tb3_6(27):=NULL;
RQCFG_100268_.old_tb3_7(27):=null;
RQCFG_100268_.tb3_7(27):=NULL;
RQCFG_100268_.old_tb3_8(27):=null;
RQCFG_100268_.tb3_8(27):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(27),
RQCFG_100268_.tb3_1(27),
RQCFG_100268_.tb3_2(27),
RQCFG_100268_.tb3_3(27),
RQCFG_100268_.tb3_4(27),
RQCFG_100268_.tb3_5(27),
RQCFG_100268_.tb3_6(27),
RQCFG_100268_.tb3_7(27),
RQCFG_100268_.tb3_8(27),
null,
106714,
19,
'Identificador De Solicitud'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(27):=1368649;
RQCFG_100268_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(27):=RQCFG_100268_.tb5_0(27);
RQCFG_100268_.old_tb5_1(27):=39387;
RQCFG_100268_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(27),-1)));
RQCFG_100268_.old_tb5_2(27):=null;
RQCFG_100268_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(27),-1)));
RQCFG_100268_.tb5_3(27):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(27):=RQCFG_100268_.tb3_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(27),
RQCFG_100268_.tb5_1(27),
RQCFG_100268_.tb5_2(27),
RQCFG_100268_.tb5_3(27),
RQCFG_100268_.tb5_4(27),
'C'
,
'Y'
,
19,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(28):=1098367;
RQCFG_100268_.tb3_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(28):=RQCFG_100268_.tb3_0(28);
RQCFG_100268_.old_tb3_1(28):=2036;
RQCFG_100268_.tb3_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(28),-1)));
RQCFG_100268_.old_tb3_2(28):=50000603;
RQCFG_100268_.tb3_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(28),-1)));
RQCFG_100268_.old_tb3_3(28):=null;
RQCFG_100268_.tb3_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(28),-1)));
RQCFG_100268_.old_tb3_4(28):=null;
RQCFG_100268_.tb3_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(28),-1)));
RQCFG_100268_.tb3_5(28):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(28):=121146304;
RQCFG_100268_.tb3_6(28):=NULL;
RQCFG_100268_.old_tb3_7(28):=null;
RQCFG_100268_.tb3_7(28):=NULL;
RQCFG_100268_.old_tb3_8(28):=null;
RQCFG_100268_.tb3_8(28):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(28),
RQCFG_100268_.tb3_1(28),
RQCFG_100268_.tb3_2(28),
RQCFG_100268_.tb3_3(28),
RQCFG_100268_.tb3_4(28),
RQCFG_100268_.tb3_5(28),
RQCFG_100268_.tb3_6(28),
RQCFG_100268_.tb3_7(28),
RQCFG_100268_.tb3_8(28),
null,
106715,
20,
'Identificador de suscriptor por motivo'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(28):=1368650;
RQCFG_100268_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(28):=RQCFG_100268_.tb5_0(28);
RQCFG_100268_.old_tb5_1(28):=50000603;
RQCFG_100268_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(28),-1)));
RQCFG_100268_.old_tb5_2(28):=null;
RQCFG_100268_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(28),-1)));
RQCFG_100268_.tb5_3(28):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(28):=RQCFG_100268_.tb3_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(28),
RQCFG_100268_.tb5_1(28),
RQCFG_100268_.tb5_2(28),
RQCFG_100268_.tb5_3(28),
RQCFG_100268_.tb5_4(28),
'C'
,
'Y'
,
20,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(29):=1098368;
RQCFG_100268_.tb3_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(29):=RQCFG_100268_.tb3_0(29);
RQCFG_100268_.old_tb3_1(29):=2036;
RQCFG_100268_.tb3_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(29),-1)));
RQCFG_100268_.old_tb3_2(29):=50000606;
RQCFG_100268_.tb3_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(29),-1)));
RQCFG_100268_.old_tb3_3(29):=146755;
RQCFG_100268_.tb3_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(29),-1)));
RQCFG_100268_.old_tb3_4(29):=null;
RQCFG_100268_.tb3_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(29),-1)));
RQCFG_100268_.tb3_5(29):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(29):=null;
RQCFG_100268_.tb3_6(29):=NULL;
RQCFG_100268_.old_tb3_7(29):=null;
RQCFG_100268_.tb3_7(29):=NULL;
RQCFG_100268_.old_tb3_8(29):=null;
RQCFG_100268_.tb3_8(29):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(29),
RQCFG_100268_.tb3_1(29),
RQCFG_100268_.tb3_2(29),
RQCFG_100268_.tb3_3(29),
RQCFG_100268_.tb3_4(29),
RQCFG_100268_.tb3_5(29),
RQCFG_100268_.tb3_6(29),
RQCFG_100268_.tb3_7(29),
RQCFG_100268_.tb3_8(29),
null,
106716,
21,
'Usuario del Servicio'
,
'N'
,
'C'
,
'Y'
,
21,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(29):=1368651;
RQCFG_100268_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(29):=RQCFG_100268_.tb5_0(29);
RQCFG_100268_.old_tb5_1(29):=50000606;
RQCFG_100268_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(29),-1)));
RQCFG_100268_.old_tb5_2(29):=null;
RQCFG_100268_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(29),-1)));
RQCFG_100268_.tb5_3(29):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(29):=RQCFG_100268_.tb3_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(29),
RQCFG_100268_.tb5_1(29),
RQCFG_100268_.tb5_2(29),
RQCFG_100268_.tb5_3(29),
RQCFG_100268_.tb5_4(29),
'C'
,
'Y'
,
21,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(30):=1098369;
RQCFG_100268_.tb3_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(30):=RQCFG_100268_.tb3_0(30);
RQCFG_100268_.old_tb3_1(30):=2036;
RQCFG_100268_.tb3_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(30),-1)));
RQCFG_100268_.old_tb3_2(30):=474;
RQCFG_100268_.tb3_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(30),-1)));
RQCFG_100268_.old_tb3_3(30):=null;
RQCFG_100268_.tb3_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(30),-1)));
RQCFG_100268_.old_tb3_4(30):=null;
RQCFG_100268_.tb3_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(30),-1)));
RQCFG_100268_.tb3_5(30):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(30):=121146305;
RQCFG_100268_.tb3_6(30):=NULL;
RQCFG_100268_.old_tb3_7(30):=null;
RQCFG_100268_.tb3_7(30):=NULL;
RQCFG_100268_.old_tb3_8(30):=null;
RQCFG_100268_.tb3_8(30):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(30),
RQCFG_100268_.tb3_1(30),
RQCFG_100268_.tb3_2(30),
RQCFG_100268_.tb3_3(30),
RQCFG_100268_.tb3_4(30),
RQCFG_100268_.tb3_5(30),
RQCFG_100268_.tb3_6(30),
RQCFG_100268_.tb3_7(30),
RQCFG_100268_.tb3_8(30),
null,
106717,
22,
'Código de la Dirección'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(30):=1368652;
RQCFG_100268_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(30):=RQCFG_100268_.tb5_0(30);
RQCFG_100268_.old_tb5_1(30):=474;
RQCFG_100268_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(30),-1)));
RQCFG_100268_.old_tb5_2(30):=null;
RQCFG_100268_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(30),-1)));
RQCFG_100268_.tb5_3(30):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(30):=RQCFG_100268_.tb3_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(30),
RQCFG_100268_.tb5_1(30),
RQCFG_100268_.tb5_2(30),
RQCFG_100268_.tb5_3(30),
RQCFG_100268_.tb5_4(30),
'C'
,
'Y'
,
22,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(31):=1098370;
RQCFG_100268_.tb3_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(31):=RQCFG_100268_.tb3_0(31);
RQCFG_100268_.old_tb3_1(31):=2036;
RQCFG_100268_.tb3_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(31),-1)));
RQCFG_100268_.old_tb3_2(31):=1035;
RQCFG_100268_.tb3_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(31),-1)));
RQCFG_100268_.old_tb3_3(31):=null;
RQCFG_100268_.tb3_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(31),-1)));
RQCFG_100268_.old_tb3_4(31):=null;
RQCFG_100268_.tb3_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(31),-1)));
RQCFG_100268_.tb3_5(31):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(31):=null;
RQCFG_100268_.tb3_6(31):=NULL;
RQCFG_100268_.old_tb3_7(31):=121146306;
RQCFG_100268_.tb3_7(31):=NULL;
RQCFG_100268_.old_tb3_8(31):=null;
RQCFG_100268_.tb3_8(31):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(31),
RQCFG_100268_.tb3_1(31),
RQCFG_100268_.tb3_2(31),
RQCFG_100268_.tb3_3(31),
RQCFG_100268_.tb3_4(31),
RQCFG_100268_.tb3_5(31),
RQCFG_100268_.tb3_6(31),
RQCFG_100268_.tb3_7(31),
RQCFG_100268_.tb3_8(31),
null,
106718,
23,
'Dirección de Visita'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(31):=1368653;
RQCFG_100268_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(31):=RQCFG_100268_.tb5_0(31);
RQCFG_100268_.old_tb5_1(31):=1035;
RQCFG_100268_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(31),-1)));
RQCFG_100268_.old_tb5_2(31):=null;
RQCFG_100268_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(31),-1)));
RQCFG_100268_.tb5_3(31):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(31):=RQCFG_100268_.tb3_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(31),
RQCFG_100268_.tb5_1(31),
RQCFG_100268_.tb5_2(31),
RQCFG_100268_.tb5_3(31),
RQCFG_100268_.tb5_4(31),
'C'
,
'Y'
,
23,
'Y'
,
'Dirección de Visita'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(32):=1098371;
RQCFG_100268_.tb3_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(32):=RQCFG_100268_.tb3_0(32);
RQCFG_100268_.old_tb3_1(32):=2036;
RQCFG_100268_.tb3_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(32),-1)));
RQCFG_100268_.old_tb3_2(32):=90021316;
RQCFG_100268_.tb3_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(32),-1)));
RQCFG_100268_.old_tb3_3(32):=null;
RQCFG_100268_.tb3_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(32),-1)));
RQCFG_100268_.old_tb3_4(32):=null;
RQCFG_100268_.tb3_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(32),-1)));
RQCFG_100268_.tb3_5(32):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(32):=null;
RQCFG_100268_.tb3_6(32):=NULL;
RQCFG_100268_.old_tb3_7(32):=null;
RQCFG_100268_.tb3_7(32):=NULL;
RQCFG_100268_.old_tb3_8(32):=120079387;
RQCFG_100268_.tb3_8(32):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(32),
RQCFG_100268_.tb3_1(32),
RQCFG_100268_.tb3_2(32),
RQCFG_100268_.tb3_3(32),
RQCFG_100268_.tb3_4(32),
RQCFG_100268_.tb3_5(32),
RQCFG_100268_.tb3_6(32),
RQCFG_100268_.tb3_7(32),
RQCFG_100268_.tb3_8(32),
null,
106719,
24,
'Tipo de Predio'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(32):=1368654;
RQCFG_100268_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(32):=RQCFG_100268_.tb5_0(32);
RQCFG_100268_.old_tb5_1(32):=90021316;
RQCFG_100268_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(32),-1)));
RQCFG_100268_.old_tb5_2(32):=null;
RQCFG_100268_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(32),-1)));
RQCFG_100268_.tb5_3(32):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(32):=RQCFG_100268_.tb3_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(32),
RQCFG_100268_.tb5_1(32),
RQCFG_100268_.tb5_2(32),
RQCFG_100268_.tb5_3(32),
RQCFG_100268_.tb5_4(32),
'C'
,
'Y'
,
24,
'Y'
,
'Tipo de Predio'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(33):=1098372;
RQCFG_100268_.tb3_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(33):=RQCFG_100268_.tb3_0(33);
RQCFG_100268_.old_tb3_1(33):=2036;
RQCFG_100268_.tb3_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(33),-1)));
RQCFG_100268_.old_tb3_2(33):=440;
RQCFG_100268_.tb3_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(33),-1)));
RQCFG_100268_.old_tb3_3(33):=null;
RQCFG_100268_.tb3_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(33),-1)));
RQCFG_100268_.old_tb3_4(33):=1035;
RQCFG_100268_.tb3_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(33),-1)));
RQCFG_100268_.tb3_5(33):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(33):=121146307;
RQCFG_100268_.tb3_6(33):=NULL;
RQCFG_100268_.old_tb3_7(33):=null;
RQCFG_100268_.tb3_7(33):=NULL;
RQCFG_100268_.old_tb3_8(33):=120079388;
RQCFG_100268_.tb3_8(33):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(33),
RQCFG_100268_.tb3_1(33),
RQCFG_100268_.tb3_2(33),
RQCFG_100268_.tb3_3(33),
RQCFG_100268_.tb3_4(33),
RQCFG_100268_.tb3_5(33),
RQCFG_100268_.tb3_6(33),
RQCFG_100268_.tb3_7(33),
RQCFG_100268_.tb3_8(33),
null,
106720,
25,
'Uso del Predio'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(33):=1368655;
RQCFG_100268_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(33):=RQCFG_100268_.tb5_0(33);
RQCFG_100268_.old_tb5_1(33):=440;
RQCFG_100268_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(33),-1)));
RQCFG_100268_.old_tb5_2(33):=1035;
RQCFG_100268_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(33),-1)));
RQCFG_100268_.tb5_3(33):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(33):=RQCFG_100268_.tb3_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(33),
RQCFG_100268_.tb5_1(33),
RQCFG_100268_.tb5_2(33),
RQCFG_100268_.tb5_3(33),
RQCFG_100268_.tb5_4(33),
'C'
,
'Y'
,
25,
'Y'
,
'Uso del Predio'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(34):=1098373;
RQCFG_100268_.tb3_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(34):=RQCFG_100268_.tb3_0(34);
RQCFG_100268_.old_tb3_1(34):=2036;
RQCFG_100268_.tb3_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(34),-1)));
RQCFG_100268_.old_tb3_2(34):=441;
RQCFG_100268_.tb3_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(34),-1)));
RQCFG_100268_.old_tb3_3(34):=null;
RQCFG_100268_.tb3_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(34),-1)));
RQCFG_100268_.old_tb3_4(34):=440;
RQCFG_100268_.tb3_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(34),-1)));
RQCFG_100268_.tb3_5(34):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(34):=null;
RQCFG_100268_.tb3_6(34):=NULL;
RQCFG_100268_.old_tb3_7(34):=null;
RQCFG_100268_.tb3_7(34):=NULL;
RQCFG_100268_.old_tb3_8(34):=120079389;
RQCFG_100268_.tb3_8(34):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(34),
RQCFG_100268_.tb3_1(34),
RQCFG_100268_.tb3_2(34),
RQCFG_100268_.tb3_3(34),
RQCFG_100268_.tb3_4(34),
RQCFG_100268_.tb3_5(34),
RQCFG_100268_.tb3_6(34),
RQCFG_100268_.tb3_7(34),
RQCFG_100268_.tb3_8(34),
null,
106721,
26,
'Estrato'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(34):=1368656;
RQCFG_100268_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(34):=RQCFG_100268_.tb5_0(34);
RQCFG_100268_.old_tb5_1(34):=441;
RQCFG_100268_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(34),-1)));
RQCFG_100268_.old_tb5_2(34):=440;
RQCFG_100268_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(34),-1)));
RQCFG_100268_.tb5_3(34):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(34):=RQCFG_100268_.tb3_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(34),
RQCFG_100268_.tb5_1(34),
RQCFG_100268_.tb5_2(34),
RQCFG_100268_.tb5_3(34),
RQCFG_100268_.tb5_4(34),
'C'
,
'Y'
,
26,
'Y'
,
'Estrato'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(35):=1098374;
RQCFG_100268_.tb3_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(35):=RQCFG_100268_.tb3_0(35);
RQCFG_100268_.old_tb3_1(35):=2036;
RQCFG_100268_.tb3_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(35),-1)));
RQCFG_100268_.old_tb3_2(35):=90021319;
RQCFG_100268_.tb3_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(35),-1)));
RQCFG_100268_.old_tb3_3(35):=255;
RQCFG_100268_.tb3_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(35),-1)));
RQCFG_100268_.old_tb3_4(35):=null;
RQCFG_100268_.tb3_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(35),-1)));
RQCFG_100268_.tb3_5(35):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(35):=null;
RQCFG_100268_.tb3_6(35):=NULL;
RQCFG_100268_.old_tb3_7(35):=null;
RQCFG_100268_.tb3_7(35):=NULL;
RQCFG_100268_.old_tb3_8(35):=null;
RQCFG_100268_.tb3_8(35):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(35),
RQCFG_100268_.tb3_1(35),
RQCFG_100268_.tb3_2(35),
RQCFG_100268_.tb3_3(35),
RQCFG_100268_.tb3_4(35),
RQCFG_100268_.tb3_5(35),
RQCFG_100268_.tb3_6(35),
RQCFG_100268_.tb3_7(35),
RQCFG_100268_.tb3_8(35),
null,
106722,
27,
'Id del Paquete'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(35):=1368657;
RQCFG_100268_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(35):=RQCFG_100268_.tb5_0(35);
RQCFG_100268_.old_tb5_1(35):=90021319;
RQCFG_100268_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(35),-1)));
RQCFG_100268_.old_tb5_2(35):=null;
RQCFG_100268_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(35),-1)));
RQCFG_100268_.tb5_3(35):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(35):=RQCFG_100268_.tb3_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(35),
RQCFG_100268_.tb5_1(35),
RQCFG_100268_.tb5_2(35),
RQCFG_100268_.tb5_3(35),
RQCFG_100268_.tb5_4(35),
'C'
,
'Y'
,
27,
'N'
,
'Id del Paquete'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(36):=1098375;
RQCFG_100268_.tb3_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(36):=RQCFG_100268_.tb3_0(36);
RQCFG_100268_.old_tb3_1(36):=2036;
RQCFG_100268_.tb3_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(36),-1)));
RQCFG_100268_.old_tb3_2(36):=6733;
RQCFG_100268_.tb3_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(36),-1)));
RQCFG_100268_.old_tb3_3(36):=null;
RQCFG_100268_.tb3_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(36),-1)));
RQCFG_100268_.old_tb3_4(36):=90021317;
RQCFG_100268_.tb3_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(36),-1)));
RQCFG_100268_.tb3_5(36):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(36):=null;
RQCFG_100268_.tb3_6(36):=NULL;
RQCFG_100268_.old_tb3_7(36):=null;
RQCFG_100268_.tb3_7(36):=NULL;
RQCFG_100268_.old_tb3_8(36):=null;
RQCFG_100268_.tb3_8(36):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(36),
RQCFG_100268_.tb3_1(36),
RQCFG_100268_.tb3_2(36),
RQCFG_100268_.tb3_3(36),
RQCFG_100268_.tb3_4(36),
RQCFG_100268_.tb3_5(36),
RQCFG_100268_.tb3_6(36),
RQCFG_100268_.tb3_7(36),
RQCFG_100268_.tb3_8(36),
null,
106728,
33,
'Apellido'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(36):=1368658;
RQCFG_100268_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(36):=RQCFG_100268_.tb5_0(36);
RQCFG_100268_.old_tb5_1(36):=6733;
RQCFG_100268_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(36),-1)));
RQCFG_100268_.old_tb5_2(36):=90021317;
RQCFG_100268_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(36),-1)));
RQCFG_100268_.tb5_3(36):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(36):=RQCFG_100268_.tb3_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(36),
RQCFG_100268_.tb5_1(36),
RQCFG_100268_.tb5_2(36),
RQCFG_100268_.tb5_3(36),
RQCFG_100268_.tb5_4(36),
'C'
,
'N'
,
33,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(37):=1098376;
RQCFG_100268_.tb3_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(37):=RQCFG_100268_.tb3_0(37);
RQCFG_100268_.old_tb3_1(37):=2036;
RQCFG_100268_.tb3_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(37),-1)));
RQCFG_100268_.old_tb3_2(37):=1037;
RQCFG_100268_.tb3_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(37),-1)));
RQCFG_100268_.old_tb3_3(37):=null;
RQCFG_100268_.tb3_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(37),-1)));
RQCFG_100268_.old_tb3_4(37):=90021317;
RQCFG_100268_.tb3_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(37),-1)));
RQCFG_100268_.tb3_5(37):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(37):=null;
RQCFG_100268_.tb3_6(37):=NULL;
RQCFG_100268_.old_tb3_7(37):=null;
RQCFG_100268_.tb3_7(37):=NULL;
RQCFG_100268_.old_tb3_8(37):=null;
RQCFG_100268_.tb3_8(37):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(37),
RQCFG_100268_.tb3_1(37),
RQCFG_100268_.tb3_2(37),
RQCFG_100268_.tb3_3(37),
RQCFG_100268_.tb3_4(37),
RQCFG_100268_.tb3_5(37),
RQCFG_100268_.tb3_6(37),
RQCFG_100268_.tb3_7(37),
RQCFG_100268_.tb3_8(37),
null,
106729,
34,
'Dirección'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(37):=1368659;
RQCFG_100268_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(37):=RQCFG_100268_.tb5_0(37);
RQCFG_100268_.old_tb5_1(37):=1037;
RQCFG_100268_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(37),-1)));
RQCFG_100268_.old_tb5_2(37):=90021317;
RQCFG_100268_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(37),-1)));
RQCFG_100268_.tb5_3(37):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(37):=RQCFG_100268_.tb3_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(37),
RQCFG_100268_.tb5_1(37),
RQCFG_100268_.tb5_2(37),
RQCFG_100268_.tb5_3(37),
RQCFG_100268_.tb5_4(37),
'C'
,
'N'
,
34,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(38):=1098377;
RQCFG_100268_.tb3_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(38):=RQCFG_100268_.tb3_0(38);
RQCFG_100268_.old_tb3_1(38):=2036;
RQCFG_100268_.tb3_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(38),-1)));
RQCFG_100268_.old_tb3_2(38):=20371;
RQCFG_100268_.tb3_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(38),-1)));
RQCFG_100268_.old_tb3_3(38):=null;
RQCFG_100268_.tb3_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(38),-1)));
RQCFG_100268_.old_tb3_4(38):=90021317;
RQCFG_100268_.tb3_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(38),-1)));
RQCFG_100268_.tb3_5(38):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(38):=null;
RQCFG_100268_.tb3_6(38):=NULL;
RQCFG_100268_.old_tb3_7(38):=null;
RQCFG_100268_.tb3_7(38):=NULL;
RQCFG_100268_.old_tb3_8(38):=null;
RQCFG_100268_.tb3_8(38):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(38),
RQCFG_100268_.tb3_1(38),
RQCFG_100268_.tb3_2(38),
RQCFG_100268_.tb3_3(38),
RQCFG_100268_.tb3_4(38),
RQCFG_100268_.tb3_5(38),
RQCFG_100268_.tb3_6(38),
RQCFG_100268_.tb3_7(38),
RQCFG_100268_.tb3_8(38),
null,
106730,
35,
'Teléfono'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(38):=1368660;
RQCFG_100268_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(38):=RQCFG_100268_.tb5_0(38);
RQCFG_100268_.old_tb5_1(38):=20371;
RQCFG_100268_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(38),-1)));
RQCFG_100268_.old_tb5_2(38):=90021317;
RQCFG_100268_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(38),-1)));
RQCFG_100268_.tb5_3(38):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(38):=RQCFG_100268_.tb3_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(38),
RQCFG_100268_.tb5_1(38),
RQCFG_100268_.tb5_2(38),
RQCFG_100268_.tb5_3(38),
RQCFG_100268_.tb5_4(38),
'C'
,
'N'
,
35,
'N'
,
'Teléfono'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(39):=1098378;
RQCFG_100268_.tb3_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(39):=RQCFG_100268_.tb3_0(39);
RQCFG_100268_.old_tb3_1(39):=2036;
RQCFG_100268_.tb3_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(39),-1)));
RQCFG_100268_.old_tb3_2(39):=269;
RQCFG_100268_.tb3_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(39),-1)));
RQCFG_100268_.old_tb3_3(39):=null;
RQCFG_100268_.tb3_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(39),-1)));
RQCFG_100268_.old_tb3_4(39):=null;
RQCFG_100268_.tb3_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(39),-1)));
RQCFG_100268_.tb3_5(39):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(39):=null;
RQCFG_100268_.tb3_6(39):=NULL;
RQCFG_100268_.old_tb3_7(39):=null;
RQCFG_100268_.tb3_7(39):=NULL;
RQCFG_100268_.old_tb3_8(39):=null;
RQCFG_100268_.tb3_8(39):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(39),
RQCFG_100268_.tb3_1(39),
RQCFG_100268_.tb3_2(39),
RQCFG_100268_.tb3_3(39),
RQCFG_100268_.tb3_4(39),
RQCFG_100268_.tb3_5(39),
RQCFG_100268_.tb3_6(39),
RQCFG_100268_.tb3_7(39),
RQCFG_100268_.tb3_8(39),
null,
106695,
0,
'Código del Tipo de Paquete'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(39):=1368661;
RQCFG_100268_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(39):=RQCFG_100268_.tb5_0(39);
RQCFG_100268_.old_tb5_1(39):=269;
RQCFG_100268_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(39),-1)));
RQCFG_100268_.old_tb5_2(39):=null;
RQCFG_100268_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(39),-1)));
RQCFG_100268_.tb5_3(39):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(39):=RQCFG_100268_.tb3_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(39),
RQCFG_100268_.tb5_1(39),
RQCFG_100268_.tb5_2(39),
RQCFG_100268_.tb5_3(39),
RQCFG_100268_.tb5_4(39),
'C'
,
'Y'
,
0,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(40):=1098379;
RQCFG_100268_.tb3_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(40):=RQCFG_100268_.tb3_0(40);
RQCFG_100268_.old_tb3_1(40):=2036;
RQCFG_100268_.tb3_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(40),-1)));
RQCFG_100268_.old_tb3_2(40):=257;
RQCFG_100268_.tb3_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(40),-1)));
RQCFG_100268_.old_tb3_3(40):=null;
RQCFG_100268_.tb3_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(40),-1)));
RQCFG_100268_.old_tb3_4(40):=null;
RQCFG_100268_.tb3_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(40),-1)));
RQCFG_100268_.tb3_5(40):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(40):=121146292;
RQCFG_100268_.tb3_6(40):=NULL;
RQCFG_100268_.old_tb3_7(40):=null;
RQCFG_100268_.tb3_7(40):=NULL;
RQCFG_100268_.old_tb3_8(40):=null;
RQCFG_100268_.tb3_8(40):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(40),
RQCFG_100268_.tb3_1(40),
RQCFG_100268_.tb3_2(40),
RQCFG_100268_.tb3_3(40),
RQCFG_100268_.tb3_4(40),
RQCFG_100268_.tb3_5(40),
RQCFG_100268_.tb3_6(40),
RQCFG_100268_.tb3_7(40),
RQCFG_100268_.tb3_8(40),
null,
106696,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(40):=1368662;
RQCFG_100268_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(40):=RQCFG_100268_.tb5_0(40);
RQCFG_100268_.old_tb5_1(40):=257;
RQCFG_100268_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(40),-1)));
RQCFG_100268_.old_tb5_2(40):=null;
RQCFG_100268_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(40),-1)));
RQCFG_100268_.tb5_3(40):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(40):=RQCFG_100268_.tb3_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(40),
RQCFG_100268_.tb5_1(40),
RQCFG_100268_.tb5_2(40),
RQCFG_100268_.tb5_3(40),
RQCFG_100268_.tb5_4(40),
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(41):=1098380;
RQCFG_100268_.tb3_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(41):=RQCFG_100268_.tb3_0(41);
RQCFG_100268_.old_tb3_1(41):=2036;
RQCFG_100268_.tb3_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(41),-1)));
RQCFG_100268_.old_tb3_2(41):=258;
RQCFG_100268_.tb3_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(41),-1)));
RQCFG_100268_.old_tb3_3(41):=null;
RQCFG_100268_.tb3_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(41),-1)));
RQCFG_100268_.old_tb3_4(41):=null;
RQCFG_100268_.tb3_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(41),-1)));
RQCFG_100268_.tb3_5(41):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(41):=121146293;
RQCFG_100268_.tb3_6(41):=NULL;
RQCFG_100268_.old_tb3_7(41):=121146294;
RQCFG_100268_.tb3_7(41):=NULL;
RQCFG_100268_.old_tb3_8(41):=null;
RQCFG_100268_.tb3_8(41):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(41),
RQCFG_100268_.tb3_1(41),
RQCFG_100268_.tb3_2(41),
RQCFG_100268_.tb3_3(41),
RQCFG_100268_.tb3_4(41),
RQCFG_100268_.tb3_5(41),
RQCFG_100268_.tb3_6(41),
RQCFG_100268_.tb3_7(41),
RQCFG_100268_.tb3_8(41),
null,
106697,
2,
'Fecha de Solicitud'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(41):=1368663;
RQCFG_100268_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(41):=RQCFG_100268_.tb5_0(41);
RQCFG_100268_.old_tb5_1(41):=258;
RQCFG_100268_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(41),-1)));
RQCFG_100268_.old_tb5_2(41):=null;
RQCFG_100268_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(41),-1)));
RQCFG_100268_.tb5_3(41):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(41):=RQCFG_100268_.tb3_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(41),
RQCFG_100268_.tb5_1(41),
RQCFG_100268_.tb5_2(41),
RQCFG_100268_.tb5_3(41),
RQCFG_100268_.tb5_4(41),
'C'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(42):=1098381;
RQCFG_100268_.tb3_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(42):=RQCFG_100268_.tb3_0(42);
RQCFG_100268_.old_tb3_1(42):=2036;
RQCFG_100268_.tb3_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(42),-1)));
RQCFG_100268_.old_tb3_2(42):=255;
RQCFG_100268_.tb3_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(42),-1)));
RQCFG_100268_.old_tb3_3(42):=null;
RQCFG_100268_.tb3_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(42),-1)));
RQCFG_100268_.old_tb3_4(42):=null;
RQCFG_100268_.tb3_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(42),-1)));
RQCFG_100268_.tb3_5(42):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(42):=null;
RQCFG_100268_.tb3_6(42):=NULL;
RQCFG_100268_.old_tb3_7(42):=121146295;
RQCFG_100268_.tb3_7(42):=NULL;
RQCFG_100268_.old_tb3_8(42):=null;
RQCFG_100268_.tb3_8(42):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(42),
RQCFG_100268_.tb3_1(42),
RQCFG_100268_.tb3_2(42),
RQCFG_100268_.tb3_3(42),
RQCFG_100268_.tb3_4(42),
RQCFG_100268_.tb3_5(42),
RQCFG_100268_.tb3_6(42),
RQCFG_100268_.tb3_7(42),
RQCFG_100268_.tb3_8(42),
null,
106698,
3,
'Número de Solicitud'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(42):=1368664;
RQCFG_100268_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(42):=RQCFG_100268_.tb5_0(42);
RQCFG_100268_.old_tb5_1(42):=255;
RQCFG_100268_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(42),-1)));
RQCFG_100268_.old_tb5_2(42):=null;
RQCFG_100268_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(42),-1)));
RQCFG_100268_.tb5_3(42):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(42):=RQCFG_100268_.tb3_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(42),
RQCFG_100268_.tb5_1(42),
RQCFG_100268_.tb5_2(42),
RQCFG_100268_.tb5_3(42),
RQCFG_100268_.tb5_4(42),
'C'
,
'E'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(43):=1098382;
RQCFG_100268_.tb3_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(43):=RQCFG_100268_.tb3_0(43);
RQCFG_100268_.old_tb3_1(43):=2036;
RQCFG_100268_.tb3_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(43),-1)));
RQCFG_100268_.old_tb3_2(43):=259;
RQCFG_100268_.tb3_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(43),-1)));
RQCFG_100268_.old_tb3_3(43):=null;
RQCFG_100268_.tb3_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(43),-1)));
RQCFG_100268_.old_tb3_4(43):=null;
RQCFG_100268_.tb3_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(43),-1)));
RQCFG_100268_.tb3_5(43):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(43):=121146296;
RQCFG_100268_.tb3_6(43):=NULL;
RQCFG_100268_.old_tb3_7(43):=null;
RQCFG_100268_.tb3_7(43):=NULL;
RQCFG_100268_.old_tb3_8(43):=null;
RQCFG_100268_.tb3_8(43):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(43),
RQCFG_100268_.tb3_1(43),
RQCFG_100268_.tb3_2(43),
RQCFG_100268_.tb3_3(43),
RQCFG_100268_.tb3_4(43),
RQCFG_100268_.tb3_5(43),
RQCFG_100268_.tb3_6(43),
RQCFG_100268_.tb3_7(43),
RQCFG_100268_.tb3_8(43),
null,
106699,
4,
'Fecha de Envío'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(43):=1368665;
RQCFG_100268_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(43):=RQCFG_100268_.tb5_0(43);
RQCFG_100268_.old_tb5_1(43):=259;
RQCFG_100268_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(43),-1)));
RQCFG_100268_.old_tb5_2(43):=null;
RQCFG_100268_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(43),-1)));
RQCFG_100268_.tb5_3(43):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(43):=RQCFG_100268_.tb3_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(43),
RQCFG_100268_.tb5_1(43),
RQCFG_100268_.tb5_2(43),
RQCFG_100268_.tb5_3(43),
RQCFG_100268_.tb5_4(43),
'C'
,
'Y'
,
4,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(44):=1098383;
RQCFG_100268_.tb3_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(44):=RQCFG_100268_.tb3_0(44);
RQCFG_100268_.old_tb3_1(44):=2036;
RQCFG_100268_.tb3_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(44),-1)));
RQCFG_100268_.old_tb3_2(44):=50001162;
RQCFG_100268_.tb3_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(44),-1)));
RQCFG_100268_.old_tb3_3(44):=null;
RQCFG_100268_.tb3_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(44),-1)));
RQCFG_100268_.old_tb3_4(44):=null;
RQCFG_100268_.tb3_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(44),-1)));
RQCFG_100268_.tb3_5(44):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(44):=121146297;
RQCFG_100268_.tb3_6(44):=NULL;
RQCFG_100268_.old_tb3_7(44):=121146298;
RQCFG_100268_.tb3_7(44):=NULL;
RQCFG_100268_.old_tb3_8(44):=120079382;
RQCFG_100268_.tb3_8(44):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(44),
RQCFG_100268_.tb3_1(44),
RQCFG_100268_.tb3_2(44),
RQCFG_100268_.tb3_3(44),
RQCFG_100268_.tb3_4(44),
RQCFG_100268_.tb3_5(44),
RQCFG_100268_.tb3_6(44),
RQCFG_100268_.tb3_7(44),
RQCFG_100268_.tb3_8(44),
null,
106700,
5,
'Funcionario'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(44):=1368666;
RQCFG_100268_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(44):=RQCFG_100268_.tb5_0(44);
RQCFG_100268_.old_tb5_1(44):=50001162;
RQCFG_100268_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(44),-1)));
RQCFG_100268_.old_tb5_2(44):=null;
RQCFG_100268_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(44),-1)));
RQCFG_100268_.tb5_3(44):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(44):=RQCFG_100268_.tb3_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(44),
RQCFG_100268_.tb5_1(44),
RQCFG_100268_.tb5_2(44),
RQCFG_100268_.tb5_3(44),
RQCFG_100268_.tb5_4(44),
'C'
,
'E'
,
5,
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
18,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(45):=1098384;
RQCFG_100268_.tb3_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(45):=RQCFG_100268_.tb3_0(45);
RQCFG_100268_.old_tb3_1(45):=2036;
RQCFG_100268_.tb3_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(45),-1)));
RQCFG_100268_.old_tb3_2(45):=109479;
RQCFG_100268_.tb3_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(45),-1)));
RQCFG_100268_.old_tb3_3(45):=null;
RQCFG_100268_.tb3_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(45),-1)));
RQCFG_100268_.old_tb3_4(45):=null;
RQCFG_100268_.tb3_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(45),-1)));
RQCFG_100268_.tb3_5(45):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(45):=121146299;
RQCFG_100268_.tb3_6(45):=NULL;
RQCFG_100268_.old_tb3_7(45):=null;
RQCFG_100268_.tb3_7(45):=NULL;
RQCFG_100268_.old_tb3_8(45):=120079383;
RQCFG_100268_.tb3_8(45):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(45),
RQCFG_100268_.tb3_1(45),
RQCFG_100268_.tb3_2(45),
RQCFG_100268_.tb3_3(45),
RQCFG_100268_.tb3_4(45),
RQCFG_100268_.tb3_5(45),
RQCFG_100268_.tb3_6(45),
RQCFG_100268_.tb3_7(45),
RQCFG_100268_.tb3_8(45),
null,
106701,
6,
'Punto de Atención'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(45):=1368667;
RQCFG_100268_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(45):=RQCFG_100268_.tb5_0(45);
RQCFG_100268_.old_tb5_1(45):=109479;
RQCFG_100268_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(45),-1)));
RQCFG_100268_.old_tb5_2(45):=null;
RQCFG_100268_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(45),-1)));
RQCFG_100268_.tb5_3(45):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(45):=RQCFG_100268_.tb3_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(45),
RQCFG_100268_.tb5_1(45),
RQCFG_100268_.tb5_2(45),
RQCFG_100268_.tb5_3(45),
RQCFG_100268_.tb5_4(45),
'C'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(46):=1098385;
RQCFG_100268_.tb3_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(46):=RQCFG_100268_.tb3_0(46);
RQCFG_100268_.old_tb3_1(46):=2036;
RQCFG_100268_.tb3_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(46),-1)));
RQCFG_100268_.old_tb3_2(46):=109478;
RQCFG_100268_.tb3_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(46),-1)));
RQCFG_100268_.old_tb3_3(46):=null;
RQCFG_100268_.tb3_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(46),-1)));
RQCFG_100268_.old_tb3_4(46):=null;
RQCFG_100268_.tb3_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(46),-1)));
RQCFG_100268_.tb3_5(46):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(46):=null;
RQCFG_100268_.tb3_6(46):=NULL;
RQCFG_100268_.old_tb3_7(46):=null;
RQCFG_100268_.tb3_7(46):=NULL;
RQCFG_100268_.old_tb3_8(46):=null;
RQCFG_100268_.tb3_8(46):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(46),
RQCFG_100268_.tb3_1(46),
RQCFG_100268_.tb3_2(46),
RQCFG_100268_.tb3_3(46),
RQCFG_100268_.tb3_4(46),
RQCFG_100268_.tb3_5(46),
RQCFG_100268_.tb3_6(46),
RQCFG_100268_.tb3_7(46),
RQCFG_100268_.tb3_8(46),
null,
106702,
7,
'Unidad Operativa Del Vendedor'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(46):=1368668;
RQCFG_100268_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(46):=RQCFG_100268_.tb5_0(46);
RQCFG_100268_.old_tb5_1(46):=109478;
RQCFG_100268_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(46),-1)));
RQCFG_100268_.old_tb5_2(46):=null;
RQCFG_100268_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(46),-1)));
RQCFG_100268_.tb5_3(46):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(46):=RQCFG_100268_.tb3_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(46),
RQCFG_100268_.tb5_1(46),
RQCFG_100268_.tb5_2(46),
RQCFG_100268_.tb5_3(46),
RQCFG_100268_.tb5_4(46),
'C'
,
'Y'
,
7,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(47):=1098386;
RQCFG_100268_.tb3_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(47):=RQCFG_100268_.tb3_0(47);
RQCFG_100268_.old_tb3_1(47):=2036;
RQCFG_100268_.tb3_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(47),-1)));
RQCFG_100268_.old_tb3_2(47):=42118;
RQCFG_100268_.tb3_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(47),-1)));
RQCFG_100268_.old_tb3_3(47):=109479;
RQCFG_100268_.tb3_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(47),-1)));
RQCFG_100268_.old_tb3_4(47):=null;
RQCFG_100268_.tb3_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(47),-1)));
RQCFG_100268_.tb3_5(47):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(47):=null;
RQCFG_100268_.tb3_6(47):=NULL;
RQCFG_100268_.old_tb3_7(47):=null;
RQCFG_100268_.tb3_7(47):=NULL;
RQCFG_100268_.old_tb3_8(47):=null;
RQCFG_100268_.tb3_8(47):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(47),
RQCFG_100268_.tb3_1(47),
RQCFG_100268_.tb3_2(47),
RQCFG_100268_.tb3_3(47),
RQCFG_100268_.tb3_4(47),
RQCFG_100268_.tb3_5(47),
RQCFG_100268_.tb3_6(47),
RQCFG_100268_.tb3_7(47),
RQCFG_100268_.tb3_8(47),
null,
106703,
8,
'Código Canal De Ventas'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(47):=1368669;
RQCFG_100268_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(47):=RQCFG_100268_.tb5_0(47);
RQCFG_100268_.old_tb5_1(47):=42118;
RQCFG_100268_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(47),-1)));
RQCFG_100268_.old_tb5_2(47):=null;
RQCFG_100268_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(47),-1)));
RQCFG_100268_.tb5_3(47):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(47):=RQCFG_100268_.tb3_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(47),
RQCFG_100268_.tb5_1(47),
RQCFG_100268_.tb5_2(47),
RQCFG_100268_.tb5_3(47),
RQCFG_100268_.tb5_4(47),
'C'
,
'Y'
,
8,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(48):=1098387;
RQCFG_100268_.tb3_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(48):=RQCFG_100268_.tb3_0(48);
RQCFG_100268_.old_tb3_1(48):=2036;
RQCFG_100268_.tb3_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(48),-1)));
RQCFG_100268_.old_tb3_2(48):=2683;
RQCFG_100268_.tb3_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(48),-1)));
RQCFG_100268_.old_tb3_3(48):=null;
RQCFG_100268_.tb3_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(48),-1)));
RQCFG_100268_.old_tb3_4(48):=null;
RQCFG_100268_.tb3_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(48),-1)));
RQCFG_100268_.tb3_5(48):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(48):=121146300;
RQCFG_100268_.tb3_6(48):=NULL;
RQCFG_100268_.old_tb3_7(48):=null;
RQCFG_100268_.tb3_7(48):=NULL;
RQCFG_100268_.old_tb3_8(48):=120079384;
RQCFG_100268_.tb3_8(48):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(48),
RQCFG_100268_.tb3_1(48),
RQCFG_100268_.tb3_2(48),
RQCFG_100268_.tb3_3(48),
RQCFG_100268_.tb3_4(48),
RQCFG_100268_.tb3_5(48),
RQCFG_100268_.tb3_6(48),
RQCFG_100268_.tb3_7(48),
RQCFG_100268_.tb3_8(48),
null,
106704,
9,
'Medio de recepción'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(48):=1368670;
RQCFG_100268_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(48):=RQCFG_100268_.tb5_0(48);
RQCFG_100268_.old_tb5_1(48):=2683;
RQCFG_100268_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(48),-1)));
RQCFG_100268_.old_tb5_2(48):=null;
RQCFG_100268_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(48),-1)));
RQCFG_100268_.tb5_3(48):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(48):=RQCFG_100268_.tb3_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(48),
RQCFG_100268_.tb5_1(48),
RQCFG_100268_.tb5_2(48),
RQCFG_100268_.tb5_3(48),
RQCFG_100268_.tb5_4(48),
'C'
,
'Y'
,
9,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(49):=1098388;
RQCFG_100268_.tb3_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(49):=RQCFG_100268_.tb3_0(49);
RQCFG_100268_.old_tb3_1(49):=2036;
RQCFG_100268_.tb3_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(49),-1)));
RQCFG_100268_.old_tb3_2(49):=146755;
RQCFG_100268_.tb3_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(49),-1)));
RQCFG_100268_.old_tb3_3(49):=null;
RQCFG_100268_.tb3_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(49),-1)));
RQCFG_100268_.old_tb3_4(49):=null;
RQCFG_100268_.tb3_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(49),-1)));
RQCFG_100268_.tb3_5(49):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(49):=121146301;
RQCFG_100268_.tb3_6(49):=NULL;
RQCFG_100268_.old_tb3_7(49):=null;
RQCFG_100268_.tb3_7(49):=NULL;
RQCFG_100268_.old_tb3_8(49):=null;
RQCFG_100268_.tb3_8(49):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(49),
RQCFG_100268_.tb3_1(49),
RQCFG_100268_.tb3_2(49),
RQCFG_100268_.tb3_3(49),
RQCFG_100268_.tb3_4(49),
RQCFG_100268_.tb3_5(49),
RQCFG_100268_.tb3_6(49),
RQCFG_100268_.tb3_7(49),
RQCFG_100268_.tb3_8(49),
null,
106705,
10,
'Información del Solicitante'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(49):=1368671;
RQCFG_100268_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(49):=RQCFG_100268_.tb5_0(49);
RQCFG_100268_.old_tb5_1(49):=146755;
RQCFG_100268_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(49),-1)));
RQCFG_100268_.old_tb5_2(49):=null;
RQCFG_100268_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(49),-1)));
RQCFG_100268_.tb5_3(49):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(49):=RQCFG_100268_.tb3_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(49),
RQCFG_100268_.tb5_1(49),
RQCFG_100268_.tb5_2(49),
RQCFG_100268_.tb5_3(49),
RQCFG_100268_.tb5_4(49),
'C'
,
'E'
,
10,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(50):=1098389;
RQCFG_100268_.tb3_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(50):=RQCFG_100268_.tb3_0(50);
RQCFG_100268_.old_tb3_1(50):=2036;
RQCFG_100268_.tb3_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(50),-1)));
RQCFG_100268_.old_tb3_2(50):=11619;
RQCFG_100268_.tb3_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(50),-1)));
RQCFG_100268_.old_tb3_3(50):=null;
RQCFG_100268_.tb3_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(50),-1)));
RQCFG_100268_.old_tb3_4(50):=null;
RQCFG_100268_.tb3_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(50),-1)));
RQCFG_100268_.tb3_5(50):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(50):=null;
RQCFG_100268_.tb3_6(50):=NULL;
RQCFG_100268_.old_tb3_7(50):=null;
RQCFG_100268_.tb3_7(50):=NULL;
RQCFG_100268_.old_tb3_8(50):=null;
RQCFG_100268_.tb3_8(50):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(50),
RQCFG_100268_.tb3_1(50),
RQCFG_100268_.tb3_2(50),
RQCFG_100268_.tb3_3(50),
RQCFG_100268_.tb3_4(50),
RQCFG_100268_.tb3_5(50),
RQCFG_100268_.tb3_6(50),
RQCFG_100268_.tb3_7(50),
RQCFG_100268_.tb3_8(50),
null,
106706,
11,
'Privacidad Suscriptor'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(50):=1368672;
RQCFG_100268_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(50):=RQCFG_100268_.tb5_0(50);
RQCFG_100268_.old_tb5_1(50):=11619;
RQCFG_100268_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(50),-1)));
RQCFG_100268_.old_tb5_2(50):=null;
RQCFG_100268_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(50),-1)));
RQCFG_100268_.tb5_3(50):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(50):=RQCFG_100268_.tb3_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(50),
RQCFG_100268_.tb5_1(50),
RQCFG_100268_.tb5_2(50),
RQCFG_100268_.tb5_3(50),
RQCFG_100268_.tb5_4(50),
'C'
,
'Y'
,
11,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(51):=1098390;
RQCFG_100268_.tb3_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(51):=RQCFG_100268_.tb3_0(51);
RQCFG_100268_.old_tb3_1(51):=2036;
RQCFG_100268_.tb3_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(51),-1)));
RQCFG_100268_.old_tb3_2(51):=191044;
RQCFG_100268_.tb3_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(51),-1)));
RQCFG_100268_.old_tb3_3(51):=null;
RQCFG_100268_.tb3_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(51),-1)));
RQCFG_100268_.old_tb3_4(51):=null;
RQCFG_100268_.tb3_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(51),-1)));
RQCFG_100268_.tb3_5(51):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(51):=121146302;
RQCFG_100268_.tb3_6(51):=NULL;
RQCFG_100268_.old_tb3_7(51):=null;
RQCFG_100268_.tb3_7(51):=NULL;
RQCFG_100268_.old_tb3_8(51):=null;
RQCFG_100268_.tb3_8(51):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(51),
RQCFG_100268_.tb3_1(51),
RQCFG_100268_.tb3_2(51),
RQCFG_100268_.tb3_3(51),
RQCFG_100268_.tb3_4(51),
RQCFG_100268_.tb3_5(51),
RQCFG_100268_.tb3_6(51),
RQCFG_100268_.tb3_7(51),
RQCFG_100268_.tb3_8(51),
null,
106707,
12,
'Facturación Es En La Recurrente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(51):=1368673;
RQCFG_100268_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(51):=RQCFG_100268_.tb5_0(51);
RQCFG_100268_.old_tb5_1(51):=191044;
RQCFG_100268_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(51),-1)));
RQCFG_100268_.old_tb5_2(51):=null;
RQCFG_100268_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(51),-1)));
RQCFG_100268_.tb5_3(51):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(51):=RQCFG_100268_.tb3_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(51),
RQCFG_100268_.tb5_1(51),
RQCFG_100268_.tb5_2(51),
RQCFG_100268_.tb5_3(51),
RQCFG_100268_.tb5_4(51),
'C'
,
'Y'
,
12,
'N'
,
'Facturación Es En La Recurrente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(52):=1098391;
RQCFG_100268_.tb3_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(52):=RQCFG_100268_.tb3_0(52);
RQCFG_100268_.old_tb3_1(52):=2036;
RQCFG_100268_.tb3_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(52),-1)));
RQCFG_100268_.old_tb3_2(52):=11621;
RQCFG_100268_.tb3_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(52),-1)));
RQCFG_100268_.old_tb3_3(52):=null;
RQCFG_100268_.tb3_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(52),-1)));
RQCFG_100268_.old_tb3_4(52):=null;
RQCFG_100268_.tb3_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(52),-1)));
RQCFG_100268_.tb3_5(52):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(52):=null;
RQCFG_100268_.tb3_6(52):=NULL;
RQCFG_100268_.old_tb3_7(52):=null;
RQCFG_100268_.tb3_7(52):=NULL;
RQCFG_100268_.old_tb3_8(52):=null;
RQCFG_100268_.tb3_8(52):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(52),
RQCFG_100268_.tb3_1(52),
RQCFG_100268_.tb3_2(52),
RQCFG_100268_.tb3_3(52),
RQCFG_100268_.tb3_4(52),
RQCFG_100268_.tb3_5(52),
RQCFG_100268_.tb3_6(52),
RQCFG_100268_.tb3_7(52),
RQCFG_100268_.tb3_8(52),
null,
106708,
13,
'Contrato pendiente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(52):=1368674;
RQCFG_100268_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(52):=RQCFG_100268_.tb5_0(52);
RQCFG_100268_.old_tb5_1(52):=11621;
RQCFG_100268_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(52),-1)));
RQCFG_100268_.old_tb5_2(52):=null;
RQCFG_100268_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(52),-1)));
RQCFG_100268_.tb5_3(52):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(52):=RQCFG_100268_.tb3_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(52),
RQCFG_100268_.tb5_1(52),
RQCFG_100268_.tb5_2(52),
RQCFG_100268_.tb5_3(52),
RQCFG_100268_.tb5_4(52),
'C'
,
'Y'
,
13,
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(53):=1098392;
RQCFG_100268_.tb3_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(53):=RQCFG_100268_.tb3_0(53);
RQCFG_100268_.old_tb3_1(53):=2036;
RQCFG_100268_.tb3_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(53),-1)));
RQCFG_100268_.old_tb3_2(53):=476;
RQCFG_100268_.tb3_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(53),-1)));
RQCFG_100268_.old_tb3_3(53):=null;
RQCFG_100268_.tb3_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(53),-1)));
RQCFG_100268_.old_tb3_4(53):=null;
RQCFG_100268_.tb3_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(53),-1)));
RQCFG_100268_.tb3_5(53):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(53):=121146308;
RQCFG_100268_.tb3_6(53):=NULL;
RQCFG_100268_.old_tb3_7(53):=null;
RQCFG_100268_.tb3_7(53):=NULL;
RQCFG_100268_.old_tb3_8(53):=null;
RQCFG_100268_.tb3_8(53):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(53),
RQCFG_100268_.tb3_1(53),
RQCFG_100268_.tb3_2(53),
RQCFG_100268_.tb3_3(53),
RQCFG_100268_.tb3_4(53),
RQCFG_100268_.tb3_5(53),
RQCFG_100268_.tb3_6(53),
RQCFG_100268_.tb3_7(53),
RQCFG_100268_.tb3_8(53),
null,
106723,
28,
'Código del Tipo Dirección'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(53):=1368675;
RQCFG_100268_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(53):=RQCFG_100268_.tb5_0(53);
RQCFG_100268_.old_tb5_1(53):=476;
RQCFG_100268_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(53),-1)));
RQCFG_100268_.old_tb5_2(53):=null;
RQCFG_100268_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(53),-1)));
RQCFG_100268_.tb5_3(53):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(53):=RQCFG_100268_.tb3_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(53),
RQCFG_100268_.tb5_1(53),
RQCFG_100268_.tb5_2(53),
RQCFG_100268_.tb5_3(53),
RQCFG_100268_.tb5_4(53),
'C'
,
'Y'
,
28,
'N'
,
'Código del Tipo Dirección'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(54):=1098393;
RQCFG_100268_.tb3_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(54):=RQCFG_100268_.tb3_0(54);
RQCFG_100268_.old_tb3_1(54):=2036;
RQCFG_100268_.tb3_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(54),-1)));
RQCFG_100268_.old_tb3_2(54):=2;
RQCFG_100268_.tb3_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(54),-1)));
RQCFG_100268_.old_tb3_3(54):=null;
RQCFG_100268_.tb3_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(54),-1)));
RQCFG_100268_.old_tb3_4(54):=null;
RQCFG_100268_.tb3_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(54),-1)));
RQCFG_100268_.tb3_5(54):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(54):=121146310;
RQCFG_100268_.tb3_6(54):=NULL;
RQCFG_100268_.old_tb3_7(54):=null;
RQCFG_100268_.tb3_7(54):=NULL;
RQCFG_100268_.old_tb3_8(54):=null;
RQCFG_100268_.tb3_8(54):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(54),
RQCFG_100268_.tb3_1(54),
RQCFG_100268_.tb3_2(54),
RQCFG_100268_.tb3_3(54),
RQCFG_100268_.tb3_4(54),
RQCFG_100268_.tb3_5(54),
RQCFG_100268_.tb3_6(54),
RQCFG_100268_.tb3_7(54),
RQCFG_100268_.tb3_8(54),
null,
106724,
29,
'Is_Address_Main'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(54):=1368676;
RQCFG_100268_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(54):=RQCFG_100268_.tb5_0(54);
RQCFG_100268_.old_tb5_1(54):=2;
RQCFG_100268_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(54),-1)));
RQCFG_100268_.old_tb5_2(54):=null;
RQCFG_100268_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(54),-1)));
RQCFG_100268_.tb5_3(54):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(54):=RQCFG_100268_.tb3_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(54),
RQCFG_100268_.tb5_1(54),
RQCFG_100268_.tb5_2(54),
RQCFG_100268_.tb5_3(54),
RQCFG_100268_.tb5_4(54),
'C'
,
'N'
,
29,
'N'
,
'Is_Address_Main'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(55):=1098394;
RQCFG_100268_.tb3_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(55):=RQCFG_100268_.tb3_0(55);
RQCFG_100268_.old_tb3_1(55):=2036;
RQCFG_100268_.tb3_1(55):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(55),-1)));
RQCFG_100268_.old_tb3_2(55):=138161;
RQCFG_100268_.tb3_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(55),-1)));
RQCFG_100268_.old_tb3_3(55):=null;
RQCFG_100268_.tb3_3(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(55),-1)));
RQCFG_100268_.old_tb3_4(55):=null;
RQCFG_100268_.tb3_4(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(55),-1)));
RQCFG_100268_.tb3_5(55):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(55):=null;
RQCFG_100268_.tb3_6(55):=NULL;
RQCFG_100268_.old_tb3_7(55):=null;
RQCFG_100268_.tb3_7(55):=NULL;
RQCFG_100268_.old_tb3_8(55):=null;
RQCFG_100268_.tb3_8(55):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (55)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(55),
RQCFG_100268_.tb3_1(55),
RQCFG_100268_.tb3_2(55),
RQCFG_100268_.tb3_3(55),
RQCFG_100268_.tb3_4(55),
RQCFG_100268_.tb3_5(55),
RQCFG_100268_.tb3_6(55),
RQCFG_100268_.tb3_7(55),
RQCFG_100268_.tb3_8(55),
null,
106725,
30,
'Información del Referente'
,
'N'
,
'Y'
,
'N'
,
30,
null,
null);

exception when others then
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(55):=1368677;
RQCFG_100268_.tb5_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(55):=RQCFG_100268_.tb5_0(55);
RQCFG_100268_.old_tb5_1(55):=138161;
RQCFG_100268_.tb5_1(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(55),-1)));
RQCFG_100268_.old_tb5_2(55):=null;
RQCFG_100268_.tb5_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(55),-1)));
RQCFG_100268_.tb5_3(55):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(55):=RQCFG_100268_.tb3_0(55);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(55),
RQCFG_100268_.tb5_1(55),
RQCFG_100268_.tb5_2(55),
RQCFG_100268_.tb5_3(55),
RQCFG_100268_.tb5_4(55),
'Y'
,
'Y'
,
30,
'N'
,
'Información del Referente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(56):=1098395;
RQCFG_100268_.tb3_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(56):=RQCFG_100268_.tb3_0(56);
RQCFG_100268_.old_tb3_1(56):=2036;
RQCFG_100268_.tb3_1(56):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(56),-1)));
RQCFG_100268_.old_tb3_2(56):=90021317;
RQCFG_100268_.tb3_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(56),-1)));
RQCFG_100268_.old_tb3_3(56):=null;
RQCFG_100268_.tb3_3(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(56),-1)));
RQCFG_100268_.old_tb3_4(56):=null;
RQCFG_100268_.tb3_4(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(56),-1)));
RQCFG_100268_.tb3_5(56):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(56):=null;
RQCFG_100268_.tb3_6(56):=NULL;
RQCFG_100268_.old_tb3_7(56):=null;
RQCFG_100268_.tb3_7(56):=NULL;
RQCFG_100268_.old_tb3_8(56):=120079390;
RQCFG_100268_.tb3_8(56):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (56)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(56),
RQCFG_100268_.tb3_1(56),
RQCFG_100268_.tb3_2(56),
RQCFG_100268_.tb3_3(56),
RQCFG_100268_.tb3_4(56),
RQCFG_100268_.tb3_5(56),
RQCFG_100268_.tb3_6(56),
RQCFG_100268_.tb3_7(56),
RQCFG_100268_.tb3_8(56),
null,
106726,
31,
'Suscripción del Usuario Referente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(56):=1368678;
RQCFG_100268_.tb5_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(56):=RQCFG_100268_.tb5_0(56);
RQCFG_100268_.old_tb5_1(56):=90021317;
RQCFG_100268_.tb5_1(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(56),-1)));
RQCFG_100268_.old_tb5_2(56):=null;
RQCFG_100268_.tb5_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(56),-1)));
RQCFG_100268_.tb5_3(56):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(56):=RQCFG_100268_.tb3_0(56);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(56),
RQCFG_100268_.tb5_1(56),
RQCFG_100268_.tb5_2(56),
RQCFG_100268_.tb5_3(56),
RQCFG_100268_.tb5_4(56),
'C'
,
'Y'
,
31,
'N'
,
'Suscripción del Usuario Referente'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb3_0(57):=1098396;
RQCFG_100268_.tb3_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
RQCFG_100268_.tb3_0(57):=RQCFG_100268_.tb3_0(57);
RQCFG_100268_.old_tb3_1(57):=2036;
RQCFG_100268_.tb3_1(57):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(RQCFG_100268_.TBENTITYNAME(NVL(RQCFG_100268_.old_tb3_1(57),-1)));
RQCFG_100268_.old_tb3_2(57):=6732;
RQCFG_100268_.tb3_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_2(57),-1)));
RQCFG_100268_.old_tb3_3(57):=null;
RQCFG_100268_.tb3_3(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_3(57),-1)));
RQCFG_100268_.old_tb3_4(57):=90021317;
RQCFG_100268_.tb3_4(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb3_4(57),-1)));
RQCFG_100268_.tb3_5(57):=RQCFG_100268_.tb2_2(0);
RQCFG_100268_.old_tb3_6(57):=null;
RQCFG_100268_.tb3_6(57):=NULL;
RQCFG_100268_.old_tb3_7(57):=null;
RQCFG_100268_.tb3_7(57):=NULL;
RQCFG_100268_.old_tb3_8(57):=null;
RQCFG_100268_.tb3_8(57):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (57)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (RQCFG_100268_.tb3_0(57),
RQCFG_100268_.tb3_1(57),
RQCFG_100268_.tb3_2(57),
RQCFG_100268_.tb3_3(57),
RQCFG_100268_.tb3_4(57),
RQCFG_100268_.tb3_5(57),
RQCFG_100268_.tb3_6(57),
RQCFG_100268_.tb3_7(57),
RQCFG_100268_.tb3_8(57),
null,
106727,
32,
'Nombre'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQCFG_100268_.blProcessStatus) then
 return;
end if;

RQCFG_100268_.old_tb5_0(57):=1368679;
RQCFG_100268_.tb5_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
RQCFG_100268_.tb5_0(57):=RQCFG_100268_.tb5_0(57);
RQCFG_100268_.old_tb5_1(57):=6732;
RQCFG_100268_.tb5_1(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_1(57),-1)));
RQCFG_100268_.old_tb5_2(57):=90021317;
RQCFG_100268_.tb5_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(RQCFG_100268_.TBENTITYATTRIBUTENAME(NVL(RQCFG_100268_.old_tb5_2(57),-1)));
RQCFG_100268_.tb5_3(57):=RQCFG_100268_.tb4_0(1);
RQCFG_100268_.tb5_4(57):=RQCFG_100268_.tb3_0(57);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (RQCFG_100268_.tb5_0(57),
RQCFG_100268_.tb5_1(57),
RQCFG_100268_.tb5_2(57),
RQCFG_100268_.tb5_3(57),
RQCFG_100268_.tb5_4(57),
'C'
,
'N'
,
32,
'N'
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
RQCFG_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   package_type_id = (100268);
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   package_type_id = (100268)
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN
ut_trace.trace('Inicia AfterScript. Se copian expresiones y sentencias a los atributos de las composiciones', 7);

if (not RQCFG_100268_.blProcessStatus) then
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
AND     external_root_id = 100268
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
AND     external_root_id = 100268
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
AND     external_root_id = 100268
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100268, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100268)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100268, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100268)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100268, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100268)
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
            WHERE   config_id = gi_boconfig.fnuGetConfig(2012, 100268, 4)
            AND     external_id in (SELECT product_type_id FROM ps_prd_motiv_package WHERE package_type_id = 100268)
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se eliminan las composiciones sobrantes', 7);
IF RQCFG_100268_.tbCompositions.FIRST IS not null THEN
   for nuIndex in RQCFG_100268_.tbCompositions.FIRST..RQCFG_100268_.tbCompositions.LAST loop
       BEGIN
           DELETE FROM GI_COMPOSITION WHERE rowid = RQCFG_100268_.tbCompositions(nuIndex);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
           ut_trace.trace('No se pudo borrar el registro '||RQCFG_100268_.tbCompositions(nuIndex));
           null;
       END;
   END loop;
END IF;

exception when others then
RQCFG_100268_.blProcessStatus := false;
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
 nuIndex := RQCFG_100268_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || RQCFG_100268_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(RQCFG_100268_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(RQCFG_100268_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(RQCFG_100268_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || RQCFG_100268_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || RQCFG_100268_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := RQCFG_100268_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('RQCFG_100268_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQCFG_100268_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_R_100268_',
'CREATE OR REPLACE PACKAGE I18N_R_100268_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_R_100268_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_R_100268_******************************'); END;
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
WHERE     EXTERNAL_ROOT_ID= 100268
AND       ENTITY_ROOT_ID=2012
AND       CONFIG_TYPE_ID=4
)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
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
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(0):='M_INSTALACION_DE_GAS_100276'
;
I18N_R_100268_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(0),
I18N_R_100268_.tb0_1(0),
'WE8ISO8859P1'
,
'Instalación de Gas'
,
'Instalación de Gas'
,
null,
'Instalación de Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(1):='M_INSTALACION_DE_GAS_100276'
;
I18N_R_100268_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(1),
I18N_R_100268_.tb0_1(1),
'WE8ISO8859P1'
,
'Instalación de Gas'
,
'Instalación de Gas'
,
null,
'Instalación de Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(2):='M_INSTALACION_DE_GAS_100276'
;
I18N_R_100268_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(2),
I18N_R_100268_.tb0_1(2),
'WE8ISO8859P1'
,
'Instalación de Gas'
,
'Instalación de Gas'
,
null,
'Instalación de Gas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(3):='PAQUETE'
;
I18N_R_100268_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(3),
I18N_R_100268_.tb0_1(3),
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
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(4):='PAQUETE'
;
I18N_R_100268_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(4),
I18N_R_100268_.tb0_1(4),
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
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(5):='PAQUETE'
;
I18N_R_100268_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(5),
I18N_R_100268_.tb0_1(5),
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
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_R_100268_.blProcessStatus) then
 return;
end if;

I18N_R_100268_.tb0_0(6):='PAQUETE'
;
I18N_R_100268_.tb0_1(6):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_R_100268_.tb0_0(6),
I18N_R_100268_.tb0_1(6),
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
I18N_R_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_R_100268_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_R_100268_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RQEXEC_100268_',
'CREATE OR REPLACE PACKAGE RQEXEC_100268_ IS ' || chr(10) ||
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
'END RQEXEC_100268_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RQEXEC_100268_******************************'); END;
/


BEGIN

if (not RQEXEC_100268_.blProcessStatus) then
 return;
end if;

RQEXEC_100268_.old_tb0_0(0):='P_LDC_VISITA_VENTA_GAS_XML_100268'
;
RQEXEC_100268_.tb0_0(0):=UPPER(RQEXEC_100268_.old_tb0_0(0));
RQEXEC_100268_.old_tb0_1(0):=500000000003801;
RQEXEC_100268_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(RQEXEC_100268_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
RQEXEC_100268_.tb0_1(0):=RQEXEC_100268_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=RQEXEC_100268_.tb0_0(0),
EXECUTABLE_ID=RQEXEC_100268_.tb0_1(0),
DESCRIPTION='LDC VISITA VENTA GAS XML'
,
PATH=null,
VERSION='155'
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
 WHERE EXECUTABLE_ID = RQEXEC_100268_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (RQEXEC_100268_.tb0_0(0),
RQEXEC_100268_.tb0_1(0),
'LDC VISITA VENTA GAS XML'
,
null,
'155'
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
RQEXEC_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RQEXEC_100268_.blProcessStatus) then
 return;
end if;

RQEXEC_100268_.tb1_0(0):=1;
RQEXEC_100268_.tb1_1(0):=RQEXEC_100268_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (RQEXEC_100268_.tb1_0(0),
RQEXEC_100268_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
RQEXEC_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('RQEXEC_100268_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RQEXEC_100268_******************************'); end;
/

