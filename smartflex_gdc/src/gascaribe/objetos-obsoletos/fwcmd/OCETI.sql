BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('OCETI_',
'CREATE OR REPLACE PACKAGE OCETI_ IS ' || chr(10) ||
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
'tb1_1 ty1_1;type ty2_0 is table of SA_EXEC_ENTITIES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_EXEC_ENTITIES.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''OCETI''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''OCETI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''OCETI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''OCETI'' ' || chr(10) ||
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
'END OCETI_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:OCETI_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
Open OCETI_.cuRoleExecutables;
loop
 fetch OCETI_.cuRoleExecutables INTO OCETI_.rcRoleExecutables;
 exit when  OCETI_.cuRoleExecutables%notfound;
 OCETI_.tbRoleExecutables(nuIndex) := OCETI_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close OCETI_.cuRoleExecutables;
nuIndex := 0;
Open OCETI_.cuUserExceptions ;
loop
 fetch OCETI_.cuUserExceptions INTO  OCETI_.rcUserExceptions;
 exit when OCETI_.cuUserExceptions%notfound;
 OCETI_.tbUserException(nuIndex):=OCETI_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close OCETI_.cuUserExceptions;
nuIndex := 0;
Open OCETI_.cuExecEntities ;
loop
 fetch OCETI_.cuExecEntities INTO  OCETI_.rcExecEntities;
 exit when OCETI_.cuExecEntities%notfound;
 OCETI_.tbExecEntities(nuIndex):=OCETI_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close OCETI_.cuExecEntities;

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI'
);

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   OCETI_.tbEntityName(8314) := 'LDC_TITULACION';
   OCETI_.tbEntityAttributeName(90016838) := 'LDC_TITULACION@ID_TITULACION';
   OCETI_.tbEntityAttributeName(90016839) := 'LDC_TITULACION@VERSION';
   OCETI_.tbEntityAttributeName(90016840) := 'LDC_TITULACION@DESCRIPCION';
   OCETI_.tbEntityAttributeName(90016841) := 'LDC_TITULACION@ID_TIPOCERT';
   OCETI_.tbEntityAttributeName(90016842) := 'LDC_TITULACION@ID_ORG_CERT';
 
   OCETI_.tbEntityName(8316) := 'LDC_CERTIFICADO';
   OCETI_.tbEntityAttributeName(90016849) := 'LDC_CERTIFICADO@ID_CERTIFICADO';
   OCETI_.tbEntityAttributeName(90016851) := 'LDC_CERTIFICADO@UNIDAD_OPERATIVA';
   OCETI_.tbEntityAttributeName(90016852) := 'LDC_CERTIFICADO@TECNICO_UNIDAD';
   OCETI_.tbEntityAttributeName(90016854) := 'LDC_CERTIFICADO@CODIGO_RUFI_CON';
   OCETI_.tbEntityAttributeName(90016853) := 'LDC_CERTIFICADO@CODIGO_RUFI_TEC';
   OCETI_.tbEntityAttributeName(90016856) := 'LDC_CERTIFICADO@FECHA_INI_VIG';
   OCETI_.tbEntityAttributeName(90016857) := 'LDC_CERTIFICADO@FECHA_FIN_VIG';
   OCETI_.tbEntityAttributeName(90016855) := 'LDC_CERTIFICADO@TIPO_CERTIFICADO';
   OCETI_.tbEntityAttributeName(90016860) := 'LDC_CERTIFICADO@ID_TITULACION';
   OCETI_.tbEntityAttributeName(90016859) := 'LDC_CERTIFICADO@ID_NORMA';
   OCETI_.tbEntityAttributeName(90016850) := 'LDC_CERTIFICADO@ID_ORG_CERT';
   OCETI_.tbEntityAttributeName(90016858) := 'LDC_CERTIFICADO@FLAG_ACTIVO';
 
END; 
/

BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI');

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI') AND ROLE_ID=1;

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI');

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI');

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI'));

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCETI');

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='OCETI';

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.old_tb0_0(0):='OCETI'
;
OCETI_.tb0_0(0):=UPPER(OCETI_.old_tb0_0(0));
OCETI_.old_tb0_1(0):=500000000000600;
OCETI_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(OCETI_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
OCETI_.tb0_1(0):=OCETI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (OCETI_.tb0_0(0),
OCETI_.tb0_1(0),
'Certificacion tecnicos x titulacion'
,
null,
'10.1'
,
8,
2,
4,
1,
1345,
'Y'
,
null,
'N'
,
'Y'
,
107,
null,
to_date('23-08-2016 09:32:58','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb1_0(0):=1;
OCETI_.tb1_1(0):=OCETI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (OCETI_.tb1_0(0),
OCETI_.tb1_1(0));

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb2_0(0):=OCETI_.tb0_1(0);
OCETI_.old_tb2_1(0):=8316;
OCETI_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYNAME(OCETI_.old_tb2_1(0)), 'ENTITY');
OCETI_.tb2_1(0):=OCETI_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_EXEC_ENTITIES fila (0)',1);
INSERT INTO SA_EXEC_ENTITIES(EXECUTABLE_ID,ENTITY_ID) 
VALUES (OCETI_.tb2_0(0),
OCETI_.tb2_1(0));

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb3_0(0):=OCETI_.tb0_1(0);
OCETI_.old_tb3_1(0):=8314;
OCETI_.tb3_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYNAME(OCETI_.old_tb3_1(0)), 'ENTITY');
OCETI_.tb3_1(0):=OCETI_.tb3_1(0);
OCETI_.old_tb3_2(0):=null;
OCETI_.tb3_2(0):=CASE WHEN (OCETI_.old_tb3_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYNAME(OCETI_.old_tb3_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (OCETI_.tb3_0(0),
OCETI_.tb3_1(0),
OCETI_.tb3_2(0),
'G'
,
0,
0,
null,
' LDC_TITULACION.ID_TITULACION  <> '|| chr(39) ||'-1'|| chr(39) ||''
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(0):=OCETI_.tb3_0(0);
OCETI_.tb4_1(0):=OCETI_.tb3_1(0);
OCETI_.old_tb4_2(0):=90016838;
OCETI_.tb4_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(0)), 'ATTRIBUTE');
OCETI_.tb4_2(0):=OCETI_.tb4_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(0),
OCETI_.tb4_1(0),
OCETI_.tb4_2(0),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(1):=OCETI_.tb3_0(0);
OCETI_.tb4_1(1):=OCETI_.tb3_1(0);
OCETI_.old_tb4_2(1):=90016839;
OCETI_.tb4_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(1)), 'ATTRIBUTE');
OCETI_.tb4_2(1):=OCETI_.tb4_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(1),
OCETI_.tb4_1(1),
OCETI_.tb4_2(1),
1,
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(2):=OCETI_.tb3_0(0);
OCETI_.tb4_1(2):=OCETI_.tb3_1(0);
OCETI_.old_tb4_2(2):=90016840;
OCETI_.tb4_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(2)), 'ATTRIBUTE');
OCETI_.tb4_2(2):=OCETI_.tb4_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(2),
OCETI_.tb4_1(2),
OCETI_.tb4_2(2),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(3):=OCETI_.tb3_0(0);
OCETI_.tb4_1(3):=OCETI_.tb3_1(0);
OCETI_.old_tb4_2(3):=90016841;
OCETI_.tb4_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(3)), 'ATTRIBUTE');
OCETI_.tb4_2(3):=OCETI_.tb4_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(3),
OCETI_.tb4_1(3),
OCETI_.tb4_2(3),
3,
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(4):=OCETI_.tb3_0(0);
OCETI_.tb4_1(4):=OCETI_.tb3_1(0);
OCETI_.old_tb4_2(4):=90016842;
OCETI_.tb4_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(4)), 'ATTRIBUTE');
OCETI_.tb4_2(4):=OCETI_.tb4_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(4),
OCETI_.tb4_1(4),
OCETI_.tb4_2(4),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb3_0(1):=OCETI_.tb0_1(0);
OCETI_.old_tb3_1(1):=8316;
OCETI_.tb3_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYNAME(OCETI_.old_tb3_1(1)), 'ENTITY');
OCETI_.tb3_1(1):=OCETI_.tb3_1(1);
OCETI_.old_tb3_2(1):=8314;
OCETI_.tb3_2(1):=CASE WHEN (OCETI_.old_tb3_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYNAME(OCETI_.old_tb3_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (OCETI_.tb3_0(1),
OCETI_.tb3_1(1),
OCETI_.tb3_2(1),
'G'
,
1,
0,
null,
null,
' LDC_TITULACION.ID_ORG_CERT  =  LDC_CERTIFICADO.ID_ORG_CERT  AND  LDC_TITULACION.ID_TITULACION  =  LDC_CERTIFICADO.ID_TITULACION '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(5):=OCETI_.tb3_0(1);
OCETI_.tb4_1(5):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(5):=90016849;
OCETI_.tb4_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(5)), 'ATTRIBUTE');
OCETI_.tb4_2(5):=OCETI_.tb4_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(5),
OCETI_.tb4_1(5),
OCETI_.tb4_2(5),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(6):=OCETI_.tb3_0(1);
OCETI_.tb4_1(6):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(6):=90016850;
OCETI_.tb4_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(6)), 'ATTRIBUTE');
OCETI_.tb4_2(6):=OCETI_.tb4_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(6),
OCETI_.tb4_1(6),
OCETI_.tb4_2(6),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(7):=OCETI_.tb3_0(1);
OCETI_.tb4_1(7):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(7):=90016851;
OCETI_.tb4_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(7)), 'ATTRIBUTE');
OCETI_.tb4_2(7):=OCETI_.tb4_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(7),
OCETI_.tb4_1(7),
OCETI_.tb4_2(7),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_UNIT_ID "C¿DIGO DE IDENTIFICACI¿N DE LA UNIDAD OPERATIVA" , NAME "NOMBRE"  FROM OR_OPERATING_UNIT ORDER BY OPERATING_UNIT_ID ASC '
,
'N'
,
'C¿DIGO DE IDENTIFICACI¿N DE LA UNIDAD OPERATIVA'
,
'NOMBRE'
,
'OPERATING_UNIT_ID C¿digo De Identificaci¿n De La Unidad Operativa|NAME Nombre|'
,
'FROM OR_OPERATING_UNIT|'
,
null,
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(8):=OCETI_.tb3_0(1);
OCETI_.tb4_1(8):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(8):=90016852;
OCETI_.tb4_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(8)), 'ATTRIBUTE');
OCETI_.tb4_2(8):=OCETI_.tb4_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(8),
OCETI_.tb4_1(8),
OCETI_.tb4_2(8),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  OPERATING_UNIT_ID "C¿DIGO DE IDENTIFICACI¿N DE LA UNIDAD OPERATIVA" , PERSON_ID "C¿DIGO" , NAME_ "NOMBRE"  FROM LDC_VIEW_PERS_UNIDAD_CERTIF WHERE OPERATING_UNIT_ID = [UNIDAD_OPERATIVA] ORDER BY OPERATING_UNIT_ID ASC '
,
'N'
,
'C¿DIGO'
,
'NOMBRE'
,
'OPERATING_UNIT_ID C¿digo De Identificaci¿n De La Unidad Operativa|PERSON_ID C¿digo|NAME_ Nombre|'
,
'FROM LDC_VIEW_PERS_UNIDAD_CERTIF|'
,
'WHERE OPERATING_UNIT_ID = UNIDAD_OPERATIVA|'
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(9):=OCETI_.tb3_0(1);
OCETI_.tb4_1(9):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(9):=90016853;
OCETI_.tb4_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(9)), 'ATTRIBUTE');
OCETI_.tb4_2(9):=OCETI_.tb4_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(9),
OCETI_.tb4_1(9),
OCETI_.tb4_2(9),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(10):=OCETI_.tb3_0(1);
OCETI_.tb4_1(10):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(10):=90016854;
OCETI_.tb4_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(10)), 'ATTRIBUTE');
OCETI_.tb4_2(10):=OCETI_.tb4_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(10),
OCETI_.tb4_1(10),
OCETI_.tb4_2(10),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(11):=OCETI_.tb3_0(1);
OCETI_.tb4_1(11):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(11):=90016855;
OCETI_.tb4_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(11)), 'ATTRIBUTE');
OCETI_.tb4_2(11):=OCETI_.tb4_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(11),
OCETI_.tb4_1(11),
OCETI_.tb4_2(11),
7,
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(12):=OCETI_.tb3_0(1);
OCETI_.tb4_1(12):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(12):=90016856;
OCETI_.tb4_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(12)), 'ATTRIBUTE');
OCETI_.tb4_2(12):=OCETI_.tb4_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(12),
OCETI_.tb4_1(12),
OCETI_.tb4_2(12),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(13):=OCETI_.tb3_0(1);
OCETI_.tb4_1(13):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(13):=90016857;
OCETI_.tb4_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(13)), 'ATTRIBUTE');
OCETI_.tb4_2(13):=OCETI_.tb4_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(13),
OCETI_.tb4_1(13),
OCETI_.tb4_2(13),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(14):=OCETI_.tb3_0(1);
OCETI_.tb4_1(14):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(14):=90016858;
OCETI_.tb4_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(14)), 'ATTRIBUTE');
OCETI_.tb4_2(14):=OCETI_.tb4_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(14),
OCETI_.tb4_1(14),
OCETI_.tb4_2(14),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(15):=OCETI_.tb3_0(1);
OCETI_.tb4_1(15):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(15):=90016859;
OCETI_.tb4_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(15)), 'ATTRIBUTE');
OCETI_.tb4_2(15):=OCETI_.tb4_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(15),
OCETI_.tb4_1(15),
OCETI_.tb4_2(15),
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
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;

