BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCISOMA_',
'CREATE OR REPLACE PACKAGE LDCISOMA_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCISOMA''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCISOMA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCISOMA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCISOMA'' ' || chr(10) ||
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
'END LDCISOMA_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCISOMA_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
Open LDCISOMA_.cuRoleExecutables;
loop
 fetch LDCISOMA_.cuRoleExecutables INTO LDCISOMA_.rcRoleExecutables;
 exit when  LDCISOMA_.cuRoleExecutables%notfound;
 LDCISOMA_.tbRoleExecutables(nuIndex) := LDCISOMA_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCISOMA_.cuRoleExecutables;
nuIndex := 0;
Open LDCISOMA_.cuUserExceptions ;
loop
 fetch LDCISOMA_.cuUserExceptions INTO  LDCISOMA_.rcUserExceptions;
 exit when LDCISOMA_.cuUserExceptions%notfound;
 LDCISOMA_.tbUserException(nuIndex):=LDCISOMA_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCISOMA_.cuUserExceptions;
nuIndex := 0;
Open LDCISOMA_.cuExecEntities ;
loop
 fetch LDCISOMA_.cuExecEntities INTO  LDCISOMA_.rcExecEntities;
 exit when LDCISOMA_.cuExecEntities%notfound;
 LDCISOMA_.tbExecEntities(nuIndex):=LDCISOMA_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCISOMA_.cuExecEntities;

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA'
);

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCISOMA_.tbEntityName(1522) := 'LDCI_TRANSOMA';
   LDCISOMA_.tbEntityAttributeName(90063707) := 'LDCI_TRANSOMA@TRSMCODI';
   LDCISOMA_.tbEntityAttributeName(90063709) := 'LDCI_TRANSOMA@TRSMCONT';
   LDCISOMA_.tbEntityAttributeName(90063711) := 'LDCI_TRANSOMA@TRSMPROV';
   LDCISOMA_.tbEntityAttributeName(90063713) := 'LDCI_TRANSOMA@TRSMUNOP';
   LDCISOMA_.tbEntityAttributeName(90063714) := 'LDCI_TRANSOMA@TRSMFECR';
   LDCISOMA_.tbEntityAttributeName(90063716) := 'LDCI_TRANSOMA@TRSMESTA';
   LDCISOMA_.tbEntityAttributeName(90063718) := 'LDCI_TRANSOMA@TRSMOFVE';
   LDCISOMA_.tbEntityAttributeName(90063720) := 'LDCI_TRANSOMA@TRSMVTOT';
   LDCISOMA_.tbEntityAttributeName(90063729) := 'LDCI_TRANSOMA@TRSMUSMO';
   LDCISOMA_.tbEntityAttributeName(90063730) := 'LDCI_TRANSOMA@TRSMMPDI';
   LDCISOMA_.tbEntityAttributeName(90063735) := 'LDCI_TRANSOMA@TRSMPROG';
   LDCISOMA_.tbEntityAttributeName(90063731) := 'LDCI_TRANSOMA@TRSMACTI';
   LDCISOMA_.tbEntityAttributeName(90082924) := 'LDCI_TRANSOMA@ORDER_ID';
   LDCISOMA_.tbEntityAttributeName(90185595) := 'LDCI_TRANSOMA@TRSMOBSE';
   LDCISOMA_.tbEntityAttributeName(90185596) := 'LDCI_TRANSOMA@TRSMCOME';
   LDCISOMA_.tbEntityAttributeName(90063734) := 'LDCI_TRANSOMA@TRSMTIPO';
   LDCISOMA_.tbEntityAttributeName(90063726) := 'LDCI_TRANSOMA@TRSMMDPE';
   LDCISOMA_.tbEntityAttributeName(90063722) := 'LDCI_TRANSOMA@TRSMDORE';
   LDCISOMA_.tbEntityAttributeName(90063723) := 'LDCI_TRANSOMA@TRSMDSRE';
   LDCISOMA_.tbEntityAttributeName(90063732) := 'LDCI_TRANSOMA@TRSMSOL';
 
   LDCISOMA_.tbEntityName(1534) := 'LDCI_TRSOITEM';
   LDCISOMA_.tbEntityAttributeName(90063778) := 'LDCI_TRSOITEM@TSITTRSM';
   LDCISOMA_.tbEntityAttributeName(90063779) := 'LDCI_TRSOITEM@TSITITEM';
   LDCISOMA_.tbEntityAttributeName(90063780) := 'LDCI_TRSOITEM@TSITCANT';
   LDCISOMA_.tbEntityAttributeName(90063781) := 'LDCI_TRSOITEM@TSITCARE';
   LDCISOMA_.tbEntityAttributeName(90063782) := 'LDCI_TRSOITEM@TSITVUNI';
   LDCISOMA_.tbEntityAttributeName(90063783) := 'LDCI_TRSOITEM@TSITPIVA';
   LDCISOMA_.tbEntityAttributeName(90063784) := 'LDCI_TRSOITEM@TSITSAFI';
   LDCISOMA_.tbEntityAttributeName(90063785) := 'LDCI_TRSOITEM@TSITMABO';
   LDCISOMA_.tbEntityAttributeName(90063786) := 'LDCI_TRSOITEM@TSITVALO';
   LDCISOMA_.tbEntityAttributeName(90063787) := 'LDCI_TRSOITEM@TSITMDMA';
   LDCISOMA_.tbEntityAttributeName(90063789) := 'LDCI_TRSOITEM@TSITCUDE';
   LDCISOMA_.tbEntityAttributeName(90063790) := 'LDCI_TRSOITEM@TSITSOMA';
   LDCISOMA_.tbEntityAttributeName(90070152) := 'LDCI_TRSOITEM@TSITESIT';
 
   LDCISOMA_.tbEntityName(1540) := 'LDCI_SERIPOSI';
   LDCISOMA_.tbEntityAttributeName(90063836) := 'LDCI_SERIPOSI@SERITRSM';
   LDCISOMA_.tbEntityAttributeName(90063837) := 'LDCI_SERIPOSI@SERITSIT';
   LDCISOMA_.tbEntityAttributeName(90063838) := 'LDCI_SERIPOSI@SERINUME';
   LDCISOMA_.tbEntityAttributeName(90063840) := 'LDCI_SERIPOSI@SERISOMA';
 
