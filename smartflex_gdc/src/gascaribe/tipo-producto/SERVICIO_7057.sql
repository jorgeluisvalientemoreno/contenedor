BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('SERV_7057_',
'CREATE OR REPLACE PACKAGE SERV_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyTIPOSERVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbTIPOSERVRowId tyTIPOSERVRowId;type tyGE_SERVICE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_SERVICE_TYPERowId tyGE_SERVICE_TYPERowId;type tySERVICIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSERVICIORowId tySERVICIORowId;type tyPS_PROD_COMPOSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_COMPOSITIONRowId tyPS_PROD_COMPOSITIONRowId;type tyPS_CLASS_SER_PRO_COMRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_CLASS_SER_PRO_COMRowId tyPS_CLASS_SER_PRO_COMRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyPS_PRODUCT_MOTIVERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PRODUCT_MOTIVERowId tyPS_PRODUCT_MOTIVERowId;type tyGE_SERVICE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_SERVICE_CLASSRowId tyGE_SERVICE_CLASSRowId;type tyPS_COMPONENT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_COMPONENT_TYPERowId tyPS_COMPONENT_TYPERowId;type tyPS_PROD_ENTITY_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_ENTITY_TYPERowId tyPS_PROD_ENTITY_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyPS_MOTIVE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_MOTIVE_TYPERowId tyPS_MOTIVE_TYPERowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type tyPS_CLASS_SERVICERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_CLASS_SERVICERowId tyPS_CLASS_SERVICERowId;type tyPS_PACKAGE_UNITTYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PACKAGE_UNITTYPERowId tyPS_PACKAGE_UNITTYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyCONFCOSERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbCONFCOSERowId tyCONFCOSERowId;type tyCONFESCORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbCONFESCORowId tyCONFESCORowId;type ty0_0 is table of TIPOSERV.TISECODI%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of SERVICIO.SERVCODI%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SERVICIO.SERVCLAS%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of SERVICIO.SERVTISE%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_3 is table of SERVICIO.SERVSETI%type index by binary_integer; ' || chr(10) ||
'old_tb2_3 ty2_3; ' || chr(10) ||
'tb2_3 ty2_3;type ty3_0 is table of WF_ATTRIBUTES_EQUIV.ATTRIBUTES_EQUIV_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_2 is table of WF_ATTRIBUTES_EQUIV.VALUE_2%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty4_0 is table of PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of PS_COMPONENT_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of PS_COMPONENT_TYPE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty5_0 is table of PS_MOTIVE_TYPE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty6_0 is table of PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_2 is table of PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty6_3 is table of PS_PRODUCT_MOTIVE.ACTION_ASSIGN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_3 ty6_3; ' || chr(10) ||
'tb6_3 ty6_3;type ty7_0 is table of PS_PROD_COMPOSITION.PROD_COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_PROD_COMPOSITION.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of PS_PROD_COMPOSITION.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty7_3 is table of PS_PROD_COMPOSITION.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_3 ty7_3; ' || chr(10) ||
'tb7_3 ty7_3;type ty7_4 is table of PS_PROD_COMPOSITION.PARENT_COMPONENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_4 ty7_4; ' || chr(10) ||
'tb7_4 ty7_4;type ty8_0 is table of PS_PACKAGE_UNITTYPE.PACKAGE_UNITTYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_2 is table of PS_PACKAGE_UNITTYPE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty9_0 is table of CONFCOSE.COCSSERV%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of CONFESCO.COECSERV%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of CONFESCO.COECCODI%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END SERV_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:SERV_7057_******************************'); END;
/

BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
UPDATE gi_comp_attribs
SET    init_expression_id = null,
valid_expression_id = null,
select_statement_id = null
WHERE  composition_id in
(
SELECT composition_id
FROM   gi_config_comp
WHERE  config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4)
AND    external_id = 7057
)
AND    entity_id <> 2036;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   SERV_7057_.tbEntityName(-1) := 'NULL';
   SERV_7057_.tbEntityAttributeName(-1) := 'NULL';

   SERV_7057_.tbEntityName(5173) := 'SERVICIO';
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_type_id = 7057
AND     PS_PROD_MOTI_PARAM.product_motive_id = PS_PRODUCT_MOTIVE.product_motive_id
AND     PS_PROD_MOTI_PARAM.attribute_id = GE_ATTRIBUTES.attribute_id
AND     gr_config_expression.config_expression_id = ge_Attributes.valid_expression
union all
SELECT  object_name
FROM    GR_CONFIG_EXPRESSION, GE_ACTION_MODULE, PS_PRODUCT_MOTIVE
WHERE   PS_PRODUCT_MOTIVE.product_type_id = 7057
AND     PS_PRODUCT_MOTIVE.action_assign_id = GE_ACTION_MODULE.action_id
AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ACTION_MODULE.config_expression_id;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  SERV_7057_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_ATTRIBUTES_EQUIV WHERE (VALUE_2) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057) AND VALUE_1=''||ps_boconfigurator_ds.fnugetsalespacktype||'';
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
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
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057)));
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
SERV_7057_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057))));
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
SERV_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057))));

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT ACTION_ASSIGN_ID FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057)));
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
SERV_7057_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_PRODUCT_MOTIVE WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057));
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_PRODUCT_MOTIVE',1);
for rcData in cuLoadTemporaryTable loop
SERV_7057_.tbPS_PRODUCT_MOTIVERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_CLASS_SERVICE WHERE (CLASS_SERVICE_ID) in (SELECT CLASS_SERVICE_ID FROM PS_CLASS_SER_PRO_COM WHERE (PROD_COMPOSITION_ID) in (SELECT PROD_COMPOSITION_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057)));
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
SERV_7057_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
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
FROM PS_CLASS_SER_PRO_COM WHERE (PROD_COMPOSITION_ID) in (SELECT PROD_COMPOSITION_ID FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057));
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_CLASS_SER_PRO_COM',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_CLASS_SER_PRO_COM WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=SERV_7057_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = SERV_7057_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SERV_7057_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SERV_7057_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
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
FROM PS_PROD_COMPOSITION WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057);
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_COMPOSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_COMPOSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=SERV_7057_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = SERV_7057_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SERV_7057_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SERV_7057_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=SERV_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = SERV_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SERV_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SERV_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=SERV_7057_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = SERV_7057_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SERV_7057_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SERV_7057_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_PRODUCT_MOTIVE',1);
nuVarcharIndex:=SERV_7057_.tbPS_PRODUCT_MOTIVERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_PRODUCT_MOTIVE where rowid = SERV_7057_.tbPS_PRODUCT_MOTIVERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SERV_7057_.tbPS_PRODUCT_MOTIVERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SERV_7057_.tbPS_PRODUCT_MOTIVERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SERV_7057_.blProcessStatus := false;
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
FROM PS_COMPONENT_TYPE WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057);
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_COMPONENT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_COMPONENT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
SERV_7057_.blProcessStatus := false;
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
FROM PS_PACKAGE_UNITTYPE WHERE (PRODUCT_TYPE_ID) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
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
SERV_7057_.blProcessStatus := false;
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
FROM CONFCOSE WHERE (COCSSERV) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057);
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla CONFCOSE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM CONFCOSE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
SERV_7057_.blProcessStatus := false;
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
FROM CONFESCO WHERE (COECSERV) in (SELECT SERVCODI FROM SERVICIO WHERE SERVCODI=7057);
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla CONFESCO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM CONFESCO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
SERV_7057_.blProcessStatus := false;
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
FROM SERVICIO WHERE SERVCODI=7057;
nuIndex binary_integer;
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SERVICIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM SERVICIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb0_0(0):='99'
;
ut_trace.trace('insertando tabla sin fallo: TIPOSERV fila (0)',1);
INSERT INTO TIPOSERV(TISECODI,TISEDESC) 
VALUES (SERV_7057_.tb0_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb1_0(0):=99;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (SERV_7057_.tb1_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb2_0(0):=7057;
SERV_7057_.tb2_2(0):=SERV_7057_.tb0_0(0);
SERV_7057_.tb2_3(0):=SERV_7057_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: SERVICIO fila (0)',1);
UPDATE SERVICIO SET SERVCODI=SERV_7057_.tb2_0(0),
SERVCLAS=null,
SERVTISE=SERV_7057_.tb2_2(0),
SERVSETI=SERV_7057_.tb2_3(0),
SERVDESC='Energia Solar'
,
SERVCOEX='7057'
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
SERVTXML='PR_ENERGIA_SOLAR_7057'
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
 WHERE SERVCODI = SERV_7057_.tb2_0(0);
if not (sql%found) then
INSERT INTO SERVICIO(SERVCODI,SERVCLAS,SERVTISE,SERVSETI,SERVDESC,SERVCOEX,SERVFLST,SERVFLBA,SERVFLAC,SERVFLIM,SERVPRRE,SERVFLFR,SERVFLRE,SERVAPFR,SERVVAAF,SERVFLPC,SERVTECO,SERVFLFI,SERVNVEC,SERVLIQU,SERVNPRC,SERVORLE,SERVREUB,SERVCEDI,SERVTXML,SERVASAU,SERVPRFI,SERVCOLC,SERVTICO,SERVDIMI) 
VALUES (SERV_7057_.tb2_0(0),
null,
SERV_7057_.tb2_2(0),
SERV_7057_.tb2_3(0),
'Energia Solar'
,
'7057'
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
'PR_ENERGIA_SOLAR_7057'
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
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb3_0(0):=100263;
SERV_7057_.tb3_2(0):=SERV_7057_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_ATTRIBUTES_EQUIV fila (0)',1);
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,VALUE_1,VALUE_2,INTERFACE_CONFIG_ID,UNIT_TYPE_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (SERV_7057_.tb3_0(0),
587,
SERV_7057_.tb3_2(0),
5,
100049,
0,
31536000,
0,
'Venta - Energia Solar'
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

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb4_0(0):=7104;
SERV_7057_.tb4_1(0):=SERV_7057_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (0)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=SERV_7057_.tb4_0(0),
SERVICE_TYPE_ID=SERV_7057_.tb4_1(0),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Energia Solar '
,
ACCEPT_IF_PROJECTED='N'
,
ASSIGNABLE='N'
,
TAG_NAME='CP_ENERGIA_SOLAR_7104'
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

 WHERE COMPONENT_TYPE_ID = SERV_7057_.tb4_0(0);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (SERV_7057_.tb4_0(0),
SERV_7057_.tb4_1(0),
null,
'Energia Solar '
,
'N'
,
'N'
,
'CP_ENERGIA_SOLAR_7104'
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
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb5_0(0):=8;
ut_trace.trace('Actualizar o insertar tabla: PS_MOTIVE_TYPE fila (0)',1);
UPDATE PS_MOTIVE_TYPE SET MOTIVE_TYPE_ID=SERV_7057_.tb5_0(0),
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

 WHERE MOTIVE_TYPE_ID = SERV_7057_.tb5_0(0);
if not (sql%found) then
INSERT INTO PS_MOTIVE_TYPE(MOTIVE_TYPE_ID,CLASS_REGISTER_ID,DESCRIPTION,ASSIGNABLE,USE_WF_PLAN,TAG_NAME,ACTIVITY_TYPE) 
VALUES (SERV_7057_.tb5_0(0),
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
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb6_0(0):=100300;
SERV_7057_.tb6_2(0):=SERV_7057_.tb5_0(0);
ut_trace.trace('insertando tabla sin fallo: PS_PRODUCT_MOTIVE fila (0)',1);
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (SERV_7057_.tb6_0(0),
7057,
SERV_7057_.tb6_2(0),
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_ENERGIA_SOLAR_100300'
,
'Instalación de Energia Solar'
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
'Y'
,
'Y'
);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb7_0(0):=10105;
SERV_7057_.tb7_1(0):=SERV_7057_.tb6_0(0);
SERV_7057_.tb7_2(0):=SERV_7057_.tb4_0(0);
SERV_7057_.tb7_3(0):=SERV_7057_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_COMPOSITION fila (0)',1);
UPDATE PS_PROD_COMPOSITION SET PROD_COMPOSITION_ID=SERV_7057_.tb7_0(0),
PRODUCT_MOTIVE_ID=SERV_7057_.tb7_1(0),
COMPONENT_TYPE_ID=SERV_7057_.tb7_2(0),
PRODUCT_TYPE_ID=SERV_7057_.tb7_3(0),
PARENT_COMPONENT_ID=null,
DESCRIPTION='Energia Solar '
,
IS_OPTIONAL='N'
,
ASSIGN_ORDER=1,
IS_MAIN='Y'

 WHERE PROD_COMPOSITION_ID = SERV_7057_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_COMPOSITION(PROD_COMPOSITION_ID,PRODUCT_MOTIVE_ID,COMPONENT_TYPE_ID,PRODUCT_TYPE_ID,PARENT_COMPONENT_ID,DESCRIPTION,IS_OPTIONAL,ASSIGN_ORDER,IS_MAIN) 
VALUES (SERV_7057_.tb7_0(0),
SERV_7057_.tb7_1(0),
SERV_7057_.tb7_2(0),
SERV_7057_.tb7_3(0),
null,
'Energia Solar '
,
'N'
,
1,
'Y'
);
end if;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb8_0(0):=10000000253;
SERV_7057_.tb8_2(0):=SERV_7057_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PACKAGE_UNITTYPE fila (0)',1);
UPDATE PS_PACKAGE_UNITTYPE SET PACKAGE_UNITTYPE_ID=SERV_7057_.tb8_0(0),
PACKAGE_TYPE_ID=587,
PRODUCT_TYPE_ID=SERV_7057_.tb8_2(0),
PRODUCT_MOTIVE_ID=null,
UNIT_TYPE_ID=100049,
INTERFACE_CONFIG_ID=5
 WHERE PACKAGE_UNITTYPE_ID = SERV_7057_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_PACKAGE_UNITTYPE(PACKAGE_UNITTYPE_ID,PACKAGE_TYPE_ID,PRODUCT_TYPE_ID,PRODUCT_MOTIVE_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID) 
VALUES (SERV_7057_.tb8_0(0),
587,
SERV_7057_.tb8_2(0),
null,
100049,
5);
end if;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb9_0(0):=SERV_7057_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: CONFCOSE fila (0)',1);
UPDATE CONFCOSE SET COCSSERV=SERV_7057_.tb9_0(0),
COCSNCDX=999,
COCSNCCX=2,
COCSMNCR=0,
COCSPDCX=100,
COCSNDRL=0,
COCSPDCR=0,
COCSNCRI=0
 WHERE COCSSERV = SERV_7057_.tb9_0(0);
if not (sql%found) then
INSERT INTO CONFCOSE(COCSSERV,COCSNCDX,COCSNCCX,COCSMNCR,COCSPDCX,COCSNDRL,COCSPDCR,COCSNCRI) 
VALUES (SERV_7057_.tb9_0(0),
999,
2,
0,
100,
0,
0,
0);
end if;

exception when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(0):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(0):=96;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (0)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(0),
SERV_7057_.tb10_1(0),
null,
'S'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(1):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(1):=1;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (1)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(1),
SERV_7057_.tb10_1(1),
null,
'S'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(2):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(2):=94;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (2)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(2),
SERV_7057_.tb10_1(2),
null,
'S'
,
90,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(3):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(3):=99;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (3)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(3),
SERV_7057_.tb10_1(3),
null,
'S'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(4):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(4):=111;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (4)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(4),
SERV_7057_.tb10_1(4),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(5):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(5):=6;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (5)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(5),
SERV_7057_.tb10_1(5),
null,
'S'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(6):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(6):=110;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (6)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(6),
SERV_7057_.tb10_1(6),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(7):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(7):=112;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (7)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(7),
SERV_7057_.tb10_1(7),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(8):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(8):=2;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (8)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(8),
SERV_7057_.tb10_1(8),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(9):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(9):=92;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (9)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(9),
SERV_7057_.tb10_1(9),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(10):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(10):=5;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (10)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(10),
SERV_7057_.tb10_1(10),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(11):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(11):=95;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (11)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(11),
SERV_7057_.tb10_1(11),
null,
'N'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SERV_7057_.blProcessStatus) then
 return;
end if;

SERV_7057_.tb10_0(12):=SERV_7057_.tb2_0(0);
SERV_7057_.tb10_1(12):=3;
ut_trace.trace('insertando tabla sin fallo: CONFESCO fila (12)',1);
INSERT INTO CONFESCO(COECSERV,COECCODI,COECFUFA,COECFACT,COECDICO,COECGECA,COECREDA,COECTECS,COECREGE,COECREGL,COECRVAD,COECIDRV) 
VALUES (SERV_7057_.tb10_0(12),
SERV_7057_.tb10_1(12),
null,
'S'
,
0,
'N'
,
'N'
,
'--'
,
null,
null,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
SERV_7057_.blProcessStatus := false;
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
 nuIndex := SERV_7057_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || SERV_7057_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(SERV_7057_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(SERV_7057_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(SERV_7057_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || SERV_7057_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || SERV_7057_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := SERV_7057_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('SERV_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:SERV_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('PET5173_7057_',
'CREATE OR REPLACE PACKAGE PET5173_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyPS_PROD_ENTITY_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_ENTITY_TYPERowId tyPS_PROD_ENTITY_TYPERowId;type ty0_0 is table of PS_PROD_ENTITY_TYPE.PROD_ENTITY_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of PS_PROD_ENTITY_TYPE.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END PET5173_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:PET5173_7057_******************************'); END;
/


BEGIN 
   PET5173_7057_.tbEntityName(-1) := 'NULL';
   PET5173_7057_.tbEntityAttributeName(-1) := 'NULL';

   PET5173_7057_.tbEntityName(5173) := 'SERVICIO';
END; 
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_ENTITY_TYPE WHERE ENTITY_VALUE=7057 and ENTITY_ID = 5173;
nuIndex binary_integer;
BEGIN

if (not PET5173_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_ENTITY_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_ENTITY_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
PET5173_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PET5173_7057_.blProcessStatus) then
 return;
end if;

PET5173_7057_.tb0_0(0):=2107;
PET5173_7057_.old_tb0_1(0):=5173;
PET5173_7057_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PET5173_7057_.TBENTITYNAME(NVL(PET5173_7057_.old_tb0_1(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_ENTITY_TYPE fila (0)',1);
UPDATE PS_PROD_ENTITY_TYPE SET PROD_ENTITY_TYPE_ID=PET5173_7057_.tb0_0(0),
ENTITY_ID=PET5173_7057_.tb0_1(0),
ENTITY_VALUE=7057,
DESCRIPTION='Energia Solar'

 WHERE PROD_ENTITY_TYPE_ID = PET5173_7057_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_ENTITY_TYPE(PROD_ENTITY_TYPE_ID,ENTITY_ID,ENTITY_VALUE,DESCRIPTION) 
VALUES (PET5173_7057_.tb0_0(0),
PET5173_7057_.tb0_1(0),
7057,
'Energia Solar'
);
end if;

exception when others then
PET5173_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('PET5173_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:PET5173_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('PRMTX_7057_',
'CREATE OR REPLACE PACKAGE PRMTX_7057_ IS ' || chr(10) ||
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
'tb4_9 ty4_9;type ty5_0 is table of GE_SERVICE_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty6_0 is table of PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of PS_COMPONENT_TYPE.SERVICE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty7_0 is table of PS_PROD_MOTIVE_COMP.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of PS_PROD_MOTIVE_COMP.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of PS_PROD_MOTIVE_COMP.PARENT_COMP%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty7_4 is table of PS_PROD_MOTIVE_COMP.COMPONENT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_4 ty7_4; ' || chr(10) ||
'tb7_4 ty7_4;type ty8_0 is table of PS_MOTI_COMP_ATTRIBS.MOTI_COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of PS_MOTI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty8_3 is table of PS_MOTI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb8_3 ty8_3; ' || chr(10) ||
'tb8_3 ty8_3;type ty8_4 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_4 ty8_4; ' || chr(10) ||
'tb8_4 ty8_4;type ty8_5 is table of PS_MOTI_COMP_ATTRIBS.PROD_MOTIVE_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_5 ty8_5; ' || chr(10) ||
'tb8_5 ty8_5;type ty8_6 is table of PS_MOTI_COMP_ATTRIBS.PARENT_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_6 ty8_6; ' || chr(10) ||
'tb8_6 ty8_6;type ty8_7 is table of PS_MOTI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_7 ty8_7; ' || chr(10) ||
'tb8_7 ty8_7;type ty8_8 is table of PS_MOTI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_8 ty8_8; ' || chr(10) ||
'tb8_8 ty8_8;type ty8_9 is table of PS_MOTI_COMP_ATTRIBS.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_9 ty8_9; ' || chr(10) ||
'tb8_9 ty8_9;type ty9_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of PS_PRD_MOTIV_PACKAGE.PRD_MOTIV_PACKAGE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of PS_PRD_MOTIV_PACKAGE.PRODUCT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;CURSOR cuProdMot is ' || chr(10) ||
'SELECT product_motive_id ' || chr(10) ||
'from   ps_prd_motiv_package ' || chr(10) ||
'where  product_type_id = 7057 ' || chr(10) ||
'AND    package_type_id = ps_boconfigurator_ds.fnugetsalespacktype; ' || chr(10) ||
'--Obtiene Reglas Asociadas a GE_ATTRIBUTES ' || chr(10) ||
'CURSOR  cuExpressions IS ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_PROD_MOTI_PARAM ' || chr(10) ||
'WHERE   PS_PROD_MOTI_PARAM.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prod_composition ' || chr(10) ||
'WHERE product_type_id = 7057 ' || chr(10) ||
')  ' || chr(10) ||
'AND     GE_ATTRIBUTES.attribute_id = PS_PROD_MOTI_PARAM.attribute_id ' || chr(10) ||
'AND     GR_CONFIG_EXPRESSION.config_expression_id = GE_ATTRIBUTES.valid_expression ' || chr(10) ||
'UNION  ' || chr(10) ||
'SELECT  GR_CONFIG_EXPRESSION.Config_Expression_Id  ' || chr(10) ||
'FROM    GR_CONFIG_EXPRESSION, GE_ATTRIBUTES, PS_MOTI_COMP_PARAM, PS_PROD_MOTIVE_COMP ' || chr(10) ||
'WHERE   PS_PROD_MOTIVE_COMP.product_motive_id in ' || chr(10) ||
'( ' || chr(10) ||
'select product_motive_id ' || chr(10) ||
'FROM ps_prod_composition ' || chr(10) ||
'WHERE product_type_id = 7057 ' || chr(10) ||
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
'END PRMTX_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:PRMTX_7057_******************************'); END;
/

BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se cargan reglas a memoria', 8);
open PRMTX_7057_.cuExpressions;
fetch PRMTX_7057_.cuExpressions bulk collect INTO PRMTX_7057_.tbExpressionsId;
close PRMTX_7057_.cuExpressions;

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   PRMTX_7057_.tbEntityName(-1) := 'NULL';
   PRMTX_7057_.tbEntityAttributeName(-1) := 'NULL';

   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityName(14) := 'MO_COMMENT';
   PRMTX_7057_.tbEntityName(68) := 'MO_PROCESS';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   PRMTX_7057_.tbEntityName(17) := 'MO_PACKAGES';
   PRMTX_7057_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   PRMTX_7057_.tbEntityName(14) := 'MO_COMMENT';
   PRMTX_7057_.tbEntityAttributeName(243) := 'MO_COMMENT@COMMENT_';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   PRMTX_7057_.tbEntityName(68) := 'MO_PROCESS';
   PRMTX_7057_.tbEntityAttributeName(703) := 'MO_PROCESS@COMMENTS';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   PRMTX_7057_.tbEntityName(17) := 'MO_PACKAGES';
   PRMTX_7057_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   PRMTX_7057_.tbEntityName(43) := 'MO_COMPONENT';
   PRMTX_7057_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   PRMTX_7057_.tbEntityName(43) := 'MO_COMPONENT';
   PRMTX_7057_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   PRMTX_7057_.tbEntityName(43) := 'MO_COMPONENT';
   PRMTX_7057_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   PRMTX_7057_.tbEntityName(43) := 'MO_COMPONENT';
   PRMTX_7057_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   PRMTX_7057_.tbEntityName(43) := 'MO_COMPONENT';
   PRMTX_7057_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   PRMTX_7057_.tbEntityName(8) := 'MO_MOTIVE';
   PRMTX_7057_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
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
FROM ps_prod_composition
WHERE product_type_id = 7057
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
FROM ps_prod_composition
WHERE product_type_id = 7057
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
FROM ps_prod_composition
WHERE product_type_id = 7057
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
FROM ps_prod_composition
WHERE product_type_id = 7057
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
FROM ps_prod_composition
WHERE product_type_id = 7057
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)
AND     ( GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.PRE_EXP_EXEC_ID OR 
          GR_CONFIG_EXPRESSION.config_expression_id = PS_PROD_MOTI_ACTION.POS_EXP_EXEC_ID ) 
;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  PRMTX_7057_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_PROD_MOTI_ATTRIB WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=PRMTX_7057_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = PRMTX_7057_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=PRMTX_7057_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = PRMTX_7057_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla IM_COMPONENT_ROUTE',1);
  DELETE FROM IM_COMPONENT_ROUTE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_OBJECT_COMP_TYPE',1);
  DELETE FROM PS_OBJECT_COMP_TYPE WHERE (OBJECT_COMP_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_COMPONENT_TYPE WHERE (COMPONENT_TYPE_ID) in (SELECT COMPONENT_TYPE_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_COMPONENT_TYPE',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbPS_COMPONENT_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_WHEN_MOTI_COMPON',1);
  DELETE FROM PS_WHEN_MOTI_COMPON WHERE (MOTI_COMPON_EVENT_ID) in (SELECT MOTI_COMPON_EVENT_ID FROM PS_MOTI_COMPON_EVENT WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ATTRIBUTES',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGE_ATTRIBUTESRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ATTRIBUTES',1);
nuVarcharIndex:=PRMTX_7057_.tbGE_ATTRIBUTESRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ATTRIBUTES where rowid = PRMTX_7057_.tbGE_ATTRIBUTESRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGE_ATTRIBUTESRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGE_ATTRIBUTESRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM PS_MOTI_COMP_ATTRIBS WHERE (PROD_MOTIVE_COMP_ID) in (SELECT PROD_MOTIVE_COMP_ID FROM PS_PROD_MOTIVE_COMP WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
)))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=PRMTX_7057_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = PRMTX_7057_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=PRMTX_7057_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = PRMTX_7057_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_COMPONENT_TYPE',1);
nuVarcharIndex:=PRMTX_7057_.tbPS_COMPONENT_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_COMPONENT_TYPE where rowid = PRMTX_7057_.tbPS_COMPONENT_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbPS_COMPONENT_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbPS_COMPONENT_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)) AND PACKAGE_TYPE_ID=ps_boconfigurator_ds.fnugetsalespacktype;
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT SOURCE_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
))));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_VALID_ACTION_MODU',1);
  DELETE FROM GE_VALID_ACTION_MODU WHERE (ACTION_ID) in (SELECT ACTION_ID FROM GE_ACTION_MODULE WHERE (ACTION_ID) in (SELECT TARGET_ACTION_ID FROM PS_PROD_MOTI_ACTION WHERE (PRODUCT_MOTIVE_ID) in (SELECT PRODUCT_MOTIVE_ID FROM PS_PRODUCT_MOTIVE WHERE product_motive_id in
(
select product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
))));

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
)));
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_ACTION_MODULE',1);
for rcData in cuLoadTemporaryTable loop
PRMTX_7057_.tbGE_ACTION_MODULERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
));
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=PRMTX_7057_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = PRMTX_7057_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_ACTION_MODULE',1);
nuVarcharIndex:=PRMTX_7057_.tbGE_ACTION_MODULERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_ACTION_MODULE where rowid = PRMTX_7057_.tbGE_ACTION_MODULERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PRMTX_7057_.tbGE_ACTION_MODULERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PRMTX_7057_.tbGE_ACTION_MODULERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
FROM ps_prod_composition
WHERE product_type_id = 7057
);
nuIndex binary_integer;
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb0_0(0):=100300;
PRMTX_7057_.tb0_1(0):=7057;
ut_trace.trace('Actualizar o insertar tabla: PS_PRODUCT_MOTIVE fila (0)',1);
UPDATE PS_PRODUCT_MOTIVE SET PRODUCT_MOTIVE_ID=PRMTX_7057_.tb0_0(0),
PRODUCT_TYPE_ID=PRMTX_7057_.tb0_1(0),
MOTIVE_TYPE_ID=8,
ACTION_ASSIGN_ID=null,
ACCEPT_IF_PROJECTED='N'
,
PARENT_ASSIGNED_FLAG='N'
,
ACCEPT_YIELDED_PROD='N'
,
TAG_NAME='M_INSTALACION_DE_ENERGIA_SOLAR_100300'
,
DESCRIPTION='Instalación de Energia Solar'
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
REUSABLE_IN_BUNDLE='Y'
,
USED_IN_INCLUDED='Y'

 WHERE PRODUCT_MOTIVE_ID = PRMTX_7057_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PRODUCT_MOTIVE(PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,MOTIVE_TYPE_ID,ACTION_ASSIGN_ID,ACCEPT_IF_PROJECTED,PARENT_ASSIGNED_FLAG,ACCEPT_YIELDED_PROD,TAG_NAME,DESCRIPTION,USE_UNCOMPOSITION,LOAD_PRODUCT_INFO,LOAD_HIERARCHY,PROCESS_WITH_XML,IS_MULTI_PRODUCT,ACTIVE,IS_NULLABLE,PROD_MOTI_TO_COPY_ID,LOAD_ALLCOMP_IN_COPY,LOAD_MOT_DATA_FOR_CP,REUSABLE_IN_BUNDLE,USED_IN_INCLUDED) 
