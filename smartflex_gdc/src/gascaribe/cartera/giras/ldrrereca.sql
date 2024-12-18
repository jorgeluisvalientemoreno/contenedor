BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('ldrrereca_',
'CREATE OR REPLACE PACKAGE ldrrereca_ IS ' || chr(10) ||
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
'    gi_assembly.assembly = ''ldrrereca'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''ldrrereca'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''ldrrereca'' ' || chr(10) ||
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
'END ldrrereca_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:ldrrereca_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;
Open ldrrereca_.cuRoleExecutables;
loop
 fetch ldrrereca_.cuRoleExecutables INTO ldrrereca_.rcRoleExecutables;
 exit when  ldrrereca_.cuRoleExecutables%notfound;
 ldrrereca_.tbRoleExecutables(nuIndex) := ldrrereca_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close ldrrereca_.cuRoleExecutables;
nuIndex := 0;
Open ldrrereca_.cuUserExceptions ;
loop
 fetch ldrrereca_.cuUserExceptions INTO  ldrrereca_.rcUserExceptions;
 exit when ldrrereca_.cuUserExceptions%notfound;
 ldrrereca_.tbUserException(nuIndex):=ldrrereca_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close ldrrereca_.cuUserExceptions;
nuIndex := 0;
Open ldrrereca_.cuExecEntities ;
loop
 fetch ldrrereca_.cuExecEntities INTO  ldrrereca_.rcExecEntities;
 exit when ldrrereca_.cuExecEntities%notfound;
 ldrrereca_.tbExecEntities(nuIndex):=ldrrereca_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close ldrrereca_.cuExecEntities;

exception when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not ldrrereca_.blProcessStatus) then
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
    gi_assembly.assembly = 'ldrrereca'
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
    gi_assembly.assembly = 'ldrrereca'
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
    gi_assembly.assembly = 'ldrrereca'
);

exception when others then
ldrrereca_.blProcessStatus := false;
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
FROM GI_COMPONENT WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ldrrereca'));
nuIndex binary_integer;
BEGIN

if (not ldrrereca_.blProcessStatus) then
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
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ldrrereca')));

exception when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ldrrereca'))) AND ROLE_ID=1;

exception when others then
ldrrereca_.blProcessStatus := false;
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
FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ldrrereca'));
nuIndex binary_integer;
BEGIN

if (not ldrrereca_.blProcessStatus) then
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
ldrrereca_.blProcessStatus := false;
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
FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='ldrrereca');
nuIndex binary_integer;
BEGIN

if (not ldrrereca_.blProcessStatus) then
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
ldrrereca_.blProcessStatus := false;
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
FROM GI_ASSEMBLY WHERE ASSEMBLY='ldrrereca';
nuIndex binary_integer;
BEGIN

if (not ldrrereca_.blProcessStatus) then
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
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;

ldrrereca_.old_tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
ldrrereca_.tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
ldrrereca_.old_tb0_1(0):='ldrrereca'
;
ldrrereca_.tb0_1(0):='ldrrereca'
;
ldrrereca_.old_tb0_2(0):=3437;
ldrrereca_.tb0_2(0):=GI_BOASSEMBLY.FNUGETASSEMBLYID(ldrrereca_.old_tb0_1(0), ldrrereca_.old_tb0_0(0));
ldrrereca_.tb0_2(0):=ldrrereca_.tb0_2(0);
ut_trace.trace('Actualizar o insertar tabla: GI_ASSEMBLY fila (0)',1);
UPDATE GI_ASSEMBLY SET ASSEMBLY_INFO=ldrrereca_.tb0_0(0),
ASSEMBLY=ldrrereca_.tb0_1(0),
ASSEMBLY_ID=ldrrereca_.tb0_2(0)
 WHERE ASSEMBLY_ID = ldrrereca_.tb0_2(0);
