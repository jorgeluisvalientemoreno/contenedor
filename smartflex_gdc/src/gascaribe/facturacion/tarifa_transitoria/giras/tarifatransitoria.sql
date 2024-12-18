BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('TARIFATRANSITORIA_',
'CREATE OR REPLACE PACKAGE TARIFATRANSITORIA_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_ASSEMBLYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ASSEMBLYRowId tyGI_ASSEMBLYRowId;type tyGI_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CLASSRowId tyGI_CLASSRowId;type tyGI_COMPONENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPONENTRowId tyGI_COMPONENTRowId;type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_MENU_OPTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_MENU_OPTIONRowId tySA_MENU_OPTIONRowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type ty0_0 is table of GI_ASSEMBLY.ASSEMBLY_INFO%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of GI_ASSEMBLY.ASSEMBLY%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty0_2 is table of GI_ASSEMBLY.ASSEMBLY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2;type ty1_0 is table of GI_CLASS.ASSEMBLY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GI_CLASS.TYPE_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GI_CLASS.NAMESPACE%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty1_3 is table of GI_CLASS.CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_3 ty1_3; ' || chr(10) ||
'tb1_3 ty1_3;type ty2_0 is table of SA_EXECUTABLE.NAME%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_EXECUTABLE.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of SA_EXECUTABLE.CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of SA_MENU_OPTION.MENU_OPTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of SA_MENU_OPTION.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;CURSOR cuRoleExecutables ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT b.name, a.executable_id, a.role_id ' || chr(10) ||
'FROM sa_role_executables a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and a.executable_id in  ' || chr(10) ||
'( ' || chr(10) ||
'SELECT ' || chr(10) ||
'    sa_executable.executable_id ' || chr(10) ||
'FROM ' || chr(10) ||
'    sa_executable, ' || chr(10) ||
'    gi_class, ' || chr(10) ||
'    gi_assembly ' || chr(10) ||
'WHERE ' || chr(10) ||
'    sa_executable.class_id = gi_class.class_id AND ' || chr(10) ||
'    gi_class.assembly_id = gi_assembly.assembly_id AND ' || chr(10) ||
'    gi_assembly.assembly = ''TARIFATRANSITORIA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT ' || chr(10) ||
'    sa_executable.executable_id ' || chr(10) ||
'FROM ' || chr(10) ||
'    sa_executable, ' || chr(10) ||
'    gi_class, ' || chr(10) ||
'    gi_assembly ' || chr(10) ||
'WHERE ' || chr(10) ||
'    sa_executable.class_id = gi_class.class_id AND ' || chr(10) ||
'    gi_class.assembly_id = gi_assembly.assembly_id AND ' || chr(10) ||
'    gi_assembly.assembly = ''TARIFATRANSITORIA'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT ' || chr(10) ||
'    sa_executable.executable_id ' || chr(10) ||
'FROM ' || chr(10) ||
'    sa_executable, ' || chr(10) ||
'    gi_class, ' || chr(10) ||
'    gi_assembly ' || chr(10) ||
'WHERE ' || chr(10) ||
'    sa_executable.class_id = gi_class.class_id AND ' || chr(10) ||
'    gi_class.assembly_id = gi_assembly.assembly_id AND ' || chr(10) ||
'    gi_assembly.assembly = ''TARIFATRANSITORIA'' ' || chr(10) ||
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
'END TARIFATRANSITORIA_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:TARIFATRANSITORIA_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
Open TARIFATRANSITORIA_.cuRoleExecutables;
loop
 fetch TARIFATRANSITORIA_.cuRoleExecutables INTO TARIFATRANSITORIA_.rcRoleExecutables;
 exit when  TARIFATRANSITORIA_.cuRoleExecutables%notfound;
 TARIFATRANSITORIA_.tbRoleExecutables(nuIndex) := TARIFATRANSITORIA_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close TARIFATRANSITORIA_.cuRoleExecutables;
nuIndex := 0;
Open TARIFATRANSITORIA_.cuUserExceptions ;
loop
 fetch TARIFATRANSITORIA_.cuUserExceptions INTO  TARIFATRANSITORIA_.rcUserExceptions;
 exit when TARIFATRANSITORIA_.cuUserExceptions%notfound;
 TARIFATRANSITORIA_.tbUserException(nuIndex):=TARIFATRANSITORIA_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close TARIFATRANSITORIA_.cuUserExceptions;
nuIndex := 0;
Open TARIFATRANSITORIA_.cuExecEntities ;
loop
 fetch TARIFATRANSITORIA_.cuExecEntities INTO  TARIFATRANSITORIA_.rcExecEntities;
 exit when TARIFATRANSITORIA_.cuExecEntities%notfound;
 TARIFATRANSITORIA_.tbExecEntities(nuIndex):=TARIFATRANSITORIA_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close TARIFATRANSITORIA_.cuExecEntities;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT
    sa_executable.executable_id
FROM
    sa_executable,
    gi_class,
    gi_assembly
WHERE
    sa_executable.class_id = gi_class.class_id AND
    gi_class.assembly_id = gi_assembly.assembly_id AND
    gi_assembly.assembly = 'TARIFATRANSITORIA'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT
    sa_executable.executable_id
FROM
    sa_executable,
    gi_class,
    gi_assembly
WHERE
    sa_executable.class_id = gi_class.class_id AND
    gi_class.assembly_id = gi_assembly.assembly_id AND
    gi_assembly.assembly = 'TARIFATRANSITORIA'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT
    sa_executable.executable_id
FROM
    sa_executable,
    gi_class,
    gi_assembly
WHERE
    sa_executable.class_id = gi_class.class_id AND
    gi_class.assembly_id = gi_assembly.assembly_id AND
    gi_assembly.assembly = 'TARIFATRANSITORIA'
);

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GI_COMPONENT WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='TARIFATRANSITORIA'));
nuIndex binary_integer;
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPONENT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GI_COMPONENT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='TARIFATRANSITORIA')));

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='TARIFATRANSITORIA'))) AND ROLE_ID=1;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='TARIFATRANSITORIA'));
nuIndex binary_integer;
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM SA_EXECUTABLE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='TARIFATRANSITORIA');
nuIndex binary_integer;
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CLASS',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GI_CLASS WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GI_ASSEMBLY WHERE ASSEMBLY='TARIFATRANSITORIA';
nuIndex binary_integer;
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ASSEMBLY',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GI_ASSEMBLY WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;

TARIFATRANSITORIA_.old_tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
TARIFATRANSITORIA_.tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
TARIFATRANSITORIA_.old_tb0_1(0):='TARIFATRANSITORIA'
;
TARIFATRANSITORIA_.tb0_1(0):='TARIFATRANSITORIA'
;
TARIFATRANSITORIA_.old_tb0_2(0):=4125;
TARIFATRANSITORIA_.tb0_2(0):=GI_BOASSEMBLY.FNUGETASSEMBLYID(TARIFATRANSITORIA_.old_tb0_1(0), TARIFATRANSITORIA_.old_tb0_0(0));
TARIFATRANSITORIA_.tb0_2(0):=TARIFATRANSITORIA_.tb0_2(0);
ut_trace.trace('Actualizar o insertar tabla: GI_ASSEMBLY fila (0)',1);
UPDATE GI_ASSEMBLY SET ASSEMBLY_INFO=TARIFATRANSITORIA_.tb0_0(0),
ASSEMBLY=TARIFATRANSITORIA_.tb0_1(0),
ASSEMBLY_ID=TARIFATRANSITORIA_.tb0_2(0)
 WHERE ASSEMBLY_ID = TARIFATRANSITORIA_.tb0_2(0);
