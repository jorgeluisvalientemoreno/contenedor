BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_GROUPS_',
'CREATE OR REPLACE PACKAGE CNCRMNG_GROUPS_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;CURSOR cuRoleExecutables ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT b.name, a.executable_id, a.role_id ' || chr(10) ||
'FROM sa_role_executables a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and a.executable_id in  ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in ' || chr(10) ||
'(SELECT  ' || chr(10) ||
'    sa_executable.executable_id  ' || chr(10) ||
'FROM    sa_executable, sa_tab  ' || chr(10) ||
'WHERE  ' || chr(10) ||
'        sa_tab.aplica_executable = ''CNCRMNG''  ' || chr(10) ||
'AND     sa_tab.process_name = sa_executable.name  ' || chr(10) ||
'AND     sa_tab.type = ''TOOLBAR_GROUP'') ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in ' || chr(10) ||
'(SELECT  ' || chr(10) ||
'    sa_executable.executable_id  ' || chr(10) ||
'FROM    sa_executable, sa_tab  ' || chr(10) ||
'WHERE  ' || chr(10) ||
'        sa_tab.aplica_executable = ''CNCRMNG''  ' || chr(10) ||
'AND     sa_tab.process_name = sa_executable.name  ' || chr(10) ||
'AND     sa_tab.type = ''TOOLBAR_GROUP'') ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in ' || chr(10) ||
'(SELECT  ' || chr(10) ||
'    sa_executable.executable_id  ' || chr(10) ||
'FROM    sa_executable, sa_tab  ' || chr(10) ||
'WHERE  ' || chr(10) ||
'        sa_tab.aplica_executable = ''CNCRMNG''  ' || chr(10) ||
'AND     sa_tab.process_name = sa_executable.name  ' || chr(10) ||
'AND     sa_tab.type = ''TOOLBAR_GROUP'') ' || chr(10) ||
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
'END CNCRMNG_GROUPS_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_GROUPS_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not CNCRMNG_GROUPS_.blProcessStatus) then
 return;
end if;
Open CNCRMNG_GROUPS_.cuRoleExecutables;
loop
 fetch CNCRMNG_GROUPS_.cuRoleExecutables INTO CNCRMNG_GROUPS_.rcRoleExecutables;
 exit when  CNCRMNG_GROUPS_.cuRoleExecutables%notfound;
 CNCRMNG_GROUPS_.tbRoleExecutables(nuIndex) := CNCRMNG_GROUPS_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_GROUPS_.cuRoleExecutables;
nuIndex := 0;
Open CNCRMNG_GROUPS_.cuUserExceptions ;
loop
 fetch CNCRMNG_GROUPS_.cuUserExceptions INTO  CNCRMNG_GROUPS_.rcUserExceptions;
 exit when CNCRMNG_GROUPS_.cuUserExceptions%notfound;
 CNCRMNG_GROUPS_.tbUserException(nuIndex):=CNCRMNG_GROUPS_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_GROUPS_.cuUserExceptions;
nuIndex := 0;
Open CNCRMNG_GROUPS_.cuExecEntities ;
loop
 fetch CNCRMNG_GROUPS_.cuExecEntities INTO  CNCRMNG_GROUPS_.rcExecEntities;
 exit when CNCRMNG_GROUPS_.cuExecEntities%notfound;
 CNCRMNG_GROUPS_.tbExecEntities(nuIndex):=CNCRMNG_GROUPS_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_GROUPS_.cuExecEntities;

exception when others then
CNCRMNG_GROUPS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not CNCRMNG_GROUPS_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT 
    sa_executable.executable_id 
FROM    sa_executable, sa_tab 
WHERE 
        sa_tab.aplica_executable = 'CNCRMNG' 
AND     sa_tab.process_name = sa_executable.name 
AND     sa_tab.type = 'TOOLBAR_GROUP')
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT 
    sa_executable.executable_id 
FROM    sa_executable, sa_tab 
WHERE 
        sa_tab.aplica_executable = 'CNCRMNG' 
AND     sa_tab.process_name = sa_executable.name 
AND     sa_tab.type = 'TOOLBAR_GROUP')
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT 
    sa_executable.executable_id 
FROM    sa_executable, sa_tab 
WHERE 
        sa_tab.aplica_executable = 'CNCRMNG' 
AND     sa_tab.process_name = sa_executable.name 
AND     sa_tab.type = 'TOOLBAR_GROUP')
);

