BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('INFO_VIGENCIAS_EXEN_',
'CREATE OR REPLACE PACKAGE INFO_VIGENCIAS_EXEN_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECTRowId tyGE_OBJECTRowId;type tyGE_OBJECT_PARAMETERRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECT_PARAMETERRowId tyGE_OBJECT_PARAMETERRowId; ' || chr(10) ||
'END INFO_VIGENCIAS_EXEN_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:INFO_VIGENCIAS_EXEN_******************************'); END;
/




COMMIT
/

begin
SA_BOCreatePackages.DropPackage('INFO_VIGENCIAS_EXEN_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:INFO_VIGENCIAS_EXEN_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('INFO_VIGENCIAS_EXEN_',
'CREATE OR REPLACE PACKAGE INFO_VIGENCIAS_EXEN_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_TAB_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_TAB_OBJECTRowId tySA_TAB_OBJECTRowId;type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type tySA_EXEC_ENTITIESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXEC_ENTITIESRowId tySA_EXEC_ENTITIESRowId;CURSOR cuRoleExecutables ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT b.name, a.executable_id, a.role_id ' || chr(10) ||
'FROM sa_role_executables a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and a.executable_id in  ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME in (select executable_name from sa_tab_object where tab_name = ''INFO_VIGENCIAS_EXENCION'') ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME in (select executable_name from sa_tab_object where tab_name = ''INFO_VIGENCIAS_EXENCION'') ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME in (select executable_name from sa_tab_object where tab_name = ''INFO_VIGENCIAS_EXENCION'') ' || chr(10) ||
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
'END INFO_VIGENCIAS_EXEN_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:INFO_VIGENCIAS_EXEN_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
Open INFO_VIGENCIAS_EXEN_.cuRoleExecutables;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuRoleExecutables INTO INFO_VIGENCIAS_EXEN_.rcRoleExecutables;
 exit when  INFO_VIGENCIAS_EXEN_.cuRoleExecutables%notfound;
 INFO_VIGENCIAS_EXEN_.tbRoleExecutables(nuIndex) := INFO_VIGENCIAS_EXEN_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuRoleExecutables;
nuIndex := 0;
Open INFO_VIGENCIAS_EXEN_.cuUserExceptions ;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuUserExceptions INTO  INFO_VIGENCIAS_EXEN_.rcUserExceptions;
 exit when INFO_VIGENCIAS_EXEN_.cuUserExceptions%notfound;
 INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex):=INFO_VIGENCIAS_EXEN_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuUserExceptions;
