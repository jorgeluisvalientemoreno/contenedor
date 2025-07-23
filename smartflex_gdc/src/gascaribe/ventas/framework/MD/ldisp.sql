BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDISP_',
'CREATE OR REPLACE PACKAGE LDISP_ IS ' || chr(10) ||
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
'tb0_1 ty0_1;type ty1_0 is table of SA_ENT_ROLE_EXEC.ENT_ROLE_EXEC_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of SA_ENT_ROLE_EXEC.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of SA_MENU_OPTION.MENU_OPTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of SA_MENU_OPTION.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of GI_ENTITY_DISP_DATA.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GI_ENTITY_DISP_DATA.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of GI_ENTITY_DISP_DATA.PARENT_ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty5_0 is table of GI_ATTRIB_DISP_DATA.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of GI_ATTRIB_DISP_DATA.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of GI_ATTRIB_DISP_DATA.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2; ' || chr(10) ||
'  executableName ge_catalog.tag_name%type := ''LDISP''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDISP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDISP'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDISP'' ' || chr(10) ||
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
'END LDISP_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDISP_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
Open LDISP_.cuRoleExecutables;
loop
 fetch LDISP_.cuRoleExecutables INTO LDISP_.rcRoleExecutables;
 exit when  LDISP_.cuRoleExecutables%notfound;
 LDISP_.tbRoleExecutables(nuIndex) := LDISP_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDISP_.cuRoleExecutables;
nuIndex := 0;
Open LDISP_.cuUserExceptions ;
loop
 fetch LDISP_.cuUserExceptions INTO  LDISP_.rcUserExceptions;
 exit when LDISP_.cuUserExceptions%notfound;
 LDISP_.tbUserException(nuIndex):=LDISP_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDISP_.cuUserExceptions;
nuIndex := 0;
Open LDISP_.cuExecEntities ;
loop
 fetch LDISP_.cuExecEntities INTO  LDISP_.rcExecEntities;
 exit when LDISP_.cuExecEntities%notfound;
 LDISP_.tbExecEntities(nuIndex):=LDISP_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDISP_.cuExecEntities;

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN 
   LDISP_.tbEntityName(8014) := 'LD_SUBSIDY';
   LDISP_.tbEntityAttributeName(90009722) := 'LD_SUBSIDY@SUBSIDY_ID';
   LDISP_.tbEntityAttributeName(90009723) := 'LD_SUBSIDY@DESCRIPTION';
   LDISP_.tbEntityAttributeName(90009724) := 'LD_SUBSIDY@DEAL_ID';
   LDISP_.tbEntityAttributeName(90009725) := 'LD_SUBSIDY@INITIAL_DATE';
   LDISP_.tbEntityAttributeName(90009726) := 'LD_SUBSIDY@FINAL_DATE';
   LDISP_.tbEntityAttributeName(90009727) := 'LD_SUBSIDY@STAR_COLLECT_DATE';
   LDISP_.tbEntityAttributeName(90009728) := 'LD_SUBSIDY@CONCCODI';
   LDISP_.tbEntityAttributeName(90009729) := 'LD_SUBSIDY@VALIDITY_YEAR_MEANS';
   LDISP_.tbEntityAttributeName(90009750) := 'LD_SUBSIDY@AUTHORIZE_QUANTITY';
   LDISP_.tbEntityAttributeName(90009751) := 'LD_SUBSIDY@AUTHORIZE_VALUE';
   LDISP_.tbEntityAttributeName(90009752) := 'LD_SUBSIDY@REMAINDER_STATUS';
   LDISP_.tbEntityAttributeName(90009753) := 'LD_SUBSIDY@TOTAL_DELIVER';
   LDISP_.tbEntityAttributeName(90009754) := 'LD_SUBSIDY@TOTAL_AVAILABLE';
   LDISP_.tbEntityAttributeName(90009755) := 'LD_SUBSIDY@PROMOTION_ID';
   LDISP_.tbEntityAttributeName(90009756) := 'LD_SUBSIDY@ORIGIN_SUBSIDY';
 
   LDISP_.tbEntityName(8015) := 'LD_UBICATION';
   LDISP_.tbEntityAttributeName(90009757) := 'LD_UBICATION@UBICATION_ID';
   LDISP_.tbEntityAttributeName(90009758) := 'LD_UBICATION@SUBSIDY_ID';
   LDISP_.tbEntityAttributeName(90009759) := 'LD_UBICATION@GEOGRA_LOCATION_ID';
   LDISP_.tbEntityAttributeName(90009760) := 'LD_UBICATION@SUCACATE';
   LDISP_.tbEntityAttributeName(90009761) := 'LD_UBICATION@SUCACODI';
   LDISP_.tbEntityAttributeName(90009762) := 'LD_UBICATION@AUTHORIZE_QUANTITY';
   LDISP_.tbEntityAttributeName(90009763) := 'LD_UBICATION@AUTHORIZE_VALUE';
   LDISP_.tbEntityAttributeName(90009764) := 'LD_UBICATION@TOTAL_DELIVER';
   LDISP_.tbEntityAttributeName(90009765) := 'LD_UBICATION@TOTAL_AVAILABLE';
 
   LDISP_.tbEntityName(8016) := 'LD_SUBSIDY_DETAIL';
   LDISP_.tbEntityAttributeName(90009770) := 'LD_SUBSIDY_DETAIL@SUBSIDY_DETAIL_ID';
   LDISP_.tbEntityAttributeName(90009766) := 'LD_SUBSIDY_DETAIL@CONCCODI';
   LDISP_.tbEntityAttributeName(90009767) := 'LD_SUBSIDY_DETAIL@SUBSIDY_PERCENTAGE';
   LDISP_.tbEntityAttributeName(90009768) := 'LD_SUBSIDY_DETAIL@SUBSIDY_VALUE';
   LDISP_.tbEntityAttributeName(90009769) := 'LD_SUBSIDY_DETAIL@UBICATION_ID';
 
   LDISP_.tbEntityName(8017) := 'LD_MAX_RECOVERY';
   LDISP_.tbEntityAttributeName(90009771) := 'LD_MAX_RECOVERY@MAX_RECOVERY_ID';
   LDISP_.tbEntityAttributeName(90009772) := 'LD_MAX_RECOVERY@YEAR';
   LDISP_.tbEntityAttributeName(90009773) := 'LD_MAX_RECOVERY@MONTH';
   LDISP_.tbEntityAttributeName(90009774) := 'LD_MAX_RECOVERY@TOTAL_SUB_RECOVERY';
   LDISP_.tbEntityAttributeName(90009775) := 'LD_MAX_RECOVERY@RECOVERY_VALUE';
   LDISP_.tbEntityAttributeName(90009776) := 'LD_MAX_RECOVERY@UBICATION_ID';
 
