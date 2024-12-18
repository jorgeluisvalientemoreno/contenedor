BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCAPLAC_',
'CREATE OR REPLACE PACKAGE LDCAPLAC_ IS ' || chr(10) ||
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
'    gi_assembly.assembly = ''LDCAPLAC'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''LDCAPLAC'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''LDCAPLAC'' ' || chr(10) ||
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
'END LDCAPLAC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCAPLAC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;
Open LDCAPLAC_.cuRoleExecutables;
loop
 fetch LDCAPLAC_.cuRoleExecutables INTO LDCAPLAC_.rcRoleExecutables;
 exit when  LDCAPLAC_.cuRoleExecutables%notfound;
 LDCAPLAC_.tbRoleExecutables(nuIndex) := LDCAPLAC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCAPLAC_.cuRoleExecutables;
nuIndex := 0;
Open LDCAPLAC_.cuUserExceptions ;
loop
 fetch LDCAPLAC_.cuUserExceptions INTO  LDCAPLAC_.rcUserExceptions;
 exit when LDCAPLAC_.cuUserExceptions%notfound;
 LDCAPLAC_.tbUserException(nuIndex):=LDCAPLAC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCAPLAC_.cuUserExceptions;
nuIndex := 0;
Open LDCAPLAC_.cuExecEntities ;
loop
 fetch LDCAPLAC_.cuExecEntities INTO  LDCAPLAC_.rcExecEntities;
 exit when LDCAPLAC_.cuExecEntities%notfound;
 LDCAPLAC_.tbExecEntities(nuIndex):=LDCAPLAC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCAPLAC_.cuExecEntities;

exception when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCAPLAC_.blProcessStatus) then
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
    gi_assembly.assembly = 'LDCAPLAC'
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
    gi_assembly.assembly = 'LDCAPLAC'
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
    gi_assembly.assembly = 'LDCAPLAC'
);

exception when others then
LDCAPLAC_.blProcessStatus := false;
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
FROM GI_COMPONENT WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCAPLAC'));
nuIndex binary_integer;
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
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
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCAPLAC')));

exception when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCAPLAC'))) AND ROLE_ID=1;

exception when others then
LDCAPLAC_.blProcessStatus := false;
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
FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCAPLAC'));
nuIndex binary_integer;
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
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
LDCAPLAC_.blProcessStatus := false;
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
FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCAPLAC');
nuIndex binary_integer;
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
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
LDCAPLAC_.blProcessStatus := false;
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
FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCAPLAC';
nuIndex binary_integer;
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
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
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;

LDCAPLAC_.old_tb0_0(0):='Version=1.0.0.1,Culture=neutral,PublicKeyToken=null'
;
LDCAPLAC_.tb0_0(0):='Version=1.0.0.1,Culture=neutral,PublicKeyToken=null'
;
LDCAPLAC_.old_tb0_1(0):='LDCAPLAC'
;
LDCAPLAC_.tb0_1(0):='LDCAPLAC'
;
LDCAPLAC_.old_tb0_2(0):=3961;
LDCAPLAC_.tb0_2(0):=GI_BOASSEMBLY.FNUGETASSEMBLYID(LDCAPLAC_.old_tb0_1(0), LDCAPLAC_.old_tb0_0(0));
LDCAPLAC_.tb0_2(0):=LDCAPLAC_.tb0_2(0);
ut_trace.trace('Actualizar o insertar tabla: GI_ASSEMBLY fila (0)',1);
UPDATE GI_ASSEMBLY SET ASSEMBLY_INFO=LDCAPLAC_.tb0_0(0),
ASSEMBLY=LDCAPLAC_.tb0_1(0),
ASSEMBLY_ID=LDCAPLAC_.tb0_2(0)
 WHERE ASSEMBLY_ID = LDCAPLAC_.tb0_2(0);
