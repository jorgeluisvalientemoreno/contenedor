BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_',
'CREATE OR REPLACE PACKAGE CNCRMNG_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type tySA_EXEC_ENTITIESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXEC_ENTITIESRowId tySA_EXEC_ENTITIESRowId;CURSOR cuRoleExecutables ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT b.name, a.executable_id, a.role_id ' || chr(10) ||
'FROM sa_role_executables a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and a.executable_id in  ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in ' || chr(10) ||
'(SELECT d.executable_id ' || chr(10) ||
'FROM gi_composition b, ' || chr(10) ||
'gi_frame c, ' || chr(10) ||
'sa_executable d, ' || chr(10) ||
'sa_executable e, ' || chr(10) ||
'gi_config f ' || chr(10) ||
'WHERE b.tag_name = d.name ' || chr(10) ||
'AND b.entity_type_id = 1258 ' || chr(10) ||
'AND b.composition_id = c.composition_id ' || chr(10) ||
'AND b.config_id = f.config_id ' || chr(10) ||
'AND e.executable_id = f.external_root_id ' || chr(10) ||
'AND e.name=''CNCRMNG'') ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in ' || chr(10) ||
'(SELECT d.executable_id ' || chr(10) ||
'FROM gi_composition b, ' || chr(10) ||
'gi_frame c, ' || chr(10) ||
'sa_executable d, ' || chr(10) ||
'sa_executable e, ' || chr(10) ||
'gi_config f ' || chr(10) ||
'WHERE b.tag_name = d.name ' || chr(10) ||
'AND b.entity_type_id = 1258 ' || chr(10) ||
'AND b.composition_id = c.composition_id ' || chr(10) ||
'AND b.config_id = f.config_id ' || chr(10) ||
'AND e.executable_id = f.external_root_id ' || chr(10) ||
'AND e.name=''CNCRMNG'') ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in ' || chr(10) ||
'(SELECT d.executable_id ' || chr(10) ||
'FROM gi_composition b, ' || chr(10) ||
'gi_frame c, ' || chr(10) ||
'sa_executable d, ' || chr(10) ||
'sa_executable e, ' || chr(10) ||
'gi_config f ' || chr(10) ||
'WHERE b.tag_name = d.name ' || chr(10) ||
'AND b.entity_type_id = 1258 ' || chr(10) ||
'AND b.composition_id = c.composition_id ' || chr(10) ||
'AND b.config_id = f.config_id ' || chr(10) ||
'AND e.executable_id = f.external_root_id ' || chr(10) ||
'AND e.name=''CNCRMNG'') ' || chr(10) ||
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
'END CNCRMNG_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
Open CNCRMNG_.cuRoleExecutables;
loop
 fetch CNCRMNG_.cuRoleExecutables INTO CNCRMNG_.rcRoleExecutables;
 exit when  CNCRMNG_.cuRoleExecutables%notfound;
 CNCRMNG_.tbRoleExecutables(nuIndex) := CNCRMNG_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_.cuRoleExecutables;
nuIndex := 0;
Open CNCRMNG_.cuUserExceptions ;
loop
 fetch CNCRMNG_.cuUserExceptions INTO  CNCRMNG_.rcUserExceptions;
 exit when CNCRMNG_.cuUserExceptions%notfound;
 CNCRMNG_.tbUserException(nuIndex):=CNCRMNG_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_.cuUserExceptions;
nuIndex := 0;
Open CNCRMNG_.cuExecEntities ;
loop
 fetch CNCRMNG_.cuExecEntities INTO  CNCRMNG_.rcExecEntities;
 exit when CNCRMNG_.cuExecEntities%notfound;
 CNCRMNG_.tbExecEntities(nuIndex):=CNCRMNG_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_.cuExecEntities;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT d.executable_id
FROM gi_composition b,
gi_frame c,
sa_executable d,
sa_executable e,
gi_config f
WHERE b.tag_name = d.name
AND b.entity_type_id = 1258
AND b.composition_id = c.composition_id
AND b.config_id = f.config_id
AND e.executable_id = f.external_root_id
AND e.name='CNCRMNG')
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT d.executable_id
FROM gi_composition b,
gi_frame c,
sa_executable d,
sa_executable e,
gi_config f
WHERE b.tag_name = d.name
AND b.entity_type_id = 1258
AND b.composition_id = c.composition_id
AND b.config_id = f.config_id
AND e.executable_id = f.external_root_id
AND e.name='CNCRMNG')
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT d.executable_id
FROM gi_composition b,
gi_frame c,
sa_executable d,
sa_executable e,
gi_config f
WHERE b.tag_name = d.name
AND b.entity_type_id = 1258
AND b.composition_id = c.composition_id
AND b.config_id = f.config_id
AND e.executable_id = f.external_root_id
AND e.name='CNCRMNG')
);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT d.executable_id
FROM gi_composition b,
gi_frame c,
sa_executable d,
sa_executable e,
gi_config f
WHERE b.tag_name = d.name
AND b.entity_type_id = 1258
AND b.composition_id = c.composition_id
AND b.config_id = f.config_id
AND e.executable_id = f.external_root_id
AND e.name='CNCRMNG')) AND ROLE_ID=1;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE executable_id in
(SELECT d.executable_id
FROM gi_composition b,
gi_frame c,
sa_executable d,
sa_executable e,
gi_config f
WHERE b.tag_name = d.name
AND b.entity_type_id = 1258
AND b.composition_id = c.composition_id
AND b.config_id = f.config_id
AND e.executable_id = f.external_root_id
AND e.name='CNCRMNG'));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE executable_id in
(SELECT d.executable_id
FROM gi_composition b,
gi_frame c,
sa_executable d,
sa_executable e,
gi_config f
WHERE b.tag_name = d.name
AND b.entity_type_id = 1258
AND b.composition_id = c.composition_id
AND b.config_id = f.config_id
AND e.executable_id = f.external_root_id
AND e.name='CNCRMNG');

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_',
'CREATE OR REPLACE PACKAGE CNCRMNG_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type tySA_EXEC_ENTITIESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXEC_ENTITIESRowId tySA_EXEC_ENTITIESRowId;type tySA_MENU_OPTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_MENU_OPTIONRowId tySA_MENU_OPTIONRowId;type tyGI_ALT_SEAR_ENTITYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ALT_SEAR_ENTITYRowId tyGI_ALT_SEAR_ENTITYRowId;type tyGI_CONFIGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIGRowId tyGI_CONFIGRowId;type tyGI_COMPOSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITIONRowId tyGI_COMPOSITIONRowId;type tyGI_FRAMERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_FRAMERowId tyGI_FRAMERowId;type tyGI_COMP_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_ATTRIBSRowId tyGI_COMP_ATTRIBSRowId;type tyGI_COMPOSITION_ADITIRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITION_ADITIRowId tyGI_COMPOSITION_ADITIRowId;type tyGI_COMP_FRAME_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_FRAME_ATTRIBRowId tyGI_COMP_FRAME_ATTRIBRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyGE_STATEMENT_COLUMNSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENT_COLUMNSRowId tyGE_STATEMENT_COLUMNSRowId;type ty0_0 is table of SA_EXECUTABLE.NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of SA_EXECUTABLE.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty0_2 is table of SA_EXECUTABLE.VERSION%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2;type ty1_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of SA_MENU_OPTION.MENU_OPTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_MENU_OPTION.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of GI_CONFIG.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GI_CONFIG.EXTERNAL_ROOT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of GI_COMPOSITION.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of GI_COMPOSITION.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of GI_COMPOSITION.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty5_0 is table of GI_COMPOSITION_ADITI.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of GI_COMPOSITION_ADITI.PARENT_STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty6_0 is table of GI_COMP_ATTRIBS.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of GI_COMP_ATTRIBS.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of GI_COMP_ATTRIBS.PARENT_GROUP_ATTR_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty6_3 is table of GI_COMP_ATTRIBS.SELECT_STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_3 ty6_3; ' || chr(10) ||
'tb6_3 ty6_3;type ty7_0 is table of GI_COMP_FRAME_ATTRIB.COMP_FRAME_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of GI_COMP_FRAME_ATTRIB.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of GI_COMP_FRAME_ATTRIB.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty8_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GI_FRAME.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of GI_FRAME.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1; ' || chr(10) ||
'CURSOR cuSAExecSynonParent(executableName IN sa_executable.name%type) ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT sa_executable_synon.executable_id, sa_executable_synon.is_active ' || chr(10) ||
'FROM sa_executable_synon, sa_executable ' || chr(10) ||
'WHERE sa_executable_synon.synonymous_id = sa_executable.executable_id ' || chr(10) ||
'AND   sa_executable_synon.executable_id <> sa_executable.executable_id ' || chr(10) ||
'AND   sa_executable.name = executableName; ' || chr(10) ||
'TYPE tySAExecSynonParent IS TABLE OF cuSAExecSynonParent%rowtype INDEX BY BINARY_INTEGER; ' || chr(10) ||
'tbOldSAExecSynonParent  tySAExecSynonParent; ' || chr(10) ||
' ' || chr(10) ||
'CURSOR cuSAExecSynonSon(executableName IN sa_executable.name%type) ' || chr(10) ||
'IS ' || chr(10) ||
'SELECT sa_executable_synon.synonymous_id, sa_executable_synon.is_active ' || chr(10) ||
'FROM sa_executable_synon, sa_executable ' || chr(10) ||
'WHERE sa_executable_synon.executable_id = sa_executable.executable_id ' || chr(10) ||
'AND   sa_executable.name = executableName; ' || chr(10) ||
'TYPE tySAExecSynonSon IS TABLE OF cuSAExecSynonSon%rowtype INDEX BY BINARY_INTEGER; ' || chr(10) ||
'tbOldSAExecSynonSon  tySAExecSynonSon; ' || chr(10) ||
'  executableName ge_catalog.tag_name%type := ''CNCRMNG''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''CNCRMNG'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''CNCRMNG'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''CNCRMNG'' ' || chr(10) ||
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
'clColumn_0 clob; ' || chr(10) ||
'clColumn_1 clob;clColumn_2 clob; ' || chr(10) ||
'END CNCRMNG_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
Open CNCRMNG_.cuRoleExecutables;
loop
 fetch CNCRMNG_.cuRoleExecutables INTO CNCRMNG_.rcRoleExecutables;
 exit when  CNCRMNG_.cuRoleExecutables%notfound;
 CNCRMNG_.tbRoleExecutables(nuIndex) := CNCRMNG_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_.cuRoleExecutables;
