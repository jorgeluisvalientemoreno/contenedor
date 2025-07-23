BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCIDEMA_',
'CREATE OR REPLACE PACKAGE LDCIDEMA_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCIDEMA''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIDEMA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIDEMA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIDEMA'' ' || chr(10) ||
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
'END LDCIDEMA_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCIDEMA_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
Open LDCIDEMA_.cuRoleExecutables;
loop
 fetch LDCIDEMA_.cuRoleExecutables INTO LDCIDEMA_.rcRoleExecutables;
 exit when  LDCIDEMA_.cuRoleExecutables%notfound;
 LDCIDEMA_.tbRoleExecutables(nuIndex) := LDCIDEMA_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCIDEMA_.cuRoleExecutables;
nuIndex := 0;
Open LDCIDEMA_.cuUserExceptions ;
loop
 fetch LDCIDEMA_.cuUserExceptions INTO  LDCIDEMA_.rcUserExceptions;
 exit when LDCIDEMA_.cuUserExceptions%notfound;
 LDCIDEMA_.tbUserException(nuIndex):=LDCIDEMA_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCIDEMA_.cuUserExceptions;
nuIndex := 0;
Open LDCIDEMA_.cuExecEntities ;
loop
 fetch LDCIDEMA_.cuExecEntities INTO  LDCIDEMA_.rcExecEntities;
 exit when LDCIDEMA_.cuExecEntities%notfound;
 LDCIDEMA_.tbExecEntities(nuIndex):=LDCIDEMA_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCIDEMA_.cuExecEntities;

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA'
);

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCIDEMA_.tbEntityName(1522) := 'LDCI_TRANSOMA';
   LDCIDEMA_.tbEntityAttributeName(90063707) := 'LDCI_TRANSOMA@TRSMCODI';
   LDCIDEMA_.tbEntityAttributeName(90063714) := 'LDCI_TRANSOMA@TRSMFECR';
   LDCIDEMA_.tbEntityAttributeName(90063716) := 'LDCI_TRANSOMA@TRSMESTA';
   LDCIDEMA_.tbEntityAttributeName(90063723) := 'LDCI_TRANSOMA@TRSMDSRE';
   LDCIDEMA_.tbEntityAttributeName(90063726) := 'LDCI_TRANSOMA@TRSMMDPE';
   LDCIDEMA_.tbEntityAttributeName(90063729) := 'LDCI_TRANSOMA@TRSMUSMO';
   LDCIDEMA_.tbEntityAttributeName(90063735) := 'LDCI_TRANSOMA@TRSMPROG';
   LDCIDEMA_.tbEntityAttributeName(90063731) := 'LDCI_TRANSOMA@TRSMACTI';
   LDCIDEMA_.tbEntityAttributeName(90082924) := 'LDCI_TRANSOMA@ORDER_ID';
   LDCIDEMA_.tbEntityAttributeName(90063709) := 'LDCI_TRANSOMA@TRSMCONT';
   LDCIDEMA_.tbEntityAttributeName(90063711) := 'LDCI_TRANSOMA@TRSMPROV';
   LDCIDEMA_.tbEntityAttributeName(90063713) := 'LDCI_TRANSOMA@TRSMUNOP';
   LDCIDEMA_.tbEntityAttributeName(90063718) := 'LDCI_TRANSOMA@TRSMOFVE';
   LDCIDEMA_.tbEntityAttributeName(90063720) := 'LDCI_TRANSOMA@TRSMVTOT';
   LDCIDEMA_.tbEntityAttributeName(90063722) := 'LDCI_TRANSOMA@TRSMDORE';
   LDCIDEMA_.tbEntityAttributeName(90063730) := 'LDCI_TRANSOMA@TRSMMPDI';
   LDCIDEMA_.tbEntityAttributeName(90063732) := 'LDCI_TRANSOMA@TRSMSOL';
   LDCIDEMA_.tbEntityAttributeName(90063734) := 'LDCI_TRANSOMA@TRSMTIPO';
   LDCIDEMA_.tbEntityAttributeName(90185285) := 'LDCI_TRANSOMA@TRSMOBSE';
   LDCIDEMA_.tbEntityAttributeName(90185286) := 'LDCI_TRANSOMA@TRSMCOME';
 
   LDCIDEMA_.tbEntityName(1534) := 'LDCI_TRSOITEM';
   LDCIDEMA_.tbEntityAttributeName(90063778) := 'LDCI_TRSOITEM@TSITTRSM';
   LDCIDEMA_.tbEntityAttributeName(90063779) := 'LDCI_TRSOITEM@TSITITEM';
   LDCIDEMA_.tbEntityAttributeName(90063780) := 'LDCI_TRSOITEM@TSITCANT';
   LDCIDEMA_.tbEntityAttributeName(90063781) := 'LDCI_TRSOITEM@TSITCARE';
   LDCIDEMA_.tbEntityAttributeName(90063782) := 'LDCI_TRSOITEM@TSITVUNI';
   LDCIDEMA_.tbEntityAttributeName(90063783) := 'LDCI_TRSOITEM@TSITPIVA';
   LDCIDEMA_.tbEntityAttributeName(90063784) := 'LDCI_TRSOITEM@TSITSAFI';
   LDCIDEMA_.tbEntityAttributeName(90063785) := 'LDCI_TRSOITEM@TSITMABO';
   LDCIDEMA_.tbEntityAttributeName(90063786) := 'LDCI_TRSOITEM@TSITVALO';
   LDCIDEMA_.tbEntityAttributeName(90063787) := 'LDCI_TRSOITEM@TSITMDMA';
   LDCIDEMA_.tbEntityAttributeName(90063789) := 'LDCI_TRSOITEM@TSITCUDE';
   LDCIDEMA_.tbEntityAttributeName(90063790) := 'LDCI_TRSOITEM@TSITSOMA';
   LDCIDEMA_.tbEntityAttributeName(90070152) := 'LDCI_TRSOITEM@TSITESIT';
 
   LDCIDEMA_.tbEntityName(1540) := 'LDCI_SERIPOSI';
   LDCIDEMA_.tbEntityAttributeName(90063836) := 'LDCI_SERIPOSI@SERITRSM';
   LDCIDEMA_.tbEntityAttributeName(90063837) := 'LDCI_SERIPOSI@SERITSIT';
   LDCIDEMA_.tbEntityAttributeName(90063838) := 'LDCI_SERIPOSI@SERINUME';
   LDCIDEMA_.tbEntityAttributeName(90063840) := 'LDCI_SERIPOSI@SERISOMA';
 
