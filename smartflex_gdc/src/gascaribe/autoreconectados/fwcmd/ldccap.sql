BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCCAP_',
'CREATE OR REPLACE PACKAGE LDCCAP_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ENT_ROLE_EXECRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ENT_ROLE_EXECRowId tySA_ENT_ROLE_EXECRowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type tySA_EXEC_ENTITIESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXEC_ENTITIESRowId tySA_EXEC_ENTITIESRowId;type tySA_MENU_OPTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_MENU_OPTIONRowId tySA_MENU_OPTIONRowId;type tyGI_ENTITY_DISP_DATARowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ENTITY_DISP_DATARowId tyGI_ENTITY_DISP_DATARowId;type tyGI_ATTRIB_DISP_DATARowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ATTRIB_DISP_DATARowId tyGI_ATTRIB_DISP_DATARowId;type ty0_0 is table of SA_EXECUTABLE.NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of SA_EXECUTABLE.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of GI_ENTITY_DISP_DATA.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GI_ENTITY_DISP_DATA.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of GI_ENTITY_DISP_DATA.PARENT_ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GI_ATTRIB_DISP_DATA.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GI_ATTRIB_DISP_DATA.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GI_ATTRIB_DISP_DATA.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2; ' || chr(10) ||
'  executableName ge_catalog.tag_name%type := ''LDCCAP''; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityName tyCatalogTagName; ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
'CURSOR cuRoleExecutables ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT b.name, a.executable_id, a.role_id ' || chr(10) ||
'FROM sa_role_executables a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and a.executable_id in  ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCAP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCAP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCAP'' ' || chr(10) ||
'); ' || chr(10) ||
'type tyRoleExecutables IS table of cuRoleExecutables%rowtype index BY binary_integer; ' || chr(10) ||
'tbRoleExecutables  tyRoleExecutables; ' || chr(10) ||
'type tyUserExceptions IS table of cuUserExceptions%rowtype index BY binary_integer; ' || chr(10) ||
'tbUserException tyUserExceptions; ' || chr(10) ||
'type tyExecEntities IS table of cuExecEntities%rowtype index BY binary_integer; ' || chr(10) ||
'tbExecEntities  tyExecEntities; ' || chr(10) ||
'rcRoleExecutables cuRoleExecutables%rowtype; ' || chr(10) ||
'rcUserExceptions  cuUserExceptions%rowtype; ' || chr(10) ||
'rcExecEntities  cuExecEntities%rowtype; ' || chr(10) ||
' ' || chr(10) ||
'END LDCCAP_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCCAP_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
Open LDCCAP_.cuRoleExecutables;
loop
 fetch LDCCAP_.cuRoleExecutables INTO LDCCAP_.rcRoleExecutables;
 exit when  LDCCAP_.cuRoleExecutables%notfound;
 LDCCAP_.tbRoleExecutables(nuIndex) := LDCCAP_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCCAP_.cuRoleExecutables;
nuIndex := 0;
Open LDCCAP_.cuUserExceptions ;
loop
 fetch LDCCAP_.cuUserExceptions INTO  LDCCAP_.rcUserExceptions;
 exit when LDCCAP_.cuUserExceptions%notfound;
 LDCCAP_.tbUserException(nuIndex):=LDCCAP_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCCAP_.cuUserExceptions;
