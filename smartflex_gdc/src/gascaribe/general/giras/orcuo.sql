BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('ORCUO_',
'CREATE OR REPLACE PACKAGE ORCUO_ IS ' || chr(10) ||
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
'    gi_assembly.assembly = ''ORCUO'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''ORCUO'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''ORCUO'' ' || chr(10) ||
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
'END ORCUO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:ORCUO_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;
Open ORCUO_.cuRoleExecutables;
loop
 fetch ORCUO_.cuRoleExecutables INTO ORCUO_.rcRoleExecutables;
 exit when  ORCUO_.cuRoleExecutables%notfound;
 ORCUO_.tbRoleExecutables(nuIndex) := ORCUO_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close ORCUO_.cuRoleExecutables;
nuIndex := 0;
Open ORCUO_.cuUserExceptions ;
loop
 fetch ORCUO_.cuUserExceptions INTO  ORCUO_.rcUserExceptions;
 exit when ORCUO_.cuUserExceptions%notfound;
 ORCUO_.tbUserException(nuIndex):=ORCUO_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close ORCUO_.cuUserExceptions;
nuIndex := 0;
Open ORCUO_.cuExecEntities ;
loop
 fetch ORCUO_.cuExecEntities INTO  ORCUO_.rcExecEntities;
 exit when ORCUO_.cuExecEntities%notfound;
 ORCUO_.tbExecEntities(nuIndex):=ORCUO_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close ORCUO_.cuExecEntities;

exception when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not ORCUO_.blProcessStatus) then
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
    gi_assembly.assembly = 'ORCUO'
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
    gi_assembly.assembly = 'ORCUO'
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
    gi_assembly.assembly = 'ORCUO'
);

exception when others then
ORCUO_.blProcessStatus := false;
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
FROM GI_COMPONENT WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ORCUO'));
nuIndex binary_integer;
BEGIN

if (not ORCUO_.blProcessStatus) then
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
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ORCUO')));

exception when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ORCUO'))) AND ROLE_ID=1;

exception when others then
ORCUO_.blProcessStatus := false;
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
FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ORCUO'));
nuIndex binary_integer;
BEGIN

if (not ORCUO_.blProcessStatus) then
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
ORCUO_.blProcessStatus := false;
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
FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ORCUO');
nuIndex binary_integer;
BEGIN

if (not ORCUO_.blProcessStatus) then
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
ORCUO_.blProcessStatus := false;
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
FROM GI_ASSEMBLY WHERE ASSEMBLY='ORCUO';
nuIndex binary_integer;
BEGIN

if (not ORCUO_.blProcessStatus) then
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
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;

ORCUO_.old_tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
ORCUO_.tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
ORCUO_.old_tb0_1(0):='ORCUO'
;
ORCUO_.tb0_1(0):='ORCUO'
;
ORCUO_.old_tb0_2(0):=3843;
ORCUO_.tb0_2(0):=GI_BOASSEMBLY.FNUGETASSEMBLYID(ORCUO_.old_tb0_1(0), ORCUO_.old_tb0_0(0));
ORCUO_.tb0_2(0):=ORCUO_.tb0_2(0);
ut_trace.trace('Actualizar o insertar tabla: GI_ASSEMBLY fila (0)',1);
UPDATE GI_ASSEMBLY SET ASSEMBLY_INFO=ORCUO_.tb0_0(0),
ASSEMBLY=ORCUO_.tb0_1(0),
ASSEMBLY_ID=ORCUO_.tb0_2(0)
 WHERE ASSEMBLY_ID = ORCUO_.tb0_2(0);