END; 
/

BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA');

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA') AND ROLE_ID=1;

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA');

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA');

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA'));

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCISOMA');

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCISOMA';

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.old_tb0_0(0):='LDCISOMA'
;
LDCISOMA_.tb0_0(0):=UPPER(LDCISOMA_.old_tb0_0(0));
LDCISOMA_.old_tb0_1(0):=500000000005499;
LDCISOMA_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCISOMA_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCISOMA_.tb0_1(0):=LDCISOMA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCISOMA_.tb0_0(0),
LDCISOMA_.tb0_1(0),
'Solicitud de material'
,
null,
'205.3'
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
2188,
'C',
to_date('02-07-2024 11:58:21','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb1_0(0):=1;
LDCISOMA_.tb1_1(0):=LDCISOMA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCISOMA_.tb1_0(0),
LDCISOMA_.tb1_1(0));

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb2_0(0):=LDCISOMA_.tb0_1(0);
LDCISOMA_.old_tb2_1(0):=1522;
LDCISOMA_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYNAME(LDCISOMA_.old_tb2_1(0)), 'ENTITY');
LDCISOMA_.tb2_1(0):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb2_2(0):=null;
LDCISOMA_.tb2_2(0):=CASE WHEN (LDCISOMA_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYNAME(LDCISOMA_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCISOMA_.tb2_0(0),
LDCISOMA_.tb2_1(0),
LDCISOMA_.tb2_2(0),
'T'
,
0,
0,
null,
' LDCI_TRANSOMA.TRSMTIPO = 1
AND
LOWER( LDCI_TRANSOMA.TRSMUSMO )  = LOWER(UT_SESSION.GETUSER)
'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(0):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(0):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(0):=90063707;
LDCISOMA_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(0)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(0):=LDCISOMA_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(0),
LDCISOMA_.tb3_1(0),
LDCISOMA_.tb3_2(0),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(1):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(1):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(1):=90063709;
LDCISOMA_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(1)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(1):=LDCISOMA_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(1),
LDCISOMA_.tb3_1(1),
LDCISOMA_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ID_CONTRATISTA "C�DIGO" , NOMBRE_CONTRATISTA "NOMBRE" , DESCRIPCION "DESCRIPCI�N"  FROM GE_CONTRATISTA WHERE   ID_CONTRATISTA IN (
SELECT  CONTRACTOR_ID
FROM    OR_OPERATING_UNIT ,OR_OPER_UNIT_PERSONS, GE_PERSON, SA_USER
WHERE   OR_OPER_UNIT_PERSONS.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID
AND     GE_PERSON.PERSON_ID = OR_OPER_UNIT_PERSONS.PERSON_ID
AND     GE_PERSON.USER_ID = SA_USER.USER_ID
AND     GE_PERSON.USER_ID = SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER)
AND     CONTRACTOR_ID IS NOT NULL) '
,
'N'
,
'C�DIGO'
,
'NOMBRE'
,
'ID_CONTRATISTA C�digo|NOMBRE_CONTRATISTA Nombre|DESCRIPCION Descripci�n|'
,
'FROM GE_CONTRATISTA|'
,
'WHERE   ID_CONTRATISTA IN (
SELECT  CONTRACTOR_ID
FROM    OR_OPERATING_UNIT ,OR_OPER_UNIT_PERSONS, GE_PERSON, SA_USER
WHERE   OR_OPER_UNIT_PERSONS.OPERATING_UNIT_ID = OR_OPERATING_UNIT.OPERATING_UNIT_ID
AND     GE_PERSON.PERSON_ID = OR_OPER_UNIT_PERSONS.PERSON_ID
AND     GE_PERSON.USER_ID = SA_USER.USER_ID
AND     GE_PERSON.USER_ID = SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER)
AND     CONTRACTOR_ID IS NOT NULL)|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(2):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(2):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(2):=90063711;
LDCISOMA_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(2)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(2):=LDCISOMA_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(2),
LDCISOMA_.tb3_1(2),
LDCISOMA_.tb3_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_UNIT_ID "IDENTIFICADOR DE LA UNIDAD DE TRABAJO" , NAME "NOMBRE"  FROM OR_OPERATING_UNIT WHERE OPERATING_UNIT_ID IN
(
    SELECT TO_NUMBER(COLUMN_VALUE)
    FROM TABLE
    (
        LDC_BOUTILITIES.SPLITSTRINGS(
            (SELECT CASEVALO FROM OPEN.LDCI_CARASEWE
            WHERE CASECODI = '|| chr(39) ||'LST_CENTROS_SOL_INV'|| chr(39) ||'
            AND CASEDESE IN ('|| chr(39) ||'WS_RESERVA_MATERIALES'|| chr(39) ||'))
        ,'|| chr(39) ||';'|| chr(39) ||')
    )
) '
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
'WHERE OPERATING_UNIT_ID IN
(
    SELECT TO_NUMBER(COLUMN_VALUE)
    FROM TABLE
    (
        LDC_BOUTILITIES.SPLITSTRINGS(
            (SELECT CASEVALO FROM OPEN.LDCI_CARASEWE
            WHERE CASECODI = '|| chr(39) ||'LST_CENTROS_SOL_INV'|| chr(39) ||'
            AND CASEDESE IN ('|| chr(39) ||'WS_RESERVA_MATERIALES'|| chr(39) ||'))
        ,'|| chr(39) ||';'|| chr(39) ||')
    )
)|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(3):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(3):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(3):=90063713;
LDCISOMA_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(3)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(3):=LDCISOMA_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(3),
LDCISOMA_.tb3_1(3),
LDCISOMA_.tb3_2(3),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_UNIT_ID "IDENTIFICADOR DE LA UNIDAD DE TRABAJO" , NAME "NOMBRE"  FROM OR_OPERATING_UNIT WHERE CONTRACTOR_ID = [TRSMCONT] AND OPER_UNIT_CLASSIF_ID NOT IN
                    ( SELECT TO_NUMBER(COLUMN_VALUE)
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.FSBGETVALUE_CHAIN('|| chr(39) ||'COD_CLASE_OPER_LOGIST'|| chr(39) ||',NULL),'|| chr(39) ||','|| chr(39) ||')
                        )
                    )
 '
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
'WHERE CONTRACTOR_ID = TRSMCONT|AND OPER_UNIT_CLASSIF_ID NOT IN
                    ( SELECT TO_NUMBER(COLUMN_VALUE)
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.FSBGETVALUE_CHAIN('|| chr(39) ||'COD_CLASE_OPER_LOGIST'|| chr(39) ||',NULL),'|| chr(39) ||','|| chr(39) ||')
                        )
                    )
