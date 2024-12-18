BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('BSS_TARIFATRANSITOR_',
'CREATE OR REPLACE PACKAGE BSS_TARIFATRANSITOR_ IS ' || chr(10) ||
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
'    gi_assembly.assembly = ''BSS.TARIFATRANSITORIA'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''BSS.TARIFATRANSITORIA'' ' || chr(10) ||
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
'    gi_assembly.assembly = ''BSS.TARIFATRANSITORIA'' ' || chr(10) ||
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
'END BSS_TARIFATRANSITOR_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:BSS_TARIFATRANSITOR_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;
Open BSS_TARIFATRANSITOR_.cuRoleExecutables;
loop
 fetch BSS_TARIFATRANSITOR_.cuRoleExecutables INTO BSS_TARIFATRANSITOR_.rcRoleExecutables;
 exit when  BSS_TARIFATRANSITOR_.cuRoleExecutables%notfound;
 BSS_TARIFATRANSITOR_.tbRoleExecutables(nuIndex) := BSS_TARIFATRANSITOR_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close BSS_TARIFATRANSITOR_.cuRoleExecutables;
nuIndex := 0;
Open BSS_TARIFATRANSITOR_.cuUserExceptions ;
loop
 fetch BSS_TARIFATRANSITOR_.cuUserExceptions INTO  BSS_TARIFATRANSITOR_.rcUserExceptions;
 exit when BSS_TARIFATRANSITOR_.cuUserExceptions%notfound;
 BSS_TARIFATRANSITOR_.tbUserException(nuIndex):=BSS_TARIFATRANSITOR_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close BSS_TARIFATRANSITOR_.cuUserExceptions;
nuIndex := 0;
Open BSS_TARIFATRANSITOR_.cuExecEntities ;
loop
 fetch BSS_TARIFATRANSITOR_.cuExecEntities INTO  BSS_TARIFATRANSITOR_.rcExecEntities;
 exit when BSS_TARIFATRANSITOR_.cuExecEntities%notfound;
 BSS_TARIFATRANSITOR_.tbExecEntities(nuIndex):=BSS_TARIFATRANSITOR_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close BSS_TARIFATRANSITOR_.cuExecEntities;

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
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
    gi_assembly.assembly = 'BSS.TARIFATRANSITORIA'
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
    gi_assembly.assembly = 'BSS.TARIFATRANSITORIA'
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
    gi_assembly.assembly = 'BSS.TARIFATRANSITORIA'
);

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
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
FROM GI_COMPONENT WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='BSS.TARIFATRANSITORIA'));
nuIndex binary_integer;
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
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
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='BSS.TARIFATRANSITORIA')));

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='BSS.TARIFATRANSITORIA'))) AND ROLE_ID=1;

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
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
FROM SA_EXECUTABLE WHERE (CLASS_ID) in (SELECT CLASS_ID FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='BSS.TARIFATRANSITORIA'));
nuIndex binary_integer;
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
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
BSS_TARIFATRANSITOR_.blProcessStatus := false;
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
FROM GI_CLASS WHERE (ASSEMBLY_ID) in (SELECT ASSEMBLY_ID FROM GI_ASSEMBLY WHERE ASSEMBLY='BSS.TARIFATRANSITORIA');
nuIndex binary_integer;
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
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
BSS_TARIFATRANSITOR_.blProcessStatus := false;
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
FROM GI_ASSEMBLY WHERE ASSEMBLY='BSS.TARIFATRANSITORIA';
nuIndex binary_integer;
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
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
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;

BSS_TARIFATRANSITOR_.old_tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
BSS_TARIFATRANSITOR_.tb0_0(0):='Version=1.0.0.0,Culture=neutral,PublicKeyToken=null'
;
BSS_TARIFATRANSITOR_.old_tb0_1(0):='BSS.TARIFATRANSITORIA'
;
BSS_TARIFATRANSITOR_.tb0_1(0):='BSS.TARIFATRANSITORIA'
;
BSS_TARIFATRANSITOR_.old_tb0_2(0):=3980;
BSS_TARIFATRANSITOR_.tb0_2(0):=GI_BOASSEMBLY.FNUGETASSEMBLYID(BSS_TARIFATRANSITOR_.old_tb0_1(0), BSS_TARIFATRANSITOR_.old_tb0_0(0));
BSS_TARIFATRANSITOR_.tb0_2(0):=BSS_TARIFATRANSITOR_.tb0_2(0);
ut_trace.trace('Actualizar o insertar tabla: GI_ASSEMBLY fila (0)',1);
UPDATE GI_ASSEMBLY SET ASSEMBLY_INFO=BSS_TARIFATRANSITOR_.tb0_0(0),
ASSEMBLY=BSS_TARIFATRANSITOR_.tb0_1(0),
ASSEMBLY_ID=BSS_TARIFATRANSITOR_.tb0_2(0)
 WHERE ASSEMBLY_ID = BSS_TARIFATRANSITOR_.tb0_2(0);
