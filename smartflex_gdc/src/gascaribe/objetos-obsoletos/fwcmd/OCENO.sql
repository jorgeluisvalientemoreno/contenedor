BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('OCENO_',
'CREATE OR REPLACE PACKAGE OCENO_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''OCENO''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''OCENO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''OCENO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''OCENO'' ' || chr(10) ||
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
'END OCENO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:OCENO_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
Open OCENO_.cuRoleExecutables;
loop
 fetch OCENO_.cuRoleExecutables INTO OCENO_.rcRoleExecutables;
 exit when  OCENO_.cuRoleExecutables%notfound;
 OCENO_.tbRoleExecutables(nuIndex) := OCENO_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close OCENO_.cuRoleExecutables;
nuIndex := 0;
Open OCENO_.cuUserExceptions ;
loop
 fetch OCENO_.cuUserExceptions INTO  OCENO_.rcUserExceptions;
 exit when OCENO_.cuUserExceptions%notfound;
 OCENO_.tbUserException(nuIndex):=OCENO_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close OCENO_.cuUserExceptions;
nuIndex := 0;
Open OCENO_.cuExecEntities ;
loop
 fetch OCENO_.cuExecEntities INTO  OCENO_.rcExecEntities;
 exit when OCENO_.cuExecEntities%notfound;
 OCENO_.tbExecEntities(nuIndex):=OCENO_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close OCENO_.cuExecEntities;

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO'
);

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   OCENO_.tbEntityName(8315) := 'LDC_NORMA';
   OCENO_.tbEntityAttributeName(90016843) := 'LDC_NORMA@ID_NORMA';
   OCENO_.tbEntityAttributeName(90016844) := 'LDC_NORMA@DESCRIPCION';
   OCENO_.tbEntityAttributeName(90016845) := 'LDC_NORMA@MATE_CONST';
   OCENO_.tbEntityAttributeName(90016846) := 'LDC_NORMA@ID_TITULACION';
   OCENO_.tbEntityAttributeName(90016847) := 'LDC_NORMA@ID_TIPOCERT';
   OCENO_.tbEntityAttributeName(90016848) := 'LDC_NORMA@ID_ORG_CERT';
 
   OCENO_.tbEntityName(8316) := 'LDC_CERTIFICADO';
   OCENO_.tbEntityAttributeName(90016849) := 'LDC_CERTIFICADO@ID_CERTIFICADO';
   OCENO_.tbEntityAttributeName(90016851) := 'LDC_CERTIFICADO@UNIDAD_OPERATIVA';
   OCENO_.tbEntityAttributeName(90016852) := 'LDC_CERTIFICADO@TECNICO_UNIDAD';
   OCENO_.tbEntityAttributeName(90016854) := 'LDC_CERTIFICADO@CODIGO_RUFI_CON';
   OCENO_.tbEntityAttributeName(90016853) := 'LDC_CERTIFICADO@CODIGO_RUFI_TEC';
   OCENO_.tbEntityAttributeName(90016856) := 'LDC_CERTIFICADO@FECHA_INI_VIG';
   OCENO_.tbEntityAttributeName(90016857) := 'LDC_CERTIFICADO@FECHA_FIN_VIG';
   OCENO_.tbEntityAttributeName(90016855) := 'LDC_CERTIFICADO@TIPO_CERTIFICADO';
   OCENO_.tbEntityAttributeName(90016860) := 'LDC_CERTIFICADO@ID_TITULACION';
   OCENO_.tbEntityAttributeName(90016859) := 'LDC_CERTIFICADO@ID_NORMA';
   OCENO_.tbEntityAttributeName(90016850) := 'LDC_CERTIFICADO@ID_ORG_CERT';
   OCENO_.tbEntityAttributeName(90016858) := 'LDC_CERTIFICADO@FLAG_ACTIVO';
 
END; 
/

BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO');

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO') AND ROLE_ID=1;

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO');

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO');

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO'));

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='OCENO');

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='OCENO';

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.old_tb0_0(0):='OCENO'
;
OCENO_.tb0_0(0):=UPPER(OCENO_.old_tb0_0(0));
OCENO_.old_tb0_1(0):=500000000000601;
OCENO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(OCENO_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
OCENO_.tb0_1(0):=OCENO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (OCENO_.tb0_0(0),
OCENO_.tb0_1(0),
'Certificacion tecnicos x norma'
,
null,
'8'
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
178,
null,
to_date('17-08-2016 08:09:23','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb1_0(0):=1;
OCENO_.tb1_1(0):=OCENO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (OCENO_.tb1_0(0),
OCENO_.tb1_1(0));

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb2_0(0):=OCENO_.tb0_1(0);
OCENO_.old_tb2_1(0):=8315;
OCENO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYNAME(OCENO_.old_tb2_1(0)), 'ENTITY');
OCENO_.tb2_1(0):=OCENO_.tb2_1(0);
OCENO_.old_tb2_2(0):=null;
OCENO_.tb2_2(0):=CASE WHEN (OCENO_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYNAME(OCENO_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (OCENO_.tb2_0(0),
OCENO_.tb2_1(0),
OCENO_.tb2_2(0),
'G'
,
0,
0,
null,
' LDC_NORMA.ID_TITULACION  = '|| chr(39) ||'-1'|| chr(39) ||''
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(0):=OCENO_.tb2_0(0);
OCENO_.tb3_1(0):=OCENO_.tb2_1(0);
OCENO_.old_tb3_2(0):=90016843;
OCENO_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(0)), 'ATTRIBUTE');
OCENO_.tb3_2(0):=OCENO_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(0),
OCENO_.tb3_1(0),
OCENO_.tb3_2(0),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(1):=OCENO_.tb2_0(0);
OCENO_.tb3_1(1):=OCENO_.tb2_1(0);
OCENO_.old_tb3_2(1):=90016844;
OCENO_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(1)), 'ATTRIBUTE');
OCENO_.tb3_2(1):=OCENO_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(1),
OCENO_.tb3_1(1),
OCENO_.tb3_2(1),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(2):=OCENO_.tb2_0(0);
OCENO_.tb3_1(2):=OCENO_.tb2_1(0);
OCENO_.old_tb3_2(2):=90016845;
OCENO_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(2)), 'ATTRIBUTE');
OCENO_.tb3_2(2):=OCENO_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(2),
OCENO_.tb3_1(2),
OCENO_.tb3_2(2),
2,
'N'
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(3):=OCENO_.tb2_0(0);
OCENO_.tb3_1(3):=OCENO_.tb2_1(0);
OCENO_.old_tb3_2(3):=90016846;
OCENO_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(3)), 'ATTRIBUTE');
OCENO_.tb3_2(3):=OCENO_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(3),
OCENO_.tb3_1(3),
OCENO_.tb3_2(3),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(4):=OCENO_.tb2_0(0);
OCENO_.tb3_1(4):=OCENO_.tb2_1(0);
OCENO_.old_tb3_2(4):=90016847;
OCENO_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(4)), 'ATTRIBUTE');
OCENO_.tb3_2(4):=OCENO_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(4),
OCENO_.tb3_1(4),
OCENO_.tb3_2(4),
4,
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(5):=OCENO_.tb2_0(0);
OCENO_.tb3_1(5):=OCENO_.tb2_1(0);
OCENO_.old_tb3_2(5):=90016848;
OCENO_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(5)), 'ATTRIBUTE');
OCENO_.tb3_2(5):=OCENO_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(5),
OCENO_.tb3_1(5),
OCENO_.tb3_2(5),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb2_0(1):=OCENO_.tb0_1(0);
OCENO_.old_tb2_1(1):=8316;
OCENO_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYNAME(OCENO_.old_tb2_1(1)), 'ENTITY');
OCENO_.tb2_1(1):=OCENO_.tb2_1(1);
OCENO_.old_tb2_2(1):=8315;
OCENO_.tb2_2(1):=CASE WHEN (OCENO_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYNAME(OCENO_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (OCENO_.tb2_0(1),
OCENO_.tb2_1(1),
OCENO_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDC_NORMA.ID_NORMA  =  LDC_CERTIFICADO.ID_NORMA  AND  LDC_NORMA.ID_ORG_CERT  =  LDC_CERTIFICADO.ID_ORG_CERT  AND  LDC_NORMA.ID_TITULACION  =  LDC_CERTIFICADO.ID_TITULACION '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(6):=OCENO_.tb2_0(1);
OCENO_.tb3_1(6):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(6):=90016849;
OCENO_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(6)), 'ATTRIBUTE');
OCENO_.tb3_2(6):=OCENO_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(6),
OCENO_.tb3_1(6),
OCENO_.tb3_2(6),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(7):=OCENO_.tb2_0(1);
OCENO_.tb3_1(7):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(7):=90016850;
OCENO_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(7)), 'ATTRIBUTE');
OCENO_.tb3_2(7):=OCENO_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(7),
OCENO_.tb3_1(7),
OCENO_.tb3_2(7),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(8):=OCENO_.tb2_0(1);
OCENO_.tb3_1(8):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(8):=90016851;
OCENO_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(8)), 'ATTRIBUTE');
OCENO_.tb3_2(8):=OCENO_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(8),
OCENO_.tb3_1(8),
OCENO_.tb3_2(8),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(9):=OCENO_.tb2_0(1);
OCENO_.tb3_1(9):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(9):=90016852;
OCENO_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(9)), 'ATTRIBUTE');
OCENO_.tb3_2(9):=OCENO_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(9),
OCENO_.tb3_1(9),
OCENO_.tb3_2(9),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(10):=OCENO_.tb2_0(1);
OCENO_.tb3_1(10):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(10):=90016853;
OCENO_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(10)), 'ATTRIBUTE');
OCENO_.tb3_2(10):=OCENO_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(10),
OCENO_.tb3_1(10),
OCENO_.tb3_2(10),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(11):=OCENO_.tb2_0(1);
OCENO_.tb3_1(11):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(11):=90016854;
OCENO_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(11)), 'ATTRIBUTE');
OCENO_.tb3_2(11):=OCENO_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(11),
OCENO_.tb3_1(11),
OCENO_.tb3_2(11),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(12):=OCENO_.tb2_0(1);
OCENO_.tb3_1(12):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(12):=90016855;
OCENO_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(12)), 'ATTRIBUTE');
OCENO_.tb3_2(12):=OCENO_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(12),
OCENO_.tb3_1(12),
OCENO_.tb3_2(12),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(13):=OCENO_.tb2_0(1);
OCENO_.tb3_1(13):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(13):=90016856;
OCENO_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(13)), 'ATTRIBUTE');
OCENO_.tb3_2(13):=OCENO_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(13),
OCENO_.tb3_1(13),
OCENO_.tb3_2(13),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(14):=OCENO_.tb2_0(1);
OCENO_.tb3_1(14):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(14):=90016857;
OCENO_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(14)), 'ATTRIBUTE');
OCENO_.tb3_2(14):=OCENO_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(14),
OCENO_.tb3_1(14),
OCENO_.tb3_2(14),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(15):=OCENO_.tb2_0(1);
OCENO_.tb3_1(15):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(15):=90016858;
OCENO_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(15)), 'ATTRIBUTE');
OCENO_.tb3_2(15):=OCENO_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(15),
OCENO_.tb3_1(15),
OCENO_.tb3_2(15),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(16):=OCENO_.tb2_0(1);
OCENO_.tb3_1(16):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(16):=90016859;
OCENO_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(16)), 'ATTRIBUTE');
OCENO_.tb3_2(16):=OCENO_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(16),
OCENO_.tb3_1(16),
OCENO_.tb3_2(16),
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
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;

OCENO_.tb3_0(17):=OCENO_.tb2_0(1);
OCENO_.tb3_1(17):=OCENO_.tb2_1(1);
OCENO_.old_tb3_2(17):=90016860;
OCENO_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(OCENO_.TBENTITYATTRIBUTENAME(OCENO_.old_tb3_2(17)), 'ATTRIBUTE');
OCENO_.tb3_2(17):=OCENO_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (OCENO_.tb3_0(17),
OCENO_.tb3_1(17),
OCENO_.tb3_2(17),
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
OCENO_.blProcessStatus := false;
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
 nuIndexInternal := OCENO_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (OCENO_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (OCENO_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := OCENO_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := OCENO_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not OCENO_.blProcessStatus) then
 return;
end if;
nuIndex :=  OCENO_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (OCENO_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(OCENO_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (OCENO_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := OCENO_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  OCENO_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(OCENO_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,OCENO_.tbUserException(nuIndex).user_id, OCENO_.tbUserException(nuIndex).status , OCENO_.tbUserException(nuIndex).usr_exc_type_id, OCENO_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := OCENO_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  OCENO_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(OCENO_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = OCENO_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,OCENO_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := OCENO_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
OCENO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('OCENO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:OCENO_******************************'); end;
/

