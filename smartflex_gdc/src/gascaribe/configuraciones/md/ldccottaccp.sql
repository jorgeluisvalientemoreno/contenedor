BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCCOTTACCP_',
'CREATE OR REPLACE PACKAGE LDCCOTTACCP_ IS ' || chr(10) ||
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
'tb0_1 ty0_1;type ty1_0 is table of SA_ENT_ROLE_EXEC.ENT_ROLE_EXEC_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of SA_ENT_ROLE_EXEC.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of GI_ENTITY_DISP_DATA.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GI_ENTITY_DISP_DATA.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GI_ENTITY_DISP_DATA.PARENT_ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty4_0 is table of GI_ATTRIB_DISP_DATA.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GI_ATTRIB_DISP_DATA.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of GI_ATTRIB_DISP_DATA.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2; ' || chr(10) ||
'  executableName ge_catalog.tag_name%type := ''LDCCOTTACCP''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCOTTACCP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCOTTACCP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCOTTACCP'' ' || chr(10) ||
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
'END LDCCOTTACCP_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCCOTTACCP_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
Open LDCCOTTACCP_.cuRoleExecutables;
loop
 fetch LDCCOTTACCP_.cuRoleExecutables INTO LDCCOTTACCP_.rcRoleExecutables;
 exit when  LDCCOTTACCP_.cuRoleExecutables%notfound;
 LDCCOTTACCP_.tbRoleExecutables(nuIndex) := LDCCOTTACCP_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCCOTTACCP_.cuRoleExecutables;
nuIndex := 0;
Open LDCCOTTACCP_.cuUserExceptions ;
loop
 fetch LDCCOTTACCP_.cuUserExceptions INTO  LDCCOTTACCP_.rcUserExceptions;
 exit when LDCCOTTACCP_.cuUserExceptions%notfound;
 LDCCOTTACCP_.tbUserException(nuIndex):=LDCCOTTACCP_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCCOTTACCP_.cuUserExceptions;
nuIndex := 0;
Open LDCCOTTACCP_.cuExecEntities ;
loop
 fetch LDCCOTTACCP_.cuExecEntities INTO  LDCCOTTACCP_.rcExecEntities;
 exit when LDCCOTTACCP_.cuExecEntities%notfound;
 LDCCOTTACCP_.tbExecEntities(nuIndex):=LDCCOTTACCP_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCCOTTACCP_.cuExecEntities;

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP'
);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCCOTTACCP_.tbEntityName(4940) := 'LDC_TASKACTCOSTPROM';
   LDCCOTTACCP_.tbEntityAttributeName(90167165) := 'LDC_TASKACTCOSTPROM@ID_REGISTRO';
   LDCCOTTACCP_.tbEntityAttributeName(90167169) := 'LDC_TASKACTCOSTPROM@UNIDAD_OPERATIVA';
   LDCCOTTACCP_.tbEntityAttributeName(90167166) := 'LDC_TASKACTCOSTPROM@TIPO_TRAB';
   LDCCOTTACCP_.tbEntityAttributeName(90167167) := 'LDC_TASKACTCOSTPROM@ACTIVIDAD';
   LDCCOTTACCP_.tbEntityAttributeName(90167168) := 'LDC_TASKACTCOSTPROM@COSTO_PROM';
 
END; 
/

BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP');

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP') AND ROLE_ID=1;

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP');

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP');

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP'));

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP');

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCCOTTACCP';

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.old_tb0_0(0):='LDCCOTTACCP'
;
LDCCOTTACCP_.tb0_0(0):=UPPER(LDCCOTTACCP_.old_tb0_0(0));
LDCCOTTACCP_.old_tb0_1(0):=500000000013705;
LDCCOTTACCP_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCCOTTACCP_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCCOTTACCP_.tb0_1(0):=LDCCOTTACCP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCCOTTACCP_.tb0_0(0),
LDCCOTTACCP_.tb0_1(0),
'Configuración costo promedio x tipo de trabajo y actividad'
,
null,
'34'
,
8,
2,
61,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
137,
'C'
,
to_date('14-08-2024 09:13:25','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb1_0(0):=2741;
LDCCOTTACCP_.tb1_1(0):=LDCCOTTACCP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (0)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCCOTTACCP_.tb1_0(0),
LDCCOTTACCP_.tb1_1(0),
5530,
4940,
'N'
,
'I'
);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb1_0(1):=2742;
LDCCOTTACCP_.tb1_1(1):=LDCCOTTACCP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (1)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCCOTTACCP_.tb1_0(1),
LDCCOTTACCP_.tb1_1(1),
5530,
4940,
'N'
,
'D'
);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb1_0(2):=2743;
LDCCOTTACCP_.tb1_1(2):=LDCCOTTACCP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (2)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCCOTTACCP_.tb1_0(2),
LDCCOTTACCP_.tb1_1(2),
5530,
4940,
'N'
,
'U'
);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb2_0(0):=1;
LDCCOTTACCP_.tb2_1(0):=LDCCOTTACCP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCCOTTACCP_.tb2_0(0),
LDCCOTTACCP_.tb2_1(0));

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb3_0(0):=LDCCOTTACCP_.tb0_1(0);
LDCCOTTACCP_.old_tb3_1(0):=4940;
LDCCOTTACCP_.tb3_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYNAME(LDCCOTTACCP_.old_tb3_1(0)), 'ENTITY');
LDCCOTTACCP_.tb3_1(0):=LDCCOTTACCP_.tb3_1(0);
LDCCOTTACCP_.old_tb3_2(0):=null;
LDCCOTTACCP_.tb3_2(0):=CASE WHEN (LDCCOTTACCP_.old_tb3_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYNAME(LDCCOTTACCP_.old_tb3_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCCOTTACCP_.tb3_0(0),
LDCCOTTACCP_.tb3_1(0),
LDCCOTTACCP_.tb3_2(0),
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
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb4_0(0):=LDCCOTTACCP_.tb3_0(0);
LDCCOTTACCP_.tb4_1(0):=LDCCOTTACCP_.tb3_1(0);
LDCCOTTACCP_.old_tb4_2(0):=90167165;
LDCCOTTACCP_.tb4_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYATTRIBUTENAME(LDCCOTTACCP_.old_tb4_2(0)), 'ATTRIBUTE');
LDCCOTTACCP_.tb4_2(0):=LDCCOTTACCP_.tb4_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOTTACCP_.tb4_0(0),
LDCCOTTACCP_.tb4_1(0),
LDCCOTTACCP_.tb4_2(0),
0,
'Y'
,
'N'
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
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb4_0(1):=LDCCOTTACCP_.tb3_0(0);
LDCCOTTACCP_.tb4_1(1):=LDCCOTTACCP_.tb3_1(0);
LDCCOTTACCP_.old_tb4_2(1):=90167166;
LDCCOTTACCP_.tb4_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYATTRIBUTENAME(LDCCOTTACCP_.old_tb4_2(1)), 'ATTRIBUTE');
LDCCOTTACCP_.tb4_2(1):=LDCCOTTACCP_.tb4_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOTTACCP_.tb4_0(1),
LDCCOTTACCP_.tb4_1(1),
LDCCOTTACCP_.tb4_2(1),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  TASK_TYPE_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM OR_TASK_TYPE ORDER BY TASK_TYPE_ID ASC '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'TASK_TYPE_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM OR_TASK_TYPE|'
,
null,
'ORDER BY TASK_TYPE_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb4_0(2):=LDCCOTTACCP_.tb3_0(0);
LDCCOTTACCP_.tb4_1(2):=LDCCOTTACCP_.tb3_1(0);
LDCCOTTACCP_.old_tb4_2(2):=90167167;
LDCCOTTACCP_.tb4_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYATTRIBUTENAME(LDCCOTTACCP_.old_tb4_2(2)), 'ATTRIBUTE');
LDCCOTTACCP_.tb4_2(2):=LDCCOTTACCP_.tb4_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOTTACCP_.tb4_0(2),
LDCCOTTACCP_.tb4_1(2),
LDCCOTTACCP_.tb4_2(2),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO_ACTIVIDAD "CODIGO ACTIVIDAD" , DESCRIPCION_ACTIVIDAD "DESCRIPCION ACTIVIDAD" , TIPO_TRABAJO "TIPO DE TRABAJO"  FROM LDC_OR_TASK_TYPES_ITEMS WHERE TIPO_TRABAJO = [TIPO_TRAB] '
,
'N'
,
'CODIGO ACTIVIDAD'
,
'DESCRIPCION ACTIVIDAD'
,
'CODIGO_ACTIVIDAD CODIGO ACTIVIDAD|DESCRIPCION_ACTIVIDAD DESCRIPCION ACTIVIDAD|TIPO_TRABAJO TIPO DE TRABAJO|'
,
'FROM LDC_OR_TASK_TYPES_ITEMS|'
,
'WHERE TIPO_TRABAJO = TIPO_TRAB|'
,
null,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb4_0(3):=LDCCOTTACCP_.tb3_0(0);
LDCCOTTACCP_.tb4_1(3):=LDCCOTTACCP_.tb3_1(0);
LDCCOTTACCP_.old_tb4_2(3):=90167168;
LDCCOTTACCP_.tb4_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYATTRIBUTENAME(LDCCOTTACCP_.old_tb4_2(3)), 'ATTRIBUTE');
LDCCOTTACCP_.tb4_2(3):=LDCCOTTACCP_.tb4_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOTTACCP_.tb4_0(3),
LDCCOTTACCP_.tb4_1(3),
LDCCOTTACCP_.tb4_2(3),
4,
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
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;