nuIndex := 0;
Open CNCRMNG_.cuUserExceptions ;
loop
 fetch CNCRMNG_.cuUserExceptions INTO  CNCRMNG_.rcUserExceptions;
 exit when CNCRMNG_.cuUserExceptions%notfound;
 CNCRMNG_.tbUserException(nuIndex):=CNCRMNG_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_.cuUserExceptions;
nuIndex := 0;
Open CNCRMNG_.cuExecEntities ;
loop
 fetch CNCRMNG_.cuExecEntities INTO  CNCRMNG_.rcExecEntities;
 exit when CNCRMNG_.cuExecEntities%notfound;
 CNCRMNG_.tbExecEntities(nuIndex):=CNCRMNG_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close CNCRMNG_.cuExecEntities;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG'
);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND ROLE_ID=1;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG');

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG');

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT PARENT_STATEMENT_ID FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339))));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT PARENT_STATEMENT_ID FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
CNCRMNG_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION_ADITI',1);
  DELETE FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=CNCRMNG_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = CNCRMNG_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
CNCRMNG_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := CNCRMNG_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339))));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
CNCRMNG_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=CNCRMNG_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = CNCRMNG_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
CNCRMNG_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := CNCRMNG_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_COMPOSITION WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_COMPOSITION',1);
for rcData in cuLoadTemporaryTable loop
CNCRMNG_.tbGI_COMPOSITIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_COMPOSITION',1);
nuVarcharIndex:=CNCRMNG_.tbGI_COMPOSITIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_COMPOSITION where rowid = CNCRMNG_.tbGI_COMPOSITIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CNCRMNG_.tbGI_COMPOSITIONRowId.next(nuVarcharIndex); 
CNCRMNG_.tbGI_COMPOSITIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='CNCRMNG') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ALT_SEAR_ENTITY',1);
  DELETE FROM GI_ALT_SEAR_ENTITY WHERE (EXECUTABLE_NAME) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='CNCRMNG');

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='CNCRMNG';

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb0_0(0):='CNCRMNG'
;
CNCRMNG_.tb0_0(0):=UPPER(CNCRMNG_.old_tb0_0(0));
CNCRMNG_.tb0_0(0):=CNCRMNG_.tb0_0(0);
CNCRMNG_.old_tb0_1(0):=500000000015700;
CNCRMNG_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(CNCRMNG_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
CNCRMNG_.tb0_1(0):=CNCRMNG_.tb0_1(0);
CNCRMNG_.old_tb0_2(0):='31'
;
CNCRMNG_.tb0_2(0):=TRUNC(CNCRMNG_.old_tb0_2(0));
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,VERSION,DESCRIPTION,PATH,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (CNCRMNG_.tb0_0(0),
CNCRMNG_.tb0_1(0),
CNCRMNG_.tb0_2(0),
'Punto unico de Atencion al Cliente para Negociacion'
,
null,
8,
2,
16,
1,
6992,
'N'
,
null,
'N'
,
'Y'
,
8,
'C',
to_date('10-11-2022 15:02:57','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.tb1_0(0):=1;
CNCRMNG_.tb1_1(0):=CNCRMNG_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (CNCRMNG_.tb1_0(0),
CNCRMNG_.tb1_1(0));

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb2_0(0):=40009758;
CNCRMNG_.tb2_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
CNCRMNG_.tb2_0(0):=CNCRMNG_.tb2_0(0);
CNCRMNG_.tb2_1(0):=CNCRMNG_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (CNCRMNG_.tb2_0(0),
CNCRMNG_.tb2_1(0),
'CNCRMNG'
,
'Punto unico de Atencion al Cliente para Negociacion'
,
1,
1,
49,
-1,
'FormExecutable'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb3_0(0):=8858;
CNCRMNG_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
CNCRMNG_.tb3_0(0):=CNCRMNG_.tb3_0(0);
CNCRMNG_.tb3_1(0):=CNCRMNG_.tb0_1(0);
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,CONFIG_TYPE_ID,ENTITY_ROOT_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (CNCRMNG_.tb3_0(0),
CNCRMNG_.tb3_1(0),
6,
3339,
'F'
,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb4_0(0):=1065813;
CNCRMNG_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CNCRMNG_.tb4_0(0):=CNCRMNG_.tb4_0(0);
CNCRMNG_.tb4_1(0):=CNCRMNG_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,CONFIG_ID,PARENT_COMP_ID,MIN_OBJECTS,MAX_OBJECTS,TAG_NAME,ENTITY_TYPE_ID,EXTERNAL_TYPE_ID,CONFIG_TYPE_ID) 
VALUES (CNCRMNG_.tb4_0(0),
CNCRMNG_.tb4_1(0),
null,
0,
0,
'CONTRACT'
,
3037,
7230,
6);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb4_0(1):=1065814;
CNCRMNG_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CNCRMNG_.tb4_0(1):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb4_1(1):=CNCRMNG_.tb3_0(0);
CNCRMNG_.tb4_2(1):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,CONFIG_ID,PARENT_COMP_ID,MIN_OBJECTS,MAX_OBJECTS,TAG_NAME,ENTITY_TYPE_ID,EXTERNAL_TYPE_ID,CONFIG_TYPE_ID) 
VALUES (CNCRMNG_.tb4_0(1),
CNCRMNG_.tb4_1(1),
CNCRMNG_.tb4_2(1),
0,
0,
'PRODUCT'
,
3037,
7273,
6);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.tb5_0(0):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (0)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,PARENT_STATEMENT_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CNCRMNG_.tb5_0(0),
null,
'cc_boOssProduct.GetSubscriptionProducts'
,
'cc_boOssProduct.GetSubscription'
,
0,
'Y'
,
'Y'
,
'CONTRACT'
,
null,
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title /><Subtitle1 /><Subtitle2 /></OpenQueryHeaderTitle>'
,
'{PRODUCT_TYPE} ({SERVICE_NUMBER})'
,
null,
null,
null,
1,
'PARENT_ID'
,
'Productos'
,
'Y'
);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(0):=1146439;
CNCRMNG_.tb6_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(0):=CNCRMNG_.tb6_0(0);
CNCRMNG_.tb6_1(0):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(0),
CNCRMNG_.tb6_1(0),
null,
null,
-1,
null,
null,
-1,
-1,
4,
'Contrato'
,
null,
null,
null,
null,
null,
null,
'INUSUBSCRIPTION'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(0):=1599097;
CNCRMNG_.tb7_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(0):=CNCRMNG_.tb7_0(0);
CNCRMNG_.tb7_2(0):=CNCRMNG_.tb6_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(0),
null,
CNCRMNG_.tb7_2(0),
-1,
'Y'
,
'N'
,
4,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'INUSUBSCRIPTION'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(1):=1146440;
CNCRMNG_.tb6_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(1):=CNCRMNG_.tb6_0(1);
CNCRMNG_.tb6_1(1):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(1),
CNCRMNG_.tb6_1(1),
null,
null,
-1,
null,
null,
-1,
-1,
0,
'Identificacion'
,
null,
null,
null,
null,
null,
null,
'ISBIDENTIFICATION'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(1):=1599098;
CNCRMNG_.tb7_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(1):=CNCRMNG_.tb7_0(1);
CNCRMNG_.tb7_2(1):=CNCRMNG_.tb6_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(1),
null,
CNCRMNG_.tb7_2(1),
-1,
'Y'
,
'N'
,
0,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBIDENTIFICATION'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(2):=1146441;
CNCRMNG_.tb6_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(2):=CNCRMNG_.tb6_0(2);
CNCRMNG_.tb6_1(2):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(2),
CNCRMNG_.tb6_1(2),
null,
null,
-1,
null,
null,
-1,
-1,
1,
'Numero de Servicio'
,
null,
null,
null,
null,
null,
null,
'ISBPRODUCTSERVICENUMBER'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(2):=1599099;
CNCRMNG_.tb7_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(2):=CNCRMNG_.tb7_0(2);
CNCRMNG_.tb7_2(2):=CNCRMNG_.tb6_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(2),
null,
CNCRMNG_.tb7_2(2),
-1,
'Y'
,
'N'
,
1,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBPRODUCTSERVICENUMBER'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(3):=1146442;
CNCRMNG_.tb6_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(3):=CNCRMNG_.tb6_0(3);
CNCRMNG_.tb6_1(3):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(3),
CNCRMNG_.tb6_1(3),
null,
null,
-1,
null,
null,
-1,
-1,
2,
'Nombre'
,
null,
null,
null,
null,
null,
null,
'ISBNAME'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(3):=1599100;
CNCRMNG_.tb7_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(3):=CNCRMNG_.tb7_0(3);
CNCRMNG_.tb7_2(3):=CNCRMNG_.tb6_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(3),
null,
CNCRMNG_.tb7_2(3),
-1,
'Y'
,
'N'
,
2,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBNAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(4):=1146443;
CNCRMNG_.tb6_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(4):=CNCRMNG_.tb6_0(4);
CNCRMNG_.tb6_1(4):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(4),
CNCRMNG_.tb6_1(4),
null,
null,
-1,
null,
null,
-1,
-1,
3,
'Apellido'
,
null,
null,
null,
null,
null,
null,
'ISBLASTNAME'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(4):=1599101;
CNCRMNG_.tb7_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(4):=CNCRMNG_.tb7_0(4);
CNCRMNG_.tb7_2(4):=CNCRMNG_.tb6_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(4),
null,
CNCRMNG_.tb7_2(4),
-1,
'Y'
,
'N'
,
3,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBLASTNAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(5):=1146444;
CNCRMNG_.tb6_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(5):=CNCRMNG_.tb6_0(5);
CNCRMNG_.tb6_1(5):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(5),
CNCRMNG_.tb6_1(5),
null,
null,
-1,
null,
null,
-1,
-1,
5,
'Elemento de Medicion'
,
null,
null,
null,
null,
null,
null,
'ISBMETER'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(5):=1599102;
CNCRMNG_.tb7_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(5):=CNCRMNG_.tb7_0(5);
CNCRMNG_.tb7_2(5):=CNCRMNG_.tb6_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(5),
null,
CNCRMNG_.tb7_2(5),
-1,
'Y'
,
'N'
,
5,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBMETER'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(6):=1146455;
CNCRMNG_.tb6_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(6):=CNCRMNG_.tb6_0(6);
CNCRMNG_.tb6_1(6):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(6),
CNCRMNG_.tb6_1(6),
null,
null,
-1,
null,
null,
-1,
-1,
9,
'�Cual es la ruta?'
,
null,
null,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb8_0(0):=120194912;
CNCRMNG_.tb8_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CNCRMNG_.tb8_0(0):=CNCRMNG_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT fila (0)',1);
UPDATE GE_STATEMENT SET STATEMENT_ID=CNCRMNG_.tb8_0(0),
MODULE_ID=4,
DESCRIPTION='LOV de Rutas'
,
STATEMENT='SELECT distinct OR_route.route_id id, OR_route.name description
FROM ab_segments, OR_route
WHERE ab_segments.operating_sector_id = :INUOPERATINGSECTOR
  AND ab_segments.route_id = OR_route.route_id'
,
NAME='Rutas'

 WHERE STATEMENT_ID = CNCRMNG_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CNCRMNG_.tb8_0(0),
4,
'LOV de Rutas'
,
'SELECT distinct OR_route.route_id id, OR_route.name description
FROM ab_segments, OR_route
WHERE ab_segments.operating_sector_id = :INUOPERATINGSECTOR
  AND ab_segments.route_id = OR_route.route_id'
,
'Rutas'
);
end if;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(7):=1146445;
CNCRMNG_.tb6_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(7):=CNCRMNG_.tb6_0(7);
CNCRMNG_.tb6_1(7):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(7):=CNCRMNG_.tb6_0(6);
CNCRMNG_.tb6_3(7):=CNCRMNG_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(7),
CNCRMNG_.tb6_1(7),
CNCRMNG_.tb6_2(7),
CNCRMNG_.tb6_3(7),
-1,
null,
null,
-1,
-1,
11,
'Ruta'
,
null,
null,
null,
null,
null,
null,
'INUROUTEID'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(6):=1599103;
CNCRMNG_.tb7_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(6):=CNCRMNG_.tb7_0(6);
CNCRMNG_.tb7_2(6):=CNCRMNG_.tb6_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(6),
null,
CNCRMNG_.tb7_2(6),
-1,
'Y'
,
'N'
,
11,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
4,
'INUROUTEID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb8_0(1):=120194911;
CNCRMNG_.tb8_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CNCRMNG_.tb8_0(1):=CNCRMNG_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT fila (1)',1);
UPDATE GE_STATEMENT SET STATEMENT_ID=CNCRMNG_.tb8_0(1),
MODULE_ID=4,
DESCRIPTION='Seleccion del sector operativo'
,
STATEMENT='SELECT OPERATING_SECTOR_ID ID, DESCRIPTION DESCRIPTION FROM OR_OPERATING_SECTOR ORDER BY OPERATING_SECTOR_ID'
,
NAME='OPERATING_SECTOR'

 WHERE STATEMENT_ID = CNCRMNG_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CNCRMNG_.tb8_0(1),
4,
'Seleccion del sector operativo'
,
'SELECT OPERATING_SECTOR_ID ID, DESCRIPTION DESCRIPTION FROM OR_OPERATING_SECTOR ORDER BY OPERATING_SECTOR_ID'
,
'OPERATING_SECTOR'
);
end if;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(8):=1146446;
CNCRMNG_.tb6_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(8):=CNCRMNG_.tb6_0(8);
CNCRMNG_.tb6_1(8):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(8):=CNCRMNG_.tb6_0(6);
CNCRMNG_.tb6_3(8):=CNCRMNG_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(8),
CNCRMNG_.tb6_1(8),
CNCRMNG_.tb6_2(8),
CNCRMNG_.tb6_3(8),
-1,
null,
null,
-1,
-1,
10,
'Sector'
,
null,
null,
null,
null,
null,
null,
'INUOPERATINGSECTOR'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(7):=1599104;
CNCRMNG_.tb7_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(7):=CNCRMNG_.tb7_0(7);
CNCRMNG_.tb7_2(7):=CNCRMNG_.tb6_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(7),
null,
CNCRMNG_.tb7_2(7),
-1,
'Y'
,
'N'
,
10,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
4,
'INUOPERATINGSECTOR'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(16):=1599113;
CNCRMNG_.tb7_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(16):=CNCRMNG_.tb7_0(16);
CNCRMNG_.tb7_2(16):=CNCRMNG_.tb6_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(16),
null,
CNCRMNG_.tb7_2(16),
-1,
'Y'
,
'N'
,
9,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(9):=1146454;
CNCRMNG_.tb6_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(9):=CNCRMNG_.tb6_0(9);
CNCRMNG_.tb6_1(9):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(9),
CNCRMNG_.tb6_1(9),
null,
null,
-1,
null,
null,
-1,
-1,
8,
'�Cual es la direccion?'
,
null,
null,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(10):=1146447;
CNCRMNG_.tb6_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(10):=CNCRMNG_.tb6_0(10);
CNCRMNG_.tb6_1(10):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(10):=CNCRMNG_.tb6_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(10),
CNCRMNG_.tb6_1(10),
CNCRMNG_.tb6_2(10),
null,
-1,
null,
null,
-1,
-1,
12,
'Localidad'
,
null,
null,
null,
null,
null,
null,
'INUGEOGRAPHLOCATIONID'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(8):=1599105;
CNCRMNG_.tb7_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(8):=CNCRMNG_.tb7_0(8);
CNCRMNG_.tb7_2(8):=CNCRMNG_.tb6_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(8),
null,
CNCRMNG_.tb7_2(8),
-1,
'Y'
,
'N'
,
12,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
6,
'INUGEOGRAPHLOCATIONID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb8_0(2):=120194909;
CNCRMNG_.tb8_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CNCRMNG_.tb8_0(2):=CNCRMNG_.tb8_0(2);
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT fila (2)',1);
UPDATE GE_STATEMENT SET STATEMENT_ID=CNCRMNG_.tb8_0(2),
MODULE_ID=16,
DESCRIPTION='Seleccion de Barrio'
,
STATEMENT='SELECT geograp_location_id ID, display_description DESCRIPTION
FROM ge_geogra_location
WHERE geog_loca_area_type = AB_BOConstants.fnuObtTipoUbicacionBarrio
START WITH geograp_location_id = :INUGEOGRAPHLOCATIONID
CONNECT BY PRIOR geograp_location_id = geo_loca_father_id
ORDER BY 1'
,
NAME='Seleccion de Barrio'

 WHERE STATEMENT_ID = CNCRMNG_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CNCRMNG_.tb8_0(2),