VALUES (PRMTX_7057_.tb0_0(0),
PRMTX_7057_.tb0_1(0),
8,
null,
'N'
,
'N'
,
'N'
,
'M_INSTALACION_DE_ENERGIA_SOLAR_100300'
,
'Instalación de Energia Solar'
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
'Y'
,
'Y'
);
end if;

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb1_0(0):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=PRMTX_7057_.tb1_0(0),
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

 WHERE MODULE_ID = PRMTX_7057_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (PRMTX_7057_.tb1_0(0),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb2_0(0):=23;
PRMTX_7057_.tb2_1(0):=PRMTX_7057_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=PRMTX_7057_.tb2_0(0),
MODULE_ID=PRMTX_7057_.tb2_1(0),
DESCRIPTION='Inicializacion de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_INITATRIB_'

 WHERE CONFIGURA_TYPE_ID = PRMTX_7057_.tb2_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (PRMTX_7057_.tb2_0(0),
PRMTX_7057_.tb2_1(0),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.old_tb3_0(0):=121397887;
PRMTX_7057_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
PRMTX_7057_.tb3_0(0):=PRMTX_7057_.tb3_0(0);
PRMTX_7057_.old_tb3_1(0):='MO_INITATRIB_CT23E121397887'
;
PRMTX_7057_.tb3_1(0):=PRMTX_7057_.tb3_0(0);
PRMTX_7057_.tb3_2(0):=PRMTX_7057_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (PRMTX_7057_.tb3_0(0),
PRMTX_7057_.tb3_1(0),
PRMTX_7057_.tb3_2(0),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETMOTIVEID())'
,
'TESTOSS'
,
to_date('28-02-2007 08:34:50','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:58','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:58','DD-MM-YYYY HH24:MI:SS'),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(0):=104221;
PRMTX_7057_.old_tb4_1(0):=8;
PRMTX_7057_.tb4_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(0),-1)));
PRMTX_7057_.old_tb4_2(0):=187;
PRMTX_7057_.tb4_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(0),-1)));
PRMTX_7057_.old_tb4_3(0):=null;
PRMTX_7057_.tb4_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(0),-1)));
PRMTX_7057_.old_tb4_4(0):=null;
PRMTX_7057_.tb4_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(0),-1)));
PRMTX_7057_.tb4_6(0):=PRMTX_7057_.tb3_0(0);
PRMTX_7057_.tb4_9(0):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (0)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(0),
ENTITY_ID=PRMTX_7057_.tb4_1(0),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(0),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(0),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(0),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=PRMTX_7057_.tb4_6(0),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(0),
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(0),
PRMTX_7057_.tb4_1(0),
PRMTX_7057_.tb4_2(0),
PRMTX_7057_.tb4_3(0),
PRMTX_7057_.tb4_4(0),
null,
PRMTX_7057_.tb4_6(0),
null,
null,
PRMTX_7057_.tb4_9(0),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(1):=104222;
PRMTX_7057_.old_tb4_1(1):=8;
PRMTX_7057_.tb4_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(1),-1)));
PRMTX_7057_.old_tb4_2(1):=213;
PRMTX_7057_.tb4_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(1),-1)));
PRMTX_7057_.old_tb4_3(1):=255;
PRMTX_7057_.tb4_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(1),-1)));
PRMTX_7057_.old_tb4_4(1):=null;
PRMTX_7057_.tb4_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(1),-1)));
PRMTX_7057_.tb4_9(1):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (1)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(1),
ENTITY_ID=PRMTX_7057_.tb4_1(1),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(1),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(1),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(1),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(1),
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(1);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(1),
PRMTX_7057_.tb4_1(1),
PRMTX_7057_.tb4_2(1),
PRMTX_7057_.tb4_3(1),
PRMTX_7057_.tb4_4(1),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(1),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.old_tb3_0(1):=121397888;
PRMTX_7057_.tb3_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
PRMTX_7057_.tb3_0(1):=PRMTX_7057_.tb3_0(1);
PRMTX_7057_.old_tb3_1(1):='MO_INITATRIB_CT23E121397888'
;
PRMTX_7057_.tb3_1(1):=PRMTX_7057_.tb3_0(1);
PRMTX_7057_.tb3_2(1):=PRMTX_7057_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (PRMTX_7057_.tb3_0(1),
PRMTX_7057_.tb3_1(1),
PRMTX_7057_.tb3_2(1),
'CF_BOINITRULES.INIPRIORITY()'
,
'TESTOSS'
,
to_date('28-02-2007 10:16:53','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(2):=104223;
PRMTX_7057_.old_tb4_1(2):=8;
PRMTX_7057_.tb4_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(2),-1)));
PRMTX_7057_.old_tb4_2(2):=203;
PRMTX_7057_.tb4_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(2),-1)));
PRMTX_7057_.old_tb4_3(2):=null;
PRMTX_7057_.tb4_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(2),-1)));
PRMTX_7057_.old_tb4_4(2):=null;
PRMTX_7057_.tb4_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(2),-1)));
PRMTX_7057_.tb4_6(2):=PRMTX_7057_.tb3_0(1);
PRMTX_7057_.tb4_9(2):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (2)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(2),
ENTITY_ID=PRMTX_7057_.tb4_1(2),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(2),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(2),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(2),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=PRMTX_7057_.tb4_6(2),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(2),
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(2);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(2),
PRMTX_7057_.tb4_1(2),
PRMTX_7057_.tb4_2(2),
PRMTX_7057_.tb4_3(2),
PRMTX_7057_.tb4_4(2),
null,
PRMTX_7057_.tb4_6(2),
null,
null,
PRMTX_7057_.tb4_9(2),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.old_tb3_0(2):=121397889;
PRMTX_7057_.tb3_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
PRMTX_7057_.tb3_0(2):=PRMTX_7057_.tb3_0(2);
PRMTX_7057_.old_tb3_1(2):='MO_INITATRIB_CT23E121397889'
;
PRMTX_7057_.tb3_1(2):=PRMTX_7057_.tb3_0(2);
PRMTX_7057_.tb3_2(2):=PRMTX_7057_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (PRMTX_7057_.tb3_0(2),
PRMTX_7057_.tb3_1(2),
PRMTX_7057_.tb3_2(2),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("Y")'
,
'TESTOSS'
,
to_date('28-02-2007 08:34:55','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(3):=104224;
PRMTX_7057_.old_tb4_1(3):=8;
PRMTX_7057_.tb4_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(3),-1)));
PRMTX_7057_.old_tb4_2(3):=322;
PRMTX_7057_.tb4_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(3),-1)));
PRMTX_7057_.old_tb4_3(3):=null;
PRMTX_7057_.tb4_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(3),-1)));
PRMTX_7057_.old_tb4_4(3):=null;
PRMTX_7057_.tb4_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(3),-1)));
PRMTX_7057_.tb4_6(3):=PRMTX_7057_.tb3_0(2);
PRMTX_7057_.tb4_9(3):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (3)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(3),
ENTITY_ID=PRMTX_7057_.tb4_1(3),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(3),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(3),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(3),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=PRMTX_7057_.tb4_6(3),
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(3),
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(3);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(3),
PRMTX_7057_.tb4_1(3),
PRMTX_7057_.tb4_2(3),
PRMTX_7057_.tb4_3(3),
PRMTX_7057_.tb4_4(3),
null,
PRMTX_7057_.tb4_6(3),
null,
null,
PRMTX_7057_.tb4_9(3),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(4):=104225;
PRMTX_7057_.old_tb4_1(4):=8;
PRMTX_7057_.tb4_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(4),-1)));
PRMTX_7057_.old_tb4_2(4):=2641;
PRMTX_7057_.tb4_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(4),-1)));
PRMTX_7057_.old_tb4_3(4):=null;
PRMTX_7057_.tb4_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(4),-1)));
PRMTX_7057_.old_tb4_4(4):=null;
PRMTX_7057_.tb4_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(4),-1)));
PRMTX_7057_.tb4_9(4):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (4)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(4),
ENTITY_ID=PRMTX_7057_.tb4_1(4),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(4),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(4),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(4),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(4),
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(4);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(4),
PRMTX_7057_.tb4_1(4),
PRMTX_7057_.tb4_2(4),
PRMTX_7057_.tb4_3(4),
PRMTX_7057_.tb4_4(4),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(4),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(5):=104226;
PRMTX_7057_.old_tb4_1(5):=8;
PRMTX_7057_.tb4_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(5),-1)));
PRMTX_7057_.old_tb4_2(5):=189;
PRMTX_7057_.tb4_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(5),-1)));
PRMTX_7057_.old_tb4_3(5):=257;
PRMTX_7057_.tb4_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(5),-1)));
PRMTX_7057_.old_tb4_4(5):=null;
PRMTX_7057_.tb4_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(5),-1)));
PRMTX_7057_.tb4_9(5):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (5)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(5),
ENTITY_ID=PRMTX_7057_.tb4_1(5),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(5),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(5),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(5),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(5),
PROCESS_SEQUENCE=5,
DISPLAY_NAME='Número Petición Atención al cliente'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(5);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(5),
PRMTX_7057_.tb4_1(5),
PRMTX_7057_.tb4_2(5),
PRMTX_7057_.tb4_3(5),
PRMTX_7057_.tb4_4(5),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(5),
5,
'Número Petición Atención al cliente'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(6):=104292;
PRMTX_7057_.old_tb4_1(6):=8;
PRMTX_7057_.tb4_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(6),-1)));
PRMTX_7057_.old_tb4_2(6):=50001324;
PRMTX_7057_.tb4_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(6),-1)));
PRMTX_7057_.old_tb4_3(6):=null;
PRMTX_7057_.tb4_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(6),-1)));
PRMTX_7057_.old_tb4_4(6):=null;
PRMTX_7057_.tb4_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(6),-1)));
PRMTX_7057_.tb4_9(6):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (6)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(6),
ENTITY_ID=PRMTX_7057_.tb4_1(6),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(6),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(6),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(6),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(6),
PROCESS_SEQUENCE=6,
DISPLAY_NAME='Ubicación Geográfica'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(6);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(6),
PRMTX_7057_.tb4_1(6),
PRMTX_7057_.tb4_2(6),
PRMTX_7057_.tb4_3(6),
PRMTX_7057_.tb4_4(6),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(6),
6,
'Ubicación Geográfica'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(7):=104293;
PRMTX_7057_.old_tb4_1(7):=8;
PRMTX_7057_.tb4_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(7),-1)));
PRMTX_7057_.old_tb4_2(7):=201;
PRMTX_7057_.tb4_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(7),-1)));
PRMTX_7057_.old_tb4_3(7):=null;
PRMTX_7057_.tb4_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(7),-1)));
PRMTX_7057_.old_tb4_4(7):=null;
PRMTX_7057_.tb4_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(7),-1)));
PRMTX_7057_.tb4_9(7):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (7)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(7),
ENTITY_ID=PRMTX_7057_.tb4_1(7),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(7),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(7),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(7),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(7),
PROCESS_SEQUENCE=7,
DISPLAY_NAME='Inicio de Provisionalidad'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(7);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(7),
PRMTX_7057_.tb4_1(7),
PRMTX_7057_.tb4_2(7),
PRMTX_7057_.tb4_3(7),
PRMTX_7057_.tb4_4(7),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(7),
7,
'Inicio de Provisionalidad'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(8):=104294;
PRMTX_7057_.old_tb4_1(8):=8;
PRMTX_7057_.tb4_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(8),-1)));
PRMTX_7057_.old_tb4_2(8):=202;
PRMTX_7057_.tb4_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(8),-1)));
PRMTX_7057_.old_tb4_3(8):=null;
PRMTX_7057_.tb4_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(8),-1)));
PRMTX_7057_.old_tb4_4(8):=null;
PRMTX_7057_.tb4_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(8),-1)));
PRMTX_7057_.tb4_9(8):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (8)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(8),
ENTITY_ID=PRMTX_7057_.tb4_1(8),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(8),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(8),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(8),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(8),
PROCESS_SEQUENCE=8,
DISPLAY_NAME='Fin de Provisionalidad'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(8);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(8),
PRMTX_7057_.tb4_1(8),
PRMTX_7057_.tb4_2(8),
PRMTX_7057_.tb4_3(8),
PRMTX_7057_.tb4_4(8),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(8),
8,
'Fin de Provisionalidad'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(9):=104295;
PRMTX_7057_.old_tb4_1(9):=8;
PRMTX_7057_.tb4_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(9),-1)));
PRMTX_7057_.old_tb4_2(9):=498;
PRMTX_7057_.tb4_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(9),-1)));
PRMTX_7057_.old_tb4_3(9):=null;
PRMTX_7057_.tb4_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(9),-1)));
PRMTX_7057_.old_tb4_4(9):=null;
PRMTX_7057_.tb4_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(9),-1)));
PRMTX_7057_.tb4_9(9):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (9)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(9),
ENTITY_ID=PRMTX_7057_.tb4_1(9),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(9),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(9),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(9),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(9),
PROCESS_SEQUENCE=9,
DISPLAY_NAME='Fecha de Atención'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(9);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(9),
PRMTX_7057_.tb4_1(9),
PRMTX_7057_.tb4_2(9),
PRMTX_7057_.tb4_3(9),
PRMTX_7057_.tb4_4(9),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(9),
9,
'Fecha de Atención'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(10):=104296;
PRMTX_7057_.old_tb4_1(10):=8;
PRMTX_7057_.tb4_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(10),-1)));
PRMTX_7057_.old_tb4_2(10):=220;
PRMTX_7057_.tb4_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(10),-1)));
PRMTX_7057_.old_tb4_3(10):=null;
PRMTX_7057_.tb4_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(10),-1)));
PRMTX_7057_.old_tb4_4(10):=null;
PRMTX_7057_.tb4_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(10),-1)));
PRMTX_7057_.tb4_9(10):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (10)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(10),
ENTITY_ID=PRMTX_7057_.tb4_1(10),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(10),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(10),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(10),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(10),
PROCESS_SEQUENCE=10,
DISPLAY_NAME='Identificador de Distribución Administrativa'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(10);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(10),
PRMTX_7057_.tb4_1(10),
PRMTX_7057_.tb4_2(10),
PRMTX_7057_.tb4_3(10),
PRMTX_7057_.tb4_4(10),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(10),
10,
'Identificador de Distribución Administrativa'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(11):=104297;
PRMTX_7057_.old_tb4_1(11):=8;
PRMTX_7057_.tb4_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(11),-1)));
PRMTX_7057_.old_tb4_2(11):=524;
PRMTX_7057_.tb4_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(11),-1)));
PRMTX_7057_.old_tb4_3(11):=null;
PRMTX_7057_.tb4_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(11),-1)));
PRMTX_7057_.old_tb4_4(11):=null;
PRMTX_7057_.tb4_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(11),-1)));
PRMTX_7057_.tb4_9(11):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (11)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(11),
ENTITY_ID=PRMTX_7057_.tb4_1(11),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(11),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(11),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(11),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(11),
PROCESS_SEQUENCE=11,
DISPLAY_NAME='Estado del Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(11);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(11),
PRMTX_7057_.tb4_1(11),
PRMTX_7057_.tb4_2(11),
PRMTX_7057_.tb4_3(11),
PRMTX_7057_.tb4_4(11),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(11),
11,
'Estado del Motivo'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(12):=104298;
PRMTX_7057_.old_tb4_1(12):=8;
PRMTX_7057_.tb4_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(12),-1)));
PRMTX_7057_.old_tb4_2(12):=191;
PRMTX_7057_.tb4_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(12),-1)));
PRMTX_7057_.old_tb4_3(12):=null;
PRMTX_7057_.tb4_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(12),-1)));
PRMTX_7057_.old_tb4_4(12):=null;
PRMTX_7057_.tb4_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(12),-1)));
PRMTX_7057_.tb4_9(12):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (12)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(12),
ENTITY_ID=PRMTX_7057_.tb4_1(12),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(12),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(12),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(12),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(12),
PROCESS_SEQUENCE=12,
DISPLAY_NAME='Identificador del Tipo de Motivo'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(12);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(12),
PRMTX_7057_.tb4_1(12),
PRMTX_7057_.tb4_2(12),
PRMTX_7057_.tb4_3(12),
PRMTX_7057_.tb4_4(12),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(12),
12,
'Identificador del Tipo de Motivo'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(13):=104299;
PRMTX_7057_.old_tb4_1(13):=8;
PRMTX_7057_.tb4_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(13),-1)));
PRMTX_7057_.old_tb4_2(13):=192;
PRMTX_7057_.tb4_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(13),-1)));
PRMTX_7057_.old_tb4_3(13):=null;
PRMTX_7057_.tb4_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(13),-1)));
PRMTX_7057_.old_tb4_4(13):=null;
PRMTX_7057_.tb4_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(13),-1)));
PRMTX_7057_.tb4_9(13):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (13)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(13),
ENTITY_ID=PRMTX_7057_.tb4_1(13),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(13),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(13),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(13),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(13),
PROCESS_SEQUENCE=13,
DISPLAY_NAME='Identificador del Tipo de Producto'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(13);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(13),
PRMTX_7057_.tb4_1(13),
PRMTX_7057_.tb4_2(13),
PRMTX_7057_.tb4_3(13),
PRMTX_7057_.tb4_4(13),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(13),
13,
'Identificador del Tipo de Producto'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(14):=104300;
PRMTX_7057_.old_tb4_1(14):=8;
PRMTX_7057_.tb4_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(14),-1)));
PRMTX_7057_.old_tb4_2(14):=4011;
PRMTX_7057_.tb4_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(14),-1)));
PRMTX_7057_.old_tb4_3(14):=null;
PRMTX_7057_.tb4_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(14),-1)));
PRMTX_7057_.old_tb4_4(14):=null;
PRMTX_7057_.tb4_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(14),-1)));
PRMTX_7057_.tb4_9(14):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (14)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(14),
ENTITY_ID=PRMTX_7057_.tb4_1(14),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(14),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(14),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(14),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(14),
PROCESS_SEQUENCE=14,
DISPLAY_NAME='Número del Servicio'
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(14);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(14),
PRMTX_7057_.tb4_1(14),
PRMTX_7057_.tb4_2(14),
PRMTX_7057_.tb4_3(14),
PRMTX_7057_.tb4_4(14),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(14),
14,
'Número del Servicio'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(15):=104301;
PRMTX_7057_.old_tb4_1(15):=8;
PRMTX_7057_.tb4_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(15),-1)));
PRMTX_7057_.old_tb4_2(15):=11403;
PRMTX_7057_.tb4_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(15),-1)));
PRMTX_7057_.old_tb4_3(15):=null;
PRMTX_7057_.tb4_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(15),-1)));
PRMTX_7057_.old_tb4_4(15):=null;
PRMTX_7057_.tb4_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(15),-1)));
PRMTX_7057_.tb4_9(15):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (15)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(15),
ENTITY_ID=PRMTX_7057_.tb4_1(15),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(15),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(15),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(15),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(15),
PROCESS_SEQUENCE=15,
DISPLAY_NAME='Identificador de la Suscripción'
,
DISPLAY_ORDER=15,
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

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(15);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(15),
PRMTX_7057_.tb4_1(15),
PRMTX_7057_.tb4_2(15),
PRMTX_7057_.tb4_3(15),
PRMTX_7057_.tb4_4(15),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(15),
15,
'Identificador de la Suscripción'
,
15,
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(16):=104302;
PRMTX_7057_.old_tb4_1(16):=68;
PRMTX_7057_.tb4_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(16),-1)));
PRMTX_7057_.old_tb4_2(16):=703;
PRMTX_7057_.tb4_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(16),-1)));
PRMTX_7057_.old_tb4_3(16):=null;
PRMTX_7057_.tb4_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(16),-1)));
PRMTX_7057_.old_tb4_4(16):=null;
PRMTX_7057_.tb4_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(16),-1)));
PRMTX_7057_.tb4_9(16):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (16)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(16),
ENTITY_ID=PRMTX_7057_.tb4_1(16),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(16),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(16),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(16),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(16),
PROCESS_SEQUENCE=16,
DISPLAY_NAME='Comentarios'
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
TAG_NAME='COMENTARIOS'
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
ATTRI_TECHNICAL_NAME='COMMENTS'
,
IN_PERSIST='N'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(16);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(16),
PRMTX_7057_.tb4_1(16),
PRMTX_7057_.tb4_2(16),
PRMTX_7057_.tb4_3(16),
PRMTX_7057_.tb4_4(16),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(16),
16,
'Comentarios'
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
'COMENTARIOS'
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
'COMMENTS'
,
'N'
,
'N'
);
end if;

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb4_0(17):=104303;
PRMTX_7057_.old_tb4_1(17):=14;
PRMTX_7057_.tb4_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb4_1(17),-1)));
PRMTX_7057_.old_tb4_2(17):=243;
PRMTX_7057_.tb4_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_2(17),-1)));
PRMTX_7057_.old_tb4_3(17):=null;
PRMTX_7057_.tb4_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_3(17),-1)));
PRMTX_7057_.old_tb4_4(17):=null;
PRMTX_7057_.tb4_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb4_4(17),-1)));
PRMTX_7057_.tb4_9(17):=PRMTX_7057_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTI_ATTRIB fila (17)',1);
UPDATE PS_PROD_MOTI_ATTRIB SET PROD_MOTI_ATTRIB_ID=PRMTX_7057_.tb4_0(17),
ENTITY_ID=PRMTX_7057_.tb4_1(17),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb4_2(17),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb4_3(17),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb4_4(17),
STATEMENT_ID=null,
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
PARENT_ATTRIB_ID=null,
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb4_9(17),
PROCESS_SEQUENCE=17,
DISPLAY_NAME='Observaciones'
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
TAG_NAME='OBSERVACIONES'
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
ENTITY_NAME='MO_COMMENT'
,
ATTRI_TECHNICAL_NAME='COMMENT_'
,
IN_PERSIST='Y'
,
INCLUDED_XML='N'

 WHERE PROD_MOTI_ATTRIB_ID = PRMTX_7057_.tb4_0(17);