if not (sql%found) then
INSERT INTO GI_ASSEMBLY(ASSEMBLY_INFO,ASSEMBLY,ASSEMBLY_ID) 
VALUES (BSS_TARIFATRANSITOR_.tb0_0(0),
BSS_TARIFATRANSITOR_.tb0_1(0),
BSS_TARIFATRANSITOR_.tb0_2(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;

BSS_TARIFATRANSITOR_.tb1_0(0):=BSS_TARIFATRANSITOR_.tb0_2(0);
BSS_TARIFATRANSITOR_.old_tb1_1(0):='callLDCSNATT'
;
BSS_TARIFATRANSITOR_.tb1_1(0):='callLDCSNATT'
;
BSS_TARIFATRANSITOR_.old_tb1_2(0):='BSS.TARIFATRANSITORIA'
;
BSS_TARIFATRANSITOR_.tb1_2(0):='BSS.TARIFATRANSITORIA'
;
BSS_TARIFATRANSITOR_.old_tb1_3(0):=11871;
BSS_TARIFATRANSITOR_.tb1_3(0):=GI_BOASSEMBLY.FNUGETCLASSID(BSS_TARIFATRANSITOR_.tb1_0(0), BSS_TARIFATRANSITOR_.old_tb1_1(0), BSS_TARIFATRANSITOR_.old_tb1_2(0));
BSS_TARIFATRANSITOR_.tb1_3(0):=BSS_TARIFATRANSITOR_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: GI_CLASS fila (0)',1);
UPDATE GI_CLASS SET ASSEMBLY_ID=BSS_TARIFATRANSITOR_.tb1_0(0),
TYPE_NAME=BSS_TARIFATRANSITOR_.tb1_1(0),
NAMESPACE=BSS_TARIFATRANSITOR_.tb1_2(0),
CLASS_ID=BSS_TARIFATRANSITOR_.tb1_3(0)
 WHERE CLASS_ID = BSS_TARIFATRANSITOR_.tb1_3(0);
if not (sql%found) then
INSERT INTO GI_CLASS(ASSEMBLY_ID,TYPE_NAME,NAMESPACE,CLASS_ID) 
VALUES (BSS_TARIFATRANSITOR_.tb1_0(0),
BSS_TARIFATRANSITOR_.tb1_1(0),
BSS_TARIFATRANSITOR_.tb1_2(0),
BSS_TARIFATRANSITOR_.tb1_3(0));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;

BSS_TARIFATRANSITOR_.old_tb2_0(0):='LDCSNATT'
;
BSS_TARIFATRANSITOR_.tb2_0(0):=UPPER(BSS_TARIFATRANSITOR_.old_tb2_0(0));
BSS_TARIFATRANSITOR_.old_tb2_1(0):=500000000015179;
BSS_TARIFATRANSITOR_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(BSS_TARIFATRANSITOR_.tb2_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
BSS_TARIFATRANSITOR_.tb2_1(0):=BSS_TARIFATRANSITOR_.tb2_1(0);
BSS_TARIFATRANSITOR_.tb2_2(0):=BSS_TARIFATRANSITOR_.tb1_3(0);
ut_trace.trace('Actualizar o insertar tabla: SA_EXECUTABLE fila (0)',1);
UPDATE SA_EXECUTABLE SET NAME=BSS_TARIFATRANSITOR_.tb2_0(0),
EXECUTABLE_ID=BSS_TARIFATRANSITOR_.tb2_1(0),
CLASS_ID=BSS_TARIFATRANSITOR_.tb2_2(0),
DESCRIPTION='Simulacion de Notas de Ajusta Tarifa Transitoria'
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
TIMES_EXECUTED=73,
EXEC_OWNER=null,
LAST_DATE_EXECUTED=to_date('16-12-2020 16:34:09','DD-MM-YYYY HH24:MI:SS')
 WHERE EXECUTABLE_ID = BSS_TARIFATRANSITOR_.tb2_1(0);
if not (sql%found) then
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,CLASS_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED) 
VALUES (BSS_TARIFATRANSITOR_.tb2_0(0),
BSS_TARIFATRANSITOR_.tb2_1(0),
BSS_TARIFATRANSITOR_.tb2_2(0),
'Simulacion de Notas de Ajusta Tarifa Transitoria'
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
73,
null,
to_date('16-12-2020 16:34:09','DD-MM-YYYY HH24:MI:SS'));
end if;

exception 
when dup_val_on_index then 
 return;
when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;

BSS_TARIFATRANSITOR_.old_tb3_0(0):=40009820;
BSS_TARIFATRANSITOR_.tb3_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
BSS_TARIFATRANSITOR_.tb3_0(0):=BSS_TARIFATRANSITOR_.tb3_0(0);
BSS_TARIFATRANSITOR_.tb3_1(0):=BSS_TARIFATRANSITOR_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (BSS_TARIFATRANSITOR_.tb3_0(0),
BSS_TARIFATRANSITOR_.tb3_1(0),
'LDCSNATT'
,
'Simulacion de Notas de Ajusta Tarifa Transitoria'
,
1,
1,
18,
5000,
'FormExecutable'
,
null);

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;

BSS_TARIFATRANSITOR_.tb4_0(0):=1;
BSS_TARIFATRANSITOR_.tb4_1(0):=BSS_TARIFATRANSITOR_.tb2_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (BSS_TARIFATRANSITOR_.tb4_0(0),
BSS_TARIFATRANSITOR_.tb4_1(0));

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
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

    sbDistFileId        := 'BSS.TARIFATRANSITORIA';
    sbDescription       := 'BSS.TARIFATRANSITORIA.dll';
    sbFileVersion       := '1.0.0.0';
    sbFileName          := 'BSS.TARIFATRANSITORIA.zip';
    sbMD5               := 'b4ae796caf49b977d9e49b819f423095';
    nuDistriGroupId     := 4;

clB64FileContent := concat(clB64FileContent, 'N3q8ryccAANDVJACpCYAAAAAAAB/AAAAAAAAAGLQmR0AJpaOcAAX9+wFu+r0/5QBL0TuTr0I2yvx');
clB64FileContent := concat(clB64FileContent, 'U9Plq7xO/c6hY0BIQykUfFcxmm1nJkkaGBLomg0YBj0sy/fHRpK4HzK+n2a7pvMs7BoPjYRR4KMd');
clB64FileContent := concat(clB64FileContent, 'xlRcAmPnIxsuvMmUyo3+xIUE3NicqBJdMqw/b/1yWS0/+OXTMq1TJbP0TTB4A8rZVam2CjjPZ84l');
clB64FileContent := concat(clB64FileContent, 'LMc9WtdbetvKILc2WU2gdWxnUMmvDvepTkrWLoWQ87UX6SADlBPTJD+CrSh2gngcpDu4hm4LZX6E');
clB64FileContent := concat(clB64FileContent, 'AAhZ1st4LBNPBk/dshc7vpqyHAC33apTbZ862e0/8l3G34NqTQ7/VA4czQWnhqfbkV7tB86M2+S2');
clB64FileContent := concat(clB64FileContent, 'kLgYLIskDIzGB7bO+ZCFRebTtC2jdlkP+A/krr/k0r0fEc43XhiADjjEAlK/8pdamw8c2zO9AO8X');
clB64FileContent := concat(clB64FileContent, 'SYZmY7tXRE4jqzJHzCopFJqG+8yADNTIrAdkKCGXg36cf6c7TSsL8A7rljz3T6YhEqPhxdQ2yN6d');
clB64FileContent := concat(clB64FileContent, 'YbapzkGQeEcuESFhQi9C2Nrno5YfQOkNg9nSNZQ0aAzFQ3XwshYDBYixfw7Ndyg+1M0P62li9pwt');
clB64FileContent := concat(clB64FileContent, '2Ht9RE7ICOkSklptxwWM4gqyRzxMa/88XhNN7qeGpQzsh1ZmbewMx5uWBTip2E/srjsIYYvABrKR');
clB64FileContent := concat(clB64FileContent, '5rc1ozUrjBOSX+CdkCA71PftgvTHDzae3NO1/Iz0uw1mpIjqYqTIuCfAQiyNBYM6mlXBF5nXnuFu');
clB64FileContent := concat(clB64FileContent, '4yIg8/4SwPlCnueaBow9vgdf/bEGIgcFne0VLRxl5IqtN6i1ZkmonFUB5o6HO3kUZwUF/D6hjiZp');
clB64FileContent := concat(clB64FileContent, 'MeactGAAbizDWnjIGqWykpJ5YfPYW45k2j69W28cn77qvOsh2RG0ZMxdSH8uhgsHVQR6jxsS0+9Z');
clB64FileContent := concat(clB64FileContent, 'YJTqY4miEKPJAroFMDMmVLC7L+R54+i7Y/dJOwSSAEm79rBzMylJUCldqc13h0tF8gtuIlIR7eMe');
clB64FileContent := concat(clB64FileContent, 'OM1nX9Lu56Pi0SOAvDaCtegFmHPPwMjSXVa0HhisTw+TT/Qy3GIl6tI5dlYtANz6okfa+caziMBB');
clB64FileContent := concat(clB64FileContent, 'mgmNSpJnI1TkDxuwFzQZUThkjnh+DvlVZYm2Zyp9RIfUOG5MDVW+P2r/9g/AixUY2fj+U9wzAB6h');
clB64FileContent := concat(clB64FileContent, '9gKC4EeAUY51M4aoq6wTymqPgz/kEjNHcojeCz9p7V9yym3fLg415Bbij821ZvNss1bxvp0jJUJ0');
clB64FileContent := concat(clB64FileContent, '6qBEhLLTBM9esUakeYxsYZmqKhUJkNXOnSaZfzJhV7jdWRN5555UMMVw+DmWwXg9q1chYYjzPSXC');
clB64FileContent := concat(clB64FileContent, 'HEhfKrVe2zFdy/WQJcio6EBXdsRdWPNLYZzJqO1l9LyK5+XcsV6vvPG/91DRGL03VdNhLk6bkOGF');
clB64FileContent := concat(clB64FileContent, 'SQfjIq+5KlqpxXyeMdOXfiJx7jcwrs120Avzgaz+Xnf2UAGszl/NEoXZ1Mnm4g3SR77jksNmMB0Z');
clB64FileContent := concat(clB64FileContent, 'PwjgYuB6R4LyKJjBtu+wBzYeoYvvUwMYmjPAgrhF+rFLzKIee9hReOgZTI6vfhVkr/eJ7/kjgUiZ');
clB64FileContent := concat(clB64FileContent, 'vJVpks7MVSxfXVe2mzADbqnDCaPH+tlXOoZSeDwbUquBZmBMzw/w/QGJn/D7MpXtKFLpzucvDtl8');
clB64FileContent := concat(clB64FileContent, '4vES+ogXprKDelYpNQzjxIWDcbruADDl5kK72YHlaIv/94A8zmdgmJlb0C/NFooB8FQUeUXyRQSt');
clB64FileContent := concat(clB64FileContent, 'jxc1ncLgd8j4s93FoUMCVt0h8Ip8/ojNPMTde1nUokiy1WQpGfBfZ+rQYUw9u11/U6cvr4DIbe5s');
clB64FileContent := concat(clB64FileContent, 'wUgJOh+FwM7T2UkkBJgHsy0T443SfgHMdMq/m1xqMlMUitcEScg4xiggc4PaDICs+DFbzZWZ3qoK');
clB64FileContent := concat(clB64FileContent, 'pEeMnn2V7EBh6S5bXJBDb5/XSxfmdfYkb7SZ3BYjVsGsR4O9yoZz//lVCi4jaDJcesVVdBVN0vyT');
clB64FileContent := concat(clB64FileContent, 'c5+Xma5kPBOp7sFGgrrS0LYrNafBg5hwegjS7crTiuqzKEATynycXLPf2uq7kPsbtLghRMarQ7OK');
clB64FileContent := concat(clB64FileContent, 'hHph5LSoDUHeknMWmhwXhFxc9Q+Afmag/180FVn9RhWPqr3+CCs7zDT8XwBybiSTRuvHMDs/Np6t');
clB64FileContent := concat(clB64FileContent, 'epk33Pfb0HxLUvNGUeW/z/4c7XkX6QOjtitkHeA6i2EViVm90XdhwxlV44bWRifrkHznsXchLxgO');
clB64FileContent := concat(clB64FileContent, 'XCPgz2kF72FnWoqXf26rYSWfqiQzqPQgwy9mkh0QQLt0oxaJdWNrUS6C0YFIOpT9xXWDvOrf5Dpg');
clB64FileContent := concat(clB64FileContent, 'Te5BU834gWli2+p7Vj1gsSPVL5xqP15bHQS0ewmDEQ2x29j9gdmKGSl7lwIh741UEfadZm8IyclQ');
clB64FileContent := concat(clB64FileContent, 'Dy+9Mih7M+rHIjkPmixCOvkov/BMSVnmuuOPyFQcL3j48rOTVXaOs3kY9SU0gMyvOX4t41ZAAba8');
clB64FileContent := concat(clB64FileContent, '0rAvz6q18zBLwbtXJeLq+8uhnV6l8jRaxFe1tlLc/WPbBJihgMc97JkLLTq4qFEzMnT/qnwInTaz');
clB64FileContent := concat(clB64FileContent, 'g2CLxeZ03dxjIIriD3mzms9bZfx8b4TS4DQ0sFgJNFhfJF3iJUgMWlGK1mmxyn7jn/GQhkTuaT4x');
clB64FileContent := concat(clB64FileContent, 'Wr+DXgfjFeIqL79w0hpMvUodr45aRmVGtZiRYT3RB1rAw14etPQHKnNUKhMC8FFdpp4/K4hpTRZa');
clB64FileContent := concat(clB64FileContent, 'LPqefWVLHVkcvoQtOnSco9vZACZYHO3ANLDDknc9cHApdAV8MoPYkO1+spgkjv1OvZx4/arnK9c+');
clB64FileContent := concat(clB64FileContent, 'dgHHbt5nLvBrkQlf7gIkFpZStyyy6xqlO+5HvhdwzM10cVJcvjouBbzrX/KRGy60H7/5FY4tWGu3');
clB64FileContent := concat(clB64FileContent, 'lCi8s7DOVifcOmuGB0zy3Tjn5verVBAJEDS+KZyUaYpRwkTSQVYGB1hJsORISf8BvAvEXGfm7mwT');
clB64FileContent := concat(clB64FileContent, 'aGJgejqMpvmdIZm9d2BLxmr2Jx0QO4OORZDgH8cLdghM5pzdekN9XIcgbp9QBOLcRD1BKGTSVO53');
clB64FileContent := concat(clB64FileContent, '1dauxkuhXAbGxcjPHShWkDmdlBfv9IbAIMAbetRT0s9RkKomQWLfdgQxJy+qTWsfVsrED4QDR/pm');
clB64FileContent := concat(clB64FileContent, 'ZAMuii3Fg5CbUZJ1j5/lgMN5mScIcBnUuZ5KvWBq4Arv5Y7ZSjnVY2Vw2RpEyaU1IF2+Eta/M8hN');
clB64FileContent := concat(clB64FileContent, 'q9ZgAf/oGMQnG3U05JjIghe7krw7X6COrGzUojeHVt6b5rFxYBcYz4R1XycbPso+cpvtTy0lIXg3');
clB64FileContent := concat(clB64FileContent, '1VDSmL9QyeDcPrwJ5jdSySG0jzrosw6p6tPlZe1kPuJVYTiS8UP14NQkPi2HTPaIWdtCZEnlJVQP');
clB64FileContent := concat(clB64FileContent, '4JP7zTIRCg0C9Rvj349NoQA0RSf0+1P3ka9ehtf9QpEXZVTG89j1zGgOb/mac3X0v+Hf6H/dSNHv');
clB64FileContent := concat(clB64FileContent, 'SXWBqbaoXDgnpUcCKoWpfSRnI0UdsM9H/7mLhPsfluGfe2m+oLLPV8Mi6ntjtjD6fcBotoYjpclK');
clB64FileContent := concat(clB64FileContent, '/v8VGaRINR5o1uiZ91DTyS4Fh7nkQ+7uWLTFiKkWz8uVbgx7s+T07XjhAuwSshMVo/I6/moyJ/qE');
clB64FileContent := concat(clB64FileContent, '8aQHh8dMEO+AAHmDOqU5ySSIQRmKAiWIXc+fxis7XyQb4l+AfRDyuQWAxpoZ156npAd4ZwIb00Cw');
clB64FileContent := concat(clB64FileContent, '9bCPvpef7nv0LD0iRce3E5ufZhKwO52kpVdWEKrEYFTC1DLeWFXP7vRViQ7aJesZku9a5P6tMhMd');
clB64FileContent := concat(clB64FileContent, 'iLQIoR2pa6fgJ+UM6AvX6+1gmJ34FNd4SS2tDx24YV00QbMt5udxMvj11OxjZlh0BpTpohLobMX2');
clB64FileContent := concat(clB64FileContent, 'I1ZIPYimgx1gVBVBlf+YI1Z9pE+vdpnuX3G7zsZUh1YQ81uDJzHLeu+aldo1dWheo3pc6ApjZMhL');
clB64FileContent := concat(clB64FileContent, 'mG0DDdWmTDs4hAluJKURxlKaoUG8ioQdXT1uiirlp4cWPfDKHfD1O0SUlFaDD2PAteXsXSpXyMI2');
clB64FileContent := concat(clB64FileContent, 'Bi4IBsi5yctqgxTd9kJmbBaWrCrhm40HZ7bbpvLPOEe087bOhPxTf/npniL96g0YDqDj7BriexAH');
clB64FileContent := concat(clB64FileContent, '3PtaZ9jBxrR8t95yMc8lNLxQ06SasdL/ujFQ+zN1GqrKlixdek6a2lHyqvTh/7uD+2Xzx7Klb1En');
clB64FileContent := concat(clB64FileContent, 'Tzw/wLRH8O4Iw3iEBq38IZsW+5lH+OjeC8ay5tCcFMH0Md8DOQtQAXb770+AK9pBiPBh61D9pR9u');
clB64FileContent := concat(clB64FileContent, 'UKCcSeonsu4rZgn7/ujweDbog+wyKgRMOBz2La2Z1IbMemty8tHTAiXeQ8tDv5yvx76kFZJg2hML');
clB64FileContent := concat(clB64FileContent, '38IZKR1Tggv05hdV1nD6T1+rsPysT3Ev+KDQ3+ubSdNaHnzHJa4bj+9GYyB3Cx1BezHPRRkcdQAB');
clB64FileContent := concat(clB64FileContent, 'kY6N5CwTFGepXv2uviZnKyM2B82t2xoCvWJdDLT9+XOpVINb4Itr152bsQNCekmQjszTSDsYaKUg');
clB64FileContent := concat(clB64FileContent, 'kr7YlOcKR3TWYQgCuNYSVz7FfhQ6d0YdqJW8ghRCz2pN7N84o7QkHtC0E6hSuGdWcCB/Nbl6kPRv');
clB64FileContent := concat(clB64FileContent, 'hNvGZOYQIn8XMOKVoRmTGogNmJKbGK07gPwCM4Cv4atCKPubQjl99z+1Bh+zyjn43yh93GJiFJAb');
clB64FileContent := concat(clB64FileContent, 'q0p+uOHt0mZKsMfLtOOsvM5y0UcsW2mr+HPinT7h4/aWiDVW9E+HremlL+N1aRRN1UlCsRag6amp');
clB64FileContent := concat(clB64FileContent, 'xnxN3bKu8ZGsZdYUSTOJIzp6B84TPDmcrkj3G94LRRcoo444n/sFZJjvOkwwG6ErVALlrd9T0ZvN');
clB64FileContent := concat(clB64FileContent, 'BxmQcPX9d/4/i28lhWuV01UdQ4lFQxZT0j5wpISRHuouoDIWOsp30mzhvp5aleTWst7li+KRyAIi');
clB64FileContent := concat(clB64FileContent, 'YYc6+RqGRp43+kwbGh70LWD0JY+dQER0YDefS6BHSLx3Hn/rVZSdQRsDwuue3eNmKfeFj3irrmcd');
clB64FileContent := concat(clB64FileContent, 'ywyyVmtqCcXGnLTddX0g1DJ3/B6+XADdWYnOmI5HIHN4epulZRgO6QG0F78qWsHir3/PGmhpn0ly');
clB64FileContent := concat(clB64FileContent, 'FOi2knxgXiW+P+ybklihVkMkxSIaDL3/UkMMRj5jUVFmFhcpO6VcRDCNG8icX14lu2qC2UvaC0Ub');
clB64FileContent := concat(clB64FileContent, 'Sh40Agrnebtx0xIWawzYzAJKypnEwX0m5zz/ASd2SH9xPqfaNXF/TUJNrLT0/cuQ+uC9EBzDv+cr');
clB64FileContent := concat(clB64FileContent, 'iyMauxT3PML5MTgCo+5Zr43cPGRnLfa3VRKFMhvvzkDkU7jkoXKOIsLGicq1ouZ0UgK4wBOEA3b6');
clB64FileContent := concat(clB64FileContent, 'BsFtQdHLVq7COGXHdGlRCl5BoxkhDVaM5TaT13p9nLu1qvTzOxq4MN/HYhp13lzWSxZdJLMPikzD');
clB64FileContent := concat(clB64FileContent, '/ylqtPvboIf97Oks24zrFDrCZHs43eXL8aR/fLsDQQBd0pXZVo73eG7hmDlnO9xqP03y3DYXwcNx');
clB64FileContent := concat(clB64FileContent, 'Sjj8054eGufBI5GbO4HffSstJxVUocIcjUjmEgfEuv+K2kacjyEOT4LE2SirigBWC/bU6vCLW5ep');
clB64FileContent := concat(clB64FileContent, 'wmM+D23jy0etSt01h4ZHjyzlnZlldansnuZC3IF10cqrIQpME7TVqekDmN+lNTCxu66w7rEg878r');
clB64FileContent := concat(clB64FileContent, 'TsJoAdD95WhIE48RF+gcZGgh6BHd6BrC8lt1QXxeUlypqfCY3aV+oWYujnuo87R9lGBry/1p2F+I');
clB64FileContent := concat(clB64FileContent, 'd96KqR0TLWSSvGRqWyJTXvO6ys0P2oFEniw6/1O+UZffUTjg5R5XzvGtqHQ2wMevEnWndg/kxws/');
clB64FileContent := concat(clB64FileContent, 'FIFdXwpFkFa41PJ7As3GPnSpwCcElNGo1uUINp+LxaoCMrwOqtNRDeHr+E7bGiN9YYoqjVvhxhwJ');
clB64FileContent := concat(clB64FileContent, 'k+VdVVFp64UmaI+Cz4C9SeZausIePM4oFoJDJAoJ1o+FLXmsNO0dmDy4zbzY0mgjDXfFnbRflZjr');
clB64FileContent := concat(clB64FileContent, 'LKnW18vLgtF8WomqEaSz11JSqOzI/fAJEh57Nxa9vgm9zHLoftrztGv2xp3PfxeG1xzcNmBA7fVa');
clB64FileContent := concat(clB64FileContent, 'YntvRtMPFGBrIhdwHvMnCeB/CnPvl8Sr23tp7v4D5lrFpTDImJJwrx77kVm+FKSEnXo14i/eUc9o');
clB64FileContent := concat(clB64FileContent, 'pQlhwRbqkeCxshkvhVLO3A3an4f7Fh3sijT/LQYnxqG/Cay7F5atb2HXi3QZN7hD/i2V/cFIGVNk');
clB64FileContent := concat(clB64FileContent, 'c/tBCQEfqVa5X1GIUiozXJVVI3MQnvMu1K7mM7luTen+fkEGmKsJGol65L/lPH/WuoXF3PqrdDig');
clB64FileContent := concat(clB64FileContent, 'auAMk72aaEerLcROP5Yn7iaf+Ap7gYyu3jEiOQHrzY0q1Xu9ta6VNXkPMW//Hy3EtAEp+wHn/zQ1');
clB64FileContent := concat(clB64FileContent, 'RwwQcNNk9iPZANwBW2vulLHzZgtc9nSUAveBqhPl4CXSQIEFmhrZw+CsdWQUvQ09h1CsnIq6l4S/');
clB64FileContent := concat(clB64FileContent, 'YRROlv/Z3IR8iH0W7bhRG9GsD4ZmG6azOg3C2HCMQE/oVLRPP6xI7GvrAwQISI8DyrPT3QPjJ4Mz');
clB64FileContent := concat(clB64FileContent, 'fyiuUO7c6+W9n15z1CdnNIh5R6KXcCz8zGkgzq9yQgeBYvAFPG+o9uKNTLD5DVQAkN7DQadrLSZG');
clB64FileContent := concat(clB64FileContent, '2tE1NhXtRfqECyFAib8SVIp6GpE+u9ivF0XCUtMqkF1xCgas9JK7CSdDbtBPCfGBm8fqipt53VGU');
clB64FileContent := concat(clB64FileContent, 'HkVt/MatvhpS2Vq4osEcqOnrGa8OkAjiicHm9RN/xjnXSjJ3pIArciybogNjZB1H9OHOVZbeGcve');
clB64FileContent := concat(clB64FileContent, 'XssPKrYnszma8f/GSJzUo7NXtAVQJsX7CGTRxv6caLZGYT+L73TIhZH8mRBhsgYFl6xa7YR1uIaw');
clB64FileContent := concat(clB64FileContent, 's8KxRbi+RMGwioh7/N4/2gZU0Cq88mngOGtZMCKIJNqPqjVdZPVMp7MAXdcE1KPjqX1YdvU25s+h');
clB64FileContent := concat(clB64FileContent, 'mfz0dahQnwTIeFk6k8g+5+VYvmtVgE8/+kZPzIMpbJHZav28c/Nvg2fksiZQQakC+8Gci4AlAbPL');
clB64FileContent := concat(clB64FileContent, 'DfpL58Wuo//cwEcJA6lohNtJlCgT53hPcP3dQ2rFmcmIG39lfXNnlqfjhO9yM7Nmkk4FcOi1JHLP');
clB64FileContent := concat(clB64FileContent, 'JpEcyx8O/Pzonwprief+i00fhgvKkLKj5Voi1Kj7ET05PtQAyinlsHoNwS3SxMSuqDVZEE1xY8Jr');
clB64FileContent := concat(clB64FileContent, 'kjAomO9IW/793gWGTeePWE9CnKDjB0PF0o28YACuqog/2+zvGiVXUcgfcrU07HaH05K8ctznItXt');
clB64FileContent := concat(clB64FileContent, 'JXpBiaG7W3RF0u2ZbGlKX5iY4Z3/l9ysL+MBqm0Ve+eLl5vwUf8piNrMkYhDgmenhq8fjiLGZT9G');
clB64FileContent := concat(clB64FileContent, 'bktz9TN+JDJRIPbctYbCFvdkG3mS77zcj3tRk4zMtcPTF+tXAr95w8ffAu/twKGJ0v7DD6dMZZ0F');
clB64FileContent := concat(clB64FileContent, 'W4WeLLA5pUYgRhXOFtP48MDjmgMYXf9ew6+PnQus/96iegwdyJ/sopA0dfa+sAEVbsdktEXZtA6d');
clB64FileContent := concat(clB64FileContent, 'TDhmA7RJPXiGJ29pNzxDKmfCd/PwCkOm5loD2pN9Z01dYC0/rcEP5B8hzB2HFDP0lUL5UHgxMA36');
clB64FileContent := concat(clB64FileContent, 'b5gbvoiXjIsuiOs3L7+8i2g47iHy2S0kf0NJSK95OQd0wMn2ETS5Ksd2lDJ1KlHK4+W5Ofaqq8My');
clB64FileContent := concat(clB64FileContent, 'vGazGTxJCWJX35PHFZC2ZA25dA9tR3xJ0ouSHC8FXDWq9L0hadWcRy6aVfSYcbfNtfz+EeyVYkgm');
clB64FileContent := concat(clB64FileContent, 'kAs+KD97CDZiEHte3WZf6SyMgsxPP17FxQ1tQCrn651EyGS0YMnR4xFUMUc6SiMUkZ0gRmXpo8q0');
clB64FileContent := concat(clB64FileContent, 'hJIyOWfYqfQ5Hlc5QREkDLbXj13ox/RfT64cArBa4Jbj9dyMa6OqkXbHqVjRIp786A3mflJ+iXKo');
clB64FileContent := concat(clB64FileContent, 'b8HFPwGfg8AktKNYV49g800/NR/sG2Z+gloVbJeMW4lfoynQoLbdTDXiycp4MfKTUtiL+AW53IFF');
clB64FileContent := concat(clB64FileContent, 'YZcmhvo0wd8KeduXMYBLTmo/YicI+9Lge495jX1vBOpxD1M6H3Z+FWOd+6kKv+xkP4UZ7wNSs22D');
clB64FileContent := concat(clB64FileContent, 'nkonvjD1XPsPJkNzw6xIZ0jUqGCrgAt8WPPSXNU1oIcm6GkVV0UjZyJs8DQiBI2H82EJfG06yIY1');
clB64FileContent := concat(clB64FileContent, 'nquIXg0R0CAr2mSHQJ6Kh5V+TjC2MLcAF4zfNNuB9/3fHW721BiW8ONV1zc8Mf8Y0bBwsuyDyRCi');
clB64FileContent := concat(clB64FileContent, '85Ih/bcmshTIKWNw231kGM/28RTZD/pxE5N5Z6u9cVnNSLd1wqbQ926dw6qG7uN8sTLmVnR29jVJ');
clB64FileContent := concat(clB64FileContent, '1bdZWMUaRxQ5ppIQKy+iMYUjfEFeQZhswTtmpnQifdRTpv1J42b5JR26KHD2490EN7rtxtvnkvLj');
clB64FileContent := concat(clB64FileContent, 'G2W//t3YmPSUYhecVcq1CRHplI5zk5Qbgztvi+CIEW6sdL+4nQyVQXcFpH+Z7zR2bT8ZgjrTj8Oc');
clB64FileContent := concat(clB64FileContent, 'y1aCTAHCPzpbQ82kqE/8PCkLyJcUQJDelKNQavgEahLBQQhnRnRQmfoucVuYJqYKTfzqvGh+iAlK');
clB64FileContent := concat(clB64FileContent, 'XD9XfBpnFjZqdIROomJZi3A5IZ26s0Hs7q/D5Ly0rSIbl+IEOgpFGzUboPZ1weFMmwjULYbxwfQY');
clB64FileContent := concat(clB64FileContent, 'K6Uk/rF8/IGxbJK4GIj+QpcWbtqEeNr5EB9jnC0+n3ep+DsMl/7KDDOr2Qr+57gw9CJJlv+DnFgu');
clB64FileContent := concat(clB64FileContent, 'izWd/ZguRE1iZCCzanic189zfC01wACViFT6a4XzmCHxXgaEMnD5gRE7q/RNzph/NxUeO/womLBw');
clB64FileContent := concat(clB64FileContent, 'p1JacoRX/zfpUvcSsPxTmaCYWgefG8INxTtrO0QTg6ASoF/eOfZ1LrswF2HaUynVJiHHzJMNFWyn');
clB64FileContent := concat(clB64FileContent, 'CQfmkfJ48aGG2XhuMeJ/9tmPDP80CbJXRTWjyl2yXMHIZkWHdtM+cHAKD/iGtEnlBOSFdc4ybGky');
clB64FileContent := concat(clB64FileContent, '9BjbNlo6PjaPSa/Q57z4KMYbgeLSswEhGyKNk3q2GDx+HbKK46qMg/vgdfoKtiMRUhxbPz8R3C32');
clB64FileContent := concat(clB64FileContent, 'tv6cQY0wRJxiWZbV69AHMxTRjLcILqTvcawrBt+hndfkluClPWqC3q8mbKugQOiQunNtbTq9f0dU');
clB64FileContent := concat(clB64FileContent, 'EftzmZLOMKSjNqxFsKOAxLQnzpBRXds1LZJ4fF4866ojpQXzoRMqd03RVs5rjjZk1AdGhklnyDAQ');
clB64FileContent := concat(clB64FileContent, 'GpNv784/43CoU8rGzjDwDK60HSCUZBRIcRnw0mT0o2sYfQWHE9eKCEVb/ADvpr+BbCXeriDM/3uk');
clB64FileContent := concat(clB64FileContent, 'a2ZxUNHnGUU+tbkUywimzSptb59yPynxd+MTCrKdXljKlI4I+CrpWM7IcI3eU2/j8DxVZSS/ercx');
clB64FileContent := concat(clB64FileContent, 'LcgJwYPrCyYg94CFybW1/qN6sdnWrGSOf7aPcYbrPLcd5Dvovsel6gAyj+E2gsNGH5L3kAiV20+h');
clB64FileContent := concat(clB64FileContent, 'DH6MfHMrutbc/EjKyiFhfxHo/EPr8dKwseDjZN8tvQ0qFL6Y/mc199M2PcOSLvQzacN6itSwwiau');
clB64FileContent := concat(clB64FileContent, 'KQ8sGPKoMGpQCy1GuM2CJz91LZs5vL0zUq6Q2qDxaB3DRj86EcDubfzVj+ViI1U2R4SA58tZiNiC');
clB64FileContent := concat(clB64FileContent, 'gliHdzgUz87uos6tcDd4VJM/1ZZQ58E7EvdVSkxatAK2GkIashx3AFKaNuyU3A3PpT6dft/8w1R3');
clB64FileContent := concat(clB64FileContent, 'P+/slsDWTbHdiEkpzAom+/GJ+KPBA0VZBiOX8JvsOgcDUPJT9VMlwwJcX0XjFel6rhwYeSN9AEeJ');
clB64FileContent := concat(clB64FileContent, '7zm3DPISj34x/fFvGTKUjqd6uMbCG2rtudEVNgyZ2Vd44Lb02EVbi/nqFOisI6VmqtXHApVOp6ZG');
clB64FileContent := concat(clB64FileContent, 'UmgojrRSMn48nrsA8wlqnem/qGjC0mlQxfy/2m3vzA63Z1Idq5tou/WoUIhCp20thP+QJkgnfb95');
clB64FileContent := concat(clB64FileContent, 'RIVrA2AgHCyl1VcBtckLp2UCcnLa9CUn4VrvaH7BPjkiB+yxmP3/RGGUWTe+w2JXnsMTSkML1gSV');
clB64FileContent := concat(clB64FileContent, '0Wpij+BX5ECv0aLdpl26GEL7NibMU0psdGPDM9FrZOlyvgwaCx6cLx9KYyAgQdUsqLuUAEGLxI5C');
clB64FileContent := concat(clB64FileContent, 'C9udj3I8hfj0M0kmyXBZd6gZV19ntiTrD8esdybji2ahUF1F5nXlQo8H0xem1p7jPhGNu09GpcBp');
clB64FileContent := concat(clB64FileContent, 'pOeJ9HhqWaUZIZR1GI/R2amOaGWcP6DuniMdfmo8zIDJs3baPWY/5V3TelJicDmdhuZtmt3obY4T');
clB64FileContent := concat(clB64FileContent, 'EZ9K+5hu74QvyBFrMFU2vR2p9Cmvhi10JILSsbXu2IPxmAEqxzZj1lBIyg8QB7zP2rBSu6Ot/q0p');
clB64FileContent := concat(clB64FileContent, 'egyocHUdTKf3mMtSojP5VduTIP9UPkofLs9/GL/YWuTtsErMvFa7XN1NnBX6RJmNxpNQ/mYM3Xg2');
clB64FileContent := concat(clB64FileContent, 'aBTLwTvxBq2a6NGFNEdWU4vV/uV883NCjfKIZ2lxdToV9kLW4z+svuQxNXak1CXBEo9Bx5t9qcpp');
clB64FileContent := concat(clB64FileContent, 'pS0kyurEJFcawXeqqeH3u4eOBmLUTsXdEQuJuS/ssHS3QUw8I4sxy+b9JK5T+DEEI8K2/7t+oa4l');
clB64FileContent := concat(clB64FileContent, 'cih4MuGqUgminIIaR6lnDqW/VLI0hCnzqFxmO+5NBhnfw5jeR4bwk9f5ye8ocq1CsO9bmNqxWZ6/');
clB64FileContent := concat(clB64FileContent, 'idIyefUwAqFFnyiac7sKK7ufygUSKXb0ziFueA3z3/GyPDim68u06z9ykDRBex4B3TGbXcUlsfpE');
clB64FileContent := concat(clB64FileContent, 'SHxSnD4laqFVdkPTSLfZP/WjH/UH6SvkudIwEFEmpSxOU/iIZXG+mu71w60eTgZxKORsd7nFJ09N');
clB64FileContent := concat(clB64FileContent, 'gxk1YpdF39MOl9JBdRDpJOVs1/ahDBThV1yABOaTzlWCt66uMGsvNlDn/DQSyd0pCSsHp7AbwsgA');
clB64FileContent := concat(clB64FileContent, 'pcUmDhDajXpiL9SfWK1U44L6SsSCYRMidu8kQupWril+9RgG5PRzaGHdDW1saATXYPEG+jesPszI');
clB64FileContent := concat(clB64FileContent, 'aVvguh3XXEc4Hi6pvRUoXPDmidJHlPqjXB1kG6gUlBC7gflREcZgdKXU/hFMgzvL08a5fQdG1Hb4');
clB64FileContent := concat(clB64FileContent, 'TFtpM8y8t1qauz2driwxKaDZG4ORU/gOTd10ZOtVOEx06HL8/Ds8GPbPThfa4AxpEnPHQHbuXPjq');
clB64FileContent := concat(clB64FileContent, '3eZUyRL+Y4H06w0pI8xBw5hcrnSd9yvkeU18r1ojxly1z3rvTE08HpfCubHT6UQssbjjYFzD87xD');
clB64FileContent := concat(clB64FileContent, 'KaaUg3pn+qNMM+tfAlTfEzzL1Y2s4ybsLUfLTeEgBr+guNxeXCuqZ176G66RQHA2PcM9U7SKQiv9');
clB64FileContent := concat(clB64FileContent, 'MM3bFKiER1LFjylkkXh7qaaE39FPLEXGG2wK+wOfYPoaoJShAtzCmzQ2NDqJc2PHxJ4svWLoH9Iz');
clB64FileContent := concat(clB64FileContent, 'bmQ1Vxgq8xkM+WxRABND3klgqnvtm3w5Uls0bPAcIl4sR0BLcfZYFpBoGHt7R9VCPaviDHCu5+m4');
clB64FileContent := concat(clB64FileContent, 'il5gzW/n0mAiEB+xHz8cc4i7czRtHJi08sGmpegVeXd6nR8jgHDefUFt4Ldlri1C7J0cfnfhvcOj');
clB64FileContent := concat(clB64FileContent, 'dF6E0GkzqwswpqgMezOWZ+lAmhXxxqSniBh3bQWsqSclSDR3IbZo6wOyaL72B3/sh636hv19KncJ');
clB64FileContent := concat(clB64FileContent, 'NsJ3M93WWW36WzVBn9Y4ErKuwvmMdif5CPEaKNhEV3YkD09xrK0xYdY/lXtwVXowoiXYi6RhpGNt');
clB64FileContent := concat(clB64FileContent, 'W5JoGIubNNOjJSkrRQ2qLuCtXxgRRtgKetZBWjhvhdHzbi1eLnIQysAubKgC5rBB2hWW2+19lOyR');
clB64FileContent := concat(clB64FileContent, 'gLJJ2JUmFtsi5YCS4CiY+Z+lKLQJhcX8qUecXxozBhFcKJttU4KSjKysLEUwiI+hkfrU2QiLInJt');
clB64FileContent := concat(clB64FileContent, 'TLd4I4TRS7MTqYvJRE+Izs3OtVd7azbF12+TSwsT3K4RgsvMiokyHHErAvHPPsLGgdEEPyDzl/es');
clB64FileContent := concat(clB64FileContent, 'HlX8cysrgwUiLtsGG3X79BWdsvCemXoRiAyIGfbQt/NFKxn6dqJMDoBAG32VIyaw016n3kQmYPtM');
clB64FileContent := concat(clB64FileContent, 'HH9b2BZmMjPwpDsXMKUAMlmxsVlIUl1NmeVrqMuq5BONC09bEBj4S4yj8W1lDr2DP/uuoA9/gnPG');
clB64FileContent := concat(clB64FileContent, 'j4+nCqyMwkt0Jot2ekAnC2YpATPjv4e2/Bxvo+jjvM4uRR+QLgtadXKUaHVuRlDrRiTsAG38a08M');
clB64FileContent := concat(clB64FileContent, 'dza0CZQvERkfr02BJ/ZpHoC4kcbGTBelbGAYfuLPfokAcC2VgAnBOVB5v8ehIH+ijYbla8Rtm/kL');
clB64FileContent := concat(clB64FileContent, 'vQ57hvDwW1jYzggWY5DcRurADIkHP/ic9EYAN3bbYnzvfCkhb9QRBHVaZ7oVypXP/Ic68SmzP4AK');
clB64FileContent := concat(clB64FileContent, 'd9jm2E7CBlceFejT4lLqb4NECS+fPX4vivlUjhHhdxfUCqfBVuPCBuq3XiXpQRLxgk04tk9gqNkX');
clB64FileContent := concat(clB64FileContent, 'GcqWAZOGtkVBq6/4rHNpj4QtoJmxWkZ1N/OUZ7eFd+guW4fdpKmh4Eym4HUmc2eGLopsm6Bh3fWB');
clB64FileContent := concat(clB64FileContent, 'hdaqXzawb5wxW5EDxksfeKZMid/g/1Gd9BLwGhEwU9bcWgnPUMeQp9Sv2/YdI9I4LIRC5SZlVMfR');
clB64FileContent := concat(clB64FileContent, 'USjL0RlUJT66k8DS7GUd3pss2HqfXv0yiGBdMEv8WhLH6wpGaFjt5sVfRcedJAsob0/NETJbVzWn');
clB64FileContent := concat(clB64FileContent, 'imC2sPgy32vkKCTXrig3cBhQpufbTm5k2DyAp+/MbVsUZbJeN2aLSSSTJciW2O485baax9B/cwkH');
clB64FileContent := concat(clB64FileContent, 'Iu0hQbGqQI5sngGbmBSoH0sft8NU60G4Oyf/Q4pcppj15BWYG5OZCX10tK1tsTSGWSarjKNi9VTH');
clB64FileContent := concat(clB64FileContent, 'UROZrEDjV/ntpdvOTxGeWf+eIcaVhRj8mk7QMkzWOEBnxTBw2qDQRMCJge06+QdlBwJlLpSsD6Uw');
clB64FileContent := concat(clB64FileContent, 'Z/v1cb7Vg3k6g7HeUWwUhrh+pMkEhuQeA9AZim8BZYQAnn16KbUAC1LE+ETGOIT88RC4UR0+Fs6k');
clB64FileContent := concat(clB64FileContent, 'XijyHaQaFq2ajLVqOHR4IQMq9PV1mIdZELFQgVWj/054z+239Ip2FH0yinJE9LbE4t2hN08dxdpT');
clB64FileContent := concat(clB64FileContent, 'Ts2BIhDQB5jOhkvyDuhCV9sfNL9enr1W/BVkQiCt9DNxr84nPzG2FLppWm/oQRwa0HTr6nCjskOp');
clB64FileContent := concat(clB64FileContent, 'Q9RevgRR4UiG6okrTvju5lyZevPO6dgPGrev7yBAAg6U2+PxR0OBEBQ64GKrbkHFZM8WieJQdc+7');
clB64FileContent := concat(clB64FileContent, 'aaWhLteKcgm4RCJytmKrXyeMbxpuYoCmJfoAdc6rqeKGazSF1KmGB/sd5k/7kXNWz5fmlO2ZTDOO');
clB64FileContent := concat(clB64FileContent, 'rSZB2cRe5x9bzBZruEYon2iug5jyMtQUv8VIZHnoqip1zpqe/Q1a/ZgmpYhQs+F/2EE8tZwlMm/4');
clB64FileContent := concat(clB64FileContent, 'L7snaUj9T0p/ahsKsVQna+p/eUsv8O2AeYoyrlHWGBBbSRlU+ZWoZvwbSVyV2SjtKKODRPSx7U0Y');
clB64FileContent := concat(clB64FileContent, '584e9nWc8WHEOstHU0dOk07kPhsf3pMqpyOrcaVi3xA1cMBWWpUGZtJJpQrn3/psvlmGcQLiQmct');
clB64FileContent := concat(clB64FileContent, '62bOTzuQ3mJkjZgKATxYq396RYj7TpXvDI3UyJLO+HZ3rPv+bAr8unh+/bZSTaVJr/BsDH4/tyZo');
clB64FileContent := concat(clB64FileContent, 'I8zrszgGc5sq+RJ01mysTcjVmIKpLlXfK1410h4KxmPj9DRVhIELkGe8KQmHJgSXsMFPIMNlQSN3');
clB64FileContent := concat(clB64FileContent, 'ay+xgHCvyf8+yDgIMiUNiyPe9bu/VNp2pitzOXE4AxuGKRHMg3kv2AEw1jud4gfXvET4F4+60xUA');
clB64FileContent := concat(clB64FileContent, 'O2kXdwp+FBtdOfk0Ivj+Ep+QnAqCCKfM+IyxZDBrOV1SvJFLzZFbxTaoUjr3o98B4rN93T6wBJx+');
clB64FileContent := concat(clB64FileContent, 'BAmmJTB3kO00eHSyTTd35+ukp2LpuJw3Q+jW118RODqLxXY3O4/CLjyUX1Ybrpd1WJLiMUeiWA+c');
clB64FileContent := concat(clB64FileContent, '38QAb/U/kg2HGstIe8Ndexp/lT0LWNYlSwEvcK3isl6xhnxg5O+yjqSoJ47y0/nfHvpr41WxjzDo');
clB64FileContent := concat(clB64FileContent, 'GhTzpgAAAQQGAAEJpqQABwsBAAIjAwEBBV0AAAEABAMDAQMBAAzAAIDAAIAACAoBqP6sCgAABQER');
clB64FileContent := concat(clB64FileContent, 'NQBCAFMAUwAuAFQAQQBSAEkARgBBAFQAUgBBAE4AUwBJAFQATwBSAEkAQQAuAGQAbABsAAAAFAoB');
clB64FileContent := concat(clB64FileContent, 'AMpk5C3z09YBFQYBAIAAAAAAAA==');
    

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
 nuIndexInternal := BSS_TARIFATRANSITOR_.tb2_0.first;
 while nuIndexInternal IS NOT null loop
  IF (BSS_TARIFATRANSITOR_.tb2_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (BSS_TARIFATRANSITOR_.tb2_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := BSS_TARIFATRANSITOR_.tb2_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := BSS_TARIFATRANSITOR_.tb2_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not BSS_TARIFATRANSITOR_.blProcessStatus) then
 return;
end if;
nuIndex :=  BSS_TARIFATRANSITOR_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (BSS_TARIFATRANSITOR_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(BSS_TARIFATRANSITOR_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (BSS_TARIFATRANSITOR_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := BSS_TARIFATRANSITOR_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  BSS_TARIFATRANSITOR_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(BSS_TARIFATRANSITOR_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,BSS_TARIFATRANSITOR_.tbUserException(nuIndex).user_id, BSS_TARIFATRANSITOR_.tbUserException(nuIndex).status , BSS_TARIFATRANSITOR_.tbUserException(nuIndex).usr_exc_type_id, BSS_TARIFATRANSITOR_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := BSS_TARIFATRANSITOR_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  BSS_TARIFATRANSITOR_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(BSS_TARIFATRANSITOR_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = BSS_TARIFATRANSITOR_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,BSS_TARIFATRANSITOR_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := BSS_TARIFATRANSITOR_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
BSS_TARIFATRANSITOR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('BSS_TARIFATRANSITOR_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:BSS_TARIFATRANSITOR_******************************'); end;
/