END; 
/

BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ENT_ROLE_EXEC',1);
  DELETE FROM SA_ENT_ROLE_EXEC WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP');

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP') AND ROLE_ID=1;

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP');

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP');

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ATTRIB_DISP_DATA',1);
  DELETE FROM GI_ATTRIB_DISP_DATA WHERE (EXECUTABLE_ID,ENTITY_ID) in (SELECT EXECUTABLE_ID,ENTITY_ID FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP'));

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_DISP_DATA',1);
  DELETE FROM GI_ENTITY_DISP_DATA WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDISP');

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDISP';

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.old_tb0_0(0):='LDISP'
;
LDISP_.tb0_0(0):=UPPER(LDISP_.old_tb0_0(0));
LDISP_.old_tb0_1(0):=500000000000038;
LDISP_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDISP_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDISP_.tb0_1(0):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDISP_.tb0_0(0),
LDISP_.tb0_1(0),
'Parametrización individual de subsidios'
,
null,
'53'
,
8,
2,
16,
1,
1345,
'Y'
,
null,
'N'
,
'Y'
,
309,
'C'
,
to_date('08-05-2025 17:15:30','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(0):=786;
LDISP_.tb1_1(0):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (0)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(0),
LDISP_.tb1_1(0),
3811,
8014,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(1):=787;
LDISP_.tb1_1(1):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (1)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(1),
LDISP_.tb1_1(1),
3811,
8014,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(2):=788;
LDISP_.tb1_1(2):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (2)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(2),
LDISP_.tb1_1(2),
3811,
8014,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(3):=789;
LDISP_.tb1_1(3):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (3)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(3),
LDISP_.tb1_1(3),
3811,
8015,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(4):=790;
LDISP_.tb1_1(4):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (4)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(4),
LDISP_.tb1_1(4),
3811,
8015,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(5):=791;
LDISP_.tb1_1(5):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (5)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(5),
LDISP_.tb1_1(5),
3811,
8015,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(6):=792;
LDISP_.tb1_1(6):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (6)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(6),
LDISP_.tb1_1(6),
3811,
8016,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(7):=793;
LDISP_.tb1_1(7):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (7)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(7),
LDISP_.tb1_1(7),
3811,
8016,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(8):=794;
LDISP_.tb1_1(8):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (8)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(8),
LDISP_.tb1_1(8),
3811,
8016,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(9):=795;
LDISP_.tb1_1(9):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (9)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(9),
LDISP_.tb1_1(9),
3811,
8017,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(10):=796;
LDISP_.tb1_1(10):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (10)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(10),
LDISP_.tb1_1(10),
3811,
8017,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(11):=797;
LDISP_.tb1_1(11):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (11)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(11),
LDISP_.tb1_1(11),
3811,
8017,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(12):=743;
LDISP_.tb1_1(12):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (12)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(12),
LDISP_.tb1_1(12),
3814,
8014,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(13):=744;
LDISP_.tb1_1(13):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (13)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(13),
LDISP_.tb1_1(13),
3814,
8014,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(14):=745;
LDISP_.tb1_1(14):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (14)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(14),
LDISP_.tb1_1(14),
3814,
8014,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(15):=746;
LDISP_.tb1_1(15):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (15)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(15),
LDISP_.tb1_1(15),
3814,
8015,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(16):=747;
LDISP_.tb1_1(16):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (16)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(16),
LDISP_.tb1_1(16),
3814,
8015,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(17):=748;
LDISP_.tb1_1(17):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (17)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(17),
LDISP_.tb1_1(17),
3814,
8015,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(18):=749;
LDISP_.tb1_1(18):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (18)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(18),
LDISP_.tb1_1(18),
3814,
8016,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(19):=750;
LDISP_.tb1_1(19):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (19)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(19),
LDISP_.tb1_1(19),
3814,
8016,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(20):=751;
LDISP_.tb1_1(20):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (20)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(20),
LDISP_.tb1_1(20),
3814,
8016,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(21):=752;
LDISP_.tb1_1(21):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (21)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(21),
LDISP_.tb1_1(21),
3814,
8017,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(22):=753;
LDISP_.tb1_1(22):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (22)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(22),
LDISP_.tb1_1(22),
3814,
8017,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(23):=754;
LDISP_.tb1_1(23):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (23)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(23),
LDISP_.tb1_1(23),
3814,
8017,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(24):=765;
LDISP_.tb1_1(24):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (24)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(24),
LDISP_.tb1_1(24),
3654,
8014,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(25):=766;
LDISP_.tb1_1(25):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (25)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(25),
LDISP_.tb1_1(25),
3654,
8014,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(26):=767;
LDISP_.tb1_1(26):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (26)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(26),
LDISP_.tb1_1(26),
3654,
8014,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(27):=768;
LDISP_.tb1_1(27):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (27)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(27),
LDISP_.tb1_1(27),
3654,
8015,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(28):=769;
LDISP_.tb1_1(28):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (28)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(28),
LDISP_.tb1_1(28),
3654,
8015,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(29):=770;
LDISP_.tb1_1(29):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (29)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(29),
LDISP_.tb1_1(29),
3654,
8015,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(30):=771;
LDISP_.tb1_1(30):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (30)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(30),
LDISP_.tb1_1(30),
3654,
8016,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(31):=772;
LDISP_.tb1_1(31):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (31)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(31),
LDISP_.tb1_1(31),
3654,
8016,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(32):=773;
LDISP_.tb1_1(32):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (32)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(32),
LDISP_.tb1_1(32),
3654,
8016,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(33):=774;
LDISP_.tb1_1(33):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (33)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(33),
LDISP_.tb1_1(33),
3654,
8017,
'N'
,
'I'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(34):=775;
LDISP_.tb1_1(34):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (34)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(34),
LDISP_.tb1_1(34),
3654,
8017,
'N'
,
'D'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb1_0(35):=776;
LDISP_.tb1_1(35):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ENT_ROLE_EXEC fila (35)',1);
INSERT INTO SA_ENT_ROLE_EXEC(ENT_ROLE_EXEC_ID,EXECUTABLE_ID,ROLE_ID,ENTITY_ID,ENABLED,EXCEPTION_TYPE) 
VALUES (LDISP_.tb1_0(35),
LDISP_.tb1_1(35),
3654,
8017,
'N'
,
'U'
);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb2_0(0):=1;
LDISP_.tb2_1(0):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDISP_.tb2_0(0),
LDISP_.tb2_1(0));

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.old_tb3_0(0):=40009795;
LDISP_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
LDISP_.tb3_0(0):=LDISP_.tb3_0(0);
LDISP_.tb3_1(0):=LDISP_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (LDISP_.tb3_0(0),
LDISP_.tb3_1(0),
'LDISP'
,
'Parametrización individual de subsidios'
,
1,
1,
28,
58,
'FormExecutable'
,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb4_0(0):=LDISP_.tb0_1(0);
LDISP_.old_tb4_1(0):=8014;
LDISP_.tb4_1(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_1(0)), 'ENTITY');
LDISP_.tb4_1(0):=LDISP_.tb4_1(0);
LDISP_.old_tb4_2(0):=null;
LDISP_.tb4_2(0):=CASE WHEN (LDISP_.old_tb4_2(0) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_2(0)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (0)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDISP_.tb4_0(0),
LDISP_.tb4_1(0),
LDISP_.tb4_2(0),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(0):=LDISP_.tb4_0(0);
LDISP_.tb5_1(0):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(0):=90009722;
LDISP_.tb5_2(0):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(0)), 'ATTRIBUTE');
LDISP_.tb5_2(0):=LDISP_.tb5_2(0);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (0)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(0),
LDISP_.tb5_1(0),
LDISP_.tb5_2(0),
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
'A'
,
null,
1);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(1):=LDISP_.tb4_0(0);
LDISP_.tb5_1(1):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(1):=90009723;
LDISP_.tb5_2(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(1)), 'ATTRIBUTE');
LDISP_.tb5_2(1):=LDISP_.tb5_2(1);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (1)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(1),
LDISP_.tb5_1(1),
LDISP_.tb5_2(1),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(2):=LDISP_.tb4_0(0);
LDISP_.tb5_1(2):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(2):=90009724;
LDISP_.tb5_2(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(2)), 'ATTRIBUTE');
LDISP_.tb5_2(2):=LDISP_.tb5_2(2);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (2)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(2),
LDISP_.tb5_1(2),
LDISP_.tb5_2(2),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  DEAL_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM LD_DEAL ORDER BY DEAL_ID ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'DEAL_ID Código|DESCRIPTION Descripción|'
,
'FROM LD_DEAL|'
,
null,
'ORDER BY DEAL_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(3):=LDISP_.tb4_0(0);
LDISP_.tb5_1(3):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(3):=90009725;
LDISP_.tb5_2(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(3)), 'ATTRIBUTE');
LDISP_.tb5_2(3):=LDISP_.tb5_2(3);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (3)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(3),
LDISP_.tb5_1(3),
LDISP_.tb5_2(3),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(4):=LDISP_.tb4_0(0);
LDISP_.tb5_1(4):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(4):=90009726;
LDISP_.tb5_2(4):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(4)), 'ATTRIBUTE');
LDISP_.tb5_2(4):=LDISP_.tb5_2(4);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (4)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(4),
LDISP_.tb5_1(4),
LDISP_.tb5_2(4),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(5):=LDISP_.tb4_0(0);
LDISP_.tb5_1(5):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(5):=90009727;
LDISP_.tb5_2(5):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(5)), 'ATTRIBUTE');
LDISP_.tb5_2(5):=LDISP_.tb5_2(5);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (5)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(5),
LDISP_.tb5_1(5),
LDISP_.tb5_2(5),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(6):=LDISP_.tb4_0(0);
LDISP_.tb5_1(6):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(6):=90009728;
LDISP_.tb5_2(6):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(6)), 'ATTRIBUTE');
LDISP_.tb5_2(6):=LDISP_.tb5_2(6);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (6)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(6),
LDISP_.tb5_1(6),
LDISP_.tb5_2(6),
6,
'Y'
,
'Y'
,
'N'
,
'SELECT  CONCCODI "CÓDIGO" , CONCDESC "DESCRIPCIÓN"  FROM CONCEPTO WHERE CONCFLDE = '|| chr(39) ||'S'|| chr(39) ||' ORDER BY CONCCODI ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'CONCCODI Código|CONCDESC Descripción|'
,
'FROM CONCEPTO|'
,
'WHERE CONCFLDE = '|| chr(39) ||'S'|| chr(39) ||'|'
,
'ORDER BY CONCCODI ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(7):=LDISP_.tb4_0(0);
LDISP_.tb5_1(7):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(7):=90009729;
LDISP_.tb5_2(7):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(7)), 'ATTRIBUTE');
LDISP_.tb5_2(7):=LDISP_.tb5_2(7);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (7)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(7),
LDISP_.tb5_1(7),
LDISP_.tb5_2(7),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(8):=LDISP_.tb4_0(0);
LDISP_.tb5_1(8):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(8):=90009750;
LDISP_.tb5_2(8):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(8)), 'ATTRIBUTE');
LDISP_.tb5_2(8):=LDISP_.tb5_2(8);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (8)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(8),
LDISP_.tb5_1(8),
LDISP_.tb5_2(8),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(9):=LDISP_.tb4_0(0);
LDISP_.tb5_1(9):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(9):=90009751;
LDISP_.tb5_2(9):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(9)), 'ATTRIBUTE');
LDISP_.tb5_2(9):=LDISP_.tb5_2(9);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (9)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(9),
LDISP_.tb5_1(9),
LDISP_.tb5_2(9),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(10):=LDISP_.tb4_0(0);
LDISP_.tb5_1(10):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(10):=90009752;
LDISP_.tb5_2(10):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(10)), 'ATTRIBUTE');
LDISP_.tb5_2(10):=LDISP_.tb5_2(10);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (10)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(10),
LDISP_.tb5_1(10),
LDISP_.tb5_2(10),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(11):=LDISP_.tb4_0(0);
LDISP_.tb5_1(11):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(11):=90009753;
LDISP_.tb5_2(11):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(11)), 'ATTRIBUTE');
LDISP_.tb5_2(11):=LDISP_.tb5_2(11);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (11)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(11),
LDISP_.tb5_1(11),
LDISP_.tb5_2(11),
11,
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(12):=LDISP_.tb4_0(0);
LDISP_.tb5_1(12):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(12):=90009754;
LDISP_.tb5_2(12):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(12)), 'ATTRIBUTE');
LDISP_.tb5_2(12):=LDISP_.tb5_2(12);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (12)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(12),
LDISP_.tb5_1(12),
LDISP_.tb5_2(12),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(13):=LDISP_.tb4_0(0);
LDISP_.tb5_1(13):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(13):=90009755;
LDISP_.tb5_2(13):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(13)), 'ATTRIBUTE');
LDISP_.tb5_2(13):=LDISP_.tb5_2(13);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (13)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(13),
LDISP_.tb5_1(13),
LDISP_.tb5_2(13),
13,
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(14):=LDISP_.tb4_0(0);
LDISP_.tb5_1(14):=LDISP_.tb4_1(0);
LDISP_.old_tb5_2(14):=90009756;
LDISP_.tb5_2(14):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(14)), 'ATTRIBUTE');
LDISP_.tb5_2(14):=LDISP_.tb5_2(14);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (14)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(14),
LDISP_.tb5_1(14),
LDISP_.tb5_2(14),
14,
'Y'
,
'Y'
,
'N'
,
'SELECT  SUBSIDY_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM LD_SUBSIDY ORDER BY SUBSIDY_ID ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'SUBSIDY_ID Código|DESCRIPTION Descripción|'
,
'FROM LD_SUBSIDY|'
,
null,
'ORDER BY SUBSIDY_ID ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb4_0(1):=LDISP_.tb0_1(0);
LDISP_.old_tb4_1(1):=8015;
LDISP_.tb4_1(1):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_1(1)), 'ENTITY');
LDISP_.tb4_1(1):=LDISP_.tb4_1(1);
LDISP_.old_tb4_2(1):=8014;
LDISP_.tb4_2(1):=CASE WHEN (LDISP_.old_tb4_2(1) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_2(1)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (1)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDISP_.tb4_0(1),
LDISP_.tb4_1(1),
LDISP_.tb4_2(1),
'G'
,
1,
0,
null,
null,
' LD_SUBSIDY.SUBSIDY_ID  =  LD_UBICATION.SUBSIDY_ID '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(15):=LDISP_.tb4_0(1);
LDISP_.tb5_1(15):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(15):=90009757;
LDISP_.tb5_2(15):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(15)), 'ATTRIBUTE');
LDISP_.tb5_2(15):=LDISP_.tb5_2(15);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (15)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(15),
LDISP_.tb5_1(15),
LDISP_.tb5_2(15),
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
'A'
,
null,
1);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(16):=LDISP_.tb4_0(1);
LDISP_.tb5_1(16):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(16):=90009758;
LDISP_.tb5_2(16):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(16)), 'ATTRIBUTE');
LDISP_.tb5_2(16):=LDISP_.tb5_2(16);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (16)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(16),
LDISP_.tb5_1(16),
LDISP_.tb5_2(16),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(17):=LDISP_.tb4_0(1);
LDISP_.tb5_1(17):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(17):=90009759;
LDISP_.tb5_2(17):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(17)), 'ATTRIBUTE');
LDISP_.tb5_2(17):=LDISP_.tb5_2(17);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (17)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(17),
LDISP_.tb5_1(17),
LDISP_.tb5_2(17),
2,
'Y'
,
'Y'
,
'N'
,
'SELECT  GEOGRAP_LOCATION_ID "CÓDIGO" , DESCRIPTION "DESCRIPCIÓN"  FROM GE_GEOGRA_LOCATION WHERE ASSIGN_LEVEL = '|| chr(39) ||'Y'|| chr(39) ||'    AND EXISTS (SELECT 1 FROM GE_GEOGRA_LOCA_TYPE          WHERE GE_GEOGRA_LOCATION.GEOG_LOCA_AREA_TYPE = GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE
            AND (GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE = AB_BOCONSTANTS.FNUOBTTIPOUBICACIONLOC OR
                GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE = AB_BOCONSTANTS.FNUOBTTIPOUBICACIONDPTO OR
                GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE = AB_BOCONSTANTS.FNUOBTTIPOUBICACIONBARRIO))
  ORDER BY GEOGRAP_LOCATION_ID, DESCRIPTION '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'GEOGRAP_LOCATION_ID Código|DESCRIPTION Descripción|'