if not (sql%found) then
INSERT INTO PS_PROD_MOTI_ATTRIB(PROD_MOTI_ATTRIB_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,PARENT_ATTRIB_ID,PRODUCT_MOTIVE_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,IS_CHANGE_ATTRIB,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb4_0(17),
PRMTX_7057_.tb4_1(17),
PRMTX_7057_.tb4_2(17),
PRMTX_7057_.tb4_3(17),
PRMTX_7057_.tb4_4(17),
null,
null,
null,
null,
PRMTX_7057_.tb4_9(17),
17,
'Observaciones'
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
'OBSERVACIONES'
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
'MO_COMMENT'
,
'COMMENT_'
,
'Y'
,
'N'
);
end if;

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb5_0(0):=99;
ut_trace.trace('insertando tabla sin fallo: GE_SERVICE_TYPE fila (0)',1);
INSERT INTO GE_SERVICE_TYPE(SERVICE_TYPE_ID,DESCRIPTION) 
VALUES (PRMTX_7057_.tb5_0(0),
'GAS'
);

exception 
when dup_val_on_index then 
 return;
when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb6_0(0):=7104;
PRMTX_7057_.tb6_1(0):=PRMTX_7057_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_COMPONENT_TYPE fila (0)',1);
UPDATE PS_COMPONENT_TYPE SET COMPONENT_TYPE_ID=PRMTX_7057_.tb6_0(0),
SERVICE_TYPE_ID=PRMTX_7057_.tb6_1(0),
PRODUCT_TYPE_ID=null,
DESCRIPTION='Energia Solar '
,
ACCEPT_IF_PROJECTED='N'
,
ASSIGNABLE='N'
,
TAG_NAME='CP_ENERGIA_SOLAR_7104'
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

 WHERE COMPONENT_TYPE_ID = PRMTX_7057_.tb6_0(0);
if not (sql%found) then
INSERT INTO PS_COMPONENT_TYPE(COMPONENT_TYPE_ID,SERVICE_TYPE_ID,PRODUCT_TYPE_ID,DESCRIPTION,ACCEPT_IF_PROJECTED,ASSIGNABLE,TAG_NAME,ELEMENT_DAYS_WAIT,IS_AUTOMATIC_ASSIGN,SUSPEND_ALLOWED,IS_DEPENDENT,VALIDATE_RETIRE,IS_MEASURABLE,IS_MOVEABLE,ELEMENT_TYPE_ID,COMPONEN_BY_QUANTITY,PRODUCT_REFERENCE,AUTOMATIC_ACTIVATION,CONCEPT_ID,SALE_CONCEPT_ID,ALLOW_CLASS_CHANGE) 
VALUES (PRMTX_7057_.tb6_0(0),
PRMTX_7057_.tb6_1(0),
null,
'Energia Solar '
,
'N'
,
'N'
,
'CP_ENERGIA_SOLAR_7104'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb7_0(0):=10340;
PRMTX_7057_.tb7_1(0):=PRMTX_7057_.tb0_0(0);
PRMTX_7057_.tb7_4(0):=PRMTX_7057_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_MOTIVE_COMP fila (0)',1);
UPDATE PS_PROD_MOTIVE_COMP SET PROD_MOTIVE_COMP_ID=PRMTX_7057_.tb7_0(0),
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb7_1(0),
PARENT_COMP=null,
SERVICE_COMPONENT=10340,
COMPONENT_TYPE_ID=PRMTX_7057_.tb7_4(0),
MOTIVE_TYPE_ID=8,
TAG_NAME='C_ENERGIA_SOLAR_10340'
,
ASSIGN_ORDER=3,
MIN_COMPONENTS=1,
MAX_COMPONENTS=1,
IS_OPTIONAL='N'
,
DESCRIPTION='Energia Solar'
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

 WHERE PROD_MOTIVE_COMP_ID = PRMTX_7057_.tb7_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_MOTIVE_COMP(PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,SERVICE_COMPONENT,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN) 
VALUES (PRMTX_7057_.tb7_0(0),
PRMTX_7057_.tb7_1(0),
null,
10340,
PRMTX_7057_.tb7_4(0),
8,
'C_ENERGIA_SOLAR_10340'
,
3,
1,
1,
'N'
,
'Energia Solar'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.old_tb3_0(3):=121397890;
PRMTX_7057_.tb3_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
PRMTX_7057_.tb3_0(3):=PRMTX_7057_.tb3_0(3);
PRMTX_7057_.old_tb3_1(3):='MO_INITATRIB_CT23E121397890'
;
PRMTX_7057_.tb3_1(3):=PRMTX_7057_.tb3_0(3);
PRMTX_7057_.tb3_2(3):=PRMTX_7057_.tb2_0(0);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (PRMTX_7057_.tb3_0(3),
PRMTX_7057_.tb3_1(3),
PRMTX_7057_.tb3_2(3),
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(MO_BOSEQUENCES.FNUGETCOMPONENTID())'
,
'DEV'
,
to_date('27-04-2002 00:00:00','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb8_0(0):=105293;
PRMTX_7057_.old_tb8_1(0):=43;
PRMTX_7057_.tb8_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb8_1(0),-1)));
PRMTX_7057_.old_tb8_2(0):=338;
PRMTX_7057_.tb8_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_2(0),-1)));
PRMTX_7057_.old_tb8_3(0):=null;
PRMTX_7057_.tb8_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_3(0),-1)));
PRMTX_7057_.old_tb8_4(0):=null;
PRMTX_7057_.tb8_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_4(0),-1)));
PRMTX_7057_.tb8_5(0):=PRMTX_7057_.tb7_0(0);
PRMTX_7057_.tb8_8(0):=PRMTX_7057_.tb3_0(3);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (0)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=PRMTX_7057_.tb8_0(0),
ENTITY_ID=PRMTX_7057_.tb8_1(0),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb8_2(0),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb8_3(0),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb8_4(0),
PROD_MOTIVE_COMP_ID=PRMTX_7057_.tb8_5(0),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=null,
INIT_EXPRESSION_ID=PRMTX_7057_.tb8_8(0),
STATEMENT_ID=null,
PROCESS_SEQUENCE=0,
DISPLAY_NAME='Identificador del Componente Registro Componente'
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

 WHERE MOTI_COMP_ATTRIBS_ID = PRMTX_7057_.tb8_0(0);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb8_0(0),