if not (sql%found) then
INSERT INTO GI_ASSEMBLY(ASSEMBLY_INFO,ASSEMBLY,ASSEMBLY_ID) 
VALUES (TARIFATRANSITORIA_.tb0_0(0),
TARIFATRANSITORIA_.tb0_1(0),
TARIFATRANSITORIA_.tb0_2(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;

TARIFATRANSITORIA_.tb1_0(0):=TARIFATRANSITORIA_.tb0_2(0);
TARIFATRANSITORIA_.old_tb1_1(0):='callLDCGCTT'
;
TARIFATRANSITORIA_.tb1_1(0):='callLDCGCTT'
;
TARIFATRANSITORIA_.old_tb1_2(0):='TARIFATRANSITORIA'
;
TARIFATRANSITORIA_.tb1_2(0):='TARIFATRANSITORIA'
;
TARIFATRANSITORIA_.old_tb1_3(0):=12128;
TARIFATRANSITORIA_.tb1_3(0):=GI_BOASSEMBLY.FNUGETCLASSID(TARIFATRANSITORIA_.tb1_0(0), TARIFATRANSITORIA_.old_tb1_1(0), TARIFATRANSITORIA_.old_tb1_2(0));
TARIFATRANSITORIA_.tb1_3(0):=TARIFATRANSITORIA_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: GI_CLASS fila (0)',1);
UPDATE GI_CLASS SET ASSEMBLY_ID=TARIFATRANSITORIA_.tb1_0(0),
TYPE_NAME=TARIFATRANSITORIA_.tb1_1(0),
NAMESPACE=TARIFATRANSITORIA_.tb1_2(0),
CLASS_ID=TARIFATRANSITORIA_.tb1_3(0)
 WHERE CLASS_ID = TARIFATRANSITORIA_.tb1_3(0);
if not (sql%found) then
INSERT INTO GI_CLASS(ASSEMBLY_ID,TYPE_NAME,NAMESPACE,CLASS_ID) 
VALUES (TARIFATRANSITORIA_.tb1_0(0),
TARIFATRANSITORIA_.tb1_1(0),
TARIFATRANSITORIA_.tb1_2(0),
TARIFATRANSITORIA_.tb1_3(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;

TARIFATRANSITORIA_.old_tb2_0(0):='LDCGCTT'
;
TARIFATRANSITORIA_.tb2_0(0):=UPPER(TARIFATRANSITORIA_.old_tb2_0(0));
TARIFATRANSITORIA_.old_tb2_1(0):=500000000015083;
TARIFATRANSITORIA_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(TARIFATRANSITORIA_.tb2_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
TARIFATRANSITORIA_.tb2_1(0):=TARIFATRANSITORIA_.tb2_1(0);
TARIFATRANSITORIA_.tb2_2(0):=TARIFATRANSITORIA_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=TARIFATRANSITORIA_.tb2_0(0),
EXECUTABLE_ID=TARIFATRANSITORIA_.tb2_1(0),
CLASS_ID=TARIFATRANSITORIA_.tb2_2(0),
DESCRIPTION='Generacion de Cancelacion de Tarifa Transitoria'
,
PATH=null,
VERSION='1.0'
,
EXECUTABLE_TYPE_ID=17,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=21,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP=null,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='Y'
,
TIMES_EXECUTED=96,
EXEC_OWNER=null,
LAST_DATE_EXECUTED=to_date('24-08-2020 17:58:41','DD-MM-YYYY HH24:MI:SS')
 WHERE EXECUTABLE_ID = TARIFATRANSITORIA_.tb2_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,CLASS_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED) 
VALUES (TARIFATRANSITORIA_.tb2_0(0),
TARIFATRANSITORIA_.tb2_1(0),
TARIFATRANSITORIA_.tb2_2(0),
'Generacion de Cancelacion de Tarifa Transitoria'
,
null,
'1.0'
,
17,
2,
21,
1,
null,
'N'
,
null,
'N'
,
'Y'
,
96,
null,
to_date('24-08-2020 17:58:41','DD-MM-YYYY HH24:MI:SS'));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;

TARIFATRANSITORIA_.old_tb3_0(0):=40010017;
TARIFATRANSITORIA_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
TARIFATRANSITORIA_.tb3_0(0):=TARIFATRANSITORIA_.tb3_0(0);
TARIFATRANSITORIA_.tb3_1(0):=TARIFATRANSITORIA_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (TARIFATRANSITORIA_.tb3_0(0),
TARIFATRANSITORIA_.tb3_1(0),
'LDCGCTT'
,
'Generacion de Cancelacion de Tarifa Transitoria'
,
1,
1,
16,
5000,
'FormExecutable'
,
null);

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;

TARIFATRANSITORIA_.tb4_0(0):=1;
TARIFATRANSITORIA_.tb4_1(0):=TARIFATRANSITORIA_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (TARIFATRANSITORIA_.tb4_0(0),
TARIFATRANSITORIA_.tb4_1(0));

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
    EXECUTE IMMEDIATE ''||
    'CREATE OR REPLACE FUNCTION fblDecodeB64Clob'|| chr(10) ||
    '('|| chr(10) ||
    'iclFileContent in clob'|| chr(10) ||
    ')'|| chr(10) ||
    'RETURN BLOB'|| chr(10) ||
    'AS LANGUAGE JAVA NAME ''os.ge.util.Decoder.decodeB64CLOB(java.sql.Clob) return java.sql.Blob'';';
END;
/
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON fblDecodeB64Clob TO SYSTEM_OBJ_PRIVS_ROLE';
END;
/
DECLARE

    nuAmountRecs        number;

    sbDistFileId        ge_distribution_file.distribution_file_id%type;
    sbDescription       ge_distribution_file.description%type;
    sbFileVersion       ge_distribution_file.file_version%type;
    nuVersionNumber     ge_distribution_file.version_number%type;
    sbFileName          ge_distribution_file.file_name%type;
    blFileContent       ge_distribution_file.file_source%type;
    sbMD5               ge_distribution_file.md5_hash%type;
    nuDistriGroupId     ge_distribution_file.distri_group_id%type;
    
    clB64FileContent    clob;

BEGIN

    sbDistFileId        := 'TARIFATRANSITORIA';
    sbDescription       := 'TARIFATRANSITORIA.dll';
    sbFileVersion       := '1.0.0.0';
    sbFileName          := 'TARIFATRANSITORIA.zip';
    sbMD5               := '6a56364667ebe6bca6142545fe398600';
    nuDistriGroupId     := 4;

clB64FileContent := concat(clB64FileContent, 'N3q8ryccAAMaWmnTwiwAAAAAAAB3AAAAAAAAAPiS5HwAJpaOcAAX9+wFu+r0/5QBL0TuTr0I2yvx');
clB64FileContent := concat(clB64FileContent, 'U9Plq7xO/c6hY0BIQykUfFcxmm1nJkkaGBLomg0YBj0sy/fHRpK4HzK+n2a7pvMs7BoPjYRR4KMd');
clB64FileContent := concat(clB64FileContent, 'xlRcAmPnIxsuvczgp+WeHPcyYaNaHlNTjN1vK/qlE3GyAhMqckNbDOBQtZLuCj43pjGxqtwJlh/3');
clB64FileContent := concat(clB64FileContent, 'A7P2rXNTu6qZLoE8j9Yi3sS2E/4w2nF3jZr/i9ZZxM0GjfOhIYikI1s7cfFMfL/svhfbFe311iXe');
clB64FileContent := concat(clB64FileContent, 'veDX4kClXKmWPZ+npkpbbHc2uJ7rEr5e0fABoIHF/qCfc3lSE1LKXa4Q8C6jU7Olk4f3IjNR3NbE');
clB64FileContent := concat(clB64FileContent, 'WmIGSeAg3b5/mCvkWeQI5SrvImwZa1pgMJzfPXiuu0n4n50TM5HlZudXnnyJR6L+y19T763D1aVD');
clB64FileContent := concat(clB64FileContent, 'zSDKKZWSqhhoIV+tS/PXN6zJlG0DxInj+KH7S871DbJ4Bo7XGyIEGnoY03ZMWPQsVm2cZdSDLQZa');
clB64FileContent := concat(clB64FileContent, 'ZA+X9XlWffqFLMQ4bBVBncU18/IM+vRwD4Tx24cdHWAhJebViqzoRMbeEX2a2ARLcJL3EDDejI+L');
clB64FileContent := concat(clB64FileContent, 'wBkMvdNvr5XQKfCpBY0KjHJG0bJ5N0TlvcKGfjIlbsvAuRc5QgBEx5G/Aq2yP9/eHBE13D6Acehw');
clB64FileContent := concat(clB64FileContent, 'kkVetnl4T3GqcjLK6jShUopN8Wkcuwse1+WZqQerOrvXK7l/+ZvqPImkz+9xKesljpCISBFaN6++');
clB64FileContent := concat(clB64FileContent, 'tvWYIMSWf1/lhAbn52NCpqfRSgPvg7m1eiTHaKF9ZNaVRcMUZQECygZMzKx+ZNBw5i9jWJr6cdrG');
clB64FileContent := concat(clB64FileContent, '3E3YM1y54YDrGmy+N1FhBsFiyWnZnODc/dpHEIzNGbGumzz9/EUmyX34PwWaTPnpNqV/ThWx2blt');
clB64FileContent := concat(clB64FileContent, '1R2pUJToho08hfz+wsmyl6Hwixy0tM38NuK5qiw76gIlq7StlZWGaVCqDm8wIO0EceY9+BmjkwkL');
clB64FileContent := concat(clB64FileContent, 'ACEYAzbNAsAw682NdtnMwBeexo/ss9xbKtg5aJBT6VA/YrtXRxNpj81T1S7gfO3cfVTpty65Zfda');
clB64FileContent := concat(clB64FileContent, 'H8IpLPDtFgDrAJ/jH4aEG57uNK66GBl6YcWs4iy5VpWqlDM2e8k/+B7uZ2N1vmtookFqamFiQf01');
clB64FileContent := concat(clB64FileContent, 'YDdC2C27r2Q0+brj4Rhoz2nf5HRh7Pd9SNDdZzSNjOf4AXvlnTTGqtqtGjl6c7O/cCr2gwxvW9ZN');
clB64FileContent := concat(clB64FileContent, 'Z3wtownubigt88F4udEfb0pdyFet+xEZda0zUs8aYIKcXfXV8EUDra6tCaHmA9Fy311I/RGcSLOF');
clB64FileContent := concat(clB64FileContent, 'LD9N2Xq9QjlhwHW1dk8R+LQynArlr4csox4L1kEQk0TlAEDbnBE8Rr0B25vZt3KMoDqnKLWTQeD0');
clB64FileContent := concat(clB64FileContent, 'KeNi/0DvEOeBTz2cWwbwHJLu9hKEU5kr9los2jQgKonWsK50bfjdJ7QwH/PfVLXmAqtMDSeQ64JF');
clB64FileContent := concat(clB64FileContent, '8umRpX09gHALzfSNMKJrqVrzEbCap7c0pPr1NAyQ7W665V3TTcViwhPw8AFrL2gWDqOw6vJrM4G7');
clB64FileContent := concat(clB64FileContent, 'QdsUg5dVpSGz5DWuw5qxenKUksqFpBIermdtaFDPdY9VbL/MEIte9NJqMxAmFSBhPgrtwT0Ys9GR');
clB64FileContent := concat(clB64FileContent, 'Rt1ke5p9rCv1u1S6kx7KmxM8usjewRaqKOaAZFho/+vz7PyQz60DShxD9nObmZ9/hPjNiOQ07MT1');
clB64FileContent := concat(clB64FileContent, 'RaIuXUOC9WQth/wiPvFbwkcv9zwJg/MpJtO0QM2OQ7S6jEKBUKyQtT/nxq24f+ngx/My7kSgmMJ0');
clB64FileContent := concat(clB64FileContent, 'AB3sV6RMkH4JM1pt37rJidRxUEyxXkk9NpN8O0/OYccmpvXnSypo7A0OvhRU1+ON00Z20tz+oYj1');
clB64FileContent := concat(clB64FileContent, 'f6FCTt0SIAzksCQeEbZjCLrfRZDkUSG+Z2Yu8eDA811nHZb5NIkDyx9lRmTzp0AqcgWEFnJzHyBq');
clB64FileContent := concat(clB64FileContent, 'KeGPsdFFFyMI7r/4KlgZOkjgoEVtV6dFP0hpnd748ktn8kz6ShKnFBjvoYJcRXbV/LJF4dZnM2WM');
clB64FileContent := concat(clB64FileContent, 'f+CqvvBawZVsjNySXZeQvJeZ+uq6jmfthTwKcVepbxYIEyNW/4jbzAcHmbtIpxEPSpYKBs33LjLo');
clB64FileContent := concat(clB64FileContent, '7N9NZ/2HyqUaYjV/Y3fIsBmLVLwqscAwsdmqQIa1MvgEAX79ZB9TF0gBg+R2ge96IcI95w9xIDM2');
clB64FileContent := concat(clB64FileContent, 'EyqR+l7RCgKokIqpwOSAxGC5DgJSHuxQ7Rp6R5/AUjas+k9JIRgxzm1PhNgi2ghZNa+H/v+uJMmA');
clB64FileContent := concat(clB64FileContent, 'qd8CI+KmwD26KLrK0WQsHReCRoZQUM+kf3Ped4pLg1xV9PnRBD9iWmmUfLSO/cAxf2Vxao94rWIX');
clB64FileContent := concat(clB64FileContent, 'GXxFR4f30Fi+JF5eMpP5nY9RslUeOZ5uIGmlrUWoqmQvTylfSf74pAUXLFkqFe/MEoSqKjUhRvK2');
clB64FileContent := concat(clB64FileContent, 'c2BGLVb1rhT3mo1qNeH4QRqfIBHdcGuL4yDHXJv5kR1QUEJEyEyUag4d6hRoLr6D5lDbR5BGhKuQ');
clB64FileContent := concat(clB64FileContent, 'A/nrqi0WUEMxrTsKX9dAVrXZaLGuGTE3+rXOBak0MGG8Na7Q4+vT1De4Acea2G5oL3lHFPqfH4Ak');
clB64FileContent := concat(clB64FileContent, 'SUSY/FN4Wk9j9XhL/9+vfbLlbfEjOoZTvxAN33TFcDF4DMYfKXh2HOM/U/BGqWqUDE6D1OSW5MJB');
clB64FileContent := concat(clB64FileContent, 'KTnlg6xZLT6vVv39kNDCNU0+uMjMG5q81nlFYEZKZ+KjD5w0zBSM9eMrKxKCC2vc/ro39NmeBMbq');
clB64FileContent := concat(clB64FileContent, 'SPLZCscfzy4D57anLnm2aHtz1rgGzZv5UJ35ZfE3IXJX15opaPi/jE9kKCH9Mbc/gcrtWCqqMYq9');
clB64FileContent := concat(clB64FileContent, 'OY+aCPneu4UJu4IR0lQoARvnv0V6fCbOW0cUUmM1foIzNcsHomgsnfoucIRzIte+VPjuPAYwjJSO');
clB64FileContent := concat(clB64FileContent, 'fuiS9GuSHurBWOXb5hsnRS+8vkHdCnM89bEneP57WpfZXq/2cjRhlD5JmHGfgTJ5F5X9PPgVvT2F');
clB64FileContent := concat(clB64FileContent, 'i7h3xWbDKjQHNHL3pNLgt8SD/dfrkhzArIrfbXM3cCsVQwQ4vDsjfsdwnLZE594PtdKMWFT682OZ');
clB64FileContent := concat(clB64FileContent, 'WP2n7E+AJfyk13STIfraJX57ZpqEyMyIyUrpfdlTqi8opPsRnrDL7tUsAjwWtNVZjOdb4V7AFyzO');
clB64FileContent := concat(clB64FileContent, 'uc7wqAltbpD+4unW343wITAjOw+hOf2zyRxI/OGy5CEMIc/5AEj5ncfUwvmmKxaFTNofQNL7sO6p');
clB64FileContent := concat(clB64FileContent, 'AvyDdNuTd1h3o4u7Tt70FnnNIeiStXjQhMp/0jwgrbUsTMcHbox/hRZdfm6WY83zya05CGzGYQz9');
clB64FileContent := concat(clB64FileContent, 'MXC36MM+6Dt+xtZTof7qiseG/o8B+q2DNiJ93YxdJnc92qORV/ax8MgKnRL/hPOK4BHqUjsIRKkX');
clB64FileContent := concat(clB64FileContent, 'gsqILgaLWdk4RerJgFTT1VSwEg4AerzKSBfPtAc/1Hk3zveEMhjomNrOXa41y/n54PliqZPYfAmw');
clB64FileContent := concat(clB64FileContent, 'bW6ir44zRn8wxAL7MCz4lCPRenEJc0pCNvJO9aSkRtwZkze2PDGL6g3atwCaMaSmPyboDmMbjOHM');
clB64FileContent := concat(clB64FileContent, 'EiBjg8JE0zJ2abSMjbK9aIcwAzj3kSPfquXyDIibI7uvH83T78Qp2EK0X7Zsl83WQ9YuglAjMmdf');
clB64FileContent := concat(clB64FileContent, '8y6g93Oh8z3gTSegrCwCmuVf7YpfIayWJIq8oQSyOy4NDTDghSI4jgdIIilhmlj9FrU9/ZrXt5Vp');
clB64FileContent := concat(clB64FileContent, 'Aru3C/jMGb/g2Ls/NG+Cn7guBnksn0Wtoc7+uSZ06aYP7zrjBEu3I5tkqKHCFk5H52AFH4rI1C0f');
clB64FileContent := concat(clB64FileContent, 'QzI2TvBvyDMCfo19xSukjhOOP99t6zYqJkFRpvsAryScip3wMlW/UE1VEF3weVYD0Jx2mj49FMx6');
clB64FileContent := concat(clB64FileContent, 'g9LN0TbsTQO2eSUxslBYjKigXecFVYI/NDh6anq7hVf+OEaztWrvyAA1Mf1z3/GVs1baH1Odq9vq');
clB64FileContent := concat(clB64FileContent, '8k2VrvcelwNNmp8PtCtDimFJwBzxaqBYmpb2/hEAgxFva+Kk3P8hNIMbOR+swIFgaHxG95G8WE0I');
clB64FileContent := concat(clB64FileContent, 'K5GbdOnVxqzzwN1vGkh4YtudKMgSeg7dHr4h/6SgD8XnO1TWK53coYXPuYVcsx+Lgz0nEmycKBUR');
clB64FileContent := concat(clB64FileContent, '6xi0J5FhdoK+h3nnIxkypp/hkQSkB2aW3zwDSNpljHN2KsVMV8N0rA9eZRyOXFX9vMll2XtGRHrz');
clB64FileContent := concat(clB64FileContent, 'Jt7U+JosWL3fruLr/ZnzQA0exl88Pwm7Fjgsc+74EMReWy4AOoXoKZSc+u6swE8ufU1yQtrkb6Ye');
clB64FileContent := concat(clB64FileContent, 'sO+LCAjQOuX3VV4sAARFS/Vgki+yH2XnZPUVdJd5yyynIjwbYTLASz1pubmLdzNOhOWacYhrU1xO');
clB64FileContent := concat(clB64FileContent, '+wBatfUty/8f+DZMGCfZeLMDKpv8sIiwQXmQBwRVg55hgi5/oivJNFZ+pE2LHXezeJUnFeQuOZYM');
clB64FileContent := concat(clB64FileContent, 'tnPSSlacuVU8/M3/u3f0rJks6Wu+LkXYp3lChS1f5uLjJuTAwiZOnrclSlKc258tCdbmfVaDstv6');
clB64FileContent := concat(clB64FileContent, 'dx54RAlyUB3gdB4V8w4q4BErYqHh4czmmo9slTzb5Og3fo/arOa5oIGcOQO3M581sc1NaNr26HlR');
clB64FileContent := concat(clB64FileContent, 'F6K5LXFDh7lApRct188I7hJ+4/b98Pzlh/iXCc2Ovd3pW/K28fNpc8/qREZb1jjVrkTKLhcuTgcu');
clB64FileContent := concat(clB64FileContent, '+Rco5tmDJASrV8qS2YUluEqrgcXNxXt+rU0qtoOKJWyPO0epsiSimeaK/dCv6yECCA0PConuC2e9');
clB64FileContent := concat(clB64FileContent, 'gYTeHEbo00ZlbZWk7RncVJIhdEHCQegUeW1xw2ISu/CQ6oahRwNjsbUTf+8uc9scz4Hza7/GD97H');
clB64FileContent := concat(clB64FileContent, '3vvtt5AkGcnU8PUt0Cz5DMAa4FunNU337txglCopNPH7pmLM7QCwVYzPJvceG04LfcCkLW8R2M07');
clB64FileContent := concat(clB64FileContent, 'N1ZU0sLhj8gDfdAZw4z0saWnco5GvRwR5l0vKPJSbinb43g9zKp7bhXubGCGTK7b+Xsn70jv2Km+');
clB64FileContent := concat(clB64FileContent, '0qAbnkIb+1R8kAX3m9K8ikynVzA96JPh637/sFy+BtdrOCCMQ44d7QII8Gh8xwxBYAIAMmj0+s7+');
clB64FileContent := concat(clB64FileContent, 'NlEUUAgOximI9mRSSYYEt6o5WD2FQceu8RubbUJFfj57PPFVdhYfXsxxmf4Azbu/x4cPmn6I3/NU');
clB64FileContent := concat(clB64FileContent, 'xfSclYxDw9u86j/UFkh5nFBb/pIJnWExXoPZ8eI+gu+GvTRYfZu8M9uqj6wC8YOfZOXGqzEIcatn');
clB64FileContent := concat(clB64FileContent, 'Z1OcLPbR0t8Zughy/45Q3HYemoCk0m2c58GhNOSlvtLBsBkhLmDyXEcwZf73j7xRtkELUoQKg1fI');
clB64FileContent := concat(clB64FileContent, 'eOhX3lUOcbnXEJ4Ceok1Au5Tjj+BasMDXOrYrfyGzv8dLY4W3FJczctb+sEZ89S6PvEbumejNTRF');
clB64FileContent := concat(clB64FileContent, '8ty5fVnpMsvav9pzV+yQpBrNoxcw1VE+HCa1F3Qs1nYCoGTddTI77VK0iaR0Hf4GCzKVwYZTc+PC');
clB64FileContent := concat(clB64FileContent, 'LckSxJCWOxK9YEMCD+i0uakY+c/Zakwgxq3usld2qpDc2Ac5tt5p4Ni5ZIKO5HkMCHvqZD3WyE0l');
clB64FileContent := concat(clB64FileContent, 'XUPArN2PWbuGB0Ulxtxa8Inuz9Mm5wk4YBfwliDkC4sW3krhAwTvPn3VuW8VREUPvVeCzN95maEt');
clB64FileContent := concat(clB64FileContent, 'jysAYZBaTYJ5svZC11xzXratx0Q+XcpbfitvsB5OhhIDnlPRkHPB01RQM6Ao0gwlVZ6ecPJvwe6i');
clB64FileContent := concat(clB64FileContent, 'j4aTaB0dNmdW0HfdkOgITRtBuTeKDvkLacEU2sp22jKkmAiHDbibc//psBKS/Mvg7Nsbm7fzcIEn');
clB64FileContent := concat(clB64FileContent, 'Y+S2XWLA8ZZVRHOpwP8BIaGX6tGdfwOXH4b/OYRK9jUJXwLsiROiLu4rGqmUIVOOx9ojGHGr+V9U');
clB64FileContent := concat(clB64FileContent, 'd2tZDQEV9P6ePVDDKwoocuVpsDwOfnSgitUujbOI9/3kInJWmRfJzCdIdSw0WF9vqfhDZPL+aw0D');
clB64FileContent := concat(clB64FileContent, 'hHg9mstg6MJNgrJWXiJx9u2QFGP2NPtqsfWOUSTjf8+T3aEVs3ny3sfkwCeQ3rc2THnRSD33smGN');
clB64FileContent := concat(clB64FileContent, 'geEOJUtpqWUzlccMkRUy0uBe2dICtAo21cAd+68kwT37REW7lFZbVocL/ki8Q+eNiVt1Hf6dWTxq');
clB64FileContent := concat(clB64FileContent, 'xx9pCsuv1JD1To3PJ25BvtxS8BU5VsBi9W+r9N6hjEZvzjPQ2/u9lB9LkFyp5dVauE3cnHrykhW2');
clB64FileContent := concat(clB64FileContent, 'u2g0s2MzNiiLShhvkx9oMY5Bnak4VbY5n6Y9XHb/AKHJpOXOLsJlmmegbR7WL9TZhkK13EJ9hRe8');
clB64FileContent := concat(clB64FileContent, 'd0a9DSTwdZYPZjZtz9af0iAeTRypJ/Kz1e13qYhQ/vDptSex9OGNQkc+PfTAaIkDXNkLPTATxVem');
clB64FileContent := concat(clB64FileContent, '2qEvRtp8o2FB8ZUcj3RaY8RTvZGRYN48iKfwV3+M4arl5lj+Z91ZhCUG8azoBvoSfFDbrBSn+zGL');
clB64FileContent := concat(clB64FileContent, '1XJERJVMbAv/I/BR7NgNWiYHem+/y44u8ucVon3PvSbqrU/ovZdKsApozFsX6SoP5I4ntZEV13xV');
clB64FileContent := concat(clB64FileContent, 'YpeBkjpMjnOLS//uEaE2l3PuMo77t4VNsw0iqYKnAkpT0ek+RY6QS7j/ttrdTCpJ1QneftubJidW');
clB64FileContent := concat(clB64FileContent, '7VbkLeMOdMNAeIHEyC7PQXmZWdi220XL/9HGF51acQ48PZlXZnZTEBJ9XxDwzdSVLOvaYRQFcdv3');
clB64FileContent := concat(clB64FileContent, 'oRq3fzRBDg++3tKPfXKqTHfKqoH/xICO0JMqeqCxJlRklJYZ8NfbE5ovRX9b0lUgvvVGtKYoCnVd');
clB64FileContent := concat(clB64FileContent, 'pwHLHS8MjvIjNnIZ4ufx6ro81EowRx9CLGfMkdC+/ey2qDxtAbfBf0AwHF0lX7dxKDg7iBou4OkW');
clB64FileContent := concat(clB64FileContent, 'E5rMluSEvNZqidDu6M1+6NkrQy4x3wo0ZckOgzBTM54EqKuLoakmLjQUwQ6nxRbK7ClX1kp/KWky');
clB64FileContent := concat(clB64FileContent, 'RSw9FjVqyFlRCZGr59+p49tzUdOXFAGnxe0aZqKqHFnhGI3UyYL69qhZgkUNCcHjOX/1NfFQ8klu');
clB64FileContent := concat(clB64FileContent, '7zph75ib0IT/aktZ+ADGLnMbybh2OnUYTig4W8yaxBXsZp361R47VDAc1pAsHjEdHX7kCTirzDbY');
clB64FileContent := concat(clB64FileContent, '6Z/1OOBpfnIR25j3DwC+mQd3rA9YLl4bA2+dF9hRxraB6ehgHz3bA/Aflu+vMOZHsk5OH+NskpLh');
clB64FileContent := concat(clB64FileContent, '3OIdUqqzGy+Hs5887kmDHgagUDJx/1Ap6u+AdiGA5xkj/wpsnlYDmRGMHgH8rrZJ45jrbjuCsiBX');
clB64FileContent := concat(clB64FileContent, 'uZRxVLwxHkNuZy52Z3yupw1usYn/pf1RLCIpa6HPFmAjal5vCKy3S7u1WiKG/M3HplTggUkXSmCC');
clB64FileContent := concat(clB64FileContent, '4bLwb1lRi59VKIQ8CJ98Sz2mMgWFwop+WIjQIkRQEJksyucRxbeiZ7ZOk6N8MXo93SKcgM+ZP89+');
clB64FileContent := concat(clB64FileContent, 'CvY7hqt2Lenq5/fIMJ0ue9UYSxhJFr76GRVPKZP3LO+caWkByZdBNc07tKA1Iu+BlAojNH0yO48y');
clB64FileContent := concat(clB64FileContent, 'wOzpUhDVBuEU67/jIeCKFxk8Ij6y7bLJvmCLcqMA//p7aYKUTtJLUiRZOSL0EoV6j+SBwJE5rtak');
clB64FileContent := concat(clB64FileContent, 'TIHMhGPQjX/wABudz+xX0h7H7nQDBY3KGX8Cio1Bv/YUuxXXYJhYrtq/KbveSJDqNY7kZaUP4Aid');
clB64FileContent := concat(clB64FileContent, '7ETttAgBsUpp3fCKDvgrry0baHz/TX6EsNSWIK+WRKlJ0cdwKuUOEnNrPxOdV8pIOnqicvXt/NZA');
clB64FileContent := concat(clB64FileContent, 'Fb7lThQnDjlj9EMksjbMN2+KnyNadlsGa5i0xMOabLlgeN/ugDOsWk6dehURPueP1UL4+aMZP71l');
clB64FileContent := concat(clB64FileContent, 'ICjdySUoIdsEyt+8pQz9GR8owUjNGA/RVqi1+75ZswTBYHHgAzDh4CjvS28jidD4iRlXNaaeSUVa');
clB64FileContent := concat(clB64FileContent, '/Ku4bo6jjAUKL8ar4iHG0spTIINci+jn7ioVBL/LzhtOfzdTp3pZhenSUF8OGY4F2z/YvvVPTwP3');
clB64FileContent := concat(clB64FileContent, 'Im0B8QorNkL3MAd1M2lnIoCutZF/SA2y9dquRtFZSwvLA7KuMy8pAig99JbGrzpjkD80Fq3PAsRu');
clB64FileContent := concat(clB64FileContent, 'twtHFkis2eA7mA7ZfrqslhJictt/yUO+STHuGyyaGZB++bMxn2hEzJ9pbOBlC1NcT7Zw7p1kE9lw');
clB64FileContent := concat(clB64FileContent, 'QWQ/aD2v626lmbQqp7af2iSR7K2N/YlGpZv2RIhYKvN6dJzIKQsKdBiho6m5jQpF/krkM8AsVSLm');
clB64FileContent := concat(clB64FileContent, 'ryi+v8dg6PbYmiF6aZI30kXRzNpc5MqVC2goclny3+fxu3pI1kHNdZHi3f8piQdj9fEGxZp+tAzb');
clB64FileContent := concat(clB64FileContent, 'NxTCXhSq16JTDKMo8b0h4V8xKmNHzAV7P1TehN01Rh7XB++C0Mm2qjrSOag4lRfLOBtHmipId+3A');
clB64FileContent := concat(clB64FileContent, 'jS1Pldj7ylMYnKEEQCFLEGdHocqOfUI7UEowuatKICrz5zBA3srU1Yg/ck5b7lPH8L30OikWbb4d');
clB64FileContent := concat(clB64FileContent, 'prSnPRfUHCLCwo9JK2y8JdJIPjh3gSWsBbilCQ7s8oReAC9YMkTROvLdsJXNLjoYWeaxj18z4pqm');
clB64FileContent := concat(clB64FileContent, 'PzwfULVBcz846G8FrJT2JleiFVBekTqPKv6vq18PlCCTs+q6kRVRa8AgBWJtsHtKChc3OVqW3rsu');
clB64FileContent := concat(clB64FileContent, 'JBVDl/rAzeZYaXQtWt3l79zRQDUYzhvRfuIz1Tr/y/SfTjFXcCn1CLjt1emBhF7PtB+jNgg/b9u6');
clB64FileContent := concat(clB64FileContent, 'vEAuHqHQbagelCgjaUSlIBJEbY1dpzSK1jQSij4Qadf5G2NL5W/fCz9a2oDB2hKCIUrQasRVUwhe');
clB64FileContent := concat(clB64FileContent, 'Of7LajNGCYwBCfak6N0Jg9CWWxZPXHQLCLg/8UJO1lcK3nNEiciyicjde5bguV9362F75H0DI9K3');
clB64FileContent := concat(clB64FileContent, 'Eml+rxAx9+waROdjcxhu/qmJO6X3Au3sUEfWcj0CEI8igKwGrbPXd4zN4CmRiKXtY3Z47lTLm4M7');
clB64FileContent := concat(clB64FileContent, 'PZC/aFj/D3+X666G0nDBoyq4LPmhIIRMqngJn4/X4gBJojpcQWS8Yv0XJWGuNJunddVUE0XdGqQp');
clB64FileContent := concat(clB64FileContent, '2EW32kLTehn04pL+aUlJ94CJ7jyULl+C77lzahTUkpH1ABW0H0mLTEYkccn5Q6lnbWBeR+tXsVqs');
clB64FileContent := concat(clB64FileContent, '177VbK4Hsu726LIunFggfbzfiCQWGfRv8WOeovBaC1ds0xY5gGcWAnd6gJ3sxYZrT9ytXY+x0KzS');
clB64FileContent := concat(clB64FileContent, '7NEHdRtJ6gBzE12iT7T2n+9JmNDkF5qXd0/IcS8k/NOacKaOqixIxK8cwAirP/xVDLzeYNvD90mU');
clB64FileContent := concat(clB64FileContent, 'IcxAHPdcsnS0PpuEoAd1ve/6TuuY2PPKa3JeYu6Fk+cFPX4li2pyKpj0kbyMPjf6oWKbaxQt6XJ5');
clB64FileContent := concat(clB64FileContent, '/yuz7lfpIoyGudlmM0woXObj6lfQJkg5TDUoDWRL7UZL0S5D+q/H9o+VRz49cYYt5RdebrG/y9iN');
clB64FileContent := concat(clB64FileContent, 'RlW54g7/cZ7bI/IwPKEc2n6WSzbGOJGqueCLXi6TtTtgtRW1GYZYEZnzH+b4jf49a2/2lA+wVPRP');
clB64FileContent := concat(clB64FileContent, 'kucyE1pTBTWBPBqiWOAGrQtuLSLuAWPxZfyDz2t2aMl6NuVYkVldpL2wLX3x1jloLonntNEW1chI');
clB64FileContent := concat(clB64FileContent, 'Tl8og2QGGMdTe/L3DNtcJPCGfePi+oHgVrsS+xwCHovbjqgh83gIEiK2MK1Y78KCTepInGLvWEY7');
clB64FileContent := concat(clB64FileContent, 'qRWHXLg5MPKzFu5n8wBK+leDVzw7zE8HF2bAjxS+uDiBWJNqhYyh7mp9oD6Jr5+PWymV5/UHqB1V');
clB64FileContent := concat(clB64FileContent, 'Zvi44FXvONXkrQenEyu0kOeBIgWSdAE7P8zhffYFud8wVZ9TTdIsabTQKGUYPFmB51jZr9qeisd3');
clB64FileContent := concat(clB64FileContent, '5r6/yGkpQBbVqWTkSqQmRq47HZkRM8UomMi/FvYSDhmALBNsqj8Dp1Fg7SCBItQo/oFjixYMwgRZ');
clB64FileContent := concat(clB64FileContent, 'GlLgcyxxiVlq7DoXZngwqs4SKfzPAprMF72JXMvERH0VQZxKJJEV6du0fw8bLflJmLwspavMOFiV');
clB64FileContent := concat(clB64FileContent, '9lJmpUeDSf8Ui2kgE8eFy99jbfp35WDw0iI/v1X5qCS3RGFxtbYJ+OOJzDVDEFv6dvndzKGtSbJw');
clB64FileContent := concat(clB64FileContent, 'O1y9ZgoMduZrxofCYILd/qWly71nQUqdHsjYsyyR1VEehn/wWkhTFWp10zTkC35ptIqeVS3vFOrj');
clB64FileContent := concat(clB64FileContent, '1RMmsVFEeKPx5dvCQJf5qZOLRGBgcCg9OzAVeQIHHTz/ZEQfipVZDyOEnEy5DGkcX3eEfJbNdN1U');
clB64FileContent := concat(clB64FileContent, '/W1+Tq7U305reYvnqSBakfdqCzaRG19LpXNavceHSRV+os4v5/1tMcgx3vUhYU3HIisMPC7uN5nX');
clB64FileContent := concat(clB64FileContent, 'xADU5p2nPxIF2QUnHkrGZYXWP3W2nZyLEs9gPDmUSOmfprQp8V6h5V2DE4iBa68qxUsaDGESWVcf');
clB64FileContent := concat(clB64FileContent, 'R0NQvOrVFXkzwo/54PVDGWcmq1WvAx76c5Oysh7O+JFCGyZD6FG++BSyVQLNDqqanor2XS3QnKcL');
clB64FileContent := concat(clB64FileContent, 'oqnZg2736Ig4LyOW3PRjKVyCM59UPK8O8EipyHu5olU4j8ooChk1zFmTYyJvD4cD8Qf+Qj7X4UyB');
clB64FileContent := concat(clB64FileContent, 'bLDOoDQILxNT1TiU++3HB42HTq6oVh8+1WO3iVTa64st+xVr2MLWsJe4cKt0Bp/Cyf4VIVgthcnO');
clB64FileContent := concat(clB64FileContent, 'oOb6/9a68diFqti9uXc9Uu5MOY8qW5hYA1YEAz50MOC4oqbbLQG6ONNqSrHI7301mBPTwXdQkZ7L');
clB64FileContent := concat(clB64FileContent, 'shqM4hfDiN8ps+K8MhRFxOQw5r0VCkV9exfBkzW41Kx25KIFOhCs80hlIWYIKf6wXy94JVAFfB9h');
clB64FileContent := concat(clB64FileContent, 'CTPzI18lM/kJxpnbzJ1TniaV1EnuZ02Sq4z3twf7kJ4jPoOJb5uZUai8qLVbrTIOkpC8HxotUsux');
clB64FileContent := concat(clB64FileContent, 'xst1ELYhQWdbp6F6n6NVGSg/8SepXZhqgWz8dcrhcm8DQ07CvddX7JohT4GknP7T0BBIJk7/+a/A');
clB64FileContent := concat(clB64FileContent, 'TiLT1wEwQFXYv1/OiYh0rdUZixjZDi75z6tdZOQS5fW+ZMYkvWuAtD6j41WEQtOSpAyztHWOauzr');
clB64FileContent := concat(clB64FileContent, 'WAjjqCAbwX2/i+2QOHycXI1+YGlr4PZ+3ugOWi8aTNBA6U+WX4xxQmiNVzuvq0FNhMloN8cifPKo');
clB64FileContent := concat(clB64FileContent, 'sLKVpVDWzpVyuDbPXIdZ0mibccsq5zBdPE92y/i92zuCuU617iHWonR2i1GCuLjFKAWD6MkpNvDx');
clB64FileContent := concat(clB64FileContent, '0Vxh/HHxyeyCrP7n6ypPBqIA1ygUliXICZBcmTKh7Zh2K+lnlIlItxYq/SmVD5hCk2tDAzJ86xe2');
clB64FileContent := concat(clB64FileContent, 'aAmB8pnPewlEYVqRdkCUuxdl0aSLJFUKUzvdhk2FvJVij8avnaIoa4Yu0J6K/Hd+PPTsWFXjAxHi');
clB64FileContent := concat(clB64FileContent, '3XB3D+bYGCwSCKPHZZF1XmZUwp8pAPp2MVe8pPZLHGJIFVcob0MrSPnrw5aDdwxiPshBTW5iAGT9');
clB64FileContent := concat(clB64FileContent, 'tSlU4briwljIVrQ/Z00kd5TAM5K5BwUVMBoC4xx/YwxchhJFLnDF5cyeeUfWoLl5xwaOyHP619sL');
clB64FileContent := concat(clB64FileContent, 'qw9GgIcc75uvzfNeCBIOrv+m99vwcc74MQ1lD1RSNjJxGc5LWc84KR9guKGe8LgmPe2vxpXYG93L');
clB64FileContent := concat(clB64FileContent, 'Mp2qtj7pqZfRv9NM9ZpIPebMnHjN99WSxCxnn9MhoI0IiwYzi8vhZ18naQ7bI/1lTCxPDiNDI3VH');
clB64FileContent := concat(clB64FileContent, 'ZLdg+M/2m0svDYSXFJM0dCE0muWxpNFz5bAp8ObNKdNO0+sd/FgCD7W/YtKwCa1cE+ZWDkINj61z');
clB64FileContent := concat(clB64FileContent, '33srdOmXFB4gLexICB6DSTP5OgyeXdQOUTmB3ky97PReH5G5TMJuIriVLdShVnu+2DyQcN0PJCIM');
clB64FileContent := concat(clB64FileContent, 'ezy/7MsTWmnMI1NYm58412YQz6w/UOzZbPkybpMGCZHBt729UPen16yJc2L8AhcBqs+2WINrUP1j');
clB64FileContent := concat(clB64FileContent, '+OgToQrb6sWsuXWm/xOt/Etlhk7pI3ZcaIBEvchCnTX3CPmqwCP2toa9SfILTaPYdjJ/wZQ6R6IM');
clB64FileContent := concat(clB64FileContent, 'kzNd+/zkhm4dNzFlx8CPWHhAfocVnbcLuw+Mrwg8BtNsVYdsjwp6zS1zgx0JLColDflwyKqop7ib');
clB64FileContent := concat(clB64FileContent, 'SYIqFCsxSNXrv3wXhPcghCiQEcjPm+uL+LV7pSSGuheBIQVJXDI/5L/cmnXaan28loh6QzQCxrF7');
clB64FileContent := concat(clB64FileContent, 'fe87UTQSXLks+rRL2gI25BKZ+xm+DzrTSJAKYL37YWEUsio+YAWg5cC14aS7IUyhgQ7Cme+YRAmj');
clB64FileContent := concat(clB64FileContent, 'EeD7k5JhPUwL8AcyoaheWX/pC+SxSM0kdI9xoNo/zR/33u+KkFsKaDSLI9bRL3nn7GTbHdnfj9YB');
clB64FileContent := concat(clB64FileContent, 'WmyOPKP7/Bunohu3d32GHYp7Lq+FbpHkRKm/6Ey5kX2nmJNwM1h4D2it9Uc29QhevMGHKsUHo81V');
clB64FileContent := concat(clB64FileContent, 'w3+x8Xbanvi2IetJtQjqqyTi7O/9CHQS2B4ZfqG7kTR20+PjHbnPMTanBhu62HWXLoYcJMRD/oAr');
clB64FileContent := concat(clB64FileContent, 'ObmZm14PsjtKdHgDHGXQPvf6kPUghrPA0qQAALuXi1bWL8ne20fgNWpaCcoGv8atW0oodqBYkj+m');
clB64FileContent := concat(clB64FileContent, 'oyp4VInxH5TQDdPLU2DjTdv7pkvz28u+fjOeYp4EiTEfkYbnH5l5vZ9TC3Tb9t7+4GpS8wi8+Cq1');
clB64FileContent := concat(clB64FileContent, 'CxK6GPzpXjmg6jel63qET3YGg92BRnolZLOCICPWwsFz9y9STaC9AoeWCibYAJZY9ncOeWaX5K6A');
clB64FileContent := concat(clB64FileContent, 'q2qcVzVuE4bfhL3/r4TCF0ot/xz+fxbwpqmULz9aT/N5/YBoHpYBoosQznDO4LZpObH0hONnlE0P');
clB64FileContent := concat(clB64FileContent, 'KdFBIxwVq49vnyW9GMYV0uws7DTABdcnDq1gDIIn9hxHEJBaPXnFmxIcunAPXsxY4xjQcWixt4Pl');
clB64FileContent := concat(clB64FileContent, 'dXdXQHxpS5WqmcdmVGUpqeGB24f7VhOg3d7p14851Tuzlitd9zmj32yAiRLaWJpCwYotcNMNeadI');
clB64FileContent := concat(clB64FileContent, 'C7iIVlebXNq/GBiypcpjAgkv2Tb8H5aAw9PnOoEDtrwrgOcXDsj7drtIkGZUovlEKudKGTKZ4hWQ');
clB64FileContent := concat(clB64FileContent, 'cV48KcOtXMke26NR2yUos4w6GZL6qfpj2EfDldmpq1829lmtAMBwyHcQUQapnwXjAPVrq6mXkyrG');
clB64FileContent := concat(clB64FileContent, 'BkDOE3forMmMwPminmdl3r6+lXRIyb5zMYkB5BvSrvvFuZA1b6V6kPOyU/BgzxFwWaDtsK+f5Ltd');
clB64FileContent := concat(clB64FileContent, 'IhBTOruzrC5YOZn88EhJ8VykLg+OUBcifEZQCDHynHyqM4u0bEJefWnzrjqHIGDdkzZEJqeGQqmi');
clB64FileContent := concat(clB64FileContent, 'Y7nZ1vj06r/Zna5i+gBt+StN0uPP427F2s8Uh5Xe025+3EKmSfkB+m5yonYOeZuupRUtbCVIv4dV');
clB64FileContent := concat(clB64FileContent, 'gOsaH1ZLQjFbWwaso2IWA9hHEoEdK+SjiFlYZz9zUI3rb7nJg4r2I2RkTo7TithfecMakIHXitpL');
clB64FileContent := concat(clB64FileContent, 'N2URDici47j3H823LmnUTm3UNJgOAFDPMGWLVfApIr5Rdk3tfBogghKHbVF9QGJVnaya5UREFNwX');
clB64FileContent := concat(clB64FileContent, '51e7SZrVfiOJRiXT1KYMOVnnbDu7twgOxNie0Ait5H4mBwTS/dt8ntg0Iitia4GLQK0ctFgl2gPO');
clB64FileContent := concat(clB64FileContent, '9DsDTQmr3nUJMHl/irgFnM6n69+gqt03jROhXNu82aMl5lrFlQQGb9K7W5g+g/vEXC2mWPdu3d8V');
clB64FileContent := concat(clB64FileContent, 'NwNB6tcvZM//ZM64aVHyH977xOK0Qw3c+oUVvEOx+e6DQRdW6mGPGuretbuzbdEnIyT05EuumdQ6');
clB64FileContent := concat(clB64FileContent, '/ydaJUP5m3rymB4tU6GOSe9NSada9ommO3OWgipb+kfRkEd/x3lqTAvrqSIjXAXUBNmdQqb9ZoA/');
clB64FileContent := concat(clB64FileContent, '9RsH6tu60OfMQnYBteEhtBMA2Jg2+G8gmh0nCoL4v+sW2GiiogDx3VvfPsdxFI6br3CYgJGaBjlG');
clB64FileContent := concat(clB64FileContent, 'djQsRCjwiZG+9v52E+keASQzYrz3iFU8qiCENki6gTc6ltUPUkO/aTEmIUYgzWFKNf8gPC8p34Qm');
clB64FileContent := concat(clB64FileContent, 'Yb+3uZoe6E5OlySPPEq4gC1wmUgbYEGVzx5qClPMZPO3ZBWNzHaMkrrXFEMz+LaPE8pkMgUM4Aht');
clB64FileContent := concat(clB64FileContent, 'DTwrqHS0PFIVX8wAkio1Z9jStCTxiWv4brXbrFi6HAIdcrJfdw66OaWKQGE+4n6MxV3OeU3VmwHq');
clB64FileContent := concat(clB64FileContent, 'BIISKs95oq1N0IMmwgxCbHR6SwA3v6KaDlATvED/RGxLmg03FOjrqw/kZGM5YTeiyqLpOM0MDFtI');
clB64FileContent := concat(clB64FileContent, 'CMHlVEnC/EzrPLwhYfLN567WS4RdY2uOezmjLODcx9zycJCvoW1iVCvILuB3Ga9rnuxSFfTaic2U');
clB64FileContent := concat(clB64FileContent, '8EWVHIHrRwR9BD9h0OVzoX1FZRm9xqwie3KxLzjN6uZK6phli39Z3svBMeqMJ2zajLGsGotSSxWy');
clB64FileContent := concat(clB64FileContent, 'yjIFf1nj32cpSdivkbicRTYxtLl3wu0EHSdqxvu6fH2n1tGstiAz8n2tpRpBIG7MHyhHpJrMnuNS');
clB64FileContent := concat(clB64FileContent, '4nrpTHIwOu9KjQVh+1yZiQm4k4QBBNzdaZfT2qKc5IQC2nmljPbpNUtjUwsFuqXTUxrl6hcLwhNW');
clB64FileContent := concat(clB64FileContent, 'gYSgN0rKJZMwydF7AA7tpGAevlR6dv0+kznEIEQzxPtYiT9m9+n0C1yTAZEQp/BrK41hZ23gWsSy');
clB64FileContent := concat(clB64FileContent, 'JU92a9C3sQWaFXSQsJeMrVPXOIDtBR8/JVTQd0ZIr/KaJ+s+Tdyg1/FuBoHmt1lQQAE4ZMoD/NIk');
clB64FileContent := concat(clB64FileContent, 'JbnR7rspSYlCQ2lvQ2v/SyQV0MCWQ+9IAnbt2ugzicdyH/+PY3Mb4KoDqnfyV6DkeXXpbtQoj5xY');
clB64FileContent := concat(clB64FileContent, 'tNDHkuVBjJcpUd4HxH/ZfF8GKEauDskwmF+kYDVZk4aSKu1uulLM9A3rX9aTDRnCP3NCy4/cm6fG');
clB64FileContent := concat(clB64FileContent, 'HmPhLATSiV50g+FVah9oldIeDLC+tU39xsu+t/LqkQCv4QJF4rzLFMLDGzVQEcZfRCDi+/Lv/VG4');
clB64FileContent := concat(clB64FileContent, 'w4n16jQoLU32enm4OroZBMwXLnrYN0cVY6v/NJoaTLxGYCFIJ/BXwRnpkYGF/bsoFYk33RJ5HNSM');
clB64FileContent := concat(clB64FileContent, 'RY0LhTR4R+P4oLT2NLEA/CJwMpYlQYDnqka8pZcsekvh0+NwxWo9H5NUpzFtBpu4AgLU1/aRFcaU');
clB64FileContent := concat(clB64FileContent, 'Rf5MArOuMGXFhZRXOhA0aWlDoaWyGyyhug2HDB96gWnCmXKpml++/hbQNMWAG36BwO0/SL5QeaNJ');
clB64FileContent := concat(clB64FileContent, '+Hu6Pr1bv10ONsynk78MsDMyH3Kcra3VY4yF1GcyBuNFIEPZMgZ+jxL4P7Ak5WHfE4B0F/05xb3H');
clB64FileContent := concat(clB64FileContent, 'VkzTvDryifRtcWno5xkvzgN09mmC55LQhFNfAfgnyEcJcZDLRX3LVv/dkX1xp6jXGH5PSkoussEC');
clB64FileContent := concat(clB64FileContent, '3EWtItg4vp2EUgSdFgwjjeBlcJG8Hd7an09JCmWwTAPEMMseQdqi+E4H6504qlXv006A5VS5htjX');
clB64FileContent := concat(clB64FileContent, 'agZPypJnDTezeH1UAXrqfsu7bR6xOjLSvJiOVj9Jdi1hi1pKZ9vyhzkueIAdfy1LxMA34TK5xYYQ');
clB64FileContent := concat(clB64FileContent, 'Z0XvffOtZ4hkphJxulAnZ22TTpL8SqDyfL1KRYqV4yZjDNZF9Bj+Tu0rUgml/Pkw5cg+tAdBN7Gs');
clB64FileContent := concat(clB64FileContent, 'tWikcLWL2xYdC99rWv4oA20fODy6jtmMsAyF4hxR8hRpvm5+dv9jCgX5f0u5g39IHb8lKVCwyQEp');
clB64FileContent := concat(clB64FileContent, '/n/yIoyzUNDB/rA0wkPDKZlSec9O+T7bhkMQTOhfPkvQZgVlEnzbqksNWGmuNQ/fRvBP2xYDaef/');
clB64FileContent := concat(clB64FileContent, 'kNwKepnTML8O8Siway1moo1t1BHi8ulsdFrBe00CdSbtkAoyJvQhs2OrD6SugGvruZ9ms+mbq7ur');
clB64FileContent := concat(clB64FileContent, 'UYaFiAJnzfq2DDbRUp+1ldtGYuaHorPQCF1KRi4CNEIt9r5TnklXTa8/g2OPXXVpYwWrIq4mkIru');
clB64FileContent := concat(clB64FileContent, '2RYGEND1D9pesxSAy1GCAp3lutRZ5X/94yP4Xog6HOR7pKEpgi6X6OGvmEIkxK1eXYIPD6S3gQdZ');
clB64FileContent := concat(clB64FileContent, 'cLNgD9ul/jK8LDWVutslUV0vCsTsvaX5q3VWuqQso0cKPtOFZOmzou+2xESZyl9AoAqW59C7CXcr');
clB64FileContent := concat(clB64FileContent, 'EIq9RTVtzKmiVAu0FKaUJUyxR4tarQt1jGgNEfk37gAAAQQGAAEJrMIABwsBAAIjAwEBBV0AAAEA');
clB64FileContent := concat(clB64FileContent, 'BAMDAQMBAAzAAJbAAJYACAoBy8JiAAAABQERLQBUAEEAUgBJAEYAQQBUAFIAQQBOAFMASQBUAE8A');
clB64FileContent := concat(clB64FileContent, 'UgBJAEEALgBkAGwAbAAAABQKAQA0wIcCanrWARUGAQCAAAAAAAA=');
    

    blFileContent := fblDecodeB64Clob(clB64FileContent);

    SELECT count(*) INTO nuAmountRecs
    FROM ge_distribution_file
    WHERE distribution_file_id = sbDistFileId;

    if nuAmountRecs = 1 then

        SELECT VERSION_NUMBER INTO nuVersionNumber
        FROM ge_distribution_file
        WHERE distribution_file_id = sbDistFileId;

        nuVersionNumber := nuVersionNumber + 1;
    else
        nuVersionNumber := 1;
    END if;

    DELETE FROM ge_distribution_file
    WHERE distribution_file_id = sbDistFileId;

    INSERT INTO ge_distribution_file
    (
        distribution_file_id,
        description,
        file_version,
        version_number,
        file_name,
        file_source,
        md5_hash,
        distri_group_id
    )
    VALUES
    (
        sbDistFileId,
        sbDescription,
        sbFileVersion,
        nuVersionNumber,
        sbFileName,
        blFileContent,
        sbMD5,
        nuDistriGroupId
    );
    
    gi_boframeworkapplication.AddCustomerApplication(sbDistFileId);
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP FUNCTION fblDecodeB64Clob';
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
 nuIndexInternal := TARIFATRANSITORIA_.tb2_0.first;
 while nuIndexInternal IS NOT null loop
  IF (TARIFATRANSITORIA_.tb2_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (TARIFATRANSITORIA_.tb2_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := TARIFATRANSITORIA_.tb2_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := TARIFATRANSITORIA_.tb2_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not TARIFATRANSITORIA_.blProcessStatus) then
 return;
end if;
nuIndex :=  TARIFATRANSITORIA_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (TARIFATRANSITORIA_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(TARIFATRANSITORIA_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (TARIFATRANSITORIA_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := TARIFATRANSITORIA_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  TARIFATRANSITORIA_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(TARIFATRANSITORIA_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,TARIFATRANSITORIA_.tbUserException(nuIndex).user_id, TARIFATRANSITORIA_.tbUserException(nuIndex).status , TARIFATRANSITORIA_.tbUserException(nuIndex).usr_exc_type_id, TARIFATRANSITORIA_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := TARIFATRANSITORIA_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  TARIFATRANSITORIA_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(TARIFATRANSITORIA_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = TARIFATRANSITORIA_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,TARIFATRANSITORIA_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := TARIFATRANSITORIA_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
TARIFATRANSITORIA_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('TARIFATRANSITORIA_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:TARIFATRANSITORIA_******************************'); end;
/