LDCCOTTACCP_.tb4_0(4):=LDCCOTTACCP_.tb3_0(0);
LDCCOTTACCP_.tb4_1(4):=LDCCOTTACCP_.tb3_1(0);
LDCCOTTACCP_.old_tb4_2(4):=90167169;
LDCCOTTACCP_.tb4_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOTTACCP_.TBENTITYATTRIBUTENAME(LDCCOTTACCP_.old_tb4_2(4)), 'ATTRIBUTE');
LDCCOTTACCP_.tb4_2(4):=LDCCOTTACCP_.tb4_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOTTACCP_.tb4_0(4),
LDCCOTTACCP_.tb4_1(4),
LDCCOTTACCP_.tb4_2(4),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_UNIT_ID "IDENTIFICADOR DE LA UNIDAD DE TRABAJO" , NAME "NOMBRE"  FROM OR_OPERATING_UNIT ORDER BY OPERATING_UNIT_ID ASC '
,
'N'
,
'IDENTIFICADOR DE LA UNIDAD DE TRABAJO'
,
'NOMBRE'
,
'OPERATING_UNIT_ID Identificador de la Unidad de Trabajo|NAME Nombre|'
,
'FROM OR_OPERATING_UNIT|'
,
null,
'ORDER BY OPERATING_UNIT_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
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
 nuIndexInternal := LDCCOTTACCP_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCCOTTACCP_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCCOTTACCP_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCCOTTACCP_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCCOTTACCP_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCCOTTACCP_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCCOTTACCP_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCCOTTACCP_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCCOTTACCP_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCCOTTACCP_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCCOTTACCP_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCCOTTACCP_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCCOTTACCP_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCCOTTACCP_.tbUserException(nuIndex).user_id, LDCCOTTACCP_.tbUserException(nuIndex).status , LDCCOTTACCP_.tbUserException(nuIndex).usr_exc_type_id, LDCCOTTACCP_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCCOTTACCP_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCCOTTACCP_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCCOTTACCP_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCCOTTACCP_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCCOTTACCP_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCCOTTACCP_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCCOTTACCP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCCOTTACCP_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCCOTTACCP_******************************'); end;
/

