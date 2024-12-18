BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCAIC_',
'CREATE OR REPLACE PACKAGE LDCAIC_ IS ' || chr(10) ||
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
'AND e.name=''LDCAIC'') ' || chr(10) ||
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
'AND e.name=''LDCAIC'') ' || chr(10) ||
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
'AND e.name=''LDCAIC'') ' || chr(10) ||
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
'END LDCAIC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCAIC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
Open LDCAIC_.cuRoleExecutables;
loop
 fetch LDCAIC_.cuRoleExecutables INTO LDCAIC_.rcRoleExecutables;
 exit when  LDCAIC_.cuRoleExecutables%notfound;
 LDCAIC_.tbRoleExecutables(nuIndex) := LDCAIC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCAIC_.cuRoleExecutables;
nuIndex := 0;
Open LDCAIC_.cuUserExceptions ;
loop
 fetch LDCAIC_.cuUserExceptions INTO  LDCAIC_.rcUserExceptions;
 exit when LDCAIC_.cuUserExceptions%notfound;
 LDCAIC_.tbUserException(nuIndex):=LDCAIC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCAIC_.cuUserExceptions;
nuIndex := 0;
Open LDCAIC_.cuExecEntities ;
loop
 fetch LDCAIC_.cuExecEntities INTO  LDCAIC_.rcExecEntities;
 exit when LDCAIC_.cuExecEntities%notfound;
 LDCAIC_.tbExecEntities(nuIndex):=LDCAIC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCAIC_.cuExecEntities;

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCAIC_.blProcessStatus) then
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
AND e.name='LDCAIC')
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
AND e.name='LDCAIC')
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
AND e.name='LDCAIC')
);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN

if (not LDCAIC_.blProcessStatus) then
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
AND e.name='LDCAIC')) AND ROLE_ID=1;

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
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
AND e.name='LDCAIC'));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
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
AND e.name='LDCAIC');

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCAIC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCAIC_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCAIC_',
'CREATE OR REPLACE PACKAGE LDCAIC_ IS ' || chr(10) ||
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
'tb7_2 ty7_2;type ty8_0 is table of GI_FRAME.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of GI_FRAME.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1; ' || chr(10) ||
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
'  executableName ge_catalog.tag_name%type := ''LDCAIC''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCAIC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCAIC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDCAIC'' ' || chr(10) ||
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
'END LDCAIC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCAIC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
Open LDCAIC_.cuRoleExecutables;
loop
 fetch LDCAIC_.cuRoleExecutables INTO LDCAIC_.rcRoleExecutables;
 exit when  LDCAIC_.cuRoleExecutables%notfound;
 LDCAIC_.tbRoleExecutables(nuIndex) := LDCAIC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDCAIC_.cuRoleExecutables;
nuIndex := 0;
Open LDCAIC_.cuUserExceptions ;
loop
 fetch LDCAIC_.cuUserExceptions INTO  LDCAIC_.rcUserExceptions;
 exit when LDCAIC_.cuUserExceptions%notfound;
 LDCAIC_.tbUserException(nuIndex):=LDCAIC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDCAIC_.cuUserExceptions;
nuIndex := 0;
Open LDCAIC_.cuExecEntities ;
loop
 fetch LDCAIC_.cuExecEntities INTO  LDCAIC_.rcExecEntities;
 exit when LDCAIC_.cuExecEntities%notfound;
 LDCAIC_.tbExecEntities(nuIndex):=LDCAIC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDCAIC_.cuExecEntities;

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC'
);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND ROLE_ID=1;

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC');

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC');

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT PARENT_STATEMENT_ID FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339))));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT PARENT_STATEMENT_ID FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
LDCAIC_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION_ADITI',1);
  DELETE FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=LDCAIC_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = LDCAIC_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
LDCAIC_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := LDCAIC_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_STATEMENT_COLUMNS',1);
  DELETE FROM GE_STATEMENT_COLUMNS WHERE (STATEMENT_ID) in (SELECT STATEMENT_ID FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339))));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
