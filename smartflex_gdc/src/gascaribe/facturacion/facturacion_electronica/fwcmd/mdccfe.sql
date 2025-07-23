BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('MDCCFE_',
'CREATE OR REPLACE PACKAGE MDCCFE_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''MDCCFE''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCCFE'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCCFE'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCCFE'' ' || chr(10) ||
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
'END MDCCFE_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:MDCCFE_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
Open MDCCFE_.cuRoleExecutables;
loop
 fetch MDCCFE_.cuRoleExecutables INTO MDCCFE_.rcRoleExecutables;
 exit when  MDCCFE_.cuRoleExecutables%notfound;
 MDCCFE_.tbRoleExecutables(nuIndex) := MDCCFE_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close MDCCFE_.cuRoleExecutables;
nuIndex := 0;
Open MDCCFE_.cuUserExceptions ;
loop
 fetch MDCCFE_.cuUserExceptions INTO  MDCCFE_.rcUserExceptions;
 exit when MDCCFE_.cuUserExceptions%notfound;
 MDCCFE_.tbUserException(nuIndex):=MDCCFE_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close MDCCFE_.cuUserExceptions;
nuIndex := 0;
Open MDCCFE_.cuExecEntities ;
loop
 fetch MDCCFE_.cuExecEntities INTO  MDCCFE_.rcExecEntities;
 exit when MDCCFE_.cuExecEntities%notfound;
 MDCCFE_.tbExecEntities(nuIndex):=MDCCFE_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close MDCCFE_.cuExecEntities;

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE'
);

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   MDCCFE_.tbEntityName(6176) := 'RECOFAEL';
   MDCCFE_.tbEntityAttributeName(90199784) := 'RECOFAEL@CODIGO';
   MDCCFE_.tbEntityAttributeName(90200375) := 'RECOFAEL@EMPRESA';
   MDCCFE_.tbEntityAttributeName(90199794) := 'RECOFAEL@TIPO_DOCUMENTO';
   MDCCFE_.tbEntityAttributeName(90199785) := 'RECOFAEL@PREFIJO';
   MDCCFE_.tbEntityAttributeName(90199793) := 'RECOFAEL@RESOLUCION';
   MDCCFE_.tbEntityAttributeName(90199786) := 'RECOFAEL@CONS_INICIAL';
   MDCCFE_.tbEntityAttributeName(90199787) := 'RECOFAEL@CONS_FINAL';
   MDCCFE_.tbEntityAttributeName(90199788) := 'RECOFAEL@ULTIMO_CONS';
   MDCCFE_.tbEntityAttributeName(90199795) := 'RECOFAEL@FECHA_RESOLUCION';
   MDCCFE_.tbEntityAttributeName(90199796) := 'RECOFAEL@FECHA_INI_VIGENCIA';
   MDCCFE_.tbEntityAttributeName(90199797) := 'RECOFAEL@FECHA_FIN_VIGENCIA';
   MDCCFE_.tbEntityAttributeName(90199789) := 'RECOFAEL@ESTADO';
   MDCCFE_.tbEntityAttributeName(90199790) := 'RECOFAEL@FECHA_REGISTRO';
   MDCCFE_.tbEntityAttributeName(90199791) := 'RECOFAEL@USUARIO';
   MDCCFE_.tbEntityAttributeName(90199792) := 'RECOFAEL@TERMINAL';
 
END; 
/

BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE');

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE') AND ROLE_ID=1;

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE');

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE');

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE'));

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCCFE');

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='MDCCFE';

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.old_tb0_0(0):='MDCCFE'
;
MDCCFE_.tb0_0(0):=UPPER(MDCCFE_.old_tb0_0(0));
MDCCFE_.old_tb0_1(0):=500000000015789;
MDCCFE_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(MDCCFE_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
MDCCFE_.tb0_1(0):=MDCCFE_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (MDCCFE_.tb0_0(0),
MDCCFE_.tb0_1(0),
'Configuración de Consecutivos de Facturación Electronica'
,
null,
'15.3'
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
28,
'C'
,
to_date('21-04-2025 11:03:04','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb1_0(0):=1;
MDCCFE_.tb1_1(0):=MDCCFE_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (MDCCFE_.tb1_0(0),
MDCCFE_.tb1_1(0));

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb2_0(0):=MDCCFE_.tb0_1(0);
MDCCFE_.old_tb2_1(0):=6176;
MDCCFE_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYNAME(MDCCFE_.old_tb2_1(0)), 'ENTITY');
MDCCFE_.tb2_1(0):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb2_2(0):=null;
MDCCFE_.tb2_2(0):=CASE WHEN (MDCCFE_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYNAME(MDCCFE_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (MDCCFE_.tb2_0(0),
MDCCFE_.tb2_1(0),
MDCCFE_.tb2_2(0),
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
'N'
,
null);

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(0):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(0):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(0):=90199784;
MDCCFE_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(0)), 'ATTRIBUTE');
MDCCFE_.tb3_2(0):=MDCCFE_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(0),
MDCCFE_.tb3_1(0),
MDCCFE_.tb3_2(0),
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(1):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(1):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(1):=90199785;
MDCCFE_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(1)), 'ATTRIBUTE');
MDCCFE_.tb3_2(1):=MDCCFE_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(1),
MDCCFE_.tb3_1(1),
MDCCFE_.tb3_2(1),
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
'M'
,
null,
null,
null,
null);

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(2):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(2):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(2):=90199786;
MDCCFE_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(2)), 'ATTRIBUTE');
MDCCFE_.tb3_2(2):=MDCCFE_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(2),
MDCCFE_.tb3_1(2),
MDCCFE_.tb3_2(2),
5,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(3):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(3):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(3):=90199787;
MDCCFE_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(3)), 'ATTRIBUTE');
MDCCFE_.tb3_2(3):=MDCCFE_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(3),
MDCCFE_.tb3_1(3),
MDCCFE_.tb3_2(3),
6,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(4):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(4):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(4):=90199788;
MDCCFE_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(4)), 'ATTRIBUTE');
MDCCFE_.tb3_2(4):=MDCCFE_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(4),
MDCCFE_.tb3_1(4),
MDCCFE_.tb3_2(4),
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(5):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(5):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(5):=90199789;
MDCCFE_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(5)), 'ATTRIBUTE');
MDCCFE_.tb3_2(5):=MDCCFE_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(5),
MDCCFE_.tb3_1(5),
MDCCFE_.tb3_2(5),
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(6):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(6):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(6):=90199790;
MDCCFE_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(6)), 'ATTRIBUTE');
MDCCFE_.tb3_2(6):=MDCCFE_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(6),
MDCCFE_.tb3_1(6),
MDCCFE_.tb3_2(6),
12,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(7):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(7):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(7):=90199791;
MDCCFE_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(7)), 'ATTRIBUTE');
MDCCFE_.tb3_2(7):=MDCCFE_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(7),
MDCCFE_.tb3_1(7),
MDCCFE_.tb3_2(7),
13,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(8):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(8):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(8):=90199792;
MDCCFE_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(8)), 'ATTRIBUTE');
MDCCFE_.tb3_2(8):=MDCCFE_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(8),
MDCCFE_.tb3_1(8),
MDCCFE_.tb3_2(8),
14,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(9):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(9):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(9):=90199793;
MDCCFE_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(9)), 'ATTRIBUTE');
MDCCFE_.tb3_2(9):=MDCCFE_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(9),
MDCCFE_.tb3_1(9),
MDCCFE_.tb3_2(9),
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
'M'
,
null,
null,
null,
null);

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(10):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(10):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(10):=90199794;
MDCCFE_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(10)), 'ATTRIBUTE');
MDCCFE_.tb3_2(10):=MDCCFE_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(10),
MDCCFE_.tb3_1(10),
MDCCFE_.tb3_2(10),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO "CODIGO" , DESCRIPCION "DESCRIPCION"  FROM TIDOFAEL ORDER BY CODIGO ASC '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'CODIGO Codigo|DESCRIPCION Descripcion|'
,
'FROM TIDOFAEL|'
,
null,
'ORDER BY CODIGO ASC|'
,
null,
'M'
,
null,
null,
null,
null);

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(11):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(11):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(11):=90199795;
MDCCFE_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(11)), 'ATTRIBUTE');
MDCCFE_.tb3_2(11):=MDCCFE_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(11),
MDCCFE_.tb3_1(11),
MDCCFE_.tb3_2(11),
8,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(12):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(12):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(12):=90199796;
MDCCFE_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(12)), 'ATTRIBUTE');
MDCCFE_.tb3_2(12):=MDCCFE_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(12),
MDCCFE_.tb3_1(12),
MDCCFE_.tb3_2(12),
9,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(13):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(13):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(13):=90199797;
MDCCFE_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(13)), 'ATTRIBUTE');
MDCCFE_.tb3_2(13):=MDCCFE_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(13),
MDCCFE_.tb3_1(13),
MDCCFE_.tb3_2(13),
10,
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
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;

MDCCFE_.tb3_0(14):=MDCCFE_.tb2_0(0);
MDCCFE_.tb3_1(14):=MDCCFE_.tb2_1(0);
MDCCFE_.old_tb3_2(14):=90200375;
MDCCFE_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCCFE_.TBENTITYATTRIBUTENAME(MDCCFE_.old_tb3_2(14)), 'ATTRIBUTE');
MDCCFE_.tb3_2(14):=MDCCFE_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCCFE_.tb3_0(14),
MDCCFE_.tb3_1(14),
MDCCFE_.tb3_2(14),
1,
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
MDCCFE_.blProcessStatus := false;
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
 nuIndexInternal := MDCCFE_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (MDCCFE_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (MDCCFE_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := MDCCFE_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := MDCCFE_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not MDCCFE_.blProcessStatus) then
 return;
end if;
nuIndex :=  MDCCFE_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (MDCCFE_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(MDCCFE_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (MDCCFE_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := MDCCFE_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  MDCCFE_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(MDCCFE_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,MDCCFE_.tbUserException(nuIndex).user_id, MDCCFE_.tbUserException(nuIndex).status , MDCCFE_.tbUserException(nuIndex).usr_exc_type_id, MDCCFE_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := MDCCFE_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  MDCCFE_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(MDCCFE_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = MDCCFE_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,MDCCFE_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := MDCCFE_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
MDCCFE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('MDCCFE_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:MDCCFE_******************************'); end;
/