,
'FROM GE_GEOGRA_LOCATION|'
,
'WHERE ASSIGN_LEVEL = '|| chr(39) ||'Y'|| chr(39) ||'    AND EXISTS (SELECT 1 FROM GE_GEOGRA_LOCA_TYPE          WHERE GE_GEOGRA_LOCATION.GEOG_LOCA_AREA_TYPE = GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE
            AND (GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE = AB_BOCONSTANTS.FNUOBTTIPOUBICACIONLOC OR
                GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE = AB_BOCONSTANTS.FNUOBTTIPOUBICACIONDPTO OR
                GE_GEOGRA_LOCA_TYPE.GEOG_LOCA_AREA_TYPE = AB_BOCONSTANTS.FNUOBTTIPOUBICACIONBARRIO))
  ORDER BY GEOGRAP_LOCATION_ID, DESCRIPTION|'
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(18):=LDISP_.tb4_0(1);
LDISP_.tb5_1(18):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(18):=90009760;
LDISP_.tb5_2(18):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(18)), 'ATTRIBUTE');
LDISP_.tb5_2(18):=LDISP_.tb5_2(18);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (18)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(18),
LDISP_.tb5_1(18),
LDISP_.tb5_2(18),
3,
'Y'
,
'Y'
,
'N'
,
'SELECT  CATECODI "CÓDIGO" , CATEDESC "DESCRIPCIÓN"  FROM CATEGORI WHERE CATECODI = 1 ORDER BY CATECODI ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'CATECODI Código|CATEDESC Descripción |'
,
'FROM CATEGORI|'
,
'WHERE CATECODI = 1|'
,
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(19):=LDISP_.tb4_0(1);
LDISP_.tb5_1(19):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(19):=90009761;
LDISP_.tb5_2(19):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(19)), 'ATTRIBUTE');
LDISP_.tb5_2(19):=LDISP_.tb5_2(19);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (19)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(19),
LDISP_.tb5_1(19),
LDISP_.tb5_2(19),
4,
'Y'
,
'Y'
,
'N'
,
'SELECT  SUCACODI "CÓDIGO" , SUCADESC "DESCRIPCIÓN"  FROM SUBCATEG WHERE SUCACATE = [SUCACATE] ORDER BY SUCACODI ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'SUCACODI Código|SUCADESC Descripción|'
,
'FROM SUBCATEG|'
,
'WHERE SUCACATE = SUCACATE|'
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(20):=LDISP_.tb4_0(1);
LDISP_.tb5_1(20):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(20):=90009762;
LDISP_.tb5_2(20):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(20)), 'ATTRIBUTE');
LDISP_.tb5_2(20):=LDISP_.tb5_2(20);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (20)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(20),
LDISP_.tb5_1(20),
LDISP_.tb5_2(20),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(21):=LDISP_.tb4_0(1);
LDISP_.tb5_1(21):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(21):=90009763;
LDISP_.tb5_2(21):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(21)), 'ATTRIBUTE');
LDISP_.tb5_2(21):=LDISP_.tb5_2(21);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (21)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(21),
LDISP_.tb5_1(21),
LDISP_.tb5_2(21),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(22):=LDISP_.tb4_0(1);
LDISP_.tb5_1(22):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(22):=90009764;
LDISP_.tb5_2(22):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(22)), 'ATTRIBUTE');
LDISP_.tb5_2(22):=LDISP_.tb5_2(22);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (22)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(22),
LDISP_.tb5_1(22),
LDISP_.tb5_2(22),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(23):=LDISP_.tb4_0(1);
LDISP_.tb5_1(23):=LDISP_.tb4_1(1);
LDISP_.old_tb5_2(23):=90009765;
LDISP_.tb5_2(23):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(23)), 'ATTRIBUTE');
LDISP_.tb5_2(23):=LDISP_.tb5_2(23);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (23)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(23),
LDISP_.tb5_1(23),
LDISP_.tb5_2(23),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb4_0(2):=LDISP_.tb0_1(0);
LDISP_.old_tb4_1(2):=8016;
LDISP_.tb4_1(2):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_1(2)), 'ENTITY');
LDISP_.tb4_1(2):=LDISP_.tb4_1(2);
LDISP_.old_tb4_2(2):=8015;
LDISP_.tb4_2(2):=CASE WHEN (LDISP_.old_tb4_2(2) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_2(2)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (2)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDISP_.tb4_0(2),
LDISP_.tb4_1(2),
LDISP_.tb4_2(2),
'G'
,
2,
0,
null,
null,
'LD_UBICATION.UBICATION_ID  = LD_SUBSIDY_DETAIL.UBICATION_ID  '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(24):=LDISP_.tb4_0(2);
LDISP_.tb5_1(24):=LDISP_.tb4_1(2);
LDISP_.old_tb5_2(24):=90009766;
LDISP_.tb5_2(24):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(24)), 'ATTRIBUTE');
LDISP_.tb5_2(24):=LDISP_.tb5_2(24);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (24)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(24),
LDISP_.tb5_1(24),
LDISP_.tb5_2(24),
1,
'Y'
,
'Y'
,
'N'
,
'SELECT  CONCCODI "CÓDIGO" , CONCDESC "DESCRIPCIÓN"  FROM CONCEPTO WHERE  CONCEPTO.CONCFLDE = LD_BOSUBSIDY.FSBGETCONSTBYCONCEPT AND    CONCEPTO.CONCCODI <> -1 ORDER BY CONCCODI ASC '
,
'N'
,
'CÓDIGO'
,
'DESCRIPCIÓN'
,
'CONCCODI Código|CONCDESC Descripción|'
,
'FROM CONCEPTO|'
,
'WHERE  CONCEPTO.CONCFLDE = LD_BOSUBSIDY.FSBGETCONSTBYCONCEPT AND    CONCEPTO.CONCCODI <> -1|'
,
'ORDER BY CONCCODI ASC|'
,
null,
'U'
,
null,
null,
null,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(25):=LDISP_.tb4_0(2);
LDISP_.tb5_1(25):=LDISP_.tb4_1(2);
LDISP_.old_tb5_2(25):=90009767;
LDISP_.tb5_2(25):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(25)), 'ATTRIBUTE');
LDISP_.tb5_2(25):=LDISP_.tb5_2(25);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (25)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(25),
LDISP_.tb5_1(25),
LDISP_.tb5_2(25),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(26):=LDISP_.tb4_0(2);
LDISP_.tb5_1(26):=LDISP_.tb4_1(2);
LDISP_.old_tb5_2(26):=90009768;
LDISP_.tb5_2(26):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(26)), 'ATTRIBUTE');
LDISP_.tb5_2(26):=LDISP_.tb5_2(26);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (26)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(26),
LDISP_.tb5_1(26),
LDISP_.tb5_2(26),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(27):=LDISP_.tb4_0(2);
LDISP_.tb5_1(27):=LDISP_.tb4_1(2);
LDISP_.old_tb5_2(27):=90009769;
LDISP_.tb5_2(27):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(27)), 'ATTRIBUTE');
LDISP_.tb5_2(27):=LDISP_.tb5_2(27);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (27)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(27),
LDISP_.tb5_1(27),
LDISP_.tb5_2(27),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(28):=LDISP_.tb4_0(2);
LDISP_.tb5_1(28):=LDISP_.tb4_1(2);
LDISP_.old_tb5_2(28):=90009770;
LDISP_.tb5_2(28):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(28)), 'ATTRIBUTE');
LDISP_.tb5_2(28):=LDISP_.tb5_2(28);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (28)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(28),
LDISP_.tb5_1(28),
LDISP_.tb5_2(28),
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
'A'
,
null,
1);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb4_0(3):=LDISP_.tb0_1(0);
LDISP_.old_tb4_1(3):=8017;
LDISP_.tb4_1(3):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_1(3)), 'ENTITY');
LDISP_.tb4_1(3):=LDISP_.tb4_1(3);
LDISP_.old_tb4_2(3):=8015;
LDISP_.tb4_2(3):=CASE WHEN (LDISP_.old_tb4_2(3) IS NULL) THEN NULL ELSE
 GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYNAME(LDISP_.old_tb4_2(3)), 'ENTITY') END;