nuIndex := 0;
Open INFO_VIGENCIAS_EXEN_.cuExecEntities ;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuExecEntities INTO  INFO_VIGENCIAS_EXEN_.rcExecEntities;
 exit when INFO_VIGENCIAS_EXEN_.cuExecEntities%notfound;
 INFO_VIGENCIAS_EXEN_.tbExecEntities(nuIndex):=INFO_VIGENCIAS_EXEN_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuExecEntities;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME in (select executable_name from sa_tab_object where tab_name = 'INFO_VIGENCIAS_EXENCION')
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME in (select executable_name from sa_tab_object where tab_name = 'INFO_VIGENCIAS_EXENCION')
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME in (select executable_name from sa_tab_object where tab_name = 'INFO_VIGENCIAS_EXENCION')
);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SA_TAB_OBJECT WHERE (EXECUTABLE_NAME) in (SELECT NAME FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION'));
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SA_TAB_OBJECT',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SA_TAB_OBJECT WHERE (EXECUTABLE_NAME) in (SELECT NAME FROM SA_EXECUTABLE WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION')) AND ROLE_ID=1));
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SA_TAB_OBJECT',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SA_EXECUTABLE WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION')) AND ROLE_ID=1);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SA_EXECUTABLE',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
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
FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION')) AND ROLE_ID=1;
nuIndex binary_integer;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM SA_ROLE_EXECUTABLES WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SA_TAB_OBJECT',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SA_TAB_OBJECT where rowid = INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SA_EXECUTABLE',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SA_EXECUTABLE where rowid = INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SA_TAB_OBJECT WHERE (EXECUTABLE_NAME) in (SELECT NAME FROM SA_EXECUTABLE WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION'))));
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SA_TAB_OBJECT',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM SA_EXECUTABLE WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION')));
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla SA_EXECUTABLE',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
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
FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION'));
nuIndex binary_integer;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM SA_EXEC_ENTITIES WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SA_TAB_OBJECT',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SA_TAB_OBJECT where rowid = INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SA_EXECUTABLE',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SA_EXECUTABLE where rowid = INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbSA_EXECUTABLERowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
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
FROM SA_EXECUTABLE WHERE (NAME) in (SELECT EXECUTABLE_NAME FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION');
nuIndex binary_integer;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
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
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria SA_TAB_OBJECT',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from SA_TAB_OBJECT where rowid = INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbSA_TAB_OBJECTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_TAB_OBJECT',1);
  DELETE FROM SA_TAB_OBJECT WHERE TAB_NAME = 'INFO_VIGENCIAS_EXENCION';

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('INFO_VIGENCIAS_EXEN_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:INFO_VIGENCIAS_EXEN_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('INFO_VIGENCIAS_EXEN_',
'CREATE OR REPLACE PACKAGE INFO_VIGENCIAS_EXEN_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type tyGE_ENTITYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITYRowId tyGE_ENTITYRowId;type tySA_EXEC_ENTITIESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXEC_ENTITIESRowId tySA_EXEC_ENTITIESRowId;type tyGE_ENTITY_ADITIONALRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITY_ADITIONALRowId tyGE_ENTITY_ADITIONALRowId;type tyGE_ENTITY_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITY_ATTRIBUTESRowId tyGE_ENTITY_ATTRIBUTESRowId;type tyGE_SEARCH_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_SEARCH_ATTRIBUTESRowId tyGE_SEARCH_ATTRIBUTESRowId;type tyGI_ENTITY_ROW_ORDERRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ENTITY_ROW_ORDERRowId tyGI_ENTITY_ROW_ORDERRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyGE_STATEMENT_COLUMNSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENT_COLUMNSRowId tyGE_STATEMENT_COLUMNSRowId;type ty0_0 is table of SA_EXECUTABLE.NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of SA_EXECUTABLE.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of GE_ENTITY.NAME_%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GE_ENTITY.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of GE_ENTITY_ADITIONAL.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GE_ENTITY_ADITIONAL.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
'CURSOR cuRoleExecutables ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT b.name, a.executable_id, a.role_id ' || chr(10) ||
'FROM sa_role_executables a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and a.executable_id in  ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''INFO_VIGENCIAS_EXENCION'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''INFO_VIGENCIAS_EXENCION'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''INFO_VIGENCIAS_EXENCION'' ' || chr(10) ||
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
'CURSOR cuAttrRoles ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT c.name_, b.technical_name, a.attr_role_exec_id, a.role_id, a.executable_id, a.entity_attribute_id, a.enabled, a.exception_type ' || chr(10) ||
'FROM sa_attr_role_exec a, ge_entity_attributes b, ge_entity c ' || chr(10) ||
'WHERE a.entity_attribute_id = b.entity_attribute_id ' || chr(10) ||
'and b.entity_id = c.entity_id ' || chr(10) ||
'and c.name_ =  ' || chr(10) ||
'''INFO_VIGENCIAS_EXENCION''; ' || chr(10) ||
'CURSOR cuAttrExcep ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT c.name_, b.technical_name, a.user_id, a.is_visible, a.entity_attribute_id ' || chr(10) ||
'FROM sa_user_attr_excep a, ge_entity_attributes b, ge_entity c ' || chr(10) ||
'WHERE a.entity_attribute_id = b.entity_attribute_id ' || chr(10) ||
'and b.entity_id = c.entity_id ' || chr(10) ||
'and c.name_ =  ' || chr(10) ||
'''INFO_VIGENCIAS_EXENCION''; ' || chr(10) ||
'type tyAttrRoles IS table of cuAttrRoles%rowtype index BY binary_integer; ' || chr(10) ||
'tbAttrRoles   tyAttrRoles; ' || chr(10) ||
'rcAttrRoles cuAttrRoles%rowtype; ' || chr(10) ||
'type tyAttrExcep IS table of cuAttrExcep%rowtype index BY binary_integer; ' || chr(10) ||
'tbAttrExcep   tyAttrExcep; ' || chr(10) ||
'rcAttrExcep cuAttrExcep%rowtype; ' || chr(10) ||
'clColumn_0 clob; ' || chr(10) ||
'clColumn_1 clob;clColumn_2 clob; ' || chr(10) ||
'END INFO_VIGENCIAS_EXEN_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:INFO_VIGENCIAS_EXEN_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
Open INFO_VIGENCIAS_EXEN_.cuRoleExecutables;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuRoleExecutables INTO INFO_VIGENCIAS_EXEN_.rcRoleExecutables;
 exit when  INFO_VIGENCIAS_EXEN_.cuRoleExecutables%notfound;
 INFO_VIGENCIAS_EXEN_.tbRoleExecutables(nuIndex) := INFO_VIGENCIAS_EXEN_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuRoleExecutables;
nuIndex := 0;
Open INFO_VIGENCIAS_EXEN_.cuUserExceptions ;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuUserExceptions INTO  INFO_VIGENCIAS_EXEN_.rcUserExceptions;
 exit when INFO_VIGENCIAS_EXEN_.cuUserExceptions%notfound;
 INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex):=INFO_VIGENCIAS_EXEN_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuUserExceptions;
