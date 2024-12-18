BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CCCCR_3051_1_',
'CREATE OR REPLACE PACKAGE CCCCR_3051_1_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGI_CONFIGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIGRowId tyGI_CONFIGRowId;type tyGI_CONFIG_COMPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIG_COMPRowId tyGI_CONFIG_COMPRowId;type tyGI_COMPOSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITIONRowId tyGI_COMPOSITIONRowId;type tyGI_FRAMERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_FRAMERowId tyGI_FRAMERowId;type tyGI_COMP_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_ATTRIBSRowId tyGI_COMP_ATTRIBSRowId;type tyGI_COMP_FRAME_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_FRAME_ATTRIBRowId tyGI_COMP_FRAME_ATTRIBRowId;type tyGI_COMPOSITION_ADITIRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITION_ADITIRowId tyGI_COMPOSITION_ADITIRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGI_NAVIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_NAVIG_EXPRESSIONRowId tyGI_NAVIG_EXPRESSIONRowId;type tyGI_NAVIG_EXP_VALUESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_NAVIG_EXP_VALUESRowId tyGI_NAVIG_EXP_VALUESRowId;type ty0_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of GI_CONFIG.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_2 is table of GI_CONFIG.ACCEPT_RULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty1_3 is table of GI_CONFIG.ENTITY_ROOT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_3 ty1_3; ' || chr(10) ||
'tb1_3 ty1_3;type ty2_0 is table of GI_COMPOSITION.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GI_COMPOSITION.EXTERNAL_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of GI_COMPOSITION.ENTITY_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_3 is table of GI_COMPOSITION.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_3 ty2_3; ' || chr(10) ||
'tb2_3 ty2_3;type ty2_4 is table of GI_COMPOSITION.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_4 ty2_4; ' || chr(10) ||
'tb2_4 ty2_4;type ty3_0 is table of GI_CONFIG_COMP.CONFIG_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GI_CONFIG_COMP.CONFIG_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GI_CONFIG_COMP.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GI_CONFIG_COMP.PARENT_COMP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of GI_COMPOSITION_ADITI.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty5_0 is table of GI_COMP_ATTRIBS.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of GI_COMP_ATTRIBS.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of GI_COMP_ATTRIBS.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty5_3 is table of GI_COMP_ATTRIBS.MIRROR_ENTI_ATTRIB%type index by binary_integer; ' || chr(10) ||
'old_tb5_3 ty5_3; ' || chr(10) ||
'tb5_3 ty5_3;type ty5_4 is table of GI_COMP_ATTRIBS.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_4 ty5_4; ' || chr(10) ||
'tb5_4 ty5_4;type ty5_5 is table of GI_COMP_ATTRIBS.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_5 ty5_5; ' || chr(10) ||
'tb5_5 ty5_5;type ty5_6 is table of GI_COMP_ATTRIBS.PARENT_GROUP_ATTR_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_6 ty5_6; ' || chr(10) ||
'tb5_6 ty5_6;type ty5_7 is table of GI_COMP_ATTRIBS.SELECT_STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_7 ty5_7; ' || chr(10) ||
'tb5_7 ty5_7;type ty5_8 is table of GI_COMP_ATTRIBS.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_8 ty5_8; ' || chr(10) ||
'tb5_8 ty5_8;type ty5_9 is table of GI_COMP_ATTRIBS.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_9 ty5_9; ' || chr(10) ||
'tb5_9 ty5_9;type ty6_0 is table of GI_FRAME.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of GI_FRAME.COMPOSITION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of GI_FRAME.AFTER_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty6_3 is table of GI_FRAME.BEFORE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_3 ty6_3; ' || chr(10) ||
'tb6_3 ty6_3;type ty7_0 is table of GI_COMP_FRAME_ATTRIB.COMP_FRAME_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of GI_COMP_FRAME_ATTRIB.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of GI_COMP_FRAME_ATTRIB.PARENT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty7_3 is table of GI_COMP_FRAME_ATTRIB.FRAME_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_3 ty7_3; ' || chr(10) ||
'tb7_3 ty7_3;type ty7_4 is table of GI_COMP_FRAME_ATTRIB.COMP_ATTRIBS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_4 ty7_4; ' || chr(10) ||
'tb7_4 ty7_4;type ty8_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GI_NAVIG_EXPRESSION.NAVIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of GI_NAVIG_EXPRESSION.EXTERNAL_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty10_0 is table of GI_NAVIG_EXP_VALUES.NAVIG_EXP_VALUES_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of GI_NAVIG_EXP_VALUES.NAVIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1; ' || chr(10) ||
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
'SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = ''F''  ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = ''F''  ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = ''F''  ' || chr(10) ||
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
'END CCCCR_3051_1_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CCCCR_3051_1_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
Open CCCCR_3051_1_.cuRoleExecutables;
loop
 fetch CCCCR_3051_1_.cuRoleExecutables INTO CCCCR_3051_1_.rcRoleExecutables;
 exit when  CCCCR_3051_1_.cuRoleExecutables%notfound;
 CCCCR_3051_1_.tbRoleExecutables(nuIndex) := CCCCR_3051_1_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close CCCCR_3051_1_.cuRoleExecutables;
nuIndex := 0;
Open CCCCR_3051_1_.cuUserExceptions ;
loop
 fetch CCCCR_3051_1_.cuUserExceptions INTO  CCCCR_3051_1_.rcUserExceptions;
 exit when CCCCR_3051_1_.cuUserExceptions%notfound;
 CCCCR_3051_1_.tbUserException(nuIndex):=CCCCR_3051_1_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close CCCCR_3051_1_.cuUserExceptions;
nuIndex := 0;
Open CCCCR_3051_1_.cuExecEntities ;
loop
 fetch CCCCR_3051_1_.cuExecEntities INTO  CCCCR_3051_1_.rcExecEntities;
 exit when CCCCR_3051_1_.cuExecEntities%notfound;
 CCCCR_3051_1_.tbExecEntities(nuIndex):=CCCCR_3051_1_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close CCCCR_3051_1_.cuExecEntities;

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' 
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' 
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' 
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  CC_BOClientRegisterComponent.DeleteApplication(3051, 1, 7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN 
   CCCCR_3051_1_.tbEntityName(-1) := 'NULL';
   CCCCR_3051_1_.tbEntityAttributeName(-1) := 'NULL';

   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityName(9716) := 'GE_SUBS_FISCAL_DATA';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityName(9725) := 'GE_SUBS_BUSINES_DATA';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityAttributeName(-1) := 'DUAL@NULL';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(653) := 'GE_SUBSCRIBER@SUBSCRIBER_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(654) := 'GE_SUBSCRIBER@SUBS_LAST_NAME';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(655) := 'GE_SUBSCRIBER@E_MAIL';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(795) := 'GE_SUBSCRIBER@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(796) := 'GE_SUBSCRIBER@IDENTIFICATION';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(797) := 'GE_SUBSCRIBER@SUBSCRIBER_NAME';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(798) := 'GE_SUBSCRIBER@ADDRESS';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(799) := 'GE_SUBSCRIBER@PHONE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(1112) := 'GE_SUBS_WORK_RELAT@ADDRESS_ID';
   CCCCR_3051_1_.tbEntityName(9716) := 'GE_SUBS_FISCAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20251) := 'GE_SUBS_FISCAL_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20255) := 'GE_SUBS_GENERAL_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20256) := 'GE_SUBS_GENERAL_DATA@DATE_BIRTH';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20257) := 'GE_SUBS_GENERAL_DATA@GENDER';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20258) := 'GE_SUBS_GENERAL_DATA@CIVIL_STATE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20259) := 'GE_SUBS_GENERAL_DATA@SCHOOL_DEGREE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20260) := 'GE_SUBS_GENERAL_DATA@WAGE_SCALE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20261) := 'GE_SUBS_GENERAL_DATA@DEBIT_SCALE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20262) := 'GE_SUBS_GENERAL_DATA@PROFESSION_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20263) := 'GE_SUBS_GENERAL_DATA@COMMENT_';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20264) := 'GE_SUBS_GENERAL_DATA@BIRTH_LOCATION_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20266) := 'GE_SUBS_GENERAL_DATA@LAST_UPDATE';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20268) := 'GE_SUBS_GENERAL_DATA@OLD_OPERATOR';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20269) := 'GE_SUBS_WORK_RELAT@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20270) := 'GE_SUBS_WORK_RELAT@COMPANY';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20271) := 'GE_SUBS_WORK_RELAT@HIRE_DATE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20272) := 'GE_SUBS_WORK_RELAT@PHONE_OFFICE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20273) := 'GE_SUBS_WORK_RELAT@ACTIVITY_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20274) := 'GE_SUBS_WORK_RELAT@TITLE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20275) := 'GE_SUBS_WORK_RELAT@WORKED_TIME';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20276) := 'GE_SUBS_WORK_RELAT@EXPERIENCE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20278) := 'GE_SUBS_WORK_RELAT@PREVIOUS_COMPANY';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20280) := 'GE_SUBS_WORK_RELAT@OCCUPATION';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20282) := 'GE_SUBS_FAMILY_DATA@HAS_VEHICULE';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20283) := 'GE_SUBS_FAMILY_DATA@COUPLE_ACTIVITY_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20284) := 'GE_SUBS_FAMILY_DATA@COUPLE_IDENTIFY';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20285) := 'GE_SUBS_FAMILY_DATA@COUPLE_NAME';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20286) := 'GE_SUBS_FAMILY_DATA@COUPLE_WAGE_SCALE';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20287) := 'GE_SUBS_FAMILY_DATA@NUMBER_DEPEND_PEOPLE';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20288) := 'GE_SUBS_FAMILY_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20289) := 'GE_SUBS_FAMILY_DATA@VEHICULE_BRAND';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20290) := 'GE_SUBS_FAMILY_DATA@VEHICULE_MODEL';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20291) := 'GE_SUBS_HOUSING_DATA@HOUSE_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20293) := 'GE_SUBS_HOUSING_DATA@RENTER_NAME';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20294) := 'GE_SUBS_HOUSING_DATA@RENTER_PHONE';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20296) := 'GE_SUBS_HOUSING_DATA@YEARS_LIVING_HOUSE';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20300) := 'GE_SUBS_HOUSING_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20305) := 'GE_SUBS_REFEREN_DATA@ACTIVITY_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20306) := 'GE_SUBS_REFEREN_DATA@ADDRESS_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20308) := 'GE_SUBS_REFEREN_DATA@COMMENT_';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20311) := 'GE_SUBS_REFEREN_DATA@IDENTIFICATION';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20312) := 'GE_SUBS_REFEREN_DATA@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20313) := 'GE_SUBS_REFEREN_DATA@LAST_NAME';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20315) := 'GE_SUBS_REFEREN_DATA@NAME_';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20317) := 'GE_SUBS_REFEREN_DATA@PHONE';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20318) := 'GE_SUBS_REFEREN_DATA@REFERENCE_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20319) := 'GE_SUBS_REFEREN_DATA@RELATIONSHIP';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20320) := 'GE_SUBS_REFEREN_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20321) := 'GE_SUBS_REFEREN_DATA@SUBS_REFERENCE_ID';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20328) := 'GE_SUBS_DOCUMEN_DATA@ACTIVE';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20329) := 'GE_SUBS_DOCUMEN_DATA@ITEM_CHECK_LIST';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20330) := 'GE_SUBS_DOCUMEN_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20332) := 'GE_SUBS_DOCUMEN_DATA@VALUE';
   CCCCR_3051_1_.tbEntityName(9725) := 'GE_SUBS_BUSINES_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20335) := 'GE_SUBS_BUSINES_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20346) := 'GE_SUBS_EXT_SCORING@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20347) := 'GE_SUBS_EXT_SCORING@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20348) := 'GE_SUBS_EXT_SCORING@IDENTIFICATION';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20349) := 'GE_SUBS_EXT_SCORING@AUTORIZATION_NUMBER';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20351) := 'GE_SUBS_EXT_SCORING@RESULT';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20353) := 'GE_SUBS_EXT_SCORING@SCORE';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20354) := 'GE_SUBS_EXT_SCORING@QUERY_DATE';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(20360) := 'GE_SUBSCRIBER@SUBS_STATUS_ID';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(44081) := 'GE_SUBS_DOCUMEN_DATA@FILE_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55554) := 'GE_SUBS_PHONE@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55555) := 'GE_SUBS_PHONE@SUBS_PHONE_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55556) := 'GE_SUBS_PHONE@PHONE';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55558) := 'GE_SUBS_PHONE@DESCRIPTION';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55580) := 'GE_THIRD_PART_SERV@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55581) := 'GE_THIRD_PART_SERV@THIRD_PART_SERV_ID';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55582) := 'GE_THIRD_PART_SERV@SERVICE_NAME';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55584) := 'GE_THIRD_PART_SERV@MONTHLY_COST';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55585) := 'GE_THIRD_PART_SERV@SERVICE_TIME';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityAttributeName(55591) := 'GE_SUBS_INTEREST@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityAttributeName(55592) := 'GE_SUBS_INTEREST@SUBS_INTEREST_ID';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityAttributeName(55593) := 'GE_SUBS_INTEREST@INTEREST_DATA_ID';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityAttributeName(55596) := 'GE_SUBS_HOBBIES@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityAttributeName(55597) := 'GE_SUBS_HOBBIES@SUBS_HOBBIES_ID';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityAttributeName(55598) := 'GE_SUBS_HOBBIES@HOBBIES_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(55619) := 'GE_SUBS_WORK_RELAT@PHONE_EXTENSION';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(55620) := 'GE_SUBS_WORK_RELAT@WORK_AREA';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(55860) := 'GE_SUBS_HOUSING_DATA@PERSON_QUANTITY';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56802) := 'CLIENT_REGISTER@BTN_EXT_SCORING';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56804) := 'CLIENT_REGISTER@CLASS_PERSON';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56805) := 'CLIENT_REGISTER@ID';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56807) := 'CLIENT_REGISTER@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(56823) := 'GE_SUBSCRIBER@CONTACT_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(67179) := 'GE_SUBSCRIBER@ADDRESS_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(71220) := 'GE_SUBSCRIBER@DATA_SEND';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(84062) := 'GE_SUBSCRIBER@VINCULATE_DATE';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(97607) := 'GE_SUBSCRIBER@ACCEPT_CALL';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97608) := 'GE_SUBS_PHONE@PHONE_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97611) := 'GE_SUBS_PHONE@TECHNICAL_SMS';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97612) := 'GE_SUBS_PHONE@ADMINISTRATIVE_SMS';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97613) := 'GE_SUBS_PHONE@COMERCIAL_SMS';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(106453) := 'GE_SUBS_PHONE@FULL_PHONE_NUMBER';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(133384) := 'GE_SUBS_HOUSING_DATA@CATEGORY_ID';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(133385) := 'GE_SUBS_HOUSING_DATA@SUBCATEGORY_ID';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044256) := 'LDC_PROTECCION_DATOS@ID_CLIENTE';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044257) := 'LDC_PROTECCION_DATOS@COD_ESTADO_LEY';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044258) := 'LDC_PROTECCION_DATOS@ESTADO';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044259) := 'LDC_PROTECCION_DATOS@FECHA_CREACION';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044260) := 'LDC_PROTECCION_DATOS@USUARIO_CREACION';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044261) := 'LDC_PROTECCION_DATOS@PACKAGE_ID';
   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityAttributeName(-1) := 'DUAL@NULL';
   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityAttributeName(-1) := 'DUAL@NULL';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(795) := 'GE_SUBSCRIBER@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(133384) := 'GE_SUBS_HOUSING_DATA@CATEGORY_ID';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044260) := 'LDC_PROTECCION_DATOS@USUARIO_CREACION';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044261) := 'LDC_PROTECCION_DATOS@PACKAGE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20268) := 'GE_SUBS_GENERAL_DATA@OLD_OPERATOR';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(653) := 'GE_SUBSCRIBER@SUBSCRIBER_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56807) := 'CLIENT_REGISTER@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20262) := 'GE_SUBS_GENERAL_DATA@PROFESSION_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(796) := 'GE_SUBSCRIBER@IDENTIFICATION';
   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityAttributeName(-1) := 'DUAL@NULL';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20255) := 'GE_SUBS_GENERAL_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20283) := 'GE_SUBS_FAMILY_DATA@COUPLE_ACTIVITY_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20258) := 'GE_SUBS_GENERAL_DATA@CIVIL_STATE_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20288) := 'GE_SUBS_FAMILY_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20285) := 'GE_SUBS_FAMILY_DATA@COUPLE_NAME';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20296) := 'GE_SUBS_HOUSING_DATA@YEARS_LIVING_HOUSE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20271) := 'GE_SUBS_WORK_RELAT@HIRE_DATE';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20320) := 'GE_SUBS_REFEREN_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20354) := 'GE_SUBS_EXT_SCORING@QUERY_DATE';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97612) := 'GE_SUBS_PHONE@ADMINISTRATIVE_SMS';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityAttributeName(55593) := 'GE_SUBS_INTEREST@INTEREST_DATA_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(655) := 'GE_SUBSCRIBER@E_MAIL';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20266) := 'GE_SUBS_GENERAL_DATA@LAST_UPDATE';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20300) := 'GE_SUBS_HOUSING_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(97607) := 'GE_SUBSCRIBER@ACCEPT_CALL';
   CCCCR_3051_1_.tbEntityName(9725) := 'GE_SUBS_BUSINES_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20335) := 'GE_SUBS_BUSINES_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20315) := 'GE_SUBS_REFEREN_DATA@NAME_';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20318) := 'GE_SUBS_REFEREN_DATA@REFERENCE_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20308) := 'GE_SUBS_REFEREN_DATA@COMMENT_';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20330) := 'GE_SUBS_DOCUMEN_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56802) := 'CLIENT_REGISTER@BTN_EXT_SCORING';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20346) := 'GE_SUBS_EXT_SCORING@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97611) := 'GE_SUBS_PHONE@TECHNICAL_SMS';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55554) := 'GE_SUBS_PHONE@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityAttributeName(55596) := 'GE_SUBS_HOBBIES@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityAttributeName(55597) := 'GE_SUBS_HOBBIES@SUBS_HOBBIES_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(797) := 'GE_SUBSCRIBER@SUBSCRIBER_NAME';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20294) := 'GE_SUBS_HOUSING_DATA@RENTER_PHONE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20275) := 'GE_SUBS_WORK_RELAT@WORKED_TIME';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20273) := 'GE_SUBS_WORK_RELAT@ACTIVITY_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(55620) := 'GE_SUBS_WORK_RELAT@WORK_AREA';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20347) := 'GE_SUBS_EXT_SCORING@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55558) := 'GE_SUBS_PHONE@DESCRIPTION';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55555) := 'GE_SUBS_PHONE@SUBS_PHONE_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20264) := 'GE_SUBS_GENERAL_DATA@BIRTH_LOCATION_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20257) := 'GE_SUBS_GENERAL_DATA@GENDER';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56804) := 'CLIENT_REGISTER@CLASS_PERSON';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(84062) := 'GE_SUBSCRIBER@VINCULATE_DATE';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(793) := 'GE_SUBSCRIBER@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20284) := 'GE_SUBS_FAMILY_DATA@COUPLE_IDENTIFY';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(133385) := 'GE_SUBS_HOUSING_DATA@SUBCATEGORY_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20276) := 'GE_SUBS_WORK_RELAT@EXPERIENCE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(55619) := 'GE_SUBS_WORK_RELAT@PHONE_EXTENSION';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20306) := 'GE_SUBS_REFEREN_DATA@ADDRESS_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20319) := 'GE_SUBS_REFEREN_DATA@RELATIONSHIP';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20348) := 'GE_SUBS_EXT_SCORING@IDENTIFICATION';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(106453) := 'GE_SUBS_PHONE@FULL_PHONE_NUMBER';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20256) := 'GE_SUBS_GENERAL_DATA@DATE_BIRTH';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(67179) := 'GE_SUBSCRIBER@ADDRESS_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(798) := 'GE_SUBSCRIBER@ADDRESS';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(20360) := 'GE_SUBSCRIBER@SUBS_STATUS_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(71220) := 'GE_SUBSCRIBER@DATA_SEND';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20282) := 'GE_SUBS_FAMILY_DATA@HAS_VEHICULE';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20291) := 'GE_SUBS_HOUSING_DATA@HOUSE_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20270) := 'GE_SUBS_WORK_RELAT@COMPANY';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(1112) := 'GE_SUBS_WORK_RELAT@ADDRESS_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20274) := 'GE_SUBS_WORK_RELAT@TITLE';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20328) := 'GE_SUBS_DOCUMEN_DATA@ACTIVE';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20353) := 'GE_SUBS_EXT_SCORING@SCORE';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97608) := 'GE_SUBS_PHONE@PHONE_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(97613) := 'GE_SUBS_PHONE@COMERCIAL_SMS';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55582) := 'GE_THIRD_PART_SERV@SERVICE_NAME';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044256) := 'LDC_PROTECCION_DATOS@ID_CLIENTE';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044257) := 'LDC_PROTECCION_DATOS@COD_ESTADO_LEY';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044258) := 'LDC_PROTECCION_DATOS@ESTADO';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20259) := 'GE_SUBS_GENERAL_DATA@SCHOOL_DEGREE_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(795) := 'GE_SUBSCRIBER@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(799) := 'GE_SUBSCRIBER@PHONE';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(56823) := 'GE_SUBSCRIBER@CONTACT_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20287) := 'GE_SUBS_FAMILY_DATA@NUMBER_DEPEND_PEOPLE';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20289) := 'GE_SUBS_FAMILY_DATA@VEHICULE_BRAND';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20313) := 'GE_SUBS_REFEREN_DATA@LAST_NAME';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20305) := 'GE_SUBS_REFEREN_DATA@ACTIVITY_ID';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20329) := 'GE_SUBS_DOCUMEN_DATA@ITEM_CHECK_LIST';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55584) := 'GE_THIRD_PART_SERV@MONTHLY_COST';
   CCCCR_3051_1_.tbEntityName(8812) := 'LDC_PROTECCION_DATOS';
   CCCCR_3051_1_.tbEntityAttributeName(90044259) := 'LDC_PROTECCION_DATOS@FECHA_CREACION';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20260) := 'GE_SUBS_GENERAL_DATA@WAGE_SCALE_ID';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20286) := 'GE_SUBS_FAMILY_DATA@COUPLE_WAGE_SCALE';
   CCCCR_3051_1_.tbEntityName(9719) := 'GE_SUBS_FAMILY_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20290) := 'GE_SUBS_FAMILY_DATA@VEHICULE_MODEL';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(133384) := 'GE_SUBS_HOUSING_DATA@CATEGORY_ID';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20293) := 'GE_SUBS_HOUSING_DATA@RENTER_NAME';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20269) := 'GE_SUBS_WORK_RELAT@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20278) := 'GE_SUBS_WORK_RELAT@PREVIOUS_COMPANY';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20317) := 'GE_SUBS_REFEREN_DATA@PHONE';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20321) := 'GE_SUBS_REFEREN_DATA@SUBS_REFERENCE_ID';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(44081) := 'GE_SUBS_DOCUMEN_DATA@FILE_ID';
   CCCCR_3051_1_.tbEntityName(1248) := 'GE_SUBS_PHONE';
   CCCCR_3051_1_.tbEntityAttributeName(55556) := 'GE_SUBS_PHONE@PHONE';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55580) := 'GE_THIRD_PART_SERV@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55581) := 'GE_THIRD_PART_SERV@THIRD_PART_SERV_ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20263) := 'GE_SUBS_GENERAL_DATA@COMMENT_';
   CCCCR_3051_1_.tbEntityName(2117) := 'CLIENT_REGISTER';
   CCCCR_3051_1_.tbEntityAttributeName(56805) := 'CLIENT_REGISTER@ID';
   CCCCR_3051_1_.tbEntityName(9717) := 'GE_SUBS_GENERAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20261) := 'GE_SUBS_GENERAL_DATA@DEBIT_SCALE_ID';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(654) := 'GE_SUBSCRIBER@SUBS_LAST_NAME';
   CCCCR_3051_1_.tbEntityName(9716) := 'GE_SUBS_FISCAL_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20251) := 'GE_SUBS_FISCAL_DATA@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(55860) := 'GE_SUBS_HOUSING_DATA@PERSON_QUANTITY';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20272) := 'GE_SUBS_WORK_RELAT@PHONE_OFFICE';
   CCCCR_3051_1_.tbEntityName(9718) := 'GE_SUBS_WORK_RELAT';
   CCCCR_3051_1_.tbEntityAttributeName(20280) := 'GE_SUBS_WORK_RELAT@OCCUPATION';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20312) := 'GE_SUBS_REFEREN_DATA@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9721) := 'GE_SUBS_REFEREN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20311) := 'GE_SUBS_REFEREN_DATA@IDENTIFICATION';
   CCCCR_3051_1_.tbEntityName(9723) := 'GE_SUBS_DOCUMEN_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(20332) := 'GE_SUBS_DOCUMEN_DATA@VALUE';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20351) := 'GE_SUBS_EXT_SCORING@RESULT';
   CCCCR_3051_1_.tbEntityName(9727) := 'GE_SUBS_EXT_SCORING';
   CCCCR_3051_1_.tbEntityAttributeName(20349) := 'GE_SUBS_EXT_SCORING@AUTORIZATION_NUMBER';
   CCCCR_3051_1_.tbEntityName(1251) := 'GE_THIRD_PART_SERV';
   CCCCR_3051_1_.tbEntityAttributeName(55585) := 'GE_THIRD_PART_SERV@SERVICE_TIME';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityAttributeName(55591) := 'GE_SUBS_INTEREST@SUBSCRIBER_ID';
   CCCCR_3051_1_.tbEntityName(1253) := 'GE_SUBS_INTEREST';
   CCCCR_3051_1_.tbEntityAttributeName(55592) := 'GE_SUBS_INTEREST@SUBS_INTEREST_ID';
   CCCCR_3051_1_.tbEntityName(1255) := 'GE_SUBS_HOBBIES';
   CCCCR_3051_1_.tbEntityAttributeName(55598) := 'GE_SUBS_HOBBIES@HOBBIES_ID';
   CCCCR_3051_1_.tbEntityName(-1) := 'DUAL';
   CCCCR_3051_1_.tbEntityAttributeName(-1) := 'DUAL@NULL';
   CCCCR_3051_1_.tbEntityName(3203) := 'GE_SUBSCRIBER';
   CCCCR_3051_1_.tbEntityAttributeName(795) := 'GE_SUBSCRIBER@IDENT_TYPE_ID';
   CCCCR_3051_1_.tbEntityName(9720) := 'GE_SUBS_HOUSING_DATA';
   CCCCR_3051_1_.tbEntityAttributeName(133384) := 'GE_SUBS_HOUSING_DATA@CATEGORY_ID';
   CCCCR_3051_1_.tbEntityName(3051) := 'GE_IDENTIFICA_TYPE';
END; 
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT ACCEPT_RULE_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' );
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' );

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ));

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION_ADITI',1);
  DELETE FROM GI_COMPOSITION_ADITI WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ));

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_NAVIG_EXP_VALUES',1);
  DELETE FROM GI_NAVIG_EXP_VALUES WHERE (NAVIG_EXPRESSION_ID) in (SELECT NAVIG_EXPRESSION_ID FROM GI_NAVIG_EXPRESSION WHERE (EXTERNAL_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ))) AND navig_type_id = 1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_NAVIG_EXPRESSION',1);
  DELETE FROM GI_NAVIG_EXPRESSION WHERE (EXTERNAL_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ))) AND navig_type_id = 1;

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ));

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = CCCCR_3051_1_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_COMPOSITION WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_COMPOSITION',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGI_COMPOSITIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )));

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ));

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_COMPOSITION',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGI_COMPOSITIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_COMPOSITION where rowid = CCCCR_3051_1_.tbGI_COMPOSITIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGI_COMPOSITIONRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGI_COMPOSITIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' );

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' ;

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
CCCCR_3051_1_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(0):=121403928;
CCCCR_3051_1_.tb0_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(0):=CCCCR_3051_1_.tb0_0(0);
CCCCR_3051_1_.old_tb0_1(0):='GEGE_EXERULVAL_CT69E121403928'
;
CCCCR_3051_1_.tb0_1(0):=CCCCR_3051_1_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(0),
CCCCR_3051_1_.tb0_1(0),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbINSTANCE);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbINSTANCE,NULL,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbVALUE);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbINSTANCE,null,"CLIENT_REGISTER","IDENT_TYPE_ID",depa);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbINSTANCE,null,"CLIENT_REGISTER","ID",loca);if (sbVALUE <> NULL,sbCOUNTER = CC_BOCCCCR_INSTANCE.FNUCOUNTSTACKBYATTRVALUES(sbINSTANCE, "GE_SUBSCRIBER", "SUBSCRIBER_ID", sbVALUE);if (sbCOUNTER > 1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"No se pueden guardar cambios sobre el cliente, porque ya se encuentra en edición.");,LDC_SAVECLIENTECCCCR(sbVALUE,depa,loca););,)'
,
'INTEGRA'
,
to_date('18-04-2012 16:13:20','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 15:14:11','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 15:14:11','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL Registro de Cliente'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb1_0(0):=8921;
CCCCR_3051_1_.tb1_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGID;
CCCCR_3051_1_.tb1_0(0):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb1_2(0):=CCCCR_3051_1_.tb0_0(0);
CCCCR_3051_1_.old_tb1_3(0):=3051;
CCCCR_3051_1_.tb1_3(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb1_3(0),-1)));
ut_trace.trace('insertando tabla: GI_CONFIG fila (0)',1);
INSERT INTO GI_CONFIG(CONFIG_ID,EXTERNAL_ROOT_ID,ACCEPT_RULE_ID,ENTITY_ROOT_ID,CONFIG_TYPE_ID,EXTERNAL_ROOT_TYPE,OBJECT_ID,QUERY_ID,ALLOW_SCHEDULE,ALLOW_FREQUENCY) 
VALUES (CCCCR_3051_1_.tb1_0(0),
1,
CCCCR_3051_1_.tb1_2(0),
CCCCR_3051_1_.tb1_3(0),
7,
'F'
,
null,
302,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(0):=1065979;
CCCCR_3051_1_.tb2_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(0):=CCCCR_3051_1_.tb2_0(0);
CCCCR_3051_1_.old_tb2_1(0):=-1;
CCCCR_3051_1_.tb2_1(0):=CCCCR_3051_1_.old_tb2_1(0);
CCCCR_3051_1_.old_tb2_2(0):=3203;
CCCCR_3051_1_.tb2_2(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(0),-1)));
CCCCR_3051_1_.old_tb2_3(0):=8921;
CCCCR_3051_1_.tb2_3(0):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(0),-1))), CCCCR_3051_1_.old_tb2_1(0), 7 );
CCCCR_3051_1_.tb2_3(0):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (0)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(0),
CCCCR_3051_1_.tb2_1(0),
CCCCR_3051_1_.tb2_2(0),
CCCCR_3051_1_.tb2_3(0),
null,
'INF_CCCCR_TAB_1034637'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(0):=100026153;
CCCCR_3051_1_.tb3_0(0):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(0):=CCCCR_3051_1_.tb3_0(0);
CCCCR_3051_1_.tb3_1(0):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(0):=CCCCR_3051_1_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (0)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(0),
CCCCR_3051_1_.tb3_1(0),
CCCCR_3051_1_.tb3_2(0),
null,
-1,
1,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(1):=1065980;
CCCCR_3051_1_.tb2_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(1):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.old_tb2_1(1):=-1;
CCCCR_3051_1_.tb2_1(1):=CCCCR_3051_1_.old_tb2_1(1);
CCCCR_3051_1_.old_tb2_2(1):=-1;
CCCCR_3051_1_.tb2_2(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(1),-1)));
CCCCR_3051_1_.old_tb2_3(1):=8921;
CCCCR_3051_1_.tb2_3(1):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(1),-1))), CCCCR_3051_1_.old_tb2_1(1), 7 );
CCCCR_3051_1_.tb2_3(1):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(1):=CCCCR_3051_1_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (1)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(1),
CCCCR_3051_1_.tb2_1(1),
CCCCR_3051_1_.tb2_2(1),
CCCCR_3051_1_.tb2_3(1),
CCCCR_3051_1_.tb2_4(1),
'INF_CCCCR_FRAME_1034638'
,
1,
999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(1):=100026154;
CCCCR_3051_1_.tb3_0(1):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(1):=CCCCR_3051_1_.tb3_0(1);
CCCCR_3051_1_.tb3_1(1):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(1):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.tb3_3(1):=CCCCR_3051_1_.tb3_0(0);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (1)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(1),
CCCCR_3051_1_.tb3_1(1),
CCCCR_3051_1_.tb3_2(1),
CCCCR_3051_1_.tb3_3(1),
-1,
0,
1,
999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(2):=1065981;
CCCCR_3051_1_.tb2_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(2):=CCCCR_3051_1_.tb2_0(2);
CCCCR_3051_1_.old_tb2_1(2):=-1;
CCCCR_3051_1_.tb2_1(2):=CCCCR_3051_1_.old_tb2_1(2);
CCCCR_3051_1_.old_tb2_2(2):=3203;
CCCCR_3051_1_.tb2_2(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(2),-1)));
CCCCR_3051_1_.old_tb2_3(2):=8921;
CCCCR_3051_1_.tb2_3(2):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(2),-1))), CCCCR_3051_1_.old_tb2_1(2), 7 );
CCCCR_3051_1_.tb2_3(2):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (2)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(2),
CCCCR_3051_1_.tb2_1(2),
CCCCR_3051_1_.tb2_2(2),
CCCCR_3051_1_.tb2_3(2),
null,
'INF_CCCCR_TAB_1021672'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(2):=100026155;
CCCCR_3051_1_.tb3_0(2):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(2):=CCCCR_3051_1_.tb3_0(2);
CCCCR_3051_1_.tb3_1(2):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(2):=CCCCR_3051_1_.tb2_0(2);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (2)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(2),
CCCCR_3051_1_.tb3_1(2),
CCCCR_3051_1_.tb3_2(2),
null,
-1,
0,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(3):=1065982;
CCCCR_3051_1_.tb2_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(3):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.old_tb2_1(3):=-1;
CCCCR_3051_1_.tb2_1(3):=CCCCR_3051_1_.old_tb2_1(3);
CCCCR_3051_1_.old_tb2_2(3):=-1;
CCCCR_3051_1_.tb2_2(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(3),-1)));
CCCCR_3051_1_.old_tb2_3(3):=8921;
CCCCR_3051_1_.tb2_3(3):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(3),-1))), CCCCR_3051_1_.old_tb2_1(3), 7 );
CCCCR_3051_1_.tb2_3(3):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(3):=CCCCR_3051_1_.tb2_0(2);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (3)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(3),
CCCCR_3051_1_.tb2_1(3),
CCCCR_3051_1_.tb2_2(3),
CCCCR_3051_1_.tb2_3(3),
CCCCR_3051_1_.tb2_4(3),
'INF_CCCCR_FRAME_1021673'
,
0,
1,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(3):=100026156;
CCCCR_3051_1_.tb3_0(3):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(3):=CCCCR_3051_1_.tb3_0(3);
CCCCR_3051_1_.tb3_1(3):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(3):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb3_3(3):=CCCCR_3051_1_.tb3_0(2);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (3)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(3),
CCCCR_3051_1_.tb3_1(3),
CCCCR_3051_1_.tb3_2(3),
CCCCR_3051_1_.tb3_3(3),
-1,
0,
0,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(4):=1065983;
CCCCR_3051_1_.tb2_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(4):=CCCCR_3051_1_.tb2_0(4);
CCCCR_3051_1_.old_tb2_1(4):=-1;
CCCCR_3051_1_.tb2_1(4):=CCCCR_3051_1_.old_tb2_1(4);
CCCCR_3051_1_.old_tb2_2(4):=3203;
CCCCR_3051_1_.tb2_2(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(4),-1)));
CCCCR_3051_1_.old_tb2_3(4):=8921;
CCCCR_3051_1_.tb2_3(4):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(4),-1))), CCCCR_3051_1_.old_tb2_1(4), 7 );
CCCCR_3051_1_.tb2_3(4):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (4)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(4),
CCCCR_3051_1_.tb2_1(4),
CCCCR_3051_1_.tb2_2(4),
CCCCR_3051_1_.tb2_3(4),
null,
'INF_CCCCR_TAB_1021674'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(4):=100026157;
CCCCR_3051_1_.tb3_0(4):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(4):=CCCCR_3051_1_.tb3_0(4);
CCCCR_3051_1_.tb3_1(4):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(4):=CCCCR_3051_1_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (4)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(4),
CCCCR_3051_1_.tb3_1(4),
CCCCR_3051_1_.tb3_2(4),
null,
-1,
2,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(5):=1065984;
CCCCR_3051_1_.tb2_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(5):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.old_tb2_1(5):=-1;
CCCCR_3051_1_.tb2_1(5):=CCCCR_3051_1_.old_tb2_1(5);
CCCCR_3051_1_.old_tb2_2(5):=-1;
CCCCR_3051_1_.tb2_2(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(5),-1)));
CCCCR_3051_1_.old_tb2_3(5):=8921;
CCCCR_3051_1_.tb2_3(5):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(5),-1))), CCCCR_3051_1_.old_tb2_1(5), 7 );
CCCCR_3051_1_.tb2_3(5):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(5):=CCCCR_3051_1_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (5)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(5),
CCCCR_3051_1_.tb2_1(5),
CCCCR_3051_1_.tb2_2(5),
CCCCR_3051_1_.tb2_3(5),
CCCCR_3051_1_.tb2_4(5),
'INF_CCCCR_FRAME_1021675'
,
0,
1,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(5):=100026158;
CCCCR_3051_1_.tb3_0(5):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(5):=CCCCR_3051_1_.tb3_0(5);
CCCCR_3051_1_.tb3_1(5):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(5):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb3_3(5):=CCCCR_3051_1_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (5)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(5),
CCCCR_3051_1_.tb3_1(5),
CCCCR_3051_1_.tb3_2(5),
CCCCR_3051_1_.tb3_3(5),
-1,
0,
0,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(6):=1065985;
CCCCR_3051_1_.tb2_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(6):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.old_tb2_1(6):=-1;
CCCCR_3051_1_.tb2_1(6):=CCCCR_3051_1_.old_tb2_1(6);
CCCCR_3051_1_.old_tb2_2(6):=-1;
CCCCR_3051_1_.tb2_2(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(6),-1)));
CCCCR_3051_1_.old_tb2_3(6):=8921;
CCCCR_3051_1_.tb2_3(6):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(6),-1))), CCCCR_3051_1_.old_tb2_1(6), 7 );
CCCCR_3051_1_.tb2_3(6):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(6):=CCCCR_3051_1_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (6)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(6),
CCCCR_3051_1_.tb2_1(6),
CCCCR_3051_1_.tb2_2(6),
CCCCR_3051_1_.tb2_3(6),
CCCCR_3051_1_.tb2_4(6),
'INF_CCCCR_FRAME_1021676'
,
0,
1,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(6):=100026159;
CCCCR_3051_1_.tb3_0(6):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(6):=CCCCR_3051_1_.tb3_0(6);
CCCCR_3051_1_.tb3_1(6):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(6):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb3_3(6):=CCCCR_3051_1_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (6)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(6),
CCCCR_3051_1_.tb3_1(6),
CCCCR_3051_1_.tb3_2(6),
CCCCR_3051_1_.tb3_3(6),
-1,
2,
0,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(7):=1065986;
CCCCR_3051_1_.tb2_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(7):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.old_tb2_1(7):=-1;
CCCCR_3051_1_.tb2_1(7):=CCCCR_3051_1_.old_tb2_1(7);
CCCCR_3051_1_.old_tb2_2(7):=-1;
CCCCR_3051_1_.tb2_2(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(7),-1)));
CCCCR_3051_1_.old_tb2_3(7):=8921;
CCCCR_3051_1_.tb2_3(7):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(7),-1))), CCCCR_3051_1_.old_tb2_1(7), 7 );
CCCCR_3051_1_.tb2_3(7):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(7):=CCCCR_3051_1_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (7)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(7),
CCCCR_3051_1_.tb2_1(7),
CCCCR_3051_1_.tb2_2(7),
CCCCR_3051_1_.tb2_3(7),
CCCCR_3051_1_.tb2_4(7),
'INF_CCCCR_FRAME_1021677'
,
0,
1,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(7):=100026160;
CCCCR_3051_1_.tb3_0(7):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(7):=CCCCR_3051_1_.tb3_0(7);
CCCCR_3051_1_.tb3_1(7):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(7):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb3_3(7):=CCCCR_3051_1_.tb3_0(4);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (7)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(7),
CCCCR_3051_1_.tb3_1(7),
CCCCR_3051_1_.tb3_2(7),
CCCCR_3051_1_.tb3_3(7),
-1,
3,
0,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(8):=1065987;
CCCCR_3051_1_.tb2_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(8):=CCCCR_3051_1_.tb2_0(8);
CCCCR_3051_1_.old_tb2_1(8):=-1;
CCCCR_3051_1_.tb2_1(8):=CCCCR_3051_1_.old_tb2_1(8);
CCCCR_3051_1_.old_tb2_2(8):=3203;
CCCCR_3051_1_.tb2_2(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(8),-1)));
CCCCR_3051_1_.old_tb2_3(8):=8921;
CCCCR_3051_1_.tb2_3(8):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(8),-1))), CCCCR_3051_1_.old_tb2_1(8), 7 );
CCCCR_3051_1_.tb2_3(8):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (8)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(8),
CCCCR_3051_1_.tb2_1(8),
CCCCR_3051_1_.tb2_2(8),
CCCCR_3051_1_.tb2_3(8),
null,
'INF_CCCCR_TAB_1021680'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(8):=100026161;
CCCCR_3051_1_.tb3_0(8):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(8):=CCCCR_3051_1_.tb3_0(8);
CCCCR_3051_1_.tb3_1(8):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(8):=CCCCR_3051_1_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (8)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(8),
CCCCR_3051_1_.tb3_1(8),
CCCCR_3051_1_.tb3_2(8),
null,
-1,
3,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(9):=1065988;
CCCCR_3051_1_.tb2_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(9):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.old_tb2_1(9):=-1;
CCCCR_3051_1_.tb2_1(9):=CCCCR_3051_1_.old_tb2_1(9);
CCCCR_3051_1_.old_tb2_2(9):=-1;
CCCCR_3051_1_.tb2_2(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(9),-1)));
CCCCR_3051_1_.old_tb2_3(9):=8921;
CCCCR_3051_1_.tb2_3(9):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(9),-1))), CCCCR_3051_1_.old_tb2_1(9), 7 );
CCCCR_3051_1_.tb2_3(9):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(9):=CCCCR_3051_1_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (9)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(9),
CCCCR_3051_1_.tb2_1(9),
CCCCR_3051_1_.tb2_2(9),
CCCCR_3051_1_.tb2_3(9),
CCCCR_3051_1_.tb2_4(9),
'INF_CCCCR_FRAME_1021681'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(9):=100026162;
CCCCR_3051_1_.tb3_0(9):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(9):=CCCCR_3051_1_.tb3_0(9);
CCCCR_3051_1_.tb3_1(9):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(9):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb3_3(9):=CCCCR_3051_1_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (9)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(9),
CCCCR_3051_1_.tb3_1(9),
CCCCR_3051_1_.tb3_2(9),
CCCCR_3051_1_.tb3_3(9),
-1,
2,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(10):=1065989;
CCCCR_3051_1_.tb2_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(10):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.old_tb2_1(10):=-1;
CCCCR_3051_1_.tb2_1(10):=CCCCR_3051_1_.old_tb2_1(10);
CCCCR_3051_1_.old_tb2_2(10):=-1;
CCCCR_3051_1_.tb2_2(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(10),-1)));
CCCCR_3051_1_.old_tb2_3(10):=8921;
CCCCR_3051_1_.tb2_3(10):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(10),-1))), CCCCR_3051_1_.old_tb2_1(10), 7 );
CCCCR_3051_1_.tb2_3(10):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(10):=CCCCR_3051_1_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (10)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(10),
CCCCR_3051_1_.tb2_1(10),
CCCCR_3051_1_.tb2_2(10),
CCCCR_3051_1_.tb2_3(10),
CCCCR_3051_1_.tb2_4(10),
'INF_CCCCR_FRAME_1021682'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(10):=100026163;
CCCCR_3051_1_.tb3_0(10):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(10):=CCCCR_3051_1_.tb3_0(10);
CCCCR_3051_1_.tb3_1(10):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(10):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb3_3(10):=CCCCR_3051_1_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (10)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(10),
CCCCR_3051_1_.tb3_1(10),
CCCCR_3051_1_.tb3_2(10),
CCCCR_3051_1_.tb3_3(10),
-1,
0,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(11):=1065990;
CCCCR_3051_1_.tb2_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(11):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.old_tb2_1(11):=-1;
CCCCR_3051_1_.tb2_1(11):=CCCCR_3051_1_.old_tb2_1(11);
CCCCR_3051_1_.old_tb2_2(11):=-1;
CCCCR_3051_1_.tb2_2(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(11),-1)));
CCCCR_3051_1_.old_tb2_3(11):=8921;
CCCCR_3051_1_.tb2_3(11):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(11),-1))), CCCCR_3051_1_.old_tb2_1(11), 7 );
CCCCR_3051_1_.tb2_3(11):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(11):=CCCCR_3051_1_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (11)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(11),
CCCCR_3051_1_.tb2_1(11),
CCCCR_3051_1_.tb2_2(11),
CCCCR_3051_1_.tb2_3(11),
CCCCR_3051_1_.tb2_4(11),
'INF_CCCCR_FRAME_1029143'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(11):=100026164;
CCCCR_3051_1_.tb3_0(11):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(11):=CCCCR_3051_1_.tb3_0(11);
CCCCR_3051_1_.tb3_1(11):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(11):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb3_3(11):=CCCCR_3051_1_.tb3_0(8);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (11)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(11),
CCCCR_3051_1_.tb3_1(11),
CCCCR_3051_1_.tb3_2(11),
CCCCR_3051_1_.tb3_3(11),
-1,
1,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(12):=1065991;
CCCCR_3051_1_.tb2_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(12):=CCCCR_3051_1_.tb2_0(12);
CCCCR_3051_1_.old_tb2_1(12):=-1;
CCCCR_3051_1_.tb2_1(12):=CCCCR_3051_1_.old_tb2_1(12);
CCCCR_3051_1_.old_tb2_2(12):=3203;
CCCCR_3051_1_.tb2_2(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(12),-1)));
CCCCR_3051_1_.old_tb2_3(12):=8921;
CCCCR_3051_1_.tb2_3(12):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(12),-1))), CCCCR_3051_1_.old_tb2_1(12), 7 );
CCCCR_3051_1_.tb2_3(12):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (12)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(12),
CCCCR_3051_1_.tb2_1(12),
CCCCR_3051_1_.tb2_2(12),
CCCCR_3051_1_.tb2_3(12),
null,
'INF_CCCCR_TAB_1021684'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(12):=100026165;
CCCCR_3051_1_.tb3_0(12):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(12):=CCCCR_3051_1_.tb3_0(12);
CCCCR_3051_1_.tb3_1(12):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(12):=CCCCR_3051_1_.tb2_0(12);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (12)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(12),
CCCCR_3051_1_.tb3_1(12),
CCCCR_3051_1_.tb3_2(12),
null,
-1,
4,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(13):=1065992;
CCCCR_3051_1_.tb2_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(13):=CCCCR_3051_1_.tb2_0(13);
CCCCR_3051_1_.old_tb2_1(13):=-1;
CCCCR_3051_1_.tb2_1(13):=CCCCR_3051_1_.old_tb2_1(13);
CCCCR_3051_1_.old_tb2_2(13):=-1;
CCCCR_3051_1_.tb2_2(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(13),-1)));
CCCCR_3051_1_.old_tb2_3(13):=8921;
CCCCR_3051_1_.tb2_3(13):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(13),-1))), CCCCR_3051_1_.old_tb2_1(13), 7 );
CCCCR_3051_1_.tb2_3(13):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(13):=CCCCR_3051_1_.tb2_0(12);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (13)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(13),
CCCCR_3051_1_.tb2_1(13),
CCCCR_3051_1_.tb2_2(13),
CCCCR_3051_1_.tb2_3(13),
CCCCR_3051_1_.tb2_4(13),
'INF_CCCCR_FRAME_1021685'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(13):=100026166;
CCCCR_3051_1_.tb3_0(13):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(13):=CCCCR_3051_1_.tb3_0(13);
CCCCR_3051_1_.tb3_1(13):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(13):=CCCCR_3051_1_.tb2_0(13);
CCCCR_3051_1_.tb3_3(13):=CCCCR_3051_1_.tb3_0(12);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (13)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(13),
CCCCR_3051_1_.tb3_1(13),
CCCCR_3051_1_.tb3_2(13),
CCCCR_3051_1_.tb3_3(13),
-1,
0,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(14):=1065993;
CCCCR_3051_1_.tb2_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(14):=CCCCR_3051_1_.tb2_0(14);
CCCCR_3051_1_.old_tb2_1(14):=-1;
CCCCR_3051_1_.tb2_1(14):=CCCCR_3051_1_.old_tb2_1(14);
CCCCR_3051_1_.old_tb2_2(14):=3203;
CCCCR_3051_1_.tb2_2(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(14),-1)));
CCCCR_3051_1_.old_tb2_3(14):=8921;
CCCCR_3051_1_.tb2_3(14):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(14),-1))), CCCCR_3051_1_.old_tb2_1(14), 7 );
CCCCR_3051_1_.tb2_3(14):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (14)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(14),
CCCCR_3051_1_.tb2_1(14),
CCCCR_3051_1_.tb2_2(14),
CCCCR_3051_1_.tb2_3(14),
null,
'INF_CCCCR_TAB_1021686'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(14):=100026167;
CCCCR_3051_1_.tb3_0(14):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(14):=CCCCR_3051_1_.tb3_0(14);
CCCCR_3051_1_.tb3_1(14):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(14):=CCCCR_3051_1_.tb2_0(14);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (14)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(14),
CCCCR_3051_1_.tb3_1(14),
CCCCR_3051_1_.tb3_2(14),
null,
-1,
5,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(15):=1065994;
CCCCR_3051_1_.tb2_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(15):=CCCCR_3051_1_.tb2_0(15);
CCCCR_3051_1_.old_tb2_1(15):=-1;
CCCCR_3051_1_.tb2_1(15):=CCCCR_3051_1_.old_tb2_1(15);
CCCCR_3051_1_.old_tb2_2(15):=-1;
CCCCR_3051_1_.tb2_2(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(15),-1)));
CCCCR_3051_1_.old_tb2_3(15):=8921;
CCCCR_3051_1_.tb2_3(15):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(15),-1))), CCCCR_3051_1_.old_tb2_1(15), 7 );
CCCCR_3051_1_.tb2_3(15):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(15):=CCCCR_3051_1_.tb2_0(14);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (15)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(15),
CCCCR_3051_1_.tb2_1(15),
CCCCR_3051_1_.tb2_2(15),
CCCCR_3051_1_.tb2_3(15),
CCCCR_3051_1_.tb2_4(15),
'INF_CCCCR_FRAME_1021688'
,
0,
1,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(15):=100026168;
CCCCR_3051_1_.tb3_0(15):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(15):=CCCCR_3051_1_.tb3_0(15);
CCCCR_3051_1_.tb3_1(15):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(15):=CCCCR_3051_1_.tb2_0(15);
CCCCR_3051_1_.tb3_3(15):=CCCCR_3051_1_.tb3_0(14);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (15)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(15),
CCCCR_3051_1_.tb3_1(15),
CCCCR_3051_1_.tb3_2(15),
CCCCR_3051_1_.tb3_3(15),
-1,
1,
0,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(16):=1065995;
CCCCR_3051_1_.tb2_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(16):=CCCCR_3051_1_.tb2_0(16);
CCCCR_3051_1_.old_tb2_1(16):=-1;
CCCCR_3051_1_.tb2_1(16):=CCCCR_3051_1_.old_tb2_1(16);
CCCCR_3051_1_.old_tb2_2(16):=3203;
CCCCR_3051_1_.tb2_2(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(16),-1)));
CCCCR_3051_1_.old_tb2_3(16):=8921;
CCCCR_3051_1_.tb2_3(16):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(16),-1))), CCCCR_3051_1_.old_tb2_1(16), 7 );
CCCCR_3051_1_.tb2_3(16):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (16)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(16),
CCCCR_3051_1_.tb2_1(16),
CCCCR_3051_1_.tb2_2(16),
CCCCR_3051_1_.tb2_3(16),
null,
'INF_CCCCR_TAB_1021691'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(16):=100026169;
CCCCR_3051_1_.tb3_0(16):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(16):=CCCCR_3051_1_.tb3_0(16);
CCCCR_3051_1_.tb3_1(16):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(16):=CCCCR_3051_1_.tb2_0(16);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (16)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(16),
CCCCR_3051_1_.tb3_1(16),
CCCCR_3051_1_.tb3_2(16),
null,
-1,
6,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(17):=1065996;
CCCCR_3051_1_.tb2_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(17):=CCCCR_3051_1_.tb2_0(17);
CCCCR_3051_1_.old_tb2_1(17):=-1;
CCCCR_3051_1_.tb2_1(17):=CCCCR_3051_1_.old_tb2_1(17);
CCCCR_3051_1_.old_tb2_2(17):=-1;
CCCCR_3051_1_.tb2_2(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(17),-1)));
CCCCR_3051_1_.old_tb2_3(17):=8921;
CCCCR_3051_1_.tb2_3(17):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(17),-1))), CCCCR_3051_1_.old_tb2_1(17), 7 );
CCCCR_3051_1_.tb2_3(17):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(17):=CCCCR_3051_1_.tb2_0(16);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (17)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(17),
CCCCR_3051_1_.tb2_1(17),
CCCCR_3051_1_.tb2_2(17),
CCCCR_3051_1_.tb2_3(17),
CCCCR_3051_1_.tb2_4(17),
'INF_CCCCR_FRAME_1021692'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(17):=100026170;
CCCCR_3051_1_.tb3_0(17):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(17):=CCCCR_3051_1_.tb3_0(17);
CCCCR_3051_1_.tb3_1(17):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(17):=CCCCR_3051_1_.tb2_0(17);
CCCCR_3051_1_.tb3_3(17):=CCCCR_3051_1_.tb3_0(16);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (17)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(17),
CCCCR_3051_1_.tb3_1(17),
CCCCR_3051_1_.tb3_2(17),
CCCCR_3051_1_.tb3_3(17),
-1,
0,
0,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(18):=1065997;
CCCCR_3051_1_.tb2_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(18):=CCCCR_3051_1_.tb2_0(18);
CCCCR_3051_1_.old_tb2_1(18):=-1;
CCCCR_3051_1_.tb2_1(18):=CCCCR_3051_1_.old_tb2_1(18);
CCCCR_3051_1_.old_tb2_2(18):=3203;
CCCCR_3051_1_.tb2_2(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(18),-1)));
CCCCR_3051_1_.old_tb2_3(18):=8921;
CCCCR_3051_1_.tb2_3(18):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(18),-1))), CCCCR_3051_1_.old_tb2_1(18), 7 );
CCCCR_3051_1_.tb2_3(18):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (18)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(18),
CCCCR_3051_1_.tb2_1(18),
CCCCR_3051_1_.tb2_2(18),
CCCCR_3051_1_.tb2_3(18),
null,
'INF_CCCCR_TAB_1021693'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(18):=100026171;
CCCCR_3051_1_.tb3_0(18):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(18):=CCCCR_3051_1_.tb3_0(18);
CCCCR_3051_1_.tb3_1(18):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(18):=CCCCR_3051_1_.tb2_0(18);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (18)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(18),
CCCCR_3051_1_.tb3_1(18),
CCCCR_3051_1_.tb3_2(18),
null,
-1,
7,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(19):=1065998;
CCCCR_3051_1_.tb2_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(19):=CCCCR_3051_1_.tb2_0(19);
CCCCR_3051_1_.old_tb2_1(19):=-1;
CCCCR_3051_1_.tb2_1(19):=CCCCR_3051_1_.old_tb2_1(19);
CCCCR_3051_1_.old_tb2_2(19):=-1;
CCCCR_3051_1_.tb2_2(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(19),-1)));
CCCCR_3051_1_.old_tb2_3(19):=8921;
CCCCR_3051_1_.tb2_3(19):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(19),-1))), CCCCR_3051_1_.old_tb2_1(19), 7 );
CCCCR_3051_1_.tb2_3(19):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(19):=CCCCR_3051_1_.tb2_0(18);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (19)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(19),
CCCCR_3051_1_.tb2_1(19),
CCCCR_3051_1_.tb2_2(19),
CCCCR_3051_1_.tb2_3(19),
CCCCR_3051_1_.tb2_4(19),
'INF_CCCCR_FRAME_1021694'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(19):=100026172;
CCCCR_3051_1_.tb3_0(19):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(19):=CCCCR_3051_1_.tb3_0(19);
CCCCR_3051_1_.tb3_1(19):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(19):=CCCCR_3051_1_.tb2_0(19);
CCCCR_3051_1_.tb3_3(19):=CCCCR_3051_1_.tb3_0(18);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (19)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(19),
CCCCR_3051_1_.tb3_1(19),
CCCCR_3051_1_.tb3_2(19),
CCCCR_3051_1_.tb3_3(19),
-1,
0,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(20):=1065999;
CCCCR_3051_1_.tb2_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(20):=CCCCR_3051_1_.tb2_0(20);
CCCCR_3051_1_.old_tb2_1(20):=-1;
CCCCR_3051_1_.tb2_1(20):=CCCCR_3051_1_.old_tb2_1(20);
CCCCR_3051_1_.old_tb2_2(20):=3203;
CCCCR_3051_1_.tb2_2(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(20),-1)));
CCCCR_3051_1_.old_tb2_3(20):=8921;
CCCCR_3051_1_.tb2_3(20):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(20),-1))), CCCCR_3051_1_.old_tb2_1(20), 7 );
CCCCR_3051_1_.tb2_3(20):=CCCCR_3051_1_.tb1_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (20)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(20),
CCCCR_3051_1_.tb2_1(20),
CCCCR_3051_1_.tb2_2(20),
CCCCR_3051_1_.tb2_3(20),
null,
'INF_CCCCR_TAB_1021695'
,
0,
0,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(20):=100026173;
CCCCR_3051_1_.tb3_0(20):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(20):=CCCCR_3051_1_.tb3_0(20);
CCCCR_3051_1_.tb3_1(20):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(20):=CCCCR_3051_1_.tb2_0(20);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (20)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(20),
CCCCR_3051_1_.tb3_1(20),
CCCCR_3051_1_.tb3_2(20),
null,
-1,
8,
0,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(21):=1066000;
CCCCR_3051_1_.tb2_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(21):=CCCCR_3051_1_.tb2_0(21);
CCCCR_3051_1_.old_tb2_1(21):=-1;
CCCCR_3051_1_.tb2_1(21):=CCCCR_3051_1_.old_tb2_1(21);
CCCCR_3051_1_.old_tb2_2(21):=-1;
CCCCR_3051_1_.tb2_2(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(21),-1)));
CCCCR_3051_1_.old_tb2_3(21):=8921;
CCCCR_3051_1_.tb2_3(21):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(21),-1))), CCCCR_3051_1_.old_tb2_1(21), 7 );
CCCCR_3051_1_.tb2_3(21):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(21):=CCCCR_3051_1_.tb2_0(20);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (21)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(21),
CCCCR_3051_1_.tb2_1(21),
CCCCR_3051_1_.tb2_2(21),
CCCCR_3051_1_.tb2_3(21),
CCCCR_3051_1_.tb2_4(21),
'INF_CCCCR_FRAME_1021697'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(21):=100026174;
CCCCR_3051_1_.tb3_0(21):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(21):=CCCCR_3051_1_.tb3_0(21);
CCCCR_3051_1_.tb3_1(21):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(21):=CCCCR_3051_1_.tb2_0(21);
CCCCR_3051_1_.tb3_3(21):=CCCCR_3051_1_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (21)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(21),
CCCCR_3051_1_.tb3_1(21),
CCCCR_3051_1_.tb3_2(21),
CCCCR_3051_1_.tb3_3(21),
-1,
2,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb2_0(22):=1066001;
CCCCR_3051_1_.tb2_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPOSITIONID;
CCCCR_3051_1_.tb2_0(22):=CCCCR_3051_1_.tb2_0(22);
CCCCR_3051_1_.old_tb2_1(22):=-1;
CCCCR_3051_1_.tb2_1(22):=CCCCR_3051_1_.old_tb2_1(22);
CCCCR_3051_1_.old_tb2_2(22):=-1;
CCCCR_3051_1_.tb2_2(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(22),-1)));
CCCCR_3051_1_.old_tb2_3(22):=8921;
CCCCR_3051_1_.tb2_3(22):=GI_BOCONFIG.FNUGETCONFIG(CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb2_2(22),-1))), CCCCR_3051_1_.old_tb2_1(22), 7 );
CCCCR_3051_1_.tb2_3(22):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb2_4(22):=CCCCR_3051_1_.tb2_0(20);
ut_trace.trace('insertando tabla: GI_COMPOSITION fila (22)',1);
INSERT INTO GI_COMPOSITION(COMPOSITION_ID,EXTERNAL_TYPE_ID,ENTITY_TYPE_ID,CONFIG_ID,PARENT_COMP_ID,TAG_NAME,MIN_OBJECTS,MAX_OBJECTS,CONFIG_TYPE_ID) 
VALUES (CCCCR_3051_1_.tb2_0(22),
CCCCR_3051_1_.tb2_1(22),
CCCCR_3051_1_.tb2_2(22),
CCCCR_3051_1_.tb2_3(22),
CCCCR_3051_1_.tb2_4(22),
'INF_CCCCR_FRAME_1021698'
,
1,
9999,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb3_0(22):=100026175;
CCCCR_3051_1_.tb3_0(22):=GI_BOSEQUENCES.FNUGETNEXTCONFIGCOMPID;
CCCCR_3051_1_.tb3_0(22):=CCCCR_3051_1_.tb3_0(22);
CCCCR_3051_1_.tb3_1(22):=CCCCR_3051_1_.tb1_0(0);
CCCCR_3051_1_.tb3_2(22):=CCCCR_3051_1_.tb2_0(22);
CCCCR_3051_1_.tb3_3(22):=CCCCR_3051_1_.tb3_0(20);
ut_trace.trace('insertando tabla: GI_CONFIG_COMP fila (22)',1);
INSERT INTO GI_CONFIG_COMP(CONFIG_COMP_ID,CONFIG_ID,COMPOSITION_ID,PARENT_COMP_ID,EXTERNAL_ID,ORDER_VIEW,MIN_OBJECTS,MAX_OBJECTS) 
VALUES (CCCCR_3051_1_.tb3_0(22),
CCCCR_3051_1_.tb3_1(22),
CCCCR_3051_1_.tb3_2(22),
CCCCR_3051_1_.tb3_3(22),
-1,
3,
1,
9999);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(0):=CCCCR_3051_1_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (0)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(0),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(0):=1149971;
CCCCR_3051_1_.tb5_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(0):=CCCCR_3051_1_.tb5_0(0);
CCCCR_3051_1_.old_tb5_1(0):=8812;
CCCCR_3051_1_.tb5_1(0):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(0),-1)));
CCCCR_3051_1_.old_tb5_2(0):=90044256;
CCCCR_3051_1_.tb5_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(0),-1)));
CCCCR_3051_1_.old_tb5_3(0):=-1;
CCCCR_3051_1_.tb5_3(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(0),-1)));
CCCCR_3051_1_.old_tb5_4(0):=-1;
CCCCR_3051_1_.tb5_4(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(0),-1)));
CCCCR_3051_1_.tb5_5(0):=CCCCR_3051_1_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (0)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(0),
CCCCR_3051_1_.tb5_1(0),
CCCCR_3051_1_.tb5_2(0),
CCCCR_3051_1_.tb5_3(0),
CCCCR_3051_1_.tb5_4(0),
CCCCR_3051_1_.tb5_5(0),
null,
null,
null,
null,
600,
0,
'Código del cliente'
,
'N'
,
'Y'
,
'Y'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(0):=2465;
CCCCR_3051_1_.tb6_0(0):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(0):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb6_1(0):=CCCCR_3051_1_.tb2_0(1);
ut_trace.trace('insertando tabla: GI_FRAME fila (0)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(0),
CCCCR_3051_1_.tb6_1(0),
null,
null,
'INF_CCCCR_FRAME_1034638'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(0):=1602629;
CCCCR_3051_1_.tb7_0(0):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(0):=CCCCR_3051_1_.tb7_0(0);
CCCCR_3051_1_.old_tb7_1(0):=90044256;
CCCCR_3051_1_.tb7_1(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(0),-1)));
CCCCR_3051_1_.old_tb7_2(0):=-1;
CCCCR_3051_1_.tb7_2(0):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(0),-1)));
CCCCR_3051_1_.tb7_3(0):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb7_4(0):=CCCCR_3051_1_.tb5_0(0);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (0)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(0),
CCCCR_3051_1_.tb7_1(0),
CCCCR_3051_1_.tb7_2(0),
CCCCR_3051_1_.tb7_3(0),
CCCCR_3051_1_.tb7_4(0),
'N'
,
'N'
,
0,
'Y'
,
'Código del cliente'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(0):=120197374;
CCCCR_3051_1_.tb8_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(0):=CCCCR_3051_1_.tb8_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(0),
16,
'LDC Lista Valores Estado Protección Datos'
,
'SELECT ID_TABLA ID, DESCRIPCION DESCRIPTION
FROM   LDC_LV_LEY_1581'
,
'LDC Lista Valores Estado Protección Datos'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(1):=1149972;
CCCCR_3051_1_.tb5_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(1):=CCCCR_3051_1_.tb5_0(1);
CCCCR_3051_1_.old_tb5_1(1):=8812;
CCCCR_3051_1_.tb5_1(1):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(1),-1)));
CCCCR_3051_1_.old_tb5_2(1):=90044257;
CCCCR_3051_1_.tb5_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(1),-1)));
CCCCR_3051_1_.old_tb5_3(1):=-1;
CCCCR_3051_1_.tb5_3(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(1),-1)));
CCCCR_3051_1_.old_tb5_4(1):=-1;
CCCCR_3051_1_.tb5_4(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(1),-1)));
CCCCR_3051_1_.tb5_5(1):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.tb5_7(1):=CCCCR_3051_1_.tb8_0(0);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (1)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(1),
CCCCR_3051_1_.tb5_1(1),
CCCCR_3051_1_.tb5_2(1),
CCCCR_3051_1_.tb5_3(1),
CCCCR_3051_1_.tb5_4(1),
CCCCR_3051_1_.tb5_5(1),
null,
CCCCR_3051_1_.tb5_7(1),
null,
null,
600,
1,
'Código estado de ley'
,
'N'
,
'Y'
,
'Y'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(1):=1602630;
CCCCR_3051_1_.tb7_0(1):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(1):=CCCCR_3051_1_.tb7_0(1);
CCCCR_3051_1_.old_tb7_1(1):=90044257;
CCCCR_3051_1_.tb7_1(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(1),-1)));
CCCCR_3051_1_.old_tb7_2(1):=-1;
CCCCR_3051_1_.tb7_2(1):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(1),-1)));
CCCCR_3051_1_.tb7_3(1):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb7_4(1):=CCCCR_3051_1_.tb5_0(1);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (1)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(1),
CCCCR_3051_1_.tb7_1(1),
CCCCR_3051_1_.tb7_2(1),
CCCCR_3051_1_.tb7_3(1),
CCCCR_3051_1_.tb7_4(1),
'Y'
,
'Y'
,
1,
'Y'
,
'Código estado de ley'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(1):=121403931;
CCCCR_3051_1_.tb0_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(1):=CCCCR_3051_1_.tb0_0(1);
CCCCR_3051_1_.old_tb0_1(1):='GEGE_EXERULVAL_CT69E121403931'
;
CCCCR_3051_1_.tb0_1(1):=CCCCR_3051_1_.tb0_0(1);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(1),
CCCCR_3051_1_.tb0_1(1),
69,
'dfecha = UT_DATE.FSBSTR_SYSDATE();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(dfecha)'
,
'ALVZAPATA'
,
to_date('15-11-2013 08:05:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Fecha'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(2):=1149973;
CCCCR_3051_1_.tb5_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(2):=CCCCR_3051_1_.tb5_0(2);
CCCCR_3051_1_.old_tb5_1(2):=8812;
CCCCR_3051_1_.tb5_1(2):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(2),-1)));
CCCCR_3051_1_.old_tb5_2(2):=90044259;
CCCCR_3051_1_.tb5_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(2),-1)));
CCCCR_3051_1_.old_tb5_3(2):=-1;
CCCCR_3051_1_.tb5_3(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(2),-1)));
CCCCR_3051_1_.old_tb5_4(2):=-1;
CCCCR_3051_1_.tb5_4(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(2),-1)));
CCCCR_3051_1_.tb5_5(2):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.tb5_8(2):=CCCCR_3051_1_.tb0_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (2)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(2),
CCCCR_3051_1_.tb5_1(2),
CCCCR_3051_1_.tb5_2(2),
CCCCR_3051_1_.tb5_3(2),
CCCCR_3051_1_.tb5_4(2),
CCCCR_3051_1_.tb5_5(2),
null,
null,
CCCCR_3051_1_.tb5_8(2),
null,
600,
2,
'Fecha creación registro'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(2):=1602631;
CCCCR_3051_1_.tb7_0(2):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(2):=CCCCR_3051_1_.tb7_0(2);
CCCCR_3051_1_.old_tb7_1(2):=90044259;
CCCCR_3051_1_.tb7_1(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(2),-1)));
CCCCR_3051_1_.old_tb7_2(2):=-1;
CCCCR_3051_1_.tb7_2(2):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(2),-1)));
CCCCR_3051_1_.tb7_3(2):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb7_4(2):=CCCCR_3051_1_.tb5_0(2);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (2)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(2),
CCCCR_3051_1_.tb7_1(2),
CCCCR_3051_1_.tb7_2(2),
CCCCR_3051_1_.tb7_3(2),
CCCCR_3051_1_.tb7_4(2),
'Y'
,
'N'
,
2,
'N'
,
'Fecha creación registro'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(2):=121403932;
CCCCR_3051_1_.tb0_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(2):=CCCCR_3051_1_.tb0_0(2);
CCCCR_3051_1_.old_tb0_1(2):='GEGE_EXERULVAL_CT69E121403932'
;
CCCCR_3051_1_.tb0_1(2):=CCCCR_3051_1_.tb0_0(2);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(2),
CCCCR_3051_1_.tb0_1(2),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_SESSION.GETUSER())'
,
'ALVZAPATA'
,
to_date('15-11-2013 08:17:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC IDENTIFICADO USUARIO '
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(3):=1149974;
CCCCR_3051_1_.tb5_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(3):=CCCCR_3051_1_.tb5_0(3);
CCCCR_3051_1_.old_tb5_1(3):=8812;
CCCCR_3051_1_.tb5_1(3):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(3),-1)));
CCCCR_3051_1_.old_tb5_2(3):=90044260;
CCCCR_3051_1_.tb5_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(3),-1)));
CCCCR_3051_1_.old_tb5_3(3):=-1;
CCCCR_3051_1_.tb5_3(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(3),-1)));
CCCCR_3051_1_.old_tb5_4(3):=-1;
CCCCR_3051_1_.tb5_4(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(3),-1)));
CCCCR_3051_1_.tb5_5(3):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.tb5_8(3):=CCCCR_3051_1_.tb0_0(2);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (3)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(3),
CCCCR_3051_1_.tb5_1(3),
CCCCR_3051_1_.tb5_2(3),
CCCCR_3051_1_.tb5_3(3),
CCCCR_3051_1_.tb5_4(3),
CCCCR_3051_1_.tb5_5(3),
null,
null,
CCCCR_3051_1_.tb5_8(3),
null,
600,
3,
'Usuario creación registro'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(3):=1602632;
CCCCR_3051_1_.tb7_0(3):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(3):=CCCCR_3051_1_.tb7_0(3);
CCCCR_3051_1_.old_tb7_1(3):=90044260;
CCCCR_3051_1_.tb7_1(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(3),-1)));
CCCCR_3051_1_.old_tb7_2(3):=-1;
CCCCR_3051_1_.tb7_2(3):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(3),-1)));
CCCCR_3051_1_.tb7_3(3):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb7_4(3):=CCCCR_3051_1_.tb5_0(3);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (3)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(3),
CCCCR_3051_1_.tb7_1(3),
CCCCR_3051_1_.tb7_2(3),
CCCCR_3051_1_.tb7_3(3),
CCCCR_3051_1_.tb7_4(3),
'Y'
,
'N'
,
3,
'N'
,
'Usuario creación registro'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(3):=121403933;
CCCCR_3051_1_.tb0_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(3):=CCCCR_3051_1_.tb0_0(3);
CCCCR_3051_1_.old_tb0_1(3):='GEGE_EXERULVAL_CT69E121403933'
;
CCCCR_3051_1_.tb0_1(3):=CCCCR_3051_1_.tb0_0(3);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(3),
CCCCR_3051_1_.tb0_1(3),
69,
'A = 1;A = NULL;GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(A)'
,
'ALVZAPATA'
,
to_date('15-11-2013 08:05:52','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 15:26:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 15:26:51','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC INI packageId en 1 cuando es nuevo'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(4):=1149975;
CCCCR_3051_1_.tb5_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(4):=CCCCR_3051_1_.tb5_0(4);
CCCCR_3051_1_.old_tb5_1(4):=8812;
CCCCR_3051_1_.tb5_1(4):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(4),-1)));
CCCCR_3051_1_.old_tb5_2(4):=90044261;
CCCCR_3051_1_.tb5_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(4),-1)));
CCCCR_3051_1_.old_tb5_3(4):=-1;
CCCCR_3051_1_.tb5_3(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(4),-1)));
CCCCR_3051_1_.old_tb5_4(4):=-1;
CCCCR_3051_1_.tb5_4(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(4),-1)));
CCCCR_3051_1_.tb5_5(4):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.tb5_8(4):=CCCCR_3051_1_.tb0_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (4)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(4),
CCCCR_3051_1_.tb5_1(4),
CCCCR_3051_1_.tb5_2(4),
CCCCR_3051_1_.tb5_3(4),
CCCCR_3051_1_.tb5_4(4),
CCCCR_3051_1_.tb5_5(4),
null,
null,
CCCCR_3051_1_.tb5_8(4),
null,
600,
4,
'Id del paquete'
,
'N'
,
'Y'
,
'Y'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(4):=1602633;
CCCCR_3051_1_.tb7_0(4):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(4):=CCCCR_3051_1_.tb7_0(4);
CCCCR_3051_1_.old_tb7_1(4):=90044261;
CCCCR_3051_1_.tb7_1(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(4),-1)));
CCCCR_3051_1_.old_tb7_2(4):=-1;
CCCCR_3051_1_.tb7_2(4):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(4),-1)));
CCCCR_3051_1_.tb7_3(4):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb7_4(4):=CCCCR_3051_1_.tb5_0(4);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (4)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(4),
CCCCR_3051_1_.tb7_1(4),
CCCCR_3051_1_.tb7_2(4),
CCCCR_3051_1_.tb7_3(4),
CCCCR_3051_1_.tb7_4(4),
'N'
,
'N'
,
4,
'Y'
,
'Id del paquete'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(4):=121403934;
CCCCR_3051_1_.tb0_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(4):=CCCCR_3051_1_.tb0_0(4);
CCCCR_3051_1_.old_tb0_1(4):='GEGE_EXERULVAL_CT69E121403934'
;
CCCCR_3051_1_.tb0_1(4):=CCCCR_3051_1_.tb0_0(4);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(4),
CCCCR_3051_1_.tb0_1(4),
69,
'B = "S";GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(B)'
,
'ALVZAPATA'
,
to_date('15-11-2013 08:08:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC INI Estado LDC_Proteccion_Datos'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(5):=1149976;
CCCCR_3051_1_.tb5_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(5):=CCCCR_3051_1_.tb5_0(5);
CCCCR_3051_1_.old_tb5_1(5):=8812;
CCCCR_3051_1_.tb5_1(5):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(5),-1)));
CCCCR_3051_1_.old_tb5_2(5):=90044258;
CCCCR_3051_1_.tb5_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(5),-1)));
CCCCR_3051_1_.old_tb5_3(5):=-1;
CCCCR_3051_1_.tb5_3(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(5),-1)));
CCCCR_3051_1_.old_tb5_4(5):=-1;
CCCCR_3051_1_.tb5_4(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(5),-1)));
CCCCR_3051_1_.tb5_5(5):=CCCCR_3051_1_.tb2_0(1);
CCCCR_3051_1_.tb5_8(5):=CCCCR_3051_1_.tb0_0(4);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (5)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(5),
CCCCR_3051_1_.tb5_1(5),
CCCCR_3051_1_.tb5_2(5),
CCCCR_3051_1_.tb5_3(5),
CCCCR_3051_1_.tb5_4(5),
CCCCR_3051_1_.tb5_5(5),
null,
null,
CCCCR_3051_1_.tb5_8(5),
null,
600,
5,
'Estado registro'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(5):=1602634;
CCCCR_3051_1_.tb7_0(5):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(5):=CCCCR_3051_1_.tb7_0(5);
CCCCR_3051_1_.old_tb7_1(5):=90044258;
CCCCR_3051_1_.tb7_1(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(5),-1)));
CCCCR_3051_1_.old_tb7_2(5):=-1;
CCCCR_3051_1_.tb7_2(5):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(5),-1)));
CCCCR_3051_1_.tb7_3(5):=CCCCR_3051_1_.tb6_0(0);
CCCCR_3051_1_.tb7_4(5):=CCCCR_3051_1_.tb5_0(5);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (5)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(5),
CCCCR_3051_1_.tb7_1(5),
CCCCR_3051_1_.tb7_2(5),
CCCCR_3051_1_.tb7_3(5),
CCCCR_3051_1_.tb7_4(5),
'Y'
,
'N'
,
5,
'N'
,
'Estado registro'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(1):=CCCCR_3051_1_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (1)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(1),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(1):=2466;
CCCCR_3051_1_.tb6_0(1):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(1):=CCCCR_3051_1_.tb6_0(1);
CCCCR_3051_1_.tb6_1(1):=CCCCR_3051_1_.tb2_0(0);
ut_trace.trace('insertando tabla: GI_FRAME fila (1)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(1),
CCCCR_3051_1_.tb6_1(1),
null,
null,
'INF_CCCCR_TAB_1034637'
,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(2):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (2)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(2),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(1):=120197375;
CCCCR_3051_1_.tb8_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(1):=CCCCR_3051_1_.tb8_0(1);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(1),
16,
'Lista de Valores Tipo de Identificación'
,
'SELECT IDENT_TYPE_ID ID, DESCRIPTION DESCRIPTION FROM GE_IDENTIFICA_TYPE ORDER BY ID
'
,
'Lista de Valores Tipo de Identificación'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(6):=1149977;
CCCCR_3051_1_.tb5_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(6):=CCCCR_3051_1_.tb5_0(6);
CCCCR_3051_1_.old_tb5_1(6):=3203;
CCCCR_3051_1_.tb5_1(6):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(6),-1)));
CCCCR_3051_1_.old_tb5_2(6):=795;
CCCCR_3051_1_.tb5_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(6),-1)));
CCCCR_3051_1_.old_tb5_3(6):=-1;
CCCCR_3051_1_.tb5_3(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(6),-1)));
CCCCR_3051_1_.old_tb5_4(6):=-1;
CCCCR_3051_1_.tb5_4(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(6),-1)));
CCCCR_3051_1_.tb5_5(6):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(6):=CCCCR_3051_1_.tb8_0(1);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (6)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(6),
CCCCR_3051_1_.tb5_1(6),
CCCCR_3051_1_.tb5_2(6),
CCCCR_3051_1_.tb5_3(6),
CCCCR_3051_1_.tb5_4(6),
CCCCR_3051_1_.tb5_5(6),
null,
CCCCR_3051_1_.tb5_7(6),
null,
null,
600,
1,
'Tipo de Identificación'
,
'N'
,
'Y'
,
'Y'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(5):=121403935;
CCCCR_3051_1_.tb0_0(5):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(5):=CCCCR_3051_1_.tb0_0(5);
CCCCR_3051_1_.old_tb0_1(5):='GEGE_EXERULVAL_CT69E121403935'
;
CCCCR_3051_1_.tb0_1(5):=CCCCR_3051_1_.tb0_0(5);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (5)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(5),
CCCCR_3051_1_.tb0_1(5),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENT_TYPE_ID",sbIdenType);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENTIFICATION",sbIdentification);GE_BOINSTANCECONTROL.GETENTITYEVENT(sbInstance,NULL,"GE_SUBSCRIBER",nuEvent);if (nuEvent = 1,if (sbIdenType <> NULL,if (sbIdentification <> NULL,CC_BOCLIENTREGISTEREXPRESSIONS.VALIDATEIDENTIFICATION(sbIdenType,sbIdentification);,);,);,GE_BOINSTANCECONTROL.GETATTRIBUTEOLDVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENTIFICATION",sbOldIdentification);if (sbIdentification <> sbOldIdentification,CC_BOCLIENTREGISTEREXPRESSIONS.VALIDATEIDENTIFICATION(sbIdenType,sbIdentification);,);)'
,
'OPEN'
,
to_date('27-11-2012 10:22:40','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL Información Básica del Cliente'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(2):=2467;
CCCCR_3051_1_.tb6_0(2):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(2):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb6_1(2):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb6_2(2):=CCCCR_3051_1_.tb0_0(5);
ut_trace.trace('insertando tabla: GI_FRAME fila (2)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(2),
CCCCR_3051_1_.tb6_1(2),
CCCCR_3051_1_.tb6_2(2),
null,
'INF_CCCCR_FRAME_1021673'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(6):=1602635;
CCCCR_3051_1_.tb7_0(6):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(6):=CCCCR_3051_1_.tb7_0(6);
CCCCR_3051_1_.old_tb7_1(6):=795;
CCCCR_3051_1_.tb7_1(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(6),-1)));
CCCCR_3051_1_.old_tb7_2(6):=-1;
CCCCR_3051_1_.tb7_2(6):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(6),-1)));
CCCCR_3051_1_.tb7_3(6):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(6):=CCCCR_3051_1_.tb5_0(6);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (6)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(6),
CCCCR_3051_1_.tb7_1(6),
CCCCR_3051_1_.tb7_2(6),
CCCCR_3051_1_.tb7_3(6),
CCCCR_3051_1_.tb7_4(6),
'Y'
,
'N'
,
1,
'Y'
,
'Tipo de Identificación'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(6):=121403936;
CCCCR_3051_1_.tb0_0(6):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(6):=CCCCR_3051_1_.tb0_0(6);
CCCCR_3051_1_.old_tb0_1(6):='GEGE_EXERULVAL_CT69E121403936'
;
CCCCR_3051_1_.tb0_1(6):=CCCCR_3051_1_.tb0_0(6);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (6)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(6),
CCCCR_3051_1_.tb0_1(6),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENT_TYPE_ID",sbIdenType);sbClassPersonId = DAGE_IDENTIFICA_TYPE.FNUGETPERSON_CLASS_ID(sbIdenType, 1);sbClassPersonDesc = DAGE_PERSON_CLASS.FSBGETDESCRIPTION(sbClassPersonId, 1);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,NULL,"CLIENT_REGISTER","CLASS_PERSON",sbClassPersonDesc)'
,
'OPEN'
,
to_date('27-11-2012 14:55:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Inicializa campo CLASE DE PERSONA - GE_SUBCRIBER'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(7):=1149978;
CCCCR_3051_1_.tb5_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(7):=CCCCR_3051_1_.tb5_0(7);
CCCCR_3051_1_.old_tb5_1(7):=2117;
CCCCR_3051_1_.tb5_1(7):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(7),-1)));
CCCCR_3051_1_.old_tb5_2(7):=56804;
CCCCR_3051_1_.tb5_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(7),-1)));
CCCCR_3051_1_.old_tb5_3(7):=-1;
CCCCR_3051_1_.tb5_3(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(7),-1)));
CCCCR_3051_1_.old_tb5_4(7):=795;
CCCCR_3051_1_.tb5_4(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(7),-1)));
CCCCR_3051_1_.tb5_5(7):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_8(7):=CCCCR_3051_1_.tb0_0(6);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (7)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(7),
CCCCR_3051_1_.tb5_1(7),
CCCCR_3051_1_.tb5_2(7),
CCCCR_3051_1_.tb5_3(7),
CCCCR_3051_1_.tb5_4(7),
CCCCR_3051_1_.tb5_5(7),
null,
null,
CCCCR_3051_1_.tb5_8(7),
null,
600,
2,
'Clase de Persona'
,
'N'
,
'Y'
,
'Y'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(7):=1602636;
CCCCR_3051_1_.tb7_0(7):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(7):=CCCCR_3051_1_.tb7_0(7);
CCCCR_3051_1_.old_tb7_1(7):=56804;
CCCCR_3051_1_.tb7_1(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(7),-1)));
CCCCR_3051_1_.old_tb7_2(7):=795;
CCCCR_3051_1_.tb7_2(7):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(7),-1)));
CCCCR_3051_1_.tb7_3(7):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(7):=CCCCR_3051_1_.tb5_0(7);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (7)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(7),
CCCCR_3051_1_.tb7_1(7),
CCCCR_3051_1_.tb7_2(7),
CCCCR_3051_1_.tb7_3(7),
CCCCR_3051_1_.tb7_4(7),
'Y'
,
'N'
,
2,
'Y'
,
'Clase de Persona'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(7):=121403937;
CCCCR_3051_1_.tb0_0(7):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(7):=CCCCR_3051_1_.tb0_0(7);
CCCCR_3051_1_.old_tb0_1(7):='GEGE_EXERULVAL_CT69E121403937'
;
CCCCR_3051_1_.tb0_1(7):=CCCCR_3051_1_.tb0_0(7);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (7)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(7),
CCCCR_3051_1_.tb0_1(7),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENT_TYPE_ID",sbIdenType);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENTIFICATION",sbIdentification);GE_BOINSTANCECONTROL.GETENTITYEVENT(sbInstance,NULL,"GE_SUBSCRIBER",nuEvent);if (nuEvent = 1,if (sbIdenType <> NULL,if (sbIdentification <> NULL,CC_BOCLIENTREGISTEREXPRESSIONS.VALIDATEIDENTIFICATION(sbIdenType,sbIdentification);,);,);,GE_BOINSTANCECONTROL.GETATTRIBUTEOLDVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENTIFICATION",sbOldIdentification);if (sbIdentification <> sbOldIdentification,CC_BOCLIENTREGISTEREXPRESSIONS.VALIDATEIDENTIFICATION(sbIdenType,sbIdentification);,);)'
,
'OPEN'
,
to_date('03-03-2013 20:12:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida Identificación de Cliente'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(8):=1149979;
CCCCR_3051_1_.tb5_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(8):=CCCCR_3051_1_.tb5_0(8);
CCCCR_3051_1_.old_tb5_1(8):=3203;
CCCCR_3051_1_.tb5_1(8):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(8),-1)));
CCCCR_3051_1_.old_tb5_2(8):=796;
CCCCR_3051_1_.tb5_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(8),-1)));
CCCCR_3051_1_.old_tb5_3(8):=-1;
CCCCR_3051_1_.tb5_3(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(8),-1)));
CCCCR_3051_1_.old_tb5_4(8):=-1;
CCCCR_3051_1_.tb5_4(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(8),-1)));
CCCCR_3051_1_.tb5_5(8):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(8):=CCCCR_3051_1_.tb0_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (8)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(8),
CCCCR_3051_1_.tb5_1(8),
CCCCR_3051_1_.tb5_2(8),
CCCCR_3051_1_.tb5_3(8),
CCCCR_3051_1_.tb5_4(8),
CCCCR_3051_1_.tb5_5(8),
null,
null,
null,
CCCCR_3051_1_.tb5_9(8),
600,
3,
'Identificación'
,
'N'
,
'Y'
,
'Y'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(8):=1602637;
CCCCR_3051_1_.tb7_0(8):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(8):=CCCCR_3051_1_.tb7_0(8);
CCCCR_3051_1_.old_tb7_1(8):=796;
CCCCR_3051_1_.tb7_1(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(8),-1)));
CCCCR_3051_1_.old_tb7_2(8):=-1;
CCCCR_3051_1_.tb7_2(8):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(8),-1)));
CCCCR_3051_1_.tb7_3(8):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(8):=CCCCR_3051_1_.tb5_0(8);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (8)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(8),
CCCCR_3051_1_.tb7_1(8),
CCCCR_3051_1_.tb7_2(8),
CCCCR_3051_1_.tb7_3(8),
CCCCR_3051_1_.tb7_4(8),
'Y'
,
'N'
,
3,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(8):=121403938;
CCCCR_3051_1_.tb0_0(8):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(8):=CCCCR_3051_1_.tb0_0(8);
CCCCR_3051_1_.old_tb0_1(8):='GEGE_EXERULVAL_CT69E121403938'
;
CCCCR_3051_1_.tb0_1(8):=CCCCR_3051_1_.tb0_0(8);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (8)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(8),
CCCCR_3051_1_.tb0_1(8),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,);LDC_PROCVALIACNOMB(1)'
,
'OPEN'
,
to_date('28-11-2012 16:10:40','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:45','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(9):=1149980;
CCCCR_3051_1_.tb5_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(9):=CCCCR_3051_1_.tb5_0(9);
CCCCR_3051_1_.old_tb5_1(9):=3203;
CCCCR_3051_1_.tb5_1(9):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(9),-1)));
CCCCR_3051_1_.old_tb5_2(9):=797;
CCCCR_3051_1_.tb5_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(9),-1)));
CCCCR_3051_1_.old_tb5_3(9):=-1;
CCCCR_3051_1_.tb5_3(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(9),-1)));
CCCCR_3051_1_.old_tb5_4(9):=-1;
CCCCR_3051_1_.tb5_4(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(9),-1)));
CCCCR_3051_1_.tb5_5(9):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(9):=CCCCR_3051_1_.tb0_0(8);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (9)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(9),
CCCCR_3051_1_.tb5_1(9),
CCCCR_3051_1_.tb5_2(9),
CCCCR_3051_1_.tb5_3(9),
CCCCR_3051_1_.tb5_4(9),
CCCCR_3051_1_.tb5_5(9),
null,
null,
null,
CCCCR_3051_1_.tb5_9(9),
600,
4,
'Nombre'
,
'N'
,
'Y'
,
'Y'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(9):=1602638;
CCCCR_3051_1_.tb7_0(9):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(9):=CCCCR_3051_1_.tb7_0(9);
CCCCR_3051_1_.old_tb7_1(9):=797;
CCCCR_3051_1_.tb7_1(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(9),-1)));
CCCCR_3051_1_.old_tb7_2(9):=-1;
CCCCR_3051_1_.tb7_2(9):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(9),-1)));
CCCCR_3051_1_.tb7_3(9):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(9):=CCCCR_3051_1_.tb5_0(9);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (9)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(9),
CCCCR_3051_1_.tb7_1(9),
CCCCR_3051_1_.tb7_2(9),
CCCCR_3051_1_.tb7_3(9),
CCCCR_3051_1_.tb7_4(9),
'Y'
,
'Y'
,
4,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(9):=121403939;
CCCCR_3051_1_.tb0_0(9):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(9):=CCCCR_3051_1_.tb0_0(9);
CCCCR_3051_1_.old_tb0_1(9):='GEGE_EXERULVAL_CT69E121403939'
;
CCCCR_3051_1_.tb0_1(9):=CCCCR_3051_1_.tb0_0(9);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (9)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(9),
CCCCR_3051_1_.tb0_1(9),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,);LDC_PROCVALIACNOMB(2)'
,
'OPEN'
,
to_date('28-11-2012 16:12:29','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(10):=1149981;
CCCCR_3051_1_.tb5_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(10):=CCCCR_3051_1_.tb5_0(10);
CCCCR_3051_1_.old_tb5_1(10):=3203;
CCCCR_3051_1_.tb5_1(10):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(10),-1)));
CCCCR_3051_1_.old_tb5_2(10):=654;
CCCCR_3051_1_.tb5_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(10),-1)));
CCCCR_3051_1_.old_tb5_3(10):=-1;
CCCCR_3051_1_.tb5_3(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(10),-1)));
CCCCR_3051_1_.old_tb5_4(10):=-1;
CCCCR_3051_1_.tb5_4(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(10),-1)));
CCCCR_3051_1_.tb5_5(10):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(10):=CCCCR_3051_1_.tb0_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (10)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(10),
CCCCR_3051_1_.tb5_1(10),
CCCCR_3051_1_.tb5_2(10),
CCCCR_3051_1_.tb5_3(10),
CCCCR_3051_1_.tb5_4(10),
CCCCR_3051_1_.tb5_5(10),
null,
null,
null,
CCCCR_3051_1_.tb5_9(10),
600,
5,
'Apellido '
,
'N'
,
'Y'
,
'Y'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(10):=1602639;
CCCCR_3051_1_.tb7_0(10):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(10):=CCCCR_3051_1_.tb7_0(10);
CCCCR_3051_1_.old_tb7_1(10):=654;
CCCCR_3051_1_.tb7_1(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(10),-1)));
CCCCR_3051_1_.old_tb7_2(10):=-1;
CCCCR_3051_1_.tb7_2(10):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(10),-1)));
CCCCR_3051_1_.tb7_3(10):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(10):=CCCCR_3051_1_.tb5_0(10);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (10)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(10),
CCCCR_3051_1_.tb7_1(10),
CCCCR_3051_1_.tb7_2(10),
CCCCR_3051_1_.tb7_3(10),
CCCCR_3051_1_.tb7_4(10),
'Y'
,
'Y'
,
5,
'Y'
,
'Apellido '
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(10):=121403940;
CCCCR_3051_1_.tb0_0(10):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(10):=CCCCR_3051_1_.tb0_0(10);
CCCCR_3051_1_.old_tb0_1(10):='GEGE_EXERULVAL_CT69E121403940'
;
CCCCR_3051_1_.tb0_1(10):=CCCCR_3051_1_.tb0_0(10);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (10)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(10),
CCCCR_3051_1_.tb0_1(10),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","PHONE",sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone = NULL,,if (UT_STRING.FNULENGTH(nuPhone) <> 7 '||chr(38)||''||chr(38)||' UT_STRING.FNULENGTH(nuPhone) <> 10,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono deber ser de 7 o 10 dígitos");,);)'
,
'OPEN'
,
to_date('27-11-2012 14:55:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Teléfono-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(11):=1149982;
CCCCR_3051_1_.tb5_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(11):=CCCCR_3051_1_.tb5_0(11);
CCCCR_3051_1_.old_tb5_1(11):=3203;
CCCCR_3051_1_.tb5_1(11):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(11),-1)));
CCCCR_3051_1_.old_tb5_2(11):=799;
CCCCR_3051_1_.tb5_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(11),-1)));
CCCCR_3051_1_.old_tb5_3(11):=-1;
CCCCR_3051_1_.tb5_3(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(11),-1)));
CCCCR_3051_1_.old_tb5_4(11):=-1;
CCCCR_3051_1_.tb5_4(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(11),-1)));
CCCCR_3051_1_.tb5_5(11):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(11):=CCCCR_3051_1_.tb0_0(10);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (11)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(11),
CCCCR_3051_1_.tb5_1(11),
CCCCR_3051_1_.tb5_2(11),
CCCCR_3051_1_.tb5_3(11),
CCCCR_3051_1_.tb5_4(11),
CCCCR_3051_1_.tb5_5(11),
null,
null,
null,
CCCCR_3051_1_.tb5_9(11),
600,
6,
'Teléfono'
,
'N'
,
'Y'
,
'Y'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(11):=1602640;
CCCCR_3051_1_.tb7_0(11):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(11):=CCCCR_3051_1_.tb7_0(11);
CCCCR_3051_1_.old_tb7_1(11):=799;
CCCCR_3051_1_.tb7_1(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(11),-1)));
CCCCR_3051_1_.old_tb7_2(11):=-1;
CCCCR_3051_1_.tb7_2(11):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(11),-1)));
CCCCR_3051_1_.tb7_3(11):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(11):=CCCCR_3051_1_.tb5_0(11);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (11)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(11),
CCCCR_3051_1_.tb7_1(11),
CCCCR_3051_1_.tb7_2(11),
CCCCR_3051_1_.tb7_3(11),
CCCCR_3051_1_.tb7_4(11),
'Y'
,
'Y'
,
6,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(2):=120197376;
CCCCR_3051_1_.tb8_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(2):=CCCCR_3051_1_.tb8_0(2);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(2),
16,
'Lista de valores sobre la tabla GE_SUBS_STATUS'
,
'select SUBS_STATUS_ID ID, DESCRIPTION from GE_SUBS_STATUS'
,
'GE_SUBS_STATUS'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(11):=121403941;
CCCCR_3051_1_.tb0_0(11):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(11):=CCCCR_3051_1_.tb0_0(11);
CCCCR_3051_1_.old_tb0_1(11):='GEGE_EXERULVAL_CT69E121403941'
;
CCCCR_3051_1_.tb0_1(11):=CCCCR_3051_1_.tb0_0(11);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (11)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(11),
CCCCR_3051_1_.tb0_1(11),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(Instancia);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(Instancia,null,"GE_SUBSCRIBER","SUBS_STATUS_ID",2)'
,
'OPEN'
,
to_date('27-11-2012 10:22:41','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Establecer Estado por Defecto'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(12):=1149983;
CCCCR_3051_1_.tb5_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(12):=CCCCR_3051_1_.tb5_0(12);
CCCCR_3051_1_.old_tb5_1(12):=3203;
CCCCR_3051_1_.tb5_1(12):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(12),-1)));
CCCCR_3051_1_.old_tb5_2(12):=20360;
CCCCR_3051_1_.tb5_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(12),-1)));
CCCCR_3051_1_.old_tb5_3(12):=-1;
CCCCR_3051_1_.tb5_3(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(12),-1)));
CCCCR_3051_1_.old_tb5_4(12):=-1;
CCCCR_3051_1_.tb5_4(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(12),-1)));
CCCCR_3051_1_.tb5_5(12):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(12):=CCCCR_3051_1_.tb8_0(2);
CCCCR_3051_1_.tb5_8(12):=CCCCR_3051_1_.tb0_0(11);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (12)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(12),
CCCCR_3051_1_.tb5_1(12),
CCCCR_3051_1_.tb5_2(12),
CCCCR_3051_1_.tb5_3(12),
CCCCR_3051_1_.tb5_4(12),
CCCCR_3051_1_.tb5_5(12),
null,
CCCCR_3051_1_.tb5_7(12),
CCCCR_3051_1_.tb5_8(12),
null,
600,
31,
'Estado'
,
'N'
,
'Y'
,
'N'
,
31,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(12):=1602641;
CCCCR_3051_1_.tb7_0(12):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(12):=CCCCR_3051_1_.tb7_0(12);
CCCCR_3051_1_.old_tb7_1(12):=20360;
CCCCR_3051_1_.tb7_1(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(12),-1)));
CCCCR_3051_1_.old_tb7_2(12):=-1;
CCCCR_3051_1_.tb7_2(12):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(12),-1)));
CCCCR_3051_1_.tb7_3(12):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(12):=CCCCR_3051_1_.tb5_0(12);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (12)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(12),
CCCCR_3051_1_.tb7_1(12),
CCCCR_3051_1_.tb7_2(12),
CCCCR_3051_1_.tb7_3(12),
CCCCR_3051_1_.tb7_4(12),
'N'
,
'N'
,
31,
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
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(12):=121403942;
CCCCR_3051_1_.tb0_0(12):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(12):=CCCCR_3051_1_.tb0_0(12);
CCCCR_3051_1_.old_tb0_1(12):='GEGE_EXERULVAL_CT69E121403942'
;
CCCCR_3051_1_.tb0_1(12):=CCCCR_3051_1_.tb0_0(12);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (12)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(12),
CCCCR_3051_1_.tb0_1(12),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBSCRIBER","DATA_SEND","N")'
,
'OPEN'
,
to_date('27-11-2012 15:28:00','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Inicializa fla de envio de información'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(13):=1149984;
CCCCR_3051_1_.tb5_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(13):=CCCCR_3051_1_.tb5_0(13);
CCCCR_3051_1_.old_tb5_1(13):=3203;
CCCCR_3051_1_.tb5_1(13):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(13),-1)));
CCCCR_3051_1_.old_tb5_2(13):=71220;
CCCCR_3051_1_.tb5_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(13),-1)));
CCCCR_3051_1_.old_tb5_3(13):=-1;
CCCCR_3051_1_.tb5_3(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(13),-1)));
CCCCR_3051_1_.old_tb5_4(13):=-1;
CCCCR_3051_1_.tb5_4(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(13),-1)));
CCCCR_3051_1_.tb5_5(13):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_8(13):=CCCCR_3051_1_.tb0_0(12);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (13)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(13),
CCCCR_3051_1_.tb5_1(13),
CCCCR_3051_1_.tb5_2(13),
CCCCR_3051_1_.tb5_3(13),
CCCCR_3051_1_.tb5_4(13),
CCCCR_3051_1_.tb5_5(13),
null,
null,
CCCCR_3051_1_.tb5_8(13),
null,
600,
20,
'Envío de Información'
,
'N'
,
'Y'
,
'N'
,
20,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(13):=1602642;
CCCCR_3051_1_.tb7_0(13):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(13):=CCCCR_3051_1_.tb7_0(13);
CCCCR_3051_1_.old_tb7_1(13):=71220;
CCCCR_3051_1_.tb7_1(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(13),-1)));
CCCCR_3051_1_.old_tb7_2(13):=-1;
CCCCR_3051_1_.tb7_2(13):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(13),-1)));
CCCCR_3051_1_.tb7_3(13):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(13):=CCCCR_3051_1_.tb5_0(13);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (13)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(13),
CCCCR_3051_1_.tb7_1(13),
CCCCR_3051_1_.tb7_2(13),
CCCCR_3051_1_.tb7_3(13),
CCCCR_3051_1_.tb7_4(13),
'Y'
,
'Y'
,
20,
'N'
,
'Envío de Información'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(14):=1149985;
CCCCR_3051_1_.tb5_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(14):=CCCCR_3051_1_.tb5_0(14);
CCCCR_3051_1_.old_tb5_1(14):=9720;
CCCCR_3051_1_.tb5_1(14):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(14),-1)));
CCCCR_3051_1_.old_tb5_2(14):=20300;
CCCCR_3051_1_.tb5_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(14),-1)));
CCCCR_3051_1_.old_tb5_3(14):=-1;
CCCCR_3051_1_.tb5_3(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(14),-1)));
CCCCR_3051_1_.old_tb5_4(14):=-1;
CCCCR_3051_1_.tb5_4(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(14),-1)));
CCCCR_3051_1_.tb5_5(14):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (14)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(14),
CCCCR_3051_1_.tb5_1(14),
CCCCR_3051_1_.tb5_2(14),
CCCCR_3051_1_.tb5_3(14),
CCCCR_3051_1_.tb5_4(14),
CCCCR_3051_1_.tb5_5(14),
null,
null,
null,
null,
600,
32,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
32,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(14):=1602643;
CCCCR_3051_1_.tb7_0(14):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(14):=CCCCR_3051_1_.tb7_0(14);
CCCCR_3051_1_.old_tb7_1(14):=20300;
CCCCR_3051_1_.tb7_1(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(14),-1)));
CCCCR_3051_1_.old_tb7_2(14):=-1;
CCCCR_3051_1_.tb7_2(14):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(14),-1)));
CCCCR_3051_1_.tb7_3(14):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(14):=CCCCR_3051_1_.tb5_0(14);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (14)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(14),
CCCCR_3051_1_.tb7_1(14),
CCCCR_3051_1_.tb7_2(14),
CCCCR_3051_1_.tb7_3(14),
CCCCR_3051_1_.tb7_4(14),
'N'
,
'Y'
,
32,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(13):=121403943;
CCCCR_3051_1_.tb0_0(13):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(13):=CCCCR_3051_1_.tb0_0(13);
CCCCR_3051_1_.old_tb0_1(13):='GEGE_EXERULVAL_CT69E121403943'
;
CCCCR_3051_1_.tb0_1(13):=CCCCR_3051_1_.tb0_0(13);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (13)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(13),
CCCCR_3051_1_.tb0_1(13),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBSCRIBER","ACCEPT_CALL","Y")'
,
'OPEN'
,
to_date('27-11-2012 15:31:35','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:46','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Inicializa Flag de acepta llamada'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(14):=121403944;
CCCCR_3051_1_.tb0_0(14):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(14):=CCCCR_3051_1_.tb0_0(14);
CCCCR_3051_1_.old_tb0_1(14):='GEGE_EXERULVAL_CT69E121403944'
;
CCCCR_3051_1_.tb0_1(14):=CCCCR_3051_1_.tb0_0(14);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (14)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(14),
CCCCR_3051_1_.tb0_1(14),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBSCRIBER","ACCEPT_CALL",sbAccept_call);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBSCRIBER","PHONE",sbPhone);if (sbAccept_call = "Y" '||chr(38)||''||chr(38)||' sbPhone = null,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Debe ingresar primero el número de teléfono");,)'
,
'OPEN'
,
to_date('27-11-2012 15:38:00','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Registro Telefono-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(15):=1149986;
CCCCR_3051_1_.tb5_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(15):=CCCCR_3051_1_.tb5_0(15);
CCCCR_3051_1_.old_tb5_1(15):=3203;
CCCCR_3051_1_.tb5_1(15):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(15),-1)));
CCCCR_3051_1_.old_tb5_2(15):=97607;
CCCCR_3051_1_.tb5_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(15),-1)));
CCCCR_3051_1_.old_tb5_3(15):=-1;
CCCCR_3051_1_.tb5_3(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(15),-1)));
CCCCR_3051_1_.old_tb5_4(15):=-1;
CCCCR_3051_1_.tb5_4(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(15),-1)));
CCCCR_3051_1_.tb5_5(15):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_8(15):=CCCCR_3051_1_.tb0_0(13);
CCCCR_3051_1_.tb5_9(15):=CCCCR_3051_1_.tb0_0(14);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (15)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(15),
CCCCR_3051_1_.tb5_1(15),
CCCCR_3051_1_.tb5_2(15),
CCCCR_3051_1_.tb5_3(15),
CCCCR_3051_1_.tb5_4(15),
CCCCR_3051_1_.tb5_5(15),
null,
null,
CCCCR_3051_1_.tb5_8(15),
CCCCR_3051_1_.tb5_9(15),
600,
21,
'Acepta Llamada'
,
'N'
,
'Y'
,
'N'
,
21,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(15):=1602644;
CCCCR_3051_1_.tb7_0(15):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(15):=CCCCR_3051_1_.tb7_0(15);
CCCCR_3051_1_.old_tb7_1(15):=97607;
CCCCR_3051_1_.tb7_1(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(15),-1)));
CCCCR_3051_1_.old_tb7_2(15):=-1;
CCCCR_3051_1_.tb7_2(15):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(15),-1)));
CCCCR_3051_1_.tb7_3(15):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(15):=CCCCR_3051_1_.tb5_0(15);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (15)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(15),
CCCCR_3051_1_.tb7_1(15),
CCCCR_3051_1_.tb7_2(15),
CCCCR_3051_1_.tb7_3(15),
CCCCR_3051_1_.tb7_4(15),
'Y'
,
'Y'
,
21,
'N'
,
'Acepta Llamada'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(16):=1149987;
CCCCR_3051_1_.tb5_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(16):=CCCCR_3051_1_.tb5_0(16);
CCCCR_3051_1_.old_tb5_1(16):=9716;
CCCCR_3051_1_.tb5_1(16):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(16),-1)));
CCCCR_3051_1_.old_tb5_2(16):=20251;
CCCCR_3051_1_.tb5_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(16),-1)));
CCCCR_3051_1_.old_tb5_3(16):=-1;
CCCCR_3051_1_.tb5_3(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(16),-1)));
CCCCR_3051_1_.old_tb5_4(16):=-1;
CCCCR_3051_1_.tb5_4(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(16),-1)));
CCCCR_3051_1_.tb5_5(16):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (16)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(16),
CCCCR_3051_1_.tb5_1(16),
CCCCR_3051_1_.tb5_2(16),
CCCCR_3051_1_.tb5_3(16),
CCCCR_3051_1_.tb5_4(16),
CCCCR_3051_1_.tb5_5(16),
null,
null,
null,
null,
600,
33,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
33,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(16):=1602645;
CCCCR_3051_1_.tb7_0(16):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(16):=CCCCR_3051_1_.tb7_0(16);
CCCCR_3051_1_.old_tb7_1(16):=20251;
CCCCR_3051_1_.tb7_1(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(16),-1)));
CCCCR_3051_1_.old_tb7_2(16):=-1;
CCCCR_3051_1_.tb7_2(16):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(16),-1)));
CCCCR_3051_1_.tb7_3(16):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(16):=CCCCR_3051_1_.tb5_0(16);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (16)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(16),
CCCCR_3051_1_.tb7_1(16),
CCCCR_3051_1_.tb7_2(16),
CCCCR_3051_1_.tb7_3(16),
CCCCR_3051_1_.tb7_4(16),
'N'
,
'Y'
,
33,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(17):=1149988;
CCCCR_3051_1_.tb5_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(17):=CCCCR_3051_1_.tb5_0(17);
CCCCR_3051_1_.old_tb5_1(17):=9725;
CCCCR_3051_1_.tb5_1(17):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(17),-1)));
CCCCR_3051_1_.old_tb5_2(17):=20335;
CCCCR_3051_1_.tb5_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(17),-1)));
CCCCR_3051_1_.old_tb5_3(17):=-1;
CCCCR_3051_1_.tb5_3(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(17),-1)));
CCCCR_3051_1_.old_tb5_4(17):=-1;
CCCCR_3051_1_.tb5_4(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(17),-1)));
CCCCR_3051_1_.tb5_5(17):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (17)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(17),
CCCCR_3051_1_.tb5_1(17),
CCCCR_3051_1_.tb5_2(17),
CCCCR_3051_1_.tb5_3(17),
CCCCR_3051_1_.tb5_4(17),
CCCCR_3051_1_.tb5_5(17),
null,
null,
null,
null,
600,
34,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
34,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(17):=1602646;
CCCCR_3051_1_.tb7_0(17):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(17):=CCCCR_3051_1_.tb7_0(17);
CCCCR_3051_1_.old_tb7_1(17):=20335;
CCCCR_3051_1_.tb7_1(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(17),-1)));
CCCCR_3051_1_.old_tb7_2(17):=-1;
CCCCR_3051_1_.tb7_2(17):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(17),-1)));
CCCCR_3051_1_.tb7_3(17):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(17):=CCCCR_3051_1_.tb5_0(17);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (17)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(17),
CCCCR_3051_1_.tb7_1(17),
CCCCR_3051_1_.tb7_2(17),
CCCCR_3051_1_.tb7_3(17),
CCCCR_3051_1_.tb7_4(17),
'N'
,
'Y'
,
34,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(18):=1149989;
CCCCR_3051_1_.tb5_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(18):=CCCCR_3051_1_.tb5_0(18);
CCCCR_3051_1_.old_tb5_1(18):=-1;
CCCCR_3051_1_.tb5_1(18):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(18),-1)));
CCCCR_3051_1_.old_tb5_2(18):=-1;
CCCCR_3051_1_.tb5_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(18),-1)));
CCCCR_3051_1_.old_tb5_3(18):=-1;
CCCCR_3051_1_.tb5_3(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(18),-1)));
CCCCR_3051_1_.old_tb5_4(18):=null;
CCCCR_3051_1_.tb5_4(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(18),-1)));
CCCCR_3051_1_.tb5_5(18):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (18)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(18),
CCCCR_3051_1_.tb5_1(18),
CCCCR_3051_1_.tb5_2(18),
CCCCR_3051_1_.tb5_3(18),
CCCCR_3051_1_.tb5_4(18),
CCCCR_3051_1_.tb5_5(18),
null,
null,
null,
null,
600,
25,
'Información de Contacto'
,
'N'
,
'Y'
,
'N'
,
25,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(18):=1602647;
CCCCR_3051_1_.tb7_0(18):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(18):=CCCCR_3051_1_.tb7_0(18);
CCCCR_3051_1_.old_tb7_1(18):=-1;
CCCCR_3051_1_.tb7_1(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(18),-1)));
CCCCR_3051_1_.old_tb7_2(18):=null;
CCCCR_3051_1_.tb7_2(18):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(18),-1)));
CCCCR_3051_1_.tb7_3(18):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(18):=CCCCR_3051_1_.tb5_0(18);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (18)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(18),
CCCCR_3051_1_.tb7_1(18),
CCCCR_3051_1_.tb7_2(18),
CCCCR_3051_1_.tb7_3(18),
CCCCR_3051_1_.tb7_4(18),
'Y'
,
'Y'
,
25,
'N'
,
'Información de Contacto'
,
'N'
,
'N'
,
'U'
,
null,
10,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(15):=121403945;
CCCCR_3051_1_.tb0_0(15):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(15):=CCCCR_3051_1_.tb0_0(15);
CCCCR_3051_1_.old_tb0_1(15):='GEGE_EXERULVAL_CT69E121403945'
;
CCCCR_3051_1_.tb0_1(15):=CCCCR_3051_1_.tb0_0(15);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (15)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(15),
CCCCR_3051_1_.tb0_1(15),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBSCRIBER","SUBSCRIBER_ID",sbClientID);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBSCRIBER","CONTACT_ID",sbContactID);if (sbClientID = sbContactID,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El contacto del Cliente no puede ser él mismo.");,)'
,
'OPEN'
,
to_date('27-11-2012 10:22:41','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Valida que el Contacto no sea el mismo Cliente.'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(19):=1149990;
CCCCR_3051_1_.tb5_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(19):=CCCCR_3051_1_.tb5_0(19);
CCCCR_3051_1_.old_tb5_1(19):=3203;
CCCCR_3051_1_.tb5_1(19):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(19),-1)));
CCCCR_3051_1_.old_tb5_2(19):=56823;
CCCCR_3051_1_.tb5_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(19),-1)));
CCCCR_3051_1_.old_tb5_3(19):=-1;
CCCCR_3051_1_.tb5_3(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(19),-1)));
CCCCR_3051_1_.old_tb5_4(19):=-1;
CCCCR_3051_1_.tb5_4(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(19),-1)));
CCCCR_3051_1_.tb5_5(19):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(19):=CCCCR_3051_1_.tb0_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (19)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(19),
CCCCR_3051_1_.tb5_1(19),
CCCCR_3051_1_.tb5_2(19),
CCCCR_3051_1_.tb5_3(19),
CCCCR_3051_1_.tb5_4(19),
CCCCR_3051_1_.tb5_5(19),
null,
null,
null,
CCCCR_3051_1_.tb5_9(19),
600,
26,
'Contacto / Representante Legal'
,
'N'
,
'Y'
,
'N'
,
26,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(19):=1602648;
CCCCR_3051_1_.tb7_0(19):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(19):=CCCCR_3051_1_.tb7_0(19);
CCCCR_3051_1_.old_tb7_1(19):=56823;
CCCCR_3051_1_.tb7_1(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(19),-1)));
CCCCR_3051_1_.old_tb7_2(19):=-1;
CCCCR_3051_1_.tb7_2(19):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(19),-1)));
CCCCR_3051_1_.tb7_3(19):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(19):=CCCCR_3051_1_.tb5_0(19);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (19)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(19),
CCCCR_3051_1_.tb7_1(19),
CCCCR_3051_1_.tb7_2(19),
CCCCR_3051_1_.tb7_3(19),
CCCCR_3051_1_.tb7_4(19),
'Y'
,
'Y'
,
26,
'N'
,
'Contacto / Representante Legal'
,
'N'
,
'N'
,
'U'
,
null,
122,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(20):=1149991;
CCCCR_3051_1_.tb5_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(20):=CCCCR_3051_1_.tb5_0(20);
CCCCR_3051_1_.old_tb5_1(20):=9717;
CCCCR_3051_1_.tb5_1(20):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(20),-1)));
CCCCR_3051_1_.old_tb5_2(20):=20268;
CCCCR_3051_1_.tb5_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(20),-1)));
CCCCR_3051_1_.old_tb5_3(20):=-1;
CCCCR_3051_1_.tb5_3(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(20),-1)));
CCCCR_3051_1_.old_tb5_4(20):=-1;
CCCCR_3051_1_.tb5_4(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(20),-1)));
CCCCR_3051_1_.tb5_5(20):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (20)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(20),
CCCCR_3051_1_.tb5_1(20),
CCCCR_3051_1_.tb5_2(20),
CCCCR_3051_1_.tb5_3(20),
CCCCR_3051_1_.tb5_4(20),
CCCCR_3051_1_.tb5_5(20),
null,
null,
null,
null,
600,
18,
'Energético Anterior'
,
'N'
,
'Y'
,
'N'
,
18,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(20):=1602649;
CCCCR_3051_1_.tb7_0(20):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(20):=CCCCR_3051_1_.tb7_0(20);
CCCCR_3051_1_.old_tb7_1(20):=20268;
CCCCR_3051_1_.tb7_1(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(20),-1)));
CCCCR_3051_1_.old_tb7_2(20):=-1;
CCCCR_3051_1_.tb7_2(20):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(20),-1)));
CCCCR_3051_1_.tb7_3(20):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(20):=CCCCR_3051_1_.tb5_0(20);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (20)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(20),
CCCCR_3051_1_.tb7_1(20),
CCCCR_3051_1_.tb7_2(20),
CCCCR_3051_1_.tb7_3(20),
CCCCR_3051_1_.tb7_4(20),
'Y'
,
'Y'
,
18,
'N'
,
'Energético Anterior'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(3):=120197377;
CCCCR_3051_1_.tb8_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(3):=CCCCR_3051_1_.tb8_0(3);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(3),
16,
'Lista de Valores Tipo de Cliente'
,
'SELECT SUBSCRIBER_TYPE_ID ID, DESCRIPTION DESCRIPTION FROM GE_SUBSCRIBER_TYPE WHERE SUBSCRIBER_TYPE_ID <> -1 ORDER BY ID'
,
'Lista de Valores Tipo de Cliente'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(21):=1149992;
CCCCR_3051_1_.tb5_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(21):=CCCCR_3051_1_.tb5_0(21);
CCCCR_3051_1_.old_tb5_1(21):=3203;
CCCCR_3051_1_.tb5_1(21):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(21),-1)));
CCCCR_3051_1_.old_tb5_2(21):=653;
CCCCR_3051_1_.tb5_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(21),-1)));
CCCCR_3051_1_.old_tb5_3(21):=-1;
CCCCR_3051_1_.tb5_3(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(21),-1)));
CCCCR_3051_1_.old_tb5_4(21):=-1;
CCCCR_3051_1_.tb5_4(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(21),-1)));
CCCCR_3051_1_.tb5_5(21):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(21):=CCCCR_3051_1_.tb8_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (21)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(21),
CCCCR_3051_1_.tb5_1(21),
CCCCR_3051_1_.tb5_2(21),
CCCCR_3051_1_.tb5_3(21),
CCCCR_3051_1_.tb5_4(21),
CCCCR_3051_1_.tb5_5(21),
null,
CCCCR_3051_1_.tb5_7(21),
null,
null,
600,
0,
'Tipo de Cliente'
,
'N'
,
'Y'
,
'Y'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(21):=1602650;
CCCCR_3051_1_.tb7_0(21):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(21):=CCCCR_3051_1_.tb7_0(21);
CCCCR_3051_1_.old_tb7_1(21):=653;
CCCCR_3051_1_.tb7_1(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(21),-1)));
CCCCR_3051_1_.old_tb7_2(21):=-1;
CCCCR_3051_1_.tb7_2(21):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(21),-1)));
CCCCR_3051_1_.tb7_3(21):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(21):=CCCCR_3051_1_.tb5_0(21);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (21)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(21),
CCCCR_3051_1_.tb7_1(21),
CCCCR_3051_1_.tb7_2(21),
CCCCR_3051_1_.tb7_3(21),
CCCCR_3051_1_.tb7_4(21),
'Y'
,
'Y'
,
0,
'Y'
,
'Tipo de Cliente'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(16):=121403946;
CCCCR_3051_1_.tb0_0(16):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(16):=CCCCR_3051_1_.tb0_0(16);
CCCCR_3051_1_.old_tb0_1(16):='GEGE_EXERULVAL_CT69E121403946'
;
CCCCR_3051_1_.tb0_1(16):=CCCCR_3051_1_.tb0_0(16);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (16)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(16),
CCCCR_3051_1_.tb0_1(16),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_GENERAL_DATA","DATE_BIRTH",dtDate);nuEdad = LDC_BOUTILITIES.FNUGETAGE(CHARTODATE(dtDate, null));if (nuEdad < 18,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El Cliente debe ser Mayor de Edad");,)'
,
'OPEN'
,
to_date('27-11-2012 15:12:42','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida que sea Mayor de Edad - Fecha de Nacimiento'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(22):=1149993;
CCCCR_3051_1_.tb5_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(22):=CCCCR_3051_1_.tb5_0(22);
CCCCR_3051_1_.old_tb5_1(22):=9717;
CCCCR_3051_1_.tb5_1(22):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(22),-1)));
CCCCR_3051_1_.old_tb5_2(22):=20256;
CCCCR_3051_1_.tb5_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(22),-1)));
CCCCR_3051_1_.old_tb5_3(22):=-1;
CCCCR_3051_1_.tb5_3(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(22),-1)));
CCCCR_3051_1_.old_tb5_4(22):=-1;
CCCCR_3051_1_.tb5_4(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(22),-1)));
CCCCR_3051_1_.tb5_5(22):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(22):=CCCCR_3051_1_.tb0_0(16);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (22)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(22),
CCCCR_3051_1_.tb5_1(22),
CCCCR_3051_1_.tb5_2(22),
CCCCR_3051_1_.tb5_3(22),
CCCCR_3051_1_.tb5_4(22),
CCCCR_3051_1_.tb5_5(22),
null,
null,
null,
CCCCR_3051_1_.tb5_9(22),
600,
10,
'Fecha de Nacimiento'
,
'N'
,
'Y'
,
'N'
,
10,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(22):=1602651;
CCCCR_3051_1_.tb7_0(22):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(22):=CCCCR_3051_1_.tb7_0(22);
CCCCR_3051_1_.old_tb7_1(22):=20256;
CCCCR_3051_1_.tb7_1(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(22),-1)));
CCCCR_3051_1_.old_tb7_2(22):=-1;
CCCCR_3051_1_.tb7_2(22):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(22),-1)));
CCCCR_3051_1_.tb7_3(22):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(22):=CCCCR_3051_1_.tb5_0(22);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (22)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(22),
CCCCR_3051_1_.tb7_1(22),
CCCCR_3051_1_.tb7_2(22),
CCCCR_3051_1_.tb7_3(22),
CCCCR_3051_1_.tb7_4(22),
'Y'
,
'Y'
,
10,
'N'
,
'Fecha de Nacimiento'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(17):=121403947;
CCCCR_3051_1_.tb0_0(17):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(17):=CCCCR_3051_1_.tb0_0(17);
CCCCR_3051_1_.old_tb0_1(17):='GEGE_EXERULVAL_CT69E121403947'
;
CCCCR_3051_1_.tb0_1(17):=CCCCR_3051_1_.tb0_0(17);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (17)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(17),
CCCCR_3051_1_.tb0_1(17),
69,
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(nuAddressId);if (AB_BOADDRESS.FSBGETADDRESS(nuAddressId) = "KR NO EXISTE CL NO EXISTE - 0",GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La direccion Dummy correcta es: KR GENERICA CL GENERICA - 0");,)'
,
'OPEN'
,
to_date('24-04-2017 11:58:33','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:47','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'VAL_DIRECCIONDUMMY'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(23):=1149994;
CCCCR_3051_1_.tb5_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(23):=CCCCR_3051_1_.tb5_0(23);
CCCCR_3051_1_.old_tb5_1(23):=3203;
CCCCR_3051_1_.tb5_1(23):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(23),-1)));
CCCCR_3051_1_.old_tb5_2(23):=67179;
CCCCR_3051_1_.tb5_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(23),-1)));
CCCCR_3051_1_.old_tb5_3(23):=-1;
CCCCR_3051_1_.tb5_3(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(23),-1)));
CCCCR_3051_1_.old_tb5_4(23):=-1;
CCCCR_3051_1_.tb5_4(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(23),-1)));
CCCCR_3051_1_.tb5_5(23):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(23):=CCCCR_3051_1_.tb0_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (23)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(23),
CCCCR_3051_1_.tb5_1(23),
CCCCR_3051_1_.tb5_2(23),
CCCCR_3051_1_.tb5_3(23),
CCCCR_3051_1_.tb5_4(23),
CCCCR_3051_1_.tb5_5(23),
null,
null,
null,
CCCCR_3051_1_.tb5_9(23),
600,
7,
'Dirección'
,
'N'
,
'Y'
,
'Y'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(23):=1602652;
CCCCR_3051_1_.tb7_0(23):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(23):=CCCCR_3051_1_.tb7_0(23);
CCCCR_3051_1_.old_tb7_1(23):=67179;
CCCCR_3051_1_.tb7_1(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(23),-1)));
CCCCR_3051_1_.old_tb7_2(23):=-1;
CCCCR_3051_1_.tb7_2(23):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(23),-1)));
CCCCR_3051_1_.tb7_3(23):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(23):=CCCCR_3051_1_.tb5_0(23);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (23)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(23),
CCCCR_3051_1_.tb7_1(23),
CCCCR_3051_1_.tb7_2(23),
CCCCR_3051_1_.tb7_3(23),
CCCCR_3051_1_.tb7_4(23),
'Y'
,
'Y'
,
7,
'Y'
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
2,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(18):=121403948;
CCCCR_3051_1_.tb0_0(18):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(18):=CCCCR_3051_1_.tb0_0(18);
CCCCR_3051_1_.old_tb0_1(18):='GEGE_EXERULVAL_CT69E121403948'
;
CCCCR_3051_1_.tb0_1(18):=CCCCR_3051_1_.tb0_0(18);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (18)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(18),
CCCCR_3051_1_.tb0_1(18),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","E_MAIL","")'
,
'OPEN'
,
to_date('27-11-2012 14:55:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Inicializa Arroba Correo Electronico-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(19):=121403949;
CCCCR_3051_1_.tb0_0(19):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(19):=CCCCR_3051_1_.tb0_0(19);
CCCCR_3051_1_.old_tb0_1(19):='GEGE_EXERULVAL_CT69E121403949'
;
CCCCR_3051_1_.tb0_1(19):=CCCCR_3051_1_.tb0_0(19);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (19)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(19),
CCCCR_3051_1_.tb0_1(19),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","E_MAIL",sbMail);if (sbMail = "'||chr(64)||'",GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El formato del Correo no es correcto. Ejemplo de un formato correcto:usuario'||chr(64)||'proveedor.dominio");,)'
,
'OPEN'
,
to_date('27-11-2012 15:01:17','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Formato Correo Electrónico-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(24):=1149995;
CCCCR_3051_1_.tb5_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(24):=CCCCR_3051_1_.tb5_0(24);
CCCCR_3051_1_.old_tb5_1(24):=3203;
CCCCR_3051_1_.tb5_1(24):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(24),-1)));
CCCCR_3051_1_.old_tb5_2(24):=655;
CCCCR_3051_1_.tb5_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(24),-1)));
CCCCR_3051_1_.old_tb5_3(24):=-1;
CCCCR_3051_1_.tb5_3(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(24),-1)));
CCCCR_3051_1_.old_tb5_4(24):=-1;
CCCCR_3051_1_.tb5_4(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(24),-1)));
CCCCR_3051_1_.tb5_5(24):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_8(24):=CCCCR_3051_1_.tb0_0(18);
CCCCR_3051_1_.tb5_9(24):=CCCCR_3051_1_.tb0_0(19);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (24)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(24),
CCCCR_3051_1_.tb5_1(24),
CCCCR_3051_1_.tb5_2(24),
CCCCR_3051_1_.tb5_3(24),
CCCCR_3051_1_.tb5_4(24),
CCCCR_3051_1_.tb5_5(24),
null,
null,
CCCCR_3051_1_.tb5_8(24),
CCCCR_3051_1_.tb5_9(24),
600,
8,
'Correo Electrónico'
,
'N'
,
'Y'
,
'N'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(24):=1602653;
CCCCR_3051_1_.tb7_0(24):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(24):=CCCCR_3051_1_.tb7_0(24);
CCCCR_3051_1_.old_tb7_1(24):=655;
CCCCR_3051_1_.tb7_1(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(24),-1)));
CCCCR_3051_1_.old_tb7_2(24):=-1;
CCCCR_3051_1_.tb7_2(24):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(24),-1)));
CCCCR_3051_1_.tb7_3(24):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(24):=CCCCR_3051_1_.tb5_0(24);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (24)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(24),
CCCCR_3051_1_.tb7_1(24),
CCCCR_3051_1_.tb7_2(24),
CCCCR_3051_1_.tb7_3(24),
CCCCR_3051_1_.tb7_4(24),
'Y'
,
'Y'
,
8,
'N'
,
'Correo Electrónico'
,
'N'
,
'N'
,
'M'
,
null,
null,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(25):=1149996;
CCCCR_3051_1_.tb5_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(25):=CCCCR_3051_1_.tb5_0(25);
CCCCR_3051_1_.old_tb5_1(25):=9717;
CCCCR_3051_1_.tb5_1(25):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(25),-1)));
CCCCR_3051_1_.old_tb5_2(25):=20263;
CCCCR_3051_1_.tb5_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(25),-1)));
CCCCR_3051_1_.old_tb5_3(25):=-1;
CCCCR_3051_1_.tb5_3(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(25),-1)));
CCCCR_3051_1_.old_tb5_4(25):=-1;
CCCCR_3051_1_.tb5_4(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(25),-1)));
CCCCR_3051_1_.tb5_5(25):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (25)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(25),
CCCCR_3051_1_.tb5_1(25),
CCCCR_3051_1_.tb5_2(25),
CCCCR_3051_1_.tb5_3(25),
CCCCR_3051_1_.tb5_4(25),
CCCCR_3051_1_.tb5_5(25),
null,
null,
null,
null,
600,
9,
'Observación'
,
'N'
,
'Y'
,
'N'
,
9,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(25):=1602654;
CCCCR_3051_1_.tb7_0(25):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(25):=CCCCR_3051_1_.tb7_0(25);
CCCCR_3051_1_.old_tb7_1(25):=20263;
CCCCR_3051_1_.tb7_1(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(25),-1)));
CCCCR_3051_1_.old_tb7_2(25):=-1;
CCCCR_3051_1_.tb7_2(25):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(25),-1)));
CCCCR_3051_1_.tb7_3(25):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(25):=CCCCR_3051_1_.tb5_0(25);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (25)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(25),
CCCCR_3051_1_.tb7_1(25),
CCCCR_3051_1_.tb7_2(25),
CCCCR_3051_1_.tb7_3(25),
CCCCR_3051_1_.tb7_4(25),
'Y'
,
'Y'
,
9,
'N'
,
'Observación'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(4):=120197378;
CCCCR_3051_1_.tb8_0(4):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(4):=CCCCR_3051_1_.tb8_0(4);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (4)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(4),
61,
'DEPARTAMENTO'
,
'SELECT DEPA_ID ID, DESCRIPCION DESCRIPTION
FROM LDC_DEPARTACOL'
,
'DEPARTAMENTO'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(26):=1149997;
CCCCR_3051_1_.tb5_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(26):=CCCCR_3051_1_.tb5_0(26);
CCCCR_3051_1_.old_tb5_1(26):=2117;
CCCCR_3051_1_.tb5_1(26):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(26),-1)));
CCCCR_3051_1_.old_tb5_2(26):=56807;
CCCCR_3051_1_.tb5_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(26),-1)));
CCCCR_3051_1_.old_tb5_3(26):=-1;
CCCCR_3051_1_.tb5_3(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(26),-1)));
CCCCR_3051_1_.old_tb5_4(26):=-1;
CCCCR_3051_1_.tb5_4(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(26),-1)));
CCCCR_3051_1_.tb5_5(26):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(26):=CCCCR_3051_1_.tb8_0(4);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (26)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(26),
CCCCR_3051_1_.tb5_1(26),
CCCCR_3051_1_.tb5_2(26),
CCCCR_3051_1_.tb5_3(26),
CCCCR_3051_1_.tb5_4(26),
CCCCR_3051_1_.tb5_5(26),
null,
CCCCR_3051_1_.tb5_7(26),
null,
null,
600,
22,
'Departamento'
,
'N'
,
'Y'
,
'N'
,
22,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(26):=1602655;
CCCCR_3051_1_.tb7_0(26):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(26):=CCCCR_3051_1_.tb7_0(26);
CCCCR_3051_1_.old_tb7_1(26):=56807;
CCCCR_3051_1_.tb7_1(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(26),-1)));
CCCCR_3051_1_.old_tb7_2(26):=-1;
CCCCR_3051_1_.tb7_2(26):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(26),-1)));
CCCCR_3051_1_.tb7_3(26):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(26):=CCCCR_3051_1_.tb5_0(26);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (26)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(26),
CCCCR_3051_1_.tb7_1(26),
CCCCR_3051_1_.tb7_2(26),
CCCCR_3051_1_.tb7_3(26),
CCCCR_3051_1_.tb7_4(26),
'Y'
,
'Y'
,
22,
'N'
,
'Departamento'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(5):=120197379;
CCCCR_3051_1_.tb8_0(5):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(5):=CCCCR_3051_1_.tb8_0(5);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (5)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(5),
61,
'lista de localidades'
,
'SELECT LOCA_ID ID, DESCRIPCION description
FROM LDC_LOCALIDCOL
WHERE DEPA_ID= ge_boinstancecontrol.fsbgetfieldvalue('|| chr(39) ||'CLIENT_REGISTER'|| chr(39) ||','|| chr(39) ||'IDENT_TYPE_ID'|| chr(39) ||')
order by 1'
,
'lista de localidades'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(27):=1149998;
CCCCR_3051_1_.tb5_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(27):=CCCCR_3051_1_.tb5_0(27);
CCCCR_3051_1_.old_tb5_1(27):=2117;
CCCCR_3051_1_.tb5_1(27):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(27),-1)));
CCCCR_3051_1_.old_tb5_2(27):=56805;
CCCCR_3051_1_.tb5_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(27),-1)));
CCCCR_3051_1_.old_tb5_3(27):=-1;
CCCCR_3051_1_.tb5_3(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(27),-1)));
CCCCR_3051_1_.old_tb5_4(27):=-1;
CCCCR_3051_1_.tb5_4(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(27),-1)));
CCCCR_3051_1_.tb5_5(27):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(27):=CCCCR_3051_1_.tb8_0(5);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (27)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(27),
CCCCR_3051_1_.tb5_1(27),
CCCCR_3051_1_.tb5_2(27),
CCCCR_3051_1_.tb5_3(27),
CCCCR_3051_1_.tb5_4(27),
CCCCR_3051_1_.tb5_5(27),
null,
CCCCR_3051_1_.tb5_7(27),
null,
null,
600,
23,
'Localidad'
,
'N'
,
'Y'
,
'N'
,
23,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(27):=1602656;
CCCCR_3051_1_.tb7_0(27):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(27):=CCCCR_3051_1_.tb7_0(27);
CCCCR_3051_1_.old_tb7_1(27):=56805;
CCCCR_3051_1_.tb7_1(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(27),-1)));
CCCCR_3051_1_.old_tb7_2(27):=-1;
CCCCR_3051_1_.tb7_2(27):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(27),-1)));
CCCCR_3051_1_.tb7_3(27):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(27):=CCCCR_3051_1_.tb5_0(27);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (27)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(27),
CCCCR_3051_1_.tb7_1(27),
CCCCR_3051_1_.tb7_2(27),
CCCCR_3051_1_.tb7_3(27),
CCCCR_3051_1_.tb7_4(27),
'Y'
,
'Y'
,
23,
'N'
,
'Localidad'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(28):=1149999;
CCCCR_3051_1_.tb5_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(28):=CCCCR_3051_1_.tb5_0(28);
CCCCR_3051_1_.old_tb5_1(28):=3203;
CCCCR_3051_1_.tb5_1(28):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(28),-1)));
CCCCR_3051_1_.old_tb5_2(28):=798;
CCCCR_3051_1_.tb5_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(28),-1)));
CCCCR_3051_1_.old_tb5_3(28):=-1;
CCCCR_3051_1_.tb5_3(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(28),-1)));
CCCCR_3051_1_.old_tb5_4(28):=-1;
CCCCR_3051_1_.tb5_4(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(28),-1)));
CCCCR_3051_1_.tb5_5(28):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (28)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(28),
CCCCR_3051_1_.tb5_1(28),
CCCCR_3051_1_.tb5_2(28),
CCCCR_3051_1_.tb5_3(28),
CCCCR_3051_1_.tb5_4(28),
CCCCR_3051_1_.tb5_5(28),
null,
null,
null,
null,
600,
24,
'Dirección Geografica'
,
'N'
,
'Y'
,
'N'
,
24,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(28):=1602657;
CCCCR_3051_1_.tb7_0(28):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(28):=CCCCR_3051_1_.tb7_0(28);
CCCCR_3051_1_.old_tb7_1(28):=798;
CCCCR_3051_1_.tb7_1(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(28),-1)));
CCCCR_3051_1_.old_tb7_2(28):=-1;
CCCCR_3051_1_.tb7_2(28):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(28),-1)));
CCCCR_3051_1_.tb7_3(28):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(28):=CCCCR_3051_1_.tb5_0(28);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (28)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(28),
CCCCR_3051_1_.tb7_1(28),
CCCCR_3051_1_.tb7_2(28),
CCCCR_3051_1_.tb7_3(28),
CCCCR_3051_1_.tb7_4(28),
'Y'
,
'Y'
,
24,
'N'
,
'Dirección Geografica'
,
'N'
,
'N'
,
'M'
,
null,
null,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(6):=120197380;
CCCCR_3051_1_.tb8_0(6):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(6):=CCCCR_3051_1_.tb8_0(6);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (6)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(6),
16,
'Lista de Valores Ubicación Geográfica'
,
'SELECT A.GEOGRAP_LOCATION_ID ID, A.DISPLAY_DESCRIPTION DESCRIPTION, B.DESCRIPTION DEPARTAMENTO
FROM GE_GEOGRA_LOCATION A, GE_GEOGRA_LOCATION B
WHERE A.ASSIGN_LEVEL = GE_BOCONSTANTS.GETYES
AND A.GEOG_LOCA_AREA_TYPE = 3
AND A.GEO_LOCA_FATHER_ID = B.GEOGRAP_LOCATION_ID
ORDER BY A.GEOGRAP_LOCATION_ID'
,
'Lista de Valores Ubicación Geográfica'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(29):=1150000;
CCCCR_3051_1_.tb5_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(29):=CCCCR_3051_1_.tb5_0(29);
CCCCR_3051_1_.old_tb5_1(29):=9717;
CCCCR_3051_1_.tb5_1(29):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(29),-1)));
CCCCR_3051_1_.old_tb5_2(29):=20264;
CCCCR_3051_1_.tb5_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(29),-1)));
CCCCR_3051_1_.old_tb5_3(29):=-1;
CCCCR_3051_1_.tb5_3(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(29),-1)));
CCCCR_3051_1_.old_tb5_4(29):=-1;
CCCCR_3051_1_.tb5_4(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(29),-1)));
CCCCR_3051_1_.tb5_5(29):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(29):=CCCCR_3051_1_.tb8_0(6);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (29)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(29),
CCCCR_3051_1_.tb5_1(29),
CCCCR_3051_1_.tb5_2(29),
CCCCR_3051_1_.tb5_3(29),
CCCCR_3051_1_.tb5_4(29),
CCCCR_3051_1_.tb5_5(29),
null,
CCCCR_3051_1_.tb5_7(29),
null,
null,
600,
11,
'Lugar de Nacimiento'
,
'N'
,
'Y'
,
'N'
,
11,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(29):=1602658;
CCCCR_3051_1_.tb7_0(29):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(29):=CCCCR_3051_1_.tb7_0(29);
CCCCR_3051_1_.old_tb7_1(29):=20264;
CCCCR_3051_1_.tb7_1(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(29),-1)));
CCCCR_3051_1_.old_tb7_2(29):=-1;
CCCCR_3051_1_.tb7_2(29):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(29),-1)));
CCCCR_3051_1_.tb7_3(29):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(29):=CCCCR_3051_1_.tb5_0(29);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (29)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(29),
CCCCR_3051_1_.tb7_1(29),
CCCCR_3051_1_.tb7_2(29),
CCCCR_3051_1_.tb7_3(29),
CCCCR_3051_1_.tb7_4(29),
'Y'
,
'Y'
,
11,
'N'
,
'Lugar de Nacimiento'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(20):=121403950;
CCCCR_3051_1_.tb0_0(20):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(20):=CCCCR_3051_1_.tb0_0(20);
CCCCR_3051_1_.old_tb0_1(20):='GEGE_EXERULVAL_CT69E121403950'
;
CCCCR_3051_1_.tb0_1(20):=CCCCR_3051_1_.tb0_0(20);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (20)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(20),
CCCCR_3051_1_.tb0_1(20),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_GENERAL_DATA","LAST_UPDATE",UT_DATE.FSBSTR_DATE(PKGENERALSERVICES.FDTGETSYSTEMDATE()))'
,
'OPEN'
,
to_date('27-11-2012 10:22:40','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Actualiza LAST_UPDATE'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(30):=1150001;
CCCCR_3051_1_.tb5_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(30):=CCCCR_3051_1_.tb5_0(30);
CCCCR_3051_1_.old_tb5_1(30):=9717;
CCCCR_3051_1_.tb5_1(30):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(30),-1)));
CCCCR_3051_1_.old_tb5_2(30):=20266;
CCCCR_3051_1_.tb5_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(30),-1)));
CCCCR_3051_1_.old_tb5_3(30):=-1;
CCCCR_3051_1_.tb5_3(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(30),-1)));
CCCCR_3051_1_.old_tb5_4(30):=-1;
CCCCR_3051_1_.tb5_4(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(30),-1)));
CCCCR_3051_1_.tb5_5(30):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_9(30):=CCCCR_3051_1_.tb0_0(20);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (30)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(30),
CCCCR_3051_1_.tb5_1(30),
CCCCR_3051_1_.tb5_2(30),
CCCCR_3051_1_.tb5_3(30),
CCCCR_3051_1_.tb5_4(30),
CCCCR_3051_1_.tb5_5(30),
null,
null,
null,
CCCCR_3051_1_.tb5_9(30),
600,
19,
'Fecha Última Actualización'
,
'N'
,
'Y'
,
'N'
,
19,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(30):=1602659;
CCCCR_3051_1_.tb7_0(30):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(30):=CCCCR_3051_1_.tb7_0(30);
CCCCR_3051_1_.old_tb7_1(30):=20266;
CCCCR_3051_1_.tb7_1(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(30),-1)));
CCCCR_3051_1_.old_tb7_2(30):=-1;
CCCCR_3051_1_.tb7_2(30):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(30),-1)));
CCCCR_3051_1_.tb7_3(30):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(30):=CCCCR_3051_1_.tb5_0(30);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (30)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(30),
CCCCR_3051_1_.tb7_1(30),
CCCCR_3051_1_.tb7_2(30),
CCCCR_3051_1_.tb7_3(30),
CCCCR_3051_1_.tb7_4(30),
'Y'
,
'N'
,
19,
'N'
,
'Fecha Última Actualización'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(7):=120197381;
CCCCR_3051_1_.tb8_0(7):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(7):=CCCCR_3051_1_.tb8_0(7);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (7)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(7),
16,
'Lista de Valores Grado de Escolaridad'
,
'SELECT SCHOOL_DEGREE_ID ID, DESCRIPTION DESCRIPTION FROM GE_SCHOOL_DEGREE ORDER BY ID
'
,
'Lista de Valores Grado de Escolaridad'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(31):=1150002;
CCCCR_3051_1_.tb5_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(31):=CCCCR_3051_1_.tb5_0(31);
CCCCR_3051_1_.old_tb5_1(31):=9717;
CCCCR_3051_1_.tb5_1(31):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(31),-1)));
CCCCR_3051_1_.old_tb5_2(31):=20259;
CCCCR_3051_1_.tb5_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(31),-1)));
CCCCR_3051_1_.old_tb5_3(31):=-1;
CCCCR_3051_1_.tb5_3(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(31),-1)));
CCCCR_3051_1_.old_tb5_4(31):=-1;
CCCCR_3051_1_.tb5_4(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(31),-1)));
CCCCR_3051_1_.tb5_5(31):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(31):=CCCCR_3051_1_.tb8_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (31)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(31),
CCCCR_3051_1_.tb5_1(31),
CCCCR_3051_1_.tb5_2(31),
CCCCR_3051_1_.tb5_3(31),
CCCCR_3051_1_.tb5_4(31),
CCCCR_3051_1_.tb5_5(31),
null,
CCCCR_3051_1_.tb5_7(31),
null,
null,
600,
12,
'Grado de Escolaridad'
,
'N'
,
'Y'
,
'N'
,
12,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(31):=1602660;
CCCCR_3051_1_.tb7_0(31):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(31):=CCCCR_3051_1_.tb7_0(31);
CCCCR_3051_1_.old_tb7_1(31):=20259;
CCCCR_3051_1_.tb7_1(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(31),-1)));
CCCCR_3051_1_.old_tb7_2(31):=-1;
CCCCR_3051_1_.tb7_2(31):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(31),-1)));
CCCCR_3051_1_.tb7_3(31):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(31):=CCCCR_3051_1_.tb5_0(31);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (31)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(31),
CCCCR_3051_1_.tb7_1(31),
CCCCR_3051_1_.tb7_2(31),
CCCCR_3051_1_.tb7_3(31),
CCCCR_3051_1_.tb7_4(31),
'Y'
,
'Y'
,
12,
'N'
,
'Grado de Escolaridad'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(8):=120197382;
CCCCR_3051_1_.tb8_0(8):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(8):=CCCCR_3051_1_.tb8_0(8);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (8)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(8),
16,
'Lista de valores Profesión'
,
'SELECT PROFESSION_ID ID, DESCRIPTION DESCRIPTION FROM GE_PROFESSION ORDER BY ID
'
,
'Lista de valores Profesión'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(32):=1150003;
CCCCR_3051_1_.tb5_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(32):=CCCCR_3051_1_.tb5_0(32);
CCCCR_3051_1_.old_tb5_1(32):=9717;
CCCCR_3051_1_.tb5_1(32):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(32),-1)));
CCCCR_3051_1_.old_tb5_2(32):=20262;
CCCCR_3051_1_.tb5_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(32),-1)));
CCCCR_3051_1_.old_tb5_3(32):=-1;
CCCCR_3051_1_.tb5_3(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(32),-1)));
CCCCR_3051_1_.old_tb5_4(32):=-1;
CCCCR_3051_1_.tb5_4(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(32),-1)));
CCCCR_3051_1_.tb5_5(32):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(32):=CCCCR_3051_1_.tb8_0(8);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (32)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(32),
CCCCR_3051_1_.tb5_1(32),
CCCCR_3051_1_.tb5_2(32),
CCCCR_3051_1_.tb5_3(32),
CCCCR_3051_1_.tb5_4(32),
CCCCR_3051_1_.tb5_5(32),
null,
CCCCR_3051_1_.tb5_7(32),
null,
null,
600,
13,
'Profesión u Ocupación'
,
'N'
,
'Y'
,
'N'
,
13,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(32):=1602661;
CCCCR_3051_1_.tb7_0(32):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(32):=CCCCR_3051_1_.tb7_0(32);
CCCCR_3051_1_.old_tb7_1(32):=20262;
CCCCR_3051_1_.tb7_1(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(32),-1)));
CCCCR_3051_1_.old_tb7_2(32):=-1;
CCCCR_3051_1_.tb7_2(32):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(32),-1)));
CCCCR_3051_1_.tb7_3(32):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(32):=CCCCR_3051_1_.tb5_0(32);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (32)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(32),
CCCCR_3051_1_.tb7_1(32),
CCCCR_3051_1_.tb7_2(32),
CCCCR_3051_1_.tb7_3(32),
CCCCR_3051_1_.tb7_4(32),
'Y'
,
'Y'
,
13,
'N'
,
'Profesión u Ocupación'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(9):=120197383;
CCCCR_3051_1_.tb8_0(9):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(9):=CCCCR_3051_1_.tb8_0(9);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (9)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(9),
16,
'Lista de valores Nivel Salarial'
,
'SELECT WAGE_SCALE_ID ID, DESCRIPTION DESCRIPTION FROM GE_WAGE_SCALE ORDER BY ID
'
,
'Lista de valores Nivel Salarial'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(33):=1150004;
CCCCR_3051_1_.tb5_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(33):=CCCCR_3051_1_.tb5_0(33);
CCCCR_3051_1_.old_tb5_1(33):=9717;
CCCCR_3051_1_.tb5_1(33):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(33),-1)));
CCCCR_3051_1_.old_tb5_2(33):=20260;
CCCCR_3051_1_.tb5_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(33),-1)));
CCCCR_3051_1_.old_tb5_3(33):=-1;
CCCCR_3051_1_.tb5_3(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(33),-1)));
CCCCR_3051_1_.old_tb5_4(33):=-1;
CCCCR_3051_1_.tb5_4(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(33),-1)));
CCCCR_3051_1_.tb5_5(33):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(33):=CCCCR_3051_1_.tb8_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (33)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(33),
CCCCR_3051_1_.tb5_1(33),
CCCCR_3051_1_.tb5_2(33),
CCCCR_3051_1_.tb5_3(33),
CCCCR_3051_1_.tb5_4(33),
CCCCR_3051_1_.tb5_5(33),
null,
CCCCR_3051_1_.tb5_7(33),
null,
null,
600,
14,
'Nivel de Ingresos'
,
'N'
,
'Y'
,
'N'
,
14,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(33):=1602662;
CCCCR_3051_1_.tb7_0(33):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(33):=CCCCR_3051_1_.tb7_0(33);
CCCCR_3051_1_.old_tb7_1(33):=20260;
CCCCR_3051_1_.tb7_1(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(33),-1)));
CCCCR_3051_1_.old_tb7_2(33):=-1;
CCCCR_3051_1_.tb7_2(33):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(33),-1)));
CCCCR_3051_1_.tb7_3(33):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(33):=CCCCR_3051_1_.tb5_0(33);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (33)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(33),
CCCCR_3051_1_.tb7_1(33),
CCCCR_3051_1_.tb7_2(33),
CCCCR_3051_1_.tb7_3(33),
CCCCR_3051_1_.tb7_4(33),
'Y'
,
'Y'
,
14,
'N'
,
'Nivel de Ingresos'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(10):=120197384;
CCCCR_3051_1_.tb8_0(10):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(10):=CCCCR_3051_1_.tb8_0(10);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (10)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(10),
16,
'Lista de Valores Escala Salarial'
,
'SELECT WAGE_SCALE_ID ID, DESCRIPTION DESCRIPTION FROM GE_WAGE_SCALE ORDER BY ID
'
,
'Lista de Valores Escala Salarial'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(34):=1150005;
CCCCR_3051_1_.tb5_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(34):=CCCCR_3051_1_.tb5_0(34);
CCCCR_3051_1_.old_tb5_1(34):=9717;
CCCCR_3051_1_.tb5_1(34):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(34),-1)));
CCCCR_3051_1_.old_tb5_2(34):=20261;
CCCCR_3051_1_.tb5_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(34),-1)));
CCCCR_3051_1_.old_tb5_3(34):=-1;
CCCCR_3051_1_.tb5_3(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(34),-1)));
CCCCR_3051_1_.old_tb5_4(34):=-1;
CCCCR_3051_1_.tb5_4(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(34),-1)));
CCCCR_3051_1_.tb5_5(34):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(34):=CCCCR_3051_1_.tb8_0(10);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (34)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(34),
CCCCR_3051_1_.tb5_1(34),
CCCCR_3051_1_.tb5_2(34),
CCCCR_3051_1_.tb5_3(34),
CCCCR_3051_1_.tb5_4(34),
CCCCR_3051_1_.tb5_5(34),
null,
CCCCR_3051_1_.tb5_7(34),
null,
null,
600,
15,
'Nivel de Egresos'
,
'N'
,
'Y'
,
'N'
,
15,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(34):=1602663;
CCCCR_3051_1_.tb7_0(34):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(34):=CCCCR_3051_1_.tb7_0(34);
CCCCR_3051_1_.old_tb7_1(34):=20261;
CCCCR_3051_1_.tb7_1(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(34),-1)));
CCCCR_3051_1_.old_tb7_2(34):=-1;
CCCCR_3051_1_.tb7_2(34):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(34),-1)));
CCCCR_3051_1_.tb7_3(34):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(34):=CCCCR_3051_1_.tb5_0(34);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (34)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(34),
CCCCR_3051_1_.tb7_1(34),
CCCCR_3051_1_.tb7_2(34),
CCCCR_3051_1_.tb7_3(34),
CCCCR_3051_1_.tb7_4(34),
'Y'
,
'Y'
,
15,
'N'
,
'Nivel de Egresos'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(11):=120197385;
CCCCR_3051_1_.tb8_0(11):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(11):=CCCCR_3051_1_.tb8_0(11);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (11)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(11),
16,
'Lista de Valores Genero'
,
'SELECT '|| chr(39) ||'M'|| chr(39) ||' ID, '|| chr(39) ||'MASCULINO'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'F'|| chr(39) ||' ID, '|| chr(39) ||'FEMENINO'|| chr(39) ||' DESCRIPTION FROM DUAL'
,
'Lista de Valores Genero'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(35):=1150006;
CCCCR_3051_1_.tb5_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(35):=CCCCR_3051_1_.tb5_0(35);
CCCCR_3051_1_.old_tb5_1(35):=9717;
CCCCR_3051_1_.tb5_1(35):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(35),-1)));
CCCCR_3051_1_.old_tb5_2(35):=20257;
CCCCR_3051_1_.tb5_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(35),-1)));
CCCCR_3051_1_.old_tb5_3(35):=-1;
CCCCR_3051_1_.tb5_3(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(35),-1)));
CCCCR_3051_1_.old_tb5_4(35):=-1;
CCCCR_3051_1_.tb5_4(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(35),-1)));
CCCCR_3051_1_.tb5_5(35):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_7(35):=CCCCR_3051_1_.tb8_0(11);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (35)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(35),
CCCCR_3051_1_.tb5_1(35),
CCCCR_3051_1_.tb5_2(35),
CCCCR_3051_1_.tb5_3(35),
CCCCR_3051_1_.tb5_4(35),
CCCCR_3051_1_.tb5_5(35),
null,
CCCCR_3051_1_.tb5_7(35),
null,
null,
600,
16,
'Género'
,
'N'
,
'Y'
,
'N'
,
16,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(35):=1602664;
CCCCR_3051_1_.tb7_0(35):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(35):=CCCCR_3051_1_.tb7_0(35);
CCCCR_3051_1_.old_tb7_1(35):=20257;
CCCCR_3051_1_.tb7_1(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(35),-1)));
CCCCR_3051_1_.old_tb7_2(35):=-1;
CCCCR_3051_1_.tb7_2(35):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(35),-1)));
CCCCR_3051_1_.tb7_3(35):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(35):=CCCCR_3051_1_.tb5_0(35);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (35)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(35),
CCCCR_3051_1_.tb7_1(35),
CCCCR_3051_1_.tb7_2(35),
CCCCR_3051_1_.tb7_3(35),
CCCCR_3051_1_.tb7_4(35),
'Y'
,
'Y'
,
16,
'N'
,
'Género'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(21):=121403951;
CCCCR_3051_1_.tb0_0(21):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(21):=CCCCR_3051_1_.tb0_0(21);
CCCCR_3051_1_.old_tb0_1(21):='GEGE_EXERULVAL_CT69E121403951'
;
CCCCR_3051_1_.tb0_1(21):=CCCCR_3051_1_.tb0_0(21);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (21)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(21),
CCCCR_3051_1_.tb0_1(21),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(UT_DATE.FSBSTR_SYSDATE())'
,
'OPEN'
,
to_date('28-11-2012 17:20:37','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Inicializa fecha del sistema'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(36):=1150007;
CCCCR_3051_1_.tb5_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(36):=CCCCR_3051_1_.tb5_0(36);
CCCCR_3051_1_.old_tb5_1(36):=3203;
CCCCR_3051_1_.tb5_1(36):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(36),-1)));
CCCCR_3051_1_.old_tb5_2(36):=84062;
CCCCR_3051_1_.tb5_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(36),-1)));
CCCCR_3051_1_.old_tb5_3(36):=-1;
CCCCR_3051_1_.tb5_3(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(36),-1)));
CCCCR_3051_1_.old_tb5_4(36):=-1;
CCCCR_3051_1_.tb5_4(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(36),-1)));
CCCCR_3051_1_.tb5_5(36):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_8(36):=CCCCR_3051_1_.tb0_0(21);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (36)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(36),
CCCCR_3051_1_.tb5_1(36),
CCCCR_3051_1_.tb5_2(36),
CCCCR_3051_1_.tb5_3(36),
CCCCR_3051_1_.tb5_4(36),
CCCCR_3051_1_.tb5_5(36),
null,
null,
CCCCR_3051_1_.tb5_8(36),
null,
600,
17,
'Fecha De Vinculación'
,
'N'
,
'Y'
,
'N'
,
17,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(36):=1602665;
CCCCR_3051_1_.tb7_0(36):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(36):=CCCCR_3051_1_.tb7_0(36);
CCCCR_3051_1_.old_tb7_1(36):=84062;
CCCCR_3051_1_.tb7_1(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(36),-1)));
CCCCR_3051_1_.old_tb7_2(36):=-1;
CCCCR_3051_1_.tb7_2(36):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(36),-1)));
CCCCR_3051_1_.tb7_3(36):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(36):=CCCCR_3051_1_.tb5_0(36);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (36)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(36),
CCCCR_3051_1_.tb7_1(36),
CCCCR_3051_1_.tb7_2(36),
CCCCR_3051_1_.tb7_3(36),
CCCCR_3051_1_.tb7_4(36),
'Y'
,
'N'
,
17,
'N'
,
'Fecha De Vinculación'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(22):=121403952;
CCCCR_3051_1_.tb0_0(22):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(22):=CCCCR_3051_1_.tb0_0(22);
CCCCR_3051_1_.old_tb0_1(22):='GEGE_EXERULVAL_CT69E121403952'
;
CCCCR_3051_1_.tb0_1(22):=CCCCR_3051_1_.tb0_0(22);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (22)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(22),
CCCCR_3051_1_.tb0_1(22),
69,
'newSubscriberID = GE_BOSEQUENCE.NEXTGE_SUBSCRIBER();GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(newSubscriberID)'
,
'OPEN'
,
to_date('27-11-2012 10:22:41','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Identificador Suscriptor'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(37):=1150008;
CCCCR_3051_1_.tb5_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(37):=CCCCR_3051_1_.tb5_0(37);
CCCCR_3051_1_.old_tb5_1(37):=3203;
CCCCR_3051_1_.tb5_1(37):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(37),-1)));
CCCCR_3051_1_.old_tb5_2(37):=793;
CCCCR_3051_1_.tb5_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(37),-1)));
CCCCR_3051_1_.old_tb5_3(37):=-1;
CCCCR_3051_1_.tb5_3(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(37),-1)));
CCCCR_3051_1_.old_tb5_4(37):=-1;
CCCCR_3051_1_.tb5_4(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(37),-1)));
CCCCR_3051_1_.tb5_5(37):=CCCCR_3051_1_.tb2_0(3);
CCCCR_3051_1_.tb5_8(37):=CCCCR_3051_1_.tb0_0(22);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (37)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(37),
CCCCR_3051_1_.tb5_1(37),
CCCCR_3051_1_.tb5_2(37),
CCCCR_3051_1_.tb5_3(37),
CCCCR_3051_1_.tb5_4(37),
CCCCR_3051_1_.tb5_5(37),
null,
null,
CCCCR_3051_1_.tb5_8(37),
null,
600,
30,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
30,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(37):=1602666;
CCCCR_3051_1_.tb7_0(37):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(37):=CCCCR_3051_1_.tb7_0(37);
CCCCR_3051_1_.old_tb7_1(37):=793;
CCCCR_3051_1_.tb7_1(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(37),-1)));
CCCCR_3051_1_.old_tb7_2(37):=-1;
CCCCR_3051_1_.tb7_2(37):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(37),-1)));
CCCCR_3051_1_.tb7_3(37):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(37):=CCCCR_3051_1_.tb5_0(37);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (37)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(37),
CCCCR_3051_1_.tb7_1(37),
CCCCR_3051_1_.tb7_2(37),
CCCCR_3051_1_.tb7_3(37),
CCCCR_3051_1_.tb7_4(37),
'N'
,
'Y'
,
30,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(38):=1150009;
CCCCR_3051_1_.tb5_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(38):=CCCCR_3051_1_.tb5_0(38);
CCCCR_3051_1_.old_tb5_1(38):=9717;
CCCCR_3051_1_.tb5_1(38):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(38),-1)));
CCCCR_3051_1_.old_tb5_2(38):=20255;
CCCCR_3051_1_.tb5_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(38),-1)));
CCCCR_3051_1_.old_tb5_3(38):=-1;
CCCCR_3051_1_.tb5_3(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(38),-1)));
CCCCR_3051_1_.old_tb5_4(38):=-1;
CCCCR_3051_1_.tb5_4(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(38),-1)));
CCCCR_3051_1_.tb5_5(38):=CCCCR_3051_1_.tb2_0(3);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (38)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(38),
CCCCR_3051_1_.tb5_1(38),
CCCCR_3051_1_.tb5_2(38),
CCCCR_3051_1_.tb5_3(38),
CCCCR_3051_1_.tb5_4(38),
CCCCR_3051_1_.tb5_5(38),
null,
null,
null,
null,
600,
31,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
31,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(38):=1602667;
CCCCR_3051_1_.tb7_0(38):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(38):=CCCCR_3051_1_.tb7_0(38);
CCCCR_3051_1_.old_tb7_1(38):=20255;
CCCCR_3051_1_.tb7_1(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(38),-1)));
CCCCR_3051_1_.old_tb7_2(38):=-1;
CCCCR_3051_1_.tb7_2(38):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(38),-1)));
CCCCR_3051_1_.tb7_3(38):=CCCCR_3051_1_.tb6_0(2);
CCCCR_3051_1_.tb7_4(38):=CCCCR_3051_1_.tb5_0(38);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (38)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(38),
CCCCR_3051_1_.tb7_1(38),
CCCCR_3051_1_.tb7_2(38),
CCCCR_3051_1_.tb7_3(38),
CCCCR_3051_1_.tb7_4(38),
'N'
,
'Y'
,
31,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(3):=CCCCR_3051_1_.tb2_0(2);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (3)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(3),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(3):=2468;
CCCCR_3051_1_.tb6_0(3):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(3):=CCCCR_3051_1_.tb6_0(3);
CCCCR_3051_1_.tb6_1(3):=CCCCR_3051_1_.tb2_0(2);
ut_trace.trace('insertando tabla: GI_FRAME fila (3)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(3),
CCCCR_3051_1_.tb6_1(3),
null,
null,
'INF_CCCCR_TAB_1021672'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(4):=CCCCR_3051_1_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (4)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(4),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(12):=120197386;
CCCCR_3051_1_.tb8_0(12):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(12):=CCCCR_3051_1_.tb8_0(12);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (12)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(12),
16,
'Lista de Valores Actividades'
,
'SELECT ACTIVITY_ID ID, DESCRIPTION DESCRIPTION FROM GE_ACTIVITY ORDER BY ID
'
,
'Lista de Valores Actividades'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(23):=121403953;
CCCCR_3051_1_.tb0_0(23):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(23):=CCCCR_3051_1_.tb0_0(23);
CCCCR_3051_1_.old_tb0_1(23):='GEGE_EXERULVAL_CT69E121403953'
;
CCCCR_3051_1_.tb0_1(23):=CCCCR_3051_1_.tb0_0(23);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (23)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(23),
CCCCR_3051_1_.tb0_1(23),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","COUPLE_ACTIVITY_ID",sbValue);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","COUPLE_NAME",sbName);if (sbValue <> NULL '||chr(38)||''||chr(38)||' sbName = NULL,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Debe ingresar primero el nombre del conyugue");,)'
,
'OPEN'
,
to_date('27-11-2012 16:03:48','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida si ha digitado nombre del conyuge - Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(39):=1150010;
CCCCR_3051_1_.tb5_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(39):=CCCCR_3051_1_.tb5_0(39);
CCCCR_3051_1_.old_tb5_1(39):=9719;
CCCCR_3051_1_.tb5_1(39):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(39),-1)));
CCCCR_3051_1_.old_tb5_2(39):=20283;
CCCCR_3051_1_.tb5_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(39),-1)));
CCCCR_3051_1_.old_tb5_3(39):=-1;
CCCCR_3051_1_.tb5_3(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(39),-1)));
CCCCR_3051_1_.old_tb5_4(39):=-1;
CCCCR_3051_1_.tb5_4(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(39),-1)));
CCCCR_3051_1_.tb5_5(39):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_7(39):=CCCCR_3051_1_.tb8_0(12);
CCCCR_3051_1_.tb5_9(39):=CCCCR_3051_1_.tb0_0(23);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (39)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(39),
CCCCR_3051_1_.tb5_1(39),
CCCCR_3051_1_.tb5_2(39),
CCCCR_3051_1_.tb5_3(39),
CCCCR_3051_1_.tb5_4(39),
CCCCR_3051_1_.tb5_5(39),
null,
CCCCR_3051_1_.tb5_7(39),
null,
CCCCR_3051_1_.tb5_9(39),
600,
3,
'Actividad del Conyugue'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(4):=2469;
CCCCR_3051_1_.tb6_0(4):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(4):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb6_1(4):=CCCCR_3051_1_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_FRAME fila (4)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(4),
CCCCR_3051_1_.tb6_1(4),
null,
null,
'INF_CCCCR_FRAME_1021675'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(39):=1602668;
CCCCR_3051_1_.tb7_0(39):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(39):=CCCCR_3051_1_.tb7_0(39);
CCCCR_3051_1_.old_tb7_1(39):=20283;
CCCCR_3051_1_.tb7_1(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(39),-1)));
CCCCR_3051_1_.old_tb7_2(39):=-1;
CCCCR_3051_1_.tb7_2(39):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(39),-1)));
CCCCR_3051_1_.tb7_3(39):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(39):=CCCCR_3051_1_.tb5_0(39);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (39)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(39),
CCCCR_3051_1_.tb7_1(39),
CCCCR_3051_1_.tb7_2(39),
CCCCR_3051_1_.tb7_3(39),
CCCCR_3051_1_.tb7_4(39),
'Y'
,
'Y'
,
3,
'N'
,
'Actividad del Conyugue'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(13):=120197387;
CCCCR_3051_1_.tb8_0(13):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(13):=CCCCR_3051_1_.tb8_0(13);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (13)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(13),
16,
'Lista de Valores Escala Salarial'
,
'SELECT WAGE_SCALE_ID ID, DESCRIPTION DESCRIPTION FROM GE_WAGE_SCALE ORDER BY ID
'
,
'Lista de Valores Escala Salarial'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(24):=121403954;
CCCCR_3051_1_.tb0_0(24):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(24):=CCCCR_3051_1_.tb0_0(24);
CCCCR_3051_1_.old_tb0_1(24):='GEGE_EXERULVAL_CT69E121403954'
;
CCCCR_3051_1_.tb0_1(24):=CCCCR_3051_1_.tb0_0(24);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (24)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(24),
CCCCR_3051_1_.tb0_1(24),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","COUPLE_WAGE_SCALE",sbValue);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","COUPLE_NAME",sbName);if (sbValue <> NULL '||chr(38)||''||chr(38)||' sbName = NULL,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"Debe ingresar primero el nombre del conyuge");,)'
,
'OPEN'
,
to_date('27-11-2012 16:14:00','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida escala si ha ingresado nombre del conyuge'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(40):=1150011;
CCCCR_3051_1_.tb5_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(40):=CCCCR_3051_1_.tb5_0(40);
CCCCR_3051_1_.old_tb5_1(40):=9719;
CCCCR_3051_1_.tb5_1(40):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(40),-1)));
CCCCR_3051_1_.old_tb5_2(40):=20286;
CCCCR_3051_1_.tb5_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(40),-1)));
CCCCR_3051_1_.old_tb5_3(40):=-1;
CCCCR_3051_1_.tb5_3(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(40),-1)));
CCCCR_3051_1_.old_tb5_4(40):=-1;
CCCCR_3051_1_.tb5_4(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(40),-1)));
CCCCR_3051_1_.tb5_5(40):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_7(40):=CCCCR_3051_1_.tb8_0(13);
CCCCR_3051_1_.tb5_9(40):=CCCCR_3051_1_.tb0_0(24);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (40)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(40),
CCCCR_3051_1_.tb5_1(40),
CCCCR_3051_1_.tb5_2(40),
CCCCR_3051_1_.tb5_3(40),
CCCCR_3051_1_.tb5_4(40),
CCCCR_3051_1_.tb5_5(40),
null,
CCCCR_3051_1_.tb5_7(40),
null,
CCCCR_3051_1_.tb5_9(40),
600,
4,
'Escala Salarial del Conyugue'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(40):=1602669;
CCCCR_3051_1_.tb7_0(40):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(40):=CCCCR_3051_1_.tb7_0(40);
CCCCR_3051_1_.old_tb7_1(40):=20286;
CCCCR_3051_1_.tb7_1(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(40),-1)));
CCCCR_3051_1_.old_tb7_2(40):=-1;
CCCCR_3051_1_.tb7_2(40):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(40),-1)));
CCCCR_3051_1_.tb7_3(40):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(40):=CCCCR_3051_1_.tb5_0(40);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (40)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(40),
CCCCR_3051_1_.tb7_1(40),
CCCCR_3051_1_.tb7_2(40),
CCCCR_3051_1_.tb7_3(40),
CCCCR_3051_1_.tb7_4(40),
'Y'
,
'Y'
,
4,
'N'
,
'Escala Salarial del Conyugue'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(41):=1150012;
CCCCR_3051_1_.tb5_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(41):=CCCCR_3051_1_.tb5_0(41);
CCCCR_3051_1_.old_tb5_1(41):=9720;
CCCCR_3051_1_.tb5_1(41):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(41),-1)));
CCCCR_3051_1_.old_tb5_2(41):=20300;
CCCCR_3051_1_.tb5_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(41),-1)));
CCCCR_3051_1_.old_tb5_3(41):=-1;
CCCCR_3051_1_.tb5_3(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(41),-1)));
CCCCR_3051_1_.old_tb5_4(41):=-1;
CCCCR_3051_1_.tb5_4(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(41),-1)));
CCCCR_3051_1_.tb5_5(41):=CCCCR_3051_1_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (41)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(41),
CCCCR_3051_1_.tb5_1(41),
CCCCR_3051_1_.tb5_2(41),
CCCCR_3051_1_.tb5_3(41),
CCCCR_3051_1_.tb5_4(41),
CCCCR_3051_1_.tb5_5(41),
null,
null,
null,
null,
600,
10,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
10,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(41):=1602670;
CCCCR_3051_1_.tb7_0(41):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(41):=CCCCR_3051_1_.tb7_0(41);
CCCCR_3051_1_.old_tb7_1(41):=20300;
CCCCR_3051_1_.tb7_1(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(41),-1)));
CCCCR_3051_1_.old_tb7_2(41):=-1;
CCCCR_3051_1_.tb7_2(41):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(41),-1)));
CCCCR_3051_1_.tb7_3(41):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(41):=CCCCR_3051_1_.tb5_0(41);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (41)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(41),
CCCCR_3051_1_.tb7_1(41),
CCCCR_3051_1_.tb7_2(41),
CCCCR_3051_1_.tb7_3(41),
CCCCR_3051_1_.tb7_4(41),
'N'
,
'Y'
,
10,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(14):=120197388;
CCCCR_3051_1_.tb8_0(14):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(14):=CCCCR_3051_1_.tb8_0(14);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (14)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(14),
16,
'Lista de valores sobre la tabla GE_CIVIL_STATE'
,
'SELECT CIVIL_STATE_ID ID, DESCRIPTION FROM GE_CIVIL_STATE'
,
'GE_CIVIL_STATE'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(42):=1150013;
CCCCR_3051_1_.tb5_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(42):=CCCCR_3051_1_.tb5_0(42);
CCCCR_3051_1_.old_tb5_1(42):=9717;
CCCCR_3051_1_.tb5_1(42):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(42),-1)));
CCCCR_3051_1_.old_tb5_2(42):=20258;
CCCCR_3051_1_.tb5_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(42),-1)));
CCCCR_3051_1_.old_tb5_3(42):=-1;
CCCCR_3051_1_.tb5_3(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(42),-1)));
CCCCR_3051_1_.old_tb5_4(42):=-1;
CCCCR_3051_1_.tb5_4(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(42),-1)));
CCCCR_3051_1_.tb5_5(42):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_7(42):=CCCCR_3051_1_.tb8_0(14);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (42)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(42),
CCCCR_3051_1_.tb5_1(42),
CCCCR_3051_1_.tb5_2(42),
CCCCR_3051_1_.tb5_3(42),
CCCCR_3051_1_.tb5_4(42),
CCCCR_3051_1_.tb5_5(42),
null,
CCCCR_3051_1_.tb5_7(42),
null,
null,
600,
0,
'Estado Civil'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(42):=1602671;
CCCCR_3051_1_.tb7_0(42):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(42):=CCCCR_3051_1_.tb7_0(42);
CCCCR_3051_1_.old_tb7_1(42):=20258;
CCCCR_3051_1_.tb7_1(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(42),-1)));
CCCCR_3051_1_.old_tb7_2(42):=-1;
CCCCR_3051_1_.tb7_2(42):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(42),-1)));
CCCCR_3051_1_.tb7_3(42):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(42):=CCCCR_3051_1_.tb5_0(42);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (42)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(42),
CCCCR_3051_1_.tb7_1(42),
CCCCR_3051_1_.tb7_2(42),
CCCCR_3051_1_.tb7_3(42),
CCCCR_3051_1_.tb7_4(42),
'Y'
,
'Y'
,
0,
'N'
,
'Estado Civil'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(0):=352;
CCCCR_3051_1_.tb9_0(0):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(0):=CCCCR_3051_1_.tb9_0(0);
CCCCR_3051_1_.tb9_1(0):=CCCCR_3051_1_.tb5_0(42);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (0)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(0),
CCCCR_3051_1_.tb9_1(0),
1,
'GE_SUBS_GENERAL_DATA.CIVIL_STATE_ID_OP_IN_('|| chr(39) ||'2'|| chr(39) ||','|| chr(39) ||'3'|| chr(39) ||')'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(0):=6628;
CCCCR_3051_1_.tb10_0(0):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(0):=CCCCR_3051_1_.tb10_0(0);
CCCCR_3051_1_.tb10_1(0):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (0)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(0),
CCCCR_3051_1_.tb10_1(0),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_ACTIVITY_ID'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(1):=6629;
CCCCR_3051_1_.tb10_0(1):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(1):=CCCCR_3051_1_.tb10_0(1);
CCCCR_3051_1_.tb10_1(1):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (1)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(1),
CCCCR_3051_1_.tb10_1(1),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_WAGE_SCALE'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(2):=6630;
CCCCR_3051_1_.tb10_0(2):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(2):=CCCCR_3051_1_.tb10_0(2);
CCCCR_3051_1_.tb10_1(2):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (2)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(2),
CCCCR_3051_1_.tb10_1(2),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_IDENTIFY'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(3):=6631;
CCCCR_3051_1_.tb10_0(3):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(3):=CCCCR_3051_1_.tb10_0(3);
CCCCR_3051_1_.tb10_1(3):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (3)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(3),
CCCCR_3051_1_.tb10_1(3),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_NAME'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(4):=6632;
CCCCR_3051_1_.tb10_0(4):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(4):=CCCCR_3051_1_.tb10_0(4);
CCCCR_3051_1_.tb10_1(4):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (4)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(4),
CCCCR_3051_1_.tb10_1(4),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_WAGE_SCALE'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(5):=6633;
CCCCR_3051_1_.tb10_0(5):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(5):=CCCCR_3051_1_.tb10_0(5);
CCCCR_3051_1_.tb10_1(5):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (5)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(5),
CCCCR_3051_1_.tb10_1(5),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_IDENTIFY'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(6):=6634;
CCCCR_3051_1_.tb10_0(6):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(6):=CCCCR_3051_1_.tb10_0(6);
CCCCR_3051_1_.tb10_1(6):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (6)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(6),
CCCCR_3051_1_.tb10_1(6),
'N'
,
'GE_SUBS_FAMILY_DATA.COUPLE_NAME'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(7):=6635;
CCCCR_3051_1_.tb10_0(7):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(7):=CCCCR_3051_1_.tb10_0(7);
CCCCR_3051_1_.tb10_1(7):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (7)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(7),
CCCCR_3051_1_.tb10_1(7),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_WAGE_SCALE'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(8):=6636;
CCCCR_3051_1_.tb10_0(8):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(8):=CCCCR_3051_1_.tb10_0(8);
CCCCR_3051_1_.tb10_1(8):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (8)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(8),
CCCCR_3051_1_.tb10_1(8),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_IDENTIFY'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(9):=6637;
CCCCR_3051_1_.tb10_0(9):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(9):=CCCCR_3051_1_.tb10_0(9);
CCCCR_3051_1_.tb10_1(9):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (9)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(9),
CCCCR_3051_1_.tb10_1(9),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_WAGE_SCALE'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(10):=6638;
CCCCR_3051_1_.tb10_0(10):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(10):=CCCCR_3051_1_.tb10_0(10);
CCCCR_3051_1_.tb10_1(10):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (10)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(10),
CCCCR_3051_1_.tb10_1(10),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_IDENTIFY'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(11):=6639;
CCCCR_3051_1_.tb10_0(11):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(11):=CCCCR_3051_1_.tb10_0(11);
CCCCR_3051_1_.tb10_1(11):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (11)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(11),
CCCCR_3051_1_.tb10_1(11),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_NAME'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(12):=6640;
CCCCR_3051_1_.tb10_0(12):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(12):=CCCCR_3051_1_.tb10_0(12);
CCCCR_3051_1_.tb10_1(12):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (12)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(12),
CCCCR_3051_1_.tb10_1(12),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_ACTIVITY_ID'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(13):=6641;
CCCCR_3051_1_.tb10_0(13):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(13):=CCCCR_3051_1_.tb10_0(13);
CCCCR_3051_1_.tb10_1(13):=CCCCR_3051_1_.tb9_0(0);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (13)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(13),
CCCCR_3051_1_.tb10_1(13),
'Y'
,
'GE_SUBS_FAMILY_DATA.COUPLE_NAME'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(25):=121403955;
CCCCR_3051_1_.tb0_0(25):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(25):=CCCCR_3051_1_.tb0_0(25);
CCCCR_3051_1_.old_tb0_1(25):='GEGE_EXERULVAL_CT69E121403955'
;
CCCCR_3051_1_.tb0_1(25):=CCCCR_3051_1_.tb0_0(25);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (25)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(25),
CCCCR_3051_1_.tb0_1(25),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","NUMBER_DEPEND_PEOPLE",sbValue);nuDependPeople = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuDependPeople < 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El valor debe ser positivo y entero");,)'
,
'OPEN'
,
to_date('27-11-2012 16:44:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres tipo numerico Entero-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(43):=1150014;
CCCCR_3051_1_.tb5_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(43):=CCCCR_3051_1_.tb5_0(43);
CCCCR_3051_1_.old_tb5_1(43):=9719;
CCCCR_3051_1_.tb5_1(43):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(43),-1)));
CCCCR_3051_1_.old_tb5_2(43):=20287;
CCCCR_3051_1_.tb5_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(43),-1)));
CCCCR_3051_1_.old_tb5_3(43):=-1;
CCCCR_3051_1_.tb5_3(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(43),-1)));
CCCCR_3051_1_.old_tb5_4(43):=-1;
CCCCR_3051_1_.tb5_4(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(43),-1)));
CCCCR_3051_1_.tb5_5(43):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_9(43):=CCCCR_3051_1_.tb0_0(25);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (43)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(43),
CCCCR_3051_1_.tb5_1(43),
CCCCR_3051_1_.tb5_2(43),
CCCCR_3051_1_.tb5_3(43),
CCCCR_3051_1_.tb5_4(43),
CCCCR_3051_1_.tb5_5(43),
null,
null,
null,
CCCCR_3051_1_.tb5_9(43),
600,
5,
'Número de Personas a Cargo'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(43):=1602672;
CCCCR_3051_1_.tb7_0(43):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(43):=CCCCR_3051_1_.tb7_0(43);
CCCCR_3051_1_.old_tb7_1(43):=20287;
CCCCR_3051_1_.tb7_1(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(43),-1)));
CCCCR_3051_1_.old_tb7_2(43):=-1;
CCCCR_3051_1_.tb7_2(43):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(43),-1)));
CCCCR_3051_1_.tb7_3(43):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(43):=CCCCR_3051_1_.tb5_0(43);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (43)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(43),
CCCCR_3051_1_.tb7_1(43),
CCCCR_3051_1_.tb7_2(43),
CCCCR_3051_1_.tb7_3(43),
CCCCR_3051_1_.tb7_4(43),
'Y'
,
'Y'
,
5,
'N'
,
'Número de Personas a Cargo'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(26):=121403956;
CCCCR_3051_1_.tb0_0(26):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(26):=CCCCR_3051_1_.tb0_0(26);
CCCCR_3051_1_.old_tb0_1(26):='GEGE_EXERULVAL_CT69E121403956'
;
CCCCR_3051_1_.tb0_1(26):=CCCCR_3051_1_.tb0_0(26);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (26)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(26),
CCCCR_3051_1_.tb0_1(26),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_HOUSING_DATA","PERSON_QUANTITY",sbValue);nuPersonQuantity = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nupersonQuantity < 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El valor debe ser positivo y entero");,)'
,
'OPEN'
,
to_date('27-11-2012 16:50:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Valor Habitantes Vivienda Tipo Numérico-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(44):=1150015;
CCCCR_3051_1_.tb5_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(44):=CCCCR_3051_1_.tb5_0(44);
CCCCR_3051_1_.old_tb5_1(44):=9720;
CCCCR_3051_1_.tb5_1(44):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(44),-1)));
CCCCR_3051_1_.old_tb5_2(44):=55860;
CCCCR_3051_1_.tb5_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(44),-1)));
CCCCR_3051_1_.old_tb5_3(44):=-1;
CCCCR_3051_1_.tb5_3(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(44),-1)));
CCCCR_3051_1_.old_tb5_4(44):=-1;
CCCCR_3051_1_.tb5_4(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(44),-1)));
CCCCR_3051_1_.tb5_5(44):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_9(44):=CCCCR_3051_1_.tb0_0(26);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (44)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(44),
CCCCR_3051_1_.tb5_1(44),
CCCCR_3051_1_.tb5_2(44),
CCCCR_3051_1_.tb5_3(44),
CCCCR_3051_1_.tb5_4(44),
CCCCR_3051_1_.tb5_5(44),
null,
null,
null,
CCCCR_3051_1_.tb5_9(44),
600,
6,
'Numero de habitantes de Vivienda'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(44):=1602673;
CCCCR_3051_1_.tb7_0(44):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(44):=CCCCR_3051_1_.tb7_0(44);
CCCCR_3051_1_.old_tb7_1(44):=55860;
CCCCR_3051_1_.tb7_1(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(44),-1)));
CCCCR_3051_1_.old_tb7_2(44):=-1;
CCCCR_3051_1_.tb7_2(44):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(44),-1)));
CCCCR_3051_1_.tb7_3(44):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(44):=CCCCR_3051_1_.tb5_0(44);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (44)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(44),
CCCCR_3051_1_.tb7_1(44),
CCCCR_3051_1_.tb7_2(44),
CCCCR_3051_1_.tb7_3(44),
CCCCR_3051_1_.tb7_4(44),
'Y'
,
'Y'
,
6,
'N'
,
'Numero de habitantes de Vivienda'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(27):=121403957;
CCCCR_3051_1_.tb0_0(27):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(27):=CCCCR_3051_1_.tb0_0(27);
CCCCR_3051_1_.old_tb0_1(27):='GEGE_EXERULVAL_CT69E121403957'
;
CCCCR_3051_1_.tb0_1(27):=CCCCR_3051_1_.tb0_0(27);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (27)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(27),
CCCCR_3051_1_.tb0_1(27),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("N")'
,
'OPEN'
,
to_date('27-11-2012 10:22:42','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:49','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Atributo HAS_VEHICLE'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(45):=1150016;
CCCCR_3051_1_.tb5_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(45):=CCCCR_3051_1_.tb5_0(45);
CCCCR_3051_1_.old_tb5_1(45):=9719;
CCCCR_3051_1_.tb5_1(45):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(45),-1)));
CCCCR_3051_1_.old_tb5_2(45):=20282;
CCCCR_3051_1_.tb5_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(45),-1)));
CCCCR_3051_1_.old_tb5_3(45):=-1;
CCCCR_3051_1_.tb5_3(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(45),-1)));
CCCCR_3051_1_.old_tb5_4(45):=-1;
CCCCR_3051_1_.tb5_4(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(45),-1)));
CCCCR_3051_1_.tb5_5(45):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_8(45):=CCCCR_3051_1_.tb0_0(27);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (45)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(45),
CCCCR_3051_1_.tb5_1(45),
CCCCR_3051_1_.tb5_2(45),
CCCCR_3051_1_.tb5_3(45),
CCCCR_3051_1_.tb5_4(45),
CCCCR_3051_1_.tb5_5(45),
null,
null,
CCCCR_3051_1_.tb5_8(45),
null,
600,
7,
'Tiene Vehículo?'
,
'N'
,
'Y'
,
'N'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(45):=1602674;
CCCCR_3051_1_.tb7_0(45):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(45):=CCCCR_3051_1_.tb7_0(45);
CCCCR_3051_1_.old_tb7_1(45):=20282;
CCCCR_3051_1_.tb7_1(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(45),-1)));
CCCCR_3051_1_.old_tb7_2(45):=-1;
CCCCR_3051_1_.tb7_2(45):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(45),-1)));
CCCCR_3051_1_.tb7_3(45):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(45):=CCCCR_3051_1_.tb5_0(45);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (45)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(45),
CCCCR_3051_1_.tb7_1(45),
CCCCR_3051_1_.tb7_2(45),
CCCCR_3051_1_.tb7_3(45),
CCCCR_3051_1_.tb7_4(45),
'Y'
,
'Y'
,
7,
'N'
,
'Tiene Vehículo?'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(1):=353;
CCCCR_3051_1_.tb9_0(1):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(1):=CCCCR_3051_1_.tb9_0(1);
CCCCR_3051_1_.tb9_1(1):=CCCCR_3051_1_.tb5_0(45);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (1)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(1),
CCCCR_3051_1_.tb9_1(1),
1,
''|| chr(39) ||'GE_SUBS_FAMILY_DATA.HAS_VEHICULE'|| chr(39) ||'='|| chr(39) ||'Y'|| chr(39) ||''
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(14):=6642;
CCCCR_3051_1_.tb10_0(14):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(14):=CCCCR_3051_1_.tb10_0(14);
CCCCR_3051_1_.tb10_1(14):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (14)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(14),
CCCCR_3051_1_.tb10_1(14),
'N'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_BRAND'
,
'VALUE'
,
''|| chr(39) ||''|| chr(39) ||''
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(15):=6643;
CCCCR_3051_1_.tb10_0(15):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(15):=CCCCR_3051_1_.tb10_0(15);
CCCCR_3051_1_.tb10_1(15):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (15)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(15),
CCCCR_3051_1_.tb10_1(15),
'N'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_MODEL'
,
'VALUE'
,
''|| chr(39) ||''|| chr(39) ||''
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(16):=6644;
CCCCR_3051_1_.tb10_0(16):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(16):=CCCCR_3051_1_.tb10_0(16);
CCCCR_3051_1_.tb10_1(16):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (16)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(16),
CCCCR_3051_1_.tb10_1(16),
'Y'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_BRAND'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(17):=6645;
CCCCR_3051_1_.tb10_0(17):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(17):=CCCCR_3051_1_.tb10_0(17);
CCCCR_3051_1_.tb10_1(17):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (17)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(17),
CCCCR_3051_1_.tb10_1(17),
'Y'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_MODEL'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(18):=6646;
CCCCR_3051_1_.tb10_0(18):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(18):=CCCCR_3051_1_.tb10_0(18);
CCCCR_3051_1_.tb10_1(18):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (18)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(18),
CCCCR_3051_1_.tb10_1(18),
'N'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_BRAND'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(19):=6647;
CCCCR_3051_1_.tb10_0(19):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(19):=CCCCR_3051_1_.tb10_0(19);
CCCCR_3051_1_.tb10_1(19):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (19)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(19),
CCCCR_3051_1_.tb10_1(19),
'N'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_MODEL'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(20):=6648;
CCCCR_3051_1_.tb10_0(20):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(20):=CCCCR_3051_1_.tb10_0(20);
CCCCR_3051_1_.tb10_1(20):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (20)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(20),
CCCCR_3051_1_.tb10_1(20),
'Y'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_BRAND'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(21):=6649;
CCCCR_3051_1_.tb10_0(21):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(21):=CCCCR_3051_1_.tb10_0(21);
CCCCR_3051_1_.tb10_1(21):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (21)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(21),
CCCCR_3051_1_.tb10_1(21),
'Y'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_MODEL'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(22):=6650;
CCCCR_3051_1_.tb10_0(22):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(22):=CCCCR_3051_1_.tb10_0(22);
CCCCR_3051_1_.tb10_1(22):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (22)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(22),
CCCCR_3051_1_.tb10_1(22),
'N'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_MODEL'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(23):=6651;
CCCCR_3051_1_.tb10_0(23):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(23):=CCCCR_3051_1_.tb10_0(23);
CCCCR_3051_1_.tb10_1(23):=CCCCR_3051_1_.tb9_0(1);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (23)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(23),
CCCCR_3051_1_.tb10_1(23),
'N'
,
'GE_SUBS_FAMILY_DATA.VEHICULE_BRAND'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(46):=1150017;
CCCCR_3051_1_.tb5_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(46):=CCCCR_3051_1_.tb5_0(46);
CCCCR_3051_1_.old_tb5_1(46):=9719;
CCCCR_3051_1_.tb5_1(46):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(46),-1)));
CCCCR_3051_1_.old_tb5_2(46):=20289;
CCCCR_3051_1_.tb5_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(46),-1)));
CCCCR_3051_1_.old_tb5_3(46):=-1;
CCCCR_3051_1_.tb5_3(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(46),-1)));
CCCCR_3051_1_.old_tb5_4(46):=-1;
CCCCR_3051_1_.tb5_4(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(46),-1)));
CCCCR_3051_1_.tb5_5(46):=CCCCR_3051_1_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (46)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(46),
CCCCR_3051_1_.tb5_1(46),
CCCCR_3051_1_.tb5_2(46),
CCCCR_3051_1_.tb5_3(46),
CCCCR_3051_1_.tb5_4(46),
CCCCR_3051_1_.tb5_5(46),
null,
null,
null,
null,
600,
8,
'Marca Vehículo'
,
'N'
,
'Y'
,
'N'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(46):=1602675;
CCCCR_3051_1_.tb7_0(46):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(46):=CCCCR_3051_1_.tb7_0(46);
CCCCR_3051_1_.old_tb7_1(46):=20289;
CCCCR_3051_1_.tb7_1(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(46),-1)));
CCCCR_3051_1_.old_tb7_2(46):=-1;
CCCCR_3051_1_.tb7_2(46):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(46),-1)));
CCCCR_3051_1_.tb7_3(46):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(46):=CCCCR_3051_1_.tb5_0(46);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (46)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(46),
CCCCR_3051_1_.tb7_1(46),
CCCCR_3051_1_.tb7_2(46),
CCCCR_3051_1_.tb7_3(46),
CCCCR_3051_1_.tb7_4(46),
'Y'
,
'Y'
,
8,
'N'
,
'Marca Vehículo'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(47):=1150018;
CCCCR_3051_1_.tb5_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(47):=CCCCR_3051_1_.tb5_0(47);
CCCCR_3051_1_.old_tb5_1(47):=9719;
CCCCR_3051_1_.tb5_1(47):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(47),-1)));
CCCCR_3051_1_.old_tb5_2(47):=20290;
CCCCR_3051_1_.tb5_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(47),-1)));
CCCCR_3051_1_.old_tb5_3(47):=-1;
CCCCR_3051_1_.tb5_3(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(47),-1)));
CCCCR_3051_1_.old_tb5_4(47):=-1;
CCCCR_3051_1_.tb5_4(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(47),-1)));
CCCCR_3051_1_.tb5_5(47):=CCCCR_3051_1_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (47)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(47),
CCCCR_3051_1_.tb5_1(47),
CCCCR_3051_1_.tb5_2(47),
CCCCR_3051_1_.tb5_3(47),
CCCCR_3051_1_.tb5_4(47),
CCCCR_3051_1_.tb5_5(47),
null,
null,
null,
null,
600,
9,
'Modelo Vehículo'
,
'N'
,
'Y'
,
'N'
,
9,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(47):=1602676;
CCCCR_3051_1_.tb7_0(47):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(47):=CCCCR_3051_1_.tb7_0(47);
CCCCR_3051_1_.old_tb7_1(47):=20290;
CCCCR_3051_1_.tb7_1(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(47),-1)));
CCCCR_3051_1_.old_tb7_2(47):=-1;
CCCCR_3051_1_.tb7_2(47):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(47),-1)));
CCCCR_3051_1_.tb7_3(47):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(47):=CCCCR_3051_1_.tb5_0(47);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (47)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(47),
CCCCR_3051_1_.tb7_1(47),
CCCCR_3051_1_.tb7_2(47),
CCCCR_3051_1_.tb7_3(47),
CCCCR_3051_1_.tb7_4(47),
'Y'
,
'Y'
,
9,
'N'
,
'Modelo Vehículo'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(48):=1150019;
CCCCR_3051_1_.tb5_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(48):=CCCCR_3051_1_.tb5_0(48);
CCCCR_3051_1_.old_tb5_1(48):=9719;
CCCCR_3051_1_.tb5_1(48):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(48),-1)));
CCCCR_3051_1_.old_tb5_2(48):=20288;
CCCCR_3051_1_.tb5_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(48),-1)));
CCCCR_3051_1_.old_tb5_3(48):=-1;
CCCCR_3051_1_.tb5_3(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(48),-1)));
CCCCR_3051_1_.old_tb5_4(48):=-1;
CCCCR_3051_1_.tb5_4(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(48),-1)));
CCCCR_3051_1_.tb5_5(48):=CCCCR_3051_1_.tb2_0(5);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (48)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(48),
CCCCR_3051_1_.tb5_1(48),
CCCCR_3051_1_.tb5_2(48),
CCCCR_3051_1_.tb5_3(48),
CCCCR_3051_1_.tb5_4(48),
CCCCR_3051_1_.tb5_5(48),
null,
null,
null,
null,
600,
10,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
10,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(48):=1602677;
CCCCR_3051_1_.tb7_0(48):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(48):=CCCCR_3051_1_.tb7_0(48);
CCCCR_3051_1_.old_tb7_1(48):=20288;
CCCCR_3051_1_.tb7_1(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(48),-1)));
CCCCR_3051_1_.old_tb7_2(48):=-1;
CCCCR_3051_1_.tb7_2(48):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(48),-1)));
CCCCR_3051_1_.tb7_3(48):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(48):=CCCCR_3051_1_.tb5_0(48);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (48)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(48),
CCCCR_3051_1_.tb7_1(48),
CCCCR_3051_1_.tb7_2(48),
CCCCR_3051_1_.tb7_3(48),
CCCCR_3051_1_.tb7_4(48),
'N'
,
'Y'
,
10,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(28):=121403958;
CCCCR_3051_1_.tb0_0(28):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(28):=CCCCR_3051_1_.tb0_0(28);
CCCCR_3051_1_.old_tb0_1(28):='GEGE_EXERULVAL_CT69E121403958'
;
CCCCR_3051_1_.tb0_1(28):=CCCCR_3051_1_.tb0_0(28);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (28)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(28),
CCCCR_3051_1_.tb0_1(28),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","COUPLE_NAME",sbValue);if (sbValue = NULL,,SA_BOVALIDUSER.VALLOGIN(sbValue,2,100,"áéíóú'||chr(64)||'+-#$%'||chr(38)||'/()=?¡¿|*{}[]<>;=ÁÉÍÓÚ!1234567890");)'
,
'OPEN'
,
to_date('28-11-2012 17:37:12','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Nombre Conyuge-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(49):=1150020;
CCCCR_3051_1_.tb5_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(49):=CCCCR_3051_1_.tb5_0(49);
CCCCR_3051_1_.old_tb5_1(49):=9719;
CCCCR_3051_1_.tb5_1(49):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(49),-1)));
CCCCR_3051_1_.old_tb5_2(49):=20285;
CCCCR_3051_1_.tb5_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(49),-1)));
CCCCR_3051_1_.old_tb5_3(49):=-1;
CCCCR_3051_1_.tb5_3(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(49),-1)));
CCCCR_3051_1_.old_tb5_4(49):=-1;
CCCCR_3051_1_.tb5_4(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(49),-1)));
CCCCR_3051_1_.tb5_5(49):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_9(49):=CCCCR_3051_1_.tb0_0(28);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (49)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(49),
CCCCR_3051_1_.tb5_1(49),
CCCCR_3051_1_.tb5_2(49),
CCCCR_3051_1_.tb5_3(49),
CCCCR_3051_1_.tb5_4(49),
CCCCR_3051_1_.tb5_5(49),
null,
null,
null,
CCCCR_3051_1_.tb5_9(49),
600,
1,
'Nombre del Conyugue'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(49):=1602678;
CCCCR_3051_1_.tb7_0(49):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(49):=CCCCR_3051_1_.tb7_0(49);
CCCCR_3051_1_.old_tb7_1(49):=20285;
CCCCR_3051_1_.tb7_1(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(49),-1)));
CCCCR_3051_1_.old_tb7_2(49):=-1;
CCCCR_3051_1_.tb7_2(49):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(49),-1)));
CCCCR_3051_1_.tb7_3(49):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(49):=CCCCR_3051_1_.tb5_0(49);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (49)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(49),
CCCCR_3051_1_.tb7_1(49),
CCCCR_3051_1_.tb7_2(49),
CCCCR_3051_1_.tb7_3(49),
CCCCR_3051_1_.tb7_4(49),
'Y'
,
'Y'
,
1,
'N'
,
'Nombre del Conyugue'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(29):=121403959;
CCCCR_3051_1_.tb0_0(29):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(29):=CCCCR_3051_1_.tb0_0(29);
CCCCR_3051_1_.old_tb0_1(29):='GEGE_EXERULVAL_CT69E121403959'
;
CCCCR_3051_1_.tb0_1(29):=CCCCR_3051_1_.tb0_0(29);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (29)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(29),
CCCCR_3051_1_.tb0_1(29),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_FAMILY_DATA","COUPLE_IDENTIFY",sbValue);nuIdentificacion = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuIdentificacion <> NULL,if (nuIdentificacion < 0 || UT_STRING.FNULENGTH(nuIdentificacion) > 15,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de identificación debe ser positivo y menor o igual a 15 digitos");,);,)'
,
'OPEN'
,
to_date('27-11-2012 16:03:48','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida identificacion Conyuge-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(50):=1150021;
CCCCR_3051_1_.tb5_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(50):=CCCCR_3051_1_.tb5_0(50);
CCCCR_3051_1_.old_tb5_1(50):=9719;
CCCCR_3051_1_.tb5_1(50):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(50),-1)));
CCCCR_3051_1_.old_tb5_2(50):=20284;
CCCCR_3051_1_.tb5_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(50),-1)));
CCCCR_3051_1_.old_tb5_3(50):=-1;
CCCCR_3051_1_.tb5_3(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(50),-1)));
CCCCR_3051_1_.old_tb5_4(50):=-1;
CCCCR_3051_1_.tb5_4(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(50),-1)));
CCCCR_3051_1_.tb5_5(50):=CCCCR_3051_1_.tb2_0(5);
CCCCR_3051_1_.tb5_9(50):=CCCCR_3051_1_.tb0_0(29);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (50)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(50),
CCCCR_3051_1_.tb5_1(50),
CCCCR_3051_1_.tb5_2(50),
CCCCR_3051_1_.tb5_3(50),
CCCCR_3051_1_.tb5_4(50),
CCCCR_3051_1_.tb5_5(50),
null,
null,
null,
CCCCR_3051_1_.tb5_9(50),
600,
2,
'Identificación del Conyugue'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(50):=1602679;
CCCCR_3051_1_.tb7_0(50):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(50):=CCCCR_3051_1_.tb7_0(50);
CCCCR_3051_1_.old_tb7_1(50):=20284;
CCCCR_3051_1_.tb7_1(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(50),-1)));
CCCCR_3051_1_.old_tb7_2(50):=-1;
CCCCR_3051_1_.tb7_2(50):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(50),-1)));
CCCCR_3051_1_.tb7_3(50):=CCCCR_3051_1_.tb6_0(4);
CCCCR_3051_1_.tb7_4(50):=CCCCR_3051_1_.tb5_0(50);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (50)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(50),
CCCCR_3051_1_.tb7_1(50),
CCCCR_3051_1_.tb7_2(50),
CCCCR_3051_1_.tb7_3(50),
CCCCR_3051_1_.tb7_4(50),
'Y'
,
'Y'
,
2,
'N'
,
'Identificación del Conyugue'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(5):=CCCCR_3051_1_.tb2_0(6);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (5)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(5),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(30):=121403960;
CCCCR_3051_1_.tb0_0(30):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(30):=CCCCR_3051_1_.tb0_0(30);
CCCCR_3051_1_.old_tb0_1(30):='GEGE_EXERULVAL_CT69E121403960'
;
CCCCR_3051_1_.tb0_1(30):=CCCCR_3051_1_.tb0_0(30);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (30)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(30),
CCCCR_3051_1_.tb0_1(30),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_HOUSING_DATA","RENTER_NAME",sbValue);if (sbValue <> NULL,SA_BOVALIDUSER.VALLOGIN(sbValue,2,100,"áéíóú'||chr(64)||'+-#$%'||chr(38)||'/()=?¡¿|*{}[]<>;=ÁÉÍÓÚ!1234567890");,)'
,
'OPEN'
,
to_date('27-11-2012 16:56:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Nombre Arrendador-Pasaporte'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(51):=1150022;
CCCCR_3051_1_.tb5_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(51):=CCCCR_3051_1_.tb5_0(51);
CCCCR_3051_1_.old_tb5_1(51):=9720;
CCCCR_3051_1_.tb5_1(51):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(51),-1)));
CCCCR_3051_1_.old_tb5_2(51):=20293;
CCCCR_3051_1_.tb5_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(51),-1)));
CCCCR_3051_1_.old_tb5_3(51):=-1;
CCCCR_3051_1_.tb5_3(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(51),-1)));
CCCCR_3051_1_.old_tb5_4(51):=-1;
CCCCR_3051_1_.tb5_4(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(51),-1)));
CCCCR_3051_1_.tb5_5(51):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb5_9(51):=CCCCR_3051_1_.tb0_0(30);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (51)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(51),
CCCCR_3051_1_.tb5_1(51),
CCCCR_3051_1_.tb5_2(51),
CCCCR_3051_1_.tb5_3(51),
CCCCR_3051_1_.tb5_4(51),
CCCCR_3051_1_.tb5_5(51),
null,
null,
null,
CCCCR_3051_1_.tb5_9(51),
600,
1,
'Nombre del Arrendador'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(5):=2470;
CCCCR_3051_1_.tb6_0(5):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(5):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb6_1(5):=CCCCR_3051_1_.tb2_0(6);
ut_trace.trace('insertando tabla: GI_FRAME fila (5)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(5),
CCCCR_3051_1_.tb6_1(5),
null,
null,
'INF_CCCCR_FRAME_1021676'
,
2);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(51):=1602680;
CCCCR_3051_1_.tb7_0(51):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(51):=CCCCR_3051_1_.tb7_0(51);
CCCCR_3051_1_.old_tb7_1(51):=20293;
CCCCR_3051_1_.tb7_1(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(51),-1)));
CCCCR_3051_1_.old_tb7_2(51):=-1;
CCCCR_3051_1_.tb7_2(51):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(51),-1)));
CCCCR_3051_1_.tb7_3(51):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(51):=CCCCR_3051_1_.tb5_0(51);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (51)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(51),
CCCCR_3051_1_.tb7_1(51),
CCCCR_3051_1_.tb7_2(51),
CCCCR_3051_1_.tb7_3(51),
CCCCR_3051_1_.tb7_4(51),
'Y'
,
'Y'
,
1,
'N'
,
'Nombre del Arrendador'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(31):=121403961;
CCCCR_3051_1_.tb0_0(31):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(31):=CCCCR_3051_1_.tb0_0(31);
CCCCR_3051_1_.old_tb0_1(31):='GEGE_EXERULVAL_CT69E121403961'
;
CCCCR_3051_1_.tb0_1(31):=CCCCR_3051_1_.tb0_0(31);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (31)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(31),
CCCCR_3051_1_.tb0_1(31),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_HOUSING_DATA","RENTER_PHONE",sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone <> null,if (UT_STRING.FNULENGTH(nuPhone) = 7 || UT_STRING.FNULENGTH(nuPhone) = 10,,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono debe ser de 7 o 10 dÍgitos"););,)'
,
'OPEN'
,
to_date('27-11-2012 17:06:54','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Tamaño telefono Arrendador-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(52):=1150023;
CCCCR_3051_1_.tb5_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(52):=CCCCR_3051_1_.tb5_0(52);
CCCCR_3051_1_.old_tb5_1(52):=9720;
CCCCR_3051_1_.tb5_1(52):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(52),-1)));
CCCCR_3051_1_.old_tb5_2(52):=20294;
CCCCR_3051_1_.tb5_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(52),-1)));
CCCCR_3051_1_.old_tb5_3(52):=-1;
CCCCR_3051_1_.tb5_3(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(52),-1)));
CCCCR_3051_1_.old_tb5_4(52):=-1;
CCCCR_3051_1_.tb5_4(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(52),-1)));
CCCCR_3051_1_.tb5_5(52):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb5_9(52):=CCCCR_3051_1_.tb0_0(31);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (52)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(52),
CCCCR_3051_1_.tb5_1(52),
CCCCR_3051_1_.tb5_2(52),
CCCCR_3051_1_.tb5_3(52),
CCCCR_3051_1_.tb5_4(52),
CCCCR_3051_1_.tb5_5(52),
null,
null,
null,
CCCCR_3051_1_.tb5_9(52),
600,
2,
'Teléfono del Arrendador'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(52):=1602681;
CCCCR_3051_1_.tb7_0(52):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(52):=CCCCR_3051_1_.tb7_0(52);
CCCCR_3051_1_.old_tb7_1(52):=20294;
CCCCR_3051_1_.tb7_1(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(52),-1)));
CCCCR_3051_1_.old_tb7_2(52):=-1;
CCCCR_3051_1_.tb7_2(52):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(52),-1)));
CCCCR_3051_1_.tb7_3(52):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(52):=CCCCR_3051_1_.tb5_0(52);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (52)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(52),
CCCCR_3051_1_.tb7_1(52),
CCCCR_3051_1_.tb7_2(52),
CCCCR_3051_1_.tb7_3(52),
CCCCR_3051_1_.tb7_4(52),
'Y'
,
'Y'
,
2,
'N'
,
'Teléfono del Arrendador'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(32):=121403962;
CCCCR_3051_1_.tb0_0(32):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(32):=CCCCR_3051_1_.tb0_0(32);
CCCCR_3051_1_.old_tb0_1(32):='GEGE_EXERULVAL_CT69E121403962'
;
CCCCR_3051_1_.tb0_1(32):=CCCCR_3051_1_.tb0_0(32);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (32)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(32),
CCCCR_3051_1_.tb0_1(32),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_HOUSING_DATA","YEARS_LIVING_HOUSE",sbValue);nuTiempoVivienda = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuTiempoVivienda < 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El valor debe ser positivo y entero");,)'
,
'OPEN'
,
to_date('17-02-2013 21:42:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Tiempo en Vivienda'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(53):=1150024;
CCCCR_3051_1_.tb5_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(53):=CCCCR_3051_1_.tb5_0(53);
CCCCR_3051_1_.old_tb5_1(53):=9720;
CCCCR_3051_1_.tb5_1(53):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(53),-1)));
CCCCR_3051_1_.old_tb5_2(53):=20296;
CCCCR_3051_1_.tb5_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(53),-1)));
CCCCR_3051_1_.old_tb5_3(53):=-1;
CCCCR_3051_1_.tb5_3(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(53),-1)));
CCCCR_3051_1_.old_tb5_4(53):=-1;
CCCCR_3051_1_.tb5_4(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(53),-1)));
CCCCR_3051_1_.tb5_5(53):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb5_9(53):=CCCCR_3051_1_.tb0_0(32);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (53)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(53),
CCCCR_3051_1_.tb5_1(53),
CCCCR_3051_1_.tb5_2(53),
CCCCR_3051_1_.tb5_3(53),
CCCCR_3051_1_.tb5_4(53),
CCCCR_3051_1_.tb5_5(53),
null,
null,
null,
CCCCR_3051_1_.tb5_9(53),
600,
5,
'Tiempo en Vivienda (meses)'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(53):=1602682;
CCCCR_3051_1_.tb7_0(53):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(53):=CCCCR_3051_1_.tb7_0(53);
CCCCR_3051_1_.old_tb7_1(53):=20296;
CCCCR_3051_1_.tb7_1(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(53),-1)));
CCCCR_3051_1_.old_tb7_2(53):=-1;
CCCCR_3051_1_.tb7_2(53):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(53),-1)));
CCCCR_3051_1_.tb7_3(53):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(53):=CCCCR_3051_1_.tb5_0(53);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (53)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(53),
CCCCR_3051_1_.tb7_1(53),
CCCCR_3051_1_.tb7_2(53),
CCCCR_3051_1_.tb7_3(53),
CCCCR_3051_1_.tb7_4(53),
'Y'
,
'Y'
,
5,
'N'
,
'Tiempo en Vivienda (meses)'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(54):=1150025;
CCCCR_3051_1_.tb5_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(54):=CCCCR_3051_1_.tb5_0(54);
CCCCR_3051_1_.old_tb5_1(54):=9720;
CCCCR_3051_1_.tb5_1(54):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(54),-1)));
CCCCR_3051_1_.old_tb5_2(54):=20300;
CCCCR_3051_1_.tb5_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(54),-1)));
CCCCR_3051_1_.old_tb5_3(54):=-1;
CCCCR_3051_1_.tb5_3(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(54),-1)));
CCCCR_3051_1_.old_tb5_4(54):=-1;
CCCCR_3051_1_.tb5_4(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(54),-1)));
CCCCR_3051_1_.tb5_5(54):=CCCCR_3051_1_.tb2_0(6);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (54)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(54),
CCCCR_3051_1_.tb5_1(54),
CCCCR_3051_1_.tb5_2(54),
CCCCR_3051_1_.tb5_3(54),
CCCCR_3051_1_.tb5_4(54),
CCCCR_3051_1_.tb5_5(54),
null,
null,
null,
null,
600,
8,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(54):=1602683;
CCCCR_3051_1_.tb7_0(54):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(54):=CCCCR_3051_1_.tb7_0(54);
CCCCR_3051_1_.old_tb7_1(54):=20300;
CCCCR_3051_1_.tb7_1(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(54),-1)));
CCCCR_3051_1_.old_tb7_2(54):=-1;
CCCCR_3051_1_.tb7_2(54):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(54),-1)));
CCCCR_3051_1_.tb7_3(54):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(54):=CCCCR_3051_1_.tb5_0(54);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (54)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(54),
CCCCR_3051_1_.tb7_1(54),
CCCCR_3051_1_.tb7_2(54),
CCCCR_3051_1_.tb7_3(54),
CCCCR_3051_1_.tb7_4(54),
'N'
,
'Y'
,
8,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(15):=120197389;
CCCCR_3051_1_.tb8_0(15):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(15):=CCCCR_3051_1_.tb8_0(15);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (15)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(15),
16,
'Lista de uso del servicio'
,
'SELECT catecodi id,catedesc description
FROM categori'
,
'Lista de uso del servicio'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(55):=1150026;
CCCCR_3051_1_.tb5_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(55):=CCCCR_3051_1_.tb5_0(55);
CCCCR_3051_1_.old_tb5_1(55):=9720;
CCCCR_3051_1_.tb5_1(55):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(55),-1)));
CCCCR_3051_1_.old_tb5_2(55):=133384;
CCCCR_3051_1_.tb5_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(55),-1)));
CCCCR_3051_1_.old_tb5_3(55):=-1;
CCCCR_3051_1_.tb5_3(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(55),-1)));
CCCCR_3051_1_.old_tb5_4(55):=-1;
CCCCR_3051_1_.tb5_4(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(55),-1)));
CCCCR_3051_1_.tb5_5(55):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb5_7(55):=CCCCR_3051_1_.tb8_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (55)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(55),
CCCCR_3051_1_.tb5_1(55),
CCCCR_3051_1_.tb5_2(55),
CCCCR_3051_1_.tb5_3(55),
CCCCR_3051_1_.tb5_4(55),
CCCCR_3051_1_.tb5_5(55),
null,
CCCCR_3051_1_.tb5_7(55),
null,
null,
600,
3,
'Categoría'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(55):=1602684;
CCCCR_3051_1_.tb7_0(55):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(55):=CCCCR_3051_1_.tb7_0(55);
CCCCR_3051_1_.old_tb7_1(55):=133384;
CCCCR_3051_1_.tb7_1(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(55),-1)));
CCCCR_3051_1_.old_tb7_2(55):=-1;
CCCCR_3051_1_.tb7_2(55):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(55),-1)));
CCCCR_3051_1_.tb7_3(55):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(55):=CCCCR_3051_1_.tb5_0(55);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (55)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(55),
CCCCR_3051_1_.tb7_1(55),
CCCCR_3051_1_.tb7_2(55),
CCCCR_3051_1_.tb7_3(55),
CCCCR_3051_1_.tb7_4(55),
'Y'
,
'Y'
,
3,
'N'
,
'Categoría'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(16):=120197390;
CCCCR_3051_1_.tb8_0(16):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(16):=CCCCR_3051_1_.tb8_0(16);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (16)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(16),
16,
'Lista de valores sobre la tabla SUBCATEG'
,
'select sucacodi ID, sucadesc DESCRIPTION
from   subcateg
WHERE  sucacate = ge_boInstanceControl.fsbGetFieldValue('|| chr(39) ||'GE_SUBS_HOUSING_DATA'|| chr(39) ||','|| chr(39) ||'CATEGORY_ID'|| chr(39) ||')'
,
'SUBCATEG'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(56):=1150027;
CCCCR_3051_1_.tb5_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(56):=CCCCR_3051_1_.tb5_0(56);
CCCCR_3051_1_.old_tb5_1(56):=9720;
CCCCR_3051_1_.tb5_1(56):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(56),-1)));
CCCCR_3051_1_.old_tb5_2(56):=133385;
CCCCR_3051_1_.tb5_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(56),-1)));
CCCCR_3051_1_.old_tb5_3(56):=-1;
CCCCR_3051_1_.tb5_3(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(56),-1)));
CCCCR_3051_1_.old_tb5_4(56):=133384;
CCCCR_3051_1_.tb5_4(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(56),-1)));
CCCCR_3051_1_.tb5_5(56):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb5_7(56):=CCCCR_3051_1_.tb8_0(16);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (56)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(56),
CCCCR_3051_1_.tb5_1(56),
CCCCR_3051_1_.tb5_2(56),
CCCCR_3051_1_.tb5_3(56),
CCCCR_3051_1_.tb5_4(56),
CCCCR_3051_1_.tb5_5(56),
null,
CCCCR_3051_1_.tb5_7(56),
null,
null,
600,
4,
'Subcategoría'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(56):=1602685;
CCCCR_3051_1_.tb7_0(56):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(56):=CCCCR_3051_1_.tb7_0(56);
CCCCR_3051_1_.old_tb7_1(56):=133385;
CCCCR_3051_1_.tb7_1(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(56),-1)));
CCCCR_3051_1_.old_tb7_2(56):=133384;
CCCCR_3051_1_.tb7_2(56):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(56),-1)));
CCCCR_3051_1_.tb7_3(56):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(56):=CCCCR_3051_1_.tb5_0(56);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (56)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(56),
CCCCR_3051_1_.tb7_1(56),
CCCCR_3051_1_.tb7_2(56),
CCCCR_3051_1_.tb7_3(56),
CCCCR_3051_1_.tb7_4(56),
'Y'
,
'Y'
,
4,
'N'
,
'Subcategoría'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(17):=120197391;
CCCCR_3051_1_.tb8_0(17):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(17):=CCCCR_3051_1_.tb8_0(17);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (17)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(17),
16,
'Lista de Valores Tipo de Vivienda'
,
'SELECT HOUSE_TYPE_ID ID, DESCRIPTION DESCRIPTION FROM GE_HOUSE_TYPE ORDER BY ID
'
,
'Lista de Valores Tipo de Vivienda'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(57):=1150028;
CCCCR_3051_1_.tb5_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(57):=CCCCR_3051_1_.tb5_0(57);
CCCCR_3051_1_.old_tb5_1(57):=9720;
CCCCR_3051_1_.tb5_1(57):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(57),-1)));
CCCCR_3051_1_.old_tb5_2(57):=20291;
CCCCR_3051_1_.tb5_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(57),-1)));
CCCCR_3051_1_.old_tb5_3(57):=-1;
CCCCR_3051_1_.tb5_3(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(57),-1)));
CCCCR_3051_1_.old_tb5_4(57):=-1;
CCCCR_3051_1_.tb5_4(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(57),-1)));
CCCCR_3051_1_.tb5_5(57):=CCCCR_3051_1_.tb2_0(6);
CCCCR_3051_1_.tb5_7(57):=CCCCR_3051_1_.tb8_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (57)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(57),
CCCCR_3051_1_.tb5_1(57),
CCCCR_3051_1_.tb5_2(57),
CCCCR_3051_1_.tb5_3(57),
CCCCR_3051_1_.tb5_4(57),
CCCCR_3051_1_.tb5_5(57),
null,
CCCCR_3051_1_.tb5_7(57),
null,
null,
600,
0,
'Tipo de Vivienda'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(57):=1602686;
CCCCR_3051_1_.tb7_0(57):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(57):=CCCCR_3051_1_.tb7_0(57);
CCCCR_3051_1_.old_tb7_1(57):=20291;
CCCCR_3051_1_.tb7_1(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(57),-1)));
CCCCR_3051_1_.old_tb7_2(57):=-1;
CCCCR_3051_1_.tb7_2(57):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(57),-1)));
CCCCR_3051_1_.tb7_3(57):=CCCCR_3051_1_.tb6_0(5);
CCCCR_3051_1_.tb7_4(57):=CCCCR_3051_1_.tb5_0(57);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (57)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(57),
CCCCR_3051_1_.tb7_1(57),
CCCCR_3051_1_.tb7_2(57),
CCCCR_3051_1_.tb7_3(57),
CCCCR_3051_1_.tb7_4(57),
'Y'
,
'Y'
,
0,
'N'
,
'Tipo de Vivienda'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(2):=354;
CCCCR_3051_1_.tb9_0(2):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(2):=CCCCR_3051_1_.tb9_0(2);
CCCCR_3051_1_.tb9_1(2):=CCCCR_3051_1_.tb5_0(57);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (2)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(2),
CCCCR_3051_1_.tb9_1(2),
1,
'GE_SUBS_HOUSING_DATA.HOUSE_TYPE_ID=GE_BOParameter.fnuGet('|| chr(39) ||'RENTED_HOUSING'|| chr(39) ||')'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(24):=6652;
CCCCR_3051_1_.tb10_0(24):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(24):=CCCCR_3051_1_.tb10_0(24);
CCCCR_3051_1_.tb10_1(24):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (24)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(24),
CCCCR_3051_1_.tb10_1(24),
'N'
,
'GE_SUBS_HOUSING_DATA.RENTER_NAME'
,
'VALUE'
,
''|| chr(39) ||''|| chr(39) ||''
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(25):=6653;
CCCCR_3051_1_.tb10_0(25):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(25):=CCCCR_3051_1_.tb10_0(25);
CCCCR_3051_1_.tb10_1(25):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (25)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(25),
CCCCR_3051_1_.tb10_1(25),
'N'
,
'GE_SUBS_HOUSING_DATA.RENTER_PHONE'
,
'VALUE'
,
''|| chr(39) ||''|| chr(39) ||''
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(26):=6654;
CCCCR_3051_1_.tb10_0(26):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(26):=CCCCR_3051_1_.tb10_0(26);
CCCCR_3051_1_.tb10_1(26):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (26)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(26),
CCCCR_3051_1_.tb10_1(26),
'Y'
,
'GE_SUBS_HOUSING_DATA.RENTER_NAME'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(27):=6655;
CCCCR_3051_1_.tb10_0(27):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(27):=CCCCR_3051_1_.tb10_0(27);
CCCCR_3051_1_.tb10_1(27):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (27)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(27),
CCCCR_3051_1_.tb10_1(27),
'Y'
,
'GE_SUBS_HOUSING_DATA.RENTER_PHONE'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(28):=6656;
CCCCR_3051_1_.tb10_0(28):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(28):=CCCCR_3051_1_.tb10_0(28);
CCCCR_3051_1_.tb10_1(28):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (28)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(28),
CCCCR_3051_1_.tb10_1(28),
'N'
,
'GE_SUBS_HOUSING_DATA.RENTER_NAME'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(29):=6657;
CCCCR_3051_1_.tb10_0(29):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(29):=CCCCR_3051_1_.tb10_0(29);
CCCCR_3051_1_.tb10_1(29):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (29)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(29),
CCCCR_3051_1_.tb10_1(29),
'N'
,
'GE_SUBS_HOUSING_DATA.RENTER_PHONE'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(30):=6658;
CCCCR_3051_1_.tb10_0(30):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(30):=CCCCR_3051_1_.tb10_0(30);
CCCCR_3051_1_.tb10_1(30):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (30)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(30),
CCCCR_3051_1_.tb10_1(30),
'Y'
,
'GE_SUBS_HOUSING_DATA.RENTER_NAME'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(31):=6659;
CCCCR_3051_1_.tb10_0(31):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(31):=CCCCR_3051_1_.tb10_0(31);
CCCCR_3051_1_.tb10_1(31):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (31)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(31),
CCCCR_3051_1_.tb10_1(31),
'Y'
,
'GE_SUBS_HOUSING_DATA.RENTER_PHONE'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(32):=6660;
CCCCR_3051_1_.tb10_0(32):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(32):=CCCCR_3051_1_.tb10_0(32);
CCCCR_3051_1_.tb10_1(32):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (32)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(32),
CCCCR_3051_1_.tb10_1(32),
'N'
,
'GE_SUBS_HOUSING_DATA.RENTER_NAME'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(33):=6661;
CCCCR_3051_1_.tb10_0(33):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(33):=CCCCR_3051_1_.tb10_0(33);
CCCCR_3051_1_.tb10_1(33):=CCCCR_3051_1_.tb9_0(2);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (33)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(33),
CCCCR_3051_1_.tb10_1(33),
'N'
,
'GE_SUBS_HOUSING_DATA.RENTER_PHONE'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(6):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (6)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(6),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(58):=1150029;
CCCCR_3051_1_.tb5_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(58):=CCCCR_3051_1_.tb5_0(58);
CCCCR_3051_1_.old_tb5_1(58):=9718;
CCCCR_3051_1_.tb5_1(58):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(58),-1)));
CCCCR_3051_1_.old_tb5_2(58):=20275;
CCCCR_3051_1_.tb5_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(58),-1)));
CCCCR_3051_1_.old_tb5_3(58):=-1;
CCCCR_3051_1_.tb5_3(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(58),-1)));
CCCCR_3051_1_.old_tb5_4(58):=-1;
CCCCR_3051_1_.tb5_4(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(58),-1)));
CCCCR_3051_1_.tb5_5(58):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (58)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(58),
CCCCR_3051_1_.tb5_1(58),
CCCCR_3051_1_.tb5_2(58),
CCCCR_3051_1_.tb5_3(58),
CCCCR_3051_1_.tb5_4(58),
CCCCR_3051_1_.tb5_5(58),
null,
null,
null,
null,
600,
7,
'Tiempo en la Empresa'
,
'N'
,
'Y'
,
'N'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(6):=2471;
CCCCR_3051_1_.tb6_0(6):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(6):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb6_1(6):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_FRAME fila (6)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(6),
CCCCR_3051_1_.tb6_1(6),
null,
null,
'INF_CCCCR_FRAME_1021677'
,
3);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(58):=1602687;
CCCCR_3051_1_.tb7_0(58):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(58):=CCCCR_3051_1_.tb7_0(58);
CCCCR_3051_1_.old_tb7_1(58):=20275;
CCCCR_3051_1_.tb7_1(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(58),-1)));
CCCCR_3051_1_.old_tb7_2(58):=-1;
CCCCR_3051_1_.tb7_2(58):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(58),-1)));
CCCCR_3051_1_.tb7_3(58):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(58):=CCCCR_3051_1_.tb5_0(58);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (58)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(58),
CCCCR_3051_1_.tb7_1(58),
CCCCR_3051_1_.tb7_2(58),
CCCCR_3051_1_.tb7_3(58),
CCCCR_3051_1_.tb7_4(58),
'Y'
,
'Y'
,
7,
'N'
,
'Tiempo en la Empresa'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(59):=1150030;
CCCCR_3051_1_.tb5_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(59):=CCCCR_3051_1_.tb5_0(59);
CCCCR_3051_1_.old_tb5_1(59):=9718;
CCCCR_3051_1_.tb5_1(59):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(59),-1)));
CCCCR_3051_1_.old_tb5_2(59):=20271;
CCCCR_3051_1_.tb5_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(59),-1)));
CCCCR_3051_1_.old_tb5_3(59):=-1;
CCCCR_3051_1_.tb5_3(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(59),-1)));
CCCCR_3051_1_.old_tb5_4(59):=-1;
CCCCR_3051_1_.tb5_4(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(59),-1)));
CCCCR_3051_1_.tb5_5(59):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (59)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(59),
CCCCR_3051_1_.tb5_1(59),
CCCCR_3051_1_.tb5_2(59),
CCCCR_3051_1_.tb5_3(59),
CCCCR_3051_1_.tb5_4(59),
CCCCR_3051_1_.tb5_5(59),
null,
null,
null,
null,
600,
8,
'Fecha de Contratación'
,
'N'
,
'Y'
,
'N'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(59):=1602688;
CCCCR_3051_1_.tb7_0(59):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(59):=CCCCR_3051_1_.tb7_0(59);
CCCCR_3051_1_.old_tb7_1(59):=20271;
CCCCR_3051_1_.tb7_1(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(59),-1)));
CCCCR_3051_1_.old_tb7_2(59):=-1;
CCCCR_3051_1_.tb7_2(59):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(59),-1)));
CCCCR_3051_1_.tb7_3(59):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(59):=CCCCR_3051_1_.tb5_0(59);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (59)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(59),
CCCCR_3051_1_.tb7_1(59),
CCCCR_3051_1_.tb7_2(59),
CCCCR_3051_1_.tb7_3(59),
CCCCR_3051_1_.tb7_4(59),
'Y'
,
'Y'
,
8,
'N'
,
'Fecha de Contratación'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(60):=1150031;
CCCCR_3051_1_.tb5_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(60):=CCCCR_3051_1_.tb5_0(60);
CCCCR_3051_1_.old_tb5_1(60):=9718;
CCCCR_3051_1_.tb5_1(60):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(60),-1)));
CCCCR_3051_1_.old_tb5_2(60):=20276;
CCCCR_3051_1_.tb5_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(60),-1)));
CCCCR_3051_1_.old_tb5_3(60):=-1;
CCCCR_3051_1_.tb5_3(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(60),-1)));
CCCCR_3051_1_.old_tb5_4(60):=-1;
CCCCR_3051_1_.tb5_4(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(60),-1)));
CCCCR_3051_1_.tb5_5(60):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (60)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(60),
CCCCR_3051_1_.tb5_1(60),
CCCCR_3051_1_.tb5_2(60),
CCCCR_3051_1_.tb5_3(60),
CCCCR_3051_1_.tb5_4(60),
CCCCR_3051_1_.tb5_5(60),
null,
null,
null,
null,
600,
10,
'Experiencia'
,
'N'
,
'Y'
,
'N'
,
10,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(60):=1602689;
CCCCR_3051_1_.tb7_0(60):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(60):=CCCCR_3051_1_.tb7_0(60);
CCCCR_3051_1_.old_tb7_1(60):=20276;
CCCCR_3051_1_.tb7_1(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(60),-1)));
CCCCR_3051_1_.old_tb7_2(60):=-1;
CCCCR_3051_1_.tb7_2(60):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(60),-1)));
CCCCR_3051_1_.tb7_3(60):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(60):=CCCCR_3051_1_.tb5_0(60);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (60)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(60),
CCCCR_3051_1_.tb7_1(60),
CCCCR_3051_1_.tb7_2(60),
CCCCR_3051_1_.tb7_3(60),
CCCCR_3051_1_.tb7_4(60),
'Y'
,
'Y'
,
10,
'N'
,
'Experiencia'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(61):=1150032;
CCCCR_3051_1_.tb5_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(61):=CCCCR_3051_1_.tb5_0(61);
CCCCR_3051_1_.old_tb5_1(61):=9718;
CCCCR_3051_1_.tb5_1(61):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(61),-1)));
CCCCR_3051_1_.old_tb5_2(61):=20269;
CCCCR_3051_1_.tb5_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(61),-1)));
CCCCR_3051_1_.old_tb5_3(61):=-1;
CCCCR_3051_1_.tb5_3(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(61),-1)));
CCCCR_3051_1_.old_tb5_4(61):=-1;
CCCCR_3051_1_.tb5_4(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(61),-1)));
CCCCR_3051_1_.tb5_5(61):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (61)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(61),
CCCCR_3051_1_.tb5_1(61),
CCCCR_3051_1_.tb5_2(61),
CCCCR_3051_1_.tb5_3(61),
CCCCR_3051_1_.tb5_4(61),
CCCCR_3051_1_.tb5_5(61),
null,
null,
null,
null,
600,
11,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
11,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(61):=1602690;
CCCCR_3051_1_.tb7_0(61):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(61):=CCCCR_3051_1_.tb7_0(61);
CCCCR_3051_1_.old_tb7_1(61):=20269;
CCCCR_3051_1_.tb7_1(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(61),-1)));
CCCCR_3051_1_.old_tb7_2(61):=-1;
CCCCR_3051_1_.tb7_2(61):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(61),-1)));
CCCCR_3051_1_.tb7_3(61):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(61):=CCCCR_3051_1_.tb5_0(61);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (61)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(61),
CCCCR_3051_1_.tb7_1(61),
CCCCR_3051_1_.tb7_2(61),
CCCCR_3051_1_.tb7_3(61),
CCCCR_3051_1_.tb7_4(61),
'N'
,
'Y'
,
11,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(62):=1150033;
CCCCR_3051_1_.tb5_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(62):=CCCCR_3051_1_.tb5_0(62);
CCCCR_3051_1_.old_tb5_1(62):=9718;
CCCCR_3051_1_.tb5_1(62):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(62),-1)));
CCCCR_3051_1_.old_tb5_2(62):=20270;
CCCCR_3051_1_.tb5_2(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(62),-1)));
CCCCR_3051_1_.old_tb5_3(62):=-1;
CCCCR_3051_1_.tb5_3(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(62),-1)));
CCCCR_3051_1_.old_tb5_4(62):=-1;
CCCCR_3051_1_.tb5_4(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(62),-1)));
CCCCR_3051_1_.tb5_5(62):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (62)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(62),
CCCCR_3051_1_.tb5_1(62),
CCCCR_3051_1_.tb5_2(62),
CCCCR_3051_1_.tb5_3(62),
CCCCR_3051_1_.tb5_4(62),
CCCCR_3051_1_.tb5_5(62),
null,
null,
null,
null,
600,
1,
'Empresa donde Labora'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(62):=1602691;
CCCCR_3051_1_.tb7_0(62):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(62):=CCCCR_3051_1_.tb7_0(62);
CCCCR_3051_1_.old_tb7_1(62):=20270;
CCCCR_3051_1_.tb7_1(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(62),-1)));
CCCCR_3051_1_.old_tb7_2(62):=-1;
CCCCR_3051_1_.tb7_2(62):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(62),-1)));
CCCCR_3051_1_.tb7_3(62):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(62):=CCCCR_3051_1_.tb5_0(62);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (62)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(62),
CCCCR_3051_1_.tb7_1(62),
CCCCR_3051_1_.tb7_2(62),
CCCCR_3051_1_.tb7_3(62),
CCCCR_3051_1_.tb7_4(62),
'Y'
,
'N'
,
1,
'N'
,
'Empresa donde Labora'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(33):=121403963;
CCCCR_3051_1_.tb0_0(33):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(33):=CCCCR_3051_1_.tb0_0(33);
CCCCR_3051_1_.old_tb0_1(33):='GEGE_EXERULVAL_CT69E121403963'
;
CCCCR_3051_1_.tb0_1(33):=CCCCR_3051_1_.tb0_0(33);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (33)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(33),
CCCCR_3051_1_.tb0_1(33),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBS_WORK_RELAT","PHONE_OFFICE",sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone <> NULL,if (UT_STRING.FNULENGTH(nuPhone) = 7 || UT_STRING.FNULENGTH(nuPhone) = 10,,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono debe ser de 7 o 10 dígitos"););,)'
,
'OPEN'
,
to_date('17-02-2013 21:58:20','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Teléfono Laboral-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(63):=1150034;
CCCCR_3051_1_.tb5_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(63):=CCCCR_3051_1_.tb5_0(63);
CCCCR_3051_1_.old_tb5_1(63):=9718;
CCCCR_3051_1_.tb5_1(63):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(63),-1)));
CCCCR_3051_1_.old_tb5_2(63):=20272;
CCCCR_3051_1_.tb5_2(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(63),-1)));
CCCCR_3051_1_.old_tb5_3(63):=-1;
CCCCR_3051_1_.tb5_3(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(63),-1)));
CCCCR_3051_1_.old_tb5_4(63):=-1;
CCCCR_3051_1_.tb5_4(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(63),-1)));
CCCCR_3051_1_.tb5_5(63):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb5_9(63):=CCCCR_3051_1_.tb0_0(33);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (63)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(63),
CCCCR_3051_1_.tb5_1(63),
CCCCR_3051_1_.tb5_2(63),
CCCCR_3051_1_.tb5_3(63),
CCCCR_3051_1_.tb5_4(63),
CCCCR_3051_1_.tb5_5(63),
null,
null,
null,
CCCCR_3051_1_.tb5_9(63),
600,
2,
'Teléfono de la Oficina'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(63):=1602692;
CCCCR_3051_1_.tb7_0(63):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(63):=CCCCR_3051_1_.tb7_0(63);
CCCCR_3051_1_.old_tb7_1(63):=20272;
CCCCR_3051_1_.tb7_1(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(63),-1)));
CCCCR_3051_1_.old_tb7_2(63):=-1;
CCCCR_3051_1_.tb7_2(63):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(63),-1)));
CCCCR_3051_1_.tb7_3(63):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(63):=CCCCR_3051_1_.tb5_0(63);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (63)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(63),
CCCCR_3051_1_.tb7_1(63),
CCCCR_3051_1_.tb7_2(63),
CCCCR_3051_1_.tb7_3(63),
CCCCR_3051_1_.tb7_4(63),
'Y'
,
'Y'
,
2,
'N'
,
'Teléfono de la Oficina'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(64):=1150035;
CCCCR_3051_1_.tb5_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(64):=CCCCR_3051_1_.tb5_0(64);
CCCCR_3051_1_.old_tb5_1(64):=9718;
CCCCR_3051_1_.tb5_1(64):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(64),-1)));
CCCCR_3051_1_.old_tb5_2(64):=20278;
CCCCR_3051_1_.tb5_2(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(64),-1)));
CCCCR_3051_1_.old_tb5_3(64):=-1;
CCCCR_3051_1_.tb5_3(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(64),-1)));
CCCCR_3051_1_.old_tb5_4(64):=-1;
CCCCR_3051_1_.tb5_4(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(64),-1)));
CCCCR_3051_1_.tb5_5(64):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (64)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(64),
CCCCR_3051_1_.tb5_1(64),
CCCCR_3051_1_.tb5_2(64),
CCCCR_3051_1_.tb5_3(64),
CCCCR_3051_1_.tb5_4(64),
CCCCR_3051_1_.tb5_5(64),
null,
null,
null,
null,
600,
11,
'Empresa Anterior'
,
'N'
,
'Y'
,
'N'
,
11,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(64):=1602693;
CCCCR_3051_1_.tb7_0(64):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(64):=CCCCR_3051_1_.tb7_0(64);
CCCCR_3051_1_.old_tb7_1(64):=20278;
CCCCR_3051_1_.tb7_1(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(64),-1)));
CCCCR_3051_1_.old_tb7_2(64):=-1;
CCCCR_3051_1_.tb7_2(64):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(64),-1)));
CCCCR_3051_1_.tb7_3(64):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(64):=CCCCR_3051_1_.tb5_0(64);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (64)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(64),
CCCCR_3051_1_.tb7_1(64),
CCCCR_3051_1_.tb7_2(64),
CCCCR_3051_1_.tb7_3(64),
CCCCR_3051_1_.tb7_4(64),
'Y'
,
'Y'
,
11,
'N'
,
'Empresa Anterior'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(18):=120197392;
CCCCR_3051_1_.tb8_0(18):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(18):=CCCCR_3051_1_.tb8_0(18);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (18)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(18),
16,
'Lista de Valores Actividades'
,
'SELECT ACTIVITY_ID ID, DESCRIPTION DESCRIPTION FROM GE_ACTIVITY ORDER BY ID
'
,
'Lista de Valores Actividades'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(65):=1150036;
CCCCR_3051_1_.tb5_0(65):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(65):=CCCCR_3051_1_.tb5_0(65);
CCCCR_3051_1_.old_tb5_1(65):=9718;
CCCCR_3051_1_.tb5_1(65):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(65),-1)));
CCCCR_3051_1_.old_tb5_2(65):=20273;
CCCCR_3051_1_.tb5_2(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(65),-1)));
CCCCR_3051_1_.old_tb5_3(65):=-1;
CCCCR_3051_1_.tb5_3(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(65),-1)));
CCCCR_3051_1_.old_tb5_4(65):=-1;
CCCCR_3051_1_.tb5_4(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(65),-1)));
CCCCR_3051_1_.tb5_5(65):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb5_7(65):=CCCCR_3051_1_.tb8_0(18);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (65)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(65),
CCCCR_3051_1_.tb5_1(65),
CCCCR_3051_1_.tb5_2(65),
CCCCR_3051_1_.tb5_3(65),
CCCCR_3051_1_.tb5_4(65),
CCCCR_3051_1_.tb5_5(65),
null,
CCCCR_3051_1_.tb5_7(65),
null,
null,
600,
0,
'Actividad'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(65):=1602694;
CCCCR_3051_1_.tb7_0(65):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(65):=CCCCR_3051_1_.tb7_0(65);
CCCCR_3051_1_.old_tb7_1(65):=20273;
CCCCR_3051_1_.tb7_1(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(65),-1)));
CCCCR_3051_1_.old_tb7_2(65):=-1;
CCCCR_3051_1_.tb7_2(65):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(65),-1)));
CCCCR_3051_1_.tb7_3(65):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(65):=CCCCR_3051_1_.tb5_0(65);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (65)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(65),
CCCCR_3051_1_.tb7_1(65),
CCCCR_3051_1_.tb7_2(65),
CCCCR_3051_1_.tb7_3(65),
CCCCR_3051_1_.tb7_4(65),
'Y'
,
'Y'
,
0,
'N'
,
'Actividad'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(3):=355;
CCCCR_3051_1_.tb9_0(3):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(3):=CCCCR_3051_1_.tb9_0(3);
CCCCR_3051_1_.tb9_1(3):=CCCCR_3051_1_.tb5_0(65);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (3)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(3),
CCCCR_3051_1_.tb9_1(3),
1,
'GE_SUBS_WORK_RELAT.ACTIVITY_ID=1'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(34):=6662;
CCCCR_3051_1_.tb10_0(34):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(34):=CCCCR_3051_1_.tb10_0(34);
CCCCR_3051_1_.tb10_1(34):=CCCCR_3051_1_.tb9_0(3);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (34)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(34),
CCCCR_3051_1_.tb10_1(34),
'N'
,
'GE_SUBS_WORK_RELAT.COMPANY'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(35):=6663;
CCCCR_3051_1_.tb10_0(35):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(35):=CCCCR_3051_1_.tb10_0(35);
CCCCR_3051_1_.tb10_1(35):=CCCCR_3051_1_.tb9_0(3);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (35)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(35),
CCCCR_3051_1_.tb10_1(35),
'N'
,
'GE_SUBS_WORK_RELAT.COMPANY'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(36):=6664;
CCCCR_3051_1_.tb10_0(36):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(36):=CCCCR_3051_1_.tb10_0(36);
CCCCR_3051_1_.tb10_1(36):=CCCCR_3051_1_.tb9_0(3);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (36)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(36),
CCCCR_3051_1_.tb10_1(36),
'N'
,
'GE_SUBS_WORK_RELAT.ADDRESS_ID'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(37):=6665;
CCCCR_3051_1_.tb10_0(37):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(37):=CCCCR_3051_1_.tb10_0(37);
CCCCR_3051_1_.tb10_1(37):=CCCCR_3051_1_.tb9_0(3);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (37)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(37),
CCCCR_3051_1_.tb10_1(37),
'Y'
,
'GE_SUBS_WORK_RELAT.COMPANY'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(38):=6666;
CCCCR_3051_1_.tb10_0(38):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(38):=CCCCR_3051_1_.tb10_0(38);
CCCCR_3051_1_.tb10_1(38):=CCCCR_3051_1_.tb9_0(3);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (38)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(38),
CCCCR_3051_1_.tb10_1(38),
'Y'
,
'GE_SUBS_WORK_RELAT.COMPANY'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(39):=6667;
CCCCR_3051_1_.tb10_0(39):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(39):=CCCCR_3051_1_.tb10_0(39);
CCCCR_3051_1_.tb10_1(39):=CCCCR_3051_1_.tb9_0(3);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (39)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(39),
CCCCR_3051_1_.tb10_1(39),
'Y'
,
'GE_SUBS_WORK_RELAT.ADDRESS_ID'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(34):=121403964;
CCCCR_3051_1_.tb0_0(34):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(34):=CCCCR_3051_1_.tb0_0(34);
CCCCR_3051_1_.old_tb0_1(34):='GEGE_EXERULVAL_CT69E121403964'
;
CCCCR_3051_1_.tb0_1(34):=CCCCR_3051_1_.tb0_0(34);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (34)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(34),
CCCCR_3051_1_.tb0_1(34),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"GE_SUBS_WORK_RELAT","OCCUPATION",sbValue);if (sbValue <> NULL,SA_BOVALIDUSER.VALLOGIN(sbValue,2,100,"áéíóú'||chr(64)||'+-#$%'||chr(38)||'=()=?¡¿|*{}[]<>;=ÁÉÍÓÚ!1234567890");,)'
,
'OPEN'
,
to_date('30-11-2012 16:54:41','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Ocupación-Cédula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(66):=1150037;
CCCCR_3051_1_.tb5_0(66):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(66):=CCCCR_3051_1_.tb5_0(66);
CCCCR_3051_1_.old_tb5_1(66):=9718;
CCCCR_3051_1_.tb5_1(66):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(66),-1)));
CCCCR_3051_1_.old_tb5_2(66):=20280;
CCCCR_3051_1_.tb5_2(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(66),-1)));
CCCCR_3051_1_.old_tb5_3(66):=-1;
CCCCR_3051_1_.tb5_3(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(66),-1)));
CCCCR_3051_1_.old_tb5_4(66):=-1;
CCCCR_3051_1_.tb5_4(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(66),-1)));
CCCCR_3051_1_.tb5_5(66):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb5_9(66):=CCCCR_3051_1_.tb0_0(34);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (66)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(66),
CCCCR_3051_1_.tb5_1(66),
CCCCR_3051_1_.tb5_2(66),
CCCCR_3051_1_.tb5_3(66),
CCCCR_3051_1_.tb5_4(66),
CCCCR_3051_1_.tb5_5(66),
null,
null,
null,
CCCCR_3051_1_.tb5_9(66),
600,
9,
'Ocupación'
,
'N'
,
'Y'
,
'N'
,
9,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(66):=1602695;
CCCCR_3051_1_.tb7_0(66):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(66):=CCCCR_3051_1_.tb7_0(66);
CCCCR_3051_1_.old_tb7_1(66):=20280;
CCCCR_3051_1_.tb7_1(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(66),-1)));
CCCCR_3051_1_.old_tb7_2(66):=-1;
CCCCR_3051_1_.tb7_2(66):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(66),-1)));
CCCCR_3051_1_.tb7_3(66):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(66):=CCCCR_3051_1_.tb5_0(66);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (66)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(66),
CCCCR_3051_1_.tb7_1(66),
CCCCR_3051_1_.tb7_2(66),
CCCCR_3051_1_.tb7_3(66),
CCCCR_3051_1_.tb7_4(66),
'Y'
,
'Y'
,
9,
'N'
,
'Ocupación'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(35):=121403965;
CCCCR_3051_1_.tb0_0(35):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(35):=CCCCR_3051_1_.tb0_0(35);
CCCCR_3051_1_.old_tb0_1(35):='GEGE_EXERULVAL_CT69E121403965'
;
CCCCR_3051_1_.tb0_1(35):=CCCCR_3051_1_.tb0_0(35);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (35)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(35),
CCCCR_3051_1_.tb0_1(35),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBS_WORK_RELAT","PHONE_EXTENSION",sbValue);nuExtension = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuExtension <> NULL,if (nuExtension <= 0,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de Extensión debe ser mayor que 0");,);,)'
,
'OPEN'
,
to_date('17-02-2013 22:04:47','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida el valor sea positivo y numerico-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(67):=1150038;
CCCCR_3051_1_.tb5_0(67):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(67):=CCCCR_3051_1_.tb5_0(67);
CCCCR_3051_1_.old_tb5_1(67):=9718;
CCCCR_3051_1_.tb5_1(67):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(67),-1)));
CCCCR_3051_1_.old_tb5_2(67):=55619;
CCCCR_3051_1_.tb5_2(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(67),-1)));
CCCCR_3051_1_.old_tb5_3(67):=-1;
CCCCR_3051_1_.tb5_3(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(67),-1)));
CCCCR_3051_1_.old_tb5_4(67):=-1;
CCCCR_3051_1_.tb5_4(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(67),-1)));
CCCCR_3051_1_.tb5_5(67):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb5_9(67):=CCCCR_3051_1_.tb0_0(35);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (67)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(67),
CCCCR_3051_1_.tb5_1(67),
CCCCR_3051_1_.tb5_2(67),
CCCCR_3051_1_.tb5_3(67),
CCCCR_3051_1_.tb5_4(67),
CCCCR_3051_1_.tb5_5(67),
null,
null,
null,
CCCCR_3051_1_.tb5_9(67),
600,
3,
'Extensión'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(67):=1602696;
CCCCR_3051_1_.tb7_0(67):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(67):=CCCCR_3051_1_.tb7_0(67);
CCCCR_3051_1_.old_tb7_1(67):=55619;
CCCCR_3051_1_.tb7_1(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(67),-1)));
CCCCR_3051_1_.old_tb7_2(67):=-1;
CCCCR_3051_1_.tb7_2(67):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(67),-1)));
CCCCR_3051_1_.tb7_3(67):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(67):=CCCCR_3051_1_.tb5_0(67);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (67)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(67),
CCCCR_3051_1_.tb7_1(67),
CCCCR_3051_1_.tb7_2(67),
CCCCR_3051_1_.tb7_3(67),
CCCCR_3051_1_.tb7_4(67),
'Y'
,
'Y'
,
3,
'N'
,
'Extensión'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(68):=1150039;
CCCCR_3051_1_.tb5_0(68):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(68):=CCCCR_3051_1_.tb5_0(68);
CCCCR_3051_1_.old_tb5_1(68):=9718;
CCCCR_3051_1_.tb5_1(68):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(68),-1)));
CCCCR_3051_1_.old_tb5_2(68):=1112;
CCCCR_3051_1_.tb5_2(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(68),-1)));
CCCCR_3051_1_.old_tb5_3(68):=-1;
CCCCR_3051_1_.tb5_3(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(68),-1)));
CCCCR_3051_1_.old_tb5_4(68):=-1;
CCCCR_3051_1_.tb5_4(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(68),-1)));
CCCCR_3051_1_.tb5_5(68):=CCCCR_3051_1_.tb2_0(7);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (68)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(68),
CCCCR_3051_1_.tb5_1(68),
CCCCR_3051_1_.tb5_2(68),
CCCCR_3051_1_.tb5_3(68),
CCCCR_3051_1_.tb5_4(68),
CCCCR_3051_1_.tb5_5(68),
null,
null,
null,
null,
600,
4,
'Dirección'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(68):=1602697;
CCCCR_3051_1_.tb7_0(68):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(68):=CCCCR_3051_1_.tb7_0(68);
CCCCR_3051_1_.old_tb7_1(68):=1112;
CCCCR_3051_1_.tb7_1(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(68),-1)));
CCCCR_3051_1_.old_tb7_2(68):=-1;
CCCCR_3051_1_.tb7_2(68):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(68),-1)));
CCCCR_3051_1_.tb7_3(68):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(68):=CCCCR_3051_1_.tb5_0(68);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (68)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(68),
CCCCR_3051_1_.tb7_1(68),
CCCCR_3051_1_.tb7_2(68),
CCCCR_3051_1_.tb7_3(68),
CCCCR_3051_1_.tb7_4(68),
'Y'
,
'Y'
,
4,
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
2,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(36):=121403966;
CCCCR_3051_1_.tb0_0(36):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(36):=CCCCR_3051_1_.tb0_0(36);
CCCCR_3051_1_.old_tb0_1(36):='GEGE_EXERULVAL_CT69E121403966'
;
CCCCR_3051_1_.tb0_1(36):=CCCCR_3051_1_.tb0_0(36);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (36)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(36),
CCCCR_3051_1_.tb0_1(36),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBS_WORK_RELAT","TITLE",sbValue);if (sbValue = NULL,,SA_BOVALIDUSER.VALLOGIN(sbValue,2,100,"áéíóú'||chr(64)||'+-#$%'||chr(38)||'/()=?¡¿|*{}[]<>;=ÁÉÍÓÚ!");)'
,
'OPEN'
,
to_date('17-02-2013 22:12:26','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cargo-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(69):=1150040;
CCCCR_3051_1_.tb5_0(69):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(69):=CCCCR_3051_1_.tb5_0(69);
CCCCR_3051_1_.old_tb5_1(69):=9718;
CCCCR_3051_1_.tb5_1(69):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(69),-1)));
CCCCR_3051_1_.old_tb5_2(69):=20274;
CCCCR_3051_1_.tb5_2(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(69),-1)));
CCCCR_3051_1_.old_tb5_3(69):=-1;
CCCCR_3051_1_.tb5_3(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(69),-1)));
CCCCR_3051_1_.old_tb5_4(69):=-1;
CCCCR_3051_1_.tb5_4(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(69),-1)));
CCCCR_3051_1_.tb5_5(69):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb5_9(69):=CCCCR_3051_1_.tb0_0(36);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (69)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(69),
CCCCR_3051_1_.tb5_1(69),
CCCCR_3051_1_.tb5_2(69),
CCCCR_3051_1_.tb5_3(69),
CCCCR_3051_1_.tb5_4(69),
CCCCR_3051_1_.tb5_5(69),
null,
null,
null,
CCCCR_3051_1_.tb5_9(69),
600,
5,
'Cargo'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(69):=1602698;
CCCCR_3051_1_.tb7_0(69):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(69):=CCCCR_3051_1_.tb7_0(69);
CCCCR_3051_1_.old_tb7_1(69):=20274;
CCCCR_3051_1_.tb7_1(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(69),-1)));
CCCCR_3051_1_.old_tb7_2(69):=-1;
CCCCR_3051_1_.tb7_2(69):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(69),-1)));
CCCCR_3051_1_.tb7_3(69):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(69):=CCCCR_3051_1_.tb5_0(69);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (69)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(69),
CCCCR_3051_1_.tb7_1(69),
CCCCR_3051_1_.tb7_2(69),
CCCCR_3051_1_.tb7_3(69),
CCCCR_3051_1_.tb7_4(69),
'Y'
,
'Y'
,
5,
'N'
,
'Cargo'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(37):=121403967;
CCCCR_3051_1_.tb0_0(37):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(37):=CCCCR_3051_1_.tb0_0(37);
CCCCR_3051_1_.old_tb0_1(37):='GEGE_EXERULVAL_CT69E121403967'
;
CCCCR_3051_1_.tb0_1(37):=CCCCR_3051_1_.tb0_0(37);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (37)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(37),
CCCCR_3051_1_.tb0_1(37),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBS_WORK_RELAT","WORK_AREA",sbValue);if (sbValue <> NULL,SA_BOVALIDUSER.VALLOGIN(sbValue,2,100,"áéíóú'||chr(64)||'+-#$%'||chr(38)||'/()=?¡¿|*{}[]<>;=ÁÉÍÓÚ!1234567890");,)'
,
'OPEN'
,
to_date('17-02-2013 22:18:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:52','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Area de Trabajo-Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(70):=1150041;
CCCCR_3051_1_.tb5_0(70):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(70):=CCCCR_3051_1_.tb5_0(70);
CCCCR_3051_1_.old_tb5_1(70):=9718;
CCCCR_3051_1_.tb5_1(70):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(70),-1)));
CCCCR_3051_1_.old_tb5_2(70):=55620;
CCCCR_3051_1_.tb5_2(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(70),-1)));
CCCCR_3051_1_.old_tb5_3(70):=-1;
CCCCR_3051_1_.tb5_3(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(70),-1)));
CCCCR_3051_1_.old_tb5_4(70):=-1;
CCCCR_3051_1_.tb5_4(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(70),-1)));
CCCCR_3051_1_.tb5_5(70):=CCCCR_3051_1_.tb2_0(7);
CCCCR_3051_1_.tb5_9(70):=CCCCR_3051_1_.tb0_0(37);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (70)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(70),
CCCCR_3051_1_.tb5_1(70),
CCCCR_3051_1_.tb5_2(70),
CCCCR_3051_1_.tb5_3(70),
CCCCR_3051_1_.tb5_4(70),
CCCCR_3051_1_.tb5_5(70),
null,
null,
null,
CCCCR_3051_1_.tb5_9(70),
600,
6,
'Área en la que Trabaja'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(70):=1602699;
CCCCR_3051_1_.tb7_0(70):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(70):=CCCCR_3051_1_.tb7_0(70);
CCCCR_3051_1_.old_tb7_1(70):=55620;
CCCCR_3051_1_.tb7_1(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(70),-1)));
CCCCR_3051_1_.old_tb7_2(70):=-1;
CCCCR_3051_1_.tb7_2(70):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(70),-1)));
CCCCR_3051_1_.tb7_3(70):=CCCCR_3051_1_.tb6_0(6);
CCCCR_3051_1_.tb7_4(70):=CCCCR_3051_1_.tb5_0(70);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (70)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(70),
CCCCR_3051_1_.tb7_1(70),
CCCCR_3051_1_.tb7_2(70),
CCCCR_3051_1_.tb7_3(70),
CCCCR_3051_1_.tb7_4(70),
'Y'
,
'Y'
,
6,
'N'
,
'Área en la que Trabaja'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(7):=CCCCR_3051_1_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (7)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(7),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(7):=2472;
CCCCR_3051_1_.tb6_0(7):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(7):=CCCCR_3051_1_.tb6_0(7);
CCCCR_3051_1_.tb6_1(7):=CCCCR_3051_1_.tb2_0(4);
ut_trace.trace('insertando tabla: GI_FRAME fila (7)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(7),
CCCCR_3051_1_.tb6_1(7),
null,
null,
'INF_CCCCR_TAB_1021674'
,
2);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(8):=CCCCR_3051_1_.tb2_0(9);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (8)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(8),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
'REFERENCE_TYPE_ID = 2'
,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(19):=120197393;
CCCCR_3051_1_.tb8_0(19):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(19):=CCCCR_3051_1_.tb8_0(19);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (19)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(19),
16,
'Lista de Valores Tipo de Identificación'
,
'SELECT IDENT_TYPE_ID ID, DESCRIPTION DESCRIPTION FROM GE_IDENTIFICA_TYPE ORDER BY ID
'
,
'Lista de Valores Tipo de Identificación'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(71):=1150042;
CCCCR_3051_1_.tb5_0(71):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(71):=CCCCR_3051_1_.tb5_0(71);
CCCCR_3051_1_.old_tb5_1(71):=9721;
CCCCR_3051_1_.tb5_1(71):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(71),-1)));
CCCCR_3051_1_.old_tb5_2(71):=20312;
CCCCR_3051_1_.tb5_2(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(71),-1)));
CCCCR_3051_1_.old_tb5_3(71):=-1;
CCCCR_3051_1_.tb5_3(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(71),-1)));
CCCCR_3051_1_.old_tb5_4(71):=-1;
CCCCR_3051_1_.tb5_4(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(71),-1)));
CCCCR_3051_1_.tb5_5(71):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_7(71):=CCCCR_3051_1_.tb8_0(19);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (71)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(71),
CCCCR_3051_1_.tb5_1(71),
CCCCR_3051_1_.tb5_2(71),
CCCCR_3051_1_.tb5_3(71),
CCCCR_3051_1_.tb5_4(71),
CCCCR_3051_1_.tb5_5(71),
null,
CCCCR_3051_1_.tb5_7(71),
null,
null,
600,
0,
'Tipo de Identificación'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(8):=2473;
CCCCR_3051_1_.tb6_0(8):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(8):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb6_1(8):=CCCCR_3051_1_.tb2_0(9);
ut_trace.trace('insertando tabla: GI_FRAME fila (8)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(8),
CCCCR_3051_1_.tb6_1(8),
null,
null,
'INF_CCCCR_FRAME_1021681'
,
2);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(71):=1602700;
CCCCR_3051_1_.tb7_0(71):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(71):=CCCCR_3051_1_.tb7_0(71);
CCCCR_3051_1_.old_tb7_1(71):=20312;
CCCCR_3051_1_.tb7_1(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(71),-1)));
CCCCR_3051_1_.old_tb7_2(71):=-1;
CCCCR_3051_1_.tb7_2(71):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(71),-1)));
CCCCR_3051_1_.tb7_3(71):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(71):=CCCCR_3051_1_.tb5_0(71);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (71)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(71),
CCCCR_3051_1_.tb7_1(71),
CCCCR_3051_1_.tb7_2(71),
CCCCR_3051_1_.tb7_3(71),
CCCCR_3051_1_.tb7_4(71),
'N'
,
'Y'
,
0,
'N'
,
'Tipo de Identificación'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(4):=356;
CCCCR_3051_1_.tb9_0(4):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(4):=CCCCR_3051_1_.tb9_0(4);
CCCCR_3051_1_.tb9_1(4):=CCCCR_3051_1_.tb5_0(71);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (4)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(4),
CCCCR_3051_1_.tb9_1(4),
1,
'GE_SUBS_REFEREN_DATA.IDENT_TYPE_ID=NULL'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(40):=6668;
CCCCR_3051_1_.tb10_0(40):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(40):=CCCCR_3051_1_.tb10_0(40);
CCCCR_3051_1_.tb10_1(40):=CCCCR_3051_1_.tb9_0(4);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (40)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(40),
CCCCR_3051_1_.tb10_1(40),
'N'
,
'GE_SUBS_REFEREN_DATA.NAME_'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(41):=6669;
CCCCR_3051_1_.tb10_0(41):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(41):=CCCCR_3051_1_.tb10_0(41);
CCCCR_3051_1_.tb10_1(41):=CCCCR_3051_1_.tb9_0(4);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (41)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(41),
CCCCR_3051_1_.tb10_1(41),
'N'
,
'GE_SUBS_REFEREN_DATA.LAST_NAME'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(42):=6670;
CCCCR_3051_1_.tb10_0(42):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(42):=CCCCR_3051_1_.tb10_0(42);
CCCCR_3051_1_.tb10_1(42):=CCCCR_3051_1_.tb9_0(4);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (42)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(42),
CCCCR_3051_1_.tb10_1(42),
'Y'
,
'GE_SUBS_REFEREN_DATA.NAME_'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(43):=6671;
CCCCR_3051_1_.tb10_0(43):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(43):=CCCCR_3051_1_.tb10_0(43);
CCCCR_3051_1_.tb10_1(43):=CCCCR_3051_1_.tb9_0(4);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (43)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(43),
CCCCR_3051_1_.tb10_1(43),
'Y'
,
'GE_SUBS_REFEREN_DATA.LAST_NAME'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(44):=6672;
CCCCR_3051_1_.tb10_0(44):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(44):=CCCCR_3051_1_.tb10_0(44);
CCCCR_3051_1_.tb10_1(44):=CCCCR_3051_1_.tb9_0(4);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (44)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(44),
CCCCR_3051_1_.tb10_1(44),
'Y'
,
'GE_SUBS_REFEREN_DATA.IDENTIFICATION'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(45):=6673;
CCCCR_3051_1_.tb10_0(45):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(45):=CCCCR_3051_1_.tb10_0(45);
CCCCR_3051_1_.tb10_1(45):=CCCCR_3051_1_.tb9_0(4);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (45)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(45),
CCCCR_3051_1_.tb10_1(45),
'N'
,
'GE_SUBS_REFEREN_DATA.IDENTIFICATION'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(38):=121403968;
CCCCR_3051_1_.tb0_0(38):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(38):=CCCCR_3051_1_.tb0_0(38);
CCCCR_3051_1_.old_tb0_1(38):='GEGE_EXERULVAL_CT69E121403968'
;
CCCCR_3051_1_.tb0_1(38):=CCCCR_3051_1_.tb0_0(38);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (38)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(38),
CCCCR_3051_1_.tb0_1(38),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuIdentificacion = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nunuIdentificacion <> NULL,if (nuIdentificacion < 0 || UT_STRING.FNULENGTH(nuIdentificacion) > 15,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de identificación debe ser positivo y menor o igual a 15 digitos");,);,)'
,
'OPEN'
,
to_date('29-11-2012 08:01:51','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:52','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Identificacion de la Referencia - Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(72):=1150043;
CCCCR_3051_1_.tb5_0(72):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(72):=CCCCR_3051_1_.tb5_0(72);
CCCCR_3051_1_.old_tb5_1(72):=9721;
CCCCR_3051_1_.tb5_1(72):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(72),-1)));
CCCCR_3051_1_.old_tb5_2(72):=20311;
CCCCR_3051_1_.tb5_2(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(72),-1)));
CCCCR_3051_1_.old_tb5_3(72):=-1;
CCCCR_3051_1_.tb5_3(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(72),-1)));
CCCCR_3051_1_.old_tb5_4(72):=-1;
CCCCR_3051_1_.tb5_4(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(72),-1)));
CCCCR_3051_1_.tb5_5(72):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_9(72):=CCCCR_3051_1_.tb0_0(38);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (72)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(72),
CCCCR_3051_1_.tb5_1(72),
CCCCR_3051_1_.tb5_2(72),
CCCCR_3051_1_.tb5_3(72),
CCCCR_3051_1_.tb5_4(72),
CCCCR_3051_1_.tb5_5(72),
null,
null,
null,
CCCCR_3051_1_.tb5_9(72),
600,
1,
'Identificación'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(72):=1602701;
CCCCR_3051_1_.tb7_0(72):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(72):=CCCCR_3051_1_.tb7_0(72);
CCCCR_3051_1_.old_tb7_1(72):=20311;
CCCCR_3051_1_.tb7_1(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(72),-1)));
CCCCR_3051_1_.old_tb7_2(72):=-1;
CCCCR_3051_1_.tb7_2(72):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(72),-1)));
CCCCR_3051_1_.tb7_3(72):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(72):=CCCCR_3051_1_.tb5_0(72);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (72)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(72),
CCCCR_3051_1_.tb7_1(72),
CCCCR_3051_1_.tb7_2(72),
CCCCR_3051_1_.tb7_3(72),
CCCCR_3051_1_.tb7_4(72),
'N'
,
'Y'
,
1,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(39):=121403969;
CCCCR_3051_1_.tb0_0(39):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(39):=CCCCR_3051_1_.tb0_0(39);
CCCCR_3051_1_.old_tb0_1(39):='GEGE_EXERULVAL_CT69E121403969'
;
CCCCR_3051_1_.tb0_1(39):=CCCCR_3051_1_.tb0_0(39);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (39)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(39),
CCCCR_3051_1_.tb0_1(39),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,)'
,
'OPEN'
,
to_date('29-11-2012 08:05:26','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:52','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:52','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(73):=1150044;
CCCCR_3051_1_.tb5_0(73):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(73):=CCCCR_3051_1_.tb5_0(73);
CCCCR_3051_1_.old_tb5_1(73):=9721;
CCCCR_3051_1_.tb5_1(73):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(73),-1)));
CCCCR_3051_1_.old_tb5_2(73):=20315;
CCCCR_3051_1_.tb5_2(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(73),-1)));
CCCCR_3051_1_.old_tb5_3(73):=-1;
CCCCR_3051_1_.tb5_3(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(73),-1)));
CCCCR_3051_1_.old_tb5_4(73):=-1;
CCCCR_3051_1_.tb5_4(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(73),-1)));
CCCCR_3051_1_.tb5_5(73):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_9(73):=CCCCR_3051_1_.tb0_0(39);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (73)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(73),
CCCCR_3051_1_.tb5_1(73),
CCCCR_3051_1_.tb5_2(73),
CCCCR_3051_1_.tb5_3(73),
CCCCR_3051_1_.tb5_4(73),
CCCCR_3051_1_.tb5_5(73),
null,
null,
null,
CCCCR_3051_1_.tb5_9(73),
600,
2,
'Nombre'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(73):=1602702;
CCCCR_3051_1_.tb7_0(73):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(73):=CCCCR_3051_1_.tb7_0(73);
CCCCR_3051_1_.old_tb7_1(73):=20315;
CCCCR_3051_1_.tb7_1(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(73),-1)));
CCCCR_3051_1_.old_tb7_2(73):=-1;
CCCCR_3051_1_.tb7_2(73):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(73),-1)));
CCCCR_3051_1_.tb7_3(73):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(73):=CCCCR_3051_1_.tb5_0(73);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (73)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(73),
CCCCR_3051_1_.tb7_1(73),
CCCCR_3051_1_.tb7_2(73),
CCCCR_3051_1_.tb7_3(73),
CCCCR_3051_1_.tb7_4(73),
'Y'
,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(40):=121403970;
CCCCR_3051_1_.tb0_0(40):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(40):=CCCCR_3051_1_.tb0_0(40);
CCCCR_3051_1_.old_tb0_1(40):='GEGE_EXERULVAL_CT69E121403970'
;
CCCCR_3051_1_.tb0_1(40):=CCCCR_3051_1_.tb0_0(40);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (40)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(40),
CCCCR_3051_1_.tb0_1(40),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,)'
,
'OPEN'
,
to_date('29-11-2012 08:06:38','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(74):=1150045;
CCCCR_3051_1_.tb5_0(74):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(74):=CCCCR_3051_1_.tb5_0(74);
CCCCR_3051_1_.old_tb5_1(74):=9721;
CCCCR_3051_1_.tb5_1(74):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(74),-1)));
CCCCR_3051_1_.old_tb5_2(74):=20313;
CCCCR_3051_1_.tb5_2(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(74),-1)));
CCCCR_3051_1_.old_tb5_3(74):=-1;
CCCCR_3051_1_.tb5_3(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(74),-1)));
CCCCR_3051_1_.old_tb5_4(74):=-1;
CCCCR_3051_1_.tb5_4(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(74),-1)));
CCCCR_3051_1_.tb5_5(74):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_9(74):=CCCCR_3051_1_.tb0_0(40);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (74)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(74),
CCCCR_3051_1_.tb5_1(74),
CCCCR_3051_1_.tb5_2(74),
CCCCR_3051_1_.tb5_3(74),
CCCCR_3051_1_.tb5_4(74),
CCCCR_3051_1_.tb5_5(74),
null,
null,
null,
CCCCR_3051_1_.tb5_9(74),
600,
3,
'Apellido'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(74):=1602703;
CCCCR_3051_1_.tb7_0(74):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(74):=CCCCR_3051_1_.tb7_0(74);
CCCCR_3051_1_.old_tb7_1(74):=20313;
CCCCR_3051_1_.tb7_1(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(74),-1)));
CCCCR_3051_1_.old_tb7_2(74):=-1;
CCCCR_3051_1_.tb7_2(74):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(74),-1)));
CCCCR_3051_1_.tb7_3(74):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(74):=CCCCR_3051_1_.tb5_0(74);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (74)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(74),
CCCCR_3051_1_.tb7_1(74),
CCCCR_3051_1_.tb7_2(74),
CCCCR_3051_1_.tb7_3(74),
CCCCR_3051_1_.tb7_4(74),
'Y'
,
'Y'
,
3,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(75):=1150046;
CCCCR_3051_1_.tb5_0(75):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(75):=CCCCR_3051_1_.tb5_0(75);
CCCCR_3051_1_.old_tb5_1(75):=9721;
CCCCR_3051_1_.tb5_1(75):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(75),-1)));
CCCCR_3051_1_.old_tb5_2(75):=20306;
CCCCR_3051_1_.tb5_2(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(75),-1)));
CCCCR_3051_1_.old_tb5_3(75):=-1;
CCCCR_3051_1_.tb5_3(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(75),-1)));
CCCCR_3051_1_.old_tb5_4(75):=-1;
CCCCR_3051_1_.tb5_4(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(75),-1)));
CCCCR_3051_1_.tb5_5(75):=CCCCR_3051_1_.tb2_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (75)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(75),
CCCCR_3051_1_.tb5_1(75),
CCCCR_3051_1_.tb5_2(75),
CCCCR_3051_1_.tb5_3(75),
CCCCR_3051_1_.tb5_4(75),
CCCCR_3051_1_.tb5_5(75),
null,
null,
null,
null,
600,
4,
'Dirección'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(75):=1602704;
CCCCR_3051_1_.tb7_0(75):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(75):=CCCCR_3051_1_.tb7_0(75);
CCCCR_3051_1_.old_tb7_1(75):=20306;
CCCCR_3051_1_.tb7_1(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(75),-1)));
CCCCR_3051_1_.old_tb7_2(75):=-1;
CCCCR_3051_1_.tb7_2(75):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(75),-1)));
CCCCR_3051_1_.tb7_3(75):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(75):=CCCCR_3051_1_.tb5_0(75);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (75)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(75),
CCCCR_3051_1_.tb7_1(75),
CCCCR_3051_1_.tb7_2(75),
CCCCR_3051_1_.tb7_3(75),
CCCCR_3051_1_.tb7_4(75),
'Y'
,
'Y'
,
4,
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
2,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(41):=121403971;
CCCCR_3051_1_.tb0_0(41):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(41):=CCCCR_3051_1_.tb0_0(41);
CCCCR_3051_1_.old_tb0_1(41):='GEGE_EXERULVAL_CT69E121403971'
;
CCCCR_3051_1_.tb0_1(41):=CCCCR_3051_1_.tb0_0(41);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (41)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(41),
CCCCR_3051_1_.tb0_1(41),
69,
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone = NULL,,if (UT_STRING.FNULENGTH(nuPhone) <> 7 || UT_STRING.FNULENGTH(nuPhone) <> 10,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono deber ser de 7 o 10 dígitos");,);)'
,
'OPEN'
,
to_date('29-11-2012 08:14:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida teléfonos de Contacto'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(76):=1150047;
CCCCR_3051_1_.tb5_0(76):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(76):=CCCCR_3051_1_.tb5_0(76);
CCCCR_3051_1_.old_tb5_1(76):=9721;
CCCCR_3051_1_.tb5_1(76):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(76),-1)));
CCCCR_3051_1_.old_tb5_2(76):=20317;
CCCCR_3051_1_.tb5_2(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(76),-1)));
CCCCR_3051_1_.old_tb5_3(76):=-1;
CCCCR_3051_1_.tb5_3(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(76),-1)));
CCCCR_3051_1_.old_tb5_4(76):=-1;
CCCCR_3051_1_.tb5_4(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(76),-1)));
CCCCR_3051_1_.tb5_5(76):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_9(76):=CCCCR_3051_1_.tb0_0(41);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (76)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(76),
CCCCR_3051_1_.tb5_1(76),
CCCCR_3051_1_.tb5_2(76),
CCCCR_3051_1_.tb5_3(76),
CCCCR_3051_1_.tb5_4(76),
CCCCR_3051_1_.tb5_5(76),
null,
null,
null,
CCCCR_3051_1_.tb5_9(76),
600,
5,
'Teléfono'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(76):=1602705;
CCCCR_3051_1_.tb7_0(76):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(76):=CCCCR_3051_1_.tb7_0(76);
CCCCR_3051_1_.old_tb7_1(76):=20317;
CCCCR_3051_1_.tb7_1(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(76),-1)));
CCCCR_3051_1_.old_tb7_2(76):=-1;
CCCCR_3051_1_.tb7_2(76):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(76),-1)));
CCCCR_3051_1_.tb7_3(76):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(76):=CCCCR_3051_1_.tb5_0(76);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (76)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(76),
CCCCR_3051_1_.tb7_1(76),
CCCCR_3051_1_.tb7_2(76),
CCCCR_3051_1_.tb7_3(76),
CCCCR_3051_1_.tb7_4(76),
'Y'
,
'Y'
,
5,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(77):=1150048;
CCCCR_3051_1_.tb5_0(77):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(77):=CCCCR_3051_1_.tb5_0(77);
CCCCR_3051_1_.old_tb5_1(77):=9721;
CCCCR_3051_1_.tb5_1(77):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(77),-1)));
CCCCR_3051_1_.old_tb5_2(77):=20320;
CCCCR_3051_1_.tb5_2(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(77),-1)));
CCCCR_3051_1_.old_tb5_3(77):=-1;
CCCCR_3051_1_.tb5_3(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(77),-1)));
CCCCR_3051_1_.old_tb5_4(77):=-1;
CCCCR_3051_1_.tb5_4(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(77),-1)));
CCCCR_3051_1_.tb5_5(77):=CCCCR_3051_1_.tb2_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (77)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(77),
CCCCR_3051_1_.tb5_1(77),
CCCCR_3051_1_.tb5_2(77),
CCCCR_3051_1_.tb5_3(77),
CCCCR_3051_1_.tb5_4(77),
CCCCR_3051_1_.tb5_5(77),
null,
null,
null,
null,
600,
7,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(77):=1602706;
CCCCR_3051_1_.tb7_0(77):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(77):=CCCCR_3051_1_.tb7_0(77);
CCCCR_3051_1_.old_tb7_1(77):=20320;
CCCCR_3051_1_.tb7_1(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(77),-1)));
CCCCR_3051_1_.old_tb7_2(77):=-1;
CCCCR_3051_1_.tb7_2(77):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(77),-1)));
CCCCR_3051_1_.tb7_3(77):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(77):=CCCCR_3051_1_.tb5_0(77);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (77)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(77),
CCCCR_3051_1_.tb7_1(77),
CCCCR_3051_1_.tb7_2(77),
CCCCR_3051_1_.tb7_3(77),
CCCCR_3051_1_.tb7_4(77),
'N'
,
'Y'
,
7,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(42):=121403972;
CCCCR_3051_1_.tb0_0(42):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(42):=CCCCR_3051_1_.tb0_0(42);
CCCCR_3051_1_.old_tb0_1(42):='GEGE_EXERULVAL_CT69E121403972'
;
CCCCR_3051_1_.tb0_1(42):=CCCCR_3051_1_.tb0_0(42);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (42)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(42),
CCCCR_3051_1_.tb0_1(42),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_SUBS_REFEREN_DATA", "SEQ_GE_SUBS_REFEREN_DATA"))'
,
'OPEN'
,
to_date('27-11-2012 10:22:43','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave primaria tabla GE_SUBS_REFEREN_DATA'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(78):=1150049;
CCCCR_3051_1_.tb5_0(78):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(78):=CCCCR_3051_1_.tb5_0(78);
CCCCR_3051_1_.old_tb5_1(78):=9721;
CCCCR_3051_1_.tb5_1(78):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(78),-1)));
CCCCR_3051_1_.old_tb5_2(78):=20321;
CCCCR_3051_1_.tb5_2(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(78),-1)));
CCCCR_3051_1_.old_tb5_3(78):=-1;
CCCCR_3051_1_.tb5_3(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(78),-1)));
CCCCR_3051_1_.old_tb5_4(78):=-1;
CCCCR_3051_1_.tb5_4(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(78),-1)));
CCCCR_3051_1_.tb5_5(78):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_8(78):=CCCCR_3051_1_.tb0_0(42);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (78)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(78),
CCCCR_3051_1_.tb5_1(78),
CCCCR_3051_1_.tb5_2(78),
CCCCR_3051_1_.tb5_3(78),
CCCCR_3051_1_.tb5_4(78),
CCCCR_3051_1_.tb5_5(78),
null,
null,
CCCCR_3051_1_.tb5_8(78),
null,
600,
8,
'Id'
,
'N'
,
'Y'
,
'Y'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(78):=1602707;
CCCCR_3051_1_.tb7_0(78):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(78):=CCCCR_3051_1_.tb7_0(78);
CCCCR_3051_1_.old_tb7_1(78):=20321;
CCCCR_3051_1_.tb7_1(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(78),-1)));
CCCCR_3051_1_.old_tb7_2(78):=-1;
CCCCR_3051_1_.tb7_2(78):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(78),-1)));
CCCCR_3051_1_.tb7_3(78):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(78):=CCCCR_3051_1_.tb5_0(78);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (78)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(78),
CCCCR_3051_1_.tb7_1(78),
CCCCR_3051_1_.tb7_2(78),
CCCCR_3051_1_.tb7_3(78),
CCCCR_3051_1_.tb7_4(78),
'N'
,
'Y'
,
8,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(43):=121403973;
CCCCR_3051_1_.tb0_0(43):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(43):=CCCCR_3051_1_.tb0_0(43);
CCCCR_3051_1_.old_tb0_1(43):='GEGE_EXERULVAL_CT69E121403973'
;
CCCCR_3051_1_.tb0_1(43):=CCCCR_3051_1_.tb0_0(43);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (43)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(43),
CCCCR_3051_1_.tb0_1(43),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(2)'
,
'OPEN'
,
to_date('27-11-2012 10:22:43','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Tipo de Referencia Comercial'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(79):=1150050;
CCCCR_3051_1_.tb5_0(79):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(79):=CCCCR_3051_1_.tb5_0(79);
CCCCR_3051_1_.old_tb5_1(79):=9721;
CCCCR_3051_1_.tb5_1(79):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(79),-1)));
CCCCR_3051_1_.old_tb5_2(79):=20318;
CCCCR_3051_1_.tb5_2(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(79),-1)));
CCCCR_3051_1_.old_tb5_3(79):=-1;
CCCCR_3051_1_.tb5_3(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(79),-1)));
CCCCR_3051_1_.old_tb5_4(79):=-1;
CCCCR_3051_1_.tb5_4(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(79),-1)));
CCCCR_3051_1_.tb5_5(79):=CCCCR_3051_1_.tb2_0(9);
CCCCR_3051_1_.tb5_8(79):=CCCCR_3051_1_.tb0_0(43);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (79)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(79),
CCCCR_3051_1_.tb5_1(79),
CCCCR_3051_1_.tb5_2(79),
CCCCR_3051_1_.tb5_3(79),
CCCCR_3051_1_.tb5_4(79),
CCCCR_3051_1_.tb5_5(79),
null,
null,
CCCCR_3051_1_.tb5_8(79),
null,
600,
9,
'Tipo de Referencia'
,
'N'
,
'Y'
,
'Y'
,
9,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(79):=1602708;
CCCCR_3051_1_.tb7_0(79):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(79):=CCCCR_3051_1_.tb7_0(79);
CCCCR_3051_1_.old_tb7_1(79):=20318;
CCCCR_3051_1_.tb7_1(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(79),-1)));
CCCCR_3051_1_.old_tb7_2(79):=-1;
CCCCR_3051_1_.tb7_2(79):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(79),-1)));
CCCCR_3051_1_.tb7_3(79):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(79):=CCCCR_3051_1_.tb5_0(79);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (79)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(79),
CCCCR_3051_1_.tb7_1(79),
CCCCR_3051_1_.tb7_2(79),
CCCCR_3051_1_.tb7_3(79),
CCCCR_3051_1_.tb7_4(79),
'N'
,
'Y'
,
9,
'Y'
,
'Tipo de Referencia'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(80):=1150051;
CCCCR_3051_1_.tb5_0(80):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(80):=CCCCR_3051_1_.tb5_0(80);
CCCCR_3051_1_.old_tb5_1(80):=9721;
CCCCR_3051_1_.tb5_1(80):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(80),-1)));
CCCCR_3051_1_.old_tb5_2(80):=20308;
CCCCR_3051_1_.tb5_2(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(80),-1)));
CCCCR_3051_1_.old_tb5_3(80):=-1;
CCCCR_3051_1_.tb5_3(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(80),-1)));
CCCCR_3051_1_.old_tb5_4(80):=-1;
CCCCR_3051_1_.tb5_4(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(80),-1)));
CCCCR_3051_1_.tb5_5(80):=CCCCR_3051_1_.tb2_0(9);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (80)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(80),
CCCCR_3051_1_.tb5_1(80),
CCCCR_3051_1_.tb5_2(80),
CCCCR_3051_1_.tb5_3(80),
CCCCR_3051_1_.tb5_4(80),
CCCCR_3051_1_.tb5_5(80),
null,
null,
null,
null,
600,
6,
'Observaciones'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(80):=1602709;
CCCCR_3051_1_.tb7_0(80):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(80):=CCCCR_3051_1_.tb7_0(80);
CCCCR_3051_1_.old_tb7_1(80):=20308;
CCCCR_3051_1_.tb7_1(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(80),-1)));
CCCCR_3051_1_.old_tb7_2(80):=-1;
CCCCR_3051_1_.tb7_2(80):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(80),-1)));
CCCCR_3051_1_.tb7_3(80):=CCCCR_3051_1_.tb6_0(8);
CCCCR_3051_1_.tb7_4(80):=CCCCR_3051_1_.tb5_0(80);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (80)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(80),
CCCCR_3051_1_.tb7_1(80),
CCCCR_3051_1_.tb7_2(80),
CCCCR_3051_1_.tb7_3(80),
CCCCR_3051_1_.tb7_4(80),
'Y'
,
'Y'
,
6,
'N'
,
'Observaciones'
,
'N'
,
'N'
,
'U'
,
null,
43,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(9):=CCCCR_3051_1_.tb2_0(10);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (9)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(9),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
'REFERENCE_TYPE_ID =4'
,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(20):=120197394;
CCCCR_3051_1_.tb8_0(20):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(20):=CCCCR_3051_1_.tb8_0(20);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (20)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(20),
16,
'Lista de Valores Tipo de Identificación'
,
'SELECT IDENT_TYPE_ID ID, DESCRIPTION DESCRIPTION FROM GE_IDENTIFICA_TYPE ORDER BY ID
'
,
'Lista de Valores Tipo de Identificación'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(81):=1150052;
CCCCR_3051_1_.tb5_0(81):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(81):=CCCCR_3051_1_.tb5_0(81);
CCCCR_3051_1_.old_tb5_1(81):=9721;
CCCCR_3051_1_.tb5_1(81):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(81),-1)));
CCCCR_3051_1_.old_tb5_2(81):=20312;
CCCCR_3051_1_.tb5_2(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(81),-1)));
CCCCR_3051_1_.old_tb5_3(81):=-1;
CCCCR_3051_1_.tb5_3(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(81),-1)));
CCCCR_3051_1_.old_tb5_4(81):=-1;
CCCCR_3051_1_.tb5_4(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(81),-1)));
CCCCR_3051_1_.tb5_5(81):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_7(81):=CCCCR_3051_1_.tb8_0(20);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (81)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(81),
CCCCR_3051_1_.tb5_1(81),
CCCCR_3051_1_.tb5_2(81),
CCCCR_3051_1_.tb5_3(81),
CCCCR_3051_1_.tb5_4(81),
CCCCR_3051_1_.tb5_5(81),
null,
CCCCR_3051_1_.tb5_7(81),
null,
null,
600,
0,
'Tipo de Identificación'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(9):=2474;
CCCCR_3051_1_.tb6_0(9):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(9):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb6_1(9):=CCCCR_3051_1_.tb2_0(10);
ut_trace.trace('insertando tabla: GI_FRAME fila (9)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(9),
CCCCR_3051_1_.tb6_1(9),
null,
null,
'INF_CCCCR_FRAME_1021682'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(81):=1602710;
CCCCR_3051_1_.tb7_0(81):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(81):=CCCCR_3051_1_.tb7_0(81);
CCCCR_3051_1_.old_tb7_1(81):=20312;
CCCCR_3051_1_.tb7_1(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(81),-1)));
CCCCR_3051_1_.old_tb7_2(81):=-1;
CCCCR_3051_1_.tb7_2(81):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(81),-1)));
CCCCR_3051_1_.tb7_3(81):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(81):=CCCCR_3051_1_.tb5_0(81);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (81)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(81),
CCCCR_3051_1_.tb7_1(81),
CCCCR_3051_1_.tb7_2(81),
CCCCR_3051_1_.tb7_3(81),
CCCCR_3051_1_.tb7_4(81),
'N'
,
'Y'
,
0,
'N'
,
'Tipo de Identificación'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(5):=357;
CCCCR_3051_1_.tb9_0(5):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(5):=CCCCR_3051_1_.tb9_0(5);
CCCCR_3051_1_.tb9_1(5):=CCCCR_3051_1_.tb5_0(81);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (5)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(5),
CCCCR_3051_1_.tb9_1(5),
1,
'GE_SUBS_REFEREN_DATA.IDENT_TYPE_ID=NULL'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(46):=6674;
CCCCR_3051_1_.tb10_0(46):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(46):=CCCCR_3051_1_.tb10_0(46);
CCCCR_3051_1_.tb10_1(46):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (46)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(46),
CCCCR_3051_1_.tb10_1(46),
'N'
,
'GE_SUBS_REFEREN_DATA.IDENTIFICATION'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(47):=6675;
CCCCR_3051_1_.tb10_0(47):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(47):=CCCCR_3051_1_.tb10_0(47);
CCCCR_3051_1_.tb10_1(47):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (47)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(47),
CCCCR_3051_1_.tb10_1(47),
'N'
,
'GE_SUBS_REFEREN_DATA.NAME_'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(48):=6676;
CCCCR_3051_1_.tb10_0(48):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(48):=CCCCR_3051_1_.tb10_0(48);
CCCCR_3051_1_.tb10_1(48):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (48)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(48),
CCCCR_3051_1_.tb10_1(48),
'N'
,
'GE_SUBS_REFEREN_DATA.LAST_NAME'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(49):=6677;
CCCCR_3051_1_.tb10_0(49):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(49):=CCCCR_3051_1_.tb10_0(49);
CCCCR_3051_1_.tb10_1(49):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (49)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(49),
CCCCR_3051_1_.tb10_1(49),
'N'
,
'GE_SUBS_REFEREN_DATA.ADDRESS_ID'
,
'REQUIRED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(50):=6678;
CCCCR_3051_1_.tb10_0(50):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(50):=CCCCR_3051_1_.tb10_0(50);
CCCCR_3051_1_.tb10_1(50):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (50)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(50),
CCCCR_3051_1_.tb10_1(50),
'Y'
,
'GE_SUBS_REFEREN_DATA.IDENTIFICATION'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(51):=6679;
CCCCR_3051_1_.tb10_0(51):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(51):=CCCCR_3051_1_.tb10_0(51);
CCCCR_3051_1_.tb10_1(51):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (51)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(51),
CCCCR_3051_1_.tb10_1(51),
'Y'
,
'GE_SUBS_REFEREN_DATA.NAME_'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(52):=6680;
CCCCR_3051_1_.tb10_0(52):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(52):=CCCCR_3051_1_.tb10_0(52);
CCCCR_3051_1_.tb10_1(52):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (52)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(52),
CCCCR_3051_1_.tb10_1(52),
'Y'
,
'GE_SUBS_REFEREN_DATA.LAST_NAME'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(53):=6681;
CCCCR_3051_1_.tb10_0(53):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(53):=CCCCR_3051_1_.tb10_0(53);
CCCCR_3051_1_.tb10_1(53):=CCCCR_3051_1_.tb9_0(5);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (53)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(53),
CCCCR_3051_1_.tb10_1(53),
'Y'
,
'GE_SUBS_REFEREN_DATA.ADDRESS_ID'
,
'REQUIRED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(44):=121403974;
CCCCR_3051_1_.tb0_0(44):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(44):=CCCCR_3051_1_.tb0_0(44);
CCCCR_3051_1_.old_tb0_1(44):='GEGE_EXERULVAL_CT69E121403974'
;
CCCCR_3051_1_.tb0_1(44):=CCCCR_3051_1_.tb0_0(44);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (44)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(44),
CCCCR_3051_1_.tb0_1(44),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuIdentificacion = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nunuIdentificacion <> NULL,if (nuIdentificacion < 0 || UT_STRING.FNULENGTH(nuIdentificacion) > 15,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de identificación debe ser positivo y menor o igual a 15 digitos");,);,)'
,
'OPEN'
,
to_date('27-11-2012 17:18:14','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Identificacion de la Referencia - Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(82):=1150053;
CCCCR_3051_1_.tb5_0(82):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(82):=CCCCR_3051_1_.tb5_0(82);
CCCCR_3051_1_.old_tb5_1(82):=9721;
CCCCR_3051_1_.tb5_1(82):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(82),-1)));
CCCCR_3051_1_.old_tb5_2(82):=20311;
CCCCR_3051_1_.tb5_2(82):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(82),-1)));
CCCCR_3051_1_.old_tb5_3(82):=-1;
CCCCR_3051_1_.tb5_3(82):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(82),-1)));
CCCCR_3051_1_.old_tb5_4(82):=-1;
CCCCR_3051_1_.tb5_4(82):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(82),-1)));
CCCCR_3051_1_.tb5_5(82):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_9(82):=CCCCR_3051_1_.tb0_0(44);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (82)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(82),
CCCCR_3051_1_.tb5_1(82),
CCCCR_3051_1_.tb5_2(82),
CCCCR_3051_1_.tb5_3(82),
CCCCR_3051_1_.tb5_4(82),
CCCCR_3051_1_.tb5_5(82),
null,
null,
null,
CCCCR_3051_1_.tb5_9(82),
600,
1,
'Identificación'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(82):=1602711;
CCCCR_3051_1_.tb7_0(82):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(82):=CCCCR_3051_1_.tb7_0(82);
CCCCR_3051_1_.old_tb7_1(82):=20311;
CCCCR_3051_1_.tb7_1(82):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(82),-1)));
CCCCR_3051_1_.old_tb7_2(82):=-1;
CCCCR_3051_1_.tb7_2(82):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(82),-1)));
CCCCR_3051_1_.tb7_3(82):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(82):=CCCCR_3051_1_.tb5_0(82);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (82)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(82),
CCCCR_3051_1_.tb7_1(82),
CCCCR_3051_1_.tb7_2(82),
CCCCR_3051_1_.tb7_3(82),
CCCCR_3051_1_.tb7_4(82),
'N'
,
'Y'
,
1,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(45):=121403975;
CCCCR_3051_1_.tb0_0(45):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(45):=CCCCR_3051_1_.tb0_0(45);
CCCCR_3051_1_.old_tb0_1(45):='GEGE_EXERULVAL_CT69E121403975'
;
CCCCR_3051_1_.tb0_1(45):=CCCCR_3051_1_.tb0_0(45);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (45)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(45),
CCCCR_3051_1_.tb0_1(45),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,)'
,
'OPEN'
,
to_date('28-11-2012 17:56:41','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(83):=1150054;
CCCCR_3051_1_.tb5_0(83):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(83):=CCCCR_3051_1_.tb5_0(83);
CCCCR_3051_1_.old_tb5_1(83):=9721;
CCCCR_3051_1_.tb5_1(83):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(83),-1)));
CCCCR_3051_1_.old_tb5_2(83):=20315;
CCCCR_3051_1_.tb5_2(83):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(83),-1)));
CCCCR_3051_1_.old_tb5_3(83):=-1;
CCCCR_3051_1_.tb5_3(83):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(83),-1)));
CCCCR_3051_1_.old_tb5_4(83):=-1;
CCCCR_3051_1_.tb5_4(83):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(83),-1)));
CCCCR_3051_1_.tb5_5(83):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_9(83):=CCCCR_3051_1_.tb0_0(45);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (83)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(83),
CCCCR_3051_1_.tb5_1(83),
CCCCR_3051_1_.tb5_2(83),
CCCCR_3051_1_.tb5_3(83),
CCCCR_3051_1_.tb5_4(83),
CCCCR_3051_1_.tb5_5(83),
null,
null,
null,
CCCCR_3051_1_.tb5_9(83),
600,
2,
'Nombre'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(83):=1602712;
CCCCR_3051_1_.tb7_0(83):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(83):=CCCCR_3051_1_.tb7_0(83);
CCCCR_3051_1_.old_tb7_1(83):=20315;
CCCCR_3051_1_.tb7_1(83):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(83),-1)));
CCCCR_3051_1_.old_tb7_2(83):=-1;
CCCCR_3051_1_.tb7_2(83):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(83),-1)));
CCCCR_3051_1_.tb7_3(83):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(83):=CCCCR_3051_1_.tb5_0(83);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (83)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(83),
CCCCR_3051_1_.tb7_1(83),
CCCCR_3051_1_.tb7_2(83),
CCCCR_3051_1_.tb7_3(83),
CCCCR_3051_1_.tb7_4(83),
'Y'
,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(46):=121403976;
CCCCR_3051_1_.tb0_0(46):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(46):=CCCCR_3051_1_.tb0_0(46);
CCCCR_3051_1_.old_tb0_1(46):='GEGE_EXERULVAL_CT69E121403976'
;
CCCCR_3051_1_.tb0_1(46):=CCCCR_3051_1_.tb0_0(46);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (46)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(46),
CCCCR_3051_1_.tb0_1(46),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,)'
,
'OPEN'
,
to_date('28-11-2012 17:58:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:54','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:54','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(84):=1150055;
CCCCR_3051_1_.tb5_0(84):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(84):=CCCCR_3051_1_.tb5_0(84);
CCCCR_3051_1_.old_tb5_1(84):=9721;
CCCCR_3051_1_.tb5_1(84):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(84),-1)));
CCCCR_3051_1_.old_tb5_2(84):=20313;
CCCCR_3051_1_.tb5_2(84):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(84),-1)));
CCCCR_3051_1_.old_tb5_3(84):=-1;
CCCCR_3051_1_.tb5_3(84):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(84),-1)));
CCCCR_3051_1_.old_tb5_4(84):=-1;
CCCCR_3051_1_.tb5_4(84):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(84),-1)));
CCCCR_3051_1_.tb5_5(84):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_9(84):=CCCCR_3051_1_.tb0_0(46);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (84)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(84),
CCCCR_3051_1_.tb5_1(84),
CCCCR_3051_1_.tb5_2(84),
CCCCR_3051_1_.tb5_3(84),
CCCCR_3051_1_.tb5_4(84),
CCCCR_3051_1_.tb5_5(84),
null,
null,
null,
CCCCR_3051_1_.tb5_9(84),
600,
3,
'Apellido'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(84):=1602713;
CCCCR_3051_1_.tb7_0(84):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(84):=CCCCR_3051_1_.tb7_0(84);
CCCCR_3051_1_.old_tb7_1(84):=20313;
CCCCR_3051_1_.tb7_1(84):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(84),-1)));
CCCCR_3051_1_.old_tb7_2(84):=-1;
CCCCR_3051_1_.tb7_2(84):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(84),-1)));
CCCCR_3051_1_.tb7_3(84):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(84):=CCCCR_3051_1_.tb5_0(84);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (84)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(84),
CCCCR_3051_1_.tb7_1(84),
CCCCR_3051_1_.tb7_2(84),
CCCCR_3051_1_.tb7_3(84),
CCCCR_3051_1_.tb7_4(84),
'Y'
,
'Y'
,
3,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(21):=120197395;
CCCCR_3051_1_.tb8_0(21):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(21):=CCCCR_3051_1_.tb8_0(21);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (21)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(21),
16,
'Lista de Valores Relaciones Familiares.'
,
'SELECT '|| chr(39) ||'CONYUGUE/COMPAÑERO(A)'|| chr(39) ||' ID, '|| chr(39) ||'CONYUGUE/COMPAÑERO(A)'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'PADRE/MADRE'|| chr(39) ||' ID, '|| chr(39) ||'PADRE/MADRE'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'HERMANO/HERMANA'|| chr(39) ||' ID, '|| chr(39) ||'HERMANO/HERMANA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'ABUELO/ABUELA'|| chr(39) ||' ID, '|| chr(39) ||'ABUELO/ABUELA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'TIO/TIA'|| chr(39) ||' ID, '|| chr(39) ||'TIO/TIA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'PRIMO/PRIMA'|| chr(39) ||' ID, '|| chr(39) ||'PRIMO/PRIMA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'SOBRINO/SOBRINA'|| chr(39) ||' ID, '|| chr(39) ||'SOBRINO/SOBRINA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'NIETO/NIETA'|| chr(39) ||' ID, '|| chr(39) ||'NIETO/NIETA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'OTRO'|| chr(39) ||' ID, '|| chr(39) ||'OTRO'|| chr(39) ||' DESCRIPTION FROM DUAL'
,
'Lista de Valores Relaciones Familiares.'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(85):=1150056;
CCCCR_3051_1_.tb5_0(85):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(85):=CCCCR_3051_1_.tb5_0(85);
CCCCR_3051_1_.old_tb5_1(85):=9721;
CCCCR_3051_1_.tb5_1(85):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(85),-1)));
CCCCR_3051_1_.old_tb5_2(85):=20319;
CCCCR_3051_1_.tb5_2(85):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(85),-1)));
CCCCR_3051_1_.old_tb5_3(85):=-1;
CCCCR_3051_1_.tb5_3(85):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(85),-1)));
CCCCR_3051_1_.old_tb5_4(85):=-1;
CCCCR_3051_1_.tb5_4(85):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(85),-1)));
CCCCR_3051_1_.tb5_5(85):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_7(85):=CCCCR_3051_1_.tb8_0(21);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (85)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(85),
CCCCR_3051_1_.tb5_1(85),
CCCCR_3051_1_.tb5_2(85),
CCCCR_3051_1_.tb5_3(85),
CCCCR_3051_1_.tb5_4(85),
CCCCR_3051_1_.tb5_5(85),
null,
CCCCR_3051_1_.tb5_7(85),
null,
null,
600,
4,
'Parentesco'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(85):=1602714;
CCCCR_3051_1_.tb7_0(85):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(85):=CCCCR_3051_1_.tb7_0(85);
CCCCR_3051_1_.old_tb7_1(85):=20319;
CCCCR_3051_1_.tb7_1(85):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(85),-1)));
CCCCR_3051_1_.old_tb7_2(85):=-1;
CCCCR_3051_1_.tb7_2(85):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(85),-1)));
CCCCR_3051_1_.tb7_3(85):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(85):=CCCCR_3051_1_.tb5_0(85);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (85)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(85),
CCCCR_3051_1_.tb7_1(85),
CCCCR_3051_1_.tb7_2(85),
CCCCR_3051_1_.tb7_3(85),
CCCCR_3051_1_.tb7_4(85),
'N'
,
'Y'
,
4,
'N'
,
'Parentesco'
,
'N'
,
'N'
,
'M'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(47):=121403977;
CCCCR_3051_1_.tb0_0(47):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(47):=CCCCR_3051_1_.tb0_0(47);
CCCCR_3051_1_.old_tb0_1(47):='GEGE_EXERULVAL_CT69E121403977'
;
CCCCR_3051_1_.tb0_1(47):=CCCCR_3051_1_.tb0_0(47);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (47)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(47),
CCCCR_3051_1_.tb0_1(47),
69,
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone = NULL,,if (UT_STRING.FNULENGTH(nuPhone) <> 7 '||chr(38)||''||chr(38)||' UT_STRING.FNULENGTH(nuPhone) <> 10,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono deber ser de 7 o 10 dígitos");,);)'
,
'OPEN'
,
to_date('28-11-2012 18:10:31','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:54','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:54','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida teléfonos de Contacto'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(86):=1150057;
CCCCR_3051_1_.tb5_0(86):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(86):=CCCCR_3051_1_.tb5_0(86);
CCCCR_3051_1_.old_tb5_1(86):=9721;
CCCCR_3051_1_.tb5_1(86):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(86),-1)));
CCCCR_3051_1_.old_tb5_2(86):=20317;
CCCCR_3051_1_.tb5_2(86):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(86),-1)));
CCCCR_3051_1_.old_tb5_3(86):=-1;
CCCCR_3051_1_.tb5_3(86):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(86),-1)));
CCCCR_3051_1_.old_tb5_4(86):=-1;
CCCCR_3051_1_.tb5_4(86):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(86),-1)));
CCCCR_3051_1_.tb5_5(86):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_9(86):=CCCCR_3051_1_.tb0_0(47);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (86)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(86),
CCCCR_3051_1_.tb5_1(86),
CCCCR_3051_1_.tb5_2(86),
CCCCR_3051_1_.tb5_3(86),
CCCCR_3051_1_.tb5_4(86),
CCCCR_3051_1_.tb5_5(86),
null,
null,
null,
CCCCR_3051_1_.tb5_9(86),
600,
5,
'Teléfono'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(86):=1602715;
CCCCR_3051_1_.tb7_0(86):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(86):=CCCCR_3051_1_.tb7_0(86);
CCCCR_3051_1_.old_tb7_1(86):=20317;
CCCCR_3051_1_.tb7_1(86):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(86),-1)));
CCCCR_3051_1_.old_tb7_2(86):=-1;
CCCCR_3051_1_.tb7_2(86):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(86),-1)));
CCCCR_3051_1_.tb7_3(86):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(86):=CCCCR_3051_1_.tb5_0(86);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (86)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(86),
CCCCR_3051_1_.tb7_1(86),
CCCCR_3051_1_.tb7_2(86),
CCCCR_3051_1_.tb7_3(86),
CCCCR_3051_1_.tb7_4(86),
'Y'
,
'Y'
,
5,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(87):=1150058;
CCCCR_3051_1_.tb5_0(87):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(87):=CCCCR_3051_1_.tb5_0(87);
CCCCR_3051_1_.old_tb5_1(87):=9721;
CCCCR_3051_1_.tb5_1(87):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(87),-1)));
CCCCR_3051_1_.old_tb5_2(87):=20306;
CCCCR_3051_1_.tb5_2(87):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(87),-1)));
CCCCR_3051_1_.old_tb5_3(87):=-1;
CCCCR_3051_1_.tb5_3(87):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(87),-1)));
CCCCR_3051_1_.old_tb5_4(87):=-1;
CCCCR_3051_1_.tb5_4(87):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(87),-1)));
CCCCR_3051_1_.tb5_5(87):=CCCCR_3051_1_.tb2_0(10);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (87)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(87),
CCCCR_3051_1_.tb5_1(87),
CCCCR_3051_1_.tb5_2(87),
CCCCR_3051_1_.tb5_3(87),
CCCCR_3051_1_.tb5_4(87),
CCCCR_3051_1_.tb5_5(87),
null,
null,
null,
null,
600,
6,
'Dirección'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(87):=1602716;
CCCCR_3051_1_.tb7_0(87):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(87):=CCCCR_3051_1_.tb7_0(87);
CCCCR_3051_1_.old_tb7_1(87):=20306;
CCCCR_3051_1_.tb7_1(87):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(87),-1)));
CCCCR_3051_1_.old_tb7_2(87):=-1;
CCCCR_3051_1_.tb7_2(87):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(87),-1)));
CCCCR_3051_1_.tb7_3(87):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(87):=CCCCR_3051_1_.tb5_0(87);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (87)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(87),
CCCCR_3051_1_.tb7_1(87),
CCCCR_3051_1_.tb7_2(87),
CCCCR_3051_1_.tb7_3(87),
CCCCR_3051_1_.tb7_4(87),
'Y'
,
'Y'
,
6,
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
2,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(22):=120197396;
CCCCR_3051_1_.tb8_0(22):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(22):=CCCCR_3051_1_.tb8_0(22);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (22)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(22),
16,
'Lista de Valores Actividades'
,
'SELECT ACTIVITY_ID ID, DESCRIPTION DESCRIPTION FROM GE_ACTIVITY ORDER BY ID
'
,
'Lista de Valores Actividades'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(88):=1150059;
CCCCR_3051_1_.tb5_0(88):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(88):=CCCCR_3051_1_.tb5_0(88);
CCCCR_3051_1_.old_tb5_1(88):=9721;
CCCCR_3051_1_.tb5_1(88):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(88),-1)));
CCCCR_3051_1_.old_tb5_2(88):=20305;
CCCCR_3051_1_.tb5_2(88):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(88),-1)));
CCCCR_3051_1_.old_tb5_3(88):=-1;
CCCCR_3051_1_.tb5_3(88):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(88),-1)));
CCCCR_3051_1_.old_tb5_4(88):=-1;
CCCCR_3051_1_.tb5_4(88):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(88),-1)));
CCCCR_3051_1_.tb5_5(88):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_7(88):=CCCCR_3051_1_.tb8_0(22);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (88)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(88),
CCCCR_3051_1_.tb5_1(88),
CCCCR_3051_1_.tb5_2(88),
CCCCR_3051_1_.tb5_3(88),
CCCCR_3051_1_.tb5_4(88),
CCCCR_3051_1_.tb5_5(88),
null,
CCCCR_3051_1_.tb5_7(88),
null,
null,
600,
7,
'Actividad'
,
'N'
,
'Y'
,
'N'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(88):=1602717;
CCCCR_3051_1_.tb7_0(88):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(88):=CCCCR_3051_1_.tb7_0(88);
CCCCR_3051_1_.old_tb7_1(88):=20305;
CCCCR_3051_1_.tb7_1(88):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(88),-1)));
CCCCR_3051_1_.old_tb7_2(88):=-1;
CCCCR_3051_1_.tb7_2(88):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(88),-1)));
CCCCR_3051_1_.tb7_3(88):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(88):=CCCCR_3051_1_.tb5_0(88);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (88)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(88),
CCCCR_3051_1_.tb7_1(88),
CCCCR_3051_1_.tb7_2(88),
CCCCR_3051_1_.tb7_3(88),
CCCCR_3051_1_.tb7_4(88),
'N'
,
'Y'
,
7,
'N'
,
'Actividad'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(89):=1150060;
CCCCR_3051_1_.tb5_0(89):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(89):=CCCCR_3051_1_.tb5_0(89);
CCCCR_3051_1_.old_tb5_1(89):=9721;
CCCCR_3051_1_.tb5_1(89):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(89),-1)));
CCCCR_3051_1_.old_tb5_2(89):=20308;
CCCCR_3051_1_.tb5_2(89):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(89),-1)));
CCCCR_3051_1_.old_tb5_3(89):=-1;
CCCCR_3051_1_.tb5_3(89):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(89),-1)));
CCCCR_3051_1_.old_tb5_4(89):=-1;
CCCCR_3051_1_.tb5_4(89):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(89),-1)));
CCCCR_3051_1_.tb5_5(89):=CCCCR_3051_1_.tb2_0(10);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (89)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(89),
CCCCR_3051_1_.tb5_1(89),
CCCCR_3051_1_.tb5_2(89),
CCCCR_3051_1_.tb5_3(89),
CCCCR_3051_1_.tb5_4(89),
CCCCR_3051_1_.tb5_5(89),
null,
null,
null,
null,
600,
8,
'Observaciones'
,
'N'
,
'Y'
,
'N'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(89):=1602718;
CCCCR_3051_1_.tb7_0(89):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(89):=CCCCR_3051_1_.tb7_0(89);
CCCCR_3051_1_.old_tb7_1(89):=20308;
CCCCR_3051_1_.tb7_1(89):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(89),-1)));
CCCCR_3051_1_.old_tb7_2(89):=-1;
CCCCR_3051_1_.tb7_2(89):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(89),-1)));
CCCCR_3051_1_.tb7_3(89):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(89):=CCCCR_3051_1_.tb5_0(89);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (89)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(89),
CCCCR_3051_1_.tb7_1(89),
CCCCR_3051_1_.tb7_2(89),
CCCCR_3051_1_.tb7_3(89),
CCCCR_3051_1_.tb7_4(89),
'Y'
,
'Y'
,
8,
'N'
,
'Observaciones'
,
'N'
,
'N'
,
'U'
,
null,
43,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(90):=1150061;
CCCCR_3051_1_.tb5_0(90):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(90):=CCCCR_3051_1_.tb5_0(90);
CCCCR_3051_1_.old_tb5_1(90):=9721;
CCCCR_3051_1_.tb5_1(90):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(90),-1)));
CCCCR_3051_1_.old_tb5_2(90):=20320;
CCCCR_3051_1_.tb5_2(90):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(90),-1)));
CCCCR_3051_1_.old_tb5_3(90):=-1;
CCCCR_3051_1_.tb5_3(90):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(90),-1)));
CCCCR_3051_1_.old_tb5_4(90):=-1;
CCCCR_3051_1_.tb5_4(90):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(90),-1)));
CCCCR_3051_1_.tb5_5(90):=CCCCR_3051_1_.tb2_0(10);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (90)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(90),
CCCCR_3051_1_.tb5_1(90),
CCCCR_3051_1_.tb5_2(90),
CCCCR_3051_1_.tb5_3(90),
CCCCR_3051_1_.tb5_4(90),
CCCCR_3051_1_.tb5_5(90),
null,
null,
null,
null,
600,
9,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
9,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(90):=1602719;
CCCCR_3051_1_.tb7_0(90):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(90):=CCCCR_3051_1_.tb7_0(90);
CCCCR_3051_1_.old_tb7_1(90):=20320;
CCCCR_3051_1_.tb7_1(90):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(90),-1)));
CCCCR_3051_1_.old_tb7_2(90):=-1;
CCCCR_3051_1_.tb7_2(90):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(90),-1)));
CCCCR_3051_1_.tb7_3(90):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(90):=CCCCR_3051_1_.tb5_0(90);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (90)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(90),
CCCCR_3051_1_.tb7_1(90),
CCCCR_3051_1_.tb7_2(90),
CCCCR_3051_1_.tb7_3(90),
CCCCR_3051_1_.tb7_4(90),
'N'
,
'Y'
,
9,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(48):=121403978;
CCCCR_3051_1_.tb0_0(48):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(48):=CCCCR_3051_1_.tb0_0(48);
CCCCR_3051_1_.old_tb0_1(48):='GEGE_EXERULVAL_CT69E121403978'
;
CCCCR_3051_1_.tb0_1(48):=CCCCR_3051_1_.tb0_0(48);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (48)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(48),
CCCCR_3051_1_.tb0_1(48),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_SUBS_REFEREN_DATA", "SEQ_GE_SUBS_REFEREN_DATA"))'
,
'OPEN'
,
to_date('27-11-2012 10:22:43','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:54','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:54','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave primaria tabla GE_SUBS_REFEREN_DATA'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(91):=1150062;
CCCCR_3051_1_.tb5_0(91):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(91):=CCCCR_3051_1_.tb5_0(91);
CCCCR_3051_1_.old_tb5_1(91):=9721;
CCCCR_3051_1_.tb5_1(91):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(91),-1)));
CCCCR_3051_1_.old_tb5_2(91):=20321;
CCCCR_3051_1_.tb5_2(91):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(91),-1)));
CCCCR_3051_1_.old_tb5_3(91):=-1;
CCCCR_3051_1_.tb5_3(91):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(91),-1)));
CCCCR_3051_1_.old_tb5_4(91):=-1;
CCCCR_3051_1_.tb5_4(91):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(91),-1)));
CCCCR_3051_1_.tb5_5(91):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_8(91):=CCCCR_3051_1_.tb0_0(48);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (91)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(91),
CCCCR_3051_1_.tb5_1(91),
CCCCR_3051_1_.tb5_2(91),
CCCCR_3051_1_.tb5_3(91),
CCCCR_3051_1_.tb5_4(91),
CCCCR_3051_1_.tb5_5(91),
null,
null,
CCCCR_3051_1_.tb5_8(91),
null,
600,
10,
'Id'
,
'N'
,
'Y'
,
'Y'
,
10,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(91):=1602720;
CCCCR_3051_1_.tb7_0(91):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(91):=CCCCR_3051_1_.tb7_0(91);
CCCCR_3051_1_.old_tb7_1(91):=20321;
CCCCR_3051_1_.tb7_1(91):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(91),-1)));
CCCCR_3051_1_.old_tb7_2(91):=-1;
CCCCR_3051_1_.tb7_2(91):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(91),-1)));
CCCCR_3051_1_.tb7_3(91):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(91):=CCCCR_3051_1_.tb5_0(91);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (91)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(91),
CCCCR_3051_1_.tb7_1(91),
CCCCR_3051_1_.tb7_2(91),
CCCCR_3051_1_.tb7_3(91),
CCCCR_3051_1_.tb7_4(91),
'N'
,
'Y'
,
10,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(49):=121403979;
CCCCR_3051_1_.tb0_0(49):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(49):=CCCCR_3051_1_.tb0_0(49);
CCCCR_3051_1_.old_tb0_1(49):='GEGE_EXERULVAL_CT69E121403979'
;
CCCCR_3051_1_.tb0_1(49):=CCCCR_3051_1_.tb0_0(49);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (49)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(49),
CCCCR_3051_1_.tb0_1(49),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(1)'
,
'OPEN'
,
to_date('27-11-2012 10:22:43','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Tipo de Referencia Familiar'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(92):=1150063;
CCCCR_3051_1_.tb5_0(92):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(92):=CCCCR_3051_1_.tb5_0(92);
CCCCR_3051_1_.old_tb5_1(92):=9721;
CCCCR_3051_1_.tb5_1(92):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(92),-1)));
CCCCR_3051_1_.old_tb5_2(92):=20318;
CCCCR_3051_1_.tb5_2(92):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(92),-1)));
CCCCR_3051_1_.old_tb5_3(92):=-1;
CCCCR_3051_1_.tb5_3(92):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(92),-1)));
CCCCR_3051_1_.old_tb5_4(92):=-1;
CCCCR_3051_1_.tb5_4(92):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(92),-1)));
CCCCR_3051_1_.tb5_5(92):=CCCCR_3051_1_.tb2_0(10);
CCCCR_3051_1_.tb5_8(92):=CCCCR_3051_1_.tb0_0(49);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (92)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(92),
CCCCR_3051_1_.tb5_1(92),
CCCCR_3051_1_.tb5_2(92),
CCCCR_3051_1_.tb5_3(92),
CCCCR_3051_1_.tb5_4(92),
CCCCR_3051_1_.tb5_5(92),
null,
null,
CCCCR_3051_1_.tb5_8(92),
null,
600,
11,
'Tipo de Referencia'
,
'N'
,
'Y'
,
'Y'
,
11,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(92):=1602721;
CCCCR_3051_1_.tb7_0(92):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(92):=CCCCR_3051_1_.tb7_0(92);
CCCCR_3051_1_.old_tb7_1(92):=20318;
CCCCR_3051_1_.tb7_1(92):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(92),-1)));
CCCCR_3051_1_.old_tb7_2(92):=-1;
CCCCR_3051_1_.tb7_2(92):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(92),-1)));
CCCCR_3051_1_.tb7_3(92):=CCCCR_3051_1_.tb6_0(9);
CCCCR_3051_1_.tb7_4(92):=CCCCR_3051_1_.tb5_0(92);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (92)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(92),
CCCCR_3051_1_.tb7_1(92),
CCCCR_3051_1_.tb7_2(92),
CCCCR_3051_1_.tb7_3(92),
CCCCR_3051_1_.tb7_4(92),
'N'
,
'Y'
,
11,
'Y'
,
'Tipo de Referencia'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(10):=CCCCR_3051_1_.tb2_0(11);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (10)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(10),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
'REFERENCE_TYPE_ID =1'
,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(23):=120197397;
CCCCR_3051_1_.tb8_0(23):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(23):=CCCCR_3051_1_.tb8_0(23);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (23)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(23),
16,
'Lista de Valores Tipo de Identificación'
,
'SELECT IDENT_TYPE_ID ID, DESCRIPTION DESCRIPTION FROM GE_IDENTIFICA_TYPE ORDER BY ID
'
,
'Lista de Valores Tipo de Identificación'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(93):=1150064;
CCCCR_3051_1_.tb5_0(93):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(93):=CCCCR_3051_1_.tb5_0(93);
CCCCR_3051_1_.old_tb5_1(93):=9721;
CCCCR_3051_1_.tb5_1(93):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(93),-1)));
CCCCR_3051_1_.old_tb5_2(93):=20312;
CCCCR_3051_1_.tb5_2(93):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(93),-1)));
CCCCR_3051_1_.old_tb5_3(93):=-1;
CCCCR_3051_1_.tb5_3(93):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(93),-1)));
CCCCR_3051_1_.old_tb5_4(93):=-1;
CCCCR_3051_1_.tb5_4(93):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(93),-1)));
CCCCR_3051_1_.tb5_5(93):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_7(93):=CCCCR_3051_1_.tb8_0(23);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (93)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(93),
CCCCR_3051_1_.tb5_1(93),
CCCCR_3051_1_.tb5_2(93),
CCCCR_3051_1_.tb5_3(93),
CCCCR_3051_1_.tb5_4(93),
CCCCR_3051_1_.tb5_5(93),
null,
CCCCR_3051_1_.tb5_7(93),
null,
null,
600,
0,
'Tipo de Identificación'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(10):=2475;
CCCCR_3051_1_.tb6_0(10):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(10):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb6_1(10):=CCCCR_3051_1_.tb2_0(11);
ut_trace.trace('insertando tabla: GI_FRAME fila (10)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(10),
CCCCR_3051_1_.tb6_1(10),
null,
null,
'INF_CCCCR_FRAME_1029143'
,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(93):=1602722;
CCCCR_3051_1_.tb7_0(93):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(93):=CCCCR_3051_1_.tb7_0(93);
CCCCR_3051_1_.old_tb7_1(93):=20312;
CCCCR_3051_1_.tb7_1(93):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(93),-1)));
CCCCR_3051_1_.old_tb7_2(93):=-1;
CCCCR_3051_1_.tb7_2(93):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(93),-1)));
CCCCR_3051_1_.tb7_3(93):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(93):=CCCCR_3051_1_.tb5_0(93);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (93)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(93),
CCCCR_3051_1_.tb7_1(93),
CCCCR_3051_1_.tb7_2(93),
CCCCR_3051_1_.tb7_3(93),
CCCCR_3051_1_.tb7_4(93),
'N'
,
'Y'
,
0,
'N'
,
'Tipo de Identificación'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(50):=121403980;
CCCCR_3051_1_.tb0_0(50):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(50):=CCCCR_3051_1_.tb0_0(50);
CCCCR_3051_1_.old_tb0_1(50):='GEGE_EXERULVAL_CT69E121403980'
;
CCCCR_3051_1_.tb0_1(50):=CCCCR_3051_1_.tb0_0(50);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (50)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(50),
CCCCR_3051_1_.tb0_1(50),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,)'
,
'ALVZAPATA'
,
to_date('10-09-2013 09:56:25','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(94):=1150065;
CCCCR_3051_1_.tb5_0(94):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(94):=CCCCR_3051_1_.tb5_0(94);
CCCCR_3051_1_.old_tb5_1(94):=9721;
CCCCR_3051_1_.tb5_1(94):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(94),-1)));
CCCCR_3051_1_.old_tb5_2(94):=20313;
CCCCR_3051_1_.tb5_2(94):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(94),-1)));
CCCCR_3051_1_.old_tb5_3(94):=-1;
CCCCR_3051_1_.tb5_3(94):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(94),-1)));
CCCCR_3051_1_.old_tb5_4(94):=-1;
CCCCR_3051_1_.tb5_4(94):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(94),-1)));
CCCCR_3051_1_.tb5_5(94):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_9(94):=CCCCR_3051_1_.tb0_0(50);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (94)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(94),
CCCCR_3051_1_.tb5_1(94),
CCCCR_3051_1_.tb5_2(94),
CCCCR_3051_1_.tb5_3(94),
CCCCR_3051_1_.tb5_4(94),
CCCCR_3051_1_.tb5_5(94),
null,
null,
null,
CCCCR_3051_1_.tb5_9(94),
600,
3,
'Apellido'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(94):=1602723;
CCCCR_3051_1_.tb7_0(94):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(94):=CCCCR_3051_1_.tb7_0(94);
CCCCR_3051_1_.old_tb7_1(94):=20313;
CCCCR_3051_1_.tb7_1(94):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(94),-1)));
CCCCR_3051_1_.old_tb7_2(94):=-1;
CCCCR_3051_1_.tb7_2(94):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(94),-1)));
CCCCR_3051_1_.tb7_3(94):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(94):=CCCCR_3051_1_.tb5_0(94);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (94)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(94),
CCCCR_3051_1_.tb7_1(94),
CCCCR_3051_1_.tb7_2(94),
CCCCR_3051_1_.tb7_3(94),
CCCCR_3051_1_.tb7_4(94),
'Y'
,
'Y'
,
3,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(24):=120197398;
CCCCR_3051_1_.tb8_0(24):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(24):=CCCCR_3051_1_.tb8_0(24);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (24)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(24),
16,
'Lista de Valores Relaciones Familiares.'
,
'SELECT '|| chr(39) ||'CONYUGUE/COMPAÑERO(A)'|| chr(39) ||' ID, '|| chr(39) ||'CONYUGUE/COMPAÑERO(A)'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'PADRE/MADRE'|| chr(39) ||' ID, '|| chr(39) ||'PADRE/MADRE'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'HERMANO/HERMANA'|| chr(39) ||' ID, '|| chr(39) ||'HERMANO/HERMANA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'ABUELO/ABUELA'|| chr(39) ||' ID, '|| chr(39) ||'ABUELO/ABUELA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'TIO/TIA'|| chr(39) ||' ID, '|| chr(39) ||'TIO/TIA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'PRIMO/PRIMA'|| chr(39) ||' ID, '|| chr(39) ||'PRIMO/PRIMA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'SOBRINO/SOBRINA'|| chr(39) ||' ID, '|| chr(39) ||'SOBRINO/SOBRINA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'NIETO/NIETA'|| chr(39) ||' ID, '|| chr(39) ||'NIETO/NIETA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION ALL
SELECT '|| chr(39) ||'OTRO'|| chr(39) ||' ID, '|| chr(39) ||'OTRO'|| chr(39) ||' DESCRIPTION FROM DUAL'
,
'Lista de Valores Relaciones Familiares.'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(95):=1150066;
CCCCR_3051_1_.tb5_0(95):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(95):=CCCCR_3051_1_.tb5_0(95);
CCCCR_3051_1_.old_tb5_1(95):=9721;
CCCCR_3051_1_.tb5_1(95):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(95),-1)));
CCCCR_3051_1_.old_tb5_2(95):=20319;
CCCCR_3051_1_.tb5_2(95):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(95),-1)));
CCCCR_3051_1_.old_tb5_3(95):=-1;
CCCCR_3051_1_.tb5_3(95):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(95),-1)));
CCCCR_3051_1_.old_tb5_4(95):=-1;
CCCCR_3051_1_.tb5_4(95):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(95),-1)));
CCCCR_3051_1_.tb5_5(95):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_7(95):=CCCCR_3051_1_.tb8_0(24);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (95)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(95),
CCCCR_3051_1_.tb5_1(95),
CCCCR_3051_1_.tb5_2(95),
CCCCR_3051_1_.tb5_3(95),
CCCCR_3051_1_.tb5_4(95),
CCCCR_3051_1_.tb5_5(95),
null,
CCCCR_3051_1_.tb5_7(95),
null,
null,
600,
4,
'Parentesco'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(95):=1602724;
CCCCR_3051_1_.tb7_0(95):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(95):=CCCCR_3051_1_.tb7_0(95);
CCCCR_3051_1_.old_tb7_1(95):=20319;
CCCCR_3051_1_.tb7_1(95):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(95),-1)));
CCCCR_3051_1_.old_tb7_2(95):=-1;
CCCCR_3051_1_.tb7_2(95):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(95),-1)));
CCCCR_3051_1_.tb7_3(95):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(95):=CCCCR_3051_1_.tb5_0(95);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (95)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(95),
CCCCR_3051_1_.tb7_1(95),
CCCCR_3051_1_.tb7_2(95),
CCCCR_3051_1_.tb7_3(95),
CCCCR_3051_1_.tb7_4(95),
'Y'
,
'Y'
,
4,
'N'
,
'Parentesco'
,
'N'
,
'N'
,
'M'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(51):=121403981;
CCCCR_3051_1_.tb0_0(51):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(51):=CCCCR_3051_1_.tb0_0(51);
CCCCR_3051_1_.old_tb0_1(51):='GEGE_EXERULVAL_CT69E121403981'
;
CCCCR_3051_1_.tb0_1(51):=CCCCR_3051_1_.tb0_0(51);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (51)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(51),
CCCCR_3051_1_.tb0_1(51),
69,
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone = NULL,,if (UT_STRING.FNULENGTH(nuPhone) <> 7 '||chr(38)||''||chr(38)||' UT_STRING.FNULENGTH(nuPhone) <> 10,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono deber ser de 7 o 10 dígitos");,);)'
,
'ALVZAPATA'
,
to_date('10-09-2013 09:56:25','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida teléfonos de Contacto'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(96):=1150067;
CCCCR_3051_1_.tb5_0(96):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(96):=CCCCR_3051_1_.tb5_0(96);
CCCCR_3051_1_.old_tb5_1(96):=9721;
CCCCR_3051_1_.tb5_1(96):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(96),-1)));
CCCCR_3051_1_.old_tb5_2(96):=20317;
CCCCR_3051_1_.tb5_2(96):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(96),-1)));
CCCCR_3051_1_.old_tb5_3(96):=-1;
CCCCR_3051_1_.tb5_3(96):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(96),-1)));
CCCCR_3051_1_.old_tb5_4(96):=-1;
CCCCR_3051_1_.tb5_4(96):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(96),-1)));
CCCCR_3051_1_.tb5_5(96):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_9(96):=CCCCR_3051_1_.tb0_0(51);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (96)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(96),
CCCCR_3051_1_.tb5_1(96),
CCCCR_3051_1_.tb5_2(96),
CCCCR_3051_1_.tb5_3(96),
CCCCR_3051_1_.tb5_4(96),
CCCCR_3051_1_.tb5_5(96),
null,
null,
null,
CCCCR_3051_1_.tb5_9(96),
600,
5,
'Teléfono'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(96):=1602725;
CCCCR_3051_1_.tb7_0(96):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(96):=CCCCR_3051_1_.tb7_0(96);
CCCCR_3051_1_.old_tb7_1(96):=20317;
CCCCR_3051_1_.tb7_1(96):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(96),-1)));
CCCCR_3051_1_.old_tb7_2(96):=-1;
CCCCR_3051_1_.tb7_2(96):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(96),-1)));
CCCCR_3051_1_.tb7_3(96):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(96):=CCCCR_3051_1_.tb5_0(96);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (96)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(96),
CCCCR_3051_1_.tb7_1(96),
CCCCR_3051_1_.tb7_2(96),
CCCCR_3051_1_.tb7_3(96),
CCCCR_3051_1_.tb7_4(96),
'Y'
,
'Y'
,
5,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(97):=1150068;
CCCCR_3051_1_.tb5_0(97):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(97):=CCCCR_3051_1_.tb5_0(97);
CCCCR_3051_1_.old_tb5_1(97):=9721;
CCCCR_3051_1_.tb5_1(97):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(97),-1)));
CCCCR_3051_1_.old_tb5_2(97):=20306;
CCCCR_3051_1_.tb5_2(97):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(97),-1)));
CCCCR_3051_1_.old_tb5_3(97):=-1;
CCCCR_3051_1_.tb5_3(97):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(97),-1)));
CCCCR_3051_1_.old_tb5_4(97):=-1;
CCCCR_3051_1_.tb5_4(97):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(97),-1)));
CCCCR_3051_1_.tb5_5(97):=CCCCR_3051_1_.tb2_0(11);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (97)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(97),
CCCCR_3051_1_.tb5_1(97),
CCCCR_3051_1_.tb5_2(97),
CCCCR_3051_1_.tb5_3(97),
CCCCR_3051_1_.tb5_4(97),
CCCCR_3051_1_.tb5_5(97),
null,
null,
null,
null,
600,
6,
'Dirección'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(97):=1602726;
CCCCR_3051_1_.tb7_0(97):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(97):=CCCCR_3051_1_.tb7_0(97);
CCCCR_3051_1_.old_tb7_1(97):=20306;
CCCCR_3051_1_.tb7_1(97):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(97),-1)));
CCCCR_3051_1_.old_tb7_2(97):=-1;
CCCCR_3051_1_.tb7_2(97):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(97),-1)));
CCCCR_3051_1_.tb7_3(97):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(97):=CCCCR_3051_1_.tb5_0(97);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (97)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(97),
CCCCR_3051_1_.tb7_1(97),
CCCCR_3051_1_.tb7_2(97),
CCCCR_3051_1_.tb7_3(97),
CCCCR_3051_1_.tb7_4(97),
'Y'
,
'Y'
,
6,
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
2,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(25):=120197399;
CCCCR_3051_1_.tb8_0(25):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(25):=CCCCR_3051_1_.tb8_0(25);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (25)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(25),
16,
'Lista de Valores Actividades'
,
'SELECT ACTIVITY_ID ID, DESCRIPTION DESCRIPTION FROM GE_ACTIVITY ORDER BY ID
'
,
'Lista de Valores Actividades'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(98):=1150069;
CCCCR_3051_1_.tb5_0(98):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(98):=CCCCR_3051_1_.tb5_0(98);
CCCCR_3051_1_.old_tb5_1(98):=9721;
CCCCR_3051_1_.tb5_1(98):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(98),-1)));
CCCCR_3051_1_.old_tb5_2(98):=20305;
CCCCR_3051_1_.tb5_2(98):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(98),-1)));
CCCCR_3051_1_.old_tb5_3(98):=-1;
CCCCR_3051_1_.tb5_3(98):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(98),-1)));
CCCCR_3051_1_.old_tb5_4(98):=-1;
CCCCR_3051_1_.tb5_4(98):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(98),-1)));
CCCCR_3051_1_.tb5_5(98):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_7(98):=CCCCR_3051_1_.tb8_0(25);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (98)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(98),
CCCCR_3051_1_.tb5_1(98),
CCCCR_3051_1_.tb5_2(98),
CCCCR_3051_1_.tb5_3(98),
CCCCR_3051_1_.tb5_4(98),
CCCCR_3051_1_.tb5_5(98),
null,
CCCCR_3051_1_.tb5_7(98),
null,
null,
600,
7,
'Actividad'
,
'N'
,
'Y'
,
'N'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(98):=1602727;
CCCCR_3051_1_.tb7_0(98):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(98):=CCCCR_3051_1_.tb7_0(98);
CCCCR_3051_1_.old_tb7_1(98):=20305;
CCCCR_3051_1_.tb7_1(98):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(98),-1)));
CCCCR_3051_1_.old_tb7_2(98):=-1;
CCCCR_3051_1_.tb7_2(98):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(98),-1)));
CCCCR_3051_1_.tb7_3(98):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(98):=CCCCR_3051_1_.tb5_0(98);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (98)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(98),
CCCCR_3051_1_.tb7_1(98),
CCCCR_3051_1_.tb7_2(98),
CCCCR_3051_1_.tb7_3(98),
CCCCR_3051_1_.tb7_4(98),
'N'
,
'Y'
,
7,
'N'
,
'Actividad'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(99):=1150070;
CCCCR_3051_1_.tb5_0(99):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(99):=CCCCR_3051_1_.tb5_0(99);
CCCCR_3051_1_.old_tb5_1(99):=9721;
CCCCR_3051_1_.tb5_1(99):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(99),-1)));
CCCCR_3051_1_.old_tb5_2(99):=20308;
CCCCR_3051_1_.tb5_2(99):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(99),-1)));
CCCCR_3051_1_.old_tb5_3(99):=-1;
CCCCR_3051_1_.tb5_3(99):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(99),-1)));
CCCCR_3051_1_.old_tb5_4(99):=-1;
CCCCR_3051_1_.tb5_4(99):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(99),-1)));
CCCCR_3051_1_.tb5_5(99):=CCCCR_3051_1_.tb2_0(11);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (99)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(99),
CCCCR_3051_1_.tb5_1(99),
CCCCR_3051_1_.tb5_2(99),
CCCCR_3051_1_.tb5_3(99),
CCCCR_3051_1_.tb5_4(99),
CCCCR_3051_1_.tb5_5(99),
null,
null,
null,
null,
600,
8,
'Observaciones'
,
'N'
,
'Y'
,
'N'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(99):=1602728;
CCCCR_3051_1_.tb7_0(99):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(99):=CCCCR_3051_1_.tb7_0(99);
CCCCR_3051_1_.old_tb7_1(99):=20308;
CCCCR_3051_1_.tb7_1(99):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(99),-1)));
CCCCR_3051_1_.old_tb7_2(99):=-1;
CCCCR_3051_1_.tb7_2(99):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(99),-1)));
CCCCR_3051_1_.tb7_3(99):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(99):=CCCCR_3051_1_.tb5_0(99);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (99)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(99),
CCCCR_3051_1_.tb7_1(99),
CCCCR_3051_1_.tb7_2(99),
CCCCR_3051_1_.tb7_3(99),
CCCCR_3051_1_.tb7_4(99),
'Y'
,
'Y'
,
8,
'N'
,
'Observaciones'
,
'N'
,
'N'
,
'U'
,
null,
43,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(52):=121403982;
CCCCR_3051_1_.tb0_0(52):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(52):=CCCCR_3051_1_.tb0_0(52);
CCCCR_3051_1_.old_tb0_1(52):='GEGE_EXERULVAL_CT69E121403982'
;
CCCCR_3051_1_.tb0_1(52):=CCCCR_3051_1_.tb0_0(52);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (52)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(52),
CCCCR_3051_1_.tb0_1(52),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_SUBS_REFEREN_DATA", "SEQ_GE_SUBS_REFEREN_DATA"))'
,
'ALVZAPATA'
,
to_date('10-09-2013 09:56:26','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave primaria tabla GE_SUBS_REFEREN_DATA'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(100):=1150071;
CCCCR_3051_1_.tb5_0(100):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(100):=CCCCR_3051_1_.tb5_0(100);
CCCCR_3051_1_.old_tb5_1(100):=9721;
CCCCR_3051_1_.tb5_1(100):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(100),-1)));
CCCCR_3051_1_.old_tb5_2(100):=20321;
CCCCR_3051_1_.tb5_2(100):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(100),-1)));
CCCCR_3051_1_.old_tb5_3(100):=-1;
CCCCR_3051_1_.tb5_3(100):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(100),-1)));
CCCCR_3051_1_.old_tb5_4(100):=-1;
CCCCR_3051_1_.tb5_4(100):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(100),-1)));
CCCCR_3051_1_.tb5_5(100):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_8(100):=CCCCR_3051_1_.tb0_0(52);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (100)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(100),
CCCCR_3051_1_.tb5_1(100),
CCCCR_3051_1_.tb5_2(100),
CCCCR_3051_1_.tb5_3(100),
CCCCR_3051_1_.tb5_4(100),
CCCCR_3051_1_.tb5_5(100),
null,
null,
CCCCR_3051_1_.tb5_8(100),
null,
600,
10,
'Id'
,
'N'
,
'Y'
,
'Y'
,
10,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(100):=1602729;
CCCCR_3051_1_.tb7_0(100):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(100):=CCCCR_3051_1_.tb7_0(100);
CCCCR_3051_1_.old_tb7_1(100):=20321;
CCCCR_3051_1_.tb7_1(100):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(100),-1)));
CCCCR_3051_1_.old_tb7_2(100):=-1;
CCCCR_3051_1_.tb7_2(100):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(100),-1)));
CCCCR_3051_1_.tb7_3(100):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(100):=CCCCR_3051_1_.tb5_0(100);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (100)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(100),
CCCCR_3051_1_.tb7_1(100),
CCCCR_3051_1_.tb7_2(100),
CCCCR_3051_1_.tb7_3(100),
CCCCR_3051_1_.tb7_4(100),
'N'
,
'Y'
,
10,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(53):=121403983;
CCCCR_3051_1_.tb0_0(53):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(53):=CCCCR_3051_1_.tb0_0(53);
CCCCR_3051_1_.old_tb0_1(53):='GEGE_EXERULVAL_CT69E121403983'
;
CCCCR_3051_1_.tb0_1(53):=CCCCR_3051_1_.tb0_0(53);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (53)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(53),
CCCCR_3051_1_.tb0_1(53),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(1)'
,
'ALVZAPATA'
,
to_date('10-09-2013 09:56:26','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa Tipo de Referencia Familiar'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(101):=1150072;
CCCCR_3051_1_.tb5_0(101):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(101):=CCCCR_3051_1_.tb5_0(101);
CCCCR_3051_1_.old_tb5_1(101):=9721;
CCCCR_3051_1_.tb5_1(101):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(101),-1)));
CCCCR_3051_1_.old_tb5_2(101):=20318;
CCCCR_3051_1_.tb5_2(101):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(101),-1)));
CCCCR_3051_1_.old_tb5_3(101):=-1;
CCCCR_3051_1_.tb5_3(101):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(101),-1)));
CCCCR_3051_1_.old_tb5_4(101):=-1;
CCCCR_3051_1_.tb5_4(101):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(101),-1)));
CCCCR_3051_1_.tb5_5(101):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_8(101):=CCCCR_3051_1_.tb0_0(53);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (101)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(101),
CCCCR_3051_1_.tb5_1(101),
CCCCR_3051_1_.tb5_2(101),
CCCCR_3051_1_.tb5_3(101),
CCCCR_3051_1_.tb5_4(101),
CCCCR_3051_1_.tb5_5(101),
null,
null,
CCCCR_3051_1_.tb5_8(101),
null,
600,
11,
'Tipo de Referencia'
,
'N'
,
'Y'
,
'Y'
,
11,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(101):=1602730;
CCCCR_3051_1_.tb7_0(101):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(101):=CCCCR_3051_1_.tb7_0(101);
CCCCR_3051_1_.old_tb7_1(101):=20318;
CCCCR_3051_1_.tb7_1(101):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(101),-1)));
CCCCR_3051_1_.old_tb7_2(101):=-1;
CCCCR_3051_1_.tb7_2(101):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(101),-1)));
CCCCR_3051_1_.tb7_3(101):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(101):=CCCCR_3051_1_.tb5_0(101);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (101)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(101),
CCCCR_3051_1_.tb7_1(101),
CCCCR_3051_1_.tb7_2(101),
CCCCR_3051_1_.tb7_3(101),
CCCCR_3051_1_.tb7_4(101),
'N'
,
'Y'
,
11,
'Y'
,
'Tipo de Referencia'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(54):=121403984;
CCCCR_3051_1_.tb0_0(54):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(54):=CCCCR_3051_1_.tb0_0(54);
CCCCR_3051_1_.old_tb0_1(54):='GEGE_EXERULVAL_CT69E121403984'
;
CCCCR_3051_1_.tb0_1(54):=CCCCR_3051_1_.tb0_0(54);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (54)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(54),
CCCCR_3051_1_.tb0_1(54),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuIdentificacion = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nunuIdentificacion <> NULL,if (nuIdentificacion < 0 || UT_STRING.FNULENGTH(nuIdentificacion) > 15,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de identificación debe ser positivo y menor o igual a 15 digitos");,);,)'
,
'ALVZAPATA'
,
to_date('10-09-2013 09:56:23','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Identificacion de la Referencia - Cedula'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(102):=1150073;
CCCCR_3051_1_.tb5_0(102):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(102):=CCCCR_3051_1_.tb5_0(102);
CCCCR_3051_1_.old_tb5_1(102):=9721;
CCCCR_3051_1_.tb5_1(102):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(102),-1)));
CCCCR_3051_1_.old_tb5_2(102):=20311;
CCCCR_3051_1_.tb5_2(102):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(102),-1)));
CCCCR_3051_1_.old_tb5_3(102):=-1;
CCCCR_3051_1_.tb5_3(102):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(102),-1)));
CCCCR_3051_1_.old_tb5_4(102):=-1;
CCCCR_3051_1_.tb5_4(102):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(102),-1)));
CCCCR_3051_1_.tb5_5(102):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_9(102):=CCCCR_3051_1_.tb0_0(54);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (102)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(102),
CCCCR_3051_1_.tb5_1(102),
CCCCR_3051_1_.tb5_2(102),
CCCCR_3051_1_.tb5_3(102),
CCCCR_3051_1_.tb5_4(102),
CCCCR_3051_1_.tb5_5(102),
null,
null,
null,
CCCCR_3051_1_.tb5_9(102),
600,
1,
'Identificación'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(102):=1602731;
CCCCR_3051_1_.tb7_0(102):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(102):=CCCCR_3051_1_.tb7_0(102);
CCCCR_3051_1_.old_tb7_1(102):=20311;
CCCCR_3051_1_.tb7_1(102):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(102),-1)));
CCCCR_3051_1_.old_tb7_2(102):=-1;
CCCCR_3051_1_.tb7_2(102):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(102),-1)));
CCCCR_3051_1_.tb7_3(102):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(102):=CCCCR_3051_1_.tb5_0(102);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (102)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(102),
CCCCR_3051_1_.tb7_1(102),
CCCCR_3051_1_.tb7_2(102),
CCCCR_3051_1_.tb7_3(102),
CCCCR_3051_1_.tb7_4(102),
'N'
,
'Y'
,
1,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(55):=121403985;
CCCCR_3051_1_.tb0_0(55):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(55):=CCCCR_3051_1_.tb0_0(55);
CCCCR_3051_1_.old_tb0_1(55):='GEGE_EXERULVAL_CT69E121403985'
;
CCCCR_3051_1_.tb0_1(55):=CCCCR_3051_1_.tb0_0(55);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (55)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(55),
CCCCR_3051_1_.tb0_1(55),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);if (sbValue <> NULL,nuValidacion = LDC_BOUTILITIES.FNUVALCARACTERESPECIAL(sbValue);if (nuValidacion = -1,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"La cadena tiene caracteres especiales o números");,);,)'
,
'ALVZAPATA'
,
to_date('10-09-2013 09:56:24','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida Caracteres Especiales Cadena'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(103):=1150074;
CCCCR_3051_1_.tb5_0(103):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(103):=CCCCR_3051_1_.tb5_0(103);
CCCCR_3051_1_.old_tb5_1(103):=9721;
CCCCR_3051_1_.tb5_1(103):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(103),-1)));
CCCCR_3051_1_.old_tb5_2(103):=20315;
CCCCR_3051_1_.tb5_2(103):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(103),-1)));
CCCCR_3051_1_.old_tb5_3(103):=-1;
CCCCR_3051_1_.tb5_3(103):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(103),-1)));
CCCCR_3051_1_.old_tb5_4(103):=-1;
CCCCR_3051_1_.tb5_4(103):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(103),-1)));
CCCCR_3051_1_.tb5_5(103):=CCCCR_3051_1_.tb2_0(11);
CCCCR_3051_1_.tb5_9(103):=CCCCR_3051_1_.tb0_0(55);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (103)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(103),
CCCCR_3051_1_.tb5_1(103),
CCCCR_3051_1_.tb5_2(103),
CCCCR_3051_1_.tb5_3(103),
CCCCR_3051_1_.tb5_4(103),
CCCCR_3051_1_.tb5_5(103),
null,
null,
null,
CCCCR_3051_1_.tb5_9(103),
600,
2,
'Nombre'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(103):=1602732;
CCCCR_3051_1_.tb7_0(103):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(103):=CCCCR_3051_1_.tb7_0(103);
CCCCR_3051_1_.old_tb7_1(103):=20315;
CCCCR_3051_1_.tb7_1(103):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(103),-1)));
CCCCR_3051_1_.old_tb7_2(103):=-1;
CCCCR_3051_1_.tb7_2(103):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(103),-1)));
CCCCR_3051_1_.tb7_3(103):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(103):=CCCCR_3051_1_.tb5_0(103);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (103)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(103),
CCCCR_3051_1_.tb7_1(103),
CCCCR_3051_1_.tb7_2(103),
CCCCR_3051_1_.tb7_3(103),
CCCCR_3051_1_.tb7_4(103),
'Y'
,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(104):=1150075;
CCCCR_3051_1_.tb5_0(104):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(104):=CCCCR_3051_1_.tb5_0(104);
CCCCR_3051_1_.old_tb5_1(104):=9721;
CCCCR_3051_1_.tb5_1(104):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(104),-1)));
CCCCR_3051_1_.old_tb5_2(104):=20320;
CCCCR_3051_1_.tb5_2(104):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(104),-1)));
CCCCR_3051_1_.old_tb5_3(104):=-1;
CCCCR_3051_1_.tb5_3(104):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(104),-1)));
CCCCR_3051_1_.old_tb5_4(104):=-1;
CCCCR_3051_1_.tb5_4(104):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(104),-1)));
CCCCR_3051_1_.tb5_5(104):=CCCCR_3051_1_.tb2_0(11);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (104)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(104),
CCCCR_3051_1_.tb5_1(104),
CCCCR_3051_1_.tb5_2(104),
CCCCR_3051_1_.tb5_3(104),
CCCCR_3051_1_.tb5_4(104),
CCCCR_3051_1_.tb5_5(104),
null,
null,
null,
null,
600,
9,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
9,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(104):=1602733;
CCCCR_3051_1_.tb7_0(104):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(104):=CCCCR_3051_1_.tb7_0(104);
CCCCR_3051_1_.old_tb7_1(104):=20320;
CCCCR_3051_1_.tb7_1(104):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(104),-1)));
CCCCR_3051_1_.old_tb7_2(104):=-1;
CCCCR_3051_1_.tb7_2(104):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(104),-1)));
CCCCR_3051_1_.tb7_3(104):=CCCCR_3051_1_.tb6_0(10);
CCCCR_3051_1_.tb7_4(104):=CCCCR_3051_1_.tb5_0(104);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (104)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(104),
CCCCR_3051_1_.tb7_1(104),
CCCCR_3051_1_.tb7_2(104),
CCCCR_3051_1_.tb7_3(104),
CCCCR_3051_1_.tb7_4(104),
'N'
,
'Y'
,
9,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(11):=CCCCR_3051_1_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (11)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(11),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(11):=2476;
CCCCR_3051_1_.tb6_0(11):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(11):=CCCCR_3051_1_.tb6_0(11);
CCCCR_3051_1_.tb6_1(11):=CCCCR_3051_1_.tb2_0(8);
ut_trace.trace('insertando tabla: GI_FRAME fila (11)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(11),
CCCCR_3051_1_.tb6_1(11),
null,
null,
'INF_CCCCR_TAB_1021680'
,
3);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(12):=CCCCR_3051_1_.tb2_0(13);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (12)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(12),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(105):=1150076;
CCCCR_3051_1_.tb5_0(105):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(105):=CCCCR_3051_1_.tb5_0(105);
CCCCR_3051_1_.old_tb5_1(105):=9723;
CCCCR_3051_1_.tb5_1(105):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(105),-1)));
CCCCR_3051_1_.old_tb5_2(105):=20330;
CCCCR_3051_1_.tb5_2(105):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(105),-1)));
CCCCR_3051_1_.old_tb5_3(105):=-1;
CCCCR_3051_1_.tb5_3(105):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(105),-1)));
CCCCR_3051_1_.old_tb5_4(105):=-1;
CCCCR_3051_1_.tb5_4(105):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(105),-1)));
CCCCR_3051_1_.tb5_5(105):=CCCCR_3051_1_.tb2_0(13);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (105)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(105),
CCCCR_3051_1_.tb5_1(105),
CCCCR_3051_1_.tb5_2(105),
CCCCR_3051_1_.tb5_3(105),
CCCCR_3051_1_.tb5_4(105),
CCCCR_3051_1_.tb5_5(105),
null,
null,
null,
null,
600,
4,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(12):=2477;
CCCCR_3051_1_.tb6_0(12):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(12):=CCCCR_3051_1_.tb6_0(12);
CCCCR_3051_1_.tb6_1(12):=CCCCR_3051_1_.tb2_0(13);
ut_trace.trace('insertando tabla: GI_FRAME fila (12)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(12),
CCCCR_3051_1_.tb6_1(12),
null,
null,
'INF_CCCCR_FRAME_1021685'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(105):=1602734;
CCCCR_3051_1_.tb7_0(105):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(105):=CCCCR_3051_1_.tb7_0(105);
CCCCR_3051_1_.old_tb7_1(105):=20330;
CCCCR_3051_1_.tb7_1(105):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(105),-1)));
CCCCR_3051_1_.old_tb7_2(105):=-1;
CCCCR_3051_1_.tb7_2(105):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(105),-1)));
CCCCR_3051_1_.tb7_3(105):=CCCCR_3051_1_.tb6_0(12);
CCCCR_3051_1_.tb7_4(105):=CCCCR_3051_1_.tb5_0(105);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (105)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(105),
CCCCR_3051_1_.tb7_1(105),
CCCCR_3051_1_.tb7_2(105),
CCCCR_3051_1_.tb7_3(105),
CCCCR_3051_1_.tb7_4(105),
'N'
,
'Y'
,
4,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(26):=120197400;
CCCCR_3051_1_.tb8_0(26):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(26):=CCCCR_3051_1_.tb8_0(26);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (26)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(26),
16,
'Lista de Valores Tipo de Documentación'
,
'SELECT GE_CHECK_LIST.ITEM_CHECK_LIST ID, GE_CHECK_LIST.DESCRIPTION DESCRIPTION
FROM
GE_CHECK_LIST,
GE_CHLIST_BY_SUBTYP
WHERE
    GE_CHECK_LIST.item_check_list = ge_chlist_by_subtyp.item_check_list
    AND ge_chlist_by_subtyp.subscriber_type_id = 1100
ORDER BY ID'
,
'Lista de Valores Tipo de Documentación'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(106):=1150077;
CCCCR_3051_1_.tb5_0(106):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(106):=CCCCR_3051_1_.tb5_0(106);
CCCCR_3051_1_.old_tb5_1(106):=9723;
CCCCR_3051_1_.tb5_1(106):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(106),-1)));
CCCCR_3051_1_.old_tb5_2(106):=20329;
CCCCR_3051_1_.tb5_2(106):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(106),-1)));
CCCCR_3051_1_.old_tb5_3(106):=-1;
CCCCR_3051_1_.tb5_3(106):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(106),-1)));
CCCCR_3051_1_.old_tb5_4(106):=-1;
CCCCR_3051_1_.tb5_4(106):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(106),-1)));
CCCCR_3051_1_.tb5_5(106):=CCCCR_3051_1_.tb2_0(13);
CCCCR_3051_1_.tb5_7(106):=CCCCR_3051_1_.tb8_0(26);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (106)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(106),
CCCCR_3051_1_.tb5_1(106),
CCCCR_3051_1_.tb5_2(106),
CCCCR_3051_1_.tb5_3(106),
CCCCR_3051_1_.tb5_4(106),
CCCCR_3051_1_.tb5_5(106),
null,
CCCCR_3051_1_.tb5_7(106),
null,
null,
600,
0,
'Tipo de Documento'
,
'N'
,
'Y'
,
'Y'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(106):=1602735;
CCCCR_3051_1_.tb7_0(106):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(106):=CCCCR_3051_1_.tb7_0(106);
CCCCR_3051_1_.old_tb7_1(106):=20329;
CCCCR_3051_1_.tb7_1(106):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(106),-1)));
CCCCR_3051_1_.old_tb7_2(106):=-1;
CCCCR_3051_1_.tb7_2(106):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(106),-1)));
CCCCR_3051_1_.tb7_3(106):=CCCCR_3051_1_.tb6_0(12);
CCCCR_3051_1_.tb7_4(106):=CCCCR_3051_1_.tb5_0(106);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (106)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(106),
CCCCR_3051_1_.tb7_1(106),
CCCCR_3051_1_.tb7_2(106),
CCCCR_3051_1_.tb7_3(106),
CCCCR_3051_1_.tb7_4(106),
'Y'
,
'Y'
,
0,
'Y'
,
'Tipo de Documento'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(56):=121403986;
CCCCR_3051_1_.tb0_0(56):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(56):=CCCCR_3051_1_.tb0_0(56);
CCCCR_3051_1_.old_tb0_1(56):='GEGE_EXERULVAL_CT69E121403986'
;
CCCCR_3051_1_.tb0_1(56):=CCCCR_3051_1_.tb0_0(56);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (56)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(56),
CCCCR_3051_1_.tb0_1(56),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("N")'
,
'OPEN'
,
to_date('27-11-2012 10:22:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa campo ACTIVE tabla GE_SUBS_DOCUMEN_DATA'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(107):=1150078;
CCCCR_3051_1_.tb5_0(107):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(107):=CCCCR_3051_1_.tb5_0(107);
CCCCR_3051_1_.old_tb5_1(107):=9723;
CCCCR_3051_1_.tb5_1(107):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(107),-1)));
CCCCR_3051_1_.old_tb5_2(107):=20328;
CCCCR_3051_1_.tb5_2(107):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(107),-1)));
CCCCR_3051_1_.old_tb5_3(107):=-1;
CCCCR_3051_1_.tb5_3(107):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(107),-1)));
CCCCR_3051_1_.old_tb5_4(107):=-1;
CCCCR_3051_1_.tb5_4(107):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(107),-1)));
CCCCR_3051_1_.tb5_5(107):=CCCCR_3051_1_.tb2_0(13);
CCCCR_3051_1_.tb5_8(107):=CCCCR_3051_1_.tb0_0(56);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (107)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(107),
CCCCR_3051_1_.tb5_1(107),
CCCCR_3051_1_.tb5_2(107),
CCCCR_3051_1_.tb5_3(107),
CCCCR_3051_1_.tb5_4(107),
CCCCR_3051_1_.tb5_5(107),
null,
null,
CCCCR_3051_1_.tb5_8(107),
null,
600,
1,
'Activo'
,
'N'
,
'Y'
,
'Y'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(107):=1602736;
CCCCR_3051_1_.tb7_0(107):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(107):=CCCCR_3051_1_.tb7_0(107);
CCCCR_3051_1_.old_tb7_1(107):=20328;
CCCCR_3051_1_.tb7_1(107):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(107),-1)));
CCCCR_3051_1_.old_tb7_2(107):=-1;
CCCCR_3051_1_.tb7_2(107):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(107),-1)));
CCCCR_3051_1_.tb7_3(107):=CCCCR_3051_1_.tb6_0(12);
CCCCR_3051_1_.tb7_4(107):=CCCCR_3051_1_.tb5_0(107);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (107)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(107),
CCCCR_3051_1_.tb7_1(107),
CCCCR_3051_1_.tb7_2(107),
CCCCR_3051_1_.tb7_3(107),
CCCCR_3051_1_.tb7_4(107),
'Y'
,
'Y'
,
1,
'Y'
,
'Activo'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(57):=121403987;
CCCCR_3051_1_.tb0_0(57):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(57):=CCCCR_3051_1_.tb0_0(57);
CCCCR_3051_1_.old_tb0_1(57):='GEGE_EXERULVAL_CT69E121403987'
;
CCCCR_3051_1_.tb0_1(57):=CCCCR_3051_1_.tb0_0(57);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (57)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(57),
CCCCR_3051_1_.tb0_1(57),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE("N")'
,
'OPEN'
,
to_date('27-11-2012 10:22:44','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicializa campo VALUE tabla GE_SUBS_DOCUMEN_DATA'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(108):=1150079;
CCCCR_3051_1_.tb5_0(108):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(108):=CCCCR_3051_1_.tb5_0(108);
CCCCR_3051_1_.old_tb5_1(108):=9723;
CCCCR_3051_1_.tb5_1(108):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(108),-1)));
CCCCR_3051_1_.old_tb5_2(108):=20332;
CCCCR_3051_1_.tb5_2(108):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(108),-1)));
CCCCR_3051_1_.old_tb5_3(108):=-1;
CCCCR_3051_1_.tb5_3(108):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(108),-1)));
CCCCR_3051_1_.old_tb5_4(108):=-1;
CCCCR_3051_1_.tb5_4(108):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(108),-1)));
CCCCR_3051_1_.tb5_5(108):=CCCCR_3051_1_.tb2_0(13);
CCCCR_3051_1_.tb5_8(108):=CCCCR_3051_1_.tb0_0(57);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (108)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(108),
CCCCR_3051_1_.tb5_1(108),
CCCCR_3051_1_.tb5_2(108),
CCCCR_3051_1_.tb5_3(108),
CCCCR_3051_1_.tb5_4(108),
CCCCR_3051_1_.tb5_5(108),
null,
null,
CCCCR_3051_1_.tb5_8(108),
null,
600,
2,
'Valor'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(108):=1602737;
CCCCR_3051_1_.tb7_0(108):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(108):=CCCCR_3051_1_.tb7_0(108);
CCCCR_3051_1_.old_tb7_1(108):=20332;
CCCCR_3051_1_.tb7_1(108):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(108),-1)));
CCCCR_3051_1_.old_tb7_2(108):=-1;
CCCCR_3051_1_.tb7_2(108):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(108),-1)));
CCCCR_3051_1_.tb7_3(108):=CCCCR_3051_1_.tb6_0(12);
CCCCR_3051_1_.tb7_4(108):=CCCCR_3051_1_.tb5_0(108);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (108)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(108),
CCCCR_3051_1_.tb7_1(108),
CCCCR_3051_1_.tb7_2(108),
CCCCR_3051_1_.tb7_3(108),
CCCCR_3051_1_.tb7_4(108),
'N'
,
'Y'
,
2,
'N'
,
'Valor'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(27):=120197401;
CCCCR_3051_1_.tb8_0(27):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(27):=CCCCR_3051_1_.tb8_0(27);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (27)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(27),
16,
'Lista de valores para archivos adjuntos'
,
'SELECT FILE_ID ID, FILE_NAME DESCRIPTION FROM CC_FILE order by id'
,
'Lista de valores para archivos adjuntos'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(109):=1150080;
CCCCR_3051_1_.tb5_0(109):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(109):=CCCCR_3051_1_.tb5_0(109);
CCCCR_3051_1_.old_tb5_1(109):=9723;
CCCCR_3051_1_.tb5_1(109):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(109),-1)));
CCCCR_3051_1_.old_tb5_2(109):=44081;
CCCCR_3051_1_.tb5_2(109):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(109),-1)));
CCCCR_3051_1_.old_tb5_3(109):=-1;
CCCCR_3051_1_.tb5_3(109):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(109),-1)));
CCCCR_3051_1_.old_tb5_4(109):=-1;
CCCCR_3051_1_.tb5_4(109):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(109),-1)));
CCCCR_3051_1_.tb5_5(109):=CCCCR_3051_1_.tb2_0(13);
CCCCR_3051_1_.tb5_7(109):=CCCCR_3051_1_.tb8_0(27);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (109)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(109),
CCCCR_3051_1_.tb5_1(109),
CCCCR_3051_1_.tb5_2(109),
CCCCR_3051_1_.tb5_3(109),
CCCCR_3051_1_.tb5_4(109),
CCCCR_3051_1_.tb5_5(109),
null,
CCCCR_3051_1_.tb5_7(109),
null,
null,
600,
3,
'Archivo Adjunto'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(109):=1602738;
CCCCR_3051_1_.tb7_0(109):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(109):=CCCCR_3051_1_.tb7_0(109);
CCCCR_3051_1_.old_tb7_1(109):=44081;
CCCCR_3051_1_.tb7_1(109):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(109),-1)));
CCCCR_3051_1_.old_tb7_2(109):=-1;
CCCCR_3051_1_.tb7_2(109):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(109),-1)));
CCCCR_3051_1_.tb7_3(109):=CCCCR_3051_1_.tb6_0(12);
CCCCR_3051_1_.tb7_4(109):=CCCCR_3051_1_.tb5_0(109);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (109)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(109),
CCCCR_3051_1_.tb7_1(109),
CCCCR_3051_1_.tb7_2(109),
CCCCR_3051_1_.tb7_3(109),
CCCCR_3051_1_.tb7_4(109),
'Y'
,
'Y'
,
3,
'N'
,
'Archivo Adjunto'
,
'N'
,
'N'
,
'U'
,
null,
30,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(13):=CCCCR_3051_1_.tb2_0(12);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (13)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(13),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(13):=2478;
CCCCR_3051_1_.tb6_0(13):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(13):=CCCCR_3051_1_.tb6_0(13);
CCCCR_3051_1_.tb6_1(13):=CCCCR_3051_1_.tb2_0(12);
ut_trace.trace('insertando tabla: GI_FRAME fila (13)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(13),
CCCCR_3051_1_.tb6_1(13),
null,
null,
'INF_CCCCR_TAB_1021684'
,
4);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(14):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (14)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(14),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(110):=1150083;
CCCCR_3051_1_.tb5_0(110):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(110):=CCCCR_3051_1_.tb5_0(110);
CCCCR_3051_1_.old_tb5_1(110):=9727;
CCCCR_3051_1_.tb5_1(110):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(110),-1)));
CCCCR_3051_1_.old_tb5_2(110):=20347;
CCCCR_3051_1_.tb5_2(110):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(110),-1)));
CCCCR_3051_1_.old_tb5_3(110):=-1;
CCCCR_3051_1_.tb5_3(110):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(110),-1)));
CCCCR_3051_1_.old_tb5_4(110):=-1;
CCCCR_3051_1_.tb5_4(110):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(110),-1)));
CCCCR_3051_1_.tb5_5(110):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (110)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(110),
CCCCR_3051_1_.tb5_1(110),
CCCCR_3051_1_.tb5_2(110),
CCCCR_3051_1_.tb5_3(110),
CCCCR_3051_1_.tb5_4(110),
CCCCR_3051_1_.tb5_5(110),
null,
null,
null,
null,
600,
7,
'Tipo de Identificación'
,
'N'
,
'Y'
,
'N'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(14):=2479;
CCCCR_3051_1_.tb6_0(14):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(14):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb6_1(14):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_FRAME fila (14)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(14),
CCCCR_3051_1_.tb6_1(14),
null,
null,
'INF_CCCCR_FRAME_1021688'
,
1);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(110):=1602741;
CCCCR_3051_1_.tb7_0(110):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(110):=CCCCR_3051_1_.tb7_0(110);
CCCCR_3051_1_.old_tb7_1(110):=20347;
CCCCR_3051_1_.tb7_1(110):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(110),-1)));
CCCCR_3051_1_.old_tb7_2(110):=-1;
CCCCR_3051_1_.tb7_2(110):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(110),-1)));
CCCCR_3051_1_.tb7_3(110):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(110):=CCCCR_3051_1_.tb5_0(110);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (110)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(110),
CCCCR_3051_1_.tb7_1(110),
CCCCR_3051_1_.tb7_2(110),
CCCCR_3051_1_.tb7_3(110),
CCCCR_3051_1_.tb7_4(110),
'N'
,
'Y'
,
7,
'N'
,
'Tipo de Identificación'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(111):=1150084;
CCCCR_3051_1_.tb5_0(111):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(111):=CCCCR_3051_1_.tb5_0(111);
CCCCR_3051_1_.old_tb5_1(111):=9727;
CCCCR_3051_1_.tb5_1(111):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(111),-1)));
CCCCR_3051_1_.old_tb5_2(111):=20351;
CCCCR_3051_1_.tb5_2(111):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(111),-1)));
CCCCR_3051_1_.old_tb5_3(111):=-1;
CCCCR_3051_1_.tb5_3(111):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(111),-1)));
CCCCR_3051_1_.old_tb5_4(111):=-1;
CCCCR_3051_1_.tb5_4(111):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(111),-1)));
CCCCR_3051_1_.tb5_5(111):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (111)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(111),
CCCCR_3051_1_.tb5_1(111),
CCCCR_3051_1_.tb5_2(111),
CCCCR_3051_1_.tb5_3(111),
CCCCR_3051_1_.tb5_4(111),
CCCCR_3051_1_.tb5_5(111),
null,
null,
null,
null,
600,
0,
'Valor de la Calificación'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(111):=1602742;
CCCCR_3051_1_.tb7_0(111):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(111):=CCCCR_3051_1_.tb7_0(111);
CCCCR_3051_1_.old_tb7_1(111):=20351;
CCCCR_3051_1_.tb7_1(111):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(111),-1)));
CCCCR_3051_1_.old_tb7_2(111):=-1;
CCCCR_3051_1_.tb7_2(111):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(111),-1)));
CCCCR_3051_1_.tb7_3(111):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(111):=CCCCR_3051_1_.tb5_0(111);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (111)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(111),
CCCCR_3051_1_.tb7_1(111),
CCCCR_3051_1_.tb7_2(111),
CCCCR_3051_1_.tb7_3(111),
CCCCR_3051_1_.tb7_4(111),
'Y'
,
'N'
,
0,
'N'
,
'Valor de la Calificación'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(112):=1150085;
CCCCR_3051_1_.tb5_0(112):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(112):=CCCCR_3051_1_.tb5_0(112);
CCCCR_3051_1_.old_tb5_1(112):=9727;
CCCCR_3051_1_.tb5_1(112):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(112),-1)));
CCCCR_3051_1_.old_tb5_2(112):=20353;
CCCCR_3051_1_.tb5_2(112):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(112),-1)));
CCCCR_3051_1_.old_tb5_3(112):=-1;
CCCCR_3051_1_.tb5_3(112):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(112),-1)));
CCCCR_3051_1_.old_tb5_4(112):=-1;
CCCCR_3051_1_.tb5_4(112):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(112),-1)));
CCCCR_3051_1_.tb5_5(112):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (112)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(112),
CCCCR_3051_1_.tb5_1(112),
CCCCR_3051_1_.tb5_2(112),
CCCCR_3051_1_.tb5_3(112),
CCCCR_3051_1_.tb5_4(112),
CCCCR_3051_1_.tb5_5(112),
null,
null,
null,
null,
600,
1,
'Puntaje'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(112):=1602743;
CCCCR_3051_1_.tb7_0(112):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(112):=CCCCR_3051_1_.tb7_0(112);
CCCCR_3051_1_.old_tb7_1(112):=20353;
CCCCR_3051_1_.tb7_1(112):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(112),-1)));
CCCCR_3051_1_.old_tb7_2(112):=-1;
CCCCR_3051_1_.tb7_2(112):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(112),-1)));
CCCCR_3051_1_.tb7_3(112):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(112):=CCCCR_3051_1_.tb5_0(112);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (112)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(112),
CCCCR_3051_1_.tb7_1(112),
CCCCR_3051_1_.tb7_2(112),
CCCCR_3051_1_.tb7_3(112),
CCCCR_3051_1_.tb7_4(112),
'Y'
,
'N'
,
1,
'N'
,
'Puntaje'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(58):=121403988;
CCCCR_3051_1_.tb0_0(58):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(58):=CCCCR_3051_1_.tb0_0(58);
CCCCR_3051_1_.old_tb0_1(58):='GEGE_EXERULVAL_CT69E121403988'
;
CCCCR_3051_1_.tb0_1(58):=CCCCR_3051_1_.tb0_0(58);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (58)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(58),
CCCCR_3051_1_.tb0_1(58),
69,
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENT_TYPE_ID",sbIdenTypeId);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"GE_SUBSCRIBER","IDENTIFICATION",sbIdentification);CC_BOCLIENTREGISTEREXPRESSIONS.SETEXTERNALSCORING(sbInstance,sbIdenTypeId,sbIdentification);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,null,"CLIENT_REGISTER","PROCESS_MESSAGE","Calculo de Scoring Externo realizado satisfactoriamente")'
,
'OPEN'
,
to_date('27-11-2012 10:22:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Calculo de scoring GE_SUBS_EXT_SCORING'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(113):=1150081;
CCCCR_3051_1_.tb5_0(113):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(113):=CCCCR_3051_1_.tb5_0(113);
CCCCR_3051_1_.old_tb5_1(113):=2117;
CCCCR_3051_1_.tb5_1(113):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(113),-1)));
CCCCR_3051_1_.old_tb5_2(113):=56802;
CCCCR_3051_1_.tb5_2(113):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(113),-1)));
CCCCR_3051_1_.old_tb5_3(113):=-1;
CCCCR_3051_1_.tb5_3(113):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(113),-1)));
CCCCR_3051_1_.old_tb5_4(113):=-1;
CCCCR_3051_1_.tb5_4(113):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(113),-1)));
CCCCR_3051_1_.tb5_5(113):=CCCCR_3051_1_.tb2_0(15);
CCCCR_3051_1_.tb5_9(113):=CCCCR_3051_1_.tb0_0(58);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (113)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(113),
CCCCR_3051_1_.tb5_1(113),
CCCCR_3051_1_.tb5_2(113),
CCCCR_3051_1_.tb5_3(113),
CCCCR_3051_1_.tb5_4(113),
CCCCR_3051_1_.tb5_5(113),
null,
null,
null,
CCCCR_3051_1_.tb5_9(113),
600,
4,
'Calcular Scoring'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(113):=1602739;
CCCCR_3051_1_.tb7_0(113):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(113):=CCCCR_3051_1_.tb7_0(113);
CCCCR_3051_1_.old_tb7_1(113):=56802;
CCCCR_3051_1_.tb7_1(113):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(113),-1)));
CCCCR_3051_1_.old_tb7_2(113):=-1;
CCCCR_3051_1_.tb7_2(113):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(113),-1)));
CCCCR_3051_1_.tb7_3(113):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(113):=CCCCR_3051_1_.tb5_0(113);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (113)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(113),
CCCCR_3051_1_.tb7_1(113),
CCCCR_3051_1_.tb7_2(113),
CCCCR_3051_1_.tb7_3(113),
CCCCR_3051_1_.tb7_4(113),
'Y'
,
'Y'
,
4,
'N'
,
'Calcular Scoring'
,
'N'
,
'N'
,
'U'
,
null,
15,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(114):=1150082;
CCCCR_3051_1_.tb5_0(114):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(114):=CCCCR_3051_1_.tb5_0(114);
CCCCR_3051_1_.old_tb5_1(114):=9727;
CCCCR_3051_1_.tb5_1(114):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(114),-1)));
CCCCR_3051_1_.old_tb5_2(114):=20348;
CCCCR_3051_1_.tb5_2(114):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(114),-1)));
CCCCR_3051_1_.old_tb5_3(114):=-1;
CCCCR_3051_1_.tb5_3(114):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(114),-1)));
CCCCR_3051_1_.old_tb5_4(114):=-1;
CCCCR_3051_1_.tb5_4(114):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(114),-1)));
CCCCR_3051_1_.tb5_5(114):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (114)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(114),
CCCCR_3051_1_.tb5_1(114),
CCCCR_3051_1_.tb5_2(114),
CCCCR_3051_1_.tb5_3(114),
CCCCR_3051_1_.tb5_4(114),
CCCCR_3051_1_.tb5_5(114),
null,
null,
null,
null,
600,
6,
'Identificación'
,
'N'
,
'Y'
,
'N'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(114):=1602740;
CCCCR_3051_1_.tb7_0(114):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(114):=CCCCR_3051_1_.tb7_0(114);
CCCCR_3051_1_.old_tb7_1(114):=20348;
CCCCR_3051_1_.tb7_1(114):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(114),-1)));
CCCCR_3051_1_.old_tb7_2(114):=-1;
CCCCR_3051_1_.tb7_2(114):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(114),-1)));
CCCCR_3051_1_.tb7_3(114):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(114):=CCCCR_3051_1_.tb5_0(114);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (114)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(114),
CCCCR_3051_1_.tb7_1(114),
CCCCR_3051_1_.tb7_2(114),
CCCCR_3051_1_.tb7_3(114),
CCCCR_3051_1_.tb7_4(114),
'N'
,
'Y'
,
6,
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(115):=1150086;
CCCCR_3051_1_.tb5_0(115):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(115):=CCCCR_3051_1_.tb5_0(115);
CCCCR_3051_1_.old_tb5_1(115):=9727;
CCCCR_3051_1_.tb5_1(115):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(115),-1)));
CCCCR_3051_1_.old_tb5_2(115):=20349;
CCCCR_3051_1_.tb5_2(115):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(115),-1)));
CCCCR_3051_1_.old_tb5_3(115):=-1;
CCCCR_3051_1_.tb5_3(115):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(115),-1)));
CCCCR_3051_1_.old_tb5_4(115):=-1;
CCCCR_3051_1_.tb5_4(115):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(115),-1)));
CCCCR_3051_1_.tb5_5(115):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (115)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(115),
CCCCR_3051_1_.tb5_1(115),
CCCCR_3051_1_.tb5_2(115),
CCCCR_3051_1_.tb5_3(115),
CCCCR_3051_1_.tb5_4(115),
CCCCR_3051_1_.tb5_5(115),
null,
null,
null,
null,
600,
2,
'Número de Autorización'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(115):=1602744;
CCCCR_3051_1_.tb7_0(115):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(115):=CCCCR_3051_1_.tb7_0(115);
CCCCR_3051_1_.old_tb7_1(115):=20349;
CCCCR_3051_1_.tb7_1(115):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(115),-1)));
CCCCR_3051_1_.old_tb7_2(115):=-1;
CCCCR_3051_1_.tb7_2(115):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(115),-1)));
CCCCR_3051_1_.tb7_3(115):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(115):=CCCCR_3051_1_.tb5_0(115);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (115)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(115),
CCCCR_3051_1_.tb7_1(115),
CCCCR_3051_1_.tb7_2(115),
CCCCR_3051_1_.tb7_3(115),
CCCCR_3051_1_.tb7_4(115),
'Y'
,
'N'
,
2,
'N'
,
'Número de Autorización'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(116):=1150087;
CCCCR_3051_1_.tb5_0(116):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(116):=CCCCR_3051_1_.tb5_0(116);
CCCCR_3051_1_.old_tb5_1(116):=9727;
CCCCR_3051_1_.tb5_1(116):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(116),-1)));
CCCCR_3051_1_.old_tb5_2(116):=20354;
CCCCR_3051_1_.tb5_2(116):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(116),-1)));
CCCCR_3051_1_.old_tb5_3(116):=-1;
CCCCR_3051_1_.tb5_3(116):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(116),-1)));
CCCCR_3051_1_.old_tb5_4(116):=-1;
CCCCR_3051_1_.tb5_4(116):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(116),-1)));
CCCCR_3051_1_.tb5_5(116):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (116)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(116),
CCCCR_3051_1_.tb5_1(116),
CCCCR_3051_1_.tb5_2(116),
CCCCR_3051_1_.tb5_3(116),
CCCCR_3051_1_.tb5_4(116),
CCCCR_3051_1_.tb5_5(116),
null,
null,
null,
null,
600,
3,
'Fecha de la Consulta'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(116):=1602745;
CCCCR_3051_1_.tb7_0(116):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(116):=CCCCR_3051_1_.tb7_0(116);
CCCCR_3051_1_.old_tb7_1(116):=20354;
CCCCR_3051_1_.tb7_1(116):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(116),-1)));
CCCCR_3051_1_.old_tb7_2(116):=-1;
CCCCR_3051_1_.tb7_2(116):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(116),-1)));
CCCCR_3051_1_.tb7_3(116):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(116):=CCCCR_3051_1_.tb5_0(116);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (116)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(116),
CCCCR_3051_1_.tb7_1(116),
CCCCR_3051_1_.tb7_2(116),
CCCCR_3051_1_.tb7_3(116),
CCCCR_3051_1_.tb7_4(116),
'Y'
,
'N'
,
3,
'N'
,
'Fecha de la Consulta'
,
'N'
,
'N'
,
'U'
,
null,
7,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(117):=1150088;
CCCCR_3051_1_.tb5_0(117):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(117):=CCCCR_3051_1_.tb5_0(117);
CCCCR_3051_1_.old_tb5_1(117):=-1;
CCCCR_3051_1_.tb5_1(117):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(117),-1)));
CCCCR_3051_1_.old_tb5_2(117):=-1;
CCCCR_3051_1_.tb5_2(117):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(117),-1)));
CCCCR_3051_1_.old_tb5_3(117):=-1;
CCCCR_3051_1_.tb5_3(117):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(117),-1)));
CCCCR_3051_1_.old_tb5_4(117):=null;
CCCCR_3051_1_.tb5_4(117):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(117),-1)));
CCCCR_3051_1_.tb5_5(117):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (117)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(117),
CCCCR_3051_1_.tb5_1(117),
CCCCR_3051_1_.tb5_2(117),
CCCCR_3051_1_.tb5_3(117),
CCCCR_3051_1_.tb5_4(117),
CCCCR_3051_1_.tb5_5(117),
null,
null,
null,
null,
600,
5,
'Espacio en blanco'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(117):=1602746;
CCCCR_3051_1_.tb7_0(117):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(117):=CCCCR_3051_1_.tb7_0(117);
CCCCR_3051_1_.old_tb7_1(117):=-1;
CCCCR_3051_1_.tb7_1(117):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(117),-1)));
CCCCR_3051_1_.old_tb7_2(117):=null;
CCCCR_3051_1_.tb7_2(117):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(117),-1)));
CCCCR_3051_1_.tb7_3(117):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(117):=CCCCR_3051_1_.tb5_0(117);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (117)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(117),
CCCCR_3051_1_.tb7_1(117),
CCCCR_3051_1_.tb7_2(117),
CCCCR_3051_1_.tb7_3(117),
CCCCR_3051_1_.tb7_4(117),
'Y'
,
'Y'
,
5,
'N'
,
'Espacio en blanco'
,
'N'
,
'N'
,
'U'
,
null,
98,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(118):=1150089;
CCCCR_3051_1_.tb5_0(118):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(118):=CCCCR_3051_1_.tb5_0(118);
CCCCR_3051_1_.old_tb5_1(118):=9727;
CCCCR_3051_1_.tb5_1(118):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(118),-1)));
CCCCR_3051_1_.old_tb5_2(118):=20346;
CCCCR_3051_1_.tb5_2(118):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(118),-1)));
CCCCR_3051_1_.old_tb5_3(118):=-1;
CCCCR_3051_1_.tb5_3(118):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(118),-1)));
CCCCR_3051_1_.old_tb5_4(118):=-1;
CCCCR_3051_1_.tb5_4(118):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(118),-1)));
CCCCR_3051_1_.tb5_5(118):=CCCCR_3051_1_.tb2_0(15);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (118)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(118),
CCCCR_3051_1_.tb5_1(118),
CCCCR_3051_1_.tb5_2(118),
CCCCR_3051_1_.tb5_3(118),
CCCCR_3051_1_.tb5_4(118),
CCCCR_3051_1_.tb5_5(118),
null,
null,
null,
null,
600,
6,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(118):=1602747;
CCCCR_3051_1_.tb7_0(118):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(118):=CCCCR_3051_1_.tb7_0(118);
CCCCR_3051_1_.old_tb7_1(118):=20346;
CCCCR_3051_1_.tb7_1(118):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(118),-1)));
CCCCR_3051_1_.old_tb7_2(118):=-1;
CCCCR_3051_1_.tb7_2(118):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(118),-1)));
CCCCR_3051_1_.tb7_3(118):=CCCCR_3051_1_.tb6_0(14);
CCCCR_3051_1_.tb7_4(118):=CCCCR_3051_1_.tb5_0(118);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (118)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(118),
CCCCR_3051_1_.tb7_1(118),
CCCCR_3051_1_.tb7_2(118),
CCCCR_3051_1_.tb7_3(118),
CCCCR_3051_1_.tb7_4(118),
'N'
,
'Y'
,
6,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(15):=CCCCR_3051_1_.tb2_0(14);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (15)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(15),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(15):=2480;
CCCCR_3051_1_.tb6_0(15):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(15):=CCCCR_3051_1_.tb6_0(15);
CCCCR_3051_1_.tb6_1(15):=CCCCR_3051_1_.tb2_0(14);
ut_trace.trace('insertando tabla: GI_FRAME fila (15)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(15),
CCCCR_3051_1_.tb6_1(15),
null,
null,
'INF_CCCCR_TAB_1021686'
,
5);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(16):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (16)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(16),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
' PHONE_TYPE_ID <> 3'
,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(28):=120197402;
CCCCR_3051_1_.tb8_0(28):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(28):=CCCCR_3051_1_.tb8_0(28);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (28)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(28),
16,
'Lista de Valores de Tipos de Teléfonos.'
,
'SELECT PHONE_TYPE_ID Código, PHONE_TYPE_DESC Descripción
from GE_PHONE_TYPE
where PHONE_TYPE_ID <> CC_BOProdConstants.fnuGetVOIPPhoneType
order by PHONE_TYPE_ID asc'
,
'Lista de Valores de Tipos de Teléfonos.'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(119):=1150090;
CCCCR_3051_1_.tb5_0(119):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(119):=CCCCR_3051_1_.tb5_0(119);
CCCCR_3051_1_.old_tb5_1(119):=1248;
CCCCR_3051_1_.tb5_1(119):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(119),-1)));
CCCCR_3051_1_.old_tb5_2(119):=97608;
CCCCR_3051_1_.tb5_2(119):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(119),-1)));
CCCCR_3051_1_.old_tb5_3(119):=-1;
CCCCR_3051_1_.tb5_3(119):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(119),-1)));
CCCCR_3051_1_.old_tb5_4(119):=-1;
CCCCR_3051_1_.tb5_4(119):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(119),-1)));
CCCCR_3051_1_.tb5_5(119):=CCCCR_3051_1_.tb2_0(17);
CCCCR_3051_1_.tb5_7(119):=CCCCR_3051_1_.tb8_0(28);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (119)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(119),
CCCCR_3051_1_.tb5_1(119),
CCCCR_3051_1_.tb5_2(119),
CCCCR_3051_1_.tb5_3(119),
CCCCR_3051_1_.tb5_4(119),
CCCCR_3051_1_.tb5_5(119),
null,
CCCCR_3051_1_.tb5_7(119),
null,
null,
600,
0,
'Tipo de Teléfono'
,
'N'
,
'Y'
,
'Y'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(59):=121403989;
CCCCR_3051_1_.tb0_0(59):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(59):=CCCCR_3051_1_.tb0_0(59);
CCCCR_3051_1_.old_tb0_1(59):='GEGE_EXERULVAL_CT69E121403989'
;
CCCCR_3051_1_.tb0_1(59):=CCCCR_3051_1_.tb0_0(59);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (59)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(59),
CCCCR_3051_1_.tb0_1(59),
69,
'CC_BOSUBSPHONEREGIS.SETNUMBERCONTACTPHONES()'
,
'OPEN'
,
to_date('27-11-2012 10:22:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Actualizar Telefonos de Contacto'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(16):=2481;
CCCCR_3051_1_.tb6_0(16):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(16):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb6_1(16):=CCCCR_3051_1_.tb2_0(17);
CCCCR_3051_1_.tb6_2(16):=CCCCR_3051_1_.tb0_0(59);
ut_trace.trace('insertando tabla: GI_FRAME fila (16)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(16),
CCCCR_3051_1_.tb6_1(16),
CCCCR_3051_1_.tb6_2(16),
null,
'INF_CCCCR_FRAME_1021692'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(119):=1602748;
CCCCR_3051_1_.tb7_0(119):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(119):=CCCCR_3051_1_.tb7_0(119);
CCCCR_3051_1_.old_tb7_1(119):=97608;
CCCCR_3051_1_.tb7_1(119):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(119),-1)));
CCCCR_3051_1_.old_tb7_2(119):=-1;
CCCCR_3051_1_.tb7_2(119):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(119),-1)));
CCCCR_3051_1_.tb7_3(119):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(119):=CCCCR_3051_1_.tb5_0(119);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (119)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(119),
CCCCR_3051_1_.tb7_1(119),
CCCCR_3051_1_.tb7_2(119),
CCCCR_3051_1_.tb7_3(119),
CCCCR_3051_1_.tb7_4(119),
'Y'
,
'Y'
,
0,
'Y'
,
'Tipo de Teléfono'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb9_0(6):=358;
CCCCR_3051_1_.tb9_0(6):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPRESSION;
CCCCR_3051_1_.tb9_0(6):=CCCCR_3051_1_.tb9_0(6);
CCCCR_3051_1_.tb9_1(6):=CCCCR_3051_1_.tb5_0(119);
ut_trace.trace('insertando tabla: GI_NAVIG_EXPRESSION fila (6)',1);
INSERT INTO GI_NAVIG_EXPRESSION(NAVIG_EXPRESSION_ID,EXTERNAL_ID,NAVIG_TYPE_ID,EXPRESSION) 
VALUES (CCCCR_3051_1_.tb9_0(6),
CCCCR_3051_1_.tb9_1(6),
1,
'GE_SUBS_PHONE.PHONE_TYPE_ID<>2'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(54):=6682;
CCCCR_3051_1_.tb10_0(54):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(54):=CCCCR_3051_1_.tb10_0(54);
CCCCR_3051_1_.tb10_1(54):=CCCCR_3051_1_.tb9_0(6);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (54)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(54),
CCCCR_3051_1_.tb10_1(54),
'Y'
,
'GE_SUBS_PHONE.COMERCIAL_SMS'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(55):=6683;
CCCCR_3051_1_.tb10_0(55):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(55):=CCCCR_3051_1_.tb10_0(55);
CCCCR_3051_1_.tb10_1(55):=CCCCR_3051_1_.tb9_0(6);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (55)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(55),
CCCCR_3051_1_.tb10_1(55),
'Y'
,
'GE_SUBS_PHONE.ADMINISTRATIVE_SMS'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(56):=6684;
CCCCR_3051_1_.tb10_0(56):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(56):=CCCCR_3051_1_.tb10_0(56);
CCCCR_3051_1_.tb10_1(56):=CCCCR_3051_1_.tb9_0(6);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (56)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(56),
CCCCR_3051_1_.tb10_1(56),
'Y'
,
'GE_SUBS_PHONE.TECHNICAL_SMS'
,
'ENABLED'
,
'N'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(57):=6685;
CCCCR_3051_1_.tb10_0(57):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(57):=CCCCR_3051_1_.tb10_0(57);
CCCCR_3051_1_.tb10_1(57):=CCCCR_3051_1_.tb9_0(6);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (57)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(57),
CCCCR_3051_1_.tb10_1(57),
'N'
,
'GE_SUBS_PHONE.COMERCIAL_SMS'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(58):=6686;
CCCCR_3051_1_.tb10_0(58):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(58):=CCCCR_3051_1_.tb10_0(58);
CCCCR_3051_1_.tb10_1(58):=CCCCR_3051_1_.tb9_0(6);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (58)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(58),
CCCCR_3051_1_.tb10_1(58),
'N'
,
'GE_SUBS_PHONE.ADMINISTRATIVE_SMS'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb10_0(59):=6687;
CCCCR_3051_1_.tb10_0(59):=GI_BOSEQUENCES.FNUGETNEXTNAVIGEXPVALUES;
CCCCR_3051_1_.tb10_0(59):=CCCCR_3051_1_.tb10_0(59);
CCCCR_3051_1_.tb10_1(59):=CCCCR_3051_1_.tb9_0(6);
ut_trace.trace('insertando tabla: GI_NAVIG_EXP_VALUES fila (59)',1);
INSERT INTO GI_NAVIG_EXP_VALUES(NAVIG_EXP_VALUES_ID,NAVIG_EXPRESSION_ID,EXPRESSION_VALUE,ATTRIBUTE_NAME,PROPERTY_NAME,PROPERTY_VALUE) 
VALUES (CCCCR_3051_1_.tb10_0(59),
CCCCR_3051_1_.tb10_1(59),
'N'
,
'GE_SUBS_PHONE.TECHNICAL_SMS'
,
'ENABLED'
,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(60):=121403990;
CCCCR_3051_1_.tb0_0(60):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(60):=CCCCR_3051_1_.tb0_0(60);
CCCCR_3051_1_.old_tb0_1(60):='GEGE_EXERULVAL_CT69E121403990'
;
CCCCR_3051_1_.tb0_1(60):=CCCCR_3051_1_.tb0_0(60);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (60)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(60),
CCCCR_3051_1_.tb0_1(60),
69,
'GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbValue);nuPhone = UT_CONVERT.FNUCHARTONUMCONTROL(sbValue);if (nuPhone = NULL,,if (UT_STRING.FNULENGTH(nuPhone) <> 7 '||chr(38)||''||chr(38)||' UT_STRING.FNULENGTH(nuPhone) <> 10,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El número de teléfono deber ser de 7 o 10 dígitos");,);)'
,
'OPEN'
,
to_date('27-11-2012 10:22:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:56','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC-Valida teléfonos de Contacto'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(120):=1150091;
CCCCR_3051_1_.tb5_0(120):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(120):=CCCCR_3051_1_.tb5_0(120);
CCCCR_3051_1_.old_tb5_1(120):=1248;
CCCCR_3051_1_.tb5_1(120):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(120),-1)));
CCCCR_3051_1_.old_tb5_2(120):=106453;
CCCCR_3051_1_.tb5_2(120):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(120),-1)));
CCCCR_3051_1_.old_tb5_3(120):=-1;
CCCCR_3051_1_.tb5_3(120):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(120),-1)));
CCCCR_3051_1_.old_tb5_4(120):=-1;
CCCCR_3051_1_.tb5_4(120):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(120),-1)));
CCCCR_3051_1_.tb5_5(120):=CCCCR_3051_1_.tb2_0(17);
CCCCR_3051_1_.tb5_9(120):=CCCCR_3051_1_.tb0_0(60);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (120)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(120),
CCCCR_3051_1_.tb5_1(120),
CCCCR_3051_1_.tb5_2(120),
CCCCR_3051_1_.tb5_3(120),
CCCCR_3051_1_.tb5_4(120),
CCCCR_3051_1_.tb5_5(120),
null,
null,
null,
CCCCR_3051_1_.tb5_9(120),
600,
1,
'Número Telefónico Completo'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(120):=1602749;
CCCCR_3051_1_.tb7_0(120):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(120):=CCCCR_3051_1_.tb7_0(120);
CCCCR_3051_1_.old_tb7_1(120):=106453;
CCCCR_3051_1_.tb7_1(120):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(120),-1)));
CCCCR_3051_1_.old_tb7_2(120):=-1;
CCCCR_3051_1_.tb7_2(120):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(120),-1)));
CCCCR_3051_1_.tb7_3(120):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(120):=CCCCR_3051_1_.tb5_0(120);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (120)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(120),
CCCCR_3051_1_.tb7_1(120),
CCCCR_3051_1_.tb7_2(120),
CCCCR_3051_1_.tb7_3(120),
CCCCR_3051_1_.tb7_4(120),
'Y'
,
'Y'
,
1,
'N'
,
'Número Telefónico Completo'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(121):=1150092;
CCCCR_3051_1_.tb5_0(121):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(121):=CCCCR_3051_1_.tb5_0(121);
CCCCR_3051_1_.old_tb5_1(121):=1248;
CCCCR_3051_1_.tb5_1(121):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(121),-1)));
CCCCR_3051_1_.old_tb5_2(121):=97611;
CCCCR_3051_1_.tb5_2(121):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(121),-1)));
CCCCR_3051_1_.old_tb5_3(121):=-1;
CCCCR_3051_1_.tb5_3(121):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(121),-1)));
CCCCR_3051_1_.old_tb5_4(121):=-1;
CCCCR_3051_1_.tb5_4(121):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(121),-1)));
CCCCR_3051_1_.tb5_5(121):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (121)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(121),
CCCCR_3051_1_.tb5_1(121),
CCCCR_3051_1_.tb5_2(121),
CCCCR_3051_1_.tb5_3(121),
CCCCR_3051_1_.tb5_4(121),
CCCCR_3051_1_.tb5_5(121),
null,
null,
null,
null,
600,
3,
'SMS Técnicos'
,
'N'
,
'Y'
,
'N'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(121):=1602750;
CCCCR_3051_1_.tb7_0(121):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(121):=CCCCR_3051_1_.tb7_0(121);
CCCCR_3051_1_.old_tb7_1(121):=97611;
CCCCR_3051_1_.tb7_1(121):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(121),-1)));
CCCCR_3051_1_.old_tb7_2(121):=-1;
CCCCR_3051_1_.tb7_2(121):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(121),-1)));
CCCCR_3051_1_.tb7_3(121):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(121):=CCCCR_3051_1_.tb5_0(121);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (121)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(121),
CCCCR_3051_1_.tb7_1(121),
CCCCR_3051_1_.tb7_2(121),
CCCCR_3051_1_.tb7_3(121),
CCCCR_3051_1_.tb7_4(121),
'Y'
,
'N'
,
3,
'N'
,
'SMS Técnicos'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(122):=1150093;
CCCCR_3051_1_.tb5_0(122):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(122):=CCCCR_3051_1_.tb5_0(122);
CCCCR_3051_1_.old_tb5_1(122):=1248;
CCCCR_3051_1_.tb5_1(122):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(122),-1)));
CCCCR_3051_1_.old_tb5_2(122):=97612;
CCCCR_3051_1_.tb5_2(122):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(122),-1)));
CCCCR_3051_1_.old_tb5_3(122):=-1;
CCCCR_3051_1_.tb5_3(122):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(122),-1)));
CCCCR_3051_1_.old_tb5_4(122):=-1;
CCCCR_3051_1_.tb5_4(122):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(122),-1)));
CCCCR_3051_1_.tb5_5(122):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (122)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(122),
CCCCR_3051_1_.tb5_1(122),
CCCCR_3051_1_.tb5_2(122),
CCCCR_3051_1_.tb5_3(122),
CCCCR_3051_1_.tb5_4(122),
CCCCR_3051_1_.tb5_5(122),
null,
null,
null,
null,
600,
4,
'SMS Administrativos'
,
'N'
,
'Y'
,
'N'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(122):=1602751;
CCCCR_3051_1_.tb7_0(122):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(122):=CCCCR_3051_1_.tb7_0(122);
CCCCR_3051_1_.old_tb7_1(122):=97612;
CCCCR_3051_1_.tb7_1(122):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(122),-1)));
CCCCR_3051_1_.old_tb7_2(122):=-1;
CCCCR_3051_1_.tb7_2(122):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(122),-1)));
CCCCR_3051_1_.tb7_3(122):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(122):=CCCCR_3051_1_.tb5_0(122);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (122)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(122),
CCCCR_3051_1_.tb7_1(122),
CCCCR_3051_1_.tb7_2(122),
CCCCR_3051_1_.tb7_3(122),
CCCCR_3051_1_.tb7_4(122),
'Y'
,
'N'
,
4,
'N'
,
'SMS Administrativos'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(123):=1150094;
CCCCR_3051_1_.tb5_0(123):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(123):=CCCCR_3051_1_.tb5_0(123);
CCCCR_3051_1_.old_tb5_1(123):=1248;
CCCCR_3051_1_.tb5_1(123):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(123),-1)));
CCCCR_3051_1_.old_tb5_2(123):=97613;
CCCCR_3051_1_.tb5_2(123):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(123),-1)));
CCCCR_3051_1_.old_tb5_3(123):=-1;
CCCCR_3051_1_.tb5_3(123):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(123),-1)));
CCCCR_3051_1_.old_tb5_4(123):=-1;
CCCCR_3051_1_.tb5_4(123):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(123),-1)));
CCCCR_3051_1_.tb5_5(123):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (123)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(123),
CCCCR_3051_1_.tb5_1(123),
CCCCR_3051_1_.tb5_2(123),
CCCCR_3051_1_.tb5_3(123),
CCCCR_3051_1_.tb5_4(123),
CCCCR_3051_1_.tb5_5(123),
null,
null,
null,
null,
600,
5,
'SMS Comerciales'
,
'N'
,
'Y'
,
'N'
,
5,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(123):=1602752;
CCCCR_3051_1_.tb7_0(123):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(123):=CCCCR_3051_1_.tb7_0(123);
CCCCR_3051_1_.old_tb7_1(123):=97613;
CCCCR_3051_1_.tb7_1(123):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(123),-1)));
CCCCR_3051_1_.old_tb7_2(123):=-1;
CCCCR_3051_1_.tb7_2(123):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(123),-1)));
CCCCR_3051_1_.tb7_3(123):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(123):=CCCCR_3051_1_.tb5_0(123);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (123)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(123),
CCCCR_3051_1_.tb7_1(123),
CCCCR_3051_1_.tb7_2(123),
CCCCR_3051_1_.tb7_3(123),
CCCCR_3051_1_.tb7_4(123),
'Y'
,
'N'
,
5,
'N'
,
'SMS Comerciales'
,
'N'
,
'N'
,
'U'
,
null,
1,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(124):=1150095;
CCCCR_3051_1_.tb5_0(124):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(124):=CCCCR_3051_1_.tb5_0(124);
CCCCR_3051_1_.old_tb5_1(124):=1248;
CCCCR_3051_1_.tb5_1(124):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(124),-1)));
CCCCR_3051_1_.old_tb5_2(124):=55558;
CCCCR_3051_1_.tb5_2(124):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(124),-1)));
CCCCR_3051_1_.old_tb5_3(124):=-1;
CCCCR_3051_1_.tb5_3(124):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(124),-1)));
CCCCR_3051_1_.old_tb5_4(124):=-1;
CCCCR_3051_1_.tb5_4(124):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(124),-1)));
CCCCR_3051_1_.tb5_5(124):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (124)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(124),
CCCCR_3051_1_.tb5_1(124),
CCCCR_3051_1_.tb5_2(124),
CCCCR_3051_1_.tb5_3(124),
CCCCR_3051_1_.tb5_4(124),
CCCCR_3051_1_.tb5_5(124),
null,
null,
null,
null,
600,
6,
'Descripción'
,
'N'
,
'Y'
,
'Y'
,
6,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(124):=1602753;
CCCCR_3051_1_.tb7_0(124):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(124):=CCCCR_3051_1_.tb7_0(124);
CCCCR_3051_1_.old_tb7_1(124):=55558;
CCCCR_3051_1_.tb7_1(124):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(124),-1)));
CCCCR_3051_1_.old_tb7_2(124):=-1;
CCCCR_3051_1_.tb7_2(124):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(124),-1)));
CCCCR_3051_1_.tb7_3(124):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(124):=CCCCR_3051_1_.tb5_0(124);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (124)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(124),
CCCCR_3051_1_.tb7_1(124),
CCCCR_3051_1_.tb7_2(124),
CCCCR_3051_1_.tb7_3(124),
CCCCR_3051_1_.tb7_4(124),
'Y'
,
'Y'
,
6,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(125):=1150096;
CCCCR_3051_1_.tb5_0(125):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(125):=CCCCR_3051_1_.tb5_0(125);
CCCCR_3051_1_.old_tb5_1(125):=1248;
CCCCR_3051_1_.tb5_1(125):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(125),-1)));
CCCCR_3051_1_.old_tb5_2(125):=55554;
CCCCR_3051_1_.tb5_2(125):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(125),-1)));
CCCCR_3051_1_.old_tb5_3(125):=-1;
CCCCR_3051_1_.tb5_3(125):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(125),-1)));
CCCCR_3051_1_.old_tb5_4(125):=-1;
CCCCR_3051_1_.tb5_4(125):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(125),-1)));
CCCCR_3051_1_.tb5_5(125):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (125)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(125),
CCCCR_3051_1_.tb5_1(125),
CCCCR_3051_1_.tb5_2(125),
CCCCR_3051_1_.tb5_3(125),
CCCCR_3051_1_.tb5_4(125),
CCCCR_3051_1_.tb5_5(125),
null,
null,
null,
null,
600,
7,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
7,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(125):=1602754;
CCCCR_3051_1_.tb7_0(125):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(125):=CCCCR_3051_1_.tb7_0(125);
CCCCR_3051_1_.old_tb7_1(125):=55554;
CCCCR_3051_1_.tb7_1(125):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(125),-1)));
CCCCR_3051_1_.old_tb7_2(125):=-1;
CCCCR_3051_1_.tb7_2(125):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(125),-1)));
CCCCR_3051_1_.tb7_3(125):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(125):=CCCCR_3051_1_.tb5_0(125);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (125)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(125),
CCCCR_3051_1_.tb7_1(125),
CCCCR_3051_1_.tb7_2(125),
CCCCR_3051_1_.tb7_3(125),
CCCCR_3051_1_.tb7_4(125),
'N'
,
'Y'
,
7,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(61):=121403991;
CCCCR_3051_1_.tb0_0(61):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(61):=CCCCR_3051_1_.tb0_0(61);
CCCCR_3051_1_.old_tb0_1(61):='GEGE_EXERULVAL_CT69E121403991'
;
CCCCR_3051_1_.tb0_1(61):=CCCCR_3051_1_.tb0_0(61);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (61)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(61),
CCCCR_3051_1_.tb0_1(61),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_SUBS_PHONE", "SEQ_GE_SUBS_PHONE"))'
,
'OPEN'
,
to_date('27-11-2012 10:22:45','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave de la tabla GE_SUBS_PHONE'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(126):=1150097;
CCCCR_3051_1_.tb5_0(126):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(126):=CCCCR_3051_1_.tb5_0(126);
CCCCR_3051_1_.old_tb5_1(126):=1248;
CCCCR_3051_1_.tb5_1(126):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(126),-1)));
CCCCR_3051_1_.old_tb5_2(126):=55555;
CCCCR_3051_1_.tb5_2(126):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(126),-1)));
CCCCR_3051_1_.old_tb5_3(126):=-1;
CCCCR_3051_1_.tb5_3(126):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(126),-1)));
CCCCR_3051_1_.old_tb5_4(126):=-1;
CCCCR_3051_1_.tb5_4(126):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(126),-1)));
CCCCR_3051_1_.tb5_5(126):=CCCCR_3051_1_.tb2_0(17);
CCCCR_3051_1_.tb5_8(126):=CCCCR_3051_1_.tb0_0(61);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (126)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(126),
CCCCR_3051_1_.tb5_1(126),
CCCCR_3051_1_.tb5_2(126),
CCCCR_3051_1_.tb5_3(126),
CCCCR_3051_1_.tb5_4(126),
CCCCR_3051_1_.tb5_5(126),
null,
null,
CCCCR_3051_1_.tb5_8(126),
null,
600,
8,
'Id'
,
'N'
,
'Y'
,
'Y'
,
8,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(126):=1602755;
CCCCR_3051_1_.tb7_0(126):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(126):=CCCCR_3051_1_.tb7_0(126);
CCCCR_3051_1_.old_tb7_1(126):=55555;
CCCCR_3051_1_.tb7_1(126):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(126),-1)));
CCCCR_3051_1_.old_tb7_2(126):=-1;
CCCCR_3051_1_.tb7_2(126):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(126),-1)));
CCCCR_3051_1_.tb7_3(126):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(126):=CCCCR_3051_1_.tb5_0(126);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (126)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(126),
CCCCR_3051_1_.tb7_1(126),
CCCCR_3051_1_.tb7_2(126),
CCCCR_3051_1_.tb7_3(126),
CCCCR_3051_1_.tb7_4(126),
'N'
,
'Y'
,
8,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(127):=1150098;
CCCCR_3051_1_.tb5_0(127):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(127):=CCCCR_3051_1_.tb5_0(127);
CCCCR_3051_1_.old_tb5_1(127):=1248;
CCCCR_3051_1_.tb5_1(127):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(127),-1)));
CCCCR_3051_1_.old_tb5_2(127):=55556;
CCCCR_3051_1_.tb5_2(127):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(127),-1)));
CCCCR_3051_1_.old_tb5_3(127):=-1;
CCCCR_3051_1_.tb5_3(127):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(127),-1)));
CCCCR_3051_1_.old_tb5_4(127):=-1;
CCCCR_3051_1_.tb5_4(127):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(127),-1)));
CCCCR_3051_1_.tb5_5(127):=CCCCR_3051_1_.tb2_0(17);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (127)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(127),
CCCCR_3051_1_.tb5_1(127),
CCCCR_3051_1_.tb5_2(127),
CCCCR_3051_1_.tb5_3(127),
CCCCR_3051_1_.tb5_4(127),
CCCCR_3051_1_.tb5_5(127),
null,
null,
null,
null,
600,
2,
'Teléfono Ingresado en la venta'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(127):=1602756;
CCCCR_3051_1_.tb7_0(127):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(127):=CCCCR_3051_1_.tb7_0(127);
CCCCR_3051_1_.old_tb7_1(127):=55556;
CCCCR_3051_1_.tb7_1(127):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(127),-1)));
CCCCR_3051_1_.old_tb7_2(127):=-1;
CCCCR_3051_1_.tb7_2(127):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(127),-1)));
CCCCR_3051_1_.tb7_3(127):=CCCCR_3051_1_.tb6_0(16);
CCCCR_3051_1_.tb7_4(127):=CCCCR_3051_1_.tb5_0(127);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (127)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(127),
CCCCR_3051_1_.tb7_1(127),
CCCCR_3051_1_.tb7_2(127),
CCCCR_3051_1_.tb7_3(127),
CCCCR_3051_1_.tb7_4(127),
'Y'
,
'Y'
,
2,
'N'
,
'Teléfono Ingresado en la venta'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(17):=CCCCR_3051_1_.tb2_0(16);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (17)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(17),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(17):=2482;
CCCCR_3051_1_.tb6_0(17):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(17):=CCCCR_3051_1_.tb6_0(17);
CCCCR_3051_1_.tb6_1(17):=CCCCR_3051_1_.tb2_0(16);
ut_trace.trace('insertando tabla: GI_FRAME fila (17)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(17),
CCCCR_3051_1_.tb6_1(17),
null,
null,
'INF_CCCCR_TAB_1021691'
,
6);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(18):=CCCCR_3051_1_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (18)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(18),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(128):=1150099;
CCCCR_3051_1_.tb5_0(128):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(128):=CCCCR_3051_1_.tb5_0(128);
CCCCR_3051_1_.old_tb5_1(128):=1251;
CCCCR_3051_1_.tb5_1(128):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(128),-1)));
CCCCR_3051_1_.old_tb5_2(128):=55582;
CCCCR_3051_1_.tb5_2(128):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(128),-1)));
CCCCR_3051_1_.old_tb5_3(128):=-1;
CCCCR_3051_1_.tb5_3(128):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(128),-1)));
CCCCR_3051_1_.old_tb5_4(128):=-1;
CCCCR_3051_1_.tb5_4(128):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(128),-1)));
CCCCR_3051_1_.tb5_5(128):=CCCCR_3051_1_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (128)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(128),
CCCCR_3051_1_.tb5_1(128),
CCCCR_3051_1_.tb5_2(128),
CCCCR_3051_1_.tb5_3(128),
CCCCR_3051_1_.tb5_4(128),
CCCCR_3051_1_.tb5_5(128),
null,
null,
null,
null,
600,
0,
'Nombre del Energético'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(18):=2483;
CCCCR_3051_1_.tb6_0(18):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(18):=CCCCR_3051_1_.tb6_0(18);
CCCCR_3051_1_.tb6_1(18):=CCCCR_3051_1_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_FRAME fila (18)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(18),
CCCCR_3051_1_.tb6_1(18),
null,
null,
'INF_CCCCR_FRAME_1021694'
,
0);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(128):=1602757;
CCCCR_3051_1_.tb7_0(128):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(128):=CCCCR_3051_1_.tb7_0(128);
CCCCR_3051_1_.old_tb7_1(128):=55582;
CCCCR_3051_1_.tb7_1(128):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(128),-1)));
CCCCR_3051_1_.old_tb7_2(128):=-1;
CCCCR_3051_1_.tb7_2(128):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(128),-1)));
CCCCR_3051_1_.tb7_3(128):=CCCCR_3051_1_.tb6_0(18);
CCCCR_3051_1_.tb7_4(128):=CCCCR_3051_1_.tb5_0(128);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (128)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(128),
CCCCR_3051_1_.tb7_1(128),
CCCCR_3051_1_.tb7_2(128),
CCCCR_3051_1_.tb7_3(128),
CCCCR_3051_1_.tb7_4(128),
'Y'
,
'Y'
,
0,
'N'
,
'Nombre del Energético'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(129):=1150100;
CCCCR_3051_1_.tb5_0(129):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(129):=CCCCR_3051_1_.tb5_0(129);
CCCCR_3051_1_.old_tb5_1(129):=1251;
CCCCR_3051_1_.tb5_1(129):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(129),-1)));
CCCCR_3051_1_.old_tb5_2(129):=55584;
CCCCR_3051_1_.tb5_2(129):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(129),-1)));
CCCCR_3051_1_.old_tb5_3(129):=-1;
CCCCR_3051_1_.tb5_3(129):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(129),-1)));
CCCCR_3051_1_.old_tb5_4(129):=-1;
CCCCR_3051_1_.tb5_4(129):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(129),-1)));
CCCCR_3051_1_.tb5_5(129):=CCCCR_3051_1_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (129)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(129),
CCCCR_3051_1_.tb5_1(129),
CCCCR_3051_1_.tb5_2(129),
CCCCR_3051_1_.tb5_3(129),
CCCCR_3051_1_.tb5_4(129),
CCCCR_3051_1_.tb5_5(129),
null,
null,
null,
null,
600,
1,
'Costo Mensual'
,
'N'
,
'Y'
,
'N'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(129):=1602758;
CCCCR_3051_1_.tb7_0(129):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(129):=CCCCR_3051_1_.tb7_0(129);
CCCCR_3051_1_.old_tb7_1(129):=55584;
CCCCR_3051_1_.tb7_1(129):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(129),-1)));
CCCCR_3051_1_.old_tb7_2(129):=-1;
CCCCR_3051_1_.tb7_2(129):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(129),-1)));
CCCCR_3051_1_.tb7_3(129):=CCCCR_3051_1_.tb6_0(18);
CCCCR_3051_1_.tb7_4(129):=CCCCR_3051_1_.tb5_0(129);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (129)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(129),
CCCCR_3051_1_.tb7_1(129),
CCCCR_3051_1_.tb7_2(129),
CCCCR_3051_1_.tb7_3(129),
CCCCR_3051_1_.tb7_4(129),
'Y'
,
'Y'
,
1,
'N'
,
'Costo Mensual'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(130):=1150101;
CCCCR_3051_1_.tb5_0(130):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(130):=CCCCR_3051_1_.tb5_0(130);
CCCCR_3051_1_.old_tb5_1(130):=1251;
CCCCR_3051_1_.tb5_1(130):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(130),-1)));
CCCCR_3051_1_.old_tb5_2(130):=55585;
CCCCR_3051_1_.tb5_2(130):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(130),-1)));
CCCCR_3051_1_.old_tb5_3(130):=-1;
CCCCR_3051_1_.tb5_3(130):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(130),-1)));
CCCCR_3051_1_.old_tb5_4(130):=-1;
CCCCR_3051_1_.tb5_4(130):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(130),-1)));
CCCCR_3051_1_.tb5_5(130):=CCCCR_3051_1_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (130)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(130),
CCCCR_3051_1_.tb5_1(130),
CCCCR_3051_1_.tb5_2(130),
CCCCR_3051_1_.tb5_3(130),
CCCCR_3051_1_.tb5_4(130),
CCCCR_3051_1_.tb5_5(130),
null,
null,
null,
null,
600,
2,
'Tiempo con el Energético'
,
'N'
,
'Y'
,
'N'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(130):=1602759;
CCCCR_3051_1_.tb7_0(130):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(130):=CCCCR_3051_1_.tb7_0(130);
CCCCR_3051_1_.old_tb7_1(130):=55585;
CCCCR_3051_1_.tb7_1(130):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(130),-1)));
CCCCR_3051_1_.old_tb7_2(130):=-1;
CCCCR_3051_1_.tb7_2(130):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(130),-1)));
CCCCR_3051_1_.tb7_3(130):=CCCCR_3051_1_.tb6_0(18);
CCCCR_3051_1_.tb7_4(130):=CCCCR_3051_1_.tb5_0(130);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (130)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(130),
CCCCR_3051_1_.tb7_1(130),
CCCCR_3051_1_.tb7_2(130),
CCCCR_3051_1_.tb7_3(130),
CCCCR_3051_1_.tb7_4(130),
'Y'
,
'Y'
,
2,
'N'
,
'Tiempo con el Energético'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(131):=1150102;
CCCCR_3051_1_.tb5_0(131):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(131):=CCCCR_3051_1_.tb5_0(131);
CCCCR_3051_1_.old_tb5_1(131):=1251;
CCCCR_3051_1_.tb5_1(131):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(131),-1)));
CCCCR_3051_1_.old_tb5_2(131):=55580;
CCCCR_3051_1_.tb5_2(131):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(131),-1)));
CCCCR_3051_1_.old_tb5_3(131):=-1;
CCCCR_3051_1_.tb5_3(131):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(131),-1)));
CCCCR_3051_1_.old_tb5_4(131):=-1;
CCCCR_3051_1_.tb5_4(131):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(131),-1)));
CCCCR_3051_1_.tb5_5(131):=CCCCR_3051_1_.tb2_0(19);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (131)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(131),
CCCCR_3051_1_.tb5_1(131),
CCCCR_3051_1_.tb5_2(131),
CCCCR_3051_1_.tb5_3(131),
CCCCR_3051_1_.tb5_4(131),
CCCCR_3051_1_.tb5_5(131),
null,
null,
null,
null,
600,
3,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
3,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(131):=1602760;
CCCCR_3051_1_.tb7_0(131):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(131):=CCCCR_3051_1_.tb7_0(131);
CCCCR_3051_1_.old_tb7_1(131):=55580;
CCCCR_3051_1_.tb7_1(131):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(131),-1)));
CCCCR_3051_1_.old_tb7_2(131):=-1;
CCCCR_3051_1_.tb7_2(131):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(131),-1)));
CCCCR_3051_1_.tb7_3(131):=CCCCR_3051_1_.tb6_0(18);
CCCCR_3051_1_.tb7_4(131):=CCCCR_3051_1_.tb5_0(131);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (131)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(131),
CCCCR_3051_1_.tb7_1(131),
CCCCR_3051_1_.tb7_2(131),
CCCCR_3051_1_.tb7_3(131),
CCCCR_3051_1_.tb7_4(131),
'N'
,
'Y'
,
3,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(62):=121403992;
CCCCR_3051_1_.tb0_0(62):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(62):=CCCCR_3051_1_.tb0_0(62);
CCCCR_3051_1_.old_tb0_1(62):='GEGE_EXERULVAL_CT69E121403992'
;
CCCCR_3051_1_.tb0_1(62):=CCCCR_3051_1_.tb0_0(62);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (62)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(62),
CCCCR_3051_1_.tb0_1(62),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_THIRD_PART_SERV", "SEQ_GE_THIRD_PART_SERV"))'
,
'OPEN'
,
to_date('27-11-2012 10:22:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave primaria tabla GE_THIRD_PART_SERV'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(132):=1150103;
CCCCR_3051_1_.tb5_0(132):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(132):=CCCCR_3051_1_.tb5_0(132);
CCCCR_3051_1_.old_tb5_1(132):=1251;
CCCCR_3051_1_.tb5_1(132):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(132),-1)));
CCCCR_3051_1_.old_tb5_2(132):=55581;
CCCCR_3051_1_.tb5_2(132):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(132),-1)));
CCCCR_3051_1_.old_tb5_3(132):=-1;
CCCCR_3051_1_.tb5_3(132):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(132),-1)));
CCCCR_3051_1_.old_tb5_4(132):=-1;
CCCCR_3051_1_.tb5_4(132):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(132),-1)));
CCCCR_3051_1_.tb5_5(132):=CCCCR_3051_1_.tb2_0(19);
CCCCR_3051_1_.tb5_8(132):=CCCCR_3051_1_.tb0_0(62);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (132)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(132),
CCCCR_3051_1_.tb5_1(132),
CCCCR_3051_1_.tb5_2(132),
CCCCR_3051_1_.tb5_3(132),
CCCCR_3051_1_.tb5_4(132),
CCCCR_3051_1_.tb5_5(132),
null,
null,
CCCCR_3051_1_.tb5_8(132),
null,
600,
4,
'Id'
,
'N'
,
'Y'
,
'Y'
,
4,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(132):=1602761;
CCCCR_3051_1_.tb7_0(132):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(132):=CCCCR_3051_1_.tb7_0(132);
CCCCR_3051_1_.old_tb7_1(132):=55581;
CCCCR_3051_1_.tb7_1(132):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(132),-1)));
CCCCR_3051_1_.old_tb7_2(132):=-1;
CCCCR_3051_1_.tb7_2(132):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(132),-1)));
CCCCR_3051_1_.tb7_3(132):=CCCCR_3051_1_.tb6_0(18);
CCCCR_3051_1_.tb7_4(132):=CCCCR_3051_1_.tb5_0(132);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (132)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(132),
CCCCR_3051_1_.tb7_1(132),
CCCCR_3051_1_.tb7_2(132),
CCCCR_3051_1_.tb7_3(132),
CCCCR_3051_1_.tb7_4(132),
'N'
,
'Y'
,
4,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(19):=CCCCR_3051_1_.tb2_0(18);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (19)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(19),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(19):=2484;
CCCCR_3051_1_.tb6_0(19):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(19):=CCCCR_3051_1_.tb6_0(19);
CCCCR_3051_1_.tb6_1(19):=CCCCR_3051_1_.tb2_0(18);
ut_trace.trace('insertando tabla: GI_FRAME fila (19)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(19),
CCCCR_3051_1_.tb6_1(19),
null,
null,
'INF_CCCCR_TAB_1021693'
,
7);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(20):=CCCCR_3051_1_.tb2_0(21);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (20)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(20),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(29):=120197403;
CCCCR_3051_1_.tb8_0(29):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(29):=CCCCR_3051_1_.tb8_0(29);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (29)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(29),
16,
'Lista de Valores Datos de Interes'
,
'SELECT INTEREST_DATA_ID ID, DESCRIPTION DESCRIPTION FROM GE_INTEREST_DATA ORDER BY ID
'
,
'Lista de Valores Datos de Interes'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(133):=1150104;
CCCCR_3051_1_.tb5_0(133):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(133):=CCCCR_3051_1_.tb5_0(133);
CCCCR_3051_1_.old_tb5_1(133):=1253;
CCCCR_3051_1_.tb5_1(133):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(133),-1)));
CCCCR_3051_1_.old_tb5_2(133):=55593;
CCCCR_3051_1_.tb5_2(133):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(133),-1)));
CCCCR_3051_1_.old_tb5_3(133):=-1;
CCCCR_3051_1_.tb5_3(133):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(133),-1)));
CCCCR_3051_1_.old_tb5_4(133):=-1;
CCCCR_3051_1_.tb5_4(133):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(133),-1)));
CCCCR_3051_1_.tb5_5(133):=CCCCR_3051_1_.tb2_0(21);
CCCCR_3051_1_.tb5_7(133):=CCCCR_3051_1_.tb8_0(29);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (133)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(133),
CCCCR_3051_1_.tb5_1(133),
CCCCR_3051_1_.tb5_2(133),
CCCCR_3051_1_.tb5_3(133),
CCCCR_3051_1_.tb5_4(133),
CCCCR_3051_1_.tb5_5(133),
null,
CCCCR_3051_1_.tb5_7(133),
null,
null,
600,
0,
'Tema de Interés'
,
'N'
,
'Y'
,
'N'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(20):=2485;
CCCCR_3051_1_.tb6_0(20):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(20):=CCCCR_3051_1_.tb6_0(20);
CCCCR_3051_1_.tb6_1(20):=CCCCR_3051_1_.tb2_0(21);
ut_trace.trace('insertando tabla: GI_FRAME fila (20)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(20),
CCCCR_3051_1_.tb6_1(20),
null,
null,
'INF_CCCCR_FRAME_1021697'
,
2);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(133):=1602762;
CCCCR_3051_1_.tb7_0(133):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(133):=CCCCR_3051_1_.tb7_0(133);
CCCCR_3051_1_.old_tb7_1(133):=55593;
CCCCR_3051_1_.tb7_1(133):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(133),-1)));
CCCCR_3051_1_.old_tb7_2(133):=-1;
CCCCR_3051_1_.tb7_2(133):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(133),-1)));
CCCCR_3051_1_.tb7_3(133):=CCCCR_3051_1_.tb6_0(20);
CCCCR_3051_1_.tb7_4(133):=CCCCR_3051_1_.tb5_0(133);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (133)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(133),
CCCCR_3051_1_.tb7_1(133),
CCCCR_3051_1_.tb7_2(133),
CCCCR_3051_1_.tb7_3(133),
CCCCR_3051_1_.tb7_4(133),
'Y'
,
'Y'
,
0,
'N'
,
'Tema de Interés'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(134):=1150105;
CCCCR_3051_1_.tb5_0(134):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(134):=CCCCR_3051_1_.tb5_0(134);
CCCCR_3051_1_.old_tb5_1(134):=1253;
CCCCR_3051_1_.tb5_1(134):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(134),-1)));
CCCCR_3051_1_.old_tb5_2(134):=55591;
CCCCR_3051_1_.tb5_2(134):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(134),-1)));
CCCCR_3051_1_.old_tb5_3(134):=-1;
CCCCR_3051_1_.tb5_3(134):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(134),-1)));
CCCCR_3051_1_.old_tb5_4(134):=-1;
CCCCR_3051_1_.tb5_4(134):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(134),-1)));
CCCCR_3051_1_.tb5_5(134):=CCCCR_3051_1_.tb2_0(21);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (134)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(134),
CCCCR_3051_1_.tb5_1(134),
CCCCR_3051_1_.tb5_2(134),
CCCCR_3051_1_.tb5_3(134),
CCCCR_3051_1_.tb5_4(134),
CCCCR_3051_1_.tb5_5(134),
null,
null,
null,
null,
600,
1,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(134):=1602763;
CCCCR_3051_1_.tb7_0(134):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(134):=CCCCR_3051_1_.tb7_0(134);
CCCCR_3051_1_.old_tb7_1(134):=55591;
CCCCR_3051_1_.tb7_1(134):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(134),-1)));
CCCCR_3051_1_.old_tb7_2(134):=-1;
CCCCR_3051_1_.tb7_2(134):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(134),-1)));
CCCCR_3051_1_.tb7_3(134):=CCCCR_3051_1_.tb6_0(20);
CCCCR_3051_1_.tb7_4(134):=CCCCR_3051_1_.tb5_0(134);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (134)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(134),
CCCCR_3051_1_.tb7_1(134),
CCCCR_3051_1_.tb7_2(134),
CCCCR_3051_1_.tb7_3(134),
CCCCR_3051_1_.tb7_4(134),
'N'
,
'Y'
,
1,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(63):=121403993;
CCCCR_3051_1_.tb0_0(63):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(63):=CCCCR_3051_1_.tb0_0(63);
CCCCR_3051_1_.old_tb0_1(63):='GEGE_EXERULVAL_CT69E121403993'
;
CCCCR_3051_1_.tb0_1(63):=CCCCR_3051_1_.tb0_0(63);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (63)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(63),
CCCCR_3051_1_.tb0_1(63),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_SUBS_INTEREST", "SEQ_GE_SUBS_INTEREST"))'
,
'OPEN'
,
to_date('27-11-2012 10:22:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave primaria tabla GE_SUBS_INTEREST'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(135):=1150106;
CCCCR_3051_1_.tb5_0(135):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(135):=CCCCR_3051_1_.tb5_0(135);
CCCCR_3051_1_.old_tb5_1(135):=1253;
CCCCR_3051_1_.tb5_1(135):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(135),-1)));
CCCCR_3051_1_.old_tb5_2(135):=55592;
CCCCR_3051_1_.tb5_2(135):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(135),-1)));
CCCCR_3051_1_.old_tb5_3(135):=-1;
CCCCR_3051_1_.tb5_3(135):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(135),-1)));
CCCCR_3051_1_.old_tb5_4(135):=-1;
CCCCR_3051_1_.tb5_4(135):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(135),-1)));
CCCCR_3051_1_.tb5_5(135):=CCCCR_3051_1_.tb2_0(21);
CCCCR_3051_1_.tb5_8(135):=CCCCR_3051_1_.tb0_0(63);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (135)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(135),
CCCCR_3051_1_.tb5_1(135),
CCCCR_3051_1_.tb5_2(135),
CCCCR_3051_1_.tb5_3(135),
CCCCR_3051_1_.tb5_4(135),
CCCCR_3051_1_.tb5_5(135),
null,
null,
CCCCR_3051_1_.tb5_8(135),
null,
600,
2,
'Id'
,
'N'
,
'Y'
,
'Y'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(135):=1602764;
CCCCR_3051_1_.tb7_0(135):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(135):=CCCCR_3051_1_.tb7_0(135);
CCCCR_3051_1_.old_tb7_1(135):=55592;
CCCCR_3051_1_.tb7_1(135):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(135),-1)));
CCCCR_3051_1_.old_tb7_2(135):=-1;
CCCCR_3051_1_.tb7_2(135):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(135),-1)));
CCCCR_3051_1_.tb7_3(135):=CCCCR_3051_1_.tb6_0(20);
CCCCR_3051_1_.tb7_4(135):=CCCCR_3051_1_.tb5_0(135);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (135)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(135),
CCCCR_3051_1_.tb7_1(135),
CCCCR_3051_1_.tb7_2(135),
CCCCR_3051_1_.tb7_3(135),
CCCCR_3051_1_.tb7_4(135),
'N'
,
'Y'
,
2,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(21):=CCCCR_3051_1_.tb2_0(22);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (21)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(21),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb8_0(30):=120197404;
CCCCR_3051_1_.tb8_0(30):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
CCCCR_3051_1_.tb8_0(30):=CCCCR_3051_1_.tb8_0(30);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (30)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (CCCCR_3051_1_.tb8_0(30),
16,
'Lista de Valores Pasatiempos'
,
'SELECT HOBBIES_ID ID, DESCRIPTION DESCRIPTION FROM GE_HOBBIES'
,
'Lista de Valores Pasatiempos'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(136):=1150107;
CCCCR_3051_1_.tb5_0(136):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(136):=CCCCR_3051_1_.tb5_0(136);
CCCCR_3051_1_.old_tb5_1(136):=1255;
CCCCR_3051_1_.tb5_1(136):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(136),-1)));
CCCCR_3051_1_.old_tb5_2(136):=55598;
CCCCR_3051_1_.tb5_2(136):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(136),-1)));
CCCCR_3051_1_.old_tb5_3(136):=-1;
CCCCR_3051_1_.tb5_3(136):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(136),-1)));
CCCCR_3051_1_.old_tb5_4(136):=-1;
CCCCR_3051_1_.tb5_4(136):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(136),-1)));
CCCCR_3051_1_.tb5_5(136):=CCCCR_3051_1_.tb2_0(22);
CCCCR_3051_1_.tb5_7(136):=CCCCR_3051_1_.tb8_0(30);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (136)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(136),
CCCCR_3051_1_.tb5_1(136),
CCCCR_3051_1_.tb5_2(136),
CCCCR_3051_1_.tb5_3(136),
CCCCR_3051_1_.tb5_4(136),
CCCCR_3051_1_.tb5_5(136),
null,
CCCCR_3051_1_.tb5_7(136),
null,
null,
600,
0,
'Hobbie'
,
'N'
,
'Y'
,
'Y'
,
0,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(21):=2486;
CCCCR_3051_1_.tb6_0(21):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(21):=CCCCR_3051_1_.tb6_0(21);
CCCCR_3051_1_.tb6_1(21):=CCCCR_3051_1_.tb2_0(22);
ut_trace.trace('insertando tabla: GI_FRAME fila (21)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(21),
CCCCR_3051_1_.tb6_1(21),
null,
null,
'INF_CCCCR_FRAME_1021698'
,
3);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(136):=1602765;
CCCCR_3051_1_.tb7_0(136):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(136):=CCCCR_3051_1_.tb7_0(136);
CCCCR_3051_1_.old_tb7_1(136):=55598;
CCCCR_3051_1_.tb7_1(136):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(136),-1)));
CCCCR_3051_1_.old_tb7_2(136):=-1;
CCCCR_3051_1_.tb7_2(136):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(136),-1)));
CCCCR_3051_1_.tb7_3(136):=CCCCR_3051_1_.tb6_0(21);
CCCCR_3051_1_.tb7_4(136):=CCCCR_3051_1_.tb5_0(136);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (136)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(136),
CCCCR_3051_1_.tb7_1(136),
CCCCR_3051_1_.tb7_2(136),
CCCCR_3051_1_.tb7_3(136),
CCCCR_3051_1_.tb7_4(136),
'Y'
,
'Y'
,
0,
'Y'
,
'Hobbie'
,
'N'
,
'N'
,
'U'
,
null,
4,
null,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(137):=1150108;
CCCCR_3051_1_.tb5_0(137):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(137):=CCCCR_3051_1_.tb5_0(137);
CCCCR_3051_1_.old_tb5_1(137):=1255;
CCCCR_3051_1_.tb5_1(137):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(137),-1)));
CCCCR_3051_1_.old_tb5_2(137):=55596;
CCCCR_3051_1_.tb5_2(137):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(137),-1)));
CCCCR_3051_1_.old_tb5_3(137):=-1;
CCCCR_3051_1_.tb5_3(137):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(137),-1)));
CCCCR_3051_1_.old_tb5_4(137):=-1;
CCCCR_3051_1_.tb5_4(137):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(137),-1)));
CCCCR_3051_1_.tb5_5(137):=CCCCR_3051_1_.tb2_0(22);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (137)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(137),
CCCCR_3051_1_.tb5_1(137),
CCCCR_3051_1_.tb5_2(137),
CCCCR_3051_1_.tb5_3(137),
CCCCR_3051_1_.tb5_4(137),
CCCCR_3051_1_.tb5_5(137),
null,
null,
null,
null,
600,
1,
'Cliente'
,
'N'
,
'Y'
,
'Y'
,
1,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(137):=1602766;
CCCCR_3051_1_.tb7_0(137):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(137):=CCCCR_3051_1_.tb7_0(137);
CCCCR_3051_1_.old_tb7_1(137):=55596;
CCCCR_3051_1_.tb7_1(137):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(137),-1)));
CCCCR_3051_1_.old_tb7_2(137):=-1;
CCCCR_3051_1_.tb7_2(137):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(137),-1)));
CCCCR_3051_1_.tb7_3(137):=CCCCR_3051_1_.tb6_0(21);
CCCCR_3051_1_.tb7_4(137):=CCCCR_3051_1_.tb5_0(137);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (137)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(137),
CCCCR_3051_1_.tb7_1(137),
CCCCR_3051_1_.tb7_2(137),
CCCCR_3051_1_.tb7_3(137),
CCCCR_3051_1_.tb7_4(137),
'N'
,
'Y'
,
1,
'Y'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb0_0(64):=121403994;
CCCCR_3051_1_.tb0_0(64):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
CCCCR_3051_1_.tb0_0(64):=CCCCR_3051_1_.tb0_0(64);
CCCCR_3051_1_.old_tb0_1(64):='GEGE_EXERULVAL_CT69E121403994'
;
CCCCR_3051_1_.tb0_1(64):=CCCCR_3051_1_.tb0_0(64);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (64)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (CCCCR_3051_1_.tb0_0(64),
CCCCR_3051_1_.tb0_1(64),
69,
'GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE(GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE("GE_SUBS_HOBBIES", "SEQ_GE_SUBS_HOBBIES"))'
,
'OPEN'
,
to_date('27-11-2012 10:22:46','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
to_date('10-07-2024 11:31:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene llave primaria tabla GE_SUBS_HOBBIES'
,
'PP'
,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb5_0(138):=1150109;
CCCCR_3051_1_.tb5_0(138):=GI_BOSEQUENCES.FNUGETNEXTCOMPATTRIBSID;
CCCCR_3051_1_.tb5_0(138):=CCCCR_3051_1_.tb5_0(138);
CCCCR_3051_1_.old_tb5_1(138):=1255;
CCCCR_3051_1_.tb5_1(138):=CC_BOUTILEXPORT.FNUGETIDENTITYFROMCAT(CCCCR_3051_1_.TBENTITYNAME(NVL(CCCCR_3051_1_.old_tb5_1(138),-1)));
CCCCR_3051_1_.old_tb5_2(138):=55597;
CCCCR_3051_1_.tb5_2(138):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_2(138),-1)));
CCCCR_3051_1_.old_tb5_3(138):=-1;
CCCCR_3051_1_.tb5_3(138):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_3(138),-1)));
CCCCR_3051_1_.old_tb5_4(138):=-1;
CCCCR_3051_1_.tb5_4(138):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb5_4(138),-1)));
CCCCR_3051_1_.tb5_5(138):=CCCCR_3051_1_.tb2_0(22);
CCCCR_3051_1_.tb5_8(138):=CCCCR_3051_1_.tb0_0(64);
ut_trace.trace('insertando tabla: GI_COMP_ATTRIBS fila (138)',1);
INSERT INTO GI_COMP_ATTRIBS(COMP_ATTRIBS_ID,ENTITY_ID,ENTITY_ATTRIBUTE_ID,MIRROR_ENTI_ATTRIB,PARENT_ATTRIBUTE_ID,COMPOSITION_ID,PARENT_GROUP_ATTR_ID,SELECT_STATEMENT_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,EXTERNAL_ID,DISPLAY_ORDER,DISPLAY_NAME,GROUP_ATTRIBUTE_TYPE,INCLUDED_VAL_DOC,REQUIRED,PROCESS_SEQUENCE,TAG_NAME,TAB_STOP) 
VALUES (CCCCR_3051_1_.tb5_0(138),
CCCCR_3051_1_.tb5_1(138),
CCCCR_3051_1_.tb5_2(138),
CCCCR_3051_1_.tb5_3(138),
CCCCR_3051_1_.tb5_4(138),
CCCCR_3051_1_.tb5_5(138),
null,
null,
CCCCR_3051_1_.tb5_8(138),
null,
600,
2,
'Id'
,
'N'
,
'Y'
,
'Y'
,
2,
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb7_0(138):=1602767;
CCCCR_3051_1_.tb7_0(138):=GI_BOSEQUENCES.FNUGETNEXTCOMPFRAMEATTRIBID;
CCCCR_3051_1_.tb7_0(138):=CCCCR_3051_1_.tb7_0(138);
CCCCR_3051_1_.old_tb7_1(138):=55597;
CCCCR_3051_1_.tb7_1(138):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_1(138),-1)));
CCCCR_3051_1_.old_tb7_2(138):=-1;
CCCCR_3051_1_.tb7_2(138):=CC_BOUTILEXPORT.FNUGETIDENTATTIBFROMCAT(CCCCR_3051_1_.TBENTITYATTRIBUTENAME(NVL(CCCCR_3051_1_.old_tb7_2(138),-1)));
CCCCR_3051_1_.tb7_3(138):=CCCCR_3051_1_.tb6_0(21);
CCCCR_3051_1_.tb7_4(138):=CCCCR_3051_1_.tb5_0(138);
ut_trace.trace('insertando tabla: GI_COMP_FRAME_ATTRIB fila (138)',1);
INSERT INTO GI_COMP_FRAME_ATTRIB(COMP_FRAME_ATTRIB_ID,ENTITY_ATTRIBUTE_ID,PARENT_ATTRIBUTE_ID,FRAME_ID,COMP_ATTRIBS_ID,IS_VISIBLE,IS_UPDATABLE,DISPLAY_ORDER,REQUIRED,DISPLAY_NAME,STATEMENT_CACHE,USER_DEFAULT_ALLOWED,STYLE_CASE,MASK_ID,DISPLAY_VIEW,TAG_NAME,ROW_ORDER_TYPE,ROW_ORDER_SEQUENCE) 
VALUES (CCCCR_3051_1_.tb7_0(138),
CCCCR_3051_1_.tb7_1(138),
CCCCR_3051_1_.tb7_2(138),
CCCCR_3051_1_.tb7_3(138),
CCCCR_3051_1_.tb7_4(138),
'N'
,
'Y'
,
2,
'Y'
,
'Id'
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
null,
null);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.tb4_0(22):=CCCCR_3051_1_.tb2_0(20);
ut_trace.trace('insertando tabla: GI_COMPOSITION_ADITI fila (22)',1);
INSERT INTO GI_COMPOSITION_ADITI(COMPOSITION_ID,CHILD_PARENT_SERVICE,PARENT_CHILD_SERVICE,SEQUENCE_,IS_FIRST,IS_SEARCH,LEVEL_TO_GO,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,SEARCH_SECUENCE,FOREING_KEY_ATTRIBUTE,PARENT_STATEMENT_ID,DISPLAY_NAME,LOAD_CHILD_QUERIES) 
VALUES (CCCCR_3051_1_.tb4_0(22),
null,
null,
1,
'N'
,
'N'
,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
'Y'
);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

CCCCR_3051_1_.old_tb6_0(22):=2487;
CCCCR_3051_1_.tb6_0(22):=GI_BOSEQUENCES.FNUGETNEXTFRAMEID;
CCCCR_3051_1_.tb6_0(22):=CCCCR_3051_1_.tb6_0(22);
CCCCR_3051_1_.tb6_1(22):=CCCCR_3051_1_.tb2_0(20);
ut_trace.trace('insertando tabla: GI_FRAME fila (22)',1);
INSERT INTO GI_FRAME(FRAME_ID,COMPOSITION_ID,AFTER_EXPRESSION_ID,BEFORE_EXPRESSION_ID,DESCRIPTION,ORDER_VIEW) 
VALUES (CCCCR_3051_1_.tb6_0(22),
CCCCR_3051_1_.tb6_1(22),
null,
null,
'INF_CCCCR_TAB_1021695'
,
8);

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;

 GI_BOFrameworkApplication.AddCustomerApplication('CCCCR_3051_1');

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not CCCCR_3051_1_.blProcessStatus) then
 return;
end if;
nuRowProcess:=CCCCR_3051_1_.tb0_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| CCCCR_3051_1_.tb0_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(CCCCR_3051_1_.tb0_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| CCCCR_3051_1_.tb0_0(nuRowProcess),1);
end;
nuRowProcess := CCCCR_3051_1_.tb0_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
CCCCR_3051_1_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

begin
SA_BOCreatePackages.DropPackage('CCCCR_3051_1_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CCCCR_3051_1_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('I18N_CCCCR_',
'CREATE OR REPLACE PACKAGE I18N_CCCCR_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyI18N_STRINGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbI18N_STRINGRowId tyI18N_STRINGRowId;type ty0_0 is table of I18N_STRING.ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of I18N_STRING.LANGUAGE_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END I18N_CCCCR_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:I18N_CCCCR_******************************'); END;
/


declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM I18N_STRING WHERE ID IN 
(SELECT TAG_NAME 
FROM GI_COMPOSITION 
WHERE 
CONFIG_ID IN (SELECT CONFIG_ID FROM GI_CONFIG WHERE CONFIG_TYPE_ID = 7 AND ENTITY_ROOT_ID = 3051 AND EXTERNAL_ROOT_ID = 1 AND EXTERNAL_ROOT_TYPE = 'F' )
)
;
nuIndex binary_integer;
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla I18N_STRING',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM I18N_STRING WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(39):='INF_CCCCR_FRAME_1021673'
;
I18N_CCCCR_.tb0_1(39):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (39)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(39),
I18N_CCCCR_.tb0_1(39),
'WE8ISO8859P1'
,
'Información Básica'
,
'Información Básica'
,
null,
'Información Básica'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(40):='INF_CCCCR_FRAME_1021673'
;
I18N_CCCCR_.tb0_1(40):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (40)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(40),
I18N_CCCCR_.tb0_1(40),
'WE8ISO8859P1'
,
'Información Básica'
,
'Información Básica'
,
null,
'Información Básica'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(41):='INF_CCCCR_FRAME_1021673'
;
I18N_CCCCR_.tb0_1(41):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (41)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(41),
I18N_CCCCR_.tb0_1(41),
'WE8ISO8859P1'
,
'Información Básica'
,
'Información Básica'
,
null,
'Información Básica'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(54):='INF_CCCCR_FRAME_1021675'
;
I18N_CCCCR_.tb0_1(54):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (54)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(54),
I18N_CCCCR_.tb0_1(54),
'WE8ISO8859P1'
,
'Información Familiar'
,
'Información Familiar'
,
null,
'Información Familiar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(55):='INF_CCCCR_FRAME_1021675'
;
I18N_CCCCR_.tb0_1(55):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (55)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(55),
I18N_CCCCR_.tb0_1(55),
'WE8ISO8859P1'
,
'Información Familiar'
,
'Información Familiar'
,
null,
'Información Familiar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(56):='INF_CCCCR_FRAME_1021675'
;
I18N_CCCCR_.tb0_1(56):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (56)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(56),
I18N_CCCCR_.tb0_1(56),
'WE8ISO8859P1'
,
'Información Familiar'
,
'Información Familiar'
,
null,
'Información Familiar'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(15):='INF_CCCCR_FRAME_1021676'
;
I18N_CCCCR_.tb0_1(15):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (15)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(15),
I18N_CCCCR_.tb0_1(15),
'WE8ISO8859P1'
,
'Información Habitacional Actual'
,
'Información Habitacional Actual'
,
null,
'Información Habitacional Actual'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(16):='INF_CCCCR_FRAME_1021676'
;
I18N_CCCCR_.tb0_1(16):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (16)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(16),
I18N_CCCCR_.tb0_1(16),
'WE8ISO8859P1'
,
'Información Habitacional Actual'
,
'Información Habitacional Actual'
,
null,
'Información Habitacional Actual'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(17):='INF_CCCCR_FRAME_1021676'
;
I18N_CCCCR_.tb0_1(17):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (17)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(17),
I18N_CCCCR_.tb0_1(17),
'WE8ISO8859P1'
,
'Información Habitacional Actual'
,
'Información Habitacional Actual'
,
null,
'Información Habitacional Actual'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(3):='INF_CCCCR_FRAME_1021677'
;
I18N_CCCCR_.tb0_1(3):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (3)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(3),
I18N_CCCCR_.tb0_1(3),
'WE8ISO8859P1'
,
'Información Laboral Actual'
,
'Información Laboral Actual'
,
null,
'Información Laboral Actual'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(4):='INF_CCCCR_FRAME_1021677'
;
I18N_CCCCR_.tb0_1(4):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (4)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(4),
I18N_CCCCR_.tb0_1(4),
'WE8ISO8859P1'
,
'Información Laboral Actual'
,
'Información Laboral Actual'
,
null,
'Información Laboral Actual'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(5):='INF_CCCCR_FRAME_1021677'
;
I18N_CCCCR_.tb0_1(5):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (5)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(5),
I18N_CCCCR_.tb0_1(5),
'WE8ISO8859P1'
,
'Información Laboral Actual'
,
'Información Laboral Actual'
,
null,
'Información Laboral Actual'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(45):='INF_CCCCR_FRAME_1021681'
;
I18N_CCCCR_.tb0_1(45):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (45)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(45),
I18N_CCCCR_.tb0_1(45),
'WE8ISO8859P1'
,
'Referencias Comerciales'
,
'Referencias Comerciales'
,
null,
'Referencias Comerciales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(46):='INF_CCCCR_FRAME_1021681'
;
I18N_CCCCR_.tb0_1(46):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (46)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(46),
I18N_CCCCR_.tb0_1(46),
'WE8ISO8859P1'
,
'Referencias Comerciales'
,
'Referencias Comerciales'
,
null,
'Referencias Comerciales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(47):='INF_CCCCR_FRAME_1021681'
;
I18N_CCCCR_.tb0_1(47):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (47)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(47),
I18N_CCCCR_.tb0_1(47),
'WE8ISO8859P1'
,
'Referencias Comerciales'
,
'Referencias Comerciales'
,
null,
'Referencias Comerciales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(21):='INF_CCCCR_FRAME_1021682'
;
I18N_CCCCR_.tb0_1(21):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (21)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(21),
I18N_CCCCR_.tb0_1(21),
'WE8ISO8859P1'
,
'Referencias Personales'
,
'Referencias Personales'
,
null,
'Referencias Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(22):='INF_CCCCR_FRAME_1021682'
;
I18N_CCCCR_.tb0_1(22):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (22)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(22),
I18N_CCCCR_.tb0_1(22),
'WE8ISO8859P1'
,
'Referencias Personales'
,
'Referencias Personales'
,
null,
'Referencias Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(23):='INF_CCCCR_FRAME_1021682'
;
I18N_CCCCR_.tb0_1(23):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (23)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(23),
I18N_CCCCR_.tb0_1(23),
'WE8ISO8859P1'
,
'Referencias Personales'
,
'Referencias Personales'
,
null,
'Referencias Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(57):='INF_CCCCR_FRAME_1021685'
;
I18N_CCCCR_.tb0_1(57):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (57)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(57),
I18N_CCCCR_.tb0_1(57),
'WE8ISO8859P1'
,
'Documentación'
,
'Documentación'
,
null,
'Documentación'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(58):='INF_CCCCR_FRAME_1021685'
;
I18N_CCCCR_.tb0_1(58):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (58)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(58),
I18N_CCCCR_.tb0_1(58),
'WE8ISO8859P1'
,
'Documentación'
,
'Documentación'
,
null,
'Documentación'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(59):='INF_CCCCR_FRAME_1021685'
;
I18N_CCCCR_.tb0_1(59):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (59)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(59),
I18N_CCCCR_.tb0_1(59),
'WE8ISO8859P1'
,
'Documentación'
,
'Documentación'
,
null,
'Documentación'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(48):='INF_CCCCR_FRAME_1021688'
;
I18N_CCCCR_.tb0_1(48):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (48)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(48),
I18N_CCCCR_.tb0_1(48),
'WE8ISO8859P1'
,
'Scoring Externo'
,
'Scoring Externo'
,
null,
'Scoring Externo'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(49):='INF_CCCCR_FRAME_1021688'
;
I18N_CCCCR_.tb0_1(49):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (49)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(49),
I18N_CCCCR_.tb0_1(49),
'WE8ISO8859P1'
,
'Scoring Externo'
,
'Scoring Externo'
,
null,
'Scoring Externo'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(50):='INF_CCCCR_FRAME_1021688'
;
I18N_CCCCR_.tb0_1(50):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (50)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(50),
I18N_CCCCR_.tb0_1(50),
'WE8ISO8859P1'
,
'Scoring Externo'
,
'Scoring Externo'
,
null,
'Scoring Externo'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(66):='INF_CCCCR_FRAME_1021692'
;
I18N_CCCCR_.tb0_1(66):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (66)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(66),
I18N_CCCCR_.tb0_1(66),
'WE8ISO8859P1'
,
'Teléfonos de Contacto'
,
'Teléfonos de Contacto'
,
null,
'Teléfonos de Contacto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(67):='INF_CCCCR_FRAME_1021692'
;
I18N_CCCCR_.tb0_1(67):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (67)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(67),
I18N_CCCCR_.tb0_1(67),
'WE8ISO8859P1'
,
'Teléfonos de Contacto'
,
'Teléfonos de Contacto'
,
null,
'Teléfonos de Contacto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(68):='INF_CCCCR_FRAME_1021692'
;
I18N_CCCCR_.tb0_1(68):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (68)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(68),
I18N_CCCCR_.tb0_1(68),
'WE8ISO8859P1'
,
'Teléfonos de Contacto'
,
'Teléfonos de Contacto'
,
null,
'Teléfonos de Contacto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(18):='INF_CCCCR_FRAME_1021694'
;
I18N_CCCCR_.tb0_1(18):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (18)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(18),
I18N_CCCCR_.tb0_1(18),
'WE8ISO8859P1'
,
'Servicios Contratados con Otras Empresas'
,
'Servicios Contratados con Otras Empresas'
,
null,
'Servicios Contratados con Otras Empresas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(19):='INF_CCCCR_FRAME_1021694'
;
I18N_CCCCR_.tb0_1(19):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (19)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(19),
I18N_CCCCR_.tb0_1(19),
'WE8ISO8859P1'
,
'Servicios Contratados con Otras Empresas'
,
'Servicios Contratados con Otras Empresas'
,
null,
'Servicios Contratados con Otras Empresas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(20):='INF_CCCCR_FRAME_1021694'
;
I18N_CCCCR_.tb0_1(20):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (20)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(20),
I18N_CCCCR_.tb0_1(20),
'WE8ISO8859P1'
,
'Servicios Contratados con Otras Empresas'
,
'Servicios Contratados con Otras Empresas'
,
null,
'Servicios Contratados con Otras Empresas'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(33):='INF_CCCCR_FRAME_1021697'
;
I18N_CCCCR_.tb0_1(33):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (33)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(33),
I18N_CCCCR_.tb0_1(33),
'WE8ISO8859P1'
,
'Temas de Interés'
,
'Temas de Interés'
,
null,
'Temas de Interés'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(34):='INF_CCCCR_FRAME_1021697'
;
I18N_CCCCR_.tb0_1(34):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (34)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(34),
I18N_CCCCR_.tb0_1(34),
'WE8ISO8859P1'
,
'Temas de Interés'
,
'Temas de Interés'
,
null,
'Temas de Interés'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(35):='INF_CCCCR_FRAME_1021697'
;
I18N_CCCCR_.tb0_1(35):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (35)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(35),
I18N_CCCCR_.tb0_1(35),
'WE8ISO8859P1'
,
'Temas de Interés'
,
'Temas de Interés'
,
null,
'Temas de Interés'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(30):='INF_CCCCR_FRAME_1021698'
;
I18N_CCCCR_.tb0_1(30):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (30)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(30),
I18N_CCCCR_.tb0_1(30),
'WE8ISO8859P1'
,
'Pasatiempos'
,
'Pasatiempos'
,
null,
'Pasatiempos'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(31):='INF_CCCCR_FRAME_1021698'
;
I18N_CCCCR_.tb0_1(31):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (31)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(31),
I18N_CCCCR_.tb0_1(31),
'WE8ISO8859P1'
,
'Pasatiempos'
,
'Pasatiempos'
,
null,
'Pasatiempos'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(32):='INF_CCCCR_FRAME_1021698'
;
I18N_CCCCR_.tb0_1(32):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (32)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(32),
I18N_CCCCR_.tb0_1(32),
'WE8ISO8859P1'
,
'Pasatiempos'
,
'Pasatiempos'
,
null,
'Pasatiempos'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(24):='INF_CCCCR_FRAME_1029143'
;
I18N_CCCCR_.tb0_1(24):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (24)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(24),
I18N_CCCCR_.tb0_1(24),
'WE8ISO8859P1'
,
'Referencias Familiares'
,
'Referencias Familiares'
,
null,
'Referencias Familiares'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(25):='INF_CCCCR_FRAME_1029143'
;
I18N_CCCCR_.tb0_1(25):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (25)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(25),
I18N_CCCCR_.tb0_1(25),
'WE8ISO8859P1'
,
'Referencias Familiares'
,
'Referencias Familiares'
,
null,
'Referencias Familiares'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(26):='INF_CCCCR_FRAME_1029143'
;
I18N_CCCCR_.tb0_1(26):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (26)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(26),
I18N_CCCCR_.tb0_1(26),
'WE8ISO8859P1'
,
'Referencias Familiares'
,
'Referencias Familiares'
,
null,
'Referencias Familiares'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(36):='INF_CCCCR_FRAME_1034638'
;
I18N_CCCCR_.tb0_1(36):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (36)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(36),
I18N_CCCCR_.tb0_1(36),
'WE8ISO8859P1'
,
'Protección Datos Personales'
,
'Protección Datos Personales'
,
null,
'Protección Datos Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(37):='INF_CCCCR_FRAME_1034638'
;
I18N_CCCCR_.tb0_1(37):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (37)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(37),
I18N_CCCCR_.tb0_1(37),
'WE8ISO8859P1'
,
'Protección Datos Personales'
,
'Protección Datos Personales'
,
null,
'Protección Datos Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(38):='INF_CCCCR_FRAME_1034638'
;
I18N_CCCCR_.tb0_1(38):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (38)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(38),
I18N_CCCCR_.tb0_1(38),
'WE8ISO8859P1'
,
'Protección Datos Personales'
,
'Protección Datos Personales'
,
null,
'Protección Datos Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(12):='INF_CCCCR_TAB_1021672'
;
I18N_CCCCR_.tb0_1(12):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (12)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(12),
I18N_CCCCR_.tb0_1(12),
'WE8ISO8859P1'
,
'Básica'
,
'Básica'
,
null,
'Básica'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(13):='INF_CCCCR_TAB_1021672'
;
I18N_CCCCR_.tb0_1(13):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (13)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(13),
I18N_CCCCR_.tb0_1(13),
'WE8ISO8859P1'
,
'Básica'
,
'Básica'
,
null,
'Básica'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(14):='INF_CCCCR_TAB_1021672'
;
I18N_CCCCR_.tb0_1(14):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (14)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(14),
I18N_CCCCR_.tb0_1(14),
'WE8ISO8859P1'
,
'Básica'
,
'Básica'
,
null,
'Básica'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(0):='INF_CCCCR_TAB_1021674'
;
I18N_CCCCR_.tb0_1(0):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (0)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(0),
I18N_CCCCR_.tb0_1(0),
'WE8ISO8859P1'
,
'Familiar / Laboral'
,
'Familiar / Laboral'
,
null,
'Familiar / Laboral'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(1):='INF_CCCCR_TAB_1021674'
;
I18N_CCCCR_.tb0_1(1):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (1)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(1),
I18N_CCCCR_.tb0_1(1),
'WE8ISO8859P1'
,
'Familiar / Laboral'
,
'Familiar / Laboral'
,
null,
'Familiar / Laboral'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(2):='INF_CCCCR_TAB_1021674'
;
I18N_CCCCR_.tb0_1(2):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (2)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(2),
I18N_CCCCR_.tb0_1(2),
'WE8ISO8859P1'
,
'Familiar / Laboral'
,
'Familiar / Laboral'
,
null,
'Familiar / Laboral'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(6):='INF_CCCCR_TAB_1021680'
;
I18N_CCCCR_.tb0_1(6):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (6)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(6),
I18N_CCCCR_.tb0_1(6),
'WE8ISO8859P1'
,
'Referencias'
,
'Referencias'
,
null,
'Referencias'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(7):='INF_CCCCR_TAB_1021680'
;
I18N_CCCCR_.tb0_1(7):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (7)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(7),
I18N_CCCCR_.tb0_1(7),
'WE8ISO8859P1'
,
'Referencias'
,
'Referencias'
,
null,
'Referencias'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(8):='INF_CCCCR_TAB_1021680'
;
I18N_CCCCR_.tb0_1(8):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (8)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(8),
I18N_CCCCR_.tb0_1(8),
'WE8ISO8859P1'
,
'Referencias'
,
'Referencias'
,
null,
'Referencias'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(42):='INF_CCCCR_TAB_1021684'
;
I18N_CCCCR_.tb0_1(42):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (42)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(42),
I18N_CCCCR_.tb0_1(42),
'WE8ISO8859P1'
,
'Documentación'
,
'Documentación'
,
null,
'Documentación'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(43):='INF_CCCCR_TAB_1021684'
;
I18N_CCCCR_.tb0_1(43):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (43)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(43),
I18N_CCCCR_.tb0_1(43),
'WE8ISO8859P1'
,
'Documentación'
,
'Documentación'
,
null,
'Documentación'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(44):='INF_CCCCR_TAB_1021684'
;
I18N_CCCCR_.tb0_1(44):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (44)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(44),
I18N_CCCCR_.tb0_1(44),
'WE8ISO8859P1'
,
'Documentación'
,
'Documentación'
,
null,
'Documentación'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(60):='INF_CCCCR_TAB_1021686'
;
I18N_CCCCR_.tb0_1(60):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (60)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(60),
I18N_CCCCR_.tb0_1(60),
'WE8ISO8859P1'
,
'Información Scoring'
,
'Información Scoring'
,
null,
'Información Scoring'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(61):='INF_CCCCR_TAB_1021686'
;
I18N_CCCCR_.tb0_1(61):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (61)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(61),
I18N_CCCCR_.tb0_1(61),
'WE8ISO8859P1'
,
'Información Scoring'
,
'Información Scoring'
,
null,
'Información Scoring'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(62):='INF_CCCCR_TAB_1021686'
;
I18N_CCCCR_.tb0_1(62):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (62)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(62),
I18N_CCCCR_.tb0_1(62),
'WE8ISO8859P1'
,
'Información Scoring'
,
'Información Scoring'
,
null,
'Información Scoring'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(63):='INF_CCCCR_TAB_1021691'
;
I18N_CCCCR_.tb0_1(63):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (63)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(63),
I18N_CCCCR_.tb0_1(63),
'WE8ISO8859P1'
,
'Teléfonos de Contacto'
,
'Teléfonos de Contacto'
,
null,
'Teléfonos de Contacto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(64):='INF_CCCCR_TAB_1021691'
;
I18N_CCCCR_.tb0_1(64):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (64)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(64),
I18N_CCCCR_.tb0_1(64),
'WE8ISO8859P1'
,
'Teléfonos de Contacto'
,
'Teléfonos de Contacto'
,
null,
'Teléfonos de Contacto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(65):='INF_CCCCR_TAB_1021691'
;
I18N_CCCCR_.tb0_1(65):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (65)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(65),
I18N_CCCCR_.tb0_1(65),
'WE8ISO8859P1'
,
'Teléfonos de Contacto'
,
'Teléfonos de Contacto'
,
null,
'Teléfonos de Contacto'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(27):='INF_CCCCR_TAB_1021693'
;
I18N_CCCCR_.tb0_1(27):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (27)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(27),
I18N_CCCCR_.tb0_1(27),
'WE8ISO8859P1'
,
'Otros Servicios'
,
'Otros Servicios'
,
null,
'Otros Servicios'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(28):='INF_CCCCR_TAB_1021693'
;
I18N_CCCCR_.tb0_1(28):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (28)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(28),
I18N_CCCCR_.tb0_1(28),
'WE8ISO8859P1'
,
'Otros Servicios'
,
'Otros Servicios'
,
null,
'Otros Servicios'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(29):='INF_CCCCR_TAB_1021693'
;
I18N_CCCCR_.tb0_1(29):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (29)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(29),
I18N_CCCCR_.tb0_1(29),
'WE8ISO8859P1'
,
'Otros Servicios'
,
'Otros Servicios'
,
null,
'Otros Servicios'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(51):='INF_CCCCR_TAB_1021695'
;
I18N_CCCCR_.tb0_1(51):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (51)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(51),
I18N_CCCCR_.tb0_1(51),
'WE8ISO8859P1'
,
'Información Adicional'
,
'Información Adicional'
,
null,
'Información Adicional'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(52):='INF_CCCCR_TAB_1021695'
;
I18N_CCCCR_.tb0_1(52):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (52)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(52),
I18N_CCCCR_.tb0_1(52),
'WE8ISO8859P1'
,
'Información Adicional'
,
'Información Adicional'
,
null,
'Información Adicional'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(53):='INF_CCCCR_TAB_1021695'
;
I18N_CCCCR_.tb0_1(53):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (53)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(53),
I18N_CCCCR_.tb0_1(53),
'WE8ISO8859P1'
,
'Información Adicional'
,
'Información Adicional'
,
null,
'Información Adicional'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(9):='INF_CCCCR_TAB_1034637'
;
I18N_CCCCR_.tb0_1(9):='E'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (9)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(9),
I18N_CCCCR_.tb0_1(9),
'WE8ISO8859P1'
,
'Protección Datos Personales'
,
'Protección Datos Personales'
,
null,
'Protección Datos Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(10):='INF_CCCCR_TAB_1034637'
;
I18N_CCCCR_.tb0_1(10):='ESA'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (10)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(10),
I18N_CCCCR_.tb0_1(10),
'WE8ISO8859P1'
,
'Protección Datos Personales'
,
'Protección Datos Personales'
,
null,
'Protección Datos Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not I18N_CCCCR_.blProcessStatus) then
 return;
end if;

I18N_CCCCR_.tb0_0(11):='INF_CCCCR_TAB_1034637'
;
I18N_CCCCR_.tb0_1(11):='PTB'
;
ut_trace.trace('insertando tabla sin fallo: I18N_STRING fila (11)',1);
INSERT INTO I18N_STRING(ID,LANGUAGE_CODE,CHARACTER_SET,PROMPT_TEXT,PROMPT_HINT,PROMPT_LABEL,PROMPT_TOOLTIP,STATUS) 
VALUES (I18N_CCCCR_.tb0_0(11),
I18N_CCCCR_.tb0_1(11),
'WE8ISO8859P1'
,
'Protección Datos Personales'
,
'Protección Datos Personales'
,
null,
'Protección Datos Personales'
,
null);

exception 
when dup_val_on_index then 
 return;
when others then
I18N_CCCCR_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('I18N_CCCCR_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:I18N_CCCCR_******************************'); end;
/

