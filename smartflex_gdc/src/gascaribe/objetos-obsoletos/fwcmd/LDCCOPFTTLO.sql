BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCCOPFTTLO_',
'CREATE OR REPLACE PACKAGE LDCCOPFTTLO_ IS ' || chr(10) ||
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
'tb1_1 ty1_1;type ty2_0 is table of SA_MENU_OPTION.MENU_OPTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_MENU_OPTION.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCCOPFTTLO''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCOPFTTLO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCOPFTTLO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCCOPFTTLO'' ' || chr(10) ||
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
'END LDCCOPFTTLO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCCOPFTTLO_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
Open LDCCOPFTTLO_.cuRoleExecutables;
loop
 fetch LDCCOPFTTLO_.cuRoleExecutables INTO LDCCOPFTTLO_.rcRoleExecutables;
 exit when  LDCCOPFTTLO_.cuRoleExecutables%notfound;
 LDCCOPFTTLO_.tbRoleExecutables(nuIndex) := LDCCOPFTTLO_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCCOPFTTLO_.cuRoleExecutables;
nuIndex := 0;
Open LDCCOPFTTLO_.cuUserExceptions ;
loop
 fetch LDCCOPFTTLO_.cuUserExceptions INTO  LDCCOPFTTLO_.rcUserExceptions;
 exit when LDCCOPFTTLO_.cuUserExceptions%notfound;
 LDCCOPFTTLO_.tbUserException(nuIndex):=LDCCOPFTTLO_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCCOPFTTLO_.cuUserExceptions;
nuIndex := 0;
Open LDCCOPFTTLO_.cuExecEntities ;
loop
 fetch LDCCOPFTTLO_.cuExecEntities INTO  LDCCOPFTTLO_.rcExecEntities;
 exit when LDCCOPFTTLO_.cuExecEntities%notfound;
 LDCCOPFTTLO_.tbExecEntities(nuIndex):=LDCCOPFTTLO_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCCOPFTTLO_.cuExecEntities;

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO'
);

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCCOPFTTLO_.tbEntityName(4878) := 'LDC_LIQTITRLOCA';
   LDCCOPFTTLO_.tbEntityAttributeName(90165907) := 'LDC_LIQTITRLOCA@ID_REGISTRO';
   LDCCOPFTTLO_.tbEntityAttributeName(90169405) := 'LDC_LIQTITRLOCA@TIPO_CONTRATO_ADM';
   LDCCOPFTTLO_.tbEntityAttributeName(90169406) := 'LDC_LIQTITRLOCA@ACTIVIDAD_PAGO';
   LDCCOPFTTLO_.tbEntityAttributeName(90169408) := 'LDC_LIQTITRLOCA@ITEM_PAGO';
   LDCCOPFTTLO_.tbEntityAttributeName(90165909) := 'LDC_LIQTITRLOCA@DEPARTAMENTO';
   LDCCOPFTTLO_.tbEntityAttributeName(90165910) := 'LDC_LIQTITRLOCA@LOCALIDAD';
   LDCCOPFTTLO_.tbEntityAttributeName(90165990) := 'LDC_LIQTITRLOCA@PORCENTAJE_FIJO';
 
END; 
/

BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO');

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO') AND ROLE_ID=1;

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO');

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO');

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO'));

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO');

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCCOPFTTLO';

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.old_tb0_0(0):='LDCCOPFTTLO'
;
LDCCOPFTTLO_.tb0_0(0):=UPPER(LDCCOPFTTLO_.old_tb0_0(0));
LDCCOPFTTLO_.old_tb0_1(0):=500000000013647;
LDCCOPFTTLO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCCOPFTTLO_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCCOPFTTLO_.tb0_1(0):=LDCCOPFTTLO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCCOPFTTLO_.tb0_0(0),
LDCCOPFTTLO_.tb0_1(0),
'Configuracion % fijo x tipo de trabajo y localidad'
,
null,
'51.1'
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
40,
null,
to_date('10-10-2018 14:44:43','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb1_0(0):=1;
LDCCOPFTTLO_.tb1_1(0):=LDCCOPFTTLO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCCOPFTTLO_.tb1_0(0),
LDCCOPFTTLO_.tb1_1(0));

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.old_tb2_0(0):=40009823;
LDCCOPFTTLO_.tb2_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
LDCCOPFTTLO_.tb2_0(0):=LDCCOPFTTLO_.tb2_0(0);
LDCCOPFTTLO_.tb2_1(0):=LDCCOPFTTLO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (LDCCOPFTTLO_.tb2_0(0),
LDCCOPFTTLO_.tb2_1(0),
'LDCCOPFTTLO'
,
'Configuracion % fijo x tipo de trabajo y localidad'
,
1,
1,
3,
-19,
'FormExecutable'
,
null);

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb3_0(0):=LDCCOPFTTLO_.tb0_1(0);
LDCCOPFTTLO_.old_tb3_1(0):=4878;
LDCCOPFTTLO_.tb3_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYNAME(LDCCOPFTTLO_.old_tb3_1(0)), 'ENTITY');
LDCCOPFTTLO_.tb3_1(0):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb3_2(0):=null;
LDCCOPFTTLO_.tb3_2(0):=CASE WHEN (LDCCOPFTTLO_.old_tb3_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYNAME(LDCCOPFTTLO_.old_tb3_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCCOPFTTLO_.tb3_0(0),
LDCCOPFTTLO_.tb3_1(0),
LDCCOPFTTLO_.tb3_2(0),
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
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(0):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(0):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(0):=90165907;
LDCCOPFTTLO_.tb4_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(0)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(0):=LDCCOPFTTLO_.tb4_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(0),
LDCCOPFTTLO_.tb4_1(0),
LDCCOPFTTLO_.tb4_2(0),
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
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(1):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(1):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(1):=90165909;
LDCCOPFTTLO_.tb4_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(1)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(1):=LDCCOPFTTLO_.tb4_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(1),
LDCCOPFTTLO_.tb4_1(1),
LDCCOPFTTLO_.tb4_2(1),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  GEOGRAP_LOCATION_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_GEOGRA_LOCATION WHERE GEOG_LOCA_AREA_TYPE = 2 ORDER BY GEOGRAP_LOCATION_ID ASC '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'GEOGRAP_LOCATION_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_GEOGRA_LOCATION|'
,
'WHERE GEOG_LOCA_AREA_TYPE = 2|'
,
'ORDER BY GEOGRAP_LOCATION_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(2):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(2):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(2):=90165910;
LDCCOPFTTLO_.tb4_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(2)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(2):=LDCCOPFTTLO_.tb4_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(2),
LDCCOPFTTLO_.tb4_1(2),
LDCCOPFTTLO_.tb4_2(2),
5,
'Y'
,
'Y'
,
'N'
,
'SELECT  GEOGRAP_LOCATION_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_GEOGRA_LOCATION WHERE GEO_LOCA_FATHER_ID = [DEPARTAMENTO] ORDER BY GEOGRAP_LOCATION_ID ASC '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'GEOGRAP_LOCATION_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_GEOGRA_LOCATION|'
,
'WHERE GEO_LOCA_FATHER_ID = DEPARTAMENTO|'
,
'ORDER BY GEOGRAP_LOCATION_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(3):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(3):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(3):=90165990;
LDCCOPFTTLO_.tb4_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(3)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(3):=LDCCOPFTTLO_.tb4_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(3),
LDCCOPFTTLO_.tb4_1(3),
LDCCOPFTTLO_.tb4_2(3),
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
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(4):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(4):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(4):=90169405;
LDCCOPFTTLO_.tb4_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(4)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(4):=LDCCOPFTTLO_.tb4_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(4),
LDCCOPFTTLO_.tb4_1(4),
LDCCOPFTTLO_.tb4_2(4),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ID_TIPOCONTRATO "ID TIPO DE CONTRATO ADMINISTRATIVO" , DESCRIPCION "DESCRIPCION" , ACTIVIDAD "ACTIVIDAD DE NOVEDAD ADMINISTRATIVA"  FROM LDC_TIPOCON_ADMINISTRATIVO WHERE ES_CONTRATO_VEHI = '|| chr(39) ||'N'|| chr(39) ||' '
,
'N'
,
'ID TIPO DE CONTRATO ADMINISTRATIVO'
,
'DESCRIPCION'
,
'ID_TIPOCONTRATO Id tipo de contrato administrativo|DESCRIPCION Descripcion|ACTIVIDAD Actividad de novedad administrativa|'
,
'FROM LDC_TIPOCON_ADMINISTRATIVO|'
,
'WHERE ES_CONTRATO_VEHI = '|| chr(39) ||'N'|| chr(39) ||'|'
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
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(5):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(5):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(5):=90169406;
LDCCOPFTTLO_.tb4_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(5)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(5):=LDCCOPFTTLO_.tb4_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(5),
LDCCOPFTTLO_.tb4_1(5),
LDCCOPFTTLO_.tb4_2(5),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS WHERE ITEM_CLASSIF_ID = 2 ORDER BY ITEMS_ID ASC '
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
'WHERE ITEM_CLASSIF_ID = 2|'
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
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;

LDCCOPFTTLO_.tb4_0(6):=LDCCOPFTTLO_.tb3_0(0);
LDCCOPFTTLO_.tb4_1(6):=LDCCOPFTTLO_.tb3_1(0);
LDCCOPFTTLO_.old_tb4_2(6):=90169408;
LDCCOPFTTLO_.tb4_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCCOPFTTLO_.TBENTITYATTRIBUTENAME(LDCCOPFTTLO_.old_tb4_2(6)), 'ATTRIBUTE');
LDCCOPFTTLO_.tb4_2(6):=LDCCOPFTTLO_.tb4_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCCOPFTTLO_.tb4_0(6),
LDCCOPFTTLO_.tb4_1(6),
LDCCOPFTTLO_.tb4_2(6),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS ORDER BY ITEMS_ID ASC '
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
null,
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
LDCCOPFTTLO_.blProcessStatus := false;
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
 nuIndexInternal := LDCCOPFTTLO_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCCOPFTTLO_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCCOPFTTLO_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCCOPFTTLO_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCCOPFTTLO_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCCOPFTTLO_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCCOPFTTLO_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCCOPFTTLO_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCCOPFTTLO_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCCOPFTTLO_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCCOPFTTLO_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCCOPFTTLO_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCCOPFTTLO_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCCOPFTTLO_.tbUserException(nuIndex).user_id, LDCCOPFTTLO_.tbUserException(nuIndex).status , LDCCOPFTTLO_.tbUserException(nuIndex).usr_exc_type_id, LDCCOPFTTLO_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCCOPFTTLO_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCCOPFTTLO_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCCOPFTTLO_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCCOPFTTLO_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCCOPFTTLO_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCCOPFTTLO_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCCOPFTTLO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCCOPFTTLO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCCOPFTTLO_******************************'); end;
/

