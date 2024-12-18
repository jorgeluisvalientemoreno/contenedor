BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCTA_',
'CREATE OR REPLACE PACKAGE LDCTA_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCTA''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCTA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCTA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCTA'' ' || chr(10) ||
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
'END LDCTA_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCTA_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
Open LDCTA_.cuRoleExecutables;
loop
 fetch LDCTA_.cuRoleExecutables INTO LDCTA_.rcRoleExecutables;
 exit when  LDCTA_.cuRoleExecutables%notfound;
 LDCTA_.tbRoleExecutables(nuIndex) := LDCTA_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCTA_.cuRoleExecutables;
nuIndex := 0;
Open LDCTA_.cuUserExceptions ;
loop
 fetch LDCTA_.cuUserExceptions INTO  LDCTA_.rcUserExceptions;
 exit when LDCTA_.cuUserExceptions%notfound;
 LDCTA_.tbUserException(nuIndex):=LDCTA_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCTA_.cuUserExceptions;
nuIndex := 0;
Open LDCTA_.cuExecEntities ;
loop
 fetch LDCTA_.cuExecEntities INTO  LDCTA_.rcExecEntities;
 exit when LDCTA_.cuExecEntities%notfound;
 LDCTA_.tbExecEntities(nuIndex):=LDCTA_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCTA_.cuExecEntities;

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA'
);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCTA_.tbEntityName(584) := 'LDC_ORDTIPTRAADI';
   LDCTA_.tbEntityAttributeName(90053552) := 'LDC_ORDTIPTRAADI@ORDER_ID';
   LDCTA_.tbEntityAttributeName(90053553) := 'LDC_ORDTIPTRAADI@USER_ID';
   LDCTA_.tbEntityAttributeName(90053554) := 'LDC_ORDTIPTRAADI@GENERADO';
   LDCTA_.tbEntityAttributeName(90068544) := 'LDC_ORDTIPTRAADI@CAUSAL_ID';
   LDCTA_.tbEntityAttributeName(90068545) := 'LDC_ORDTIPTRAADI@TECNICO_UNIDAD';
   LDCTA_.tbEntityAttributeName(90092847) := 'LDC_ORDTIPTRAADI@EXEC_INITIAL_DATE';
   LDCTA_.tbEntityAttributeName(90092848) := 'LDC_ORDTIPTRAADI@EXEC_FINAL_DATE';
   LDCTA_.tbEntityAttributeName(90092849) := 'LDC_ORDTIPTRAADI@ORDER_COMMENT';
   LDCTA_.tbEntityAttributeName(90092887) := 'LDC_ORDTIPTRAADI@REGISTER_BY_XML';
 
   LDCTA_.tbEntityName(585) := 'LDC_REGTIPOTRAADI';
   LDCTA_.tbEntityAttributeName(90053555) := 'LDC_REGTIPOTRAADI@ORDER_ID';
   LDCTA_.tbEntityAttributeName(90053556) := 'LDC_REGTIPOTRAADI@TASK_TYPE_ID';
   LDCTA_.tbEntityAttributeName(90053557) := 'LDC_REGTIPOTRAADI@ITEMS_ID';
   LDCTA_.tbEntityAttributeName(90053558) := 'LDC_REGTIPOTRAADI@CAUSAL_ID';
   LDCTA_.tbEntityAttributeName(90053559) := 'LDC_REGTIPOTRAADI@OBSERVACION';
   LDCTA_.tbEntityAttributeName(90066494) := 'LDC_REGTIPOTRAADI@TECNICO_UNIDAD';
 
   LDCTA_.tbEntityName(620) := 'LDC_ITEMTIPTRAADI';
   LDCTA_.tbEntityAttributeName(90053996) := 'LDC_ITEMTIPTRAADI@ORDER_ID';
   LDCTA_.tbEntityAttributeName(90053997) := 'LDC_ITEMTIPTRAADI@TASK_TYPE_ID';
   LDCTA_.tbEntityAttributeName(90053998) := 'LDC_ITEMTIPTRAADI@ITEMS_ID';
   LDCTA_.tbEntityAttributeName(90053999) := 'LDC_ITEMTIPTRAADI@MATERIAL_ID';
   LDCTA_.tbEntityAttributeName(90054000) := 'LDC_ITEMTIPTRAADI@CANTIDAD';
 