exception when others then
CNCRMNG_GROUPS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN

if (not CNCRMNG_GROUPS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT 
    sa_executable.executable_id 
FROM    sa_executable, sa_tab 
WHERE 
        sa_tab.aplica_executable = 'CNCRMNG' 
AND     sa_tab.process_name = sa_executable.name 
AND     sa_tab.type = 'TOOLBAR_GROUP')) AND ROLE_ID=1;

exception when others then
CNCRMNG_GROUPS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_GROUPS_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE executable_id in
(SELECT 
    sa_executable.executable_id 
FROM    sa_executable, sa_tab 
WHERE 
        sa_tab.aplica_executable = 'CNCRMNG' 
AND     sa_tab.process_name = sa_executable.name 
AND     sa_tab.type = 'TOOLBAR_GROUP');

exception when others then
CNCRMNG_GROUPS_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_GROUPS_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_GROUPS_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_OPTION_',
'CREATE OR REPLACE PACKAGE CNCRMNG_OPTION_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_TABRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_TABRowId tySA_TABRowId;type tySA_TAB_OPTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_TAB_OPTIONRowId tySA_TAB_OPTIONRowId;type tySA_TAB_OPTION_STATUSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_TAB_OPTION_STATUSRowId tySA_TAB_OPTION_STATUSRowId;type ty0_0 is table of SA_TAB.TAB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0; ' || chr(10) ||
'END CNCRMNG_OPTION_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_OPTION_******************************'); END;
/


BEGIN

if (not CNCRMNG_OPTION_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_TAB_OPTION',1);
  DELETE FROM SA_TAB_OPTION WHERE (TAB_ID) in (SELECT TAB_ID FROM SA_TAB WHERE APLICA_EXECUTABLE='CNCRMNG');

exception when others then
CNCRMNG_OPTION_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_OPTION_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_TAB_OPTION_STATUS',1);
  DELETE FROM SA_TAB_OPTION_STATUS WHERE (TAB_ID) in (SELECT TAB_ID FROM SA_TAB WHERE APLICA_EXECUTABLE='CNCRMNG');

exception when others then
CNCRMNG_OPTION_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_OPTION_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_TAB',1);
  DELETE FROM SA_TAB WHERE APLICA_EXECUTABLE='CNCRMNG';

exception when others then
CNCRMNG_OPTION_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_OPTION_.blProcessStatus) then
 return;
end if;

CNCRMNG_OPTION_.old_tb0_0(0):=340182;
CNCRMNG_OPTION_.tb0_0(0):=SA_BOSEQUENCES.FNUGETSEQ_SA_TAB;
CNCRMNG_OPTION_.tb0_0(0):=CNCRMNG_OPTION_.tb0_0(0);
ut_trace.trace('insertando tabla: SA_TAB fila (0)',1);
INSERT INTO SA_TAB(TAB_ID,TAB_NAME,PROCESS_NAME,APLICA_EXECUTABLE,PARENT_TAB,TYPE,SEQUENCE,ADDITIONAL_ATTRIBUTES,CONDITION) 
VALUES (CNCRMNG_OPTION_.tb0_0(0),
'CONTRACT'
,
'GCNED'
,
'CNCRMNG'
,
null,
null,
0,
null,
null);

exception when others then
CNCRMNG_OPTION_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_OPTION_.blProcessStatus) then
 return;
end if;

CNCRMNG_OPTION_.old_tb0_0(1):=340183;
CNCRMNG_OPTION_.tb0_0(1):=SA_BOSEQUENCES.FNUGETSEQ_SA_TAB;
CNCRMNG_OPTION_.tb0_0(1):=CNCRMNG_OPTION_.tb0_0(1);
ut_trace.trace('insertando tabla: SA_TAB fila (1)',1);
INSERT INTO SA_TAB(TAB_ID,TAB_NAME,PROCESS_NAME,APLICA_EXECUTABLE,PARENT_TAB,TYPE,SEQUENCE,ADDITIONAL_ATTRIBUTES,CONDITION) 
VALUES (CNCRMNG_OPTION_.tb0_0(1),
'PRODUCT'
,
'GCNED'
,
'CNCRMNG'
,
null,
null,
0,
null,
null);

exception when others then
CNCRMNG_OPTION_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_OPTION_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_OPTION_******************************'); end;
/