nuIndex := 0;
Open INFO_VIGENCIAS_EXEN_.cuExecEntities ;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuExecEntities INTO  INFO_VIGENCIAS_EXEN_.rcExecEntities;
 exit when INFO_VIGENCIAS_EXEN_.cuExecEntities%notfound;
 INFO_VIGENCIAS_EXEN_.tbExecEntities(nuIndex):=INFO_VIGENCIAS_EXEN_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuExecEntities;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
Open INFO_VIGENCIAS_EXEN_.cuAttrRoles;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuAttrRoles INTO INFO_VIGENCIAS_EXEN_.rcAttrRoles;
 exit when  INFO_VIGENCIAS_EXEN_.cuAttrRoles%notfound;
 INFO_VIGENCIAS_EXEN_.tbAttrRoles(nuIndex) := INFO_VIGENCIAS_EXEN_.rcAttrRoles;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuAttrRoles;
nuIndex := 0;
Open INFO_VIGENCIAS_EXEN_.cuAttrExcep ;
loop
 fetch INFO_VIGENCIAS_EXEN_.cuAttrExcep INTO  INFO_VIGENCIAS_EXEN_.rcAttrExcep;
 exit when INFO_VIGENCIAS_EXEN_.cuAttrExcep%notfound;
 INFO_VIGENCIAS_EXEN_.tbAttrExcep(nuIndex):=INFO_VIGENCIAS_EXEN_.rcAttrExcep;
 nuIndex := nuIndex + 1;
END loop;
close INFO_VIGENCIAS_EXEN_.cuAttrExcep;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'
);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_attr_role_exec
WHERE entity_attribute_id in
(
SELECT entity_attribute_id
FROM ge_entity_attributes, ge_entity
WHERE ge_entity_attributes.entity_id = ge_entity.entity_id
and ge_entity.name_ = 'INFO_VIGENCIAS_EXENCION'
);
DELETE FROM sa_user_attr_excep
WHERE entity_attribute_id in
(
SELECT entity_attribute_id
FROM ge_entity_attributes, ge_entity
WHERE ge_entity_attributes.entity_id = ge_entity.entity_id
and ge_entity.name_ = 'INFO_VIGENCIAS_EXENCION'
);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/