16,
'Seleccion de Barrio'
,
'SELECT geograp_location_id ID, display_description DESCRIPTION
FROM ge_geogra_location
WHERE geog_loca_area_type = AB_BOConstants.fnuObtTipoUbicacionBarrio
START WITH geograp_location_id = :INUGEOGRAPHLOCATIONID
CONNECT BY PRIOR geograp_location_id = geo_loca_father_id
ORDER BY 1'
,
'Seleccion de Barrio'
);
end if;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(11):=1146448;
CNCRMNG_.tb6_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(11):=CNCRMNG_.tb6_0(11);
CNCRMNG_.tb6_1(11):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(11):=CNCRMNG_.tb6_0(9);
CNCRMNG_.tb6_3(11):=CNCRMNG_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(11),
CNCRMNG_.tb6_1(11),
CNCRMNG_.tb6_2(11),
CNCRMNG_.tb6_3(11),
-1,
null,
null,
-1,
-1,
13,
'Barrio'
,
null,
null,
null,
null,
null,
null,
'INUNEIGHBORTHOODID'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(9):=1599106;
CNCRMNG_.tb7_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(9):=CNCRMNG_.tb7_0(9);
CNCRMNG_.tb7_2(9):=CNCRMNG_.tb6_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(9),
null,
CNCRMNG_.tb7_2(9),
-1,
'Y'
,
'N'
,
13,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
4,
'INUNEIGHBORTHOODID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(12):=1146449;
CNCRMNG_.tb6_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(12):=CNCRMNG_.tb6_0(12);
CNCRMNG_.tb6_1(12):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(12):=CNCRMNG_.tb6_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(12),
CNCRMNG_.tb6_1(12),
CNCRMNG_.tb6_2(12),
null,
-1,
null,
null,
-1,
-1,
14,
'Direccion'
,
null,
null,
null,
null,
null,
null,
'ISBADDRESSSTRING'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(10):=1599107;
CNCRMNG_.tb7_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(10):=CNCRMNG_.tb7_0(10);
CNCRMNG_.tb7_2(10):=CNCRMNG_.tb6_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(10),
null,
CNCRMNG_.tb7_2(10),
-1,
'Y'
,
'N'
,
14,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBADDRESSSTRING'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(15):=1599112;
CNCRMNG_.tb7_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(15):=CNCRMNG_.tb7_0(15);
CNCRMNG_.tb7_2(15):=CNCRMNG_.tb6_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(15),
null,
CNCRMNG_.tb7_2(15),
-1,
'Y'
,
'N'
,
8,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(13):=1146450;
CNCRMNG_.tb6_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(13):=CNCRMNG_.tb6_0(13);
CNCRMNG_.tb6_1(13):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(13),
CNCRMNG_.tb6_1(13),
null,
null,
-1,
null,
null,
-1,
-1,
6,
'Numero de Servicio del Componente'
,
null,
null,
null,
null,
null,
null,
'ISBCOMPSERVICENUMBER'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(11):=1599108;
CNCRMNG_.tb7_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(11):=CNCRMNG_.tb7_0(11);
CNCRMNG_.tb7_2(11):=CNCRMNG_.tb6_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(11),
null,
CNCRMNG_.tb7_2(11),
-1,
'Y'
,
'N'
,
6,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBCOMPSERVICENUMBER'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(14):=1146456;
CNCRMNG_.tb6_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(14):=CNCRMNG_.tb6_0(14);
CNCRMNG_.tb6_1(14):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(14),
CNCRMNG_.tb6_1(14),
null,
null,
-1,
null,
null,
-1,
-1,
10,
'Figuracion'
,
null,
null,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(15):=1146451;
CNCRMNG_.tb6_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(15):=CNCRMNG_.tb6_0(15);
CNCRMNG_.tb6_1(15):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(15):=CNCRMNG_.tb6_0(14);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(15),
CNCRMNG_.tb6_1(15),
CNCRMNG_.tb6_2(15),
null,
-1,
null,
null,
-1,
-1,
7,
'Tipo de Figuracion'
,
null,
null,
null,
null,
null,
null,
'INUFIGURETYPEID'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(12):=1599109;
CNCRMNG_.tb7_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(12):=CNCRMNG_.tb7_0(12);
CNCRMNG_.tb7_2(12):=CNCRMNG_.tb6_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(12),
null,
CNCRMNG_.tb7_2(12),
-1,
'Y'
,
'N'
,
7,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'INUFIGURETYPEID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(16):=1146452;
CNCRMNG_.tb6_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(16):=CNCRMNG_.tb6_0(16);
CNCRMNG_.tb6_1(16):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(16):=CNCRMNG_.tb6_0(14);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(16),
CNCRMNG_.tb6_1(16),
CNCRMNG_.tb6_2(16),
null,
-1,
null,
null,
-1,
-1,
9,
'Alias'
,
null,
null,
null,
null,
null,
null,
'ISBALIAS'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(13):=1599110;
CNCRMNG_.tb7_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(13):=CNCRMNG_.tb7_0(13);
CNCRMNG_.tb7_2(13):=CNCRMNG_.tb6_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(13),
null,
CNCRMNG_.tb7_2(13),
-1,
'Y'
,
'N'
,
9,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBALIAS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(17):=1146453;
CNCRMNG_.tb6_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(17):=CNCRMNG_.tb6_0(17);
CNCRMNG_.tb6_1(17):=CNCRMNG_.tb4_0(1);
CNCRMNG_.tb6_2(17):=CNCRMNG_.tb6_0(14);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(17),
CNCRMNG_.tb6_1(17),
CNCRMNG_.tb6_2(17),
null,
-1,
null,
null,
-1,
-1,
8,
'Nombre de Figuracion'
,
null,
null,
null,
null,
null,
null,
'ISBNOMBREFIGURACION'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(14):=1599111;
CNCRMNG_.tb7_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(14):=CNCRMNG_.tb7_0(14);
CNCRMNG_.tb7_2(14):=CNCRMNG_.tb6_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(14),
null,
CNCRMNG_.tb7_2(14),
-1,
'Y'
,
'N'
,
8,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBNOMBREFIGURACION'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(17):=1599114;
CNCRMNG_.tb7_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(17):=CNCRMNG_.tb7_0(17);
CNCRMNG_.tb7_2(17):=CNCRMNG_.tb6_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(17),
null,
CNCRMNG_.tb7_2(17),
-1,
'Y'
,
'N'
,
10,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb9_0(0):=2301;
CNCRMNG_.tb9_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CNCRMNG_.tb9_0(0):=CNCRMNG_.tb9_0(0);
CNCRMNG_.tb9_1(0):=CNCRMNG_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,DESCRIPTION,ORDER_VIEW,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID) 
VALUES (CNCRMNG_.tb9_0(0),
CNCRMNG_.tb9_1(0),
'PRODUCT'
,
0,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(18):=1599041;
CNCRMNG_.tb7_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(18):=CNCRMNG_.tb7_0(18);
CNCRMNG_.tb7_1(18):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(18),
CNCRMNG_.tb7_1(18),
null,
null,
'Y'
,
'N'
,
0,
'N'
,
'Producto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PRODUCT_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(19):=1599042;
CNCRMNG_.tb7_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(19):=CNCRMNG_.tb7_0(19);
CNCRMNG_.tb7_1(19):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(19),
CNCRMNG_.tb7_1(19),
null,
null,
'Y'
,
'N'
,
1,
'N'
,
'Tipo de Producto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PRODUCT_TYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(20):=1599043;
CNCRMNG_.tb7_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(20):=CNCRMNG_.tb7_0(20);
CNCRMNG_.tb7_1(20):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(20),
CNCRMNG_.tb7_1(20),
null,
null,
'Y'
,
'N'
,
2,
'N'
,
'Producto Base'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PRODUCT_BASE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(21):=1599044;
CNCRMNG_.tb7_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(21):=CNCRMNG_.tb7_0(21);
CNCRMNG_.tb7_1(21):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(21),
CNCRMNG_.tb7_1(21),
null,
null,
'Y'
,
'N'
,
3,
'N'
,
'Privado'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'IS_PRIVATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(22):=1599045;
CNCRMNG_.tb7_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(22):=CNCRMNG_.tb7_0(22);
CNCRMNG_.tb7_1(22):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(22),
CNCRMNG_.tb7_1(22),
null,
null,
'Y'
,
'N'
,
4,
'N'
,
'Contrato'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIPTION_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(23):=1599046;
CNCRMNG_.tb7_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(23):=CNCRMNG_.tb7_0(23);
CNCRMNG_.tb7_1(23):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(23),
CNCRMNG_.tb7_1(23),
null,
null,
'Y'
,
'N'
,
5,
'N'
,
'Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(24):=1599047;
CNCRMNG_.tb7_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(24):=CNCRMNG_.tb7_0(24);
CNCRMNG_.tb7_1(24):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(24),
CNCRMNG_.tb7_1(24),
null,
null,
'Y'
,
'N'
,
6,
'N'
,
'Numero de Servicio'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SERVICE_NUMBER'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(25):=1599048;
CNCRMNG_.tb7_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(25):=CNCRMNG_.tb7_0(25);
CNCRMNG_.tb7_1(25):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(25),
CNCRMNG_.tb7_1(25),
null,
null,
'Y'
,
'N'
,
7,
'N'
,
'Nombre'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_NAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(26):=1599049;
CNCRMNG_.tb7_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(26):=CNCRMNG_.tb7_0(26);
CNCRMNG_.tb7_1(26):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(26),
CNCRMNG_.tb7_1(26),
null,
null,
'Y'
,
'N'
,
8,
'N'
,
'Plan Comercial'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'COMMERCIAL_PLAN_'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(27):=1599050;
CNCRMNG_.tb7_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(27):=CNCRMNG_.tb7_0(27);
CNCRMNG_.tb7_1(27):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(27),
CNCRMNG_.tb7_1(27),
null,
null,
'Y'
,
'N'
,
9,
'N'
,
'Tipo Identificacion Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_IDENTTYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(28):=1599051;
CNCRMNG_.tb7_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(28):=CNCRMNG_.tb7_0(28);
CNCRMNG_.tb7_1(28):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(28),
CNCRMNG_.tb7_1(28),
null,
null,
'Y'
,
'N'
,
10,
'N'
,
'Identificacion Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_IDENT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(29):=1599052;
CNCRMNG_.tb7_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(29):=CNCRMNG_.tb7_0(29);
CNCRMNG_.tb7_1(29):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(29),
CNCRMNG_.tb7_1(29),
null,
null,
'N'
,
'N'
,
11,
'N'
,
'Estado Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_STATUS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(30):=1599053;
CNCRMNG_.tb7_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(30):=CNCRMNG_.tb7_0(30);
CNCRMNG_.tb7_1(30):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(30),
CNCRMNG_.tb7_1(30),
null,
null,
'N'
,
'N'
,
12,
'N'
,
'Segmento de Mercado Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_MARKSEG'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(31):=1599054;
CNCRMNG_.tb7_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(31):=CNCRMNG_.tb7_0(31);
CNCRMNG_.tb7_1(31):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(31),
CNCRMNG_.tb7_1(31),
null,
null,
'N'
,
'N'
,
13,
'N'
,
'Direccion de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_CONTACADDR'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(32):=1599055;
CNCRMNG_.tb7_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(32):=CNCRMNG_.tb7_0(32);
CNCRMNG_.tb7_1(32):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(32),
CNCRMNG_.tb7_1(32),
null,
null,
'Y'
,
'N'
,
14,
'N'
,
'Categoria'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'USE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(33):=1599056;
CNCRMNG_.tb7_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(33):=CNCRMNG_.tb7_0(33);
CNCRMNG_.tb7_1(33):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(33),
CNCRMNG_.tb7_1(33),
null,
null,
'Y'
,
'N'
,
15,
'N'
,
'Subcategoria'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'STRATUM'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(34):=1599057;
CNCRMNG_.tb7_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(34):=CNCRMNG_.tb7_0(34);
CNCRMNG_.tb7_1(34):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(34),
CNCRMNG_.tb7_1(34),
null,
null,
'N'
,
'N'
,
16,
'N'
,
'Telefono de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_CONTACPHON'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(35):=1599058;
CNCRMNG_.tb7_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(35):=CNCRMNG_.tb7_0(35);
CNCRMNG_.tb7_1(35):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(35),
CNCRMNG_.tb7_1(35),
null,
null,
'Y'
,
'N'
,
17,
'N'
,
'URL Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_URL'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(36):=1599059;
CNCRMNG_.tb7_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(36):=CNCRMNG_.tb7_0(36);
CNCRMNG_.tb7_1(36):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(36),
CNCRMNG_.tb7_1(36),
null,
null,
'Y'
,
'N'
,
18,
'N'
,
'Correo Electronico'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_EMAIL'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(37):=1599060;
CNCRMNG_.tb7_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(37):=CNCRMNG_.tb7_0(37);
CNCRMNG_.tb7_1(37):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(37),
CNCRMNG_.tb7_1(37),
null,
null,
'Y'
,
'N'
,
19,
'N'
,
'Cuentas con Saldo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ACCOUNT_WITH_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(38):=1599061;
CNCRMNG_.tb7_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(38):=CNCRMNG_.tb7_0(38);
CNCRMNG_.tb7_1(38):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(38),
CNCRMNG_.tb7_1(38),
null,
null,
'Y'
,
'N'
,
20,
'N'
,
'Estado de Corte'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FINANCIAL_STATUS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(39):=1599062;
CNCRMNG_.tb7_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(39):=CNCRMNG_.tb7_0(39);
CNCRMNG_.tb7_1(39):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(39),
CNCRMNG_.tb7_1(39),
null,
null,
'Y'
,
'N'
,
21,
'N'
,
'Estado Financiero'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FINAN_STAT_PROD'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(40):=1599063;
CNCRMNG_.tb7_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(40):=CNCRMNG_.tb7_0(40);
CNCRMNG_.tb7_1(40):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(40),
CNCRMNG_.tb7_1(40),
null,
null,
'Y'
,
'N'
,
22,
'N'
,
'Saldo Pendiente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PENDING_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(41):=1599064;
CNCRMNG_.tb7_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(41):=CNCRMNG_.tb7_0(41);
CNCRMNG_.tb7_1(41):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(41),
CNCRMNG_.tb7_1(41),
null,
null,
'Y'
,
'N'
,
23,
'N'
,
'Saldo en Reclamo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CLAIM_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(42):=1599065;
CNCRMNG_.tb7_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(42):=CNCRMNG_.tb7_0(42);
CNCRMNG_.tb7_1(42):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(42),
CNCRMNG_.tb7_1(42),
null,
null,
'Y'
,
'N'
,
24,
'N'
,
'Saldo en Reclamo por Pago no Abonado'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CLAIM_BALANCE_NO_PAID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(43):=1599066;
CNCRMNG_.tb7_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(43):=CNCRMNG_.tb7_0(43);
CNCRMNG_.tb7_1(43):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(43),
CNCRMNG_.tb7_1(43),
null,
null,
'Y'
,
'N'
,
25,
'N'
,
'Fecha de Instalacion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'INSTALL_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(44):=1599067;
CNCRMNG_.tb7_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(44):=CNCRMNG_.tb7_0(44);
CNCRMNG_.tb7_1(44):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(44),
CNCRMNG_.tb7_1(44),
null,
null,
'Y'
,
'N'
,
26,
'N'
,
'Fecha de Retiro'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'RETIRE_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(45):=1599068;
CNCRMNG_.tb7_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(45):=CNCRMNG_.tb7_0(45);
CNCRMNG_.tb7_1(45):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(45),
CNCRMNG_.tb7_1(45),
null,
null,
'N'
,
'N'
,
27,
'N'
,
'Codigo del Padre'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PARENT_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(46):=1599069;
CNCRMNG_.tb7_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(46):=CNCRMNG_.tb7_0(46);
CNCRMNG_.tb7_1(46):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(46),
CNCRMNG_.tb7_1(46),
null,
null,
'Y'
,
'N'
,
28,
'N'
,
'Saldo a Favor'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FAVOR_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(47):=1599070;
CNCRMNG_.tb7_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(47):=CNCRMNG_.tb7_0(47);
CNCRMNG_.tb7_1(47):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(47),
CNCRMNG_.tb7_1(47),
null,
null,
'Y'
,
'N'
,
29,
'N'
,
'Fin Provisionalidad'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PROVISIONAL_END_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(48):=1599071;
CNCRMNG_.tb7_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(48):=CNCRMNG_.tb7_0(48);
CNCRMNG_.tb7_1(48):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(48),
CNCRMNG_.tb7_1(48),
null,
null,
'Y'
,
'N'
,
30,
'N'
,
'Provisional'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'IS_PROVISIONAL'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(49):=1599072;
CNCRMNG_.tb7_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(49):=CNCRMNG_.tb7_0(49);
CNCRMNG_.tb7_1(49):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(49),
CNCRMNG_.tb7_1(49),
null,
null,
'Y'
,
'N'
,
31,
'N'
,
'Inicio Provisionalidad'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PROVISIONAL_BEG_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(50):=1599073;
CNCRMNG_.tb7_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(50):=CNCRMNG_.tb7_0(50);
CNCRMNG_.tb7_1(50):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(50),
CNCRMNG_.tb7_1(50),
null,
null,
'Y'
,
'N'
,
32,
'N'
,
'Unidades Habitacionales'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'MULTIFAMILY'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(51):=1599074;
CNCRMNG_.tb7_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(51):=CNCRMNG_.tb7_0(51);
CNCRMNG_.tb7_1(51):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(51),
CNCRMNG_.tb7_1(51),
null,
null,
'Y'
,
'N'
,
33,
'N'
,
'Limite Credito'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CREDIT_LIMIT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(52):=1599075;
CNCRMNG_.tb7_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(52):=CNCRMNG_.tb7_0(52);
CNCRMNG_.tb7_1(52):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(52),
CNCRMNG_.tb7_1(52),
null,
null,
'Y'
,
'N'
,
34,
'N'
,
'Tipo de Medicion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'TIPOMED'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(53):=1599076;
CNCRMNG_.tb7_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(53):=CNCRMNG_.tb7_0(53);
CNCRMNG_.tb7_1(53):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(53),
CNCRMNG_.tb7_1(53),
null,
null,
'Y'
,
'N'
,
35,
'N'
,
'Tipo de Prorrateo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PRORRATEO'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(54):=1599077;
CNCRMNG_.tb7_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(54):=CNCRMNG_.tb7_0(54);
CNCRMNG_.tb7_1(54):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(54),
CNCRMNG_.tb7_1(54),
null,
null,
'Y'
,
'N'
,
36,
'N'
,
'Conjunto de incluidos'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'INCLUDED_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(55):=1599078;
CNCRMNG_.tb7_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(55):=CNCRMNG_.tb7_0(55);
CNCRMNG_.tb7_1(55):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(55),
CNCRMNG_.tb7_1(55),
null,
null,
'Y'
,
'N'
,
37,
'N'
,
'Tipo de Tecnologia'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'TECHNOLOGY_TYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(56):=1599079;
CNCRMNG_.tb7_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(56):=CNCRMNG_.tb7_0(56);
CNCRMNG_.tb7_1(56):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(56),
CNCRMNG_.tb7_1(56),
null,
null,
'Y'
,
'N'
,
38,
'N'
,
'Distribucion Administrativa'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'DISTRIBUT_ADMIN'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(57):=1599080;
CNCRMNG_.tb7_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(57):=CNCRMNG_.tb7_0(57);
CNCRMNG_.tb7_1(57):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(57),
CNCRMNG_.tb7_1(57),
null,
null,
'Y'
,
'N'
,
39,
'N'
,
'Comuna'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'COMMUNE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(58):=1599081;
CNCRMNG_.tb7_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(58):=CNCRMNG_.tb7_0(58);
CNCRMNG_.tb7_1(58):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (58)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(58),
CNCRMNG_.tb7_1(58),
null,
null,
'Y'
,
'N'
,
40,
'N'
,
'Direccion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ADDRESS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(59):=1599082;
CNCRMNG_.tb7_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(59):=CNCRMNG_.tb7_0(59);
CNCRMNG_.tb7_1(59):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (59)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(59),
CNCRMNG_.tb7_1(59),
null,
null,
'Y'
,
'N'
,
41,
'N'
,
'Ubic. Geografica de Direccion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ADD_GEO_LOC_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(60):=1599083;
CNCRMNG_.tb7_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(60):=CNCRMNG_.tb7_0(60);
CNCRMNG_.tb7_1(60):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (60)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(60),
CNCRMNG_.tb7_1(60),
null,
null,
'Y'
,
'N'
,
42,
'N'
,
'Barrio de Direccion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ADD_NEIGHBOR_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(61):=1599084;
CNCRMNG_.tb7_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(61):=CNCRMNG_.tb7_0(61);
CNCRMNG_.tb7_1(61):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (61)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(61),
CNCRMNG_.tb7_1(61),
null,
null,
'Y'
,
'N'
,
43,
'N'
,
'Empresa'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'COMPANY'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(62):=1599085;
CNCRMNG_.tb7_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(62):=CNCRMNG_.tb7_0(62);
CNCRMNG_.tb7_1(62):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (62)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(62),
CNCRMNG_.tb7_1(62),
null,
null,
'Y'
,
'N'
,
44,
'N'
,
'Estado del Producto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PRODUCT_STATUS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(63):=1599086;
CNCRMNG_.tb7_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(63):=CNCRMNG_.tb7_0(63);
CNCRMNG_.tb7_1(63):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (63)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(63),
CNCRMNG_.tb7_1(63),
null,
null,
'Y'
,
'N'
,
45,
'N'
,
'Fecha Expiracion Plan'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'EXPIRATION_OF_PLAN'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(64):=1599087;
CNCRMNG_.tb7_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(64):=CNCRMNG_.tb7_0(64);
CNCRMNG_.tb7_1(64):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (64)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(64),
CNCRMNG_.tb7_1(64),
null,
null,
'Y'
,
'N'
,
46,
'N'
,
'Dias de Permanencia Minima'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PERMANENCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(65):=1599088;
CNCRMNG_.tb7_0(65):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(65):=CNCRMNG_.tb7_0(65);
CNCRMNG_.tb7_1(65):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (65)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(65),
CNCRMNG_.tb7_1(65),
null,
null,
'Y'
,
'N'
,
47,
'N'
,
'ultima Fecha de Facturacion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'BILL_LAST_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(66):=1599089;
CNCRMNG_.tb7_0(66):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(66):=CNCRMNG_.tb7_0(66);
CNCRMNG_.tb7_1(66):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (66)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(66),
CNCRMNG_.tb7_1(66),
null,
null,
'Y'
,
'N'
,
48,
'N'
,
'Fecha Programada para Baja'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PROD_RETIRE_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(67):=1599090;
CNCRMNG_.tb7_0(67):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(67):=CNCRMNG_.tb7_0(67);
CNCRMNG_.tb7_1(67):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (67)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(67),
CNCRMNG_.tb7_1(67),
null,
null,
'Y'
,
'N'
,
49,
'N'
,
'Telefono de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBS_PHONE_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(68):=1599091;
CNCRMNG_.tb7_0(68):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(68):=CNCRMNG_.tb7_0(68);
CNCRMNG_.tb7_1(68):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (68)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(68),
CNCRMNG_.tb7_1(68),
null,
null,
'Y'
,
'N'
,
50,
'N'
,
'Total Perio. Facturado Normal'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'METCAL_NORMAL'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(69):=1599092;
CNCRMNG_.tb7_0(69):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(69):=CNCRMNG_.tb7_0(69);
CNCRMNG_.tb7_1(69):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (69)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(69),
CNCRMNG_.tb7_1(69),
null,
null,
'Y'
,
'N'
,
51,
'N'
,
'Total Perio. Facturado Estimado'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'METCAL_ESTIMA'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(70):=1599093;
CNCRMNG_.tb7_0(70):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(70):=CNCRMNG_.tb7_0(70);
CNCRMNG_.tb7_1(70):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (70)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(70),
CNCRMNG_.tb7_1(70),
null,
null,
'Y'
,
'N'
,
52,
'N'
,
'Cartera Castigada'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PUNISH_VALUE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(71):=1599094;
CNCRMNG_.tb7_0(71):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(71):=CNCRMNG_.tb7_0(71);
CNCRMNG_.tb7_1(71):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (71)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(71),
CNCRMNG_.tb7_1(71),
null,
null,
'Y'
,
'N'
,
53,
'N'
,
'Financiaciones sobre Cartera No Vencida'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FINANCING_COUNT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(72):=1599095;
CNCRMNG_.tb7_0(72):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(72):=CNCRMNG_.tb7_0(72);
CNCRMNG_.tb7_1(72):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (72)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(72),
CNCRMNG_.tb7_1(72),
null,
null,
'Y'
,
'N'
,
54,
'N'
,
'Financiaciones sobre Cartera Vencida'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FINAN_ON_EXP_DEBT_COUNT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(73):=1599096;
CNCRMNG_.tb7_0(73):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(73):=CNCRMNG_.tb7_0(73);
CNCRMNG_.tb7_1(73):=CNCRMNG_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (73)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(73),
CNCRMNG_.tb7_1(73),
null,
null,
'Y'
,
'N'
,
55,
'N'
,
'Cambios de Condiciones de Financiacion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CHANGE_COND_COUNT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.tb5_0(1):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (1)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,PARENT_STATEMENT_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CNCRMNG_.tb5_0(1),
null,
null,
null,
0,
'Y'
,
'Y'
,
null,
null,
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title /><Subtitle1 /><Subtitle2 /></OpenQueryHeaderTitle>'
,
'Contratos'
,
null,
null,
null,
0,
'PARENT_ID'
,
'Contratos'
,
'Y'
);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(18):=1146457;
CNCRMNG_.tb6_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(18):=CNCRMNG_.tb6_0(18);
CNCRMNG_.tb6_1(18):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(18),
CNCRMNG_.tb6_1(18),
null,
null,
-1,
null,
null,
-1,
-1,
5,
'Opciones adicionales de Busqueda'
,
null,
null,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(19):=1146430;
CNCRMNG_.tb6_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(19):=CNCRMNG_.tb6_0(19);
CNCRMNG_.tb6_1(19):=CNCRMNG_.tb4_0(0);
CNCRMNG_.tb6_2(19):=CNCRMNG_.tb6_0(18);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(19),
CNCRMNG_.tb6_1(19),
CNCRMNG_.tb6_2(19),
null,
-1,
null,
null,
-1,
-1,
4,
'Contrato'
,
null,
null,
null,
null,
null,
null,
'INUSUBSCRIPTION'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(74):=1599032;
CNCRMNG_.tb7_0(74):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(74):=CNCRMNG_.tb7_0(74);
CNCRMNG_.tb7_2(74):=CNCRMNG_.tb6_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (74)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(74),
null,
CNCRMNG_.tb7_2(74),
-1,
'Y'
,
'N'
,
4,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'INUSUBSCRIPTION'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(24):=1146435;
CNCRMNG_.tb6_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(24):=CNCRMNG_.tb6_0(24);
CNCRMNG_.tb6_1(24):=CNCRMNG_.tb4_0(0);
CNCRMNG_.tb6_2(24):=CNCRMNG_.tb6_0(18);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(24),
CNCRMNG_.tb6_1(24),
CNCRMNG_.tb6_2(24),
null,
-1,
null,
null,
-1,
-1,
5,
'Correo electronico'
,
null,
null,
null,
null,
null,
null,
'ISBEMAIL'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(79):=1599037;
CNCRMNG_.tb7_0(79):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(79):=CNCRMNG_.tb7_0(79);
CNCRMNG_.tb7_2(79):=CNCRMNG_.tb6_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (79)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(79),
null,
CNCRMNG_.tb7_2(79),
-1,
'Y'
,
'N'
,
5,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBEMAIL'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(25):=1146436;
CNCRMNG_.tb6_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(25):=CNCRMNG_.tb6_0(25);
CNCRMNG_.tb6_1(25):=CNCRMNG_.tb4_0(0);
CNCRMNG_.tb6_2(25):=CNCRMNG_.tb6_0(18);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(25),
CNCRMNG_.tb6_1(25),
CNCRMNG_.tb6_2(25),
null,
-1,
null,
null,
-1,
-1,
6,
'Localidad'
,
null,
null,
null,
null,
null,
null,
'INUGEOGRAPHLOCATIONID'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(80):=1599038;
CNCRMNG_.tb7_0(80):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(80):=CNCRMNG_.tb7_0(80);
CNCRMNG_.tb7_2(80):=CNCRMNG_.tb6_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (80)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(80),
null,
CNCRMNG_.tb7_2(80),
-1,
'Y'
,
'N'
,
6,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
6,
'INUGEOGRAPHLOCATIONID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb8_0(3):=120194910;
CNCRMNG_.tb8_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CNCRMNG_.tb8_0(3):=CNCRMNG_.tb8_0(3);
ut_trace.trace('Actualizar o insertar tabla: GE_STATEMENT fila (3)',1);
UPDATE GE_STATEMENT SET STATEMENT_ID=CNCRMNG_.tb8_0(3),
MODULE_ID=12,
DESCRIPTION='Consulta de Barrio'
,
STATEMENT='SELECT geograp_location_id ID, display_description DESCRIPTION
FROM ge_geogra_location
WHERE geog_loca_area_type = AB_BOConstants.fnuObtTipoUbicacionBarrio
START WITH geograp_location_id = :INUGEOGRAPHLOCATIONID
CONNECT BY PRIOR geograp_location_id = geo_loca_father_id
ORDER BY 1'
,
NAME='NEIGHTBORTHOOD'

 WHERE STATEMENT_ID = CNCRMNG_.tb8_0(3);
