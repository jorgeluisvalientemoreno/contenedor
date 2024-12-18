BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LECTESP_',
'CREATE OR REPLACE PACKAGE LECTESP_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LECTESP''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LECTESP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LECTESP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LECTESP'' ' || chr(10) ||
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
'END LECTESP_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LECTESP_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
Open LECTESP_.cuRoleExecutables;
loop
 fetch LECTESP_.cuRoleExecutables INTO LECTESP_.rcRoleExecutables;
 exit when  LECTESP_.cuRoleExecutables%notfound;
 LECTESP_.tbRoleExecutables(nuIndex) := LECTESP_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LECTESP_.cuRoleExecutables;
nuIndex := 0;
Open LECTESP_.cuUserExceptions ;
loop
 fetch LECTESP_.cuUserExceptions INTO  LECTESP_.rcUserExceptions;
 exit when LECTESP_.cuUserExceptions%notfound;
 LECTESP_.tbUserException(nuIndex):=LECTESP_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LECTESP_.cuUserExceptions;
nuIndex := 0;
Open LECTESP_.cuExecEntities ;
loop
 fetch LECTESP_.cuExecEntities INTO  LECTESP_.rcExecEntities;
 exit when LECTESP_.cuExecEntities%notfound;
 LECTESP_.tbExecEntities(nuIndex):=LECTESP_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LECTESP_.cuExecEntities;

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP'
);

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LECTESP_.tbEntityName(3831) := 'LDC_CM_LECTESP';
   LECTESP_.tbEntityAttributeName(90132973) := 'LDC_CM_LECTESP@ORDER_ID';
   LECTESP_.tbEntityAttributeName(90132974) := 'LDC_CM_LECTESP@SESUNUSE';
   LECTESP_.tbEntityAttributeName(90132975) := 'LDC_CM_LECTESP@CONSEC_EXT';
   LECTESP_.tbEntityAttributeName(90132976) := 'LDC_CM_LECTESP@PEFACODI';
   LECTESP_.tbEntityAttributeName(90132970) := 'LDC_CM_LECTESP@PECSCONS';
   LECTESP_.tbEntityAttributeName(90132977) := 'LDC_CM_LECTESP@FELECTURA';
   LECTESP_.tbEntityAttributeName(90132978) := 'LDC_CM_LECTESP@FEREGISTRO';
   LECTESP_.tbEntityAttributeName(90132979) := 'LDC_CM_LECTESP@LECTURA';
   LECTESP_.tbEntityAttributeName(90132980) := 'LDC_CM_LECTESP@TEMPERATURA';
   LECTESP_.tbEntityAttributeName(90132971) := 'LDC_CM_LECTESP@PRES';
   LECTESP_.tbEntityAttributeName(90132981) := 'LDC_CM_LECTESP@PRESALT';
   LECTESP_.tbEntityAttributeName(90132982) := 'LDC_CM_LECTESP@PRESBJ';
   LECTESP_.tbEntityAttributeName(90132983) := 'LDC_CM_LECTESP@VOLCORR';
   LECTESP_.tbEntityAttributeName(90132984) := 'LDC_CM_LECTESP@VOLNCORR';
   LECTESP_.tbEntityAttributeName(90132985) := 'LDC_CM_LECTESP@LECT_EAGLE';
   LECTESP_.tbEntityAttributeName(90132986) := 'LDC_CM_LECTESP@VOLTBAT';
   LECTESP_.tbEntityAttributeName(90132987) := 'LDC_CM_LECTESP@USOCONS';
   LECTESP_.tbEntityAttributeName(90132972) := 'LDC_CM_LECTESP@PROCESADO';
   LECTESP_.tbEntityAttributeName(90132988) := 'LDC_CM_LECTESP@CLIENTE';
   LECTESP_.tbEntityAttributeName(90147401) := 'LDC_CM_LECTESP@SUBSCRIBER_ID';
   LECTESP_.tbEntityAttributeName(90132989) := 'LDC_CM_LECTESP@MEDIDOR';
   LECTESP_.tbEntityAttributeName(90132990) := 'LDC_CM_LECTESP@CONTRATO';
   LECTESP_.tbEntityAttributeName(90141326) := 'LDC_CM_LECTESP@CAUSAL';
   LECTESP_.tbEntityAttributeName(90141327) := 'LDC_CM_LECTESP@CAUSAL_OBS';
   LECTESP_.tbEntityAttributeName(90199398) := 'LDC_CM_LECTESP@OBSERVACION';
   LECTESP_.tbEntityAttributeName(90147402) := 'LDC_CM_LECTESP@ADDRESS_ID';
   LECTESP_.tbEntityAttributeName(90147403) := 'LDC_CM_LECTESP@LOCALIDAD';
   LECTESP_.tbEntityAttributeName(90147404) := 'LDC_CM_LECTESP@DPTO';
 