BEGIN 
  INFO_VIGENCIAS_EXEN_.tbEntityAttributeName(90200618) := 'INFO_VIGENCIAS_EXENCION@SOLICITUD'; 
  INFO_VIGENCIAS_EXEN_.tbEntityAttributeName(90200619) := 'INFO_VIGENCIAS_EXENCION@PRODUCTO'; 
  INFO_VIGENCIAS_EXEN_.tbEntityAttributeName(90200620) := 'INFO_VIGENCIAS_EXENCION@FECHA_INI_VIGENCIA'; 
  INFO_VIGENCIAS_EXEN_.tbEntityAttributeName(90200621) := 'INFO_VIGENCIAS_EXENCION@FECHA_FIN_VIGENCIA'; 
  INFO_VIGENCIAS_EXEN_.tbEntityAttributeName(90200622) := 'INFO_VIGENCIAS_EXENCION@PARENT_ID'; 
END;
/

BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_ENTITY_ADITIONAL WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'))));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_ENTITY_ADITIONAL WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION')));
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GE_SEARCH_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY_ADITIONAL WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION')))));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GE_SEARCH_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY_ADITIONAL WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'))));
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_SEARCH_ATTRIBUTES',1);
  DELETE FROM GE_SEARCH_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY_ADITIONAL WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION')));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ENTITY_ADITIONAL',1);
  DELETE FROM GE_ENTITY_ADITIONAL WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := INFO_VIGENCIAS_EXEN_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ENTITY_ROW_ORDER',1);
  DELETE FROM GI_ENTITY_ROW_ORDER WHERE (ENTITY_ID,ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ID,ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION')));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ENTITY_ATTRIBUTES',1);
  DELETE FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION'));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ENTITY',1);
  DELETE FROM GE_ENTITY WHERE (NAME_) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION');

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION') AND ROLE_ID=1;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='INFO_VIGENCIAS_EXENCION';

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb0_0(0):='INFO_VIGENCIAS_EXENCION'
;
INFO_VIGENCIAS_EXEN_.old_tb0_1(0):=500000000015839;
INFO_VIGENCIAS_EXEN_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
INFO_VIGENCIAS_EXEN_.tb0_1(0):=INFO_VIGENCIAS_EXEN_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (INFO_VIGENCIAS_EXEN_.tb0_0(0),
INFO_VIGENCIAS_EXEN_.tb0_1(0),
'Vigencias de Exención de Contribución'
,
null,
'1.0'
,
10,
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
null,
null,
null,
null);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb1_0(0):=INFO_VIGENCIAS_EXEN_.tb0_0(0);
INFO_VIGENCIAS_EXEN_.old_tb1_1(0):=6247;
INFO_VIGENCIAS_EXEN_.tb1_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.tb1_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
INFO_VIGENCIAS_EXEN_.tb1_1(0):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
ut_trace.trace('insertando tabla: GE_ENTITY fila (0)',1);
INSERT INTO GE_ENTITY(NAME_,ENTITY_ID,MODULE_ID,SELEC_TYPE_OBJECT_ID,INS_SEQ,IN_PERSIST,DESCRIPTION,DISPLAY_NAME,LOAD_CARTRIDGE,TABLESPACE,CREATION_DATE,LAST_MODIFY_DATE,STATUS,ALLOWED_FULL_SCAN) 
VALUES (INFO_VIGENCIAS_EXEN_.tb1_0(0),
INFO_VIGENCIAS_EXEN_.tb1_1(0),
16,
null,
null,
'N'
,
'Vigencias de Exención de Contribución'
,
'Vigencias de Exención de Contribución'
,
'N'
,
null,
to_date('14-05-2025 18:50:38','DD-MM-YYYY HH24:MI:SS'),
to_date('14-05-2025 18:50:38','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb2_0(0):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
ut_trace.trace('insertando tabla: GE_ENTITY_ADITIONAL fila (0)',1);
INSERT INTO GE_ENTITY_ADITIONAL(ENTITY_ID,STATEMENT_ID,QUERY_SERVICE_NAME,PROCESS_SERVICE_NAME,BASE_ENTITY_NAME,BASE_ID_NAME,PRIMARY_KEY_ATTRIBUTE,FOREING_KEY_ATTRIBUTE,ICON,IS_SEARCH,SEARCH_SERVICE_NAME,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,IS_CUSTOM_ENTITY) 
VALUES (INFO_VIGENCIAS_EXEN_.tb2_0(0),
null,
'PKG_UICNCRM.prcObtInfoExenciones'
,
null,
'Vigencias de Exención de Contribución'
,
null,
'SOLICITUD'
,
'PARENT_ID'
,
null,
'N'
,
null,
null,
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title /><Subtitle1 /><Subtitle2 /></OpenQueryHeaderTitle>'
,
null,
null,
null,
null,
'N'
);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb3_0(0):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
INFO_VIGENCIAS_EXEN_.old_tb3_1(0):=90200618;
INFO_VIGENCIAS_EXEN_.tb3_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.TBENTITYATTRIBUTENAME(INFO_VIGENCIAS_EXEN_.old_tb3_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
INFO_VIGENCIAS_EXEN_.tb3_1(0):=INFO_VIGENCIAS_EXEN_.tb3_1(0);
ut_trace.trace('insertando tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,TECHNICAL_NAME,REFERENCE,ATTRIBUTE_TYPE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,GI_COMPONENT_ID,MASK_ID,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (INFO_VIGENCIAS_EXEN_.tb3_0(0),
INFO_VIGENCIAS_EXEN_.tb3_1(0),
'SOLICITUD'
,
null,
2,
null,
null,
0,
'N'
,
'N'
,
'Solicitud'
,
'Y'
,
null,
null,
null,
null,
null,
null,
'G'
,
null,
null,
'N'
,
'N'
,
'N'
,
null,
null,
null);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb3_0(1):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
INFO_VIGENCIAS_EXEN_.old_tb3_1(1):=90200619;
INFO_VIGENCIAS_EXEN_.tb3_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.TBENTITYATTRIBUTENAME(INFO_VIGENCIAS_EXEN_.old_tb3_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
INFO_VIGENCIAS_EXEN_.tb3_1(1):=INFO_VIGENCIAS_EXEN_.tb3_1(1);
ut_trace.trace('insertando tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,TECHNICAL_NAME,REFERENCE,ATTRIBUTE_TYPE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,GI_COMPONENT_ID,MASK_ID,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (INFO_VIGENCIAS_EXEN_.tb3_0(1),
INFO_VIGENCIAS_EXEN_.tb3_1(1),
'PRODUCTO'
,
null,
2,
null,
null,
1,
'N'
,
'N'
,
'Producto'
,
'Y'
,
null,
null,
null,
null,
null,
null,
'G'
,
null,
null,
'N'
,
'N'
,
'N'
,
null,
null,
null);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb3_0(2):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
INFO_VIGENCIAS_EXEN_.old_tb3_1(2):=90200620;
INFO_VIGENCIAS_EXEN_.tb3_1(2):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.TBENTITYATTRIBUTENAME(INFO_VIGENCIAS_EXEN_.old_tb3_1(2)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
INFO_VIGENCIAS_EXEN_.tb3_1(2):=INFO_VIGENCIAS_EXEN_.tb3_1(2);
ut_trace.trace('insertando tabla: GE_ENTITY_ATTRIBUTES fila (2)',1);
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,TECHNICAL_NAME,REFERENCE,ATTRIBUTE_TYPE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,GI_COMPONENT_ID,MASK_ID,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (INFO_VIGENCIAS_EXEN_.tb3_0(2),
INFO_VIGENCIAS_EXEN_.tb3_1(2),
'FECHA_INI_VIGENCIA'
,
null,
3,
null,
null,
2,
'N'
,
'N'
,
'Fecha_Ini_Vigencia'
,
'Y'
,
null,
null,
null,
7,
null,
null,
'G'
,
null,
null,
'N'
,
'N'
,
'N'
,
null,
null,
null);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb3_0(3):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
INFO_VIGENCIAS_EXEN_.old_tb3_1(3):=90200621;
INFO_VIGENCIAS_EXEN_.tb3_1(3):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.TBENTITYATTRIBUTENAME(INFO_VIGENCIAS_EXEN_.old_tb3_1(3)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
INFO_VIGENCIAS_EXEN_.tb3_1(3):=INFO_VIGENCIAS_EXEN_.tb3_1(3);
ut_trace.trace('insertando tabla: GE_ENTITY_ATTRIBUTES fila (3)',1);
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,TECHNICAL_NAME,REFERENCE,ATTRIBUTE_TYPE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,GI_COMPONENT_ID,MASK_ID,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (INFO_VIGENCIAS_EXEN_.tb3_0(3),
INFO_VIGENCIAS_EXEN_.tb3_1(3),
'FECHA_FIN_VIGENCIA'
,
null,
3,
null,
null,
3,
'N'
,
'N'
,
'Fecha_Fin_Vigencia'
,
'Y'
,
null,
null,
null,
7,
null,
null,
'G'
,
null,
null,
'N'
,
'N'
,
'N'
,
null,
null,
null);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb3_0(4):=INFO_VIGENCIAS_EXEN_.tb1_1(0);
INFO_VIGENCIAS_EXEN_.old_tb3_1(4):=90200622;
INFO_VIGENCIAS_EXEN_.tb3_1(4):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(INFO_VIGENCIAS_EXEN_.TBENTITYATTRIBUTENAME(INFO_VIGENCIAS_EXEN_.old_tb3_1(4)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
INFO_VIGENCIAS_EXEN_.tb3_1(4):=INFO_VIGENCIAS_EXEN_.tb3_1(4);
ut_trace.trace('insertando tabla: GE_ENTITY_ATTRIBUTES fila (4)',1);
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,TECHNICAL_NAME,REFERENCE,ATTRIBUTE_TYPE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,GI_COMPONENT_ID,MASK_ID,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (INFO_VIGENCIAS_EXEN_.tb3_0(4),
INFO_VIGENCIAS_EXEN_.tb3_1(4),
'PARENT_ID'
,
null,
2,
null,
null,
4,
'N'
,
'N'
,
'Parent_Id'
,
'Y'
,
null,
null,
null,
null,
null,
null,
'G'
,
null,
null,
'N'
,
'N'
,
'N'
,
null,
null,
null);

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;

INFO_VIGENCIAS_EXEN_.tb4_0(0):=1;
INFO_VIGENCIAS_EXEN_.tb4_1(0):=INFO_VIGENCIAS_EXEN_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (INFO_VIGENCIAS_EXEN_.tb4_0(0),
INFO_VIGENCIAS_EXEN_.tb4_1(0));

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
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
 nuIndexInternal := INFO_VIGENCIAS_EXEN_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (INFO_VIGENCIAS_EXEN_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (INFO_VIGENCIAS_EXEN_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := INFO_VIGENCIAS_EXEN_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := INFO_VIGENCIAS_EXEN_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
nuIndex :=  INFO_VIGENCIAS_EXEN_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (INFO_VIGENCIAS_EXEN_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(INFO_VIGENCIAS_EXEN_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (INFO_VIGENCIAS_EXEN_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := INFO_VIGENCIAS_EXEN_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  INFO_VIGENCIAS_EXEN_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex).user_id, INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex).status , INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex).usr_exc_type_id, INFO_VIGENCIAS_EXEN_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := INFO_VIGENCIAS_EXEN_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  INFO_VIGENCIAS_EXEN_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(INFO_VIGENCIAS_EXEN_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = INFO_VIGENCIAS_EXEN_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,INFO_VIGENCIAS_EXEN_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := INFO_VIGENCIAS_EXEN_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


DECLARE
nuNewAttributeId ge_entity_attributes.entity_attribute_id%type;
nuIndex binary_integer;
nuRecCount binary_integer;
nunewSeq binary_integer;
sbEntityName ge_entity_attributes.technical_name%type;
FUNCTION fnuGetNewAttributeId(isbEntityName in ge_entity.name_%type,
   isbAttributeName in ge_entity_attributes.technical_name%type)
 return ge_entity_attributes.entity_attribute_id%type
IS
 nuEntityAttributeId ge_entity_attributes.entity_attribute_id%type;
BEGIN
 SELECT entity_attribute_id
 INTO   nuEntityAttributeId
 FROM   ge_entity, ge_entity_attributes
 WHERE  ge_entity.name_ = isbEntityName
 AND    ge_entity.entity_id = ge_entity_attributes.entity_id
 AND    ge_entity_attributes.technical_name = isbAttributeName; return nuEntityAttributeId;
END;
BEGIN

if (not INFO_VIGENCIAS_EXEN_.blProcessStatus) then
 return;
end if;
nuIndex :=  INFO_VIGENCIAS_EXEN_.tbAttrRoles.first;
while nuIndex IS NOT null loop
 sbEntityName := 'INFO_VIGENCIAS_EXENCION';
  nuNewAttributeId := fnuGetNewAttributeId(sbEntityName, INFO_VIGENCIAS_EXEN_.tbAttrRoles(nuIndex).technical_name);
  IF nuNewAttributeId is not null then
    nunewSeq :=  SA_BOSequences.fnuGetSeq_SA_ATTR_ROLE_EXEC;
    INSERT INTO sa_attr_role_exec (attr_role_exec_id, role_id, executable_id, entity_attribute_id, enabled, exception_type)
    VALUES (nunewSeq, INFO_VIGENCIAS_EXEN_.tbAttrRoles(nuIndex).role_id, INFO_VIGENCIAS_EXEN_.tbAttrRoles(nuIndex).executable_id, nuNewAttributeId, INFO_VIGENCIAS_EXEN_.tbAttrRoles(nuIndex).enabled, INFO_VIGENCIAS_EXEN_.tbAttrRoles(nuIndex).exception_type);
  END IF;
 nuIndex := INFO_VIGENCIAS_EXEN_.tbAttrRoles.next(nuIndex);
END loop;
nuIndex :=  INFO_VIGENCIAS_EXEN_.tbAttrExcep.first;
while nuIndex IS NOT null loop
 sbEntityName := 'INFO_VIGENCIAS_EXENCION';
 nuNewAttributeId := fnuGetNewAttributeId(sbEntityName, INFO_VIGENCIAS_EXEN_.tbAttrExcep(nuIndex).technical_name);
 IF nuNewAttributeId is not null then
  insert INTO sa_user_attr_excep (entity_attribute_id, user_id, is_visible)
  VALUES (nuNewAttributeId ,INFO_VIGENCIAS_EXEN_.tbAttrExcep(nuIndex).user_id, INFO_VIGENCIAS_EXEN_.tbAttrExcep(nuIndex).is_visible );
 END IF;
 nuIndex := INFO_VIGENCIAS_EXEN_.tbAttrExcep.next(nuIndex);
END loop;

exception when others then
INFO_VIGENCIAS_EXEN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('INFO_VIGENCIAS_EXEN_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:INFO_VIGENCIAS_EXEN_******************************'); end;
/

