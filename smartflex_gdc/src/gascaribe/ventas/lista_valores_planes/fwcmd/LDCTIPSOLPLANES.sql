BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCTIPSOLPLANES_',
'CREATE OR REPLACE PACKAGE LDCTIPSOLPLANES_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCTIPSOLPLANES''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCTIPSOLPLANES'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCTIPSOLPLANES'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCTIPSOLPLANES'' ' || chr(10) ||
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
'END LDCTIPSOLPLANES_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCTIPSOLPLANES_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
Open LDCTIPSOLPLANES_.cuRoleExecutables;
loop
 fetch LDCTIPSOLPLANES_.cuRoleExecutables INTO LDCTIPSOLPLANES_.rcRoleExecutables;
 exit when  LDCTIPSOLPLANES_.cuRoleExecutables%notfound;
 LDCTIPSOLPLANES_.tbRoleExecutables(nuIndex) := LDCTIPSOLPLANES_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCTIPSOLPLANES_.cuRoleExecutables;
nuIndex := 0;
Open LDCTIPSOLPLANES_.cuUserExceptions ;
loop
 fetch LDCTIPSOLPLANES_.cuUserExceptions INTO  LDCTIPSOLPLANES_.rcUserExceptions;
 exit when LDCTIPSOLPLANES_.cuUserExceptions%notfound;
 LDCTIPSOLPLANES_.tbUserException(nuIndex):=LDCTIPSOLPLANES_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCTIPSOLPLANES_.cuUserExceptions;
nuIndex := 0;
Open LDCTIPSOLPLANES_.cuExecEntities ;
loop
 fetch LDCTIPSOLPLANES_.cuExecEntities INTO  LDCTIPSOLPLANES_.rcExecEntities;
 exit when LDCTIPSOLPLANES_.cuExecEntities%notfound;
 LDCTIPSOLPLANES_.tbExecEntities(nuIndex):=LDCTIPSOLPLANES_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCTIPSOLPLANES_.cuExecEntities;

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES'
);

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCTIPSOLPLANES_.tbEntityName(6031) := 'LDC_TIPSOLPLANCOMERCIAL';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198276) := 'LDC_TIPSOLPLANCOMERCIAL@PACKAGE_TYPE_ID';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198277) := 'LDC_TIPSOLPLANCOMERCIAL@COMMERCIAL_PLAN_ID';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198278) := 'LDC_TIPSOLPLANCOMERCIAL@CREATED_TSPC';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198279) := 'LDC_TIPSOLPLANCOMERCIAL@USUARIO_CREATED';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198280) := 'LDC_TIPSOLPLANCOMERCIAL@UPDATED_TSPC';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198281) := 'LDC_TIPSOLPLANCOMERCIAL@USUARIO_UPDATED';
 
   LDCTIPSOLPLANES_.tbEntityName(6032) := 'LDC_TIPSOLPLANFINAN';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198282) := 'LDC_TIPSOLPLANFINAN@PACKAGE_TYPE_ID';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198283) := 'LDC_TIPSOLPLANFINAN@PLDICODI';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198284) := 'LDC_TIPSOLPLANFINAN@CREATED_TSPF';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198285) := 'LDC_TIPSOLPLANFINAN@USUARIO_CREATED';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198286) := 'LDC_TIPSOLPLANFINAN@UPDATED_TSPF';
   LDCTIPSOLPLANES_.tbEntityAttributeName(90198287) := 'LDC_TIPSOLPLANFINAN@USUARIO_UPDATED';
 
END; 
/

BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES');

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES') AND ROLE_ID=1;

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES');

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES');

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES'));

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES');

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCTIPSOLPLANES';

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.old_tb0_0(0):='LDCTIPSOLPLANES'
;
LDCTIPSOLPLANES_.tb0_0(0):=UPPER(LDCTIPSOLPLANES_.old_tb0_0(0));
LDCTIPSOLPLANES_.old_tb0_1(0):=500000000015634;
LDCTIPSOLPLANES_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCTIPSOLPLANES_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCTIPSOLPLANES_.tb0_1(0):=LDCTIPSOLPLANES_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCTIPSOLPLANES_.tb0_0(0),
LDCTIPSOLPLANES_.tb0_1(0),
'TIPO SOLICITUD POR PLANES'
,
null,
'2'
,
8,
2,
16,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
4,
null,
to_date('27-07-2022 10:36:24','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb1_0(0):=1;
LDCTIPSOLPLANES_.tb1_1(0):=LDCTIPSOLPLANES_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCTIPSOLPLANES_.tb1_0(0),
LDCTIPSOLPLANES_.tb1_1(0));

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb2_0(0):=LDCTIPSOLPLANES_.tb0_1(0);
LDCTIPSOLPLANES_.old_tb2_1(0):=6031;
LDCTIPSOLPLANES_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYNAME(LDCTIPSOLPLANES_.old_tb2_1(0)), 'ENTITY');
LDCTIPSOLPLANES_.tb2_1(0):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb2_2(0):=null;
LDCTIPSOLPLANES_.tb2_2(0):=CASE WHEN (LDCTIPSOLPLANES_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYNAME(LDCTIPSOLPLANES_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCTIPSOLPLANES_.tb2_0(0),
LDCTIPSOLPLANES_.tb2_1(0),
LDCTIPSOLPLANES_.tb2_2(0),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(0):=LDCTIPSOLPLANES_.tb2_0(0);
LDCTIPSOLPLANES_.tb3_1(0):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb3_2(0):=90198276;
LDCTIPSOLPLANES_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(0)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(0):=LDCTIPSOLPLANES_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(0),
LDCTIPSOLPLANES_.tb3_1(0),
LDCTIPSOLPLANES_.tb3_2(0),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT PACKAGE_TYPE_ID "Código",DESCRIPTION "Descripción" FROM PS_PACKAGE_TYPE'
,
'N'
,
'Código'
,
'Descripción'
,
'PACKAGE_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM PS_PACKAGE_TYPE'
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(1):=LDCTIPSOLPLANES_.tb2_0(0);
LDCTIPSOLPLANES_.tb3_1(1):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb3_2(1):=90198277;
LDCTIPSOLPLANES_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(1)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(1):=LDCTIPSOLPLANES_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(1),
LDCTIPSOLPLANES_.tb3_1(1),
LDCTIPSOLPLANES_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT COMMERCIAL_PLAN_ID "Código",DESCRIPTION "Descripción" FROM CC_COMMERCIAL_PLAN'
,
'N'
,
'Código'
,
'Descripción'
,
'COMMERCIAL_PLAN_ID Código|DESCRIPTION Descripción|'
,
'FROM CC_COMMERCIAL_PLAN'
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(2):=LDCTIPSOLPLANES_.tb2_0(0);
LDCTIPSOLPLANES_.tb3_1(2):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb3_2(2):=90198278;
LDCTIPSOLPLANES_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(2)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(2):=LDCTIPSOLPLANES_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(2),
LDCTIPSOLPLANES_.tb3_1(2),
LDCTIPSOLPLANES_.tb3_2(2),
2,
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(3):=LDCTIPSOLPLANES_.tb2_0(0);
LDCTIPSOLPLANES_.tb3_1(3):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb3_2(3):=90198279;
LDCTIPSOLPLANES_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(3)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(3):=LDCTIPSOLPLANES_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(3),
LDCTIPSOLPLANES_.tb3_1(3),
LDCTIPSOLPLANES_.tb3_2(3),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(4):=LDCTIPSOLPLANES_.tb2_0(0);
LDCTIPSOLPLANES_.tb3_1(4):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb3_2(4):=90198280;
LDCTIPSOLPLANES_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(4)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(4):=LDCTIPSOLPLANES_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(4),
LDCTIPSOLPLANES_.tb3_1(4),
LDCTIPSOLPLANES_.tb3_2(4),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(5):=LDCTIPSOLPLANES_.tb2_0(0);
LDCTIPSOLPLANES_.tb3_1(5):=LDCTIPSOLPLANES_.tb2_1(0);
LDCTIPSOLPLANES_.old_tb3_2(5):=90198281;
LDCTIPSOLPLANES_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(5)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(5):=LDCTIPSOLPLANES_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(5),
LDCTIPSOLPLANES_.tb3_1(5),
LDCTIPSOLPLANES_.tb3_2(5),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb2_0(1):=LDCTIPSOLPLANES_.tb0_1(0);
LDCTIPSOLPLANES_.old_tb2_1(1):=6032;
LDCTIPSOLPLANES_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYNAME(LDCTIPSOLPLANES_.old_tb2_1(1)), 'ENTITY');
LDCTIPSOLPLANES_.tb2_1(1):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb2_2(1):=null;
LDCTIPSOLPLANES_.tb2_2(1):=CASE WHEN (LDCTIPSOLPLANES_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYNAME(LDCTIPSOLPLANES_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCTIPSOLPLANES_.tb2_0(1),
LDCTIPSOLPLANES_.tb2_1(1),
LDCTIPSOLPLANES_.tb2_2(1),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(6):=LDCTIPSOLPLANES_.tb2_0(1);
LDCTIPSOLPLANES_.tb3_1(6):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb3_2(6):=90198282;
LDCTIPSOLPLANES_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(6)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(6):=LDCTIPSOLPLANES_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(6),
LDCTIPSOLPLANES_.tb3_1(6),
LDCTIPSOLPLANES_.tb3_2(6),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT PACKAGE_TYPE_ID "Código",DESCRIPTION "Descripción" FROM PS_PACKAGE_TYPE'
,
'N'
,
'Código'
,
'Descripción'
,
'PACKAGE_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM PS_PACKAGE_TYPE'
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(7):=LDCTIPSOLPLANES_.tb2_0(1);
LDCTIPSOLPLANES_.tb3_1(7):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb3_2(7):=90198283;
LDCTIPSOLPLANES_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(7)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(7):=LDCTIPSOLPLANES_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(7),
LDCTIPSOLPLANES_.tb3_1(7),
LDCTIPSOLPLANES_.tb3_2(7),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT PLDICODI "Código",PLDIDESC "Descripción" FROM PLANDIFE'
,
'N'
,
'Código'
,
'Descripción'
,
'PLDICODI Código|PLDIDESC Descripción|'
,
'FROM PLANDIFE'
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(8):=LDCTIPSOLPLANES_.tb2_0(1);
LDCTIPSOLPLANES_.tb3_1(8):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb3_2(8):=90198284;
LDCTIPSOLPLANES_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(8)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(8):=LDCTIPSOLPLANES_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(8),
LDCTIPSOLPLANES_.tb3_1(8),
LDCTIPSOLPLANES_.tb3_2(8),
2,
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(9):=LDCTIPSOLPLANES_.tb2_0(1);
LDCTIPSOLPLANES_.tb3_1(9):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb3_2(9):=90198285;
LDCTIPSOLPLANES_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(9)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(9):=LDCTIPSOLPLANES_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(9),
LDCTIPSOLPLANES_.tb3_1(9),
LDCTIPSOLPLANES_.tb3_2(9),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(10):=LDCTIPSOLPLANES_.tb2_0(1);
LDCTIPSOLPLANES_.tb3_1(10):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb3_2(10):=90198286;
LDCTIPSOLPLANES_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(10)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(10):=LDCTIPSOLPLANES_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(10),
LDCTIPSOLPLANES_.tb3_1(10),
LDCTIPSOLPLANES_.tb3_2(10),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;

LDCTIPSOLPLANES_.tb3_0(11):=LDCTIPSOLPLANES_.tb2_0(1);
LDCTIPSOLPLANES_.tb3_1(11):=LDCTIPSOLPLANES_.tb2_1(1);
LDCTIPSOLPLANES_.old_tb3_2(11):=90198287;
LDCTIPSOLPLANES_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTIPSOLPLANES_.TBENTITYATTRIBUTENAME(LDCTIPSOLPLANES_.old_tb3_2(11)), 'ATTRIBUTE');
LDCTIPSOLPLANES_.tb3_2(11):=LDCTIPSOLPLANES_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTIPSOLPLANES_.tb3_0(11),
LDCTIPSOLPLANES_.tb3_1(11),
LDCTIPSOLPLANES_.tb3_2(11),
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
LDCTIPSOLPLANES_.blProcessStatus := false;
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
 nuIndexInternal := LDCTIPSOLPLANES_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCTIPSOLPLANES_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCTIPSOLPLANES_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCTIPSOLPLANES_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCTIPSOLPLANES_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCTIPSOLPLANES_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCTIPSOLPLANES_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCTIPSOLPLANES_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCTIPSOLPLANES_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCTIPSOLPLANES_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCTIPSOLPLANES_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCTIPSOLPLANES_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCTIPSOLPLANES_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCTIPSOLPLANES_.tbUserException(nuIndex).user_id, LDCTIPSOLPLANES_.tbUserException(nuIndex).status , LDCTIPSOLPLANES_.tbUserException(nuIndex).usr_exc_type_id, LDCTIPSOLPLANES_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCTIPSOLPLANES_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCTIPSOLPLANES_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCTIPSOLPLANES_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCTIPSOLPLANES_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCTIPSOLPLANES_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCTIPSOLPLANES_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCTIPSOLPLANES_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCTIPSOLPLANES_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCTIPSOLPLANES_******************************'); end;
/

