BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('MDCUUE_',
'CREATE OR REPLACE PACKAGE MDCUUE_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''MDCUUE''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCUUE'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCUUE'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''MDCUUE'' ' || chr(10) ||
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
'END MDCUUE_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:MDCUUE_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
Open MDCUUE_.cuRoleExecutables;
loop
 fetch MDCUUE_.cuRoleExecutables INTO MDCUUE_.rcRoleExecutables;
 exit when  MDCUUE_.cuRoleExecutables%notfound;
 MDCUUE_.tbRoleExecutables(nuIndex) := MDCUUE_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close MDCUUE_.cuRoleExecutables;
nuIndex := 0;
Open MDCUUE_.cuUserExceptions ;
loop
 fetch MDCUUE_.cuUserExceptions INTO  MDCUUE_.rcUserExceptions;
 exit when MDCUUE_.cuUserExceptions%notfound;
 MDCUUE_.tbUserException(nuIndex):=MDCUUE_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close MDCUUE_.cuUserExceptions;
nuIndex := 0;
Open MDCUUE_.cuExecEntities ;
loop
 fetch MDCUUE_.cuExecEntities INTO  MDCUUE_.rcExecEntities;
 exit when MDCUUE_.cuExecEntities%notfound;
 MDCUUE_.tbExecEntities(nuIndex):=MDCUUE_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close MDCUUE_.cuExecEntities;

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE'
);

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   MDCUUE_.tbEntityName(6227) := 'CONF_UO_USU_ESPECIALES';
   MDCUUE_.tbEntityAttributeName(90200337) := 'CONF_UO_USU_ESPECIALES@CODIGO';
   MDCUUE_.tbEntityAttributeName(90200338) := 'CONF_UO_USU_ESPECIALES@CICLO';
   MDCUUE_.tbEntityAttributeName(90200339) := 'CONF_UO_USU_ESPECIALES@SECTOR_OPERATIVO';
   MDCUUE_.tbEntityAttributeName(90200340) := 'CONF_UO_USU_ESPECIALES@UNIDAD_OPERATIVA';
 
END; 
/

BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE');

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE') AND ROLE_ID=1;

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE');

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE');

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE'));

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='MDCUUE');

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='MDCUUE';

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.old_tb0_0(0):='MDCUUE'
;
MDCUUE_.tb0_0(0):=UPPER(MDCUUE_.old_tb0_0(0));
MDCUUE_.old_tb0_1(0):=500000000015828;
MDCUUE_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(MDCUUE_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
MDCUUE_.tb0_1(0):=MDCUUE_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (MDCUUE_.tb0_0(0),
MDCUUE_.tb0_1(0),
'Configuración de unidad operativa para usuarios especiales'
,
null,
'22'
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
5,
'C',
to_date('22-10-2024 15:29:53','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.tb1_0(0):=1;
MDCUUE_.tb1_1(0):=MDCUUE_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (MDCUUE_.tb1_0(0),
MDCUUE_.tb1_1(0));

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.tb2_0(0):=MDCUUE_.tb0_1(0);
MDCUUE_.old_tb2_1(0):=6227;
MDCUUE_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCUUE_.TBENTITYNAME(MDCUUE_.old_tb2_1(0)), 'ENTITY');
MDCUUE_.tb2_1(0):=MDCUUE_.tb2_1(0);
MDCUUE_.old_tb2_2(0):=null;
MDCUUE_.tb2_2(0):=CASE WHEN (MDCUUE_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCUUE_.TBENTITYNAME(MDCUUE_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (MDCUUE_.tb2_0(0),
MDCUUE_.tb2_1(0),
MDCUUE_.tb2_2(0),
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
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.tb3_0(0):=MDCUUE_.tb2_0(0);
MDCUUE_.tb3_1(0):=MDCUUE_.tb2_1(0);
MDCUUE_.old_tb3_2(0):=90200337;
MDCUUE_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCUUE_.TBENTITYATTRIBUTENAME(MDCUUE_.old_tb3_2(0)), 'ATTRIBUTE');
MDCUUE_.tb3_2(0):=MDCUUE_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCUUE_.tb3_0(0),
MDCUUE_.tb3_1(0),
MDCUUE_.tb3_2(0),
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
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.tb3_0(1):=MDCUUE_.tb2_0(0);
MDCUUE_.tb3_1(1):=MDCUUE_.tb2_1(0);
MDCUUE_.old_tb3_2(1):=90200338;
MDCUUE_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCUUE_.TBENTITYATTRIBUTENAME(MDCUUE_.old_tb3_2(1)), 'ATTRIBUTE');
MDCUUE_.tb3_2(1):=MDCUUE_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCUUE_.tb3_0(1),
MDCUUE_.tb3_1(1),
MDCUUE_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  CICLCODI "CÓDIGO" , CICLDESC "DESCRIPCIÓN"  FROM CICLO WHERE CICLCODI <> -1 ORDER BY CICLCODI ASC '
,
'H'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'CICLCODI Código|CICLDESC Descripción|'
,
'FROM CICLO|'
,
'WHERE CICLCODI <> -1|'
,
'ORDER BY CICLCODI ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.tb3_0(2):=MDCUUE_.tb2_0(0);
MDCUUE_.tb3_1(2):=MDCUUE_.tb2_1(0);
MDCUUE_.old_tb3_2(2):=90200339;
MDCUUE_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCUUE_.TBENTITYATTRIBUTENAME(MDCUUE_.old_tb3_2(2)), 'ATTRIBUTE');
MDCUUE_.tb3_2(2):=MDCUUE_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCUUE_.tb3_0(2),
MDCUUE_.tb3_1(2),
MDCUUE_.tb3_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_SECTOR_ID "CÓDIGO DEL SECTOR OPERATIVO" , DESCRIPTION "DESCRIPCIÓN DEL SECTOR OPERATIVO"  FROM OR_OPERATING_SECTOR WHERE OPERATING_SECTOR_ID NOT IN (1,-1) ORDER BY OPERATING_SECTOR_ID ASC '
,
'H'
,
'CÓDIGO DEL SECTOR OPERATIVO'
,
'DESCRIPCIÓN DEL SECTOR OPERATIVO'
,
'OPERATING_SECTOR_ID Código Del Sector Operativo|DESCRIPTION Descripción Del Sector Operativo|'
,
'FROM OR_OPERATING_SECTOR|'
,
'WHERE OPERATING_SECTOR_ID NOT IN (1,-1)|'
,
'ORDER BY OPERATING_SECTOR_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;

MDCUUE_.tb3_0(3):=MDCUUE_.tb2_0(0);
MDCUUE_.tb3_1(3):=MDCUUE_.tb2_1(0);
MDCUUE_.old_tb3_2(3):=90200340;
MDCUUE_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(MDCUUE_.TBENTITYATTRIBUTENAME(MDCUUE_.old_tb3_2(3)), 'ATTRIBUTE');
MDCUUE_.tb3_2(3):=MDCUUE_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (MDCUUE_.tb3_0(3),
MDCUUE_.tb3_1(3),
MDCUUE_.tb3_2(3),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_UNIT_ID "IDENTIFICADOR DE LA UNIDAD DE TRABAJO" , NAME "NOMBRE"  FROM OR_OPERATING_UNIT WHERE OPERATING_UNIT_ID NOT IN (-1,1) ORDER BY OPERATING_UNIT_ID ASC '
,
'H'
,
'IDENTIFICADOR DE LA UNIDAD DE TRABAJO'
,
'NOMBRE'
,
'OPERATING_UNIT_ID Identificador de la Unidad de Trabajo|NAME Nombre|'
,
'FROM OR_OPERATING_UNIT|'
,
'WHERE OPERATING_UNIT_ID NOT IN (-1,1)|'
,
'ORDER BY OPERATING_UNIT_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
MDCUUE_.blProcessStatus := false;
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
 nuIndexInternal := MDCUUE_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (MDCUUE_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (MDCUUE_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := MDCUUE_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := MDCUUE_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not MDCUUE_.blProcessStatus) then
 return;
end if;
nuIndex :=  MDCUUE_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (MDCUUE_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(MDCUUE_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (MDCUUE_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := MDCUUE_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  MDCUUE_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(MDCUUE_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,MDCUUE_.tbUserException(nuIndex).user_id, MDCUUE_.tbUserException(nuIndex).status , MDCUUE_.tbUserException(nuIndex).usr_exc_type_id, MDCUUE_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := MDCUUE_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  MDCUUE_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(MDCUUE_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = MDCUUE_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,MDCUUE_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := MDCUUE_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
MDCUUE_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('MDCUUE_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:MDCUUE_******************************'); end;
/

