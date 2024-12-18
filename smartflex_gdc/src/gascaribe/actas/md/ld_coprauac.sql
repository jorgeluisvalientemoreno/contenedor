BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LD_COPRAUAC_',
'CREATE OR REPLACE PACKAGE LD_COPRAUAC_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LD_COPRAUAC''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LD_COPRAUAC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LD_COPRAUAC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LD_COPRAUAC'' ' || chr(10) ||
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
'END LD_COPRAUAC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LD_COPRAUAC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
Open LD_COPRAUAC_.cuRoleExecutables;
loop
 fetch LD_COPRAUAC_.cuRoleExecutables INTO LD_COPRAUAC_.rcRoleExecutables;
 exit when  LD_COPRAUAC_.cuRoleExecutables%notfound;
 LD_COPRAUAC_.tbRoleExecutables(nuIndex) := LD_COPRAUAC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LD_COPRAUAC_.cuRoleExecutables;
nuIndex := 0;
Open LD_COPRAUAC_.cuUserExceptions ;
loop
 fetch LD_COPRAUAC_.cuUserExceptions INTO  LD_COPRAUAC_.rcUserExceptions;
 exit when LD_COPRAUAC_.cuUserExceptions%notfound;
 LD_COPRAUAC_.tbUserException(nuIndex):=LD_COPRAUAC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LD_COPRAUAC_.cuUserExceptions;
nuIndex := 0;
Open LD_COPRAUAC_.cuExecEntities ;
loop
 fetch LD_COPRAUAC_.cuExecEntities INTO  LD_COPRAUAC_.rcExecEntities;
 exit when LD_COPRAUAC_.cuExecEntities%notfound;
 LD_COPRAUAC_.tbExecEntities(nuIndex):=LD_COPRAUAC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LD_COPRAUAC_.cuExecEntities;

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC'
);

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LD_COPRAUAC_.tbEntityName(5980) := 'LDC_COPRAUAC';
   LD_COPRAUAC_.tbEntityAttributeName(90197625) := 'LDC_COPRAUAC@COPAIDCP';
   LD_COPRAUAC_.tbEntityAttributeName(90197626) := 'LDC_COPRAUAC@COPAIDCT';
   LD_COPRAUAC_.tbEntityAttributeName(90197627) := 'LDC_COPRAUAC@COPATICO';
   LD_COPRAUAC_.tbEntityAttributeName(90197628) := 'LDC_COPRAUAC@COPAFECO';
   LD_COPRAUAC_.tbEntityAttributeName(90197629) := 'LDC_COPRAUAC@COPABAAD';
   LD_COPRAUAC_.tbEntityAttributeName(90197630) := 'LDC_COPRAUAC@COPAFEPR';
   LD_COPRAUAC_.tbEntityAttributeName(90197631) := 'LDC_COPRAUAC@COPAFEGA';
   LD_COPRAUAC_.tbEntityAttributeName(90197632) := 'LDC_COPRAUAC@COPAESTA';
   LD_COPRAUAC_.tbEntityAttributeName(90197633) := 'LDC_COPRAUAC@COPARESU';
   LD_COPRAUAC_.tbEntityAttributeName(90197634) := 'LDC_COPRAUAC@COPACOEL';
   LD_COPRAUAC_.tbEntityAttributeName(90197635) := 'LDC_COPRAUAC@COPACOIN';
   LD_COPRAUAC_.tbEntityAttributeName(90197636) := 'LDC_COPRAUAC@COPACOCO';
   LD_COPRAUAC_.tbEntityAttributeName(90197638) := 'LDC_COPRAUAC@COPAFCON';
   LD_COPRAUAC_.tbEntityAttributeName(90197637) := 'LDC_COPRAUAC@COPAUSER';
   LD_COPRAUAC_.tbEntityAttributeName(90197639) := 'LDC_COPRAUAC@COPATERM';
 
END; 
/

BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC');

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC') AND ROLE_ID=1;

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC');

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC');

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC'));

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC');

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LD_COPRAUAC';

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.old_tb0_0(0):='LD_COPRAUAC'
;
LD_COPRAUAC_.tb0_0(0):=UPPER(LD_COPRAUAC_.old_tb0_0(0));
LD_COPRAUAC_.old_tb0_1(0):=500000000015540;
LD_COPRAUAC_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LD_COPRAUAC_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LD_COPRAUAC_.tb0_1(0):=LD_COPRAUAC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LD_COPRAUAC_.tb0_0(0),
LD_COPRAUAC_.tb0_1(0),
'Configuración del proceso de automatización de actas'
,
null,
'6'
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
67,
null,
to_date('09-09-2022 15:43:07','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb1_0(0):=1;
LD_COPRAUAC_.tb1_1(0):=LD_COPRAUAC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LD_COPRAUAC_.tb1_0(0),
LD_COPRAUAC_.tb1_1(0));

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb2_0(0):=LD_COPRAUAC_.tb0_1(0);
LD_COPRAUAC_.old_tb2_1(0):=5980;
LD_COPRAUAC_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYNAME(LD_COPRAUAC_.old_tb2_1(0)), 'ENTITY');
LD_COPRAUAC_.tb2_1(0):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb2_2(0):=null;
LD_COPRAUAC_.tb2_2(0):=CASE WHEN (LD_COPRAUAC_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYNAME(LD_COPRAUAC_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LD_COPRAUAC_.tb2_0(0),
LD_COPRAUAC_.tb2_1(0),
LD_COPRAUAC_.tb2_2(0),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(0):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(0):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(0):=90197625;
LD_COPRAUAC_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(0)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(0):=LD_COPRAUAC_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(0),
LD_COPRAUAC_.tb3_1(0),
LD_COPRAUAC_.tb3_2(0),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(1):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(1):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(1):=90197626;
LD_COPRAUAC_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(1)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(1):=LD_COPRAUAC_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(1),
LD_COPRAUAC_.tb3_1(1),
LD_COPRAUAC_.tb3_2(1),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  ID_CONTRATISTA "CÓDIGO" , DESCRIPCION "DESCRIPCIÓN"  FROM GE_CONTRATISTA WHERE ID_CONTRATISTA IN (SELECT UNIQUE GE_CONTRATO.ID_CONTRATISTA FROM GE_CONTRATISTA ,GE_CONTRATO WHERE GE_CONTRATISTA.ID_CONTRATISTA = GE_CONTRATO.ID_CONTRATISTA AND GE_CONTRATO.STATUS = '|| chr(39) ||'AB'|| chr(39) ||') UNION ALL  SELECT IDENT_TYPE_ID "CÓDIGO" , '|| chr(39) ||'TODOS'|| chr(39) ||' "DESCRIPCIÓN" FROM GE_IDENTIFICA_TYPE WHERE IDENT_TYPE_ID = -1  ORDER BY 1  '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'ID_CONTRATISTA Código|DESCRIPCION Descripción|'
,
'FROM GE_CONTRATISTA|'
,
'WHERE ID_CONTRATISTA IN (SELECT UNIQUE GE_CONTRATO.ID_CONTRATISTA FROM GE_CONTRATISTA ,GE_CONTRATO WHERE GE_CONTRATISTA.ID_CONTRATISTA = GE_CONTRATO.ID_CONTRATISTA AND GE_CONTRATO.STATUS = '|| chr(39) ||'AB'|| chr(39) ||')|UNION ALL |SELECT IDENT_TYPE_ID "CÓDIGO" , '|| chr(39) ||'TODOS'|| chr(39) ||' "DESCRIPCIÓN" FROM GE_IDENTIFICA_TYPE WHERE IDENT_TYPE_ID = -1 |ORDER BY 1 |'
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(2):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(2):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(2):=90197627;
LD_COPRAUAC_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(2)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(2):=LD_COPRAUAC_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(2),
LD_COPRAUAC_.tb3_1(2),
LD_COPRAUAC_.tb3_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  ID_TIPO_CONTRATO "CÓDIGO" , DESCRIPCION "DESCRIPCIÓN"  FROM GE_TIPO_CONTRATO WHERE EXISTS (SELECT '|| chr(39) ||'X'|| chr(39) ||' FROM GE_CONTRATO WHERE GE_TIPO_CONTRATO.ID_TIPO_CONTRATO = GE_CONTRATO.ID_TIPO_CONTRATO AND GE_CONTRATO.STATUS = '|| chr(39) ||'AB'|| chr(39) ||') ORDER BY ID_TIPO_CONTRATO ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'ID_TIPO_CONTRATO Código|DESCRIPCION Descripción|'
,
'FROM GE_TIPO_CONTRATO|'
,
'WHERE EXISTS (SELECT '|| chr(39) ||'X'|| chr(39) ||' FROM GE_CONTRATO WHERE GE_TIPO_CONTRATO.ID_TIPO_CONTRATO = GE_CONTRATO.ID_TIPO_CONTRATO AND GE_CONTRATO.STATUS = '|| chr(39) ||'AB'|| chr(39) ||')|'
,
'ORDER BY ID_TIPO_CONTRATO ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(3):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(3):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(3):=90197628;
LD_COPRAUAC_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(3)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(3):=LD_COPRAUAC_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(3),
LD_COPRAUAC_.tb3_1(3),
LD_COPRAUAC_.tb3_2(3),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(4):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(4):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(4):=90197629;
LD_COPRAUAC_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(4)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(4):=LD_COPRAUAC_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(4),
LD_COPRAUAC_.tb3_1(4),
LD_COPRAUAC_.tb3_2(4),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  ID_BASE_ADMINISTRA "BASE ADMINISTRATIVA" , DESCRIPCION "DESCRIPCIÓN"  FROM GE_BASE_ADMINISTRA ORDER BY ID_BASE_ADMINISTRA ASC '
,
'N'
,
'BASE ADMINISTRATIVA'
,
'DESCRIPCIÓN'
,
'ID_BASE_ADMINISTRA BASE ADMINISTRATIVA|DESCRIPCION DESCRIPCIÓN|'
,
'FROM GE_BASE_ADMINISTRA|'
,
null,
'ORDER BY ID_BASE_ADMINISTRA ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(5):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(5):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(5):=90197630;
LD_COPRAUAC_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(5)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(5):=LD_COPRAUAC_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(5),
LD_COPRAUAC_.tb3_1(5),
LD_COPRAUAC_.tb3_2(5),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(6):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(6):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(6):=90197631;
LD_COPRAUAC_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(6)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(6):=LD_COPRAUAC_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(6),
LD_COPRAUAC_.tb3_1(6),
LD_COPRAUAC_.tb3_2(6),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(7):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(7):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(7):=90197632;
LD_COPRAUAC_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(7)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(7):=LD_COPRAUAC_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(7),
LD_COPRAUAC_.tb3_1(7),
LD_COPRAUAC_.tb3_2(7),
7,
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(8):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(8):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(8):=90197633;
LD_COPRAUAC_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(8)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(8):=LD_COPRAUAC_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(8),
LD_COPRAUAC_.tb3_1(8),
LD_COPRAUAC_.tb3_2(8),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(9):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(9):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(9):=90197634;
LD_COPRAUAC_.tb3_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(9)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(9):=LD_COPRAUAC_.tb3_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(9),
LD_COPRAUAC_.tb3_1(9),
LD_COPRAUAC_.tb3_2(9),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(10):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(10):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(10):=90197635;
LD_COPRAUAC_.tb3_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(10)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(10):=LD_COPRAUAC_.tb3_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(10),
LD_COPRAUAC_.tb3_1(10),
LD_COPRAUAC_.tb3_2(10),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(11):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(11):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(11):=90197636;
LD_COPRAUAC_.tb3_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(11)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(11):=LD_COPRAUAC_.tb3_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(11),
LD_COPRAUAC_.tb3_1(11),
LD_COPRAUAC_.tb3_2(11),
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(12):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(12):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(12):=90197637;
LD_COPRAUAC_.tb3_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(12)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(12):=LD_COPRAUAC_.tb3_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(12),
LD_COPRAUAC_.tb3_1(12),
LD_COPRAUAC_.tb3_2(12),
13,
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(13):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(13):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(13):=90197638;
LD_COPRAUAC_.tb3_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(13)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(13):=LD_COPRAUAC_.tb3_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(13),
LD_COPRAUAC_.tb3_1(13),
LD_COPRAUAC_.tb3_2(13),
12,
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
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;

LD_COPRAUAC_.tb3_0(14):=LD_COPRAUAC_.tb2_0(0);
LD_COPRAUAC_.tb3_1(14):=LD_COPRAUAC_.tb2_1(0);
LD_COPRAUAC_.old_tb3_2(14):=90197639;
LD_COPRAUAC_.tb3_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LD_COPRAUAC_.TBENTITYATTRIBUTENAME(LD_COPRAUAC_.old_tb3_2(14)), 'ATTRIBUTE');
LD_COPRAUAC_.tb3_2(14):=LD_COPRAUAC_.tb3_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LD_COPRAUAC_.tb3_0(14),
LD_COPRAUAC_.tb3_1(14),
LD_COPRAUAC_.tb3_2(14),
14,
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
LD_COPRAUAC_.blProcessStatus := false;
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
 nuIndexInternal := LD_COPRAUAC_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LD_COPRAUAC_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LD_COPRAUAC_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LD_COPRAUAC_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LD_COPRAUAC_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LD_COPRAUAC_.blProcessStatus) then
 return;
end if;
nuIndex :=  LD_COPRAUAC_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LD_COPRAUAC_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LD_COPRAUAC_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LD_COPRAUAC_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LD_COPRAUAC_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LD_COPRAUAC_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LD_COPRAUAC_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LD_COPRAUAC_.tbUserException(nuIndex).user_id, LD_COPRAUAC_.tbUserException(nuIndex).status , LD_COPRAUAC_.tbUserException(nuIndex).usr_exc_type_id, LD_COPRAUAC_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LD_COPRAUAC_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LD_COPRAUAC_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LD_COPRAUAC_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LD_COPRAUAC_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LD_COPRAUAC_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LD_COPRAUAC_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LD_COPRAUAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LD_COPRAUAC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LD_COPRAUAC_******************************'); end;
/

