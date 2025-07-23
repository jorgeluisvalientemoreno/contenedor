BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCLNKFAC_',
'CREATE OR REPLACE PACKAGE LDCLNKFAC_ IS ' || chr(10) ||
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
'    gi_assembly.assembly = ''LDCLNKFAC'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''LDCLNKFAC'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''LDCLNKFAC'' ' || chr(10) ||
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
'END LDCLNKFAC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCLNKFAC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;
Open LDCLNKFAC_.cuRoleExecutables;
loop
 fetch LDCLNKFAC_.cuRoleExecutables INTO LDCLNKFAC_.rcRoleExecutables;
 exit when  LDCLNKFAC_.cuRoleExecutables%notfound;
 LDCLNKFAC_.tbRoleExecutables(nuIndex) := LDCLNKFAC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCLNKFAC_.cuRoleExecutables;
nuIndex := 0;
Open LDCLNKFAC_.cuUserExceptions ;
loop
 fetch LDCLNKFAC_.cuUserExceptions INTO  LDCLNKFAC_.rcUserExceptions;
 exit when LDCLNKFAC_.cuUserExceptions%notfound;
 LDCLNKFAC_.tbUserException(nuIndex):=LDCLNKFAC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCLNKFAC_.cuUserExceptions;
nuIndex := 0;
Open LDCLNKFAC_.cuExecEntities ;
loop
 fetch LDCLNKFAC_.cuExecEntities INTO  LDCLNKFAC_.rcExecEntities;
 exit when LDCLNKFAC_.cuExecEntities%notfound;
 LDCLNKFAC_.tbExecEntities(nuIndex):=LDCLNKFAC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCLNKFAC_.cuExecEntities;

exception when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
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
    gi_assembly.assembly = 'LDCLNKFAC'
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
    gi_assembly.assembly = 'LDCLNKFAC'
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
    gi_assembly.assembly = 'LDCLNKFAC'
);

exception when others then
LDCLNKFAC_.blProcessStatus := false;
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
FROM GI_COMPONENT WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCLNKFAC'));
nuIndex binary_integer;
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
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
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCLNKFAC')));

exception when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCLNKFAC'))) AND ROLE_ID=1;

exception when others then
LDCLNKFAC_.blProcessStatus := false;
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
FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCLNKFAC'));
nuIndex binary_integer;
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
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
LDCLNKFAC_.blProcessStatus := false;
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
FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCLNKFAC');
nuIndex binary_integer;
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
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
LDCLNKFAC_.blProcessStatus := false;
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
FROM GI_ASSEMBLY WHERE ASSEMBLY='LDCLNKFAC';
nuIndex binary_integer;
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
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
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;

LDCLNKFAC_.old_tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
LDCLNKFAC_.tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
LDCLNKFAC_.old_tb0_1(0):='LDCLNKFAC'
;
LDCLNKFAC_.tb0_1(0):='LDCLNKFAC'
;
LDCLNKFAC_.old_tb0_2(0):=3922;
LDCLNKFAC_.tb0_2(0):=GI_BOASSEMBLY.FNUGETASSEMBLYID(LDCLNKFAC_.old_tb0_1(0), LDCLNKFAC_.old_tb0_0(0));
LDCLNKFAC_.tb0_2(0):=LDCLNKFAC_.tb0_2(0);
ut_trace.trace('Actualizar o insertar tabla: GI_ASSEMBLY fila (0)',1);
UPDATE GI_ASSEMBLY SET ASSEMBLY_INFO=LDCLNKFAC_.tb0_0(0),
ASSEMBLY=LDCLNKFAC_.tb0_1(0),
ASSEMBLY_ID=LDCLNKFAC_.tb0_2(0)
 WHERE ASSEMBLY_ID = LDCLNKFAC_.tb0_2(0);