PRMTX_7057_.tb8_1(0),
PRMTX_7057_.tb8_2(0),
PRMTX_7057_.tb8_3(0),
PRMTX_7057_.tb8_4(0),
PRMTX_7057_.tb8_5(0),
null,
null,
PRMTX_7057_.tb8_8(0),
null,
0,
'Identificador del Componente Registro Componente'
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb2_0(1):=26;
PRMTX_7057_.tb2_1(1):=PRMTX_7057_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=PRMTX_7057_.tb2_0(1),
MODULE_ID=PRMTX_7057_.tb2_1(1),
DESCRIPTION='Validaci¿n de atributos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_VALIDATTR_'

 WHERE CONFIGURA_TYPE_ID = PRMTX_7057_.tb2_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (PRMTX_7057_.tb2_0(1),
PRMTX_7057_.tb2_1(1),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.old_tb3_0(4):=121397891;
PRMTX_7057_.tb3_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
PRMTX_7057_.tb3_0(4):=PRMTX_7057_.tb3_0(4);
PRMTX_7057_.old_tb3_1(4):='MO_VALIDATTR_CT26E121397891'
;
PRMTX_7057_.tb3_1(4):=PRMTX_7057_.tb3_0(4);
PRMTX_7057_.tb3_2(4):=PRMTX_7057_.tb2_0(1);
ut_trace.trace('insertando tabla sin fallo: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (PRMTX_7057_.tb3_0(4),
PRMTX_7057_.tb3_1(4),
PRMTX_7057_.tb3_2(4),
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuAlternativa);DAPS_CLASS_SERVICE.ACCKEY(nuAlternativa)'
,
'FLEX'
,
to_date('27-09-2002 08:47:50','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
to_date('14-06-2023 10:58:59','DD-MM-YYYY HH24:MI:SS'),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.old_tb9_0(0):=120195701;
PRMTX_7057_.tb9_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
PRMTX_7057_.tb9_0(0):=PRMTX_7057_.tb9_0(0);
ut_trace.trace('insertando tabla sin fallo: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (PRMTX_7057_.tb9_0(0),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb8_0(1):=105294;
PRMTX_7057_.old_tb8_1(1):=43;
PRMTX_7057_.tb8_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb8_1(1),-1)));
PRMTX_7057_.old_tb8_2(1):=1801;
PRMTX_7057_.tb8_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_2(1),-1)));
PRMTX_7057_.old_tb8_3(1):=null;
PRMTX_7057_.tb8_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_3(1),-1)));
PRMTX_7057_.old_tb8_4(1):=null;
PRMTX_7057_.tb8_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_4(1),-1)));
PRMTX_7057_.tb8_5(1):=PRMTX_7057_.tb7_0(0);
PRMTX_7057_.tb8_7(1):=PRMTX_7057_.tb3_0(4);
PRMTX_7057_.tb8_9(1):=PRMTX_7057_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (1)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=PRMTX_7057_.tb8_0(1),
ENTITY_ID=PRMTX_7057_.tb8_1(1),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb8_2(1),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb8_3(1),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb8_4(1),
PROD_MOTIVE_COMP_ID=PRMTX_7057_.tb8_5(1),
PARENT_ATTRIB_ID=null,
VALID_EXPRESSION_ID=PRMTX_7057_.tb8_7(1),
INIT_EXPRESSION_ID=null,
STATEMENT_ID=PRMTX_7057_.tb8_9(1),
PROCESS_SEQUENCE=1,
DISPLAY_NAME='Alternativa'
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
TAG_NAME='ALTERNATIVA'
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
ATTRI_TECHNICAL_NAME='CLASS_SERVICE_ID'
,
IN_PERSIST='Y'
,
INCLUDED_XML='Y'

 WHERE MOTI_COMP_ATTRIBS_ID = PRMTX_7057_.tb8_0(1);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb8_0(1),
PRMTX_7057_.tb8_1(1),
PRMTX_7057_.tb8_2(1),
PRMTX_7057_.tb8_3(1),
PRMTX_7057_.tb8_4(1),
PRMTX_7057_.tb8_5(1),
null,
PRMTX_7057_.tb8_7(1),
null,
PRMTX_7057_.tb8_9(1),
1,
'Alternativa'
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
'ALTERNATIVA'
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
'CLASS_SERVICE_ID'
,
'Y'
,
'Y'
);
end if;

exception when others then
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb8_0(2):=105295;
PRMTX_7057_.old_tb8_1(2):=43;
PRMTX_7057_.tb8_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb8_1(2),-1)));
PRMTX_7057_.old_tb8_2(2):=456;
PRMTX_7057_.tb8_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_2(2),-1)));
PRMTX_7057_.old_tb8_3(2):=187;
PRMTX_7057_.tb8_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_3(2),-1)));
PRMTX_7057_.old_tb8_4(2):=null;
PRMTX_7057_.tb8_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_4(2),-1)));
PRMTX_7057_.tb8_5(2):=PRMTX_7057_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (2)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=PRMTX_7057_.tb8_0(2),
ENTITY_ID=PRMTX_7057_.tb8_1(2),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb8_2(2),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb8_3(2),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb8_4(2),
PROD_MOTIVE_COMP_ID=PRMTX_7057_.tb8_5(2),
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

 WHERE MOTI_COMP_ATTRIBS_ID = PRMTX_7057_.tb8_0(2);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb8_0(2),
PRMTX_7057_.tb8_1(2),
PRMTX_7057_.tb8_2(2),
PRMTX_7057_.tb8_3(2),
PRMTX_7057_.tb8_4(2),
PRMTX_7057_.tb8_5(2),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb8_0(3):=105296;
PRMTX_7057_.old_tb8_1(3):=43;
PRMTX_7057_.tb8_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb8_1(3),-1)));
PRMTX_7057_.old_tb8_2(3):=696;
PRMTX_7057_.tb8_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_2(3),-1)));
PRMTX_7057_.old_tb8_3(3):=697;
PRMTX_7057_.tb8_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_3(3),-1)));
PRMTX_7057_.old_tb8_4(3):=null;
PRMTX_7057_.tb8_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_4(3),-1)));
PRMTX_7057_.tb8_5(3):=PRMTX_7057_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (3)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=PRMTX_7057_.tb8_0(3),
ENTITY_ID=PRMTX_7057_.tb8_1(3),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb8_2(3),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb8_3(3),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb8_4(3),
PROD_MOTIVE_COMP_ID=PRMTX_7057_.tb8_5(3),
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

 WHERE MOTI_COMP_ATTRIBS_ID = PRMTX_7057_.tb8_0(3);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb8_0(3),
PRMTX_7057_.tb8_1(3),
PRMTX_7057_.tb8_2(3),
PRMTX_7057_.tb8_3(3),
PRMTX_7057_.tb8_4(3),
PRMTX_7057_.tb8_5(3),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb8_0(4):=105297;
PRMTX_7057_.old_tb8_1(4):=43;
PRMTX_7057_.tb8_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(PRMTX_7057_.TBENTITYNAME(NVL(PRMTX_7057_.old_tb8_1(4),-1)));
PRMTX_7057_.old_tb8_2(4):=1026;
PRMTX_7057_.tb8_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_2(4),-1)));
PRMTX_7057_.old_tb8_3(4):=null;
PRMTX_7057_.tb8_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_3(4),-1)));
PRMTX_7057_.old_tb8_4(4):=null;
PRMTX_7057_.tb8_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(PRMTX_7057_.TBENTITYATTRIBUTENAME(NVL(PRMTX_7057_.old_tb8_4(4),-1)));
PRMTX_7057_.tb8_5(4):=PRMTX_7057_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: PS_MOTI_COMP_ATTRIBS fila (4)',1);
UPDATE PS_MOTI_COMP_ATTRIBS SET MOTI_COMP_ATTRIBS_ID=PRMTX_7057_.tb8_0(4),
ENTITY_ID=PRMTX_7057_.tb8_1(4),
ENTITY_ATTRIBUTE_ID=PRMTX_7057_.tb8_2(4),
MIRROR_ENTI_ATTRIB=PRMTX_7057_.tb8_3(4),
PARENT_ATTRIBUTE_ID=PRMTX_7057_.tb8_4(4),
PROD_MOTIVE_COMP_ID=PRMTX_7057_.tb8_5(4),
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

 WHERE MOTI_COMP_ATTRIBS_ID = PRMTX_7057_.tb8_0(4);