if not (sql%found) then
INSERT INTO GI_ASSEMBLY(ASSEMBLY_INFO,ASSEMBLY,ASSEMBLY_ID) 
VALUES (ORCUO_.tb0_0(0),
ORCUO_.tb0_1(0),
ORCUO_.tb0_2(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;

ORCUO_.tb1_0(0):=ORCUO_.tb0_2(0);
ORCUO_.old_tb1_1(0):='DynamicCallerORCUO'
;
ORCUO_.tb1_1(0):='DynamicCallerORCUO'
;
ORCUO_.old_tb1_2(0):='ORCUO'
;
ORCUO_.tb1_2(0):='ORCUO'
;
ORCUO_.old_tb1_3(0):=11698;
ORCUO_.tb1_3(0):=GI_BOASSEMBLY.FNUGETCLASSID(ORCUO_.tb1_0(0), ORCUO_.old_tb1_1(0), ORCUO_.old_tb1_2(0));
ORCUO_.tb1_3(0):=ORCUO_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: GI_CLASS fila (0)',1);
UPDATE GI_CLASS SET ASSEMBLY_ID=ORCUO_.tb1_0(0),
TYPE_NAME=ORCUO_.tb1_1(0),
NAMESPACE=ORCUO_.tb1_2(0),
CLASS_ID=ORCUO_.tb1_3(0)
 WHERE CLASS_ID = ORCUO_.tb1_3(0);
if not (sql%found) then
INSERT INTO GI_CLASS(ASSEMBLY_ID,TYPE_NAME,NAMESPACE,CLASS_ID) 
VALUES (ORCUO_.tb1_0(0),
ORCUO_.tb1_1(0),
ORCUO_.tb1_2(0),
ORCUO_.tb1_3(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;

ORCUO_.old_tb2_0(0):='ORCUO'
;
ORCUO_.tb2_0(0):=UPPER(ORCUO_.old_tb2_0(0));
ORCUO_.old_tb2_1(0):=500000000014881;
ORCUO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(ORCUO_.tb2_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
ORCUO_.tb2_1(0):=ORCUO_.tb2_1(0);
ORCUO_.tb2_2(0):=ORCUO_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=ORCUO_.tb2_0(0),
EXECUTABLE_ID=ORCUO_.tb2_1(0),
CLASS_ID=ORCUO_.tb2_2(0),
DESCRIPTION='Gestión de saldos por unidad de trabajo.'
,
PATH=null,
VERSION='1.0'
,
EXECUTABLE_TYPE_ID=17,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=4,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP=null,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='Y'
,
TIMES_EXECUTED=1029,
EXEC_OWNER='C'
,
LAST_DATE_EXECUTED=to_date('23-09-2024 14:58:44','DD-MM-YYYY HH24:MI:SS')
 WHERE EXECUTABLE_ID = ORCUO_.tb2_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,CLASS_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED) 
VALUES (ORCUO_.tb2_0(0),
ORCUO_.tb2_1(0),
ORCUO_.tb2_2(0),
'Gestión de saldos por unidad de trabajo.'
,
null,
'1.0'
,
17,
2,
4,
1,
null,
'N'
,
null,
'N'
,
'Y'
,
1029,
'C'
,
to_date('23-09-2024 14:58:44','DD-MM-YYYY HH24:MI:SS'));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;

ORCUO_.old_tb3_0(0):=40009666;
ORCUO_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
ORCUO_.tb3_0(0):=ORCUO_.tb3_0(0);
ORCUO_.tb3_1(0):=ORCUO_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (ORCUO_.tb3_0(0),
ORCUO_.tb3_1(0),
'ORCUO'
,
'Gestión de saldos por unidad de trabajo.'
,
1,
1,
35,
-1,
'FormExecutable'
,
null);

exception when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;

ORCUO_.tb4_0(0):=1;
ORCUO_.tb4_1(0):=ORCUO_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (ORCUO_.tb4_0(0),
ORCUO_.tb4_1(0));

exception when others then
ORCUO_.blProcessStatus := false;
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

    sbDistFileId        := 'ORCUO';
    sbDescription       := 'ORCUO.dll';
    sbFileVersion       := '1.0.0.0';
    sbFileName          := 'ORCUO.zip';
    sbMD5               := '3858ec770ca17505cdbad3cfd7e26e53';
    nuDistriGroupId     := 4;

clB64FileContent := concat(clB64FileContent, 'N3q8ryccAAPlOfS4chsAAAAAAABfAAAAAAAAAEoq9BYAJpaOcAAX9+wFu+r0/5QBL0TuTr0I2yvx');
clB64FileContent := concat(clB64FileContent, 'U9Plq7xO/c6hY0BIQykUfFcxmm1nJkkaGBLomg0YBj0sy/fHRpK4HzK+n2a7pvMs7BoPjYRR4KMd');
clB64FileContent := concat(clB64FileContent, 'xlRcAmPnIxsuvYmgqCZb03X3ZMCyATMmodUF5rLQ65NVVz0QKYt4UvsAymo6S1MzFsINzzJ9FIDZ');
clB64FileContent := concat(clB64FileContent, 'dxXluQKu+kcQFlogMMj9nH15QnX1DcuKVYMVgJmrUyfhyDojIyrPozAzBgWRXDaAkxDeeodebjy1');
clB64FileContent := concat(clB64FileContent, '1E3QLRCwsLPEf2JgvwChsUDljLMdk9gVchCB1qAWciF8eqXiCrUV1OzEH3jXCrJgXFp0F4YRnj4x');
clB64FileContent := concat(clB64FileContent, 'b43ueIWN/4eCrh2Y0IIx3+R7d4VslFfOy5UbfTuFCSqJHhlhWh/wxnXqxp3WYGMDPHaG+3tgwmiY');
clB64FileContent := concat(clB64FileContent, 'g952KuyjoPlNcePSRiJSfpyzXyt2hg2T8fuixNUjGQzcqD4XVhltCSjCPldFrdOV0d8ZIM9wPEXd');
clB64FileContent := concat(clB64FileContent, 'VAVMncAIu3a3dNBF+szS5+jcuJAKlD9uOzZxe3D4coP+so090hOaStH6e6ZUkGeJBE89Cb5qf2ST');
clB64FileContent := concat(clB64FileContent, 'sQMk4sr3izQBqn2J8Jh2DBc/jw30RGJQIB2CPJs4CO2b+5aJu0fOVYZgRpbgcUWnNylsLxAIdft6');
clB64FileContent := concat(clB64FileContent, 'a+TffqNxdJHPPVGwZ6suedv1v5tonGzgxXBq5mUts1s27fDkrZvQw1MBDIoXMYLdkIPdS9dkdOcb');
clB64FileContent := concat(clB64FileContent, 'dH1NhwY/dVQWi3DZSjbvhQn4jJe2LsXOZM62J4D9jRMoM4+G0TYBh4r0dDQPjivbn3MXJhpqk/kc');
clB64FileContent := concat(clB64FileContent, 'Nfh5m6TFlsOJOABnt/6lwrUEixcN/qKc3HPxikaospwqgDradQgYSS/GDFG7lDaNR46C72LGNqnU');
clB64FileContent := concat(clB64FileContent, '/e66BMcyVhcOhh0UGf2jMV+y4+8khBxYlxGpzBvtPdye4Oizt6CyTutzCd09/uUmrBm4aPkVsMmc');
clB64FileContent := concat(clB64FileContent, '3LDhkIXmzMYg7Y4DjPqJvWYum2JJSYJKWtTxTN9n51FOfyq4OdLP+TS7OSjpLdWWyJF9kJPZHn80');
clB64FileContent := concat(clB64FileContent, 'Lj51DPu+bN45ufbg5SfIN2z1vksvQcsRrPFniphj1D0/sPqPRGSu2qpwVP9bV7eaWc1eAbs7i+Kw');
clB64FileContent := concat(clB64FileContent, 'bZ49KBM26Qzefc0A6+WjXUeb81QJHQkSbbwHs0y8o4KiopIDxPF/3ipZbeEaYnByn4QCc6hMDHot');
clB64FileContent := concat(clB64FileContent, 'WxmJ2hC+0+ixGJevxdfSKONSSs3ZPPsEQeZhWq6W6AlaP2B7y7n56QOlVBMtvf92rkiUEvusUWtq');
clB64FileContent := concat(clB64FileContent, '3bNXksAvu4FQFbkKJgRT56w+ZZ3A8up4lRJ7NHoCxahvvm8cqHjeKsn7QkJ6k+jWlAql3vuFDh/T');
clB64FileContent := concat(clB64FileContent, 'Doco8A2hUqeMM3hbKiJuRBbCBm1vjvT7cJ9wN1wuNf5TkL7gwdPtt30Urn96UUi6Amb+RWBIav5E');
clB64FileContent := concat(clB64FileContent, 'zeFZzysdXxlIvO3gm9TgOmEbG7Gn0OxFGu0tBQwUcOlQQKGu9pbipuBgWYHiUfF2bv7uIvsQZABx');
clB64FileContent := concat(clB64FileContent, '7tDd6qYFhBHSuiAM339DrbCnSUiws36xEHBhUytBGmzsStdHwwM+f435BdD6s0Sn6rIL9alGDatZ');
clB64FileContent := concat(clB64FileContent, 'zZYBeTI2iaPZKAAZpy1M/A4RlDEGUX7B3PQUyLL0f5wpLKLMMvZ9kjVwvyTOoFasgr8V/HtEbjdV');
clB64FileContent := concat(clB64FileContent, 'e4C6pwHJk7cdXbBGNGEqTvtx3SZd6eYEvAkgaDxffXXm8gbg4ZYbhSSD0rDgX6gFNgoIQ8V4nBO4');
clB64FileContent := concat(clB64FileContent, 'r9+51csbIBDOCBqPY6xrbRzsXZhBHI+hzLBuikxdiiCEp8s2viQ+kB4ELg1/LXH1GLXyA5MSumKu');
clB64FileContent := concat(clB64FileContent, 'oclOOlwOklBP0hrTkZEJfZcIaTaRZCDUz5WBXsLwRJpc2w56SL4xBs3uXM9tM79NewLDNYqY/i2i');
clB64FileContent := concat(clB64FileContent, 'NoNvLwy/YY7qcQvhW+RS0/JAvGte00eRVEnOo61taztx1xgpbujA6i97gaTCCLaBy+CPub/t4GfN');
clB64FileContent := concat(clB64FileContent, 'U8e6DDDBEYijRs5mgglvlmC4+Vvo3cu0kO5IFSFtEE/J6TjGK9GIunXAFiCLesEEwleqs4uvRG4z');
clB64FileContent := concat(clB64FileContent, 'Wk7/BJwkP1OSyGHQmYSkC00KjmSxTW3Upf2PnFfPyCFJRE7H13NDAMOMrsevc4EJQNCeAeiZqzqA');
clB64FileContent := concat(clB64FileContent, 'eD7//l2UcJzzrRYJ3vz5dn7a3o6hfiAgdUNamVOK5bK7i/Ciemhd7Ivzq1/zTLI86QOYYqF01Iwg');
clB64FileContent := concat(clB64FileContent, 'AnH4qRGNbRqGOSyl2mgjLeG9w6mQXzBIbBlXwblLIEjda31CUJut3ZOXOrWnRaNzoEXz/pdrlOTN');
clB64FileContent := concat(clB64FileContent, '03r8ZJJn1M9w5BUBnMor2G+3+W1Q9bgP7sF222ExCTo/+KpEISKkDUYQNMr15w8PawEuqqljZZYg');
clB64FileContent := concat(clB64FileContent, 'NwuPY4fflU/ikHYo2zI3w1TP8pgLH7Kg3WUI/DvZfW6kHdLFe0iWifqFBLSGfu4Rl/v8qfehqe0o');
clB64FileContent := concat(clB64FileContent, 'V7XU41EIFdE5XAzd1qqMwu6nH+V48fBh9z7ls7RmWwtuyhSKrmixohADs2+/zJz2hxPTWA0awJop');
clB64FileContent := concat(clB64FileContent, 'n7JLTjIH6Yud8RsdR7d1GNnE/gdd32EYOzFB0BcXEWy3b9Oj3su2zfbOe9WEMw7IbhZp4gVl0aqC');
clB64FileContent := concat(clB64FileContent, 'VIHsm9GhVLpb6I2dXs7vjog66biSl5F5Xgzxdn1RDZ3BB02n2tVOQZqG8PrakjPepdfcW1mrZic7');
clB64FileContent := concat(clB64FileContent, 'TRb6lxK1sT19ERvxkYr3NpNM+HpsmCJiL2PClZwuW6GlKBfN1DbGDpeTKkxWTWL7vIibX5vJGbOs');
clB64FileContent := concat(clB64FileContent, 'bx7Moe/z/nZXVzXsPIKEqx8cMIfwOI18SG1pdHfMJT7DM2ldNHUWFZU0msL+b8PyX78+9rOHyIE1');
clB64FileContent := concat(clB64FileContent, 'GONSWGTyzFkus3kEr3YEhLlhqaeeDS+lfCk9rHdI48RChU76UMQcs15+yIEoSNcvKDCCqMN/EQ+X');
clB64FileContent := concat(clB64FileContent, 'gP85/i/8+aUHkXvgZU7sJtGsMjkYFPbXKANoNo5woKRBvWdKIv1QQZRljDjy01TEziSx5Li5oj2W');
clB64FileContent := concat(clB64FileContent, 'I7qDzwouN8PtcncY1S1Hmx7IckLXGakgMCvlXduViybB1BEetP/2xcXe/q8Ty/J+1DQ2D6cyh4ww');
clB64FileContent := concat(clB64FileContent, 'c7lxEonlMhoLzYXCnH/Cz/t0xzaO+Ra6Oc0Ai8K6TLaNMCsrXNhe/lj/o7WHvD8xmmC6AFO+vJuG');
clB64FileContent := concat(clB64FileContent, 'c7Y7OafQTv4D1Cd9zAxuwcUAMOjG1EN3TlDxJx4Gj+TmRFR5mnT5wTnDYh3a4hhSSq4jjlAJe1tD');
clB64FileContent := concat(clB64FileContent, 'Tc7bzm6zV+O4HELA12KWZTYlE82DJ6POOjPQyMDb+qvfFHT7JL1N1Hv4FhZKefKbyNl4qUL40eWz');
clB64FileContent := concat(clB64FileContent, 'gQh2ePd2ER61ChbgQVLU6hSCqRQ19IEYV9UZ2kEZZzUjBnWAg5SRNIWFFnV4f5zOuu/tneFnpvv7');
clB64FileContent := concat(clB64FileContent, 'm2bDMpUCkcI9pL9KprvogdzYmKj+Iz6SHJ7XZHKTiASkNMXbYiE9KwQlOIICRQCAKoaNHdlKg+r7');
clB64FileContent := concat(clB64FileContent, 'QLLn4r5VddaLQ8jzEOMG1T2IoeHX73ANS8X4F8TnsMdAqppm8w7SedIc9Ak42xjSKzHdc505w6/R');
clB64FileContent := concat(clB64FileContent, 'CDznsnppQ0uF7wF5iFSl0hW1Jc4lOZxlvAAan6jqV3T4lat9jN138AtC9qPhIAIqgSvtdXyLR8f3');
clB64FileContent := concat(clB64FileContent, 'TdkvGETwfOeZ2yN0ThzPo3VuhQy6MAnr/W2MiKD4DZM5AIu33n3mzj982F1cRBs1Jcc49l2UEQfQ');
clB64FileContent := concat(clB64FileContent, 'ZSUETlf03aVgW+8VZWtHS7Aj+qrRVstXeDtDRAxzPLN8Y4ohLtBOMaBuTyiBCE6aGq+c6d2DG1fG');
clB64FileContent := concat(clB64FileContent, 'IGF+YqXvO0jsPqH2hTa+aoHHCD488u6WmgSwrSXcEtqzEKkqzDAtvh7cwCW8CYX4Rjp/VMku790K');
clB64FileContent := concat(clB64FileContent, '9Fpt5r9cvqm/5uSBASPkkFRlY9tSfTRysjOhGxaM+E868xsFiDUaQIYncbqgJ1pB1ydWnZwriNA1');
clB64FileContent := concat(clB64FileContent, 'Jxh6MfomIZX8dC0Kl504mg8TfJox1Xu8Rqmi5Mr8HLdrOuzYPyhY99cbUImMAiW2p+CAECK4rlaV');
clB64FileContent := concat(clB64FileContent, 'NXy+M5SHMxkV+wDd0fKk70mBEtBUKqjmq0L2roH3vdM+5bN4C5KCfGcrKu60Vjsq3C84XkhLQi/3');
clB64FileContent := concat(clB64FileContent, 'Y6wJPVEK59vnYFVEO35o5fR/t8HnM2VxqN9ZYvbKl54Y1VRg9wEXSwSDg6Ni+MbWsH+lzQFc10eO');
clB64FileContent := concat(clB64FileContent, 'p929uGBrrrloaqdobKtv+dG6yDHkgXzfb/3+9Fk194DuVzxB/RRNvCsv4yi2IRET0nRBDYtPTxJ9');
clB64FileContent := concat(clB64FileContent, 'DfodJ3kcAJX9oBkZw14MmIiXMT2f/VS9Qm+5MgFb0nzT/e0NnlFUaJDS2rX5n/H5YSejacOucKf8');
clB64FileContent := concat(clB64FileContent, 'qWp5GveThmnodVprZnYYW23Vz3N5EXuhPC8Zp8WuTcurYmpsId5dtGDnfElOh8eJJH2QL0Nh9lFv');
clB64FileContent := concat(clB64FileContent, 'VyZ5Pyj+9Q0qoYMq4vcRkRJkFyuzMQnW6jPuaCC+JqWRW95wYfjBxqBEYgWjxbqZ0pDcYLzCz8v5');
clB64FileContent := concat(clB64FileContent, 'nU5URxWO1/GcG6Xi0w9hP7liwfT29+HrhX2G612r9BlwTkcpcjb/EVfBaksjCJbOAmYI/tRwYxSB');
clB64FileContent := concat(clB64FileContent, 'icDAlca6vb+OWJvLQUrfoPmUNjlSwZdS6C38CDsRGKylGZHesnMqsjiAXocLjYZ5gwP4P5/A0ZLa');
clB64FileContent := concat(clB64FileContent, '54o1cBKVlSsq7yIbRNwR+9Xu2zs6wlrd269/ttvrbfwk4BVSfbZcBY5BNgZq+rgi7lrel0EbgUQC');
clB64FileContent := concat(clB64FileContent, 'eQFp5Vz3wU20Sh/A6TzHMLhvEy1jgV8EBKGNVg4xZHyji2WOpOosrtIwcKdzebmE0hPMl3FOBY1U');
clB64FileContent := concat(clB64FileContent, 'nFp/iO1Wtv/PxGf0jMd7Y+m5gb9hL70WUVvrb3c8MvqB3D4dD4z4bt1iivr0jM7qiWfXerQo2xSR');
clB64FileContent := concat(clB64FileContent, 'Gng42Y3zbKToK8ua25geQqVLFBdCf/OdjsZY90lSAjhS2utfFb8RnIOAPIH4sDxhwDqx8NKseq8m');
clB64FileContent := concat(clB64FileContent, 'L7V778P041beuN0VAnOkbMNVWgHC3VVOUS0ER5FUTUzYsuEeBUk2rQCHhuVEw24vUvM+tW63EloA');
clB64FileContent := concat(clB64FileContent, 'AZWXGHRMWkSLUP40TmMU8FRvNax570Wl4RSZyn5f5OCT+U2vaYnTOaOlNtFR0CPagzWbNrYE15g5');
clB64FileContent := concat(clB64FileContent, '6HmEgYxn24YCqi98/97xxSVYuHE8gPfE02/2Zr1wjX8GY54g5yMNzr2JofXzQdYYIEP6aQYlBKNd');
clB64FileContent := concat(clB64FileContent, 'MkJlyt6eKe4tsukon0gyR/38jVrl9vvlbH5TZoQ1iF1BGxr2znuw6D1fv8Yu69va61kDOPBPybLa');
clB64FileContent := concat(clB64FileContent, 'toa2W8oM5Rlo2nWmUxAbbMtgmtklkafG+TpBMmbfaNJn1dfs3lZraNj9AIsD28Jh4nP25bi7gAr7');
clB64FileContent := concat(clB64FileContent, 'nmY13S1KDU1uU7JI4rmLAehTLc4Nw+n1RUYG2KwP0FG/nr3ee2Xzq/cL/YdlcjpQ2d5YsiCvHMxa');
clB64FileContent := concat(clB64FileContent, 'C9O32BF1T8AojJl2Nn3oV8YCaSIK6Av9EqOJ8WY7gk3y+aHWQYD2g55v8+wbdz8CvNzHe50goGGJ');
clB64FileContent := concat(clB64FileContent, '7/g4NiWxecpO5EsLVGC2z/bcbg2LkWwQ2rz6yvriGSygS3aZsVb4IrqswT934ItmWAeKWZCQ9vKc');
clB64FileContent := concat(clB64FileContent, 'uHY7TOI5odSprDGflUOju8tiGO3r6u0peeiG0gI9DuJyROZ5Jnguhh/MjaMbJURvmlCf4KJzDtYi');
clB64FileContent := concat(clB64FileContent, 'sUUA4KgHre4SEDQBnl/CjKWglL2X+QX9S2QOHH4802zFBydai1+zeOzxc7s6gwiV7BAooFYwjkd6');
clB64FileContent := concat(clB64FileContent, 'oR88L8B4eecVHk0b/KANPmhnnE2yc3e76jwHZhWYoWj5+2iX4+yjXMC8+31BKWkpwUDHzQCedygv');
clB64FileContent := concat(clB64FileContent, 'Jul9yzN/CKeh7lWJS/UoFZu7bNStK61OUyIKjCVaB/rQpuW2fauIvHFYlreW5p6MlONg9dXpqXYP');
clB64FileContent := concat(clB64FileContent, 'asoSvVRPjPItzqg1x+fMyUGEZJovpyBbjbQE3dmEH3UZnAq2pkolpOwioz+Ja79/0KFseC8dX8jc');
clB64FileContent := concat(clB64FileContent, 'br1QGT7Lva+1iuzHmVe/WWLsXgY59a5BEvkU9sQBMybHIDs8VQUXkxedu5ESLpkyhGjpFzMDnmhq');
clB64FileContent := concat(clB64FileContent, 'nX25UckZ6nq+yFmDlHH6mWR8cqaOX9J67n4LEDvi7pW8Pd6HUN2rJYUfE27j/xyNtbnl6sXOSFpa');
clB64FileContent := concat(clB64FileContent, 'yZvCAjpRPUrGcWD9VDNyPOXOBEozSjXFwSCRdpUHh5i7Gp5I9i8SnjSKcPXkrQS5MUPsT+NhJnoG');
clB64FileContent := concat(clB64FileContent, 'Asi3WOrJRSnbAu0deigBs/ApuZ1hpeTUJr5ZtEGtDFL2q+yYfMmjNU9S1kXhDgdv+hJng/ePUT7P');
clB64FileContent := concat(clB64FileContent, 'y3Ea/PHSkKwcpbn0KgqdObccZ1w9FSa9g7e++1VG1LzZAx8CHnL1wDlUeU90/GuFAA9pt1xEigfN');
clB64FileContent := concat(clB64FileContent, 'bIquS2LifKJQP0UXMJONTxEcxvl215mfliLBA51/URHCZhVd01FD02fu3v8O93wdyFO5G459enmf');
clB64FileContent := concat(clB64FileContent, 'voZLMqx8ijcPEsvfjW55cIw9wUDuLbzD8UiOqixYkZgYqVEGrLtCTnSRrSyBxJ4STRWxuTSxbjk3');
clB64FileContent := concat(clB64FileContent, 'joPAZ3CfyQO/qz7eIaFyNAmnYH8c4IUYvzesaFsiIePcOSZA43XYUkqOo0YwsLQ9jAqmMvbkf7CV');
clB64FileContent := concat(clB64FileContent, 'aaugGBWCsmMxqN02qnJyLXQ8gjKFq05TvM1xjDqqDLsVPrZ2SEvwDZxQJn3OfaJtuysF67zICKOA');
clB64FileContent := concat(clB64FileContent, '639vyQ3gHsyhpYyKamUXtEdwCS0MP0hX/zyfRDS7eVkUESmfzYGPRRblkgTECbTbViQEh0WQLjbO');
clB64FileContent := concat(clB64FileContent, 'Lz2l7deK8gCL2yBVq44clJJ9FAjNhWdDdvd1H8pHXP99X9boVShMPjtuRvjom1jCRlP+4RIjgIiM');
clB64FileContent := concat(clB64FileContent, 'uHfP2/ZOuZgluv9kr1r1OT6HTuO/biUaWN2ZVN/V266NH7WkXyeRAwhEulNnvj+Y0EXVQPHTOC+2');
clB64FileContent := concat(clB64FileContent, 'Dtcoflw5hFyCBDYmWTe43x+HFROS4gqOKaUDAHZTakhGbOwsNYZcwHm4k3/Dtb0AYi5fA7Te2686');
clB64FileContent := concat(clB64FileContent, 'nYw7jm77Fd5DFm2gSVHmxDOTfXocN0wv7IPZzv6sNiA0kKwB5CtytTZmY3IdFx32lbx6+JF//8w3');
clB64FileContent := concat(clB64FileContent, '3lLl84w4a+a5BbtwIjk1wWl2rjeS0pVIKbpLjWtOVW5isP9SGcKRfKz5TwfElPZ5DY+GRc/m+2bk');
clB64FileContent := concat(clB64FileContent, '6e6l+WaCqgZyG8v8ZoibPrC6GwDr1Ge3+ToQf55osuPO+2Jsf7l07f6U+EhMWgGwk9U2E7qctk/C');
clB64FileContent := concat(clB64FileContent, 'aTUnxNBM9An0MWtSqK4FR/nNVBGO4HkSttkZ60bKnwyC4b5hsip7jgNJlS7Y+o0pclI5xHUhUNxI');
clB64FileContent := concat(clB64FileContent, 'py7SRW84OZXrPZsadioBZBaWGhgr8XaJ73gjmMMP/eChDTXnGj8asH2tJ926xASaavB4HHMn/qWw');
clB64FileContent := concat(clB64FileContent, 'LDmSo3RjYn6Gf4qr7r6IA5FuZcjs4TqtQrWbxQ6pyWiaAimNACfzzBtvMt76helmVfUx4w/lwEah');
clB64FileContent := concat(clB64FileContent, 'snDTcapFUXd7QmeZytXVFnFkgjhCeJHAfgA179g0tRWI1xI7o/gtPHR1Dj8DhUmZMbAhyoeATGqj');
clB64FileContent := concat(clB64FileContent, 'G0Gjoh7VSBTZ8xTPHc5Cq3UuGu8zCs6zLhYwo7a4azK8hDf8lLiXdHlBxlE2OlTORZw9jar0he0N');
clB64FileContent := concat(clB64FileContent, 'DavjeCzqM7DeUEjoNabyJi4++gmgydMF70a2KHOjItbTTVyieUMR4S+7ZnblZZcg/QYP8j+7LsIu');
clB64FileContent := concat(clB64FileContent, 'owohCpty5FG0J+xdcJv2JiK/F9OS8aEnY8m+my5jFXH77aqJ2IF19OED/8jip+dx7SzfSFS0hA3x');
clB64FileContent := concat(clB64FileContent, 'nOw3rFYf9ESgFYF27j5zb5lDVefvBXDF2w1BJLraOSYGs48s+Bxv2jnmC4v3eohXdJPzEmns7vYF');
clB64FileContent := concat(clB64FileContent, 'V0ymJL9dSlQ9O7F5dlKF+O5IT3VDFaSWN990qen+xNR7T6NNPjKI7vT28+03FTICgZQle8zoSnqy');
clB64FileContent := concat(clB64FileContent, 'P+Or+LGdvTuU6qNVsY4fErIVGnri1nt75y1zVJCVX0u6VRNVXDsFZ1GDubOqnKDIa4i4W2TtfB9/');
clB64FileContent := concat(clB64FileContent, '42+CLWgDl3xJ4DikExA9QUvIcAsWKbF8ALRmz2imVghlOrwweZhNiKqblsVU02rC7dAvNrLiy4aX');
clB64FileContent := concat(clB64FileContent, 'phngPMA5NwDGuJIRmIBMZHFhmJjlA9UtjS1Ravrx+bijJgIcA2L5la3FvgTF5qed+AiINDUQFt6v');
clB64FileContent := concat(clB64FileContent, 'v8Mg5gSLVRPtIAWzVq52E6FVVqCbNZ81umwMNC+piBdGIPgfOCF+g99ECJEaM2MH/z6BSsCzFKbe');
clB64FileContent := concat(clB64FileContent, '++yaEniDV3+4c56hXblcIhx2XFIZ87M8hKN2aapxdV07LimYryskON5NNJTkiAUMp5XsrF+dvZUi');
clB64FileContent := concat(clB64FileContent, 'NACiHX+sjUoDvTXtLWpJunSO0UGAGWwgx7nACBW3JNAOnhpBdHNB5eDgxr8Xa7ggpG6BRrSxz65b');
clB64FileContent := concat(clB64FileContent, 'raFdq64fLgBx4SAVP+cR6zRGZe2saFHWPsD5yPGDIosOLaZoA+3yTlZ1pc+pDfltfZR2MQfq7JSs');
clB64FileContent := concat(clB64FileContent, 'sTlLGbzcGowQv7H576rtCfPvfleBMAqeBLXnp341PXWNYSl6fO7icywwXQxsnReg8WllCpLGrfQ/');
clB64FileContent := concat(clB64FileContent, 'u9JsrZkR7RToRyk6Fc8onJgmsGGTUzw91pK4O9dmjfnVPMaT0jg/ARYeCLCYAFsHoqMomTFEhd2+');
clB64FileContent := concat(clB64FileContent, 'gk2AJPe7tmM6K+qMgx1lv4Uxu+AIC2W8YR7wiA+lXu9ohLoRZNP4PSG9N0JpkLi/7bMqYUAJlzVo');
clB64FileContent := concat(clB64FileContent, 'Vvxi8aUedD28Q9mzGeOXKOmcrDFfvdcelf4lobilZR9TlyqZJ9SBR/dK6LBkE7TlpCT66vkFKOEZ');
clB64FileContent := concat(clB64FileContent, 'OPaXQf/woBiXHAcUseuJnkIPM2ofSSNIEoEP7sw8Pb6VDd0IKbwzThcy4kNf3FxezhN7QulPRlx3');
clB64FileContent := concat(clB64FileContent, 'z5Ki/UU6pVlGmY3193iKJFgU7gXWFdC9YXEse986L+r2cOdUmG8/Reg4tMo6fEv1+yVVARFcsu9E');
clB64FileContent := concat(clB64FileContent, 'RGgXzdUYowdTGx50jJrwDnW96qLJ99W02hzvCmB1Ur0/vV8pgRnCiahCCDmZjLvRYkB5t5zDCMdS');
clB64FileContent := concat(clB64FileContent, 'tu5OK4T/qtBPiXre9DspobwZcFYWfvcpY3v6BuHxiunoXJY3yA2wJ6hRyt7WwN6P3eTmCc3bsCOF');
clB64FileContent := concat(clB64FileContent, 'YRkkoWfIQG6gEOO6znDOjk1UVaL28vw8QwF0VpK3nlxsGIUTKqrIR7kBshnQa8jU0sZbOGSv75Y9');
clB64FileContent := concat(clB64FileContent, 'IkUhCqOaU+xC1a4QpjjF6TARpYRPgL/ZKTTBlFQWUsXp1fdTwKZ8RXvnbPDd1hAzABk20fcMggD8');
clB64FileContent := concat(clB64FileContent, 'NWZ43gLPGoSM+zIr1tYTMt/Ah8Tun4O/47dYWv992odrBZDVWZyRCMmAwixidgf9VNFLN3mhd1Gj');
clB64FileContent := concat(clB64FileContent, 'Zp9DhRCEAYsuiN5T/WrCuhu9DdoROCcA6nDd28Vchr/6yHJOlPewZ0dBKNmXbCMSVuXITiNRrKvy');
clB64FileContent := concat(clB64FileContent, 'a0O/ogy91JR8QznUAbCvYp7fcXdS1nmF3go+jQDL4uSjlB84P76gP5DZix+jsoH5AWAijR4/CjOY');
clB64FileContent := concat(clB64FileContent, 'ocR9R4QLgyOKUUE5Tmm74PsRm20tElxmL/zzbdUKLPy5uBqbzD2Xex7SekNhresw12U+a2GYgPbm');
clB64FileContent := concat(clB64FileContent, 'NrrBYm/SI/3/A7acLf5pDS6abtPM55RqNFTXvRdvArPG9KiPKdjNc4fmcgUZeQABBAYAAQmbcgAH');
clB64FileContent := concat(clB64FileContent, 'CwEAAiMDAQEFXQAAAQAEAwMBAwEADMAARsAARgAICgHVqZM2AAAFAREVAE8AUgBDAFUATwAuAGQA');
clB64FileContent := concat(clB64FileContent, 'bABsAAAAFAoBAG0TxKEBDtsBFQYBAIAAAAAAAA==');
    

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
 nuIndexInternal := ORCUO_.tb2_0.first;
 while nuIndexInternal IS NOT null loop
  IF (ORCUO_.tb2_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (ORCUO_.tb2_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := ORCUO_.tb2_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := ORCUO_.tb2_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not ORCUO_.blProcessStatus) then
 return;
end if;
nuIndex :=  ORCUO_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (ORCUO_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(ORCUO_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (ORCUO_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := ORCUO_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  ORCUO_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(ORCUO_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,ORCUO_.tbUserException(nuIndex).user_id, ORCUO_.tbUserException(nuIndex).status , ORCUO_.tbUserException(nuIndex).usr_exc_type_id, ORCUO_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := ORCUO_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  ORCUO_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(ORCUO_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = ORCUO_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,ORCUO_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := ORCUO_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
ORCUO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('ORCUO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:ORCUO_******************************'); end;
/