nuIndex := 0;
Open LDCCAP_.cuExecEntities ;
loop
 fetch LDCCAP_.cuExecEntities INTO  LDCCAP_.rcExecEntities;
 exit when LDCCAP_.cuExecEntities%notfound;
 LDCCAP_.tbExecEntities(nuIndex):=LDCCAP_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCCAP_.cuExecEntities;

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP'
);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCCAP_.tbEntityName(1728) := 'LDC_PROCESO_ACTIVIDAD';
   LDCCAP_.tbEntityAttributeName(90065456) := 'LDC_PROCESO_ACTIVIDAD@PROCESO_ID';
   LDCCAP_.tbEntityAttributeName(90065458) := 'LDC_PROCESO_ACTIVIDAD@TASK_TYPE_ID';
   LDCCAP_.tbEntityAttributeName(90065460) := 'LDC_PROCESO_ACTIVIDAD@ACTIVITY_ID';
 
   LDCCAP_.tbEntityName(1726) := 'LDC_PROCESO';
   LDCCAP_.tbEntityAttributeName(90065447) := 'LDC_PROCESO@PROCESO_ID';
   LDCCAP_.tbEntityAttributeName(90065448) := 'LDC_PROCESO@PROCESO_DESCRIPCION';
   LDCCAP_.tbEntityAttributeName(90065449) := 'LDC_PROCESO@EMAIL';
   LDCCAP_.tbEntityAttributeName(90065450) := 'LDC_PROCESO@PERCONEVA';
   LDCCAP_.tbEntityAttributeName(90065451) := 'LDC_PROCESO@VALCONTOP';
   LDCCAP_.tbEntityAttributeName(90065452) := 'LDC_PROCESO@SALTOTEVA';
   LDCCAP_.tbEntityAttributeName(90065453) := 'LDC_PROCESO@ESTADOCORTE';
   LDCCAP_.tbEntityAttributeName(90065454) := 'LDC_PROCESO@ESTADOPRODUCTO';
   LDCCAP_.tbEntityAttributeName(90065455) := 'LDC_PROCESO@ESTADOCORTECC';
   LDCCAP_.tbEntityAttributeName(90076885) := 'LDC_PROCESO@SUSPENSION_TYPES';
   LDCCAP_.tbEntityAttributeName(90172839) := 'LDC_PROCESO@ACTIVIDAD_VALIDAR';
   LDCCAP_.tbEntityAttributeName(90199890) := 'LDC_PROCESO@PROCESO_AUTOMATICO';
 
   LDCCAP_.tbEntityName(1751) := 'LDC_ACTIVIDAD_GENERADA';
   LDCCAP_.tbEntityAttributeName(90065549) := 'LDC_ACTIVIDAD_GENERADA@PROCESO_ID';
   LDCCAP_.tbEntityAttributeName(90065550) := 'LDC_ACTIVIDAD_GENERADA@ACTIVITY_ID_GENERADA';
   LDCCAP_.tbEntityAttributeName(90065551) := 'LDC_ACTIVIDAD_GENERADA@PROXIMA_ACTIVITY_ID';
   LDCCAP_.tbEntityAttributeName(90172828) := 'LDC_ACTIVIDAD_GENERADA@SUSPENSION_TYPE_ID';
 
END; 
/

BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP');

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP') AND ROLE_ID=1;

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP');

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP');

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP'));

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCAP');

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCCAP';

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.old_tb0_0(0):='LDCCAP'
;
LDCCAP_.tb0_0(0):=UPPER(LDCCAP_.old_tb0_0(0));
LDCCAP_.old_tb0_1(0):=500000000005715;
LDCCAP_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCCAP_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCCAP_.tb0_1(0):=LDCCAP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCCAP_.tb0_0(0),
LDCCAP_.tb0_1(0),
'CONFIGURACION DE ACTIVIDADES POR PROCESO'
,
null,
'24.2'
,
8,
2,
21,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
99,
null,
to_date('18-03-2024 07:28:46','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb1_0(0):=1;
LDCCAP_.tb1_1(0):=LDCCAP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCCAP_.tb1_0(0),
LDCCAP_.tb1_1(0));

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb2_0(0):=LDCCAP_.tb0_1(0);
LDCCAP_.old_tb2_1(0):=1728;
LDCCAP_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYNAME(LDCCAP_.old_tb2_1(0)), 'ENTITY');
LDCCAP_.tb2_1(0):=LDCCAP_.tb2_1(0);
LDCCAP_.old_tb2_2(0):=null;
LDCCAP_.tb2_2(0):=CASE WHEN (LDCCAP_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYNAME(LDCCAP_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCCAP_.tb2_0(0),
LDCCAP_.tb2_1(0),
LDCCAP_.tb2_2(0),
'G'
,
0,
0,
null,
null,
null,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(0):=LDCCAP_.tb2_0(0);
LDCCAP_.tb3_1(0):=LDCCAP_.tb2_1(0);
LDCCAP_.old_tb3_2(0):=90065456;
LDCCAP_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(0)), 'ATTRIBUTE');
LDCCAP_.tb3_2(0):=LDCCAP_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(0),
LDCCAP_.tb3_1(0),
LDCCAP_.tb3_2(0),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT  PROCESO_ID "CODIGO" , PROCESO_DESCRIPCION "DESCRIPCION"  FROM LDC_PROCESO ORDER BY PROCESO_ID ASC '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'PROCESO_ID CODIGO|PROCESO_DESCRIPCION DESCRIPCION|'
,
'FROM LDC_PROCESO|'
,
null,
'ORDER BY PROCESO_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(1):=LDCCAP_.tb2_0(0);
LDCCAP_.tb3_1(1):=LDCCAP_.tb2_1(0);
LDCCAP_.old_tb3_2(1):=90065458;
LDCCAP_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(1)), 'ATTRIBUTE');
LDCCAP_.tb3_2(1):=LDCCAP_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(1),
LDCCAP_.tb3_1(1),
LDCCAP_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT TASK_TYPE_ID "Código",DESCRIPTION "Descripción" FROM OR_TASK_TYPE'
,
'N'
,
'Código'
,
'Descripción'
,
'TASK_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM OR_TASK_TYPE'
,
null,
null,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(2):=LDCCAP_.tb2_0(0);
LDCCAP_.tb3_1(2):=LDCCAP_.tb2_1(0);
LDCCAP_.old_tb3_2(2):=90065460;
LDCCAP_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(2)), 'ATTRIBUTE');
LDCCAP_.tb3_2(2):=LDCCAP_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(2),
LDCCAP_.tb3_1(2),
LDCCAP_.tb3_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT ITEMS_ID "CÓDIGO",DESCRIPTION "DESCRIPCIÓN" FROM GE_ITEMS'
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'ITEMS_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_ITEMS'
,
null,
null,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb2_0(1):=LDCCAP_.tb0_1(0);
LDCCAP_.old_tb2_1(1):=1726;
LDCCAP_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYNAME(LDCCAP_.old_tb2_1(1)), 'ENTITY');
LDCCAP_.tb2_1(1):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb2_2(1):=null;
LDCCAP_.tb2_2(1):=CASE WHEN (LDCCAP_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYNAME(LDCCAP_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCCAP_.tb2_0(1),
LDCCAP_.tb2_1(1),
LDCCAP_.tb2_2(1),
'G'
,
0,
0,
null,
null,
null,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(3):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(3):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(3):=90065447;
LDCCAP_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(3)), 'ATTRIBUTE');
LDCCAP_.tb3_2(3):=LDCCAP_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(3),
LDCCAP_.tb3_1(3),
LDCCAP_.tb3_2(3),
0,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
'A'
,
null,
1);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(4):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(4):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(4):=90065448;
LDCCAP_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(4)), 'ATTRIBUTE');
LDCCAP_.tb3_2(4):=LDCCAP_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(4),
LDCCAP_.tb3_1(4),
LDCCAP_.tb3_2(4),
1,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(5):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(5):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(5):=90065449;
LDCCAP_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(5)), 'ATTRIBUTE');
LDCCAP_.tb3_2(5):=LDCCAP_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(5),
LDCCAP_.tb3_1(5),
LDCCAP_.tb3_2(5),
2,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(6):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(6):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(6):=90065450;
LDCCAP_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(6)), 'ATTRIBUTE');
LDCCAP_.tb3_2(6):=LDCCAP_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(6),
LDCCAP_.tb3_1(6),
LDCCAP_.tb3_2(6),
3,
'N'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(7):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(7):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(7):=90065451;
LDCCAP_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(7)), 'ATTRIBUTE');
LDCCAP_.tb3_2(7):=LDCCAP_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(7),
LDCCAP_.tb3_1(7),
LDCCAP_.tb3_2(7),
4,
'N'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(8):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(8):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(8):=90065452;
LDCCAP_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(8)), 'ATTRIBUTE');
LDCCAP_.tb3_2(8):=LDCCAP_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(8),
LDCCAP_.tb3_1(8),
LDCCAP_.tb3_2(8),
5,
'N'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(9):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(9):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(9):=90065453;
LDCCAP_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(9)), 'ATTRIBUTE');
LDCCAP_.tb3_2(9):=LDCCAP_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(9),
LDCCAP_.tb3_1(9),
LDCCAP_.tb3_2(9),
6,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(10):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(10):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(10):=90065454;
LDCCAP_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(10)), 'ATTRIBUTE');
LDCCAP_.tb3_2(10):=LDCCAP_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(10),
LDCCAP_.tb3_1(10),
LDCCAP_.tb3_2(10),
7,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(11):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(11):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(11):=90065455;
LDCCAP_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(11)), 'ATTRIBUTE');
LDCCAP_.tb3_2(11):=LDCCAP_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(11),
LDCCAP_.tb3_1(11),
LDCCAP_.tb3_2(11),
8,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(12):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(12):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(12):=90076885;
LDCCAP_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(12)), 'ATTRIBUTE');
LDCCAP_.tb3_2(12):=LDCCAP_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(12),
LDCCAP_.tb3_1(12),
LDCCAP_.tb3_2(12),
9,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(13):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(13):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(13):=90172839;
LDCCAP_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(13)), 'ATTRIBUTE');
LDCCAP_.tb3_2(13):=LDCCAP_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(13),
LDCCAP_.tb3_1(13),
LDCCAP_.tb3_2(13),
10,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(14):=LDCCAP_.tb2_0(1);
LDCCAP_.tb3_1(14):=LDCCAP_.tb2_1(1);
LDCCAP_.old_tb3_2(14):=90199890;
LDCCAP_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(14)), 'ATTRIBUTE');
LDCCAP_.tb3_2(14):=LDCCAP_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(14),
LDCCAP_.tb3_1(14),
LDCCAP_.tb3_2(14),
11,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb2_0(2):=LDCCAP_.tb0_1(0);
LDCCAP_.old_tb2_1(2):=1751;
LDCCAP_.tb2_1(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYNAME(LDCCAP_.old_tb2_1(2)), 'ENTITY');
LDCCAP_.tb2_1(2):=LDCCAP_.tb2_1(2);
LDCCAP_.old_tb2_2(2):=null;
LDCCAP_.tb2_2(2):=CASE WHEN (LDCCAP_.old_tb2_2(2) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYNAME(LDCCAP_.old_tb2_2(2)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (2)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCCAP_.tb2_0(2),
LDCCAP_.tb2_1(2),
LDCCAP_.tb2_2(2),
'G'
,
0,
0,
null,
null,
null,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(15):=LDCCAP_.tb2_0(2);
LDCCAP_.tb3_1(15):=LDCCAP_.tb2_1(2);
LDCCAP_.old_tb3_2(15):=90065549;
LDCCAP_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(15)), 'ATTRIBUTE');
LDCCAP_.tb3_2(15):=LDCCAP_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(15),
LDCCAP_.tb3_1(15),
LDCCAP_.tb3_2(15),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT  PROCESO_ID "CODIGO" , PROCESO_DESCRIPCION "DESCRIPCION"  FROM LDC_PROCESO ORDER BY PROCESO_ID ASC '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'PROCESO_ID CODIGO|PROCESO_DESCRIPCION DESCRIPCION|'
,
'FROM LDC_PROCESO|'
,
null,
'ORDER BY PROCESO_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(16):=LDCCAP_.tb2_0(2);
LDCCAP_.tb3_1(16):=LDCCAP_.tb2_1(2);
LDCCAP_.old_tb3_2(16):=90065550;
LDCCAP_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(16)), 'ATTRIBUTE');
LDCCAP_.tb3_2(16):=LDCCAP_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(16),
LDCCAP_.tb3_1(16),
LDCCAP_.tb3_2(16),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS ORDER BY ITEMS_ID ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'ITEMS_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_ITEMS|'
,
null,
'ORDER BY ITEMS_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(17):=LDCCAP_.tb2_0(2);
LDCCAP_.tb3_1(17):=LDCCAP_.tb2_1(2);
LDCCAP_.old_tb3_2(17):=90065551;
LDCCAP_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(17)), 'ATTRIBUTE');
LDCCAP_.tb3_2(17):=LDCCAP_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(17),
LDCCAP_.tb3_1(17),
LDCCAP_.tb3_2(17),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS ORDER BY ITEMS_ID ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'ITEMS_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_ITEMS|'
,
null,
'ORDER BY ITEMS_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;

