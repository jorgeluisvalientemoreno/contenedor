BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCHOIMIA_',
'CREATE OR REPLACE PACKAGE LDCHOIMIA_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCHOIMIA''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCHOIMIA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCHOIMIA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCHOIMIA'' ' || chr(10) ||
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
'END LDCHOIMIA_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCHOIMIA_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
Open LDCHOIMIA_.cuRoleExecutables;
loop
 fetch LDCHOIMIA_.cuRoleExecutables INTO LDCHOIMIA_.rcRoleExecutables;
 exit when  LDCHOIMIA_.cuRoleExecutables%notfound;
 LDCHOIMIA_.tbRoleExecutables(nuIndex) := LDCHOIMIA_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCHOIMIA_.cuRoleExecutables;
nuIndex := 0;
Open LDCHOIMIA_.cuUserExceptions ;
loop
 fetch LDCHOIMIA_.cuUserExceptions INTO  LDCHOIMIA_.rcUserExceptions;
 exit when LDCHOIMIA_.cuUserExceptions%notfound;
 LDCHOIMIA_.tbUserException(nuIndex):=LDCHOIMIA_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCHOIMIA_.cuUserExceptions;
nuIndex := 0;
Open LDCHOIMIA_.cuExecEntities ;
loop
 fetch LDCHOIMIA_.cuExecEntities INTO  LDCHOIMIA_.rcExecEntities;
 exit when LDCHOIMIA_.cuExecEntities%notfound;
 LDCHOIMIA_.tbExecEntities(nuIndex):=LDCHOIMIA_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCHOIMIA_.cuExecEntities;

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCHOIMIA_.tbEntityName(5141) := 'LDC_HOMOITMAITAC';
   LDCHOIMIA_.tbEntityAttributeName(90171538) := 'LDC_HOMOITMAITAC@ITEM_MATERIAL';
   LDCHOIMIA_.tbEntityAttributeName(90171539) := 'LDC_HOMOITMAITAC@ITEM_ACTIVIDAD';
   LDCHOIMIA_.tbEntityAttributeName(90200638) := 'LDC_HOMOITMAITAC@EMPRESA';
 
END; 
/

BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA');

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA') AND ROLE_ID=1;

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA');

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA');

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA'));

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA');

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCHOIMIA';

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.old_tb0_0(0):='LDCHOIMIA'
;
LDCHOIMIA_.tb0_0(0):=UPPER(LDCHOIMIA_.old_tb0_0(0));
LDCHOIMIA_.old_tb0_1(0):=500000000014107;
LDCHOIMIA_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCHOIMIA_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCHOIMIA_.tb0_1(0):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCHOIMIA_.tb0_0(0),
LDCHOIMIA_.tb0_1(0),
'Homologación item de material items de actividad'
,
null,
'31'
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
252,
'C'
,
to_date('11-06-2025 14:54:56','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(0):=2701;
LDCHOIMIA_.tb1_1(0):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (0)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(0),
LDCHOIMIA_.tb1_1(0),
5312,
5141,
'N'
,
'I'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(1):=2702;
LDCHOIMIA_.tb1_1(1):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (1)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(1),
LDCHOIMIA_.tb1_1(1),
5312,
5141,
'N'
,
'D'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(2):=2703;
LDCHOIMIA_.tb1_1(2):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (2)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(2),
LDCHOIMIA_.tb1_1(2),
5312,
5141,
'N'
,
'U'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(3):=2704;
LDCHOIMIA_.tb1_1(3):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (3)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(3),
LDCHOIMIA_.tb1_1(3),
3669,
5141,
'N'
,
'I'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(4):=2705;
LDCHOIMIA_.tb1_1(4):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (4)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(4),
LDCHOIMIA_.tb1_1(4),
3669,
5141,
'N'
,
'D'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(5):=2706;
LDCHOIMIA_.tb1_1(5):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (5)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(5),
LDCHOIMIA_.tb1_1(5),
3669,
5141,
'N'
,
'U'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(6):=2621;
LDCHOIMIA_.tb1_1(6):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (6)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(6),
LDCHOIMIA_.tb1_1(6),
5530,
5141,
'N'
,
'I'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(7):=2622;
LDCHOIMIA_.tb1_1(7):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (7)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(7),
LDCHOIMIA_.tb1_1(7),
5530,
5141,
'N'
,
'D'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb1_0(8):=2623;
LDCHOIMIA_.tb1_1(8):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (8)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDCHOIMIA_.tb1_0(8),
LDCHOIMIA_.tb1_1(8),
5530,
5141,
'N'
,
'U'
);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb2_0(0):=1;
LDCHOIMIA_.tb2_1(0):=LDCHOIMIA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCHOIMIA_.tb2_0(0),
LDCHOIMIA_.tb2_1(0));

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb3_0(0):=LDCHOIMIA_.tb0_1(0);
LDCHOIMIA_.old_tb3_1(0):=5141;
LDCHOIMIA_.tb3_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCHOIMIA_.TBENTITYNAME(LDCHOIMIA_.old_tb3_1(0)), 'ENTITY');
LDCHOIMIA_.tb3_1(0):=LDCHOIMIA_.tb3_1(0);
LDCHOIMIA_.old_tb3_2(0):=null;
LDCHOIMIA_.tb3_2(0):=CASE WHEN (LDCHOIMIA_.old_tb3_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCHOIMIA_.TBENTITYNAME(LDCHOIMIA_.old_tb3_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCHOIMIA_.tb3_0(0),
LDCHOIMIA_.tb3_1(0),
LDCHOIMIA_.tb3_2(0),
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
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb4_0(0):=LDCHOIMIA_.tb3_0(0);
LDCHOIMIA_.tb4_1(0):=LDCHOIMIA_.tb3_1(0);
LDCHOIMIA_.old_tb4_2(0):=90171538;
LDCHOIMIA_.tb4_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCHOIMIA_.TBENTITYATTRIBUTENAME(LDCHOIMIA_.old_tb4_2(0)), 'ATTRIBUTE');
LDCHOIMIA_.tb4_2(0):=LDCHOIMIA_.tb4_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCHOIMIA_.tb4_0(0),
LDCHOIMIA_.tb4_1(0),
LDCHOIMIA_.tb4_2(0),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID IN (3,8,21) ORDER BY ITEMS_ID ASC '
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
'WHERE ITEM_CLASSIF_ID IN (3,8,21)|'
,
'ORDER BY ITEMS_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb4_0(1):=LDCHOIMIA_.tb3_0(0);
LDCHOIMIA_.tb4_1(1):=LDCHOIMIA_.tb3_1(0);
LDCHOIMIA_.old_tb4_2(1):=90171539;
LDCHOIMIA_.tb4_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCHOIMIA_.TBENTITYATTRIBUTENAME(LDCHOIMIA_.old_tb4_2(1)), 'ATTRIBUTE');
LDCHOIMIA_.tb4_2(1):=LDCHOIMIA_.tb4_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCHOIMIA_.tb4_0(1),
LDCHOIMIA_.tb4_1(1),
LDCHOIMIA_.tb4_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID = 51 ORDER BY ITEMS_ID ASC '
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
'WHERE ITEM_CLASSIF_ID = 51|'
,
'ORDER BY ITEMS_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;

LDCHOIMIA_.tb4_0(2):=LDCHOIMIA_.tb3_0(0);
LDCHOIMIA_.tb4_1(2):=LDCHOIMIA_.tb3_1(0);
LDCHOIMIA_.old_tb4_2(2):=90200638;
LDCHOIMIA_.tb4_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCHOIMIA_.TBENTITYATTRIBUTENAME(LDCHOIMIA_.old_tb4_2(2)), 'ATTRIBUTE');
LDCHOIMIA_.tb4_2(2):=LDCHOIMIA_.tb4_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCHOIMIA_.tb4_0(2),
LDCHOIMIA_.tb4_1(2),
LDCHOIMIA_.tb4_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO "CODIGO EMPRESA" , NOMBRE "NOMBRE EMPRESA"  FROM VW_EMPRESA '
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
null,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCHOIMIA_.blProcessStatus := false;
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
 nuIndexInternal := LDCHOIMIA_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCHOIMIA_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCHOIMIA_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCHOIMIA_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCHOIMIA_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCHOIMIA_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCHOIMIA_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCHOIMIA_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCHOIMIA_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCHOIMIA_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCHOIMIA_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCHOIMIA_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCHOIMIA_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCHOIMIA_.tbUserException(nuIndex).user_id, LDCHOIMIA_.tbUserException(nuIndex).status , LDCHOIMIA_.tbUserException(nuIndex).usr_exc_type_id, LDCHOIMIA_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCHOIMIA_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCHOIMIA_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCHOIMIA_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCHOIMIA_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCHOIMIA_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCHOIMIA_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCHOIMIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCHOIMIA_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCHOIMIA_******************************'); end;
/