END; 
/

BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA');

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA') AND ROLE_ID=1;

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA');

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA');

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA'));

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA');

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCIDEMA';

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.old_tb0_0(0):='LDCIDEMA'
;
LDCIDEMA_.tb0_0(0):=UPPER(LDCIDEMA_.old_tb0_0(0));
LDCIDEMA_.old_tb0_1(0):=500000000005494;
LDCIDEMA_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCIDEMA_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCIDEMA_.tb0_1(0):=LDCIDEMA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCIDEMA_.tb0_0(0),
LDCIDEMA_.tb0_1(0),
'Devoluci¿n de material'
,
null,
'203.3'
,
8,
2,
61,
1,
1345,
'Y'
,
null,
'N'
,
'Y'
,
16,
'C',
to_date('25-03-2020 20:41:58','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb1_0(0):=1;
LDCIDEMA_.tb1_1(0):=LDCIDEMA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCIDEMA_.tb1_0(0),
LDCIDEMA_.tb1_1(0));

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb2_0(0):=LDCIDEMA_.tb0_1(0);
LDCIDEMA_.old_tb2_1(0):=1522;
LDCIDEMA_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYNAME(LDCIDEMA_.old_tb2_1(0)), 'ENTITY');
LDCIDEMA_.tb2_1(0):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb2_2(0):=null;
LDCIDEMA_.tb2_2(0):=CASE WHEN (LDCIDEMA_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYNAME(LDCIDEMA_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCIDEMA_.tb2_0(0),
LDCIDEMA_.tb2_1(0),
LDCIDEMA_.tb2_2(0),
'T'
,
0,
0,
null,
' LDCI_TRANSOMA.TRSMTIPO = 2
 AND
LOWER( LDCI_TRANSOMA.TRSMUSMO )  = LOWER(UT_SESSION.GETUSER)'
,
null,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(0):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(0):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(0):=90063707;
LDCIDEMA_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(0)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(0):=LDCIDEMA_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(0),
LDCIDEMA_.tb3_1(0),
LDCIDEMA_.tb3_2(0),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(1):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(1):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(1):=90063709;
LDCIDEMA_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(1)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(1):=LDCIDEMA_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(1),
LDCIDEMA_.tb3_1(1),
LDCIDEMA_.tb3_2(1),
9,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(2):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(2):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(2):=90063711;
LDCIDEMA_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(2)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(2):=LDCIDEMA_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(2),
LDCIDEMA_.tb3_1(2),
LDCIDEMA_.tb3_2(2),
10,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(3):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(3):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(3):=90063713;
LDCIDEMA_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(3)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(3):=LDCIDEMA_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(3),
LDCIDEMA_.tb3_1(3),
LDCIDEMA_.tb3_2(3),
11,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(4):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(4):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(4):=90063714;
LDCIDEMA_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(4)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(4):=LDCIDEMA_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(4),
LDCIDEMA_.tb3_1(4),
LDCIDEMA_.tb3_2(4),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(5):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(5):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(5):=90063716;
LDCIDEMA_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(5)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(5):=LDCIDEMA_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(5),
LDCIDEMA_.tb3_1(5),
LDCIDEMA_.tb3_2(5),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO "CODIGO DEL ESTADO" , DESCRIPCION "DESCRIPCION DEL ESTADO"  FROM LDCI_TRANESTA '
,
'N'
,
'CODIGO DEL ESTADO'
,
'DESCRIPCION DEL ESTADO'
,
'CODIGO Codigo del estado|DESCRIPCION Descripcion del estado|'
,
'FROM LDCI_TRANESTA|'
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(6):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(6):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(6):=90063718;
LDCIDEMA_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(6)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(6):=LDCIDEMA_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(6),
LDCIDEMA_.tb3_1(6),
LDCIDEMA_.tb3_2(6),
12,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(7):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(7):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(7):=90063720;
LDCIDEMA_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(7)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(7):=LDCIDEMA_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(7),
LDCIDEMA_.tb3_1(7),
LDCIDEMA_.tb3_2(7),
13,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(8):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(8):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(8):=90063722;
LDCIDEMA_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(8)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(8):=LDCIDEMA_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(8),
LDCIDEMA_.tb3_1(8),
LDCIDEMA_.tb3_2(8),
14,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(9):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(9):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(9):=90063723;
LDCIDEMA_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(9)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(9):=LDCIDEMA_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(9),
LDCIDEMA_.tb3_1(9),
LDCIDEMA_.tb3_2(9),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(10):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(10):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(10):=90063726;
LDCIDEMA_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(10)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(10):=LDCIDEMA_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(10),
LDCIDEMA_.tb3_1(10),
LDCIDEMA_.tb3_2(10),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  MDPECODI "C¿DIGO DEL MOTIVO" , MDPEDESC "DESCRIPCI¿N DEL MOTIVO"  FROM LDCI_MOTIDEPE '
,
'N'
,
'C¿DIGO DEL MOTIVO'
,
'DESCRIPCI¿N DEL MOTIVO'
,
'MDPECODI C¿digo del motivo|MDPEDESC Descripci¿n del motivo|'
,
'FROM LDCI_MOTIDEPE|'
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(11):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(11):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(11):=90063729;
LDCIDEMA_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(11)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(11):=LDCIDEMA_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(11),
LDCIDEMA_.tb3_1(11),
LDCIDEMA_.tb3_2(11),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(12):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(12):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(12):=90063730;
LDCIDEMA_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(12)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(12):=LDCIDEMA_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(12),
LDCIDEMA_.tb3_1(12),
LDCIDEMA_.tb3_2(12),
15,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(13):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(13):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(13):=90063731;
LDCIDEMA_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(13)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(13):=LDCIDEMA_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(13),
LDCIDEMA_.tb3_1(13),
LDCIDEMA_.tb3_2(13),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(14):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(14):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(14):=90063732;
LDCIDEMA_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(14)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(14):=LDCIDEMA_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(14),
LDCIDEMA_.tb3_1(14),
LDCIDEMA_.tb3_2(14),
16,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(15):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(15):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(15):=90063734;
LDCIDEMA_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(15)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(15):=LDCIDEMA_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(15),
LDCIDEMA_.tb3_1(15),
LDCIDEMA_.tb3_2(15),
17,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(16):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(16):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(16):=90063735;
LDCIDEMA_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(16)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(16):=LDCIDEMA_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(16),
LDCIDEMA_.tb3_1(16),
LDCIDEMA_.tb3_2(16),
6,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(17):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(17):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(17):=90082924;
LDCIDEMA_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(17)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(17):=LDCIDEMA_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(17),
LDCIDEMA_.tb3_1(17),
LDCIDEMA_.tb3_2(17),
8,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(18):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(18):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(18):=90185285;
LDCIDEMA_.tb3_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(18)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(18):=LDCIDEMA_.tb3_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(18),
LDCIDEMA_.tb3_1(18),
LDCIDEMA_.tb3_2(18),
18,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(19):=LDCIDEMA_.tb2_0(0);
LDCIDEMA_.tb3_1(19):=LDCIDEMA_.tb2_1(0);
LDCIDEMA_.old_tb3_2(19):=90185286;
LDCIDEMA_.tb3_2(19):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(19)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(19):=LDCIDEMA_.tb3_2(19);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (19)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(19),
LDCIDEMA_.tb3_1(19),
LDCIDEMA_.tb3_2(19),
19,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb2_0(1):=LDCIDEMA_.tb0_1(0);
LDCIDEMA_.old_tb2_1(1):=1534;
LDCIDEMA_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYNAME(LDCIDEMA_.old_tb2_1(1)), 'ENTITY');
LDCIDEMA_.tb2_1(1):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb2_2(1):=1522;
LDCIDEMA_.tb2_2(1):=CASE WHEN (LDCIDEMA_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYNAME(LDCIDEMA_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCIDEMA_.tb2_0(1),
LDCIDEMA_.tb2_1(1),
LDCIDEMA_.tb2_2(1),
'G'
,
1,
0,
null,
null,
'LDCI_TRSOITEM.TSITSOMA  =  LDCI_TRANSOMA.TRSMCODI'
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(20):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(20):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(20):=90063778;
LDCIDEMA_.tb3_2(20):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(20)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(20):=LDCIDEMA_.tb3_2(20);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (20)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(20),
LDCIDEMA_.tb3_1(20),
LDCIDEMA_.tb3_2(20),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(21):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(21):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(21):=90063779;
LDCIDEMA_.tb3_2(21):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(21)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(21):=LDCIDEMA_.tb3_2(21);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (21)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(21),
LDCIDEMA_.tb3_1(21),
LDCIDEMA_.tb3_2(21),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID IN (8,3,21)  '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'ITEMS_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_ITEMS|'
,
'WHERE ITEM_CLASSIF_ID IN (8,3,21) |'
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(22):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(22):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(22):=90063780;
LDCIDEMA_.tb3_2(22):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(22)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(22):=LDCIDEMA_.tb3_2(22);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (22)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(22),
LDCIDEMA_.tb3_1(22),
LDCIDEMA_.tb3_2(22),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(23):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(23):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(23):=90063781;
LDCIDEMA_.tb3_2(23):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(23)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(23):=LDCIDEMA_.tb3_2(23);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (23)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(23),
LDCIDEMA_.tb3_1(23),
LDCIDEMA_.tb3_2(23),
3,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(24):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(24):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(24):=90063782;
LDCIDEMA_.tb3_2(24):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(24)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(24):=LDCIDEMA_.tb3_2(24);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (24)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(24),
LDCIDEMA_.tb3_1(24),
LDCIDEMA_.tb3_2(24),
4,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(25):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(25):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(25):=90063783;
LDCIDEMA_.tb3_2(25):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(25)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(25):=LDCIDEMA_.tb3_2(25);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (25)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(25),
LDCIDEMA_.tb3_1(25),
LDCIDEMA_.tb3_2(25),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(26):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(26):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(26):=90063784;
LDCIDEMA_.tb3_2(26):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(26)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(26):=LDCIDEMA_.tb3_2(26);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (26)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(26),
LDCIDEMA_.tb3_1(26),
LDCIDEMA_.tb3_2(26),
6,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(27):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(27):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(27):=90063785;
LDCIDEMA_.tb3_2(27):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(27)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(27):=LDCIDEMA_.tb3_2(27);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (27)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(27),
LDCIDEMA_.tb3_1(27),
LDCIDEMA_.tb3_2(27),
7,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(28):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(28):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(28):=90063786;
LDCIDEMA_.tb3_2(28):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(28)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(28):=LDCIDEMA_.tb3_2(28);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (28)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(28),
LDCIDEMA_.tb3_1(28),
LDCIDEMA_.tb3_2(28),
8,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(29):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(29):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(29):=90063787;
LDCIDEMA_.tb3_2(29):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(29)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(29):=LDCIDEMA_.tb3_2(29);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (29)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(29),
LDCIDEMA_.tb3_1(29),
LDCIDEMA_.tb3_2(29),
9,
'Y'
,
'Y'
,
'N'
,
'SELECT  MDMACODI "CODIGO MOTIVO DEVOLUCION DEL MATERIAL" , MDMADESC "DESCRIPCI¿N MOTIVO DE DEVOLUCI¿N DEL MATERIAL"  FROM LDCI_MOTIDEMA '
,
'N'
,
'CODIGO MOTIVO DEVOLUCION DEL MATERIAL'
,
'DESCRIPCI¿N MOTIVO DE DEVOLUCI¿N DEL MATERIAL'
,
'MDMACODI Codigo Motivo devolucion del material|MDMADESC Descripci¿n motivo de devoluci¿n del material|'
,
'FROM LDCI_MOTIDEMA|'
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(30):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(30):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(30):=90063789;
LDCIDEMA_.tb3_2(30):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(30)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(30):=LDCIDEMA_.tb3_2(30);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (30)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(30),
LDCIDEMA_.tb3_1(30),
LDCIDEMA_.tb3_2(30),
10,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(31):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(31):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(31):=90063790;
LDCIDEMA_.tb3_2(31):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(31)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(31):=LDCIDEMA_.tb3_2(31);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (31)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(31),
LDCIDEMA_.tb3_1(31),
LDCIDEMA_.tb3_2(31),
11,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(32):=LDCIDEMA_.tb2_0(1);
LDCIDEMA_.tb3_1(32):=LDCIDEMA_.tb2_1(1);
LDCIDEMA_.old_tb3_2(32):=90070152;
LDCIDEMA_.tb3_2(32):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(32)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(32):=LDCIDEMA_.tb3_2(32);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (32)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(32),
LDCIDEMA_.tb3_1(32),
LDCIDEMA_.tb3_2(32),
12,
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb2_0(2):=LDCIDEMA_.tb0_1(0);
LDCIDEMA_.old_tb2_1(2):=1540;
LDCIDEMA_.tb2_1(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYNAME(LDCIDEMA_.old_tb2_1(2)), 'ENTITY');
LDCIDEMA_.tb2_1(2):=LDCIDEMA_.tb2_1(2);
LDCIDEMA_.old_tb2_2(2):=1534;
LDCIDEMA_.tb2_2(2):=CASE WHEN (LDCIDEMA_.old_tb2_2(2) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYNAME(LDCIDEMA_.old_tb2_2(2)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (2)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCIDEMA_.tb2_0(2),
LDCIDEMA_.tb2_1(2),
LDCIDEMA_.tb2_2(2),
'G'
,
2,
0,
null,
null,
'LDCI_SERIPOSI.SERITSIT  =  LDCI_TRSOITEM.TSITITEM  AND  LDCI_SERIPOSI.SERISOMA   =  LDCI_TRSOITEM.TSITSOMA'
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(33):=LDCIDEMA_.tb2_0(2);
LDCIDEMA_.tb3_1(33):=LDCIDEMA_.tb2_1(2);
LDCIDEMA_.old_tb3_2(33):=90063836;
LDCIDEMA_.tb3_2(33):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(33)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(33):=LDCIDEMA_.tb3_2(33);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (33)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(33),
LDCIDEMA_.tb3_1(33),
LDCIDEMA_.tb3_2(33),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(34):=LDCIDEMA_.tb2_0(2);
LDCIDEMA_.tb3_1(34):=LDCIDEMA_.tb2_1(2);
LDCIDEMA_.old_tb3_2(34):=90063837;
LDCIDEMA_.tb3_2(34):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(34)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(34):=LDCIDEMA_.tb3_2(34);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (34)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(34),
LDCIDEMA_.tb3_1(34),
LDCIDEMA_.tb3_2(34),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(35):=LDCIDEMA_.tb2_0(2);
LDCIDEMA_.tb3_1(35):=LDCIDEMA_.tb2_1(2);
LDCIDEMA_.old_tb3_2(35):=90063838;
LDCIDEMA_.tb3_2(35):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(35)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(35):=LDCIDEMA_.tb3_2(35);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (35)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(35),
LDCIDEMA_.tb3_1(35),
LDCIDEMA_.tb3_2(35),
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
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;

LDCIDEMA_.tb3_0(36):=LDCIDEMA_.tb2_0(2);
LDCIDEMA_.tb3_1(36):=LDCIDEMA_.tb2_1(2);
LDCIDEMA_.old_tb3_2(36):=90063840;
LDCIDEMA_.tb3_2(36):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIDEMA_.TBENTITYATTRIBUTENAME(LDCIDEMA_.old_tb3_2(36)), 'ATTRIBUTE');
LDCIDEMA_.tb3_2(36):=LDCIDEMA_.tb3_2(36);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (36)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIDEMA_.tb3_0(36),
LDCIDEMA_.tb3_1(36),
LDCIDEMA_.tb3_2(36),
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
LDCIDEMA_.blProcessStatus := false;
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
 nuIndexInternal := LDCIDEMA_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCIDEMA_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCIDEMA_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCIDEMA_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCIDEMA_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCIDEMA_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCIDEMA_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCIDEMA_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCIDEMA_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCIDEMA_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCIDEMA_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCIDEMA_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCIDEMA_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCIDEMA_.tbUserException(nuIndex).user_id, LDCIDEMA_.tbUserException(nuIndex).status , LDCIDEMA_.tbUserException(nuIndex).usr_exc_type_id, LDCIDEMA_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCIDEMA_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCIDEMA_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCIDEMA_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCIDEMA_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCIDEMA_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCIDEMA_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCIDEMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCIDEMA_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCIDEMA_******************************'); end;
/