if not (sql%found) then
INSERT INTO GI_ASSEMBLY(ASSEMBLY_INFO,ASSEMBLY,ASSEMBLY_ID) 
VALUES (LDCLNKFAC_.tb0_0(0),
LDCLNKFAC_.tb0_1(0),
LDCLNKFAC_.tb0_2(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;

LDCLNKFAC_.tb1_0(0):=LDCLNKFAC_.tb0_2(0);
LDCLNKFAC_.old_tb1_1(0):='callLDC_LNKFAC'
;
LDCLNKFAC_.tb1_1(0):='callLDC_LNKFAC'
;
LDCLNKFAC_.old_tb1_2(0):='LDCLNKFAC'
;
LDCLNKFAC_.tb1_2(0):='LDCLNKFAC'
;
LDCLNKFAC_.old_tb1_3(0):=11784;
LDCLNKFAC_.tb1_3(0):=GI_BOASSEMBLY.FNUGETCLASSID(LDCLNKFAC_.tb1_0(0), LDCLNKFAC_.old_tb1_1(0), LDCLNKFAC_.old_tb1_2(0));
LDCLNKFAC_.tb1_3(0):=LDCLNKFAC_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: GI_CLASS fila (0)',1);
UPDATE GI_CLASS SET ASSEMBLY_ID=LDCLNKFAC_.tb1_0(0),
TYPE_NAME=LDCLNKFAC_.tb1_1(0),
NAMESPACE=LDCLNKFAC_.tb1_2(0),
CLASS_ID=LDCLNKFAC_.tb1_3(0)
 WHERE CLASS_ID = LDCLNKFAC_.tb1_3(0);
if not (sql%found) then
INSERT INTO GI_CLASS(ASSEMBLY_ID,TYPE_NAME,NAMESPACE,CLASS_ID) 
VALUES (LDCLNKFAC_.tb1_0(0),
LDCLNKFAC_.tb1_1(0),
LDCLNKFAC_.tb1_2(0),
LDCLNKFAC_.tb1_3(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;

LDCLNKFAC_.old_tb2_0(0):='LDCLNKFAC'
;
LDCLNKFAC_.tb2_0(0):=UPPER(LDCLNKFAC_.old_tb2_0(0));
LDCLNKFAC_.old_tb2_1(0):=500000000015619;
LDCLNKFAC_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCLNKFAC_.tb2_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCLNKFAC_.tb2_1(0):=LDCLNKFAC_.tb2_1(0);
LDCLNKFAC_.tb2_2(0):=LDCLNKFAC_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=LDCLNKFAC_.tb2_0(0),
EXECUTABLE_ID=LDCLNKFAC_.tb2_1(0),
CLASS_ID=LDCLNKFAC_.tb2_2(0),
DESCRIPTION='Link de visualizacion de facturas'
,
PATH=null,
VERSION='1.0'
,
EXECUTABLE_TYPE_ID=17,
EXEC_OPER_TYPE_ID=2,
MODULE_ID=16,
SUBSYSTEM_ID=1,
PARENT_EXECUTABLE_ID=null,
LAST_RECORD_ALLOWED='N'
,
PATH_FILE_HELP=null,
WITHOUT_RESTR_POLICY='N'
,
DIRECT_EXECUTION='Y'
,
TIMES_EXECUTED=17,
EXEC_OWNER=null,
LAST_DATE_EXECUTED=to_date('07-06-2022 11:31:25','DD-MM-YYYY HH24:MI:SS')
 WHERE EXECUTABLE_ID = LDCLNKFAC_.tb2_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,CLASS_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED) 
VALUES (LDCLNKFAC_.tb2_0(0),
LDCLNKFAC_.tb2_1(0),
LDCLNKFAC_.tb2_2(0),
'Link de visualizacion de facturas'
,
null,
'1.0'
,
17,
2,
16,
1,
null,
'N'
,
null,
'N'
,
'Y'
,
17,
null,
to_date('07-06-2022 11:31:25','DD-MM-YYYY HH24:MI:SS'));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;

LDCLNKFAC_.old_tb3_0(0):=40009751;
LDCLNKFAC_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
LDCLNKFAC_.tb3_0(0):=LDCLNKFAC_.tb3_0(0);
LDCLNKFAC_.tb3_1(0):=LDCLNKFAC_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (LDCLNKFAC_.tb3_0(0),
LDCLNKFAC_.tb3_1(0),
'LDCLNKFAC'
,
'Link de visualizacion de facturas'
,
1,
1,
48,
-1,
'FormExecutable'
,
null);

exception when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;

LDCLNKFAC_.tb4_0(0):=1;
LDCLNKFAC_.tb4_1(0):=LDCLNKFAC_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCLNKFAC_.tb4_0(0),
LDCLNKFAC_.tb4_1(0));

exception when others then
LDCLNKFAC_.blProcessStatus := false;
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

    sbDistFileId        := 'LDCLNKFAC';
    sbDescription       := 'LDCLNKFAC.dll';
    sbFileVersion       := '1.0.0.0';
    sbFileName          := 'LDCLNKFAC.zip';
    sbMD5               := '4918cb5d6dc070114737f96ab6acc830';
    nuDistriGroupId     := 4;

clB64FileContent := concat(clB64FileContent, 'N3q8ryccAAOzrgk9iQ0AAAAAAABlAAAAAAAAAOshtZEAJpaOcAAX9+wFu+r0/5QBL0TuTr0I2yvx');
clB64FileContent := concat(clB64FileContent, 'U9Plq7xO/c6hY0BIQykUfFcxmm1nJkkaGBLomg0YBj0sy/fHRpK4HzK+n2a7pvMs7BoPjYRR4KMd');
clB64FileContent := concat(clB64FileContent, 'xlRcAmPnIxsuvdJpYURv9Tzm2qa0LVp2CMon+fhXW7zOBOjPgxK9VrEmewYknaxYHukGDfSToWSn');
clB64FileContent := concat(clB64FileContent, 'ovtT38mIQ8DYdSpxQhIhEeNvPdGO0N2S2E4n1P93cvER1vXhaxPH8LFuDurxSFIOpxTM0Myl9rvx');
clB64FileContent := concat(clB64FileContent, 'AqFchtvb/FHdM3gnRAU1lwMmS70Bk8RCZm2cmq5Q7o9zOrUbAoj6buQqIGkjcutnt2xhuqFX/+Wm');
clB64FileContent := concat(clB64FileContent, 'g0OYfYQLwJbprOgWZOcGmGDZIFagdL4BcmranrGty/2Q/gr/Wx+t5O+cnUFwX5ZWBhnvJLHlP0S5');
clB64FileContent := concat(clB64FileContent, '5MY6agEA8M1G1XVAG2iIQ1EPWzdT1xuvpEMOepZ3g8osU9MuIT5S/6DQ0DBGnORv9VKjQzNIYxvh');
clB64FileContent := concat(clB64FileContent, 'TpfkycWtXva8VyDzAjnTfy7dKV9Y2cekvH7daIr5TdV/5gdxhXeOGS3Fb8V5X5h1T2kZgQ1U5Iqm');
clB64FileContent := concat(clB64FileContent, 'lGWjhF9J7heImfoKs2ISJlJASbUcfn+shjFQPmq/GvYo7R9al+xKGTUjuFpnzP2Zlw1MT/81/rgi');
clB64FileContent := concat(clB64FileContent, 'eT4JdYHyjOOnS0sI+NPHkga0IqmBU2JeRP0ZUvquD27U++2iYMM8Xe2t/D4CxWbXUk1dXfuNJO4b');
clB64FileContent := concat(clB64FileContent, '09GB5SBveJVtU6GpeYCQNgT5s+YoSR1tP7V7wQAFMLkQ315SlbiUwGehlqGijsGrMDlc9MoSUP5S');
clB64FileContent := concat(clB64FileContent, 'oCAmIiSNnOZRtC7uH3XbskrhZHO4MeiPZ0sNWNTPwTmP01LiE8m+sLbfFt7lrWWbfoe7kri29TIM');
clB64FileContent := concat(clB64FileContent, 'IH6ByALJ0joGhlnma4qwZ8dphrKjLsUMWEtXNboNqz/byZq8V+Cvw8GiiJNsKLb3O37tS5rccBXj');
clB64FileContent := concat(clB64FileContent, 'aQn+1yuVFOYxYJ5bqcWefJYJBD0eFHpiG64vVdvyZKO81e1FkHOepgHaTQ+lhZlBKZjWsVbpVAfz');
clB64FileContent := concat(clB64FileContent, 'u7yDjTb30PjnRiw1zNmlVM4vCtSIThC3EH3EX+NDkkMxoHG17fdpY2FaMxW75wc/keQqMFx3YErQ');
clB64FileContent := concat(clB64FileContent, '8yvcI3qEU+lIlW7MfeW7/kMn+7O/L4ezhkrGool2fbeKokPVp3IDK3JEZI/xHew0SDnswpgOyFpB');
clB64FileContent := concat(clB64FileContent, '5qp8oawUM2LSk9yVQwpxNXIkhuslaMuAl36fMMw+NO0OFWXq114DdbZQQuaBKJ70DXh25C7Jd7cB');
clB64FileContent := concat(clB64FileContent, 'HkDWxbhu2YXiUFm26rjJWbUj8c5T6+uCv5S2rVujhHzrV21WEzB/lJDhskWT2/5sJJqILSCaiIOy');
clB64FileContent := concat(clB64FileContent, 'M/6z7mriJbfV9/WwEDvyB4Ht1XuNc2MGE1w/9yvVJ4KtXKfA2lhxY765iThUmn300gr7iLbusgGr');
clB64FileContent := concat(clB64FileContent, 'cfZE68MQJrvWXGPuMlg/qCK9hCGmZ/wyhPq/jNZNogM49T4MSPNwCSGhfAbl5zg+kFzNc4uTBE4i');
clB64FileContent := concat(clB64FileContent, 'NrNLf0B+XcWYBX9OdQT2j7oYJC5yBLnEHgd7VeHpwYdolQE8dCRuapCK2Aaku08uEr69wdMEHwzT');
clB64FileContent := concat(clB64FileContent, 'KhrPqwJDJkU5OuQPvnlTx0yb8ETmQ44nqKEHevWDh5nzZWyykp0ebUsyKkpuxvSqPkycC4V8wfqY');
clB64FileContent := concat(clB64FileContent, '6cManc5HGdNPi0xynFthooPiumTfWCD9malEUk0fgoWAuU/BFtLlVnxJmm91yWeW+vuyoR2BjlzW');
clB64FileContent := concat(clB64FileContent, 'YUVT/XqY9FigzuCyIqAzKCtZRPeXHIfCdShfZAiu2uNb0mPD1cm0PC03+rNeak1zM4y6UWi3hCj6');
clB64FileContent := concat(clB64FileContent, 'jNtysxaizLJbGiQV7DIpctgecL899pOoZSXFn3JB3hZH0GvdhSrXirMfzp642b077jQF2pjGenyK');
clB64FileContent := concat(clB64FileContent, '1S2zII5g4FdNQHgQmEHlYiZ2KH7xvHU+HHo0jV31RpVHyRtwrGZNs3hUIJDAh0Tn4GHtC0kBCkmz');
clB64FileContent := concat(clB64FileContent, 'LbIkGd3evybGEYbzwLZHV1BAZzAp7FASpIMVQ510sZyIMeHBMuW8J2AEMNMSTQCMfHr6xi792n6y');
clB64FileContent := concat(clB64FileContent, 'zO499cE9AkzO2FHk4Syyui4jScj0zwMsrkPvPL0NuxPjpDTLL5YozULqcAhOuYSgxUa221xllAU4');
clB64FileContent := concat(clB64FileContent, 'dGijWDswiBn71qmTz8gBc4tl0wwDgwvrPVexEOpc5WlK2IDSEzj3Au88r0lODeD1s/jcFzaPdQEV');
clB64FileContent := concat(clB64FileContent, 'HQZJlO2L+9zz050/AtcrfUWLypry9S136kSsyJ/vNT6btjY7Y+7zeoouTDuqf2z8ib0BAMZfyyRS');
clB64FileContent := concat(clB64FileContent, '7IowFeMZaG5d9JVztKe62ETOP3TdA3JqmJXNpo8bsNVa9mjrr8+LILTmbjeD/+fH1USgolXr4urU');
clB64FileContent := concat(clB64FileContent, 'nGUbxUSrNXQbyFoLfcb9wk5FbP50H4JOtziV68oS6hMLw++Z/YehLMJulWSz6hqSXwRnJKFUqGog');
clB64FileContent := concat(clB64FileContent, 'pFJv47j6nk1Vke2VCujnqDCtlZi5Z5gyF95sT/ecD4PHLpUasZVnifOFecxgkRHUR4Lwk9GxTheR');
clB64FileContent := concat(clB64FileContent, 'Sh6fcR3EUqU+xQAOVUiRDmNp8t2GeLgWRkWLRN67gaPErGQyuUt4u3W8za2lSK/zF1Sptp9db+9x');
clB64FileContent := concat(clB64FileContent, '8wd7LOG8jmWlb+8AnvopNFxVWjoOPaijCzKn/nJLHru9PaG7MfJCdvxG1+d0lc1UFfs8ROrFoNFY');
clB64FileContent := concat(clB64FileContent, 'cQT6BNu8zjCnS5Zu/O1OjZ8wiIZ9+Ub+VoaBwoLAdQ8M1WslfZrM384iUIsDSiSbvIq0Naj5hmaO');
clB64FileContent := concat(clB64FileContent, 'Z30OBHP1Icqd+pIab3GWJvXXhNAF+FZa1HIwIwcHeF0MFvemACqjYKboNkJI59uBTqUTsu4xIdB+');
clB64FileContent := concat(clB64FileContent, 'DDsfCunzeUHjILA703vvAZQwpAv4urapQRq530gvZmTT0z6ovNVBOCJWcqNYIZLXafMf3KmS3WPi');
clB64FileContent := concat(clB64FileContent, 'PkgEXGqAAWW+KsVbnaHUGtcZYlakL89uNKjBS/5DsTiK8UJZSFyhr3W0HExRndApRmXzVoYyvZ0X');
clB64FileContent := concat(clB64FileContent, 'VmbcZY1YaF5nI+t79zK2NjnlaxerTSH/cdkiasPCAMgYai3f9RRMNYXcytEQyystQdOJ2u72FNJS');
clB64FileContent := concat(clB64FileContent, 'kWUPvUN1I+Nvhlk6pB/apmZnYov+MqGuYeM489S2AdpxAJB6QVseZEpuka7K/kSJxM5k9Z2pFCN0');
clB64FileContent := concat(clB64FileContent, 'XNSf5W1yTft/MFs9up3rPar+k2VuXlNIFasr/OpWtXzBKq5iaOiF/qTC6DHz7F+iGjqlb6fji8Z8');
clB64FileContent := concat(clB64FileContent, 'DC1oJcIzfjvTpiJ07Yh7Q4uupSaJKIrf0c72I2DyW5AwDyMMJLREjIBiWdtBs5PeA49XtCsNgd4f');
clB64FileContent := concat(clB64FileContent, '0Elc0NwCgPMPEwKXV5PvcL+1EzIPqbLg7M5Sz5R/+8BaKj0b+8Cjby3tYfIYCm1bJrVAEg+7Bhis');
clB64FileContent := concat(clB64FileContent, 'IWD81Tgp6UJ4L9KSgyMEg66iuJlQWmaCaPMMXWiK+c4vMFr63X+8p9KqlgTCjDqRmUyxaJaO8Pxz');
clB64FileContent := concat(clB64FileContent, 'nWpbmZn3rl9j0jLHkhSFaI4e53gaIwObynu+RFLm9lygMbNKnTEbTB+SlNOMdnMdTvgEx5psaM2j');
clB64FileContent := concat(clB64FileContent, '71B/rj6F0CuuNl9Xkttj1tDIIxOP6lfHmJxpZR7dDwmV0WLvZFJgq3RFRwb4gOpPJT7dUmayIdzp');
clB64FileContent := concat(clB64FileContent, '6hqYRCXjgg3vTld3+mbVyrJDlgjWC2BLo//ybXk9dBCyUcvA/43M6rJz7WOfOj2jvucUx5ekAA1S');
clB64FileContent := concat(clB64FileContent, 'TwtGb5W4xEVlvr+0I2OD8RlQZZonReRQ8VZG6UPj7v4wqiOvyiygj/T/pde/IzqzPmDH6ck9GqmR');
clB64FileContent := concat(clB64FileContent, '8Kt0tsWApv550gyfFZqh4DRV7OvdHPXm8M1+5XpwRV2BNQUmeVzsbxzrrqbj85IoX4eahc0A4M/r');
clB64FileContent := concat(clB64FileContent, 'Ibh25jTJrdbHY1TEc8+iK4s6HZeYEy1L5niJyEYaRRCjmriVnIIlWjPoT4zmnn4jF7TvDgMYZecp');
clB64FileContent := concat(clB64FileContent, '1S9sK9cg1XVZLzIzU+3mDpFHhqspDYXan0kVFHy3eNqJPhpULvpTsCmDcbGmOUM67UKB/Vi/LuBw');
clB64FileContent := concat(clB64FileContent, '88x5O9b9U4bL+Rx5NxTwmZRUrRdO3reaqIZPT40FBxFJzks8n6HtOilqiA5n5tWXnGLWL/EEF5n8');
clB64FileContent := concat(clB64FileContent, 'vq4xA/JxDGZYcwf+OQrB4wsfoF3TYR/RszrfcaBei4Skj7bIqZS5kTLnB8DDX0LlVVPasQxcNXOj');
clB64FileContent := concat(clB64FileContent, '80vzKQqXRYdL9thqOoedA2MkGKoikrGnsJ4UAbGj2iqjY7CFdG5qjUx1b7VzzwCSy1T5xfPl/4Lg');
clB64FileContent := concat(clB64FileContent, 'r+frZEw7FkZtNDH00RM9FjTbH2MIc74xLj/69M+gIHRaywIeyu1BhpmnAbLj7uXEb9IyNXrR8/Pv');
clB64FileContent := concat(clB64FileContent, '6EXG8mivzgzWnM86tft1noxUyN9dTHCdD7b6rY55jcGD1YPYKrFTRMxp9Z7xrXDcUoYdWKIxSJWf');
clB64FileContent := concat(clB64FileContent, 'ko1fL4dGtP7OsnWjgEdQ5wTLUa32/E8XyJ0RmFVBeNnnDXrcWRLw/Y9eyHjNix5tjRr7L8vRgek2');
clB64FileContent := concat(clB64FileContent, 'RLuOFLOrEZmXI2M1sb6FKPLN7Hg7B013dWvd8P+Z6/n/V6LlmtZj4D2e6PkuCBtQWa5rhSOsZTdl');
clB64FileContent := concat(clB64FileContent, 'oALZmpIAYXw1u8dFa7Ut2892YPRH5Q6ThVSdDlt9m1O0XahTteSaa7chQMMULiUPRBb7r+ajnCcP');
clB64FileContent := concat(clB64FileContent, 'bDpkvP4mp/o3kDdyYsXcW/U6hqCj7WlC4bOLTB1udvcTnFs0L+i/KaRbJgDhQR8Xii+7q9FPJrsd');
clB64FileContent := concat(clB64FileContent, 'Tw8D3AfxWa/P3CccKyQgqvEo8gABBAYAAQmNiQAHCwEAAiMDAQEFXQAAAQAEAwMBAwEADKAAoAAA');
clB64FileContent := concat(clB64FileContent, 'CAoB582ofQAABQERHQBMAEQAQwBMAE4ASwBGAEEAQwAuAGQAbABsAAAAFAoBAOviInOMetgBFQYB');
clB64FileContent := concat(clB64FileContent, 'AIAAAAAAAA==');
    

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
 nuIndexInternal := LDCLNKFAC_.tb2_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCLNKFAC_.tb2_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCLNKFAC_.tb2_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCLNKFAC_.tb2_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCLNKFAC_.tb2_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCLNKFAC_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCLNKFAC_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCLNKFAC_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCLNKFAC_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCLNKFAC_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCLNKFAC_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCLNKFAC_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCLNKFAC_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCLNKFAC_.tbUserException(nuIndex).user_id, LDCLNKFAC_.tbUserException(nuIndex).status , LDCLNKFAC_.tbUserException(nuIndex).usr_exc_type_id, LDCLNKFAC_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCLNKFAC_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCLNKFAC_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCLNKFAC_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCLNKFAC_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCLNKFAC_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCLNKFAC_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCLNKFAC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCLNKFAC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCLNKFAC_******************************'); end;
/