if not (sql%found) then
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CNCRMNG_.tb8_0(3),
12,
'Consulta de Barrio'
,
'SELECT geograp_location_id ID, display_description DESCRIPTION
FROM ge_geogra_location
WHERE geog_loca_area_type = AB_BOConstants.fnuObtTipoUbicacionBarrio
START WITH geograp_location_id = :INUGEOGRAPHLOCATIONID
CONNECT BY PRIOR geograp_location_id = geo_loca_father_id
ORDER BY 1'
,
'NEIGHTBORTHOOD'
);
end if;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(26):=1146437;
CNCRMNG_.tb6_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(26):=CNCRMNG_.tb6_0(26);
CNCRMNG_.tb6_1(26):=CNCRMNG_.tb4_0(0);
CNCRMNG_.tb6_2(26):=CNCRMNG_.tb6_0(18);
CNCRMNG_.tb6_3(26):=CNCRMNG_.tb8_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(26),
CNCRMNG_.tb6_1(26),
CNCRMNG_.tb6_2(26),
CNCRMNG_.tb6_3(26),
-1,
null,
null,
-1,
-1,
7,
'Barrrio'
,
null,
null,
null,
null,
null,
null,
'INUNEIGHBORTHOODID'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(81):=1599039;
CNCRMNG_.tb7_0(81):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(81):=CNCRMNG_.tb7_0(81);
CNCRMNG_.tb7_2(81):=CNCRMNG_.tb6_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (81)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(81),
null,
CNCRMNG_.tb7_2(81),
-1,
'Y'
,
'N'
,
7,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
4,
'INUNEIGHBORTHOODID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(27):=1146438;
CNCRMNG_.tb6_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(27):=CNCRMNG_.tb6_0(27);
CNCRMNG_.tb6_1(27):=CNCRMNG_.tb4_0(0);
CNCRMNG_.tb6_2(27):=CNCRMNG_.tb6_0(18);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(27),
CNCRMNG_.tb6_1(27),
CNCRMNG_.tb6_2(27),
null,
-1,
null,
null,
-1,
-1,
8,
'Direccion'
,
null,
null,
null,
null,
null,
null,
'ISBADDRESSSTRING'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(82):=1599040;
CNCRMNG_.tb7_0(82):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(82):=CNCRMNG_.tb7_0(82);
CNCRMNG_.tb7_2(82):=CNCRMNG_.tb6_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (82)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(82),
null,
CNCRMNG_.tb7_2(82),
-1,
'Y'
,
'N'
,
8,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBADDRESSSTRING'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(83):=1599115;
CNCRMNG_.tb7_0(83):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(83):=CNCRMNG_.tb7_0(83);
CNCRMNG_.tb7_2(83):=CNCRMNG_.tb6_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (83)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(83),
null,
CNCRMNG_.tb7_2(83),
-1,
'Y'
,
'N'
,
5,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
null,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(20):=1146431;
CNCRMNG_.tb6_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(20):=CNCRMNG_.tb6_0(20);
CNCRMNG_.tb6_1(20):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(20),
CNCRMNG_.tb6_1(20),
null,
null,
-1,
null,
null,
-1,
-1,
0,
'Identificacion'
,
null,
null,
null,
null,
null,
null,
'ISBIDENTIFICATION'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(75):=1599033;
CNCRMNG_.tb7_0(75):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(75):=CNCRMNG_.tb7_0(75);
CNCRMNG_.tb7_2(75):=CNCRMNG_.tb6_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (75)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(75),
null,
CNCRMNG_.tb7_2(75),
-1,
'Y'
,
'N'
,
0,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBIDENTIFICATION'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(21):=1146432;
CNCRMNG_.tb6_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(21):=CNCRMNG_.tb6_0(21);
CNCRMNG_.tb6_1(21):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(21),
CNCRMNG_.tb6_1(21),
null,
null,
-1,
null,
null,
-1,
-1,
1,
'Nombre'
,
null,
null,
null,
null,
null,
null,
'ISBNAME'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(76):=1599034;
CNCRMNG_.tb7_0(76):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(76):=CNCRMNG_.tb7_0(76);
CNCRMNG_.tb7_2(76):=CNCRMNG_.tb6_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (76)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(76),
null,
CNCRMNG_.tb7_2(76),
-1,
'Y'
,
'N'
,
1,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBNAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(22):=1146433;
CNCRMNG_.tb6_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(22):=CNCRMNG_.tb6_0(22);
CNCRMNG_.tb6_1(22):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(22),
CNCRMNG_.tb6_1(22),
null,
null,
-1,
null,
null,
-1,
-1,
2,
'Apellido'
,
null,
null,
null,
null,
null,
null,
'ISBLASTNAME'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(77):=1599035;
CNCRMNG_.tb7_0(77):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(77):=CNCRMNG_.tb7_0(77);
CNCRMNG_.tb7_2(77):=CNCRMNG_.tb6_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (77)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(77),
null,
CNCRMNG_.tb7_2(77),
-1,
'Y'
,
'N'
,
2,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBLASTNAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb6_0(23):=1146434;
CNCRMNG_.tb6_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CNCRMNG_.tb6_0(23):=CNCRMNG_.tb6_0(23);
CNCRMNG_.tb6_1(23):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (CNCRMNG_.tb6_0(23),
CNCRMNG_.tb6_1(23),
null,
null,
-1,
null,
null,
-1,
-1,
3,
'Telefono de contacto'
,
null,
null,
null,
null,
null,
null,
'ISBCONTACTPHONE'
,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(78):=1599036;
CNCRMNG_.tb7_0(78):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(78):=CNCRMNG_.tb7_0(78);
CNCRMNG_.tb7_2(78):=CNCRMNG_.tb6_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (78)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(78),
null,
CNCRMNG_.tb7_2(78),
-1,
'Y'
,
'N'
,
3,
'N'
,
null,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ISBCONTACTPHONE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb9_0(1):=2300;
CNCRMNG_.tb9_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CNCRMNG_.tb9_0(1):=CNCRMNG_.tb9_0(1);
CNCRMNG_.tb9_1(1):=CNCRMNG_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,DESCRIPTION,ORDER_VIEW,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID) 
VALUES (CNCRMNG_.tb9_0(1),
CNCRMNG_.tb9_1(1),
'CONTRACT'
,
0,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(84):=1598985;
CNCRMNG_.tb7_0(84):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(84):=CNCRMNG_.tb7_0(84);
CNCRMNG_.tb7_1(84):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (84)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(84),
CNCRMNG_.tb7_1(84),
null,
null,
'N'
,
'N'
,
0,
'N'
,
'Codigo del Padre'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PARENT_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(85):=1598986;
CNCRMNG_.tb7_0(85):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(85):=CNCRMNG_.tb7_0(85);
CNCRMNG_.tb7_1(85):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (85)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(85),
CNCRMNG_.tb7_1(85),
null,
null,
'Y'
,
'N'
,
1,
'N'
,
'Contrato'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIPTION_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(86):=1598987;
CNCRMNG_.tb7_0(86):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(86):=CNCRMNG_.tb7_0(86);
CNCRMNG_.tb7_1(86):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (86)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(86),
CNCRMNG_.tb7_1(86),
null,
null,
'Y'
,
'N'
,
2,
'N'
,
'Direccion de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CONTACT_ADDRESS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(87):=1598988;
CNCRMNG_.tb7_0(87):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(87):=CNCRMNG_.tb7_0(87);
CNCRMNG_.tb7_1(87):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (87)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(87),
CNCRMNG_.tb7_1(87),
null,
null,
'Y'
,
'N'
,
3,
'N'
,
'Nombre'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIPTION_NAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(88):=1598989;
CNCRMNG_.tb7_0(88):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(88):=CNCRMNG_.tb7_0(88);
CNCRMNG_.tb7_1(88):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (88)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(88),
CNCRMNG_.tb7_1(88),
null,
null,
'Y'
,
'N'
,
4,
'N'
,
'Barrio de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CONTACT_NEIGHBORHOOD'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(89):=1598990;
CNCRMNG_.tb7_0(89):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(89):=CNCRMNG_.tb7_0(89);
CNCRMNG_.tb7_1(89):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (89)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(89),
CNCRMNG_.tb7_1(89),
null,
null,
'Y'
,
'N'
,
5,
'N'
,
'Apellido'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBS_LAST_NAME'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(90):=1598991;
CNCRMNG_.tb7_0(90):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(90):=CNCRMNG_.tb7_0(90);
CNCRMNG_.tb7_1(90):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (90)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(90),
CNCRMNG_.tb7_1(90),
null,
null,
'Y'
,
'N'
,
6,
'N'
,
'Ubic. Geografica de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CONTACT_GEO_LOC'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(91):=1598992;
CNCRMNG_.tb7_0(91):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(91):=CNCRMNG_.tb7_0(91);
CNCRMNG_.tb7_1(91):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (91)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(91),
CNCRMNG_.tb7_1(91),
null,
null,
'Y'
,
'N'
,
7,
'N'
,
'Ciclo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CICLE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(92):=1598993;
CNCRMNG_.tb7_0(92):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(92):=CNCRMNG_.tb7_0(92);
CNCRMNG_.tb7_1(92):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (92)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(92),
CNCRMNG_.tb7_1(92),
null,
null,
'Y'
,
'N'
,
8,
'N'
,
'Saldo Pendiente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(93):=1598994;
CNCRMNG_.tb7_0(93):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(93):=CNCRMNG_.tb7_0(93);
CNCRMNG_.tb7_1(93):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (93)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(93),
CNCRMNG_.tb7_1(93),
null,
null,
'Y'
,
'N'
,
9,
'N'
,
'Facturas con Saldo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ACCOUNT_WITH_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(94):=1598995;
CNCRMNG_.tb7_0(94):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(94):=CNCRMNG_.tb7_0(94);
CNCRMNG_.tb7_1(94):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (94)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(94),
CNCRMNG_.tb7_1(94),
null,
null,
'Y'
,
'N'
,
10,
'N'
,
'Saldo en Reclamo'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CLAIM_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(95):=1598996;
CNCRMNG_.tb7_0(95):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(95):=CNCRMNG_.tb7_0(95);
CNCRMNG_.tb7_1(95):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (95)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(95),
CNCRMNG_.tb7_1(95),
null,
null,
'Y'
,
'N'
,
11,
'N'
,
'Saldo en Reclamo por Pago no Abonado'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CLAIM_BALANCE_NO_PAID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(96):=1598997;
CNCRMNG_.tb7_0(96):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(96):=CNCRMNG_.tb7_0(96);
CNCRMNG_.tb7_1(96):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (96)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(96),
CNCRMNG_.tb7_1(96),
null,
null,
'Y'
,
'N'
,
12,
'N'
,
'Ruta'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'ROUTE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(97):=1598998;
CNCRMNG_.tb7_0(97):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(97):=CNCRMNG_.tb7_0(97);
CNCRMNG_.tb7_1(97):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (97)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(97),
CNCRMNG_.tb7_1(97),
null,
null,
'Y'
,
'N'
,
13,
'N'
,
'Saldo a Favor'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FAVOR_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(98):=1598999;
CNCRMNG_.tb7_0(98):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(98):=CNCRMNG_.tb7_0(98);
CNCRMNG_.tb7_1(98):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (98)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(98),
CNCRMNG_.tb7_1(98),
null,
null,
'N'
,
'N'
,
14,
'N'
,
'Fin Contrato'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FINALDATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(99):=1599000;
CNCRMNG_.tb7_0(99):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(99):=CNCRMNG_.tb7_0(99);
CNCRMNG_.tb7_1(99):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (99)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(99),
CNCRMNG_.tb7_1(99),
null,
null,
'Y'
,
'N'
,
15,
'N'
,
'Fecha de Pago'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PAYDATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(100):=1599001;
CNCRMNG_.tb7_0(100):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(100):=CNCRMNG_.tb7_0(100);
CNCRMNG_.tb7_1(100):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (100)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(100),
CNCRMNG_.tb7_1(100),
null,
null,
'Y'
,
'N'
,
16,
'N'
,
'Fecha Limite de Pago'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PAYLIMITDATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(101):=1599002;
CNCRMNG_.tb7_0(101):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(101):=CNCRMNG_.tb7_0(101);
CNCRMNG_.tb7_1(101):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (101)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(101),
CNCRMNG_.tb7_1(101),
null,
null,
'Y'
,
'N'
,
17,
'N'
,
'Tipo de Moneda'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'COIN_TYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(102):=1599003;
CNCRMNG_.tb7_0(102):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(102):=CNCRMNG_.tb7_0(102);
CNCRMNG_.tb7_1(102):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (102)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(102),
CNCRMNG_.tb7_1(102),
null,
null,
'Y'
,
'N'
,
18,
'N'
,
'Cliente'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIBER_ID'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(103):=1599004;
CNCRMNG_.tb7_0(103):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(103):=CNCRMNG_.tb7_0(103);
CNCRMNG_.tb7_1(103):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (103)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(103),
CNCRMNG_.tb7_1(103),
null,
null,
'Y'
,
'N'
,
19,
'N'
,
'Identificacion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'IDENTIFICATION'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(104):=1599005;
CNCRMNG_.tb7_0(104):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(104):=CNCRMNG_.tb7_0(104);
CNCRMNG_.tb7_1(104):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (104)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(104),
CNCRMNG_.tb7_1(104),
null,
null,
'Y'
,
'N'
,
20,
'N'
,
'Tipo Identificacion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'IDENTIFICATION_TYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(105):=1599006;
CNCRMNG_.tb7_0(105):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(105):=CNCRMNG_.tb7_0(105);
CNCRMNG_.tb7_1(105):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (105)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(105),
CNCRMNG_.tb7_1(105),
null,
null,
'Y'
,
'N'
,
21,
'N'
,
'Telefono'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PHONE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(106):=1599007;
CNCRMNG_.tb7_0(106):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(106):=CNCRMNG_.tb7_0(106);
CNCRMNG_.tb7_1(106):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (106)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(106),
CNCRMNG_.tb7_1(106),
null,
null,
'Y'
,
'N'
,
22,
'N'
,
'Direccion de Cobro'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CHARGE_ADDRESS'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(107):=1599008;
CNCRMNG_.tb7_0(107):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(107):=CNCRMNG_.tb7_0(107);
CNCRMNG_.tb7_1(107):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (107)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(107),
CNCRMNG_.tb7_1(107),
null,
null,
'Y'
,
'N'
,
23,
'N'
,
'Barrio de Cobro'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CHARGE_NEIGHBORTHOOD'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(108):=1599009;
CNCRMNG_.tb7_0(108):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(108):=CNCRMNG_.tb7_0(108);
CNCRMNG_.tb7_1(108):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (108)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(108),
CNCRMNG_.tb7_1(108),
null,
null,
'Y'
,
'N'
,
24,
'N'
,
'Ciudad de Cobro'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CHARGE_CITY'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(109):=1599010;
CNCRMNG_.tb7_0(109):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(109):=CNCRMNG_.tb7_0(109);
CNCRMNG_.tb7_1(109):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (109)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(109),
CNCRMNG_.tb7_1(109),
null,
null,
'Y'
,
'N'
,
25,
'N'
,
'Departamento de Cobro'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CHARGE_STATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(110):=1599011;
CNCRMNG_.tb7_0(110):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(110):=CNCRMNG_.tb7_0(110);
CNCRMNG_.tb7_1(110):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (110)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(110),
CNCRMNG_.tb7_1(110),
null,
null,
'Y'
,
'N'
,
26,
'N'
,
'Tipo de Cobro'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCTDCO'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(111):=1599012;
CNCRMNG_.tb7_0(111):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(111):=CNCRMNG_.tb7_0(111);
CNCRMNG_.tb7_1(111):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (111)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(111),
CNCRMNG_.tb7_1(111),
null,
null,
'Y'
,
'N'
,
27,
'N'
,
'Tipo de Cuenta Bancaria '
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCTCBA'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(112):=1599013;
CNCRMNG_.tb7_0(112):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(112):=CNCRMNG_.tb7_0(112);
CNCRMNG_.tb7_1(112):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (112)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(112),
CNCRMNG_.tb7_1(112),
null,
null,
'Y'
,
'N'
,
28,
'N'
,
'Banco'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCBANC'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(113):=1599014;
CNCRMNG_.tb7_0(113):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(113):=CNCRMNG_.tb7_0(113);
CNCRMNG_.tb7_1(113):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (113)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(113),
CNCRMNG_.tb7_1(113),
null,
null,
'Y'
,
'N'
,
29,
'N'
,
'Sucursal Bancaria'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCSUBA'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(114):=1599015;
CNCRMNG_.tb7_0(114):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(114):=CNCRMNG_.tb7_0(114);
CNCRMNG_.tb7_1(114):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (114)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(114),
CNCRMNG_.tb7_1(114),
null,
null,
'Y'
,
'N'
,
30,
'N'
,
'Cuenta Bancaria'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCCUCO'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(115):=1599016;
CNCRMNG_.tb7_0(115):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(115):=CNCRMNG_.tb7_0(115);
CNCRMNG_.tb7_1(115):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (115)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(115),
CNCRMNG_.tb7_1(115),
null,
null,
'Y'
,
'N'
,
31,
'N'
,
'Vencimiento Tarjeta de Credito'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCVETC'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(116):=1599017;
CNCRMNG_.tb7_0(116):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(116):=CNCRMNG_.tb7_0(116);
CNCRMNG_.tb7_1(116):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (116)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(116),
CNCRMNG_.tb7_1(116),
null,
null,
'Y'
,
'N'
,
32,
'N'
,
'Tipo Tarjeta de Pago'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CARD_TYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(117):=1599018;
CNCRMNG_.tb7_0(117):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(117):=CNCRMNG_.tb7_0(117);
CNCRMNG_.tb7_1(117):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (117)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(117),
CNCRMNG_.tb7_1(117),
null,
null,
'Y'
,
'N'
,
33,
'N'
,
'Tipo de Contrato'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUBSCRIPTION_TYPE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(118):=1599019;
CNCRMNG_.tb7_0(118):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(118):=CNCRMNG_.tb7_0(118);
CNCRMNG_.tb7_1(118):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (118)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(118),
CNCRMNG_.tb7_1(118),
null,
null,
'Y'
,
'N'
,
34,
'N'
,
'Deuda Diferida'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'DEF_BALANCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(119):=1599020;
CNCRMNG_.tb7_0(119):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(119):=CNCRMNG_.tb7_0(119);
CNCRMNG_.tb7_1(119):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (119)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(119),
CNCRMNG_.tb7_1(119),
null,
null,
'Y'
,
'N'
,
35,
'N'
,
'Cuota Total'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'TOTAL_CUOTE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(120):=1599021;
CNCRMNG_.tb7_0(120):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(120):=CNCRMNG_.tb7_0(120);
CNCRMNG_.tb7_1(120):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (120)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(120),
CNCRMNG_.tb7_1(120),
null,
null,
'Y'
,
'N'
,
36,
'N'
,
'Empresa'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'COMPANY'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(121):=1599022;
CNCRMNG_.tb7_0(121):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(121):=CNCRMNG_.tb7_0(121);
CNCRMNG_.tb7_1(121):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (121)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(121),
CNCRMNG_.tb7_1(121),
null,
null,
'Y'
,
'N'
,
37,
'N'
,
'Envio de Facturas por Correo Electronico'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCEFCE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(122):=1599023;
CNCRMNG_.tb7_0(122):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(122):=CNCRMNG_.tb7_0(122);
CNCRMNG_.tb7_1(122):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (122)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(122),
CNCRMNG_.tb7_1(122),
null,
null,
'Y'
,
'N'
,
38,
'N'
,
'Tipo de documento titular de la tarjeta'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCTITT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(123):=1599024;
CNCRMNG_.tb7_0(123):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(123):=CNCRMNG_.tb7_0(123);
CNCRMNG_.tb7_1(123):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (123)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(123),
CNCRMNG_.tb7_1(123),
null,
null,
'Y'
,
'N'
,
39,
'N'
,
'Identificacion del titular de la tarjeta'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'SUSCIDTT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(124):=1599025;
CNCRMNG_.tb7_0(124):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(124):=CNCRMNG_.tb7_0(124);
CNCRMNG_.tb7_1(124):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (124)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(124),
CNCRMNG_.tb7_1(124),
null,
null,
'Y'
,
'N'
,
40,
'N'
,
'Fecha Final de Distribucion'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'FINAL_DIST_DATE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(125):=1599026;
CNCRMNG_.tb7_0(125):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(125):=CNCRMNG_.tb7_0(125);
CNCRMNG_.tb7_1(125):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (125)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(125),
CNCRMNG_.tb7_1(125),
null,
null,
'Y'
,
'N'
,
41,
'N'
,
'Cantidad de facturas impagas'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'COUNT_BILL_NO_PAY'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(126):=1599027;
CNCRMNG_.tb7_0(126):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(126):=CNCRMNG_.tb7_0(126);
CNCRMNG_.tb7_1(126):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (126)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(126),
CNCRMNG_.tb7_1(126),
null,
null,
'Y'
,
'N'
,
42,
'N'
,
'Saldo de Reclamos por pago no Abonado'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'CLAIM_NO_PAY'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(127):=1599028;
CNCRMNG_.tb7_0(127):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(127):=CNCRMNG_.tb7_0(127);
CNCRMNG_.tb7_1(127):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (127)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(127),
CNCRMNG_.tb7_1(127),
null,
null,
'Y'
,
'N'
,
43,
'N'
,
'Deposito disponible'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'DEPOSIT'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(128):=1599029;
CNCRMNG_.tb7_0(128):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(128):=CNCRMNG_.tb7_0(128);
CNCRMNG_.tb7_1(128):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (128)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(128),
CNCRMNG_.tb7_1(128),
null,
null,
'Y'
,
'N'
,
44,
'N'
,
'Fecha Registro Debito Automatico'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'NOVEFENO_REG'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(129):=1599030;
CNCRMNG_.tb7_0(129):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(129):=CNCRMNG_.tb7_0(129);
CNCRMNG_.tb7_1(129):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (129)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(129),
CNCRMNG_.tb7_1(129),
null,
null,
'Y'
,
'N'
,
45,
'N'
,
'Fecha Eliminacion Debito Automatico'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'NOVEFENO_DEL'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;

CNCRMNG_.old_tb7_0(130):=1599031;
CNCRMNG_.tb7_0(130):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CNCRMNG_.tb7_0(130):=CNCRMNG_.tb7_0(130);
CNCRMNG_.tb7_1(130):=CNCRMNG_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (130)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CNCRMNG_.tb7_0(130),
CNCRMNG_.tb7_1(130),
null,
null,
'Y'
,
'N'
,
46,
'N'
,
'Cartera Castigada'
,
'N'
,
'N'
,
'U'
,
null,
null,
null,
'PUNISH_VALUE'
,
null,
null);

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
    nuIndex             BINARY_INTEGER;
    nuNewSAExecutable   sa_executable.executable_id%type;
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
SELECT executable_id INTO nuNewSAExecutable FROM sa_executable WHERE name = 'CNCRMNG';

