BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCACGEOL_',
'CREATE OR REPLACE PACKAGE LDCACGEOL_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCACGEOL''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCACGEOL'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCACGEOL'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCACGEOL'' ' || chr(10) ||
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
'END LDCACGEOL_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCACGEOL_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
Open LDCACGEOL_.cuRoleExecutables;
loop
 fetch LDCACGEOL_.cuRoleExecutables INTO LDCACGEOL_.rcRoleExecutables;
 exit when  LDCACGEOL_.cuRoleExecutables%notfound;
 LDCACGEOL_.tbRoleExecutables(nuIndex) := LDCACGEOL_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCACGEOL_.cuRoleExecutables;
nuIndex := 0;
Open LDCACGEOL_.cuUserExceptions ;
loop
 fetch LDCACGEOL_.cuUserExceptions INTO  LDCACGEOL_.rcUserExceptions;
 exit when LDCACGEOL_.cuUserExceptions%notfound;
 LDCACGEOL_.tbUserException(nuIndex):=LDCACGEOL_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCACGEOL_.cuUserExceptions;
nuIndex := 0;
Open LDCACGEOL_.cuExecEntities ;
loop
 fetch LDCACGEOL_.cuExecEntities INTO  LDCACGEOL_.rcExecEntities;
 exit when LDCACGEOL_.cuExecEntities%notfound;
 LDCACGEOL_.tbExecEntities(nuIndex):=LDCACGEOL_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCACGEOL_.cuExecEntities;

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL'
);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCACGEOL_.tbEntityName(6093) := 'LDC_RECROBLE';
   LDCACGEOL_.tbEntityAttributeName(90199264) := 'LDC_RECROBLE@REOBCODI';
   LDCACGEOL_.tbEntityAttributeName(90199265) := 'LDC_RECROBLE@REOBDESC';
   LDCACGEOL_.tbEntityAttributeName(90199266) := 'LDC_RECROBLE@REOBREOB';
 
   LDCACGEOL_.tbEntityName(6023) := 'LDC_OBLEACTI';
   LDCACGEOL_.tbEntityAttributeName(90199254) := 'LDC_OBLEACTI@REGLOBLE';
   LDCACGEOL_.tbEntityAttributeName(90198135) := 'LDC_OBLEACTI@OBLECODI';
   LDCACGEOL_.tbEntityAttributeName(90198137) := 'LDC_OBLEACTI@PERIOD_CONSE';
   LDCACGEOL_.tbEntityAttributeName(90198138) := 'LDC_OBLEACTI@DIAS_GEN_OT';
   LDCACGEOL_.tbEntityAttributeName(90198134) := 'LDC_OBLEACTI@MEDIO_RECEPCION';
   LDCACGEOL_.tbEntityAttributeName(90198136) := 'LDC_OBLEACTI@ACTIVIDAD';
   LDCACGEOL_.tbEntityAttributeName(90198139) := 'LDC_OBLEACTI@GEN_NOTI';
   LDCACGEOL_.tbEntityAttributeName(90198495) := 'LDC_OBLEACTI@CAUSAL_EXITO';
   LDCACGEOL_.tbEntityAttributeName(90198496) := 'LDC_OBLEACTI@ACTIVIDAD_CRITICA';
   LDCACGEOL_.tbEntityAttributeName(90199255) := 'LDC_OBLEACTI@ESTACORTE';
   LDCACGEOL_.tbEntityAttributeName(90199296) := 'LDC_OBLEACTI@TIPO_SUSPENSION';
   LDCACGEOL_.tbEntityAttributeName(90199297) := 'LDC_OBLEACTI@GEN_RELECTURA';
 
END; 
/

BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL');

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL') AND ROLE_ID=1;

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL');

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL');

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL'));

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL');

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCACGEOL';

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.old_tb0_0(0):='LDCACGEOL'
;
LDCACGEOL_.tb0_0(0):=UPPER(LDCACGEOL_.old_tb0_0(0));
LDCACGEOL_.old_tb0_1(0):=500000000015617;
LDCACGEOL_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCACGEOL_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCACGEOL_.tb0_1(0):=LDCACGEOL_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCACGEOL_.tb0_0(0),
LDCACGEOL_.tb0_1(0),
'Actividades a Generar por Observacion de Lectura'
,
null,
'18'
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
33,
'C',
to_date('14-08-2023 23:25:59','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb1_0(0):=1;
LDCACGEOL_.tb1_1(0):=LDCACGEOL_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCACGEOL_.tb1_0(0),
LDCACGEOL_.tb1_1(0));

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb2_0(0):=LDCACGEOL_.tb0_1(0);
LDCACGEOL_.old_tb2_1(0):=6093;
LDCACGEOL_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYNAME(LDCACGEOL_.old_tb2_1(0)), 'ENTITY');
LDCACGEOL_.tb2_1(0):=LDCACGEOL_.tb2_1(0);
LDCACGEOL_.old_tb2_2(0):=null;
LDCACGEOL_.tb2_2(0):=CASE WHEN (LDCACGEOL_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYNAME(LDCACGEOL_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCACGEOL_.tb2_0(0),
LDCACGEOL_.tb2_1(0),
LDCACGEOL_.tb2_2(0),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(0):=LDCACGEOL_.tb2_0(0);
LDCACGEOL_.tb3_1(0):=LDCACGEOL_.tb2_1(0);
LDCACGEOL_.old_tb3_2(0):=90199264;
LDCACGEOL_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(0)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(0):=LDCACGEOL_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(0),
LDCACGEOL_.tb3_1(0),
LDCACGEOL_.tb3_2(0),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT CONSECUTIVO "Código",CODIGO_CALIFICACION "Descripción" FROM LDC_CALIFICACION_CONS'
,
'N'
,
'Código'
,
'Descripción'
,
'CONSECUTIVO Código|CODIGO_CALIFICACION Descripción|'
,
'FROM LDC_CALIFICACION_CONS'
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(1):=LDCACGEOL_.tb2_0(0);
LDCACGEOL_.tb3_1(1):=LDCACGEOL_.tb2_1(0);
LDCACGEOL_.old_tb3_2(1):=90199265;
LDCACGEOL_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(1)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(1):=LDCACGEOL_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(1),
LDCACGEOL_.tb3_1(1),
LDCACGEOL_.tb3_2(1),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(2):=LDCACGEOL_.tb2_0(0);
LDCACGEOL_.tb3_1(2):=LDCACGEOL_.tb2_1(0);
LDCACGEOL_.old_tb3_2(2):=90199266;
LDCACGEOL_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(2)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(2):=LDCACGEOL_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(2),
LDCACGEOL_.tb3_1(2),
LDCACGEOL_.tb3_2(2),
2,
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb2_0(1):=LDCACGEOL_.tb0_1(0);
LDCACGEOL_.old_tb2_1(1):=6023;
LDCACGEOL_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYNAME(LDCACGEOL_.old_tb2_1(1)), 'ENTITY');
LDCACGEOL_.tb2_1(1):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb2_2(1):=6093;
LDCACGEOL_.tb2_2(1):=CASE WHEN (LDCACGEOL_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYNAME(LDCACGEOL_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCACGEOL_.tb2_0(1),
LDCACGEOL_.tb2_1(1),
LDCACGEOL_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDC_OBLEACTI.REGLOBLE  =  LDC_RECROBLE.REOBCODI '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(3):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(3):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(3):=90198134;
LDCACGEOL_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(3)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(3):=LDCACGEOL_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(3),
LDCACGEOL_.tb3_1(3),
LDCACGEOL_.tb3_2(3),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  RECEPTION_TYPE_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_RECEPTION_TYPE ORDER BY RECEPTION_TYPE_ID ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'RECEPTION_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_RECEPTION_TYPE|'
,
null,
'ORDER BY RECEPTION_TYPE_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(4):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(4):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(4):=90198135;
LDCACGEOL_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(4)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(4):=LDCACGEOL_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(4),
LDCACGEOL_.tb3_1(4),
LDCACGEOL_.tb3_2(4),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  OBLECODI "CÓDIGO" , OBLEDESC "DESCRIPCIÓN"  FROM OBSELECT '
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(5):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(5):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(5):=90198136;
LDCACGEOL_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(5)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(5):=LDCACGEOL_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(5),
LDCACGEOL_.tb3_1(5),
LDCACGEOL_.tb3_2(5),
5,
'Y'
,
'Y'
,
'N'
,
'SELECT  ITEMS_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_ITEMS '
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
null,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(6):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(6):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(6):=90198137;
LDCACGEOL_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(6)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(6):=LDCACGEOL_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(6),
LDCACGEOL_.tb3_1(6),
LDCACGEOL_.tb3_2(6),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(7):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(7):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(7):=90198138;
LDCACGEOL_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(7)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(7):=LDCACGEOL_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(7),
LDCACGEOL_.tb3_1(7),
LDCACGEOL_.tb3_2(7),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(8):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(8):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(8):=90198139;
LDCACGEOL_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(8)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(8):=LDCACGEOL_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(8),
LDCACGEOL_.tb3_1(8),
LDCACGEOL_.tb3_2(8),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(9):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(9):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(9):=90198495;
LDCACGEOL_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(9)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(9):=LDCACGEOL_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(9),
LDCACGEOL_.tb3_1(9),
LDCACGEOL_.tb3_2(9),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(10):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(10):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(10):=90198496;
LDCACGEOL_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(10)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(10):=LDCACGEOL_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(10),
LDCACGEOL_.tb3_1(10),
LDCACGEOL_.tb3_2(10),
8,
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(11):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(11):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(11):=90199254;
LDCACGEOL_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(11)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(11):=LDCACGEOL_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(11),
LDCACGEOL_.tb3_1(11),
LDCACGEOL_.tb3_2(11),
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
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(12):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(12):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(12):=90199255;
LDCACGEOL_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(12)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(12):=LDCACGEOL_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(12),
LDCACGEOL_.tb3_1(12),
LDCACGEOL_.tb3_2(12),
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
'M'
,
null,
null,
null,
null);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(13):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(13):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(13):=90199296;
LDCACGEOL_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(13)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(13):=LDCACGEOL_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(13),
LDCACGEOL_.tb3_1(13),
LDCACGEOL_.tb3_2(13),
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
'M'
,
null,
null,
null,
null);

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;

LDCACGEOL_.tb3_0(14):=LDCACGEOL_.tb2_0(1);
LDCACGEOL_.tb3_1(14):=LDCACGEOL_.tb2_1(1);
LDCACGEOL_.old_tb3_2(14):=90199297;
LDCACGEOL_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCACGEOL_.TBENTITYATTRIBUTENAME(LDCACGEOL_.old_tb3_2(14)), 'ATTRIBUTE');
LDCACGEOL_.tb3_2(14):=LDCACGEOL_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCACGEOL_.tb3_0(14),
LDCACGEOL_.tb3_1(14),
LDCACGEOL_.tb3_2(14),
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
LDCACGEOL_.blProcessStatus := false;
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
 nuIndexInternal := LDCACGEOL_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCACGEOL_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCACGEOL_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCACGEOL_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCACGEOL_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCACGEOL_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCACGEOL_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCACGEOL_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCACGEOL_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCACGEOL_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCACGEOL_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCACGEOL_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCACGEOL_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCACGEOL_.tbUserException(nuIndex).user_id, LDCACGEOL_.tbUserException(nuIndex).status , LDCACGEOL_.tbUserException(nuIndex).usr_exc_type_id, LDCACGEOL_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCACGEOL_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCACGEOL_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCACGEOL_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCACGEOL_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCACGEOL_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCACGEOL_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCACGEOL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCACGEOL_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCACGEOL_******************************'); end;
/