OCETI_.tb4_0(16):=OCETI_.tb3_0(1);
OCETI_.tb4_1(16):=OCETI_.tb3_1(1);
OCETI_.old_tb4_2(16):=90016860;
OCETI_.tb4_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCETI_.TBENTITYATTRIBUTENAME(OCETI_.old_tb4_2(16)), 'ATTRIBUTE');
OCETI_.tb4_2(16):=OCETI_.tb4_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCETI_.tb4_0(16),
OCETI_.tb4_1(16),
OCETI_.tb4_2(16),
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
OCETI_.blProcessStatus := false;
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
 nuIndexInternal := OCETI_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (OCETI_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (OCETI_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := OCETI_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := OCETI_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not OCETI_.blProcessStatus) then
 return;
end if;
nuIndex :=  OCETI_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (OCETI_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(OCETI_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (OCETI_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := OCETI_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  OCETI_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(OCETI_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,OCETI_.tbUserException(nuIndex).user_id, OCETI_.tbUserException(nuIndex).status , OCETI_.tbUserException(nuIndex).usr_exc_type_id, OCETI_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := OCETI_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  OCETI_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(OCETI_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = OCETI_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,OCETI_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := OCETI_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
OCETI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('OCETI_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:OCETI_******************************'); end;
/