if not (sql%found) then
INSERT INTO PS_MOTI_COMP_ATTRIBS(MOTI_COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,PROD_MOTIVE_COMP_ID,PARENT_ATTRIB_ID,VALID_EXPRESSION_ID,INIT_EXPRESSION_ID,STATEMENT_ID,PROCESS_SEQUENCE,DISPLAY_NAME,DISPLAY_ORDER,INCLUDED_VAL_DOC,HEADER_TAG_XML,USED_ASSIGNATION,REQUIRED,TAG_NAME,GROUP_ATTRIBUTE_TYPE,INSTANCE_AMOUNT,MODULE,PROCESS_WITH_XML,ACTIVE,ENTITY_NAME,ATTRI_TECHNICAL_NAME,IN_PERSIST,INCLUDED_XML) 
VALUES (PRMTX_7057_.tb8_0(4),
PRMTX_7057_.tb8_1(4),
PRMTX_7057_.tb8_2(4),
PRMTX_7057_.tb8_3(4),
PRMTX_7057_.tb8_4(4),
PRMTX_7057_.tb8_5(4),
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
PRMTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;

PRMTX_7057_.tb10_0(0):=100293;
PRMTX_7057_.tb10_1(0):=PRMTX_7057_.tb0_0(0);
PRMTX_7057_.tb10_2(0):=PRMTX_7057_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: PS_PRD_MOTIV_PACKAGE fila (0)',1);
UPDATE PS_PRD_MOTIV_PACKAGE SET PRD_MOTIV_PACKAGE_ID=PRMTX_7057_.tb10_0(0),
PRODUCT_MOTIVE_ID=PRMTX_7057_.tb10_1(0),
PRODUCT_TYPE_ID=PRMTX_7057_.tb10_2(0),
PACKAGE_TYPE_ID=587,
MIN_MOTIVE_COMP=1,
MAX_MOTIVE_COMP=1,
SEQUENCE_NUMBER=2
 WHERE PRD_MOTIV_PACKAGE_ID = PRMTX_7057_.tb10_0(0);
if not (sql%found) then
INSERT INTO PS_PRD_MOTIV_PACKAGE(PRD_MOTIV_PACKAGE_ID,PRODUCT_MOTIVE_ID,PRODUCT_TYPE_ID,PACKAGE_TYPE_ID,MIN_MOTIVE_COMP,MAX_MOTIVE_COMP,SEQUENCE_NUMBER) 
VALUES (PRMTX_7057_.tb10_0(0),
PRMTX_7057_.tb10_1(0),
PRMTX_7057_.tb10_2(0),
587,
1,
1,
2);
end if;

exception when others then
PRMTX_7057_.blProcessStatus := false;
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

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;


ps_bspscps_mgr.ResetServSaleConf(sbSuccess, nuErrCode, sbErrMssg);
FOR rc in PRMTX_7057_.cuProdMot LOOP
PS_BSPSCRE_MGR.SetProdMotiveConf(rc.product_motive_id, sbSuccess, nuErrCode, sbErrMssg);
END LOOP;
if(nvl(sbSuccess, ge_boconstants.csbNO) != ge_boconstants.csbYES)then
Raise_application_error(-20101, 'No se pudo generar la información de Configuración');
end if;

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
nuIndex := PRMTX_7057_.tbExpressionsId.first;
while (nuIndex is not null) LOOP
BEGIN
 ut_trace.trace('Regla a borrar: ' || PRMTX_7057_.tbExpressionsId(nuIndex),1);
 Delete from gr_config_expression where Config_Expression_Id = PRMTX_7057_.tbExpressionsId(nuIndex);
EXCEPTION when others then
ut_trace.trace('- No se borra la regla (' || PRMTX_7057_.tbExpressionsId(nuIndex) || '): ' || sqlerrm,1);
END;
nuIndex := PRMTX_7057_.tbExpressionsId.next(nuIndex);
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

if (not PRMTX_7057_.blProcessStatus) then
 return;
end if;
nuRowProcess:=PRMTX_7057_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| PRMTX_7057_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(PRMTX_7057_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| PRMTX_7057_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := PRMTX_7057_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
PRMTX_7057_.blProcessStatus := false;
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
 nuIndex := PRMTX_7057_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || PRMTX_7057_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(PRMTX_7057_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(PRMTX_7057_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(PRMTX_7057_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || PRMTX_7057_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || PRMTX_7057_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := PRMTX_7057_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('PRMTX_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:PRMTX_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('PCCTX_7057_',
'CREATE OR REPLACE PACKAGE PCCTX_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyPS_PROCESS_COMPTYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROCESS_COMPTYPERowId tyPS_PROCESS_COMPTYPERowId;type tyPS_MOTIVE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_MOTIVE_TYPERowId tyPS_MOTIVE_TYPERowId; ' || chr(10) ||
'END PCCTX_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:PCCTX_7057_******************************'); END;
/


DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_MOTIVE_TYPE WHERE (MOTIVE_TYPE_ID) in (SELECT MOTIVE_TYPE_ID FROM PS_PROCESS_COMPTYPE WHERE component_type_id in
(
SELECT distinct ps_prod_motive_comp.component_type_id
FROM ps_prod_composition, ps_prod_motive_comp
WHERE ps_prod_composition.product_type_id= 7057
AND   ps_prod_composition.IS_main = 'Y'
AND ps_prod_composition.product_motive_id = ps_prod_motive_comp.product_motive_id
)
);
BEGIN 

if (not PCCTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_MOTIVE_TYPE',1);
for rcData in cuLoadTemporaryTable loop
PCCTX_7057_.tbPS_MOTIVE_TYPERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
PCCTX_7057_.blProcessStatus := false;
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
FROM PS_PROCESS_COMPTYPE WHERE component_type_id in
(
SELECT distinct ps_prod_motive_comp.component_type_id
FROM ps_prod_composition, ps_prod_motive_comp
WHERE ps_prod_composition.product_type_id= 7057
AND   ps_prod_composition.IS_main = 'Y'
AND ps_prod_composition.product_motive_id = ps_prod_motive_comp.product_motive_id
)
;
nuIndex binary_integer;
BEGIN

if (not PCCTX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROCESS_COMPTYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROCESS_COMPTYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
PCCTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not PCCTX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_MOTIVE_TYPE',1);
nuVarcharIndex:=PCCTX_7057_.tbPS_MOTIVE_TYPERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_MOTIVE_TYPE where rowid = PCCTX_7057_.tbPS_MOTIVE_TYPERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
PCCTX_7057_.tbPS_MOTIVE_TYPERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := PCCTX_7057_.tbPS_MOTIVE_TYPERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
PCCTX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('PCCTX_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:PCCTX_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CSCX_7057_',
'CREATE OR REPLACE PACKAGE CSCX_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyPS_CLASS_SERVIC_COMPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_CLASS_SERVIC_COMPRowId tyPS_CLASS_SERVIC_COMPRowId;type tyPS_CLASS_SERVICERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_CLASS_SERVICERowId tyPS_CLASS_SERVICERowId; ' || chr(10) ||
'END CSCX_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CSCX_7057_******************************'); END;
/


DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM PS_CLASS_SERVICE WHERE (CLASS_SERVICE_ID) in (SELECT CLASS_SERVICE_ID FROM PS_CLASS_SERVIC_COMP WHERE component_type_id in
(
SELECT component_type_id
FROM ps_prod_motive_comp
WHERE product_motive_id in
(
SELECT product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
)
)
);
BEGIN 

if (not CSCX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla PS_CLASS_SERVICE',1);
for rcData in cuLoadTemporaryTable loop
CSCX_7057_.tbPS_CLASS_SERVICERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CSCX_7057_.blProcessStatus := false;
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
FROM PS_CLASS_SERVIC_COMP WHERE component_type_id in
(
SELECT component_type_id
FROM ps_prod_motive_comp
WHERE product_motive_id in
(
SELECT product_motive_id
FROM ps_prod_composition
WHERE product_type_id = 7057
)
)
;
nuIndex binary_integer;
BEGIN

if (not CSCX_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_CLASS_SERVIC_COMP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_CLASS_SERVIC_COMP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
CSCX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CSCX_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria PS_CLASS_SERVICE',1);
nuVarcharIndex:=CSCX_7057_.tbPS_CLASS_SERVICERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from PS_CLASS_SERVICE where rowid = CSCX_7057_.tbPS_CLASS_SERVICERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
CSCX_7057_.tbPS_CLASS_SERVICERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := CSCX_7057_.tbPS_CLASS_SERVICERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
CSCX_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CSCX_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CSCX_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXAD_7057_',
'CREATE OR REPLACE PACKAGE EXAD_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyPS_PROD_ENTITY_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbPS_PROD_ENTITY_TYPERowId tyPS_PROD_ENTITY_TYPERowId;type ty0_0 is table of PS_PROD_ENTITY_TYPE.PROD_ENTITY_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of PS_PROD_ENTITY_TYPE.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END EXAD_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXAD_7057_******************************'); END;
/


BEGIN 
   EXAD_7057_.tbEntityName(-1) := 'NULL';
   EXAD_7057_.tbEntityAttributeName(-1) := 'NULL';

   EXAD_7057_.tbEntityName(2002) := 'PS_COMPONENT_TYPE';
END; 
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM PS_PROD_ENTITY_TYPE WHERE ENTITY_ID = 2002 AND ENTITY_VALUE in (SELECT component_type_id FROM ps_prod_motive_comp WHERE product_motive_id in(
SELECT product_motive_id FROM ps_prd_motiv_package WHERE product_type_id = 7057 AND PACKAGE_type_id = ps_boconfigurator_ds.fnugetsalespacktype));
nuIndex binary_integer;
BEGIN

if (not EXAD_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla PS_PROD_ENTITY_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM PS_PROD_ENTITY_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXAD_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXAD_7057_.blProcessStatus) then
 return;
end if;

EXAD_7057_.tb0_0(0):=2106;
EXAD_7057_.old_tb0_1(0):=2002;
EXAD_7057_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(EXAD_7057_.TBENTITYNAME(NVL(EXAD_7057_.old_tb0_1(0),-1)));
ut_trace.trace('Actualizar o insertar tabla: PS_PROD_ENTITY_TYPE fila (0)',1);
UPDATE PS_PROD_ENTITY_TYPE SET PROD_ENTITY_TYPE_ID=EXAD_7057_.tb0_0(0),
ENTITY_ID=EXAD_7057_.tb0_1(0),
ENTITY_VALUE=7104,
DESCRIPTION='Energia Solar '

 WHERE PROD_ENTITY_TYPE_ID = EXAD_7057_.tb0_0(0);
if not (sql%found) then
INSERT INTO PS_PROD_ENTITY_TYPE(PROD_ENTITY_TYPE_ID,ENTITY_ID,ENTITY_VALUE,DESCRIPTION) 
VALUES (EXAD_7057_.tb0_0(0),
EXAD_7057_.tb0_1(0),
7104,
'Energia Solar '
);
end if;

exception when others then
EXAD_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXAD_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXAD_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('SVCFG_7057_',
'CREATE OR REPLACE PACKAGE SVCFG_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_CONFIG_COMPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIG_COMPRowId tyGI_CONFIG_COMPRowId;type tyGI_COMPOSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITIONRowId tyGI_COMPOSITIONRowId;type tyGI_FRAMERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_FRAMERowId tyGI_FRAMERowId;type tyGI_COMP_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_ATTRIBSRowId tyGI_COMP_ATTRIBSRowId;type tyGI_COMP_FRAME_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_FRAME_ATTRIBRowId tyGI_COMP_FRAME_ATTRIBRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type ty0_0 is table of GI_COMPOSITION.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of GI_COMPOSITION.EXTERNAL_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty0_2 is table of GI_COMPOSITION.ENTITY_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2;type ty0_3 is table of GI_COMPOSITION.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_3 ty0_3; ' || chr(10) ||
'tb0_3 ty0_3;type ty0_4 is table of GI_COMPOSITION.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_4 ty0_4; ' || chr(10) ||
'tb0_4 ty0_4;type ty1_0 is table of GI_CONFIG_COMP.CONFIG_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GI_CONFIG_COMP.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GI_CONFIG_COMP.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty1_3 is table of GI_CONFIG_COMP.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_3 ty1_3; ' || chr(10) ||
'tb1_3 ty1_3;type ty2_0 is table of GI_COMP_ATTRIBS.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of GI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_3 is table of GI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb2_3 ty2_3; ' || chr(10) ||
'tb2_3 ty2_3;type ty2_4 is table of GI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_4 ty2_4; ' || chr(10) ||
'tb2_4 ty2_4;type ty2_5 is table of GI_COMP_ATTRIBS.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty2_6 is table of GI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_6 ty2_6; ' || chr(10) ||
'tb2_6 ty2_6;type ty2_7 is table of GI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_7 ty2_7; ' || chr(10) ||
'tb2_7 ty2_7;type ty2_8 is table of GI_COMP_ATTRIBS.SELECT_STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_8 ty2_8; ' || chr(10) ||
'tb2_8 ty2_8;type ty3_0 is table of GI_FRAME.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GI_FRAME.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GI_FRAME.AFTER_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GI_FRAME.BEFORE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of GI_COMP_FRAME_ATTRIB.COMP_FRAME_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GI_COMP_FRAME_ATTRIB.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of GI_COMP_FRAME_ATTRIB.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of GI_COMP_FRAME_ATTRIB.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty4_4 is table of GI_COMP_FRAME_ATTRIB.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_4 ty4_4; ' || chr(10) ||
'tb4_4 ty4_4;cnuSalesPackage constant ps_package_type.package_type_id%type := ps_boconfigurator_ds.fnugetsalespacktype; ' || chr(10) ||
'cnuSalesConfig constant gi_config.config_id%type := gi_boconfig.fnuGetConfig(2012, cnuSalesPackage, 4); ' || chr(10) ||
'cnuCommonComposition  gi_composition.composition_id%type; ' || chr(10) ||
'CURSOR  cuCompositions IS ' || chr(10) ||
'SELECT  rowid ' || chr(10) ||
'FROM    gi_composition ' || chr(10) ||
'WHERE   composition_id in ' || chr(10) ||
'    ( ' || chr(10) ||
'        SELECT  composition_id ' || chr(10) ||
'        FROM    gi_config_comp ' || chr(10) ||
'        WHERE   config_id = cnuSalesConfig ' || chr(10) ||
'        AND     external_id = 7057 ' || chr(10) ||
'        AND     composition_id != cnuCommonComposition ' || chr(10) ||
'    ); ' || chr(10) ||
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
'END SVCFG_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:SVCFG_7057_******************************'); END;
/

DECLARE
nuCantidad  number;
cursor cuValidateCompositions is
SELECT  count(composition_id)
FROM    gi_composition
WHERE   rownum <= 2
AND     CONFIG_ID = SVCFG_7057_.cnuSalesConfig;
cursor cuValidateConfigs is
SELECT  count(config_id)
FROM    gi_config
WHERE   config_type_id = 4
AND     entity_root_id = 2012
AND     external_root_id = SVCFG_7057_.cnuSalesPackage
AND     rownum <= 2;
cursor cuGetComposition is
    SELECT  composition_id
    FROM    gi_composition
    WHERE   config_id = SVCFG_7057_.cnuSalesConfig;
BEGIN
ut_trace.trace('Inicia BeforeScript para GI de Producto', 7);

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
open cuValidateConfigs;
fetch cuValidateConfigs into nuCantidad;
close cuValidateConfigs;
ut_trace.trace('Se validó cantidad de configuraciones para encabezado. Total: ' || nuCantidad, 7);
if(nuCantidad > 1)then
Raise_application_error(-20101, 'Existe más de una configuración para el encabezado de la solicitud de venta');
end if;
open cuValidateCompositions;
fetch cuValidateCompositions into nuCantidad;
close cuValidateCompositions;
ut_trace.trace('Se validó cantidad de composiciones de encabezado. Total: ' || nuCantidad, 7);
if( nuCantidad > 1 )then
    Raise_application_error(-20101, 'Existe más de una composición configurada para el encabezado');
end if;
OPEN cuGetComposition;
FETCH cuGetComposition into SVCFG_7057_.cnuCommonComposition;
CLOSE cuGetComposition;
ut_trace.trace('Se obtuvo la composición['||SVCFG_7057_.cnuCommonComposition||']', 7);
ut_trace.trace('Se cargan las composiciones en memoria', 7);
open SVCFG_7057_.cuCompositions;
fetch SVCFG_7057_.cuCompositions bulk collect INTO SVCFG_7057_.tbCompositions;
close SVCFG_7057_.cuCompositions;

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN 
   SVCFG_7057_.tbEntityName(-1) := 'NULL';
   SVCFG_7057_.tbEntityAttributeName(-1) := 'NULL';

   SVCFG_7057_.tbEntityName(2012) := 'PS_PACKAGE_TYPE';
   SVCFG_7057_.tbEntityName(2013) := 'PS_PRODUCT_MOTIVE';
   SVCFG_7057_.tbEntityName(2014) := 'PS_PROD_MOTIVE_COMP';
   SVCFG_7057_.tbEntityName(2042) := 'PS_MOTI_COMP_ATTRIBS';
   SVCFG_7057_.tbEntityName(3334) := 'PS_PROD_MOTI_ATTRIB';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   SVCFG_7057_.tbEntityName(14) := 'MO_COMMENT';
   SVCFG_7057_.tbEntityAttributeName(243) := 'MO_COMMENT@COMMENT_';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   SVCFG_7057_.tbEntityName(68) := 'MO_PROCESS';
   SVCFG_7057_.tbEntityAttributeName(703) := 'MO_PROCESS@COMMENTS';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   SVCFG_7057_.tbEntityName(17) := 'MO_PACKAGES';
   SVCFG_7057_.tbEntityAttributeName(255) := 'MO_PACKAGES@PACKAGE_ID';
   SVCFG_7057_.tbEntityName(17) := 'MO_PACKAGES';
   SVCFG_7057_.tbEntityAttributeName(257) := 'MO_PACKAGES@CUST_CARE_REQUES_NUM';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(697) := 'MO_MOTIVE@PRODUCT_MOTIVE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(187) := 'MO_MOTIVE@MOTIVE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(2641) := 'MO_MOTIVE@CREDIT_LIMIT';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(191) := 'MO_MOTIVE@MOTIVE_TYPE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(322) := 'MO_MOTIVE@PARTIAL_FLAG';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(189) := 'MO_MOTIVE@CUST_CARE_REQUES_NUM';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(498) := 'MO_MOTIVE@ATTENTION_DATE';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(524) := 'MO_MOTIVE@MOTIVE_STATUS_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(4011) := 'MO_MOTIVE@SERVICE_NUMBER';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(456) := 'MO_COMPONENT@MOTIVE_ID';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(338) := 'MO_COMPONENT@COMPONENT_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(203) := 'MO_MOTIVE@PRIORITY';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(202) := 'MO_MOTIVE@PROV_FINAL_DATE';
   SVCFG_7057_.tbEntityName(14) := 'MO_COMMENT';
   SVCFG_7057_.tbEntityAttributeName(243) := 'MO_COMMENT@COMMENT_';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(50001324) := 'MO_MOTIVE@GEOGRAP_LOCATION_ID';
   SVCFG_7057_.tbEntityName(68) := 'MO_PROCESS';
   SVCFG_7057_.tbEntityAttributeName(703) := 'MO_PROCESS@COMMENTS';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(220) := 'MO_MOTIVE@DISTRIBUT_ADMIN_ID';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(696) := 'MO_COMPONENT@PRODUCT_MOTIVE_ID';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(1026) := 'MO_COMPONENT@SERVICE_DATE';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(213) := 'MO_MOTIVE@PACKAGE_ID';
   SVCFG_7057_.tbEntityName(43) := 'MO_COMPONENT';
   SVCFG_7057_.tbEntityAttributeName(1801) := 'MO_COMPONENT@CLASS_SERVICE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(201) := 'MO_MOTIVE@PROV_INITIAL_DATE';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(192) := 'MO_MOTIVE@PRODUCT_TYPE_ID';
   SVCFG_7057_.tbEntityName(8) := 'MO_MOTIVE';
   SVCFG_7057_.tbEntityAttributeName(11403) := 'MO_MOTIVE@SUBSCRIPTION_ID';
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
WHERE   external_id = 7057
AND     config_id = SVCFG_7057_.cnuSalesConfig
);
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  SVCFG_7057_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057) AND COMPOSITION_ID != (SELECT composition_id from GI_COMPOSITION WHERE config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4)));

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057) AND COMPOSITION_ID != (SELECT composition_id from GI_COMPOSITION WHERE config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4));

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057) AND COMPOSITION_ID != (SELECT composition_id from GI_COMPOSITION WHERE config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4)));
BEGIN 

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057) AND COMPOSITION_ID != (SELECT composition_id from GI_COMPOSITION WHERE config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4)));
BEGIN 

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057) AND COMPOSITION_ID != (SELECT composition_id from GI_COMPOSITION WHERE config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4)));

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057) AND COMPOSITION_ID != (SELECT composition_id from GI_COMPOSITION WHERE config_id = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4));

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := SVCFG_7057_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE CONFIG_ID = gi_boconfig.fnuGetConfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4) AND external_id = 7057;

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb0_0(0):=1020949;
SVCFG_7057_.tb0_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
SVCFG_7057_.tb0_0(0):=SVCFG_7057_.tb0_0(0);
SVCFG_7057_.old_tb0_1(0):=587;
SVCFG_7057_.tb0_1(0):=SVCFG_7057_.old_tb0_1(0);
SVCFG_7057_.old_tb0_2(0):=2012;
SVCFG_7057_.tb0_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb0_2(0),-1)));
SVCFG_7057_.old_tb0_3(0):=6469;
SVCFG_7057_.tb0_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb0_2(0),-1))), SVCFG_7057_.old_tb0_1(0), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (SVCFG_7057_.tb0_0(0),
SVCFG_7057_.tb0_1(0),
SVCFG_7057_.tb0_2(0),
SVCFG_7057_.tb0_3(0),
null,
'PAQUETE'
,
1,
1,
4);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb1_0(0):=100026097;
SVCFG_7057_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
SVCFG_7057_.tb1_0(0):=SVCFG_7057_.tb1_0(0);
SVCFG_7057_.old_tb1_1(0):=6469;
SVCFG_7057_.tb1_1(0):=GI_BOCONFIG.FNUGETCONFIG( 2012, PS_BOCONFIGURATOR_DS.FNUGETSALESPACKTYPE, 4);
SVCFG_7057_.tb1_2(0):=SVCFG_7057_.tb0_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (SVCFG_7057_.tb1_0(0),
SVCFG_7057_.tb1_1(0),
SVCFG_7057_.tb1_2(0),
null,
7057,
1,
1,
1);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb0_0(1):=1066180;
SVCFG_7057_.tb0_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
SVCFG_7057_.tb0_0(1):=SVCFG_7057_.tb0_0(1);
SVCFG_7057_.old_tb0_1(1):=100300;
SVCFG_7057_.tb0_1(1):=SVCFG_7057_.old_tb0_1(1);
SVCFG_7057_.old_tb0_2(1):=2013;
SVCFG_7057_.tb0_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb0_2(1),-1)));
SVCFG_7057_.old_tb0_3(1):=null;
SVCFG_7057_.tb0_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb0_2(1),-1))), SVCFG_7057_.old_tb0_1(1), 4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (SVCFG_7057_.tb0_0(1),
SVCFG_7057_.tb0_1(1),
SVCFG_7057_.tb0_2(1),
SVCFG_7057_.tb0_3(1),
null,
'M_INSTALACION_DE_ENERGIA_SOLAR_100300'
,
1,
1,
4);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb1_0(1):=100026098;
SVCFG_7057_.tb1_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
SVCFG_7057_.tb1_0(1):=SVCFG_7057_.tb1_0(1);
SVCFG_7057_.old_tb1_1(1):=6469;
SVCFG_7057_.tb1_1(1):=GI_BOCONFIG.FNUGETCONFIG( 2012, PS_BOCONFIGURATOR_DS.FNUGETSALESPACKTYPE, 4);
SVCFG_7057_.tb1_2(1):=SVCFG_7057_.tb0_0(1);
SVCFG_7057_.tb1_3(1):=SVCFG_7057_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (SVCFG_7057_.tb1_0(1),
SVCFG_7057_.tb1_1(1),
SVCFG_7057_.tb1_2(1),
SVCFG_7057_.tb1_3(1),
7057,
2,
1,
1);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb0_0(2):=1066181;
SVCFG_7057_.tb0_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
SVCFG_7057_.tb0_0(2):=SVCFG_7057_.tb0_0(2);
SVCFG_7057_.old_tb0_1(2):=10340;
SVCFG_7057_.tb0_1(2):=SVCFG_7057_.old_tb0_1(2);
SVCFG_7057_.old_tb0_2(2):=2014;
SVCFG_7057_.tb0_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb0_2(2),-1)));
SVCFG_7057_.old_tb0_3(2):=null;
SVCFG_7057_.tb0_3(2):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb0_2(2),-1))), SVCFG_7057_.old_tb0_1(2), 4);
SVCFG_7057_.tb0_4(2):=SVCFG_7057_.tb0_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (SVCFG_7057_.tb0_0(2),
SVCFG_7057_.tb0_1(2),
SVCFG_7057_.tb0_2(2),
SVCFG_7057_.tb0_3(2),
SVCFG_7057_.tb0_4(2),
'C_ENERGIA_SOLAR_10340'
,
1,
1,
4);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb1_0(2):=100026099;
SVCFG_7057_.tb1_0(2):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
SVCFG_7057_.tb1_0(2):=SVCFG_7057_.tb1_0(2);
SVCFG_7057_.old_tb1_1(2):=6469;
SVCFG_7057_.tb1_1(2):=GI_BOCONFIG.FNUGETCONFIG( 2012, PS_BOCONFIGURATOR_DS.FNUGETSALESPACKTYPE, 4);
SVCFG_7057_.tb1_2(2):=SVCFG_7057_.tb0_0(2);
SVCFG_7057_.tb1_3(2):=SVCFG_7057_.tb1_0(1);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (2)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (SVCFG_7057_.tb1_0(2),
SVCFG_7057_.tb1_1(2),
SVCFG_7057_.tb1_2(2),
SVCFG_7057_.tb1_3(2),
7057,
3,
1,
1);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(0):=1149190;
SVCFG_7057_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(0):=SVCFG_7057_.tb2_0(0);
SVCFG_7057_.old_tb2_1(0):=2042;
SVCFG_7057_.tb2_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(0),-1)));
SVCFG_7057_.old_tb2_2(0):=338;
SVCFG_7057_.tb2_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(0),-1)));
SVCFG_7057_.old_tb2_3(0):=null;
SVCFG_7057_.tb2_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(0),-1)));
SVCFG_7057_.old_tb2_4(0):=null;
SVCFG_7057_.tb2_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(0),-1)));
SVCFG_7057_.tb2_5(0):=SVCFG_7057_.tb1_2(2);
SVCFG_7057_.old_tb2_6(0):=121397890;
SVCFG_7057_.tb2_6(0):=NULL;
SVCFG_7057_.old_tb2_7(0):=null;
SVCFG_7057_.tb2_7(0):=NULL;
SVCFG_7057_.old_tb2_8(0):=null;
SVCFG_7057_.tb2_8(0):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(0),
SVCFG_7057_.tb2_1(0),
SVCFG_7057_.tb2_2(0),
SVCFG_7057_.tb2_3(0),
SVCFG_7057_.tb2_4(0),
SVCFG_7057_.tb2_5(0),
SVCFG_7057_.tb2_6(0),
SVCFG_7057_.tb2_7(0),
SVCFG_7057_.tb2_8(0),
null,
105293,
0,
'Identificador del Componente Registro Componente'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb3_0(0):=2599;
SVCFG_7057_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
SVCFG_7057_.tb3_0(0):=SVCFG_7057_.tb3_0(0);
SVCFG_7057_.tb3_1(0):=SVCFG_7057_.tb1_2(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (SVCFG_7057_.tb3_0(0),
SVCFG_7057_.tb3_1(0),
null,
null,
'FRAME-C_ENERGIA_SOLAR_10340-1066167'
,
3);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(0):=1604663;
SVCFG_7057_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(0):=SVCFG_7057_.tb4_0(0);
SVCFG_7057_.old_tb4_1(0):=338;
SVCFG_7057_.tb4_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(0),-1)));
SVCFG_7057_.old_tb4_2(0):=null;
SVCFG_7057_.tb4_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(0),-1)));
SVCFG_7057_.tb4_3(0):=SVCFG_7057_.tb3_0(0);
SVCFG_7057_.tb4_4(0):=SVCFG_7057_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(0),
SVCFG_7057_.tb4_1(0),
SVCFG_7057_.tb4_2(0),
SVCFG_7057_.tb4_3(0),
SVCFG_7057_.tb4_4(0),
'C'
,
'Y'
,
0,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(1):=1149191;
SVCFG_7057_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(1):=SVCFG_7057_.tb2_0(1);
SVCFG_7057_.old_tb2_1(1):=2042;
SVCFG_7057_.tb2_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(1),-1)));
SVCFG_7057_.old_tb2_2(1):=1801;
SVCFG_7057_.tb2_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(1),-1)));
SVCFG_7057_.old_tb2_3(1):=null;
SVCFG_7057_.tb2_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(1),-1)));
SVCFG_7057_.old_tb2_4(1):=null;
SVCFG_7057_.tb2_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(1),-1)));
SVCFG_7057_.tb2_5(1):=SVCFG_7057_.tb1_2(2);
SVCFG_7057_.old_tb2_6(1):=null;
SVCFG_7057_.tb2_6(1):=NULL;
SVCFG_7057_.old_tb2_7(1):=121397891;
SVCFG_7057_.tb2_7(1):=NULL;
SVCFG_7057_.old_tb2_8(1):=120195701;
SVCFG_7057_.tb2_8(1):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(1),
SVCFG_7057_.tb2_1(1),
SVCFG_7057_.tb2_2(1),
SVCFG_7057_.tb2_3(1),
SVCFG_7057_.tb2_4(1),
SVCFG_7057_.tb2_5(1),
SVCFG_7057_.tb2_6(1),
SVCFG_7057_.tb2_7(1),
SVCFG_7057_.tb2_8(1),
null,
105294,
1,
'Alternativa'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(1):=1604664;
SVCFG_7057_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(1):=SVCFG_7057_.tb4_0(1);
SVCFG_7057_.old_tb4_1(1):=1801;
SVCFG_7057_.tb4_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(1),-1)));
SVCFG_7057_.old_tb4_2(1):=null;
SVCFG_7057_.tb4_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(1),-1)));
SVCFG_7057_.tb4_3(1):=SVCFG_7057_.tb3_0(0);
SVCFG_7057_.tb4_4(1):=SVCFG_7057_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(1),
SVCFG_7057_.tb4_1(1),
SVCFG_7057_.tb4_2(1),
SVCFG_7057_.tb4_3(1),
SVCFG_7057_.tb4_4(1),
'Y'
,
'Y'
,
1,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(2):=1149192;
SVCFG_7057_.tb2_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(2):=SVCFG_7057_.tb2_0(2);
SVCFG_7057_.old_tb2_1(2):=2042;
SVCFG_7057_.tb2_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(2),-1)));
SVCFG_7057_.old_tb2_2(2):=456;
SVCFG_7057_.tb2_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(2),-1)));
SVCFG_7057_.old_tb2_3(2):=187;
SVCFG_7057_.tb2_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(2),-1)));
SVCFG_7057_.old_tb2_4(2):=null;
SVCFG_7057_.tb2_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(2),-1)));
SVCFG_7057_.tb2_5(2):=SVCFG_7057_.tb1_2(2);
SVCFG_7057_.old_tb2_6(2):=null;
SVCFG_7057_.tb2_6(2):=NULL;
SVCFG_7057_.old_tb2_7(2):=null;
SVCFG_7057_.tb2_7(2):=NULL;
SVCFG_7057_.old_tb2_8(2):=null;
SVCFG_7057_.tb2_8(2):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(2),
SVCFG_7057_.tb2_1(2),
SVCFG_7057_.tb2_2(2),
SVCFG_7057_.tb2_3(2),
SVCFG_7057_.tb2_4(2),
SVCFG_7057_.tb2_5(2),
SVCFG_7057_.tb2_6(2),
SVCFG_7057_.tb2_7(2),
SVCFG_7057_.tb2_8(2),
null,
105295,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(2):=1604665;
SVCFG_7057_.tb4_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(2):=SVCFG_7057_.tb4_0(2);
SVCFG_7057_.old_tb4_1(2):=456;
SVCFG_7057_.tb4_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(2),-1)));
SVCFG_7057_.old_tb4_2(2):=null;
SVCFG_7057_.tb4_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(2),-1)));
SVCFG_7057_.tb4_3(2):=SVCFG_7057_.tb3_0(0);
SVCFG_7057_.tb4_4(2):=SVCFG_7057_.tb2_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(2),
SVCFG_7057_.tb4_1(2),
SVCFG_7057_.tb4_2(2),
SVCFG_7057_.tb4_3(2),
SVCFG_7057_.tb4_4(2),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(3):=1149193;
SVCFG_7057_.tb2_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(3):=SVCFG_7057_.tb2_0(3);
SVCFG_7057_.old_tb2_1(3):=2042;
SVCFG_7057_.tb2_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(3),-1)));
SVCFG_7057_.old_tb2_2(3):=696;
SVCFG_7057_.tb2_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(3),-1)));
SVCFG_7057_.old_tb2_3(3):=697;
SVCFG_7057_.tb2_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(3),-1)));
SVCFG_7057_.old_tb2_4(3):=null;
SVCFG_7057_.tb2_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(3),-1)));
SVCFG_7057_.tb2_5(3):=SVCFG_7057_.tb1_2(2);
SVCFG_7057_.old_tb2_6(3):=null;
SVCFG_7057_.tb2_6(3):=NULL;
SVCFG_7057_.old_tb2_7(3):=null;
SVCFG_7057_.tb2_7(3):=NULL;
SVCFG_7057_.old_tb2_8(3):=null;
SVCFG_7057_.tb2_8(3):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(3),
SVCFG_7057_.tb2_1(3),
SVCFG_7057_.tb2_2(3),
SVCFG_7057_.tb2_3(3),
SVCFG_7057_.tb2_4(3),
SVCFG_7057_.tb2_5(3),
SVCFG_7057_.tb2_6(3),
SVCFG_7057_.tb2_7(3),
SVCFG_7057_.tb2_8(3),
null,
105296,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(3):=1604666;
SVCFG_7057_.tb4_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(3):=SVCFG_7057_.tb4_0(3);
SVCFG_7057_.old_tb4_1(3):=696;
SVCFG_7057_.tb4_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(3),-1)));
SVCFG_7057_.old_tb4_2(3):=null;
SVCFG_7057_.tb4_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(3),-1)));
SVCFG_7057_.tb4_3(3):=SVCFG_7057_.tb3_0(0);
SVCFG_7057_.tb4_4(3):=SVCFG_7057_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(3),
SVCFG_7057_.tb4_1(3),
SVCFG_7057_.tb4_2(3),
SVCFG_7057_.tb4_3(3),
SVCFG_7057_.tb4_4(3),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(4):=1149194;
SVCFG_7057_.tb2_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(4):=SVCFG_7057_.tb2_0(4);
SVCFG_7057_.old_tb2_1(4):=2042;
SVCFG_7057_.tb2_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(4),-1)));
SVCFG_7057_.old_tb2_2(4):=1026;
SVCFG_7057_.tb2_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(4),-1)));
SVCFG_7057_.old_tb2_3(4):=null;
SVCFG_7057_.tb2_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(4),-1)));
SVCFG_7057_.old_tb2_4(4):=null;
SVCFG_7057_.tb2_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(4),-1)));
SVCFG_7057_.tb2_5(4):=SVCFG_7057_.tb1_2(2);
SVCFG_7057_.old_tb2_6(4):=null;
SVCFG_7057_.tb2_6(4):=NULL;
SVCFG_7057_.old_tb2_7(4):=null;
SVCFG_7057_.tb2_7(4):=NULL;
SVCFG_7057_.old_tb2_8(4):=null;
SVCFG_7057_.tb2_8(4):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(4),
SVCFG_7057_.tb2_1(4),
SVCFG_7057_.tb2_2(4),
SVCFG_7057_.tb2_3(4),
SVCFG_7057_.tb2_4(4),
SVCFG_7057_.tb2_5(4),
SVCFG_7057_.tb2_6(4),
SVCFG_7057_.tb2_7(4),
SVCFG_7057_.tb2_8(4),
null,
105297,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(4):=1604667;
SVCFG_7057_.tb4_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(4):=SVCFG_7057_.tb4_0(4);
SVCFG_7057_.old_tb4_1(4):=1026;
SVCFG_7057_.tb4_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(4),-1)));
SVCFG_7057_.old_tb4_2(4):=null;
SVCFG_7057_.tb4_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(4),-1)));
SVCFG_7057_.tb4_3(4):=SVCFG_7057_.tb3_0(0);
SVCFG_7057_.tb4_4(4):=SVCFG_7057_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(4),
SVCFG_7057_.tb4_1(4),
SVCFG_7057_.tb4_2(4),
SVCFG_7057_.tb4_3(4),
SVCFG_7057_.tb4_4(4),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(5):=1149195;
SVCFG_7057_.tb2_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(5):=SVCFG_7057_.tb2_0(5);
SVCFG_7057_.old_tb2_1(5):=3334;
SVCFG_7057_.tb2_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(5),-1)));
SVCFG_7057_.old_tb2_2(5):=187;
SVCFG_7057_.tb2_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(5),-1)));
SVCFG_7057_.old_tb2_3(5):=null;
SVCFG_7057_.tb2_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(5),-1)));
SVCFG_7057_.old_tb2_4(5):=null;
SVCFG_7057_.tb2_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(5),-1)));
SVCFG_7057_.tb2_5(5):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(5):=121397887;
SVCFG_7057_.tb2_6(5):=NULL;
SVCFG_7057_.old_tb2_7(5):=null;
SVCFG_7057_.tb2_7(5):=NULL;
SVCFG_7057_.old_tb2_8(5):=null;
SVCFG_7057_.tb2_8(5):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(5),
SVCFG_7057_.tb2_1(5),
SVCFG_7057_.tb2_2(5),
SVCFG_7057_.tb2_3(5),
SVCFG_7057_.tb2_4(5),
SVCFG_7057_.tb2_5(5),
SVCFG_7057_.tb2_6(5),
SVCFG_7057_.tb2_7(5),
SVCFG_7057_.tb2_8(5),
null,
104221,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb3_0(1):=2600;
SVCFG_7057_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
SVCFG_7057_.tb3_0(1):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb3_1(1):=SVCFG_7057_.tb1_2(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (SVCFG_7057_.tb3_0(1),
SVCFG_7057_.tb3_1(1),
null,
null,
'FRAME-M_INSTALACION_DE_ENERGIA_SOLAR_100300-1066166'
,
2);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(5):=1604668;
SVCFG_7057_.tb4_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(5):=SVCFG_7057_.tb4_0(5);
SVCFG_7057_.old_tb4_1(5):=187;
SVCFG_7057_.tb4_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(5),-1)));
SVCFG_7057_.old_tb4_2(5):=null;
SVCFG_7057_.tb4_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(5),-1)));
SVCFG_7057_.tb4_3(5):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(5):=SVCFG_7057_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(5),
SVCFG_7057_.tb4_1(5),
SVCFG_7057_.tb4_2(5),
SVCFG_7057_.tb4_3(5),
SVCFG_7057_.tb4_4(5),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(6):=1149196;
SVCFG_7057_.tb2_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(6):=SVCFG_7057_.tb2_0(6);
SVCFG_7057_.old_tb2_1(6):=3334;
SVCFG_7057_.tb2_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(6),-1)));
SVCFG_7057_.old_tb2_2(6):=213;
SVCFG_7057_.tb2_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(6),-1)));
SVCFG_7057_.old_tb2_3(6):=255;
SVCFG_7057_.tb2_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(6),-1)));
SVCFG_7057_.old_tb2_4(6):=null;
SVCFG_7057_.tb2_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(6),-1)));
SVCFG_7057_.tb2_5(6):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(6):=null;
SVCFG_7057_.tb2_6(6):=NULL;
SVCFG_7057_.old_tb2_7(6):=null;
SVCFG_7057_.tb2_7(6):=NULL;
SVCFG_7057_.old_tb2_8(6):=null;
SVCFG_7057_.tb2_8(6):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(6),
SVCFG_7057_.tb2_1(6),
SVCFG_7057_.tb2_2(6),
SVCFG_7057_.tb2_3(6),
SVCFG_7057_.tb2_4(6),
SVCFG_7057_.tb2_5(6),
SVCFG_7057_.tb2_6(6),
SVCFG_7057_.tb2_7(6),
SVCFG_7057_.tb2_8(6),
null,
104222,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(6):=1604669;
SVCFG_7057_.tb4_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(6):=SVCFG_7057_.tb4_0(6);
SVCFG_7057_.old_tb4_1(6):=213;
SVCFG_7057_.tb4_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(6),-1)));
SVCFG_7057_.old_tb4_2(6):=null;
SVCFG_7057_.tb4_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(6),-1)));
SVCFG_7057_.tb4_3(6):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(6):=SVCFG_7057_.tb2_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(6),
SVCFG_7057_.tb4_1(6),
SVCFG_7057_.tb4_2(6),
SVCFG_7057_.tb4_3(6),
SVCFG_7057_.tb4_4(6),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(7):=1149197;
SVCFG_7057_.tb2_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(7):=SVCFG_7057_.tb2_0(7);
SVCFG_7057_.old_tb2_1(7):=3334;
SVCFG_7057_.tb2_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(7),-1)));
SVCFG_7057_.old_tb2_2(7):=203;
SVCFG_7057_.tb2_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(7),-1)));
SVCFG_7057_.old_tb2_3(7):=null;
SVCFG_7057_.tb2_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(7),-1)));
SVCFG_7057_.old_tb2_4(7):=null;
SVCFG_7057_.tb2_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(7),-1)));
SVCFG_7057_.tb2_5(7):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(7):=121397888;
SVCFG_7057_.tb2_6(7):=NULL;
SVCFG_7057_.old_tb2_7(7):=null;
SVCFG_7057_.tb2_7(7):=NULL;
SVCFG_7057_.old_tb2_8(7):=null;
SVCFG_7057_.tb2_8(7):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(7),
SVCFG_7057_.tb2_1(7),
SVCFG_7057_.tb2_2(7),
SVCFG_7057_.tb2_3(7),
SVCFG_7057_.tb2_4(7),
SVCFG_7057_.tb2_5(7),
SVCFG_7057_.tb2_6(7),
SVCFG_7057_.tb2_7(7),
SVCFG_7057_.tb2_8(7),
null,
104223,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(7):=1604670;
SVCFG_7057_.tb4_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(7):=SVCFG_7057_.tb4_0(7);
SVCFG_7057_.old_tb4_1(7):=203;
SVCFG_7057_.tb4_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(7),-1)));
SVCFG_7057_.old_tb4_2(7):=null;
SVCFG_7057_.tb4_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(7),-1)));
SVCFG_7057_.tb4_3(7):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(7):=SVCFG_7057_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(7),
SVCFG_7057_.tb4_1(7),
SVCFG_7057_.tb4_2(7),
SVCFG_7057_.tb4_3(7),
SVCFG_7057_.tb4_4(7),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(8):=1149198;
SVCFG_7057_.tb2_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(8):=SVCFG_7057_.tb2_0(8);
SVCFG_7057_.old_tb2_1(8):=3334;
SVCFG_7057_.tb2_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(8),-1)));
SVCFG_7057_.old_tb2_2(8):=322;
SVCFG_7057_.tb2_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(8),-1)));
SVCFG_7057_.old_tb2_3(8):=null;
SVCFG_7057_.tb2_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(8),-1)));
SVCFG_7057_.old_tb2_4(8):=null;
SVCFG_7057_.tb2_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(8),-1)));
SVCFG_7057_.tb2_5(8):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(8):=121397889;
SVCFG_7057_.tb2_6(8):=NULL;
SVCFG_7057_.old_tb2_7(8):=null;
SVCFG_7057_.tb2_7(8):=NULL;
SVCFG_7057_.old_tb2_8(8):=null;
SVCFG_7057_.tb2_8(8):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(8),
SVCFG_7057_.tb2_1(8),
SVCFG_7057_.tb2_2(8),
SVCFG_7057_.tb2_3(8),
SVCFG_7057_.tb2_4(8),
SVCFG_7057_.tb2_5(8),
SVCFG_7057_.tb2_6(8),
SVCFG_7057_.tb2_7(8),
SVCFG_7057_.tb2_8(8),
null,
104224,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(8):=1604671;
SVCFG_7057_.tb4_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(8):=SVCFG_7057_.tb4_0(8);
SVCFG_7057_.old_tb4_1(8):=322;
SVCFG_7057_.tb4_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(8),-1)));
SVCFG_7057_.old_tb4_2(8):=null;
SVCFG_7057_.tb4_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(8),-1)));
SVCFG_7057_.tb4_3(8):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(8):=SVCFG_7057_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(8),
SVCFG_7057_.tb4_1(8),
SVCFG_7057_.tb4_2(8),
SVCFG_7057_.tb4_3(8),
SVCFG_7057_.tb4_4(8),
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(9):=1149199;
SVCFG_7057_.tb2_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(9):=SVCFG_7057_.tb2_0(9);
SVCFG_7057_.old_tb2_1(9):=3334;
SVCFG_7057_.tb2_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(9),-1)));
SVCFG_7057_.old_tb2_2(9):=2641;
SVCFG_7057_.tb2_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(9),-1)));
SVCFG_7057_.old_tb2_3(9):=null;
SVCFG_7057_.tb2_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(9),-1)));
SVCFG_7057_.old_tb2_4(9):=null;
SVCFG_7057_.tb2_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(9),-1)));
SVCFG_7057_.tb2_5(9):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(9):=null;
SVCFG_7057_.tb2_6(9):=NULL;
SVCFG_7057_.old_tb2_7(9):=null;
SVCFG_7057_.tb2_7(9):=NULL;
SVCFG_7057_.old_tb2_8(9):=null;
SVCFG_7057_.tb2_8(9):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(9),
SVCFG_7057_.tb2_1(9),
SVCFG_7057_.tb2_2(9),
SVCFG_7057_.tb2_3(9),
SVCFG_7057_.tb2_4(9),
SVCFG_7057_.tb2_5(9),
SVCFG_7057_.tb2_6(9),
SVCFG_7057_.tb2_7(9),
SVCFG_7057_.tb2_8(9),
null,
104225,
4,
'Límite de Crédito'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(9):=1604672;
SVCFG_7057_.tb4_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(9):=SVCFG_7057_.tb4_0(9);
SVCFG_7057_.old_tb4_1(9):=2641;
SVCFG_7057_.tb4_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(9),-1)));
SVCFG_7057_.old_tb4_2(9):=null;
SVCFG_7057_.tb4_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(9),-1)));
SVCFG_7057_.tb4_3(9):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(9):=SVCFG_7057_.tb2_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(9),
SVCFG_7057_.tb4_1(9),
SVCFG_7057_.tb4_2(9),
SVCFG_7057_.tb4_3(9),
SVCFG_7057_.tb4_4(9),
'C'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(10):=1149200;
SVCFG_7057_.tb2_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(10):=SVCFG_7057_.tb2_0(10);
SVCFG_7057_.old_tb2_1(10):=3334;
SVCFG_7057_.tb2_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(10),-1)));
SVCFG_7057_.old_tb2_2(10):=189;
SVCFG_7057_.tb2_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(10),-1)));
SVCFG_7057_.old_tb2_3(10):=257;
SVCFG_7057_.tb2_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(10),-1)));
SVCFG_7057_.old_tb2_4(10):=null;
SVCFG_7057_.tb2_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(10),-1)));
SVCFG_7057_.tb2_5(10):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(10):=null;
SVCFG_7057_.tb2_6(10):=NULL;
SVCFG_7057_.old_tb2_7(10):=null;
SVCFG_7057_.tb2_7(10):=NULL;
SVCFG_7057_.old_tb2_8(10):=null;
SVCFG_7057_.tb2_8(10):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(10),
SVCFG_7057_.tb2_1(10),
SVCFG_7057_.tb2_2(10),
SVCFG_7057_.tb2_3(10),
SVCFG_7057_.tb2_4(10),
SVCFG_7057_.tb2_5(10),
SVCFG_7057_.tb2_6(10),
SVCFG_7057_.tb2_7(10),
SVCFG_7057_.tb2_8(10),
null,
104226,
5,
'Número Petición Atención al cliente'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(10):=1604673;
SVCFG_7057_.tb4_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(10):=SVCFG_7057_.tb4_0(10);
SVCFG_7057_.old_tb4_1(10):=189;
SVCFG_7057_.tb4_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(10),-1)));
SVCFG_7057_.old_tb4_2(10):=null;
SVCFG_7057_.tb4_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(10),-1)));
SVCFG_7057_.tb4_3(10):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(10):=SVCFG_7057_.tb2_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(10),
SVCFG_7057_.tb4_1(10),
SVCFG_7057_.tb4_2(10),
SVCFG_7057_.tb4_3(10),
SVCFG_7057_.tb4_4(10),
'C'
,
'Y'
,
5,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(11):=1149201;
SVCFG_7057_.tb2_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(11):=SVCFG_7057_.tb2_0(11);
SVCFG_7057_.old_tb2_1(11):=3334;
SVCFG_7057_.tb2_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(11),-1)));
SVCFG_7057_.old_tb2_2(11):=50001324;
SVCFG_7057_.tb2_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(11),-1)));
SVCFG_7057_.old_tb2_3(11):=null;
SVCFG_7057_.tb2_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(11),-1)));
SVCFG_7057_.old_tb2_4(11):=null;
SVCFG_7057_.tb2_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(11),-1)));
SVCFG_7057_.tb2_5(11):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(11):=null;
SVCFG_7057_.tb2_6(11):=NULL;
SVCFG_7057_.old_tb2_7(11):=null;
SVCFG_7057_.tb2_7(11):=NULL;
SVCFG_7057_.old_tb2_8(11):=null;
SVCFG_7057_.tb2_8(11):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(11),
SVCFG_7057_.tb2_1(11),
SVCFG_7057_.tb2_2(11),
SVCFG_7057_.tb2_3(11),
SVCFG_7057_.tb2_4(11),
SVCFG_7057_.tb2_5(11),
SVCFG_7057_.tb2_6(11),
SVCFG_7057_.tb2_7(11),
SVCFG_7057_.tb2_8(11),
null,
104292,
6,
'Ubicación Geográfica'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(11):=1604674;
SVCFG_7057_.tb4_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(11):=SVCFG_7057_.tb4_0(11);
SVCFG_7057_.old_tb4_1(11):=50001324;
SVCFG_7057_.tb4_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(11),-1)));
SVCFG_7057_.old_tb4_2(11):=null;
SVCFG_7057_.tb4_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(11),-1)));
SVCFG_7057_.tb4_3(11):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(11):=SVCFG_7057_.tb2_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(11),
SVCFG_7057_.tb4_1(11),
SVCFG_7057_.tb4_2(11),
SVCFG_7057_.tb4_3(11),
SVCFG_7057_.tb4_4(11),
'C'
,
'Y'
,
6,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(12):=1149202;
SVCFG_7057_.tb2_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(12):=SVCFG_7057_.tb2_0(12);
SVCFG_7057_.old_tb2_1(12):=3334;
SVCFG_7057_.tb2_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(12),-1)));
SVCFG_7057_.old_tb2_2(12):=201;
SVCFG_7057_.tb2_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(12),-1)));
SVCFG_7057_.old_tb2_3(12):=null;
SVCFG_7057_.tb2_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(12),-1)));
SVCFG_7057_.old_tb2_4(12):=null;
SVCFG_7057_.tb2_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(12),-1)));
SVCFG_7057_.tb2_5(12):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(12):=null;
SVCFG_7057_.tb2_6(12):=NULL;
SVCFG_7057_.old_tb2_7(12):=null;
SVCFG_7057_.tb2_7(12):=NULL;
SVCFG_7057_.old_tb2_8(12):=null;
SVCFG_7057_.tb2_8(12):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(12),
SVCFG_7057_.tb2_1(12),
SVCFG_7057_.tb2_2(12),
SVCFG_7057_.tb2_3(12),
SVCFG_7057_.tb2_4(12),
SVCFG_7057_.tb2_5(12),
SVCFG_7057_.tb2_6(12),
SVCFG_7057_.tb2_7(12),
SVCFG_7057_.tb2_8(12),
null,
104293,
7,
'Inicio de Provisionalidad'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(12):=1604675;
SVCFG_7057_.tb4_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(12):=SVCFG_7057_.tb4_0(12);
SVCFG_7057_.old_tb4_1(12):=201;
SVCFG_7057_.tb4_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(12),-1)));
SVCFG_7057_.old_tb4_2(12):=null;
SVCFG_7057_.tb4_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(12),-1)));
SVCFG_7057_.tb4_3(12):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(12):=SVCFG_7057_.tb2_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(12),
SVCFG_7057_.tb4_1(12),
SVCFG_7057_.tb4_2(12),
SVCFG_7057_.tb4_3(12),
SVCFG_7057_.tb4_4(12),
'C'
,
'Y'
,
7,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(13):=1149203;
SVCFG_7057_.tb2_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(13):=SVCFG_7057_.tb2_0(13);
SVCFG_7057_.old_tb2_1(13):=3334;
SVCFG_7057_.tb2_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(13),-1)));
SVCFG_7057_.old_tb2_2(13):=202;
SVCFG_7057_.tb2_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(13),-1)));
SVCFG_7057_.old_tb2_3(13):=null;
SVCFG_7057_.tb2_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(13),-1)));
SVCFG_7057_.old_tb2_4(13):=null;
SVCFG_7057_.tb2_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(13),-1)));
SVCFG_7057_.tb2_5(13):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(13):=null;
SVCFG_7057_.tb2_6(13):=NULL;
SVCFG_7057_.old_tb2_7(13):=null;
SVCFG_7057_.tb2_7(13):=NULL;
SVCFG_7057_.old_tb2_8(13):=null;
SVCFG_7057_.tb2_8(13):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(13),
SVCFG_7057_.tb2_1(13),
SVCFG_7057_.tb2_2(13),
SVCFG_7057_.tb2_3(13),
SVCFG_7057_.tb2_4(13),
SVCFG_7057_.tb2_5(13),
SVCFG_7057_.tb2_6(13),
SVCFG_7057_.tb2_7(13),
SVCFG_7057_.tb2_8(13),
null,
104294,
8,
'Fin de Provisionalidad'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(13):=1604676;
SVCFG_7057_.tb4_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(13):=SVCFG_7057_.tb4_0(13);
SVCFG_7057_.old_tb4_1(13):=202;
SVCFG_7057_.tb4_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(13),-1)));
SVCFG_7057_.old_tb4_2(13):=null;
SVCFG_7057_.tb4_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(13),-1)));
SVCFG_7057_.tb4_3(13):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(13):=SVCFG_7057_.tb2_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(13),
SVCFG_7057_.tb4_1(13),
SVCFG_7057_.tb4_2(13),
SVCFG_7057_.tb4_3(13),
SVCFG_7057_.tb4_4(13),
'C'
,
'Y'
,
8,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(14):=1149204;
SVCFG_7057_.tb2_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(14):=SVCFG_7057_.tb2_0(14);
SVCFG_7057_.old_tb2_1(14):=3334;
SVCFG_7057_.tb2_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(14),-1)));
SVCFG_7057_.old_tb2_2(14):=498;
SVCFG_7057_.tb2_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(14),-1)));
SVCFG_7057_.old_tb2_3(14):=null;
SVCFG_7057_.tb2_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(14),-1)));
SVCFG_7057_.old_tb2_4(14):=null;
SVCFG_7057_.tb2_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(14),-1)));
SVCFG_7057_.tb2_5(14):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(14):=null;
SVCFG_7057_.tb2_6(14):=NULL;
SVCFG_7057_.old_tb2_7(14):=null;
SVCFG_7057_.tb2_7(14):=NULL;
SVCFG_7057_.old_tb2_8(14):=null;
SVCFG_7057_.tb2_8(14):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(14),
SVCFG_7057_.tb2_1(14),
SVCFG_7057_.tb2_2(14),
SVCFG_7057_.tb2_3(14),
SVCFG_7057_.tb2_4(14),
SVCFG_7057_.tb2_5(14),
SVCFG_7057_.tb2_6(14),
SVCFG_7057_.tb2_7(14),
SVCFG_7057_.tb2_8(14),
null,
104295,
9,
'Fecha de Atención'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(14):=1604677;
SVCFG_7057_.tb4_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(14):=SVCFG_7057_.tb4_0(14);
SVCFG_7057_.old_tb4_1(14):=498;
SVCFG_7057_.tb4_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(14),-1)));
SVCFG_7057_.old_tb4_2(14):=null;
SVCFG_7057_.tb4_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(14),-1)));
SVCFG_7057_.tb4_3(14):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(14):=SVCFG_7057_.tb2_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(14),
SVCFG_7057_.tb4_1(14),
SVCFG_7057_.tb4_2(14),
SVCFG_7057_.tb4_3(14),
SVCFG_7057_.tb4_4(14),
'C'
,
'Y'
,
9,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(15):=1149205;
SVCFG_7057_.tb2_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(15):=SVCFG_7057_.tb2_0(15);
SVCFG_7057_.old_tb2_1(15):=3334;
SVCFG_7057_.tb2_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(15),-1)));
SVCFG_7057_.old_tb2_2(15):=220;
SVCFG_7057_.tb2_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(15),-1)));
SVCFG_7057_.old_tb2_3(15):=null;
SVCFG_7057_.tb2_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(15),-1)));
SVCFG_7057_.old_tb2_4(15):=null;
SVCFG_7057_.tb2_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(15),-1)));
SVCFG_7057_.tb2_5(15):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(15):=null;
SVCFG_7057_.tb2_6(15):=NULL;
SVCFG_7057_.old_tb2_7(15):=null;
SVCFG_7057_.tb2_7(15):=NULL;
SVCFG_7057_.old_tb2_8(15):=null;
SVCFG_7057_.tb2_8(15):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(15),
SVCFG_7057_.tb2_1(15),
SVCFG_7057_.tb2_2(15),
SVCFG_7057_.tb2_3(15),
SVCFG_7057_.tb2_4(15),
SVCFG_7057_.tb2_5(15),
SVCFG_7057_.tb2_6(15),
SVCFG_7057_.tb2_7(15),
SVCFG_7057_.tb2_8(15),
null,
104296,
10,
'Identificador de Distribución Administrativa'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(15):=1604678;
SVCFG_7057_.tb4_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(15):=SVCFG_7057_.tb4_0(15);
SVCFG_7057_.old_tb4_1(15):=220;
SVCFG_7057_.tb4_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(15),-1)));
SVCFG_7057_.old_tb4_2(15):=null;
SVCFG_7057_.tb4_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(15),-1)));
SVCFG_7057_.tb4_3(15):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(15):=SVCFG_7057_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(15),
SVCFG_7057_.tb4_1(15),
SVCFG_7057_.tb4_2(15),
SVCFG_7057_.tb4_3(15),
SVCFG_7057_.tb4_4(15),
'C'
,
'Y'
,
10,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(16):=1149206;
SVCFG_7057_.tb2_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(16):=SVCFG_7057_.tb2_0(16);
SVCFG_7057_.old_tb2_1(16):=3334;
SVCFG_7057_.tb2_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(16),-1)));
SVCFG_7057_.old_tb2_2(16):=524;
SVCFG_7057_.tb2_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(16),-1)));
SVCFG_7057_.old_tb2_3(16):=null;
SVCFG_7057_.tb2_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(16),-1)));
SVCFG_7057_.old_tb2_4(16):=null;
SVCFG_7057_.tb2_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(16),-1)));
SVCFG_7057_.tb2_5(16):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(16):=null;
SVCFG_7057_.tb2_6(16):=NULL;
SVCFG_7057_.old_tb2_7(16):=null;
SVCFG_7057_.tb2_7(16):=NULL;
SVCFG_7057_.old_tb2_8(16):=null;
SVCFG_7057_.tb2_8(16):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(16),
SVCFG_7057_.tb2_1(16),
SVCFG_7057_.tb2_2(16),
SVCFG_7057_.tb2_3(16),
SVCFG_7057_.tb2_4(16),
SVCFG_7057_.tb2_5(16),
SVCFG_7057_.tb2_6(16),
SVCFG_7057_.tb2_7(16),
SVCFG_7057_.tb2_8(16),
null,
104297,
11,
'Estado del Motivo'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(16):=1604679;
SVCFG_7057_.tb4_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(16):=SVCFG_7057_.tb4_0(16);
SVCFG_7057_.old_tb4_1(16):=524;
SVCFG_7057_.tb4_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(16),-1)));
SVCFG_7057_.old_tb4_2(16):=null;
SVCFG_7057_.tb4_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(16),-1)));
SVCFG_7057_.tb4_3(16):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(16):=SVCFG_7057_.tb2_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(16),
SVCFG_7057_.tb4_1(16),
SVCFG_7057_.tb4_2(16),
SVCFG_7057_.tb4_3(16),
SVCFG_7057_.tb4_4(16),
'C'
,
'Y'
,
11,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(17):=1149207;
SVCFG_7057_.tb2_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(17):=SVCFG_7057_.tb2_0(17);
SVCFG_7057_.old_tb2_1(17):=3334;
SVCFG_7057_.tb2_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(17),-1)));
SVCFG_7057_.old_tb2_2(17):=191;
SVCFG_7057_.tb2_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(17),-1)));
SVCFG_7057_.old_tb2_3(17):=null;
SVCFG_7057_.tb2_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(17),-1)));
SVCFG_7057_.old_tb2_4(17):=null;
SVCFG_7057_.tb2_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(17),-1)));
SVCFG_7057_.tb2_5(17):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(17):=null;
SVCFG_7057_.tb2_6(17):=NULL;
SVCFG_7057_.old_tb2_7(17):=null;
SVCFG_7057_.tb2_7(17):=NULL;
SVCFG_7057_.old_tb2_8(17):=null;
SVCFG_7057_.tb2_8(17):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(17),
SVCFG_7057_.tb2_1(17),
SVCFG_7057_.tb2_2(17),
SVCFG_7057_.tb2_3(17),
SVCFG_7057_.tb2_4(17),
SVCFG_7057_.tb2_5(17),
SVCFG_7057_.tb2_6(17),
SVCFG_7057_.tb2_7(17),
SVCFG_7057_.tb2_8(17),
null,
104298,
12,
'Identificador del Tipo de Motivo'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(17):=1604680;
SVCFG_7057_.tb4_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(17):=SVCFG_7057_.tb4_0(17);
SVCFG_7057_.old_tb4_1(17):=191;
SVCFG_7057_.tb4_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(17),-1)));
SVCFG_7057_.old_tb4_2(17):=null;
SVCFG_7057_.tb4_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(17),-1)));
SVCFG_7057_.tb4_3(17):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(17):=SVCFG_7057_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(17),
SVCFG_7057_.tb4_1(17),
SVCFG_7057_.tb4_2(17),
SVCFG_7057_.tb4_3(17),
SVCFG_7057_.tb4_4(17),
'C'
,
'Y'
,
12,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(18):=1149208;
SVCFG_7057_.tb2_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(18):=SVCFG_7057_.tb2_0(18);
SVCFG_7057_.old_tb2_1(18):=3334;
SVCFG_7057_.tb2_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(18),-1)));
SVCFG_7057_.old_tb2_2(18):=192;
SVCFG_7057_.tb2_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(18),-1)));
SVCFG_7057_.old_tb2_3(18):=null;
SVCFG_7057_.tb2_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(18),-1)));
SVCFG_7057_.old_tb2_4(18):=null;
SVCFG_7057_.tb2_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(18),-1)));
SVCFG_7057_.tb2_5(18):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(18):=null;
SVCFG_7057_.tb2_6(18):=NULL;
SVCFG_7057_.old_tb2_7(18):=null;
SVCFG_7057_.tb2_7(18):=NULL;
SVCFG_7057_.old_tb2_8(18):=null;
SVCFG_7057_.tb2_8(18):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(18),
SVCFG_7057_.tb2_1(18),
SVCFG_7057_.tb2_2(18),
SVCFG_7057_.tb2_3(18),
SVCFG_7057_.tb2_4(18),
SVCFG_7057_.tb2_5(18),
SVCFG_7057_.tb2_6(18),
SVCFG_7057_.tb2_7(18),
SVCFG_7057_.tb2_8(18),
null,
104299,
13,
'Identificador del Tipo de Producto'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(18):=1604681;
SVCFG_7057_.tb4_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(18):=SVCFG_7057_.tb4_0(18);
SVCFG_7057_.old_tb4_1(18):=192;
SVCFG_7057_.tb4_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(18),-1)));
SVCFG_7057_.old_tb4_2(18):=null;
SVCFG_7057_.tb4_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(18),-1)));
SVCFG_7057_.tb4_3(18):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(18):=SVCFG_7057_.tb2_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(18),
SVCFG_7057_.tb4_1(18),
SVCFG_7057_.tb4_2(18),
SVCFG_7057_.tb4_3(18),
SVCFG_7057_.tb4_4(18),
'C'
,
'Y'
,
13,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(19):=1149209;
SVCFG_7057_.tb2_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(19):=SVCFG_7057_.tb2_0(19);
SVCFG_7057_.old_tb2_1(19):=3334;
SVCFG_7057_.tb2_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(19),-1)));
SVCFG_7057_.old_tb2_2(19):=4011;
SVCFG_7057_.tb2_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(19),-1)));
SVCFG_7057_.old_tb2_3(19):=null;
SVCFG_7057_.tb2_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(19),-1)));
SVCFG_7057_.old_tb2_4(19):=null;
SVCFG_7057_.tb2_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(19),-1)));
SVCFG_7057_.tb2_5(19):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(19):=null;
SVCFG_7057_.tb2_6(19):=NULL;
SVCFG_7057_.old_tb2_7(19):=null;
SVCFG_7057_.tb2_7(19):=NULL;
SVCFG_7057_.old_tb2_8(19):=null;
SVCFG_7057_.tb2_8(19):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(19),
SVCFG_7057_.tb2_1(19),
SVCFG_7057_.tb2_2(19),
SVCFG_7057_.tb2_3(19),
SVCFG_7057_.tb2_4(19),
SVCFG_7057_.tb2_5(19),
SVCFG_7057_.tb2_6(19),
SVCFG_7057_.tb2_7(19),
SVCFG_7057_.tb2_8(19),
null,
104300,
14,
'Número del Servicio'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(19):=1604682;
SVCFG_7057_.tb4_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(19):=SVCFG_7057_.tb4_0(19);
SVCFG_7057_.old_tb4_1(19):=4011;
SVCFG_7057_.tb4_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(19),-1)));
SVCFG_7057_.old_tb4_2(19):=null;
SVCFG_7057_.tb4_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(19),-1)));
SVCFG_7057_.tb4_3(19):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(19):=SVCFG_7057_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(19),
SVCFG_7057_.tb4_1(19),
SVCFG_7057_.tb4_2(19),
SVCFG_7057_.tb4_3(19),
SVCFG_7057_.tb4_4(19),
'C'
,
'Y'
,
14,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(20):=1149210;
SVCFG_7057_.tb2_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(20):=SVCFG_7057_.tb2_0(20);
SVCFG_7057_.old_tb2_1(20):=3334;
SVCFG_7057_.tb2_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(20),-1)));
SVCFG_7057_.old_tb2_2(20):=11403;
SVCFG_7057_.tb2_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(20),-1)));
SVCFG_7057_.old_tb2_3(20):=null;
SVCFG_7057_.tb2_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(20),-1)));
SVCFG_7057_.old_tb2_4(20):=null;
SVCFG_7057_.tb2_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(20),-1)));
SVCFG_7057_.tb2_5(20):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(20):=null;
SVCFG_7057_.tb2_6(20):=NULL;
SVCFG_7057_.old_tb2_7(20):=null;
SVCFG_7057_.tb2_7(20):=NULL;
SVCFG_7057_.old_tb2_8(20):=null;
SVCFG_7057_.tb2_8(20):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(20),
SVCFG_7057_.tb2_1(20),
SVCFG_7057_.tb2_2(20),
SVCFG_7057_.tb2_3(20),
SVCFG_7057_.tb2_4(20),
SVCFG_7057_.tb2_5(20),
SVCFG_7057_.tb2_6(20),
SVCFG_7057_.tb2_7(20),
SVCFG_7057_.tb2_8(20),
null,
104301,
15,
'Identificador de la Suscripción'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(20):=1604683;
SVCFG_7057_.tb4_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(20):=SVCFG_7057_.tb4_0(20);
SVCFG_7057_.old_tb4_1(20):=11403;
SVCFG_7057_.tb4_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(20),-1)));
SVCFG_7057_.old_tb4_2(20):=null;
SVCFG_7057_.tb4_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(20),-1)));
SVCFG_7057_.tb4_3(20):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(20):=SVCFG_7057_.tb2_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(20),
SVCFG_7057_.tb4_1(20),
SVCFG_7057_.tb4_2(20),
SVCFG_7057_.tb4_3(20),
SVCFG_7057_.tb4_4(20),
'C'
,
'Y'
,
15,
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(21):=1149211;
SVCFG_7057_.tb2_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(21):=SVCFG_7057_.tb2_0(21);
SVCFG_7057_.old_tb2_1(21):=3334;
SVCFG_7057_.tb2_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(21),-1)));
SVCFG_7057_.old_tb2_2(21):=703;
SVCFG_7057_.tb2_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(21),-1)));
SVCFG_7057_.old_tb2_3(21):=null;
SVCFG_7057_.tb2_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(21),-1)));
SVCFG_7057_.old_tb2_4(21):=null;
SVCFG_7057_.tb2_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(21),-1)));
SVCFG_7057_.tb2_5(21):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(21):=null;
SVCFG_7057_.tb2_6(21):=NULL;
SVCFG_7057_.old_tb2_7(21):=null;
SVCFG_7057_.tb2_7(21):=NULL;
SVCFG_7057_.old_tb2_8(21):=null;
SVCFG_7057_.tb2_8(21):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(21),
SVCFG_7057_.tb2_1(21),
SVCFG_7057_.tb2_2(21),
SVCFG_7057_.tb2_3(21),
SVCFG_7057_.tb2_4(21),
SVCFG_7057_.tb2_5(21),
SVCFG_7057_.tb2_6(21),
SVCFG_7057_.tb2_7(21),
SVCFG_7057_.tb2_8(21),
null,
104302,
16,
'Comentarios'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(21):=1604684;
SVCFG_7057_.tb4_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(21):=SVCFG_7057_.tb4_0(21);
SVCFG_7057_.old_tb4_1(21):=703;
SVCFG_7057_.tb4_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(21),-1)));
SVCFG_7057_.old_tb4_2(21):=null;
SVCFG_7057_.tb4_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(21),-1)));
SVCFG_7057_.tb4_3(21):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(21):=SVCFG_7057_.tb2_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(21),
SVCFG_7057_.tb4_1(21),
SVCFG_7057_.tb4_2(21),
SVCFG_7057_.tb4_3(21),
SVCFG_7057_.tb4_4(21),
'Y'
,
'Y'
,
16,
'N'
,
'Comentarios'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb2_0(22):=1149212;
SVCFG_7057_.tb2_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
SVCFG_7057_.tb2_0(22):=SVCFG_7057_.tb2_0(22);
SVCFG_7057_.old_tb2_1(22):=3334;
SVCFG_7057_.tb2_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(SVCFG_7057_.TBENTITYNAME(NVL(SVCFG_7057_.old_tb2_1(22),-1)));
SVCFG_7057_.old_tb2_2(22):=243;
SVCFG_7057_.tb2_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_2(22),-1)));
SVCFG_7057_.old_tb2_3(22):=null;
SVCFG_7057_.tb2_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_3(22),-1)));
SVCFG_7057_.old_tb2_4(22):=null;
SVCFG_7057_.tb2_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb2_4(22),-1)));
SVCFG_7057_.tb2_5(22):=SVCFG_7057_.tb1_2(1);
SVCFG_7057_.old_tb2_6(22):=null;
SVCFG_7057_.tb2_6(22):=NULL;
SVCFG_7057_.old_tb2_7(22):=null;
SVCFG_7057_.tb2_7(22):=NULL;
SVCFG_7057_.old_tb2_8(22):=null;
SVCFG_7057_.tb2_8(22):=NULL;
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SELECT_STATEMENT_ID,PARENT_GROUP_ATTR_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (SVCFG_7057_.tb2_0(22),
SVCFG_7057_.tb2_1(22),
SVCFG_7057_.tb2_2(22),
SVCFG_7057_.tb2_3(22),
SVCFG_7057_.tb2_4(22),
SVCFG_7057_.tb2_5(22),
SVCFG_7057_.tb2_6(22),
SVCFG_7057_.tb2_7(22),
SVCFG_7057_.tb2_8(22),
null,
104303,
17,
'Observaciones'
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
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;

SVCFG_7057_.old_tb4_0(22):=1604685;
SVCFG_7057_.tb4_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
SVCFG_7057_.tb4_0(22):=SVCFG_7057_.tb4_0(22);
SVCFG_7057_.old_tb4_1(22):=243;
SVCFG_7057_.tb4_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_1(22),-1)));
SVCFG_7057_.old_tb4_2(22):=null;
SVCFG_7057_.tb4_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(SVCFG_7057_.TBENTITYATTRIBUTENAME(NVL(SVCFG_7057_.old_tb4_2(22),-1)));
SVCFG_7057_.tb4_3(22):=SVCFG_7057_.tb3_0(1);
SVCFG_7057_.tb4_4(22):=SVCFG_7057_.tb2_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (SVCFG_7057_.tb4_0(22),
SVCFG_7057_.tb4_1(22),
SVCFG_7057_.tb4_2(22),
SVCFG_7057_.tb4_3(22),
SVCFG_7057_.tb4_4(22),
'Y'
,
'Y'
,
17,
'N'
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
null,
null,
null,
null);