if not (sql%found) then
INSERT INTO GI_ASSEMBLY(ASSEMBLY_INFO,ASSEMBLY,ASSEMBLY_ID) 
VALUES (ldrrereca_.tb0_0(0),
ldrrereca_.tb0_1(0),
ldrrereca_.tb0_2(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;

ldrrereca_.tb1_0(0):=ldrrereca_.tb0_2(0);
ldrrereca_.old_tb1_1(0):='Class1'
;
ldrrereca_.tb1_1(0):='Class1'
;
ldrrereca_.old_tb1_2(0):='ldrrereca'
;
ldrrereca_.tb1_2(0):='ldrrereca'
;
ldrrereca_.old_tb1_3(0):=10785;
ldrrereca_.tb1_3(0):=GI_BOASSEMBLY.FNUGETCLASSID(ldrrereca_.tb1_0(0), ldrrereca_.old_tb1_1(0), ldrrereca_.old_tb1_2(0));
ldrrereca_.tb1_3(0):=ldrrereca_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: GI_CLASS fila (0)',1);
UPDATE GI_CLASS SET ASSEMBLY_ID=ldrrereca_.tb1_0(0),
TYPE_NAME=ldrrereca_.tb1_1(0),
NAMESPACE=ldrrereca_.tb1_2(0),
CLASS_ID=ldrrereca_.tb1_3(0)
 WHERE CLASS_ID = ldrrereca_.tb1_3(0);
if not (sql%found) then
INSERT INTO GI_CLASS(ASSEMBLY_ID,TYPE_NAME,NAMESPACE,CLASS_ID) 
VALUES (ldrrereca_.tb1_0(0),
ldrrereca_.tb1_1(0),
ldrrereca_.tb1_2(0),
ldrrereca_.tb1_3(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;

ldrrereca_.old_tb2_0(0):='LDRRERECA'
;
ldrrereca_.tb2_0(0):=UPPER(ldrrereca_.old_tb2_0(0));
ldrrereca_.old_tb2_1(0):=500000000002094;
ldrrereca_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(ldrrereca_.tb2_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
ldrrereca_.tb2_1(0):=ldrrereca_.tb2_1(0);
ldrrereca_.tb2_2(0):=ldrrereca_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=ldrrereca_.tb2_0(0),
EXECUTABLE_ID=ldrrereca_.tb2_1(0),
CLASS_ID=ldrrereca_.tb2_2(0),
DESCRIPTION='Reporte de recuperacion de castigados'
,
PATH=null,
VERSION='1.0'
,
EXECUTABLE_TYPE_ID=17,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=61,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP=null,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='Y'
,
TIMES_EXECUTED=362,
EXEC_OWNER=null,
LAST_DATE_EXECUTED=to_date('04-06-2024 17:44:56','DD-MM-YYYY HH24:MI:SS')
 WHERE EXECUTABLE_ID = ldrrereca_.tb2_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,CLASS_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED) 
VALUES (ldrrereca_.tb2_0(0),
ldrrereca_.tb2_1(0),
ldrrereca_.tb2_2(0),
'Reporte de recuperacion de castigados'
,
null,
'1.0'
,
17,
2,
61,
1,
null,
'N'
,
null,
'N'
,
'Y'
,
362,
null,
to_date('04-06-2024 17:44:56','DD-MM-YYYY HH24:MI:SS'));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;

ldrrereca_.old_tb3_0(0):=40009057;
ldrrereca_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
ldrrereca_.tb3_0(0):=ldrrereca_.tb3_0(0);
ldrrereca_.tb3_1(0):=ldrrereca_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (ldrrereca_.tb3_0(0),
ldrrereca_.tb3_1(0),
'LDRRERECA'
,
'Reporte de recuperacion de castigados'
,
1,
1,
22,
-6,
'FormExecutable'
,
null);

exception when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;

ldrrereca_.tb4_0(0):=1;
ldrrereca_.tb4_1(0):=ldrrereca_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (ldrrereca_.tb4_0(0),
ldrrereca_.tb4_1(0));

exception when others then
ldrrereca_.blProcessStatus := false;
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

    sbDistFileId        := 'ldrrereca';
    sbDescription       := 'ldrrereca.dll';
    sbFileVersion       := '1.0.0.0';
    sbFileName          := 'ldrrereca.zip';
    sbMD5               := 'f007d8372fffecd44cabccb53c34bc6d';
    nuDistriGroupId     := 4;

clB64FileContent := concat(clB64FileContent, 'N3q8ryccAAMIQ7rJ6GwAAAAAAABoAAAAAAAAAJ9aJDYAJpaOcAAX9+wFu+r0/5QBL0TuTr0I2yvx');
clB64FileContent := concat(clB64FileContent, 'U9Plq7xO/c6hY0BIQykUfFcxmm1nJkkaGBLomg0YBj0sy/fHRpK4HzK+n2a7pvMs7BoPjYRR4KMd');
clB64FileContent := concat(clB64FileContent, 'xlRcAmPnIxsuvkvlaIKC46BAx45TYy0UDNLOGbMg2aPOyNSwF+gKQfGE7OuxeCiNi0qiVI3uDvOt');
clB64FileContent := concat(clB64FileContent, 'Bv7fJxqdVRh0yr5aouEFZFakr8IquRSW76ahFFMmtPCVEN0SZ13jgNBKh2T3XAU1VPyQUQKPd3tJ');
clB64FileContent := concat(clB64FileContent, 'AI8AS2oXW7sksOl/7JYvaEC6PfLKQ0I+mdDT0VMdR0M93FJwe8pWukxoNr8tJxqM0pxOu9w4ZoBc');
clB64FileContent := concat(clB64FileContent, 'WYgC+t/KrU82gS05WF8V37rsE3Vzc2JhSUu8a6VBbKpf+lMfPFE1uc2pZfRQLK5Gu+xu0sCQSDjv');
clB64FileContent := concat(clB64FileContent, '+eVlgo5UCoc+33gyqbC6FZRNu7RsniETHC1P8v2vOBLhNFeo3H2si8krpHOaV12+uvHwPzmNV84k');
clB64FileContent := concat(clB64FileContent, 'Uhp0fl/Hi1NZlmH8UVfsnPGpcUve8vChwDoi7FLb2aDNNYsc8UjWolthWez+2ovSDsWmAlF/TNYd');
clB64FileContent := concat(clB64FileContent, 'f48habaB3cAIUv7Q1n4KMgYRlCLyktQFlfZUmhvbqAqCVG3GBlX1+Q/QVWqOjBnRE6N0ElqolCNs');
clB64FileContent := concat(clB64FileContent, '/OqZtOSI+MdglYW3iapHpDTuExscpa5QXIpRsOTIGDCcG47eP2kakTKgcdeFPWbO58LH1ACd5U02');
clB64FileContent := concat(clB64FileContent, 'cHBMAdxdgA/fPd4c4xT3eyQ1CJ24YQjco4vhZTKKljDkOnrK3qVd1v/LbqxNZnCkmdsqF2K4swuM');
clB64FileContent := concat(clB64FileContent, 'C9PkvgTM8mnx/FSZfsVfEpEwzbI1utxhA2bfNO1/pXfCTLVGHXdoHgFpc3vO1XjbTyVRCAbG2yDs');
clB64FileContent := concat(clB64FileContent, 'VDSuKoowHuUpQjly2m36Sh87HKCaao1lmEZ3UQ02hNo8hgNEAysmVUAyMR/sfC7a7ivH4ZCXpY6S');
clB64FileContent := concat(clB64FileContent, 'VJz1UjM5Lgw8xUiK1Jy2RFopCmS5lwFmRnurJaqp6o/oHzMteg5UDfVX2rDd37XHseWDv1dLGKJU');
clB64FileContent := concat(clB64FileContent, 'xpAvx/jMM2xJWhWCm4S2nPKKUfRyni3/g6tM+RddCjcp24lVQ4l1B+92TZN7GY49d6fqpJ3L8NQA');
clB64FileContent := concat(clB64FileContent, 'EI6Y0w8SXl4p4HCBdzkc0Ol1Q0L4cjhGqw4rLx7+VCZJsYpcgTZZ7xt43VWiRP8jnMwdeUvLH8qv');
clB64FileContent := concat(clB64FileContent, '7hCRm8TtP1q+uHqD56LwNn7xdecacZUHsPfvrFzZWSDMTNpx6DurRJ1VLipHOTyDpb73t6YaI5ot');
clB64FileContent := concat(clB64FileContent, '+I3XPBfFrwh1QWZCsaIR6PeKpmO3fTXvHKN8E8BjNfaUspsAsrZOJtXReVkwq0Bs9geJS5cC8OT+');
clB64FileContent := concat(clB64FileContent, 'nSWbimILqgCRXu+eBhn3HzzZBaNFndB3GDQuB6v+JYDGJUQzClRGKIf/aYiNDIJiqNVQMK4uwYsU');
clB64FileContent := concat(clB64FileContent, 'erDqeTSFoQ/FTuxZA21XFFE4com3zlOYIk6AAks4x1IWgVZm7xSX86qvQ/36nJfKSmE2wzot9iPg');
clB64FileContent := concat(clB64FileContent, 'PtANxtqo7ll95JmgtRfEKwa1NmeoxU6e5l8e+XdF/WwnLe+s44m0dnoQAXzvuO/A5DFG/6HttWBU');
clB64FileContent := concat(clB64FileContent, 'NiKxcd45dwVOSX51AepMmXM6khvnbaeucgyfUqmNE98DhrqqCg39LhjKIrvOnnAxEnetMfAiy/hw');
clB64FileContent := concat(clB64FileContent, 'p5oP1LHsSzu36+/KkiPlstWPwMbKbajLIH22AMhOfT7GbUzR710wgIosSul/wiFPLRrLmuUyGBoo');
clB64FileContent := concat(clB64FileContent, 'ctGBREypzXSvmCr55TWJeLA32v/LIt6yDWq6JM9camxxhZQ8NfkVNBUaUr8h8PBs2DhNyw1D6da7');
clB64FileContent := concat(clB64FileContent, '3pKoxvDOF9dsPtTdr5de6o8P56fufiF+1Xf8kIIGsbz5QRJprUVicMNL5szswtSjU1mEoZmd7ze5');
clB64FileContent := concat(clB64FileContent, 'J13cgVlQxQCB9T1vaYsBfLYPs0m6SQozUeGerWBpizJxejmZLtxEOVEgQs3Ks582OaHx40m86CLM');
clB64FileContent := concat(clB64FileContent, 'zYSYcQc+sp2pBtqNIqQO6kcQLdqyVC8P6k/hn2Jmf4fYrIsKgmeNm/eiy6+6kjLIoFoatJvGifar');
clB64FileContent := concat(clB64FileContent, 'xwySkkagtTRTKxkzX6KBOoHW4EPRZG0bWMMquwkf60cIO9zM0NEKn19t5bVqpernreq/73PFGVnE');
clB64FileContent := concat(clB64FileContent, 'nQ58QWcs5WwCfB3u2abxO8WRDBPGSt/Q3pP3nMeUkPW8XPV2vP5qm2ZmGqFC94OZECon2v8HCrYL');
clB64FileContent := concat(clB64FileContent, 'K3BG/ouaI2HUqUPSoui3kT5DH9D1jib/ylDkZGLd574mKAK2zH6yKHWOxmVjhYLZDNSQYA/zEUfu');
clB64FileContent := concat(clB64FileContent, 'MXzpr0ysOzINXXk2bHKJU4uq0PCv8O4pdmjTF6NtdVf9vOuU3QaPp6EOVhsSBbv3dbJG7S5LY0Je');
clB64FileContent := concat(clB64FileContent, '5v5ywSK2JgPyNCMI3bM0eFtiAuM+DUJH0qpK383WJTx8u60vUaNmk7foOH7BwBrjHA+an89MNUBQ');
clB64FileContent := concat(clB64FileContent, '++gjQ+x4cM6WFvNY5VfNjuviizoeZQb3NEYz0PCthfy+Rv/qMWFa7xlMAvRcCh0MSjmR/jknT5o7');
clB64FileContent := concat(clB64FileContent, 'UC4My749ZTZU9zEFLEX4xySgZRsZYibOeFqgM9TePpGZso1kc3VB8Hra4yYoUHzAq1/ytQx7K7fl');
clB64FileContent := concat(clB64FileContent, 'BsAE5CzjXDK69EyFTE4yAjA6EsPXWJ7SiR4Ojfh1/RbxMa7+y6kiRyqzJYIHbWYORN01rli2gxTP');
clB64FileContent := concat(clB64FileContent, '1suTKZUKNZk8chnJjBNe2ilTn2o3tqkoII2AIcxp3J1Fm3gBg638hgXms36hVDtEYgEwsc60P+D6');
clB64FileContent := concat(clB64FileContent, 'toV5v+4fOBdJ8PrCmTp2CQKMddtQZ7YqCSdkontGAQ8W7vhEMmcgSAgMfxGorxmO6+nQk7M0uKZB');
clB64FileContent := concat(clB64FileContent, 'XgSR9cde+5NEQwSZ5K4vYC4qP6FovxcDBhZinduChVkGZOvVjJ9SUKkVmGiyLyDO9EyavmC1AqB1');
clB64FileContent := concat(clB64FileContent, 'NwYgteOVbM0s8Q65i3i8oAlX+6AqbXVSoePPE19BMAWWMCHDD8BA+/iz9o5d5lBem3TKKECdkCJg');
clB64FileContent := concat(clB64FileContent, 'wV7Jqj1T1tjSP7xWwVUCjy/kByaG+gd+CVW2+k3SKDpTRvYbs6JgKT11zLmwOzA+WVdVPM2V5UrU');
clB64FileContent := concat(clB64FileContent, 'R468XL4VW0w29F60w71urP8mLMD6Or1VmDq5SrIfdbPHPq8c/bEny1u0EG5Z8zSq1aEAquPKL9xq');
clB64FileContent := concat(clB64FileContent, 'mKchR20bbs4lJ5K7jEIX846OhpvD5P4GKQxGERKB/4XE182BZQMsAbufzXs7u2C+1mNM4Kyqx1KN');
clB64FileContent := concat(clB64FileContent, 'UeawSgyPhaHYVmsYIlrXR+Er5bhJxBtM3GD6+k6MNO88RsLj21LYeXe+7obnyd7wwe8eY7HgHFAV');
clB64FileContent := concat(clB64FileContent, 'iHmo3ugCDCMWGIiDKlD6lanwe9WIIaXJVeWHg07MzSKDzqt9ZFLBjE2zT+tbNiGgU3LG/6yawYIP');
clB64FileContent := concat(clB64FileContent, 'nMiJZpA15SSA3BpgEDGzY/dvUstLfxzbTBHnr5K8nkBfjVgL1fZ7bbJ8oWWGGeCP1BkeIz19yc6/');
clB64FileContent := concat(clB64FileContent, 'BQtLKulVje5yEHfQ2ki2/DZIfJPu0669YTEQiYKuwjk6PWSQKPojvCJ65IwFlMQIJLlMoObLXE0b');
clB64FileContent := concat(clB64FileContent, '1FdzbabhyP55IVr2EJ8yB9hcNWCNgUH1059+DJAbEzqTF2W2vEuq/krkiCl5obgV/fp9EhZU+PUC');
clB64FileContent := concat(clB64FileContent, 's1I+XjUESu3YjiIPSQw6oeg+XnF1TAEt4b692jxWcflMFGgOhLOdieI20T6dSoi8DnByWXOy12H2');
clB64FileContent := concat(clB64FileContent, '3lkk5grnX9zRZfgEAfFZqO6YY0A/ZvmQyoZHUX7+we3jHYNYF7l3AETbWNLOJLNE20CKWgAshu5O');
clB64FileContent := concat(clB64FileContent, 'AaW8L1fNpECImTaLvbCS+aWd/WsXQyVWMOiQGJoeq8yeZlkvkFXIK0R/w4feVZvdPY/JkZ7hs5q/');
clB64FileContent := concat(clB64FileContent, 'TW0fhvWu0kyfufCNq3ihGdPTSqZQqUBcO6M2IAtwkoNDC7EZcRiOYBnEFPe20esAtg151Bgw/xzi');
clB64FileContent := concat(clB64FileContent, 'Lptd5/bC+F3GdqQtOhk9n2z1TglP4Gl6iRY+UrVrxM7AUMmCdNJSgzncGVrYcL62GeZyiwUr2g+0');
clB64FileContent := concat(clB64FileContent, 'qYpQqUHk92Ki3tVVYSNwqzx8ad5xmP3BStsh7HOO03s/W1v9KH6U7QkUK4WNTjZZi7/DZkYPs+4j');
clB64FileContent := concat(clB64FileContent, 'v2DJs2FaQPWwTVMjuusZNO/cvtB3chaFi/Gvo/gLTpU6aFoDJQiIbpgAvDQbgLXxVm87WBDFJKtE');
clB64FileContent := concat(clB64FileContent, 'sGrLsA+/gRtnzOaBQZu3+z36O/7/P8w6hjuHtLTxcTa66aBKxer9j1Is2SKDWQNV+gZtQdTcqQV7');
clB64FileContent := concat(clB64FileContent, 'QuIQTUkpBzl3Qs9vTj6mZ7sF3dEPw8wwaXJ5fLqAjXoz+lwGKpyIID34+jpo4BW0+ckWtUwCi6oi');
clB64FileContent := concat(clB64FileContent, '9DvmDz8t688200z51F9/VRnAiFuecWqsRFi/pnTYQN74HRn/lvueyZf5JaBq+7GETdfHaFnCL0Cv');
clB64FileContent := concat(clB64FileContent, 'i1yHHnxd/9PZf19wi4fz+9iX4TYDzz/WWEa6g2iB3eiIw97pdEJUHzTokCiepKB6MgagSFxTfn5x');
clB64FileContent := concat(clB64FileContent, 'miB2PLiXV18zzFeZmTbIQVqRGwjnKSvBahpkwk9R4Q63NmXiLARuempJMyEidJx1eRxOdX22Ntpy');
clB64FileContent := concat(clB64FileContent, 'qC3o3RpaHj3FSUqM7dVp6MFWebAQxmyWnqsYly8kJNrEU/cLUVk81tQBdg9iAbewyQQAgeF5octP');
clB64FileContent := concat(clB64FileContent, 'qWVHhk56tlcXGxMPZbtI7IL6NJILieuap80CdZF5tqPdH3KvGoTcvNoAjRhfYriWOJB9pltwElDO');
clB64FileContent := concat(clB64FileContent, 'tOqFGAa5NwRYPXO3M1/uj7zakcRN6AR/LgmtBObFRPCnkapk0z8VlCp6J0K4U2zQFl7KRn8K7/k4');
clB64FileContent := concat(clB64FileContent, '4KRXJO6PMqJqUQldKB7vz7jKakgoH63rVcVuZA7jNsofrmYNbw0Up2e2mQxtBmLkXpRDedjzrlSz');
clB64FileContent := concat(clB64FileContent, 'KPrsGoszFUl6E2bSVTB3A7DRyloQxy2Ej6t++2aRZirCBSR4UJ8HN3N+Y2yJpJVdnffM9/BFQiWk');
clB64FileContent := concat(clB64FileContent, 'COth8TVJrhc+ClBCEBpJXIbY9t/BzM3ZAjFjL3Qk2XxzBr+baXAHqEPcAjiLyrdieUg2DgeEcB9G');
clB64FileContent := concat(clB64FileContent, 'xfUrHzqlMvyJe2v5Fme0l0r1rzVWYOIXDDSSjoFb0/+KaIWYiW86U5Jq0lm64b74IEBKMgdw1vs0');
clB64FileContent := concat(clB64FileContent, 'KooYuDjap7atQhRlIYwV4TXPvbdn++/C2FF9B6TTvAY3LgDElpR95W1ePwYciIo+mm/ylfbCVABY');
clB64FileContent := concat(clB64FileContent, 'liVWpey2Y8cw3XKNnILaeY0CTJS0+L+ZtlN/TUW2nRq9bNTiBeT6X5qfEEU+Sas6/XMzzQwFhPKk');
clB64FileContent := concat(clB64FileContent, 'xGqkh2RqNMwJaMiQfD1I09tYJ9cmaRgkevTtkE74pV2AiYlejUL/UDsKytCM4HdvpCZmd3+CrCRL');
clB64FileContent := concat(clB64FileContent, '/vCSd6pdwXXxgVlODPhsDG+dKBM45hGGcf5CqcouFI+frRkenaMhKr+FVVHKTwfPPE12cMTU9cBW');
clB64FileContent := concat(clB64FileContent, '5juHBcO90ZN5flrsNvM3K17v676dZvqlPfz+YM9gLg4OMOibskjERwemrHUFp5XrZgzxLKWA9Nnd');
clB64FileContent := concat(clB64FileContent, 'OKho5AOjmqwR35n+n7BJyFSL56MRmCbSoOe6kPLwdQc2ppebwOStwAYfpnDQNgYQGy4R+re0c6m1');
clB64FileContent := concat(clB64FileContent, '58V+CPcQYYJXX4P8g8bWnPZ/xq3vw73bMP+8J8dOMf3Y8FFf56VLgsZ3iLZfXdUYGJfmf5mHJrGj');
clB64FileContent := concat(clB64FileContent, 'ghYyrV/G5p0IB8uPVnf+BREINJSVzQj6Zesj4ZKO54+ImLFferrQ3WsEMcE8h3KeK1hYP53bUDp4');
clB64FileContent := concat(clB64FileContent, 'RQ1RVbEFr1hTSUgWO2tMTmph4cCpqVIF+gfLoKEpLfYnlqddTRXPNLAInHdoGT460v87bWFWzCmP');
clB64FileContent := concat(clB64FileContent, 'rknlDvflV7eVMMGP214iW18nKt1SjQv4Mc44UKeedfiBjHoxbXNE8F29NkpmRO02JxAjHcQ1acfG');
clB64FileContent := concat(clB64FileContent, 'YwRTB2muq2gwFn4Z3uglgrAhhvO8pjemOFPVY1vxdTkBOBKdM0mkSEZSCQfz+x7g05UK0bUl+5+F');
clB64FileContent := concat(clB64FileContent, 'JaK6re4PLaCM33jrT/eMrAMngBXOAM2vqkAKzCvM3aXfOiI4N0yQnNvHMo/Chfrg784zCr0dT7kr');
clB64FileContent := concat(clB64FileContent, 'PAZezqFm8yhBfnrlK1+ddjMeJ84C5SG8cdhZHLNWXlPLuX1J/Qy6aIxeKxcf4Cz7ThpiqezcDs/V');
clB64FileContent := concat(clB64FileContent, 'W1jVRnumBtzrv/gKMyDXxLC59ZcZfphR7XAVmowelkNFn0aa0UY1NTbyutKPYT5aWuV4pGLKRZPN');
clB64FileContent := concat(clB64FileContent, 'io8PDOsRMvcRCBA+yGDLfmjE/paYY+uaV+FAeslEMwLR5qW4TbH25UqWz5ekfDtjdZTY4BKODVkF');
clB64FileContent := concat(clB64FileContent, 'UyC+o19n0MOc8GQZ/7JPGbGrmDUbH58jLPSue39uPrXXDSCiQVbKj722+NbBnKwpvJm8d6nASFId');
clB64FileContent := concat(clB64FileContent, 'WZeyPVZMub/Fs3tack5mPZKJgxFBMQlxrfkrehdvRvE7VICACi9jezDPQNgCLibQqOXRx24mflm4');
clB64FileContent := concat(clB64FileContent, 'gehfDyj/Fhd2nnjQT2YXZ31BSxlZGjBa+OKFZUu8PA4Hmj1RjGrWoBaO40d5P7kM0wQowdldrA7D');
clB64FileContent := concat(clB64FileContent, 'ODfqgSgX/v0kXOtlrL+6AtP5MdWAZWmIcxLqCBjcadfpnUqVUr4ovo4RiHcx4XbKirWx7GbiJPnk');
clB64FileContent := concat(clB64FileContent, '9Iub/uMa6r6nXw6M+bHEnb1OpUp5PQkNkHoeENbfyqSZojbw6eSoovK+m6iGHsoMukWCgqP1vwt5');
clB64FileContent := concat(clB64FileContent, 'JLfRyDYoSUqKw5n3aWSoP1p7HbtHNqXMMUIe6s3J+bXKVqdgrLcxC3lZfUK5tVIbBLzrdFrhJMmk');
clB64FileContent := concat(clB64FileContent, 'E0bzWXfBVVfckozo5UayrXcceADntKfsluxWhFD1bxmgax5f3bTm760oap62xjBwqllF9pSrkdfp');
clB64FileContent := concat(clB64FileContent, '8EGMaLrQ7+huHYUlOSu2+X4psje0VhBP8tYDVTH34HKDSt2Km3v4eoQACIH14XHlPElPOKy6su06');
clB64FileContent := concat(clB64FileContent, '1RhfNQYIqWHfB8MC4s8GP6OyQO9EgpzRSaUjGD7HBrBsBjQtJ/P5Jr3QDn7UNLkVFI+7kb3VrmgX');
clB64FileContent := concat(clB64FileContent, 'H/A4WztdYRuFsnR/+f3noXa/dw+kg+dWrghIovHEFjLI7xevAGKyIxJRQsOb47pARyNy3+a1eUqH');
clB64FileContent := concat(clB64FileContent, 'GS2xybWQr/BvQ5HStdOz/3td9KC1ReoYRb2Sw5hyyIn5PKm6zCJ1AEXd5KcIKIdkX7S3RLsycJPG');
clB64FileContent := concat(clB64FileContent, 'sstJbrKebm9niuv0WERhRbmYRj5tKCj5eJ6P794mnBbaoqib8IgNuzzPgBDvNJSVJ/M4T+vJOO/y');
clB64FileContent := concat(clB64FileContent, '8CKBGexsz+wXhUdj3ABryvdv4JGQWgt6R7Pvjab3oPqo4aFPARw8cH0LeEliWGNdF/gCY7Y+BCJX');
clB64FileContent := concat(clB64FileContent, 'TDPeumOYowxed/aRFBSeTGFPxGPJRLTDQfDq5os6Mq5uXo6FAdlx773EfB9pWtjYPN2bj2jE9bzI');
clB64FileContent := concat(clB64FileContent, 'TgO8cMtiGPcWCIIXIagNFQP/i4gQYdSwlY/VwjeGifmjUJjRXeFeEkFWXNaMnY47oQgWXqiiiRO1');
clB64FileContent := concat(clB64FileContent, '0qufFif0KKzh2HNin6Und0uVdhzMoanBaTDOJlp2ma3FfOyaKbx+naw/Bnkgel+ubSDMK1aNkqYa');
clB64FileContent := concat(clB64FileContent, '5tiKDEG4BeVkpHemCVA+auMSgYcJYmMk1j9O9DXblkbWqpaD+h2f2C2PjygIjXqH9EeoMCPj/LUE');
clB64FileContent := concat(clB64FileContent, 'goEYcO/i2PszapMOjmGO7Xawhif2FAAD4dx997m38ndDHy4Fzop4ubsVzKKAf392RSNcQdrEAt16');
clB64FileContent := concat(clB64FileContent, 'gZFS5Mo9V/JpM0++lVwICQMkKEw8Ry8TDzvAKCDootA8SmWXI/Wdz24Q9EY6q6/ecZVyMW1ify2l');
clB64FileContent := concat(clB64FileContent, '1FpOwkPEAzKSq0kh260hT/UCtBjkdPYULD6dGAfPkVjnNWy5R/O+c+WQG8yQOQtmZjmk4PU+Y6o7');
clB64FileContent := concat(clB64FileContent, 'hoXn+ZHfnvYZJdlerIjHvtWAuNR3D/lTFx86tWgzJfahDQJD3b8FF/aoxppZg1/Kdt1F8x4M2IFC');
clB64FileContent := concat(clB64FileContent, 'jDsx/x/SPSJZljwWGTGmJi5jCnxa6n6M0ZHxNIMzDsroLaz2VSm+BALaUV/rvWE80EToY+XAH2CL');
clB64FileContent := concat(clB64FileContent, 'zOjA0xHvNCnYSb5VyOAxZ+WuI7tJwUD+NXBtpBxmn1KHeFk9F6SBrWFzPcUzf9eTNPzYsctQ4urU');
clB64FileContent := concat(clB64FileContent, 'K5GFkOhObObRiVUT0KJiJ2qTk4Xd9xEGbfwP8kNyGa4qjWlmDTJcIvOqNd82aRceSkG7Od7uot0f');
clB64FileContent := concat(clB64FileContent, 'gBz1WrVE27dKT5QVYwxk6paSbXSFrZc6WO0OVEhuYiQ+cU9gxbz2kg13Q08tIF7TknjIGwjheM6m');
clB64FileContent := concat(clB64FileContent, 'NvP/v8Gqwt3OAbAC3RdpL7dw1sEr03C+jjt+Qh3DUmOyv+te+fm7nPbYHRpuQ/XhQnM4wedJE7j8');
clB64FileContent := concat(clB64FileContent, 'O2vd8F0myolOuZN/XReKXDPY4C2O+7XQfBJgXi+TLkOEeQRIYDLvtsBBX+FXxJ2K747dCZlSxqDD');
clB64FileContent := concat(clB64FileContent, 'q9OmLxpSHa9b0IERxZqeiZc7qCdWPctCKSVsth+oMvlU05SJ9qQGO3uE+xF62337uYpjs31AoAGZ');
clB64FileContent := concat(clB64FileContent, 'dGSISmLbN14VAJ574Q4YABihLEFqPxzGiUYynWyNQKZynrAH0g1zGY/68YYMnUtMaLAax905J/3A');
clB64FileContent := concat(clB64FileContent, 'jIUmHSIPr7NoOJJJxcCBCp6gaS3YwxFF5Oq+50WfbV7BTQ9v1qRO+QAWDC9FodSGQ4E5OjFIE3HQ');
clB64FileContent := concat(clB64FileContent, 'GXgvlZvHimczDprrh0t87ShmNqb8v9XxsAVgs2AvtPnazXR/FroQBWHax93Of8lJk3BlvxhFLx7M');
clB64FileContent := concat(clB64FileContent, 'mRlLMmrfqnmu0YT09ElZ7mAS0W5G8xnnB0s5lq0ms1yqnN8J8PFhAC4U0P8/GRP2h6ZiUCdbbnaH');
clB64FileContent := concat(clB64FileContent, 'H+R5WFt7QZwXWfC7TKbjGO1T8AhsvNHT4uH0231daojD5HOesLtdNwtWvTEBXaWo+eHS4wPm0Wmo');
clB64FileContent := concat(clB64FileContent, 'e+mVCpZ5xBChLRZGzy1T++tKuLTQUVwbHrBVrEZOcqaSbzOoMiKH6vhck4IDo1N3iLm5cArJe5lM');
clB64FileContent := concat(clB64FileContent, 'SZYiKmlF2lV64qcz6hetcrbDJVn4UVj6FbRsaQPlVSUggASZ2hh3U6sCipqGyZTEvTDz09aMksPB');
clB64FileContent := concat(clB64FileContent, '9TBrowFi9i0EYpcs4xVYS33+EgViLyU1mQaffkf9kVp4L0tN4fU922x/2xYJAwcunLjS+LleGCko');
clB64FileContent := concat(clB64FileContent, 'R3xG33eruq56J6LijTqKr/zJtW6CtU7DeKVQuQJ8y8WDqud8AYXHnOLkqxJHQqH6QJJpRPtKDEnR');
clB64FileContent := concat(clB64FileContent, 'G5awjNO6Ikmgz2l+Ody52ndmH6ALuAoXoLZMs5mF4B8GbbvprkJ0IiirzYCT2oYBMl6BDtiL2a4b');
clB64FileContent := concat(clB64FileContent, 'X0QI/eePH6DRho6GJdYB+CQWOWvO5pLCjo3bAxORoWdB6dcufs0k9bHf7Z6+wUVcGy0gzasl1WHA');
clB64FileContent := concat(clB64FileContent, '74cDTNNaSpPSiSk3jkmf08E11cVDl9vs2YPpazGZ1eRMxKkiR/h3iOwgHtgBYnhN940+5knV6QJJ');
clB64FileContent := concat(clB64FileContent, '1NmzzJidMQStY3qNnVGA8K+1awO43YS4dy9L5f9G2EtF+hzmTPJ/Fl7J+a3xYWUfdhQnHABML+Bx');
clB64FileContent := concat(clB64FileContent, '1dnrKihnaPWtbsQTj8Kal6IkxofW07ySKTK0OTL6lcZ2A0x/xocAAL4AamqTRMEVyRvH95cVZGmu');
clB64FileContent := concat(clB64FileContent, 'FvoKRQ0hWVeE7ADwWPy/gYnVvC4Es0o7W635yUEBjupKexWkoM8t4IphvvgQps/1okKgZTQUcK4V');
clB64FileContent := concat(clB64FileContent, 'BuszntMgC7YgpoA88tXH7HBDt2QFX2L0EB1sUzZfqMviaEwuLIEyaC0UGhjNWKc4gIDFOEJD9xOW');
clB64FileContent := concat(clB64FileContent, 'o0RcYuPqp7/jTswGLdfcLztw5Hl6MNnmeYY5gKQxtb5sy5fbbicI5KG16bOX2ts6pT4nA+TxTVlp');
clB64FileContent := concat(clB64FileContent, 'KZbJqkLfwW6wFKA/+rngFAZyTNRsu1GAZYzyv9T3sTkzDl98YXsmSLKLqSSvRvF+bTq5NUAm8YC0');
clB64FileContent := concat(clB64FileContent, 'wFmlLa3UqzwkIlXYhGLLX3jpcnLwJgzQACrsccUsgIQj7Hj9x4ez5kfdsxPRjxACZqmU15ofR7Bs');
clB64FileContent := concat(clB64FileContent, 'HWb2Dp6b7OAfMv5ordZYwUe23KORE1pB0AoaTEyYs2Qg1qVURpwDbhItPzONXr3Io41lHIHKSJHh');
clB64FileContent := concat(clB64FileContent, 'QE9bg7WudUrQI1rI0xmeS0MKe+UmGU8mHCVBDUBtHJemXNz73ETnPmZeLTx70y3vzmUAGYG3v+W7');
clB64FileContent := concat(clB64FileContent, '9ZncP3BbveXX3NlF0Y6kKsRKVhK8XkWPl6kP6lwh5xq+uM1KzHaF4hw4PiQ7Pq5j3WMSHKX9f7yx');
clB64FileContent := concat(clB64FileContent, 'JWVxZptuuhhTRmb62VN04vloNk/TFKZU1TWunBZ+ZHHC6K01+TZCNy5FHg7IP+zUqtvxVJEUunlT');
clB64FileContent := concat(clB64FileContent, '7T37HrD1PldCStnjMqN0J9D1Xb2FVIInp7Z/gnTPjQVIfRbapMCKfzagN+zSgDinkh3oXR2ke3uI');
clB64FileContent := concat(clB64FileContent, 'E41tuXe6h6Y35th4q+MMqzBmbTov4VnZYnIrZboFC6VwfkH1E6aGeXMFI2/G15RjGz/NowjBGkwD');
clB64FileContent := concat(clB64FileContent, 'M8pBMnFVLWu3tfLDtI1eaMMtoKaXrkYwrcUkwfRMVtBuR4yjxQrK2fAq0w7D0DLC2jPN13kUyoY/');
clB64FileContent := concat(clB64FileContent, '7IhNqhhtXcWynhhNiFSTTB0gZ0OLVdv9uWPoDRcHv0Mqh3qpWx5GbkLKaluBSLanANIiK2Z/Tkzr');
clB64FileContent := concat(clB64FileContent, 'UqnJDbzQnnbxCNyZaxdu3LGIMir2Lu4XS6tzi13wcl5n0cP9pOi4MHIfMsqbPEScicjf1zRDVfp4');
clB64FileContent := concat(clB64FileContent, 'g6F8bYqSowGvOMgebgLvtJKr9BMirL0BZO62DNhZuFHiQeEdhoW/fanPjrjlqwwVIXhqS7UYdQeY');
clB64FileContent := concat(clB64FileContent, '+CL/Iz7Qjm/3CeMSDukRqwcNPetKGG1Ade0aWAtXa7Mn0WfHrHIMY0RtEuLk67D8i4HD8jyGOSET');
clB64FileContent := concat(clB64FileContent, 'KzQgsj8cKo21rq8qZnlkKxUprjI3Xr8fu6e/wwjEuSeHvz7U9SKLb+SEppnDlnK1hBzcvA4Agw8X');
clB64FileContent := concat(clB64FileContent, 'WC+F+jyA2bBEX0fMNtPf1gWoKZpzebAGlk+vP8xQxi4LR/4Un/8FS8UcEPu87lWyuVxtKmiDkwrb');
clB64FileContent := concat(clB64FileContent, '7eJAG5hOZ3aEzBkysedUWqhzqjocZGC+wKHDtFPuFf4h6lEfdOAhesihXPlFvY/Q4hX7pGSHz6yb');
clB64FileContent := concat(clB64FileContent, 'bfBJuwZWQ8jNYW4RZutdikzj+L+cr/DBsoNAiDIVxfaVGD1FRrtTEy+wHk1bAMNCrvpvW7xN5u5v');
clB64FileContent := concat(clB64FileContent, '2teU6/uqubiWtCui72aeTO/WQucQJtXXwWYg6MmvJD+ISXlq9CXEVRu+svKBcIEw4A5JL3P14EkV');
clB64FileContent := concat(clB64FileContent, 'nvfFSqjfd5t4OwSsIMBzqlQkzUGykRTWdcBe3Y8QaHPIKnvcJCcXe7KAxFKKphLP/jNgC/yXCrnm');
clB64FileContent := concat(clB64FileContent, 'VYdONuPodC+DbMBeM0vc3YR7IYUWbPC/lPzTYc90bM5WoanmHVKbd/yiZCRgMK1feC7auTaYsw0g');
clB64FileContent := concat(clB64FileContent, 'NtzfYL2rWBkcF2/khThyIaFctaDUv/+iQpbMx989P4iyVYMpSUXI9xKmnjuUMMSQpSJbHmWOCjXr');
clB64FileContent := concat(clB64FileContent, 'Vd7EHjQj4DnmcZ6C10n2n6dz7VThwtWcYBtoTLvfOE605pTlu+JlqM0tTcKkBR1BgGbQm9y/j6E8');
clB64FileContent := concat(clB64FileContent, '+s8yUlDWw/Cs3kpMxsfRYzOWO+TFnFtOJtpDYfOzTTfot6eXfROvDynJliWYxKZRWPk8KNA4TdTD');
clB64FileContent := concat(clB64FileContent, 'GxxX0SRZne9Po3M85KhAr6zYXmL0gR8A/+Z+crKFFfaI+rey+wqmKYOE3Gc9V4BFYKLOAc7Vhyk3');
clB64FileContent := concat(clB64FileContent, 'LLqBQpvYfoeed5nRYtTvm9x7pAnyQCWGxIqzhS0rLJIXFL/kq3G8hispmPEh5CC8MdNPVUc+gp7B');
clB64FileContent := concat(clB64FileContent, 'zxEIOwky+/g0z0jUeG8kqL2eJeTA3UmahkACJs28z4yZq7EtyR9M30+U1J5Gw+8OxyGDx1A/kWnk');
clB64FileContent := concat(clB64FileContent, 'IfxTr5sUrtmNKb79HjesaDHbeE5+QbcsaHye3PL4z5UydR4sYSO0oE9vNS/sugAchs6Yr0l5PRjM');
clB64FileContent := concat(clB64FileContent, '5UPLYyr+BS7reYLaZ/eo4wc2KjuqO1RX2QUat9+VrLXuW2bGX9dh2JMuyNohAWFUHrAHYTwh3puN');
clB64FileContent := concat(clB64FileContent, 'c6zo11fqKtwpPEAdsmCWieCcAQT2R6p/v4KazD06VZA4vDy/tGmzz27dHrdZGmK8dpSL7q1ysP0r');
clB64FileContent := concat(clB64FileContent, 'jP3TzapEnm0XFYr4RZdQD4fAx+x/jJxv3R/0PaBjIMoMPmaTKJYrV3tir11hgz8PQXs2XulpaiYK');
clB64FileContent := concat(clB64FileContent, 'VcO4zPdHXwjyuLP6O+HuSiYgpOCa6tnb5yvXRNJB9Seep8wDC/xOzp5cbaNwAuZA3UuuLlDL9OYM');
clB64FileContent := concat(clB64FileContent, 'MNbO8g6OoYLascXY8IL+luV17oVHMKDIG97ZHYuxida6cOhg6c3WxMS3kIiqxwuigAyITgnoWlWN');
clB64FileContent := concat(clB64FileContent, 'VSHjQMx8WaKWXSjEYS+0SUhqJ5ymD4mX+2FlmO48xZqxGh+Y1TIjz/37i/sXFtIOwtGXDlohN/Ah');
clB64FileContent := concat(clB64FileContent, 'FUGIGPK81lPP/dHYMXFDJp5QfsKe4fpLBShlvYEdeNojawTmeRw7iD5z29AfBPMhGqEhMSR839a2');
clB64FileContent := concat(clB64FileContent, '6l2LqfMuz6n8fjQhXxJZH8/w4rmRxsB7+QXVoDbk3z2888rnonGVMe+aUvFulzR3pDwNOm+I07yM');
clB64FileContent := concat(clB64FileContent, 'WbEjtlIf790OgK0oKWcQ6OtS7dt/AOGtV3ft4HaqDXQ+LNglKB2XE8D/35s0Rf/et6FlCZU71QS9');
clB64FileContent := concat(clB64FileContent, '/h1F9zB9S1p8eTUqkkxHIuiFJVX8IUyEbJYWiwi0Vdhw86kyD9AU0Owc0i2QuyxrDQnWOdn9/zyk');
clB64FileContent := concat(clB64FileContent, 'dvrhRn6KysHv4L1odE1nHLrmvytuSbiPFXgFAHReDG9KqryDTVmQiHwzgjeis2atlnYe92xFqRSJ');
clB64FileContent := concat(clB64FileContent, 'e7AAm6ZcIGEVQ8RcXN34Vb199eSPNRA8+oN5Yg5TRSeNNyATmefusmPTNq3Pu5syufeCahyvJcj8');
clB64FileContent := concat(clB64FileContent, 'hrsFXuM2+HMRrlaT3tTBWE9SQpdIGtkUJuvwtnsrkFgfMqeEzJTqnMkhixtueTHHFTtjJ2FzBzGw');
clB64FileContent := concat(clB64FileContent, 'pRXXVPkPi1lY6G0iZWKuP2dOiOUAPz0fJY3LOjCaq7IpAmbglhS6tKVQsQBaUqXHWPn35Q2qv+AM');
clB64FileContent := concat(clB64FileContent, 'ZfgKjccGSdLZWZdRueMWVpy3QAPGRHzmX6tqQJ/LOMy/3Za4Q4UFYTibcLIBlVqG/ccEiqIvQ39w');
clB64FileContent := concat(clB64FileContent, '5c6mgY6cZPoEn5WRGi/NhG8xNPT1NLr8ZIJPjcMZr6mwyGZXmMctfMh+xaB0w9NkVN2NKZL8qvrf');
clB64FileContent := concat(clB64FileContent, 'WizooAiwZ+GmPxpBgFpvKlUN+fZixpx06Y2SRC8Ic/WXdu6ri0oqRNODtZF0qaajy9fXE6zHt9ry');
clB64FileContent := concat(clB64FileContent, 'SeTDQu6k6IuN5pu5uBsPnLadDSPbbom3It6MrJVNSjBGPuJqcKmNK8cAtm3uy7+LBdQbwjHpBOlV');
clB64FileContent := concat(clB64FileContent, 'UTvs2GTwHIe6KCmHMcsg3PKCcA3OXmr0aNnJm44ZwYF5OIcCR0Kl5y2uQlLXqu/Pi2nAeSsnM04Z');
clB64FileContent := concat(clB64FileContent, 'VvjSB73d7Lq4QKAZG6zeSAYKgaQPw/9IxF7M6hg8aD9INqxAsShzJxWos7VP5TBViDKvQErY08VH');
clB64FileContent := concat(clB64FileContent, 'SmxNZYhWL0dBv/TFV7BDFJnC+P2YiQLg8HSRAYS/QVOZJC5N0hBbXZX0Mc/HJYY+8afamo/mvrM8');
clB64FileContent := concat(clB64FileContent, 'k/qLSWnNQSl9UBi2sA6dshmhQSVllYNUTPs1F5EKkUiYaqa1j4800Kah+0/JG3/t1eQ0XTGdwxQM');
clB64FileContent := concat(clB64FileContent, 'vmlc3zrOdYvOUj9VcQ2y+jhwaToySX1ML21va/7Yyuw00Rlgxk34Q/UyzD8aKMdTclUExWmIqagE');
clB64FileContent := concat(clB64FileContent, 'FcqmPJCjUBxK1AJGWZNkx7ca5hMrIjCpHw+4H/2rbiF1T+7XrEsutK6AwUFm9EGS6bfB8bKWAEkc');
clB64FileContent := concat(clB64FileContent, 'H0llefF5L+7gVcscY1/Hv2G6VT5pF/6x8U5xvlimOlCyJdRE0tYOcDyXOTTIwe8xuwMVPaqvCNVV');
clB64FileContent := concat(clB64FileContent, 'IWWXHPs8M4d+9v6/CtF6ipxdeMWl7auOzaA+LChlPhG01o3A9N3WvHEIQZqz0zx25ynUzSWilS5N');
clB64FileContent := concat(clB64FileContent, 'jBW5gfL6TlrkJzD02VkU60rU5TRh174/j+dTs1LIxX2DsWpl6BE27m9Jawy72Qurx6jyTNSeoQP5');
clB64FileContent := concat(clB64FileContent, '2/v2tK5PaCvAk5zBQOUX5aeaUJ4gsUFRAh1rKT963MGgJkaPEaaPth9xvBJOMulGaQgHiZXmoaZ8');
clB64FileContent := concat(clB64FileContent, 'wImuP80jDNANYC2/+hE4a+GFn8KAhR7Iy0gLxtiMn1zUBeVa2eLZt3oqQto8mIo6HhfKc/y8bGHQ');
clB64FileContent := concat(clB64FileContent, 'zYTGfKtCAPxEvup0uAaa84n4txxNiMvUSR8/NL278ioZodc++TwQQBHAIKJxFXRmSVfRFP/w//Kj');
clB64FileContent := concat(clB64FileContent, 'IEI9wYv8R8VqmBsAKkFVgDeR/CVw23iKdvURujsf4N10k1oTnSI66baGGl5KI3S3A5QuT23ZDMca');
clB64FileContent := concat(clB64FileContent, 'LTXOWGtT4vpVx7aPdStz+CPh3ZT77IJIdxoMuOMnF25Zfjq09esaTT1d0lOxRUVEsPUlxWGaqvgi');
clB64FileContent := concat(clB64FileContent, 'DYxQrHArwTz9FIviEwZaiTNana397pCZlcLRJ6OWYLd/SV9pzgsajhCTuKCyog/9srK+uZ/EDCKr');
clB64FileContent := concat(clB64FileContent, 'duwZF3XdAgiNo39RQXxfxZFJtA0wVD3wDn/jRoNvQAZj0ZC5FoyetSNRYU1vRK1EcMmxqYs7XUpF');
clB64FileContent := concat(clB64FileContent, 'f5S+SwiEPdMQ8hFvrzPZJC0lRav81qzyzELyK3zresziN/rrxUFp6wTIABRDpPnz8LWWixKp1m7x');
clB64FileContent := concat(clB64FileContent, 'khVBtaHPKFlQVKqpZhvJr4EnAivjb/wX3avBngL2Ozo6yA4XSXrzUoHWRjddT6zEddNJRhsi7rQm');
clB64FileContent := concat(clB64FileContent, '7Cn0QweYnB/P9yTm9awyoWaoouD3L/Qx5LOkMR9hgn/XG4xmFv5oX7giAvFbgW6aMD2iDlD4OXir');
clB64FileContent := concat(clB64FileContent, 'wKYH0pTy732v9bxiGL2ursLl5gMeiGpI4J3XAhvWenbOXzLURQ/REIb27BqZTYNzkQVV+vcG3lRx');
clB64FileContent := concat(clB64FileContent, 'u/a2TwXbgVy8gx5I0Qf7W88rLA8+Iudtd4cBFefJS0QadIQ8LJ0tHtu5PUFgiwkV7vIXNzdZMp02');
clB64FileContent := concat(clB64FileContent, 'l4kT1IvtBtJmyYZzCOIymjkssq4J8MxEB/MgFJbn6c6pK+4FP0dyz4YvzHVyDoCSIK1l6LgWrSnd');
clB64FileContent := concat(clB64FileContent, 'n+CArtH7BQMKJr8SFNQ8NU6KoxKGpZfA0VrjI50OWGEe8P+YTaJ6iPWIbt4rSVIG8rNyeuPsK3Da');
clB64FileContent := concat(clB64FileContent, 'p9KaIhr4HZibGFdkqtmC33nHocHHXYQBa0A7Q2JrLW4A9foUU13ryxoNt9lsnjUEy+FFLtlGWUs/');
clB64FileContent := concat(clB64FileContent, '215DSsF6y6dUHpwUJJnXblefED5hJOr08Ek6+UUNDMie3ngJydDExnieVsJuByr67r2881TTmz5Y');
clB64FileContent := concat(clB64FileContent, '8ZY9tAGTOcCrSuYTmExG3jpMfM3GYMePcOw1jtO3EjVoxuUyOqJHkHKLHTG/FyOAHoNW1MTZWVNi');
clB64FileContent := concat(clB64FileContent, '47K89+nLbSzyCkykQCJGwmsmqXf4m9bRYXMEuGls8Y1bu5qiYox5AdsP2wUwHkuAtxu4X0DpmppX');
clB64FileContent := concat(clB64FileContent, 'eM3aIPFI+pck/hr50sKBt4FlGSmnRKg1dGEe5xEwIofJ16RwVotg7i/dKPTtAH5iOLMxCIN1LKmq');
clB64FileContent := concat(clB64FileContent, '+uY1IkH87NDLrTWYkIHWtY81gJOIJa/QM04GTV3TUBq4FgFj8f/jrlANv2QHdknuDO5YQAZ2WlGF');
clB64FileContent := concat(clB64FileContent, '8DToO3c/bJJqK+55qhdDpczLe7tNYJmJg0fEuy1PWkT6IM9+n5pj1tblCaWNCMZdtIXrDHbRhnXW');
clB64FileContent := concat(clB64FileContent, 'M1L648wGzCZeLkOsCePJkmDlxhll/XdgCKKG40Nuqo2FI2QWf8liEanLu5+yQPz8XUY49SvxQ0dZ');
clB64FileContent := concat(clB64FileContent, 'GF7BxCrqYenU3DFXbBu04qzM0iLZbRpTPVfYu7HKj+bPh8kc3B022ImKrgLcdwpycOp9o6kg9WZT');
clB64FileContent := concat(clB64FileContent, '7pt3y9TTWLG71XHu/Mc4UWaY5rKndGDS/EvNtF3+b4CaPr7VeiTalp0j5lffLlMuwqgwNPn5xOz5');
clB64FileContent := concat(clB64FileContent, 'o/Uy6F7bVM8cpbztP6pDcBYLK5U3CZk7bJ7HT/BNnrudMKhesNpp7eWPHR40fk7U6Jtgz7jyE26q');
clB64FileContent := concat(clB64FileContent, 'JkTfbJ8rs2OsDabMceqpBRuw6oirGgSGft8HRVLjnZky4F30nKZNiUHsbKLoEJyrNNIDzi776JcE');
clB64FileContent := concat(clB64FileContent, '9spUSKcn6m+VuDRV6syM7qfPpuLzejUcGpLmL40C46esg/lNfmG6URBDgV+jxjNfvlhU8Zhw0mS7');
clB64FileContent := concat(clB64FileContent, 'HYtTzev5JNIEP38tTfaHstIBMksU17P7TTVBpYDU6zdrwAyT7xm5cw5TRE+n8mo89gKYwbkebBK4');
clB64FileContent := concat(clB64FileContent, 'sYkAw2QXF+ATVkohyLEIYls+JLXdbXMGHC/shNI5hUGUYpaXbcRXHqVz+wPY/sUuGX/jk/yeh2tA');
clB64FileContent := concat(clB64FileContent, 'FRWARLFEqiZlRPtXQbGQFt/2RvRkkP5HwN1pEpKxdijRW5CjG6yLbjdyZ4G2zS/CcqzWXb85am6e');
clB64FileContent := concat(clB64FileContent, 'CSg+Y4xBUCIKzoiLR8Q67PIlf/P7Gc4G5cEviO+h6+j9XHF9jzPNdcqX56wzqtcCSqRU6MciVTVz');
clB64FileContent := concat(clB64FileContent, 'uM1RxsVpS4Q+MmHB6B7/DAUOhnijHbXeDGjp4jB6ZivvdNcVCcS7IAHmo2W+PseGIuUi+jGgEMfz');
clB64FileContent := concat(clB64FileContent, 'Sl/yQIJn7ZyVKWp25CakBQ8yXQ5vfOL61iQl1W43nPThV1aK93TNe56UbdtUe+IFoyKiWIz963r6');
clB64FileContent := concat(clB64FileContent, '+vFdxloPHLod+n1sRoM00NZzpKT0scF6O7YN7qNUdxqjd6Wch9ptAF8J+em6osP0VTBwJ7kJvuH3');
clB64FileContent := concat(clB64FileContent, 'pgSUGyQUK+XqhryRsGS1RJO76TqSMDiizsGTzWkxakWnKrmURKMIPp8QWBIkvEtuZQzEal7UrMv0');
clB64FileContent := concat(clB64FileContent, 'Zo77dQFode5dYxiIHNcbXDT+YRboJE8+OAM3T8c4Eq5zRGe5LIHbj3HO0IdKyrjNeWyAWRmSWa4k');
clB64FileContent := concat(clB64FileContent, 'efoKkQS1jNjg/MhiD4QTU4366mRggWbMyKnwPMASWUnq6uPSre7Go9flDp3wY12959dPAQ4M/dsv');
clB64FileContent := concat(clB64FileContent, 'mcdFYSbVXDeItZuG3pfdysJSBTFAl/ZNOETK7CvDmv5mSgeTT81UWgBkOE04h3TFB8a0T2bei8Xr');
clB64FileContent := concat(clB64FileContent, 'xFlKVsq4lAKEOHPSTlWNqJA+lnq9XpvpHx76rD3MGBvUqLK+KFuTEqC7SQtn2cTiHHW6XvMXvtlP');
clB64FileContent := concat(clB64FileContent, 'RE35updVqmm3GoJFlYbqFtT5B5vAr5/XikLbkSB6Zl4hNnEt3Kk3EE5o/Jjm8XBv3UXAgSM85GGm');
clB64FileContent := concat(clB64FileContent, 'SwKSz/MwnlYcAtgD/himaO/VlSaK2YSGOb1pIyGcfSXD2l4R6tm3/GoSJ2DximXInDMs3hd2Cegu');
clB64FileContent := concat(clB64FileContent, '9Z3lx9AYC3Oz9nrVSBVsiZTBz+jxG3sKpqRG/2/BRf1ErsddJdDi26Wf40+jyhGlonFBTRSQcTMH');
clB64FileContent := concat(clB64FileContent, 'Uj67EMK5mTCEHKAddsGL1xyn2go/AnHtJ0CMI4OPSkolLE0JMFPR7HsUpzcddpP7z07+YLNlM1RZ');
clB64FileContent := concat(clB64FileContent, 'yAbazXSmd/00DPbSN4hbFuuJ6TQdlWN/HUCq7EPD+iQCKkAsg6I1/8FzgrSlRqaFokF7fHL2XfDt');
clB64FileContent := concat(clB64FileContent, 'enAuH5CJ+zh7QnG/AZcJQCfvODoyKolhnpo2KUKnylayCKAjibDpdeHKbZ4hHeGhQfObb+XW3VAy');
clB64FileContent := concat(clB64FileContent, 'nUfqbtnjjAWT6gLuQZ+UE6QWhmTseTUfm4lhfj1kaj8hkltJBzo5UyBesYB4EjNtmuA8aE7crX9R');
clB64FileContent := concat(clB64FileContent, 'gaVyGQ6V+QsASqZ/iHoc7qMXsxu6odnWcR2EZSrDgVd5tOfHpkHOkxO3wQfD3dVzm9X1wEarBBk8');
clB64FileContent := concat(clB64FileContent, 'tt7iJMGMn99I3qTgmNlDqT9RmrRLDja29lfiKmXwYz+q8JwxxwamIv/sywTdBe4rmFCXFrgRMr1k');
clB64FileContent := concat(clB64FileContent, 'xEHPIyzM7I7qJx/eleXPFVC601oyM1JhENjaSTGP/9oyLiPQujYr8pHxqsXkb6SXLTSnVS3pZvIW');
clB64FileContent := concat(clB64FileContent, 'SR54D5octIZImS3ckX2mx/VaimeCUDjo9ZiEXpKaH0VeCKcK/+qJQ48DArLQWNgq94AAUmW6XBU5');
clB64FileContent := concat(clB64FileContent, 'ma5yDIqrtli+4PbX+bb7hpshfTI2nas6rG/y9gAu96HzSBzlu+8PfFmfamv2bm6idaYp3al7BxOM');
clB64FileContent := concat(clB64FileContent, 'jHqqvHuRgWl7UhaFRzZy2elyspetmItFlPE97G1NVMmSdmrCDZcFY3Wuv1INsKNxrF3FQ5T8rBPr');
clB64FileContent := concat(clB64FileContent, 'NhvANXQqJkYZ1ytO26ckoeXtwzf9m1VhmzpElTahY3GkywdPtDAo0DIucqQA0rOqk/mbyGyvDaHv');
clB64FileContent := concat(clB64FileContent, 'tUZWIy7TaLeyZfPwT6HqSY6YJ8NZcN4sNIu3B3ajN7zW9wx7D+pyliWTzQeFJLF0usA6nBsrRn+l');
clB64FileContent := concat(clB64FileContent, '0wrRed+hpzrAZ5mlEhfQmPHf1ck9ObdHsQPKOnpiXm0v718RI6s9oMCGXay1gEwmX4hDHkeKOJIy');
clB64FileContent := concat(clB64FileContent, 'dMNlMpGN1lpz7kT6stLtSpugyJhQvRgCierP2tTndAcC7HyCeyABcag7rrXonYTU8jItt8qV+NZr');
clB64FileContent := concat(clB64FileContent, 'TyyYTZdcb92dzaNJDXTGLntlaEHWzSVX5Lt0VpZYDazhk5g9GN/HSyR+jtb5R1st+bjJYcbhkFiK');
clB64FileContent := concat(clB64FileContent, 'xcxU1ooJEi2JJd3QsueReW0Ko6UzGKk7Xi2V3Fj0aHAYm5O+khBM07Rox8OL9HsSZ6kt+6Yn6lbf');
clB64FileContent := concat(clB64FileContent, 'w+DbAU1EeTapDhLkdfzJD0h29JxosKFYx2cyOKr6SdCQik3gaWXaP9tAZAHa0psse5wnqh6nhkw6');
clB64FileContent := concat(clB64FileContent, 'wRmE80Psu3FSTjLJrpjOs8WpZ/+VESBVfpnFouJtm3QU8Pixns9NXoxcAWnxRdiWKw+bcVcLaeBk');
clB64FileContent := concat(clB64FileContent, '3eCnEWWq1+9zjuPTxsWLufRNxdIsjkUQwvZOzKVzstGWakFwVJ1YoEi0Xd9JNO2/lMcmpjXCAXC1');
clB64FileContent := concat(clB64FileContent, 'V4vv+Ck1QXEZpfkrccfDmo2iT4fkAINVc1hwVmh3GU780U/EOZLI82T+13nuAmd3Oaw3lzsX2+43');
clB64FileContent := concat(clB64FileContent, 'Cj2UAt+4iOPvP3tevfN9R/sIrxEW+eidMxj7dsJyMu+w9BbG08iHRY+wICft/PpTQUHb6sjNWfyK');
clB64FileContent := concat(clB64FileContent, 'znENcNDc/+d3AnRkuZcNTmRPlUpLvkejtToVtzPgtYMwsvJYR/UiY24iZ/43eZoL+IbL6H5Ta+KU');
clB64FileContent := concat(clB64FileContent, 'uVmvZdwof0oG1AvJQZoTqQW3oUuOZTV+bt1c6PcPMbSyKt6IuR1N8MJXYFTTjBcpullKRDkzX6yj');
clB64FileContent := concat(clB64FileContent, 'uaIRCVcyPvClrwxiePYoq59cn8tHA9mmcDdS6mICUeKm2gx6TV6u+fIU8VyjOCmDKxAYnNyfVmgV');
clB64FileContent := concat(clB64FileContent, 'l//ObC+QAknnYi+eCxvcMM6K+unxZEd/vV6qaICZABDkFxIgvYAgCnE75F4uXJO0F3Sp1OQyitdW');
clB64FileContent := concat(clB64FileContent, 'n+x1m25YSX9oFDZ0aTEjhQXZN8ZTvaQvEaXU0ExuCa5Pgx/HgMKq0Y5M/U5luY7sdfzO5+Sx3Z8+');
clB64FileContent := concat(clB64FileContent, 'ZIgWaed7LKS6EL7xKLu966sQwXLHScGfPpK4E4srFv7Qn124k/CVTjPsSSL4XTjXD75A/WcNZBgj');
clB64FileContent := concat(clB64FileContent, 'rCDn8rGBV1qgKWh9GQn9kWB0fF4uhVtBL3TqVCXmN6jvipznBDpI3WoRtMB/DYvKGKGbtHi/3MG/');
clB64FileContent := concat(clB64FileContent, 'xiV64hdzxQTqrjbT9GTGcsL1bD2kxsquUqcZ4MSqYfbyodx8HDnctx8jbiypRe/ANOZuR0hpukG2');
clB64FileContent := concat(clB64FileContent, '92N/PtmfzZam/x28ieSe3dGM/iQbqn+L63xrI/aUmcaJc033OArZANKaejaKmjOlgWw8ZtMHSO/S');
clB64FileContent := concat(clB64FileContent, 'S2Fj/ujy6XgMr+1x+PNoqxtmkNiTQC+VMLAf1UALqP7UkilwLgWxF8BUwo9TYFzTDViKPzPMK4Da');
clB64FileContent := concat(clB64FileContent, 'pK5OIs7PscG6N9pjpdMRhMihPdO2dBaiuftlqY8QBnyxHyIJPEFfPsJ9qO1vK+3MoTBMpr+VbTAz');
clB64FileContent := concat(clB64FileContent, '64FX1di3EkaQiXJRp9pIwd3Ca9DZkPV9HQLZ9M4JRb9s3bxCrNDAQgHRAVuaCiDJ+5rFF5deWEUj');
clB64FileContent := concat(clB64FileContent, 'xmqqwcI+s864BC21mseT9c4QMwPJYhqRyQCZLud5MY3J9ZiwsNXs9/S2ms1UQV6rcHKsw3IYCLTl');
clB64FileContent := concat(clB64FileContent, '9RvKKhvu2PU/jWgdJkGxC6cyqBguoZincU1nW6SjaPkcHGsrM6fOhGUHKv9xDQw7NcO7OUi8FUW8');
clB64FileContent := concat(clB64FileContent, 'g+cdhcU1uovtrZfKbGe15KMnsqqOwDINE7IqLUgRAC2WXxZZ+6qaKaEhI53brqtimtBLBc/9dsdD');
clB64FileContent := concat(clB64FileContent, 'RL9hNDjnQ5v3dyCvoS+Am3FBW2lNaKSpkIU9yya9cnXPqTf100H2pBoC5poiMiXfIVpmJaJ4EzdU');
clB64FileContent := concat(clB64FileContent, 'qepFyj4r7PSCPbgTWK8Y5mOsLOQ6nmYxmuTzJskc090HyShVSg9NzTDEYercQBgsNKQwoFRywtP4');
clB64FileContent := concat(clB64FileContent, '69k1lMVod4U7HyM+OEVj7MeEXEzexo4/QxhErY2O+vbh/vxv/DMR33jgi0btPFoXCc/qvTYpOSwR');
clB64FileContent := concat(clB64FileContent, 'tekJ6y3xPEO2CV8B301xzTXXTMlY9TBeZYtLGoknAYT4KMBAhCPfdJq7exInDhRFkcymKogdiB1Z');
clB64FileContent := concat(clB64FileContent, 'AYMvst5/0IkZkVPLULzl3EsC9szYe2Um20l33C35dMen7tQpjsFzIFCQfz+yDW0G6PViYEFsODOE');
clB64FileContent := concat(clB64FileContent, '8a0+pCVbQQeVDULgHJ04YjI3IFwm7GMpPAKe91ybXOZGRhjWd+d3w6ymLWmUxmRalZa/FIoWdFda');
clB64FileContent := concat(clB64FileContent, 'kvJnonoRWZPN6Xc+N3e2cV1Gz2sosSqCyK32y25SgIxZD5xoQCZy0oZF/pzq436zwakuuFQ1PN1F');
clB64FileContent := concat(clB64FileContent, 'XXAYVY2H3YR8J2aUL1vD5NwnkLas7dl+ktJVf5JAIV8yXs69XH3mF+D29NvNK904hyrtAqzW/UaB');
clB64FileContent := concat(clB64FileContent, 'kkGWZjN+k3X1xAR250DPNwXylU6X/kUU70pGR8UFjaSDjk7hoPfWrYafrcocSlcbXHxXyMCz8U5u');
clB64FileContent := concat(clB64FileContent, '1NaDiXwglboJ/A+KaobMLo/Hzze6blBcXGmPuoPC6RTOCF0XqM2UpPmxDqo7gANRMN6rUjtxBTFr');
clB64FileContent := concat(clB64FileContent, 'rOovAZJwBioAUF6LSkwMDiYYDyR5ABeJsijIRsltXfq6LL+c2uEdel0hv/Jk3fIK9a+DhRBmYVtH');
clB64FileContent := concat(clB64FileContent, 'fofy/g+cf6/fxM8l0nEg3dkGi9ONXgRsZRI8fpy/Moh+3YM6VlR4kN1jPvzHAozcRfqalIzzAhtT');
clB64FileContent := concat(clB64FileContent, 'SqelJRVF0nCbi7K1HSGA29a8fxHanIDZfT4u2mIiMWHetSC9RNHBjpsxA5sN7hP4DJJ9FfEmAWwV');
clB64FileContent := concat(clB64FileContent, 'EQxLIy1qs133pPVEyFwMua7FPnPZiyZi4/VOrdlMyULY/jcWKC/6ZxXYMMF7pCnU3M392xcI230V');
clB64FileContent := concat(clB64FileContent, '22Opz6Q5wEc3GA833X510tspoJftla8h3sX1a2S6TaRfgrlQynScq7XS0BDRMGVXqKPip/4vbH2S');
clB64FileContent := concat(clB64FileContent, 'ZXiTUwuXj9CwVl6DQsKl2C9QaWcq0DhxiDCYFwBz0IOniDAkA2nYh2mVZGrSLUO3OGy5lLtqPQcT');
clB64FileContent := concat(clB64FileContent, 'gJCXIDHmFZqyqjxrvf6vaBqzmnGHVO9lvoo+DzmJCFvKldtX4qqsnXqrxlalh2xb/o1YdH+/duy0');
clB64FileContent := concat(clB64FileContent, 'mkKrNDm7XpZ1WIfAw92Q6n75Ym+UxLzaw4tFqmfh+XVRVQt1UOllofLIpgG8ds11V6VUEtDa345y');
clB64FileContent := concat(clB64FileContent, 'bMZlzGwf6b6IGxIKPmHKabDxl4GcnaURMwV1V6Sw9naIWJ0U+A3w6KBXiwuzdx1MWi5bjuNjHfN7');
clB64FileContent := concat(clB64FileContent, '3p8BuzbLfVplACYJKfGltmqMSfShBgccZNi/zvf+OLGO98ndqXrIehs8LSX/aUjn0FjuvqAfyYla');
clB64FileContent := concat(clB64FileContent, '+8sig2dtkHdLsh9sIqlr6XVBvaXqi9fN7+m/o2T9Eg7+Fq5WbFY56s/2Ck29cbwl5YAy5x4yNIJb');
clB64FileContent := concat(clB64FileContent, 'utp0YqGwGVz3T+Cb9xYMiv9qByLJ6uK+DkxcsVuCGnbGKVxVguUjypgLBxqs/b1ys7iw+SQEypep');
clB64FileContent := concat(clB64FileContent, 'lJeRMMkQQEs9ZevNTInEM8w+2cQc8kY8zkG6qh8WeAw5NGJ5+nJiBcSt53Z8aK8mPLe2XScj8p5O');
clB64FileContent := concat(clB64FileContent, 'mO1ItfzWVgkZzj9dhwFtHqpD7YrkNpiD3Xr3cXw096Zr1iUpnFWL6AEQHpx8xnY0wUpT5QdEvcWO');
clB64FileContent := concat(clB64FileContent, '8XwwoTyUzVR7DzXfZcYyRsrRYHNgcZbDnN1kMh5jhXJQ0nLNCPi5sogS4qKJpuTj0zlY0pNj4EvH');
clB64FileContent := concat(clB64FileContent, 'JrB1RORvxXul6RwSUGMdH2TsWkoHDdgMZ9rBFte6FiSfIOBSkpa17SvPSi9QXSDTFfNunHgL3uBP');
clB64FileContent := concat(clB64FileContent, '0Yo1NVThTDx3Wq6F8OC6sSJQyw9BM6jDLMQCg4P5rLTaaVJ5cTGMAFGTnGzRznbsnwl/NLBO7xY/');
clB64FileContent := concat(clB64FileContent, 'rThoRbmonNGc+J0cX3MQf1WTmyi5CydzxkTxPXqXPw0jS9rV8jUAaMcYm1wZGLovsH7OtDbCQbv6');
clB64FileContent := concat(clB64FileContent, 'MNVClau2cgjozcO/jJy+uLTaBxrTEWFRrbs+KmKW14VaGdXFvS5jq9DZZ9FQRc798W1Fz5Ru7cQE');
clB64FileContent := concat(clB64FileContent, 'btjX0KjHYj5RC9E1GbuXc1cZBvCNxyonKM8sPBKH2YgZS24RcgFCh/EXXWVMVAK6/kz3ioi/p7UM');
clB64FileContent := concat(clB64FileContent, 'vM9/AkkKdV8wL2yOhRhXXGm6/PxGpAv2xHC6IjKafv9hqzTzCl8MoR3GvAsDPGPv2fQq6rH1zmTd');
clB64FileContent := concat(clB64FileContent, '+CeaIvlEVWfSD4JdlPLO95sPUWmp3v42+hhRnbFmLN876rtSW+TF9bJSAFiS+5Yn2WE3rUvuSWJR');
clB64FileContent := concat(clB64FileContent, 'aNIjgz60TlaRAAP20s2FIbUR86wqA7CgUj4qUmr7RiyfIHcYaBhiCd608efqFuRSBroRGWrG+f/G');
clB64FileContent := concat(clB64FileContent, 'UxAJyjMNoT7kRoZtWe2DCw+30TVLXlMSJi8LkNklGUhKtI71Y3hYXtYRWE6RuQOcPq9LqfVMDTd3');
clB64FileContent := concat(clB64FileContent, 'CZ7482/3FfIUTRyPraiNuY+khkOityfqOQxp033b0ZZ72RY4NMuqfyzTY/fMKbWglxiiZ+MkLJnE');
clB64FileContent := concat(clB64FileContent, 'Bk/ozyVvnvICS2aVlVnnQ7a8deuvLhay6Gs4+WO1WnJDjiTN5VTNwzIwee87UHc3Riz2rhaoEGjC');
clB64FileContent := concat(clB64FileContent, 'MAXjjCfORqtc4C8XZXyJba4I1IsjqAELtaaFSAx0dgQwwx9xoPRGWVTVX052B4UziGc8msDUIO/5');
clB64FileContent := concat(clB64FileContent, 'NS+gxRAtkxMDrP7oSKn3+5xC6iXSP2BLACvg75wuHQMM0wq9QTXIuqhllXF2eo1au1n2fx0nkFCy');
clB64FileContent := concat(clB64FileContent, 'DgLM+eLGYYEXsWwOISFCwjKsYNcC7b7hNK1VA9a0NW69S17N5cncKUXm5ddEJW3JYftQpO740ugv');
clB64FileContent := concat(clB64FileContent, '9FFsnMJyHQeFjLCqU3VelmCNyd0vHfJKmP3F1OjA6JFsLUY6RPk607P6T6bUOOvn6vkVy2J6Oh4v');
clB64FileContent := concat(clB64FileContent, 'wIqOKyva0fkPdJgNA2bJFjWSOrTRNVcxbBH4Za8OCX+BGYzXsWCHOU/CeTWgCjJG/N6bjlv6nr+1');
clB64FileContent := concat(clB64FileContent, '358Gmv1SQ7ffAbwemIzZKSg/Qp9B41WSxGs0mkOVXUdRBHU1XWZDPADicoxMaCFWZTdCR2HRvtEn');
clB64FileContent := concat(clB64FileContent, 'syVowBYRW9q5SnxGJTb5CfSoy7IrfpFDJYO7umyZT3wZuPsNH4C4ho4IWB39jUW3QCtGmZ/pzrbW');
clB64FileContent := concat(clB64FileContent, 'p6Kua/+wImvIN7zC5eznP7V/aJj1IcIoZwvpJHulNvwPyMf8KqqSJQZ683fnOceZzIdZ8HDWvdKk');
clB64FileContent := concat(clB64FileContent, '9nCBkh80H1adyaRt8nZwvzrmA3bK2mkCeK8ytKky/lXEq/z8kNwDDfX6kkT97JoRe9VH0OXsgqqn');
clB64FileContent := concat(clB64FileContent, 'Rsi+v0JOWVV3/0+BGZrxXfFUaDbsMsw41dd7W2dBgpXza/GAhVAVnjlbFHnnquboK+m4Dd17g5Hu');
clB64FileContent := concat(clB64FileContent, 'xUOZnvZYXzVy8QuDUy2yYg2ids5IY9AcfTBJB1EY9ZE769jWg8KIQeCfAvTz8kVDBpQwWaZo/gQz');
clB64FileContent := concat(clB64FileContent, '34vCYSw6nDsgoEJGpG16ZY2sy+Vh6TPc8X4hIM/PEts1q99kjUaME2O4vN/G8ik0WpuDhJ1vjsxk');
clB64FileContent := concat(clB64FileContent, 'MO1R2OBtmxeWFYKzh6UqxkezjRgvPe3OtPoA8JEEFeYpDNU96PRl8WDLBgmr9DUtbdYmDoSRQ7Ml');
clB64FileContent := concat(clB64FileContent, 'mjgyepnR2+PGl5e1KYRRnjZoNi4Cd+9afTkanyhL6qj+63YcZjYbi2YsQj05M+cv22lwz5nhG+JY');
clB64FileContent := concat(clB64FileContent, 'SHyvmPbTvf/3RxpQRhP1WrUnVYVu/VGesSGyEton0XE3d40l/TFjj/eWQCyil+A+00jaSYHAdhJA');
clB64FileContent := concat(clB64FileContent, '0WqoQOhFPL/TevOwGItf8nMggIStEcNbc+xW7rd80JOiNChL67oKEsrLHV635XLIXOpF4Lv8NIzA');
clB64FileContent := concat(clB64FileContent, 'SEQ7+WtTvLj7db0Vk4Yji5TIqcXpUM9j4+wLiSSTQwUPOi+tmicALjJWMQlicvF2PhODrtEW566W');
clB64FileContent := concat(clB64FileContent, 'xyPfoD3xhk8iuH2yL95yJ8O549oRTlqN++T4ukQGmrdQf1Sfd1v+I+JKmOGbAt5nnCJjlZjHxWff');
clB64FileContent := concat(clB64FileContent, 'UHuy6pBBYqrx4kFZMni+KcjiUM+W4RlVb0qlX4r1VzWhAj5/ONJ/popfArfkBC2jMyZ1cc89BPU9');
clB64FileContent := concat(clB64FileContent, 'OGL4SsXreyjpiIXkzGCH20a+w9Iq0/xOxJ6xYyjhHkkdO9nWotbkm4LHQxREDzP1S9Z0ZWTsN7Yi');
clB64FileContent := concat(clB64FileContent, 'VipXXfxhBfgzPHcL/mF+1FNgHhF5oSt6xFFSLs/nqt2K06ji0ELL1ldIxVh5qII9rnfAWhwvG7X6');
clB64FileContent := concat(clB64FileContent, '2E589g8u8kr2CXFrZ57WOjkU8NnXiR1hXHfxXHt7ThuZX+wcs0cSA0OPYW2W1k/o3xs4ZWYyQhIs');
clB64FileContent := concat(clB64FileContent, 'QpLCGCwrtcv+zNUf6XPcF7el6yrObWr2JMP5Fa1nXcOSwbUnvu2rQhpwIiudpZRblVkN9IrVvbna');
clB64FileContent := concat(clB64FileContent, 'SRoo01aOrvsttip7FxAkEKjTg9u6fQ5xBPgWRVcxqQdjq3iwa4kZWWSxNHlzezg9EVcze97NIqZf');
clB64FileContent := concat(clB64FileContent, '2Rveza1zqCzAQsaFCCe/f2wYogdBkP1kCq7uppFCdDxotmBxWz8PwF1DmjOMqjhSOzK2updU8390');
clB64FileContent := concat(clB64FileContent, 'MDrtAcErjdoD0N5tDhyVW5j/5VgPnCAd3wJE3ep9ERmOpzKeHlKtiG9biCkXOFzhVnl1BFWYpWEi');
clB64FileContent := concat(clB64FileContent, 'VbMCh1u9+Gv7uV2I/EX/akuckAldHrnur9qTbgK5UXCGyNIU+FMyXLuKTsyVXExu8LWItcJ6KtZH');
clB64FileContent := concat(clB64FileContent, 'wkMBeXJ9o98nmdFTn0+UDAxM11a0m6m1O54Iy/d4ftbCB0+kyX+Ir04DcZ8yKLSaqSjhtg/GIOu8');
clB64FileContent := concat(clB64FileContent, 'f2SjCVDer7MOn1cI424jtLsIlSMOOTsspKuMAHaOTCMMnfTDZGtoruEK6yhOHgSCyb8TdrMEZdUU');
clB64FileContent := concat(clB64FileContent, '9mJhiRfGIMfNHPJbM93rQ565pk1DZtM8BvlpEIS9RL7MhcUHxYk9a8/XY/CpyvLjME2gXehrYdZH');
clB64FileContent := concat(clB64FileContent, 'l/Qg1+niTzhkaeelqIvHUQh09Ih7qKXNovHAvKV3j6IOjiY+4SrteE1C43Y1TaJf9mFRGjQA5vxx');
clB64FileContent := concat(clB64FileContent, 'X+3Sw9mDpRCa1ToolHfwQ1uEAaLLUoe6mzRqQN3YszWqeGiapEwrnz64vz67jVZnRwdpOWcNmrHz');
clB64FileContent := concat(clB64FileContent, 'ROQ00yfgi1ZUAtKyIdsln/0yjd4T+lVk9Cr6lXPv3y2gugkr75Ywh4GL0DFk5iRT1l+HBsPZCJ6R');
clB64FileContent := concat(clB64FileContent, 'BWbYiJQlFGpaBEaUnssO4xmLTHF4rA7qe/+mfxjtjAGWNoOyKrzzA1NaNz87+tlb1MO6lb6GJp+9');
clB64FileContent := concat(clB64FileContent, 'dz1D+L/+ryD8QHDJ25IzhMmkBJH2xyCnBDqQaaCbjVnYBqjVzWY1yGEhtvh01vzgenMugdUtW/4j');
clB64FileContent := concat(clB64FileContent, '0UFzLIuCoKGGwjGHf2wgk76WLzjEP6xoyQITnbt29qsJhZ1IN3vGhA0v1VpOi5nZzwdGS97HeXgg');
clB64FileContent := concat(clB64FileContent, '40Qg5ICmX6krRtTpTcgo7hZhiTxp7UxhjxYRWPRcQovXgbUAKssOhf7MlIRTRpNnyyTvXevS2uJz');
clB64FileContent := concat(clB64FileContent, 'sG4OoITfwGwwqomJypSZKSMzu9Nr14fjAu+l2CSxg/g3QxlDDmop2lTFwwRuQCDeATulxCXsrQfp');
clB64FileContent := concat(clB64FileContent, 'cFaJQcmOBBx1BSlrbn0+2Wx2BRyAmKttD+q49i+ZH26qA8ex3UAtiW8ecJWE7potTbJgD07Ghnd5');
clB64FileContent := concat(clB64FileContent, 'UR3a/vMw5zAFsb43xtucJu7SS2fSMtWn9uyLauumiNBFb1ilq4e9xAR3u/CAcM8rFQlhB+FPZXb/');
clB64FileContent := concat(clB64FileContent, 'I+JsYWa55ypxjSy/MJp4ProT4zvgGz41Skoae7PYLOPWQb327gJEGFaf+GISvDvTCWZw/Uwj3OKl');
clB64FileContent := concat(clB64FileContent, 'B4lE7bOQkdTQKcpuF/gy/Sa9DtZW0oBEqLGUpQFvhI4l/c4ShD7N/8jMpuyv5MdnSEMdNBafFoDe');
clB64FileContent := concat(clB64FileContent, 'XMZIsps8ZqvplhbPI2GEb/syIu1vNfc/8gJM9SSNJJ5/YgwHNP52g9xMVIXdIo9TPUPfFjaf98mf');
clB64FileContent := concat(clB64FileContent, '/teUz6YCWIAsRjLCdc5PxoUbYSPE0GoUgprKfhpXJUbzNu6jXWhgKke5TfSPciNzVpFnJ647HSl8');
clB64FileContent := concat(clB64FileContent, '8NhboTC+Dj5jwFAxzsiHfsts5hvMQ+97iVOFlF78ZjEvfRGbnQEEjmKGe+COtS4WVTAqaIi+IIqo');
clB64FileContent := concat(clB64FileContent, '81o8n4xp1EXy44ASgKsLZi0T+/AucVHGF7nC6KHD00MQDPZOlq5aYw5VbzGBaObQFpN/am2zhLI2');
clB64FileContent := concat(clB64FileContent, 'oCBIMK7l3Dw0WLH6fMZdigM+Iq6w8WRwbDWVuN/qUEW+0N3W1xQ4TAhuZ1CYJkBKkzffpVBn3n7b');
clB64FileContent := concat(clB64FileContent, 'YzeG2RVkdaw3SCfeLRdkGIWw2lXmoodiMv9vKwj9k6JTiiFzBVvUEGUnRyYsRZAe366mHOwhxdev');
clB64FileContent := concat(clB64FileContent, 'R9lksm7Sz8WwhHVT93o1iix7IqAfY3to8o9BZVvtwbdprkjucsjatBWiLa3sRo2+Vb7dwFxCNjUl');
clB64FileContent := concat(clB64FileContent, 'F9YVFg5YSaXtKwPss1oI9nmdhcWTedSXDTPJb5dnAaZ3xjp7HSxQDezfUwZndxOw69X4rgguIXl9');
clB64FileContent := concat(clB64FileContent, 'dOArsBdAs9Tli1vr4y4eXYDUma9Bf7ZqzPKeNCCIzQ923Kd7eDdA3z8AaAEaqB+rs5S+R2B5R7iF');
clB64FileContent := concat(clB64FileContent, '9PvhPdb5dZ4aK7pJpTjnzFQuqUiYHI3kKEhtN3Oks1p9vIdOhYivloiEAeQ5edZQMuXMxCUC47wh');
clB64FileContent := concat(clB64FileContent, 'fWy712VlxrMZdLgu4tHDR8d6/KIiAnD2GlSwLeBtUZzwcFBeplV9fpodj1aGi2wFOlbuGJpzhzW/');
clB64FileContent := concat(clB64FileContent, 'tp0G277h/J7PaLcgLc4IzSoiC+F1nsJQWKiamq1zcAG20RFfxK9dyxCK1vlAlmc1QmxB0U4tyJIR');
clB64FileContent := concat(clB64FileContent, 'T0mY60RXFMCwN3WQ7DLAHB79WZtnXKFPbSci1ddpJ0JkhEaXZbQfWP0/uWjWSccDkduOTNPjNY+S');
clB64FileContent := concat(clB64FileContent, 'AeG0vvRN5h+QTdvXJbkX7vkZI8L1QNLc/VIHHo5uULMdktjQW/AWNcLXTfiAAqdBZHOK5Uit7zjr');
clB64FileContent := concat(clB64FileContent, 'M1vQiMRmN+xwCukliIH0itwDjjfw57OuCFrmHTVWvyCjfGvX4n23C7hJMesSEhJwS5nTYQi8Wd1O');
clB64FileContent := concat(clB64FileContent, 'HKBiVGh9fi1AJAq53pk93xeVpD0sclllg1I524Grj5Z2Zcko9gp4Ve/NQb4f9PQmjm7TGS1/Bjxx');
clB64FileContent := concat(clB64FileContent, 'zurdjdB3AKsfNz+1j+nlHBuTrvDU7ltSrCGPLGDxnmqzM/8czDPGH/K58h4QUO5pv7EmJ08qJxaO');
clB64FileContent := concat(clB64FileContent, 'TGInqxJzJxWIHPETQXMdrCWt+9douqb/HynNQw7ssGj7DopZvnRYxW/6IYxF6R+rMF9ehTk6Sz+L');
clB64FileContent := concat(clB64FileContent, 'TZYM7rVwwtPE4v2Xrtj2J3DWyauWdb/yEXWXQhHIdu05GnEE6/ysaGiXDFrmSu4XRU78nzzfErqT');
clB64FileContent := concat(clB64FileContent, 'HyBvxW+Et6U5TmXZIG67n4M08vvdm0UvYkRL30UUqvRjjm1wpcnxj8/XKf0TYSW5Ofwv67LhFO9o');
clB64FileContent := concat(clB64FileContent, 'xy8umRB361BtSgTMSEsAtyvxtFSl88bj8PsPFmmjgxPyWXuj5yRA4TAYch+PS51nHF4ImISlZBL6');
clB64FileContent := concat(clB64FileContent, '+HoJvK8hiDzh7sCj8TH4EuZeTC/z7DvADpVTL6Ku3Prct5pN8d8AXbGjB1FaKvq6Cq6vDilQrrSr');
clB64FileContent := concat(clB64FileContent, 'MubtZQICVeJJxn2ORMJTL3s/xKPqZqqdxYji91+ULDJvBMreJo3OSREDjjmwvdIbueFY3m9pbCnH');
clB64FileContent := concat(clB64FileContent, '+xNPClwJ6U1ZpokJJz2mgHp25OQ74Uki/d81/omcnHJ0MMuuhbvLa3cpgG7rlBUN9d8HjdMEZ43l');
clB64FileContent := concat(clB64FileContent, 'n4KgozTsPW0+yyUk86/j3xKXeW+xOcnyEpTG7z2qP7hczkuZGPkIlRINy0mA/GpHJf2PN6PBLDse');
clB64FileContent := concat(clB64FileContent, 'OIoGjElSXZldfKJFm0K6KsCxHpxNidyD1yKpSxUEj3F0jmfrGGPioDzuJJlu3U3CGULQqsT2MFni');
clB64FileContent := concat(clB64FileContent, 'Cj4Fm+uhTTn+0JLM7KQw72dRqyGxr6oH24QQa3NtEapcpCto7hfPH55XYHTne7xJoSS4QXEMfvVS');
clB64FileContent := concat(clB64FileContent, 'N4lwb/CdtR2CM4VMxaYgn0ZbuTo5kzmPYBeZJdIRvL1ZHDnKs4UBZGjFNL9BfUFDLhjghM9ZwPU3');
clB64FileContent := concat(clB64FileContent, 'HPygwFP2Dz/jExoIWOKUjDlpoPmDeHu9o9smtlCQITjs1ujVJWstITz8KfwWInZ8HhgZAZyka84c');
clB64FileContent := concat(clB64FileContent, 'o9KEow8raM4x63TwiHKKx1NImSK/XGC2BvEXGwEvcunG4wU+d6ltR1iJ1eV1FdvKB5jLnbzJCNGo');
clB64FileContent := concat(clB64FileContent, 'rrDRF+oE244oJ9Cu0Iyg1ED6dP8nGe1cx7VC69qGei4506iwKs54OV/zw4a7ilGlvt7+18t73Sr5');
clB64FileContent := concat(clB64FileContent, '0gnXjYpIdVrD+1ANxm+SWNNAac7Uesd4/m0iPPZIksP4UpiWKLDrlLecjOpzBC+LH6X2zaCqK6Uz');
clB64FileContent := concat(clB64FileContent, '9yZ7SZKiJW1v1vXdy0AO/lNWwSulAnv7jKxDnapulpdnBRIfRqAFLcrkXUm4Y30UOVMGpbbKIfm4');
clB64FileContent := concat(clB64FileContent, '4WTw1JIJxAHROLwcY37ZpLiXOmVxw2fRI19pTyLgjqySOXERN5pigTqw+QAQlBNhbk5xVNnDMfWO');
clB64FileContent := concat(clB64FileContent, 'ex3hruzNYa+x6BPOPOyuCuLFpCmvTcBD7c90ltVvUDBi76l+CSeNCoBSQxrQHsbf+ORyNSpVUAvf');
clB64FileContent := concat(clB64FileContent, 'dEA0kBT5/HJVrTxHNj42OelO/uS4t2vCY/0LmeZm+GtiuAh5+0QJ617xKWCaAc8wv+dw7MnCHDz/');
clB64FileContent := concat(clB64FileContent, 'KRBoMBzv7d6wSz1e7ygkMcX5op+d3qUndrbR+qYXOnjh+RbwaZv7ChQJ7uJFu05I+/jm1nFEc75y');
clB64FileContent := concat(clB64FileContent, '5brsx8eu2Nw4U3TsYphU6RfZS/fzTqzbH6XGf4bAcCxhlnbTmfr624ZbYILJBunGwHzIIBuWciMp');
clB64FileContent := concat(clB64FileContent, 'zpaweGFfDtVvWryYgFH+kTnjIwBC0+FlQAi9GEA5RGzDpSm4gHec7Btsv5W/ZQdxyt5JU2YxInAm');
clB64FileContent := concat(clB64FileContent, '68BL/nm6wkLcrTNCrAPkFI8qccwdlNV2kN+mZuoJteoc2SdaigrzTQMHA+raW14gKaDLO9ap97yT');
clB64FileContent := concat(clB64FileContent, '6QqQxrLp1Ig4a78pto58MJL0opDXzaTL5rmnu/Yw4J+6iktuc2JXZECvXwe8nMsiW4KWuV3s5rrx');
clB64FileContent := concat(clB64FileContent, '3TgLFPQWDvIGaqiGtvrCPW8u5ZQ7L87lxznPi5etC4QPTl7cOid9E7PcyyhX40nSrUl+XS6oP+R2');
clB64FileContent := concat(clB64FileContent, 'NQ2kmUW/MzLvXczRFbCKv47SneYvwDHWNz3hNbCR7wh0rBSOtEdq8+mD8MccbsXDakNUrTOtvQXz');
clB64FileContent := concat(clB64FileContent, 'mFMfL8GtiBGMv9rBc2g1vsfMdJEbLRhbAs3gb7c+pVpuFUU05BwxrHHSLGRrWKqp+AkIXVzkYPk3');
clB64FileContent := concat(clB64FileContent, 'zE4l1It24z+VxM4QxWd/giSYn8z0/UJAIb+0+FUoo1/QvUc8nNUO2An99kKe6liG4cfWFqxf/L6/');
clB64FileContent := concat(clB64FileContent, 'BkE22LxEiRi9bHofg4Yt+VFZuDIdCRPCgDPzo/+qXFRF2M33hrPWA06oT47sVtz4JcSFU1DPNZAz');
clB64FileContent := concat(clB64FileContent, 'Qv5nOClkn8j3dLkEmtXMI+ErEdyglnnl83asPxbmh8tckRmT/O0WXrFJIncz07DJSjhvaltiRgvC');
clB64FileContent := concat(clB64FileContent, 'I7BISVSf4MwV7hqxWuSVUMS+si2Ul+RAMyVI8HVyq0WJVl+YhIS6HnAIVtXhZIa+dkNQECQTEDi4');
clB64FileContent := concat(clB64FileContent, 'm58+h9RjJRuvMRETsS8bPywIa8g+20Y/oTyRxTXKFXIUTY5zFd4pw/gHyZ/KdNjO313jx6HN7dcj');
clB64FileContent := concat(clB64FileContent, '4aJiJTT/ujODsUH+dordhqTGRwIalysG9ljYPbzhJd3OxPiwJY/8jQ0DBBhd5nHNBehyBUTFQqHH');
clB64FileContent := concat(clB64FileContent, 'GQA6keQcYrdbq6nkt82zYhSj6fQO4ATljsByXxx1QovrqsewzasXYw1dMsmcCUaHBPyoR5ypMHAW');
clB64FileContent := concat(clB64FileContent, 'A8hU3YL+ZrmN1UBXMDFjO/3By0FoeS9V/vsNS8AOW+wLDedFx1/BLpr9kwUAmUevgMwXRhw4tMCS');
clB64FileContent := concat(clB64FileContent, '9n5AS02z5vHOqgh8YAULjCWhE+fbtbtLMvy3T0W2dVxVC2+3qJw0V1EBwfp93K03YbJEDzA/jQ0a');
clB64FileContent := concat(clB64FileContent, 'JrMNP6UAp9T0mCpQvgDp4RNXeiufRjwa9l6mFRQ+w1VDKZzE5FBTrVr6tnM2ZvzfM5PtKA/KcQR3');
clB64FileContent := concat(clB64FileContent, '9pXnGjd5285KgdWKG68+1zvC3MwKRy+Kq0Wcd5B5RL3vEQhlhX9nVd9bz9Ao9AVUu9PTYOZk5aUG');
clB64FileContent := concat(clB64FileContent, 'dfxGDDn6uijvsN9nF0In8ps3K3hfCNSkZfFgABewtPf2Le8m5PBQOzMDTiwHpqdzYJVTuHtJCm+f');
clB64FileContent := concat(clB64FileContent, 'Im87tfrmJO0ngPEF550g15I5LNPhZiCxoBnpkh+DOoYwmGLP/waCvVC4eP6UrVGkOJQteZkfSS5v');
clB64FileContent := concat(clB64FileContent, 'r6jga60LS5Y6WbDOVDj2lsG4vlFBTkj0GH6NFuLIF3UDsRW2kNkOXKWrUVfC1OhOkjWG9H0MAWIF');
clB64FileContent := concat(clB64FileContent, 'CPD/e6ctSHsIC8fTFf1veyRuFlk1QvKPtAdWpVegIR3Mjxsb+Z9tqZbFtW69wao5Coo95YFT6Wqw');
clB64FileContent := concat(clB64FileContent, 'ryoJdwEXIgg2pqTGVOEsUZCTFwthXIkoB6pcTpLCIm+Z8j0oZlavBJexDfOQmXFRWv030n5q690B');
clB64FileContent := concat(clB64FileContent, '1xyjpdlHpNQ4RnF+zZlAYfn9uw/Gfe2K3O7g9pGXd1g4PoFjzD6qq8Ipe9VJVD8P24OinPGBBDoB');
clB64FileContent := concat(clB64FileContent, 'TVsoXlls89ObUYIPmdquT33zn5QwtMpm6T6M6qYzOhnVQCVKMBV1TFahOEBxpTUQll/lFD40Jo8t');
clB64FileContent := concat(clB64FileContent, '+yHFGC8knok7tH40T17qlAIiPCEuM6t6iRNMIvYcnNW1LQP4V+TldlfLZFgpBmVTbVh3uQxJUnqn');
clB64FileContent := concat(clB64FileContent, 'YEKxg2CXswmEllbGZnkAyhxbl0ct7kCoFY/G1XneSXBRGUsIgyO8gLnIJUP/Xoql0o8Ul6JbVnou');
clB64FileContent := concat(clB64FileContent, 'jvBDefQy1BEIkorDE2Lt761XbReH3yhYFXKS593/pUrxj9TXJaAP+CH+CH1PNwd81RLWmBPqyxjm');
clB64FileContent := concat(clB64FileContent, 'apEov6Pp3aE/Beuf3FjGZrP+G9CoJOdtwGF73H3BT18UctfVpc0WbxlqmdPXSJuz78x9kszVknj0');
clB64FileContent := concat(clB64FileContent, '4gd5lnMqCh2N3Bf46l4SUDcRKPdEwLeXflTKNnqB5d5aoHB/oIAsjcmPfwGHO/VHslzJiOYz3Mi7');
clB64FileContent := concat(clB64FileContent, 'PYq8Y5TV2UIGwi8Js8HpTnaOWRqHoBt77sB7QyQl8MwWaUxcZpjBYIc9iJR6i/G2ugpgQXxP1mLy');
clB64FileContent := concat(clB64FileContent, 'gnjUCaDowjz7ynsd0XJtNqktmCgbHEDgUISYz2LebRAdxh7FpwQICakMAo4HeDwMofaVDig72tYr');
clB64FileContent := concat(clB64FileContent, 'HL/PPaauTA/0ElOAoOSZSzHUReMZO37YlOn4QkjN7q9SgjNSFCSQo65R7ouD1D22N68vrdc3db9g');
clB64FileContent := concat(clB64FileContent, 'dMi8cwIFIp5aeu5tfNXUcIvg0iVzSEQJpprOLr0abWGsx8/wusLRsqPBCzzJDth2iiuCzIGsLK3P');
clB64FileContent := concat(clB64FileContent, 'npJOrP0XmckqTVgDCSELkc468bbyDRYP5gsdDaAgZl7/P9HI0SN4v8M+JL4k1Wk2JqRHXpuHxWlh');
clB64FileContent := concat(clB64FileContent, 'CKxMX8ITuyBQfLeXiCrz7fIKrm82wrVlrkIM1dbr1hFFlv6y1RVbDH3+lZKWl5uXhOx6wMsXIDuj');
clB64FileContent := concat(clB64FileContent, 'YLHRQUNRggXnIN6C9zFF5GbFXmsXuVEvUbWTptTuKcg3mh9vr7drWOl4ie5Bn0y+7Y87AiHgB9DU');
clB64FileContent := concat(clB64FileContent, 'FM2akCxtKt3G11rgbJz4eRCGBBp1/3xoHYvVdr/24XJJQdLHZStNvh+9d6ZOyiZITpKegV8OFeya');
clB64FileContent := concat(clB64FileContent, 'lwITTXmOjr+8p45ckGexri5D4G2INcGVXvE7b4S0Yh4jlBzB3IeMSIKe+QSmHwQZiOtsxQHJwYld');
clB64FileContent := concat(clB64FileContent, '8xm5xzPT7iLBZYJOBzXVL8fCq0huBUTKq9fhx7qsd+9qoEpGKjPGSpFfnlNhJeYIIArVnVJua3Yi');
clB64FileContent := concat(clB64FileContent, 'xoN8k7kB/iyfrCwDC1J3zelY2STAfa9dSwVe5dDT9mm+wTCdzBfg9+7OUca3e/jaVUJCEvmtBP+U');
clB64FileContent := concat(clB64FileContent, 'zPJNsluVCGH8GZRALV471UusTVtl7F9DTuNcUyh96sey6Tpu/m+VUz2T5G7rZUJTzGNY8QpDZ4jJ');
clB64FileContent := concat(clB64FileContent, 'UNhhvEnTHR2I5Y2MtNovio6R78eDxjTw4uQHJfrLHTjyB2yZNkS4tY7aB5//xl03UT/heK3jUmd5');
clB64FileContent := concat(clB64FileContent, 'fR+FE0YTgV+4Py6UPIlOREzqf9MaYFqQPdTQa7uueytzFqpn/QkFfvOvW2ZItv0aWOCPYCj2pjIE');
clB64FileContent := concat(clB64FileContent, 'G12yMMFym5HEw+6Aupa9gH0cd5awBlDydqAQonumFBYrgtJCEga/pgZlFWy9xGww9I6xROXtwUAa');
clB64FileContent := concat(clB64FileContent, 'ojcs9WLbsvFM9uNZe3px+o8izkgbvQQwroq6mpx4qGu3xxFdCkdxJAzfc6OuzxoJQmyKN25x3XEn');
clB64FileContent := concat(clB64FileContent, 'N8gpIOG9MT00DwlOK7knf9NJgZW3/yPsVVbPNNY8rqlV2c0n20XybUoDhcKUKLg2/CSnygtt6SQd');
clB64FileContent := concat(clB64FileContent, 'U99EYGfvveCtpNyrTOfUbj4J5kF8p8ml2vopLJ8PFczHDAQnysj+2RN6E012JWjh5gGvNJvScYCn');
clB64FileContent := concat(clB64FileContent, 'YTjgOjlCUoD89ZzY8CupXGZiYI2rly9nnPa6/3UmGNx8kaRps/cgx+F6+altQpzqQ7dmbF2f1n9s');
clB64FileContent := concat(clB64FileContent, '1+pGVqrjirW4oOLErHTYQhPpLoOLyeL8LJLB85Ipb7ixa60qp9m3p69q2CBaVs9D8t4mMCyuAlMo');
clB64FileContent := concat(clB64FileContent, 'szO4+R3pUHnUTN2y7duU6QohpUAxaTV9Cv3+5nfGka0w6FS4LgO36CVEpG/FqDblKR2eul/Ij7Jx');
clB64FileContent := concat(clB64FileContent, 'kG1VyzmIwSuRf/Xp9KUxvJZIX0w6qGv6NS3VBmTspAJmmrwPaY4OUgGIRrk4LrtMUmFkZMHMhBcS');
clB64FileContent := concat(clB64FileContent, 'hIoO5FA2hn/5puWi1QMy1qAwvxPW8lOI9+pPPKEa9gdVT+Mb1KAcpJYZMu4AifuilgXDmsQ6TaCg');
clB64FileContent := concat(clB64FileContent, 'JlDsCRAowdCPZS4j6QZSj5pd2O3DoNmah9F2khPqR80fJBGbRoSsTtAiFTgO5ysK9TqW70VtKzKH');
clB64FileContent := concat(clB64FileContent, 'b3C406n0yOEinQRqJHtU0UUf0+kiVqQ5jE5T17ncm8PQBP1776vzOtxckL0ZCrObOCadp44VGpBj');
clB64FileContent := concat(clB64FileContent, 'PMDJLIrCavyKrpdpSo12zL8IdQ9LlPUYfNXqhySCtpWxyhRJ9S+t5Dz4KGOGmB1tV6vLv1exR+OK');
clB64FileContent := concat(clB64FileContent, 'fv8040H5AVaL/6Vv6w3b+MjdAq6a+NTlxvnbtTUR2Pg94jpy9m921d6tiEPZSZhWI3QJjwSv0m0N');
clB64FileContent := concat(clB64FileContent, 'bHxOQ+suSEaNzLgj+Lwp0LKDVW+6gRTOzBDUIp5dpamOrsevCTPfGQF/ZEW3IHLvcMRMLZ8ftDQO');
clB64FileContent := concat(clB64FileContent, 'efGc9kSZaRVCPImt1/nRG9CwvpM+d5FgMDUFs0ByEErel+6sY1Gese2JTw3vDXBeRCkhIcT7KqCq');
clB64FileContent := concat(clB64FileContent, 'hTaS0L0wJScH/4PS2lcHc0URhdZS1Wb3F8Ykhjw5XQjswOXiH8ESiIIy6EudyKS6VEYqMUuyXP6V');
clB64FileContent := concat(clB64FileContent, '9eaiNMCT7srHaZLNb2FOZtx/smbDBxOxi+3VlRI/2a4sHsqmaGMMAHH2Fb641nZ4ut99EgB8/DEw');
clB64FileContent := concat(clB64FileContent, 'kk++jd4LcfXRlxyztm+PTqgdDguAXordAExIyF620NBUlUcWTsgMgi1JuRr58xboXvAAQsSD4cYx');
clB64FileContent := concat(clB64FileContent, 'zM84MlKBD70jaowNYpnb0Exlo7W/AfGTsgAhl+L648FeAfbee3cUrCt8Odxd1ShhasfAiP7qAlWf');
clB64FileContent := concat(clB64FileContent, 'JIpfGebec4BH4ljnV6nKWy2CXmXC9p3uT+fZUMH6wzdpJakAO5NUckLXSCps7FUavdO6TFVU0YW1');
clB64FileContent := concat(clB64FileContent, 'jJf1NQUGJD4Tvy5s8g2uOzB+hqEdzOnaSyLpJlUyQrFSc+tZGUQqly/k560xfbb2gJhbHnGWp4PX');
clB64FileContent := concat(clB64FileContent, 'gwbUw+4ZQJfnqZwtjbUxZeY95JSBySTZAv9TnUn/I6fNns2089MG8gMDnWA9yyLGZyFf5/QhyZGn');
clB64FileContent := concat(clB64FileContent, 'J65VSB7i6fxFW+Ez9F5R+jJUaBl1Pj8GtXoFZiCDoRmeIgyQgGOPb1cxvno6DU3DgUN8Uvyw3lLd');
clB64FileContent := concat(clB64FileContent, 'lzVwMhELRii+YDoy08bd1NH1ggCe/g0XoKwrPrr5BqMjAbNI8p/nC0kJh1XPDtPCDrpW/mRB2A1l');
clB64FileContent := concat(clB64FileContent, 'XahWy8rTx9ZWU0RaHaue16wt+uiHZ9qrcoS2d/89iT1+VhuzC+ZigSynu8ZuUzd0DDNe/nM68dTW');
clB64FileContent := concat(clB64FileContent, 'mTI05q/jmHnU281nItXEsydKattV/2HgQOeGAWsWlaSuS9b+J8AulbcAhVEC2H7R4uTn+nyrtmvx');
clB64FileContent := concat(clB64FileContent, '8/XSTGUsrpdd4TXjbtXoQAp0+nyhOAX4XsCmW87viYT8MOagG3FmJca2UzPTV7BBVG1+6PzGKhpB');
clB64FileContent := concat(clB64FileContent, '3+T9+3OF0k3Dkcfu9dhUQMrZFkudQx+q4D8hK2p256LpT9Z2VU1m22Fl/F1KXNAlIK7y00QzLlpF');
clB64FileContent := concat(clB64FileContent, 'CLrOYIiKQ22aTE0MAw0fbMjl5J2czjY9L2I13dE1xCsbe71q9fcKf/8qhQvU7FYy1aPo3tZX/Ccm');
clB64FileContent := concat(clB64FileContent, 'wqkZwgVwolXDnJjpb7Ihcg5Gpzz7d//ElkA2CQtnf03D1rv+TGKfgu3cSo41w9nc14nfZ4xCZ12x');
clB64FileContent := concat(clB64FileContent, 'T2SgsuraWpLEk7HiPkHTxQcXoAfLMffdbJ/JZpCy1jxzbCTkkoa2kOOC02mICs98QwRdMW/IIPAJ');
clB64FileContent := concat(clB64FileContent, 'BwDBT/pnbWFSGPCcPMOF2hzOGPp5jTIo6G7Kx3q1QqzybqwgKPz9EnEA+xImCMBUCe3RquJedG/f');
clB64FileContent := concat(clB64FileContent, 'Z+IlpnbigmAeHQx3rOLjQNMS5k5OIs3YbRW7fqujiEcfE1xyNp+kC75kB/6JiX6lqEYE6RZwLJDX');
clB64FileContent := concat(clB64FileContent, 'ufGEP+53FVEVw0EN3pYjgmTyT1i2rroFe6iboHCXEhPTpvEEJwoaS6WLuJNGIDpPg38N2zE7nis3');
clB64FileContent := concat(clB64FileContent, 'ztlYj0DLyYqRo8ORxKGRreirMOK4Adj48hOTnaEDVtsrd/cZg/jz+k4aoqanRumWep++b9FoORFq');
clB64FileContent := concat(clB64FileContent, 'lytMVI4yoqdQve1KyHLPf21wtlgu/tmo9T+aCwjttohad2aEkRyWMMiVczorZZfLrRM/uugRVnrX');
clB64FileContent := concat(clB64FileContent, '1evnh7cn2PjyhnvvNtuis/UEoiVt7NDlAC7Go1YjnqWydZqkYUW1sgPhubilIqniaX64MAvRIwBJ');
clB64FileContent := concat(clB64FileContent, 'W86uxo6/4XfQS63hrrE3lWCtQAng2YVT0EIg2BX/jSzpvfl3t+4L2wJxji5J5eolWCyqj/FScNn8');
clB64FileContent := concat(clB64FileContent, 'aqxzTfu9gnzhAVTQ7cHvmOAidcVHBl2J3lNmgrPgdKcQxb6c4WuDgTf8fv8eMrF/pqU9W/kUESxw');
clB64FileContent := concat(clB64FileContent, '5bC1EK+jsPjP8Lumhic7ZBezYMsflM7KhQg6A9nne7Z8SfDebINdidSqD7shJjMDX6FlvtEahUzm');
clB64FileContent := concat(clB64FileContent, 'GjH3T/EsYR1xtB7wb9qtnJL20RoWbGC2fnnNNS/MEKH+BP5moW0m/xQXbhYf5rQdSbKIwffSh43f');
clB64FileContent := concat(clB64FileContent, 'Vo6GVKdT+FAJCJ1YU4eDdpD20gdXclK84OdK0pzgxayH7xfR/6KMTd1sa4Yv/P6b+R1Az/TjoMrz');
clB64FileContent := concat(clB64FileContent, 'O5iYznsmLR9heg+RSejy+W0sSocfMcm0xpsZnXwhMQg0uInQmZ7m0iygsbd9cyNUBfQdtlrXREop');
clB64FileContent := concat(clB64FileContent, 'NyAlZMPXJdkLj7WAb4orRnGWxoNw3JrAHD1jZr4c525Kq1FTz0VxC8msXUB4o8+HFXYuibpQpu97');
clB64FileContent := concat(clB64FileContent, 'oXNDFmCIMTXPL7HTkLM+QOOljonoJG7zxQHP1M0y6fr0MMX9RM/e/TWTMXCUgqLE5lIFPx2pbpLY');
clB64FileContent := concat(clB64FileContent, 'w7hSY5gjymu/K9ehthQJFKYgHc+d8LHqon3Vs6O/pNsjmNCxczt6Nm1QJ5nCEE+02XhPf8H7aTcx');
clB64FileContent := concat(clB64FileContent, 'gu+BF3tD+gz7Amy+GINghP12gC7N/eI5HzZfGgTtNh4eOjOVzaji5LDk/emPlL5yfVLNFgsoLGX0');
clB64FileContent := concat(clB64FileContent, 'uUaZ8FV/lvc0EmSE/FfLuovzm8A38WI/OgpAkjP7wlyLnZ/6yDx/fHHi4NCIuTwTcZpAgCcZIQLo');
clB64FileContent := concat(clB64FileContent, 'V4OfHdvvDk2oEAF6PgCD/psRiuMWA2WWyEcgcUexwnVC/dalzUlAKJegIDl+oLAtFYiIi6T1Uqvj');
clB64FileContent := concat(clB64FileContent, 'sbNa/vmPES/SrrPswuQcjdTpcL0t6BehaC73N07ie3P8mr56SFZtxscJhw8H6+I+2uGIxpvv5REB');
clB64FileContent := concat(clB64FileContent, '2zXMKc4JJsXRP2l1UOr9QSFXQbdlz3mZZcMOOvseAj3Jdyj4uqiVDlWho3SVBe2SSHXvVMedCEPW');
clB64FileContent := concat(clB64FileContent, 'QWdXCmtDt5uFb4EodfsDl8xWOy5T3M5l6pXsZUEBBr9Ql/4R2nqjtHWG5Usq8vdJ/w9AIefs1Mlu');
clB64FileContent := concat(clB64FileContent, 'Kq8grIOl7eK13yoP9D2a7CKZhDsEt42+i+nwH/cZbeQ29YbuoXxP7tmrPIkvc/Cgw4SgCVgvlhuF');
clB64FileContent := concat(clB64FileContent, 'U6dw9jhe69quJv7t8UhnfpSoyCg/NyR5XAR6PsszFpJbzq19xiZWFuHjHkZIF0TPToZPTEzsZyyI');
clB64FileContent := concat(clB64FileContent, 'iOk+maSn5TGk5r40yuxdXXgdsiU+PlgnWH0oDkFceJubUBq/PiKgMfmq4wx7Suv85aWaxcKf4lyx');
clB64FileContent := concat(clB64FileContent, '/0MePwYLFrPFKr8+5okZKbsiswTtjNfOGgA0LQxEvnh9bdQ5zrFhZzCJ3621Wt/295UPAPyIZivP');
clB64FileContent := concat(clB64FileContent, 'WbW2oM0OVl+EI62A0gauM+aXmObB2avr4jP0xRKRp1DnO9SGJhkLoQoFfo4TFf0plPd7yjNu7pxF');
clB64FileContent := concat(clB64FileContent, 'V4N+c7Z2N8m40H9WriyacR5xFWR6Ey7uadcthykvfJ59qMtxKFYWVdXIONuFXVNoie9pRMHDAsIp');
clB64FileContent := concat(clB64FileContent, 't05ILijJC62sj5mIG7mG/bgChBvLTZUfz4O+6JnCA8NRDOJb7E+ORWzkCuQ46WDwzYkXTKqbqD2H');
clB64FileContent := concat(clB64FileContent, 'r60eemF1L1KQMgw/mYWwELLrmSZwUwKT9mCqH79nhvPoKK3w8G3N/gww5fXaUzySt/4FO+5Jy8xc');
clB64FileContent := concat(clB64FileContent, 'XV0ku+c7pD+icUox1+6MMNh5z9iN773qwviXc+eGUsMnIQxlHL+zJxbxI97GHVKtTi00ocT7HF2T');
clB64FileContent := concat(clB64FileContent, '/rhE1LcJpXyDZ2PexZfD+tn1HxGWQX0vJGtySl3Fqs6S5fAqT8QwjGuve3xnwg0xLEPa+IDJD5Si');
clB64FileContent := concat(clB64FileContent, 'onAttJsFPIvbuI/vtqaOFuWIspnr+o+lrZcpNCGqwfPYX65KJjEn+HEchyLAbXsnOmhCq7f1h8hX');
clB64FileContent := concat(clB64FileContent, 'bIS6aWw7Jc1yVKveFnVrh1NtqUF+0f0s1eAPwoHeOnczsUiaYEiRPNg6QGc/jTvbsyknKEfmPu3m');
clB64FileContent := concat(clB64FileContent, '65SesrSd77TBPD01fas/7c0tjn/K6I0jnF2Oy+33mhaa9ou8CI5fgR6MAiiFgJSrdYxVZmWXLSuS');
clB64FileContent := concat(clB64FileContent, 'tIiqGJJKpQ0ZO3XATARPnEFl+xExCYlL9Ug8qyrTbKgaE+mVdsdvPIODfW12bvdJHBVR2BxR8/Jc');
clB64FileContent := concat(clB64FileContent, 'uxByBftW0y67Xkhd2t1mX3YXGCfMF4IRDs/khB7Ty+Ho0Ci9kUtym0JKOmGYEMMsAtmiuJLHnqPA');
clB64FileContent := concat(clB64FileContent, '39TWOXoRwoiTwJ9FPUpW4Sep7hDfy35CmiXpiSsCRaR89G3War+RfDl1EUbsQBYQRPE+3vgSYF+o');
clB64FileContent := concat(clB64FileContent, 'E6wNvcwJN8wWjkYSbeUNSMGrH10kuzIukZL6WMbP++Gk1FK00OQz8uB4Pp3O64hFlycupKHMIpHL');
clB64FileContent := concat(clB64FileContent, 'l3JX8v0K/21t2OY4BeLXQUIFAk4lQxdT+IuqFeiQAWprVnT6qabjyYPpWnvvtCUuffDxXH0XMcb+');
clB64FileContent := concat(clB64FileContent, 'YRO6xcKgd48FoTSGdISQsinNiChMc45uM04SjZcRr3Vepfpw83xFKrm0sdwtvQjVtRnv8zK2xiNQ');
clB64FileContent := concat(clB64FileContent, '7NYhobRZs/nSD2fHjBcZnE8sDHFDgwhMssI4KbfjLIhfExOIvEk0xE7T8BrkmXzVlIMgNEk9e4bu');
clB64FileContent := concat(clB64FileContent, '8yWiea+ejxEkzx8A0FJXV5hisXS80hdzXdbRpmLyx+HKc9jTEgKWAQQGAAEJwOhsAAcLAQACIwMB');
clB64FileContent := concat(clB64FileContent, 'AQVdAAAIAAQDAwEDAQAMxgB+xgB+AAgKATLRD7AAAAUBER0AbABkAHIAcgBlAHIAZQBjAGEALgBk');
clB64FileContent := concat(clB64FileContent, 'AGwAbAAAABQKAQBLolAD0bbaARUGAQCAAAAAAAA=');
    

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
 nuIndexInternal := ldrrereca_.tb2_0.first;
 while nuIndexInternal IS NOT null loop
  IF (ldrrereca_.tb2_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (ldrrereca_.tb2_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := ldrrereca_.tb2_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := ldrrereca_.tb2_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not ldrrereca_.blProcessStatus) then
 return;
end if;
nuIndex :=  ldrrereca_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (ldrrereca_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(ldrrereca_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (ldrrereca_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := ldrrereca_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  ldrrereca_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(ldrrereca_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,ldrrereca_.tbUserException(nuIndex).user_id, ldrrereca_.tbUserException(nuIndex).status , ldrrereca_.tbUserException(nuIndex).usr_exc_type_id, ldrrereca_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := ldrrereca_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  ldrrereca_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(ldrrereca_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = ldrrereca_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,ldrrereca_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := ldrrereca_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
ldrrereca_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('ldrrereca_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:ldrrereca_******************************'); end;
/