nuIndex := CNCRMNG_.tbOldSAExecSynonParent.first;
while ( nuIndex IS NOT null) LOOP
    INSERT INTO sa_executable_synon
        (executable_synon_id, executable_id, synonymous_id, IS_active)
    VALUES
        (sa_bosequences.fnuGetSEQ_SA_EXECUTABLE_SYNON,
         CNCRMNG_.tbOldSAExecSynonParent(nuIndex).executable_id,
         nuNewSAExecutable,
         CNCRMNG_.tbOldSAExecSynonParent(nuIndex).is_active);
    nuIndex := CNCRMNG_.tbOldSAExecSynonParent.next(nuIndex);
END loop;

nuIndex := CNCRMNG_.tbOldSAExecSynonSon.first;
while ( nuIndex IS NOT null) LOOP
    INSERT INTO sa_executable_synon
        (executable_synon_id, executable_id, synonymous_id, IS_active)
    VALUES
        (sa_bosequences.fnuGetSEQ_SA_EXECUTABLE_SYNON,
         nuNewSAExecutable,
         CNCRMNG_.tbOldSAExecSynonSon(nuIndex).synonymous_id,
         CNCRMNG_.tbOldSAExecSynonSon(nuIndex).is_active);
    nuIndex := CNCRMNG_.tbOldSAExecSynonSon.next(nuIndex);