exception when others then
SVCFG_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
nuIndex number;
CURSOR c1 IS
    SELECT  distinct product_motive_id
    FROM    ps_prd_motiv_package
    WHERE   product_type_id = 7057
    AND     package_type_id = ps_boconfigurator_ds.fnugetsalespacktype;
CURSOR c2 is
    SELECT  prod_motive_comp_id
    FROM    ps_prod_motive_comp
    WHERE   product_motive_id in
    (
        SELECT  product_motive_id
        FROM    ps_prd_motiv_package
        WHERE   product_type_id = 7057
        AND     package_type_id = ps_boconfigurator_ds.fnugetsalespacktype
    );
type tytbMotivos IS table of ps_product_motive.product_motive_id%type;
tbMotivos   tytbMotivos;
type tytbMoticom IS table of ps_prod_motive_comp.prod_motive_comp_id%type;
tbMoticom   tytbMoticom;
indice  number;
BEGIN

if (not SVCFG_7057_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Se actualizan las expresiones y sentencias', 7);
UPDATE  gi_comp_attribs
SET     init_expression_id  = ( SELECT init_expression_id  FROM ps_moti_comp_attribs WHERE moti_comp_attribs_id = gi_comp_attribs.external_id ),
valid_expression_id = ( SELECT valid_expression_id FROM ps_moti_comp_attribs WHERE moti_comp_attribs_id = gi_comp_attribs.external_id ),
select_statement_id = ( SELECT    statement_id     FROM ps_moti_comp_attribs WHERE moti_comp_attribs_id = gi_comp_attribs.external_id )
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id = SVCFG_7057_.cnuSalesConfig
AND     external_id = 7057AND     composition_id != SVCFG_7057_.cnuCommonComposition
)
AND     entity_id = 2042;
UPDATE  gi_comp_attribs
SET     init_expression_id  = ( SELECT init_expression_id  FROM ps_prod_moti_attrib WHERE prod_moti_attrib_id = gi_comp_attribs.external_id ),
valid_expression_id = ( SELECT valid_expression_id FROM ps_prod_moti_attrib WHERE prod_moti_attrib_id = gi_comp_attribs.external_id ),
select_statement_id = ( SELECT    statement_id     FROM ps_prod_moti_attrib WHERE prod_moti_attrib_id = gi_comp_attribs.external_id )
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   config_id = SVCFG_7057_.cnuSalesConfig
AND     external_id = 7057AND     composition_id != SVCFG_7057_.cnuCommonComposition
)
AND     entity_id = 3334;
ut_trace.trace('Se Actualizan las solicitudes asociadas', 7);
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
            WHERE   config_id = SVCFG_7057_.cnuSalesConfig
            AND     external_id = 7057
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
            WHERE   config_id = SVCFG_7057_.cnuSalesConfig
            AND     external_id = 7057
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
            WHERE   config_id = SVCFG_7057_.cnuSalesConfig
            AND     external_id = 7057
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
            WHERE   config_id = SVCFG_7057_.cnuSalesConfig
            AND     external_id = 7057
        )
    );
    indice := tbMoticom.NEXT(indice);
