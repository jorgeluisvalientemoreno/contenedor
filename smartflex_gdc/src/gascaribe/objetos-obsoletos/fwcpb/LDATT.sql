BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDATT_',
'CREATE OR REPLACE PACKAGE LDATT_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDATT''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDATT'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDATT'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDATT'' ' || chr(10) ||
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
'END LDATT_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDATT_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
Open LDATT_.cuRoleExecutables;
loop
 fetch LDATT_.cuRoleExecutables INTO LDATT_.rcRoleExecutables;
 exit when  LDATT_.cuRoleExecutables%notfound;
 LDATT_.tbRoleExecutables(nuIndex) := LDATT_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDATT_.cuRoleExecutables;
nuIndex := 0;
Open LDATT_.cuUserExceptions ;
loop
 fetch LDATT_.cuUserExceptions INTO  LDATT_.rcUserExceptions;
 exit when LDATT_.cuUserExceptions%notfound;
 LDATT_.tbUserException(nuIndex):=LDATT_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDATT_.cuUserExceptions;
nuIndex := 0;
Open LDATT_.cuExecEntities ;
loop
 fetch LDATT_.cuExecEntities INTO  LDATT_.rcExecEntities;
 exit when LDATT_.cuExecEntities%notfound;
 LDATT_.tbExecEntities(nuIndex):=LDATT_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDATT_.cuExecEntities;

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT'
);

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDATT_.tbEntityName(4655) := 'LDC_TASK_ACTIVITY_TYPE';
   LDATT_.tbEntityAttributeName(90160623) := 'LDC_TASK_ACTIVITY_TYPE@ACTI_TASK_TYPE_ID';
   LDATT_.tbEntityAttributeName(90160624) := 'LDC_TASK_ACTIVITY_TYPE@LEGA_TASK_TYPE_ID';
   LDATT_.tbEntityAttributeName(90160625) := 'LDC_TASK_ACTIVITY_TYPE@LEGA_ACTIVITY_ID';
   LDATT_.tbEntityAttributeName(90160626) := 'LDC_TASK_ACTIVITY_TYPE@NEW_TASK_TYPE_ID';
   LDATT_.tbEntityAttributeName(90160627) := 'LDC_TASK_ACTIVITY_TYPE@NEW_ACTIVITY_ID';
 
END; 
/

BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT');

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT') AND ROLE_ID=1;

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT');

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT');

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT'));

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDATT');

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDATT';

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.old_tb0_0(0):='LDATT'
;
LDATT_.tb0_0(0):=UPPER(LDATT_.old_tb0_0(0));
LDATT_.old_tb0_1(0):=500000000013052;
LDATT_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDATT_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDATT_.tb0_1(0):=LDATT_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDATT_.tb0_0(0),
LDATT_.tb0_1(0),
'Configuración de actividades por tipo de trabajo y actividades de apoyo'
,
null,
'5'
,
8,
2,
4,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
7,
null,
to_date('25-11-2017 16:02:03','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb1_0(0):=1;
LDATT_.tb1_1(0):=LDATT_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDATT_.tb1_0(0),
LDATT_.tb1_1(0));

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb2_0(0):=LDATT_.tb0_1(0);
LDATT_.old_tb2_1(0):=4655;
LDATT_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYNAME(LDATT_.old_tb2_1(0)), 'ENTITY');
LDATT_.tb2_1(0):=LDATT_.tb2_1(0);
LDATT_.old_tb2_2(0):=null;
LDATT_.tb2_2(0):=CASE WHEN (LDATT_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYNAME(LDATT_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDATT_.tb2_0(0),
LDATT_.tb2_1(0),
LDATT_.tb2_2(0),
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
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb3_0(0):=LDATT_.tb2_0(0);
LDATT_.tb3_1(0):=LDATT_.tb2_1(0);
LDATT_.old_tb3_2(0):=90160623;
LDATT_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYATTRIBUTENAME(LDATT_.old_tb3_2(0)), 'ATTRIBUTE');
LDATT_.tb3_2(0):=LDATT_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDATT_.tb3_0(0),
LDATT_.tb3_1(0),
LDATT_.tb3_2(0),
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
null,
null,
null);

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb3_0(1):=LDATT_.tb2_0(0);
LDATT_.tb3_1(1):=LDATT_.tb2_1(0);
LDATT_.old_tb3_2(1):=90160624;
LDATT_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYATTRIBUTENAME(LDATT_.old_tb3_2(1)), 'ATTRIBUTE');
LDATT_.tb3_2(1):=LDATT_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDATT_.tb3_0(1),
LDATT_.tb3_1(1),
LDATT_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  TASK_TYPE_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM OR_TASK_TYPE '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'TASK_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM OR_TASK_TYPE|'
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
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb3_0(2):=LDATT_.tb2_0(0);
LDATT_.tb3_1(2):=LDATT_.tb2_1(0);
LDATT_.old_tb3_2(2):=90160625;
LDATT_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYATTRIBUTENAME(LDATT_.old_tb3_2(2)), 'ATTRIBUTE');
LDATT_.tb3_2(2):=LDATT_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDATT_.tb3_0(2),
LDATT_.tb3_1(2),
LDATT_.tb3_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID = 2 '
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
'WHERE ITEM_CLASSIF_ID = 2|'
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
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb3_0(3):=LDATT_.tb2_0(0);
LDATT_.tb3_1(3):=LDATT_.tb2_1(0);
LDATT_.old_tb3_2(3):=90160626;
LDATT_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYATTRIBUTENAME(LDATT_.old_tb3_2(3)), 'ATTRIBUTE');
LDATT_.tb3_2(3):=LDATT_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDATT_.tb3_0(3),
LDATT_.tb3_1(3),
LDATT_.tb3_2(3),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  TASK_TYPE_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM OR_TASK_TYPE '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'TASK_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM OR_TASK_TYPE|'
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
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;

LDATT_.tb3_0(4):=LDATT_.tb2_0(0);
LDATT_.tb3_1(4):=LDATT_.tb2_1(0);
LDATT_.old_tb3_2(4):=90160627;
LDATT_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDATT_.TBENTITYATTRIBUTENAME(LDATT_.old_tb3_2(4)), 'ATTRIBUTE');
LDATT_.tb3_2(4):=LDATT_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDATT_.tb3_0(4),
LDATT_.tb3_1(4),
LDATT_.tb3_2(4),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID = 2 '
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
'WHERE ITEM_CLASSIF_ID = 2|'
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
LDATT_.blProcessStatus := false;
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
 nuIndexInternal := LDATT_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDATT_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDATT_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDATT_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDATT_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDATT_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDATT_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDATT_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDATT_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDATT_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDATT_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDATT_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDATT_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDATT_.tbUserException(nuIndex).user_id, LDATT_.tbUserException(nuIndex).status , LDATT_.tbUserException(nuIndex).usr_exc_type_id, LDATT_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDATT_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDATT_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDATT_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDATT_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDATT_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDATT_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDATT_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDATT_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDATT_******************************'); end;
/

