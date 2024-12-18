BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('MDCPGS_',
'CREATE OR REPLACE PACKAGE MDCPGS_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''MDCPGS''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCPGS'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCPGS'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCPGS'' ' || chr(10) ||
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
'END MDCPGS_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:MDCPGS_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
Open MDCPGS_.cuRoleExecutables;
loop
 fetch MDCPGS_.cuRoleExecutables INTO MDCPGS_.rcRoleExecutables;
 exit when  MDCPGS_.cuRoleExecutables%notfound;
 MDCPGS_.tbRoleExecutables(nuIndex) := MDCPGS_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close MDCPGS_.cuRoleExecutables;
nuIndex := 0;
Open MDCPGS_.cuUserExceptions ;
loop
 fetch MDCPGS_.cuUserExceptions INTO  MDCPGS_.rcUserExceptions;
 exit when MDCPGS_.cuUserExceptions%notfound;
 MDCPGS_.tbUserException(nuIndex):=MDCPGS_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close MDCPGS_.cuUserExceptions;
nuIndex := 0;
Open MDCPGS_.cuExecEntities ;
loop
 fetch MDCPGS_.cuExecEntities INTO  MDCPGS_.rcExecEntities;
 exit when MDCPGS_.cuExecEntities%notfound;
 MDCPGS_.tbExecEntities(nuIndex):=MDCPGS_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close MDCPGS_.cuExecEntities;

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS'
);

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   MDCPGS_.tbEntityName(6176) := 'PROCESO_NEGOCIO';
   MDCPGS_.tbEntityAttributeName(90199943) := 'PROCESO_NEGOCIO@CODIGO';
   MDCPGS_.tbEntityAttributeName(90199944) := 'PROCESO_NEGOCIO@DESCRIPCION';
 
   MDCPGS_.tbEntityName(6177) := 'PARAMETROS';
   MDCPGS_.tbEntityAttributeName(90199945) := 'PARAMETROS@CODIGO';
   MDCPGS_.tbEntityAttributeName(90199946) := 'PARAMETROS@DESCRIPCION';
   MDCPGS_.tbEntityAttributeName(90199950) := 'PARAMETROS@PROCESO';
   MDCPGS_.tbEntityAttributeName(90199947) := 'PARAMETROS@VALOR_NUMERICO';
   MDCPGS_.tbEntityAttributeName(90199948) := 'PARAMETROS@VALOR_CADENA';
   MDCPGS_.tbEntityAttributeName(90199949) := 'PARAMETROS@VALOR_FECHA';
   MDCPGS_.tbEntityAttributeName(90199955) := 'PARAMETROS@ESTADO';
   MDCPGS_.tbEntityAttributeName(90199956) := 'PARAMETROS@OBLIGATORIO';
   MDCPGS_.tbEntityAttributeName(90199951) := 'PARAMETROS@FECHA_CREACION';
   MDCPGS_.tbEntityAttributeName(90199952) := 'PARAMETROS@FECHA_ACTUALIZACION';
   MDCPGS_.tbEntityAttributeName(90199953) := 'PARAMETROS@USUARIO';
   MDCPGS_.tbEntityAttributeName(90199954) := 'PARAMETROS@TERMINAL';
 
END; 
/

BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS');

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS') AND ROLE_ID=1;

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS');

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS');

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS'));

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCPGS');

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='MDCPGS';

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.old_tb0_0(0):='MDCPGS'
;
MDCPGS_.tb0_0(0):=UPPER(MDCPGS_.old_tb0_0(0));
MDCPGS_.old_tb0_1(0):=500000000015794;
MDCPGS_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(MDCPGS_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
MDCPGS_.tb0_1(0):=MDCPGS_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (MDCPGS_.tb0_0(0),
MDCPGS_.tb0_1(0),
'Configuración de Parámetros Personalizados del Sistema'
,
null,
'19.1'
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
16,
'C'
,
to_date('28-08-2024 08:39:43','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb1_0(0):=1;
MDCPGS_.tb1_1(0):=MDCPGS_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (MDCPGS_.tb1_0(0),
MDCPGS_.tb1_1(0));

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb2_0(0):=MDCPGS_.tb0_1(0);
MDCPGS_.old_tb2_1(0):=6176;
MDCPGS_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYNAME(MDCPGS_.old_tb2_1(0)), 'ENTITY');
MDCPGS_.tb2_1(0):=MDCPGS_.tb2_1(0);
MDCPGS_.old_tb2_2(0):=null;
MDCPGS_.tb2_2(0):=CASE WHEN (MDCPGS_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYNAME(MDCPGS_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (MDCPGS_.tb2_0(0),
MDCPGS_.tb2_1(0),
MDCPGS_.tb2_2(0),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(0):=MDCPGS_.tb2_0(0);
MDCPGS_.tb3_1(0):=MDCPGS_.tb2_1(0);
MDCPGS_.old_tb3_2(0):=90199943;
MDCPGS_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(0)), 'ATTRIBUTE');
MDCPGS_.tb3_2(0):=MDCPGS_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(0),
MDCPGS_.tb3_1(0),
MDCPGS_.tb3_2(0),
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
'A'
,
null,
1);

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(1):=MDCPGS_.tb2_0(0);
MDCPGS_.tb3_1(1):=MDCPGS_.tb2_1(0);
MDCPGS_.old_tb3_2(1):=90199944;
MDCPGS_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(1)), 'ATTRIBUTE');
MDCPGS_.tb3_2(1):=MDCPGS_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(1),
MDCPGS_.tb3_1(1),
MDCPGS_.tb3_2(1),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb2_0(1):=MDCPGS_.tb0_1(0);
MDCPGS_.old_tb2_1(1):=6177;
MDCPGS_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYNAME(MDCPGS_.old_tb2_1(1)), 'ENTITY');
MDCPGS_.tb2_1(1):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb2_2(1):=null;
MDCPGS_.tb2_2(1):=CASE WHEN (MDCPGS_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYNAME(MDCPGS_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (MDCPGS_.tb2_0(1),
MDCPGS_.tb2_1(1),
MDCPGS_.tb2_2(1),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(2):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(2):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(2):=90199945;
MDCPGS_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(2)), 'ATTRIBUTE');
MDCPGS_.tb3_2(2):=MDCPGS_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(2),
MDCPGS_.tb3_1(2),
MDCPGS_.tb3_2(2),
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
'A'
,
null,
1);

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(3):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(3):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(3):=90199946;
MDCPGS_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(3)), 'ATTRIBUTE');
MDCPGS_.tb3_2(3):=MDCPGS_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(3),
MDCPGS_.tb3_1(3),
MDCPGS_.tb3_2(3),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(4):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(4):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(4):=90199947;
MDCPGS_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(4)), 'ATTRIBUTE');
MDCPGS_.tb3_2(4):=MDCPGS_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(4),
MDCPGS_.tb3_1(4),
MDCPGS_.tb3_2(4),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(5):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(5):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(5):=90199948;
MDCPGS_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(5)), 'ATTRIBUTE');
MDCPGS_.tb3_2(5):=MDCPGS_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(5),
MDCPGS_.tb3_1(5),
MDCPGS_.tb3_2(5),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(6):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(6):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(6):=90199949;
MDCPGS_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(6)), 'ATTRIBUTE');
MDCPGS_.tb3_2(6):=MDCPGS_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(6),
MDCPGS_.tb3_1(6),
MDCPGS_.tb3_2(6),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(7):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(7):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(7):=90199950;
MDCPGS_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(7)), 'ATTRIBUTE');
MDCPGS_.tb3_2(7):=MDCPGS_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(7),
MDCPGS_.tb3_1(7),
MDCPGS_.tb3_2(7),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO "CODIGO" , DESCRIPCION "DESCRIPCION"  FROM PROCESO_NEGOCIO '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'CODIGO Codigo|DESCRIPCION Descripcion|'
,
'FROM PROCESO_NEGOCIO|'
,
null,
null,
null,
'M'
,
null,
'A'
,
null,
2);

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(8):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(8):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(8):=90199951;
MDCPGS_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(8)), 'ATTRIBUTE');
MDCPGS_.tb3_2(8):=MDCPGS_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(8),
MDCPGS_.tb3_1(8),
MDCPGS_.tb3_2(8),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(9):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(9):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(9):=90199952;
MDCPGS_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(9)), 'ATTRIBUTE');
MDCPGS_.tb3_2(9):=MDCPGS_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(9),
MDCPGS_.tb3_1(9),
MDCPGS_.tb3_2(9),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(10):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(10):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(10):=90199953;
MDCPGS_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(10)), 'ATTRIBUTE');
MDCPGS_.tb3_2(10):=MDCPGS_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(10),
MDCPGS_.tb3_1(10),
MDCPGS_.tb3_2(10),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(11):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(11):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(11):=90199954;
MDCPGS_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(11)), 'ATTRIBUTE');
MDCPGS_.tb3_2(11):=MDCPGS_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(11),
MDCPGS_.tb3_1(11),
MDCPGS_.tb3_2(11),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(12):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(12):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(12):=90199955;
MDCPGS_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(12)), 'ATTRIBUTE');
MDCPGS_.tb3_2(12):=MDCPGS_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(12),
MDCPGS_.tb3_1(12),
MDCPGS_.tb3_2(12),
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
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;

MDCPGS_.tb3_0(13):=MDCPGS_.tb2_0(1);
MDCPGS_.tb3_1(13):=MDCPGS_.tb2_1(1);
MDCPGS_.old_tb3_2(13):=90199956;
MDCPGS_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCPGS_.TBENTITYATTRIBUTENAME(MDCPGS_.old_tb3_2(13)), 'ATTRIBUTE');
MDCPGS_.tb3_2(13):=MDCPGS_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCPGS_.tb3_0(13),
MDCPGS_.tb3_1(13),
MDCPGS_.tb3_2(13),
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
MDCPGS_.blProcessStatus := false;
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
 nuIndexInternal := MDCPGS_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (MDCPGS_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (MDCPGS_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := MDCPGS_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := MDCPGS_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not MDCPGS_.blProcessStatus) then
 return;
end if;
nuIndex :=  MDCPGS_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (MDCPGS_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(MDCPGS_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (MDCPGS_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := MDCPGS_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  MDCPGS_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(MDCPGS_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,MDCPGS_.tbUserException(nuIndex).user_id, MDCPGS_.tbUserException(nuIndex).status , MDCPGS_.tbUserException(nuIndex).usr_exc_type_id, MDCPGS_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := MDCPGS_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  MDCPGS_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(MDCPGS_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = MDCPGS_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,MDCPGS_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := MDCPGS_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
MDCPGS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('MDCPGS_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:MDCPGS_******************************'); end;
/