END loop;
ut_trace.trace('Se actualiza el registro de composición por configuración', 7);
update gi_config_comp SET composition_id=SVCFG_7057_.cnuCommonComposition where composition_id = (SELECT composition_id FROM gi_composition WHERE config_id = SVCFG_7057_.cnuSalesConfig AND composition_id != SVCFG_7057_.cnuCommonComposition);
ut_trace.trace('Se elimina la composición sobrante', 7);
delete gi_composition where config_id = SVCFG_7057_.cnuSalesConfig and composition_id != SVCFG_7057_.cnuCommonComposition;
ut_trace.trace('Se eliminan composiciones sobrantes', 7);
forall nuIndex in SVCFG_7057_.tbCompositions.FIRST..SVCFG_7057_.tbCompositions.LAST
DELETE gi_composition WHERE rowid = SVCFG_7057_.tbCompositions(nuIndex);

exception when others then
SVCFG_7057_.blProcessStatus := false;
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
 nuIndex := SVCFG_7057_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || SVCFG_7057_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(SVCFG_7057_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(SVCFG_7057_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(SVCFG_7057_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || SVCFG_7057_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || SVCFG_7057_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := SVCFG_7057_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('SVCFG_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:SVCFG_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_P_7057_',
'CREATE OR REPLACE PACKAGE I18N_P_7057_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_P_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_P_7057_******************************'); END;
/


declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM I18N_STRING WHERE ID IN
(  SELECT  tag_name
FROM    gi_composition
WHERE   composition_id in
(
SELECT  composition_id
FROM    gi_config_comp
WHERE   external_id = 7057
AND     config_id = gi_boconfig.fnugetconfig(2012, ps_boconfigurator_ds.fnugetsalespacktype, 4)
)
);
nuIndex binary_integer;
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
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
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(0):='C_ENERGIA_SOLAR_10340'
;
I18N_P_7057_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(0),
I18N_P_7057_.tb0_1(0),
'WE8ISO8859P1'
,
'Energia Solar'
,
'Energia Solar'
,
null,
'Energia Solar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(1):='C_ENERGIA_SOLAR_10340'
;
I18N_P_7057_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(1),
I18N_P_7057_.tb0_1(1),
'WE8ISO8859P1'
,
'Energia Solar'
,
'Energia Solar'
,
null,
'Energia Solar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(2):='C_ENERGIA_SOLAR_10340'
;
I18N_P_7057_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(2),
I18N_P_7057_.tb0_1(2),
'WE8ISO8859P1'
,
'Energia Solar'
,
'Energia Solar'
,
null,
'Energia Solar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(3):='M_INSTALACION_DE_ENERGIA_SOLAR_100300'
;
I18N_P_7057_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(3),
I18N_P_7057_.tb0_1(3),
'WE8ISO8859P1'
,
'Instalación de Energia Solar'
,
'Instalación de Energia Solar'
,
null,
'Instalación de Energia Solar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(4):='M_INSTALACION_DE_ENERGIA_SOLAR_100300'
;
I18N_P_7057_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(4),
I18N_P_7057_.tb0_1(4),
'WE8ISO8859P1'
,
'Instalación de Energia Solar'
,
'Instalación de Energia Solar'
,
null,
'Instalación de Energia Solar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(5):='M_INSTALACION_DE_ENERGIA_SOLAR_100300'
;
I18N_P_7057_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(5),
I18N_P_7057_.tb0_1(5),
'WE8ISO8859P1'
,
'Instalación de Energia Solar'
,
'Instalación de Energia Solar'
,
null,
'Instalación de Energia Solar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(6):='PAQUETE'
;
I18N_P_7057_.tb0_1(6):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(6),
I18N_P_7057_.tb0_1(6),
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
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(7):='PAQUETE'
;
I18N_P_7057_.tb0_1(7):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (7)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(7),
I18N_P_7057_.tb0_1(7),
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
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(8):='PAQUETE'
;
I18N_P_7057_.tb0_1(8):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (8)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(8),
I18N_P_7057_.tb0_1(8),
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
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_P_7057_.blProcessStatus) then
 return;
end if;

I18N_P_7057_.tb0_0(9):='PAQUETE'
;
I18N_P_7057_.tb0_1(9):='US'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (9)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_P_7057_.tb0_0(9),
I18N_P_7057_.tb0_1(9),
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
I18N_P_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_P_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_P_7057_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('SVEXEC_7057_',
'CREATE OR REPLACE PACKAGE SVEXEC_7057_ IS ' || chr(10) ||
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
'END SVEXEC_7057_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:SVEXEC_7057_******************************'); END;
/


BEGIN

if (not SVEXEC_7057_.blProcessStatus) then
 return;
end if;

SVEXEC_7057_.old_tb0_0(0):='PR_ENERGIA_SOLAR_7057'
;
SVEXEC_7057_.tb0_0(0):=UPPER(SVEXEC_7057_.old_tb0_0(0));
SVEXEC_7057_.old_tb0_1(0):=500000000015735;
SVEXEC_7057_.tb0_1(0):=CC_BOUTILEXPORT.FNUGETIDSEQEXEFROMCAT(SVEXEC_7057_.tb0_0(0), 'SA_BOEXECUTABLE.GETNEXTID');
SVEXEC_7057_.tb0_1(0):=SVEXEC_7057_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=SVEXEC_7057_.tb0_0(0),
EXECUTABLE_ID=SVEXEC_7057_.tb0_1(0),
DESCRIPTION='Energia Solar '
,
PATH=null,
VERSION='5'
,
EXECUTABLE_TYPE_ID=11,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=10,
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
EXEC_OWNER=null,
LAST_DATE_EXECUTED=null,
CLASS_ID=null
 WHERE EXECUTABLE_ID = SVEXEC_7057_.tb0_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (SVEXEC_7057_.tb0_0(0),
SVEXEC_7057_.tb0_1(0),
'Energia Solar '
,
null,
'5'
,
11,
2,
10,
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
null,
null,
null);
end if;

exception when others then
SVEXEC_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not SVEXEC_7057_.blProcessStatus) then
 return;
end if;

SVEXEC_7057_.tb1_0(0):=1;
SVEXEC_7057_.tb1_1(0):=SVEXEC_7057_.tb0_1(0);
ut_trace.trace('insertando tabla sin fallo: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (SVEXEC_7057_.tb1_0(0),
SVEXEC_7057_.tb1_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
SVEXEC_7057_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('SVEXEC_7057_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:SVEXEC_7057_******************************'); end;
/

