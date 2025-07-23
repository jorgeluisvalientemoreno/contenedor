BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('PCFO_',
'CREATE OR REPLACE PACKAGE PCFO_ IS ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''PCFO''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''PCFO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''PCFO'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''PCFO'' ' || chr(10) ||
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
'END PCFO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:PCFO_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
Open PCFO_.cuRoleExecutables;
loop
 fetch PCFO_.cuRoleExecutables INTO PCFO_.rcRoleExecutables;
 exit when  PCFO_.cuRoleExecutables%notfound;
 PCFO_.tbRoleExecutables(nuIndex) := PCFO_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close PCFO_.cuRoleExecutables;
nuIndex := 0;
Open PCFO_.cuUserExceptions ;
loop
 fetch PCFO_.cuUserExceptions INTO  PCFO_.rcUserExceptions;
 exit when PCFO_.cuUserExceptions%notfound;
 PCFO_.tbUserException(nuIndex):=PCFO_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close PCFO_.cuUserExceptions;
nuIndex := 0;
Open PCFO_.cuExecEntities ;
loop
 fetch PCFO_.cuExecEntities INTO  PCFO_.rcExecEntities;
 exit when PCFO_.cuExecEntities%notfound;
 PCFO_.tbExecEntities(nuIndex):=PCFO_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close PCFO_.cuExecEntities;

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO'
);

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   PCFO_.tbEntityName(8627) := 'LDC_FINAN_COND';
   PCFO_.tbEntityAttributeName(90028298) := 'LDC_FINAN_COND@REC_FINAN_COND_ID';
   PCFO_.tbEntityAttributeName(90028299) := 'LDC_FINAN_COND@RECO_ACTIVITY';
   PCFO_.tbEntityAttributeName(90028300) := 'LDC_FINAN_COND@GEO_LOCATION_ID';
   PCFO_.tbEntityAttributeName(90028301) := 'LDC_FINAN_COND@CATEGORY_ID';
   PCFO_.tbEntityAttributeName(90028302) := 'LDC_FINAN_COND@SUBCATEGORY_ID';
   PCFO_.tbEntityAttributeName(90028303) := 'LDC_FINAN_COND@MIN_VALUE';
   PCFO_.tbEntityAttributeName(90028304) := 'LDC_FINAN_COND@MAX_VALUE';
   PCFO_.tbEntityAttributeName(90028305) := 'LDC_FINAN_COND@FINAN_PLAN_ID';
   PCFO_.tbEntityAttributeName(90028306) := 'LDC_FINAN_COND@QUOTAS_NUMBER';
 
END; 
/

BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO');

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO') AND ROLE_ID=1;

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO');

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO');

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO'));

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='PCFO');

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='PCFO';

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.old_tb0_0(0):='PCFO'
;
PCFO_.tb0_0(0):=UPPER(PCFO_.old_tb0_0(0));
PCFO_.old_tb0_1(0):=500000000001330;
PCFO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(PCFO_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
PCFO_.tb0_1(0):=PCFO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (PCFO_.tb0_0(0),
PCFO_.tb0_1(0),
'LDC - Parametrización Condiciones de Financiación de Ordenes'
,
null,
'60.1'
,
8,
2,
48,
1,
5947,
'Y'
,
null,
'N'
,
'Y'
,
33,
'C'
,
to_date('21-02-2025 17:21:23','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb1_0(0):=1;
PCFO_.tb1_1(0):=PCFO_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (PCFO_.tb1_0(0),
PCFO_.tb1_1(0));

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb2_0(0):=PCFO_.tb0_1(0);
PCFO_.old_tb2_1(0):=8627;
PCFO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYNAME(PCFO_.old_tb2_1(0)), 'ENTITY');
PCFO_.tb2_1(0):=PCFO_.tb2_1(0);
PCFO_.old_tb2_2(0):=null;
PCFO_.tb2_2(0):=CASE WHEN (PCFO_.old_tb2_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYNAME(PCFO_.old_tb2_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (PCFO_.tb2_0(0),
PCFO_.tb2_1(0),
PCFO_.tb2_2(0),
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
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(0):=PCFO_.tb2_0(0);
PCFO_.tb3_1(0):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(0):=90028298;
PCFO_.tb3_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(0)), 'ATTRIBUTE');
PCFO_.tb3_2(0):=PCFO_.tb3_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(0),
PCFO_.tb3_1(0),
PCFO_.tb3_2(0),
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
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(1):=PCFO_.tb2_0(0);
PCFO_.tb3_1(1):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(1):=90028299;
PCFO_.tb3_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(1)), 'ATTRIBUTE');
PCFO_.tb3_2(1):=PCFO_.tb3_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(1),
PCFO_.tb3_1(1),
PCFO_.tb3_2(1),
1,
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
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(2):=PCFO_.tb2_0(0);
PCFO_.tb3_1(2):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(2):=90028300;
PCFO_.tb3_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(2)), 'ATTRIBUTE');
PCFO_.tb3_2(2):=PCFO_.tb3_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(2),
PCFO_.tb3_1(2),
PCFO_.tb3_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT GEOGRAP_LOCATION_ID "Código",DESCRIPTION "Descripción",GEO_LOCA_FATHER_ID "Padre" FROM GE_GEOGRA_LOCATION'
,
'T'
,
'Código'
,
'Descripción'
,
'GEOGRAP_LOCATION_ID Código|DESCRIPTION Descripción|GEO_LOCA_FATHER_ID Padre|'
,
'FROM GE_GEOGRA_LOCATION'
,
null,
null,
'Padre'
,
'U'
,
null,
null,
null,
null);

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(3):=PCFO_.tb2_0(0);
PCFO_.tb3_1(3):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(3):=90028301;
PCFO_.tb3_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(3)), 'ATTRIBUTE');
PCFO_.tb3_2(3):=PCFO_.tb3_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(3),
PCFO_.tb3_1(3),
PCFO_.tb3_2(3),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  CATECODI "CODIGO DE LA CATEGORIA" , CATEDESC "DESCRIPCION DE LA CATEGORIA"  FROM CATEGORI ORDER BY CATECODI ASC '
,
'N'
,
'CODIGO DE LA CATEGORIA'
,
'DESCRIPCION DE LA CATEGORIA'
,
'CATECODI Codigo de la categoria|CATEDESC Descripcion de la categoria|'
,
'FROM CATEGORI|'
,
null,
'ORDER BY CATECODI ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(4):=PCFO_.tb2_0(0);
PCFO_.tb3_1(4):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(4):=90028302;
PCFO_.tb3_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(4)), 'ATTRIBUTE');
PCFO_.tb3_2(4):=PCFO_.tb3_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(4),
PCFO_.tb3_1(4),
PCFO_.tb3_2(4),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  SUCACODI "SUBCATEGORÍA" , SUCADESC "DESCRIPCIÓN"  FROM VW_SUBCATEGORIA_PCFO WHERE SUCACATE = [CATEGORY_ID] ORDER BY SUCACODI ASC '
,
'N'
,
'SUBCATEGORÍA'
,
'DESCRIPCIÓN'
,
'SUCACODI SubCategoría|SUCADESC Descripción|'
,
'FROM VW_SUBCATEGORIA_PCFO|'
,
'WHERE SUCACATE = CATEGORY_ID|'
,
'ORDER BY SUCACODI ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(5):=PCFO_.tb2_0(0);
PCFO_.tb3_1(5):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(5):=90028303;
PCFO_.tb3_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(5)), 'ATTRIBUTE');
PCFO_.tb3_2(5):=PCFO_.tb3_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(5),
PCFO_.tb3_1(5),
PCFO_.tb3_2(5),
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
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(6):=PCFO_.tb2_0(0);
PCFO_.tb3_1(6):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(6):=90028304;
PCFO_.tb3_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(6)), 'ATTRIBUTE');
PCFO_.tb3_2(6):=PCFO_.tb3_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(6),
PCFO_.tb3_1(6),
PCFO_.tb3_2(6),
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
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(7):=PCFO_.tb2_0(0);
PCFO_.tb3_1(7):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(7):=90028305;
PCFO_.tb3_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(7)), 'ATTRIBUTE');
PCFO_.tb3_2(7):=PCFO_.tb3_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(7),
PCFO_.tb3_1(7),
PCFO_.tb3_2(7),
7,
'Y'
,
'Y'
,
'N'
,
'SELECT PLDICODI "CÓDIGO",PLDIDESC "DESCRIPCIÓN" FROM PLANDIFE'
,
'N'
,
'Código'
,
'Descripción'
,
'PLDICODI Código|PLDIDESC Descripción|'
,
'FROM PLANDIFE'
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
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;

PCFO_.tb3_0(8):=PCFO_.tb2_0(0);
PCFO_.tb3_1(8):=PCFO_.tb2_1(0);
PCFO_.old_tb3_2(8):=90028306;
PCFO_.tb3_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(PCFO_.TBENTITYATTRIBUTENAME(PCFO_.old_tb3_2(8)), 'ATTRIBUTE');
PCFO_.tb3_2(8):=PCFO_.tb3_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (PCFO_.tb3_0(8),
PCFO_.tb3_1(8),
PCFO_.tb3_2(8),
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
PCFO_.blProcessStatus := false;
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
 nuIndexInternal := PCFO_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (PCFO_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (PCFO_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := PCFO_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := PCFO_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not PCFO_.blProcessStatus) then
 return;
end if;
nuIndex :=  PCFO_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (PCFO_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(PCFO_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (PCFO_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := PCFO_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  PCFO_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(PCFO_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,PCFO_.tbUserException(nuIndex).user_id, PCFO_.tbUserException(nuIndex).status , PCFO_.tbUserException(nuIndex).usr_exc_type_id, PCFO_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := PCFO_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  PCFO_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(PCFO_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = PCFO_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,PCFO_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := PCFO_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
PCFO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('PCFO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:PCFO_******************************'); end;
/