END; 
/

BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA');

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA') AND ROLE_ID=1;

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA');

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA');

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA'));

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCTA');

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCTA';

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.old_tb0_0(0):='LDCTA'
;
LDCTA_.tb0_0(0):=UPPER(LDCTA_.old_tb0_0(0));
LDCTA_.old_tb0_1(0):=500000000004449;
LDCTA_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCTA_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCTA_.tb0_1(0):=LDCTA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCTA_.tb0_0(0),
LDCTA_.tb0_1(0),
'REGISTRO DE TRABAJOS ADCIONALES'
,
null,
'107'
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
64,
null,
to_date('28-04-2016 17:24:19','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb1_0(0):=1;
LDCTA_.tb1_1(0):=LDCTA_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCTA_.tb1_0(0),
LDCTA_.tb1_1(0));

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb2_0(0):=LDCTA_.tb0_1(0);
LDCTA_.old_tb2_1(0):=584;
LDCTA_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYNAME(LDCTA_.old_tb2_1(0)), 'ENTITY');
LDCTA_.tb2_1(0):=LDCTA_.tb2_1(0);
LDCTA_.old_tb2_2(0):=null;
LDCTA_.tb2_2(0):=CASE WHEN (LDCTA_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYNAME(LDCTA_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCTA_.tb2_0(0),
LDCTA_.tb2_1(0),
LDCTA_.tb2_2(0),
'G'
,
0,
0,
null,
' (LDC_ORDTIPTRAADI.GENERADO  = '|| chr(39) ||'A'|| chr(39) ||'  OR  LDC_ORDTIPTRAADI.GENERADO  = '|| chr(39) ||'N'|| chr(39) ||'  OR  LDC_ORDTIPTRAADI.GENERADO IS NULL) AND LDC_FNUVISUALIZAORPLO( LDC_ORDTIPTRAADI.ORDER_ID) =1'
,
null,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(0):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(0):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(0):=90053552;
LDCTA_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(0)), 'ATTRIBUTE');
LDCTA_.tb3_2(0):=LDCTA_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(0),
LDCTA_.tb3_1(0),
LDCTA_.tb3_2(0),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(1):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(1):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(1):=90053553;
LDCTA_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(1)), 'ATTRIBUTE');
LDCTA_.tb3_2(1):=LDCTA_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(1),
LDCTA_.tb3_1(1),
LDCTA_.tb3_2(1),
1,
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(2):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(2):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(2):=90053554;
LDCTA_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(2)), 'ATTRIBUTE');
LDCTA_.tb3_2(2):=LDCTA_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(2),
LDCTA_.tb3_1(2),
LDCTA_.tb3_2(2),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(3):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(3):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(3):=90068544;
LDCTA_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(3)), 'ATTRIBUTE');
LDCTA_.tb3_2(3):=LDCTA_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(3),
LDCTA_.tb3_1(3),
LDCTA_.tb3_2(3),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT CAUSAL_ID "CÓDIGO",DESCRIPTION "DESCRIPCIÓN" FROM GE_CAUSAL'
,
'N'
,
'Código'
,
'Descripción'
,
'CAUSAL_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_CAUSAL'
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(4):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(4):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(4):=90068545;
LDCTA_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(4)), 'ATTRIBUTE');
LDCTA_.tb3_2(4):=LDCTA_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(4),
LDCTA_.tb3_1(4),
LDCTA_.tb3_2(4),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  CODIGO_TECNICO "CODIGO" , NOMBRE_TECNICO "DESCRIPCION"  FROM LDC_VIEW_TECNICO_ORDEN ORDER BY CODIGO_TECNICO ASC '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'CODIGO_TECNICO CODIGO|NOMBRE_TECNICO DESCRIPCION|'
,
'FROM LDC_VIEW_TECNICO_ORDEN|'
,
null,
'ORDER BY CODIGO_TECNICO ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(5):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(5):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(5):=90092847;
LDCTA_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(5)), 'ATTRIBUTE');
LDCTA_.tb3_2(5):=LDCTA_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(5),
LDCTA_.tb3_1(5),
LDCTA_.tb3_2(5),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(6):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(6):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(6):=90092848;
LDCTA_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(6)), 'ATTRIBUTE');
LDCTA_.tb3_2(6):=LDCTA_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(6),
LDCTA_.tb3_1(6),
LDCTA_.tb3_2(6),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(7):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(7):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(7):=90092849;
LDCTA_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(7)), 'ATTRIBUTE');
LDCTA_.tb3_2(7):=LDCTA_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(7),
LDCTA_.tb3_1(7),
LDCTA_.tb3_2(7),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(8):=LDCTA_.tb2_0(0);
LDCTA_.tb3_1(8):=LDCTA_.tb2_1(0);
LDCTA_.old_tb3_2(8):=90092887;
LDCTA_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(8)), 'ATTRIBUTE');
LDCTA_.tb3_2(8):=LDCTA_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(8),
LDCTA_.tb3_1(8),
LDCTA_.tb3_2(8),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb2_0(1):=LDCTA_.tb0_1(0);
LDCTA_.old_tb2_1(1):=585;
LDCTA_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYNAME(LDCTA_.old_tb2_1(1)), 'ENTITY');
LDCTA_.tb2_1(1):=LDCTA_.tb2_1(1);
LDCTA_.old_tb2_2(1):=584;
LDCTA_.tb2_2(1):=CASE WHEN (LDCTA_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYNAME(LDCTA_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCTA_.tb2_0(1),
LDCTA_.tb2_1(1),
LDCTA_.tb2_2(1),
'G'
,
1,
0,
null,
null,
' LDC_ORDTIPTRAADI.ORDER_ID  =  LDC_REGTIPOTRAADI.ORDER_ID'
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(9):=LDCTA_.tb2_0(1);
LDCTA_.tb3_1(9):=LDCTA_.tb2_1(1);
LDCTA_.old_tb3_2(9):=90053555;
LDCTA_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(9)), 'ATTRIBUTE');
LDCTA_.tb3_2(9):=LDCTA_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(9),
LDCTA_.tb3_1(9),
LDCTA_.tb3_2(9),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(10):=LDCTA_.tb2_0(1);
LDCTA_.tb3_1(10):=LDCTA_.tb2_1(1);
LDCTA_.old_tb3_2(10):=90053556;
LDCTA_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(10)), 'ATTRIBUTE');
LDCTA_.tb3_2(10):=LDCTA_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(10),
LDCTA_.tb3_1(10),
LDCTA_.tb3_2(10),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT TASK_TYPE_ID "CÓDIGO",DESCRIPTION "DESCRIPCIÓN" FROM OR_TASK_TYPE'
,
'N'
,
'Código'
,
'Descripción'
,
'TASK_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM OR_TASK_TYPE'
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(11):=LDCTA_.tb2_0(1);
LDCTA_.tb3_1(11):=LDCTA_.tb2_1(1);
LDCTA_.old_tb3_2(11):=90053557;
LDCTA_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(11)), 'ATTRIBUTE');
LDCTA_.tb3_2(11):=LDCTA_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(11),
LDCTA_.tb3_1(11),
LDCTA_.tb3_2(11),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  TIPO_TRABAJO "TIPO DE TRABAJO" , CODIGO_ACTIVIDAD "CODIGO ACTIVIDAD" , DESCRIPCION_ACTIVIDAD "DESCRIPCION ACTIVIDAD"  FROM LDC_OR_TASK_TYPES_ITEMS WHERE TIPO_TRABAJO = [TASK_TYPE_ID] ORDER BY CODIGO_ACTIVIDAD ASC '
,
'N'
,
'CODIGO ACTIVIDAD'
,
'DESCRIPCION ACTIVIDAD'
,
'TIPO_TRABAJO TIPO DE TRABAJO|CODIGO_ACTIVIDAD CODIGO ACTIVIDAD|DESCRIPCION_ACTIVIDAD DESCRIPCION ACTIVIDAD|'
,
'FROM LDC_OR_TASK_TYPES_ITEMS|'
,
'WHERE TIPO_TRABAJO = TASK_TYPE_ID|'
,
'ORDER BY CODIGO_ACTIVIDAD ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(12):=LDCTA_.tb2_0(1);
LDCTA_.tb3_1(12):=LDCTA_.tb2_1(1);
LDCTA_.old_tb3_2(12):=90053558;
LDCTA_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(12)), 'ATTRIBUTE');
LDCTA_.tb3_2(12):=LDCTA_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(12),
LDCTA_.tb3_1(12),
LDCTA_.tb3_2(12),
3,
'N'
,
'Y'
,
'N'
,
'SELECT  TIPO_TRABAJO "TIPO DE TRABAJO" , CODIGO_CAUSAL "CODIGO CAUSAL" , DESCRIPCION_CAUSAL "DESCRIPCION CAUSAL"  FROM LDC_OR_TASK_TYPE_CAUSAL WHERE TIPO_TRABAJO = [TASK_TYPE_ID] ORDER BY CODIGO_CAUSAL ASC '
,
'N'
,
'CODIGO CAUSAL'
,
'DESCRIPCION CAUSAL'
,
'TIPO_TRABAJO TIPO DE TRABAJO|CODIGO_CAUSAL CODIGO CAUSAL|DESCRIPCION_CAUSAL DESCRIPCION CAUSAL|'
,
'FROM LDC_OR_TASK_TYPE_CAUSAL|'
,
'WHERE TIPO_TRABAJO = TASK_TYPE_ID|'
,
'ORDER BY CODIGO_CAUSAL ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(13):=LDCTA_.tb2_0(1);
LDCTA_.tb3_1(13):=LDCTA_.tb2_1(1);
LDCTA_.old_tb3_2(13):=90053559;
LDCTA_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(13)), 'ATTRIBUTE');
LDCTA_.tb3_2(13):=LDCTA_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(13),
LDCTA_.tb3_1(13),
LDCTA_.tb3_2(13),
4,
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(14):=LDCTA_.tb2_0(1);
LDCTA_.tb3_1(14):=LDCTA_.tb2_1(1);
LDCTA_.old_tb3_2(14):=90066494;
LDCTA_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(14)), 'ATTRIBUTE');
LDCTA_.tb3_2(14):=LDCTA_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(14),
LDCTA_.tb3_1(14),
LDCTA_.tb3_2(14),
5,
'N'
,
'Y'
,
'N'
,
'SELECT  NOMBRE_TECNICO "DESCRIPCION" , CODIGO_TECNICO "CODIGO"  FROM LDC_VIEW_TECNICO_ORDEN ORDER BY CODIGO_TECNICO ASC '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'NOMBRE_TECNICO DESCRIPCION|CODIGO_TECNICO CODIGO|'
,
'FROM LDC_VIEW_TECNICO_ORDEN|'
,
null,
'ORDER BY CODIGO_TECNICO ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb2_0(2):=LDCTA_.tb0_1(0);
LDCTA_.old_tb2_1(2):=620;
LDCTA_.tb2_1(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYNAME(LDCTA_.old_tb2_1(2)), 'ENTITY');
LDCTA_.tb2_1(2):=LDCTA_.tb2_1(2);
LDCTA_.old_tb2_2(2):=585;
LDCTA_.tb2_2(2):=CASE WHEN (LDCTA_.old_tb2_2(2) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYNAME(LDCTA_.old_tb2_2(2)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (2)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCTA_.tb2_0(2),
LDCTA_.tb2_1(2),
LDCTA_.tb2_2(2),
'G'
,
2,
0,
null,
null,
' LDC_ITEMTIPTRAADI.ORDER_ID  =  LDC_REGTIPOTRAADI.ORDER_ID  AND  LDC_ITEMTIPTRAADI.TASK_TYPE_ID  =  LDC_REGTIPOTRAADI.TASK_TYPE_ID  AND  LDC_ITEMTIPTRAADI.ITEMS_ID  =  LDC_REGTIPOTRAADI.ITEMS_ID '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(15):=LDCTA_.tb2_0(2);
LDCTA_.tb3_1(15):=LDCTA_.tb2_1(2);
LDCTA_.old_tb3_2(15):=90053996;
LDCTA_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(15)), 'ATTRIBUTE');
LDCTA_.tb3_2(15):=LDCTA_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(15),
LDCTA_.tb3_1(15),
LDCTA_.tb3_2(15),
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(16):=LDCTA_.tb2_0(2);
LDCTA_.tb3_1(16):=LDCTA_.tb2_1(2);
LDCTA_.old_tb3_2(16):=90053997;
LDCTA_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(16)), 'ATTRIBUTE');
LDCTA_.tb3_2(16):=LDCTA_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(16),
LDCTA_.tb3_1(16),
LDCTA_.tb3_2(16),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT TASK_TYPE_ID "CÓDIGO",DESCRIPTION "DESCRIPCIÓN" FROM OR_TASK_TYPE'
,
'N'
,
'Código'
,
'Descripción'
,
'TASK_TYPE_ID Código|DESCRIPTION Descripción|'
,
'FROM OR_TASK_TYPE'
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(17):=LDCTA_.tb2_0(2);
LDCTA_.tb3_1(17):=LDCTA_.tb2_1(2);
LDCTA_.old_tb3_2(17):=90053998;
LDCTA_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(17)), 'ATTRIBUTE');
LDCTA_.tb3_2(17):=LDCTA_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(17),
LDCTA_.tb3_1(17),
LDCTA_.tb3_2(17),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT ITEMS_ID "Código",DESCRIPTION "Descripción" FROM GE_ITEMS'
,
'N'
,
'Código'
,
'Descripción'
,
'ITEMS_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_ITEMS'
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
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(18):=LDCTA_.tb2_0(2);
LDCTA_.tb3_1(18):=LDCTA_.tb2_1(2);
LDCTA_.old_tb3_2(18):=90053999;
LDCTA_.tb3_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(18)), 'ATTRIBUTE');
LDCTA_.tb3_2(18):=LDCTA_.tb3_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(18),
LDCTA_.tb3_1(18),
LDCTA_.tb3_2(18),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  TIPO_TRABAJO "TIPO DE TRABAJO" , CODIGO_MATERIAL "CODIGO MATERIAL" , DESCRIPCION_MATERIAL "DESCRIPCION MATERIAL"  FROM LDC_OR_TASK_TYPES_MATERIALES WHERE TIPO_TRABAJO = [TASK_TYPE_ID] ORDER BY CODIGO_MATERIAL ASC '
,
'N'
,
'CODIGO MATERIAL'
,
'DESCRIPCION MATERIAL'
,
'TIPO_TRABAJO TIPO DE TRABAJO|CODIGO_MATERIAL CODIGO MATERIAL|DESCRIPCION_MATERIAL DESCRIPCION MATERIAL|'
,
'FROM LDC_OR_TASK_TYPES_MATERIALES|'
,
'WHERE TIPO_TRABAJO = TASK_TYPE_ID|'
,
'ORDER BY CODIGO_MATERIAL ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;

LDCTA_.tb3_0(19):=LDCTA_.tb2_0(2);
LDCTA_.tb3_1(19):=LDCTA_.tb2_1(2);
LDCTA_.old_tb3_2(19):=90054000;
LDCTA_.tb3_2(19):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCTA_.TBENTITYATTRIBUTENAME(LDCTA_.old_tb3_2(19)), 'ATTRIBUTE');
LDCTA_.tb3_2(19):=LDCTA_.tb3_2(19);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (19)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCTA_.tb3_0(19),
LDCTA_.tb3_1(19),
LDCTA_.tb3_2(19),
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
LDCTA_.blProcessStatus := false;
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
 nuIndexInternal := LDCTA_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCTA_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCTA_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCTA_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCTA_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCTA_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCTA_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCTA_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCTA_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCTA_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCTA_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCTA_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCTA_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCTA_.tbUserException(nuIndex).user_id, LDCTA_.tbUserException(nuIndex).status , LDCTA_.tbUserException(nuIndex).usr_exc_type_id, LDCTA_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCTA_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCTA_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCTA_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCTA_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCTA_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCTA_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCTA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCTA_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCTA_******************************'); end;
/