END; 
/

BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP');

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP') AND ROLE_ID=1;

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP');

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP');

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP'));

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LECTESP');

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LECTESP';

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.old_tb0_0(0):='LECTESP'
;
LECTESP_.tb0_0(0):=UPPER(LECTESP_.old_tb0_0(0));
LECTESP_.old_tb0_1(0):=500000000011131;
LECTESP_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LECTESP_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LECTESP_.tb0_1(0):=LECTESP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LECTESP_.tb0_0(0),
LECTESP_.tb0_1(0),
'Listado de Lecturas de Clientes Especiales'
,
null,
'13'
,
8,
2,
80,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
202,
'C',
to_date('19-09-2023 14:14:21','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb1_0(0):=1;
LECTESP_.tb1_1(0):=LECTESP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LECTESP_.tb1_0(0),
LECTESP_.tb1_1(0));

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb2_0(0):=LECTESP_.tb0_1(0);
LECTESP_.old_tb2_1(0):=3831;
LECTESP_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYNAME(LECTESP_.old_tb2_1(0)), 'ENTITY');
LECTESP_.tb2_1(0):=LECTESP_.tb2_1(0);
LECTESP_.old_tb2_2(0):=null;
LECTESP_.tb2_2(0):=CASE WHEN (LECTESP_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYNAME(LECTESP_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LECTESP_.tb2_0(0),
LECTESP_.tb2_1(0),
LECTESP_.tb2_2(0),
'G'
,
0,
0,
null,
' LDC_CM_LECTESP.PEFACODI  IN  (SELECT PERIFACT.PEFACODI
FROM PERIFACT, LDC_CM_LECTESP_CICL, LDC_CM_LECTESP_PETC
WHERE PERIFACT.PEFACICL = LDC_CM_LECTESP_CICL.PECSCICO
AND LDC_CM_LECTESP_CICL.PECSTPCI = LDC_CM_LECTESP_PETC.TIPOCICL_ID
AND LDC_CM_LECTESP_PETC.PERSON_ID = GE_BOPERSONAL.FNUGETPERSONID)'
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(0):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(0):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(0):=90132970;
LECTESP_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(0)), 'ATTRIBUTE');
LECTESP_.tb3_2(0):=LECTESP_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(0),
LECTESP_.tb3_1(0),
LECTESP_.tb3_2(0),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(1):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(1):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(1):=90132971;
LECTESP_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(1)), 'ATTRIBUTE');
LECTESP_.tb3_2(1):=LECTESP_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(1),
LECTESP_.tb3_1(1),
LECTESP_.tb3_2(1),
9,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(2):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(2):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(2):=90132972;
LECTESP_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(2)), 'ATTRIBUTE');
LECTESP_.tb3_2(2):=LECTESP_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(2),
LECTESP_.tb3_1(2),
LECTESP_.tb3_2(2),
17,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(3):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(3):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(3):=90132973;
LECTESP_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(3)), 'ATTRIBUTE');
LECTESP_.tb3_2(3):=LECTESP_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(3),
LECTESP_.tb3_1(3),
LECTESP_.tb3_2(3),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(4):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(4):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(4):=90132974;
LECTESP_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(4)), 'ATTRIBUTE');
LECTESP_.tb3_2(4):=LECTESP_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(4),
LECTESP_.tb3_1(4),
LECTESP_.tb3_2(4),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(5):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(5):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(5):=90132975;
LECTESP_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(5)), 'ATTRIBUTE');
LECTESP_.tb3_2(5):=LECTESP_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(5),
LECTESP_.tb3_1(5),
LECTESP_.tb3_2(5),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(6):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(6):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(6):=90132976;
LECTESP_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(6)), 'ATTRIBUTE');
LECTESP_.tb3_2(6):=LECTESP_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(6),
LECTESP_.tb3_1(6),
LECTESP_.tb3_2(6),
3,
'Y'
,
'N'
,
'N'
,
'SELECT PEFACODI "C¿DIGO",PEFADESC "DESCRIPCI¿N" FROM PERIFACT'
,
'N'
,
'C¿digo'
,
'Descripci¿n'
,
'PEFACODI C¿digo|PEFADESC Descripci¿n|'
,
'FROM PERIFACT'
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(7):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(7):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(7):=90132977;
LECTESP_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(7)), 'ATTRIBUTE');
LECTESP_.tb3_2(7):=LECTESP_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(7),
LECTESP_.tb3_1(7),
LECTESP_.tb3_2(7),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(8):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(8):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(8):=90132978;
LECTESP_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(8)), 'ATTRIBUTE');
LECTESP_.tb3_2(8):=LECTESP_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(8),
LECTESP_.tb3_1(8),
LECTESP_.tb3_2(8),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(9):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(9):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(9):=90132979;
LECTESP_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(9)), 'ATTRIBUTE');
LECTESP_.tb3_2(9):=LECTESP_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(9),
LECTESP_.tb3_1(9),
LECTESP_.tb3_2(9),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(10):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(10):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(10):=90132980;
LECTESP_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(10)), 'ATTRIBUTE');
LECTESP_.tb3_2(10):=LECTESP_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(10),
LECTESP_.tb3_1(10),
LECTESP_.tb3_2(10),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(11):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(11):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(11):=90132981;
LECTESP_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(11)), 'ATTRIBUTE');
LECTESP_.tb3_2(11):=LECTESP_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(11),
LECTESP_.tb3_1(11),
LECTESP_.tb3_2(11),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(12):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(12):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(12):=90132982;
LECTESP_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(12)), 'ATTRIBUTE');
LECTESP_.tb3_2(12):=LECTESP_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(12),
LECTESP_.tb3_1(12),
LECTESP_.tb3_2(12),
11,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(13):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(13):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(13):=90132983;
LECTESP_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(13)), 'ATTRIBUTE');
LECTESP_.tb3_2(13):=LECTESP_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(13),
LECTESP_.tb3_1(13),
LECTESP_.tb3_2(13),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(14):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(14):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(14):=90132984;
LECTESP_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(14)), 'ATTRIBUTE');
LECTESP_.tb3_2(14):=LECTESP_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(14),
LECTESP_.tb3_1(14),
LECTESP_.tb3_2(14),
13,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(15):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(15):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(15):=90132985;
LECTESP_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(15)), 'ATTRIBUTE');
LECTESP_.tb3_2(15):=LECTESP_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(15),
LECTESP_.tb3_1(15),
LECTESP_.tb3_2(15),
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(16):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(16):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(16):=90132986;
LECTESP_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(16)), 'ATTRIBUTE');
LECTESP_.tb3_2(16):=LECTESP_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(16),
LECTESP_.tb3_1(16),
LECTESP_.tb3_2(16),
15,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(17):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(17):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(17):=90132987;
LECTESP_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(17)), 'ATTRIBUTE');
LECTESP_.tb3_2(17):=LECTESP_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(17),
LECTESP_.tb3_1(17),
LECTESP_.tb3_2(17),
16,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(18):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(18):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(18):=90132988;
LECTESP_.tb3_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(18)), 'ATTRIBUTE');
LECTESP_.tb3_2(18):=LECTESP_.tb3_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(18),
LECTESP_.tb3_1(18),
LECTESP_.tb3_2(18),
18,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(19):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(19):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(19):=90132989;
LECTESP_.tb3_2(19):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(19)), 'ATTRIBUTE');
LECTESP_.tb3_2(19):=LECTESP_.tb3_2(19);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (19)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(19),
LECTESP_.tb3_1(19),
LECTESP_.tb3_2(19),
20,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(20):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(20):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(20):=90132990;
LECTESP_.tb3_2(20):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(20)), 'ATTRIBUTE');
LECTESP_.tb3_2(20):=LECTESP_.tb3_2(20);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (20)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(20),
LECTESP_.tb3_1(20),
LECTESP_.tb3_2(20),
21,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(21):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(21):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(21):=90141326;
LECTESP_.tb3_2(21):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(21)), 'ATTRIBUTE');
LECTESP_.tb3_2(21):=LECTESP_.tb3_2(21);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (21)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(21),
LECTESP_.tb3_1(21),
LECTESP_.tb3_2(21),
22,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(22):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(22):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(22):=90141327;
LECTESP_.tb3_2(22):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(22)), 'ATTRIBUTE');
LECTESP_.tb3_2(22):=LECTESP_.tb3_2(22);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (22)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(22),
LECTESP_.tb3_1(22),
LECTESP_.tb3_2(22),
23,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(23):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(23):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(23):=90147401;
LECTESP_.tb3_2(23):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(23)), 'ATTRIBUTE');
LECTESP_.tb3_2(23):=LECTESP_.tb3_2(23);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (23)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(23),
LECTESP_.tb3_1(23),
LECTESP_.tb3_2(23),
19,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(24):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(24):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(24):=90147402;
LECTESP_.tb3_2(24):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(24)), 'ATTRIBUTE');
LECTESP_.tb3_2(24):=LECTESP_.tb3_2(24);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (24)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(24),
LECTESP_.tb3_1(24),
LECTESP_.tb3_2(24),
25,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(25):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(25):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(25):=90147403;
LECTESP_.tb3_2(25):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(25)), 'ATTRIBUTE');
LECTESP_.tb3_2(25):=LECTESP_.tb3_2(25);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (25)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(25),
LECTESP_.tb3_1(25),
LECTESP_.tb3_2(25),
26,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(26):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(26):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(26):=90147404;
LECTESP_.tb3_2(26):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(26)), 'ATTRIBUTE');
LECTESP_.tb3_2(26):=LECTESP_.tb3_2(26);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (26)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(26),
LECTESP_.tb3_1(26),
LECTESP_.tb3_2(26),
27,
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
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;