END loop;
   GI_BOFrameworkUserConfig.SyncUserConfig('CNCRMNG');

exception when others then
CNCRMNG_.blProcessStatus := false;
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
 nuIndexInternal := CNCRMNG_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (CNCRMNG_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (CNCRMNG_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := CNCRMNG_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := CNCRMNG_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
nuIndex :=  CNCRMNG_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (CNCRMNG_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(CNCRMNG_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (CNCRMNG_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := CNCRMNG_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  CNCRMNG_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(CNCRMNG_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,CNCRMNG_.tbUserException(nuIndex).user_id, CNCRMNG_.tbUserException(nuIndex).status , CNCRMNG_.tbUserException(nuIndex).usr_exc_type_id, CNCRMNG_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := CNCRMNG_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  CNCRMNG_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(CNCRMNG_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = CNCRMNG_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,CNCRMNG_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := CNCRMNG_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_',
'CREATE OR REPLACE PACKAGE CNCRMNG_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_CTRL_BY_TAB_APPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CTRL_BY_TAB_APPRowId tyGI_CTRL_BY_TAB_APPRowId; ' || chr(10) ||
'END CNCRMNG_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_******************************'); END;
/


BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CTRL_BY_TAB_APP',1);
  DELETE FROM GI_CTRL_BY_TAB_APP WHERE APPLICATION='CNCRMNG';

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_',
'CREATE OR REPLACE PACKAGE CNCRMNG_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_APPLIC_COMPONENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_APPLIC_COMPONENTRowId tyGI_APPLIC_COMPONENTRowId; ' || chr(10) ||
'END CNCRMNG_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_******************************'); END;
/


BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_APPLIC_COMPONENT',1);
  DELETE FROM GI_APPLIC_COMPONENT WHERE APPLICATION_NAME='CNCRMNG';

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CNCRMNG_',
'CREATE OR REPLACE PACKAGE CNCRMNG_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_ALT_ATRB_BROWSERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ALT_ATRB_BROWSERowId tyGI_ALT_ATRB_BROWSERowId; ' || chr(10) ||
'END CNCRMNG_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CNCRMNG_******************************'); END;
/


BEGIN

if (not CNCRMNG_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ALT_ATRB_BROWSE',1);
  DELETE FROM GI_ALT_ATRB_BROWSE WHERE APPLICATION='CNCRMNG';

exception when others then
CNCRMNG_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CNCRMNG_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CNCRMNG_******************************'); end;
/