LDCAIC_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=LDCAIC_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = LDCAIC_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
LDCAIC_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := LDCAIC_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_COMPOSITION WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_COMPOSITION',1);
for rcData in cuLoadTemporaryTable loop
LDCAIC_.tbGI_COMPOSITIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339)));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_COMPOSITION',1);
nuVarcharIndex:=LDCAIC_.tbGI_COMPOSITIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_COMPOSITION where rowid = LDCAIC_.tbGI_COMPOSITIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDCAIC_.tbGI_COMPOSITIONRowId.next(nuVarcharIndex); 
LDCAIC_.tbGI_COMPOSITIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDCAIC') AND CONFIG_TYPE_ID=6 AND ENTITY_ROOT_ID=3339;

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ALT_SEAR_ENTITY',1);
  DELETE FROM GI_ALT_SEAR_ENTITY WHERE (EXECUTABLE_NAME) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='LDCAIC');

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDCAIC';

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb0_0(0):='LDCAIC'
;
LDCAIC_.tb0_0(0):=UPPER(LDCAIC_.old_tb0_0(0));
LDCAIC_.tb0_0(0):=LDCAIC_.tb0_0(0);
LDCAIC_.old_tb0_1(0):=500000000002323;
LDCAIC_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCAIC_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDCAIC_.tb0_1(0):=LDCAIC_.tb0_1(0);
LDCAIC_.old_tb0_2(0):='35'
;
LDCAIC_.tb0_2(0):=TRUNC(LDCAIC_.old_tb0_2(0));
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,VERSION,DESCRIPTION,PATH,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDCAIC_.tb0_0(0),
LDCAIC_.tb0_1(0),
LDCAIC_.tb0_2(0),
'Administración Imagen Colombia'
,
null,
8,
2,
4,
1,
6992,
'N'
,
null,
'N'
,
'Y'
,
17448,
null,
to_date('24-08-2016 09:13:54','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.tb1_0(0):=1;
LDCAIC_.tb1_1(0):=LDCAIC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDCAIC_.tb1_0(0),
LDCAIC_.tb1_1(0));

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb2_0(0):=40004815;
LDCAIC_.tb2_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
LDCAIC_.tb2_0(0):=LDCAIC_.tb2_0(0);
LDCAIC_.tb2_1(0):=LDCAIC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (LDCAIC_.tb2_0(0),
LDCAIC_.tb2_1(0),
'LDCAIC'
,
'Administración Imagen Colombia'
,
1,
1,
7,
15060,
'FormExecutable'
,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb3_0(0):=7566;
LDCAIC_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
LDCAIC_.tb3_0(0):=LDCAIC_.tb3_0(0);
LDCAIC_.tb3_1(0):=LDCAIC_.tb0_1(0);
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,CONFIG_TYPE_ID,ENTITY_ROOT_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY,ACCEPT_RULE_ID) 
VALUES (LDCAIC_.tb3_0(0),
LDCAIC_.tb3_1(0),
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb4_0(0):=1035594;
LDCAIC_.tb4_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
LDCAIC_.tb4_0(0):=LDCAIC_.tb4_0(0);
LDCAIC_.tb4_1(0):=LDCAIC_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,CONFIG_ID,PARENT_COMP_ID,MIN_OBJECTS,MAX_OBJECTS,TAG_NAME,ENTITY_TYPE_ID,EXTERNAL_TYPE_ID,CONFIG_TYPE_ID) 
VALUES (LDCAIC_.tb4_0(0),
LDCAIC_.tb4_1(0),
null,
0,
0,
'LDC_FW_CONTRATISTA'
,
3037,
8785,
6);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb4_0(1):=1035595;
LDCAIC_.tb4_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
LDCAIC_.tb4_0(1):=LDCAIC_.tb4_0(1);
LDCAIC_.tb4_1(1):=LDCAIC_.tb3_0(0);
LDCAIC_.tb4_2(1):=LDCAIC_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,CONFIG_ID,PARENT_COMP_ID,MIN_OBJECTS,MAX_OBJECTS,TAG_NAME,ENTITY_TYPE_ID,EXTERNAL_TYPE_ID,CONFIG_TYPE_ID) 
VALUES (LDCAIC_.tb4_0(1),
LDCAIC_.tb4_1(1),
LDCAIC_.tb4_2(1),
0,
0,
'LDC_FW_OPERUNITCONTRACTOR'
,
3037,
8786,
6);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb4_0(2):=1035596;
LDCAIC_.tb4_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
LDCAIC_.tb4_0(2):=LDCAIC_.tb4_0(2);
LDCAIC_.tb4_1(2):=LDCAIC_.tb3_0(0);
LDCAIC_.tb4_2(2):=LDCAIC_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,CONFIG_ID,PARENT_COMP_ID,MIN_OBJECTS,MAX_OBJECTS,TAG_NAME,ENTITY_TYPE_ID,EXTERNAL_TYPE_ID,CONFIG_TYPE_ID) 
VALUES (LDCAIC_.tb4_0(2),
LDCAIC_.tb4_1(2),
LDCAIC_.tb4_2(2),
0,
0,
'LDC_FWORDERIMAGEN'
,
3037,
8787,
6);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.tb5_0(0):=LDCAIC_.tb4_0(2);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (0)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,PARENT_STATEMENT_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (LDCAIC_.tb5_0(0),
null,
'LDC_BO_IMAGENCOLOMBIA.GetOrdersByOperatingUnitId'
,
'LDC_BO_IMAGENCOLOMBIA.GetOperatingUnitByOrderId'
,
0,
'Y'
,
'Y'
,
'LDC_FW_CONTRATISTA.LDC_FW_OPERUNITCONTRACTOR'
,
null,
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title>Identificador: {ORDER_ID}</Title><Subtitle1>Estado :{ORDER_STATUS}              Tipo de Trabajo:{TASK_TYPE}</Subtitle1><Subtitle2>Sector: {OPERATING_SECTOR}        Unidad Operativa: {OPERATING_UNIT}</Subtitle2></OpenQueryHeaderTitle>'
,
'Órdenes de Trabajo'
,
null,
null,
null,
2,
'PARENT_ID'
,
'Órdenes Imagen Colombia'
,
'Y'
);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb6_0(0):=1079799;
LDCAIC_.tb6_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
LDCAIC_.tb6_0(0):=LDCAIC_.tb6_0(0);
LDCAIC_.tb6_1(0):=LDCAIC_.tb4_0(2);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (LDCAIC_.tb6_0(0),
LDCAIC_.tb6_1(0),
null,
null,
-1,
null,
null,
-1,
-1,
0,
'Identificador de la Orden'
,
null,
null,
null,
null,
null,
null,
'INUORDERID'
,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(0):=1262849;
LDCAIC_.tb7_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(0):=LDCAIC_.tb7_0(0);
LDCAIC_.tb7_2(0):=LDCAIC_.tb6_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(0),
null,
LDCAIC_.tb7_2(0),
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
'INUORDERID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb8_0(0):=95035;
LDCAIC_.tb8_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
LDCAIC_.tb8_0(0):=LDCAIC_.tb8_0(0);
LDCAIC_.tb8_1(0):=LDCAIC_.tb4_0(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,DESCRIPTION,ORDER_VIEW,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID) 
VALUES (LDCAIC_.tb8_0(0),
LDCAIC_.tb8_1(0),
'LDC_FWORDERIMAGEN'
,
0,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(1):=1262850;
LDCAIC_.tb7_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(1):=LDCAIC_.tb7_0(1);
LDCAIC_.tb7_1(1):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(1),
LDCAIC_.tb7_1(1),
null,
null,
'Y'
,
'N'
,
1,
'N'
,
'Numerador'
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
'NUMERATOR'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(2):=1262851;
LDCAIC_.tb7_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(2):=LDCAIC_.tb7_0(2);
LDCAIC_.tb7_1(2):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(2),
LDCAIC_.tb7_1(2),
null,
null,
'Y'
,
'N'
,
2,
'N'
,
'Tipo de trabajo'
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
'TASK_TYPE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(3):=1262852;
LDCAIC_.tb7_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(3):=LDCAIC_.tb7_0(3);
LDCAIC_.tb7_1(3):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(3),
LDCAIC_.tb7_1(3),
null,
null,
'Y'
,
'N'
,
3,
'N'
,
'Estado'
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
'ORDER_STATUS'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(4):=1262853;
LDCAIC_.tb7_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(4):=LDCAIC_.tb7_0(4);
LDCAIC_.tb7_1(4):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(4),
LDCAIC_.tb7_1(4),
null,
null,
'Y'
,
'N'
,
4,
'N'
,
'Sector Operativo'
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
'OPERATING_SECTOR'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(5):=1262854;
LDCAIC_.tb7_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(5):=LDCAIC_.tb7_0(5);
LDCAIC_.tb7_1(5):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(5),
LDCAIC_.tb7_1(5),
null,
null,
'Y'
,
'N'
,
5,
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(6):=1262855;
LDCAIC_.tb7_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(6):=LDCAIC_.tb7_0(6);
LDCAIC_.tb7_1(6):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(6),
LDCAIC_.tb7_1(6),
null,
null,
'Y'
,
'N'
,
6,
'N'
,
'Unidad operativa'
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
'OPERATING_UNIT'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(7):=1262856;
LDCAIC_.tb7_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(7):=LDCAIC_.tb7_0(7);
LDCAIC_.tb7_1(7):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(7),
LDCAIC_.tb7_1(7),
null,
null,
'N'
,
'N'
,
7,
'N'
,
'Operating_Unit_Status'
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
'OPERATING_UNIT_STATUS'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(8):=1262857;
LDCAIC_.tb7_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(8):=LDCAIC_.tb7_0(8);
LDCAIC_.tb7_1(8):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(8),
LDCAIC_.tb7_1(8),
null,
null,
'Y'
,
'N'
,
8,
'N'
,
'Fecha de Creación'
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
'CREATED_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(9):=1262858;
LDCAIC_.tb7_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(9):=LDCAIC_.tb7_0(9);
LDCAIC_.tb7_1(9):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(9),
LDCAIC_.tb7_1(9),
null,
null,
'Y'
,
'N'
,
9,
'N'
,
'Fecha de Asignación'
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
'ASSIGNED_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(10):=1262859;
LDCAIC_.tb7_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(10):=LDCAIC_.tb7_0(10);
LDCAIC_.tb7_1(10):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(10),
LDCAIC_.tb7_1(10),
null,
null,
'Y'
,
'N'
,
10,
'N'
,
'Fecha Estimada de Ejecución'
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
'EXEC_ESTIMATE_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(11):=1262860;
LDCAIC_.tb7_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(11):=LDCAIC_.tb7_0(11);
LDCAIC_.tb7_1(11):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(11),
LDCAIC_.tb7_1(11),
null,
null,
'Y'
,
'N'
,
11,
'N'
,
'Fecha Máxima para Legalización'
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
'MAX_DATE_TO_LEGALIZE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(12):=1262861;
LDCAIC_.tb7_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(12):=LDCAIC_.tb7_0(12);
LDCAIC_.tb7_1(12):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(12),
LDCAIC_.tb7_1(12),
null,
null,
'Y'
,
'N'
,
12,
'N'
,
'Última Reprogramación'
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
'REPROGRAM_LAST_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(13):=1262862;
LDCAIC_.tb7_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(13):=LDCAIC_.tb7_0(13);
LDCAIC_.tb7_1(13):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(13),
LDCAIC_.tb7_1(13),
null,
null,
'Y'
,
'N'
,
13,
'N'
,
'Fecha de Legalización'
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
'LEGALIZATION_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(14):=1262863;
LDCAIC_.tb7_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(14):=LDCAIC_.tb7_0(14);
LDCAIC_.tb7_1(14):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(14),
LDCAIC_.tb7_1(14),
null,
null,
'Y'
,
'N'
,
14,
'N'
,
'Inicio de Ejecución'
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
'EXEC_INITIAL_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(15):=1262864;
LDCAIC_.tb7_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(15):=LDCAIC_.tb7_0(15);
LDCAIC_.tb7_1(15):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(15),
LDCAIC_.tb7_1(15),
null,
null,
'Y'
,
'N'
,
15,
'N'
,
'Fin de Ejecución'
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
'EXECUTION_FINAL_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(16):=1262865;
LDCAIC_.tb7_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(16):=LDCAIC_.tb7_0(16);
LDCAIC_.tb7_1(16):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(16),
LDCAIC_.tb7_1(16),
null,
null,
'Y'
,
'N'
,
16,
'N'
,
'Causal de Legalización'
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
'CAUSAL'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(17):=1262866;
LDCAIC_.tb7_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(17):=LDCAIC_.tb7_0(17);
LDCAIC_.tb7_1(17):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(17),
LDCAIC_.tb7_1(17),
null,
null,
'Y'
,
'N'
,
17,
'N'
,
'Personal'
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
'PERSON'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(18):=1262867;
LDCAIC_.tb7_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(18):=LDCAIC_.tb7_0(18);
LDCAIC_.tb7_1(18):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(18),
LDCAIC_.tb7_1(18),
null,
null,
'Y'
,
'N'
,
18,
'N'
,
'Valor de la orden'
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
'ORDER_VALUE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(19):=1262868;
LDCAIC_.tb7_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(19):=LDCAIC_.tb7_0(19);
LDCAIC_.tb7_1(19):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(19),
LDCAIC_.tb7_1(19),
null,
null,
'N'
,
'N'
,
19,
'N'
,
'Printing_Time_Number'
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
'PRINTING_TIME_NUMBER'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(20):=1262869;
LDCAIC_.tb7_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(20):=LDCAIC_.tb7_0(20);
LDCAIC_.tb7_1(20):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(20),
LDCAIC_.tb7_1(20),
null,
null,
'N'
,
'N'
,
20,
'N'
,
'Legalize_Try_Times'
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
'LEGALIZE_TRY_TIMES'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(21):=1262870;
LDCAIC_.tb7_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(21):=LDCAIC_.tb7_0(21);
LDCAIC_.tb7_1(21):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(21),
LDCAIC_.tb7_1(21),
null,
null,
'Y'
,
'N'
,
21,
'N'
,
'Tipo de trabajo Real'
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
'REAL_TASK_TYPE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(22):=1262871;
LDCAIC_.tb7_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(22):=LDCAIC_.tb7_0(22);
LDCAIC_.tb7_1(22):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(22),
LDCAIC_.tb7_1(22),
null,
null,
'N'
,
'N'
,
22,
'N'
,
'Prioridad'
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
'PRIORITY'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(23):=1262872;
LDCAIC_.tb7_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(23):=LDCAIC_.tb7_0(23);
LDCAIC_.tb7_1(23):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(23),
LDCAIC_.tb7_1(23),
null,
null,
'N'
,
'N'
,
23,
'N'
,
'Progclasdesc'
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
'PROGCLASDESC'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(24):=1262873;
LDCAIC_.tb7_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(24):=LDCAIC_.tb7_0(24);
LDCAIC_.tb7_1(24):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(24),
LDCAIC_.tb7_1(24),
null,
null,
'N'
,
'N'
,
24,
'N'
,
'Hora Acordada'
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
'ARRANGED_HOUR'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(25):=1262874;
LDCAIC_.tb7_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(25):=LDCAIC_.tb7_0(25);
LDCAIC_.tb7_1(25):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(25),
LDCAIC_.tb7_1(25),
null,
null,
'N'
,
'N'
,
25,
'N'
,
'Appointment_Confirm'
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
'APPOINTMENT_CONFIRM'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(26):=1262875;
LDCAIC_.tb7_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(26):=LDCAIC_.tb7_0(26);
LDCAIC_.tb7_1(26):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(26),
LDCAIC_.tb7_1(26),
null,
null,
'Y'
,
'N'
,
26,
'N'
,
'Consecutivo Predio'
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
'CORSCOPR'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(27):=1262876;
LDCAIC_.tb7_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(27):=LDCAIC_.tb7_0(27);
LDCAIC_.tb7_1(27):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(27),
LDCAIC_.tb7_1(27),
null,
null,
'Y'
,
'N'
,
27,
'N'
,
'Ruseruta'
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
'RUSERUTA'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(28):=1262877;
LDCAIC_.tb7_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(28):=LDCAIC_.tb7_0(28);
LDCAIC_.tb7_1(28):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(28),
LDCAIC_.tb7_1(28),
null,
null,
'Y'
,
'N'
,
28,
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
'ROUTE_NAME'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(29):=1262878;
LDCAIC_.tb7_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(29):=LDCAIC_.tb7_0(29);
LDCAIC_.tb7_1(29):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(29),
LDCAIC_.tb7_1(29),
null,
null,
'Y'
,
'N'
,
29,
'N'
,
'Dirección'
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
'ADDRESS_PARSED'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(30):=1262879;
LDCAIC_.tb7_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(30):=LDCAIC_.tb7_0(30);
LDCAIC_.tb7_1(30):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(30),
LDCAIC_.tb7_1(30),
null,
null,
'Y'
,
'N'
,
30,
'N'
,
'Barrio'
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
'NEIGHBORTHOOD'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(31):=1262880;
LDCAIC_.tb7_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(31):=LDCAIC_.tb7_0(31);
LDCAIC_.tb7_1(31):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(31),
LDCAIC_.tb7_1(31),
null,
null,
'N'
,
'N'
,
31,
'N'
,
'Geograp_Location'
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
'GEOGRAP_LOCATION'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(32):=1262881;
LDCAIC_.tb7_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(32):=LDCAIC_.tb7_0(32);
LDCAIC_.tb7_1(32):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(32),
LDCAIC_.tb7_1(32),
null,
null,
'Y'
,
'N'
,
32,
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(33):=1262882;
LDCAIC_.tb7_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(33):=LDCAIC_.tb7_0(33);
LDCAIC_.tb7_1(33):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(33),
LDCAIC_.tb7_1(33),
null,
null,
'Y'
,
'N'
,
33,
'N'
,
'Nombre suscriptor'
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
'SUBSC_NAME'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(34):=1262883;
LDCAIC_.tb7_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(34):=LDCAIC_.tb7_0(34);
LDCAIC_.tb7_1(34):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(34),
LDCAIC_.tb7_1(34),
null,
null,
'Y'
,
'N'
,
34,
'N'
,
'Apellido suscriptor'
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
'SUBSC_LAST_NAME'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(35):=1262884;
LDCAIC_.tb7_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(35):=LDCAIC_.tb7_0(35);
LDCAIC_.tb7_1(35):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(35),
LDCAIC_.tb7_1(35),
null,
null,
'N'
,
'N'
,
35,
'N'
,
'Client_Type'
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
'CLIENT_TYPE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(36):=1262885;
LDCAIC_.tb7_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(36):=LDCAIC_.tb7_0(36);
LDCAIC_.tb7_1(36):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(36),
LDCAIC_.tb7_1(36),
null,
null,
'N'
,
'N'
,
36,
'N'
,
'Client_Phone'
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
'CLIENT_PHONE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(37):=1262886;
LDCAIC_.tb7_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(37):=LDCAIC_.tb7_0(37);
LDCAIC_.tb7_1(37):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(37),
LDCAIC_.tb7_1(37),
null,
null,
'N'
,
'N'
,
37,
'N'
,
'Scoring'
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
'SCORING'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(38):=1262887;
LDCAIC_.tb7_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(38):=LDCAIC_.tb7_0(38);
LDCAIC_.tb7_1(38):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(38),
LDCAIC_.tb7_1(38),
null,
null,
'N'
,
'N'
,
38,
'N'
,
'Duration'
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
'DURATION'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(39):=1262888;
LDCAIC_.tb7_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(39):=LDCAIC_.tb7_0(39);
LDCAIC_.tb7_1(39):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(39),
LDCAIC_.tb7_1(39),
null,
null,
'N'
,
'N'
,
39,
'N'
,
'Order_Comment'
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
'ORDER_COMMENT'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(40):=1262889;
LDCAIC_.tb7_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(40):=LDCAIC_.tb7_0(40);
LDCAIC_.tb7_1(40):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(40),
LDCAIC_.tb7_1(40),
null,
null,
'N'
,
'N'
,
40,
'N'
,
'Comment_Type'
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
'COMMENT_TYPE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(41):=1262890;
LDCAIC_.tb7_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(41):=LDCAIC_.tb7_0(41);
LDCAIC_.tb7_1(41):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(41),
LDCAIC_.tb7_1(41),
null,
null,
'N'
,
'N'
,
41,
'N'
,
'Asso_Unit'
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
'ASSO_UNIT'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(42):=1262891;
LDCAIC_.tb7_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(42):=LDCAIC_.tb7_0(42);
LDCAIC_.tb7_1(42):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(42),
LDCAIC_.tb7_1(42),
null,
null,
'Y'
,
'N'
,
0,
'N'
,
'Identificador'
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
'ORDER_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(43):=1262892;
LDCAIC_.tb7_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(43):=LDCAIC_.tb7_0(43);
LDCAIC_.tb7_1(43):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(43),
LDCAIC_.tb7_1(43),
null,
null,
'N'
,
'N'
,
42,
'N'
,
'Offered'
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
'OFFERED'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(44):=1262893;
LDCAIC_.tb7_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(44):=LDCAIC_.tb7_0(44);
LDCAIC_.tb7_1(44):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(44),
LDCAIC_.tb7_1(44),
null,
null,
'N'
,
'N'
,
43,
'N'
,
'Project_Name'
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
'PROJECT_NAME'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(45):=1262894;
LDCAIC_.tb7_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(45):=LDCAIC_.tb7_0(45);
LDCAIC_.tb7_1(45):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(45),
LDCAIC_.tb7_1(45),
null,
null,
'N'
,
'N'
,
44,
'N'
,
'Stage_Name'
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
'STAGE_NAME'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(46):=1262895;
LDCAIC_.tb7_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(46):=LDCAIC_.tb7_0(46);
LDCAIC_.tb7_1(46):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(46),
LDCAIC_.tb7_1(46),
null,
null,
'N'
,
'N'
,
45,
'N'
,
'Estado de la Orden'
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
'ORDER_STATUS_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(47):=1262896;
LDCAIC_.tb7_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(47):=LDCAIC_.tb7_0(47);
LDCAIC_.tb7_1(47):=LDCAIC_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(47),
LDCAIC_.tb7_1(47),
null,
null,
'N'
,
'N'
,
46,
'N'
,
'Parent_Id'
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.tb5_0(1):=LDCAIC_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (1)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,PARENT_STATEMENT_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (LDCAIC_.tb5_0(1),
null,
'LDC_BO_IMAGENCOLOMBIA.getFatherOperUnit'
,
'LDC_BO_IMAGENCOLOMBIA.GetContractorByOperaUnitId'
,
0,
'Y'
,
'Y'
,
'LDC_FW_CONTRATISTA'
,
null,
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title>Unidad de Trabajo: {OPERATING_UNIT_ID} - {NAME}</Title><Subtitle1>{ADDRESS} - {PHONE_NUMBER}. Fax: {FAX_NUMBER}</Subtitle1><Subtitle2>{E_MAIL}.</Subtitle2></OpenQueryHeaderTitle>'
,
'Unidad de Trabajo: {OPERATING_UNIT_ID} - {NAME}'
,
null,
null,
null,
1,
'PARENT_ID'
,
'Unidades de Trabajo'
,
'Y'
);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb6_0(1):=1079800;
LDCAIC_.tb6_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
LDCAIC_.tb6_0(1):=LDCAIC_.tb6_0(1);
LDCAIC_.tb6_1(1):=LDCAIC_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (LDCAIC_.tb6_0(1),
LDCAIC_.tb6_1(1),
null,
null,
-1,
null,
null,
-1,
-1,
0,
'Código'
,
null,
null,
null,
null,
null,
null,
'INUOPERATINGUNIT'
,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(48):=1262897;
LDCAIC_.tb7_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(48):=LDCAIC_.tb7_0(48);
LDCAIC_.tb7_2(48):=LDCAIC_.tb6_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(48),
null,
LDCAIC_.tb7_2(48),
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
'INUOPERATINGUNIT'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb6_0(2):=1079801;
LDCAIC_.tb6_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
LDCAIC_.tb6_0(2):=LDCAIC_.tb6_0(2);
LDCAIC_.tb6_1(2):=LDCAIC_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (LDCAIC_.tb6_0(2),
LDCAIC_.tb6_1(2),
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
'ISBNOMBRE'
,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(49):=1262898;
LDCAIC_.tb7_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(49):=LDCAIC_.tb7_0(49);
LDCAIC_.tb7_2(49):=LDCAIC_.tb6_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(49),
null,
LDCAIC_.tb7_2(49),
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
'ISBNOMBRE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb8_0(1):=95036;
LDCAIC_.tb8_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
LDCAIC_.tb8_0(1):=LDCAIC_.tb8_0(1);
LDCAIC_.tb8_1(1):=LDCAIC_.tb4_0(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,DESCRIPTION,ORDER_VIEW,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID) 
VALUES (LDCAIC_.tb8_0(1),
LDCAIC_.tb8_1(1),
'LDC_FW_OPERUNITCONTRACTOR'
,
0,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(50):=1262927;
LDCAIC_.tb7_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(50):=LDCAIC_.tb7_0(50);
LDCAIC_.tb7_1(50):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(50),
LDCAIC_.tb7_1(50),
null,
null,
'Y'
,
'N'
,
28,
'N'
,
'Correo Electrónico'
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
'E_MAIL'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(51):=1262928;
LDCAIC_.tb7_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(51):=LDCAIC_.tb7_0(51);
LDCAIC_.tb7_1(51):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(51),
LDCAIC_.tb7_1(51),
null,
null,
'N'
,
'N'
,
29,
'N'
,
'Contractor_Id'
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
'CONTRACTOR_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(52):=1262929;
LDCAIC_.tb7_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(52):=LDCAIC_.tb7_0(52);
LDCAIC_.tb7_1(52):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(52),
LDCAIC_.tb7_1(52),
null,
null,
'N'
,
'N'
,
30,
'N'
,
'Parent_Id'
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(53):=1262899;
LDCAIC_.tb7_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(53):=LDCAIC_.tb7_0(53);
LDCAIC_.tb7_1(53):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(53),
LDCAIC_.tb7_1(53),
null,
null,
'Y'
,
'N'
,
0,
'N'
,
'Unidad de trabajo'
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
'OPERATING_UNIT_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(54):=1262900;
LDCAIC_.tb7_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(54):=LDCAIC_.tb7_0(54);
LDCAIC_.tb7_1(54):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(54),
LDCAIC_.tb7_1(54),
null,
null,
'Y'
,
'N'
,
1,
'N'
,
'Código alterno'
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
'OPER_UNIT_CODE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(55):=1262901;
LDCAIC_.tb7_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(55):=LDCAIC_.tb7_0(55);
LDCAIC_.tb7_1(55):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(55),
LDCAIC_.tb7_1(55),
null,
null,
'Y'
,
'N'
,
2,
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
'NAME'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(56):=1262902;
LDCAIC_.tb7_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(56):=LDCAIC_.tb7_0(56);
LDCAIC_.tb7_1(56):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(56),
LDCAIC_.tb7_1(56),
null,
null,
'Y'
,
'N'
,
3,
'N'
,
'Clasificación'
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
'OPER_UNIT_CLASSIF_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(57):=1262903;
LDCAIC_.tb7_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(57):=LDCAIC_.tb7_0(57);
LDCAIC_.tb7_1(57):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(57),
LDCAIC_.tb7_1(57),
null,
null,
'Y'
,
'N'
,
4,
'N'
,
'Almacén asociado'
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
'ASSO_OPER_UNIT'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(58):=1262904;
LDCAIC_.tb7_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(58):=LDCAIC_.tb7_0(58);
LDCAIC_.tb7_1(58):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (58)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(58),
LDCAIC_.tb7_1(58),
null,
null,
'Y'
,
'N'
,
5,
'N'
,
'Unidad operativa padre'
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
'FATHER_OPER_UNIT_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(59):=1262905;
LDCAIC_.tb7_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(59):=LDCAIC_.tb7_0(59);
LDCAIC_.tb7_1(59):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (59)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(59),
LDCAIC_.tb7_1(59),
null,
null,
'Y'
,
'N'
,
6,
'N'
,
'Responsable'
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
'PERSON_IN_CHARGE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(60):=1262906;
LDCAIC_.tb7_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(60):=LDCAIC_.tb7_0(60);
LDCAIC_.tb7_1(60):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (60)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(60),
LDCAIC_.tb7_1(60),
null,
null,
'Y'
,
'N'
,
7,
'N'
,
'Fecha última evaluación'
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
'EVAL_LAST_DATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(61):=1262907;
LDCAIC_.tb7_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(61):=LDCAIC_.tb7_0(61);
LDCAIC_.tb7_1(61):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (61)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(61),
LDCAIC_.tb7_1(61),
null,
null,
'Y'
,
'N'
,
8,
'N'
,
'Identificación'
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(62):=1262908;
LDCAIC_.tb7_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(62):=LDCAIC_.tb7_0(62);
LDCAIC_.tb7_1(62):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (62)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(62),
LDCAIC_.tb7_1(62),
null,
null,
'N'
,
'N'
,
9,
'N'
,
'Placas vehículo asignado'
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
'VEHICLE_NUMBER_PLATE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(63):=1262909;
LDCAIC_.tb7_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(63):=LDCAIC_.tb7_0(63);
LDCAIC_.tb7_1(63):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (63)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(63),
LDCAIC_.tb7_1(63),
null,
null,
'Y'
,
'N'
,
10,
'N'
,
'Estado'
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
'OPER_UNIT_STATUS_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(64):=1262910;
LDCAIC_.tb7_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(64):=LDCAIC_.tb7_0(64);
LDCAIC_.tb7_1(64):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (64)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(64),
LDCAIC_.tb7_1(64),
null,
null,
'N'
,
'N'
,
11,
'N'
,
'Valida para asignación'
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
'VALID_FOR_ASSIGN'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(65):=1262911;
LDCAIC_.tb7_0(65):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(65):=LDCAIC_.tb7_0(65);
LDCAIC_.tb7_1(65):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (65)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(65),
LDCAIC_.tb7_1(65),
null,
null,
'N'
,
'N'
,
12,
'N'
,
'Gen_Admin_Order'
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
'GEN_ADMIN_ORDER'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(66):=1262912;
LDCAIC_.tb7_0(66):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(66):=LDCAIC_.tb7_0(66);
LDCAIC_.tb7_1(66):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (66)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(66),
LDCAIC_.tb7_1(66),
null,
null,
'N'
,
'N'
,
13,
'N'
,
'Notificable'
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
'NOTIFICABLE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(67):=1262913;
LDCAIC_.tb7_0(67):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(67):=LDCAIC_.tb7_0(67);
LDCAIC_.tb7_1(67):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (67)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(67),
LDCAIC_.tb7_1(67),
null,
null,
'N'
,
'N'
,
14,
'N'
,
'Centro_Oper_Id'
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
'CENTRO_OPER_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(68):=1262914;
LDCAIC_.tb7_0(68):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(68):=LDCAIC_.tb7_0(68);
LDCAIC_.tb7_1(68):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (68)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(68),
LDCAIC_.tb7_1(68),
null,
null,
'N'
,
'N'
,
15,
'N'
,
'Admin_Base_Id'
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
'ADMIN_BASE_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(69):=1262915;
LDCAIC_.tb7_0(69):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(69):=LDCAIC_.tb7_0(69);
LDCAIC_.tb7_1(69):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (69)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(69),
LDCAIC_.tb7_1(69),
null,
null,
'N'
,
'N'
,
16,
'N'
,
'Zona Operativa'
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
'OPERATING_ZONE_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(70):=1262916;
LDCAIC_.tb7_0(70):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(70):=LDCAIC_.tb7_0(70);
LDCAIC_.tb7_1(70):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (70)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(70),
LDCAIC_.tb7_1(70),
null,
null,
'N'
,
'N'
,
17,
'N'
,
'Tipo de asignación'
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
'ASSIGN_TYPE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(71):=1262917;
LDCAIC_.tb7_0(71):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(71):=LDCAIC_.tb7_0(71);
LDCAIC_.tb7_1(71):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (71)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(71),
LDCAIC_.tb7_1(71),
null,
null,
'N'
,
'N'
,
18,
'N'
,
'Assign_Capacity'
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
'ASSIGN_CAPACITY'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(72):=1262918;
LDCAIC_.tb7_0(72):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(72):=LDCAIC_.tb7_0(72);
LDCAIC_.tb7_1(72):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (72)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(72),
LDCAIC_.tb7_1(72),
null,
null,
'N'
,
'N'
,
19,
'N'
,
'Used_Assign_Cap'
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
'USED_ASSIGN_CAP'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(73):=1262919;
LDCAIC_.tb7_0(73):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(73):=LDCAIC_.tb7_0(73);
LDCAIC_.tb7_1(73):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (73)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(73),
LDCAIC_.tb7_1(73),
null,
null,
'N'
,
'N'
,
20,
'N'
,
'Aiu_Value_Util'
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
'AIU_VALUE_UTIL'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(74):=1262920;
LDCAIC_.tb7_0(74):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(74):=LDCAIC_.tb7_0(74);
LDCAIC_.tb7_1(74):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (74)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(74),
LDCAIC_.tb7_1(74),
null,
null,
'N'
,
'N'
,
21,
'N'
,
'Aiu_Value_Admin'
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
'AIU_VALUE_ADMIN'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(75):=1262921;
LDCAIC_.tb7_0(75):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(75):=LDCAIC_.tb7_0(75);
LDCAIC_.tb7_1(75):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (75)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(75),
LDCAIC_.tb7_1(75),
null,
null,
'N'
,
'N'
,
22,
'N'
,
'Aiu_Value_Unexpected'
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
'AIU_VALUE_UNEXPECTED'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(76):=1262922;
LDCAIC_.tb7_0(76):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(76):=LDCAIC_.tb7_0(76);
LDCAIC_.tb7_1(76):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (76)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(76),
LDCAIC_.tb7_1(76),
null,
null,
'N'
,
'N'
,
23,
'N'
,
'Password_Required'
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
'PASSWORD_REQUIRED'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(77):=1262923;
LDCAIC_.tb7_0(77):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(77):=LDCAIC_.tb7_0(77);
LDCAIC_.tb7_1(77):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (77)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(77),
LDCAIC_.tb7_1(77),
null,
null,
'Y'
,
'N'
,
24,
'N'
,
'Dirección'
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(78):=1262924;
LDCAIC_.tb7_0(78):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(78):=LDCAIC_.tb7_0(78);
LDCAIC_.tb7_1(78):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (78)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(78),
LDCAIC_.tb7_1(78),
null,
null,
'Y'
,
'N'
,
25,
'N'
,
'Teléfono'
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
'PHONE_NUMBER'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(79):=1262925;
LDCAIC_.tb7_0(79):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(79):=LDCAIC_.tb7_0(79);
LDCAIC_.tb7_1(79):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (79)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(79),
LDCAIC_.tb7_1(79),
null,
null,
'N'
,
'N'
,
26,
'N'
,
'Fax_Number'
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
'FAX_NUMBER'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(80):=1262926;
LDCAIC_.tb7_0(80):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(80):=LDCAIC_.tb7_0(80);
LDCAIC_.tb7_1(80):=LDCAIC_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (80)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(80),
LDCAIC_.tb7_1(80),
null,
null,
'N'
,
'N'
,
27,
'N'
,
'Beeper'
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
'BEEPER'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.tb5_0(2):=LDCAIC_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (2)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,PARENT_STATEMENT_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (LDCAIC_.tb5_0(2),
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
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title>Contratista: {ID_CONTRATISTA}</Title><Subtitle1>Nombre: {NOMBRE_CONTRATISTA} - Descripcion: {DESCRIPCION}</Subtitle1><Subtitle2>Telefono: {TELEFONO} - Correo Electronico: {CORREO_ELECTRONICO}</Subtitle2></OpenQueryHeaderTitle>'
,
null,
null,
null,
null,
0,
'PARENT_ID'
,
'Contratistas'
,
'Y'
);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb6_0(3):=1079802;
LDCAIC_.tb6_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
LDCAIC_.tb6_0(3):=LDCAIC_.tb6_0(3);
LDCAIC_.tb6_1(3):=LDCAIC_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (LDCAIC_.tb6_0(3),
LDCAIC_.tb6_1(3),
null,
null,
-1,
null,
null,
-1,
-1,
0,
'Código'
,
null,
null,
null,
null,
null,
null,
'INUCONTRATISTA'
,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(81):=1262930;
LDCAIC_.tb7_0(81):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(81):=LDCAIC_.tb7_0(81);
LDCAIC_.tb7_2(81):=LDCAIC_.tb6_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (81)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(81),
null,
LDCAIC_.tb7_2(81),
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
'INUCONTRATISTA'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb6_0(4):=1079803;
LDCAIC_.tb6_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
LDCAIC_.tb6_0(4):=LDCAIC_.tb6_0(4);
LDCAIC_.tb6_1(4):=LDCAIC_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,ENTITY_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,MIRROR_ENTI_ATTRIB,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,PARENT_ATTRIBUTE_ID,TAG_NAME,TAB_STOP) 
VALUES (LDCAIC_.tb6_0(4),
LDCAIC_.tb6_1(4),
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
'ISBNOMBRE'
,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(82):=1262931;
LDCAIC_.tb7_0(82):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(82):=LDCAIC_.tb7_0(82);
LDCAIC_.tb7_2(82):=LDCAIC_.tb6_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (82)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(82),
null,
LDCAIC_.tb7_2(82),
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
'ISBNOMBRE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb8_0(2):=95037;
LDCAIC_.tb8_0(2):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
LDCAIC_.tb8_0(2):=LDCAIC_.tb8_0(2);
LDCAIC_.tb8_1(2):=LDCAIC_.tb4_0(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (2)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,DESCRIPTION,ORDER_VIEW,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID) 
VALUES (LDCAIC_.tb8_0(2),
LDCAIC_.tb8_1(2),
'LDC_FW_CONTRATISTA'
,
0,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(83):=1262932;
LDCAIC_.tb7_0(83):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(83):=LDCAIC_.tb7_0(83);
LDCAIC_.tb7_1(83):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (83)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(83),
LDCAIC_.tb7_1(83),
null,
null,
'Y'
,
'N'
,
0,
'N'
,
'Código'
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
'ID_CONTRATISTA'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(84):=1262933;
LDCAIC_.tb7_0(84):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(84):=LDCAIC_.tb7_0(84);
LDCAIC_.tb7_1(84):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (84)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(84),
LDCAIC_.tb7_1(84),
null,
null,
'Y'
,
'N'
,
1,
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
'NOMBRE_CONTRATISTA'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(85):=1262934;
LDCAIC_.tb7_0(85):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(85):=LDCAIC_.tb7_0(85);
LDCAIC_.tb7_1(85):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (85)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(85),
LDCAIC_.tb7_1(85),
null,
null,
'Y'
,
'N'
,
2,
'N'
,
'Descripción'
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
'DESCRIPCION'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(86):=1262935;
LDCAIC_.tb7_0(86):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(86):=LDCAIC_.tb7_0(86);
LDCAIC_.tb7_1(86):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (86)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(86),
LDCAIC_.tb7_1(86),
null,
null,
'Y'
,
'N'
,
3,
'N'
,
'Correo Electrónico'
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
'CORREO_ELECTRONICO'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(87):=1262936;
LDCAIC_.tb7_0(87):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(87):=LDCAIC_.tb7_0(87);
LDCAIC_.tb7_1(87):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (87)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(87),
LDCAIC_.tb7_1(87),
null,
null,
'Y'
,
'N'
,
4,
'N'
,
'Teléfono'
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
'TELEFONO'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(88):=1262937;
LDCAIC_.tb7_0(88):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(88):=LDCAIC_.tb7_0(88);
LDCAIC_.tb7_1(88):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (88)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(88),
LDCAIC_.tb7_1(88),
null,
null,
'Y'
,
'N'
,
5,
'N'
,
'Nombre Contacto'
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
'NOMBRE_CONTACTO'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(89):=1262938;
LDCAIC_.tb7_0(89):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(89):=LDCAIC_.tb7_0(89);
LDCAIC_.tb7_1(89):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (89)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(89),
LDCAIC_.tb7_1(89),
null,
null,
'Y'
,
'N'
,
6,
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
'ID_EMPRESA'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(90):=1262939;
LDCAIC_.tb7_0(90):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(90):=LDCAIC_.tb7_0(90);
LDCAIC_.tb7_1(90):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (90)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(90),
LDCAIC_.tb7_1(90),
null,
null,
'N'
,
'N'
,
7,
'N'
,
'Id_Suscriptor'
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
'ID_SUSCRIPTOR'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(91):=1262940;
LDCAIC_.tb7_0(91):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(91):=LDCAIC_.tb7_0(91);
LDCAIC_.tb7_1(91):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (91)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(91),
LDCAIC_.tb7_1(91),
null,
null,
'Y'
,
'N'
,
8,
'N'
,
'Tipo de Autorización'
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
'ID_TIPOAUTORIZACION'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(92):=1262941;
LDCAIC_.tb7_0(92):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(92):=LDCAIC_.tb7_0(92);
LDCAIC_.tb7_1(92):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (92)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(92),
LDCAIC_.tb7_1(92),
null,
null,
'Y'
,
'N'
,
9,
'N'
,
'Tipo de Contribuyente'
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
'ID_TIPOCONTRIBUYENTE'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(93):=1262942;
LDCAIC_.tb7_0(93):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(93):=LDCAIC_.tb7_0(93);
LDCAIC_.tb7_1(93):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (93)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(93),
LDCAIC_.tb7_1(93),
null,
null,
'Y'
,
'N'
,
10,
'N'
,
'Estado'
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
'STATUS'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(94):=1262943;
LDCAIC_.tb7_0(94):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(94):=LDCAIC_.tb7_0(94);
LDCAIC_.tb7_1(94):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (94)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(94),
LDCAIC_.tb7_1(94),
null,
null,
'Y'
,
'N'
,
11,
'N'
,
'Identificación'
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(95):=1262944;
LDCAIC_.tb7_0(95):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(95):=LDCAIC_.tb7_0(95);
LDCAIC_.tb7_1(95):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (95)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(95),
LDCAIC_.tb7_1(95),
null,
null,
'Y'
,
'N'
,
12,
'N'
,
'¿Pertenece al Régimen Común?'
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
'COMMON_REG'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(96):=1262945;
LDCAIC_.tb7_0(96):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(96):=LDCAIC_.tb7_0(96);
LDCAIC_.tb7_1(96):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (96)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(96),
LDCAIC_.tb7_1(96),
null,
null,
'Y'
,
'N'
,
13,
'N'
,
'¿Es Autoretenedor de IVA?'
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
'IVA_TAX'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(97):=1262946;
LDCAIC_.tb7_0(97):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(97):=LDCAIC_.tb7_0(97);
LDCAIC_.tb7_1(97):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (97)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(97),
LDCAIC_.tb7_1(97),
null,
null,
'Y'
,
'N'
,
14,
'N'
,
'¿Es Autoretenedor de Fuente?'
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
'WITHHOLDING_TAX'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(98):=1262947;
LDCAIC_.tb7_0(98):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(98):=LDCAIC_.tb7_0(98);
LDCAIC_.tb7_1(98):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (98)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(98),
LDCAIC_.tb7_1(98),
null,
null,
'Y'
,
'N'
,
15,
'N'
,
'Cargo del Representante Legal'
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
'POSITION_TYPE_ID'
,
null,
null);

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;

LDCAIC_.old_tb7_0(99):=1262948;
LDCAIC_.tb7_0(99):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
LDCAIC_.tb7_0(99):=LDCAIC_.tb7_0(99);
LDCAIC_.tb7_1(99):=LDCAIC_.tb8_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (99)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,FRAME_ID,COMP_ATTRIBS_ID,ENTITY_ATTRIBUTE_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,PARENT_ATTRIBUTE_ID,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (LDCAIC_.tb7_0(99),
LDCAIC_.tb7_1(99),
null,
null,
'N'
,
'N'
,
16,
'N'
,
'Parent_Id'
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
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
    nuIndex             BINARY_INTEGER;
    nuNewSAExecutable   sa_executable.executable_id%type;
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
SELECT executable_id INTO nuNewSAExecutable FROM sa_executable WHERE name = 'LDCAIC';

nuIndex := LDCAIC_.tbOldSAExecSynonParent.first;
while ( nuIndex IS NOT null) LOOP
    INSERT INTO sa_executable_synon
        (executable_synon_id, executable_id, synonymous_id, IS_active)
    VALUES
        (sa_bosequences.fnuGetSEQ_SA_EXECUTABLE_SYNON,
         LDCAIC_.tbOldSAExecSynonParent(nuIndex).executable_id,
         nuNewSAExecutable,
         LDCAIC_.tbOldSAExecSynonParent(nuIndex).is_active);
    nuIndex := LDCAIC_.tbOldSAExecSynonParent.next(nuIndex);
END loop;

nuIndex := LDCAIC_.tbOldSAExecSynonSon.first;
while ( nuIndex IS NOT null) LOOP
    INSERT INTO sa_executable_synon
        (executable_synon_id, executable_id, synonymous_id, IS_active)
    VALUES
        (sa_bosequences.fnuGetSEQ_SA_EXECUTABLE_SYNON,
         nuNewSAExecutable,
         LDCAIC_.tbOldSAExecSynonSon(nuIndex).synonymous_id,
         LDCAIC_.tbOldSAExecSynonSon(nuIndex).is_active);
    nuIndex := LDCAIC_.tbOldSAExecSynonSon.next(nuIndex);
END loop;
   GI_BOFrameworkUserConfig.SyncUserConfig('LDCAIC');

exception when others then
LDCAIC_.blProcessStatus := false;
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
 nuIndexInternal := LDCAIC_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDCAIC_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDCAIC_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDCAIC_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDCAIC_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDCAIC_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDCAIC_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDCAIC_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDCAIC_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDCAIC_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDCAIC_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCAIC_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDCAIC_.tbUserException(nuIndex).user_id, LDCAIC_.tbUserException(nuIndex).status , LDCAIC_.tbUserException(nuIndex).usr_exc_type_id, LDCAIC_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDCAIC_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDCAIC_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDCAIC_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDCAIC_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDCAIC_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDCAIC_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCAIC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCAIC_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCAIC_',
'CREATE OR REPLACE PACKAGE LDCAIC_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_CTRL_BY_TAB_APPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CTRL_BY_TAB_APPRowId tyGI_CTRL_BY_TAB_APPRowId; ' || chr(10) ||
'END LDCAIC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCAIC_******************************'); END;
/


BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CTRL_BY_TAB_APP',1);
  DELETE FROM GI_CTRL_BY_TAB_APP WHERE APPLICATION='LDCAIC';

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCAIC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCAIC_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCAIC_',
'CREATE OR REPLACE PACKAGE LDCAIC_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_APPLIC_COMPONENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_APPLIC_COMPONENTRowId tyGI_APPLIC_COMPONENTRowId; ' || chr(10) ||
'END LDCAIC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCAIC_******************************'); END;
/


BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_APPLIC_COMPONENT',1);
  DELETE FROM GI_APPLIC_COMPONENT WHERE APPLICATION_NAME='LDCAIC';

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCAIC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCAIC_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCAIC_',
'CREATE OR REPLACE PACKAGE LDCAIC_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_ALT_ATRB_BROWSERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_ALT_ATRB_BROWSERowId tyGI_ALT_ATRB_BROWSERowId; ' || chr(10) ||
'END LDCAIC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCAIC_******************************'); END;
/


BEGIN

if (not LDCAIC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_ALT_ATRB_BROWSE',1);
  DELETE FROM GI_ALT_ATRB_BROWSE WHERE APPLICATION='LDCAIC';

exception when others then
LDCAIC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('LDCAIC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCAIC_******************************'); end;
/

