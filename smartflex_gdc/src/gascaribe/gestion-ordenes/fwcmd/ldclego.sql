BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCLEGO_',
'CREATE OR REPLACE PACKAGE LDCLEGO_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCLEGO''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCLEGO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCLEGO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCLEGO'' ' || chr(10) ||
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
'END LDCLEGO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCLEGO_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
Open LDCLEGO_.cuRoleExecutables;
loop
 fetch LDCLEGO_.cuRoleExecutables INTO LDCLEGO_.rcRoleExecutables;
 exit when  LDCLEGO_.cuRoleExecutables%notfound;
 LDCLEGO_.tbRoleExecutables(nuIndex) := LDCLEGO_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCLEGO_.cuRoleExecutables;
nuIndex := 0;
Open LDCLEGO_.cuUserExceptions ;
loop
 fetch LDCLEGO_.cuUserExceptions INTO  LDCLEGO_.rcUserExceptions;
 exit when LDCLEGO_.cuUserExceptions%notfound;
 LDCLEGO_.tbUserException(nuIndex):=LDCLEGO_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCLEGO_.cuUserExceptions;
nuIndex := 0;
Open LDCLEGO_.cuExecEntities ;
loop
 fetch LDCLEGO_.cuExecEntities INTO  LDCLEGO_.rcExecEntities;
 exit when LDCLEGO_.cuExecEntities%notfound;
 LDCLEGO_.tbExecEntities(nuIndex):=LDCLEGO_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCLEGO_.cuExecEntities;

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO'
);

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCLEGO_.tbEntityName(4558) := 'LDC_AGENLEGO';
   LDCLEGO_.tbEntityAttributeName(90157842) := 'LDC_AGENLEGO@AGENTE_ID';
   LDCLEGO_.tbEntityAttributeName(90157843) := 'LDC_AGENLEGO@DESCRIPTION';
 
   LDCLEGO_.tbEntityName(4561) := 'LDC_USUALEGO';
   LDCLEGO_.tbEntityAttributeName(90157849) := 'LDC_USUALEGO@PERSON_ID';
   LDCLEGO_.tbEntityAttributeName(90157850) := 'LDC_USUALEGO@AGENTE_ID';
   LDCLEGO_.tbEntityAttributeName(90157851) := 'LDC_USUALEGO@TECNICO_UNIDAD';
   LDCLEGO_.tbEntityAttributeName(90157852) := 'LDC_USUALEGO@UNICO_TECNICO';
   LDCLEGO_.tbEntityAttributeName(90157853) := 'LDC_USUALEGO@CAUSAL_ID';
 
END; 
/

BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO');

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO') AND ROLE_ID=1;

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO');

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO');

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO'));

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCLEGO');

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCLEGO';

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.old_tb0_0(0):='LDCLEGO'
;
LDCLEGO_.tb0_0(0):=UPPER(LDCLEGO_.old_tb0_0(0));
LDCLEGO_.old_tb0_1(0):=500000000012905;
LDCLEGO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCLEGO_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCLEGO_.tb0_1(0):=LDCLEGO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCLEGO_.tb0_0(0),
LDCLEGO_.tb0_1(0),
'Administracion LEGO'
,
null,
'40'
,
8,
2,
4,
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
'C'
,
to_date('10-07-2025 10:47:19','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb1_0(0):=1;
LDCLEGO_.tb1_1(0):=LDCLEGO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCLEGO_.tb1_0(0),
LDCLEGO_.tb1_1(0));

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb2_0(0):=LDCLEGO_.tb0_1(0);
LDCLEGO_.old_tb2_1(0):=4558;
LDCLEGO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYNAME(LDCLEGO_.old_tb2_1(0)), 'ENTITY');
LDCLEGO_.tb2_1(0):=LDCLEGO_.tb2_1(0);
LDCLEGO_.old_tb2_2(0):=null;
LDCLEGO_.tb2_2(0):=CASE WHEN (LDCLEGO_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYNAME(LDCLEGO_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCLEGO_.tb2_0(0),
LDCLEGO_.tb2_1(0),
LDCLEGO_.tb2_2(0),
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
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(0):=LDCLEGO_.tb2_0(0);
LDCLEGO_.tb3_1(0):=LDCLEGO_.tb2_1(0);
LDCLEGO_.old_tb3_2(0):=90157842;
LDCLEGO_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(0)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(0):=LDCLEGO_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(0),
LDCLEGO_.tb3_1(0),
LDCLEGO_.tb3_2(0),
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
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(1):=LDCLEGO_.tb2_0(0);
LDCLEGO_.tb3_1(1):=LDCLEGO_.tb2_1(0);
LDCLEGO_.old_tb3_2(1):=90157843;
LDCLEGO_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(1)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(1):=LDCLEGO_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(1),
LDCLEGO_.tb3_1(1),
LDCLEGO_.tb3_2(1),
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
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb2_0(1):=LDCLEGO_.tb0_1(0);
LDCLEGO_.old_tb2_1(1):=4561;
LDCLEGO_.tb2_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYNAME(LDCLEGO_.old_tb2_1(1)), 'ENTITY');
LDCLEGO_.tb2_1(1):=LDCLEGO_.tb2_1(1);
LDCLEGO_.old_tb2_2(1):=null;
LDCLEGO_.tb2_2(1):=CASE WHEN (LDCLEGO_.old_tb2_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYNAME(LDCLEGO_.old_tb2_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCLEGO_.tb2_0(1),
LDCLEGO_.tb2_1(1),
LDCLEGO_.tb2_2(1),
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
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(2):=LDCLEGO_.tb2_0(1);
LDCLEGO_.tb3_1(2):=LDCLEGO_.tb2_1(1);
LDCLEGO_.old_tb3_2(2):=90157849;
LDCLEGO_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(2)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(2):=LDCLEGO_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(2),
LDCLEGO_.tb3_1(2),
LDCLEGO_.tb3_2(2),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT  PERSON_ID "C¿DIGO" , NAME_ "NOMBRE"  FROM GE_PERSON WHERE EXISTS (SELECT O.PERSON_ID FROM OPEN.OR_OPER_UNIT_PERSONS O WHERE O.PERSON_ID = PERSON_ID) ORDER BY PERSON_ID ASC '
,
'N'
,
'C¿DIGO'
,
'NOMBRE'
,
'PERSON_ID C¿digo|NAME_ Nombre|'
,
'FROM GE_PERSON|'
,
'WHERE EXISTS (SELECT O.PERSON_ID FROM OPEN.OR_OPER_UNIT_PERSONS O WHERE O.PERSON_ID = PERSON_ID)|'
,
'ORDER BY PERSON_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(3):=LDCLEGO_.tb2_0(1);
LDCLEGO_.tb3_1(3):=LDCLEGO_.tb2_1(1);
LDCLEGO_.old_tb3_2(3):=90157850;
LDCLEGO_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(3)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(3):=LDCLEGO_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(3),
LDCLEGO_.tb3_1(3),
LDCLEGO_.tb3_2(3),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  AGENTE_ID "CODIGO" , DESCRIPTION "DESCRIPCION"  FROM LDC_AGENLEGO ORDER BY AGENTE_ID ASC '
,
'N'
,
'CODIGO'
,
'DESCRIPCION'
,
'AGENTE_ID CODIGO|DESCRIPTION DESCRIPCION|'
,
'FROM LDC_AGENLEGO|'
,
null,
'ORDER BY AGENTE_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(4):=LDCLEGO_.tb2_0(1);
LDCLEGO_.tb3_1(4):=LDCLEGO_.tb2_1(1);
LDCLEGO_.old_tb3_2(4):=90157851;
LDCLEGO_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(4)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(4):=LDCLEGO_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(4),
LDCLEGO_.tb3_1(4),
LDCLEGO_.tb3_2(4),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  PERSON_ID "C¿DIGO" , NAME_ "NOMBRE"  FROM GE_PERSON WHERE EXISTS (SELECT O.PERSON_ID FROM OPEN.OR_OPER_UNIT_PERSONS O WHERE O.PERSON_ID = PERSON_ID) ORDER BY PERSON_ID ASC '
,
'N'
,
'C¿DIGO'
,
'NOMBRE'
,
'PERSON_ID C¿digo|NAME_ Nombre|'
,
'FROM GE_PERSON|'
,
'WHERE EXISTS (SELECT O.PERSON_ID FROM OPEN.OR_OPER_UNIT_PERSONS O WHERE O.PERSON_ID = PERSON_ID)|'
,
'ORDER BY PERSON_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(5):=LDCLEGO_.tb2_0(1);
LDCLEGO_.tb3_1(5):=LDCLEGO_.tb2_1(1);
LDCLEGO_.old_tb3_2(5):=90157852;
LDCLEGO_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(5)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(5):=LDCLEGO_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(5),
LDCLEGO_.tb3_1(5),
LDCLEGO_.tb3_2(5),
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
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;

LDCLEGO_.tb3_0(6):=LDCLEGO_.tb2_0(1);
LDCLEGO_.tb3_1(6):=LDCLEGO_.tb2_1(1);
LDCLEGO_.old_tb3_2(6):=90157853;
LDCLEGO_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCLEGO_.TBENTITYATTRIBUTENAME(LDCLEGO_.old_tb3_2(6)), 'ATTRIBUTE');
LDCLEGO_.tb3_2(6):=LDCLEGO_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCLEGO_.tb3_0(6),
LDCLEGO_.tb3_1(6),
LDCLEGO_.tb3_2(6),
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
LDCLEGO_.blProcessStatus := false;
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
 nuIndexInternal := LDCLEGO_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCLEGO_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCLEGO_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCLEGO_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCLEGO_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCLEGO_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCLEGO_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCLEGO_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCLEGO_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCLEGO_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCLEGO_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCLEGO_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCLEGO_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCLEGO_.tbUserException(nuIndex).user_id, LDCLEGO_.tbUserException(nuIndex).status , LDCLEGO_.tbUserException(nuIndex).usr_exc_type_id, LDCLEGO_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCLEGO_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCLEGO_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCLEGO_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCLEGO_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCLEGO_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCLEGO_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCLEGO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCLEGO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCLEGO_******************************'); end;
/