ut_trace.trace('insertando tabla: GI_ENTITY_DISP_DATA fila (3)',1);
INSERT INTO GI_ENTITY_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,PARENT_ENTITY_ID,DISPLAY_TYPE,LEVEL_,POSITION_IN_LEVEL,ICON_,DEFAULT_WHERE,JOIN_CONDITION,READ_ONLY,ALLOW_INSERT,ALLOW_DELETE,CONFIGURA_TYPE_ID) 
VALUES (LDISP_.tb4_0(3),
LDISP_.tb4_1(3),
LDISP_.tb4_2(3),
'G'
,
2,
1,
null,
null,
' LD_UBICATION.UBICATION_ID =  LD_MAX_RECOVERY.UBICATION_ID '
,
'Y'
,
'Y'
,
'Y'
,
null);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(29):=LDISP_.tb4_0(3);
LDISP_.tb5_1(29):=LDISP_.tb4_1(3);
LDISP_.old_tb5_2(29):=90009771;
LDISP_.tb5_2(29):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(29)), 'ATTRIBUTE');
LDISP_.tb5_2(29):=LDISP_.tb5_2(29);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (29)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(29),
LDISP_.tb5_1(29),
LDISP_.tb5_2(29),
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
'A'
,
null,
1);

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(30):=LDISP_.tb4_0(3);
LDISP_.tb5_1(30):=LDISP_.tb4_1(3);
LDISP_.old_tb5_2(30):=90009772;
LDISP_.tb5_2(30):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(30)), 'ATTRIBUTE');
LDISP_.tb5_2(30):=LDISP_.tb5_2(30);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (30)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(30),
LDISP_.tb5_1(30),
LDISP_.tb5_2(30),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(31):=LDISP_.tb4_0(3);
LDISP_.tb5_1(31):=LDISP_.tb4_1(3);
LDISP_.old_tb5_2(31):=90009773;
LDISP_.tb5_2(31):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(31)), 'ATTRIBUTE');
LDISP_.tb5_2(31):=LDISP_.tb5_2(31);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (31)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(31),
LDISP_.tb5_1(31),
LDISP_.tb5_2(31),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(32):=LDISP_.tb4_0(3);
LDISP_.tb5_1(32):=LDISP_.tb4_1(3);
LDISP_.old_tb5_2(32):=90009774;
LDISP_.tb5_2(32):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(32)), 'ATTRIBUTE');
LDISP_.tb5_2(32):=LDISP_.tb5_2(32);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (32)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(32),
LDISP_.tb5_1(32),
LDISP_.tb5_2(32),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(33):=LDISP_.tb4_0(3);
LDISP_.tb5_1(33):=LDISP_.tb4_1(3);
LDISP_.old_tb5_2(33):=90009775;
LDISP_.tb5_2(33):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(33)), 'ATTRIBUTE');
LDISP_.tb5_2(33):=LDISP_.tb5_2(33);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (33)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(33),
LDISP_.tb5_1(33),
LDISP_.tb5_2(33),
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
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;

