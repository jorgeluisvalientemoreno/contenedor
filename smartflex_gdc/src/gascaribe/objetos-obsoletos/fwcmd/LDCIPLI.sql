BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCIPLI_',
'CREATE OR REPLACE PACKAGE LDCIPLI_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCIPLI''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIPLI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIPLI'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCIPLI'' ' || chr(10) ||
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
'END LDCIPLI_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCIPLI_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
Open LDCIPLI_.cuRoleExecutables;
loop
 fetch LDCIPLI_.cuRoleExecutables INTO LDCIPLI_.rcRoleExecutables;
 exit when  LDCIPLI_.cuRoleExecutables%notfound;
 LDCIPLI_.tbRoleExecutables(nuIndex) := LDCIPLI_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCIPLI_.cuRoleExecutables;
nuIndex := 0;
Open LDCIPLI_.cuUserExceptions ;
loop
 fetch LDCIPLI_.cuUserExceptions INTO  LDCIPLI_.rcUserExceptions;
 exit when LDCIPLI_.cuUserExceptions%notfound;
 LDCIPLI_.tbUserException(nuIndex):=LDCIPLI_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCIPLI_.cuUserExceptions;
nuIndex := 0;
Open LDCIPLI_.cuExecEntities ;
loop
 fetch LDCIPLI_.cuExecEntities INTO  LDCIPLI_.rcExecEntities;
 exit when LDCIPLI_.cuExecEntities%notfound;
 LDCIPLI_.tbExecEntities(nuIndex):=LDCIPLI_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCIPLI_.cuExecEntities;

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI'
);

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDCIPLI_.tbEntityName(8876) := 'LDC_IPLI_IO';
   LDCIPLI_.tbEntityAttributeName(90046642) := 'LDC_IPLI_IO@IPLIO_ID';
   LDCIPLI_.tbEntityAttributeName(90046643) := 'LDC_IPLI_IO@IPLIMEDE';
   LDCIPLI_.tbEntityAttributeName(90046644) := 'LDC_IPLI_IO@IPLIFECH';
   LDCIPLI_.tbEntityAttributeName(90046645) := 'LDC_IPLI_IO@IPLIHORA';
   LDCIPLI_.tbEntityAttributeName(90046646) := 'LDC_IPLI_IO@IPLIDIRE';
   LDCIPLI_.tbEntityAttributeName(90046647) := 'LDC_IPLI_IO@IPLIBARR';
   LDCIPLI_.tbEntityAttributeName(90046648) := 'LDC_IPLI_IO@IPLIESTA';
   LDCIPLI_.tbEntityAttributeName(90046649) := 'LDC_IPLI_IO@IPLILOCA';
   LDCIPLI_.tbEntityAttributeName(90046650) := 'LDC_IPLI_IO@IPLICONCE';
   LDCIPLI_.tbEntityAttributeName(90046651) := 'LDC_IPLI_IO@IPLIPRES';
   LDCIPLI_.tbEntityAttributeName(90046652) := 'LDC_IPLI_IO@IPLITIOD';
   LDCIPLI_.tbEntityAttributeName(90046653) := 'LDC_IPLI_IO@IPLIMETO';
   LDCIPLI_.tbEntityAttributeName(90046654) := 'LDC_IPLI_IO@IPLIREGU';
   LDCIPLI_.tbEntityAttributeName(90046655) := 'LDC_IPLI_IO@IPLILECT';
   LDCIPLI_.tbEntityAttributeName(90046656) := 'LDC_IPLI_IO@ORDER_ID';
   LDCIPLI_.tbEntityAttributeName(90046657) := 'LDC_IPLI_IO@FLAG';
   LDCIPLI_.tbEntityAttributeName(90046680) := 'LDC_IPLI_IO@UNIT_OPER';
   LDCIPLI_.tbEntityAttributeName(90046659) := 'LDC_IPLI_IO@IPLIFECC';
   LDCIPLI_.tbEntityAttributeName(90046660) := 'LDC_IPLI_IO@IPLIUSUC';
 
END; 
/

BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI');

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI') AND ROLE_ID=1;

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI');

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI');

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI'));

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCIPLI');

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCIPLI';

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.old_tb0_0(0):='LDCIPLI'
;
LDCIPLI_.tb0_0(0):=UPPER(LDCIPLI_.old_tb0_0(0));
LDCIPLI_.old_tb0_1(0):=500000000002732;
LDCIPLI_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCIPLI_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCIPLI_.tb0_1(0):=LDCIPLI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCIPLI_.tb0_0(0),
LDCIPLI_.tb0_1(0),
'Registro Indice de Presión y/o Odorización'
,
null,
'29.1'
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
1280,
null,
to_date('24-08-2016 08:15:30','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb1_0(0):=1;
LDCIPLI_.tb1_1(0):=LDCIPLI_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCIPLI_.tb1_0(0),
LDCIPLI_.tb1_1(0));

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb2_0(0):=LDCIPLI_.tb0_1(0);
LDCIPLI_.old_tb2_1(0):=8876;
LDCIPLI_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYNAME(LDCIPLI_.old_tb2_1(0)), 'ENTITY');
LDCIPLI_.tb2_1(0):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb2_2(0):=null;
LDCIPLI_.tb2_2(0):=CASE WHEN (LDCIPLI_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYNAME(LDCIPLI_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDCIPLI_.tb2_0(0),
LDCIPLI_.tb2_1(0),
LDCIPLI_.tb2_2(0),
'G'
,
0,
0,
null,
' LDC_IPLI_IO.FLAG IS NULL'
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(0):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(0):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(0):=90046642;
LDCIPLI_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(0)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(0):=LDCIPLI_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(0),
LDCIPLI_.tb3_1(0),
LDCIPLI_.tb3_2(0),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(1):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(1):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(1):=90046643;
LDCIPLI_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(1)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(1):=LDCIPLI_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(1),
LDCIPLI_.tb3_1(1),
LDCIPLI_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  EMSSCOEM "CODIGO" , ADDRESS_PARSED "DESCRIPCION"  FROM VW_MEDIDORES  WHERE EMSSCOEM  = [IPLIMEDE]'
,
'H'
,
'CODIGO'
,
'DESCRIPCION'
,
'EMSSCOEM CODIGO|ADDRESS_PARSED DESCRIPCION|'
,
'FROM VW_MEDIDORES|'
,
'WHERE EMSSCOEM  = IPLIMEDE|'
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(2):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(2):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(2):=90046644;
LDCIPLI_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(2)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(2):=LDCIPLI_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(2),
LDCIPLI_.tb3_1(2),
LDCIPLI_.tb3_2(2),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(3):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(3):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(3):=90046645;
LDCIPLI_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(3)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(3):=LDCIPLI_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(3),
LDCIPLI_.tb3_1(3),
LDCIPLI_.tb3_2(3),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(4):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(4):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(4):=90046646;
LDCIPLI_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(4)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(4):=LDCIPLI_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(4),
LDCIPLI_.tb3_1(4),
LDCIPLI_.tb3_2(4),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(5):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(5):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(5):=90046647;
LDCIPLI_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(5)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(5):=LDCIPLI_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(5),
LDCIPLI_.tb3_1(5),
LDCIPLI_.tb3_2(5),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(6):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(6):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(6):=90046648;
LDCIPLI_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(6)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(6):=LDCIPLI_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(6),
LDCIPLI_.tb3_1(6),
LDCIPLI_.tb3_2(6),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(7):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(7):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(7):=90046649;
LDCIPLI_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(7)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(7):=LDCIPLI_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(7),
LDCIPLI_.tb3_1(7),
LDCIPLI_.tb3_2(7),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(8):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(8):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(8):=90046650;
LDCIPLI_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(8)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(8):=LDCIPLI_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(8),
LDCIPLI_.tb3_1(8),
LDCIPLI_.tb3_2(8),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(9):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(9):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(9):=90046651;
LDCIPLI_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(9)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(9):=LDCIPLI_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(9),
LDCIPLI_.tb3_1(9),
LDCIPLI_.tb3_2(9),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(10):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(10):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(10):=90046652;
LDCIPLI_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(10)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(10):=LDCIPLI_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(10),
LDCIPLI_.tb3_1(10),
LDCIPLI_.tb3_2(10),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(11):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(11):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(11):=90046653;
LDCIPLI_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(11)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(11):=LDCIPLI_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(11),
LDCIPLI_.tb3_1(11),
LDCIPLI_.tb3_2(11),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(12):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(12):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(12):=90046654;
LDCIPLI_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(12)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(12):=LDCIPLI_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(12),
LDCIPLI_.tb3_1(12),
LDCIPLI_.tb3_2(12),
12,
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(13):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(13):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(13):=90046655;
LDCIPLI_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(13)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(13):=LDCIPLI_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(13),
LDCIPLI_.tb3_1(13),
LDCIPLI_.tb3_2(13),
13,
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(14):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(14):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(14):=90046656;
LDCIPLI_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(14)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(14):=LDCIPLI_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(14),
LDCIPLI_.tb3_1(14),
LDCIPLI_.tb3_2(14),
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(15):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(15):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(15):=90046657;
LDCIPLI_.tb3_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(15)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(15):=LDCIPLI_.tb3_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(15),
LDCIPLI_.tb3_1(15),
LDCIPLI_.tb3_2(15),
15,
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(16):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(16):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(16):=90046659;
LDCIPLI_.tb3_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(16)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(16):=LDCIPLI_.tb3_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(16),
LDCIPLI_.tb3_1(16),
LDCIPLI_.tb3_2(16),
17,
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(17):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(17):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(17):=90046660;
LDCIPLI_.tb3_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(17)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(17):=LDCIPLI_.tb3_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(17),
LDCIPLI_.tb3_1(17),
LDCIPLI_.tb3_2(17),
18,
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
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;

LDCIPLI_.tb3_0(18):=LDCIPLI_.tb2_0(0);
LDCIPLI_.tb3_1(18):=LDCIPLI_.tb2_1(0);
LDCIPLI_.old_tb3_2(18):=90046680;
LDCIPLI_.tb3_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDCIPLI_.TBENTITYATTRIBUTENAME(LDCIPLI_.old_tb3_2(18)), 'ATTRIBUTE');
LDCIPLI_.tb3_2(18):=LDCIPLI_.tb3_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDCIPLI_.tb3_0(18),
LDCIPLI_.tb3_1(18),
LDCIPLI_.tb3_2(18),
16,
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
LDCIPLI_.blProcessStatus := false;
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
 nuIndexInternal := LDCIPLI_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCIPLI_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCIPLI_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCIPLI_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCIPLI_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCIPLI_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCIPLI_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCIPLI_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCIPLI_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCIPLI_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCIPLI_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCIPLI_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCIPLI_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCIPLI_.tbUserException(nuIndex).user_id, LDCIPLI_.tbUserException(nuIndex).status , LDCIPLI_.tbUserException(nuIndex).usr_exc_type_id, LDCIPLI_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCIPLI_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCIPLI_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCIPLI_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCIPLI_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCIPLI_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCIPLI_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCIPLI_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCIPLI_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCIPLI_******************************'); end;
/