if not (sql%found) then
INSERT INTO GI_ASSEMBLY(ASSEMBLY_INFO,ASSEMBLY,ASSEMBLY_ID) 
VALUES (LDCAPLAC_.tb0_0(0),
LDCAPLAC_.tb0_1(0),
LDCAPLAC_.tb0_2(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;

LDCAPLAC_.tb1_0(0):=LDCAPLAC_.tb0_2(0);
LDCAPLAC_.old_tb1_1(0):='callLDC_APLAC'
;
LDCAPLAC_.tb1_1(0):='callLDC_APLAC'
;
LDCAPLAC_.old_tb1_2(0):='LDCAPLAC'
;
LDCAPLAC_.tb1_2(0):='LDCAPLAC'
;
LDCAPLAC_.old_tb1_3(0):=11827;
LDCAPLAC_.tb1_3(0):=GI_BOASSEMBLY.FNUGETCLASSID(LDCAPLAC_.tb1_0(0), LDCAPLAC_.old_tb1_1(0), LDCAPLAC_.old_tb1_2(0));
LDCAPLAC_.tb1_3(0):=LDCAPLAC_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: GI_CLASS fila (0)',1);
UPDATE GI_CLASS SET ASSEMBLY_ID=LDCAPLAC_.tb1_0(0),
TYPE_NAME=LDCAPLAC_.tb1_1(0),
NAMESPACE=LDCAPLAC_.tb1_2(0),
CLASS_ID=LDCAPLAC_.tb1_3(0)
 WHERE CLASS_ID = LDCAPLAC_.tb1_3(0);
if not (sql%found) then
INSERT INTO GI_CLASS(ASSEMBLY_ID,TYPE_NAME,NAMESPACE,CLASS_ID) 
VALUES (LDCAPLAC_.tb1_0(0),
LDCAPLAC_.tb1_1(0),
LDCAPLAC_.tb1_2(0),
LDCAPLAC_.tb1_3(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;

LDCAPLAC_.old_tb2_0(0):='LDCAPLAC'
;
LDCAPLAC_.tb2_0(0):=UPPER(LDCAPLAC_.old_tb2_0(0));
LDCAPLAC_.old_tb2_1(0):=500000000015223;
LDCAPLAC_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCAPLAC_.tb2_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCAPLAC_.tb2_1(0):=LDCAPLAC_.tb2_1(0);
LDCAPLAC_.tb2_2(0):=LDCAPLAC_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=LDCAPLAC_.tb2_0(0),
EXECUTABLE_ID=LDCAPLAC_.tb2_1(0),
CLASS_ID=LDCAPLAC_.tb2_2(0),
DESCRIPTION='Automatizacion de proceso de legalizacion de areas comunes'
,
PATH=null,
VERSION='2'
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
TIMES_EXECUTED=1610,
EXEC_OWNER=null,
LAST_DATE_EXECUTED=to_date('01-02-2023 10:24:45','DD-MM-YYYY HH24:MI:SS')
 WHERE EXECUTABLE_ID = LDCAPLAC_.tb2_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,CLASS_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED) 
VALUES (LDCAPLAC_.tb2_0(0),
LDCAPLAC_.tb2_1(0),
LDCAPLAC_.tb2_2(0),
'Automatizacion de proceso de legalizacion de areas comunes'
,
null,
'2'
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
1610,
null,
to_date('01-02-2023 10:24:45','DD-MM-YYYY HH24:MI:SS'));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;

LDCAPLAC_.old_tb3_0(0):=40009770;
LDCAPLAC_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
LDCAPLAC_.tb3_0(0):=LDCAPLAC_.tb3_0(0);
LDCAPLAC_.tb3_1(0):=LDCAPLAC_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (LDCAPLAC_.tb3_0(0),
LDCAPLAC_.tb3_1(0),
'LDCAPLAC'
,
'Automatizacion de proceso de legalizacion de areas comunes'
,
1,
1,
33,
-1,
'FormExecutable'
,
null);

exception when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;

LDCAPLAC_.tb4_0(0):=1;
LDCAPLAC_.tb4_1(0):=LDCAPLAC_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCAPLAC_.tb4_0(0),
LDCAPLAC_.tb4_1(0));

exception when others then
LDCAPLAC_.blProcessStatus := false;
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

    sbDistFileId        := 'LDCAPLAC';
    sbDescription       := 'LDCAPLAC.dll';
    sbFileVersion       := '1.0.0.1';
    sbFileName          := 'LDCAPLAC.zip';
    sbMD5               := '3974fdf5b78ee361513f013f8b2dbcdb';
    nuDistriGroupId     := 4;

clB64FileContent := concat(clB64FileContent, 'N3q8ryccAAMUioUg23EAAAAAAABmAAAAAAAAAAhHDXcAJpaOcAAX9+wFu+r0/5QBL0TuTr0I2yvx');
clB64FileContent := concat(clB64FileContent, 'U9Plq7xO/c6hY0BIQykUfFcxmm1nJkkaGBLomg0YBj0sy/fHRpK4HzK+n2a7pvMs7BoPjYRR4KMd');
clB64FileContent := concat(clB64FileContent, 'xlRcAmPnIxsuvS+GAbV/Oqu6IS3oAErUpeQXs3eW8NG+TgppizYc5NDotYfnwN56F7XcP9jNTG4Y');
clB64FileContent := concat(clB64FileContent, 'TLu9X4O006IVljOpbNAUdGFZsOfwbtiGOaryg+aTMLWhoBbZDjIh/f9YDhKX9EJ2Q9/Fizi8m/fb');
clB64FileContent := concat(clB64FileContent, 'oGpz6mGOcQzBTQ3/fKm6rLMomZqxVbbF7D4jR5Soxt1u6O7fRNg+UWmNC20p5ForCSW7ecqsDhBK');
clB64FileContent := concat(clB64FileContent, '9DUKsroROr9sgQAI51bSme7mWuRfDLqkGMxHheixdtq55lPudBMzFdEozPQcmFlOLCdeAAsRIbwk');
clB64FileContent := concat(clB64FileContent, 'v3hEwjF43Ta7Iz6guoEsxKuPr0aRofwnd3O1WCx9YuVUIJLBbpQlOoqCGUT8d1MbzH7hv888rCIj');
clB64FileContent := concat(clB64FileContent, 'I7+oltsR/cSwQuuwg6JQc3tj3z/oj4MgTAuVfJ7X7O0V9E+g1p0GSZG5YUExj7hCpmEGH58RdlNB');
clB64FileContent := concat(clB64FileContent, '4KDMOjqWZcto7nzIu710x/VDCq8ntxpQUdLC8mFq6u+WGh+PBKv18VJJPVUs9XLKUJwOqnHOEAnM');
clB64FileContent := concat(clB64FileContent, 'i5/+WnKggIXsONMDZ/Sucs4L0LMo/C6e9+4GHY2qOepR2pN4Jp+NoJ6TZ6eNsEFnoyZ0lZJPLS/v');
clB64FileContent := concat(clB64FileContent, '3+oLi4VM4Tv6Erk9AwsP4PIM9BgkCdWxrMnanuyP6Dswgt2UxaJyFuuhpSCzijCrITD802o73/qH');
clB64FileContent := concat(clB64FileContent, 'mkmf6FbMHUs/oxuLTHCdKV7f2o0Sfg0sHmiAxqbq3ztdLmkfzaLZmuxZenGP1Gjo9ZsMw0N2f2Pk');
clB64FileContent := concat(clB64FileContent, '3y0ScD2D9AdFVvNKi1T/60l8kaQv0hDvJa1IBJreurue1aXFXl29U+MWU18E75bhZlf3XVDf7wax');
clB64FileContent := concat(clB64FileContent, 'cM5b6Kx95iS0W688/sniguXSOJZ4foytTofAjE5vPnONiWbOq1RkT8ZLgTJ8CVsKIALxEATS5AY7');
clB64FileContent := concat(clB64FileContent, '0BQqVP1Jinmfz8i486ZBW9bZ4owUQ445QB/puYXLjznpSEMpGeAnd7+ntrV4QnvRIN9pSMDskTaZ');
clB64FileContent := concat(clB64FileContent, 'cQnvrkRC3OlHNETVRnFF9wHLmqH7YbWvxWyCmJv88jb7WjQ6yGEXti1ngjXp6oFulo5ZFCCMphnb');
clB64FileContent := concat(clB64FileContent, 'fISpfJl2eVcWT1e4s8TQYh4jJFISyVFjmFxwB1GK3WH46WLABzrOyfWbBmM9W3GMVqb7lfj/yGzH');
clB64FileContent := concat(clB64FileContent, 'GfO8hdKAsXHwkQ4AZ8P+mOQ+JL0CXryz6T8wRRlQw3C9ZSsJ4sxONtCBsI4EBiNQGE/fgZ3Ydnx9');
clB64FileContent := concat(clB64FileContent, 'nrcBg8+n1+ymWuqBpqsprApn9+DQBHB+XyrOxFcu2FfH78/6Shd1X8lEGxX+qucUBDkvVgPbLLb2');
clB64FileContent := concat(clB64FileContent, 'o8xvPzq802Mm3uXKehQ5PX1SmTVGpPXa4BdVKJ2zagZOFKuojU5sxLuiTnPR/aXmI2fRQD1Fbg3A');
clB64FileContent := concat(clB64FileContent, '8rBrt0HW4g2nn6xSC+lNz4IZkTk//fpfuMyI237U2QwQaV/HJMywoqes5aL9qBDNUhWnT5k01NzV');
clB64FileContent := concat(clB64FileContent, 'sg9JGqfdOh+06QVc4J2IPCAS7vb6I0jt3EnGta5Di4m3t1gsQeNAdTqYa97Cgm8YmQRasBngYJCT');
clB64FileContent := concat(clB64FileContent, 'q46Xnd4yV33avwKeMcLVdMvU8G4a8SaNlI1i5bNWRHXrC07ZlDyJTKty+4LheyubY63tUkzEI+Id');
clB64FileContent := concat(clB64FileContent, 'W5Oe+jOrsoYNMUF8pGJuYShmUvBaDet/PHrGSWvgHmHhNsVrt0RXYlb8k9OWj7ZzQ8Bu22URpdGm');
clB64FileContent := concat(clB64FileContent, '5nAoaseZ6z/7HTww/JuH9G3YBbwmJL9hWto2DKqpgRAXqe65grAxWYJK/ruumtjwd27O2aKxrYt5');
clB64FileContent := concat(clB64FileContent, 'UCqJqbqg7ia3Vyhdno8WJ2iRP3EPIOOT9E3IybUbtyFFUR8tyUixdKfaZ1rN2am3AJkZoF+isTAE');
clB64FileContent := concat(clB64FileContent, '5g148AtOJhPzCjYsDNVDvQmGdQots9GIUL1oMEiwZsjvas6+FgkbJ8yFgcIRL62SCebQLvav35qy');
clB64FileContent := concat(clB64FileContent, '7pJn+FouRZqtoPfs28A2xQ+nHttzMO/Tg6de7ozQz28AFbbxwZi/00TaASOYai657iiuBF/vRMAz');
clB64FileContent := concat(clB64FileContent, 'B0oSdsSXBikEVvoqwqAlNdYK/jyusREdgfshENI3+GWms7tBmc6eEemylPRiy7sHsCgGfhaI5h25');
clB64FileContent := concat(clB64FileContent, 'Db5PhcPFCfJNcVNs8SCKVP1hPGryTpUqe6D36weO13v2rH/61BMAS6Fv1CX2zKpey30KA7srv44B');
clB64FileContent := concat(clB64FileContent, 'Ca1KiXHi5Vp2DnhUVuVojrB57qpaV2BoUqwuPJs4OToLtTS+NT2bDTKCS0SIkMYGoZj+5SzAY2DH');
clB64FileContent := concat(clB64FileContent, 'NwtZmLYONjpTrRCJRgsDlcm5Linte3wTrgelWELByo94dhnR+vqNKQym0Em/CpeGh4+nDXCC0bwM');
clB64FileContent := concat(clB64FileContent, 'lDwkBQIhmtHSKtRVpCZ2iBQ9qZNVJFEK5KnZfvqEl0SELDzV2x8oJWJbLboECdhy1mUAekx+87ef');
clB64FileContent := concat(clB64FileContent, 'N4ukfzF8xYLmPBHHXBbuY+wdHpSN5W6IDusH2jfgzAdqzm7BEjj1gq0IiisZoGWZnXJzvoyYe4Rm');
clB64FileContent := concat(clB64FileContent, 'NrQjlbheP/ao9QlHvr5qvhGyMr74y5sbrTOBF8Vweb0S++CZ2veFtwNZu3xSNbTxViqHE6sfvWg3');
clB64FileContent := concat(clB64FileContent, 'wconPaFjkCcWQEqZXG5kw+IMgVqy7e4RSWLNl3aVfAglpvKfokW1v115kJB5hGvBl/FrdXe0lP0S');
clB64FileContent := concat(clB64FileContent, 'nNtVI3irO1xxaBRMEAzs//G1YXsRNqI3Vqce6ctTVyO9GImDzhn3f/0ZKdiqoat4udZ1EFhE0rHE');
clB64FileContent := concat(clB64FileContent, 'Qvf9K/Osk2LPmYXYTI2mZ7KTBCVgn2eDMTyMiWG74uboa7uCwHywbMpZQgO0J64rHs4fnJocxPBN');
clB64FileContent := concat(clB64FileContent, '1xogagUQfUD1caCt800urJmaGF9NXBxFmV+bIzaNfVmD6CWqZixBWPb1ZrvgnCQTZEJuBB9FfQj/');
clB64FileContent := concat(clB64FileContent, 'HdCSAFmuU5R2AMfqW04nrpJzryl1KvlZG/gO6Vz3wqodgZVwBlRscolFNc7xmPXVFq2rokp0p7xo');
clB64FileContent := concat(clB64FileContent, 'G2S4JQE19xah5ETZ8RWjoSrHOtRRQ7mde9W4vrywOFbLqKXIEEqRZ1krziYHuUP/jnxR5UJK+2Eg');
clB64FileContent := concat(clB64FileContent, 'c0ik2p/D6cwuUh9jwYO9hOJvFyGybTKL54aooEGp07lc5Wps7Y17lFfIyrDWKrU1RUS0WRb/20Uw');
clB64FileContent := concat(clB64FileContent, '9uB3x1iTfiAJZRHfb2oFj1t+bV3wLZQyQ5sVzm56rGJF1uVkqryQd40SQFpjitNlamkXde/ks7AA');
clB64FileContent := concat(clB64FileContent, '7BDKKge+4i4j3LHRZxKjT+p4s7SyZIRfsHkTRopZ5XmBo/i3byOK4KImsQh2b2R7aGu5AkQib+Hg');
clB64FileContent := concat(clB64FileContent, 'BBWXtYJryreOeq9KTD2dc39Hk73w2wN1oPPzQF0x3WahaTtgHAm4Fp/3RwKRHgD8VRXPGX72PoEt');
clB64FileContent := concat(clB64FileContent, 'HUbG/TQ7lOJb/P4pQn9F3Nk1jwi9QjeHC4HHK5P+OFJIJYGlvOuyqishqGmThUE55x/9GX5itVrg');
clB64FileContent := concat(clB64FileContent, 'FVy8F4ASNmm2lKgK2isRiSsVMJc3RmstayYnUITHHHV8JVRJ0/ILrh6KC+HDU0aDVMz7/LBi5tot');
clB64FileContent := concat(clB64FileContent, 'IcvSvtN7XaEiJW/yUsKff3rPzlLlK4ms8HbrB5doemqAqoeCOrgDXoj4aj3561CRX4naNh5Ehzt2');
clB64FileContent := concat(clB64FileContent, 'oXW+jKsLLrVbXNecok4PWiltph6Mhaw8fAfIkshHEHXOEKOU8HVmB+FXpbKLS/GTwAnen0XXxD4y');
clB64FileContent := concat(clB64FileContent, 'rLqy17zkmkH6TnOx33taXvDl7dcdh4ryRs1O4jeEW2psSrzypSMruRul+WdvjGZaaVm+MR0Evjol');
clB64FileContent := concat(clB64FileContent, 'EA938KasOiWX0cZjrnM8CgW9rXn4DQ5KSJh8TrifbxHW8eoRZhsjATGdELO4isw+nruDNvil+P7y');
clB64FileContent := concat(clB64FileContent, 'L0tI+sAH46arcW200NdiVyjLTysvCnqWPBPU9EkL1AH2w29e8NpebC1/+sOWFTIX14YeIYjRUE/A');
clB64FileContent := concat(clB64FileContent, 'AiaF/hbmy7jvm011FIAY0YLrl7d1PFueT1FaiM+F5ueJ2fULYZf20gZ1uUbZWtg7BtmxD80ZqTwJ');
clB64FileContent := concat(clB64FileContent, 'A6jZBhTes0n8dbqlhMJ9knhUZmq8b5PrSyS+DH9QElU/cZ2dz8aLiswOnX+t/QvbvxiRMUyihpPE');
clB64FileContent := concat(clB64FileContent, 'Q/qoHTSRPYuH4rDGjt+/tPZakf98C4zCkm+iIJ65Yn+h11k4ID1xuf2Trry3S0PK87uaGcKccVxn');
clB64FileContent := concat(clB64FileContent, 'Kmyi+jglOZkwFqrGtonNux07zc28OdCk71hlVQc+h6dQs5xp0jsCyM7+pjQUT+vlOpiEQAao/l3n');
clB64FileContent := concat(clB64FileContent, '1REggxpQwQrMm6itv+ZzBWGYIDxdv5m3r896ppz/sHGdBcUvh0tcNCRWG5TTJQwafyQDzTPpr/Wu');
clB64FileContent := concat(clB64FileContent, 'Trg3PGKiUHWWZQQXDD6bsUPzko/rRoq4lWpWQz4gk8VGrQZ4/vdaJ8xC0IPUGZkOtkPH4R47CszT');
clB64FileContent := concat(clB64FileContent, 'Sr+2INlaZJU3i4vaSp4YHg7k3cvfVyFN3HfoVmP/i72rxi9+yoh0I/xaklqXzoBuy8zLumjUEe8l');
clB64FileContent := concat(clB64FileContent, 'xFoqoj91pib3enyVxpX3lL2Nc1QIdKzxSXKwqGtPMt4+ybubnqbZ6KtuZ2l558x8ayo+XQbZT3CA');
clB64FileContent := concat(clB64FileContent, 'fh0IGtQPJRkkNV5otLZhkxEHIapbjlUrJKJq3ohYEthbqKZJ29k6KEecI6Yx9+ArVAAkQJa8HCYW');
clB64FileContent := concat(clB64FileContent, 'INrZnBnZTkkhh7c3QKf9tQlBVLUDi3xzjgCU+vvo0Z5YHh07bt2DYp7B63Ab7rtWKCAsmqljFDy3');
clB64FileContent := concat(clB64FileContent, 'iJEzjx62iVdPK87nOdMGbbkoqcCfNJ6U2XRVt/rPlLXr9sijBnUNz3AcJrvnv7op4fMwkIu3kc/o');
clB64FileContent := concat(clB64FileContent, 'nf+qcs3DXKJgKGTSthmUvRqao2ur7iEauYzRg/3vUpDBhZB85FcZ/Ybxs605MRrA3XkcLSzb4jkZ');
clB64FileContent := concat(clB64FileContent, 'Rn3EmsBV+amFHehYd7n6XDgD8i6NuEsLUtQww4dWyNYP2Y8jAX/00IpzTt0EwGsWIWtNX9hbAN97');
clB64FileContent := concat(clB64FileContent, 'TI/sTX+qksU8jJdgNrgvWmCZTksi8q23dMAFP/CGNcNEIHgSceHiRSeXkaIL4Wo8zUP5+dQD9aI6');
clB64FileContent := concat(clB64FileContent, 'qjftLDCUb88dMCeQ6p/L+gGPhyaqKEat/lgcy0K+lGeJRv8jcFN8Y3qSUhDCXiMupGvVFekUqF0R');
clB64FileContent := concat(clB64FileContent, 'bXd8subRgGprc52MTDm7xYlvbySSeMSzwl1joRXWkzmkAgZJ5mDmyiW8kHtVzlVJjYm+g1wa79a4');
clB64FileContent := concat(clB64FileContent, '8TFJOh1M7SiqSpOMIdXGvZd2Nd8tyZJ/Qs7om0NG7enFfB1aQeP601Ox23TkfRA+rxcKM/kN3E8d');
clB64FileContent := concat(clB64FileContent, 'IsZaPFtTOIqlBaxigBKbX1sDfIe660BvFYDcAEsMQkqunAg7k0XNKqGkHtUbaongGOkzMJRDNbeK');
clB64FileContent := concat(clB64FileContent, '54A06echXuQKRamUWmmPHO15P9q3Am2/d+PzcpLvwEyqoDdptVoXi8fYWTlNl7w2/vr0Zmm6yDfn');
clB64FileContent := concat(clB64FileContent, '+kH38qACW7kQ62kbgnnXc8YoSKx36N9OIMIBiYsPohvpJpB9+pkxUQRcJ5URhhtfbQixoWaUsS7c');
clB64FileContent := concat(clB64FileContent, 'K7YUlMsbUKViUT8Q/d+N5eyB7of2scWM4vGzduulJ6FHvvdUlvWcOYwmmTVwYDBOdBtRDlY+9uCr');
clB64FileContent := concat(clB64FileContent, 'qXynxOqFdTr3pjaoSno95ulfCDr+99Yso2welamdfJTWbomeT6wic1h7BTv7g88DDAcvJ4li9FhG');
clB64FileContent := concat(clB64FileContent, '+3qXk6zMAaopyyQNA9e+2XNB3kqBax9KxRaHFsMVhnJBlql3Ki3DSnrdtyErudxBSvsfH/8u/tAy');
clB64FileContent := concat(clB64FileContent, '0QhTzSL2HCB++9duZLsX9R2vZFRpFbedyDwTyVOCQe+NVwpk/+xckzbJU8/wO5DHnWiAYGCqMphB');
clB64FileContent := concat(clB64FileContent, 'W3xMo8PzdH+SAc/F+18wTK/ZbwvsIJwZ2DKttm9LNxo1Glk+ZsJFL1iWWTizYNKon9TFZ8MXLs/A');
clB64FileContent := concat(clB64FileContent, 'n6kVss2pZjH9oFYabUVS0qeknEidVPddCIcTCX3PZB4FP9c4dKoRY6SM5cjGx4NJNPrpBswql4l/');
clB64FileContent := concat(clB64FileContent, '5c+0CxjlWtN4qXsgpvjGBOdQ31alD5J9AdXS5aU6Nlzpjy9nUfkHR0YsCi/7Jc8cQ2jXzV8nWAZ8');
clB64FileContent := concat(clB64FileContent, 'NQ+VujeWPFuHp/Sb+LqMslUXtAA2Q1bU88UJj4ugjp4sF0ks8GIwyqeZrE1lIxoPVTW6kJspl2s6');
clB64FileContent := concat(clB64FileContent, '2xzo0NosuS/B5N8ho64meDl/Z88NgI1C1hB7msPvKwrH/U83BZiBB9rVqCPLX2EiZnQ3pHlmYKxF');
clB64FileContent := concat(clB64FileContent, '1J/Rkmc2hbbkpLvUBmKyEiAdEHKtyknmIgqfYZ6O60vqs+J+x15gZeZYHRqucMWNdugJD0PVXVcS');
clB64FileContent := concat(clB64FileContent, 'dphwfelEjayJEUlv4ZC488XYYpYfIadw3o4HlpqsQjOjwJUWioVTrGK9Stoy7SQiJZej+5B+Jl2a');
clB64FileContent := concat(clB64FileContent, 'LTeNn25+VugYPSfBtnxcvdcwcUqX3T0HSP9kKoVROtCTSO7ZA51J8A5kd+ZcXoLnrDq70cslt93l');
clB64FileContent := concat(clB64FileContent, 'zW1z/jyNSrnLNpRldGWlBztZONwAr77yDdCSXtXu1YJ1KOim3VXSIP50NtU77VeHzPL81LI5ZA8L');
clB64FileContent := concat(clB64FileContent, '1gbsAmwQctjsAsPxo3Jr7Efxo8mODg2JrL//ecz0v6SqPm0cVfq7hEpxNOUxBfoIT10WeG0bvWTI');
clB64FileContent := concat(clB64FileContent, 'i4EbYBgY8mINRlbPmKy6jI85eRcal0QVGeBDN2AdBtsc2jy51UOKC1T8lt/M48y/wD3QLt1ygmok');
clB64FileContent := concat(clB64FileContent, 'iGmoz+zmDTN95TLTgZbabvN1VcfOYBLdLF90REuja5nSUyhGQOPXDchvfgAqSEhbTLKrmV9lY8C2');
clB64FileContent := concat(clB64FileContent, 'V4niS87uTVbmeXTcKD/UcaGY67QZjpeT87FkYhE+gFqQKbLuxGYxa8xQO5RXWUlGSqAguVSiDozb');
clB64FileContent := concat(clB64FileContent, '7udiiBEovZ75xhT1UiOsw6IwGE/jiBN6oSZ67m/BgNOejKTZw2ZJe/wZitWILquyBFWmLDfM96jU');
clB64FileContent := concat(clB64FileContent, 'VYdxkaFmWNkcCPjfwYTCnlEAAyh9FaUcIg//a1MIGHgcfh3AZOoptHTdxv+75PojX3wv9+7H9H2h');
clB64FileContent := concat(clB64FileContent, 'c+fqQrOhPoMl/kpO8jMqrgVyEkQUwWmXN/5CfrfdnXdE1A3jyLaPVwdwiAHgRb3dDMmJseFhSvDB');
clB64FileContent := concat(clB64FileContent, 'g1HHDjiZfM63E6sUw9W52MM9iM/DRMXPwYKrcSvEaxRuKFzvQObaUyQrfYTTMtR6tc7kT4LGEnJv');
clB64FileContent := concat(clB64FileContent, 'EcZmUCmQr1WhUiqpckGBsMkBA3biNdBxHJg2ObyYJWdlu5OfoqeiDMof03qy32GUDwSnw1dBmzQN');
clB64FileContent := concat(clB64FileContent, 'Xr5U7GZu1e0qesgmpY3cBZmCx5qVFOj556yJb4M1aJfuo+2BX577Y2x6QJoV/D/Aj0ruRAKYN1Nd');
clB64FileContent := concat(clB64FileContent, 'T8qW1I10aKXtiGkLJ+oE5eqKodwtcXSxBV/mdIDMp8T+SANBvUy4WhqK2zPYEEOTueYwGDvQ9r1J');
clB64FileContent := concat(clB64FileContent, 'QE5ECJ8cFD6Ix9r5e6A3Yw+JpUoLrBStq4Ko/WkQdo3UCNY+liT3SzoDuAaxwv6BtOfYty73OArS');
clB64FileContent := concat(clB64FileContent, '/dL1F1sGPvJKIylt/jT8AlYEnAxkKAnqbB0pe9FZ5UpZgRqW97r8MF6DyjN/kxcNqYf7aXHKSMRU');
clB64FileContent := concat(clB64FileContent, '7NuHS4YAhipLuuMy3QtvIM135X5oSFyTwbb8u0vLr8wDVrrHwBI72Z5OmqfnNd6J6aTYvBBye6ej');
clB64FileContent := concat(clB64FileContent, 'miz+w/8zBpkHkQdwWBcl4KnkDeSUM5ys8L1pcS23rfX5obVQprEC9W9BJ+QS1fSOcTpgVkVBJPaO');
clB64FileContent := concat(clB64FileContent, 'ObY6UKMnwBYT2p8wYs0uxE97gwAMYMNnGQDWoPlyI38NR03n4spZF0f39uVyW/qqaJukYFuzjIjL');
clB64FileContent := concat(clB64FileContent, '5cgXVuqaBotEbAzvBZS7V8LiEICOK7+OW9hMVhD/a7drrCDUAJSKZqY2qjsM8CgcCk77XoqrcUkG');
clB64FileContent := concat(clB64FileContent, 'iL1iLJY6T7Te7nQ9pnTLl7RrIANprCe9+U/Mcsqj1h6Acsk7V0SA45Fh06xNtrvE3pi0dwfmJT8a');
clB64FileContent := concat(clB64FileContent, 'WEH5zBJmAO/tOi5JuXRGdKhNQN52/26MzzVAX+Rs/w2ubka5kV2hcMxdMaPbZV4Q1ld7g97bisRX');
clB64FileContent := concat(clB64FileContent, 'c4kBrOcx9OBq4IbVP7qq5QvXilu5bBVdx+1Al7vp99cDKk7Ql11skVwg2VPBY06aQg+jVqQ9L6C5');
clB64FileContent := concat(clB64FileContent, 'W7KqjUBTtlA2IXxc8x1hsf8a/mKBlkjmhQ6CbTtanX+VH/fqhIlZybiSRZb9aaO5bHzpEYQPKzP7');
clB64FileContent := concat(clB64FileContent, 'LP4RhmP5rm7qz9Hf7knQe8oMe2QF02YDujbT+RKAB+PZIejQ1BNMGy1zuI9YXKBk/zDQTFqsvaBd');
clB64FileContent := concat(clB64FileContent, 'B8qgUHGjqUVAictcU4yogiFTLdirPU1lusvpg1RpgFiQZJn1N5WLgAO58BM08G6wTkzZ7QCvuUFw');
clB64FileContent := concat(clB64FileContent, 'ebPl//iR/wBFe37wYsCynORIi9XQmWiNLt98JWhG3qsFTO+etmD7hliqmgtqxghggJ5k/Di97f+c');
clB64FileContent := concat(clB64FileContent, 'whryDHxbQVMdDXaEj/QYTpICplooZT3Lb6xAPBv+6iE/IOxx1uS7wrCVe+DtxJTVLcQVtW+5oqLH');
clB64FileContent := concat(clB64FileContent, 'pzGscAAYU0Ghmj0/G7jeYPDF11cjbpktXRjefKxMxVQP1jWCLZ0h9DGVNvGuiwky9eq7ZONPCtZV');
clB64FileContent := concat(clB64FileContent, '7w0QFzlWdSicYNco9bb6iHDrclsWGcb46iACrEvQ/5bRqXPrk30BzBTXLKFw+siAzzPeIP1aHCVW');
clB64FileContent := concat(clB64FileContent, 'l4tNGC8STGAsZy4JKbGT2MRMN3sUf9pOjCVCMBbzgdg7V/gRNjmBsfIXe8/OfqRRE0SZ4HvRbNez');
clB64FileContent := concat(clB64FileContent, '4OCK0M1wfmWEc/i51tBWnplB4e34553ogtCI+f2IzsIMwl/QUp1v11OIpV4/+3AlN1b6g3tDDQoQ');
clB64FileContent := concat(clB64FileContent, 'iUhj7Y16AzoRYdf6t7rkmi7kD7QkV8qt7u4IkqF8oNol+bXFFFZWfkQyviPGsxEe38pFnAhE27hN');
clB64FileContent := concat(clB64FileContent, 'lmBgtPec9QlfGlQYWB55rD65YOiKOSaP6A+SxooGFa02oQN9W+wIBGSIsZg3a8siy/YCJ57UHkFp');
clB64FileContent := concat(clB64FileContent, 'tvIE6i2SOVBLbnfxzW03tcoFiT/7a3cH2gCZPqQeSUhVGPajso1rBKwTjTN8Gd40yAuOBx8t76Ef');
clB64FileContent := concat(clB64FileContent, 'qB+YTyHUTYc6I7oBiV1TdpMpn28y/hbPHGpYiKhsZf/ROJhmk+c9rPikixAz8XSOsJ1V6wDgCTIy');
clB64FileContent := concat(clB64FileContent, '35vEI4jucmmPAF+xlJ3FJLXgUovWPJUEFCdozssT7iOeeG9p1Ap2CMk6nivu3InK+LwO0Y/mB7s7');
clB64FileContent := concat(clB64FileContent, 'Ksik2qzZf/nP1V6tiWZ4dTSKAHdLrIDhVz3sEFlEItrK7kDnRZdmCBIrlk/dRrAVIHxxgyC/akj/');
clB64FileContent := concat(clB64FileContent, 'MRcWEHJWdx1jbQBNaXjDAg8fi88Mu+3UTA4vfxe+1WdwzC3KkUHRfrhWnURF21xWsW0IfjtyJyww');
clB64FileContent := concat(clB64FileContent, 'vz823B5kXap7I/4TalVYVEmbqE/whIIPXPIrXS6kmhcH8yLa8vHNMo4ahMKGhFVSwOmDiz1hYAeg');
clB64FileContent := concat(clB64FileContent, 'WhvQ6Qdof/3U37cYglev4S0RxXUZ8S1JFSuI62rAySInaaYirQzR1z6rZAqelm9TZ7WFj4S6HZPm');
clB64FileContent := concat(clB64FileContent, 'EMe4llQFlxYsWgzDCRWC8C3/jbMUUYV2004YmLLoBojB+gU01LmPgpwBz5tBtqKk/ASARQuBv29+');
clB64FileContent := concat(clB64FileContent, 'a4Rbqo8c8PW0Ub9nxyzq2a/AH8G+6NJ3/p+dJ+/L+GE1k+nbEJXs+inyHq8LKc4M0cyyiEO1iwlm');
clB64FileContent := concat(clB64FileContent, 'tYxTqIMkJ4VJt+7pHlr+0kwNf+Zs7p1nMnTdcXL8r++jCvu2ltC1nC3mBDXXbEMKf41pWu349Zrf');
clB64FileContent := concat(clB64FileContent, '4ck7NCYhKETEDjG9VWSbBRQIN29z1I6rdidVry30tWp/LrHCSktF4xVwi6FZDtPm1u0OlXSxtT/a');
clB64FileContent := concat(clB64FileContent, 'vc+g9dTpxZ5e9KFkpu2cHf5uTCJulPXE8nFbj2dj9bPdCb61UAE2UFRYISKZwwcUcA26ilvg35Ue');
clB64FileContent := concat(clB64FileContent, '+tKFZxYakV9UuM/jt6T3885wuvgJu4dtBk6exszNFWmAA+tLetIfX97cDlFzjD1MBg2vhUZHx2Dw');
clB64FileContent := concat(clB64FileContent, 'i97wgpMd0rTx0AcFSAdtUucn01sI5S/pLazIF29HGMQZzfh+gPbCmXTSC0ef+hBfsf8E0VH5GbWl');
clB64FileContent := concat(clB64FileContent, 'KtGyuouhwCQrZmiTe12y3HivEZUuFUt3LUjE6aiAqtcLwU/xMF0MF6mDgsJ3zDHIYWoMcpX+rcdS');
clB64FileContent := concat(clB64FileContent, 'Gwv+6qFBz1LTHFsWPnA2DWkgA9IiqKYws7K3Cw7oOjgWTSfbiRDYHQPK5IXOXMgaTbBjPdZ8RGgN');
clB64FileContent := concat(clB64FileContent, 'DQzzmDIx4CWZ7dSY0mMhA1LYvl6avGkxLkn/P4KwRewW+OrLlXqGDGWsrrqU9fM2+H9WwHPoasXh');
clB64FileContent := concat(clB64FileContent, '71DPVOgvRdjOYtPA/UivSgtdl+l244u8jbhi0u0+PP6f61XFR+Gm1zdjA3U11UDkjejEFRnPa2xf');
clB64FileContent := concat(clB64FileContent, 'BNspxQZtRZIYIuq2W3GL4v80THYzorwDqgJEMWPsnw6A0I5gDZt+eAVDiF6gQn+CCBYJ8vOxmFSJ');
clB64FileContent := concat(clB64FileContent, 'QEXFk+Qa8xuxanb4Vpv0xVDqAbmUsStOsIL+JUFTZyDZL5kflg01pN8GFlUrhly/zHtWnfMpmnEs');
clB64FileContent := concat(clB64FileContent, 'Qs68PmoBIYEy1yM4CLXlneKc+/+bkFMV1hxsU+U31IfIRNmPv5dcKb5FFRMAe0LG2/6arekvkVqi');
clB64FileContent := concat(clB64FileContent, 'vusbARz/w6J+hJm9jIel6ZVS6hYxaGC5lNtwGr/b5f9caRP/zTUbxeW+ZkB9zHddKM6oTJE0jBm/');
clB64FileContent := concat(clB64FileContent, '25N2zBlpGa2hOsUMdlRWaLe6L9oLREx6AXbK/dMWlzpIyNZ/R7lmtgVchzmhOK8tDSahzu/PQTPI');
clB64FileContent := concat(clB64FileContent, 'RlZhNQr5myV3aPPQRT/azxZ1rpXnrkxOs2hU3b2rQL16hRmsTzP77FrlxQQaBrttDBka8w8NjG2a');
clB64FileContent := concat(clB64FileContent, 'XBPor+/irfme7WRE24E2kQhjIgmozLdMcSlqI29Dv7vVM6zcJI0u1XpTUgAYc00ayVurIUXVrwHQ');
clB64FileContent := concat(clB64FileContent, 'pAu1wTY47JbF3rpuWn+AqEQz56Ff57t9ZULN/46LjehtncYsf+X5wJmzRi6kAahHJtG880te0VbA');
clB64FileContent := concat(clB64FileContent, 'bfnTeJRPP/pQqs/80c8hzMlTsID6eNKWrtiaLNrKyO9Gt/IHycG453ar1rkQwxmf0FI65HXpovLv');
clB64FileContent := concat(clB64FileContent, 'cqTV7cgjEC6KiTqATXVW0QwEWJcV/fUTzojgsfvkr6ot0johxpiVfShtVbMesfYWrCFGCpvuN+Qb');
clB64FileContent := concat(clB64FileContent, 'wjjbCFnnsVIW1tHIujg7RJOAuzpMFThJhGMNl7DhDog0+/WH3ZskMR8oWnJnhrCu05s+S8vtbjQD');
clB64FileContent := concat(clB64FileContent, 'idPY/BT05tyLFxHLgOxVPtpXzrPmL2HhQ42mnqGZ05QSpFkt1A1YqtMXICD2YLqslDMIZFUXNMEm');
clB64FileContent := concat(clB64FileContent, 'XBw54flgJC7fhQ6d89zcsUs7HQi1FsnP9NJyMmTU3qIemSBsryEDnw8/hjelLZcq+/rLoCCegIcc');
clB64FileContent := concat(clB64FileContent, 'igK6iav7IZrP6mEGdmWBZWDITuXnGjGaHEkFdqCKifMwyNtYC8SyvQGe3BI74F/biFVoVqq7Ta2t');
clB64FileContent := concat(clB64FileContent, 'bEufdO5vHuN43ZPvc2NRxX8rXY/0B8g4S+VqP2nOPa+PNaoUcCL4a2J0rRmBtMIFe6A6xtcgsToU');
clB64FileContent := concat(clB64FileContent, 'gd5biQ6a1TDT+pUEJSsqnbMuevNJekEK91cQfULmZsHoZ9oxUTpTCX3Jfo9T/h31387hf6V1bH5n');
clB64FileContent := concat(clB64FileContent, '/fVfVHHbUS+/FTle8CwDLEQUXbvKAatdrrl32Wnef/UXpaG6CVExgwTzSbaTMaHpfECj42x3Lh9Z');
clB64FileContent := concat(clB64FileContent, 'kKjHF3SdN6mEuwJ3qWAkltXEgPJtFgSsFL5Q9sgAG5Kn24k5mU4aSUzq6MOW4ANncXJzcjY5KXG3');
clB64FileContent := concat(clB64FileContent, 'kU7UGV4x9OtQY6izX4DVSYOgvsMZI802hv8TTOd7U8M1YdWas3mzz80+n3yaTXFH3WhTh7r5FS2T');
clB64FileContent := concat(clB64FileContent, 'du7YTGzvuME+zmmM43pX2Sk8LBfibq8Cauw17IAVgLXkvZs9Xeh4XkpHC+ZSCt4Rb+9y5acgDOSF');
clB64FileContent := concat(clB64FileContent, 'bPmSwUl0Mk0d6crBkc1labiHk3rOWzF4TkRtCvCfNy+FzZHE6fJi0RQi0yHgWXIRM1sACB7gy7X8');
clB64FileContent := concat(clB64FileContent, 'Kn4dG8gGM7L5yCSXZnn4OMOoG8fsOlOI89G5PEv+jx3/kjh37N+Qv1Kae3lph1XHCy1Iy4UfqMYh');
clB64FileContent := concat(clB64FileContent, 'rtZrdO5TdVgEU9xTjpOc8wrMV8M6kEIW/KeytEOdmHrm/Y2B3fZVNgu88lE7+hVUdGbXaaY0sHM+');
clB64FileContent := concat(clB64FileContent, '0wIFje5d+zzh89nZ5EhJM/R4YpVYPVJldVhYv6fhhSVSp0HhbPNHIL8snWbyW1EC/HlLSEbkKF81');
clB64FileContent := concat(clB64FileContent, 'cXhSkDMZHI6YeuqjHZu0EKtmSXSh5UTFx2X2sUjScgUIU3IJtlz8Gpp5RD78IUxPkuQxvRrdR2bG');
clB64FileContent := concat(clB64FileContent, 'Ln4uLdtomTqhDmuMf7/GdR0RAU2cNUU/BAUg57r+OjbXt0H3ON+I07FGNZPnhiWhr1HqxsATTqHB');
clB64FileContent := concat(clB64FileContent, 'rOTCWV9WpSkgATPh/TcrvXa+9TVdyfyPUOpeeMNTJh29smMsua8UVFe0NmMRGy8NHFkcCTmlonpj');
clB64FileContent := concat(clB64FileContent, 'U9OXObsLxYcNo1uzv/nvPeCernfweYFYh0pRuWfoJiUUtEMAhVmuPMCBTDawNFkkuRmj1PZ7wZXz');
clB64FileContent := concat(clB64FileContent, 'jtLxz6DXEegygqE+vUPuBb7A/2ymlQKXgqN4wuAevHo7lj58IWREIcPR/ZppnCeYfKCGP6UF2l98');
clB64FileContent := concat(clB64FileContent, 'gqzMWnQvZ1dIjKsd5pfzZC+UY7xcmDDJuOdoQ1dc5d6ZNh8IGK1S842716xpMg8LTrOYh/5+HzpM');
clB64FileContent := concat(clB64FileContent, 'WJ0+N2jZmWYcYP4g+SNr+4mokHEjzFkadHxczz+2ZlfBny33lKEsgo+WB0LVIoXgtI64J/ZTe/5v');
clB64FileContent := concat(clB64FileContent, 'fV/qqpQV+vcXZflpio6zTVlzphxrVpVN0bOaqBGzcwmsfteyBwMx+OfrZT4VAkDFZiFgCs1ci+ED');
clB64FileContent := concat(clB64FileContent, 'baXVUoKvgKfoRLnbAn/nOewyso5OnddeoFl+S5FGS8Gxk+1tRPLDPcLB81NhWKVKkf/g9PMte8N1');
clB64FileContent := concat(clB64FileContent, 'Uw62DaSwy9eFmhfyPm/anWmPPdhUOqMG82FV65tv8+m3VoXoJMsuHsIy7ejN4RtTs1vX0ZHpHdZn');
clB64FileContent := concat(clB64FileContent, 'xoP1c6QI3LLMF5xe3j4+G9cRRalPFIsgB+pc1eVCOal+ewfdG9+rSNyEXA7UbocX3R+8BHqyw9Ls');
clB64FileContent := concat(clB64FileContent, 'bisv0XvQo/cxBOXUMa+EsnW6pnMQxwprI1331WrPzNUxz3O6kreBtXyS+Y6D6JCsm8V0Ms5mpC0r');
clB64FileContent := concat(clB64FileContent, '4fnUNWaiSTN9UmhBGNvJIq4YgGkjaJH+vIk+rQnCrin2YPrZpN9v1DauppEG1z/uB0NnAfpB7/u2');
clB64FileContent := concat(clB64FileContent, 'vImlBuoLKIDa/ngJsfaPVQYlnwD4csQLDzWoBNK3fdE19SB5OhpWdT+OMzYwDXPj0/4iRKFHwYLM');
clB64FileContent := concat(clB64FileContent, 'm/i7SQUawV8pyby+UMZIlR6pOYHu32gtdwWo7DypWg9A3r/h9H7fIgQ51NH146GKCkQ63OMpiIj3');
clB64FileContent := concat(clB64FileContent, 'SzXbdpW2YqurzgqKx58Fnne0YwZy/Dl86627wFyvdzALgvOTbrZJwoEhWbPhVbBkB2iQO7fE923J');
clB64FileContent := concat(clB64FileContent, 'YD3erx5t1+Lb1YQIv2Tf9mtdHY2NZ0wHFIIdmj9IDUd+CRjYEgCclgwFXe/LDgD6K77PJQL02mUE');
clB64FileContent := concat(clB64FileContent, 'FBioh+WIQ8ujwaNbTzQ2NaSRpJjwD2t7fudHW1PFpHPcn7i9HQ/2cnlwmnm33wU3dlDmY+l59bHn');
clB64FileContent := concat(clB64FileContent, 'ulcPfzPuK0BIszNDcTTe4fIiRjCBXsJVcSZrE+hiKvdlzeVamFOrpt4g0JYqHGjd6jOT0AXaQnbv');
clB64FileContent := concat(clB64FileContent, '38FvPBxjQZN87dbv1Zrs/Fk7hENKMCm+jsORLiIzhoflFJjVeNJY7j1ngHL+AYXcdnGMvmEzt7/Y');
clB64FileContent := concat(clB64FileContent, 'I6Rucfx9YiclH0v9kYsmqrwNQqFItCvTeikGHQuCaAZgMqoOLX5nqkxFtlqyAoHJqhS0oJpeOQjp');
clB64FileContent := concat(clB64FileContent, 'zE5qv35YN+jk/KWCVPzGc3Exl2HDCZ1PNIiqRRkKwL2m+y6F9uwMjDCh7XqMYphY/gI7UQ46uHEc');
clB64FileContent := concat(clB64FileContent, 'XnvPaVv8Xu3cR90+E5o9u5X7L6G/fdWLdSZnpMdH/es2bMxPydqdafij8AEPZl+DVo9zn9bs2eoF');
clB64FileContent := concat(clB64FileContent, 'gZa3Gws6sZCDmi+uPAPU57FvfWkgbCCydSSwjfyH6GVLo8cCWWIMziQx0ROQRoXS9NPTyLFzBdRn');
clB64FileContent := concat(clB64FileContent, 'oUr0gswBDQPe9TzF7zUbhySLePfVW1KCtHA/AfQ+fyYw11r4+0XfUYsq5obMHG7JMEcVpEzH69z0');
clB64FileContent := concat(clB64FileContent, 'KfK4OkKq2BdWtC1xXYDpx5DI2UnQoNbLn6xpT7dVnvl8Yotchw274RnDbGvSnbzlKWn/j/yQ8P0W');
clB64FileContent := concat(clB64FileContent, 'aAM23Dmt2kaQZWgnPPTERuPbknwJiSaBm/wm3vTqAyN88Ii6fZk0VDPUFxCwFXv4H4KiCl6U/KmI');
clB64FileContent := concat(clB64FileContent, 'aAWdj97qa0gm6XfjMhvvQie5eq90z0l9/6rxMtHSItzpa4vh8ck4vYRax5vhwnb87gPqPVOrAoV9');
clB64FileContent := concat(clB64FileContent, 'aXy4IBFqW3SmwYFsdHr7C3HezJt6WCtxo/qug3I2XLT4xDV8cXDGtwk2YTOWVM2ycCj8mRANfcJG');
clB64FileContent := concat(clB64FileContent, 'kPjMDa8SSo4VaGQDR860sP4SCEMdD27NdVR7CJJr8fw0tsFaeOv+L5Z7TICsgErJ3P9Mx/jfWbv7');
clB64FileContent := concat(clB64FileContent, '0RdR9AcrEbMXXqGjODEI6R/ZQawiMfPImY19eSONXCwgyPRmdE/saSC2+mi8G4UJIfyb5VfsLBbn');
clB64FileContent := concat(clB64FileContent, 'HqmDBiCfCzMT/2gLquhZn8L3M+5895XZ+i/FUctK+Sn6FQUfqu+r6HqKvYYWxwmwCOl3nC+cSDM5');
clB64FileContent := concat(clB64FileContent, 'S39eSsUjU3jQOXaVetgvZc1SY4+brVme6pN7BuAgJ8rxNxbqDistdm+Yd90ZQoYiVYFUffSP1JsL');
clB64FileContent := concat(clB64FileContent, 'YgoQRBe0GPtftSka6gVV+5QsfcvmMwivkZQPxAdK6KQYhHGM4ox755qRuU7/ALZXxVxNBKsDuCox');
clB64FileContent := concat(clB64FileContent, 'cD9mQnpyJW36Jfu1KmzLzfFgq7nuWdg7o/IyBTmNDlh3xBqVtcMik8D741VGZXVjBSLQRXUZVrc8');
clB64FileContent := concat(clB64FileContent, 'CzjQ6bxVtoouwdXKNAIxYoC0xW3zEjiBcyZm2zNXmsFzxCIid82YDsma/xNhPiRnnsCpFvYlJXsV');
clB64FileContent := concat(clB64FileContent, 'AJvfi4EMx7l4idKtxMddjzUU80PCIOgHd/hWGAsaUEOHMKXZwk+kwb1RNvblWBMHHi7JwGGY5Ly1');
clB64FileContent := concat(clB64FileContent, 'qEirAZJsmrtl2D1FSssiCjiEDsYuSP3VUb98uwGdKH85Y+rQYlg9o9APdgJnVkvEQiyyelWlZXsE');
clB64FileContent := concat(clB64FileContent, 'pXdRZ1Ds8ffYwUEIWcvf3ShATetq1D5bawziLqnTFgVRXSGkXECAdrSe4b3dt8966UL4tz5vzNX4');
clB64FileContent := concat(clB64FileContent, 'RD8uR1BLRQtB8hxTjZ4a8DWgbvUPkCOEP0UzL72PkhD2zA+ovFN9idldlGxy50PjDgDCOiJ2fSTr');
clB64FileContent := concat(clB64FileContent, 'TLA9YedZWDAAA8SXCwzkH1HC3TTR5T62XET9HWUzvVXjz3ar5Fc0nPZthL8TfjZ5hxeceR52R+Gj');
clB64FileContent := concat(clB64FileContent, 'buqmdXaeWTpS5AdKG/mRyVuwwltRMpdCn2pZiD5bEw6W+1mkeOsFy1yEp+wTC2pwJtLacVasGncj');
clB64FileContent := concat(clB64FileContent, 'WfD021lCMimGxYGgB2AVFxJATLw10LJorSPqnnfg/Lg1lZVULs9G1DB6Mw3PvqDgyTomFMq1sPrW');
clB64FileContent := concat(clB64FileContent, '4RToKRSMr2wNbRD3Dj3qFx56jpet492g4c1+KxXZ8SxRtJ/gH4Vb7MYexQlfQa8q1IhPqGPQ9fH1');
clB64FileContent := concat(clB64FileContent, '/bnzcw9uyqgZn5yZpVKZG5d352WUlC3tqBGRerC6WOB+YqH+NVBO2rK8MkWCfcCAXxcSeV8hPTFA');
clB64FileContent := concat(clB64FileContent, 'qpFWfwa90eth70oIs9XsU+AXRxf7s4RXJYUT7ec7xGrTPRH7C1xw2JlE5WqVVEyB1lb/RrU4ywe9');
clB64FileContent := concat(clB64FileContent, 'U2xjG/SvKo8N+UCxW7t/XcMTd7HnFsbCA99q5b7IS5UbNo7NSY4GV42WxaFy5yGfFnNiLl7+UKL3');
clB64FileContent := concat(clB64FileContent, 'i9GCSUMnvH5dI0U1laiJLuLyWAIIVExtFoQRyieab7wJ8YrPlPNCFDtRtLpFw9QKpt4W3hXg2/LW');
clB64FileContent := concat(clB64FileContent, 'QRs7jZevgMFL6zNRV8hbUJhegRPi2ZNuV/WNxeyoiDRIsFEgckSUu/dVX4R+NxkxrPQm1BWg9eZs');
clB64FileContent := concat(clB64FileContent, 'B5hvOaZizN2HAt86gb5izpYaDBdkCcc4qfxDBiCUidwzFmGE7vyKdCqL+9zfl8seWHSMQyDzhXLB');
clB64FileContent := concat(clB64FileContent, 'BXw5YpqMYiTIHgvHgfFN5eB2K9SU1N9jL8R0yDGwgZApSvpM8rrT8dQLzMAWUsHQ513i1t/2C0NC');
clB64FileContent := concat(clB64FileContent, 'Wz37Pqqu+9UDpwJzrk+I8de067nzAUSJvM2ErG0RBXWFuxlXxJVb8yTJ//GUzC90YwXqIM5tApK0');
clB64FileContent := concat(clB64FileContent, 'jjnFz6Y7glQq23VH4IwAL15HPEXZbxBG1tmNeqeiFUEiTLCMUStKOHU6WN3n4mvg4Kbu72yDUNkE');
clB64FileContent := concat(clB64FileContent, 'vOd02clCFW2GzfOWRDn2Xl6O3ZqWb5mWRp5dmuVse2+p9TIT9Ia4lmVTBjG77VA0ymuyD9ccc9Bc');
clB64FileContent := concat(clB64FileContent, 'KmG08GYD93uJLlX+udiU+LFRS14Hq2czoYief7ayLBmWXMaH776sZId3CY1L6Kszy6OfJegCco0k');
clB64FileContent := concat(clB64FileContent, '6Q+g8B9Kn9D+ee5aPXgDUAr/Xg+l0VAg5eTdov3s/Zxre4FZNTfJ31WxnxleRWl2EQbakNYIOmLm');
clB64FileContent := concat(clB64FileContent, 'mHhRtRo4sxE32lr+CzKxLxwXjIwRN/agtFYdL+9X+y2qrm1WmmWv9PSdtF6//yZE4lDSe+SofEsG');
clB64FileContent := concat(clB64FileContent, 'akXxn/jEWG/3Y6UynMej9oh1OwcvwUs3ZFSSm1tUZAye5P3R5XfXzPOzaQbMb9KUT+I2PWnwcPP9');
clB64FileContent := concat(clB64FileContent, 'xkcccLX5jyciWJKxC7rKc73XReEPs0J9sdhN3ziOzyc7JK/Oe0y9oUwJDKuvlSf8GJksK1Xqe1wj');
clB64FileContent := concat(clB64FileContent, 'F0L16Dj0QOpuhSvcS3Uwr5pGjjg+m9BQazZtBEUvf+Nu/Jpq2FSEbv0vdwVGHa+WVTQQy1y2+mL8');
clB64FileContent := concat(clB64FileContent, 'ervEr2teCuw2y5RofxZfTD6HUSaBnRnZSnTd11eoygeh4N7bIz4TsAab4x9VfFLhVbAJNvivDWX3');
clB64FileContent := concat(clB64FileContent, 'lkL4u31dCxUg/d4SQBmgzgPpTBlPm1agMfaAWm4hcJ9kVf286wL0IBJnhj30rq/ncZzBpveYIENY');
clB64FileContent := concat(clB64FileContent, 'PHuKwaZ8FFhAb/9/YFpkLFHrV+lI7xKm2fDkObd+K5lVshlEHMNS6FO7Oc1Ba+1V49ih0YnyDQVO');
clB64FileContent := concat(clB64FileContent, 'BL40I4m8eL8f5YrGvPVpvyq0pKr9ReqTf+b1FpWUDJYABfuje5i08t95QKMbWBHnTAsFHWEqmWKF');
clB64FileContent := concat(clB64FileContent, 'ezRJJQahSqfktZ1YnL2+XuyPwZmorKnLUjFGZWmLBssqcHmVoc99yTTgdSdrBuxL5UdKNLawPqCe');
clB64FileContent := concat(clB64FileContent, 'lAoJBnwoIGU/K+G0CRIeauYunk5HaTZmYXS6YXyY41AOWjOMdKKTpEXRtLVQOXkF6bf7y6j+Fzzh');
clB64FileContent := concat(clB64FileContent, 'gUck+OYabYL/rnielPmkXj1K5G3a7glWgwPUmRe8kWU65TcbS+je8ChLTyl2TBrxo693dNbd1vpp');
clB64FileContent := concat(clB64FileContent, 'zLjhJr+zKSwM6f+/wUIdbHhafP5nTRncl3Ai/40GuUYWFE1cnp9t55QGkurayy7S9etVz4ged/eb');
clB64FileContent := concat(clB64FileContent, '1XDCQp4PY71HHA5v9XVTK+7eoQZaIUlVQBlYP8/B6vKNsoNn1oj4rchhv52+/1PGnHY/qUel66MX');
clB64FileContent := concat(clB64FileContent, 'lPWzHwXL/BzQlZ4bHqen0BwWXN51St0gUyEJuMKERGMOlDEu14oiYfGFeyyFQaEv+YnfsUBH3GGN');
clB64FileContent := concat(clB64FileContent, 'd368VZQpqZSwr9wXUmscAehqiqhybHonooqRWDDyKfKJYuPCKCNoEhTJM8+LAvlDvZ551g+cIBUb');
clB64FileContent := concat(clB64FileContent, 'XMgUizZclqltIP+LJGcUzeAuyySmgk2KDzgcSpbRuUk6+ozaDCG6Dhd1Fx1pzoIC9/3btRFTOfaE');
clB64FileContent := concat(clB64FileContent, 'CtzphR4NdgfaqcoN8Whk4SoTpLV+/sZsgX8Cvh9hD2/w4Q/BO6bXFttFzgQ2FgIHtwm7/Wo53NUY');
clB64FileContent := concat(clB64FileContent, 'v3TNl7lT+M23O4VYbO1WOcMTMIgzHQrhUNyd1oHg7BQFfYOONppKo/T7VZszoN1kqcedO3hUNb9Z');
clB64FileContent := concat(clB64FileContent, '8xk0owYQWIWAkj49fFGWjQOEaAA2oy/jbbvDvwfs39A7n+y/qpXuGvXkPZKSI0iTK7+ttk7u4T7F');
clB64FileContent := concat(clB64FileContent, 'rabmM2DkKzMPuDrBQ0IxgBZQeKZ7Td+asEe6WfBiPs8wC8l2fbosrWkZ+8xQPN95whde7haWNFvt');
clB64FileContent := concat(clB64FileContent, 'VaAU0gE5KJZxGFQWQptmCJsVY+hBdKiz0k8rSCUQzIoAZHaUW1elSJ352oYlWNeGpsE5gfgTgI5z');
clB64FileContent := concat(clB64FileContent, 'cgtVv/LTQA3JMzhnUR/hCUVhnCRhO131o0AIv1SO4/EIJ1vV61rFGmzwR1hmiKRvefaBx9FeUir1');
clB64FileContent := concat(clB64FileContent, 'm5mA2D43l2KtKj1tv9ATI0jxETWkQL+Ta8kP1GyZYRPbHhgX2DUvSo21xl7yuHMeJX32mgBrTO+K');
clB64FileContent := concat(clB64FileContent, 'ZJ9hAtJT5dk0zdlNekdvl/8We6HxWHhMSaf0HeiTWuO3lJKHthAs57laoCfG73IUK4bILTNtyB92');
clB64FileContent := concat(clB64FileContent, 'hJf1mn449WNh4x2ynm4hfcwt3DCZHNtOSlsKn/GCohkMm8+3JAenDKqY/UKHRTCaAlcpryjYzQjN');
clB64FileContent := concat(clB64FileContent, '1EkESE9ofoPVnvZkkdpB6Huwj3oy1NbxVtq88WQQ791zpDww4KFHDSAja58juklDX3RKzfz+piUp');
clB64FileContent := concat(clB64FileContent, 'l73yZEpN5Vv550siJ13cwwu8mB+7VCiMaV69bsqDItAOmBA9VrWaW39qFjSep9YlpR2974kYz0xG');
clB64FileContent := concat(clB64FileContent, 'cms1JdrzjpXxtiZanVF9OYmulZKWemn0H2jJFxrQbZ5SqZCGtr8pmKDPv9F4h8QNLZnpvucD3s7A');
clB64FileContent := concat(clB64FileContent, 'm4vjcPqeCDRNCs3NvblEyd75q+VGKKH84ALDk4h2lpb4zX6Dab+mtxzkU2w9zntZ/p2IU6IAvO7P');
clB64FileContent := concat(clB64FileContent, '8IX9ofvUxFDvogaMK31Bd0noG0S3o+E8CPN1ZJrIyxdrRpuqUqzwMf0lWy8ugdzDV0dm/JjVuVGC');
clB64FileContent := concat(clB64FileContent, '17gPJvgmgUBHIpYUH+MgXH5fZXPHa3SE1kaxYMyDrBOmOEYmzF4l8r1ANMgWR5fbvfuAIyCmKQFf');
clB64FileContent := concat(clB64FileContent, 'bRoeEU+NzjnPSXDBYEG0nkB47SLy8adGHX+V9VakFYVnvAxIWigXph8fqOU4xv9g4/JSRa0SqOUW');
clB64FileContent := concat(clB64FileContent, 'lLmnQR/69Msy4wfitXrl2AyprEWGMlJ5w5q1c6ZUal1lbUOK1g7AdptokHBdqPdfrErnkaba7+kD');
clB64FileContent := concat(clB64FileContent, 'hXOmRtprbEXx0M4zZd8G7RDVqYGz2Dm5wh2L0AseCNYZLPulMxIf8DAdZRmcomJQ3sBg+ncnXmJ0');
clB64FileContent := concat(clB64FileContent, 'nI2sa4QF5LAHVFSfNpko7hkmRtyl+jsJTmJFjMk/TBBndMs1YBJHqEoWn49TOKxE6HRBhm6xR8a6');
clB64FileContent := concat(clB64FileContent, 'INsyGuuuqISGmiYFHjIeBxrKR0QT9wzXI/H9UPsVnAUv80ASv9puJiDZdsXUxZfdYFk93MX37DTf');
clB64FileContent := concat(clB64FileContent, '9GH3mWEWgy7wodCSrF1jKqpzd/YJRA39BeV61mYmtvFZBnnvaTpUrAQQWGWjJYd/NQeNo1yw1NOZ');
clB64FileContent := concat(clB64FileContent, 'jyNjuQLh+5wWcFS1MudJ6Uq/yswocmUalrJxAm3jNZY8j37URM9fis1ZEOdTPF/j+ZsrudZOVYdr');
clB64FileContent := concat(clB64FileContent, 'YBq2dVbY4MFScjslxtpUvPufEQSVhheQ6SyRr7I87yKlms2QbN6jUCOcVfNzbQek/kxnN0w5mzbh');
clB64FileContent := concat(clB64FileContent, '9hLZGD3FFmjVJu4aFcGyZX+47tLdFTo9Vlj/QayCLPfeF+CsijD5hwxNOGI2grXuLgceUPz4jSGu');
clB64FileContent := concat(clB64FileContent, 'gyrWmGsUGirH5cxH2mLGuNLO1DWQdbAfJbykqRtOuQPYPa5n4bL8phw7tGHmfARgIwUGhO6ZgvhJ');
clB64FileContent := concat(clB64FileContent, 'joQQC4dYFg+Zm8n+NGoOYFDZRj+pqocT1zCBqNPJkEiutO2fSaDwF3+uOw7i59JknjppxjqjU7+f');
clB64FileContent := concat(clB64FileContent, 'mhtotrkL2b4DxoaCW2xSBLz/k8M5n3oirsLOlJ7nz3xEEisGHj16+UGPwL/bJBkRbOzp+FU4Y3n+');
clB64FileContent := concat(clB64FileContent, 'SRswGl0bM9KglRXuH84VM7m0GTP6zhLwBeBMzkcs7OPjMSB3bg0cmDEH4seqec4u90dEdDoYsWNh');
clB64FileContent := concat(clB64FileContent, '1obIMhRiCj792/nksuA+yaKuNKI0jqLOaTzdEHQxfoKPHgJc/UYt3zlCgLYTY+UpMvlxc+HESfR/');
clB64FileContent := concat(clB64FileContent, 'A0AoheVDDtRsyBZ+yRJZLd5qotBosRpezT93obelVuvu9ikiFNMke7N7GPz9j/QXz96ClrGTrhLi');
clB64FileContent := concat(clB64FileContent, 'EtcS+BL27FX37Ojw6w/TtdvYAjFpnfrpHY+b7ajEfFicD/kKYvvdpRFeaTJxHuoBpkEdRhKE4pgR');
clB64FileContent := concat(clB64FileContent, 'kk8koEU8/l+hZy5nMo4Z05KAWp6NQYZ+z8bZlFoentv003NR0FajHCn0rOwSvECRr76XyKo5+KlV');
clB64FileContent := concat(clB64FileContent, 'SgHCCkykcFAif16NnXBU4r9U8pB6j7VTLSGqCTb3uV/txYdFgELESCa9ahTMXcQV772A5/SwsGPs');
clB64FileContent := concat(clB64FileContent, 'hF/jmFcnd/3b0A1d3uBsOtvMtUW9mX/ioQko2PIBlHnVJSbRJA6idqDWh1XNgkqtnzVtO544WVVk');
clB64FileContent := concat(clB64FileContent, 'dGWI8wB7j1bKdk/vupY+JbeRbQjWC7A9uJH0vmw8mShw4SsyRwaNgyWyqIjGwVadabBzTGNDptwz');
clB64FileContent := concat(clB64FileContent, 'mllWKVifI7veUm8BCBZJ83lwhrreTcIHFDa7cBrpO2ae2kQU2SNqUyzcCWUQTivht10dtqaFDgdw');
clB64FileContent := concat(clB64FileContent, '8KXXbGWcpsclOumizZRcJ+nR+oNfh0Cx9K25OTAQdSCQQiLVLJuga6Gv6S5K1Y56BqERSswX9zli');
clB64FileContent := concat(clB64FileContent, 'SkrrpgkN3+tLHPzSsyekGvmhnhp6/nKMKq0+71eODqRE4pSzyHRbZwBEJQdOryi1WTytHSV1nV6j');
clB64FileContent := concat(clB64FileContent, 'AxDx7eKdrkWyKgu2//FOz5/T0AzONQV78yV7uOCiJCwvG3Tk0tMuS4jx2RpIZiQxB26+NKxeHNcK');
clB64FileContent := concat(clB64FileContent, 'GrZQzusyD9xnu/3UMum2j7TakQTZyg8gigkwaW4kbf22JhmJdmF33TGGk1HHq3j/YB/iSAMKbUm+');
clB64FileContent := concat(clB64FileContent, 'uj9wTQRllVghaZd3Ol1Td2V48sIdYzC6l8VWUJkVZw0jbrVRKca6/vPVcH8bPmrw1NhMldH3ES7C');
clB64FileContent := concat(clB64FileContent, 'SBrCiIPNTqSbsz9mG+WlL+dGan9YOyVuLjm2/o08JmeJow0Dl5LeE6e1pBxGMJVifMIRZJXvcvxZ');
clB64FileContent := concat(clB64FileContent, 'bwgqOUvqQcF3TRfnBAC3hLCLiSneQP7S3MX/E82qyTR68b8z1hwOTMhdUnXnJTKVel3NURWIMhdc');
clB64FileContent := concat(clB64FileContent, 'XEz17P2lnA1LYv+wLrhVCw5or6vLXVOqRNdtk5Eaa8mfU4XiDcp8eRp+aYYE4tlVexryOvx/CRx6');
clB64FileContent := concat(clB64FileContent, 'YJox5cmA/AGbxPjbxKMXmU9UfsmmJKnPrR2a0O8zWfcTeY+f3ct5SsS2BjTtMs7YsaW9KdDBv2nj');
clB64FileContent := concat(clB64FileContent, '8AAaUd8QUnWKSqQ882B/9QnWc4C6XJ7E9IHmabUu/PY49LiVcxuU5zM2eE1RaMbLmde9zZmwe3ll');
clB64FileContent := concat(clB64FileContent, '6Grgi8p4BUR9n0RMgYgnNscluzxKqF0RqhMLVv4Tau+Ia9XJc3a03CwAN41i0+TFT5Si57nD92RM');
clB64FileContent := concat(clB64FileContent, 'fW0IUoWozBos4uEPVKoLzwOpoL0wwROdGf/N99SeaKBvDv2oU9w6A7lIuvpMd0ex/MdZnB5LSCm2');
clB64FileContent := concat(clB64FileContent, 'GgaKhT/aWXriejQ9sq+yyA5BYYmm7drpq118+fDf/cbi/msAcea64l3La8VVzQ+4C4IZl5UKIL0K');
clB64FileContent := concat(clB64FileContent, 'RJqzjgGXbZl7nqEIB3W8vAvoN3uVposB0PHmMLTNfXK5Vx5wGTJlKRGXTXso9ee4dH3hvbsp5XJA');
clB64FileContent := concat(clB64FileContent, 'WiFyZFzBM2nn9Od/zhksY90gJWZtTfezQaas1LDifDz0xwZKLNwQO0Crqjp9dxU8ChiaZUULoPUS');
clB64FileContent := concat(clB64FileContent, 'BIcMJvfImfrIzgcsm7pxysGVac/GI9Pk48dUP2KaTtbnNkr9xIiCWRuB9W6QdyMBEp43VqIXGFMu');
clB64FileContent := concat(clB64FileContent, '9tXcFDySakwawVHC89JnQ3qCmQiB77C4YX05ueAhLdaeYdWYd+nxVxHm8ORVwAcLugKE6x4IzvG0');
clB64FileContent := concat(clB64FileContent, 'k4ZorBMw23mxRKT0s92UTRm3yamagO2zHNN/f3IwM8HmYgNLW/EwHCkm8W28dUwHdUxsiZoQjw1H');
clB64FileContent := concat(clB64FileContent, 'xodBZDpgziYMKo9R/XZr869gJk/BtLeQFAXvbz0Qcp/atOaxs+qrByjiKNkC4uY8U3uMYFOe4jQ2');
clB64FileContent := concat(clB64FileContent, 'BCALcoFdWSzygU8YVzANZ51f6N+P5+HxSXTo2v6+oxnVnzoVIqWNqbcDD5rwEHw0RviGdsJQVxuO');
clB64FileContent := concat(clB64FileContent, 'b8UPyckQ0VfD7z+tX69cYwerKx3r2iTPFxnnYwqtRKt7bCI9E/AfFflwZ+dy7AocZLhSbdesTUnN');
clB64FileContent := concat(clB64FileContent, 'WCI9FN+UTvhppcFcEl9NZfkOhnUcRZj9q9gz7UtyIfhxgDP8Z8V7yAR8HDLMmm9UVMOHHqDc042T');
clB64FileContent := concat(clB64FileContent, 'RRRd2uFxSzdBNu9jqlhmYN4viMHaWqar4Gwge0Hf/VB3IZlAdwz6r1mPtEc+y36e92xW9jqe2qQ3');
clB64FileContent := concat(clB64FileContent, 'RPc9ZNL1dsoYYgrasp6BkA1QjZ+D5+FeATOFJRXYr+Q+EIpyaZPHjmsA6qKNAxE1mWDbipNENQuR');
clB64FileContent := concat(clB64FileContent, '5FwubEhwSenZ4lvaqnm5lENHcse0OkAh193AjemO1FMrAJc+Qeh8c5tw6WETJufquZMreVZuuvN1');
clB64FileContent := concat(clB64FileContent, 'J1jznIDaHisV45IcsLBR52uWyxAkS431X0QTqD631rva8W59s0gaqSldhcZ8/kgyetL8sFA+5lnL');
clB64FileContent := concat(clB64FileContent, '1408h421mi2tQ3q21Yyb4INaeJQXk2plLH1LWxOXyAZylpVhgFZKH4tO2Jm9cfMGuL32mwloLGtf');
clB64FileContent := concat(clB64FileContent, 'k/ZlMT+2ZFWKc9mAl07NKgPSr6K7XmJ5pLSPVrT422AsZh/eD9nA3Mz9wGGtotO3np/bYkMi7Nju');
clB64FileContent := concat(clB64FileContent, 'eg1GRqpMS3M7FU5mUsrNs4H2NdGHjW1qyUWNSxb2Tv/UezoBOkMCxdQTKV19ANxKW+ndrtffunpm');
clB64FileContent := concat(clB64FileContent, 'abXPCKymHJlFlmy/XJ+4YAlE8ZvX75MEfIEI89dpYClM92taC+r4qLt9YzvxEbBr3E60mMpmJFBW');
clB64FileContent := concat(clB64FileContent, 'Nc7X+FrHyCffslqzIsAG8MKGu5go+v2QLDf/i+U5lRCryIxmgImYuIomR+WPXRLF5codnnyQqtOO');
clB64FileContent := concat(clB64FileContent, 'P1eaUCFjn5fnsFTDeSGRMVoIkOD+hCPsdA3pcGSzIgDgDPtlhTId5tFP3wtq/osl8knYzUMB3hem');
clB64FileContent := concat(clB64FileContent, 'nGhUrXqyDX1Hk0RyMGsAkIsQNT+LC/1hkvNxXqDQN4KkDE5gI4tnNoTcCLmgwsrXGauI+nCBHVXl');
clB64FileContent := concat(clB64FileContent, 'sVDVILHJXSisfg5i+k8AswyLgHX6KF4/vS9Vv4scKinRdPUYBzYAcAFYvh9KKptqCngHQZMA8M0y');
clB64FileContent := concat(clB64FileContent, 'aiJzFwks37A38IXe9d+wmJ61pMOzUz9pu5KANEdjz+gW9Pp/u6GDa9g8GCt1Fdk7Zowtfadf15Io');
clB64FileContent := concat(clB64FileContent, 'fnGNvxqxXcTKRgF41d4KBRUb8YSJGIWZZYl5C0FdQ2h0ZOihsvjox32itXn0zxJReU3eoa3sX4JQ');
clB64FileContent := concat(clB64FileContent, '0ZV/LHPCx4EFbgpYHObCC+PKrwa+2VvqJlFGr59iw6z9BWDGio4tCb1BAm+7daPNjI5tL1+BduY5');
clB64FileContent := concat(clB64FileContent, 'jp2rh9KFzanAExa4093vqjoDD6hwKB5XGl/XqQ0BzdonM6S0H35YC6UO6qlGcQ0cQLDJbJFdOmom');
clB64FileContent := concat(clB64FileContent, 'd7kPeyQkBpDFMJF5VjOpp2l7Ii45DeqGwCRIh4dWREGMMBY/UAwmaisw+HligNfeEvlxvEMLDKI0');
clB64FileContent := concat(clB64FileContent, 't9ke8v35Iyp8PMS+xiEUCO1AWyOQ8VfRH78GYDgrZeSSdPbXWCkvBmra3U2IALeBPMbNFdRG5H5D');
clB64FileContent := concat(clB64FileContent, 'RaXhG+2OzAPzpJVPfHIUmWPIGfNxmgb8Zm9+GEQ7mnmLFm27iL+YzPR4ciYAVwBmAaCpkB1bZ+UI');
clB64FileContent := concat(clB64FileContent, 'FOu5OlcJoWNwaMKVwuRs/phY3gtSGd8Ve7IISPg+/gBkIk//bma6Bd04uuktWvU5Rx67v45Cb1Dt');
clB64FileContent := concat(clB64FileContent, 'BiEDPePPXJgnSD5WoSozPzFrf/t+0tbGJYrT+XnxWKS6lB1PMcTFaWonzUi2tWnRwNYNm/jzJpEA');
clB64FileContent := concat(clB64FileContent, '7rI/HxjVQ7+81bQ9d5sTotXYBfpj3zJDZ+IsaTjWUxSyn6n1t3KeRCGxwLUoAUhYTpzv602Ac0gC');
clB64FileContent := concat(clB64FileContent, '7Qx5/Fyl2Q+yVrJiXxtc1b0wSlM4GVpRU5qNcmMXrQgxWgEMc5ZGxBYK4dU+chXc46bXiM27I/ag');
clB64FileContent := concat(clB64FileContent, 'TMIWKhwb/pwADiDsRpGsw49bhLIsEeH9tdL5ZDB4bsxQ3hTKm8nS4xVFZloIdS8sMKPWWYeVFN4I');
clB64FileContent := concat(clB64FileContent, 'MtMuL0ubAKsNtt039gq4sKIXx0tlCbGxy5j8zXXRoMffAEZj3yFlvCWcwF3oF4wcqng5h7HNGRAH');
clB64FileContent := concat(clB64FileContent, 'pOj3Nrv9l/7pybcxN1PRXGIjF+jPXns4x3lTQhUfzWIWbS3vZ3QVGAXOC3hdmblEDcYzJg/LMErS');
clB64FileContent := concat(clB64FileContent, 'MSWgm/XSLmUPetfFjxWEbO7CzVwKGuq0148lQ8pOps/DBCQKytGBnS1wV+KTxHyPcbmQr7WoQ+Mm');
clB64FileContent := concat(clB64FileContent, '7GGSyBcmZQGDJpVt3AC+mH4TfZ65kIeC8gtQGDOBcjfZOnFJUcKgyntTpVI+Yo7lQyj+nd4fVbF7');
clB64FileContent := concat(clB64FileContent, 'tY59xo/ubDCavSORJtZdI5UTIBYJs+Z8CpArgVenBuzOr+UvA/8RGm7vd1Fkbx3x854/BO7ZeJVW');
clB64FileContent := concat(clB64FileContent, 'cHZsh54lL7MBbhe8IPMQyPs2BEqWkmwizgFRmHDzCjcXbC6IiSRxIKdY7X7MN42mf6RFC2eTlesg');
clB64FileContent := concat(clB64FileContent, '6gtvPh7FFzdLh03GLYGZIUwEEDjKkKXzcvPu4YJavTYhjEkOw6tCz9oHlpmHIgHTnh3YpU+ytxxz');
clB64FileContent := concat(clB64FileContent, 'V3g/PAZ/XI3d325xxbdPLfy5TvdjECWQP/6yCp0bAZ+Jgkgr1UQT6G89uEPJ/xPeLgWlKweAOWsp');
clB64FileContent := concat(clB64FileContent, '42TXzp/8jJJGxaFFAtiidOsOfka1/8JW9+UCGTjMfAVi73VIk/Xzg0nbmM56LgGal0Esx3qWqvXP');
clB64FileContent := concat(clB64FileContent, 'wXzMwrIS3FKn7oVXx1ShSZeTJhaQ3XSp92b7dR7Rg6Q/t56G2jVUGl3kYPx1gSwS58ojcwZHZ3nG');
clB64FileContent := concat(clB64FileContent, 'wMbPnLVakKa3nujeek/y+n82WrKXaMnfnFFvIzsbvbguwjXbFUdVAROC6aQ7KAFy4Z/GgFrN67SX');
clB64FileContent := concat(clB64FileContent, 'ucnCRxO0sz9g6OCByk83hgY2qL6ruTrFZGrq4DM7wcM5wUBsx7ZkFM+S//r8K6OtxE9LilOMi8Fa');
clB64FileContent := concat(clB64FileContent, 'U0rrqBKxrALkjuCFm4d4Qsy/SvKbCfSmDC4YEBMCksLe7yeVrV817FXC8ICGohEu5wpP/SUpo+2U');
clB64FileContent := concat(clB64FileContent, 'FQ+y0hq8HtJgToh4VH+arzbym175a217D4Qr/MrazmLH2y/JTzv4Y9ciLURyL9fHkbrj6D7vplQV');
clB64FileContent := concat(clB64FileContent, 'crxmwXTXCQbmYEEqnB0ii1jb6hNFSTy2peGVO1qAritivzBOVovcWPyvrKZynDXVRngRdR2yLXAB');
clB64FileContent := concat(clB64FileContent, 'EnulYqzhZb1H0bNqBk8yxOL735fehVkfYZYt3oBkGsVXopkFfINFhFoAS13hUQuclpJIh9L/P4/H');
clB64FileContent := concat(clB64FileContent, 'hapJZTzM3NksSAq1xemxRiwcdAxzVVKdpGkGAT1h1446B5fH4TaFEVMOvummFIm1CTN/H5N5ad/R');
clB64FileContent := concat(clB64FileContent, 'qrcFgfABSV3wUgCb9dJ0qSdoNZsyZRncAE3z/DG09D4E93a18U1oQI7UM+ELaFwHZV43vrWMMibf');
clB64FileContent := concat(clB64FileContent, 'axky2a+3a1/EDYh92iPrnCc1T7/pipstk3HXS+UcG74oEec/DvZR2xd0H3CXKy2R8Y94xyYtvUCe');
clB64FileContent := concat(clB64FileContent, 'fYH0XjIOU+uqqv5B8KSnT/scsU5PBV01jnMHimTm5Yr79rk/JmEfBg0qcQ6y6wmL+NtLQ2Jf/lE3');
clB64FileContent := concat(clB64FileContent, 'XoiU1LKsj+Fc/KRLJPtI5XVKXyCNg72woj3RiQ75+tkFsrAvW8ipdmz/rNN88l+jdgAwzG87Odli');
clB64FileContent := concat(clB64FileContent, 'ER8HhO12ciqSu2Z2p5YfCzqUmNDuPGOnIDdj8QZednDBgLf5rNXeiZj2PapZmtg08xETUNsvSitW');
clB64FileContent := concat(clB64FileContent, '2fZaDmNWo1wk83Gvp9woeJ1jU+Cf5E0FZv+0GrUgTZrG4UbVrmWwkegTuRPQXUaAAridStet8xpN');
clB64FileContent := concat(clB64FileContent, '1NNKTnZTUyGwLsGzxqSXTSluv+hT04rSM6wsMWiyO54NM0PzeeVBH7a4qQ2JkasxhCiNkz7SZw97');
clB64FileContent := concat(clB64FileContent, 'G37vclWwWt5zp4Gf2vA7wrR4s0gLxV5iT/uCqcUxGFuBAFmNPiwyYKGxqvpAlQCRnbXpvKeNcyvy');
clB64FileContent := concat(clB64FileContent, 'OLyGCOc4dFhpRbbmDNxHVYdEm3hfWTKqytkWijnOyjEfrj7lla4/q0b13rNiuf9y0zI182W15pkY');
clB64FileContent := concat(clB64FileContent, 'HLdE3O2KmssBUq/DnMTYNUpKjfmTJU2XtZreMpeem5/K6K0L1xl7Clb9/Ijb9eayUEciZquN/ImM');
clB64FileContent := concat(clB64FileContent, 'xPp9MvTl1ThcXygthKVUbdlzDESpxgVRnJn2ac6t/73pe0IyDmRvT67Y4B3Capm+29RJ1Fzap4Vf');
clB64FileContent := concat(clB64FileContent, 'r6CVe8nxQFo/9csX2SEjqjEtvQGkzOFyE/LJJS2OhglmovHvVYuvdUEhUyjZyPH8FhuVk2An7/U8');
clB64FileContent := concat(clB64FileContent, 'jSqIHT4t9mCOcK600vNL7HkWxH+f9EqU5FLHrHoe7BIsLizBauNOtegiwkdaR8YITqoT1/DvYC7p');
clB64FileContent := concat(clB64FileContent, '30Y40TzoeacPvBBF5J2XF4jRawJcR9eq4UfNHaLpTeBkNCeRQIQWDs7gzPyXxDadehR8+tbovOIx');
clB64FileContent := concat(clB64FileContent, 'Mn94sSHL24zwUr9c+oyTdxS1pI5lzT7ycCcMHzfilgLseR1mkUmaHn1UD0f8H8wq2OkYHCc3mQUi');
clB64FileContent := concat(clB64FileContent, 'mBZtMpsty6NpvsVdCB+YGp70UtrKyiI4vNokrTvgmuM4QmaJEIjfVQ4jRHLhAah8HR1+G3RXcn50');
clB64FileContent := concat(clB64FileContent, 'Cb9T7IXLM4IObD+VD0By9/9puZkqQq387xRBSYrkaQPNvQep6jYEJi3tw1NI2N1BRDLzEc6McCfp');
clB64FileContent := concat(clB64FileContent, 'HsoEUqG6vx9lS9T+r3pqnEqt+nluaKPRKvXlzFa3b9Rqbqc/uYgtliQgjIh4/IrTUEtqB9PcXEW1');
clB64FileContent := concat(clB64FileContent, 'dZa6HP/Y+u7wX6ym+Wko/v6HpCmRVqWq7Ygx0KhdttY7gJiL2/wS5RqvceQhbsITZ8Ito4eMwS0Z');
clB64FileContent := concat(clB64FileContent, '0tcMKdW71tya5Pp471KX9mQ1FD4Ydn0oI92aQbSzSS7UT3ZnWmSD10/mFj/lv+xSPpQdgAryFAt1');
clB64FileContent := concat(clB64FileContent, 'zAxtmsCMVsOJwXkUgJVzLzpbEjulOlPLJVZxQ6v3P8rGBsryvJI937czJBcoWRVyv/zWNmAwYdtc');
clB64FileContent := concat(clB64FileContent, 'wcy/NCyvT8TG8a0PII1Mn9L5PqTjvB3nD/kJuMC2NwVlJxXy+3ovHxG7VCLN8X6HUHAEv2KEcU8q');
clB64FileContent := concat(clB64FileContent, 'iYyCfRBTn1oweCrEXClD6ehtURmere2KbOZ1rbgrSE6RU4Tytg6IFD+HkRQzYRuAgT1TO8aygsXL');
clB64FileContent := concat(clB64FileContent, 'a9m4aSqEFueNEAEhyyzrM60RIt1cNc75aDNswar6YET4tAWfDvOXZbNtzodEGdZ8s0vlDENjfwuW');
clB64FileContent := concat(clB64FileContent, '4mgL1EylfIEgwJphyaCcAq8CmBJ3KEE9zrdGYaRuS+JKeJ7/dmP5c8thmy9+xMjITO/tjrYyVnTR');
clB64FileContent := concat(clB64FileContent, 'u1p0+m+qX+Bh3fMhuh+LSLejTPtrO/oOjRoWLAQHHoqvpO0xoXW7PmRcsvYfihCEd8ox5xfqNxLp');
clB64FileContent := concat(clB64FileContent, 'llwS2jrhLY15Dd3et6MPhWBzwcTp5/XWwWGnVm8jcRNRINCu+Ss/afqQduyYqvwPPaZhyq+N45Td');
clB64FileContent := concat(clB64FileContent, 'LY46gfwCLFiERgy9D81VujZSmdRYwgP/ieOC1GOEp6hLmC1G43MhcwsXGA/PtM0V7Ehgs9m86sAD');
clB64FileContent := concat(clB64FileContent, 'P0dLRJPCUhaMFgqLtobeUzv0FkAaISJJbMI4KHuLC/3G8Bdny4Sd9eS/WHASxNJK+cm8E2lPO3hd');
clB64FileContent := concat(clB64FileContent, 'dseyr2wfr81WhfWUuh0POIDOjbX8gZdrqqHn6aEao8/hE4ipiGKzYnPNTh/F+qctNd2hGdxWCd10');
clB64FileContent := concat(clB64FileContent, 'vV6BGJFF9ITr9cWlPl8IfeYlrglosWcIBZ3g4c2c5qFqWI8jQUcs89cARuwHi7taxKGaHwE4pJa7');
clB64FileContent := concat(clB64FileContent, 'fu1cUdW0P3b58y7IwCv4N5HHxIkxbjWdYJr7fV8M0ytqDTLoMS+6SOFK7zsTpkUFQgWHkMPk+W+t');
clB64FileContent := concat(clB64FileContent, 'igCnw4T/wPq2KNCsMS7M/QUePCG3oBm6ZOetkmLRe1uXC7wkCYRpY97otU8EFBi6z4rQqeTq/8X1');
clB64FileContent := concat(clB64FileContent, 'MCvgWW008N/lAlj1JaRM5uoE9Es+/0v0wr+jgoJrjRcxE5f7u5zRkHlheXIGCqdDNhgHsHOpteDq');
clB64FileContent := concat(clB64FileContent, 'FOOCNKCsfMNkULhF2dUL7RVfAq8nRh6ps9ZrufHCetYYOn9jgwLrFrOIFxsSp9asNA8gEpk25Xie');
clB64FileContent := concat(clB64FileContent, 'VUd59Rp2VaZM8cHtyfx4XQwATcj4dA6PwMHi2CMB2IFlF8HxcbDJpBAcL0edbQNDuD/cxTcznmcg');
clB64FileContent := concat(clB64FileContent, '5GDxovaL87NDibalIgbwEdIr2GUGR6HN8eVkHejfHZRF7GKqS27RKF4THsZDLlzAV8kLCkapc5T5');
clB64FileContent := concat(clB64FileContent, 'jKmlkIwHLNuXYyTbX6pcbakbuNajtb55N7bh7GHxWXc6kays3sevwtGc+PjM8wawdqwmV4EI1FRb');
clB64FileContent := concat(clB64FileContent, 'xXP9peA+/Nvw+jWZXxb7ow8Ar5kBtVJvVD7aJ7m8GD9r2hgi0ulkqL7RVa65oiK2vr8l5eEfNwra');
clB64FileContent := concat(clB64FileContent, '5j9biEtRBx0dD/yp7GyL9RmXtaukKWmMPQCY/NRZzIHT69XaPHbcdfJLPLGvTpsJWp5Lvvo5F0rz');
clB64FileContent := concat(clB64FileContent, '9OL+9o5go/FKVQGimaXqwm7/cSv9v6H+l5FuCN94L85LEY7FH4l4Fq5x5X1Kp+WBZ0Y8ydLjlT1L');
clB64FileContent := concat(clB64FileContent, 'F6ey1pMaSvY3aejvV52AIXI2kSC8/UwHZzPincu/zVxCKcgIilQ0p5eqP+O8EP7sR/+eeKm/1nhi');
clB64FileContent := concat(clB64FileContent, 'EUnqYUX+Wwzm12SxGeM66KYHoyns7I8ehbV1iurbEQogrhrIU66KtBN3+Xn5DS+LI1U1GFdzgIsx');
clB64FileContent := concat(clB64FileContent, '/VHO2gHT7OmyykQY8S1Y6OoiXIj6t/Bv0d0DeP6Ij4tMMzjSYMjrHJ7fwIeGbCyvdCzNn5fQ20hH');
clB64FileContent := concat(clB64FileContent, '8+Qbf5D6LnvNcC+UdHgfFONeR/IKdWtCKSxTq8MkZLwJcV0trG+3/HNJSsAyQhf/jvQRLqvtAI6h');
clB64FileContent := concat(clB64FileContent, 'Mw9UK7QnYq5n8P0epg9q4iqXooMaGmnS7tDSjQ49teRysZPvJC5sLd0+Cdvh//IUvLOXhxzZQKQS');
clB64FileContent := concat(clB64FileContent, '7o2+WER5kR0qHMhOmCIgGbzGhigxVoKmwEgpnyiRhlv3xldMg2cJrKiT6NE4aEItl0w0HcApvPvF');
clB64FileContent := concat(clB64FileContent, 'O1+kwY8izQtf379S0Nysbj693szk8Gyc/gd8nj2VWs6i+pxVBLoTgpia5er01eIbzss6H+P6j9PA');
clB64FileContent := concat(clB64FileContent, 'ny6wcYUplNRUVfCxL3Gp05MMU4B3PaJy5UNavZe952gLPOHzK62Y1f7sAsxha+Bms88wVt50fvXL');
clB64FileContent := concat(clB64FileContent, '9BvgLHTJ3DMMnkYF11Tq+s5ueoUuNH0CflgFt6FoQN/uX2EuhEHHh50On18XJpu8QsAz2rAF0UY3');
clB64FileContent := concat(clB64FileContent, 'E9QuPuHIjhCHuMF/ec6Yy784kYT6cyFMjdlcNQy0xaKxm9pH5vzxlha9A1BxwNXnZqbY1ZKmjd8G');
clB64FileContent := concat(clB64FileContent, 'rgn1G4zODJ/XqTNKoBG2iI82OxoudkC5iZ+0uooIcr24whGkDXbgfWH8r8t21HLOvqS4V9hb4IPv');
clB64FileContent := concat(clB64FileContent, 'JSoRHZuk87+WGoEvb+rbwub9dVaG3LEV6S3TaPzQvYgCK0dA98YoWYXOhFdz+dggRRv4XWXJbHeY');
clB64FileContent := concat(clB64FileContent, 'uUHdK9nqwhQ5oT4pO5hzhLYunzfXbDZRkrxfArurjLCRtYHzt/roqwlXwkyqWbcszN/xS70Sopl7');
clB64FileContent := concat(clB64FileContent, '7egjtiBSGhMez2L7yOZfh9CAQzl6J3LzmXme2bF/gXCPJbERW4jh0MSFAcvnncInsgfvHcBBBb6G');
clB64FileContent := concat(clB64FileContent, 'JbQfFVPEEOmnzX417N5UkNIsfuSc5g/pU/AeC6BZw3gzNfs4WAKl1aG2gMln6cP/mF4BeVej8sHn');
clB64FileContent := concat(clB64FileContent, 'M77qzjVwqECiNla7375C6LNCAcfxtMoyjSqTtlzkY+3urC8ArQwxpwMAwEHpp516o2LtGRf72Cla');
clB64FileContent := concat(clB64FileContent, 'ITxSlXNvzmZ8q0M5+J5HwZUmnXhFebIWM0x0k4kTtyL2frL8oOUdFd8bJg104AllsbaSggSQfEKm');
clB64FileContent := concat(clB64FileContent, 'eI2B1HsIB3NxlDZWGcJKYjZq7ooztEe+BfR/wCbzS8Auu9axyb3ACs5JKVGEzT9S6SfAahEvlkG2');
clB64FileContent := concat(clB64FileContent, 'VCAgp5ZV4gEXYu115EoubhviVl3cHLE3JNzrx4VyDjCRzRpnNElC16wdrKvnuEIBMKn1ghFz9By2');
clB64FileContent := concat(clB64FileContent, 'JgAFpAdwnffJOxbR/mgguaZvdcDVniVO+wFIC/AY1xzXPLKD2LO9EUf8QGWUpbM+c4kubbWrqfbk');
clB64FileContent := concat(clB64FileContent, 'O+hDLANKkmCFM/fXyCiipEGbvJKAnTVGGgXTKEoyR+1U9HehtKSUwxVP0SRqlwVyzzaJXU/X+Ge5');
clB64FileContent := concat(clB64FileContent, 'F3OM+FqbbVUvZr5UGg4aoC9IR0hgNBHy0oef9DVpH5ElCxEq06AqIIFMqEgYAubhRXhaXNBnc4z+');
clB64FileContent := concat(clB64FileContent, 'XZtrj5UaqLHpc5laj++a6sa4hHsbY7/4oyHccFUXjPQlIUXRdy1vtS/6v1IKEJrWOFnAbNHEoZ3m');
clB64FileContent := concat(clB64FileContent, 'zDffMfUp5qo2gYAZPvnNdKZzR7oJHGk6DI6+8ixH2P7ofIGJDtUXJ2ht+EfZNaoOhmYPQK7RprL6');
clB64FileContent := concat(clB64FileContent, 'C3apXsDvMFwbOtMCF0naJr1NVo2fKKcnY+8K5m18Q+P1G97Qt0GyTb0uh7tfD+J3P2cnjCtKUb6Y');
clB64FileContent := concat(clB64FileContent, 'c9Z0L9vt3AH2kA/CRtIbrM9Ep140dOhAqZ1adfKNRrcy8FtdflrcNhq6K8ZwSiuqLyIP3q8G1E/r');
clB64FileContent := concat(clB64FileContent, 'SQD3MzTNvroquPYufMRTV9gLya3gSwZwgn0eo9wPoXLhcVwKShIlnBxNP4NUMfpNbdhWpu5TBSuJ');
clB64FileContent := concat(clB64FileContent, '5EdjC3GdynzhNhTTSacARK73Rwk9fTOGpUxps8MTVFP0SVlVOMzrgXK4+HK3YjsWyb5aN88Bsmgu');
clB64FileContent := concat(clB64FileContent, '4s6r/Bu8pSbfb3/2HoiUpRZMD6takbmWvGMwri92d+Aq00vCxNrEIyFQY5xj+Qfu6kMTdHqgZ1+/');
clB64FileContent := concat(clB64FileContent, 'UstyUw1sHHEtoT8jm4k4sVK5rcXHiCrB1/a5RTe8rWFT0D28bZG0CSBfFv+SjlArP8Hnezx51cgt');
clB64FileContent := concat(clB64FileContent, 'iZRYWsJlTI+wkCD8JMAOZq1LH8ntgGCL8581eavYqsXPs6a3VzwOk7fwq5vExzbprvA8DMtr5WiK');
clB64FileContent := concat(clB64FileContent, 'zRVWJYZvPgN6WEbX9NhhDpXQrc8+/qOc3w9YryEBhEfA9Y5VnR8omXUout4jyAvJ/q1Fsq5qCQZn');
clB64FileContent := concat(clB64FileContent, 'BFOjmaxALxyiYW7ahhM14vSM8mT0OcPDQs7D1rQ7MB/2MuMPxfUEbcZC13Bg3I7QHZciGkjchktY');
clB64FileContent := concat(clB64FileContent, 'rvfC1UGV8CYhl3IYBrFMEvTmW1fM/k5AXLLFeVRBuAETA4A8Esq92OAydD2uNv4NnJQaICsFwD6U');
clB64FileContent := concat(clB64FileContent, 'DnBL5Aj0mdTMobWLnk6gLV84I4InL+gOjXdYgOofCTMwtuVfw+d9fCIlaCDxJ6FPltNsuHbMuGdL');
clB64FileContent := concat(clB64FileContent, 'pGaThJ+I/N/8vF7HxoYxrr9k6uyIRdGwsyimaihcJYuEIOJXjQJkbpxHKNbOnsD+dtfZbXGUpxpT');
clB64FileContent := concat(clB64FileContent, 'u/ZmGsNHNT2bdLStlDQDN9QbK5PCUzl6jNRR2HyRlXpr8ukl+iF184yiRWajLGBRt35EizJki53p');
clB64FileContent := concat(clB64FileContent, 'zxoJmYVCpsmrPuLm6sbSWmvoBSbNJNedBvkybYPx348rXmGCsN8E/TxG7CgFBXmc8np+tv+lMnO6');
clB64FileContent := concat(clB64FileContent, '8IJkGT7fMjaICVhcBu8rcS6PrVdr5TPcBsTgAPcSRxgNFt87dOYd1vco5+aEJ1P1g22U/F82AP4g');
clB64FileContent := concat(clB64FileContent, 'jDPKhaA6GRfNWHcOU1EWQSl6abDSQFhM4FemC37HEjnYUTTcDJA1n1ioI7gIM7Q9bfKQm0ZZwpB3');
clB64FileContent := concat(clB64FileContent, 'dEq91G3jyDo5CB4tHt3oD4YRyX87UR9mnb0lFR0AZQPjnEXFVnrpnurTtTMndUJLdoMtd1X+rKwt');
clB64FileContent := concat(clB64FileContent, 'bZvJnqgwFBlSYgMVwvd1XKcqIcu/WYoYegHNKpU6ggTrH5Pt9kxj3k36Lq+vW7FMQkSr+DNrs2Qh');
clB64FileContent := concat(clB64FileContent, 'PXsA7iOMDy0AP2K402ExPJDXjcr7E8DLgwi1+QOnB623FZpz/O97imbsTZ3+/DnYoEiJ69rGtLRR');
clB64FileContent := concat(clB64FileContent, 'BW/YDwgWbr1a3RExB+ayyQUlpHRJyw1q9jUdtjTfvBXdvZXcNaGZ5ODz/jx7csFqy3aa7kUyWT6l');
clB64FileContent := concat(clB64FileContent, 'jpLbwNkINyJDMO+BrOe0dINTjWZWursdowp9HgKGBH+RX6jRiYs5CIrfCMs+TxTw9J7a0/0b8w7l');
clB64FileContent := concat(clB64FileContent, 'I1WVwrQ/k2/IUtC6xUuJ4SnQsEot3AEzyptZ4nR+wM9UQdvulZ8kgXAey41vVQ57rkxjtnyQ+HUS');
clB64FileContent := concat(clB64FileContent, 'NXAjD7AWxwV3n3Zf+Y6Sh1E8HNOO84+vBJIvSue1g73++rSYUxQWj/Na+r1NnDxVyBvcKr8Voqb3');
clB64FileContent := concat(clB64FileContent, 'f93FRa7TmUSkTNL9lQ2w8EygsMCH9pPqPrY4efG2hLEH3fIFOWP0/CM3wslY8fID5FIBDczv0+hO');
clB64FileContent := concat(clB64FileContent, 'ykgmZRUQBY3q+Qc9en3wAtXhGCyx+wazVhj4tQkLx3cNmimI86ftZNlaQbmBYn+CJLl65oLpgjQW');
clB64FileContent := concat(clB64FileContent, 'd8PVKqtZBZZk/LJOUEMO9Osf7iVgJwopwnzX5xSXkyh37WeMCtee7GrbUaawHfAjNbLWzPxGPra6');
clB64FileContent := concat(clB64FileContent, 'VF8IOGiyVToVeeOdgCzevoiaG5vDFaC3gSEsJ+ViNPfL7NR0cYP0TA6kwIemXaFp4zoBmX9CDHNc');
clB64FileContent := concat(clB64FileContent, 'IYAcAte33UtVpOuIAeAS8J/Rfb9QTM2H5of2VazzhQ8l1TFK8ZojUwDpdf83NEzxAqVO9KIWp183');
clB64FileContent := concat(clB64FileContent, '54fArw2QXCBTH+Sj4YObNKUx/QG8EtDhrK7qHH1cSWZzjLcMaXSqKEdz0BwDx7+0U3MMqbFY7Jnx');
clB64FileContent := concat(clB64FileContent, 'U4V6pnBhmJILeiFGbDuRcJD0ynFC1WAbsUhmIraCCrezOC9uS/qha75qQBbJlkcEivqGT1Mwsd4u');
clB64FileContent := concat(clB64FileContent, 'EJ6mE08yTjiLfJwMNAlSe4CdEWu7Zw+vt50RN15j7gz52tCrr1r5wLkQhlmtH2U4wvDy6Kly+dog');
clB64FileContent := concat(clB64FileContent, '3yHNTGG4bhAfBEExG/G8lK000VM2bx3O0sLmFoOUU47yP3Lqm2d/P041yEBHYcAEA8CNx7VgxYtT');
clB64FileContent := concat(clB64FileContent, 'YoVEwiNmnuJz/n/Amlgs2T50fqYMUgkEmH7MHO9sNRxmYp/bqw/XpuC4eqm/8jIZs7EWRtaDhkfC');
clB64FileContent := concat(clB64FileContent, 'Vpmn1aPBsRuzctl+QcluY+YeyNWwNKAJMYzYNTGUr8f1UFpsljTLU/mqRR5uTurVMnTxxDcpqOCv');
clB64FileContent := concat(clB64FileContent, 'x5va0bdLM2OI2bf4fnlLjzOjUnEfVH0nthq6e9nl2S+3+XRUM1ezrhA6uf5Zxsb43kxZ2B5dSG6a');
clB64FileContent := concat(clB64FileContent, 'RgZd/dAuaK3WP/CUd34fzpYyJs9k5TpGNJtMkIzNZRDbFpjYy1B70a25JD7bA9Wrkywxpv2y4tXW');
clB64FileContent := concat(clB64FileContent, 'OsP+J3aqW8Ozusgv6Vm05/SvmUSJnMtDWh4bu0PpJNGXzuuvq0arXNuUmNwlYf0+CJKUiT8tFyJc');
clB64FileContent := concat(clB64FileContent, 'J2ad2QD+5Lg0fgAcX2FqHPxnKkn+57wkiMmyIUHuWxuxivaoQW2kAgejy8mgl/7SVUzdP0Cmjjtq');
clB64FileContent := concat(clB64FileContent, 'GdfQcQfhk/MvLnKPpk4vpM8V81noBdcnuNPBRD81gOVB5Gm17rc4c9MB9r2jHRSBzReEvLn8ySx1');
clB64FileContent := concat(clB64FileContent, '1xQ1Fe/KiMRehW5URAmqkO5/Mg00WiOsxJuXUO/Hjjrt/EJMWupE+eMAVKysv7widC1PplDE2acM');
clB64FileContent := concat(clB64FileContent, 'yiovTmTDJqo6c/dDN3oHMyipl3LPKcbTMFNt0z/mFgHzMQwh8VhHYR4EZi8acb95YwwH9kEs9lxO');
clB64FileContent := concat(clB64FileContent, 'n/1M8rtw+Gwos4N7aAzVqUqvr/jXmq2Mgghrc5BFE28/bFGedLV2YtBwj6OPNQw57v3QBMFFN/Wy');
clB64FileContent := concat(clB64FileContent, 'M6GMiGa4IsAJ9Yi+Gsu3BYBH/UWzxyLpmGIOz2WH8qOneEhfbMOOG5cxPi9dBz++1hk/ONsA4hHB');
clB64FileContent := concat(clB64FileContent, 'oOY5RTqHR0ujJFsAzB1PkXGHBuYsytu6Q/5se4ZS2YPfowluzHwI24iMjRQg62UoMQCI38dHR538');
clB64FileContent := concat(clB64FileContent, 'CRpV8c1S8XiDKBivFhUO4CgzBYFVDCuTqCOHP+WedfgNGsFNK5XkibsNVZEV2OLUqd5FODqaLN4T');
clB64FileContent := concat(clB64FileContent, 'NCAh2HFzkOJ9V4t8mq9zVJyNo1Z/HpTpfcCgdkZym/mSGzwW+K4Aoiqe/F7cbJtHKfVBYqd0Lbvx');
clB64FileContent := concat(clB64FileContent, '0XGhQkztb0AAYNGpQ12nCEQdUt9VRnydVRWn5pZkGQfZl09P418Ip/AN14lcOU+mPfZXohb50SzD');
clB64FileContent := concat(clB64FileContent, 'dNDl7w7g9cdaskHj6a+a7vjt5LRO8Cg+1Q/XVmzSTY0+hwizxqYTBBDw7o3yTOLrMSrj8ODzBREL');
clB64FileContent := concat(clB64FileContent, 'lcjTugEzW6VOHfxpawtoEWvDJmsnyphS5RoRA4oqralfP5xTA5zXMS0WS0H3pbuQcI2yHeT1bJM6');
clB64FileContent := concat(clB64FileContent, 'eAxH1YqVbV8lCTk9s20/N0lyaSinUovjBwxoF822K0B31wPc5HPOS4KQ4rcCWAYnCfcv9UkxsNVK');
clB64FileContent := concat(clB64FileContent, 'ALq505ZOKkgnQKa1Io8Jy/+VptwMB5Jyaw6h8M4E7+epaEuoyyXXDAtyBj2PgHvW+1s/tdyV4e4M');
clB64FileContent := concat(clB64FileContent, '8E+WYJPb3sZEuu3C+Z7S5omuwtYVf37GmVp+/QSJmsN3FzKNv+w/iwVkxIz2t7lr3MwXUscjyphC');
clB64FileContent := concat(clB64FileContent, 'BQ0dE4nNJXgmeom7sso0Cu/AixX6brMvBJwmAip8+Y7zXPBqB0cMhwmdvgFJzMhuZTYgCp+JkJjZ');
clB64FileContent := concat(clB64FileContent, 'noXs8K7mdKvt+JWGFj6STEPKs4jOpdppD36xGEbbqpH/l0orEJ/uneXh8PgrVA+rQeNivoq+QGlY');
clB64FileContent := concat(clB64FileContent, 'vCDgCkBWXNNP1wC4pRfhny2N1xPUs3a5YyGcRX3RWO3jxGTXO2915pOsVzEjvRqTYIibH+Phk1VT');
clB64FileContent := concat(clB64FileContent, '7mGTV3FIHRlsDkGgxc1T3Thp6k719Uh/eJOwHipKGv9tcyeyg20RZEy06f3/oPZcKd495DSIHs8Q');
clB64FileContent := concat(clB64FileContent, 'od229s65kVGJAm5blz1luVS3DCQndypVQBcWyZRkB2vrIXyf/4X0Ns8wLwJThzqijZXv1yDcVHwl');
clB64FileContent := concat(clB64FileContent, 'uh4RLZ88370M2sXQR7ZWWiFLPEjNHChXJQOULDV9fXpGS2mvqG6mIuziYWXl6gdkn/2594uJwDKW');
clB64FileContent := concat(clB64FileContent, 'OTfAa3yVM2GWJW+h4QJ13wpSD2OhJf82VyI45Us4HNPlzFuSovU2XVvokwSGNdlcrWXMSvZ3MlJX');
clB64FileContent := concat(clB64FileContent, 'e0f6G/8z1hWYjSwIlstxsd7+EBx9ab+ujgNftKUh/FNQhlAgA2uKFJP0bOl37b4bK6pvNpjO0ra1');
clB64FileContent := concat(clB64FileContent, '+XUp116JNHDq4DT5nFUACTmGjdU3OQJ0kLlB6GhqSe9cEnwDYvGatW+FHzH7jghz106iM0VeULW+');
clB64FileContent := concat(clB64FileContent, '+XqKl581Pqk4aLpBOu7YQzcykbZWqDTeOGXTFv46bnEUhevxX7Aj3vfyp1UytSthh7y1dlPslPQh');
clB64FileContent := concat(clB64FileContent, 'tNASCufCh9ACzxDWCOngd7GUBeHwz3cGPO0NgdReMLo3V/bFaQ6l2MQXMaCfNaGveoGYoalABgfK');
clB64FileContent := concat(clB64FileContent, 'Oyicb375AT8rHkaqW4gixJyLqn6pTGG5GDys/UAXD5GPxL4jVVp5oMC61PcbhxVyc4y8qgE0t239');
clB64FileContent := concat(clB64FileContent, '9daoixFmNbDG3thPJGhSLYgXZyTofB9nUu0fstAfX4ShNt+/bdoz5m8CYMDT4j339QdmMMyYhTiL');
clB64FileContent := concat(clB64FileContent, '84McnWQWwQk3tMA6mSY7ook5PkK7rrzay8DdiVdPtQjFmyrYpjWNhUKv3XLprg2l979SwFNhd6En');
clB64FileContent := concat(clB64FileContent, '96EiXH/VkyVoB6gEMgDOkA6C1eKZlfdXKcbjPR+IhspVrfzTx3/styBdcfA7YQmr7p5F9n61fINd');
clB64FileContent := concat(clB64FileContent, 'Ln0cgfbMCYL5okUpii9gMzBrjAB5HFvBHcfuamD43wK5VwIupgO/JlwUlCKmAegjMU0UPPf+A3Oi');
clB64FileContent := concat(clB64FileContent, 'dJ7FZJnNYDqftziPHKWlPfuSKyeH9h/Bu2XsCA13PSNWzeFxpkK5fxOoq37/M4IryeJmdevMoJ1c');
clB64FileContent := concat(clB64FileContent, 'cfA+meNiD10roBSvrUl+DIdgdMis+F9HgrKAwcVpYXW9AxJmmKDN5AWoMZu9HJMVP0zEdC7ddlyw');
clB64FileContent := concat(clB64FileContent, 'WgIo0QBcgWnLG2SWZJ8SZQVf/CPBoxJT11BpupEbCY++/fRmDQ/3E+pyA9tq732+rwLWHyZepYAF');
clB64FileContent := concat(clB64FileContent, 'YPj5m8XmMTCZfDJIAUM/bjcH0Q+AO+QCFLgP7ppgPqe38XPa+EhXXPbdPFAroYEnhytmIJmJ2cVx');
clB64FileContent := concat(clB64FileContent, '+OdiHwvzvvoBKFSWQDN1BVPU1vfMyO/RGT2B6Tj6DzqDvkaTllXn7Pj6FTtVGaNU7SUI8zJzipGj');
clB64FileContent := concat(clB64FileContent, 'SlASFUIS7eCr0xCk7D0Lf808ITngnRBQtPcMwE5+ZSV2ZYNek6njnJg3vEiifjZ2YTILWwYl+tBs');
clB64FileContent := concat(clB64FileContent, 'KLn17FA/TaEKfmbIJQEVRXKTKUpytHD+K2U9SufRT3LldvNV5Dn5psMThhVwLDdhUpjLYquO0sOR');
clB64FileContent := concat(clB64FileContent, 'sP5jq99URkRWaxXzB8HIn2sAre2BFgnOg5v/NPKiXyP3nCcaYtU0s2TOy4NGeHsbsVS2S6DovC7F');
clB64FileContent := concat(clB64FileContent, 'dmlbuXTazEUbdASEw8+2A65N8yqUQ/DnRrWOt8QKThHeoeijYyT8L8dNqgL8EApbQqbpcRIw6sZU');
clB64FileContent := concat(clB64FileContent, 'ad5QbAbrfwmYpIKxHVTAohl7q1S6kF1KT6oraEKt9thyvs0hc+3C9anUGxa9dos5q4uWNKs8qXbU');
clB64FileContent := concat(clB64FileContent, 'gEmFL31AZrui17tvvlZ++qR48/3o5GFX/itOlP1YsDWL8cLaK5nzmLKZSj2Dijm9Dpe9SGgKfCGd');
clB64FileContent := concat(clB64FileContent, 'e9ZcaOMb4WLSehOJXhskz8b7jHxdDEEAqXJbq8X3sTjsu3JkK40lD71euibw70lc6wIX4HZSFzMt');
clB64FileContent := concat(clB64FileContent, 'gUeNbxlSQgb3IviKeJuw1eo4TeicIW1IgR3Vd2vNxyBxJ6UV5onCO1GrWgK788jeGTKZ2PblfxII');
clB64FileContent := concat(clB64FileContent, 'kX29+RBukAtL9Avb3m0qW+BMUATccqH1pT1uOoWzCie6rmDtJ5CuZVU/cZIVQXYjSEVTMjZkoxtQ');
clB64FileContent := concat(clB64FileContent, '3yUH6c0HHXBnb7kz/4naGDRSskKIjUwuSArnOnrekzBYCOms4YeH8VCRAViiB94XA2Z9WRdslKPW');
clB64FileContent := concat(clB64FileContent, 'mGiAGvRAAJWIzVobd78Eghk6Wqyo6vC6k/xQuVtH2GMsLTiQNutzSe3BykV8jFNUa+Soqu6Qorim');
clB64FileContent := concat(clB64FileContent, 'JTd7ZlmDOGKyC/aGUNb2tCBdSeNJXW1UnKhQya9d4cLHUgedSgJfw4BUr8CuO+ixnUc567BeW8wx');
clB64FileContent := concat(clB64FileContent, 'DCYOAIbryNt9fqZmc4Z/YwAPTxY1Htvlc8s8yRAZfq5VPRkG37XN88TjYjrEA61DHBv8n0gJoIHX');
clB64FileContent := concat(clB64FileContent, 'Au+sVmVvAPaO8I0GcghmJs5zb2xHAGqzW/2qgNH+C5/bVUsz5PRoUGr38yjxRvmDWoTjBAw4EOG1');
clB64FileContent := concat(clB64FileContent, 'pZWNUbPV9Wwj+TquXrFtjWDUpzLx3Z/SJgdXQtNhu/S9sZ5G6ov27DT9LyuM65/uA/X98bL+f7TI');
clB64FileContent := concat(clB64FileContent, 'UmMQg5UbYJGC9M1faVjBHboOvPn7p+LnoU2IhGnbm2gFZcKJp3YplwcwuuWNayMbvf6NdvUHLx+p');
clB64FileContent := concat(clB64FileContent, 'qpdb8Bih61XvUbwihhZ9d+6r4m8wDYMtZNnMiL/qYqebsSzWC7fJNpp7AlfE31kVBMjv25ehl5Hs');
clB64FileContent := concat(clB64FileContent, 'z6Ao9joAAKE3jfcMBZwy9QmyEdd1QinZXacg0hF6ERx9BrDWKpTgOwpBFmz6y6cMtwF97j11VFPA');
clB64FileContent := concat(clB64FileContent, 'lkYP+G0TDmgKBUHeLgOjfl6DALRUYv3za8w8Ab3q+aHxvVFF6mxbWLSU3dNKzU0bja5L9wbGVCia');
clB64FileContent := concat(clB64FileContent, 'IPDLeIBK2W5bT0LF0YsdbUPxkiHtjb60dUAjEefFhzsxM666uq6R57CeU9RapoZ9/50ecXefZi7q');
clB64FileContent := concat(clB64FileContent, 'cY7WvWomD2zbSBYjp243fmVOQZfcZ8jh+gVmOyB6ABHlN3rePcQjzgAj1UVsJqS5CtLhRW7rW8CP');
clB64FileContent := concat(clB64FileContent, 'Ur53xDrtEyeaHQ/JRUMswoPSYWc9Yl/Qqwvf67uli7Nw8cEam/zasCDY7iKgehrQZekMdhnX/BQv');
clB64FileContent := concat(clB64FileContent, 'mFVFlrxXKgNCrjgip56dC0JgPfTK87ukK9eZ7/EwVPWz3KKgkmkYUxwEXL3Jp8AwpsgqxUfFaVtq');
clB64FileContent := concat(clB64FileContent, 'eZiaVZakPcrTI8GgUacfAQ1w4UHIleh48gdJ1p6wKIa1dnPO6ZFMtVt1LQ3QpEIC3DsWzD+Qoc5b');
clB64FileContent := concat(clB64FileContent, 'DeTSCFLCsyVmBujGovDNGJ9OnHTNncYeoIYxsPqAz6lKWOXVKLQFiirqVyATzaYNnwGfPiwaGUIa');
clB64FileContent := concat(clB64FileContent, 'dqVVJ6KeIvY92IqI7Y+gjEXAeb5LLx3SlV8JuMt0zYDMEfAYdG9TqexHyKesRbGT/X0J0cugPp0u');
clB64FileContent := concat(clB64FileContent, '+M/RsqluyxROIvVVykmzeYkcxBRPcKeqnbJ3UMOUxonTAl0XnZ78WZGZ+RsNKaGrQj3WL9KG/YzG');
clB64FileContent := concat(clB64FileContent, 'Vb02o8yDDWYTsXYIhqIcSfgXFAycrY5qBl0HfL+Ik2LijkqcyWmikx1pFi5Ms0KOw7b+L8j+TmwV');
clB64FileContent := concat(clB64FileContent, 's1FQgxllO29nUdST1fqp8HYguEueVFldKmwd3NBGCakljsX7aELpwTKGk75fn5EKSjh99E4OLI5Z');
clB64FileContent := concat(clB64FileContent, '5xQv3TWOV90APm969SYpOFtbNnr2pk0d5ZVLcnqrMfDP05oaxN7gtXuXX5cgF4TERANATq6hNGqv');
clB64FileContent := concat(clB64FileContent, 'SdNCvKVL4MeLOcLTxiU31+PFR+e8RUZn/VTv7P/0ZrLkqWxgjqQuBSCtKBwfV35dYfADbXuCNIg8');
clB64FileContent := concat(clB64FileContent, 'WH821O2tMDP6iWarKOJPvOz5bbnBZaicc2XrC09GJD14syTI3IuILkZpfbzcWlMeyXKJfA46jRbh');
clB64FileContent := concat(clB64FileContent, '3YjgR8lap2G9nKwlva2yPlEgH4jvKH1BsLupMZPC4lWoJszmXxdW5cyzhH/oJJxudDhBU8K4ZBxi');
clB64FileContent := concat(clB64FileContent, '1nBCa2DBHa6kIkeBZ7V5KTzNGhW/oshsN705F9gHPiLyQShHzNV0WpHVC1QANi47BHJhH+e7pLUP');
clB64FileContent := concat(clB64FileContent, 'Ex8D/f8EcFOy+wa5SZRgOdAtI7OqjcLzpefB9d/PmNksf8al7Lm8h6j1WIq1rhVrgdCKmLBHtqAc');
clB64FileContent := concat(clB64FileContent, '34iI6zNfdARVcY9eL5kqmjmDQACje+bVpiMt2/coHFqPI0s8HZOzIkGrDAxxHvpb16lw2Yyu+xDB');
clB64FileContent := concat(clB64FileContent, '1uiztSdMRG5hJpz+8EkJWqyXKNLLpKsWutijShS6OdMyI3SrWE4Tizg9arJqk7ZNlcdE35lYaTGj');
clB64FileContent := concat(clB64FileContent, 'BYpokmw+zblYsJryF4dby6BgxhfoAMuo9xXuzHIXYc3vuwGUaGXa32YbQOiTHW1yi0m4NnH0gvkA');
clB64FileContent := concat(clB64FileContent, 'U43fR0tewE4W/5ttBvbZpivBOBBllvpuHwWkp0UZWPjy+GEMWrbEYWMXuSifoxLa9X3qgCJ/C2Ls');
clB64FileContent := concat(clB64FileContent, 'yxzHKeMdvMfzUVevtjHPq1R6KTQlRRUTr1UD80lhH+KumN/baiwl9ILaepdS4NkASdCxBQKCz5rI');
clB64FileContent := concat(clB64FileContent, 'CDhIJ4pjvaJQv7R9xSM5of+53SazFKeTi4Y82QfgZE0aHcwwIT7TwYqk0GAUSXTIATZ/RzrpfEy1');
clB64FileContent := concat(clB64FileContent, 'xI4hpRTNtUVSdgIcMRif1gAel5MQn0Z0O5eqX0yVFKYaWNRCaUmPmNkMR52cGRvFPcSG3PV28Rur');
clB64FileContent := concat(clB64FileContent, 'yl6s1nRRZT5wOGeDBxwSbIaiabKA8Yn2jDDu+Rl1RzQfGMCLHH0ePRgOFTPZvr7LB+nCYoK8LoPg');
clB64FileContent := concat(clB64FileContent, 'PqYBZ1BWaXNPWQyPlOUmOS5qiBtnPBD8EKaFazrH9NQD/NvHDBYMzuUW5Acj/kjnd1c5FC6s29Q5');
clB64FileContent := concat(clB64FileContent, 'EDGtPVL5VmziyNCazsirlfSbKC2b+mDDrEsXx/70RG6Bh6FXLqF5X6RTGKD9mYhfxUkBAAEEBgAB');
clB64FileContent := concat(clB64FileContent, 'CcDbcQAHCwEAAiMDAQEFXQAAAgAEAwMBAwEADMEAoMEAoAAICgHPJOKfAAAFAREbAEwARABDAEEA');
clB64FileContent := concat(clB64FileContent, 'UABMAEEAQwAuAGQAbABsAAAAFAoBAOxsNrNSNtkBFQYBAIAAAAAAAA==');
    

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
 nuIndexInternal := LDCAPLAC_.tb2_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCAPLAC_.tb2_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCAPLAC_.tb2_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCAPLAC_.tb2_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCAPLAC_.tb2_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCAPLAC_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCAPLAC_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCAPLAC_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCAPLAC_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCAPLAC_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCAPLAC_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCAPLAC_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCAPLAC_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCAPLAC_.tbUserException(nuIndex).user_id, LDCAPLAC_.tbUserException(nuIndex).status , LDCAPLAC_.tbUserException(nuIndex).usr_exc_type_id, LDCAPLAC_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCAPLAC_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCAPLAC_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCAPLAC_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCAPLAC_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCAPLAC_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCAPLAC_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCAPLAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCAPLAC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCAPLAC_******************************'); end;
/

