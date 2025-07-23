BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCIMOTIPEDI_',
'CREATE OR REPLACE PACKAGE LDCIMOTIPEDI_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCIMOTIPEDI''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIMOTIPEDI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIMOTIPEDI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIMOTIPEDI'' ' || chr(10) ||
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
'END LDCIMOTIPEDI_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCIMOTIPEDI_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
Open LDCIMOTIPEDI_.cuRoleExecutables;
loop
 fetch LDCIMOTIPEDI_.cuRoleExecutables INTO LDCIMOTIPEDI_.rcRoleExecutables;
 exit when  LDCIMOTIPEDI_.cuRoleExecutables%notfound;
 LDCIMOTIPEDI_.tbRoleExecutables(nuIndex) := LDCIMOTIPEDI_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCIMOTIPEDI_.cuRoleExecutables;
nuIndex := 0;
Open LDCIMOTIPEDI_.cuUserExceptions ;
loop
 fetch LDCIMOTIPEDI_.cuUserExceptions INTO  LDCIMOTIPEDI_.rcUserExceptions;
 exit when LDCIMOTIPEDI_.cuUserExceptions%notfound;
 LDCIMOTIPEDI_.tbUserException(nuIndex):=LDCIMOTIPEDI_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCIMOTIPEDI_.cuUserExceptions;
nuIndex := 0;
Open LDCIMOTIPEDI_.cuExecEntities ;
loop
 fetch LDCIMOTIPEDI_.cuExecEntities INTO  LDCIMOTIPEDI_.rcExecEntities;
 exit when LDCIMOTIPEDI_.cuExecEntities%notfound;
 LDCIMOTIPEDI_.tbExecEntities(nuIndex):=LDCIMOTIPEDI_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCIMOTIPEDI_.cuExecEntities;

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI'
);

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCIMOTIPEDI_.tbEntityName(1506) := 'LDCI_MOTIPEDI';
   LDCIMOTIPEDI_.tbEntityAttributeName(90063671) := 'LDCI_MOTIPEDI@MOPECODI';
   LDCIMOTIPEDI_.tbEntityAttributeName(90063672) := 'LDCI_MOTIPEDI@MOPEDESC';
   LDCIMOTIPEDI_.tbEntityAttributeName(90063673) := 'LDCI_MOTIPEDI@MOPECLDO';
   LDCIMOTIPEDI_.tbEntityAttributeName(90082906) := 'LDCI_MOTIPEDI@MOPEFLAG';
   LDCIMOTIPEDI_.tbEntityAttributeName(90200536) := 'LDCI_MOTIPEDI@EMPRESA';
 
END; 
/

BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI');

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI') AND ROLE_ID=1;

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI');

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI');

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI'));

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI');

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCIMOTIPEDI';

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.old_tb0_0(0):='LDCIMOTIPEDI'
;
LDCIMOTIPEDI_.tb0_0(0):=UPPER(LDCIMOTIPEDI_.old_tb0_0(0));
LDCIMOTIPEDI_.old_tb0_1(0):=500000000005489;
LDCIMOTIPEDI_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCIMOTIPEDI_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCIMOTIPEDI_.tb0_1(0):=LDCIMOTIPEDI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCIMOTIPEDI_.tb0_0(0),
LDCIMOTIPEDI_.tb0_1(0),
'Motivos de Venta'
,
null,
'16'
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
20,
'C'
,
to_date('22-04-2025 17:36:03','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb1_0(0):=1;
LDCIMOTIPEDI_.tb1_1(0):=LDCIMOTIPEDI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCIMOTIPEDI_.tb1_0(0),
LDCIMOTIPEDI_.tb1_1(0));

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb2_0(0):=LDCIMOTIPEDI_.tb0_1(0);
LDCIMOTIPEDI_.old_tb2_1(0):=1506;
LDCIMOTIPEDI_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYNAME(LDCIMOTIPEDI_.old_tb2_1(0)), 'ENTITY');
LDCIMOTIPEDI_.tb2_1(0):=LDCIMOTIPEDI_.tb2_1(0);
LDCIMOTIPEDI_.old_tb2_2(0):=null;
LDCIMOTIPEDI_.tb2_2(0):=CASE WHEN (LDCIMOTIPEDI_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYNAME(LDCIMOTIPEDI_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCIMOTIPEDI_.tb2_0(0),
LDCIMOTIPEDI_.tb2_1(0),
LDCIMOTIPEDI_.tb2_2(0),
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
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb3_0(0):=LDCIMOTIPEDI_.tb2_0(0);
LDCIMOTIPEDI_.tb3_1(0):=LDCIMOTIPEDI_.tb2_1(0);
LDCIMOTIPEDI_.old_tb3_2(0):=90063671;
LDCIMOTIPEDI_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYATTRIBUTENAME(LDCIMOTIPEDI_.old_tb3_2(0)), 'ATTRIBUTE');
LDCIMOTIPEDI_.tb3_2(0):=LDCIMOTIPEDI_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIMOTIPEDI_.tb3_0(0),
LDCIMOTIPEDI_.tb3_1(0),
LDCIMOTIPEDI_.tb3_2(0),
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
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb3_0(1):=LDCIMOTIPEDI_.tb2_0(0);
LDCIMOTIPEDI_.tb3_1(1):=LDCIMOTIPEDI_.tb2_1(0);
LDCIMOTIPEDI_.old_tb3_2(1):=90063672;
LDCIMOTIPEDI_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYATTRIBUTENAME(LDCIMOTIPEDI_.old_tb3_2(1)), 'ATTRIBUTE');
LDCIMOTIPEDI_.tb3_2(1):=LDCIMOTIPEDI_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIMOTIPEDI_.tb3_0(1),
LDCIMOTIPEDI_.tb3_1(1),
LDCIMOTIPEDI_.tb3_2(1),
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
'M'
,
null,
null,
null,
null);

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb3_0(2):=LDCIMOTIPEDI_.tb2_0(0);
LDCIMOTIPEDI_.tb3_1(2):=LDCIMOTIPEDI_.tb2_1(0);
LDCIMOTIPEDI_.old_tb3_2(2):=90063673;
LDCIMOTIPEDI_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYATTRIBUTENAME(LDCIMOTIPEDI_.old_tb3_2(2)), 'ATTRIBUTE');
LDCIMOTIPEDI_.tb3_2(2):=LDCIMOTIPEDI_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIMOTIPEDI_.tb3_0(2),
LDCIMOTIPEDI_.tb3_1(2),
LDCIMOTIPEDI_.tb3_2(2),
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
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb3_0(3):=LDCIMOTIPEDI_.tb2_0(0);
LDCIMOTIPEDI_.tb3_1(3):=LDCIMOTIPEDI_.tb2_1(0);
LDCIMOTIPEDI_.old_tb3_2(3):=90082906;
LDCIMOTIPEDI_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYATTRIBUTENAME(LDCIMOTIPEDI_.old_tb3_2(3)), 'ATTRIBUTE');
LDCIMOTIPEDI_.tb3_2(3):=LDCIMOTIPEDI_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIMOTIPEDI_.tb3_0(3),
LDCIMOTIPEDI_.tb3_1(3),
LDCIMOTIPEDI_.tb3_2(3),
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
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;

LDCIMOTIPEDI_.tb3_0(4):=LDCIMOTIPEDI_.tb2_0(0);
LDCIMOTIPEDI_.tb3_1(4):=LDCIMOTIPEDI_.tb2_1(0);
LDCIMOTIPEDI_.old_tb3_2(4):=90200536;
LDCIMOTIPEDI_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIMOTIPEDI_.TBENTITYATTRIBUTENAME(LDCIMOTIPEDI_.old_tb3_2(4)), 'ATTRIBUTE');
LDCIMOTIPEDI_.tb3_2(4):=LDCIMOTIPEDI_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIMOTIPEDI_.tb3_0(4),
LDCIMOTIPEDI_.tb3_1(4),
LDCIMOTIPEDI_.tb3_2(4),
4,
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
LDCIMOTIPEDI_.blProcessStatus := false;
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
 nuIndexInternal := LDCIMOTIPEDI_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCIMOTIPEDI_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCIMOTIPEDI_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCIMOTIPEDI_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCIMOTIPEDI_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCIMOTIPEDI_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCIMOTIPEDI_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCIMOTIPEDI_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCIMOTIPEDI_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCIMOTIPEDI_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCIMOTIPEDI_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCIMOTIPEDI_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCIMOTIPEDI_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCIMOTIPEDI_.tbUserException(nuIndex).user_id, LDCIMOTIPEDI_.tbUserException(nuIndex).status , LDCIMOTIPEDI_.tbUserException(nuIndex).usr_exc_type_id, LDCIMOTIPEDI_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCIMOTIPEDI_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCIMOTIPEDI_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCIMOTIPEDI_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCIMOTIPEDI_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCIMOTIPEDI_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCIMOTIPEDI_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCIMOTIPEDI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCIMOTIPEDI_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCIMOTIPEDI_******************************'); end;
/

