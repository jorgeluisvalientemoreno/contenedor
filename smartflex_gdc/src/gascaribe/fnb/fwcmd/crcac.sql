BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CRCAC_',
'CREATE OR REPLACE PACKAGE CRCAC_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''CRCAC''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''CRCAC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''CRCAC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''CRCAC'' ' || chr(10) ||
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
'END CRCAC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CRCAC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
Open CRCAC_.cuRoleExecutables;
loop
 fetch CRCAC_.cuRoleExecutables INTO CRCAC_.rcRoleExecutables;
 exit when  CRCAC_.cuRoleExecutables%notfound;
 CRCAC_.tbRoleExecutables(nuIndex) := CRCAC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close CRCAC_.cuRoleExecutables;
nuIndex := 0;
Open CRCAC_.cuUserExceptions ;
loop
 fetch CRCAC_.cuUserExceptions INTO  CRCAC_.rcUserExceptions;
 exit when CRCAC_.cuUserExceptions%notfound;
 CRCAC_.tbUserException(nuIndex):=CRCAC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close CRCAC_.cuUserExceptions;
nuIndex := 0;
Open CRCAC_.cuExecEntities ;
loop
 fetch CRCAC_.cuExecEntities INTO  CRCAC_.rcExecEntities;
 exit when CRCAC_.cuExecEntities%notfound;
 CRCAC_.tbExecEntities(nuIndex):=CRCAC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close CRCAC_.cuExecEntities;

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC'
);

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   CRCAC_.tbEntityName(8577) := 'LD_SEND_AUTHORIZED';
   CRCAC_.tbEntityAttributeName(90024576) := 'LD_SEND_AUTHORIZED@IDENT_TYPE_ID';
   CRCAC_.tbEntityAttributeName(90024577) := 'LD_SEND_AUTHORIZED@IDENTIFICATION';
   CRCAC_.tbEntityAttributeName(90024578) := 'LD_SEND_AUTHORIZED@AUTHORIZED';
   CRCAC_.tbEntityAttributeName(90024579) := 'LD_SEND_AUTHORIZED@TYPE_PRODUCT_ID';
   CRCAC_.tbEntityAttributeName(90024580) := 'LD_SEND_AUTHORIZED@MODIF_USER_ID';
   CRCAC_.tbEntityAttributeName(90024581) := 'LD_SEND_AUTHORIZED@MODIF_DATE';
   CRCAC_.tbEntityAttributeName(90138408) := 'LD_SEND_AUTHORIZED@PRODUCT_ID';
   CRCAC_.tbEntityAttributeName(90138416) := 'LD_SEND_AUTHORIZED@TIPO_RESPONSABLE';
   CRCAC_.tbEntityAttributeName(90151561) := 'LD_SEND_AUTHORIZED@CAUSAL';
   CRCAC_.tbEntityAttributeName(90167130) := 'LD_SEND_AUTHORIZED@SAMPLE_ID';
 
END; 
/

BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC');

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC') AND ROLE_ID=1;

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC');

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC');

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC'));

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CRCAC');

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='CRCAC';

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.old_tb0_0(0):='CRCAC'
;
CRCAC_.tb0_0(0):=UPPER(CRCAC_.old_tb0_0(0));
CRCAC_.old_tb0_1(0):=500000000001139;
CRCAC_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(CRCAC_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
CRCAC_.tb0_1(0):=CRCAC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (CRCAC_.tb0_0(0),
CRCAC_.tb0_1(0),
'Configuraci¿n de autorizaci¿n de clientes a centrales de riesgo'
,
null,
'41.1'
,
8,
2,
47,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
24,
'C'
,
to_date('26-02-2018 11:17:30','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb1_0(0):=1;
CRCAC_.tb1_1(0):=CRCAC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (CRCAC_.tb1_0(0),
CRCAC_.tb1_1(0));

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb2_0(0):=CRCAC_.tb0_1(0);
CRCAC_.old_tb2_1(0):=8577;
CRCAC_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYNAME(CRCAC_.old_tb2_1(0)), 'ENTITY');
CRCAC_.tb2_1(0):=CRCAC_.tb2_1(0);
CRCAC_.old_tb2_2(0):=null;
CRCAC_.tb2_2(0):=CASE WHEN (CRCAC_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYNAME(CRCAC_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (CRCAC_.tb2_0(0),
CRCAC_.tb2_1(0),
CRCAC_.tb2_2(0),
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(0):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(0):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(0):=90024576;
CRCAC_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(0)), 'ATTRIBUTE');
CRCAC_.tb3_2(0):=CRCAC_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(0),
CRCAC_.tb3_1(0),
CRCAC_.tb3_2(0),
0,
'Y'
,
'Y'
,
'N'
,
'SELECT  IDENT_TYPE_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_IDENTIFICA_TYPE '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'IDENT_TYPE_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_IDENTIFICA_TYPE|'
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(1):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(1):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(1):=90024577;
CRCAC_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(1)), 'ATTRIBUTE');
CRCAC_.tb3_2(1):=CRCAC_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(1),
CRCAC_.tb3_1(1),
CRCAC_.tb3_2(1),
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(2):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(2):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(2):=90024578;
CRCAC_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(2)), 'ATTRIBUTE');
CRCAC_.tb3_2(2):=CRCAC_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(2),
CRCAC_.tb3_1(2),
CRCAC_.tb3_2(2),
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(3):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(3):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(3):=90024579;
CRCAC_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(3)), 'ATTRIBUTE');
CRCAC_.tb3_2(3):=CRCAC_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(3),
CRCAC_.tb3_1(3),
CRCAC_.tb3_2(3),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  SERVCODI "C¿DIGO" , SERVDESC "DESCRIPCI¿N"  FROM SERVICIO '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'SERVCODI C¿digo|SERVDESC Descripci¿n|'
,
'FROM SERVICIO|'
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(4):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(4):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(4):=90024580;
CRCAC_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(4)), 'ATTRIBUTE');
CRCAC_.tb3_2(4):=CRCAC_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(4),
CRCAC_.tb3_1(4),
CRCAC_.tb3_2(4),
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(5):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(5):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(5):=90024581;
CRCAC_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(5)), 'ATTRIBUTE');
CRCAC_.tb3_2(5):=CRCAC_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(5),
CRCAC_.tb3_1(5),
CRCAC_.tb3_2(5),
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(6):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(6):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(6):=90138408;
CRCAC_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(6)), 'ATTRIBUTE');
CRCAC_.tb3_2(6):=CRCAC_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(6),
CRCAC_.tb3_1(6),
CRCAC_.tb3_2(6),
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(7):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(7):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(7):=90138416;
CRCAC_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(7)), 'ATTRIBUTE');
CRCAC_.tb3_2(7):=CRCAC_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(7),
CRCAC_.tb3_1(7),
CRCAC_.tb3_2(7),
7,
'Y'
,
'Y'
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
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(8):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(8):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(8):=90151561;
CRCAC_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(8)), 'ATTRIBUTE');
CRCAC_.tb3_2(8):=CRCAC_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(8),
CRCAC_.tb3_1(8),
CRCAC_.tb3_2(8),
8,
'Y'
,
'Y'
,
'N'
,
'SELECT  CAUSAL_ID "C¿DIGO" , DESCRIPTION "DESCRIPCI¿N"  FROM GE_CAUSAL WHERE MODULE_ID = 47 ORDER BY CAUSAL_ID ASC '
,
'N'
,
'C¿DIGO'
,
'DESCRIPCI¿N'
,
'CAUSAL_ID C¿digo|DESCRIPTION Descripci¿n|'
,
'FROM GE_CAUSAL|'
,
'WHERE MODULE_ID = 47|'
,
'ORDER BY CAUSAL_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;

CRCAC_.tb3_0(9):=CRCAC_.tb2_0(0);
CRCAC_.tb3_1(9):=CRCAC_.tb2_1(0);
CRCAC_.old_tb3_2(9):=90167130;
CRCAC_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(CRCAC_.TBENTITYATTRIBUTENAME(CRCAC_.old_tb3_2(9)), 'ATTRIBUTE');
CRCAC_.tb3_2(9):=CRCAC_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (CRCAC_.tb3_0(9),
CRCAC_.tb3_1(9),
CRCAC_.tb3_2(9),
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
CRCAC_.blProcessStatus := false;
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
 nuIndexInternal := CRCAC_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (CRCAC_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (CRCAC_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := CRCAC_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := CRCAC_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not CRCAC_.blProcessStatus) then
 return;
end if;
nuIndex :=  CRCAC_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (CRCAC_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(CRCAC_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (CRCAC_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := CRCAC_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  CRCAC_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(CRCAC_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,CRCAC_.tbUserException(nuIndex).user_id, CRCAC_.tbUserException(nuIndex).status , CRCAC_.tbUserException(nuIndex).usr_exc_type_id, CRCAC_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := CRCAC_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  CRCAC_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(CRCAC_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = CRCAC_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,CRCAC_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := CRCAC_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
CRCAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CRCAC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CRCAC_******************************'); end;
/