|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(4):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(4):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(4):=90063714;
LDCISOMA_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(4)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(4):=LDCISOMA_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(4),
LDCISOMA_.tb3_1(4),
LDCISOMA_.tb3_2(4),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(5):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(5):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(5):=90063716;
LDCISOMA_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(5)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(5):=LDCISOMA_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(5),
LDCISOMA_.tb3_1(5),
LDCISOMA_.tb3_2(5),
5,
'Y'
,
'N'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(6):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(6):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(6):=90063718;
LDCISOMA_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(6)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(6):=LDCISOMA_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(6),
LDCISOMA_.tb3_1(6),
LDCISOMA_.tb3_2(6),
6,
'Y'
,
'Y'
,
'N'
,
'SELECT  OFVECODI "C�DIGO DE LA OFICINA" , OFVEDESC "DESCRIPCI�N DE LA OFICINA"  FROM LDCI_OFICVENT '
,
'N'
,
'C�DIGO DE LA OFICINA'
,
'DESCRIPCI�N DE LA OFICINA'
,
'OFVECODI C�digo de la Oficina|OFVEDESC Descripci�n de la Oficina|'
,
'FROM LDCI_OFICVENT|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(7):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(7):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(7):=90063720;
LDCISOMA_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(7)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(7):=LDCISOMA_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(7),
LDCISOMA_.tb3_1(7),
LDCISOMA_.tb3_2(7),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(8):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(8):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(8):=90063722;
LDCISOMA_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(8)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(8):=LDCISOMA_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(8),
LDCISOMA_.tb3_1(8),
LDCISOMA_.tb3_2(8),
17,
'N'
,
'Y'
,
'N'
,
'SELECT  TRSMCODI "C�DIGO NRO. FRONT" , TRSMSOL "DESCRIPCION"  FROM LDCI_TRANSOMA WHERE TRSMESTA = 3 '
,
'N'
,
'C�DIGO NRO. FRONT'
,
'DESCRIPCION'
,
'TRSMCODI C�DIGO NRO. FRONT|TRSMSOL DESCRIPCION|'
,
'FROM LDCI_TRANSOMA|'
,
'WHERE TRSMESTA = 3|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(9):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(9):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(9):=90063723;
LDCISOMA_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(9)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(9):=LDCISOMA_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(9),
LDCISOMA_.tb3_1(9),
LDCISOMA_.tb3_2(9),
18,
'N'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(10):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(10):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(10):=90063726;
LDCISOMA_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(10)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(10):=LDCISOMA_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(10),
LDCISOMA_.tb3_1(10),
LDCISOMA_.tb3_2(10),
16,
'N'
,
'Y'
,
'N'
,
'SELECT  MDMACODI "CODIGO MOTIVO DEVOLUCION DEL MATERIAL" , MDMADESC "DESCRIPCI�N MOTIVO DE DEVOLUCI�N DEL MATERIAL"  FROM LDCI_MOTIDEMA '
,
'N'
,
'CODIGO MOTIVO DEVOLUCION DEL MATERIAL'
,
'DESCRIPCI�N MOTIVO DE DEVOLUCI�N DEL MATERIAL'
,
'MDMACODI Codigo Motivo devolucion del material|MDMADESC Descripci�n motivo de devoluci�n del material|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(11):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(11):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(11):=90063729;
LDCISOMA_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(11)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(11):=LDCISOMA_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(11),
LDCISOMA_.tb3_1(11),
LDCISOMA_.tb3_2(11),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(12):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(12):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(12):=90063730;
LDCISOMA_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(12)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(12):=LDCISOMA_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(12),
LDCISOMA_.tb3_1(12),
LDCISOMA_.tb3_2(12),
9,
'Y'
,
'Y'
,
'N'
,
'SELECT  MOPECODI "CODIGO MOTIVO" , MOPEDESC "DESCRIPCION"  FROM LDCI_MOTIPEDI '
,
'N'
,
'CODIGO MOTIVO'
,
'DESCRIPCION'
,
'MOPECODI Codigo motivo|MOPEDESC Descripcion|'
,
'FROM LDCI_MOTIPEDI|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(13):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(13):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(13):=90063731;
LDCISOMA_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(13)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(13):=LDCISOMA_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(13),
LDCISOMA_.tb3_1(13),
LDCISOMA_.tb3_2(13),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(14):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(14):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(14):=90063732;
LDCISOMA_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(14)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(14):=LDCISOMA_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(14),
LDCISOMA_.tb3_1(14),
LDCISOMA_.tb3_2(14),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(15):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(15):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(15):=90063734;
LDCISOMA_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(15)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(15):=LDCISOMA_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(15),
LDCISOMA_.tb3_1(15),
LDCISOMA_.tb3_2(15),
15,
'N'
,
'N'
,
'N'
,
'SELECT  TIPOCODI "CODIGO" , TIPODESC "DESCRIPCION"  FROM LDCI_TIPOSSOLI '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'TIPOCODI Codigo|TIPODESC Descripcion|'
,
'FROM LDCI_TIPOSSOLI|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(16):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(16):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(16):=90063735;
LDCISOMA_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(16)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(16):=LDCISOMA_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(16),
LDCISOMA_.tb3_1(16),
LDCISOMA_.tb3_2(16),
10,
'Y'
,
'N'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(17):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(17):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(17):=90082924;
LDCISOMA_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(17)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(17):=LDCISOMA_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(17),
LDCISOMA_.tb3_1(17),
LDCISOMA_.tb3_2(17),
12,
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(18):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(18):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(18):=90185595;
LDCISOMA_.tb3_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(18)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(18):=LDCISOMA_.tb3_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(18),
LDCISOMA_.tb3_1(18),
LDCISOMA_.tb3_2(18),
13,
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
'M'
,
null,
null,
null,
null);

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(19):=LDCISOMA_.tb2_0(0);
LDCISOMA_.tb3_1(19):=LDCISOMA_.tb2_1(0);
LDCISOMA_.old_tb3_2(19):=90185596;
LDCISOMA_.tb3_2(19):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(19)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(19):=LDCISOMA_.tb3_2(19);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (19)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(19),
LDCISOMA_.tb3_1(19),
LDCISOMA_.tb3_2(19),
14,
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb2_0(1):=LDCISOMA_.tb0_1(0);
LDCISOMA_.old_tb2_1(1):=1534;
LDCISOMA_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYNAME(LDCISOMA_.old_tb2_1(1)), 'ENTITY');
LDCISOMA_.tb2_1(1):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb2_2(1):=1522;
LDCISOMA_.tb2_2(1):=CASE WHEN (LDCISOMA_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYNAME(LDCISOMA_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCISOMA_.tb2_0(1),
LDCISOMA_.tb2_1(1),
LDCISOMA_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDCI_TRSOITEM.TSITSOMA  =  LDCI_TRANSOMA.TRSMCODI '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(20):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(20):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(20):=90063778;
LDCISOMA_.tb3_2(20):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(20)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(20):=LDCISOMA_.tb3_2(20);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (20)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(20),
LDCISOMA_.tb3_1(20),
LDCISOMA_.tb3_2(20),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(21):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(21):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(21):=90063779;
LDCISOMA_.tb3_2(21):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(21)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(21):=LDCISOMA_.tb3_2(21);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (21)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(21),
LDCISOMA_.tb3_1(21),
LDCISOMA_.tb3_2(21),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "C�DIGO" , DESCRIPTION "DESCRIPCI�N" , CODE "C�DIGO EXTERNO"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID IN (8,3,21) AND  NVL(OBSOLETO,'|| chr(39) ||'N'|| chr(39) ||') = '|| chr(39) ||'N'|| chr(39) ||' '
,
'N'
,
'C�DIGO'
,
'DESCRIPCI�N'
,
'ITEMS_ID C�digo|DESCRIPTION Descripci�n|CODE C�digo Externo|'
,
'FROM GE_ITEMS|'
,
'WHERE ITEM_CLASSIF_ID IN (8,3,21)|AND  NVL(OBSOLETO,'|| chr(39) ||'N'|| chr(39) ||') = '|| chr(39) ||'N'|| chr(39) ||'|'
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(22):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(22):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(22):=90063780;
LDCISOMA_.tb3_2(22):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(22)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(22):=LDCISOMA_.tb3_2(22);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (22)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(22),
LDCISOMA_.tb3_1(22),
LDCISOMA_.tb3_2(22),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(23):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(23):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(23):=90063781;
LDCISOMA_.tb3_2(23):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(23)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(23):=LDCISOMA_.tb3_2(23);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (23)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(23),
LDCISOMA_.tb3_1(23),
LDCISOMA_.tb3_2(23),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(24):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(24):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(24):=90063782;
LDCISOMA_.tb3_2(24):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(24)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(24):=LDCISOMA_.tb3_2(24);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (24)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(24),
LDCISOMA_.tb3_1(24),
LDCISOMA_.tb3_2(24),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(25):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(25):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(25):=90063783;
LDCISOMA_.tb3_2(25):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(25)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(25):=LDCISOMA_.tb3_2(25);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (25)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(25),
LDCISOMA_.tb3_1(25),
LDCISOMA_.tb3_2(25),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(26):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(26):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(26):=90063784;
LDCISOMA_.tb3_2(26):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(26)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(26):=LDCISOMA_.tb3_2(26);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (26)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(26),
LDCISOMA_.tb3_1(26),
LDCISOMA_.tb3_2(26),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(27):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(27):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(27):=90063785;
LDCISOMA_.tb3_2(27):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(27)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(27):=LDCISOMA_.tb3_2(27);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (27)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(27),
LDCISOMA_.tb3_1(27),
LDCISOMA_.tb3_2(27),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(28):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(28):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(28):=90063786;
LDCISOMA_.tb3_2(28):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(28)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(28):=LDCISOMA_.tb3_2(28);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (28)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(28),
LDCISOMA_.tb3_1(28),
LDCISOMA_.tb3_2(28),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(29):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(29):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(29):=90063787;
LDCISOMA_.tb3_2(29):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(29)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(29):=LDCISOMA_.tb3_2(29);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (29)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(29),
LDCISOMA_.tb3_1(29),
LDCISOMA_.tb3_2(29),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(30):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(30):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(30):=90063789;
LDCISOMA_.tb3_2(30):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(30)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(30):=LDCISOMA_.tb3_2(30);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (30)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(30),
LDCISOMA_.tb3_1(30),
LDCISOMA_.tb3_2(30),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(31):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(31):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(31):=90063790;
LDCISOMA_.tb3_2(31):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(31)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(31):=LDCISOMA_.tb3_2(31);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (31)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(31),
LDCISOMA_.tb3_1(31),
LDCISOMA_.tb3_2(31),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(32):=LDCISOMA_.tb2_0(1);
LDCISOMA_.tb3_1(32):=LDCISOMA_.tb2_1(1);
LDCISOMA_.old_tb3_2(32):=90070152;
LDCISOMA_.tb3_2(32):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(32)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(32):=LDCISOMA_.tb3_2(32);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (32)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(32),
LDCISOMA_.tb3_1(32),
LDCISOMA_.tb3_2(32),
12,
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb2_0(2):=LDCISOMA_.tb0_1(0);
LDCISOMA_.old_tb2_1(2):=1540;
LDCISOMA_.tb2_1(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYNAME(LDCISOMA_.old_tb2_1(2)), 'ENTITY');
LDCISOMA_.tb2_1(2):=LDCISOMA_.tb2_1(2);
LDCISOMA_.old_tb2_2(2):=1534;
LDCISOMA_.tb2_2(2):=CASE WHEN (LDCISOMA_.old_tb2_2(2) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYNAME(LDCISOMA_.old_tb2_2(2)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (2)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCISOMA_.tb2_0(2),
LDCISOMA_.tb2_1(2),
LDCISOMA_.tb2_2(2),
'G'
,
2,
0,
null,
null,
' LDCI_SERIPOSI.SERITSIT   =  LDCI_TRSOITEM.TSITITEM  AND  LDCI_SERIPOSI.SERISOMA  =  LDCI_TRSOITEM.TSITSOMA '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(33):=LDCISOMA_.tb2_0(2);
LDCISOMA_.tb3_1(33):=LDCISOMA_.tb2_1(2);
LDCISOMA_.old_tb3_2(33):=90063836;
LDCISOMA_.tb3_2(33):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(33)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(33):=LDCISOMA_.tb3_2(33);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (33)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(33),
LDCISOMA_.tb3_1(33),
LDCISOMA_.tb3_2(33),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(34):=LDCISOMA_.tb2_0(2);
LDCISOMA_.tb3_1(34):=LDCISOMA_.tb2_1(2);
LDCISOMA_.old_tb3_2(34):=90063837;
LDCISOMA_.tb3_2(34):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(34)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(34):=LDCISOMA_.tb3_2(34);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (34)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(34),
LDCISOMA_.tb3_1(34),
LDCISOMA_.tb3_2(34),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(35):=LDCISOMA_.tb2_0(2);
LDCISOMA_.tb3_1(35):=LDCISOMA_.tb2_1(2);
LDCISOMA_.old_tb3_2(35):=90063838;
LDCISOMA_.tb3_2(35):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(35)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(35):=LDCISOMA_.tb3_2(35);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (35)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(35),
LDCISOMA_.tb3_1(35),
LDCISOMA_.tb3_2(35),
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
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;

LDCISOMA_.tb3_0(36):=LDCISOMA_.tb2_0(2);
LDCISOMA_.tb3_1(36):=LDCISOMA_.tb2_1(2);
LDCISOMA_.old_tb3_2(36):=90063840;
LDCISOMA_.tb3_2(36):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCISOMA_.TBENTITYATTRIBUTENAME(LDCISOMA_.old_tb3_2(36)), 'ATTRIBUTE');
LDCISOMA_.tb3_2(36):=LDCISOMA_.tb3_2(36);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (36)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCISOMA_.tb3_0(36),
LDCISOMA_.tb3_1(36),
LDCISOMA_.tb3_2(36),
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
LDCISOMA_.blProcessStatus := false;
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
 nuIndexInternal := LDCISOMA_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCISOMA_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCISOMA_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCISOMA_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCISOMA_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCISOMA_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCISOMA_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCISOMA_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCISOMA_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCISOMA_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCISOMA_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCISOMA_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCISOMA_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCISOMA_.tbUserException(nuIndex).user_id, LDCISOMA_.tbUserException(nuIndex).status , LDCISOMA_.tbUserException(nuIndex).usr_exc_type_id, LDCISOMA_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCISOMA_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCISOMA_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCISOMA_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCISOMA_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCISOMA_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCISOMA_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCISOMA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCISOMA_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCISOMA_******************************'); end;
/

