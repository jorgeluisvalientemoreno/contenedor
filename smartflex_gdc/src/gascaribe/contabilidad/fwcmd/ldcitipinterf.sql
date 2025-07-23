BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCITIPINTERF_',
'CREATE OR REPLACE PACKAGE LDCITIPINTERF_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCITIPINTERF''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCITIPINTERF'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCITIPINTERF'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCITIPINTERF'' ' || chr(10) ||
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
'END LDCITIPINTERF_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCITIPINTERF_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
Open LDCITIPINTERF_.cuRoleExecutables;
loop
 fetch LDCITIPINTERF_.cuRoleExecutables INTO LDCITIPINTERF_.rcRoleExecutables;
 exit when  LDCITIPINTERF_.cuRoleExecutables%notfound;
 LDCITIPINTERF_.tbRoleExecutables(nuIndex) := LDCITIPINTERF_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCITIPINTERF_.cuRoleExecutables;
nuIndex := 0;
Open LDCITIPINTERF_.cuUserExceptions ;
loop
 fetch LDCITIPINTERF_.cuUserExceptions INTO  LDCITIPINTERF_.rcUserExceptions;
 exit when LDCITIPINTERF_.cuUserExceptions%notfound;
 LDCITIPINTERF_.tbUserException(nuIndex):=LDCITIPINTERF_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCITIPINTERF_.cuUserExceptions;
nuIndex := 0;
Open LDCITIPINTERF_.cuExecEntities ;
loop
 fetch LDCITIPINTERF_.cuExecEntities INTO  LDCITIPINTERF_.rcExecEntities;
 exit when LDCITIPINTERF_.cuExecEntities%notfound;
 LDCITIPINTERF_.tbExecEntities(nuIndex):=LDCITIPINTERF_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCITIPINTERF_.cuExecEntities;

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF'
);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCITIPINTERF_.tbEntityName(8908) := 'LDCI_TIPODOCO';
   LDCITIPINTERF_.tbEntityAttributeName(90047752) := 'LDCI_TIPODOCO@TIDCCODI';
   LDCITIPINTERF_.tbEntityAttributeName(90047751) := 'LDCI_TIPODOCO@TIDCDESC';
 
   LDCITIPINTERF_.tbEntityName(8909) := 'LDCI_TIPOINTERFAZ';
   LDCITIPINTERF_.tbEntityAttributeName(90047753) := 'LDCI_TIPOINTERFAZ@CONSECUTIVO';
   LDCITIPINTERF_.tbEntityAttributeName(90047754) := 'LDCI_TIPOINTERFAZ@TIPOINTERFAZ';
   LDCITIPINTERF_.tbEntityAttributeName(90047756) := 'LDCI_TIPOINTERFAZ@COD_TIPOCOMP';
   LDCITIPINTERF_.tbEntityAttributeName(90047755) := 'LDCI_TIPOINTERFAZ@COD_COMPROBANTE';
   LDCITIPINTERF_.tbEntityAttributeName(90050205) := 'LDCI_TIPOINTERFAZ@LEDGERS';
   LDCITIPINTERF_.tbEntityAttributeName(90200446) := 'LDCI_TIPOINTERFAZ@EMPRESA';
 
END; 
/

BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF');

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF') AND ROLE_ID=1;

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF');

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF');

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF'));

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF');

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCITIPINTERF';

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.old_tb0_0(0):='LDCITIPINTERF'
;
LDCITIPINTERF_.tb0_0(0):=UPPER(LDCITIPINTERF_.old_tb0_0(0));
LDCITIPINTERF_.old_tb0_1(0):=500000000002775;
LDCITIPINTERF_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCITIPINTERF_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCITIPINTERF_.tb0_1(0):=LDCITIPINTERF_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCITIPINTERF_.tb0_0(0),
LDCITIPINTERF_.tb0_1(0),
'Tipo Interfaz X Comprobante X Tipo Comprobante'
,
null,
'22'
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
5,
'C'
,
to_date('21-04-2025 14:25:26','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb1_0(0):=1;
LDCITIPINTERF_.tb1_1(0):=LDCITIPINTERF_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCITIPINTERF_.tb1_0(0),
LDCITIPINTERF_.tb1_1(0));

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb2_0(0):=LDCITIPINTERF_.tb0_1(0);
LDCITIPINTERF_.old_tb2_1(0):=8908;
LDCITIPINTERF_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYNAME(LDCITIPINTERF_.old_tb2_1(0)), 'ENTITY');
LDCITIPINTERF_.tb2_1(0):=LDCITIPINTERF_.tb2_1(0);
LDCITIPINTERF_.old_tb2_2(0):=null;
LDCITIPINTERF_.tb2_2(0):=CASE WHEN (LDCITIPINTERF_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYNAME(LDCITIPINTERF_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCITIPINTERF_.tb2_0(0),
LDCITIPINTERF_.tb2_1(0),
LDCITIPINTERF_.tb2_2(0),
'T'
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
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(0):=LDCITIPINTERF_.tb2_0(0);
LDCITIPINTERF_.tb3_1(0):=LDCITIPINTERF_.tb2_1(0);
LDCITIPINTERF_.old_tb3_2(0):=90047751;
LDCITIPINTERF_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(0)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(0):=LDCITIPINTERF_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(0),
LDCITIPINTERF_.tb3_1(0),
LDCITIPINTERF_.tb3_2(0),
1,
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
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(1):=LDCITIPINTERF_.tb2_0(0);
LDCITIPINTERF_.tb3_1(1):=LDCITIPINTERF_.tb2_1(0);
LDCITIPINTERF_.old_tb3_2(1):=90047752;
LDCITIPINTERF_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(1)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(1):=LDCITIPINTERF_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(1),
LDCITIPINTERF_.tb3_1(1),
LDCITIPINTERF_.tb3_2(1),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT  TIDCCODI "ID" , TIDCDESC "DESCRIPCION"  FROM LDCI_TIPODOCO ORDER BY TIDCDESC ASC '
,
'N'
,
'ID'
,
'DESCRIPCION'
,
'TIDCCODI ID|TIDCDESC DESCRIPCION|'
,
'FROM LDCI_TIPODOCO|'
,
null,
'ORDER BY TIDCDESC ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb2_0(1):=LDCITIPINTERF_.tb0_1(0);
LDCITIPINTERF_.old_tb2_1(1):=8909;
LDCITIPINTERF_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYNAME(LDCITIPINTERF_.old_tb2_1(1)), 'ENTITY');
LDCITIPINTERF_.tb2_1(1):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb2_2(1):=8908;
LDCITIPINTERF_.tb2_2(1):=CASE WHEN (LDCITIPINTERF_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYNAME(LDCITIPINTERF_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCITIPINTERF_.tb2_0(1),
LDCITIPINTERF_.tb2_1(1),
LDCITIPINTERF_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDCI_TIPOINTERFAZ.TIPOINTERFAZ  =  LDCI_TIPODOCO.TIDCCODI '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(2):=LDCITIPINTERF_.tb2_0(1);
LDCITIPINTERF_.tb3_1(2):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb3_2(2):=90047753;
LDCITIPINTERF_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(2)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(2):=LDCITIPINTERF_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(2),
LDCITIPINTERF_.tb3_1(2),
LDCITIPINTERF_.tb3_2(2),
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
null,
null,
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(3):=LDCITIPINTERF_.tb2_0(1);
LDCITIPINTERF_.tb3_1(3):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb3_2(3):=90047754;
LDCITIPINTERF_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(3)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(3):=LDCITIPINTERF_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(3),
LDCITIPINTERF_.tb3_1(3),
LDCITIPINTERF_.tb3_2(3),
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
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(4):=LDCITIPINTERF_.tb2_0(1);
LDCITIPINTERF_.tb3_1(4):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb3_2(4):=90047755;
LDCITIPINTERF_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(4)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(4):=LDCITIPINTERF_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(4),
LDCITIPINTERF_.tb3_1(4),
LDCITIPINTERF_.tb3_2(4),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  COCOCODI "CÓDIGO" , COCODESC "DESCRIPCIÓN"  FROM IC_COMPCONT WHERE COCOTCCO = [COD_TIPOCOMP] ORDER BY COCODESC ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'COCOCODI Código|COCODESC Descripción|'
,
'FROM IC_COMPCONT|'
,
'WHERE COCOTCCO = COD_TIPOCOMP|'
,
'ORDER BY COCODESC ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(5):=LDCITIPINTERF_.tb2_0(1);
LDCITIPINTERF_.tb3_1(5):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb3_2(5):=90047756;
LDCITIPINTERF_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(5)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(5):=LDCITIPINTERF_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(5),
LDCITIPINTERF_.tb3_1(5),
LDCITIPINTERF_.tb3_2(5),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  TCCOCODI "CÓDIGO" , TCCODESC "DESCRIPCIÓN"  FROM IC_TICOCONT ORDER BY TCCODESC ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'TCCOCODI Código|TCCODESC Descripción|'
,
'FROM IC_TICOCONT|'
,
null,
'ORDER BY TCCODESC ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(6):=LDCITIPINTERF_.tb2_0(1);
LDCITIPINTERF_.tb3_1(6):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb3_2(6):=90050205;
LDCITIPINTERF_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(6)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(6):=LDCITIPINTERF_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(6),
LDCITIPINTERF_.tb3_1(6),
LDCITIPINTERF_.tb3_2(6),
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
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;

LDCITIPINTERF_.tb3_0(7):=LDCITIPINTERF_.tb2_0(1);
LDCITIPINTERF_.tb3_1(7):=LDCITIPINTERF_.tb2_1(1);
LDCITIPINTERF_.old_tb3_2(7):=90200446;
LDCITIPINTERF_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCITIPINTERF_.TBENTITYATTRIBUTENAME(LDCITIPINTERF_.old_tb3_2(7)), 'ATTRIBUTE');
LDCITIPINTERF_.tb3_2(7):=LDCITIPINTERF_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCITIPINTERF_.tb3_0(7),
LDCITIPINTERF_.tb3_1(7),
LDCITIPINTERF_.tb3_2(7),
5,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO "CODIGO EMPRESA" , NOMBRE "NOMBRE EMPRESA"  FROM VW_EMPRESA ORDER BY CODIGO ASC '
,
'N'
,
'CODIGO EMPRESA'
,
'NOMBRE EMPRESA'
,
'CODIGO Codigo Empresa|NOMBRE Nombre Empresa|'
,
'FROM VW_EMPRESA|'
,
null,
'ORDER BY CODIGO ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
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
 nuIndexInternal := LDCITIPINTERF_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCITIPINTERF_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCITIPINTERF_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCITIPINTERF_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCITIPINTERF_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCITIPINTERF_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCITIPINTERF_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCITIPINTERF_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCITIPINTERF_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCITIPINTERF_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCITIPINTERF_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCITIPINTERF_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCITIPINTERF_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCITIPINTERF_.tbUserException(nuIndex).user_id, LDCITIPINTERF_.tbUserException(nuIndex).status , LDCITIPINTERF_.tbUserException(nuIndex).usr_exc_type_id, LDCITIPINTERF_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCITIPINTERF_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCITIPINTERF_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCITIPINTERF_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCITIPINTERF_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCITIPINTERF_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCITIPINTERF_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCITIPINTERF_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCITIPINTERF_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCITIPINTERF_******************************'); end;
/