LECTESP_.tb3_0(27):=LECTESP_.tb2_0(0);
LECTESP_.tb3_1(27):=LECTESP_.tb2_1(0);
LECTESP_.old_tb3_2(27):=90199398;
LECTESP_.tb3_2(27):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LECTESP_.TBENTITYATTRIBUTENAME(LECTESP_.old_tb3_2(27)), 'ATTRIBUTE');
LECTESP_.tb3_2(27):=LECTESP_.tb3_2(27);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (27)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LECTESP_.tb3_0(27),
LECTESP_.tb3_1(27),
LECTESP_.tb3_2(27),
24,
'Y'
,
'N'
,
'N'
,
'SELECT  OBLECODI "CÓDIGO" , OBLEDESC "DESCRIPCIÓN"  FROM OBSELECT WHERE OBLECODI = [OBSERVACION] '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'OBLECODI Código|OBLEDESC Descripción|'
,
'FROM OBSELECT|'
,
'WHERE OBLECODI = OBSERVACION|'
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
LECTESP_.blProcessStatus := false;
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
 nuIndexInternal := LECTESP_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LECTESP_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LECTESP_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LECTESP_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LECTESP_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LECTESP_.blProcessStatus) then
 return;
end if;
nuIndex :=  LECTESP_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LECTESP_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LECTESP_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LECTESP_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LECTESP_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LECTESP_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LECTESP_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LECTESP_.tbUserException(nuIndex).user_id, LECTESP_.tbUserException(nuIndex).status , LECTESP_.tbUserException(nuIndex).usr_exc_type_id, LECTESP_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LECTESP_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LECTESP_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LECTESP_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LECTESP_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LECTESP_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LECTESP_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LECTESP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LECTESP_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LECTESP_******************************'); end;
/