LDCCAP_.tb3_0(18):=LDCCAP_.tb2_0(2);
LDCCAP_.tb3_1(18):=LDCCAP_.tb2_1(2);
LDCCAP_.old_tb3_2(18):=90172828;
LDCCAP_.tb3_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCAP_.TBENTITYATTRIBUTENAME(LDCCAP_.old_tb3_2(18)), 'ATTRIBUTE');
LDCCAP_.tb3_2(18):=LDCCAP_.tb3_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCAP_.tb3_0(18),
LDCCAP_.tb3_1(18),
LDCCAP_.tb3_2(18),
3,
'Y'
,
'Y'
,
'N'
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
'U'
,
null,
null,
null,
null);

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
type tyExecutableEquivalence IS table of sa_executable.executable_id%type index BY sa_executable.name%type;
tbExecutableEquivalence tyExecutableEquivalence;
nuNewExecutableId sa_executable.executable_id%type;
nuIndex binary_integer;
nuRecCount binary_integer;
FUNCTION fnuGetNewExecutableId(isbExecutableName in sa_executable.name%type)
 return sa_executable.executable_id%type
IS
nuIndexInternal binary_integer;
BEGIN
 IF (tbExecutableEquivalence.exists(isbExecutableName)) THEN
  return tbExecutableEquivalence(isbExecutableName);
 END IF;
 tbExecutableEquivalence(isbExecutableName) := null;
 nuIndexInternal := LDCCAP_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCCAP_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCCAP_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCCAP_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCCAP_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCCAP_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCCAP_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCCAP_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCCAP_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCCAP_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCCAP_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCCAP_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCCAP_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCCAP_.tbUserException(nuIndex).user_id, LDCCAP_.tbUserException(nuIndex).status , LDCCAP_.tbUserException(nuIndex).usr_exc_type_id, LDCCAP_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCCAP_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCCAP_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCCAP_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCCAP_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCCAP_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCCAP_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCCAP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCCAP_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCCAP_******************************'); end;
/

