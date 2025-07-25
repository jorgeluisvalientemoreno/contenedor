BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCLCTOI_',
'CREATE OR REPLACE PACKAGE LDCLCTOI_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCLCTOI''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCLCTOI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCLCTOI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCLCTOI'' ' || chr(10) ||
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
'END LDCLCTOI_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCLCTOI_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
Open LDCLCTOI_.cuRoleExecutables;
loop
 fetch LDCLCTOI_.cuRoleExecutables INTO LDCLCTOI_.rcRoleExecutables;
 exit when  LDCLCTOI_.cuRoleExecutables%notfound;
 LDCLCTOI_.tbRoleExecutables(nuIndex) := LDCLCTOI_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCLCTOI_.cuRoleExecutables;
nuIndex := 0;
Open LDCLCTOI_.cuUserExceptions ;
loop
 fetch LDCLCTOI_.cuUserExceptions INTO  LDCLCTOI_.rcUserExceptions;
 exit when LDCLCTOI_.cuUserExceptions%notfound;
 LDCLCTOI_.tbUserException(nuIndex):=LDCLCTOI_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCLCTOI_.cuUserExceptions;
nuIndex := 0;
Open LDCLCTOI_.cuExecEntities ;
loop
 fetch LDCLCTOI_.cuExecEntities INTO  LDCLCTOI_.rcExecEntities;
 exit when LDCLCTOI_.cuExecEntities%notfound;
 LDCLCTOI_.tbExecEntities(nuIndex):=LDCLCTOI_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCLCTOI_.cuExecEntities;

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI'
);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCLCTOI_.tbEntityName(9743) := 'IC_CLASCONT';
   LDCLCTOI_.tbEntityAttributeName(36627) := 'IC_CLASCONT@CLCOCODI';
   LDCLCTOI_.tbEntityAttributeName(36628) := 'IC_CLASCONT@CLCODESC';
   LDCLCTOI_.tbEntityAttributeName(36630) := 'IC_CLASCONT@CLCOTERM';
   LDCLCTOI_.tbEntityAttributeName(36629) := 'IC_CLASCONT@CLCOUSUA';
   LDCLCTOI_.tbEntityAttributeName(36631) := 'IC_CLASCONT@CLCOPROG';
   LDCLCTOI_.tbEntityAttributeName(170749) := 'IC_CLASCONT@CLCODOMI';
 
   LDCLCTOI_.tbEntityName(8885) := 'LDCI_CLASCONTCATEOI';
   LDCLCTOI_.tbEntityAttributeName(90047506) := 'LDCI_CLASCONTCATEOI@CLCOCODI';
   LDCLCTOI_.tbEntityAttributeName(90047507) := 'LDCI_CLASCONTCATEOI@CLCOCATE';
   LDCLCTOI_.tbEntityAttributeName(90047508) := 'LDCI_CLASCONTCATEOI@CLCOORIN';
   LDCLCTOI_.tbEntityAttributeName(90047510) := 'LDCI_CLASCONTCATEOI@CLCOPROV';
 
END; 
/

BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI');

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI') AND ROLE_ID=1;

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI');

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI');

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI'));

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI');

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCLCTOI';

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.old_tb0_0(0):='LDCLCTOI'
;
LDCLCTOI_.tb0_0(0):=UPPER(LDCLCTOI_.old_tb0_0(0));
LDCLCTOI_.old_tb0_1(0):=500000000002777;
LDCLCTOI_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCLCTOI_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCLCTOI_.tb0_1(0):=LDCLCTOI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCLCTOI_.tb0_0(0),
LDCLCTOI_.tb0_1(0),
'Clasificador Contable x Categ x OI'
,
null,
'36'
,
8,
2,
38,
1,
1345,
'Y'
,
null,
'N'
,
'Y'
,
39,
'C'
,
to_date('09-04-2025 16:24:09','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb1_0(0):=1;
LDCLCTOI_.tb1_1(0):=LDCLCTOI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCLCTOI_.tb1_0(0),
LDCLCTOI_.tb1_1(0));

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb2_0(0):=LDCLCTOI_.tb0_1(0);
LDCLCTOI_.old_tb2_1(0):=9743;
LDCLCTOI_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYNAME(LDCLCTOI_.old_tb2_1(0)), 'ENTITY');
LDCLCTOI_.tb2_1(0):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb2_2(0):=null;
LDCLCTOI_.tb2_2(0):=CASE WHEN (LDCLCTOI_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYNAME(LDCLCTOI_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCLCTOI_.tb2_0(0),
LDCLCTOI_.tb2_1(0),
LDCLCTOI_.tb2_2(0),
'T'
,
0,
0,
null,
' IC_CLASCONT.CLCODOMI = '|| chr(39) ||'C'|| chr(39) ||''
,
null,
'N'
,
'N'
,
'N'
,
null);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(0):=LDCLCTOI_.tb2_0(0);
LDCLCTOI_.tb3_1(0):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb3_2(0):=36627;
LDCLCTOI_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(0)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(0):=LDCLCTOI_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(0),
LDCLCTOI_.tb3_1(0),
LDCLCTOI_.tb3_2(0),
0,
'Y'
,
'N'
,
'N'
,
'SELECT  CLCOCODI "CÓDIGO" , CLCODESC "DESCRIPCIÓN" , CLCODOMI "DOMINIO"  FROM IC_CLASCONT WHERE CLCODOMI = '|| chr(39) ||'C'|| chr(39) ||' ORDER BY CLCODESC ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'CLCOCODI Código|CLCODESC Descripción|CLCODOMI Dominio|'
,
'FROM IC_CLASCONT|'
,
'WHERE CLCODOMI = '|| chr(39) ||'C'|| chr(39) ||'|'
,
'ORDER BY CLCODESC ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(1):=LDCLCTOI_.tb2_0(0);
LDCLCTOI_.tb3_1(1):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb3_2(1):=36628;
LDCLCTOI_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(1)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(1):=LDCLCTOI_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(1),
LDCLCTOI_.tb3_1(1),
LDCLCTOI_.tb3_2(1),
1,
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
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(2):=LDCLCTOI_.tb2_0(0);
LDCLCTOI_.tb3_1(2):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb3_2(2):=36629;
LDCLCTOI_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(2)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(2):=LDCLCTOI_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(2),
LDCLCTOI_.tb3_1(2),
LDCLCTOI_.tb3_2(2),
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
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(3):=LDCLCTOI_.tb2_0(0);
LDCLCTOI_.tb3_1(3):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb3_2(3):=36630;
LDCLCTOI_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(3)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(3):=LDCLCTOI_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(3),
LDCLCTOI_.tb3_1(3),
LDCLCTOI_.tb3_2(3),
2,
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
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(4):=LDCLCTOI_.tb2_0(0);
LDCLCTOI_.tb3_1(4):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb3_2(4):=36631;
LDCLCTOI_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(4)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(4):=LDCLCTOI_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(4),
LDCLCTOI_.tb3_1(4),
LDCLCTOI_.tb3_2(4),
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
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(5):=LDCLCTOI_.tb2_0(0);
LDCLCTOI_.tb3_1(5):=LDCLCTOI_.tb2_1(0);
LDCLCTOI_.old_tb3_2(5):=170749;
LDCLCTOI_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(5)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(5):=LDCLCTOI_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(5),
LDCLCTOI_.tb3_1(5),
LDCLCTOI_.tb3_2(5),
5,
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
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb2_0(1):=LDCLCTOI_.tb0_1(0);
LDCLCTOI_.old_tb2_1(1):=8885;
LDCLCTOI_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYNAME(LDCLCTOI_.old_tb2_1(1)), 'ENTITY');
LDCLCTOI_.tb2_1(1):=LDCLCTOI_.tb2_1(1);
LDCLCTOI_.old_tb2_2(1):=9743;
LDCLCTOI_.tb2_2(1):=CASE WHEN (LDCLCTOI_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYNAME(LDCLCTOI_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCLCTOI_.tb2_0(1),
LDCLCTOI_.tb2_1(1),
LDCLCTOI_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDCI_CLASCONTCATEOI.CLCOCODI  =  IC_CLASCONT.CLCOCODI '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(6):=LDCLCTOI_.tb2_0(1);
LDCLCTOI_.tb3_1(6):=LDCLCTOI_.tb2_1(1);
LDCLCTOI_.old_tb3_2(6):=90047506;
LDCLCTOI_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(6)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(6):=LDCLCTOI_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(6),
LDCLCTOI_.tb3_1(6),
LDCLCTOI_.tb3_2(6),
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
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(7):=LDCLCTOI_.tb2_0(1);
LDCLCTOI_.tb3_1(7):=LDCLCTOI_.tb2_1(1);
LDCLCTOI_.old_tb3_2(7):=90047507;
LDCLCTOI_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(7)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(7):=LDCLCTOI_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(7),
LDCLCTOI_.tb3_1(7),
LDCLCTOI_.tb3_2(7),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  CATECODI "CODIGO DE LA CATEGORIA" , CATEDESC "DESCRIPCION DE LA CATEGORIA"  FROM CATEGORI ORDER BY CATECODI ASC '
,
'N'
,
'CODIGO DE LA CATEGORIA'
,
'DESCRIPCION DE LA CATEGORIA'
,
'CATECODI Codigo de la categoria|CATEDESC Descripcion de la categoria|'
,
'FROM CATEGORI|'
,
null,
'ORDER BY CATECODI ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(8):=LDCLCTOI_.tb2_0(1);
LDCLCTOI_.tb3_1(8):=LDCLCTOI_.tb2_1(1);
LDCLCTOI_.old_tb3_2(8):=90047508;
LDCLCTOI_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(8)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(8):=LDCLCTOI_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(8),
LDCLCTOI_.tb3_1(8),
LDCLCTOI_.tb3_2(8),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODI_ORDEINTERNA "CODIGO DE ORDEN INTERNA" , DESC_ORDEINTERNA "DESCRIPCION DE ORDEN INTERNA"  FROM LDCI_ORDENINTERNA ORDER BY CODI_ORDEINTERNA ASC '
,
'N'
,
'CODIGO DE ORDEN INTERNA'
,
'DESCRIPCION DE ORDEN INTERNA'
,
'CODI_ORDEINTERNA Codigo de orden interna|DESC_ORDEINTERNA Descripcion de orden interna|'
,
'FROM LDCI_ORDENINTERNA|'
,
null,
'ORDER BY CODI_ORDEINTERNA ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;

LDCLCTOI_.tb3_0(9):=LDCLCTOI_.tb2_0(1);
LDCLCTOI_.tb3_1(9):=LDCLCTOI_.tb2_1(1);
LDCLCTOI_.old_tb3_2(9):=90047510;
LDCLCTOI_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLCTOI_.TBENTITYATTRIBUTENAME(LDCLCTOI_.old_tb3_2(9)), 'ATTRIBUTE');
LDCLCTOI_.tb3_2(9):=LDCLCTOI_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLCTOI_.tb3_0(9),
LDCLCTOI_.tb3_1(9),
LDCLCTOI_.tb3_2(9),
3,
'Y'
,
'Y'
,
'N'
,
null,
'N'
,
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
LDCLCTOI_.blProcessStatus := false;
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
 nuIndexInternal := LDCLCTOI_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCLCTOI_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCLCTOI_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCLCTOI_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCLCTOI_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCLCTOI_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCLCTOI_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCLCTOI_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCLCTOI_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCLCTOI_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCLCTOI_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCLCTOI_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCLCTOI_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCLCTOI_.tbUserException(nuIndex).user_id, LDCLCTOI_.tbUserException(nuIndex).status , LDCLCTOI_.tbUserException(nuIndex).usr_exc_type_id, LDCLCTOI_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCLCTOI_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCLCTOI_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCLCTOI_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCLCTOI_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCLCTOI_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCLCTOI_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCLCTOI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCLCTOI_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCLCTOI_******************************'); end;
/