LDISP_.tb5_0(34):=LDISP_.tb4_0(3);
LDISP_.tb5_1(34):=LDISP_.tb4_1(3);
LDISP_.old_tb5_2(34):=90009776;
LDISP_.tb5_2(34):=GE_BOCATALOG.FNUGETIDFROMCATALOG(LDISP_.TBENTITYATTRIBUTENAME(LDISP_.old_tb5_2(34)), 'ATTRIBUTE');
LDISP_.tb5_2(34):=LDISP_.tb5_2(34);
ut_trace.trace('insertando tabla: GI_ATTRIB_DISP_DATA fila (34)',1);
INSERT INTO GI_ATTRIB_DISP_DATA(EXECUTABLE_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,POSITION,VISIBLE_,ALLOW_UPDATE,USE_RULE_EDITOR,LIST_OF_VALUES,LIST_OF_VALUE_TYPE,LIST_OF_VALUE_CODE,LIST_OF_VALUE_DESC,LIST_OF_VALUE_ATTR,LIST_OF_VALUE_FROM,LIST_OF_VALUE_WHERE,LIST_OF_VALUE_ORDER,LIST_OF_VALUE_P_ATTR,STYLE_CASE,NUMERATOR_SEQ,SELECTION_ORDER,CONFIGURA_TYPE_ID,SEL_ORDER_SEQ) 
VALUES (LDISP_.tb5_0(34),
LDISP_.tb5_1(34),
LDISP_.tb5_2(34),
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
LDISP_.blProcessStatus := false;
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
 nuIndexInternal := LDISP_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDISP_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDISP_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDISP_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDISP_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDISP_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDISP_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDISP_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDISP_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDISP_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDISP_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDISP_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDISP_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDISP_.tbUserException(nuIndex).user_id, LDISP_.tbUserException(nuIndex).status , LDISP_.tbUserException(nuIndex).usr_exc_type_id, LDISP_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDISP_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDISP_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDISP_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDISP_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDISP_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDISP_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDISP_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDISP_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDISP_******************************'); end;
/

