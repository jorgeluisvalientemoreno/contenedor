BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDC_MAGRUPLOCA_',
'CREATE OR REPLACE PACKAGE LDC_MAGRUPLOCA_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDC_MAGRUPLOCA''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDC_MAGRUPLOCA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDC_MAGRUPLOCA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDC_MAGRUPLOCA'' ' || chr(10) ||
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
'END LDC_MAGRUPLOCA_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDC_MAGRUPLOCA_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
Open LDC_MAGRUPLOCA_.cuRoleExecutables;
loop
 fetch LDC_MAGRUPLOCA_.cuRoleExecutables INTO LDC_MAGRUPLOCA_.rcRoleExecutables;
 exit when  LDC_MAGRUPLOCA_.cuRoleExecutables%notfound;
 LDC_MAGRUPLOCA_.tbRoleExecutables(nuIndex) := LDC_MAGRUPLOCA_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDC_MAGRUPLOCA_.cuRoleExecutables;
nuIndex := 0;
Open LDC_MAGRUPLOCA_.cuUserExceptions ;
loop
 fetch LDC_MAGRUPLOCA_.cuUserExceptions INTO  LDC_MAGRUPLOCA_.rcUserExceptions;
 exit when LDC_MAGRUPLOCA_.cuUserExceptions%notfound;
 LDC_MAGRUPLOCA_.tbUserException(nuIndex):=LDC_MAGRUPLOCA_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDC_MAGRUPLOCA_.cuUserExceptions;
nuIndex := 0;
Open LDC_MAGRUPLOCA_.cuExecEntities ;
loop
 fetch LDC_MAGRUPLOCA_.cuExecEntities INTO  LDC_MAGRUPLOCA_.rcExecEntities;
 exit when LDC_MAGRUPLOCA_.cuExecEntities%notfound;
 LDC_MAGRUPLOCA_.tbExecEntities(nuIndex):=LDC_MAGRUPLOCA_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDC_MAGRUPLOCA_.cuExecEntities;

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA'
);

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDC_MAGRUPLOCA_.tbEntityName(4249) := 'LDC_GRUPO';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145104) := 'LDC_GRUPO@GRUPCODI';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145105) := 'LDC_GRUPO@GRUPDESC';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145106) := 'LDC_GRUPO@GRUPTAMU';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90166787) := 'LDC_GRUPO@VIGENCIA_INIT_DATE';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90166788) := 'LDC_GRUPO@VIGENCIA_FINAL_DATE';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90200364) := 'LDC_GRUPO@GRUPMURE';
 
   LDC_MAGRUPLOCA_.tbEntityName(4250) := 'LDC_GRUPO_LOCALIDAD';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145107) := 'LDC_GRUPO_LOCALIDAD@GRLOCODI';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145108) := 'LDC_GRUPO_LOCALIDAD@GRUPCODI';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145109) := 'LDC_GRUPO_LOCALIDAD@GRLOIDLO';
   LDC_MAGRUPLOCA_.tbEntityAttributeName(90145110) := 'LDC_GRUPO_LOCALIDAD@GRLOSEOP';
 
END; 
/

BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA');

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA') AND ROLE_ID=1;

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA');

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA');

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA'));

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA');

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDC_MAGRUPLOCA';

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.old_tb0_0(0):='LDC_MAGRUPLOCA'
;
LDC_MAGRUPLOCA_.tb0_0(0):=UPPER(LDC_MAGRUPLOCA_.old_tb0_0(0));
LDC_MAGRUPLOCA_.old_tb0_1(0):=500000000012295;
LDC_MAGRUPLOCA_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_MAGRUPLOCA_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDC_MAGRUPLOCA_.tb0_1(0):=LDC_MAGRUPLOCA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDC_MAGRUPLOCA_.tb0_0(0),
LDC_MAGRUPLOCA_.tb0_1(0),
'Localidades por grupo'
,
null,
'34'
,
8,
2,
4,
1,
1345,
'Y'
,
null,
'N'
,
'Y'
,
85,
'C'
,
to_date('14-05-2025 07:40:59','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb1_0(0):=1;
LDC_MAGRUPLOCA_.tb1_1(0):=LDC_MAGRUPLOCA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDC_MAGRUPLOCA_.tb1_0(0),
LDC_MAGRUPLOCA_.tb1_1(0));

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb2_0(0):=LDC_MAGRUPLOCA_.tb0_1(0);
LDC_MAGRUPLOCA_.old_tb2_1(0):=4249;
LDC_MAGRUPLOCA_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYNAME(LDC_MAGRUPLOCA_.old_tb2_1(0)), 'ENTITY');
LDC_MAGRUPLOCA_.tb2_1(0):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb2_2(0):=null;
LDC_MAGRUPLOCA_.tb2_2(0):=CASE WHEN (LDC_MAGRUPLOCA_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYNAME(LDC_MAGRUPLOCA_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDC_MAGRUPLOCA_.tb2_0(0),
LDC_MAGRUPLOCA_.tb2_1(0),
LDC_MAGRUPLOCA_.tb2_2(0),
'G'
,
0,
0,
null,
null,
null,
'N'
,
'N'
,
'N'
,
null);

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(0):=LDC_MAGRUPLOCA_.tb2_0(0);
LDC_MAGRUPLOCA_.tb3_1(0):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb3_2(0):=90145104;
LDC_MAGRUPLOCA_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(0)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(0):=LDC_MAGRUPLOCA_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(0),
LDC_MAGRUPLOCA_.tb3_1(0),
LDC_MAGRUPLOCA_.tb3_2(0),
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(1):=LDC_MAGRUPLOCA_.tb2_0(0);
LDC_MAGRUPLOCA_.tb3_1(1):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb3_2(1):=90145105;
LDC_MAGRUPLOCA_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(1)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(1):=LDC_MAGRUPLOCA_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(1),
LDC_MAGRUPLOCA_.tb3_1(1),
LDC_MAGRUPLOCA_.tb3_2(1),
1,
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(2):=LDC_MAGRUPLOCA_.tb2_0(0);
LDC_MAGRUPLOCA_.tb3_1(2):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb3_2(2):=90145106;
LDC_MAGRUPLOCA_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(2)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(2):=LDC_MAGRUPLOCA_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(2),
LDC_MAGRUPLOCA_.tb3_1(2),
LDC_MAGRUPLOCA_.tb3_2(2),
2,
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(3):=LDC_MAGRUPLOCA_.tb2_0(0);
LDC_MAGRUPLOCA_.tb3_1(3):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb3_2(3):=90166787;
LDC_MAGRUPLOCA_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(3)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(3):=LDC_MAGRUPLOCA_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(3),
LDC_MAGRUPLOCA_.tb3_1(3),
LDC_MAGRUPLOCA_.tb3_2(3),
3,
'N'
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(4):=LDC_MAGRUPLOCA_.tb2_0(0);
LDC_MAGRUPLOCA_.tb3_1(4):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb3_2(4):=90166788;
LDC_MAGRUPLOCA_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(4)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(4):=LDC_MAGRUPLOCA_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(4),
LDC_MAGRUPLOCA_.tb3_1(4),
LDC_MAGRUPLOCA_.tb3_2(4),
4,
'N'
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(5):=LDC_MAGRUPLOCA_.tb2_0(0);
LDC_MAGRUPLOCA_.tb3_1(5):=LDC_MAGRUPLOCA_.tb2_1(0);
LDC_MAGRUPLOCA_.old_tb3_2(5):=90200364;
LDC_MAGRUPLOCA_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(5)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(5):=LDC_MAGRUPLOCA_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(5),
LDC_MAGRUPLOCA_.tb3_1(5),
LDC_MAGRUPLOCA_.tb3_2(5),
5,
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb2_0(1):=LDC_MAGRUPLOCA_.tb0_1(0);
LDC_MAGRUPLOCA_.old_tb2_1(1):=4250;
LDC_MAGRUPLOCA_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYNAME(LDC_MAGRUPLOCA_.old_tb2_1(1)), 'ENTITY');
LDC_MAGRUPLOCA_.tb2_1(1):=LDC_MAGRUPLOCA_.tb2_1(1);
LDC_MAGRUPLOCA_.old_tb2_2(1):=4249;
LDC_MAGRUPLOCA_.tb2_2(1):=CASE WHEN (LDC_MAGRUPLOCA_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYNAME(LDC_MAGRUPLOCA_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDC_MAGRUPLOCA_.tb2_0(1),
LDC_MAGRUPLOCA_.tb2_1(1),
LDC_MAGRUPLOCA_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDC_GRUPO.GRUPCODI  =  LDC_GRUPO_LOCALIDAD.GRUPCODI '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(6):=LDC_MAGRUPLOCA_.tb2_0(1);
LDC_MAGRUPLOCA_.tb3_1(6):=LDC_MAGRUPLOCA_.tb2_1(1);
LDC_MAGRUPLOCA_.old_tb3_2(6):=90145107;
LDC_MAGRUPLOCA_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(6)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(6):=LDC_MAGRUPLOCA_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(6),
LDC_MAGRUPLOCA_.tb3_1(6),
LDC_MAGRUPLOCA_.tb3_2(6),
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(7):=LDC_MAGRUPLOCA_.tb2_0(1);
LDC_MAGRUPLOCA_.tb3_1(7):=LDC_MAGRUPLOCA_.tb2_1(1);
LDC_MAGRUPLOCA_.old_tb3_2(7):=90145108;
LDC_MAGRUPLOCA_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(7)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(7):=LDC_MAGRUPLOCA_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(7),
LDC_MAGRUPLOCA_.tb3_1(7),
LDC_MAGRUPLOCA_.tb3_2(7),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  GRUPCODI "ID" , GRUPDESC "DESCRIPCI¿N"  FROM LDC_GRUPO '
,
'N'
,
'ID'
,
'DESCRIPCI¿N'
,
'GRUPCODI Id|GRUPDESC Descripci¿n|'
,
'FROM LDC_GRUPO|'
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(8):=LDC_MAGRUPLOCA_.tb2_0(1);
LDC_MAGRUPLOCA_.tb3_1(8):=LDC_MAGRUPLOCA_.tb2_1(1);
LDC_MAGRUPLOCA_.old_tb3_2(8):=90145109;
LDC_MAGRUPLOCA_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(8)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(8):=LDC_MAGRUPLOCA_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(8),
LDC_MAGRUPLOCA_.tb3_1(8),
LDC_MAGRUPLOCA_.tb3_2(8),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  GEOGRAP_LOCATION_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_GEOGRA_LOCATION WHERE GEOG_LOCA_AREA_TYPE = 3 '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'GEOGRAP_LOCATION_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_GEOGRA_LOCATION|'
,
'WHERE GEOG_LOCA_AREA_TYPE = 3|'
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;

LDC_MAGRUPLOCA_.tb3_0(9):=LDC_MAGRUPLOCA_.tb2_0(1);
LDC_MAGRUPLOCA_.tb3_1(9):=LDC_MAGRUPLOCA_.tb2_1(1);
LDC_MAGRUPLOCA_.old_tb3_2(9):=90145110;
LDC_MAGRUPLOCA_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDC_MAGRUPLOCA_.TBENTITYATTRIBUTENAME(LDC_MAGRUPLOCA_.old_tb3_2(9)), 'ATTRIBUTE');
LDC_MAGRUPLOCA_.tb3_2(9):=LDC_MAGRUPLOCA_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDC_MAGRUPLOCA_.tb3_0(9),
LDC_MAGRUPLOCA_.tb3_1(9),
LDC_MAGRUPLOCA_.tb3_2(9),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  GEOGRAP_LOCATION_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_GEOGRA_LOCATION WHERE GEO_LOCA_FATHER_ID = [GRLOIDLO] AND GEOG_LOCA_AREA_TYPE = 4 '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'GEOGRAP_LOCATION_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_GEOGRA_LOCATION|'
,
'WHERE GEO_LOCA_FATHER_ID = GRLOIDLO|AND GEOG_LOCA_AREA_TYPE = 4|'
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
LDC_MAGRUPLOCA_.blProcessStatus := false;
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
 nuIndexInternal := LDC_MAGRUPLOCA_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDC_MAGRUPLOCA_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDC_MAGRUPLOCA_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDC_MAGRUPLOCA_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDC_MAGRUPLOCA_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDC_MAGRUPLOCA_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDC_MAGRUPLOCA_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDC_MAGRUPLOCA_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDC_MAGRUPLOCA_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDC_MAGRUPLOCA_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDC_MAGRUPLOCA_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDC_MAGRUPLOCA_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDC_MAGRUPLOCA_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDC_MAGRUPLOCA_.tbUserException(nuIndex).user_id, LDC_MAGRUPLOCA_.tbUserException(nuIndex).status , LDC_MAGRUPLOCA_.tbUserException(nuIndex).usr_exc_type_id, LDC_MAGRUPLOCA_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDC_MAGRUPLOCA_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDC_MAGRUPLOCA_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDC_MAGRUPLOCA_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDC_MAGRUPLOCA_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDC_MAGRUPLOCA_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDC_MAGRUPLOCA_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDC_MAGRUPLOCA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDC_MAGRUPLOCA_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDC_MAGRUPLOCA_******************************'); end;
/

